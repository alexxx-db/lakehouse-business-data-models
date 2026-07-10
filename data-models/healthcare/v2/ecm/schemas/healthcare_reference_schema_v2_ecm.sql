-- Schema for Domain: reference | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`reference` COMMENT 'SSOT for all enterprise reference data and standardized code sets. Owns ICD-10 diagnosis codes, CPT procedure codes, HCPCS codes, DRG (Diagnosis-Related Group) grouper tables, SNOMED CT clinical terms, LOINC observation codes, NDC drug codes, payer master lists, provider taxonomies, geographic codes, and HL7/FHIR value sets. Provides the authoritative terminology consumed by clinical, billing, pharmacy, and quality domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`icd_code` (
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the ICD code record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: ICD-10-CM and ICD-10-PCS codes are published annually by CMS with version-specific effective/expiration dates. The icd_code table has version (STRING) and status attributes that should be normalized t',
    `age_high` STRING COMMENT 'The maximum patient age (in years) for which this ICD code is clinically appropriate. Used for coding validation and quality checks. Null if no maximum age restriction applies.',
    `age_low` STRING COMMENT 'The minimum patient age (in years) for which this ICD code is clinically appropriate. Used for coding validation and quality checks. Null if no minimum age restriction applies.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this ICD code is valid for billing and reimbursement purposes. Only billable codes may be submitted on claims to payers. Non-billable codes are typically higher-level category codes used for classification only.',
    `icd_code_category` STRING COMMENT 'The three-character category code representing a group of related conditions or procedures within a chapter (e.g., A01 for typhoid and paratyphoid fevers).',
    `cc_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code is classified as a Complication or Comorbidity (CC) for DRG assignment and severity adjustment purposes.',
    `chapter` STRING COMMENT 'The ICD-10 chapter to which this code belongs, representing the highest-level clinical category (e.g., Chapter 1: Certain infectious and parasitic diseases, Chapter 9: Diseases of the circulatory system).',
    `chapter_code` STRING COMMENT 'The alphanumeric range defining the chapter boundaries (e.g., A00-B99 for infectious diseases). Used for hierarchical grouping and reporting.. Valid values are `^[A-Z][0-9]{2}-[A-Z][0-9]{2}$`',
    `icd_code_code` STRING COMMENT 'The full ICD-10-CM diagnosis code or ICD-10-PCS procedure code as published by WHO and maintained by CMS. Format follows alphanumeric pattern with optional decimal subdivision (e.g., A01.0, Z99.89).. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `code_type` STRING COMMENT 'Indicates whether this code represents a diagnosis (ICD-10-CM) or a procedure (ICD-10-PCS).. Valid values are `diagnosis|procedure`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ICD code record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'The date on which this ICD code became valid for use in clinical documentation, billing, and reporting. Aligns with annual CMS ICD-10 update cycles (typically October 1).',
    `etiology_code_flag` BOOLEAN COMMENT 'Indicates whether this code represents the underlying etiology or cause of a condition and should be sequenced before manifestation codes per ICD-10-CM coding conventions.',
    `expiration_date` DATE COMMENT 'The date on which this ICD code was retired or replaced and is no longer valid for use. Null for currently active codes.',
    `gender_specific_flag` BOOLEAN COMMENT 'Indicates whether this ICD code is applicable only to male patients, only to female patients, or to both. Used for clinical validation and coding accuracy.',
    `hac_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code represents a Hospital-Acquired Condition (HAC) as defined by CMS. HACs may result in payment penalties under the Hospital-Acquired Condition Reduction Program.',
    `long_description` STRING COMMENT 'Full clinical description of the diagnosis or procedure code, providing comprehensive detail for clinical documentation, coding accuracy, and medical record completeness.',
    `manifestation_code_flag` BOOLEAN COMMENT 'Indicates whether this code represents a manifestation of an underlying disease and must be sequenced after the underlying condition code per ICD-10-CM coding conventions.',
    `mcc_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code is classified as a Major Complication or Comorbidity (MCC) for DRG assignment and severity adjustment purposes. MCCs have greater impact on reimbursement than standard CCs.',
    `parent_code` STRING COMMENT 'The immediate parent code in the ICD-10 hierarchy, enabling hierarchical rollup and drill-down navigation for reporting and analytics.',
    `poa_exempt_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code is exempt from the CMS Present on Admission (POA) reporting requirement for inpatient claims. POA-exempt codes do not require a POA indicator on UB-04 claims.',
    `replacement_code` STRING COMMENT 'The ICD code that replaces this code if the code has been retired or superseded. Used for code mapping and historical claims reprocessing.',
    `short_description` STRING COMMENT 'Abbreviated clinical description of the diagnosis or procedure code, typically used in constrained display contexts such as billing forms and summary reports.',
    `snomed_ct_mapping` STRING COMMENT 'The corresponding SNOMED CT concept identifier(s) mapped to this ICD code, enabling interoperability with clinical terminology systems and EHR platforms.',
    `subcategory` STRING COMMENT 'The four-character subcategory code providing additional clinical specificity within a category (e.g., A01.0 for typhoid fever).',
    `unacceptable_principal_dx_flag` BOOLEAN COMMENT 'Indicates whether this diagnosis code is prohibited from being used as the principal diagnosis on an inpatient claim per CMS coding guidelines.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this ICD code record was last modified in the system. Used for audit trail and change tracking.',
    `valid_for_coding_flag` BOOLEAN COMMENT 'Indicates whether this code is valid for use in clinical documentation and coding. Codes may be invalid due to retirement, replacement, or administrative reasons.',
    CONSTRAINT pk_icd_code PRIMARY KEY(`icd_code_id`)
) COMMENT 'Authoritative master catalog of ICD-10-CM diagnosis codes and ICD-10-PCS procedure codes as published by WHO and maintained by CMS. Each record captures the full code, short and long descriptions, code category, chapter, validity dates, billable flag, and hierarchical parent code. Consumed by clinical documentation, billing, claims, and quality domains for diagnosis and procedure coding.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` (
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the CPT code record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: CPT codes are published annually by the AMA with version-specific RVU values and payment amounts. The cpt_code table tracks effective_date and termination_date but lacks explicit version tracking. Add',
    `age_range_high` STRING COMMENT 'Maximum patient age (in years) for which the CPT code is clinically appropriate. Null if no upper age restriction applies. Used for claims editing and clinical decision support.',
    `age_range_low` STRING COMMENT 'Minimum patient age (in years) for which the CPT code is clinically appropriate. Null if no lower age restriction applies. Used for claims editing and clinical decision support.',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'Base unit value assigned to anesthesia CPT codes, representing the complexity and risk of the anesthesia service. Used in anesthesia billing formulas along with time units and modifying factors.',
    `cpt_code_category` STRING COMMENT 'Classification of the CPT code. Category I codes describe established procedures and services. Category II codes are supplemental tracking codes for performance measurement. Category III codes are temporary codes for emerging technology, services, and procedures.. Valid values are `Category I|Category II|Category III`',
    `clinical_family` STRING COMMENT 'Grouping of clinically related CPT codes, such as all codes for a specific type of surgery or diagnostic test. Used for clinical pathway design, order sets, and utilization management.',
    `conversion_factor` DECIMAL(18,2) COMMENT 'Dollar amount multiplied by total RVU to calculate Medicare payment. Updated annually by CMS. Used in revenue cycle forecasting and contract modeling.',
    `cpt_code` STRING COMMENT 'Five-digit numeric code published by the American Medical Association (AMA) that identifies medical, surgical, and diagnostic services. This is the authoritative business identifier used on CMS-1500 claims, in CPOE systems, and for professional billing.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CPT code record was first created in the enterprise reference data system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date on which the CPT code became valid for use in billing and clinical documentation. Typically January 1 of the release year for annual updates.',
    `facility_indicator` STRING COMMENT 'Indicates whether the CPT code is typically performed in a facility setting (hospital, ASC) or non-facility setting (physician office). Affects practice expense RVU calculation.. Valid values are `facility|non-facility|both`',
    `full_descriptor` STRING COMMENT 'Complete clinical description of the procedure or service, including anatomical site, approach, and any modifiers or conditions. Used for clinical documentation, coding review, and CDI workflows.',
    `gender_specific` STRING COMMENT 'Indicates whether the procedure is anatomically or clinically specific to male or female patients. Used for claims editing and clinical decision support.. Valid values are `male|female|both`',
    `global_period` STRING COMMENT 'Number of days of post-operative care included in the procedure payment. 000 = endoscopic or minor procedure with 0-day follow-up. 010 = minor procedure with 10-day follow-up. 090 = major surgery with 90-day follow-up. XXX = global concept does not apply. YYY = carrier determines global period. ZZZ = add-on code. MMM = maternity codes with global period. [ENUM-REF-CANDIDATE: 000|010|090|XXX|YYY|ZZZ|MMM — 7 candidates stripped; promote to reference product]',
    `malpractice_rvu` DECIMAL(18,2) COMMENT 'Relative Value Unit representing the professional liability insurance component. Reflects the relative risk and cost of malpractice insurance for the service.',
    `medically_unlikely_edit_value` STRING COMMENT 'Maximum number of units of service that CMS considers medically reasonable for a single patient on a single date of service. Used for claims editing and fraud detection.',
    `modifier_indicator` STRING COMMENT 'Indicates whether bilateral surgery, assistant surgeon, or co-surgeon modifiers are applicable. 0 = not subject to modifier rules. 1 = bilateral surgery applies. 2 = assistant surgeon may not be paid. 3 = assistant surgeon and co-surgeon rules apply. 9 = concept does not apply.. Valid values are `0|1|2|3|9`',
    `multiple_procedure_indicator` STRING COMMENT 'Indicates payment adjustment rules when multiple procedures are performed in the same session. 0 = no payment adjustment. 1 = standard payment adjustment applies. 2 = bilateral adjustment applies. 3 = assistant surgeon adjustment. 4 = diagnostic imaging adjustment. 5 = therapy adjustment. 9 = concept does not apply. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|9 — 7 candidates stripped; promote to reference product]',
    `national_payment_amount` DECIMAL(18,2) COMMENT 'National average Medicare payment amount for the CPT code, calculated as total RVU multiplied by the conversion factor. Actual payment varies by geographic locality. Used for budgeting and benchmarking.',
    `ncci_edit_indicator` BOOLEAN COMMENT 'Indicates whether this CPT code is subject to National Correct Coding Initiative edits, which prevent inappropriate code combinations from being billed together. Used for claims scrubbing and compliance.',
    `physician_supervision_required` STRING COMMENT 'Level of physician supervision required for the service to be billable. Direct = physician must be present in the room. General = physician must be immediately available. Personal = physician must perform the service. None = no supervision required.. Valid values are `direct|general|personal|none`',
    `place_of_service_restriction` STRING COMMENT 'Comma-separated list of valid CMS Place of Service codes where this CPT code may be performed and billed. Used for claims editing and compliance validation.',
    `practice_expense_rvu` DECIMAL(18,2) COMMENT 'Relative Value Unit representing the practice expense component, including clinical staff, medical supplies, and equipment costs. Varies by facility vs non-facility setting.',
    `section` STRING COMMENT 'High-level section of the CPT code set to which this code belongs, such as Evaluation and Management, Anesthesia, Surgery, Radiology, Pathology and Laboratory, or Medicine. Used for reporting and analytics grouping.',
    `short_descriptor` STRING COMMENT 'Abbreviated description of the procedure or service, typically 28 characters or fewer, used in billing systems and charge capture interfaces for space-constrained displays.',
    `source_system_code` STRING COMMENT 'Unique identifier for this CPT code in the source system. Used for data lineage, reconciliation, and troubleshooting integration issues.',
    `cpt_code_status` STRING COMMENT 'Current lifecycle status of the CPT code. Active codes are valid for billing. Inactive codes have been retired but retained for historical claims. Deleted codes are no longer recognized. Pending codes are scheduled for future activation.. Valid values are `active|inactive|deleted|pending`',
    `subsection` STRING COMMENT 'Subsection within the CPT section, providing more granular classification such as Digestive System, Cardiovascular System, or Office Visits. Used for clinical analytics and charge capture workflows.',
    `telemedicine_eligible` BOOLEAN COMMENT 'Indicates whether the service can be delivered via telemedicine or telehealth platforms and remain eligible for reimbursement. Updated based on CMS and payer policies.',
    `termination_date` DATE COMMENT 'Date on which the CPT code was retired or deleted from the active code set. Null for currently active codes. Used to prevent billing of obsolete codes and support historical claims adjudication.',
    `total_rvu` DECIMAL(18,2) COMMENT 'Sum of work RVU, practice expense RVU, and malpractice RVU. Used to calculate Medicare reimbursement and benchmark physician productivity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CPT code record was last modified in the enterprise reference data system. Used for change tracking and data quality monitoring.',
    `work_rvu` DECIMAL(18,2) COMMENT 'Relative Value Unit representing the physician work component, including time, technical skill, physical effort, mental effort, and judgment required to perform the service. Used in MIPS reporting and physician compensation models.',
    CONSTRAINT pk_cpt_code PRIMARY KEY(`cpt_code_id`)
) COMMENT 'Authoritative master catalog of CPT (Current Procedural Terminology) codes published by the AMA. Captures CPT code, descriptor (short and full), category (Category I, II, III), work RVU, practice expense RVU, malpractice RVU, total RVU, global period, effective and termination dates. Used by professional billing (CMS-1500), MIPS reporting, and clinical order management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` (
    `hcpcs_code_id` BIGINT COMMENT 'Unique identifier for the HCPCS code record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: HCPCS Level II codes are maintained by CMS with annual updates and quarterly releases. The hcpcs_code table has version_year (INT) and status attributes that should be normalized to code_set_version f',
    `age_restriction` STRING COMMENT 'Indicates any age-based coverage restrictions for this HCPCS code (e.g., pediatric only, adult only, age 65+). Defines patient age eligibility criteria.',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'The base unit value assigned to anesthesia-related HCPCS codes, used in calculating anesthesia reimbursement. Null for non-anesthesia codes.',
    `asc_payment_indicator` STRING COMMENT 'Indicates the payment methodology for this HCPCS code when performed in an Ambulatory Surgical Center setting. Defines whether the code is separately payable, bundled, or excluded from ASC payment.',
    `assistant_surgeon_indicator` STRING COMMENT 'Indicates whether an assistant surgeon is allowed for this HCPCS code and the applicable payment percentage for assistant surgeon services.',
    `bilateral_surgery_indicator` STRING COMMENT 'Indicates whether this HCPCS code is eligible for bilateral surgery payment adjustment when performed on both sides of the body during the same operative session.',
    `hcpcs_code_category` STRING COMMENT 'The major category of the HCPCS code based on the first letter: A=Transportation/Medical Supplies, B=Enteral/Parenteral, C=Outpatient PPS, D=Dental, E=DME, G=Temporary Procedures, H=Alcohol/Drug, J=Drugs, K=Temporary Codes, L=Orthotics/Prosthetics, M=Medical Services, P=Pathology/Lab, Q=Temporary Codes, R=Diagnostic Radiology, S=Private Payer, T=State Medicaid, V=Vision/Hearing. [ENUM-REF-CANDIDATE: A|B|C|D|E|G|H|J|K|L|M|P|Q|R|S|T|V — 17 candidates stripped; promote to reference product]',
    `co_surgeon_indicator` STRING COMMENT 'Indicates whether co-surgeons are allowed for this HCPCS code, where two surgeons perform distinct portions of a complex procedure.',
    `hcpcs_code_code` STRING COMMENT 'The five-character alphanumeric HCPCS Level II code (e.g., E0601, J1234). First character is always a letter (A-V), followed by four digits. Used to identify durable medical equipment, prosthetics, orthotics, supplies, drugs, and non-physician services.. Valid values are `^[A-Z][0-9]{4}$`',
    `code_type` STRING COMMENT 'Classification of the code lifecycle: permanent codes are established in the annual update, temporary codes are used for emerging technology or services, deleted codes are no longer valid.. Valid values are `permanent|temporary|deleted`',
    `coverage_indicator` STRING COMMENT 'Indicates whether the HCPCS code is covered by Medicare: covered codes are reimbursable, not_covered codes are excluded, carrier_discretion allows local Medicare Administrative Contractor (MAC) determination, bundled codes are included in other services, conditional codes require specific clinical criteria.. Valid values are `covered|not_covered|carrier_discretion|bundled|conditional`',
    `diagnosis_requirement_indicator` BOOLEAN COMMENT 'Indicates whether this HCPCS code requires specific ICD-10 diagnosis codes for coverage. True if diagnosis-based medical necessity criteria apply, false otherwise.',
    `dme_indicator` BOOLEAN COMMENT 'Indicates whether this HCPCS code represents durable medical equipment as defined by Medicare. True for DME items (typically E-codes), false for other categories.',
    `drug_indicator` BOOLEAN COMMENT 'Indicates whether this HCPCS code represents a pharmaceutical drug or biological product (typically J-codes). True for drug codes, false for equipment, supplies, and services.',
    `effective_date` DATE COMMENT 'The date on which this HCPCS code became valid and available for use in billing and claims submission.',
    `frequency_limit` STRING COMMENT 'The maximum frequency at which this HCPCS code can be billed (e.g., once per year, once per lifetime, twice per month). Defines time-based coverage restrictions.',
    `gender_restriction` STRING COMMENT 'Indicates any gender-based restrictions for this HCPCS code. Some codes are specific to male or female anatomy; most have no restriction.. Valid values are `male|female|none`',
    `global_period` STRING COMMENT 'The number of days of post-operative care included in the payment for this HCPCS code (e.g., 000, 010, 090, XXX, YYY, ZZZ). Defines the global surgical package period.',
    `intraoperative_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total payment allocated to intraoperative services for this HCPCS code within the global surgical package.',
    `last_updated_date` DATE COMMENT 'The date on which this HCPCS code record was last modified in the reference data system, reflecting the most recent change to code attributes, descriptions, or coverage indicators.',
    `long_description` STRING COMMENT 'Full detailed description of the HCPCS code, providing comprehensive information about the item, service, drug, or supply represented by the code.',
    `modifier_required_indicator` BOOLEAN COMMENT 'Indicates whether a modifier is required when billing this HCPCS code. True if a modifier is mandatory for proper claims adjudication, false otherwise.',
    `multiple_procedure_indicator` STRING COMMENT 'Indicates whether and how payment adjustments apply when this HCPCS code is billed with other procedures on the same date of service. Defines reduction percentages for subsequent procedures.',
    `ndc_crosswalk_indicator` BOOLEAN COMMENT 'Indicates whether this HCPCS code has an associated NDC crosswalk mapping. True for drug codes that map to specific NDC products, false otherwise.',
    `opps_payment_indicator` STRING COMMENT 'Indicates the payment status for this HCPCS code under the Hospital Outpatient Prospective Payment System. Defines whether the code is separately payable, packaged, or excluded from OPPS payment.',
    `place_of_service_restriction` STRING COMMENT 'Indicates any restrictions on where this HCPCS code may be performed or billed (e.g., inpatient only, outpatient only, office only). Defines valid place of service codes.',
    `postoperative_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total payment allocated to postoperative services for this HCPCS code within the global surgical package.',
    `preoperative_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total payment allocated to preoperative services for this HCPCS code within the global surgical package.',
    `pricing_indicator` STRING COMMENT 'Indicates the pricing methodology for the HCPCS code: fee_schedule uses CMS published rates, asc uses Ambulatory Surgical Center payment, reasonable_charge uses historical pricing, not_priced has no established rate, contractor_priced is determined by local MAC.. Valid values are `fee_schedule|asc|reasonable_charge|not_priced|contractor_priced`',
    `prior_authorization_indicator` BOOLEAN COMMENT 'Indicates whether this HCPCS code requires prior authorization from the payer before services can be rendered. True if pre-approval is required, false otherwise.',
    `professional_component_indicator` STRING COMMENT 'Indicates whether this HCPCS code has separate professional and technical components (e.g., for radiology and pathology services). Defines billing options for split or global billing.',
    `quantity_limit` DECIMAL(18,2) COMMENT 'The maximum allowable quantity of this HCPCS code that can be billed per claim, per day, or per time period as defined by coverage policy. Null if no limit applies.',
    `short_description` STRING COMMENT 'Abbreviated description of the HCPCS code, typically 28 characters or less, used for display on claims and billing screens.',
    `superseded_by_code` STRING COMMENT 'The HCPCS code that replaces this code if it has been superseded or deleted. Null for active codes that have not been replaced.',
    `team_surgery_indicator` STRING COMMENT 'Indicates whether team surgery is allowed for this HCPCS code, where multiple surgeons of different specialties are medically necessary.',
    `technical_component_indicator` STRING COMMENT 'Indicates whether this HCPCS code includes a technical component representing facility resources, equipment, and supplies.',
    `termination_date` DATE COMMENT 'The date on which this HCPCS code was discontinued or replaced. Null for currently active codes.',
    `unit_of_measure` STRING COMMENT 'The standard unit of measure for billing this HCPCS code (e.g., each, milligram, milliliter, hour, day, unit). Defines the quantity increment for claims submission.',
    CONSTRAINT pk_hcpcs_code PRIMARY KEY(`hcpcs_code_id`)
) COMMENT 'Master catalog of HCPCS (Healthcare Common Procedure Coding System) Level II codes maintained by CMS. Covers durable medical equipment, prosthetics, orthotics, supplies, drugs, and non-physician services not captured by CPT. Includes code, description, category, coverage indicator, pricing methodology, effective and termination dates. Used in facility billing (UB-04) and Medicare/Medicaid claims.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`drg` (
    `drg_id` BIGINT COMMENT 'Unique identifier for the DRG record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: DRG grouper systems (MS-DRG, APR-DRG, AP-DRG) are versioned annually by CMS with fiscal-year-specific relative weights and payment rules. The drg table has grouper_version (STRING), fiscal_year (INT),',
    `major_diagnostic_category_id` BIGINT COMMENT 'Foreign key reference to the parent Major Diagnostic Category under which this DRG is classified.',
    `arithmetic_mean_los` DECIMAL(18,2) COMMENT 'The arithmetic mean (average) length of stay in days for cases in this DRG. Used for benchmarking and operational performance analysis.',
    `bundled_payment_flag` BOOLEAN COMMENT 'Indicates whether this DRG is included in bundled payment initiatives such as the Bundled Payments for Care Improvement (BPCI) program or Comprehensive Care for Joint Replacement (CJR) model.',
    `clinical_family` STRING COMMENT 'Grouping of related DRGs into clinical families for service line analysis (e.g., Cardiovascular, Orthopedic, Neurology). Facilitates portfolio management and strategic planning.',
    `drg_code` STRING COMMENT 'The official numeric code assigned to this DRG by the grouper system (e.g., 470, 871). Used as the business identifier for reimbursement and case mix reporting.. Valid values are `^[0-9]{3,4}$`',
    `complication_level` STRING COMMENT 'Indicates the severity level of complications or comorbidities included in this DRG definition: without CC/MCC, with CC (moderate complications), or with MCC (major complications). Drives relative weight differentiation.. Valid values are `without CC/MCC|with CC|with MCC`',
    `cost_outlier_threshold` DECIMAL(18,2) COMMENT 'The dollar threshold above which a case qualifies for additional outlier payment. Calculated as: (DRG payment × fixed loss ratio) + fixed loss amount.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRG record was first created in the reference data system. Used for data lineage and historical analysis.',
    `drg_description` STRING COMMENT 'Extended narrative description of the DRG, including clinical context, typical procedures, and coding guidance. Used for clinical documentation improvement (CDI) and coder education.',
    `effective_date` DATE COMMENT 'The date on which this DRG definition and relative weight became effective (typically October 1 of the fiscal year).',
    `expiration_date` DATE COMMENT 'The date on which this DRG definition and relative weight expire (typically September 30 of the fiscal year). Null for currently active DRGs.',
    `geometric_mean_los` DECIMAL(18,2) COMMENT 'The geometric mean length of stay in days for cases in this DRG, calculated from national claims data. Used as the threshold for identifying outlier cases and calculating outlier payments.',
    `grouper_system` STRING COMMENT 'The DRG grouper classification system under which this DRG is defined: MS-DRG (Medicare Severity), AP-DRG (All Patient), APR-DRG (All Patient Refined), or IR-DRG (International Refined).. Valid values are `MS-DRG|AP-DRG|APR-DRG|IR-DRG`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this DRG record was last modified in the reference data system. Used for change tracking and audit trails.',
    `national_average_charges` DECIMAL(18,2) COMMENT 'The national average total charges (not payments) for cases in this DRG. Used for charge benchmarking and cost-to-charge ratio analysis.',
    `national_average_payment` DECIMAL(18,2) COMMENT 'The national average Medicare payment amount for this DRG, calculated as: national base rate × relative weight. Used for benchmarking and financial forecasting.',
    `national_case_volume` STRING COMMENT 'The total number of Medicare cases nationally that grouped to this DRG in the most recent fiscal year. Used for prevalence analysis and market sizing.',
    `operating_room_procedure_flag` BOOLEAN COMMENT 'Indicates whether this DRG is classified as an OR procedure DRG, which affects payment and resource allocation.',
    `post_acute_transfer_flag` BOOLEAN COMMENT 'Indicates whether this DRG is subject to the post-acute care transfer policy, which adjusts payment when a patient is discharged to a post-acute care setting (SNF, IRF, LTCH, HHA) before the geometric mean LOS.',
    `principal_diagnosis_range_end` STRING COMMENT 'The ending ICD-10-CM diagnosis code in the range of principal diagnoses that can group to this DRG.',
    `principal_diagnosis_range_start` STRING COMMENT 'The starting ICD-10-CM diagnosis code in the range of principal diagnoses that can group to this DRG. Used for grouper logic validation and clinical documentation improvement.',
    `procedure_requirement_flag` BOOLEAN COMMENT 'Indicates whether this DRG requires the presence of a specific ICD-10-PCS procedure code to group (true for surgical DRGs, false for medical DRGs).',
    `quality_measure_flag` BOOLEAN COMMENT 'Indicates whether this DRG is associated with specific quality measures under the Hospital Value-Based Purchasing (VBP) or Hospital-Acquired Condition (HAC) Reduction Programs.',
    `readmission_penalty_flag` BOOLEAN COMMENT 'Indicates whether this DRG is included in the Hospital Readmissions Reduction Program (HRRP) and subject to payment penalties for excess readmissions.',
    `relative_weight` DECIMAL(18,2) COMMENT 'The DRG relative weight representing the average resource intensity for cases in this DRG compared to the national average (1.0000). Used to calculate expected reimbursement: base rate × relative weight.',
    `special_pay_flag` BOOLEAN COMMENT 'Indicates whether this DRG has special payment rules or adjustments (e.g., new technology add-on payments, device-intensive procedures).',
    `title` STRING COMMENT 'The full descriptive title of the DRG (e.g., Major Hip and Knee Joint Replacement or Reattachment of Lower Extremity with MCC).',
    `drg_type` STRING COMMENT 'Classification of the DRG as medical (non-surgical), surgical, or procedure-based. Used for service line segmentation and resource planning.. Valid values are `medical|surgical|procedure`',
    CONSTRAINT pk_drg PRIMARY KEY(`drg_id`)
) COMMENT 'Master table of Diagnosis-Related Groups (DRGs) and their parent Major Diagnostic Categories (MDCs) used for inpatient prospective payment under CMS MS-DRG, AP-DRG, and APR-DRG grouper systems. DRG records capture DRG code, title, type (medical/surgical/procedure), relative weight, geometric and arithmetic mean LOS, cost threshold, effective fiscal year, and grouper version. MDC records (included as a classification dimension) capture MDC number, title, description, principal diagnosis criteria, and associated DRG range. Central to inpatient reimbursement, CMI (Case Mix Index) calculation, case mix analysis, and service line performance management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` (
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the SNOMED CT concept as assigned by SNOMED International. This is the primary key and corresponds to the SCTID (SNOMED CT Identifier) in the SNOMED CT release files.',
    `code_set_version_id` BIGINT COMMENT 'The SNOMED CT release version identifier from which this concept was loaded (e.g., 20230901, 2023-09-01). Supports version tracking and change management across SNOMED CT releases.',
    `parent_concept_snomed_concept_id` BIGINT COMMENT 'Identifier of the immediate parent concept in the SNOMED CT IS-A hierarchy. Used to navigate the taxonomy and determine subsumption relationships. A concept may have multiple parents in a polyhierarchy.',
    `clinical_documentation_section` STRING COMMENT 'The typical section(s) of clinical documentation where this concept is used (e.g., Problem List, Allergies, Past Medical History, Assessment, Plan, Procedures). Supports context-aware search and documentation templates.',
    `concept_class` STRING COMMENT 'Additional classification of the concept beyond the semantic tag, used for grouping and filtering (e.g., diagnosis, symptom, surgical procedure, medication, laboratory test). May be derived from semantic tag or additional metadata.',
    `concept_definition` STRING COMMENT 'A formal textual definition of the concept providing clinical context and meaning. May be sourced from SNOMED International or supplemented with organizational definitions for clarity.',
    `concept_status` STRING COMMENT 'Current lifecycle status of the SNOMED CT concept. Active concepts are available for use in clinical documentation; inactive concepts are deprecated and should not be used for new entries but may appear in historical data.. Valid values are `active|inactive|retired|duplicate|ambiguous|erroneous`',
    `cpt_map_target` STRING COMMENT 'The CPT code(s) to which this SNOMED CT procedure concept is mapped, if applicable. Supports billing and revenue cycle management by linking clinical procedures to reimbursable CPT codes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this concept record was first created in the enterprise data platform. Used for audit trail and data lineage tracking.',
    `definition_status` STRING COMMENT 'Indicates whether the concept is primitive (defined only by its stated relationships) or fully defined (sufficient conditions provided for automated classification). Fully defined concepts can be automatically classified by description logic reasoners.. Valid values are `primitive|fully_defined`',
    `effective_time` DATE COMMENT 'The date on which this version of the concept became effective in the SNOMED CT release. Represents the snapshot date of the concept state in the release cycle (typically in YYYYMMDD format in source, stored as DATE).',
    `fhir_value_set_membership` STRING COMMENT 'Comma-separated list of FHIR value set identifiers (URIs) to which this concept belongs. Used to support FHIR-based interoperability and constrain coded elements in FHIR resources.',
    `fully_specified_name` STRING COMMENT 'The complete, unambiguous name of the SNOMED CT concept including the semantic tag in parentheses (e.g., Pneumonia (disorder)). The FSN uniquely identifies the concept and includes the semantic category to distinguish homonyms.',
    `hierarchy_level` STRING COMMENT 'The depth of this concept in the SNOMED CT hierarchy, with the root concept at level 0. Used for hierarchy traversal, rollup queries, and determining concept granularity.',
    `icd10_map_correlation` STRING COMMENT 'The correlation type between the SNOMED CT concept and the ICD-10 map target, indicating the semantic equivalence of the mapping (e.g., exact match, SNOMED concept is narrower than ICD-10 code, SNOMED concept is broader, partial overlap, or not mappable).. Valid values are `exact|narrow_to_broad|broad_to_narrow|partial|not_mappable`',
    `icd10_map_target` STRING COMMENT 'The ICD-10 code(s) to which this SNOMED CT concept is mapped, if applicable. Supports billing, reporting, and interoperability with systems that use ICD-10 for diagnosis coding. Multiple codes may be pipe-separated.',
    `is_ehr_preferred` BOOLEAN COMMENT 'Boolean flag indicating whether this concept is designated as a preferred term for use in the organizations EHR system. Preferred concepts are promoted in search results and pick lists to standardize documentation.',
    `is_leaf_concept` BOOLEAN COMMENT 'Boolean flag indicating whether this concept is a leaf node in the hierarchy (has no child concepts). Leaf concepts represent the most granular clinical terms available.',
    `is_primitive` BOOLEAN COMMENT 'Boolean flag indicating whether the concept is primitive (true) or fully defined (false). Primitive concepts require manual classification; fully defined concepts can be automatically classified by reasoners.',
    `is_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether this concept represents a condition that must be reported to public health authorities (e.g., notifiable diseases, healthcare-associated infections). Used to trigger automated reporting workflows.',
    `last_used_date` DATE COMMENT 'The most recent date on which this concept was used in clinical documentation within the organization. Used to identify obsolete or rarely used concepts for potential retirement or training needs.',
    `loinc_map_target` STRING COMMENT 'The LOINC code(s) to which this SNOMED CT concept is mapped, if applicable. Used for laboratory and clinical observations to support interoperability with laboratory information systems and FHIR resources.',
    `module_code` BIGINT COMMENT 'Identifier of the SNOMED CT module (namespace) to which this concept belongs. Modules represent different editions or extensions (e.g., International Edition, US Edition, UK Edition) and control versioning and governance.',
    `patient_friendly_term` STRING COMMENT 'A simplified, patient-friendly description of the concept for use in patient portals, after-visit summaries, and patient education materials. Avoids medical jargon and uses plain language.',
    `preferred_term` STRING COMMENT 'The preferred human-readable term for the concept in the default language (typically English). This is the term most commonly used in clinical documentation and user interfaces, without the semantic tag.',
    `quality_measure_inclusion` STRING COMMENT 'Comma-separated list of quality measure identifiers (e.g., HEDIS, CMS, MIPS) for which this concept is included in the numerator, denominator, or exclusion criteria. Supports automated quality reporting and value-based care programs.',
    `relationship_count` STRING COMMENT 'The total number of active relationships (both stated and inferred) associated with this concept. Relationships define the concepts meaning and position in the ontology.',
    `rxnorm_map_target` STRING COMMENT 'The RxNorm code(s) to which this SNOMED CT pharmaceutical/biologic product concept is mapped, if applicable. Enables medication interoperability and e-prescribing by linking to the NLM RxNorm drug terminology.',
    `semantic_tag` STRING COMMENT 'The high-level semantic category of the concept extracted from the FSN (e.g., disorder, procedure, finding, body structure, substance, organism). Used to classify concepts into broad clinical domains.',
    `specialty_relevance` STRING COMMENT 'Comma-separated list of medical specialties for which this concept is particularly relevant (e.g., Cardiology, Oncology, Pediatrics, Emergency Medicine). Used to customize pick lists and search results by provider specialty.',
    `synonym_count` STRING COMMENT 'The number of active synonym descriptions associated with this concept. Synonyms provide alternative terms for the same concept to support varied clinical documentation styles and search.',
    `top_level_hierarchy` STRING COMMENT 'The top-level SNOMED CT hierarchy to which this concept belongs (e.g., Clinical Finding, Procedure, Body Structure, Pharmaceutical / Biologic Product, Organism, Substance, Physical Object, Qualifier Value, Observable Entity, Situation, Event, Environment, Social Context, Staging and Scales, Linkage Concept, Special Concept, Navigational Concept, Record Artifact). Derived from the root ancestor in the IS-A hierarchy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this concept record was last updated in the enterprise data platform. Used for change tracking and incremental data processing.',
    `usage_frequency_rank` STRING COMMENT 'Rank of this concept based on usage frequency in clinical documentation within the organization. Lower numbers indicate higher usage. Used to prioritize search results and optimize user interfaces.',
    CONSTRAINT pk_snomed_concept PRIMARY KEY(`snomed_concept_id`)
) COMMENT 'Master catalog of SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) clinical concepts as distributed by SNOMED International and the NLM. Each record captures concept ID, fully specified name, preferred term, semantic tag, concept status (active/inactive), module, effective time, and hierarchy path. Provides the clinical terminology backbone for problem lists, allergies, clinical findings, and FHIR-based interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` (
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the LOINC code record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: LOINC codes are maintained by Regenstrief Institute with biannual releases. The loinc_code table has version_first_released (STRING), version_last_changed (STRING), and status attributes that should b',
    `class` STRING COMMENT 'The high-level category or domain of the observation (e.g., CHEM=Chemistry, HEM/BC=Hematology/Blood Count, MICRO=Microbiology, RAD=Radiology, VITALS=Vital Signs).',
    `component` STRING COMMENT 'The substance or entity being measured or observed (e.g., Glucose, Hemoglobin, Creatinine). This is the analyte, the target of the measurement.',
    `consumer_name` STRING COMMENT 'A patient-friendly, lay-language name for the observation or test, used in patient portals and consumer-facing applications.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this LOINC code record was first created in the system. Audit trail field.',
    `deprecated_date` DATE COMMENT 'The date when this LOINC code was deprecated or retired. Null if the code is still active.',
    `display_name` STRING COMMENT 'The preferred display name for this LOINC code in the current implementation. May be customized by the organization while maintaining the standard LOINC number.',
    `effective_date` DATE COMMENT 'The date when this LOINC code became active and available for use in clinical systems.',
    `example_ucum_units` STRING COMMENT 'The standardized UCUM representation of the example units. Used for interoperability and unit conversion.',
    `example_units` STRING COMMENT 'Common units of measure for this observation (e.g., mg/dL, mmol/L, %). Provides guidance for result reporting.',
    `external_copyright_notice` STRING COMMENT 'Copyright or licensing information for LOINC codes that incorporate third-party content (e.g., SNOMED CT, CPT). Required for compliance with external terminology licenses.',
    `hl7_field_subfield_code` STRING COMMENT 'The HL7 v2.x message field identifier where this LOINC code is typically used (e.g., OBX-3 for observation identifier). Supports HL7 message mapping.',
    `hl7_v3_code_system_oid` STRING COMMENT 'The HL7 v3 object identifier for the LOINC code system (typically 2.16.840.1.113883.6.1). Used in CDA documents and HL7 v3 messages.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this LOINC code is currently active and available for use in the organization. True=active, False=inactive or deprecated locally.',
    `last_verified_date` DATE COMMENT 'The date when this LOINC code mapping was last reviewed and verified by clinical informatics or laboratory staff. Supports ongoing terminology governance.',
    `local_code` STRING COMMENT 'Organization-specific internal code or identifier mapped to this LOINC code. Used for legacy system integration and local terminology management.',
    `loinc_number` STRING COMMENT 'The unique LOINC code identifier assigned by Regenstrief Institute. Format: numeric-numeric (e.g., 2345-7). This is the authoritative external identifier for the observation or test.. Valid values are `^[0-9]+-[0-9]+$`',
    `long_common_name` STRING COMMENT 'The full, human-readable display name for the LOINC code. This is the primary display term used in clinical systems and reports.',
    `method_type` STRING COMMENT 'The method or technique used to make the observation or measurement (e.g., Electrophoresis, Immunoassay, Microscopy). May be null if method is not specified.',
    `order_observation_flag` BOOLEAN COMMENT 'Indicates whether this LOINC code is used for ordering tests, recording observations, or both. Order=orderable panel or test, Observation=result only, Both=can be used for ordering and results.',
    `panel_type` STRING COMMENT 'Indicates if this LOINC code represents a panel (group of related tests), battery (predefined test group), or set (collection of observations). Null for individual observations.. Valid values are `Panel|Battery|Set`',
    `property` STRING COMMENT 'The characteristic or attribute of the analyte being measured (e.g., Mass Concentration, Substance Concentration, Presence, Volume).',
    `related_names` STRING COMMENT 'Synonyms, alternate names, or legacy names for this observation. Supports search and mapping from legacy systems.',
    `scale_type` STRING COMMENT 'The scale of measurement for the observation result. Qn=Quantitative (numeric), Ord=Ordinal (ranked), Nom=Nominal (named categories), Nar=Narrative (free text), Doc=Document (attached file).. Valid values are `Qn|Ord|Nom|Nar|Doc`',
    `short_name` STRING COMMENT 'An abbreviated display name for the LOINC code, used when space is limited in user interfaces or reports.',
    `survey_question_source` STRING COMMENT 'The source instrument or questionnaire from which the survey question originates (e.g., PHQ-9, PROMIS, CAHPS).',
    `survey_question_text` STRING COMMENT 'For LOINC codes representing survey or assessment questions, this field contains the full question text as presented to the patient or clinician.',
    `system` STRING COMMENT 'The specimen or body system from which the observation was made (e.g., Blood, Serum, Urine, Plasma, Cerebrospinal fluid).',
    `time_aspect` STRING COMMENT 'The time dimension of the measurement (e.g., Point in time, 24 hour, 8 hour). Indicates whether the observation is a single point measurement or collected over a time interval.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this LOINC code record was last modified. Audit trail field.',
    CONSTRAINT pk_loinc_code PRIMARY KEY(`loinc_code_id`)
) COMMENT 'Authoritative catalog of LOINC (Logical Observation Identifiers Names and Codes) codes maintained by the Regenstrief Institute. Captures LOINC number, component, property, time aspect, system, scale type, method type, long common name, short name, class, order/observation flag, status, and effective dates. Used to standardize lab results, vital signs, clinical observations, and radiology reports across LIS, RIS, and EHR systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` (
    `ndc_drug_id` BIGINT COMMENT 'Unique identifier for the NDC drug product record in the enterprise data warehouse.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: NDC drug products are maintained by the FDA with weekly updates to the NDC Directory. The ndc_drug table has ndc_status attribute and marketing_start_date/marketing_end_date that track product lifecyc',
    `active_ingredient` STRING COMMENT 'The chemical substance or compound responsible for the therapeutic effect of the drug.',
    `application_number` STRING COMMENT 'The FDA application number associated with the drug approval (e.g., NDA number, ANDA number, BLA number).',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical classification code, used internationally for drug classification.',
    `biosimilar_flag` BOOLEAN COMMENT 'Indicates whether the drug is a biosimilar product, highly similar to an already-approved biological product.',
    `black_box_warning_flag` BOOLEAN COMMENT 'Indicates whether the drug carries an FDA black box warning, the strictest warning for serious or life-threatening risks.',
    `dea_schedule` STRING COMMENT 'The controlled substance schedule classification assigned by the DEA (CI through CV), indicating the drugs potential for abuse and accepted medical use. Empty if not a controlled substance.. Valid values are `CI|CII|CIII|CIV|CV|`',
    `dosage_form` STRING COMMENT 'The physical form in which the drug is administered (e.g., tablet, capsule, injection, solution, cream, inhaler).',
    `effective_date` DATE COMMENT 'The date on which this NDC drug record became effective in the enterprise reference data system.',
    `expiration_date` DATE COMMENT 'The date on which this NDC drug record is no longer valid or was superseded. Null if currently active.',
    `fhir_medication_code` STRING COMMENT 'The standardized medication code used in FHIR MedicationRequest and Medication resources for interoperability.',
    `formulary_status` STRING COMMENT 'Indicates whether the drug is included in the organizations formulary and any restrictions or preferences applied.. Valid values are `formulary|non_formulary|restricted|preferred`',
    `gpi_code` STRING COMMENT 'The Medi-Span Generic Product Identifier, a 14-character hierarchical classification code used in pharmacy systems.',
    `high_alert_medication_flag` BOOLEAN COMMENT 'Indicates whether the drug is classified as a high-alert medication by ISMP, requiring special handling and verification procedures.',
    `labeler_name` STRING COMMENT 'The name of the company or entity that manufactures, repackages, or distributes the drug product.',
    `marketing_category` STRING COMMENT 'The regulatory pathway under which the drug was approved (e.g., NDA, ANDA, BLA, OTC Monograph).',
    `marketing_end_date` DATE COMMENT 'The date on which the drug product was discontinued or withdrawn from the market. Null if still active.',
    `marketing_start_date` DATE COMMENT 'The date on which the drug product was first marketed or made available for distribution.',
    `ndc_code` STRING COMMENT 'The 11-digit National Drug Code assigned by the FDA, uniquely identifying the labeler, product, and package size. Format: 5-4-2 (labeler-product-package).. Valid values are `^d{11}$`',
    `nonproprietary_name` STRING COMMENT 'The generic or non-proprietary name of the drug, typically the active ingredient name established by the United States Adopted Names (USAN) Council.',
    `orange_book_code` STRING COMMENT 'The therapeutic equivalence code from the FDA Orange Book, indicating whether a generic drug is therapeutically equivalent to the brand-name drug.',
    `over_the_counter_flag` BOOLEAN COMMENT 'Indicates whether the drug is available for purchase without a prescription.',
    `package_description` STRING COMMENT 'A textual description of the package size and configuration (e.g., bottle of 100 tablets, box of 10 vials).',
    `package_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of units contained in the package.',
    `package_unit` STRING COMMENT 'The unit of measure for the package quantity (e.g., tablet, capsule, mL, vial).',
    `pregnancy_category` STRING COMMENT 'The FDA pregnancy category classification indicating the risk of fetal harm (A=safest, X=contraindicated, N=not classified). Note: FDA replaced this with narrative labeling in 2015.. Valid values are `A|B|C|D|X|N`',
    `product_name` STRING COMMENT 'The full product name as registered with the FDA, including strength and dosage form.',
    `proprietary_name` STRING COMMENT 'The brand or trade name under which the drug is marketed to consumers and healthcare providers.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NDC drug record was first created in the enterprise data warehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this NDC drug record was last updated in the enterprise data warehouse.',
    `refrigeration_required_flag` BOOLEAN COMMENT 'Indicates whether the drug requires refrigerated storage to maintain stability and efficacy.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered into the body (e.g., oral, intravenous, topical, subcutaneous, intramuscular).',
    `rxcui` STRING COMMENT 'The RxNorm Concept Unique Identifier assigned by the National Library of Medicine, providing a normalized drug concept mapping for interoperability.',
    `rxnorm_name` STRING COMMENT 'The normalized drug name as defined in RxNorm, representing the clinical drug concept.',
    `rxnorm_source_vocabulary` STRING COMMENT 'The source vocabulary from which the RxNorm concept was derived (e.g., RXNORM, VANDF, MMSL, NDDF).',
    `rxnorm_suppress_flag` BOOLEAN COMMENT 'Indicates whether the RxNorm concept is suppressed from use (N=not suppressed, Y=suppressed, O=obsolete, E=entry term).',
    `rxnorm_term_type` STRING COMMENT 'The RxNorm term type classification (e.g., IN for ingredient, BN for brand name, SCD for semantic clinical drug, GPCK for generic pack).',
    `snomed_ct_code` STRING COMMENT 'The SNOMED CT concept code representing the drug product or substance for clinical documentation and interoperability.',
    `strength` STRING COMMENT 'The concentration or potency of the active ingredient(s) in the drug product, expressed as a numeric value with unit (e.g., 500 mg, 10 mg/mL).',
    `strength_unit` STRING COMMENT 'The unit of measure for the drug strength (e.g., mg, mL, mcg, IU, %).',
    `therapeutic_class` STRING COMMENT 'The therapeutic or pharmacological classification of the drug (e.g., antibiotic, antihypertensive, analgesic).',
    `unii_code` STRING COMMENT 'The FDA Unique Ingredient Identifier code for the active ingredient, used for substance identification.',
    `vaccine_flag` BOOLEAN COMMENT 'Indicates whether the drug product is a vaccine used for immunization.',
    CONSTRAINT pk_ndc_drug PRIMARY KEY(`ndc_drug_id`)
) COMMENT 'Master catalog of NDC (National Drug Code) drug products as maintained by the FDA, enriched with RxNorm normalized drug concept mappings (RxCUI, term type, ingredient/brand/clinical drug hierarchy) published by the NLM. NDC records capture the 11-digit NDC, labeler name, product name, proprietary and non-proprietary names, dosage form, route of administration, strength, unit, DEA schedule, marketing category, application number, package description, and active/inactive status. RxNorm normalization records capture RxCUI, name, term type (TTY: ingredient, brand name, clinical drug, etc.), source vocabulary, suppress flag, and effective dates, providing the canonical drug terminology layer that maps NDC codes, proprietary names, and generic names to a single clinical drug concept. Consumed by pharmacy, formulary management, MAR, medication reconciliation, FHIR MedicationRequest interoperability, and billing domains.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` (
    `fhir_value_set_id` BIGINT COMMENT 'Unique identifier for the FHIR value set record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: FHIR value sets are versioned by HL7 with release-specific canonical URLs and expansion timestamps. The fhir_value_set table has version (STRING) and status attributes that should be normalized to cod',
    `exchange_standard_id` BIGINT COMMENT 'add column interoperability_exchange_standard_id (BIGINT) with FK to interoperability.exchange_standard.exchange_standard_id - FHIR value sets are part of exchange standards but lack this link',
    `approval_date` DATE COMMENT 'Date when this value set was formally approved by the governance authority for production use. Required for regulatory compliance and change control.',
    `binding_strength` STRING COMMENT 'Defines how strictly FHIR resources must conform to this value set. Required = must use codes from this set only, Extensible = should use but may extend, Preferred = recommended but not enforced, Example = illustrative only.. Valid values are `required|extensible|preferred|example`',
    `canonical_url` STRING COMMENT 'Globally unique canonical URL that permanently identifies this value set across all FHIR implementations. Used for terminology server lookups and resource references.. Valid values are `^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$`',
    `compose_exclude_count` STRING COMMENT 'Number of exclude rules defined in the value set composition. Exclude rules remove specific concepts from the included set.',
    `compose_include_count` STRING COMMENT 'Number of include rules defined in the value set composition. Each include rule specifies a code system and filter criteria for selecting concepts.',
    `contact_json` STRING COMMENT 'JSON-encoded contact details for the publisher or steward of this value set, including name, email, phone, and URL. Used for support and governance inquiries.',
    `copyright` STRING COMMENT 'Legal copyright and licensing terms governing the use of this value set. Critical for code systems like SNOMED CT, CPT, and ICD-10 that require licensing agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this value set record was first created in the enterprise terminology repository. Audit trail for data lineage.',
    `fhir_value_set_description` STRING COMMENT 'Detailed narrative description of the value set purpose, scope, and intended use cases. Provides clinical and business context for terminology consumers.',
    `effective_end_date` DATE COMMENT 'Date when this value set version is retired and should no longer be used for new data entry. Null indicates the value set is currently active with no planned retirement.',
    `effective_start_date` DATE COMMENT 'Date when this value set version becomes active and available for use in clinical systems. Part of the temporal validity window.',
    `expansion_identifier` STRING COMMENT 'Unique identifier for the current expansion of this value set. Changes each time the value set is expanded by a terminology server to reflect the current set of member concepts.',
    `expansion_offset` STRING COMMENT 'Paging offset used when the expansion was generated. Supports large value sets that cannot be returned in a single response.',
    `expansion_parameter_json` STRING COMMENT 'JSON-encoded parameters used during the expansion operation, such as language, display variant, or active-only filters. Stored as text for auditability.',
    `expansion_timestamp` TIMESTAMP COMMENT 'Date and time when the value set was last expanded by a terminology server to produce the current list of member concepts. Critical for cache invalidation and version control.',
    `expansion_total_concepts` STRING COMMENT 'Total number of coded concepts included in the current expansion of this value set. Used for validation and performance optimization.',
    `experimental_flag` BOOLEAN COMMENT 'Indicates whether this value set is for testing or experimental purposes and should not be used in production clinical systems. True means not approved for operational use.',
    `fhir_element_path` STRING COMMENT 'Specific element path within the FHIR resource where this value set binding applies, using dot notation. Example: Observation.code, Condition.clinicalStatus, Procedure.category.',
    `fhir_resource_type` STRING COMMENT 'The FHIR resource type that this value set is bound to, such as Observation, Condition, Procedure, MedicationRequest, or AllergyIntolerance. Indicates where this terminology is applied in clinical workflows.',
    `immutable_flag` BOOLEAN COMMENT 'Indicates whether the value set definition is immutable and will never change once published. True means the expansion will always produce the same set of codes.',
    `jurisdiction_codes` STRING COMMENT 'Comma-separated list of ISO 3166 country codes or jurisdiction identifiers where this value set is intended for use. Examples: USA, CAN, GBR. Supports regional terminology requirements.',
    `last_review_date` DATE COMMENT 'Date when this value set was last reviewed for clinical accuracy and relevance. Used to trigger periodic re-validation cycles per governance policy.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this value set record was last updated in the enterprise terminology repository. Supports change tracking and cache invalidation.',
    `publisher` STRING COMMENT 'Name of the organization or individual responsible for publishing and maintaining this value set. Examples include HL7, SNOMED International, LOINC, or internal enterprise teams.',
    `purpose` STRING COMMENT 'Explanation of why this value set was created and the specific clinical or administrative problem it addresses. Helps users understand appropriate usage scenarios.',
    `title` STRING COMMENT 'Human-readable title for the value set displayed in user interfaces and documentation. May contain spaces and special characters.',
    `use_context_json` STRING COMMENT 'JSON-encoded array of usage contexts defining when and where this value set should be applied. Includes clinical specialty, care setting, patient demographics, and workflow phase.',
    `value_set_name` STRING COMMENT 'Computer-friendly name for the value set, typically used in code generation and system identifiers. Must be alphanumeric without spaces.',
    `value_set_oid` STRING COMMENT 'ISO object identifier uniquely identifying this value set in the global OID registry. Format follows ISO/IEC 8824 dotted decimal notation.. Valid values are `^[0-2](.(0|[1-9][0-9]*))+$`',
    CONSTRAINT pk_fhir_value_set PRIMARY KEY(`fhir_value_set_id`)
) COMMENT 'Master catalog of HL7 FHIR value sets, terminology bindings, and their expanded member concepts used across the enterprise for interoperability. Value set header records capture OID, canonical URL, name, title, status, version, publisher, binding strength (required/extensible/preferred/example), FHIR resource type, and effective dates. Member detail records capture the individual coded concepts belonging to each value set: concept system (SNOMED CT, LOINC, ICD-10, CPT, etc.), concept code, display name, designation, include/exclude flag, and effective dates. Supports runtime validation of coded fields in FHIR resources, terminology server $expand operations, and clinical decision support rule evaluation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` (
    `npi_registry_id` BIGINT COMMENT 'Primary key for npi_registry',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: NPI registry contains practice location addresses with postal codes that should be normalized to geographic_region for ZIP-based analytics (RUCA codes, HSA/HRR assignments, CMS region mapping). The np',
    `authorized_official_first_name` STRING COMMENT 'The first name of the authorized official for the organizational provider (Type 2 NPIs only). Used for credentialing verification and organizational accountability.',
    `authorized_official_last_name` STRING COMMENT 'The last name of the authorized official who is legally responsible for the organizational provider (Type 2 NPIs only). This individual has authority to bind the organization and attest to the accuracy of NPI application information.',
    `authorized_official_middle_name` STRING COMMENT 'The middle name of the authorized official for the organizational provider (Type 2 NPIs only). Optional field for complete identification.',
    `authorized_official_telephone_number` STRING COMMENT 'The telephone number of the authorized official for the organizational provider. Used for credentialing verification, attestation confirmation, and regulatory inquiries.',
    `authorized_official_title` STRING COMMENT 'The job title or position of the authorized official within the organization (e.g., CEO, CFO, Administrator, President, Medical Director). Used to verify organizational authority and credentialing compliance.',
    `deactivation_date` DATE COMMENT 'The date the NPI was deactivated by the provider or CMS. Indicates the provider is no longer actively using this identifier. Used for claims validation, credentialing status checks, and provider directory management.',
    `employer_identification_number` STRING COMMENT 'The IRS Employer Identification Number (EIN) for organizational providers (Type 2 only). Used for tax reporting and organizational identification. Also known as Federal Tax ID.. Valid values are `^[0-9]{9}$`',
    `entity_type_code` STRING COMMENT 'Indicates whether the NPI is assigned to an individual provider (Type 1) or an organization (Type 2). Type 1 = Individual healthcare provider (physician, nurse, therapist). Type 2 = Healthcare organization (hospital, clinic, group practice, pharmacy).. Valid values are `1|2`',
    `enumeration_date` DATE COMMENT 'The date the NPI was originally assigned to the provider by NPPES. Represents the providers initial enrollment in the national provider registry. Critical for credentialing timelines and provider history tracking.',
    `last_update_date` DATE COMMENT 'The date the NPI record was last updated in NPPES. Reflects the most recent change to provider demographic information, address, taxonomy, or other registry data. Used to track data freshness and trigger downstream updates.',
    `mailing_address_city` STRING COMMENT 'The city name for the providers mailing address. Used for geographic segmentation and correspondence routing.',
    `mailing_address_country_code` STRING COMMENT 'The three-letter ISO country code for the providers mailing address (e.g., USA, CAN, MEX). Used for international provider tracking and cross-border claims.. Valid values are `^[A-Z]{3}$`',
    `mailing_address_fax_number` STRING COMMENT 'The fax number associated with the providers mailing address. Used for document transmission during credentialing, prior authorization, and claims correspondence.',
    `mailing_address_line_1` STRING COMMENT 'The first line of the providers mailing address (street address, PO Box, or suite number). Used for official correspondence, credentialing documents, and regulatory communications.',
    `mailing_address_line_2` STRING COMMENT 'The second line of the providers mailing address (apartment, suite, building, floor). Optional field for additional address detail.',
    `mailing_address_postal_code` STRING COMMENT 'The ZIP code or ZIP+4 code for the providers mailing address. Used for mail delivery, geographic analysis, and service area determination.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `mailing_address_state` STRING COMMENT 'The two-letter state or territory code for the providers mailing address (e.g., CA, NY, TX). Used for state-level reporting and regulatory compliance.',
    `mailing_address_telephone_number` STRING COMMENT 'The telephone number associated with the providers mailing address. Used for provider contact and verification during credentialing and claims inquiries.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS NPPES. Unique identifier for healthcare providers in the United States. This is the authoritative business identifier for provider lookup across claims, credentialing, and directory systems.. Valid values are `^[0-9]{10}$`',
    `organization_name` STRING COMMENT 'The legal business name of the healthcare organization for Type 2 (organizational) NPIs. Examples: hospital name, clinic name, group practice name, pharmacy name.',
    `organization_other_name` STRING COMMENT 'Alternate name, trade name, or doing-business-as (DBA) name for the healthcare organization. Used when the organization operates under a name different from its legal name.',
    `practice_location_address_country_code` STRING COMMENT 'The three-letter ISO country code for the providers practice location (e.g., USA, CAN, MEX). Used for international provider tracking and cross-border service delivery.. Valid values are `^[A-Z]{3}$`',
    `practice_location_address_line_1` STRING COMMENT 'The first line of the providers primary practice location address (street address, suite number). This is the physical location where the provider sees patients or delivers services. Used for provider directories, patient navigation, and service area mapping.',
    `practice_location_address_line_2` STRING COMMENT 'The second line of the providers practice location address (apartment, suite, building, floor). Optional field for additional address detail.',
    `practice_location_fax_number` STRING COMMENT 'The fax number for the providers practice location. Used for medical records transmission, referral coordination, and prior authorization requests.',
    `practice_location_telephone_number` STRING COMMENT 'The telephone number for the providers practice location. Used for patient appointment scheduling, provider directory listings, and referral coordination.',
    `primary_taxonomy_code` STRING COMMENT 'The primary NUCC Health Care Provider Taxonomy code assigned to this NPI. A 10-digit alphanumeric code that classifies the providers type, classification, and specialization (e.g., 207Q00000X = Family Medicine, 208D00000X = General Practice). This is the providers main specialty for claims submission and network assignment.. Valid values are `^[0-9]{10}[A-Z]$`',
    `primary_taxonomy_switch` STRING COMMENT 'Indicates whether the taxonomy code is designated as the providers primary taxonomy. Y = Yes (primary), N = No (secondary). Used to distinguish the main specialty from additional specialties for claims routing and network credentialing.. Valid values are `Y|N`',
    `provider_credential` STRING COMMENT 'The professional credential or designation of the individual provider (e.g., MD, DO, RN, DDS, PharmD, PhD, LCSW). Indicates the providers professional qualifications and licensure type.',
    `provider_first_name` STRING COMMENT 'The legal first name (given name) of the individual healthcare provider for Type 1 NPIs. Used for provider identification, credentialing, and claims submission.',
    `provider_gender_code` STRING COMMENT 'The gender of the individual provider for Type 1 NPIs. M = Male, F = Female. Used for provider demographic reporting and patient preference matching.. Valid values are `M|F`',
    `provider_last_name` STRING COMMENT 'The legal last name (family name or surname) of the individual healthcare provider for Type 1 NPIs. Used for provider identification, credentialing, and claims submission.',
    `provider_middle_name` STRING COMMENT 'The middle name of the individual healthcare provider for Type 1 NPIs. Optional field used for complete provider identification.',
    `provider_name_prefix` STRING COMMENT 'The name prefix or title for the individual provider (e.g., Dr., Mr., Ms., Rev.). Used for formal provider identification and correspondence.',
    `provider_name_suffix` STRING COMMENT 'The name suffix for the individual provider (e.g., Jr., Sr., II, III). Used for complete provider identification and to distinguish between providers with similar names.',
    `provider_other_credential` STRING COMMENT 'An alternate or additional professional credential for the individual provider. Used when a provider holds multiple credentials or has changed credentials.',
    `provider_other_first_name` STRING COMMENT 'An alternate or previous first name for the individual provider. Used to track provider name changes and maintain historical continuity.',
    `provider_other_last_name` STRING COMMENT 'An alternate or previous last name for the individual provider (e.g., maiden name, former married name). Used to track provider name changes and maintain historical continuity.',
    `provider_other_middle_name` STRING COMMENT 'An alternate or previous middle name for the individual provider. Used to track provider name changes and maintain historical continuity.',
    `provider_other_name_prefix` STRING COMMENT 'An alternate name prefix for the individual provider. Used to track provider name changes.',
    `provider_other_name_suffix` STRING COMMENT 'An alternate name suffix for the individual provider. Used to track provider name changes.',
    `reactivation_date` DATE COMMENT 'The date a previously deactivated NPI was reactivated. Indicates the provider has resumed use of this identifier. Used to track provider status changes and maintain accurate active provider lists.',
    `replacement_npi` STRING COMMENT 'The NPI that has replaced this NPI if the provider has been assigned a new identifier. Used to track provider identifier changes and maintain continuity in claims and credentialing systems.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_npi_registry PRIMARY KEY(`npi_registry_id`)
) COMMENT 'Enterprise copy of the CMS National Plan and Provider Enumeration System (NPPES) NPI registry, enriched with NUCC Health Care Provider Taxonomy code classifications. NPI records capture NPI number, entity type (individual Type 1/organization Type 2), provider name, credential, gender, enumeration date, last update date, deactivation date, reactivation date, mailing and practice addresses, phone, fax, and authorized official information. Taxonomy classification records capture taxonomy code, provider type, classification, specialization, definition, and effective dates for each NPIs primary and secondary taxonomy assignments. Serves as the authoritative NPI and provider taxonomy lookup for claims submission, credentialing, payer enrollment, and provider directory across all domains. Note: this is the enterprise reference copy; provider domain owns the operational provider record.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` (
    `geographic_region_id` BIGINT COMMENT 'Unique identifier for the geographic region entity. Primary key.',
    `parent_region_geographic_region_id` BIGINT COMMENT 'Reference to the parent geographic region in the hierarchy (e.g., a ZIP codes parent county, a countys parent state). Null for top-level regions (e.g., country).',
    `aco_service_area_flag` BOOLEAN COMMENT 'Indicates whether this region is part of an ACO service area. True if the region is included in one or more ACO service territories; false otherwise. Used for value-based care program eligibility and population attribution.',
    `cbsa_code` STRING COMMENT 'The U.S. Census Bureau Core-Based Statistical Area code. Used for metropolitan and micropolitan statistical area analysis, market segmentation, and payer contracting territories.',
    `cbsa_name` STRING COMMENT 'The human-readable name of the CBSA (e.g., New York-Newark-Jersey City, NY-NJ-PA). Null for non-CBSA region types.',
    `census_division` STRING COMMENT 'The U.S. Census Bureau division classification, a finer granularity than census_region. Values: new_england, middle_atlantic, east_north_central, west_north_central, south_atlantic, east_south_central, west_south_central, mountain, pacific. [ENUM-REF-CANDIDATE: new_england|middle_atlantic|east_north_central|west_north_central|south_atlantic|east_south_central|west_south_central|mountain|pacific — 9 candidates stripped; promote to reference product]',
    `census_region` STRING COMMENT 'The U.S. Census Bureau region classification: northeast, midwest, south, west. Used for demographic and statistical analysis.. Valid values are `northeast|midwest|south|west`',
    `cms_region_number` STRING COMMENT 'The CMS administrative region number (1-10). Used for regulatory reporting, Quality Payment Program (QPP) reporting, and CMS regional office alignment.',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code (e.g., USA, CAN, MEX). Used for international patient populations and cross-border care coordination.',
    `effective_end_date` DATE COMMENT 'The date through which this geographic region record is effective. Null for currently active regions. Used for temporal validity and historical analysis of region definitions.',
    `effective_start_date` DATE COMMENT 'The date from which this geographic region record is effective. Used for temporal validity and historical analysis of region definitions (e.g., ZIP code boundary changes, CBSA redefinitions).',
    `fips_code` STRING COMMENT 'The Federal Information Processing Standards code for this region. Used for counties (5-digit) and states (2-digit). Null for non-FIPS region types.',
    `hrr_code` STRING COMMENT 'The CMS Hospital Referral Region code representing a regional health care market for tertiary medical care. Used for population health management, quality benchmarking, and regional variation analysis.',
    `hsa_code` STRING COMMENT 'The CMS Hospital Service Area code representing a collection of ZIP codes whose residents receive most of their hospitalizations from the hospitals in that area. Used for facility service area definitions and market share analysis.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this geographic region record is currently active and valid for use. True if active; false if retired or superseded. Used for address validation and operational reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this geographic region record was last updated in the data platform. Used for data lineage, change tracking, and audit purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate (decimal degrees) representing the centroid or representative point of the region. Used for mapping, distance calculations, and geospatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate (decimal degrees) representing the centroid or representative point of the region. Used for mapping, distance calculations, and geospatial analysis.',
    `median_household_income` DECIMAL(18,2) COMMENT 'The median household income (in USD) for this region, sourced from U.S. Census or American Community Survey data. Used for Social Determinants of Health (SDOH) analysis, financial assistance program eligibility, and health equity reporting.',
    `population_estimate` BIGINT COMMENT 'The estimated total population residing in this geographic region, sourced from the most recent U.S. Census or American Community Survey data. Used for population health stratification, capacity planning, and per-capita rate calculations.',
    `poverty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of the population living below the federal poverty line in this region. Used for SDOH analysis, charity care program targeting, and community health needs assessments.',
    `region_code` STRING COMMENT 'The standardized code representing this geographic region (e.g., ZIP code, FIPS code, CBSA code, HSA code, HRR code, state abbreviation). Format and length vary by region_type.',
    `region_name` STRING COMMENT 'The human-readable name of the geographic region (e.g., city name for ZIP, county name, CBSA name, state name).',
    `region_type` STRING COMMENT 'Discriminator indicating the type of geographic region: zip_code (5-digit ZIP), county, state, cbsa (Core-Based Statistical Area), hsa (Hospital Service Area), hrr (Hospital Referral Region), cms_region (CMS administrative region), aco_service_area (Accountable Care Organization service area), zcta (ZIP Code Tabulation Area), country. [ENUM-REF-CANDIDATE: zip_code|county|state|cbsa|hsa|hrr|cms_region|aco_service_area|zcta|country — 10 candidates stripped; promote to reference product]',
    `ruca_code` STRING COMMENT 'The Rural-Urban Commuting Area code classifying the region by urbanization and commuting patterns. Used for population health stratification and Social Determinants of Health (SDOH) analysis.',
    `state_abbreviation` STRING COMMENT 'The two-letter U.S. state abbreviation (e.g., CA, NY, TX). Populated for U.S. regions; null for non-U.S. or non-state region types.',
    `time_zone` STRING COMMENT 'The IANA time zone identifier for this region (e.g., America/New_York, America/Chicago). Used for scheduling, appointment management, and operational reporting across multiple facilities.',
    `uninsured_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of the population without health insurance coverage in this region. Used for access-to-care analysis, payer mix forecasting, and community benefit program planning.',
    `urban_rural_classification` STRING COMMENT 'High-level classification of the region as urban, suburban, rural, or frontier. Derived from RUCA codes or other urbanization metrics. Used for access-to-care analysis and health equity reporting.. Valid values are `urban|suburban|rural|frontier`',
    CONSTRAINT pk_geographic_region PRIMARY KEY(`geographic_region_id`)
) COMMENT 'Master catalog of all geographic reference entities used across the enterprise, including ZIP codes (with city, county, FIPS, latitude/longitude, RUCA urban/rural classification), states, counties, CBSA (Core-Based Statistical Area), HSA (Hospital Service Area), HRR (Hospital Referral Region), CMS regions, ACO service areas, and ZCTA (ZIP Code Tabulation Area). Each record captures region code, name, type discriminator, parent region, FIPS code, census region, latitude/longitude (for point-level types), urban/rural classification, time zone, demographic enrichment fields, and effective dates. Used for patient address validation, population health stratification, payer contracting territories, facility service area definitions, SDOH analysis, geographic rating, and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`condition_code` (
    `condition_code_id` BIGINT COMMENT 'Unique identifier for the condition code record. Primary key.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: UB-04 condition codes and occurrence codes are maintained by NUBC with periodic updates. The condition_code table has status attribute and effective_date/termination_date that track code lifecycle. Ad',
    `ama_indicator` BOOLEAN COMMENT 'For discharge disposition codes, indicates whether the disposition represents a discharge against medical advice.',
    `bilateral_indicator` BOOLEAN COMMENT 'For CPT/HCPCS modifier codes, indicates whether the modifier designates a bilateral procedure (e.g., modifier 50).',
    `condition_code_category` STRING COMMENT 'Logical grouping or category for the code within its code_type. Examples: Patient Status for certain condition codes, Facility Services for revenue codes, Anatomical Modifiers for CPT modifiers.',
    `claim_form_type` STRING COMMENT 'Identifies which claim form(s) this code is applicable to: UB-04 for facility claims, CMS-1500 for professional claims, or BOTH for codes used across both forms.. Valid values are `UB-04|CMS-1500|BOTH`',
    `condition_code_code` STRING COMMENT 'The standardized alphanumeric code value as defined by NUBC, CMS, or AMA. Examples: 01 for condition code, A1 for occurrence code, 01 for revenue code, LT for modifier code.. Valid values are `^[A-Z0-9]{1,5}$`',
    `code_type` STRING COMMENT 'Discriminator identifying the specific code set category. Consumers filter by this field to retrieve the appropriate code set for their use case. [ENUM-REF-CANDIDATE: condition_code|occurrence_code|occurrence_span_code|value_code|admit_source|discharge_disposition|pos_code|revenue_code|modifier_code — 9 candidates stripped; promote to reference product]',
    `commercial_payer_flag` BOOLEAN COMMENT 'Indicates whether this code is commonly accepted by commercial insurance payers for claims adjudication.',
    `condition_code_description` STRING COMMENT 'Full business description of the code explaining its meaning and usage context. Example: Patient is homeless for condition code 60.',
    `effective_date` DATE COMMENT 'The date on which this code became valid and available for use on claims. Format: yyyy-MM-dd.',
    `expired_indicator` BOOLEAN COMMENT 'For discharge disposition codes, indicates whether the disposition represents patient death (expired).',
    `facility_indicator` BOOLEAN COMMENT 'Flag indicating whether this code is applicable to facility (institutional) claims. True for codes used in hospital, SNF, hospice, and other facility settings.',
    `governing_body` STRING COMMENT 'The authoritative organization responsible for defining and maintaining this code set. NUBC for UB-04 codes, CMS for Medicare codes, AMA for CPT codes, STATE for state-specific codes.. Valid values are `NUBC|CMS|AMA|STATE`',
    `hospice_indicator` BOOLEAN COMMENT 'For discharge disposition codes, indicates whether the disposition represents a hospice discharge (home hospice or hospice facility).',
    `last_updated_date` DATE COMMENT 'The date when this code record was last modified in the reference system. Used for change tracking and data synchronization. Format: yyyy-MM-dd.',
    `medicaid_approved_flag` BOOLEAN COMMENT 'Indicates whether this code is recognized and accepted by Medicaid programs for claims processing and reimbursement.',
    `medicare_approved_flag` BOOLEAN COMMENT 'Indicates whether this code is recognized and accepted by Medicare for claims processing and reimbursement.',
    `pricing_impact_flag` BOOLEAN COMMENT 'Indicates whether this code affects reimbursement calculation, DRG assignment, or payment adjustment. True for codes that trigger pricing logic in claims adjudication.',
    `professional_indicator` BOOLEAN COMMENT 'Flag indicating whether this code is applicable to professional (physician) claims submitted on CMS-1500 forms.',
    `replacement_code` STRING COMMENT 'For deprecated or inactive codes, the new code value that should be used instead. Null if no direct replacement exists.',
    `requires_value_flag` BOOLEAN COMMENT 'For value codes and occurrence codes, indicates whether the code must be accompanied by a numeric value or date on the claim form.',
    `short_description` STRING COMMENT 'Abbreviated description for display in constrained UI contexts and reports. Typically 30-50 characters.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'For place of service (POS) codes, indicates whether the location is eligible for telehealth service delivery and reimbursement.',
    `termination_date` DATE COMMENT 'The date on which this code was retired or became invalid for use on claims. Null if the code is currently active. Format: yyyy-MM-dd.',
    `ub04_form_locator` STRING COMMENT 'The specific field location on the UB-04 claim form where this code appears. Examples: FL 18-28 for condition codes, FL 31-36 for occurrence codes, FL 39-41 for value codes, FL 42 for revenue codes.',
    `usage_notes` STRING COMMENT 'Additional guidance, constraints, or special instructions for proper use of this code on claims. May include payer-specific requirements or coding scenarios.',
    CONSTRAINT pk_condition_code PRIMARY KEY(`condition_code_id`)
) COMMENT 'Consolidated reference catalog of standardized billing form codes used across UB-04 facility claims and CMS-1500 professional claims. Encompasses condition codes (FL 18-28), occurrence codes (FL 31-36), occurrence span codes, value codes (FL 39-41), admit source codes, discharge disposition codes, place of service (POS) codes, revenue codes, and CPT/HCPCS modifier codes. Each record captures the code, code_type discriminator (condition_code, occurrence_code, value_code, admit_source, discharge_disposition, pos_code, revenue_code, modifier_code), description, applicable claim form (UB-04/CMS-1500), category, associated flags (facility indicator, pricing impact, hospice/AMA/expired indicators for dispositions, telehealth eligibility for POS, bilateral indicator for modifiers), and effective/termination dates. Provides a single authoritative lookup for all standardized billing form code sets governed by NUBC, CMS, and AMA guidelines. Consumers filter by code_type to retrieve the specific code set needed.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` (
    `code_set_version_id` BIGINT COMMENT 'Unique identifier for the code set version record. Primary key.',
    `superseded_by_version_code_set_version_id` BIGINT COMMENT 'Reference to the code_set_version_id of the newer version that replaces this one. Nullable if this is the current active version.',
    `checksum_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate the file_hash for integrity verification: MD5, SHA256, or SHA512.. Valid values are `MD5|SHA256|SHA512`',
    `code_set_name` STRING COMMENT 'The name of the reference code set (e.g., ICD-10-CM, CPT, HCPCS, SNOMED CT, LOINC, NDC, RxNorm, DRG Grouper, HL7 Value Set, FHIR Value Set).',
    `code_set_type` STRING COMMENT 'The functional category of the code set: diagnosis (ICD-10), procedure (CPT/HCPCS), drug (NDC/RxNorm), observation (LOINC), terminology (SNOMED CT), or grouper (DRG/APR-DRG).. Valid values are `diagnosis|procedure|drug|observation|terminology|grouper`',
    `compliance_year` STRING COMMENT 'The fiscal or calendar year for which this code set version is required for regulatory compliance and reimbursement (e.g., 2024 for FY2024 ICD-10-CM).',
    `copyright_notice` STRING COMMENT 'Legal copyright and licensing information for this code set version, including usage restrictions and attribution requirements.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the jurisdiction or country-specific variant of this code set (e.g., USA for ICD-10-CM, CAN for ICD-10-CA).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this code set version record was first created in the enterprise reference data repository.',
    `download_timestamp` TIMESTAMP COMMENT 'The date and time when this code set version file was downloaded from the source authority.',
    `effective_date` DATE COMMENT 'The date on which this code set version becomes valid and available for use in clinical documentation, billing, and reporting.',
    `file_hash` STRING COMMENT 'Cryptographic hash (SHA-256 or MD5) of the source file, used to verify data integrity and detect unauthorized modifications.',
    `file_name` STRING COMMENT 'The name of the source file or package containing this code set version (e.g., icd10cm_tabular_2024.xml, cpt_codes_2024.csv).',
    `format_type` STRING COMMENT 'The file format or data structure of the source code set: csv (comma-separated values), xml (extensible markup language), json (JavaScript object notation), fhir (FHIR CodeSystem resource), hl7 (HL7 v2 table), proprietary (vendor-specific format).. Valid values are `csv|xml|json|fhir|hl7|proprietary`',
    `is_hipaa_compliant` BOOLEAN COMMENT 'Indicates whether this code set version meets HIPAA transaction and code set standards for electronic healthcare transactions.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language of the code set descriptions and labels (e.g., en for English, es for Spanish).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this code set version record was last modified in the enterprise reference data repository.',
    `license_type` STRING COMMENT 'The licensing model governing the use of this code set: public_domain (freely available), proprietary (commercial license required), open_source (open license with attribution), restricted (limited use agreement).. Valid values are `public_domain|proprietary|open_source|restricted`',
    `load_status` STRING COMMENT 'The current status of the ETL process for loading this code set version into the enterprise data platform: pending (queued), in_progress (loading), completed (successfully loaded), failed (load error), validated (post-load quality checks passed).. Valid values are `pending|in_progress|completed|failed|validated`',
    `load_timestamp` TIMESTAMP COMMENT 'The date and time when this code set version was successfully loaded into the enterprise reference data repository.',
    `publication_date` DATE COMMENT 'The official date on which the source authority published or released this code set version.',
    `record_count` BIGINT COMMENT 'The total number of individual codes or entries contained in this code set version.',
    `release_notes` STRING COMMENT 'Summary of changes, additions, deletions, and updates included in this code set version compared to the previous version.',
    `source_authority` STRING COMMENT 'The governing body or organization that publishes and maintains this code set (e.g., WHO, AMA, CMS, SNOMED International, Regenstrief Institute, FDA, NLM).',
    `source_url` STRING COMMENT 'The official download or reference URL from which this code set version was obtained.',
    `termination_date` DATE COMMENT 'The date on which this code set version is no longer valid for new transactions. Nullable for versions that remain active indefinitely.',
    `usage_scope` STRING COMMENT 'The primary business domain(s) for which this code set version is intended: clinical (EHR documentation), billing (claims and revenue cycle), research (clinical trials and studies), quality (HEDIS/quality reporting), or all ().. Valid values are `clinical|billing|research|quality|all`',
    `validation_status` STRING COMMENT 'The outcome of post-load data quality validation: not_validated (validation not yet performed), passed (all quality checks passed), failed (critical validation errors detected), warning (non-critical issues identified).. Valid values are `not_validated|passed|failed|warning`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when data quality validation was performed on this code set version.',
    `version_identifier` STRING COMMENT 'The official version number or release identifier assigned by the source authority (e.g., 2024, v3.5, FY2024, 20240101).',
    `version_status` STRING COMMENT 'Current lifecycle status of this code set version: draft (not yet effective), active (currently in use), superseded (replaced by newer version), retired (no longer valid), deprecated (scheduled for retirement).. Valid values are `draft|active|superseded|retired|deprecated`',
    CONSTRAINT pk_code_set_version PRIMARY KEY(`code_set_version_id`)
) COMMENT 'Lifecycle and version tracking for all enterprise reference code sets (ICD-10, CPT, HCPCS, SNOMED CT, LOINC, NDC, RxNorm, DRG grouper, etc.). Each record captures code set name, version identifier, effective date, termination date, source authority, download URL, file hash, record count, load status, load timestamp, and superseded-by reference. Enables audit of which code set version was active at any point in time, supporting retrospective claims adjudication, regulatory compliance, and reproducible terminology expansion for FHIR value sets.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` (
    `crosswalk_id` BIGINT COMMENT 'Unique identifier for the terminology crosswalk mapping record.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Crosswalk mappings are version-specific - ICD-10-CM to SNOMED CT mappings change with each release of both terminologies. The crosswalk table has source_code_system_version (STRING), target_code_syste',
    `source_code_set_version_id` BIGINT COMMENT 'add column source_code_set_version_id (BIGINT) with FK to reference.code_set_version.code_set_version_id - crosswalk maps between code sets but only has one code_set_version FK; it needs source and target version FKs',
    `approximate_flag` BOOLEAN COMMENT 'Indicates whether the mapping is an approximate or inexact match (True) requiring clinical review, or an exact semantic match (False).',
    `choice_list_indicator` STRING COMMENT 'Indicates whether the target code is one of multiple valid choices for the source code, requiring clinical judgment to select the most appropriate target.',
    `combination_flag` BOOLEAN COMMENT 'Indicates whether this mapping requires multiple target codes to fully represent the source code (True) or is a single 1:1 or 1:0 mapping (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crosswalk mapping record was first created in the system.',
    `directionality` STRING COMMENT 'Indicates whether the mapping is valid in one direction (forward: source to target only, backward: target to source only) or both directions (bidirectional).. Valid values are `forward|backward|bidirectional`',
    `effective_date` DATE COMMENT 'The date on which this crosswalk mapping becomes valid and available for use.',
    `last_validated_date` DATE COMMENT 'The most recent date on which this mapping was reviewed and validated by clinical or coding subject matter experts.',
    `map_group` STRING COMMENT 'Grouping identifier for related mappings that should be considered together (e.g., all mappings for a specific clinical domain or use case).',
    `map_priority` STRING COMMENT 'Numeric ranking indicating the preferred order when multiple target codes are valid for a single source code (lower numbers indicate higher priority).',
    `mapping_authority` STRING COMMENT 'The authoritative source or organization that published or validated this mapping (e.g., CMS, NLM, SNOMED International, Regenstrief Institute, internal clinical terminology team).',
    `mapping_purpose` STRING COMMENT 'The intended use case or business purpose for this mapping (e.g., claims submission, clinical documentation, quality reporting, SDOH screening, interoperability, legacy system migration).',
    `mapping_quality` STRING COMMENT 'The confidence or precision level of the mapping: exact (perfect semantic match), high (strong clinical equivalence), moderate (acceptable with context), low (weak or conditional match).. Valid values are `exact|high|moderate|low`',
    `mapping_rule` STRING COMMENT 'Textual description of any conditional logic, clinical context, or business rules that govern when and how this mapping should be applied.',
    `mapping_type` STRING COMMENT 'The semantic relationship between source and target codes: equivalent (1:1 exact match), broader (source is more specific than target), narrower (source is more general than target), related (associated but not hierarchical), inexact (approximate match), unmatched (no suitable target).. Valid values are `equivalent|broader|narrower|related|inexact|unmatched`',
    `no_map_flag` BOOLEAN COMMENT 'Indicates whether the source code has no suitable equivalent in the target code system (True) or a valid mapping exists (False).',
    `notes` STRING COMMENT 'Free-text field for additional context, clinical guidance, or special instructions related to this mapping.',
    `scenario_flag` BOOLEAN COMMENT 'Identifies specific clinical or billing scenarios where this mapping applies (e.g., inpatient vs outpatient, primary vs secondary diagnosis).',
    `source_code` STRING COMMENT 'The specific code value in the source code system being mapped from (e.g., E11.9 for ICD-10, 73211009 for SNOMED CT).. Valid values are `^[A-Z0-9.-]{1,50}$`',
    `source_code_display` STRING COMMENT 'Human-readable display text or description for the source code.',
    `source_code_system` STRING COMMENT 'The originating terminology or code system from which the mapping is derived (e.g., ICD-10-CM, SNOMED CT, CPT, LOINC, NDC, RxNorm).. Valid values are `^[A-Z0-9_-]{2,50}$`',
    `target_code` STRING COMMENT 'The specific code value in the target code system being mapped to (e.g., 73211009 for SNOMED CT, 99213 for CPT).. Valid values are `^[A-Z0-9.-]{1,50}$`',
    `target_code_display` STRING COMMENT 'Human-readable display text or description for the target code.',
    `target_code_system` STRING COMMENT 'The destination terminology or code system to which the mapping is made (e.g., ICD-10-CM, SNOMED CT, CPT, LOINC, NDC, RxNorm).. Valid values are `^[A-Z0-9_-]{2,50}$`',
    `termination_date` DATE COMMENT 'The date on which this crosswalk mapping is no longer valid or has been superseded. Null indicates the mapping is still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this crosswalk mapping record was last modified.',
    `usage_count` BIGINT COMMENT 'The number of times this crosswalk mapping has been applied in production systems, used for mapping quality assessment and optimization.',
    `validated_by` STRING COMMENT 'The name or identifier of the clinical or coding expert who last validated this mapping.',
    CONSTRAINT pk_crosswalk PRIMARY KEY(`crosswalk_id`)
) COMMENT 'Enterprise terminology crosswalk and mapping table maintaining authoritative code-to-code translations between clinical and billing code systems. Each mapping record captures source code system, source code, target code system, target code, mapping type (equivalent, broader, narrower, related), mapping quality (exact, inexact), directionality, source and target code_set_version references, effective and termination dates, and source authority. Covers ICD-9→ICD-10 GEMs, SNOMED CT→ICD-10 maps, NDC→RxNorm, CPT→SNOMED procedure maps, LOINC→SNOMED observation maps, and SDOH code mappings (ICD-10-Z↔SNOMED↔LOINC SDOH panels). Essential for claims migration, clinical-to-billing translation, SDOH reporting, and cross-system interoperability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` (
    `major_diagnostic_category_id` BIGINT COMMENT 'Primary key for major_diagnostic_category',
    `parent_major_diagnostic_category_id` BIGINT COMMENT 'Self-referencing FK on major_diagnostic_category (parent_major_diagnostic_category_id)',
    `average_length_of_stay_days` DECIMAL(18,2) COMMENT 'National average length of stay in days for cases grouped to this MDC. Used for benchmarking and utilization management.',
    `body_system` STRING COMMENT 'Primary anatomical body system or organ system associated with this MDC (e.g., Cardiovascular, Respiratory, Musculoskeletal).',
    `case_volume_rank` STRING COMMENT 'National ranking of this MDC by case volume (1 = highest volume). Used for prioritization and resource planning.',
    `classification_type` STRING COMMENT 'Type of classification logic used for this MDC: organ_system (anatomical), procedure_based (surgical/procedural), condition_based (disease-focused), or special_category (pre-MDC, ungroupable).',
    `clinical_notes` STRING COMMENT 'Additional clinical context, coding guidance, or special considerations for this MDC. Used by HIM and coding staff.',
    `complication_comorbidity_logic` STRING COMMENT 'Type of CC/MCC logic applied within this MDC: standard (uses CC/MCC lists), modified (custom logic), or not_applicable (no CC partitioning).',
    `major_diagnostic_category_description` STRING COMMENT 'Detailed clinical and administrative description of the MDC scope, including typical diagnoses, procedures, and patient populations covered.',
    `drg_count` STRING COMMENT 'Total number of DRGs contained within this MDC. Used for reference and validation.',
    `effective_date` DATE COMMENT 'Date when this MDC definition became effective for use in DRG grouping and reimbursement.',
    `fiscal_year` STRING COMMENT 'Federal fiscal year for which this MDC definition applies (e.g., 2024). CMS updates MDC definitions annually.',
    `icd_10_cm_range_end` STRING COMMENT 'Ending ICD-10-CM diagnosis code that maps to this MDC (e.g., G99). Used for grouper logic.',
    `icd_10_cm_range_start` STRING COMMENT 'Starting ICD-10-CM diagnosis code that maps to this MDC (e.g., G00). Used for grouper logic.',
    `icd_10_pcs_range_end` STRING COMMENT 'Ending ICD-10-PCS procedure code that maps to this MDC. Used for surgical partition assignment.',
    `icd_10_pcs_range_start` STRING COMMENT 'Starting ICD-10-PCS procedure code that maps to this MDC. Used for surgical partition assignment.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this MDC is currently active and available for use in DRG grouping. False for historical or deprecated MDCs.',
    `last_updated_date` DATE COMMENT 'Date when this MDC record was last modified in the reference data system. Used for change tracking and audit.',
    `mdc_code` STRING COMMENT 'Standard MDC code used in DRG grouping (e.g., MDC01, MDC02). This is the externally-known unique identifier for the category.',
    `mdc_number` STRING COMMENT 'Numeric representation of the MDC (1-25). Used for sorting and grouping logic.',
    `major_diagnostic_category_name` STRING COMMENT 'Full descriptive name of the major diagnostic category (e.g., Diseases and Disorders of the Nervous System).',
    `pre_mdc_indicator` BOOLEAN COMMENT 'Indicates whether this is a pre-MDC assignment (e.g., transplants, tracheostomy, ECMO) that bypasses standard MDC logic. True for special high-resource cases.',
    `reimbursement_impact_level` STRING COMMENT 'Relative financial impact of this MDC on hospital reimbursement: high (high-cost, high-volume), medium, or low.',
    `relative_weight_average` DECIMAL(18,2) COMMENT 'Average relative weight of all DRGs within this MDC. Used for cost and resource intensity analysis.',
    `short_name` STRING COMMENT 'Abbreviated name for display and reporting purposes (e.g., Nervous System).',
    `major_diagnostic_category_status` STRING COMMENT 'Current lifecycle status of this MDC in the reference system. Active MDCs are used in current grouper logic.',
    `surgical_medical_partition` STRING COMMENT 'Indicates whether this MDC contains surgical DRGs, medical DRGs, or both. Not applicable for pre-MDC categories.',
    `termination_date` DATE COMMENT 'Date when this MDC definition was retired or superseded. Null for currently active MDCs.',
    `ungroupable_indicator` BOOLEAN COMMENT 'Indicates whether this MDC represents ungroupable cases that do not fit standard classification logic. True for error DRGs.',
    `version` STRING COMMENT 'Version identifier for this MDC definition (e.g., FY2024, v41.0). Tracks annual updates to grouper logic.',
    CONSTRAINT pk_major_diagnostic_category PRIMARY KEY(`major_diagnostic_category_id`)
) COMMENT 'Master reference table for major_diagnostic_category. Referenced by mdc_id.';

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
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ADD CONSTRAINT `fk_reference_crosswalk_source_code_set_version_id` FOREIGN KEY (`source_code_set_version_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`code_set_version`(`code_set_version_id`);
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ADD CONSTRAINT `fk_reference_major_diagnostic_category_parent_major_diagnostic_category_id` FOREIGN KEY (`parent_major_diagnostic_category_id`) REFERENCES `vibe_healthcare_v1`.`reference`.`major_diagnostic_category`(`major_diagnostic_category_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`reference` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`reference` SET TAGS ('dbx_domain' = 'reference');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Code ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_high` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_high` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_low` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `age_low` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_category` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `cc_flag` SET TAGS ('dbx_business_glossary_term' = 'CC (Complication or Comorbidity) Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Chapter');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter_code` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Chapter Code Range');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `chapter_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}-[A-Z][0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_code` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `icd_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_type` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `code_type` SET TAGS ('dbx_value_regex' = 'diagnosis|procedure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `etiology_code_flag` SET TAGS ('dbx_business_glossary_term' = 'Etiology Code Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Specific Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `hac_flag` SET TAGS ('dbx_business_glossary_term' = 'HAC (Hospital-Acquired Condition) Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Code Long Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `manifestation_code_flag` SET TAGS ('dbx_business_glossary_term' = 'Manifestation Code Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `mcc_flag` SET TAGS ('dbx_business_glossary_term' = 'MCC (Major Complication or Comorbidity) Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `parent_code` SET TAGS ('dbx_business_glossary_term' = 'Parent ICD (International Classification of Diseases) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `poa_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'POA (Present on Admission) Exempt Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `replacement_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement ICD (International Classification of Diseases) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Code Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `snomed_ct_mapping` SET TAGS ('dbx_business_glossary_term' = 'SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) Mapping');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'ICD (International Classification of Diseases) Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `unacceptable_principal_dx_flag` SET TAGS ('dbx_business_glossary_term' = 'Unacceptable Principal Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`icd_code` ALTER COLUMN `valid_for_coding_flag` SET TAGS ('dbx_business_glossary_term' = 'Valid for Coding Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Code ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_high` SET TAGS ('dbx_business_glossary_term' = 'Age Range High');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_high` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_low` SET TAGS ('dbx_business_glossary_term' = 'Age Range Low');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `age_range_low` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `anesthesia_base_units` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_category` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_category` SET TAGS ('dbx_value_regex' = 'Category I|Category II|Category III');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `clinical_family` SET TAGS ('dbx_business_glossary_term' = 'Clinical Family');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Code Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `facility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Facility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `facility_indicator` SET TAGS ('dbx_value_regex' = 'facility|non-facility|both');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `full_descriptor` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Full Descriptor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('dbx_business_glossary_term' = 'Gender Specific');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('dbx_value_regex' = 'male|female|both');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `gender_specific` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `global_period` SET TAGS ('dbx_business_glossary_term' = 'Global Period');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `malpractice_rvu` SET TAGS ('dbx_business_glossary_term' = 'Malpractice RVU (Relative Value Unit)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `medically_unlikely_edit_value` SET TAGS ('dbx_business_glossary_term' = 'MUE (Medically Unlikely Edit) Value');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `modifier_indicator` SET TAGS ('dbx_business_glossary_term' = 'Modifier Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `modifier_indicator` SET TAGS ('dbx_value_regex' = '0|1|2|3|9');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('dbx_business_glossary_term' = 'Multiple Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `national_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'National Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `ncci_edit_indicator` SET TAGS ('dbx_business_glossary_term' = 'NCCI (National Correct Coding Initiative) Edit Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `physician_supervision_required` SET TAGS ('dbx_business_glossary_term' = 'Physician Supervision Required');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `physician_supervision_required` SET TAGS ('dbx_value_regex' = 'direct|general|personal|none');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `place_of_service_restriction` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `practice_expense_rvu` SET TAGS ('dbx_business_glossary_term' = 'Practice Expense RVU (Relative Value Unit)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `section` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Section');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `short_descriptor` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Short Descriptor');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_status` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Code Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `cpt_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|pending');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `subsection` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Subsection');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `telemedicine_eligible` SET TAGS ('dbx_business_glossary_term' = 'Telemedicine Eligible');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Code Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `total_rvu` SET TAGS ('dbx_business_glossary_term' = 'Total RVU (Relative Value Unit)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`cpt_code` ALTER COLUMN `work_rvu` SET TAGS ('dbx_business_glossary_term' = 'Work RVU (Relative Value Unit)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Code ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `age_restriction` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `anesthesia_base_units` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `asc_payment_indicator` SET TAGS ('dbx_business_glossary_term' = 'ASC (Ambulatory Surgical Center) Payment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `assistant_surgeon_indicator` SET TAGS ('dbx_business_glossary_term' = 'Assistant Surgeon Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `bilateral_surgery_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Surgery Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_category` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `co_surgeon_indicator` SET TAGS ('dbx_business_glossary_term' = 'Co-Surgeon Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_code` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `hcpcs_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_type` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `code_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|deleted');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Coverage Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `coverage_indicator` SET TAGS ('dbx_value_regex' = 'covered|not_covered|carrier_discretion|bundled|conditional');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `coverage_indicator` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Requirement Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `diagnosis_requirement_indicator` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `dme_indicator` SET TAGS ('dbx_business_glossary_term' = 'DME (Durable Medical Equipment) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `drug_indicator` SET TAGS ('dbx_business_glossary_term' = 'Drug Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|none');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `global_period` SET TAGS ('dbx_business_glossary_term' = 'Global Period');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `intraoperative_percentage` SET TAGS ('dbx_business_glossary_term' = 'Intraoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `intraoperative_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Long Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `modifier_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Modifier Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `multiple_procedure_indicator` SET TAGS ('dbx_business_glossary_term' = 'Multiple Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `ndc_crosswalk_indicator` SET TAGS ('dbx_business_glossary_term' = 'NDC (National Drug Code) Crosswalk Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `opps_payment_indicator` SET TAGS ('dbx_business_glossary_term' = 'OPPS (Outpatient Prospective Payment System) Payment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `place_of_service_restriction` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Restriction');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `postoperative_percentage` SET TAGS ('dbx_business_glossary_term' = 'Postoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `postoperative_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `preoperative_percentage` SET TAGS ('dbx_business_glossary_term' = 'Preoperative Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `preoperative_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `pricing_indicator` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Pricing Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `pricing_indicator` SET TAGS ('dbx_value_regex' = 'fee_schedule|asc|reasonable_charge|not_priced|contractor_priced');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `prior_authorization_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `professional_component_indicator` SET TAGS ('dbx_business_glossary_term' = 'Professional Component Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `superseded_by_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By HCPCS (Healthcare Common Procedure Coding System) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `team_surgery_indicator` SET TAGS ('dbx_business_glossary_term' = 'Team Surgery Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `technical_component_indicator` SET TAGS ('dbx_business_glossary_term' = 'Technical Component Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'HCPCS (Healthcare Common Procedure Coding System) Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`hcpcs_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `major_diagnostic_category_id` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category (MDC) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `arithmetic_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Arithmetic Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `bundled_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Bundled Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `clinical_family` SET TAGS ('dbx_business_glossary_term' = 'Clinical Family');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `complication_level` SET TAGS ('dbx_business_glossary_term' = 'Complication or Comorbidity (CC) / Major Complication or Comorbidity (MCC) Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `complication_level` SET TAGS ('dbx_value_regex' = 'without CC/MCC|with CC|with MCC');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `cost_outlier_threshold` SET TAGS ('dbx_business_glossary_term' = 'Cost Outlier Threshold');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `geometric_mean_los` SET TAGS ('dbx_business_glossary_term' = 'Geometric Mean Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `grouper_system` SET TAGS ('dbx_business_glossary_term' = 'Grouper System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `grouper_system` SET TAGS ('dbx_value_regex' = 'MS-DRG|AP-DRG|APR-DRG|IR-DRG');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_charges` SET TAGS ('dbx_business_glossary_term' = 'National Average Charges');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_charges` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_payment` SET TAGS ('dbx_business_glossary_term' = 'National Average Payment');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_average_payment` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `national_case_volume` SET TAGS ('dbx_business_glossary_term' = 'National Case Volume');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `operating_room_procedure_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Procedure Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `post_acute_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Acute Transfer Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_end` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('dbx_business_glossary_term' = 'Principal Diagnosis Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `principal_diagnosis_range_start` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `procedure_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Procedure Requirement Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `readmission_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Readmission Penalty Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `relative_weight` SET TAGS ('dbx_business_glossary_term' = 'Relative Weight');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `special_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Payment Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Title');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis-Related Group (DRG) Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`drg` ALTER COLUMN `drg_type` SET TAGS ('dbx_value_regex' = 'medical|surgical|procedure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'SNOMED CT (Systematized Nomenclature of Medicine Clinical Terms) Concept Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `parent_concept_snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Concept Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `clinical_documentation_section` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Section');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_class` SET TAGS ('dbx_business_glossary_term' = 'Concept Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_definition` SET TAGS ('dbx_business_glossary_term' = 'Concept Definition');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_business_glossary_term' = 'Concept Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `concept_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|duplicate|ambiguous|erroneous');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `cpt_map_target` SET TAGS ('dbx_business_glossary_term' = 'CPT (Current Procedural Terminology) Map Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `definition_status` SET TAGS ('dbx_business_glossary_term' = 'Definition Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `definition_status` SET TAGS ('dbx_value_regex' = 'primitive|fully_defined');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `effective_time` SET TAGS ('dbx_business_glossary_term' = 'Effective Time');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fhir_value_set_membership` SET TAGS ('dbx_business_glossary_term' = 'FHIR (Fast Healthcare Interoperability Resources) Value Set Membership');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `fully_specified_name` SET TAGS ('dbx_business_glossary_term' = 'Fully Specified Name (FSN)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_correlation` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 Map Correlation');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_correlation` SET TAGS ('dbx_value_regex' = 'exact|narrow_to_broad|broad_to_narrow|partial|not_mappable');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `icd10_map_target` SET TAGS ('dbx_business_glossary_term' = 'ICD-10 (International Classification of Diseases 10th Revision) Map Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_ehr_preferred` SET TAGS ('dbx_business_glossary_term' = 'Is EHR (Electronic Health Record) Preferred Concept Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_leaf_concept` SET TAGS ('dbx_business_glossary_term' = 'Is Leaf Concept Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_primitive` SET TAGS ('dbx_business_glossary_term' = 'Is Primitive Concept Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable Condition Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `loinc_map_target` SET TAGS ('dbx_business_glossary_term' = 'LOINC (Logical Observation Identifiers Names and Codes) Map Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `module_code` SET TAGS ('dbx_business_glossary_term' = 'Module Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `patient_friendly_term` SET TAGS ('dbx_business_glossary_term' = 'Patient-Friendly Term');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `preferred_term` SET TAGS ('dbx_business_glossary_term' = 'Preferred Term (PT)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `quality_measure_inclusion` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Inclusion');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `relationship_count` SET TAGS ('dbx_business_glossary_term' = 'Relationship Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `rxnorm_map_target` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Map Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `semantic_tag` SET TAGS ('dbx_business_glossary_term' = 'Semantic Tag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `specialty_relevance` SET TAGS ('dbx_business_glossary_term' = 'Specialty Relevance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `synonym_count` SET TAGS ('dbx_business_glossary_term' = 'Synonym Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `top_level_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Top-Level Hierarchy');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `usage_frequency_rank` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency Rank');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`snomed_concept` ALTER COLUMN `usage_frequency_rank` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'LOINC (Logical Observation Identifiers Names and Codes) Code ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `class` SET TAGS ('dbx_business_glossary_term' = 'Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `component` SET TAGS ('dbx_business_glossary_term' = 'Component');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `consumer_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `deprecated_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Display Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `example_ucum_units` SET TAGS ('dbx_business_glossary_term' = 'Example UCUM (Unified Code for Units of Measure) Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `example_units` SET TAGS ('dbx_business_glossary_term' = 'Example Units');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `external_copyright_notice` SET TAGS ('dbx_business_glossary_term' = 'External Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `hl7_field_subfield_code` SET TAGS ('dbx_business_glossary_term' = 'HL7 (Health Level Seven) Field Subfield ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `hl7_v3_code_system_oid` SET TAGS ('dbx_business_glossary_term' = 'HL7 (Health Level Seven) Version 3 Code System OID (Object Identifier)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `local_code` SET TAGS ('dbx_business_glossary_term' = 'Local Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_number` SET TAGS ('dbx_business_glossary_term' = 'LOINC (Logical Observation Identifiers Names and Codes) Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `loinc_number` SET TAGS ('dbx_value_regex' = '^[0-9]+-[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `long_common_name` SET TAGS ('dbx_business_glossary_term' = 'Long Common Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Method Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `order_observation_flag` SET TAGS ('dbx_business_glossary_term' = 'Order Observation Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Panel Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `panel_type` SET TAGS ('dbx_value_regex' = 'Panel|Battery|Set');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `property` SET TAGS ('dbx_business_glossary_term' = 'Property');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `related_names` SET TAGS ('dbx_business_glossary_term' = 'Related Names');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `scale_type` SET TAGS ('dbx_value_regex' = 'Qn|Ord|Nom|Nar|Doc');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `survey_question_source` SET TAGS ('dbx_business_glossary_term' = 'Survey Question Source');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `survey_question_text` SET TAGS ('dbx_business_glossary_term' = 'Survey Question Text');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `system` SET TAGS ('dbx_business_glossary_term' = 'System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `time_aspect` SET TAGS ('dbx_business_glossary_term' = 'Time Aspect');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`loinc_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Drug ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Application Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `biosimilar_flag` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV|');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `dosage_form` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `fhir_medication_code` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Medication Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'formulary|non_formulary|restricted|preferred');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `gpi_code` SET TAGS ('dbx_business_glossary_term' = 'Generic Product Identifier (GPI) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `high_alert_medication_flag` SET TAGS ('dbx_business_glossary_term' = 'High-Alert Medication Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `labeler_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Labeler Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_category` SET TAGS ('dbx_business_glossary_term' = 'Marketing Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `marketing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^d{11}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `nonproprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Non-Proprietary (Generic) Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `orange_book_code` SET TAGS ('dbx_business_glossary_term' = 'FDA Orange Book Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `over_the_counter_flag` SET TAGS ('dbx_business_glossary_term' = 'Over-The-Counter (OTC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_description` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_quantity` SET TAGS ('dbx_business_glossary_term' = 'Package Quantity');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_quantity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_unit` SET TAGS ('dbx_business_glossary_term' = 'Package Unit');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `package_unit` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D|X|N');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Proprietary (Brand) Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxcui` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Concept Unique Identifier (RxCUI)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_name` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Concept Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_source_vocabulary` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Source Vocabulary');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_suppress_flag` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Suppress Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `rxnorm_term_type` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Term Type (TTY)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `snomed_ct_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `strength_unit` SET TAGS ('dbx_business_glossary_term' = 'Strength Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `unii_code` SET TAGS ('dbx_business_glossary_term' = 'Unique Ingredient Identifier (UNII) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`ndc_drug` ALTER COLUMN `vaccine_flag` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_value_set_id` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Value Set Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `binding_strength` SET TAGS ('dbx_business_glossary_term' = 'Binding Strength');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `binding_strength` SET TAGS ('dbx_value_regex' = 'required|extensible|preferred|example');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `canonical_url` SET TAGS ('dbx_business_glossary_term' = 'Canonical Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `canonical_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9._~:/?#[]@!$&()*+,;=-]*)?$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `compose_exclude_count` SET TAGS ('dbx_business_glossary_term' = 'Compose Exclude Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `compose_include_count` SET TAGS ('dbx_business_glossary_term' = 'Compose Include Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `contact_json` SET TAGS ('dbx_business_glossary_term' = 'Contact Information JavaScript Object Notation (JSON)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `copyright` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_value_set_description` SET TAGS ('dbx_business_glossary_term' = 'Value Set Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_identifier` SET TAGS ('dbx_business_glossary_term' = 'Expansion Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_offset` SET TAGS ('dbx_business_glossary_term' = 'Expansion Offset');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_parameter_json` SET TAGS ('dbx_business_glossary_term' = 'Expansion Parameter JavaScript Object Notation (JSON)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expansion Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `expansion_total_concepts` SET TAGS ('dbx_business_glossary_term' = 'Expansion Total Concepts');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `experimental_flag` SET TAGS ('dbx_business_glossary_term' = 'Experimental Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_element_path` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Element Path');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `immutable_flag` SET TAGS ('dbx_business_glossary_term' = 'Immutable Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `jurisdiction_codes` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Codes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher Organization');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Value Set Purpose');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Value Set Title');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `use_context_json` SET TAGS ('dbx_business_glossary_term' = 'Use Context JavaScript Object Notation (JSON)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_name` SET TAGS ('dbx_business_glossary_term' = 'Value Set Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_oid` SET TAGS ('dbx_business_glossary_term' = 'Object Identifier (OID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`fhir_value_set` ALTER COLUMN `value_set_oid` SET TAGS ('dbx_value_regex' = '^[0-2](.(0|[1-9][0-9]*))+$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Geographic Region Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Official First Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Official Last Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Official Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('dbx_business_glossary_term' = 'Authorized Official Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_telephone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `authorized_official_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Official Title or Position');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'NPI Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `employer_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `employer_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `employer_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `entity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Entity Type Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `entity_type_code` SET TAGS ('dbx_value_regex' = '1|2');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `enumeration_date` SET TAGS ('dbx_business_glossary_term' = 'NPI Enumeration Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `last_update_date` SET TAGS ('dbx_business_glossary_term' = 'NPI Last Update Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address City');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address State');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `mailing_address_telephone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `organization_other_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Other Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Address Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Telephone Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `practice_location_telephone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Healthcare Provider Taxonomy Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}[A-Z]$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_switch` SET TAGS ('dbx_business_glossary_term' = 'Primary Taxonomy Switch Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `primary_taxonomy_switch` SET TAGS ('dbx_value_regex' = 'Y|N');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_credential` SET TAGS ('dbx_business_glossary_term' = 'Provider Credential');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('dbx_business_glossary_term' = 'Provider First Name (Legal Name)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Gender Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('dbx_value_regex' = 'M|F');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_gender_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Last Name (Legal Name)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_prefix` SET TAGS ('dbx_business_glossary_term' = 'Provider Name Prefix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Provider Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_name_suffix` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_credential` SET TAGS ('dbx_business_glossary_term' = 'Provider Other Credential');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Other First Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Other Last Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Other Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_prefix` SET TAGS ('dbx_business_glossary_term' = 'Provider Other Name Prefix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Provider Other Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `provider_other_name_suffix` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `reactivation_date` SET TAGS ('dbx_business_glossary_term' = 'NPI Reactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('dbx_business_glossary_term' = 'Replacement National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`npi_registry` ALTER COLUMN `replacement_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Region Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `aco_service_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Service Area Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_code` SET TAGS ('dbx_business_glossary_term' = 'Core-Based Statistical Area (CBSA) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cbsa_name` SET TAGS ('dbx_business_glossary_term' = 'Core-Based Statistical Area (CBSA) Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_division` SET TAGS ('dbx_business_glossary_term' = 'Census Division');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_region` SET TAGS ('dbx_business_glossary_term' = 'Census Region');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `census_region` SET TAGS ('dbx_value_regex' = 'northeast|midwest|south|west');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `cms_region_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Region Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `fips_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `hrr_code` SET TAGS ('dbx_business_glossary_term' = 'Hospital Referral Region (HRR) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `hsa_code` SET TAGS ('dbx_business_glossary_term' = 'Hospital Service Area (HSA) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `median_household_income` SET TAGS ('dbx_business_glossary_term' = 'Median Household Income');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `poverty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Poverty Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Region Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `ruca_code` SET TAGS ('dbx_business_glossary_term' = 'Rural-Urban Commuting Area (RUCA) Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('dbx_business_glossary_term' = 'State Abbreviation');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `state_abbreviation` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `uninsured_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Uninsured Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_business_glossary_term' = 'Urban-Rural Classification');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`geographic_region` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Code ID');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `ama_indicator` SET TAGS ('dbx_business_glossary_term' = 'Against Medical Advice (AMA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `bilateral_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_category` SET TAGS ('dbx_business_glossary_term' = 'Code Category');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Form Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `claim_form_type` SET TAGS ('dbx_value_regex' = 'UB-04|CMS-1500|BOTH');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('dbx_business_glossary_term' = 'Code Value');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `code_type` SET TAGS ('dbx_business_glossary_term' = 'Code Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `commercial_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Payer Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `condition_code_description` SET TAGS ('dbx_business_glossary_term' = 'Code Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `expired_indicator` SET TAGS ('dbx_business_glossary_term' = 'Expired Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `facility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Facility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'NUBC|CMS|AMA|STATE');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `hospice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hospice Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Approved Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicare_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Approved Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `medicare_approved_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `pricing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Impact Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `professional_indicator` SET TAGS ('dbx_business_glossary_term' = 'Professional Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `replacement_code` SET TAGS ('dbx_business_glossary_term' = 'Replacement Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `requires_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Value Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `ub04_form_locator` SET TAGS ('dbx_business_glossary_term' = 'UB-04 Form Locator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`condition_code` ALTER COLUMN `usage_notes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `superseded_by_version_code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Version Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'MD5|SHA256|SHA512');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_name` SET TAGS ('dbx_business_glossary_term' = 'Code Set Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_type` SET TAGS ('dbx_business_glossary_term' = 'Code Set Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `code_set_type` SET TAGS ('dbx_value_regex' = 'diagnosis|procedure|drug|observation|terminology|grouper');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `copyright_notice` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `download_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Download Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'File Hash');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Format Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'csv|xml|json|fhir|hl7|proprietary');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `is_hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Health Insurance Portability and Accountability Act (HIPAA) Compliant');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'public_domain|proprietary|open_source|restricted');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_status` SET TAGS ('dbx_business_glossary_term' = 'Load Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|validated');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `load_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Load Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'clinical|billing|research|quality|all');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `usage_scope` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|passed|failed|warning');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_identifier` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`code_set_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired|deprecated');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` SET TAGS ('dbx_subdomain' = 'reference_governance');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `crosswalk_id` SET TAGS ('dbx_business_glossary_term' = 'Crosswalk Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `approximate_flag` SET TAGS ('dbx_business_glossary_term' = 'Approximate Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `choice_list_indicator` SET TAGS ('dbx_business_glossary_term' = 'Choice List Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `combination_flag` SET TAGS ('dbx_business_glossary_term' = 'Combination Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Mapping Directionality');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'forward|backward|bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `last_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `map_group` SET TAGS ('dbx_business_glossary_term' = 'Map Group');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `map_priority` SET TAGS ('dbx_business_glossary_term' = 'Map Priority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_authority` SET TAGS ('dbx_business_glossary_term' = 'Mapping Authority');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_purpose` SET TAGS ('dbx_business_glossary_term' = 'Mapping Purpose');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_quality` SET TAGS ('dbx_business_glossary_term' = 'Mapping Quality');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_quality` SET TAGS ('dbx_value_regex' = 'exact|high|moderate|low');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_rule` SET TAGS ('dbx_business_glossary_term' = 'Mapping Rule');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_type` SET TAGS ('dbx_business_glossary_term' = 'Mapping Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `mapping_type` SET TAGS ('dbx_value_regex' = 'equivalent|broader|narrower|related|inexact|unmatched');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `no_map_flag` SET TAGS ('dbx_business_glossary_term' = 'No Map Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'Scenario Flag');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{1,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_display` SET TAGS ('dbx_business_glossary_term' = 'Source Code Display Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_system` SET TAGS ('dbx_business_glossary_term' = 'Source Code System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `source_code_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{1,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_display` SET TAGS ('dbx_business_glossary_term' = 'Target Code Display Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_system` SET TAGS ('dbx_business_glossary_term' = 'Target Code System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `target_code_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,50}$');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`crosswalk` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` SET TAGS ('dbx_subdomain' = 'clinical_terminology');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_id` SET TAGS ('dbx_business_glossary_term' = 'Major Diagnostic Category Identifier');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `parent_major_diagnostic_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Major Diagnostic Category Id');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `parent_major_diagnostic_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `average_length_of_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Average Length Of Stay Days');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `average_length_of_stay_days` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `body_system` SET TAGS ('dbx_business_glossary_term' = 'Body System');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `case_volume_rank` SET TAGS ('dbx_business_glossary_term' = 'Case Volume Rank');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `complication_comorbidity_logic` SET TAGS ('dbx_business_glossary_term' = 'Complication Comorbidity Logic');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `drg_count` SET TAGS ('dbx_business_glossary_term' = 'Drg Count');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_end` SET TAGS ('dbx_business_glossary_term' = 'Icd 10 Cm Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_cm_range_start` SET TAGS ('dbx_business_glossary_term' = 'Icd 10 Cm Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_end` SET TAGS ('dbx_business_glossary_term' = 'Icd 10 Pcs Range End');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `icd_10_pcs_range_start` SET TAGS ('dbx_business_glossary_term' = 'Icd 10 Pcs Range Start');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `mdc_code` SET TAGS ('dbx_business_glossary_term' = 'Mdc Code');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `mdc_number` SET TAGS ('dbx_business_glossary_term' = 'Mdc Number');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `pre_mdc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pre Mdc Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `reimbursement_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Impact Level');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `relative_weight_average` SET TAGS ('dbx_business_glossary_term' = 'Relative Weight Average');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `relative_weight_average` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `major_diagnostic_category_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('dbx_business_glossary_term' = 'Surgical Medical Partition');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `surgical_medical_partition` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `ungroupable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Ungroupable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`reference`.`major_diagnostic_category` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
