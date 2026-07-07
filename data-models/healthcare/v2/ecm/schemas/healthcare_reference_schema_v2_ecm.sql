-- Schema for Domain: reference | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`reference` COMMENT 'SSOT for all enterprise reference data and standardized code sets. Owns ICD-10 diagnosis codes, CPT procedure codes, HCPCS codes, DRG (Diagnosis-Related Group) grouper tables, SNOMED CT clinical terms, LOINC observation codes, NDC drug codes, payer master lists, provider taxonomies, geographic codes, and HL7/FHIR value sets. Provides the authoritative terminology consumed by clinical, billing, pharmacy, and quality domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`icd_code` (
    `icd_code_id` BIGINT COMMENT 'Surrogate primary key for ICD code record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for ICD-10-CM, ICD-10-PCS, or ICD-9-CM release.',
    `age_high` STRING COMMENT 'Maximum age for which this code is valid (pediatric/geriatric restrictions).',
    `age_low` STRING COMMENT 'Minimum age for which this code is valid.',
    `billable_flag` BOOLEAN COMMENT 'True if the code is billable (leaf-level); false if header/category only.',
    `icd_code_category` STRING COMMENT 'Category or subcategory grouping (e.g., I20-I25 Ischemic heart diseases).',
    `cc_flag` BOOLEAN COMMENT 'True if the diagnosis qualifies as a Complication or Comorbidity (CC) for DRG grouping.',
    `chapter` STRING COMMENT 'ICD chapter name (e.g., Diseases of the circulatory system).',
    `chapter_code` STRING COMMENT 'ICD chapter code (e.g., IX for circulatory).. Valid values are `^[A-Z][0-9]{2}-[A-Z][0-9]{2}$`',
    `icd_code_code` STRING COMMENT 'The actual ICD code (e.g., I21.01, 0016070).. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `code_type` STRING COMMENT 'ICD-10-CM, ICD-10-PCS, ICD-9-CM, ICD-9-PCS.. Valid values are `diagnosis|procedure`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Date the code became valid for use.',
    `etiology_code_flag` BOOLEAN COMMENT 'True if the code represents the underlying cause (etiology) in a manifestation pair.',
    `expiration_date` DATE COMMENT 'Date the code was retired or replaced.',
    `gender_specific_flag` BOOLEAN COMMENT 'True if the code is valid only for a specific sex (e.g., pregnancy codes).',
    `hac_flag` BOOLEAN COMMENT 'True if the diagnosis is a Hospital-Acquired Condition (HAC) subject to CMS non-payment.',
    `long_description` STRING COMMENT 'Full clinical description of the code.',
    `manifestation_code_flag` BOOLEAN COMMENT 'True if the code represents a manifestation (must be sequenced after etiology).',
    `mcc_flag` BOOLEAN COMMENT 'True if the diagnosis qualifies as a Major Complication or Comorbidity (MCC) for DRG grouping.',
    `parent_code` STRING COMMENT 'Parent ICD code in the hierarchy (e.g., I21 is parent of I21.01).',
    `poa_exempt_flag` BOOLEAN COMMENT 'True if the code is exempt from Present on Admission (POA) reporting.',
    `replacement_code` STRING COMMENT 'ICD code that supersedes this code if retired.',
    `short_description` STRING COMMENT 'Abbreviated description for display.',
    `snomed_ct_mapping` STRING COMMENT 'SNOMED CT concept ID(s) mapped to this ICD code.',
    `subcategory` STRING COMMENT 'Subcategory grouping within the category.',
    `unacceptable_principal_dx_flag` BOOLEAN COMMENT 'True if the code cannot be used as a principal diagnosis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `valid_for_coding_flag` BOOLEAN COMMENT 'True if the code is currently valid for clinical coding.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference icd code record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_icd_code PRIMARY KEY(`icd_code_id`)
) COMMENT 'International Classification of Diseases (ICD-9-CM, ICD-10-CM, ICD-10-PCS) code master with billability, CC/MCC flags, and SNOMED CT mappings.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` (
    `cpt_code_id` BIGINT COMMENT 'Surrogate primary key for CPT code record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for CPT annual release.',
    `age_range_high` STRING COMMENT 'Maximum age for which this code is appropriate.',
    `age_range_low` STRING COMMENT 'Minimum age for which this code is appropriate.',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'Base units for anesthesia codes (ASA Relative Value Guide).',
    `cpt_code_category` STRING COMMENT 'Category I, II, III, or Unlisted.. Valid values are `Category I|Category II|Category III`',
    `clinical_family` STRING COMMENT 'Clinical grouping (e.g., Cardiovascular, Orthopedic).',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Dollar conversion factor for RVU-to-payment calculation.',
    `cpt_code` STRING COMMENT 'Five-digit CPT code (e.g., 99213, 27447).. Valid values are `^[0-9]{5}$`',
    `cpt_code_status` STRING COMMENT 'Active, Deleted, Revised.. Valid values are `active|inactive|deleted|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Date the code became valid.',
    `facility_indicator` STRING COMMENT 'Facility vs. non-facility pricing indicator.. Valid values are `facility|non-facility|both`',
    `full_descriptor` STRING COMMENT 'Complete CPT descriptor text.',
    `gender_specific` STRING COMMENT 'Male, Female, or null if not gender-specific.. Valid values are `male|female|both`',
    `global_period` STRING COMMENT '000, 010, 090, XXX, YYY, ZZZ (Medicare global surgery days).',
    `malpractice_rvu` DECIMAL(18,2) COMMENT 'Malpractice relative value unit.',
    `medically_unlikely_edit_value` STRING COMMENT 'CMS MUE limit (max units per day).',
    `modifier_indicator` STRING COMMENT 'Modifier applicability (e.g., 0 = no modifier, 1 = modifier allowed).. Valid values are `0|1|2|3|9`',
    `multiple_procedure_indicator` STRING COMMENT '0, 2, 3, 4, 5, 9 (multiple procedure payment reduction rules).',
    `national_payment_amount` DECIMAL(18,2) COMMENT 'National average Medicare payment amount.',
    `ncci_edit_indicator` BOOLEAN COMMENT 'True if the code has National Correct Coding Initiative (NCCI) edits.',
    `physician_supervision_required` STRING COMMENT 'Direct, General, Personal, or None.. Valid values are `direct|general|personal|none`',
    `place_of_service_restriction` STRING COMMENT 'Comma-separated POS codes where the code is valid.',
    `practice_expense_rvu` DECIMAL(18,2) COMMENT 'Practice expense relative value unit.',
    `section` STRING COMMENT 'CPT section (e.g., Evaluation and Management, Surgery).',
    `short_descriptor` STRING COMMENT 'Abbreviated descriptor for display.',
    `source_system_code` STRING COMMENT 'Source system identifier.',
    `subsection` STRING COMMENT 'CPT subsection grouping.',
    `telemedicine_eligible` BOOLEAN COMMENT 'True if the code is eligible for telemedicine billing.',
    `termination_date` DATE COMMENT 'Date the code was retired.',
    `total_rvu` DECIMAL(18,2) COMMENT 'Total relative value unit (work + PE + malpractice).',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference cpt code record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    `work_rvu` DECIMAL(18,2) COMMENT 'Work relative value unit.',
    CONSTRAINT pk_cpt_code PRIMARY KEY(`cpt_code_id`)
) COMMENT 'Current Procedural Terminology (CPT) code master with RVU values, global periods, NCCI edits, and Medicare payment data.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` (
    `hcpcs_code_id` BIGINT COMMENT 'Surrogate primary key for HCPCS code record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for HCPCS annual release.',
    `age_restriction` STRING COMMENT 'Age range or restriction text (e.g., Pediatric only).',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'Base units for anesthesia HCPCS codes.',
    `asc_payment_indicator` DECIMAL(18,2) COMMENT 'Ambulatory Surgery Center payment indicator (A, B, C, etc.).',
    `assistant_surgeon_indicator` STRING COMMENT '0, 1, 2 (assistant surgeon payment rules).',
    `bilateral_surgery_indicator` STRING COMMENT '0, 1, 2, 3 (bilateral procedure payment rules).',
    `hcpcs_code_category` STRING COMMENT 'A-V category (e.g., A = Transportation, J = Drugs).',
    `co_surgeon_indicator` STRING COMMENT '0, 1, 2 (co-surgeon payment rules).',
    `hcpcs_code_code` STRING COMMENT 'Five-character HCPCS code (e.g., J1100, E0601).. Valid values are `^[A-Z][0-9]{4}$`',
    `code_type` STRING COMMENT 'HCPCS Level II, Local Code, Temporary Code.. Valid values are `permanent|temporary|deleted`',
    `coverage_indicator` STRING COMMENT 'Covered, Not Covered, Carrier Discretion.. Valid values are `covered|not_covered|carrier_discretion|bundled|conditional`',
    `diagnosis_requirement_indicator` BOOLEAN COMMENT 'True if specific diagnosis codes are required for coverage.',
    `dme_indicator` BOOLEAN COMMENT 'True if the code represents durable medical equipment.',
    `drug_indicator` BOOLEAN COMMENT 'True if the code represents a drug or biologic.',
    `effective_date` DATE COMMENT 'Date the code became valid.',
    `frequency_limit` STRING COMMENT 'Frequency limitation text (e.g., Once per year).',
    `gender_restriction` STRING COMMENT 'Male, Female, or null.. Valid values are `male|female|none`',
    `global_period` STRING COMMENT '000, 010, 090, XXX, YYY, ZZZ.',
    `intraoperative_percentage` DECIMAL(18,2) COMMENT 'Percentage of global fee for intraoperative services.',
    `last_updated_date` DATE COMMENT 'Date the record was last updated.',
    `long_description` STRING COMMENT 'Full HCPCS descriptor.',
    `modifier_required_indicator` BOOLEAN COMMENT 'True if a modifier is required for billing.',
    `multiple_procedure_indicator` STRING COMMENT '0, 2, 3, 4, 5, 9.',
    `ndc_crosswalk_indicator` BOOLEAN COMMENT 'True if the code has an NDC crosswalk.',
    `opps_payment_indicator` DECIMAL(18,2) COMMENT 'Outpatient Prospective Payment System indicator (A, B, C, etc.).',
    `place_of_service_restriction` STRING COMMENT 'Comma-separated POS codes.',
    `postoperative_percentage` DECIMAL(18,2) COMMENT 'Percentage of global fee for postoperative services.',
    `preoperative_percentage` DECIMAL(18,2) COMMENT 'Percentage of global fee for preoperative services.',
    `pricing_indicator` STRING COMMENT 'Pricing methodology (e.g., Fee Schedule, Carrier Priced).. Valid values are `fee_schedule|asc|reasonable_charge|not_priced|contractor_priced`',
    `prior_authorization_indicator` BOOLEAN COMMENT 'True if prior authorization is required.',
    `professional_component_indicator` STRING COMMENT '0, 1, 2, 3 (professional component payment rules).',
    `quantity_limit` DECIMAL(18,2) COMMENT 'Maximum quantity per service period.',
    `short_description` STRING COMMENT 'Abbreviated descriptor.',
    `superseded_by_code` STRING COMMENT 'HCPCS code that replaces this code.',
    `team_surgery_indicator` STRING COMMENT '0, 1, 2 (team surgery payment rules).',
    `technical_component_indicator` STRING COMMENT '0, 1, 2, 3 (technical component payment rules).',
    `termination_date` DATE COMMENT 'Date the code was retired.',
    `unit_of_measure` STRING COMMENT 'Unit of measure (e.g., mg, ml, each).',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference hcpcs code record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_hcpcs_code PRIMARY KEY(`hcpcs_code_id`)
) COMMENT 'Healthcare Common Procedure Coding System (HCPCS Level II) code master for DME, drugs, supplies, and non-physician services.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`drg` (
    `drg_id` BIGINT COMMENT 'Surrogate primary key for DRG record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for DRG fiscal year release.',
    `major_diagnostic_category_id` BIGINT COMMENT 'FK to major_diagnostic_category.',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'Arithmetic mean length of stay in days.',
    `bundled_payment_flag` BOOLEAN COMMENT 'True if the DRG is part of a bundled payment program.',
    `clinical_family` STRING COMMENT 'Clinical grouping (e.g., Cardiovascular, Orthopedic).',
    `drg_code` STRING COMMENT 'Three-digit DRG code (e.g., 470, 871).. Valid values are `^[0-9]{3,4}$`',
    `complication_level` STRING COMMENT 'With CC, With MCC, Without CC/MCC.. Valid values are `without CC/MCC|with CC|with MCC`',
    `cost_outlier_threshold` DECIMAL(18,2) COMMENT 'Cost threshold for outlier payment eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `drg_description` STRING COMMENT 'Full DRG descriptor.',
    `drg_type` STRING COMMENT 'MS-DRG, APR-DRG, AP-DRG, IR-DRG.. Valid values are `medical|surgical|procedure`',
    `effective_date` DATE COMMENT 'Date the DRG became valid.',
    `expiration_date` DATE COMMENT 'Date the DRG was retired.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'Geometric mean length of stay in days (used for outlier calculation).',
    `grouper_system` STRING COMMENT 'Grouper software (e.g., 3M, Optum, CMS).. Valid values are `MS-DRG|AP-DRG|APR-DRG|IR-DRG`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `national_average_charges` DECIMAL(18,2) COMMENT 'National average total charges for the DRG.',
    `national_average_payment` DECIMAL(18,2) COMMENT 'National average Medicare payment for the DRG.',
    `national_case_volume` STRING COMMENT 'National case volume for the DRG.',
    `operating_room_procedure_flag` BOOLEAN COMMENT 'True if the DRG requires an OR procedure.',
    `post_acute_transfer_flag` BOOLEAN COMMENT 'True if the DRG is subject to post-acute transfer payment reduction.',
    `principal_diagnosis_range_end` STRING COMMENT 'End of principal diagnosis code range for the DRG.',
    `principal_diagnosis_range_start` STRING COMMENT 'Start of principal diagnosis code range for the DRG.',
    `procedure_requirement_flag` BOOLEAN COMMENT 'True if the DRG requires a specific procedure.',
    `quality_measure_flag` BOOLEAN COMMENT 'True if the DRG is tied to a quality measure.',
    `readmission_penalty_flag` BOOLEAN COMMENT 'True if the DRG is subject to CMS readmission penalties.',
    `relative_weight` DECIMAL(18,2) COMMENT 'DRG relative weight for payment calculation.',
    `special_pay_flag` BOOLEAN COMMENT 'True if the DRG has special payment rules.',
    `title` STRING COMMENT 'Short DRG title.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference drg record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_drg PRIMARY KEY(`drg_id`)
) COMMENT 'Diagnosis-Related Group (MS-DRG, APR-DRG) master with relative weights, geometric mean LOS, and payment parameters.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` (
    `snomed_concept_id` BIGINT COMMENT 'Surrogate primary key for SNOMED CT concept record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for SNOMED CT release.',
    `parent_concept_snomed_concept_id` BIGINT COMMENT 'FK to parent SNOMED CT concept (self-referential hierarchy).',
    `clinical_documentation_section` STRING COMMENT 'Recommended clinical documentation section (e.g., Problem List, Medications).',
    `concept_class` STRING COMMENT 'Clinical finding, Procedure, Observable entity, etc.',
    `concept_code` STRING COMMENT 'The concept code value classifying the reference snomed concept record.',
    `concept_definition` STRING COMMENT 'Formal definition of the concept.',
    `concept_status` STRING COMMENT 'Active, Inactive, Retired.',
    `cpt_map_target` STRING COMMENT 'CPT code(s) mapped to this SNOMED CT concept.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `definition_status` STRING COMMENT 'Primitive, Fully Defined.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the reference snomed concept record.',
    `effective_time` DATE COMMENT 'Date the concept became active.',
    `fhir_value_set_membership` STRING COMMENT 'Comma-separated FHIR value set URLs.',
    `fully_specified_name` STRING COMMENT 'Fully specified name (FSN) with semantic tag.',
    `hierarchy` STRING COMMENT 'The hierarchy of the reference snomed concept record.',
    `hierarchy_level` STRING COMMENT 'Depth in the SNOMED CT hierarchy (0 = root).',
    `icd10_map_correlation` STRING COMMENT 'Exact, Broad, Narrow, Partial.',
    `icd10_map_target` STRING COMMENT 'ICD-10-CM code(s) mapped to this SNOMED CT concept.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the reference snomed concept record.',
    `is_ehr_preferred` BOOLEAN COMMENT 'True if the concept is preferred for EHR documentation.',
    `is_leaf_concept` BOOLEAN COMMENT 'True if the concept has no children.',
    `is_primitive` BOOLEAN COMMENT 'True if the concept is primitive (not fully defined).',
    `is_reportable` BOOLEAN COMMENT 'True if the concept is reportable for quality measures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reference snomed concept record.',
    `last_used_date` DATE COMMENT 'Date the concept was last used in clinical documentation.',
    `loinc_map_target` STRING COMMENT 'LOINC code(s) mapped to this SNOMED CT concept.',
    `module_code` BIGINT COMMENT 'SNOMED CT module identifier (e.g., 900000000000207008 = International).',
    `patient_friendly_term` STRING COMMENT 'Patient-friendly synonym for patient portals.',
    `preferred_term` STRING COMMENT 'Preferred term (PT) for display.',
    `quality_measure_inclusion` STRING COMMENT 'Comma-separated quality measure identifiers.',
    `relationship_count` STRING COMMENT 'Number of relationships (IS-A, attribute, etc.).',
    `rxnorm_map_target` STRING COMMENT 'RxNorm code(s) mapped to this SNOMED CT concept.',
    `semantic_tag` STRING COMMENT 'Semantic tag (e.g., disorder, procedure, finding).',
    `specialty_relevance` STRING COMMENT 'Comma-separated specialty codes.',
    `synonym_count` STRING COMMENT 'Number of synonyms.',
    `top_level_hierarchy` STRING COMMENT 'Top-level hierarchy (e.g., Clinical finding, Procedure).',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `usage_frequency_rank` STRING COMMENT 'Usage frequency rank (1 = most used).',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference snomed concept record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_snomed_concept PRIMARY KEY(`snomed_concept_id`)
) COMMENT 'SNOMED CT concept master with hierarchies, relationships, and mappings to ICD-10, CPT, LOINC, and RxNorm.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` (
    `loinc_code_id` BIGINT COMMENT 'Surrogate primary key for LOINC code record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for LOINC release.',
    `class` STRING COMMENT 'LOINC class (e.g., CHEM, HEM/BC, MICRO).',
    `component` STRING COMMENT 'Component (analyte) being measured (e.g., Glucose, Hemoglobin).',
    `consumer_name` STRING COMMENT 'Consumer-friendly name for patient portals.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deprecated_date` DATE COMMENT 'Date the code was deprecated.',
    `display_name` STRING COMMENT 'Display name for UI.',
    `effective_date` DATE COMMENT 'Date the code became valid.',
    `example_ucum_units` STRING COMMENT 'Example UCUM units (e.g., mg/dL, mmol/L).',
    `example_units` STRING COMMENT 'Example units (non-UCUM).',
    `external_copyright_notice` STRING COMMENT 'Copyright notice for external content.',
    `hl7_field_subfield_code` STRING COMMENT 'HL7 v2 field/subfield code.',
    `hl7_v3_code_system_oid` STRING COMMENT 'The hl7 v3 code system oid of the reference loinc code record.',
    `is_active` BOOLEAN COMMENT 'True if the code is active.',
    `last_verified_date` DATE COMMENT 'Date the code was last verified.',
    `local_code` STRING COMMENT 'Local laboratory code mapped to this LOINC code.',
    `loinc_number` STRING COMMENT 'LOINC code (e.g., 2345-7, 8867-4).. Valid values are `^[0-9]+-[0-9]+$`',
    `long_common_name` STRING COMMENT 'The long common name of the reference loinc code record.',
    `method_type` STRING COMMENT 'Method (e.g., Enzymatic, Immunoassay).',
    `order_observation_flag` BOOLEAN COMMENT 'True if the code can be used for both orders and observations.',
    `panel_type` STRING COMMENT 'Panel, Battery, or null.. Valid values are `Panel|Battery|Set`',
    `property` STRING COMMENT 'Property (e.g., MCnc = mass concentration, Qn = quantitative).',
    `related_names` STRING COMMENT 'Comma-separated related names.',
    `scale_type` STRING COMMENT 'Qn (quantitative), Ord (ordinal), Nom (nominal), Nar (narrative), Doc (document).. Valid values are `Qn|Ord|Nom|Nar|Doc`',
    `short_name` STRING COMMENT 'Short name for display.',
    `survey_question_source` STRING COMMENT 'Survey question source (e.g., PHQ-9, GAD-7).',
    `survey_question_text` STRING COMMENT 'The survey question text of the reference loinc code record.',
    `system` STRING COMMENT 'System (specimen type, e.g., Ser/Plas = serum or plasma).',
    `time_aspect` STRING COMMENT 'Time aspect (e.g., Pt = point in time, 24H = 24 hour).',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference loinc code record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_loinc_code PRIMARY KEY(`loinc_code_id`)
) COMMENT 'Logical Observation Identifiers Names and Codes (LOINC) master for laboratory tests, clinical observations, and vital signs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` (
    `ndc_drug_id` BIGINT COMMENT 'Surrogate primary key for NDC drug record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for NDC release.',
    `active_ingredient` STRING COMMENT 'Active ingredient(s).',
    `application_number` STRING COMMENT 'FDA application number (NDA, ANDA, BLA).',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) code.',
    `biosimilar_flag` BOOLEAN COMMENT 'True if the drug is a biosimilar.',
    `black_box_warning_flag` BOOLEAN COMMENT 'True if the drug has a black box warning.',
    `dea_schedule` STRING COMMENT 'DEA schedule (I, II, III, IV, V).. Valid values are `CI|CII|CIII|CIV|CV|`',
    `dosage_form` STRING COMMENT 'Dosage form (e.g., Tablet, Injection, Capsule).',
    `effective_date` DATE COMMENT 'Date the NDC became valid.',
    `expiration_date` DATE COMMENT 'Date the NDC was retired.',
    `fhir_medication_code` STRING COMMENT 'FHIR Medication resource code.',
    `formulary_status` STRING COMMENT 'Formulary, Non-Formulary, Restricted.. Valid values are `formulary|non_formulary|restricted|preferred`',
    `gpi_code` STRING COMMENT 'Generic Product Identifier (GPI) code.',
    `high_alert_medication_flag` BOOLEAN COMMENT 'True if the drug is a high-alert medication (ISMP list).',
    `labeler_name` STRING COMMENT 'Labeler (manufacturer) name.',
    `marketing_category` STRING COMMENT 'NDA, ANDA, BLA, OTC Monograph, Unapproved Drug.',
    `marketing_end_date` DATE COMMENT 'Date marketing ended.',
    `marketing_start_date` DATE COMMENT 'Date marketing started.',
    `ndc_code` STRING COMMENT '11-digit NDC code (5-4-2 or 5-3-2 format).. Valid values are `^d{11}$`',
    `nonproprietary_name` STRING COMMENT 'Generic (nonproprietary) name.',
    `orange_book_code` STRING COMMENT 'FDA Orange Book therapeutic equivalence code.',
    `over_the_counter_flag` BOOLEAN COMMENT 'True if the drug is available over-the-counter.',
    `package_description` STRING COMMENT 'Package description (e.g., 100 tablets in 1 bottle).',
    `package_quantity` DECIMAL(18,2) COMMENT 'The package quantity of the reference ndc drug record.',
    `package_unit` STRING COMMENT 'Package unit (e.g., tablet, ml).',
    `pregnancy_category` STRING COMMENT 'FDA pregnancy category (A, B, C, D, X).. Valid values are `A|B|C|D|X|N`',
    `product_name` STRING COMMENT 'The product name of the reference ndc drug record.',
    `proprietary_name` STRING COMMENT 'Brand (proprietary) name.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `refrigeration_required_flag` BOOLEAN COMMENT 'True if the drug requires refrigeration.',
    `route_of_administration` STRING COMMENT 'Route of administration (e.g., Oral, Intravenous).',
    `rxcui` STRING COMMENT 'RxNorm Concept Unique Identifier (RxCUI).',
    `rxnorm_name` STRING COMMENT 'The rxnorm name of the reference ndc drug record.',
    `rxnorm_source_vocabulary` STRING COMMENT 'RxNorm source vocabulary (e.g., RXNORM, VANDF).',
    `rxnorm_suppress_flag` BOOLEAN COMMENT 'True if the RxNorm concept is suppressed.',
    `rxnorm_term_type` STRING COMMENT 'RxNorm term type (e.g., SCD, SBD, GPCK).',
    `snomed_ct_code` STRING COMMENT 'SNOMED CT code mapped to this NDC.',
    `strength` STRING COMMENT 'Strength (e.g., 500, 10).',
    `strength_unit` STRING COMMENT 'Strength unit (e.g., mg, mcg).',
    `therapeutic_class` STRING COMMENT 'Therapeutic class (e.g., Antihypertensive, Antibiotic).',
    `unii_code` STRING COMMENT 'FDA Unique Ingredient Identifier (UNII).',
    `vaccine_flag` BOOLEAN COMMENT 'True if the drug is a vaccine.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference ndc drug record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_ndc_drug PRIMARY KEY(`ndc_drug_id`)
) COMMENT 'National Drug Code (NDC) master with RxNorm mappings, DEA schedules, formulary status, and package information.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` (
    `fhir_value_set_id` BIGINT COMMENT 'Surrogate primary key for FHIR value set record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for FHIR release.',
    `approval_date` DATE COMMENT 'Date the value set was approved.',
    `binding_strength` STRING COMMENT 'Required, Extensible, Preferred, Example.. Valid values are `required|extensible|preferred|example`',
    `canonical_url` STRING COMMENT 'Canonical URL (e.g., http://hl7.org/fhir/ValueSet/observation-status).. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `compose_exclude_count` STRING COMMENT 'Number of exclude filters in the compose element.',
    `compose_include_count` STRING COMMENT 'Number of include filters in the compose element.',
    `contact_json` STRING COMMENT 'JSON array of contact information.',
    `copyright` STRING COMMENT 'Copyright notice.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `fhir_value_set_description` STRING COMMENT 'Description of the value set.',
    `effective_end_date` DATE COMMENT 'Date the value set became inactive.',
    `effective_start_date` DATE COMMENT 'Date the value set became active.',
    `expansion_identifier` STRING COMMENT 'Expansion identifier (UUID).',
    `expansion_offset` STRING COMMENT 'Expansion offset (for paging).',
    `expansion_parameter_json` STRING COMMENT 'JSON array of expansion parameters.',
    `expansion_timestamp` TIMESTAMP COMMENT 'Timestamp of the expansion.',
    `expansion_total_concepts` STRING COMMENT 'Total number of concepts in the expansion.',
    `experimental_flag` BOOLEAN COMMENT 'True if the value set is experimental.',
    `fhir_element_path` STRING COMMENT 'FHIR element path where the value set is used (e.g., Observation.status).',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type (e.g., Observation, Condition).',
    `immutable_flag` BOOLEAN COMMENT 'True if the value set is immutable.',
    `jurisdiction_codes` STRING COMMENT 'Comma-separated jurisdiction codes (e.g., US, CA).',
    `last_review_date` DATE COMMENT 'Date the value set was last reviewed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `publisher` STRING COMMENT 'Publisher (e.g., HL7 International, CMS).',
    `purpose` STRING COMMENT 'Purpose of the value set.',
    `title` STRING COMMENT 'Title of the value set.',
    `use_context_json` STRING COMMENT 'JSON array of use context.',
    `value_set_name` STRING COMMENT 'Name of the value set.',
    `value_set_oid` STRING COMMENT 'OID of the value set (e.g., 2.16.840.1.113883.4.642.3.401).. Valid values are `^[0-2](.(0|[1-9][0-9]*))+$`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference fhir value set record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_fhir_value_set PRIMARY KEY(`fhir_value_set_id`)
) COMMENT 'FHIR ValueSet resource master with expansion parameters, binding strength, and canonical URLs for interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` (
    `npi_registry_id` BIGINT COMMENT 'Surrogate primary key for NPI registry record.',
    `geographic_region_id` BIGINT COMMENT 'FK to geographic_region for practice location.',
    `authorized_official_first_name` STRING COMMENT 'Authorized official first name (for organizations).',
    `authorized_official_last_name` STRING COMMENT 'Authorized official last name (for organizations).',
    `authorized_official_middle_name` STRING COMMENT 'The authorized official middle name of the reference npi registry record.',
    `authorized_official_telephone_number` STRING COMMENT 'The authorized official telephone number of the reference npi registry record.',
    `authorized_official_title` STRING COMMENT 'Authorized official title (e.g., CEO, CFO).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the reference npi registry record.',
    `deactivation_date` DATE COMMENT 'Date the NPI was deactivated.',
    `employer_identification_number` STRING COMMENT 'EIN (for organizations).',
    `entity_type` STRING COMMENT 'The entity type value classifying the reference npi registry record.',
    `entity_type_code` STRING COMMENT '1 = Individual, 2 = Organization.',
    `enumeration_date` DATE COMMENT 'Date the NPI was enumerated.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the reference npi registry record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the reference npi registry record.',
    `last_update_date` DATE COMMENT 'Date the NPI record was last updated.',
    `mailing_address_city` STRING COMMENT 'The mailing address city of the reference npi registry record.',
    `mailing_address_country_code` STRING COMMENT 'The mailing address country code value classifying the reference npi registry record.',
    `mailing_address_fax_number` STRING COMMENT 'The mailing address fax number of the reference npi registry record.',
    `mailing_address_line_1` STRING COMMENT 'The mailing address line 1 of the reference npi registry record.',
    `mailing_address_line_2` STRING COMMENT 'The mailing address line 2 of the reference npi registry record.',
    `mailing_address_postal_code` STRING COMMENT 'The mailing address postal code value classifying the reference npi registry record.',
    `mailing_address_state` STRING COMMENT 'The mailing address state of the reference npi registry record.',
    `mailing_address_telephone_number` STRING COMMENT 'The mailing address telephone number of the reference npi registry record.',
    `npi` STRING COMMENT '10-digit National Provider Identifier.',
    `npi_number` STRING COMMENT 'The npi number of the reference npi registry record.',
    `organization_name` STRING COMMENT 'Organization name (for entity type 2).',
    `organization_other_name` STRING COMMENT 'Organization other name (DBA).',
    `practice_address_line1` STRING COMMENT 'The practice address line1 of the reference npi registry record.',
    `practice_city` STRING COMMENT 'The practice city of the reference npi registry record.',
    `practice_location_address_country_code` STRING COMMENT 'Practice location country code.',
    `practice_location_address_line_1` STRING COMMENT 'The practice location address line 1 of the reference npi registry record.',
    `practice_location_address_line_2` STRING COMMENT 'The practice location address line 2 of the reference npi registry record.',
    `practice_location_fax_number` STRING COMMENT 'The practice location fax number of the reference npi registry record.',
    `practice_location_telephone_number` STRING COMMENT 'The practice location telephone number of the reference npi registry record.',
    `practice_postal_code` STRING COMMENT 'The practice postal code value classifying the reference npi registry record.',
    `practice_state` STRING COMMENT 'The practice state of the reference npi registry record.',
    `primary_taxonomy_code` STRING COMMENT 'Primary taxonomy code (e.g., 207Q00000X = Family Medicine).',
    `primary_taxonomy_switch` STRING COMMENT 'Y = primary taxonomy, N = secondary.',
    `provider_credential` STRING COMMENT 'Provider credential (e.g., MD, DO, NP).',
    `provider_first_name` STRING COMMENT 'Provider first name (for entity type 1).',
    `provider_gender_code` STRING COMMENT 'M, F, or null.',
    `provider_last_name` STRING COMMENT 'Provider last name (for entity type 1).',
    `provider_middle_name` STRING COMMENT 'The provider middle name of the reference npi registry record.',
    `provider_name_prefix` STRING COMMENT 'Provider name prefix (e.g., Dr., Mr.).',
    `provider_name_suffix` STRING COMMENT 'Provider name suffix (e.g., Jr., III).',
    `provider_other_credential` STRING COMMENT 'The provider other credential of the reference npi registry record.',
    `provider_other_first_name` STRING COMMENT 'The provider other first name of the reference npi registry record.',
    `provider_other_last_name` STRING COMMENT 'The provider other last name of the reference npi registry record.',
    `provider_other_middle_name` STRING COMMENT 'The provider other middle name of the reference npi registry record.',
    `provider_other_name_prefix` STRING COMMENT 'The provider other name prefix of the reference npi registry record.',
    `provider_other_name_suffix` STRING COMMENT 'The provider other name suffix of the reference npi registry record.',
    `reactivation_date` DATE COMMENT 'Date the NPI was reactivated.',
    `replacement_npi` STRING COMMENT 'Replacement NPI if deactivated.',
    `taxonomy_code` STRING COMMENT 'The taxonomy code value classifying the reference npi registry record.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference npi registry record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_npi_registry PRIMARY KEY(`npi_registry_id`)
) COMMENT 'National Provider Identifier (NPI) registry from NPPES with taxonomy codes, practice locations, and authorized official information.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` (
    `geographic_region_id` BIGINT COMMENT 'Surrogate primary key for geographic region record.',
    `parent_region_geographic_region_id` BIGINT COMMENT 'FK to parent geographic region (self-referential hierarchy).',
    `aco_service_area_flag` BOOLEAN COMMENT 'True if the region is part of an ACO service area.',
    `cbsa_code` STRING COMMENT 'Core-Based Statistical Area (CBSA) code.',
    `cbsa_name` STRING COMMENT 'CBSA name (e.g., New York-Newark-Jersey City, NY-NJ-PA).',
    `census_division` STRING COMMENT 'US Census division (e.g., Middle Atlantic, Pacific).',
    `census_region` STRING COMMENT 'US Census region (e.g., Northeast, West).. Valid values are `northeast|midwest|south|west`',
    `cms_region_number` STRING COMMENT 'CMS region number (1-10).',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code (e.g., US, CA).',
    `effective_end_date` DATE COMMENT 'Date the region became inactive.',
    `effective_start_date` DATE COMMENT 'Date the region became active.',
    `fips_code` STRING COMMENT 'Federal Information Processing Standards (FIPS) code.',
    `hrr_code` STRING COMMENT 'Hospital Referral Region (HRR) code (Dartmouth Atlas).',
    `hsa_code` STRING COMMENT 'Hospital Service Area (HSA) code (Dartmouth Atlas).',
    `is_active` BOOLEAN COMMENT 'True if the region is active.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude (decimal degrees).',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude (decimal degrees).',
    `median_household_income` DECIMAL(18,2) COMMENT 'Median household income (USD).',
    `population_estimate` BIGINT COMMENT 'The population estimate of the reference geographic region record.',
    `poverty_rate_percent` DECIMAL(18,2) COMMENT 'The poverty rate percent of the reference geographic region record.',
    `region_code` STRING COMMENT 'Region code (e.g., ZIP code, county FIPS).',
    `region_name` STRING COMMENT 'Region name (e.g., New York County, 10001).',
    `region_type` STRING COMMENT 'ZIP, County, CBSA, HRR, HSA, State, Country.',
    `ruca_code` STRING COMMENT 'Rural-Urban Commuting Area (RUCA) code.',
    `state_abbreviation` STRING COMMENT 'State abbreviation (e.g., NY, CA).',
    `time_zone` STRING COMMENT 'Time zone (e.g., America/New_York).',
    `uninsured_rate_percent` DECIMAL(18,2) COMMENT 'The uninsured rate percent of the reference geographic region record.',
    `urban_rural_classification` STRING COMMENT 'Urban, Suburban, Rural.. Valid values are `urban|suburban|rural|frontier`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference geographic region record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_geographic_region PRIMARY KEY(`geographic_region_id`)
) COMMENT 'Geographic region master with ZIP codes, counties, CBSAs, HRRs, HSAs, and SDOH indicators for population health analytics.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`condition_code` (
    `condition_code_id` BIGINT COMMENT 'Surrogate primary key for condition code record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for condition code release.',
    `ama_indicator` BOOLEAN COMMENT 'True if the code is AMA-approved.',
    `bilateral_indicator` BOOLEAN COMMENT 'True if the code applies to bilateral procedures.',
    `condition_code_category` STRING COMMENT 'Category (e.g., Patient Status, Billing).',
    `claim_form_type` STRING COMMENT 'UB-04, CMS-1500, ADA Dental Claim Form.. Valid values are `UB-04|CMS-1500|BOTH`',
    `condition_code_code` STRING COMMENT 'Two-digit condition code (e.g., 01, 07, A1).. Valid values are `^[A-Z0-9]{1,5}$`',
    `code_type` STRING COMMENT 'Condition Code, Occurrence Code, Value Code.',
    `commercial_payer_flag` BOOLEAN COMMENT 'True if the code is accepted by commercial payers.',
    `condition_code_description` STRING COMMENT 'Full description of the condition code.',
    `effective_date` DATE COMMENT 'Date the code became valid.',
    `expired_indicator` BOOLEAN COMMENT 'True if the code is expired.',
    `facility_indicator` BOOLEAN COMMENT 'True if the code applies to facility claims.',
    `governing_body` STRING COMMENT 'Governing body (e.g., NUBC, CMS).. Valid values are `NUBC|CMS|AMA|STATE`',
    `hospice_indicator` BOOLEAN COMMENT 'True if the code applies to hospice claims.',
    `last_updated_date` DATE COMMENT 'Date the record was last updated.',
    `medicaid_approved_flag` BOOLEAN COMMENT 'True if the code is Medicaid-approved.',
    `medicare_approved_flag` BOOLEAN COMMENT 'True if the code is Medicare-approved.',
    `pricing_impact_flag` BOOLEAN COMMENT 'True if the code impacts pricing.',
    `professional_indicator` BOOLEAN COMMENT 'True if the code applies to professional claims.',
    `replacement_code` STRING COMMENT 'Replacement code if retired.',
    `requires_value_flag` BOOLEAN COMMENT 'True if the code requires a value (e.g., occurrence date).',
    `short_description` STRING COMMENT 'Abbreviated description.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'True if the code is telehealth-eligible.',
    `termination_date` DATE COMMENT 'Date the code was retired.',
    `ub04_form_locator` STRING COMMENT 'UB-04 form locator (e.g., FL 18-28).',
    `usage_notes` STRING COMMENT 'Usage notes and instructions.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference condition code record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_condition_code PRIMARY KEY(`condition_code_id`)
) COMMENT 'Condition code master for UB-04 and CMS-1500 claim forms with usage notes and payer applicability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` (
    `code_set_version_id` BIGINT COMMENT 'Surrogate primary key for code set version record.',
    `superseded_by_version_code_set_version_id` BIGINT COMMENT 'FK to code_set_version that supersedes this version.',
    `checksum_algorithm` STRING COMMENT 'Checksum algorithm (e.g., SHA-256, MD5).. Valid values are `MD5|SHA256|SHA512`',
    `code_set_name` STRING COMMENT 'Code set name (e.g., ICD-10-CM, CPT, SNOMED CT).',
    `code_set_type` STRING COMMENT 'Diagnosis, Procedure, Drug, Laboratory, Geography, etc.. Valid values are `diagnosis|procedure|drug|observation|terminology|grouper`',
    `compliance_year` STRING COMMENT 'Compliance year (e.g., 2024).',
    `copyright_notice` STRING COMMENT 'The copyright notice of the reference code set version record.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code (e.g., US, CA).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `download_timestamp` TIMESTAMP COMMENT 'Timestamp when the code set was downloaded.',
    `effective_date` DATE COMMENT 'Date the code set version became valid.',
    `file_hash` STRING COMMENT 'File hash (SHA-256, MD5).',
    `file_name` STRING COMMENT 'Source file name.',
    `format_type` STRING COMMENT 'CSV, XML, JSON, RF2 (SNOMED), etc.. Valid values are `csv|xml|json|fhir|hl7|proprietary`',
    `is_hipaa_compliant` BOOLEAN COMMENT 'True if the code set is HIPAA-compliant.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (e.g., en, es).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `license_type` STRING COMMENT 'Public Domain, Commercial, UMLS License, etc.. Valid values are `public_domain|proprietary|open_source|restricted`',
    `load_status` STRING COMMENT 'Pending, In Progress, Completed, Failed.. Valid values are `pending|in_progress|completed|failed|validated`',
    `load_timestamp` TIMESTAMP COMMENT 'Timestamp when the code set was loaded.',
    `publication_date` DATE COMMENT 'Date the code set was published by the source authority.',
    `record_count` BIGINT COMMENT 'Number of records in the code set.',
    `release_notes` STRING COMMENT 'The release notes of the reference code set version record.',
    `source_authority` STRING COMMENT 'Source authority (e.g., CMS, AMA, WHO, Regenstrief).',
    `source_url` STRING COMMENT 'The source url of the reference code set version record.',
    `termination_date` DATE COMMENT 'Date the code set version was retired.',
    `usage_scope` STRING COMMENT 'Clinical, Billing, Research, Interoperability.. Valid values are `clinical|billing|research|quality|all`',
    `validation_status` STRING COMMENT 'Validated, Failed, Pending.. Valid values are `not_validated|passed|failed|warning`',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the code set was validated.',
    `version_identifier` STRING COMMENT 'Version identifier (e.g., 2024, FY2024, 20240301).',
    `version_status` STRING COMMENT 'Active, Superseded, Retired.. Valid values are `draft|active|superseded|retired|deprecated`',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference code set version record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_code_set_version PRIMARY KEY(`code_set_version_id`)
) COMMENT 'Code set version master tracking releases, effective dates, and load status for all reference terminologies.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` (
    `crosswalk_id` BIGINT COMMENT 'Surrogate primary key for crosswalk record.',
    `code_set_version_id` BIGINT COMMENT 'FK to code_set_version for the crosswalk release.',
    `approximate_flag` BOOLEAN COMMENT 'True if the mapping is approximate (not exact).',
    `choice_list_indicator` STRING COMMENT 'Choice list indicator (e.g., 1 of N, All of N).',
    `combination_flag` BOOLEAN COMMENT 'True if the mapping requires a combination of target codes.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `directionality` STRING COMMENT 'Forward, Backward, Bidirectional.. Valid values are `forward|backward|bidirectional`',
    `effective_date` DATE COMMENT 'Date the mapping became valid.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the reference crosswalk record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the reference crosswalk record.',
    `last_validated_date` DATE COMMENT 'Date the mapping was last validated.',
    `map_group` STRING COMMENT 'Map group identifier (for grouped mappings).',
    `map_priority` STRING COMMENT 'Map priority (1 = highest).',
    `mapping_authority` STRING COMMENT 'Mapping authority (e.g., CMS, SNOMED International, Regenstrief).',
    `mapping_purpose` STRING COMMENT 'Billing, Clinical Documentation, Research, Interoperability.',
    `mapping_quality` STRING COMMENT 'Exact, Broad, Narrow, Partial, Unmappable.. Valid values are `exact|high|moderate|low`',
    `mapping_rule` STRING COMMENT 'Mapping rule text.',
    `mapping_type` STRING COMMENT '1:1, 1:N, N:1, N:M.. Valid values are `equivalent|broader|narrower|related|inexact|unmatched`',
    `no_map_flag` BOOLEAN COMMENT 'True if no mapping exists.',
    `notes` STRING COMMENT 'Mapping notes.',
    `scenario_flag` BOOLEAN COMMENT 'True if the mapping is scenario-dependent.',
    `source_code` STRING COMMENT 'Source code (e.g., ICD-10-CM code).. Valid values are `^[A-Z0-9.-]{1,50}$`',
    `source_code_display` STRING COMMENT 'Source code display text.',
    `source_code_system` STRING COMMENT 'Source code system (e.g., ICD-10-CM, CPT).. Valid values are `^[A-Z0-9_-]{2,50}$`',
    `target_code` STRING COMMENT 'Target code (e.g., SNOMED CT code).. Valid values are `^[A-Z0-9.-]{1,50}$`',
    `target_code_display` STRING COMMENT 'Target code display text.',
    `target_code_system` STRING COMMENT 'Target code system (e.g., SNOMED CT, LOINC).. Valid values are `^[A-Z0-9_-]{2,50}$`',
    `termination_date` DATE COMMENT 'Date the mapping was retired.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp.',
    `usage_count` BIGINT COMMENT 'Number of times the mapping has been used.',
    `validated_by` STRING COMMENT 'User or system that validated the mapping.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference crosswalk record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_crosswalk PRIMARY KEY(`crosswalk_id`)
) COMMENT 'Code-to-code crosswalk master for terminology mappings (ICD-10 to SNOMED, CPT to HCPCS, etc.) with mapping quality and directionality.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` (
    `major_diagnostic_category_id` BIGINT COMMENT 'Surrogate primary key for MDC record.',
    `parent_major_diagnostic_category_id` BIGINT COMMENT 'FK to parent MDC (self-referential hierarchy for pre-MDC).',
    `average_length_of_stay_days` DECIMAL(18,2) COMMENT 'Average length of stay in days for the MDC.',
    `body_system` STRING COMMENT 'Body system (e.g., Nervous System, Circulatory System).',
    `case_volume_rank` STRING COMMENT 'Case volume rank (1 = highest).',
    `classification_type` STRING COMMENT 'MS-DRG, APR-DRG, AP-DRG, IR-DRG.',
    `clinical_notes` STRING COMMENT 'Clinical notes and guidance.',
    `complication_comorbidity_logic` STRING COMMENT 'CC/MCC logic description.',
    `major_diagnostic_category_description` STRING COMMENT 'Full MDC description.',
    `drg_count` STRING COMMENT 'Number of DRGs in the MDC.',
    `effective_date` DATE COMMENT 'Date the MDC became valid.',
    `fiscal_year` STRING COMMENT 'Fiscal year (e.g., 2024).',
    `icd_10_cm_range_end` STRING COMMENT 'End of ICD-10-CM code range for the MDC.',
    `icd_10_cm_range_start` STRING COMMENT 'Start of ICD-10-CM code range for the MDC.',
    `icd_10_pcs_range_end` STRING COMMENT 'End of ICD-10-PCS code range for the MDC.',
    `icd_10_pcs_range_start` STRING COMMENT 'Start of ICD-10-PCS code range for the MDC.',
    `is_active` BOOLEAN COMMENT 'True if the MDC is active.',
    `last_updated_date` DATE COMMENT 'Date the record was last updated.',
    `mdc_code` STRING COMMENT 'MDC code (e.g., MDC 01, MDC 05).',
    `mdc_number` STRING COMMENT 'MDC number (1-25).',
    `major_diagnostic_category_name` STRING COMMENT 'MDC name (e.g., Diseases and Disorders of the Nervous System).',
    `pre_mdc_indicator` BOOLEAN COMMENT 'True if the MDC is a pre-MDC (e.g., transplants, tracheostomy).',
    `reimbursement_impact_level` STRING COMMENT 'High, Medium, Low.',
    `relative_weight_average` DECIMAL(18,2) COMMENT 'Average relative weight for the MDC.',
    `short_name` STRING COMMENT 'Short MDC name.',
    `major_diagnostic_category_status` STRING COMMENT 'Active, Retired.',
    `surgical_medical_partition` STRING COMMENT 'Surgical, Medical, Both.',
    `termination_date` DATE COMMENT 'Date the MDC was retired.',
    `ungroupable_indicator` BOOLEAN COMMENT 'True if the MDC is for ungroupable cases.',
    `version` STRING COMMENT 'Version identifier.',
    `vibe_mutation_applied` STRING COMMENT 'Marker added by VIBE mutation to ensure change',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference major diagnostic category record.',
    `vibe_structure_marker` STRING COMMENT 'Marker attribute stamped by required-structure enforcement pass.',
    CONSTRAINT pk_major_diagnostic_category PRIMARY KEY(`major_diagnostic_category_id`)
) COMMENT 'Major Diagnostic Category (MDC) master for DRG grouping with body system, ICD-10 ranges, and surgical/medical partition.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` (
    `reference_sdoh_zcode_mapping_id` BIGINT COMMENT 'Unique identifier for the reference sdoh zcode mapping within the reference reference sdoh zcode mapping record.',
    `code_set_version_id` BIGINT COMMENT 'Unique identifier for the code set version within the reference reference sdoh zcode mapping record.',
    `code_description` STRING COMMENT 'The code description of the reference reference sdoh zcode mapping record.',
    `community_resource_taxonomy` STRING COMMENT 'The community resource taxonomy of the reference reference sdoh zcode mapping record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the reference reference sdoh zcode mapping record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the reference reference sdoh zcode mapping record.',
    `icd10_z_code` STRING COMMENT 'The icd10 z code value classifying the reference reference sdoh zcode mapping record.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating the is active status of the reference reference sdoh zcode mapping record.',
    `is_billable` BOOLEAN COMMENT 'Boolean flag indicating the is billable status of the reference reference sdoh zcode mapping record.',
    `risk_domain` STRING COMMENT 'The risk domain of the reference reference sdoh zcode mapping record.',
    `screening_instrument` STRING COMMENT 'The screening instrument of the reference reference sdoh zcode mapping record.',
    `sdoh_category` STRING COMMENT 'The sdoh category of the reference reference sdoh zcode mapping record.',
    `sdoh_subcategory` STRING COMMENT 'The sdoh subcategory of the reference reference sdoh zcode mapping record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the reference reference sdoh zcode mapping record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the reference reference sdoh zcode mapping record.',
    `vibe_mutation_applied` STRING COMMENT 'The vibe mutation applied of the reference reference sdoh zcode mapping record.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the reference reference sdoh zcode mapping record.',
    CONSTRAINT pk_reference_sdoh_zcode_mapping PRIMARY KEY(`reference_sdoh_zcode_mapping_id`)
) COMMENT 'Reference table for reference sdoh zcode mapping in the reference domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ADD CONSTRAINT `fk_reference_icd_code_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ADD CONSTRAINT `fk_reference_cpt_code_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ADD CONSTRAINT `fk_reference_hcpcs_code_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ADD CONSTRAINT `fk_reference_drg_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ADD CONSTRAINT `fk_reference_drg_major_diagnostic_category_id` FOREIGN KEY (`major_diagnostic_category_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`major_diagnostic_category`(`major_diagnostic_category_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ADD CONSTRAINT `fk_reference_snomed_concept_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ADD CONSTRAINT `fk_reference_snomed_concept_parent_concept_snomed_concept_id` FOREIGN KEY (`parent_concept_snomed_concept_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`snomed_concept`(`snomed_concept_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ADD CONSTRAINT `fk_reference_loinc_code_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ADD CONSTRAINT `fk_reference_ndc_drug_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ADD CONSTRAINT `fk_reference_fhir_value_set_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ADD CONSTRAINT `fk_reference_npi_registry_geographic_region_id` FOREIGN KEY (`geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ADD CONSTRAINT `fk_reference_geographic_region_parent_region_geographic_region_id` FOREIGN KEY (`parent_region_geographic_region_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ADD CONSTRAINT `fk_reference_condition_code_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ADD CONSTRAINT `fk_reference_code_set_version_superseded_by_version_code_set_version_id` FOREIGN KEY (`superseded_by_version_code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ADD CONSTRAINT `fk_reference_crosswalk_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ADD CONSTRAINT `fk_reference_major_diagnostic_category_parent_major_diagnostic_category_id` FOREIGN KEY (`parent_major_diagnostic_category_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`major_diagnostic_category`(`major_diagnostic_category_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` ADD CONSTRAINT `fk_reference_reference_sdoh_zcode_mapping_code_set_version_id` FOREIGN KEY (`code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`reference` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`reference` SET TAGS ('pii_domain' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_clinical_coding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_diagnosis' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_icd10' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_icd9' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_id` SET TAGS ('pii_business_glossary_term' = 'ICD Code Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_high` SET TAGS ('pii_business_glossary_term' = 'Age High');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_low` SET TAGS ('pii_business_glossary_term' = 'Age Low');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_category` SET TAGS ('pii_business_glossary_term' = 'ICD Code Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_category` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `cc_flag` SET TAGS ('pii_business_glossary_term' = 'CC Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter` SET TAGS ('pii_business_glossary_term' = 'Chapter');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter_code` SET TAGS ('pii_business_glossary_term' = 'Chapter Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}-[A-Z][0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_code` SET TAGS ('pii_business_glossary_term' = 'ICD Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_type` SET TAGS ('pii_business_glossary_term' = 'Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_type` SET TAGS ('pii_value_regex' = 'diagnosis|procedure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `etiology_code_flag` SET TAGS ('pii_business_glossary_term' = 'Etiology Code Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('pii_business_glossary_term' = 'Gender Specific Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `hac_flag` SET TAGS ('pii_business_glossary_term' = 'HAC Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `long_description` SET TAGS ('pii_business_glossary_term' = 'Long Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `manifestation_code_flag` SET TAGS ('pii_business_glossary_term' = 'Manifestation Code Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `mcc_flag` SET TAGS ('pii_business_glossary_term' = 'MCC Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `parent_code` SET TAGS ('pii_business_glossary_term' = 'Parent Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `poa_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'POA Exempt Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `replacement_code` SET TAGS ('pii_business_glossary_term' = 'Replacement Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `short_description` SET TAGS ('pii_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `snomed_ct_mapping` SET TAGS ('pii_business_glossary_term' = 'SNOMED CT Mapping');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `snomed_ct_mapping` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `subcategory` SET TAGS ('pii_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `unacceptable_principal_dx_flag` SET TAGS ('pii_business_glossary_term' = 'Unacceptable Principal Dx Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `valid_for_coding_flag` SET TAGS ('pii_business_glossary_term' = 'Valid for Coding Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_subdomain' = 'billing_codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_procedure_coding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_cpt' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_ama' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_rvu' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_high` SET TAGS ('pii_business_glossary_term' = 'Age Range High');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_low` SET TAGS ('pii_business_glossary_term' = 'Age Range Low');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `anesthesia_base_units` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_category` SET TAGS ('pii_business_glossary_term' = 'CPT Code Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_category` SET TAGS ('pii_value_regex' = 'Category I|Category II|Category III');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_business_glossary_term' = 'Clinical Family');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `conversion_factor` SET TAGS ('pii_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_status` SET TAGS ('pii_business_glossary_term' = 'CPT Code Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_status` SET TAGS ('pii_value_regex' = 'active|inactive|deleted|pending');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `facility_indicator` SET TAGS ('pii_business_glossary_term' = 'Facility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `facility_indicator` SET TAGS ('pii_value_regex' = 'facility|non-facility|both');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `full_descriptor` SET TAGS ('pii_business_glossary_term' = 'Full Descriptor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('pii_business_glossary_term' = 'Gender Specific');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('pii_value_regex' = 'male|female|both');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `global_period` SET TAGS ('pii_business_glossary_term' = 'Global Period');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `malpractice_rvu` SET TAGS ('pii_business_glossary_term' = 'Malpractice RVU');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `medically_unlikely_edit_value` SET TAGS ('pii_business_glossary_term' = 'Medically Unlikely Edit Value');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `modifier_indicator` SET TAGS ('pii_business_glossary_term' = 'Modifier Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `modifier_indicator` SET TAGS ('pii_value_regex' = '0|1|2|3|9');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_business_glossary_term' = 'Multiple Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `national_payment_amount` SET TAGS ('pii_business_glossary_term' = 'National Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `ncci_edit_indicator` SET TAGS ('pii_business_glossary_term' = 'NCCI Edit Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `physician_supervision_required` SET TAGS ('pii_business_glossary_term' = 'Physician Supervision Required');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `physician_supervision_required` SET TAGS ('pii_value_regex' = 'direct|general|personal|none');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `place_of_service_restriction` SET TAGS ('pii_business_glossary_term' = 'Place of Service Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `practice_expense_rvu` SET TAGS ('pii_business_glossary_term' = 'Practice Expense RVU');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `section` SET TAGS ('pii_business_glossary_term' = 'Section');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `short_descriptor` SET TAGS ('pii_business_glossary_term' = 'Short Descriptor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `subsection` SET TAGS ('pii_business_glossary_term' = 'Subsection');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `telemedicine_eligible` SET TAGS ('pii_business_glossary_term' = 'Telemedicine Eligible');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `total_rvu` SET TAGS ('pii_business_glossary_term' = 'Total RVU');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `work_rvu` SET TAGS ('pii_business_glossary_term' = 'Work RVU');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_subdomain' = 'billing_codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_procedure_coding' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_hcpcs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_dme' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_drugs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `age_restriction` SET TAGS ('pii_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `anesthesia_base_units` SET TAGS ('pii_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `asc_payment_indicator` SET TAGS ('pii_business_glossary_term' = 'ASC Payment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_business_glossary_term' = 'Assistant Surgeon Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `bilateral_surgery_indicator` SET TAGS ('pii_business_glossary_term' = 'Bilateral Surgery Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_category` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_business_glossary_term' = 'Co-Surgeon Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_code` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_type` SET TAGS ('pii_business_glossary_term' = 'Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_type` SET TAGS ('pii_value_regex' = 'permanent|temporary|deleted');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `coverage_indicator` SET TAGS ('pii_business_glossary_term' = 'Coverage Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `coverage_indicator` SET TAGS ('pii_value_regex' = 'covered|not_covered|carrier_discretion|bundled|conditional');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Requirement Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `dme_indicator` SET TAGS ('pii_business_glossary_term' = 'DME Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `drug_indicator` SET TAGS ('pii_business_glossary_term' = 'Drug Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `frequency_limit` SET TAGS ('pii_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('pii_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('pii_value_regex' = 'male|female|none');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `global_period` SET TAGS ('pii_business_glossary_term' = 'Global Period');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `intraoperative_percentage` SET TAGS ('pii_business_glossary_term' = 'Intraoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `long_description` SET TAGS ('pii_business_glossary_term' = 'Long Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `modifier_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Modifier Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_business_glossary_term' = 'Multiple Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `ndc_crosswalk_indicator` SET TAGS ('pii_business_glossary_term' = 'NDC Crosswalk Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `opps_payment_indicator` SET TAGS ('pii_business_glossary_term' = 'OPPS Payment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `place_of_service_restriction` SET TAGS ('pii_business_glossary_term' = 'Place of Service Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `postoperative_percentage` SET TAGS ('pii_business_glossary_term' = 'Postoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `preoperative_percentage` SET TAGS ('pii_business_glossary_term' = 'Preoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `pricing_indicator` SET TAGS ('pii_business_glossary_term' = 'Pricing Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `pricing_indicator` SET TAGS ('pii_value_regex' = 'fee_schedule|asc|reasonable_charge|not_priced|contractor_priced');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `prior_authorization_indicator` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `professional_component_indicator` SET TAGS ('pii_business_glossary_term' = 'Professional Component Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `quantity_limit` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `short_description` SET TAGS ('pii_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `superseded_by_code` SET TAGS ('pii_business_glossary_term' = 'Superseded By Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `team_surgery_indicator` SET TAGS ('pii_business_glossary_term' = 'Team Surgery Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `technical_component_indicator` SET TAGS ('pii_business_glossary_term' = 'Technical Component Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_subdomain' = 'billing_codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_drg' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_ms_drg' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_apr_drg' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_grouper' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_reimbursement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_id` SET TAGS ('pii_business_glossary_term' = 'DRG Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `major_diagnostic_category_id` SET TAGS ('pii_business_glossary_term' = 'Major Diagnostic Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('pii_business_glossary_term' = 'Arithmetic Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `bundled_payment_flag` SET TAGS ('pii_business_glossary_term' = 'Bundled Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_business_glossary_term' = 'Clinical Family');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_business_glossary_term' = 'DRG Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `complication_level` SET TAGS ('pii_business_glossary_term' = 'Complication Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `complication_level` SET TAGS ('pii_value_regex' = 'without CC/MCC|with CC|with MCC');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `cost_outlier_threshold` SET TAGS ('pii_business_glossary_term' = 'Cost Outlier Threshold');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_description` SET TAGS ('pii_business_glossary_term' = 'DRG Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_description` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_type` SET TAGS ('pii_business_glossary_term' = 'DRG Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_type` SET TAGS ('pii_value_regex' = 'medical|surgical|procedure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_type` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_business_glossary_term' = 'Geometric Mean LOS');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `grouper_system` SET TAGS ('pii_business_glossary_term' = 'Grouper System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `grouper_system` SET TAGS ('pii_value_regex' = 'MS-DRG|AP-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_charges` SET TAGS ('pii_business_glossary_term' = 'National Average Charges');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_payment` SET TAGS ('pii_business_glossary_term' = 'National Average Payment');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_case_volume` SET TAGS ('pii_business_glossary_term' = 'National Case Volume');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_business_glossary_term' = 'Operating Room Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `post_acute_transfer_flag` SET TAGS ('pii_business_glossary_term' = 'Post Acute Transfer Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_business_glossary_term' = 'Principal Diagnosis Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Procedure Requirement Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `quality_measure_flag` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `readmission_penalty_flag` SET TAGS ('pii_business_glossary_term' = 'Readmission Penalty Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `relative_weight` SET TAGS ('pii_business_glossary_term' = 'Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `special_pay_flag` SET TAGS ('pii_business_glossary_term' = 'Special Pay Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_snomed_ct' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_clinical_terminology' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'SNOMED Concept Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `parent_concept_snomed_concept_id` SET TAGS ('pii_business_glossary_term' = 'Parent Concept');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_business_glossary_term' = 'Clinical Documentation Section');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_class` SET TAGS ('pii_business_glossary_term' = 'Concept Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_definition` SET TAGS ('pii_business_glossary_term' = 'Concept Definition');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_status` SET TAGS ('pii_business_glossary_term' = 'Concept Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `cpt_map_target` SET TAGS ('pii_business_glossary_term' = 'CPT Map Target');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `definition_status` SET TAGS ('pii_business_glossary_term' = 'Definition Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `effective_time` SET TAGS ('pii_business_glossary_term' = 'Effective Time');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fhir_value_set_membership` SET TAGS ('pii_business_glossary_term' = 'FHIR Value Set Membership');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_business_glossary_term' = 'Fully Specified Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `hierarchy_level` SET TAGS ('pii_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_correlation` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Map Correlation');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_correlation` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_target` SET TAGS ('pii_business_glossary_term' = 'ICD-10 Map Target');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_target` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_ehr_preferred` SET TAGS ('pii_business_glossary_term' = 'Is EHR Preferred');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_leaf_concept` SET TAGS ('pii_business_glossary_term' = 'Is Leaf Concept');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_primitive` SET TAGS ('pii_business_glossary_term' = 'Is Primitive');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_reportable` SET TAGS ('pii_business_glossary_term' = 'Is Reportable');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `last_used_date` SET TAGS ('pii_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `loinc_map_target` SET TAGS ('pii_business_glossary_term' = 'LOINC Map Target');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `module_code` SET TAGS ('pii_business_glossary_term' = 'Module Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `patient_friendly_term` SET TAGS ('pii_business_glossary_term' = 'Patient Friendly Term');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `preferred_term` SET TAGS ('pii_business_glossary_term' = 'Preferred Term');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `quality_measure_inclusion` SET TAGS ('pii_business_glossary_term' = 'Quality Measure Inclusion');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `relationship_count` SET TAGS ('pii_business_glossary_term' = 'Relationship Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `rxnorm_map_target` SET TAGS ('pii_business_glossary_term' = 'RxNorm Map Target');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `semantic_tag` SET TAGS ('pii_business_glossary_term' = 'Semantic Tag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `specialty_relevance` SET TAGS ('pii_business_glossary_term' = 'Specialty Relevance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `synonym_count` SET TAGS ('pii_business_glossary_term' = 'Synonym Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `top_level_hierarchy` SET TAGS ('pii_business_glossary_term' = 'Top Level Hierarchy');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `usage_frequency_rank` SET TAGS ('pii_business_glossary_term' = 'Usage Frequency Rank');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_loinc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_laboratory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_observations' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_code_id` SET TAGS ('pii_business_glossary_term' = 'LOINC Code Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `class` SET TAGS ('pii_business_glossary_term' = 'Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `component` SET TAGS ('pii_business_glossary_term' = 'Component');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_business_glossary_term' = 'Consumer Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `deprecated_date` SET TAGS ('pii_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_business_glossary_term' = 'Display Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `example_ucum_units` SET TAGS ('pii_business_glossary_term' = 'Example UCUM Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `example_units` SET TAGS ('pii_business_glossary_term' = 'Example Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `external_copyright_notice` SET TAGS ('pii_business_glossary_term' = 'External Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `hl7_field_subfield_code` SET TAGS ('pii_business_glossary_term' = 'HL7 Field Subfield Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `hl7_v3_code_system_oid` SET TAGS ('pii_business_glossary_term' = 'HL7 v3 Code System OID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `last_verified_date` SET TAGS ('pii_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `local_code` SET TAGS ('pii_business_glossary_term' = 'Local Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_number` SET TAGS ('pii_business_glossary_term' = 'LOINC Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_number` SET TAGS ('pii_value_regex' = '^[0-9]+-[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_number` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_business_glossary_term' = 'Long Common Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `method_type` SET TAGS ('pii_business_glossary_term' = 'Method Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_business_glossary_term' = 'Order Observation Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `panel_type` SET TAGS ('pii_business_glossary_term' = 'Panel Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `panel_type` SET TAGS ('pii_value_regex' = 'Panel|Battery|Set');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `property` SET TAGS ('pii_business_glossary_term' = 'Property');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_business_glossary_term' = 'Related Names');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `scale_type` SET TAGS ('pii_business_glossary_term' = 'Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `scale_type` SET TAGS ('pii_value_regex' = 'Qn|Ord|Nom|Nar|Doc');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `survey_question_source` SET TAGS ('pii_business_glossary_term' = 'Survey Question Source');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `survey_question_text` SET TAGS ('pii_business_glossary_term' = 'Survey Question Text');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `system` SET TAGS ('pii_business_glossary_term' = 'System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `time_aspect` SET TAGS ('pii_business_glossary_term' = 'Time Aspect');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_ndc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_drugs' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_pharmacy' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_rxnorm' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'NDC Drug Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `active_ingredient` SET TAGS ('pii_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `atc_code` SET TAGS ('pii_business_glossary_term' = 'ATC Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `biosimilar_flag` SET TAGS ('pii_business_glossary_term' = 'Biosimilar Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `black_box_warning_flag` SET TAGS ('pii_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_business_glossary_term' = 'DEA Schedule');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_value_regex' = 'CI|CII|CIII|CIV|CV|');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dosage_form` SET TAGS ('pii_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Medication Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `formulary_status` SET TAGS ('pii_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `formulary_status` SET TAGS ('pii_value_regex' = 'formulary|non_formulary|restricted|preferred');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `gpi_code` SET TAGS ('pii_business_glossary_term' = 'GPI Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_business_glossary_term' = 'High Alert Medication Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_business_glossary_term' = 'Labeler Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_business_glossary_term' = 'Marketing Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_business_glossary_term' = 'Marketing End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_business_glossary_term' = 'Marketing Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_code` SET TAGS ('pii_value_regex' = '^d{11}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_business_glossary_term' = 'Nonproprietary Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `orange_book_code` SET TAGS ('pii_business_glossary_term' = 'Orange Book Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `over_the_counter_flag` SET TAGS ('pii_business_glossary_term' = 'Over the Counter Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_description` SET TAGS ('pii_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_quantity` SET TAGS ('pii_business_glossary_term' = 'Package Quantity');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_unit` SET TAGS ('pii_business_glossary_term' = 'Package Unit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `pregnancy_category` SET TAGS ('pii_business_glossary_term' = 'Pregnancy Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `pregnancy_category` SET TAGS ('pii_value_regex' = 'A|B|C|D|X|N');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_business_glossary_term' = 'Proprietary Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('pii_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `route_of_administration` SET TAGS ('pii_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxcui` SET TAGS ('pii_business_glossary_term' = 'RxCUI');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_business_glossary_term' = 'RxNorm Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_source_vocabulary` SET TAGS ('pii_business_glossary_term' = 'RxNorm Source Vocabulary');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_suppress_flag` SET TAGS ('pii_business_glossary_term' = 'RxNorm Suppress Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_term_type` SET TAGS ('pii_business_glossary_term' = 'RxNorm Term Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `snomed_ct_code` SET TAGS ('pii_business_glossary_term' = 'SNOMED CT Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `snomed_ct_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `strength` SET TAGS ('pii_business_glossary_term' = 'Strength');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `strength_unit` SET TAGS ('pii_business_glossary_term' = 'Strength Unit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `therapeutic_class` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `therapeutic_class` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `unii_code` SET TAGS ('pii_business_glossary_term' = 'UNII Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `vaccine_flag` SET TAGS ('pii_business_glossary_term' = 'Vaccine Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_fhir' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_value_set' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_terminology' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_value_set_id` SET TAGS ('pii_business_glossary_term' = 'FHIR Value Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `binding_strength` SET TAGS ('pii_business_glossary_term' = 'Binding Strength');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `binding_strength` SET TAGS ('pii_value_regex' = 'required|extensible|preferred|example');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `canonical_url` SET TAGS ('pii_business_glossary_term' = 'Canonical URL');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `canonical_url` SET TAGS ('pii_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `canonical_url` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `compose_exclude_count` SET TAGS ('pii_business_glossary_term' = 'Compose Exclude Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `compose_include_count` SET TAGS ('pii_business_glossary_term' = 'Compose Include Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `contact_json` SET TAGS ('pii_business_glossary_term' = 'Contact JSON');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `copyright` SET TAGS ('pii_business_glossary_term' = 'Copyright');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_value_set_description` SET TAGS ('pii_business_glossary_term' = 'FHIR Value Set Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_business_glossary_term' = 'Expansion Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_offset` SET TAGS ('pii_business_glossary_term' = 'Expansion Offset');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_parameter_json` SET TAGS ('pii_business_glossary_term' = 'Expansion Parameter JSON');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expansion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_total_concepts` SET TAGS ('pii_business_glossary_term' = 'Expansion Total Concepts');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `experimental_flag` SET TAGS ('pii_business_glossary_term' = 'Experimental Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_element_path` SET TAGS ('pii_business_glossary_term' = 'FHIR Element Path');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `immutable_flag` SET TAGS ('pii_business_glossary_term' = 'Immutable Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `jurisdiction_codes` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `publisher` SET TAGS ('pii_business_glossary_term' = 'Publisher');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `use_context_json` SET TAGS ('pii_business_glossary_term' = 'Use Context JSON');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_business_glossary_term' = 'Value Set Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_oid` SET TAGS ('pii_business_glossary_term' = 'Value Set OID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_oid` SET TAGS ('pii_value_regex' = '^[0-2](.(0|[1-9][0-9]*))+$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_subdomain' = 'registry_directory');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_npi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_provider' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_nppes' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_taxonomy' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_business_glossary_term' = 'NPI Registry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Practice Location Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_foreign_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Official First Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Official Last Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Official Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_business_glossary_term' = 'Authorized Official Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_title` SET TAGS ('pii_business_glossary_term' = 'Authorized Official Title');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `employer_identification_number` SET TAGS ('pii_business_glossary_term' = 'Employer Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `employer_identification_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `entity_type_code` SET TAGS ('pii_business_glossary_term' = 'Entity Type Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `enumeration_date` SET TAGS ('pii_business_glossary_term' = 'Enumeration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `last_update_date` SET TAGS ('pii_business_glossary_term' = 'Last Update Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_business_glossary_term' = 'Mailing Address City');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_business_glossary_term' = 'Mailing Address State');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_business_glossary_term' = 'Mailing Address Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'NPI');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_business_glossary_term' = 'Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_business_glossary_term' = 'Organization Other Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_business_glossary_term' = 'Practice Location Address Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_business_glossary_term' = 'Practice Location Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_business_glossary_term' = 'Practice Location Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_business_glossary_term' = 'Practice Location Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_business_glossary_term' = 'Practice Location Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_code` SET TAGS ('pii_business_glossary_term' = 'Primary Taxonomy Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_switch` SET TAGS ('pii_business_glossary_term' = 'Primary Taxonomy Switch');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_credential` SET TAGS ('pii_business_glossary_term' = 'Provider Credential');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_credential` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_business_glossary_term' = 'Provider First Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('pii_business_glossary_term' = 'Provider Gender Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_business_glossary_term' = 'Provider Last Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_business_glossary_term' = 'Provider Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_business_glossary_term' = 'Provider Name Prefix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_business_glossary_term' = 'Provider Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_credential` SET TAGS ('pii_business_glossary_term' = 'Provider Other Credential');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_credential` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_business_glossary_term' = 'Provider Other First Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_business_glossary_term' = 'Provider Other Last Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_business_glossary_term' = 'Provider Other Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_business_glossary_term' = 'Provider Other Name Prefix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_business_glossary_term' = 'Provider Other Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `reactivation_date` SET TAGS ('pii_business_glossary_term' = 'Reactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_business_glossary_term' = 'Replacement NPI');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_subdomain' = 'registry_directory');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_geography' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_zip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_county' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_cbsa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_hrr' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_hsa' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Geographic Region Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_business_glossary_term' = 'Parent Region');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_foreign_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `aco_service_area_flag` SET TAGS ('pii_business_glossary_term' = 'ACO Service Area Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_code` SET TAGS ('pii_business_glossary_term' = 'CBSA Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_business_glossary_term' = 'CBSA Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_division` SET TAGS ('pii_business_glossary_term' = 'Census Division');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_region` SET TAGS ('pii_business_glossary_term' = 'Census Region');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_region` SET TAGS ('pii_value_regex' = 'northeast|midwest|south|west');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cms_region_number` SET TAGS ('pii_business_glossary_term' = 'CMS Region Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `fips_code` SET TAGS ('pii_business_glossary_term' = 'FIPS Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `hrr_code` SET TAGS ('pii_business_glossary_term' = 'HRR Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `hsa_code` SET TAGS ('pii_business_glossary_term' = 'HSA Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `median_household_income` SET TAGS ('pii_business_glossary_term' = 'Median Household Income');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `population_estimate` SET TAGS ('pii_business_glossary_term' = 'Population Estimate');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `poverty_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Poverty Rate Percent');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_code` SET TAGS ('pii_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_business_glossary_term' = 'Region Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_type` SET TAGS ('pii_business_glossary_term' = 'Region Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `ruca_code` SET TAGS ('pii_business_glossary_term' = 'RUCA Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_business_glossary_term' = 'State Abbreviation');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `time_zone` SET TAGS ('pii_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `uninsured_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Uninsured Rate Percent');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `urban_rural_classification` SET TAGS ('pii_business_glossary_term' = 'Urban Rural Classification');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `urban_rural_classification` SET TAGS ('pii_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_subdomain' = 'billing_codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_condition_code' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_ub04' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_claim_form' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_billing' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_business_glossary_term' = 'Condition Code Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `ama_indicator` SET TAGS ('pii_business_glossary_term' = 'AMA Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `bilateral_indicator` SET TAGS ('pii_business_glossary_term' = 'Bilateral Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_business_glossary_term' = 'Condition Code Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `claim_form_type` SET TAGS ('pii_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `claim_form_type` SET TAGS ('pii_value_regex' = 'UB-04|CMS-1500|BOTH');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `code_type` SET TAGS ('pii_business_glossary_term' = 'Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `commercial_payer_flag` SET TAGS ('pii_business_glossary_term' = 'Commercial Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_business_glossary_term' = 'Condition Code Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `expired_indicator` SET TAGS ('pii_business_glossary_term' = 'Expired Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `facility_indicator` SET TAGS ('pii_business_glossary_term' = 'Facility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `governing_body` SET TAGS ('pii_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `governing_body` SET TAGS ('pii_value_regex' = 'NUBC|CMS|AMA|STATE');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `hospice_indicator` SET TAGS ('pii_business_glossary_term' = 'Hospice Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Medicaid Approved Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicare_approved_flag` SET TAGS ('pii_business_glossary_term' = 'Medicare Approved Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `pricing_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Pricing Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `professional_indicator` SET TAGS ('pii_business_glossary_term' = 'Professional Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `replacement_code` SET TAGS ('pii_business_glossary_term' = 'Replacement Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `requires_value_flag` SET TAGS ('pii_business_glossary_term' = 'Requires Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `short_description` SET TAGS ('pii_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `ub04_form_locator` SET TAGS ('pii_business_glossary_term' = 'UB-04 Form Locator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `usage_notes` SET TAGS ('pii_business_glossary_term' = 'Usage Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_code_set' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_version' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_metadata' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_terminology' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `superseded_by_version_code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Superseded By Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('pii_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('pii_value_regex' = 'MD5|SHA256|SHA512');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_business_glossary_term' = 'Code Set Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_type` SET TAGS ('pii_business_glossary_term' = 'Code Set Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_type` SET TAGS ('pii_value_regex' = 'diagnosis|procedure|drug|observation|terminology|grouper');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `compliance_year` SET TAGS ('pii_business_glossary_term' = 'Compliance Year');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `copyright_notice` SET TAGS ('pii_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `download_timestamp` SET TAGS ('pii_business_glossary_term' = 'Download Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_hash` SET TAGS ('pii_business_glossary_term' = 'File Hash');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `format_type` SET TAGS ('pii_business_glossary_term' = 'Format Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `format_type` SET TAGS ('pii_value_regex' = 'csv|xml|json|fhir|hl7|proprietary');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `is_hipaa_compliant` SET TAGS ('pii_business_glossary_term' = 'Is HIPAA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `language_code` SET TAGS ('pii_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `license_type` SET TAGS ('pii_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `license_type` SET TAGS ('pii_value_regex' = 'public_domain|proprietary|open_source|restricted');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_status` SET TAGS ('pii_business_glossary_term' = 'Load Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|failed|validated');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_timestamp` SET TAGS ('pii_business_glossary_term' = 'Load Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `record_count` SET TAGS ('pii_business_glossary_term' = 'Record Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `release_notes` SET TAGS ('pii_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `source_authority` SET TAGS ('pii_business_glossary_term' = 'Source Authority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `source_url` SET TAGS ('pii_business_glossary_term' = 'Source URL');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `usage_scope` SET TAGS ('pii_business_glossary_term' = 'Usage Scope');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `usage_scope` SET TAGS ('pii_value_regex' = 'clinical|billing|research|quality|all');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_status` SET TAGS ('pii_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_status` SET TAGS ('pii_value_regex' = 'not_validated|passed|failed|warning');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_status` SET TAGS ('pii_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_status` SET TAGS ('pii_value_regex' = 'draft|active|superseded|retired|deprecated');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_crosswalk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_mapping' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_terminology' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `crosswalk_id` SET TAGS ('pii_business_glossary_term' = 'Crosswalk Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `code_set_version_id` SET TAGS ('pii_business_glossary_term' = 'Code Set Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `approximate_flag` SET TAGS ('pii_business_glossary_term' = 'Approximate Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `choice_list_indicator` SET TAGS ('pii_business_glossary_term' = 'Choice List Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `combination_flag` SET TAGS ('pii_business_glossary_term' = 'Combination Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `directionality` SET TAGS ('pii_business_glossary_term' = 'Directionality');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `directionality` SET TAGS ('pii_value_regex' = 'forward|backward|bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `last_validated_date` SET TAGS ('pii_business_glossary_term' = 'Last Validated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `map_group` SET TAGS ('pii_business_glossary_term' = 'Map Group');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `map_priority` SET TAGS ('pii_business_glossary_term' = 'Map Priority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_authority` SET TAGS ('pii_business_glossary_term' = 'Mapping Authority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_purpose` SET TAGS ('pii_business_glossary_term' = 'Mapping Purpose');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_quality` SET TAGS ('pii_business_glossary_term' = 'Mapping Quality');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_quality` SET TAGS ('pii_value_regex' = 'exact|high|moderate|low');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_rule` SET TAGS ('pii_business_glossary_term' = 'Mapping Rule');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_type` SET TAGS ('pii_business_glossary_term' = 'Mapping Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_type` SET TAGS ('pii_value_regex' = 'equivalent|broader|narrower|related|inexact|unmatched');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `no_map_flag` SET TAGS ('pii_business_glossary_term' = 'No Map Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `scenario_flag` SET TAGS ('pii_business_glossary_term' = 'Scenario Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code` SET TAGS ('pii_business_glossary_term' = 'Source Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{1,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_display` SET TAGS ('pii_business_glossary_term' = 'Source Code Display');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_system` SET TAGS ('pii_business_glossary_term' = 'Source Code System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_system` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code` SET TAGS ('pii_business_glossary_term' = 'Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{1,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_display` SET TAGS ('pii_business_glossary_term' = 'Target Code Display');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_system` SET TAGS ('pii_business_glossary_term' = 'Target Code System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_system` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `usage_count` SET TAGS ('pii_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `validated_by` SET TAGS ('pii_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_subdomain' = 'billing_codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_reference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_mdc' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_drg' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_grouper' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_reimbursement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_id` SET TAGS ('pii_business_glossary_term' = 'Major Diagnostic Category Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `parent_major_diagnostic_category_id` SET TAGS ('pii_business_glossary_term' = 'Parent Major Diagnostic Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `average_length_of_stay_days` SET TAGS ('pii_business_glossary_term' = 'Average Length of Stay Days');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `body_system` SET TAGS ('pii_business_glossary_term' = 'Body System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `case_volume_rank` SET TAGS ('pii_business_glossary_term' = 'Case Volume Rank');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `classification_type` SET TAGS ('pii_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `complication_comorbidity_logic` SET TAGS ('pii_business_glossary_term' = 'Complication Comorbidity Logic');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `drg_count` SET TAGS ('pii_business_glossary_term' = 'DRG Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `drg_count` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_end` SET TAGS ('pii_business_glossary_term' = 'ICD-10-CM Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_end` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_start` SET TAGS ('pii_business_glossary_term' = 'ICD-10-CM Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_start` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_end` SET TAGS ('pii_business_glossary_term' = 'ICD-10-PCS Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_end` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_start` SET TAGS ('pii_business_glossary_term' = 'ICD-10-PCS Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_start` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `last_updated_date` SET TAGS ('pii_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `mdc_code` SET TAGS ('pii_business_glossary_term' = 'MDC Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `mdc_code` SET TAGS ('pii_natural_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `mdc_number` SET TAGS ('pii_business_glossary_term' = 'MDC Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `pre_mdc_indicator` SET TAGS ('pii_business_glossary_term' = 'Pre-MDC Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `reimbursement_impact_level` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Impact Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `relative_weight_average` SET TAGS ('pii_business_glossary_term' = 'Relative Weight Average');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('pii_business_glossary_term' = 'Surgical Medical Partition');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `ungroupable_indicator` SET TAGS ('pii_business_glossary_term' = 'Ungroupable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` SET TAGS ('pii_subdomain' = 'registry_directory');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`reference_sdoh_zcode_mapping` ALTER COLUMN `icd10_z_code` SET TAGS ('pii_sensitivity' = 'phi');
