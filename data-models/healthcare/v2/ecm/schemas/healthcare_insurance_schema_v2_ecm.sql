-- Schema for Domain: insurance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`insurance` COMMENT 'Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer` (
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer, health plan sponsor, or government program. Primary key for the payer master record within the insurance domain.',
    `parent_payer_id` BIGINT COMMENT 'Self-referencing FK on payer (parent_payer_id)',
    `primary_successor_payer_id` BIGINT COMMENT 'Reference to the payer record that replaces this payer in the event of merger, acquisition, or consolidation. Used to redirect claims and maintain continuity. Null if no successor exists.',
    `accepts_assignment` BOOLEAN COMMENT 'Indicates whether the payer accepts assignment of benefits, meaning the payer pays the provider directly rather than reimbursing the patient. True for most contracted payers; false for some out-of-network or self-pay arrangements.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this payer record is currently active and should be used for new claims and transactions. True if active; false if payer is inactive, merged, or no longer accepting claims. Inactive payers are retained for historical claim reference.',
    `appeal_limit_days` STRING COMMENT 'Number of days from claim denial date within which appeals must be submitted to this payer. Common values are 30, 60, 90, 180 days. Null if payer does not specify appeal deadlines.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract with this payer automatically renews at the end of the contract term. True if contract auto-renews unless either party provides notice; false if contract requires explicit renewal action.',
    `payer_category` STRING COMMENT 'High-level categorization of the payer organization. Government includes federal and state programs; commercial includes private insurance carriers; managed care includes HMOs, PPOs, and ACOs; TPA (Third Party Administrator) processes claims on behalf of self-insured employers; other includes specialty programs.. Valid values are `government|commercial|managed_care|tpa|other`',
    `claim_scrubbing_vendor` STRING COMMENT 'Name of the third-party claim scrubbing or editing vendor used to validate claims before submission to this payer. Null if no scrubbing vendor is used or if internal scrubbing is performed.',
    `claims_inquiry_phone` STRING COMMENT 'Dedicated phone number for claim status inquiries and claim-related questions. May differ from general customer service phone.',
    `claims_submission_endpoint` STRING COMMENT 'URL, EDI address, or mailing address for submitting claims to this payer. Format varies by submission method.',
    `clearinghouse_code` STRING COMMENT 'Identifier for the clearinghouse or intermediary used to submit claims to this payer. Null if claims are submitted directly to the payer.',
    `coordination_of_benefits_required` BOOLEAN COMMENT 'Indicates whether this payer requires coordination of benefits information when the patient has multiple insurance coverages. True if COB is required; false if payer does not coordinate benefits or is always primary.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payer record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_service_phone` STRING COMMENT 'Primary phone number for the payers provider customer service line. Used for claim status inquiries, eligibility verification, and general provider support.',
    `edi_payer_code` STRING COMMENT 'Payer identifier used in EDI transactions, typically the ISA06 qualifier value in X12 837 claim submissions and 835 remittance advice. May differ from NPI or external payer ID.',
    `electronic_funds_transfer_flag` BOOLEAN COMMENT 'Indicates whether payments from this payer are received via electronic funds transfer (EFT) directly to the organizations bank account. True if EFT is enabled; false if payments are received by check or other method.',
    `eligibility_verification_method` STRING COMMENT 'Primary method for verifying patient eligibility and benefits with this payer. EDI 270/271 indicates HIPAA-compliant electronic eligibility inquiry and response; portal indicates web-based lookup; phone indicates manual call to payer; real-time API indicates direct system integration.. Valid values are `edi_270_271|portal|phone|real_time_api`',
    `id_external` STRING COMMENT 'Payers own identifier for their organization, often used in their systems and communications. May be a CPID (Carrier Payer ID), plan code, or other payer-assigned identifier.',
    `inactivation_date` DATE COMMENT 'Date on which this payer record was marked inactive. Null if payer is currently active. Used for audit trail and historical analysis.',
    `inactivation_reason` STRING COMMENT 'Explanation for why this payer record was inactivated. Common reasons include contract termination, payer merger or acquisition, payer out of business, or duplicate record consolidation. Null if payer is active.',
    `payer_name` STRING COMMENT 'Full legal name of the insurance payer, health plan sponsor, or government program as registered with regulatory authorities. Used for contracts, claims submission, and legal correspondence.',
    `notes` STRING COMMENT 'Free-text field for internal notes about this payer, including special billing instructions, known issues, contact preferences, or other operational guidance for revenue cycle staff.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned to the payer organization by CMS. Used for HIPAA-compliant electronic transactions and provider enrollment. Type 2 NPI for organizational entities.. Valid values are `^[0-9]{10}$`',
    `payment_terms_days` STRING COMMENT 'Number of days within which the payer is contractually obligated to remit payment after claim adjudication. Common values are 14, 30, 45 days. Used for accounts receivable aging and cash flow forecasting.',
    `portal_url` STRING COMMENT 'Web address for the payers provider portal used for eligibility verification, claim status inquiry, prior authorization submission, and remittance download.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this payer generally requires prior authorization for certain services, procedures, or medications. True if prior authorization is required for at least some service categories; false if payer does not require prior authorization. Specific authorization rules are maintained in benefit plan configurations.',
    `provider_relations_email` STRING COMMENT 'Email address for the payers provider relations or network management team. Used for contract inquiries, credentialing issues, and provider communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `remittance_address_line1` STRING COMMENT 'First line of the payers remittance mailing address where paper checks and EOBs are sent. Includes street number and street name.',
    `remittance_address_line2` STRING COMMENT 'Second line of the payers remittance mailing address. Typically contains suite, floor, department, or other secondary address information. Null if not applicable.',
    `remittance_city` STRING COMMENT 'City name for the payers remittance mailing address.',
    `remittance_delivery_method` STRING COMMENT 'Method by which the payer delivers remittance advice. EDI 835 indicates electronic remittance advice via X12 835 transaction; ERA (Electronic Remittance Advice) is synonym for EDI 835; paper EOB (Explanation of Benefits) indicates physical mail; portal indicates download from payer website.. Valid values are `edi_835|era|paper_eob|portal`',
    `remittance_postal_code` STRING COMMENT 'ZIP code or ZIP+4 code for the payers remittance mailing address. Format: XXXXX or XXXXX-XXXX.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `remittance_state` STRING COMMENT 'Two-letter state or territory abbreviation for the payers remittance mailing address. Follows USPS state abbreviation standards.. Valid values are `^[A-Z]{2}$`',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the payer for display purposes in user interfaces and reports.',
    `submission_method` STRING COMMENT 'Primary method used to submit claims to this payer. EDI indicates electronic X12 837 transactions; portal indicates web-based submission through payer portal; direct indicates direct electronic connection; clearinghouse indicates submission through third-party clearinghouse; paper indicates physical mail submission.. Valid values are `edi|portal|direct|clearinghouse|paper`',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number for the payer organization. Used for tax reporting, contract execution, and financial reconciliation. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `tier` STRING COMMENT 'Internal classification of payer by volume, strategic importance, or contract terms. Tier 1 represents highest volume or most favorable contract terms; Tier 4 represents lowest volume or least favorable terms. Used for prioritization in revenue cycle operations and contract negotiations.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `timely_filing_limit_days` STRING COMMENT 'Number of days from date of service within which claims must be submitted to this payer to be considered timely filed. Claims submitted after this period may be denied. Common values are 90, 180, 365 days. Null if payer does not enforce timely filing limits.',
    `payer_type` STRING COMMENT 'Classification of the payer by program type. Determines billing rules, claim formats, and regulatory requirements. Commercial includes private insurance carriers and employer-sponsored plans; Medicare includes traditional Medicare and Medicare Advantage; Medicaid includes state Medicaid programs and managed Medicaid; CHIP is Childrens Health Insurance Program; TRICARE is military health system; workers compensation covers occupational injuries; self-pay represents uninsured patients. [ENUM-REF-CANDIDATE: commercial|medicare|medicaid|chip|tricare|workers_compensation|self_pay — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payer record was last modified. Updated whenever any attribute value changes. Used for change tracking and synchronization.',
    CONSTRAINT pk_payer PRIMARY KEY(`payer_id`)
) COMMENT 'Master record for every insurance payer, health plan sponsor, and government program (Medicare, Medicaid, CHIP, TRICARE, commercial carriers, TPAs) operating as a financial counterparty to the healthcare organization. SSOT for payer identity within the insurance domain, capturing payer legal name, payer ID (CPID, NPI), payer type (commercial, Medicare, Medicaid, self-pay, workers comp), EDI trading partner ID (ISA06), remittance address, claims submission endpoint (clearinghouse, direct), payer portal URL, payer tier classification, contract status, and effective dates. Distinct from reference.payer which is the enterprise-wide reference catalog — this is the operational master used by billing, claim, and encounter domains for active payer relationship management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan product. Primary key for the health plan entity.',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: Health plans define consent requirements specific to plan design (e.g., telehealth consent for virtual-first plans, genetic testing consent for genomic medicine benefits, research consent for value-ba',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Health plans define coverage restrictions by diagnosis code for medical necessity determination and benefit eligibility. Essential for claims adjudication and coverage policy enforcement in real-world',
    `formulary_id` BIGINT COMMENT 'Reference to the drug formulary tier structure that defines covered medications, tier placement, and cost-sharing for this plan.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that underwrites or administers this health plan.',
    `predecessor_health_plan_id` BIGINT COMMENT 'Self-referencing FK on health_plan (predecessor_health_plan_id)',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network that defines in-network and out-of-network providers, facilities, and pharmacies for this plan.',
    `benefit_year` STRING COMMENT 'The calendar year for which this plan configuration and benefit structure are effective. Used to track annual plan changes and benefit resets.',
    `cms_contract_number` STRING COMMENT 'The unique contract identifier assigned by CMS for Medicare Advantage, Medicare Part D, or Medicaid managed care plans. Used for regulatory reporting and plan identification.',
    `cob_order` STRING COMMENT 'The order in which this plan pays when a member has multiple insurance coverages. Primary pays first, Secondary pays after primary, Tertiary pays after secondary. Used for COB adjudication logic.. Valid values are `Primary|Secondary|Tertiary`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The percentage of allowed charges that the member is responsible for paying after the deductible is met. Expressed as a percentage (e.g., 20.00 for 20% member responsibility).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this health plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'The date on which this health plan configuration becomes active and available for member enrollment and coverage. Typically aligns with benefit year start or employer plan year start.',
    `emergency_room_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for an emergency department visit. May be waived if admitted. Null if the plan uses coinsurance instead of copay.',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'The annual deductible amount in USD that a family unit must collectively pay out-of-pocket before the plan begins cost-sharing for covered services.',
    `family_oop_max_amount` DECIMAL(18,2) COMMENT 'The annual maximum amount in USD that a family unit will collectively pay out-of-pocket for covered services. After reaching this limit, the plan pays 100% of covered costs for the remainder of the benefit year.',
    `fsa_eligible` BOOLEAN COMMENT 'Indicates whether this plan allows members to participate in a Flexible Spending Account for pre-tax healthcare or dependent care expenses.',
    `funding_type` STRING COMMENT 'The financial arrangement model for the plan. Fully Insured means the payer assumes all risk; Self-Funded means the employer assumes risk and payer provides administrative services only (ASO); Level Funded is a hybrid with predictable monthly costs; Partially Self-Funded shares risk between employer and payer.. Valid values are `Fully Insured|Self-Funded|Level Funded|Partially Self-Funded`',
    `group_number` STRING COMMENT 'The group identifier assigned to employer-sponsored or association-based plans, used for member eligibility verification and claims adjudication.',
    `hra_eligible` BOOLEAN COMMENT 'Indicates whether this plan is paired with an employer-funded Health Reimbursement Arrangement that reimburses employees for qualified medical expenses.',
    `hsa_eligible` BOOLEAN COMMENT 'Indicates whether this plan is HSA-qualified, meaning it meets IRS requirements for high-deductible health plans that allow members to contribute to a tax-advantaged Health Savings Account.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'The annual deductible amount in USD that an individual member must pay out-of-pocket before the plan begins cost-sharing for covered services.',
    `individual_oop_max_amount` DECIMAL(18,2) COMMENT 'The annual maximum amount in USD that an individual member will pay out-of-pocket for covered services. After reaching this limit, the plan pays 100% of covered costs for the remainder of the benefit year.',
    `inpatient_hospital_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays per inpatient hospital admission or per day. Null if the plan uses coinsurance instead of copay.',
    `issuer_state` STRING COMMENT 'The two-letter state code where this health plan is issued and regulated. Used for multi-state payers to track jurisdiction-specific plan configurations.',
    `metal_tier` STRING COMMENT 'The actuarial value tier for ACA (Affordable Care Act) marketplace plans indicating the percentage of covered healthcare costs the plan pays on average. Bronze (60%), Silver (70%), Gold (80%), Platinum (90%), Catastrophic (minimal coverage for under-30 or hardship exemption). Not Applicable for non-ACA plans.. Valid values are `Bronze|Silver|Gold|Platinum|Catastrophic|Not Applicable`',
    `open_enrollment_end_date` DATE COMMENT 'The last date of the annual open enrollment period during which eligible individuals can enroll in or change their health plan selection without a qualifying life event.',
    `open_enrollment_start_date` DATE COMMENT 'The first date of the annual open enrollment period during which eligible individuals can enroll in or change their health plan selection without a qualifying life event.',
    `out_of_network_coverage` BOOLEAN COMMENT 'Indicates whether this plan provides any coverage for out-of-network providers and facilities. True for PPO and POS plans, false for HMO and EPO plans (except emergency services).',
    `out_of_network_deductible_amount` DECIMAL(18,2) COMMENT 'The annual deductible amount in USD for out-of-network services. Typically higher than in-network deductible. Null if plan does not cover out-of-network services.',
    `out_of_network_oop_max_amount` DECIMAL(18,2) COMMENT 'The annual maximum out-of-pocket amount in USD for out-of-network services. Typically higher than in-network OOP max. Null if plan does not cover out-of-network services.',
    `plan_document_url` STRING COMMENT 'The web URL where the official plan document, Summary of Benefits and Coverage (SBC), or Evidence of Coverage (EOC) can be accessed by members and providers.',
    `plan_identifier` STRING COMMENT 'The externally-recognized unique identifier for this plan. May be HIOS (Health Insurance Oversight System) Plan ID for ACA marketplace plans, CMS contract number for Medicare Advantage or Part D plans, or state-assigned Medicaid plan ID.',
    `plan_name` STRING COMMENT 'The marketing or official name of the health plan product as presented to members and providers.',
    `plan_status` STRING COMMENT 'The current lifecycle status of the health plan. Active means the plan is currently offered and accepting enrollments; Suspended means temporarily unavailable; Terminated means no longer offered; Pending Approval means awaiting regulatory approval; Grandfathered means exempt from certain ACA requirements; Closed to New Enrollment means existing members can renew but new members cannot enroll.. Valid values are `Active|Suspended|Terminated|Pending Approval|Grandfathered|Closed to New Enrollment`',
    `plan_type` STRING COMMENT 'The structural type of the health plan indicating network and coverage model. HMO (Health Maintenance Organization) requires PCP and referrals; PPO (Preferred Provider Organization) allows out-of-network care; EPO (Exclusive Provider Organization) requires in-network only; POS (Point of Service) hybrid model; HDHP (High Deductible Health Plan) paired with HSA; Medicare Advantage (MA) for Medicare beneficiaries; Medicare Part D for prescription drug coverage; Medicaid Managed Care for state Medicaid programs; CHIP (Childrens Health Insurance Program); Self-Funded for employer-administered plans. [ENUM-REF-CANDIDATE: HMO|PPO|EPO|POS|HDHP|Medicare Advantage|Medicare Part D|Medicaid Managed Care|CHIP|Self-Funded — 10 candidates stripped; promote to reference product]',
    `prescription_tier1_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a Tier 1 (typically generic) prescription drug. Null if the plan uses coinsurance for pharmacy benefits.',
    `prescription_tier2_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a Tier 2 (typically preferred brand) prescription drug. Null if the plan uses coinsurance for pharmacy benefits.',
    `prescription_tier3_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a Tier 3 (typically non-preferred brand) prescription drug. Null if the plan uses coinsurance for pharmacy benefits.',
    `prescription_tier4_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a Tier 4 (typically specialty) prescription drug. Null if the plan uses coinsurance for pharmacy benefits.',
    `preventive_care_covered` BOOLEAN COMMENT 'Indicates whether preventive care services (annual physicals, immunizations, screenings) are covered at 100% with no member cost-sharing, as required by ACA for non-grandfathered plans.',
    `primary_care_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a primary care physician office visit. Null if the plan uses coinsurance instead of copay.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this plan requires prior authorization for certain services, procedures, or medications. When true, members or providers must obtain approval before services are rendered to ensure coverage.',
    `requires_pcp_selection` BOOLEAN COMMENT 'Indicates whether members are required to select and maintain a designated primary care physician. Typically true for HMO and POS plans, false for PPO and EPO plans.',
    `requires_referral_for_specialist` BOOLEAN COMMENT 'Indicates whether members must obtain a referral from their PCP before seeing a specialist. Typically true for HMO plans, false for PPO, EPO, and POS plans.',
    `service_area_description` STRING COMMENT 'A textual description of the geographic service area where this plan is available, typically defined by counties, ZIP codes, or metropolitan areas.',
    `specialist_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for a specialist physician office visit. Null if the plan uses coinsurance instead of copay.',
    `state_filing_number` STRING COMMENT 'The unique filing or approval number assigned by the state insurance department for this health plan product. Required for regulatory compliance and rate filings.',
    `termination_date` DATE COMMENT 'The date on which this health plan configuration is terminated and no longer available for coverage. Null for active plans with no planned termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this health plan record was last modified in the system. Used for audit trail and change tracking.',
    `urgent_care_copay_amount` DECIMAL(18,2) COMMENT 'The fixed dollar amount in USD that a member pays for an urgent care facility visit. Null if the plan uses coinsurance instead of copay.',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Master record for every specific health insurance plan product offered by a payer, including HMO, PPO, EPO, POS, HDHP, Medicare Advantage (MA), Medicare Part D, Medicaid managed care, CHIP, and self-funded employer plans. Captures plan name, plan ID (HIOS plan ID, CMS contract number, group number), plan type, metal tier (Bronze/Silver/Gold/Platinum for ACA plans), funding type (fully insured vs self-funded), benefit year, formulary tier, deductible structure, out-of-pocket maximum, copay/coinsurance schedule, coordination of benefits (COB) order rules, and plan effective/termination dates. SSOT for plan configuration referenced by benefit, network, and coverage entities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Unique identifier for the benefit component within a health plan. Primary key for the benefit master record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Benefits often require specific diagnoses for coverage (e.g., CGM for diabetes, PT for specific conditions). Medical necessity validation and claims auto-adjudication depend on diagnosis-benefit linka',
    `health_plan_id` BIGINT COMMENT 'Reference to the parent health plan that contains this benefit component. Links benefit to its plan container.',
    `parent_benefit_id` BIGINT COMMENT 'Self-referencing FK on benefit (parent_benefit_id)',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Benefits are defined by specific CPT procedures with associated copays, coinsurance, and authorization requirements. Core to claims adjudication engine and member cost-sharing calculation in every pay',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Benefits for DME, supplies, and non-physician services are defined by HCPCS codes. Essential for benefit determination, prior authorization rules, and claims payment calculation in healthcare payer op',
    `allowed_amount_basis` STRING COMMENT 'Method used to determine the allowed amount for benefit adjudication. Defines how the plan calculates the maximum payable amount for a service.. Valid values are `usual_customary_reasonable|medicare_rate|negotiated_rate|billed_charges`',
    `benefit_category` STRING COMMENT 'High-level classification of the healthcare service category covered by this benefit. [ENUM-REF-CANDIDATE: inpatient_hospital|outpatient_surgery|primary_care|specialist|emergency|mental_health|substance_use|preventive|durable_medical_equipment|home_health|hospice|vision|dental|pharmacy|rehabilitation|skilled_nursing — promote to reference product]',
    `benefit_code` STRING COMMENT 'Unique business identifier for the benefit component used in plan documentation, member communications, and adjudication rules. Externally visible code.. Valid values are `^[A-Z0-9]{3,20}$`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible is met. Expressed as percentage (e.g., 20.00 for 20%). Null if benefit uses copay instead of coinsurance.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the member pays per service or visit as defined by the benefit. Null if benefit uses coinsurance instead of copay.',
    `cost_sharing_tier` STRING COMMENT 'Actuarial value tier of the benefit indicating the percentage of costs the plan covers on average. Used for ACA marketplace plans.. Valid values are `bronze|silver|gold|platinum`',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the plan pays for this benefit. Expressed as percentage (e.g., 80.00 for 80% plan payment). Inverse of coinsurance_percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_limit_count` STRING COMMENT 'Maximum number of days covered per benefit period for services measured in days (e.g., 90 days skilled nursing facility per benefit period). Null if no day limit applies.',
    `day_limit_period` STRING COMMENT 'Time period over which the day limit count applies. Example: per_admission for inpatient stays, per_year for annual day limits.. Valid values are `per_admission|per_year|per_lifetime`',
    `days_supply_limit` STRING COMMENT 'Maximum number of days supply allowed per prescription fill for pharmacy benefits. Common limits are 30, 60, or 90 days. Null if not applicable.',
    `deductible_applies_flag` BOOLEAN COMMENT 'Indicates whether the plan deductible must be met before this benefit pays. True if deductible applies, False if benefit is not subject to deductible (e.g., preventive services).',
    `benefit_description` STRING COMMENT 'Detailed narrative description of the benefit coverage, limitations, and member responsibilities. Used in Summary of Benefits and Coverage (SBC) and member materials.',
    `diagnosis_code_type` STRING COMMENT 'Type of diagnosis coding system used for medical necessity determination and benefit eligibility. ICD-10-CM is current standard in US; ICD-9-CM is legacy.. Valid values are `ICD10CM|ICD9CM`',
    `dollar_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount the plan will pay for this benefit per limit period. Null if no dollar limit applies. Note: ACA prohibits lifetime and annual dollar limits on essential health benefits.',
    `dollar_limit_period` STRING COMMENT 'Time period over which the dollar limit amount applies. Used for non-essential benefits where dollar limits are permitted.. Valid values are `per_visit|per_day|per_year|per_lifetime`',
    `effective_date` DATE COMMENT 'Date when this benefit component becomes active and available for coverage. Must align with plan year or mid-year plan changes.',
    `essential_health_benefit_flag` BOOLEAN COMMENT 'Indicates whether this benefit is classified as an Essential Health Benefit under ACA. EHBs cannot have annual or lifetime dollar limits.',
    `exclusions_text` STRING COMMENT 'Narrative description of services or conditions explicitly excluded from this benefit. Critical for claims denial and member communication.',
    `formulary_tier` STRING COMMENT 'Pharmacy formulary tier for drug benefits indicating cost-sharing level. Tier 1 typically generic, Tier 2 preferred brand, Tier 3 non-preferred brand, Tier 4 specialty drugs.. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty`',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit is compatible with Health Savings Account (HSA) requirements. True if benefit meets HSA-qualified high-deductible health plan (HDHP) rules.',
    `limitations_text` STRING COMMENT 'Narrative description of limitations, restrictions, or conditions that apply to this benefit beyond the structured limit fields.',
    `mail_order_available_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy benefit can be fulfilled through mail order pharmacy with potentially different cost-sharing. True if mail order option available.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit record was last modified. Updated whenever any attribute changes. Used for change tracking and audit compliance.',
    `benefit_name` STRING COMMENT 'Human-readable name of the benefit component displayed to members and providers. Example: Inpatient Hospital Services, Primary Care Office Visit.',
    `network_type` STRING COMMENT 'Indicates whether this benefit applies to in-network providers, out-of-network providers, or both. Critical for cost-sharing calculation and provider network adjudication.. Valid values are `in_network|out_of_network|both`',
    `out_of_pocket_applies_flag` BOOLEAN COMMENT 'Indicates whether member cost-sharing for this benefit counts toward the annual out-of-pocket maximum. True if it counts, False if excluded (e.g., non-covered services).',
    `place_of_service_code` STRING COMMENT 'Standard two-digit code identifying where the service is delivered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Room). Used for benefit adjudication rules.. Valid values are `^[0-9]{2}$`',
    `preventive_care_flag` BOOLEAN COMMENT 'Indicates whether this benefit is classified as preventive care under ACA requirements. Preventive services must be covered at 100% with no cost-sharing when delivered in-network.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the health plan is required before the service is covered. True if PA required, False otherwise.',
    `procedure_code_type` STRING COMMENT 'Type of procedure coding system used to identify services covered by this benefit. CPT for physician services, HCPCS for supplies and equipment, ICD-10-PCS for inpatient procedures, CDT for dental.. Valid values are `CPT|HCPCS|ICD10PCS|CDT|revenue_code`',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether this benefit has quantity or frequency limits (e.g., maximum number of visits, days supply, units per fill). True if limits apply.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether a referral from Primary Care Physician (PCP) is required to access this benefit. Common in Health Maintenance Organization (HMO) plans.',
    `service_type_code` STRING COMMENT 'Standard code identifying the type of healthcare service covered by this benefit. Aligns with X12 837 claim service type codes for electronic transactions.. Valid values are `^[0-9]{2}$`',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the benefit component. Active benefits are available for adjudication; inactive benefits are historical or discontinued.. Valid values are `active|inactive|suspended|pending_approval`',
    `step_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether step therapy protocol must be followed (trying lower-cost alternatives before higher-cost treatments). Primarily used for pharmacy benefits.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the benefit category providing granular service classification. Example: Acute Inpatient, Observation Stay, Ambulatory Surgery.',
    `termination_date` DATE COMMENT 'Date when this benefit component is no longer active. Null for currently active benefits with no planned end date.',
    `tier` STRING COMMENT 'Tiering level of the benefit indicating cost-sharing structure. Commonly used for pharmacy benefits (generic, preferred brand, non-preferred brand, specialty) and provider networks (in-network tier 1, tier 2).. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty`',
    `visit_limit_count` STRING COMMENT 'Maximum number of visits or services allowed per benefit period (e.g., 20 physical therapy visits per year). Null if no visit limit applies.',
    `visit_limit_period` STRING COMMENT 'Time period over which the visit limit count applies. Example: per_year for annual limits, per_lifetime for lifetime maximums.. Valid values are `per_day|per_week|per_month|per_year|per_lifetime`',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Master record defining individual benefit components within a health plan, representing the specific coverage rules for a category of healthcare services. Captures benefit category (inpatient hospital, outpatient surgery, primary care, specialist, emergency, mental health, substance use, preventive, DME, home health, hospice, vision, dental, pharmacy), benefit tier, in-network vs out-of-network rules, prior authorization requirement flag, referral requirement flag, copay amount, coinsurance percentage, deductible applicability, benefit limit (visit limits, dollar limits, day limits), and benefit effective dates. Enables granular benefit adjudication and member cost-sharing calculation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network. Primary key.',
    `network_id` BIGINT COMMENT 'Business identifier for the provider network, used externally by payers, providers, and members. May be referenced on insurance cards and claim submissions.',
    `parent_network_provider_network_id` BIGINT COMMENT 'Identifier of the parent or umbrella network if this network is a subset or regional variant. Used for hierarchical network structures where a national network has regional sub-networks. Null for top-level networks.',
    `parent_provider_network_id` BIGINT COMMENT 'Self-referencing FK on provider_network (parent_provider_network_id)',
    `payer_id` BIGINT COMMENT 'Identifier of the payer or health plan that owns and manages this provider network.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the network as a whole has capacity to accept new members. True if sufficient providers are accepting new patients. False if network is at capacity. Used for enrollment management.',
    `adequacy_review_date` DATE COMMENT 'Date of the most recent network adequacy assessment by CMS or state regulators. Networks must be reviewed annually or when material changes occur.',
    `behavioral_health_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes behavioral health and mental health providers. True if behavioral health services are covered. False if behavioral health is carved out to a separate network.',
    `cms_approval_date` DATE COMMENT 'Date when CMS approved the network adequacy filing. Null if not yet approved or not required.',
    `cms_filing_date` DATE COMMENT 'Date when the network adequacy filing was submitted to CMS. Required for Medicare Advantage and Marketplace plans.',
    `cms_filing_status` STRING COMMENT 'Status of the network adequacy filing with CMS for Medicare Advantage or Marketplace plans. Filed indicates submission. Approved indicates CMS acceptance. Rejected indicates CMS denial. Pending indicates under CMS review. Not required for non-CMS regulated plans.. Valid values are `filed|approved|rejected|pending|not_required`',
    `contract_type` STRING COMMENT 'Payment model used for provider contracts in this network. Fee-for-service pays per service. Capitation pays per member per month. Shared savings shares cost savings with providers. Bundled payment pays fixed amount for episode of care. Value-based ties payment to quality and outcomes. Hybrid combines multiple models.. Valid values are `fee_for_service|capitation|shared_savings|bundled_payment|value_based|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this provider network record was first created in the system. Used for audit trail and data lineage.',
    `credentialing_standard` STRING COMMENT 'Accreditation or regulatory standard used for provider credentialing in this network. NCQA (National Committee for Quality Assurance) is most common. URAC is utilization review accreditation. AAAHC (Accreditation Association for Ambulatory Health Care) for ambulatory settings. TJC (The Joint Commission) for hospitals. State-specific for state-mandated standards. Internal for payer-defined standards.. Valid values are `NCQA|URAC|AAAHC|TJC|state_specific|internal`',
    `dental_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes dental providers or if dental benefits are managed separately. True if dental is included. False if dental is carved out.',
    `directory_last_updated_date` DATE COMMENT 'Date when the provider directory was last updated with current network participation information. CMS requires directories to be updated at least monthly.',
    `effective_date` DATE COMMENT 'Date when the provider network becomes active and available for member enrollment and claim adjudication. Must align with plan year or regulatory approval dates.',
    `facility_count` STRING COMMENT 'Total number of facilities (hospitals, clinics, surgery centers, imaging centers) participating in this network. Used for network adequacy assessment and member communications.',
    `geographic_service_area` STRING COMMENT 'Geographic region where the provider network operates, defined by state, county, ZIP code, or metropolitan statistical area. Used for network adequacy assessment and member eligibility determination.',
    `network_adequacy_status` STRING COMMENT 'Assessment of whether the provider network meets regulatory standards for provider availability, geographic access, and appointment wait times. Adequate networks meet all standards. Inadequate networks require corrective action. Conditionally adequate networks meet standards with exceptions.. Valid values are `adequate|inadequate|pending_review|conditionally_adequate|exempt`',
    `network_description` STRING COMMENT 'Detailed description of the provider network, including key features, geographic coverage, specialty availability, and member benefits. Used in plan marketing materials and member communications.',
    `network_directory_url` STRING COMMENT 'Web address of the online provider directory for this network. Members use this to search for in-network providers. Required by CMS for Medicare Advantage and Marketplace plans.',
    `network_model` STRING COMMENT 'Organizational structure of the provider network. Staff model employs providers directly. Group model contracts with multi-specialty groups. Network model contracts with multiple IPAs. IPA (Independent Practice Association) is a physician-owned network. Direct contract is payer-to-provider agreements. Rental network leases access to another payers network.. Valid values are `staff_model|group_model|network_model|IPA|direct_contract|rental_network`',
    `network_name` STRING COMMENT 'Human-readable name of the provider network, used in member communications, plan documents, and provider directories.',
    `network_status` STRING COMMENT 'Current lifecycle status of the provider network. Active networks are available for member enrollment and claim adjudication. Pending networks are under development or regulatory review. Suspended networks are temporarily unavailable. Terminated networks are closed and no longer accepting new members.. Valid values are `active|inactive|pending|suspended|terminated`',
    `network_tier` STRING COMMENT 'Tier classification of the network for cost-sharing purposes. Preferred or Tier 1 networks offer lowest member cost-sharing. Standard or Tier 2 networks have moderate cost-sharing. Out-of-network or Tier 3 have highest cost-sharing. Used in tiered network benefit designs.. Valid values are `preferred|standard|out_of_network|tier_1|tier_2|tier_3`',
    `network_type` STRING COMMENT 'Classification of the provider network structure. HMO (Health Maintenance Organization) requires PCP referrals and in-network care. PPO (Preferred Provider Organization) allows out-of-network care at higher cost. EPO (Exclusive Provider Organization) requires in-network care except emergencies. POS (Point of Service) combines HMO and PPO features. ACO (Accountable Care Organization) is a value-based network. Narrow network limits provider choice for lower premiums. Tiered network assigns cost-sharing levels by provider performance. [ENUM-REF-CANDIDATE: HMO|PPO|EPO|POS|ACO|narrow_network|tiered_network|exclusive_network|open_network — 9 candidates stripped; promote to reference product]',
    `pcp_count` STRING COMMENT 'Total number of primary care physicians in this network. Critical metric for HMO and POS networks that require PCP selection. Used for network adequacy assessment.',
    `pharmacy_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes pharmacy providers or if pharmacy benefits are managed separately. True if pharmacy is included. False if pharmacy is carved out.',
    `provider_count` STRING COMMENT 'Total number of individual providers (physicians, specialists, allied health professionals) participating in this network. Used for network adequacy assessment and member communications.',
    `quality_tier_methodology` STRING COMMENT 'Description of the methodology used to assign providers to quality or performance tiers within this network. May reference HEDIS measures, patient satisfaction scores, cost efficiency, or clinical outcomes. Used in tiered network designs.',
    `recredentialing_cycle_months` STRING COMMENT 'Number of months between provider recredentialing reviews. Typically 24 or 36 months per NCQA standards. Used to schedule provider credential verification and quality reviews.',
    `risk_arrangement` STRING COMMENT 'Financial risk-sharing arrangement between payer and network providers. Full risk transfers all financial risk to providers. Shared risk splits risk between payer and providers. Upside only allows providers to share savings but not losses. Downside risk requires providers to cover losses. No risk is traditional fee-for-service.. Valid values are `full_risk|shared_risk|upside_only|downside_risk|no_risk`',
    `service_area_type` STRING COMMENT 'Classification of the geographic service area scope. Statewide covers entire state. Regional covers multiple counties or regions. County covers specific counties. ZIP code covers specific ZIP codes. MSA (Metropolitan Statistical Area) covers census-defined metro areas. National covers multiple states or entire country.. Valid values are `statewide|regional|county|zip_code|msa|national`',
    `specialist_count` STRING COMMENT 'Total number of specialist physicians in this network. Used for network adequacy assessment and member communications.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether this network includes telehealth or virtual care providers. True if telehealth services are available. False if only in-person care is covered.',
    `termination_date` DATE COMMENT 'Date when the provider network is terminated and no longer available for new member enrollment. Existing members may have a transition period. Null for open-ended networks.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this provider network record was last modified. Used for audit trail and change tracking.',
    `vision_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes vision providers or if vision benefits are managed separately. True if vision is included. False if vision is carved out.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Master record for every provider network defined and managed by a payer, representing the contracted network of providers available to plan members. Captures network name, network ID, network type (HMO, PPO, EPO, narrow network, tiered network, ACO network), geographic service area, network tier (preferred, standard, out-of-network), network effective and termination dates, network adequacy status, CMS network adequacy filing status, and the payer that owns the network. SSOT for network identity referenced by plan-network associations, provider participation records, and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` (
    `insurance_network_participation_id` BIGINT COMMENT 'Unique identifier for the network participation record. Primary key for this entity.',
    `clinician_id` BIGINT COMMENT 'Reference to the provider (individual clinician or organizational provider) participating in the network.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Payers credential facilities (hospitals, surgery centers) for network participation independent of individual clinicians. Network status determines claim payment rates, prior authorization requirement',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule or rate table that defines reimbursement amounts for services provided under this network participation.',
    `payer_contract_id` BIGINT COMMENT 'The payers contract number or identifier governing the terms of this network participation. Links to the master provider-payer contract.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan sponsoring the network.',
    `prior_insurance_network_participation_id` BIGINT COMMENT 'Self-referencing FK on insurance_network_participation (prior_insurance_network_participation_id)',
    `provider_location_id` BIGINT COMMENT 'Reference to the primary service location or facility where the provider delivers care under this network participation. A provider may have multiple participation records for different locations.',
    `provider_network_id` BIGINT COMMENT 'Reference to the payer network in which the provider is participating.',
    `provider_payer_enrollment_id` BIGINT COMMENT 'Reference to the payer enrollment record that initiated this network participation. Tracks the enrollment application and approval workflow.',
    `accepting_new_patients` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients through this network participation. Used for member directory and referral management.',
    `attribution_eligible` BOOLEAN COMMENT 'Indicates whether the provider is eligible to have patients attributed to them for value-based payment programs, ACO arrangements, or population health management.',
    `claims_submission_method` STRING COMMENT 'The method by which the provider submits claims to the payer under this network participation.. Valid values are `electronic|paper|clearinghouse|direct`',
    `contracted_specialty` STRING COMMENT 'The primary medical specialty or service line under which the provider is contracted to participate in the network. May differ from the providers board certification if contracted for specific services.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this network participation record was first created in the system.',
    `credentialing_date` DATE COMMENT 'The date on which the payer approved the providers credentials for network participation.',
    `credentialing_status` STRING COMMENT 'The status of the providers credentialing process with the payer. Approved status is required before participation can become active.. Valid values are `approved|pending|expired|denied|in_review|recredentialing`',
    `directory_listing_name` STRING COMMENT 'The name of the provider as it should appear in member-facing provider directories and network listings. May differ from legal name for clarity or branding.',
    `directory_visible` BOOLEAN COMMENT 'Indicates whether this network participation should be visible in public provider directories and member portals. May be false for closed panels or restricted networks.',
    `effective_date` DATE COMMENT 'The date on which the providers participation in the network became or will become active. Used to determine in-network eligibility for claims adjudication.',
    `exclusion_screening_date` DATE COMMENT 'The date on which the provider was last screened against federal and state exclusion lists (OIG LEIE, SAM, state Medicaid exclusions). Required monthly per CMS guidelines.',
    `exclusion_status` STRING COMMENT 'The result of the most recent exclusion screening. Excluded providers must be immediately terminated from network participation.. Valid values are `clear|excluded|pending_review`',
    `network_adequacy_category` STRING COMMENT 'The provider category used for network adequacy reporting and compliance. Ensures the network meets regulatory requirements for provider access.. Valid values are `primary_care|specialty|hospital|ancillary|behavioral_health|dental`',
    `network_participation_type` STRING COMMENT 'Indicates whether this participation record represents an individual clinician, a provider group, a facility, or another organizational arrangement.. Valid values are `individual|group|facility|ancillary|hospital_based`',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS to the participating provider. Used for claims submission and network verification.. Valid values are `^[0-9]{10}$`',
    `panel_status` STRING COMMENT 'Indicates the current capacity status of the providers patient panel. Closed or full panels may not accept new patient assignments.. Valid values are `open|closed|limited|full`',
    `participation_status` STRING COMMENT 'Current lifecycle status of the providers participation in the network. Active indicates the provider is currently in-network and eligible for in-network reimbursement rates.. Valid values are `active|pending|terminated|suspended|credentialing|inactive`',
    `participation_tier` STRING COMMENT 'The tier or level of the provider within the network, indicating reimbursement rates and patient cost-sharing levels. Preferred tier typically offers lower patient cost-sharing.. Valid values are `preferred|standard|tiered|narrow|broad`',
    `payer_provider_number` STRING COMMENT 'The unique provider identifier assigned by the payer for this network participation. Used on claims and remittance advice. May differ from NPI.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether services from this provider under this network participation require prior authorization from the payer before rendering care.',
    `quality_tier` STRING COMMENT 'The quality performance tier assigned to the provider by the payer based on quality metrics, outcomes, and patient satisfaction. May affect reimbursement rates and patient cost-sharing.. Valid values are `tier_1|tier_2|tier_3|high_performance|standard|not_rated`',
    `recredentialing_due_date` DATE COMMENT 'The date by which the provider must complete recredentialing to maintain active network participation status. Typically occurs every 2-3 years per NCQA standards.',
    `reimbursement_method` STRING COMMENT 'The payment methodology used by the payer to reimburse the provider for services rendered under this network participation.. Valid values are `fee_for_service|capitation|bundled|value_based|per_diem|case_rate`',
    `risk_arrangement` STRING COMMENT 'The type of financial risk-sharing arrangement between the provider and payer under this network participation, if applicable. Common in ACO and value-based contracts.. Valid values are `none|shared_savings|shared_risk|full_risk|upside_only|two_sided`',
    `specialty_code` STRING COMMENT 'Standardized code representing the contracted specialty, typically using taxonomy codes or payer-specific specialty classification.',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the provider is authorized to deliver telehealth services under this network participation.',
    `termination_date` DATE COMMENT 'The date on which the providers participation in the network ended or will end. Null for active ongoing participation. Used to determine out-of-network status for claims adjudication.',
    `termination_reason` STRING COMMENT 'Free-text or coded reason for termination of network participation, if applicable. Examples include provider request, quality issues, credentialing failure, or contract expiration.',
    `termination_reason_code` STRING COMMENT 'Standardized code representing the reason for termination of network participation. Used for analytics and regulatory reporting. [ENUM-REF-CANDIDATE: provider_request|quality_issue|credential_failure|contract_expiration|mutual_agreement|for_cause|network_redesign — 7 candidates stripped; promote to reference product]',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this record. Used for audit trail and data governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this network participation record was last modified.',
    CONSTRAINT pk_insurance_network_participation PRIMARY KEY(`insurance_network_participation_id`)
) COMMENT 'Association record linking individual clinicians and organizational providers to a specific payer network, capturing the full participation lifecycle. Records provider NPI, network ID, payer ID, participation status (active, pending, terminated, suspended), effective date, termination date, participation tier (preferred, standard), credentialing status with payer, contracted specialty, service location(s) covered under participation, and the payer enrollment record reference. Enables in-network vs out-of-network determination at claim adjudication and supports network adequacy reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` (
    `plan_network_id` BIGINT COMMENT 'Unique identifier for the plan-network association record. Primary key.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan participating in this network association. Links to the health plan master record.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network associated with this plan. Links to the provider network master record.',
    `superseded_plan_network_id` BIGINT COMMENT 'Self-referencing FK on plan_network (superseded_plan_network_id)',
    `auto_assignment_eligible` BOOLEAN COMMENT 'Indicates whether members can be automatically assigned to providers within this network when no explicit selection is made. Used in HMO (Health Maintenance Organization) and POS (Point of Service) plan configurations.',
    `claims_processing_priority` STRING COMMENT 'Priority level for processing claims from this network within the plan. Lower numbers indicate higher priority for adjudication workflows.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Default coinsurance percentage that members pay for services within this network under the plan. Expressed as a percentage (e.g., 20.00 for 20% member responsibility).',
    `contract_number` STRING COMMENT 'Contract or agreement number governing the relationship between the health plan and the provider network. Used for contract management and financial reconciliation.',
    `copay_tier_code` STRING COMMENT 'Code identifying the copayment tier structure applicable to this network within the plan. Links to benefit copay schedules for member cost-sharing calculations.',
    `county_code` STRING COMMENT 'Five-digit FIPS county code for granular geographic applicability of the plan-network association.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this plan-network association record was first created in the system. Used for audit trails and data lineage tracking.',
    `deductible_applies` BOOLEAN COMMENT 'Indicates whether the plan deductible applies to services rendered within this network. Some plan designs waive deductibles for preferred network tiers.',
    `effective_date` DATE COMMENT 'Date when this plan-network association becomes active and available to plan members for benefit determination.',
    `filing_reference_number` STRING COMMENT 'Reference number assigned by the regulatory authority for the filing of this plan-network association. Used for compliance tracking and audit trails.',
    `geographic_region` STRING COMMENT 'Geographic region or service area where this network is applicable for the plan. May include state, county, or custom region codes.',
    `member_communication_required` BOOLEAN COMMENT 'Indicates whether plan members must be notified about this network association or changes to it. Used for regulatory compliance with member notification requirements.',
    `network_adequacy_certification_date` DATE COMMENT 'Date when network adequacy certification was granted for this plan-network association. Used for regulatory reporting and compliance tracking.',
    `network_adequacy_certified` BOOLEAN COMMENT 'Indicates whether this network has been certified as meeting network adequacy standards for the plan service area. Required for CMS (Centers for Medicare and Medicaid Services) and state regulatory compliance.',
    `network_priority` STRING COMMENT 'Numeric priority ranking of this network within the plan when multiple networks are available. Lower numbers indicate higher priority for benefit determination.',
    `network_role` STRING COMMENT 'Role or function of this network within the plan structure. Indicates whether the network serves as the primary, secondary, or specialized network for plan members.. Valid values are `primary|secondary|tertiary|out_of_area|specialty|behavioral_health`',
    `network_tier` STRING COMMENT 'Tier designation of the network within the plan benefit structure. Determines member cost-sharing levels and benefit coverage percentages.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `network_type` STRING COMMENT 'Type of network model used in this plan-network association. HMO (Health Maintenance Organization), PPO (Preferred Provider Organization), EPO (Exclusive Provider Organization), POS (Point of Service), HDHP (High Deductible Health Plan). [ENUM-REF-CANDIDATE: hmo|ppo|epo|pos|hdhp|medicare_advantage|medicaid_managed_care — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments about this plan-network association. Used for documenting special configurations, exceptions, or business context.',
    `out_of_network_coverage` BOOLEAN COMMENT 'Indicates whether the plan provides any coverage for services rendered by providers outside this network. Supports PPO (Preferred Provider Organization) and POS (Point of Service) plan designs.',
    `out_of_pocket_max_applies` BOOLEAN COMMENT 'Indicates whether member cost-sharing for services in this network counts toward the plan out-of-pocket maximum. Critical for Affordable Care Act (ACA) compliance.',
    `pcp_selection_required` BOOLEAN COMMENT 'Indicates whether members enrolled in this plan-network combination must select a Primary Care Physician (PCP) from the network.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether specialist referrals are required for members using this network under the plan. Common in HMO (Health Maintenance Organization) configurations.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this plan-network association requires filing with state insurance departments or CMS (Centers for Medicare and Medicaid Services) for approval.',
    `reimbursement_method` STRING COMMENT 'Primary reimbursement methodology used for providers in this network under the plan. DRG (Diagnosis-Related Group) for inpatient, fee-for-service, capitation, or value-based arrangements.. Valid values are `fee_for_service|capitation|bundled_payment|value_based|drg|per_diem`',
    `state_code` STRING COMMENT 'Two-letter state code where this plan-network association is active. Supports multi-state plan configurations.. Valid values are `^[A-Z]{2}$`',
    `plan_network_status` STRING COMMENT 'Current lifecycle status of the plan-network association. Indicates whether the association is currently in effect for benefit determination and claim adjudication.. Valid values are `active|inactive|pending|suspended|terminated`',
    `termination_date` DATE COMMENT 'Date when this plan-network association ends. Null indicates an open-ended association with no planned termination.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this record. Supports audit trail requirements and change management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this plan-network association record was last modified. Used for change tracking and audit compliance.',
    CONSTRAINT pk_plan_network PRIMARY KEY(`plan_network_id`)
) COMMENT 'Association record linking a health plan to one or more provider networks, defining which networks are available to members enrolled in a given plan. Captures plan ID, network ID, network role (primary, secondary, out-of-area), geographic region applicability, effective date, termination date, and network tier designation within the plan. Supports multi-network plan configurations (e.g., tiered PPO with preferred and standard networks) and enables accurate in-network benefit determination during claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` (
    `coverage_policy_id` BIGINT COMMENT 'Unique identifier for the coverage policy record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Payer coverage policies must align with organizational compliance policies governing experimental treatment, off-label use, investigational devices, and regulatory coverage requirements. This linkage ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Coverage policies define medical necessity criteria for specific CPT procedures. Current text field applicable_cpt_codes should be normalized to proper FK for policy enforcement, prior authorization',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Coverage policies define payment rules and authorization requirements for specific DRGs in inpatient settings. Critical for bundled payment administration, outlier payment calculation, and hospital co',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Coverage policies govern HCPCS code reimbursement and authorization requirements. Denormalized text field applicable_hcpcs_codes should be proper FK for policy administration, utilization management',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan under which this coverage policy applies.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Coverage policies specify diagnosis criteria for medical necessity. Text field applicable_icd10_codes should be normalized FK for automated policy evaluation, clinical documentation requirements, an',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan that owns this coverage policy.',
    `primary_superseded_by_coverage_policy_id` BIGINT COMMENT 'Reference to the coverage policy that replaces this policy when it is retired or superseded. Nullable if the policy is still active or has not been replaced.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: Coverage policies define consent documentation requirements for specific procedures/services (e.g., sterilization consent, experimental treatment consent). Medical policy enforcement requires linking ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Medical policies define coverage criteria by specialty (e.g., orthopedic surgery criteria, cardiology device policies). Essential for claims adjudication, medical necessity determination, and specialt',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: Coverage policies reference taxonomy codes for provider type restrictions (e.g., only board-certified surgeons, only licensed clinical psychologists). Critical for claims auto-adjudication and provide',
    `age_restrictions` STRING COMMENT 'Age-based limitations or requirements for coverage under this policy (e.g., covered for patients 18 years and older, pediatric use only).',
    `appeals_allowed` BOOLEAN COMMENT 'Indicates whether coverage denials based on this policy can be appealed by the provider or patient. True = appeals allowed; False = no appeals allowed.',
    `appeals_process_description` STRING COMMENT 'Detailed description of the appeals process for coverage denials based on this policy, including timelines, required documentation, and contact information.',
    `clinical_evidence_source` STRING COMMENT 'Reference to the clinical evidence, guidelines, or literature that supports the coverage determination (e.g., NCCN Guidelines, FDA approval, peer-reviewed clinical trial).',
    `coverage_determination` STRING COMMENT 'Final determination of whether the service, procedure, or technology is covered under this policy. Covered = reimbursable; Non-Covered = not reimbursable; Conditional = covered only if specific criteria met; Investigational/Experimental = not covered due to lack of evidence; Not Medically Necessary = does not meet medical necessity criteria.. Valid values are `covered|non_covered|conditional|investigational|experimental|not_medically_necessary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage policy record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the coverage policy becomes active and enforceable for claims adjudication and prior authorization decisions.',
    `exclusions` STRING COMMENT 'Specific services, procedures, diagnoses, or circumstances that are explicitly excluded from coverage under this policy.',
    `expiration_date` DATE COMMENT 'Date on which the coverage policy ceases to be active. Nullable for policies with no defined end date.',
    `frequency_limitations` STRING COMMENT 'Limitations on how often the service or procedure can be performed and reimbursed within a specified time period (e.g., once per calendar year, maximum 12 visits per year).',
    `gender_restrictions` STRING COMMENT 'Gender-based limitations or requirements for coverage under this policy (e.g., female patients only, male patients only, no gender restrictions).',
    `last_updated_date` DATE COMMENT 'Date when the coverage policy was last modified or revised.',
    `medical_necessity_criteria` STRING COMMENT 'Clinical criteria defining when the service or procedure is considered medically necessary and therefore eligible for coverage under this policy.',
    `network_restrictions` STRING COMMENT 'Indicates whether the service or procedure must be performed by an in-network provider to be covered. In-Network Only = only in-network providers eligible; Out-of-Network Allowed = both in-network and out-of-network providers eligible (may have different reimbursement); No Restriction = network status does not affect coverage.. Valid values are `in_network_only|out_of_network_allowed|no_restriction`',
    `place_of_service_restrictions` STRING COMMENT 'Restrictions on where the service or procedure can be performed to be eligible for coverage (e.g., inpatient hospital only, outpatient facility or office, home health setting).',
    `policy_approval_date` DATE COMMENT 'Date on which the coverage policy was formally approved by the payers medical policy committee or equivalent governance body.',
    `policy_approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved the coverage policy.',
    `policy_category` STRING COMMENT 'High-level categorization of the coverage policy by clinical domain or service type (e.g., Radiology, Pharmacy, Surgical Procedures, Durable Medical Equipment).',
    `policy_description` STRING COMMENT 'Detailed narrative description of the coverage policy, including the clinical rationale, scope of coverage, and any special conditions or limitations.',
    `policy_number` STRING COMMENT 'Externally-known unique identifier for the coverage policy, used in prior authorization and claims adjudication workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for maintaining and updating this coverage policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the coverage policy. Active = in effect and enforceable; Inactive = temporarily suspended; Draft = not yet finalized; Under Review = being evaluated or updated; Retired = no longer in use; Superseded = replaced by a newer policy version.. Valid values are `active|inactive|draft|under_review|retired|superseded`',
    `policy_title` STRING COMMENT 'Human-readable title or name of the coverage policy, describing the service or condition covered.',
    `policy_type` STRING COMMENT 'Classification of the coverage policy. Medical Policy = internal payer medical necessity policy; Coverage Determination = specific coverage decision; LCD = Local Coverage Determination (Medicare contractor-specific); NCD = National Coverage Determination (CMS national policy); Administrative Policy = non-clinical coverage rule; Clinical Guideline = evidence-based clinical criteria.. Valid values are `medical_policy|coverage_determination|lcd|ncd|administrative_policy|clinical_guideline`',
    `policy_version` STRING COMMENT 'Version number of the coverage policy, used to track revisions and updates over time (e.g., 1.0, 2.3).. Valid values are `^[0-9]+.[0-9]+$`',
    `prior_authorization_criteria` STRING COMMENT 'Detailed clinical and administrative criteria that must be met to obtain prior authorization for the service or procedure covered by this policy.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required before the service or procedure can be performed and reimbursed under this policy. True = prior authorization required; False = no prior authorization required.',
    `provider_specialty_restrictions` STRING COMMENT 'Restrictions on which provider specialties are authorized to perform the service or procedure under this policy (e.g., board-certified cardiologist only, licensed physical therapist).',
    `quantity_limitations` STRING COMMENT 'Limitations on the quantity or dosage of the service, supply, or medication that can be provided and reimbursed under this policy (e.g., maximum 30-day supply, up to 10 units per month).',
    `regulatory_basis` STRING COMMENT 'Reference to the regulatory or statutory basis for the coverage policy (e.g., CMS NCD 210.1, State Medicaid Manual Section 4.5, ACA Essential Health Benefits).',
    `review_date` DATE COMMENT 'Scheduled date for the next policy review or update cycle, ensuring the policy remains aligned with current clinical evidence and regulatory requirements.',
    `step_therapy_criteria` STRING COMMENT 'Detailed criteria defining the step therapy requirements, including which treatments must be tried first and the conditions under which step therapy can be bypassed.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of less expensive or less invasive treatments first) is required before the service or procedure is covered. True = step therapy required; False = no step therapy required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage policy record was last updated in the system.',
    CONSTRAINT pk_coverage_policy PRIMARY KEY(`coverage_policy_id`)
) COMMENT 'Master record for payer coverage policies and medical policies governing whether specific services, procedures, diagnoses, or technologies are covered under a health plan. Captures policy number, policy title, policy type (medical policy, coverage determination, LCD — Local Coverage Determination, NCD — National Coverage Determination), covered/non-covered determination, applicable CPT/HCPCS codes, applicable ICD-10 diagnosis codes, prior authorization requirements, clinical criteria (medical necessity criteria, step therapy requirements), effective date, and review/expiration date. SSOT for coverage rules referenced during prior authorization and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment record. Primary key for this transactional enrollment entity.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the members assigned primary care physician. Required for HMO and POS plans.',
    `compliance_policy_id` BIGINT COMMENT 'Policy identifier assigned by the health insurance exchange for marketplace enrollments. Used for reconciliation with exchange data.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the specific health plan product the member is enrolled in. Links to the health plan master record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the member (subscriber or dependent) enrolled in the health plan. Links to the member master record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer or health plan organization providing coverage. Links to the payer master record.',
    `subscriber_id` BIGINT COMMENT 'External subscriber identifier assigned by the payer or health plan. Used for eligibility verification and claim adjudication.',
    `prior_member_enrollment_id` BIGINT COMMENT 'Self-referencing FK on member_enrollment (prior_member_enrollment_id)',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network associated with this enrollment. Determines in-network vs out-of-network benefits.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: Enrollment systems must verify required consents (treatment, HIPAA authorization, plan-specific) are on file before coverage activation. Critical for regulatory compliance and service delivery authori',
    `benefit_period_end_date` DATE COMMENT 'End date of the benefit period for deductible and out-of-pocket maximum tracking. Resets accumulators for next period.',
    `benefit_period_start_date` DATE COMMENT 'Start date of the benefit period for deductible and out-of-pocket maximum tracking. Typically calendar year or plan year.',
    `cobra_indicator` BOOLEAN COMMENT 'Indicates whether this enrollment is a COBRA continuation coverage following employment termination.',
    `cobra_qualifying_event_date` DATE COMMENT 'Date of the qualifying event that triggered COBRA eligibility (e.g., employment termination, divorce). Nullable for non-COBRA enrollments.',
    `coverage_tier` STRING COMMENT 'Coverage tier indicating the scope of family members covered under this enrollment. Affects premium calculation.. Valid values are `individual|individual_plus_spouse|individual_plus_children|family`',
    `eligibility_verification_date` DATE COMMENT 'Date when member eligibility was last verified with the payer. Used for real-time eligibility checks.',
    `eligibility_verification_status` STRING COMMENT 'Status of the most recent eligibility verification attempt. Used to flag potential coverage issues.. Valid values are `verified|pending|failed|not_verified`',
    `enrollment_channel` STRING COMMENT 'Channel or interface through which the member completed the enrollment process.. Valid values are `web|mobile|phone|mail|in_person|broker`',
    `enrollment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit and data lineage tracking.',
    `enrollment_effective_date` DATE COMMENT 'Date when the member coverage becomes effective and benefits are available. Used for eligibility determination.',
    `enrollment_notes` STRING COMMENT 'Free-text notes or comments related to this enrollment. Used for documenting special circumstances or exceptions.',
    `enrollment_source` STRING COMMENT 'Source system or channel through which the enrollment was initiated. [ENUM-REF-CANDIDATE: employer_group|aca_exchange|medicare_cms|medicaid_agency|direct_enrollment|broker|navigator|other — promote to reference product]',
    `enrollment_source_system` STRING COMMENT 'Name of the source system that originated this enrollment record. Used for data lineage and reconciliation.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the member enrollment. Used for eligibility verification and claim adjudication.. Valid values are `active|pending|suspended|terminated|cancelled`',
    `enrollment_termination_date` DATE COMMENT 'Date when the member coverage ends and benefits are no longer available. Nullable for active enrollments.',
    `enrollment_type` STRING COMMENT 'Type of enrollment event that initiated this coverage. Determines eligibility rules and enrollment period constraints.. Valid values are `open_enrollment|special_enrollment|auto_enrollment|cobra|medicare|medicaid`',
    `enrollment_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified. Used for audit and change tracking.',
    `group_number` STRING COMMENT 'Employer or sponsor group number under which the member is enrolled. Used to identify the benefit group and premium structure.',
    `last_premium_payment_date` DATE COMMENT 'Date of the most recent premium payment received for this enrollment. Used for grace period and termination calculations.',
    `medicaid_number` STRING COMMENT 'State-assigned Medicaid identifier for dual-eligible members. Used for coordination of benefits and claim adjudication.',
    `medicare_part_a_effective_date` DATE COMMENT 'Effective date of Medicare Part A coverage for dual-eligible members. Used for coordination of benefits.',
    `medicare_part_b_effective_date` DATE COMMENT 'Effective date of Medicare Part B coverage for dual-eligible members. Used for coordination of benefits.',
    `pcp_assignment_date` DATE COMMENT 'Date when the primary care physician was assigned to this member. Used for continuity of care tracking.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount for this member enrollment. May be employer-paid, member-paid, or split.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which premium payments are due for this enrollment.. Valid values are `monthly|quarterly|annual|biweekly`',
    `premium_payment_status` STRING COMMENT 'Current status of premium payments for this enrollment. Affects coverage eligibility and claim payment.. Valid values are `current|past_due|grace_period|suspended|terminated`',
    `relationship_to_subscriber` STRING COMMENT 'Relationship of the member to the primary subscriber. Determines dependent status and coverage eligibility rules.. Valid values are `self|spouse|child|domestic_partner|other_dependent`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monthly premium subsidy or tax credit amount applied to this enrollment. Applicable for ACA marketplace plans.',
    `subsidy_type` STRING COMMENT 'Type of premium subsidy or cost-sharing reduction applied to this enrollment. APTC = Advanced Premium Tax Credit, CSR = Cost-Sharing Reduction.. Valid values are `aptc|csr|medicaid|chip|none`',
    `termination_reason` STRING COMMENT 'Reason for enrollment termination. [ENUM-REF-CANDIDATE: voluntary_disenrollment|employment_termination|loss_of_eligibility|non_payment|death|medicare_eligibility|medicaid_eligibility|plan_discontinuation|other — promote to reference product]',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'Transactional record of a members enrollment into a specific health plan, capturing the full enrollment lifecycle from initial enrollment through termination. Captures member ID (subscriber ID), payer ID, health plan ID, group number, subscriber vs dependent relationship, enrollment type (open enrollment, special enrollment period, auto-enrollment, COBRA), enrollment effective date, termination date, termination reason, premium amount, premium payment status, benefit period, and enrollment source (employer group, exchange, Medicaid agency, Medicare CMS). SSOT for member plan enrollment referenced by eligibility verification and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the subscriber record. Primary key. The subscriber is the primary insured individual (policyholder) who holds the insurance contract with the payer and is responsible for premium payment.',
    `employer_group_id` BIGINT COMMENT 'Reference to the employer group sponsoring this coverage, if applicable. Null for individual/non-group plans.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product under which this subscriber is enrolled. Links to the plan master in the insurance domain.',
    `mpi_record_id` BIGINT COMMENT 'Payer-assigned unique member identifier for the subscriber. This is the externally-known subscriber number used on insurance cards and in claims processing. Also known as subscriber number or policy number.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer (health plan) that issued this subscriber contract. Links to the payer master in the insurance domain.',
    `prior_subscriber_id` BIGINT COMMENT 'Self-referencing FK on subscriber (prior_subscriber_id)',
    `address_line_1` STRING COMMENT 'Primary street address line for the subscribers residence.',
    `address_line_2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the subscribers residence.',
    `city` STRING COMMENT 'City of the subscribers residence.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for COBRA continuation coverage after employment termination. True=eligible, False=not eligible.',
    `cobra_end_date` DATE COMMENT 'Date when COBRA continuation coverage ends, if applicable. Null if not on COBRA or coverage is ongoing.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA continuation coverage began, if applicable. Null if not on COBRA.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the subscribers residence. Typically USA for US-based subscribers.. Valid values are `USA|CAN|MEX`',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the subscribers coverage. Active=currently covered, Inactive=coverage lapsed, Suspended=temporarily paused, Terminated=permanently ended, Pending=awaiting activation.. Valid values are `active|inactive|suspended|terminated|pending`',
    `coverage_type` STRING COMMENT 'Type of insurance coverage provided under this subscriber contract. Indicates the primary benefit category.. Valid values are `medical|dental|vision|pharmacy|behavioral_health|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscriber record was first created in the data platform.',
    `date_of_birth` DATE COMMENT 'Date of birth of the subscriber. Used for eligibility verification and age-based benefit determination.',
    `dual_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is dually eligible for both Medicare and Medicaid. True=dual eligible, False=not dual eligible. Critical for coordination of benefits and cost-sharing determination.',
    `effective_end_date` DATE COMMENT 'Date when the subscribers coverage terminates. Null for open-ended active coverage.',
    `effective_start_date` DATE COMMENT 'Date when the subscribers coverage becomes effective and benefits are available.',
    `email_address` STRING COMMENT 'Email address for subscriber communication and electronic correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal first name of the subscriber as registered with the payer.',
    `gender` STRING COMMENT 'Administrative gender of the subscriber. M=Male, F=Female, U=Unknown, O=Other.. Valid values are `M|F|U|O`',
    `group_number` STRING COMMENT 'Employer or sponsor group number under which the subscriber is enrolled. Used for group billing and benefit determination.',
    `last_name` STRING COMMENT 'Legal last name (family name) of the subscriber as registered with the payer.',
    `medicaid_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for Medicaid coverage. True=eligible, False=not eligible. Used for coordination of benefits and dual eligibility determination.',
    `medicaid_number` STRING COMMENT 'State-issued Medicaid identification number, if the subscriber is Medicaid-eligible. Used for coordination of benefits.',
    `medicare_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for Medicare coverage. True=eligible, False=not eligible. Used for coordination of benefits.',
    `medicare_number` STRING COMMENT 'Medicare Beneficiary Identifier (MBI) assigned by CMS, if the subscriber is Medicare-eligible. Used for coordination of benefits between Medicare and commercial insurance.',
    `middle_name` STRING COMMENT 'Middle name or initial of the subscriber, if provided.',
    `network_tier` STRING COMMENT 'Network tier or level assigned to the subscribers plan. Determines cost-sharing and provider access levels.. Valid values are `in_network|out_of_network|preferred|standard`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the subscriber.',
    `postal_code` STRING COMMENT 'ZIP code or postal code of the subscribers residence.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly or periodic premium amount the subscriber is responsible for paying. Amount in USD.',
    `premium_frequency` STRING COMMENT 'Frequency at which the subscriber pays premiums.. Valid values are `monthly|quarterly|annual|biweekly`',
    `primary_care_physician_npi` STRING COMMENT 'National Provider Identifier (NPI) of the subscribers designated primary care physician, if applicable. Used in managed care plans requiring PCP assignment.',
    `relationship_to_insured` STRING COMMENT 'Relationship of the subscriber to the primary insured. For subscriber records, this is typically self since the subscriber IS the insured party. Used when subscriber may be a dependent on another policy.. Valid values are `self|spouse|child|other`',
    `source_system_code` STRING COMMENT 'Unique identifier for this subscriber in the source system. Used for data lineage and reconciliation.',
    `ssn` STRING COMMENT 'Social Security Number of the subscriber. Stored in masked or encrypted format per HIPAA security requirements. Used for identity verification and coordination of benefits.',
    `state` STRING COMMENT 'State or province of the subscribers residence. Two-letter state code for US addresses.',
    `suffix` STRING COMMENT 'Name suffix of the subscriber (Jr, Sr, II, III, etc.), if applicable.. Valid values are `Jr|Sr|II|III|IV|V`',
    `termination_reason` STRING COMMENT 'Reason for coverage termination, if applicable. Null for active coverage.. Valid values are `voluntary|non_payment|employment_ended|death|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscriber record was last updated in the data platform.',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Master record for the primary insured individual (subscriber/policyholder) who holds the insurance contract with the payer. Distinct from the patient master (patient.mpi_record) — the subscriber is the contractual party responsible for premium payment and may or may not be a patient. Captures subscriber ID (member ID), payer-assigned subscriber number, subscriber name, date of birth, gender, SSN (masked), employer group, group number, relationship to dependents, premium responsibility, COBRA eligibility status, and Medicare/Medicaid dual eligibility flags. SSOT for the insurance contractual relationship owner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Unique identifier for the dependent record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Reference to the primary care physician assigned to this dependent for managed care plans.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identifier assigned by the health plan to this dependent for eligibility verification and claims processing.',
    `primary_dependent_id` BIGINT COMMENT 'Self-referencing FK on dependent (primary_dependent_id)',
    `primary_dependent_mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Dependents are patients with MPI records. Business process: dependent enrollment creates patient identity; clinical care delivery, scheduling, and medical records require linking insurance dependent t',
    `subscriber_id` BIGINT COMMENT 'Reference to the primary subscriber under whose health plan this dependent is covered.',
    `address_line_1` STRING COMMENT 'Primary street address line for the dependent.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `city` STRING COMMENT 'City of residence for the dependent.',
    `coordination_of_benefits_indicator` BOOLEAN COMMENT 'Indicates whether the dependent has other health insurance coverage requiring coordination of benefits.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the dependents residence.. Valid values are `^[A-Z]{3}$`',
    `coverage_effective_date` DATE COMMENT 'Date when the dependents coverage under the subscribers health plan becomes effective.',
    `coverage_termination_date` DATE COMMENT 'Date when the dependents coverage under the subscribers health plan terminates. Null if coverage is currently active.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the dependent, used for age-based eligibility determination and coverage rules.',
    `disability_status` STRING COMMENT 'Indicates whether the dependent has a qualifying disability that extends eligibility beyond standard age or relationship limits.. Valid values are `Disabled|Not Disabled`',
    `disability_verification_date` DATE COMMENT 'Date when the dependents disability status was last verified for extended eligibility purposes.',
    `eligibility_status` STRING COMMENT 'Current eligibility status of the dependent for coverage under the subscribers health plan.. Valid values are `Active|Inactive|Pending|Terminated|Suspended|Deceased`',
    `email_address` STRING COMMENT 'Email address for the dependent for communication and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_date` DATE COMMENT 'Date when the dependent was enrolled in the health plan.',
    `enrollment_source` STRING COMMENT 'Source through which the dependent was enrolled in the health plan (e.g., employer, exchange, direct, Medicaid, Medicare, CHIP). [ENUM-REF-CANDIDATE: Employer|Exchange|Direct|Medicaid|Medicare|CHIP|Other — 7 candidates stripped; promote to reference product]',
    `first_name` STRING COMMENT 'Legal first name of the dependent as registered with the health plan.',
    `gender` STRING COMMENT 'Gender of the dependent as recorded for coverage and clinical purposes.. Valid values are `Male|Female|Other|Unknown`',
    `last_eligibility_verification_date` DATE COMMENT 'Date when the dependents eligibility was last verified by the health plan.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the dependent as registered with the health plan.',
    `middle_name` STRING COMMENT 'Middle name or initial of the dependent.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the dependent.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'ZIP code for the dependents residence.. Valid values are `^d{5}(-d{4})?$`',
    `relationship_type` STRING COMMENT 'Type of relationship between the dependent and the subscriber (e.g., spouse, child, domestic partner, disabled dependent).. Valid values are `Spouse|Child|Domestic Partner|Disabled Dependent|Other`',
    `ssn` STRING COMMENT 'Social Security Number of the dependent for tax reporting and identity verification purposes.. Valid values are `^d{3}-d{2}-d{4}$`',
    `state` STRING COMMENT 'Two-letter state code for the dependents residence.. Valid values are `^[A-Z]{2}$`',
    `student_status` STRING COMMENT 'Indicates whether the dependent is a full-time or part-time student, which may extend eligibility beyond standard age limits (e.g., up to age 26).. Valid values are `Full-Time Student|Part-Time Student|Not a Student`',
    `student_verification_date` DATE COMMENT 'Date when the dependents student status was last verified for eligibility extension purposes.',
    `suffix` STRING COMMENT 'Name suffix for the dependent (e.g., Jr, Sr, II, III).. Valid values are `Jr|Sr|II|III|IV|V`',
    `termination_reason` STRING COMMENT 'Reason for termination of the dependents coverage (e.g., aging off at 26, divorce, loss of eligibility, death).. Valid values are `Aged Out|Divorce|Loss of Eligibility|Death|Voluntary Termination|Other`',
    `tobacco_use_indicator` BOOLEAN COMMENT 'Indicates whether the dependent uses tobacco products, which may affect premium calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was last updated in the system.',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master record for individuals covered under a subscribers health plan as dependents, including spouses, domestic partners, and children. Captures dependent ID, subscriber ID, dependent name, date of birth, gender, relationship type (spouse, child, domestic partner, disabled dependent), dependent eligibility status, coverage effective date, termination date, termination reason (aging off at 26, divorce, loss of eligibility), and student status for age-extension eligibility. Enables accurate member-level eligibility verification and COB determination for dependents.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` (
    `employer_group_id` BIGINT COMMENT 'Unique identifier for the employer group. Primary key for this entity. This is the system-generated surrogate key that uniquely identifies each employer group record in the master data management system.',
    `broker_id` BIGINT COMMENT 'Identifier for the insurance broker or agent who sold and services this employer group. Brokers receive commissions and provide ongoing account management. Null if the group was sold direct.',
    `health_plan_id` BIGINT COMMENT 'Identifier for the standard benefit plan design (coverage levels, deductibles, copays, coinsurance) that applies to this employer group. Links to the benefit plan master entity. Groups may have multiple plans for different employee classes.',
    `parent_employer_group_id` BIGINT COMMENT 'Self-referencing FK on employer_group (parent_employer_group_id)',
    `payer_id` BIGINT COMMENT 'Identifier for the health insurance payer (carrier) that underwrites or administers this employer group. Links to the payer master entity.',
    `provider_network_id` BIGINT COMMENT 'Identifier for the provider network assigned to this employer group. Determines which providers are in-network for members of this group. Links to the network master entity.',
    `third_party_administrator_id` BIGINT COMMENT 'Identifier for the Third Party Administrator that handles claims processing, member services, and administrative functions for this self-funded employer group. Null if the payer administers the plan directly or if the group is fully insured.',
    `aca_applicable_large_employer_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this employer group meets the ACA definition of an Applicable Large Employer (50 or more full-time equivalent employees). ALEs are subject to the employer shared responsibility mandate and must offer affordable minimum essential coverage or face penalties.',
    `address_line_1` STRING COMMENT 'The first line of the employer groups primary business address. Typically includes street number and street name. Used for premium billing, regulatory correspondence, and legal notices.',
    `address_line_2` STRING COMMENT 'The second line of the employer groups primary business address. Typically includes suite, floor, or building number. Optional field.',
    `billing_frequency` STRING COMMENT 'The frequency at which premium invoices are generated and sent to the employer group. Most groups are billed monthly, but some large groups may have quarterly or annual billing cycles.. Valid values are `monthly|quarterly|annual|semi_annual`',
    `city` STRING COMMENT 'The city of the employer groups primary business address. Used for geographic rating, network assignment, and regulatory jurisdiction determination.',
    `cobra_administrator` STRING COMMENT 'The entity responsible for administering COBRA continuation coverage for terminated employees and qualifying dependents. Payer: health plan administers. Employer: employer self-administers. TPA: third party administrator handles. External vendor: specialized COBRA vendor.. Valid values are `payer|employer|tpa|external_vendor`',
    `contact_email` STRING COMMENT 'The email address of the primary employer contact for benefits administration. Used for enrollment files, billing statements, and plan communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'The name of the primary contact person at the employer organization for benefits administration, enrollment, and billing matters. Typically the HR director or benefits manager.',
    `contact_phone` STRING COMMENT 'The phone number of the primary employer contact for benefits administration. Used for urgent enrollment issues, billing inquiries, and plan support.. Valid values are `^+?[0-9]{10,15}$`',
    `country_code` STRING COMMENT 'The three-letter ISO country code of the employer groups primary business address. Typically USA for domestic groups. Used for international employer groups and regulatory jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this employer group record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'The date on which the employer groups health insurance coverage becomes active and members are eligible for benefits. This is the contract start date.',
    `employee_count` STRING COMMENT 'The number of eligible employees (subscribers) in the employer group, excluding dependents. Used for group size classification, premium calculations, and regulatory reporting.',
    `employer_contribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employee-only premium that the employer pays. The employee pays the remainder. Typical employer contributions range from 50% to 100%. Used for ACA affordability calculations and premium billing.',
    `employer_ein` STRING COMMENT 'The federal Employer Identification Number (EIN) assigned by the IRS, also known as the Federal Tax Identification Number. This nine-digit number uniquely identifies the employer for tax reporting and regulatory purposes. Format: XX-XXXXXXX.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `erisa_plan_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this employer groups health plan is subject to ERISA federal regulations. True for most private employer plans. False for government and church plans which are ERISA-exempt.',
    `funding_type` STRING COMMENT 'The financial arrangement model for how the employer group funds its health benefits. Fully insured: payer assumes all risk. Self-funded: employer assumes claims risk. Level-funded: hybrid with predictable monthly payments. Minimum premium: employer funds expected claims, payer covers excess. Stop-loss only: employer self-funds with catastrophic reinsurance.. Valid values are `fully_insured|self_funded|level_funded|minimum_premium|stop_loss_only`',
    `grace_period_days` STRING COMMENT 'The number of days after the premium due date during which the employer group can make payment without coverage lapsing. Typically 30 days for group coverage. During the grace period, coverage remains active but claims may be pended.',
    `group_name` STRING COMMENT 'The legal or doing-business-as name of the employer organization that sponsors the health insurance coverage for its employees. This is the primary human-readable identifier for the group.',
    `group_number` STRING COMMENT 'The externally-known unique business identifier assigned to the employer group by the payer. This is the group number printed on member ID cards and used in all billing and claims transactions. Also known as the policy group number or contract group number.. Valid values are `^[A-Z0-9]{6,20}$`',
    `group_size` STRING COMMENT 'The total number of enrolled lives (employees and dependents) covered under this employer group. This count determines small group vs. large group classification for regulatory purposes and impacts premium rating methodologies.',
    `group_status` STRING COMMENT 'The current lifecycle status of the employer group contract. Active: coverage in force. Pending: application submitted, not yet effective. Suspended: temporarily inactive, may be reinstated. Terminated: contract ended by mutual agreement. Cancelled: contract ended by payer. Lapsed: contract ended due to non-payment.. Valid values are `active|pending|suspended|terminated|cancelled|lapsed`',
    `hsa_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this employer groups benefit plan is HSA-qualified (high deductible health plan meeting IRS requirements). If true, employees can contribute pre-tax dollars to a Health Savings Account.',
    `industry_risk_class` STRING COMMENT 'The risk classification based on the employers industry and occupation mix. Used in underwriting and premium rating. Low: office/professional. Moderate: light manufacturing/retail. High: construction/transportation. Hazardous: mining/heavy industrial.. Valid values are `low|moderate|high|hazardous`',
    `minimum_participation_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage of eligible employees that must enroll in the health plan for the group to qualify for coverage. Typically 75% for small groups. Used during initial underwriting and at renewal to prevent adverse selection.',
    `naics_code` STRING COMMENT 'The six-digit NAICS code that classifies the employers industry sector. NAICS has largely replaced SIC for statistical and regulatory purposes. Used for industry analysis, risk stratification, and regulatory reporting.. Valid values are `^[0-9]{6}$`',
    `payment_method` STRING COMMENT 'The method by which the employer group remits premium payments to the payer. ACH and wire transfer are most common for large groups. Check and credit card may be used by small groups.. Valid values are `ach|wire_transfer|check|credit_card|payroll_deduction`',
    `plan_sponsor_type` STRING COMMENT 'The category of organization that sponsors the health plan. Private employer: for-profit or non-profit business. Union trust: labor union-sponsored plan. Government employer: federal, state, or local government entity. Association: group of small employers. Taft-Hartley: jointly trusteed union-management plan. MEWA: Multiple Employer Welfare Arrangement.. Valid values are `private_employer|union_trust|government_employer|association|taft_hartley|multiple_employer_welfare_arrangement`',
    `postal_code` STRING COMMENT 'The ZIP code or ZIP+4 code of the employer groups primary business address. Used for geographic rating, network assignment, and premium calculations. Format: XXXXX or XXXXX-XXXX.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `rate_guarantee_months` STRING COMMENT 'The number of months for which the premium rates are guaranteed not to increase. Typically 12 months (annual rate guarantee) for most groups. Some large groups may negotiate multi-year rate guarantees.',
    `renewal_date` DATE COMMENT 'The annual date on which the employer groups contract renews. Typically the anniversary of the original effective date. Used for renewal underwriting, rate adjustments, and plan design changes.',
    `sic_code` STRING COMMENT 'The four-digit Standard Industrial Classification code that categorizes the employers primary line of business or industry. Used for risk assessment, underwriting, and industry benchmarking.. Valid values are `^[0-9]{4}$`',
    `situs_state_code` STRING COMMENT 'The state code that determines which state insurance regulations apply to this employer group. For fully insured plans, this is typically the state where the policy is issued. For self-funded ERISA plans, this may differ from the employers physical location. Format: two uppercase letters.. Valid values are `^[A-Z]{2}$`',
    `state_code` STRING COMMENT 'The two-letter state abbreviation of the employer groups primary business address. Determines state insurance regulations, mandated benefits, and tax jurisdiction. Format: two uppercase letters (e.g., CA, NY, TX).. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'The date on which the employer groups coverage ends. Null if the group is currently active. Once set, no new claims with service dates after this date will be paid under this group.',
    `underwriting_tier` STRING COMMENT 'The risk classification assigned to this employer group during underwriting. Standard: average risk. Preferred: lower than average risk, may receive rate discounts. Substandard: higher than average risk, may have rate loadings or exclusions. Declined: group was not accepted for coverage.. Valid values are `standard|preferred|substandard|declined`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this employer group record was last modified. Updated whenever any attribute changes. Used for change tracking and data synchronization. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `wellness_program_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this employer group has an active wellness or health promotion program integrated with their health plan. Wellness programs may include biometric screenings, health risk assessments, smoking cessation, weight management, and premium incentives.',
    CONSTRAINT pk_employer_group PRIMARY KEY(`employer_group_id`)
) COMMENT 'Master record for employer groups and group sponsors that purchase health insurance coverage for their employees through a payer. Captures group name, group number, employer EIN (Tax ID), SIC/NAICS industry code, group size (number of enrolled lives), funding type (fully insured, self-funded, level-funded), plan sponsor type (private employer, union trust, government employer, association), broker/TPA relationship, renewal date, and group contract effective dates. Supports group-level benefit administration, premium billing, and employer reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` (
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract record. Primary key for the payer contract entity.',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - payer contracts are site-specific but payer_contract lacks a care_site FK',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: Contracts executed with provider groups for network participation, VBC arrangements, and group-level reimbursement. Essential for contract management, payment reconciliation, and network operations. C',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Contracts executed with organizational providers for facility network participation and hospital reimbursement. Critical for facility contract management, claims pricing, and network adequacy. Creatin',
    `payer_contact_id` BIGINT COMMENT 'FK to insurance.payer_contact',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that is party to this contract.',
    `renewed_payer_contract_id` BIGINT COMMENT 'Self-referencing FK on payer_contract (renewed_payer_contract_id)',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Contracts specify covered specialties and carve-outs (e.g., behavioral health carved out, oncology specialty contract). Critical for network adequacy planning, specialty-specific rate negotiations, an',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to this contract since its original execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this contract automatically renews at the end of its term unless either party provides notice of termination.',
    `base_reimbursement_percentage` DECIMAL(18,2) COMMENT 'The baseline percentage rate applied to charges or fee schedules for reimbursement calculation (e.g., 110% of Medicare rates). Null if reimbursement method is not percentage-based.',
    `carve_out_services` STRING COMMENT 'Description or list of services explicitly excluded from this contract and reimbursed under separate arrangements (e.g., behavioral health, pharmacy, transplant services).',
    `claims_submission_method` STRING COMMENT 'The method by which claims under this contract must be submitted to the payer for adjudication.. Valid values are `electronic|paper|portal|clearinghouse`',
    `contract_administrator_email` STRING COMMENT 'Email address of the internal contract administrator for operational communication regarding this contract.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contract_administrator_name` STRING COMMENT 'Name of the internal staff member or department responsible for managing and administering this payer contract.',
    `contract_document_location` STRING COMMENT 'File path, URL, or document management system reference to the signed contract document for audit and reference purposes.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the payer contract for identification and reporting purposes.',
    `contract_number` STRING COMMENT 'The externally-known unique business identifier for this payer contract, used in communications with the payer and internal revenue cycle operations.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the payer contract. Draft indicates contract under negotiation; pending approval awaiting internal or payer sign-off; active means contract is in force; suspended indicates temporary hold; terminated means contract ended before expiration; expired means contract reached its end date.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the reimbursement model governing this contract. Fee-for-service pays per service rendered; capitation pays a fixed amount per member per month; bundled payment covers an episode of care; shared savings rewards cost reduction; pay-for-performance (P4P) ties payment to quality metrics; value-based combines quality and cost outcomes.. Valid values are `fee_for_service|capitation|bundled_payment|shared_savings|pay_for_performance|value_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer contract record was first created in the system.',
    `credentialing_required` BOOLEAN COMMENT 'Indicates whether individual providers must be credentialed and enrolled with the payer to bill under this contract.',
    `effective_date` DATE COMMENT 'The date on which this payer contract becomes binding and reimbursement terms take effect.',
    `fee_schedule_reference` STRING COMMENT 'Reference identifier to the base fee schedule or rate table that governs reimbursement rates for services under this contract (e.g., Medicare Fee Schedule, custom negotiated rates).',
    `geographic_coverage` STRING COMMENT 'Description of the geographic region or service area covered by this contract (e.g., statewide, multi-state, specific counties).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to this contract.',
    `network_tier` STRING COMMENT 'The tier or level of this provider within the payers network, affecting member cost-sharing and reimbursement rates. Tier 1 typically offers lowest member cost-sharing; out-of-network highest.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or operational guidance related to this payer contract.',
    `payment_terms_days` STRING COMMENT 'Number of days within which the payer is contractually obligated to remit payment after claim adjudication.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for certain services under this contract before services are rendered.',
    `quality_bonus_eligible` BOOLEAN COMMENT 'Indicates whether this contract includes provisions for quality-based bonus payments tied to performance metrics such as Healthcare Effectiveness Data and Information Set (HEDIS) scores or Merit-based Incentive Payment System (MIPS) performance.',
    `quality_measure_set` STRING COMMENT 'Identifier or name of the quality measure set or program used to evaluate performance under this contract (e.g., HEDIS, MIPS, hospital-acquired infection rates).',
    `quality_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this contract includes provisions for quality-based penalties or payment reductions for failure to meet performance thresholds.',
    `reconciliation_frequency` STRING COMMENT 'The frequency at which financial reconciliation and settlement occurs between provider and payer for shared savings, risk adjustments, or quality bonuses.. Valid values are `monthly|quarterly|semi_annually|annually|none`',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory body for this contracts filing or approval.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this contract must be filed with state insurance departments or other regulatory bodies for approval or compliance purposes.',
    `reimbursement_method` STRING COMMENT 'The calculation method used to determine payment amounts. Percent of charges pays a percentage of billed charges; percent of Medicare pays a percentage of Medicare rates; flat rate is a fixed amount per service; per diem is a daily rate; case rate is a fixed amount per case; DRG-based uses Diagnosis-Related Group rates; capitation is a fixed per-member-per-month amount. [ENUM-REF-CANDIDATE: percent_of_charges|percent_of_medicare|flat_rate|per_diem|case_rate|drg_based|capitation — 7 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or renegotiate the contract before auto-renewal occurs.',
    `risk_arrangement_type` STRING COMMENT 'Defines the financial risk-sharing model between provider and payer. No risk means traditional fee-for-service; upside only allows provider to share in savings; downside only exposes provider to penalties; two-sided risk includes both savings and penalties; full risk transfers all financial risk to provider.. Valid values are `no_risk|upside_only|downside_only|two_sided_risk|full_risk`',
    `state_code` STRING COMMENT 'Two-letter state code indicating the primary state jurisdiction for this contract.',
    `stop_loss_threshold_amount` DECIMAL(18,2) COMMENT 'The dollar amount threshold above which stop-loss or reinsurance provisions apply, protecting the provider or payer from catastrophic claims costs. Null if no stop-loss provision exists.',
    `termination_date` DATE COMMENT 'The date on which this payer contract ends or is scheduled to end. Null for open-ended contracts or contracts with auto-renewal.',
    `timely_filing_limit_days` STRING COMMENT 'Number of days from date of service within which claims must be submitted to the payer to be considered timely filed and eligible for reimbursement.',
    `updated_by` STRING COMMENT 'User identifier or name of the person who last updated this payer contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer contract record was last modified in the system.',
    CONSTRAINT pk_payer_contract PRIMARY KEY(`payer_contract_id`)
) COMMENT 'Master record for negotiated contracts between the healthcare organization (provider) and insurance payers, defining reimbursement terms, fee schedules, value-based care arrangements, and contractual obligations. Captures contract number, payer ID, contract type (fee-for-service, capitation, bundled payment, shared savings, P4P — Pay for Performance), contract effective date, termination date, auto-renewal terms, base fee schedule reference, carve-out provisions, quality bonus/penalty terms, risk arrangement type, and contract status. SSOT for provider-payer contractual relationships governing reimbursement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule record. Primary key.',
    `payer_contract_id` BIGINT COMMENT 'Reference to the provider-payer contract under which this fee schedule is defined. Links to the contract master entity.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan that owns this fee schedule. Links to the payer master entity.',
    `primary_predecessor_schedule_fee_schedule_id` BIGINT COMMENT 'Reference to the previous version of this fee schedule, enabling version history tracking and audit trails.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Fee schedules vary by specialty for differential reimbursement (primary care vs subspecialty rates, surgical vs medical specialties). Essential for specialty-specific contract rates and claims pricing',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: Fee schedules reference taxonomy codes for provider type-specific rates (e.g., different rates for MD vs NP, different facility rates by type). Critical for accurate claims pricing and contract compli',
    `annual_inflation_rate` DECIMAL(18,2) COMMENT 'The annual percentage rate applied for inflation adjustments, if applicable. Expressed as a decimal (e.g., 3.50 for 3.5%).',
    `approval_date` DATE COMMENT 'The date on which this fee schedule was formally approved for implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved this fee schedule for use.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether services under this fee schedule require prior authorization before rendering care.',
    `billed_charges_percentage` DECIMAL(18,2) COMMENT 'The percentage of billed charges used as the basis for reimbursement when rate_basis is percent_of_billed_charges. Expressed as a decimal (e.g., 80.00 for 80% of billed charges).',
    `carve_out_services` STRING COMMENT 'Description of services explicitly excluded or carved out from this fee schedule, to be reimbursed under separate arrangements.',
    `claims_submission_method` STRING COMMENT 'The required method for submitting claims under this fee schedule: electronic (EDI), paper, web portal, or clearinghouse.. Valid values are `electronic|paper|portal|clearinghouse`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this fee schedule becomes active and applicable for reimbursement calculations.',
    `facility_type` STRING COMMENT 'The type of healthcare facility to which this fee schedule applies: inpatient, outpatient, ambulatory surgery center (ASC), skilled nursing facility (SNF), home health, or hospice.. Valid values are `inpatient|outpatient|ambulatory_surgery_center|skilled_nursing_facility|home_health|hospice`',
    `filing_reference_number` STRING COMMENT 'The reference number assigned by the regulatory authority when this fee schedule was filed for approval.',
    `geographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Geographic adjustment factor applied to base rates to account for regional cost variations. Based on CMS Geographic Practice Cost Index (GPCI) methodology.',
    `geographic_scope` STRING COMMENT 'The geographic applicability of the fee schedule: national, regional, state-level, county-level, zip code-level, or facility-specific.. Valid values are `national|regional|state|county|zip_code|facility_specific`',
    `inflation_adjustment_method` STRING COMMENT 'The method used for annual inflation adjustments to fee schedule rates: Consumer Price Index (CPI), Medical CPI, fixed percentage, none, or custom methodology.. Valid values are `cpi|medical_cpi|fixed_percentage|none|custom`',
    `interest_penalty_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to late payments as a penalty for exceeding payment terms. Expressed as a decimal (e.g., 10.00 for 10%).',
    `locality_code` STRING COMMENT 'CMS locality code used for Medicare geographic adjustment purposes, defining the specific payment locality.',
    `medicare_percentage` DECIMAL(18,2) COMMENT 'The percentage of Medicare allowable rates used as the basis for reimbursement when rate_basis is percent_of_medicare. Expressed as a decimal (e.g., 110.00 for 110% of Medicare).',
    `network_tier` STRING COMMENT 'The provider network tier to which this fee schedule applies: tier 1 (highest reimbursement), tier 2, tier 3, preferred, standard, or out-of-network.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the fee schedule.',
    `outlier_payment_threshold` DECIMAL(18,2) COMMENT 'The cost threshold above which outlier payments are triggered for exceptionally high-cost cases, typically in DRG-based reimbursement.',
    `payment_terms_days` STRING COMMENT 'The number of days within which the payer is contractually obligated to remit payment after receiving a clean claim.',
    `quality_adjustment_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage adjustment (positive or negative) that can be applied to base rates based on quality performance metrics.',
    `quality_incentive_eligible` BOOLEAN COMMENT 'Indicates whether this fee schedule is eligible for quality-based incentive payments under value-based purchasing or pay-for-performance programs.',
    `rate_basis` STRING COMMENT 'The methodology used to determine reimbursement rates: percentage of Medicare rates, percentage of billed charges, case rate, per diem, fee-for-service, or capitation.. Valid values are `percent_of_medicare|percent_of_billed_charges|case_rate|per_diem|fee_for_service|capitation`',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this fee schedule must be filed with state insurance regulators or other governing bodies for approval.',
    `reimbursement_model` STRING COMMENT 'The payment model under which this fee schedule operates: fee-for-service, bundled payment, value-based, shared savings, capitation, or per diem.. Valid values are `fee_for_service|bundled_payment|value_based|shared_savings|capitation|per_diem`',
    `schedule_code` STRING COMMENT 'Unique alphanumeric code assigned to the fee schedule for system identification and cross-referencing.',
    `schedule_name` STRING COMMENT 'Business-friendly name or title of the fee schedule, used for identification and reporting purposes.',
    `schedule_type` STRING COMMENT 'Classification of the fee schedule by service category: professional services, facility services, durable medical equipment (DME), laboratory, pharmacy, or radiology.. Valid values are `professional|facility|dme|laboratory|pharmacy|radiology`',
    `service_category` STRING COMMENT 'Broad classification of services covered by this fee schedule (e.g., surgical, medical, diagnostic, preventive, behavioral health).',
    `state_code` STRING COMMENT 'Two-letter state code indicating the primary state jurisdiction for this fee schedule, if applicable.',
    `fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule: draft (under development), active (in use), suspended (temporarily inactive), terminated (ended by agreement), expired (past termination date), or pending approval (awaiting authorization).. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The dollar amount threshold above which stop-loss provisions apply, limiting payer liability for high-cost cases.',
    `termination_date` DATE COMMENT 'The date on which this fee schedule expires or is terminated. Null indicates an open-ended schedule.',
    `timely_filing_limit_days` STRING COMMENT 'The number of days from the date of service within which claims must be submitted to be considered timely filed.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this fee schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for the fee schedule, used to track revisions and amendments over time.',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Master record for payer-specific reimbursement fee schedules defining the contracted payment rates for procedures, services, and supplies. Captures fee schedule name, payer ID, contract ID, fee schedule type (professional, facility, DME, lab, pharmacy), effective date, termination date, geographic adjustment factor (GPCI), and the basis for rates (% of Medicare, % of billed charges, case rate, per diem). Parent entity for fee schedule line items. Supports contract modeling, underpayment detection, and revenue cycle optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` (
    `fee_schedule_line_id` BIGINT COMMENT 'Unique identifier for the fee schedule line item record. Primary key for this entity.',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Fee schedules include DRG-based case rates for inpatient hospital reimbursement. Essential for hospital claims pricing, bundled payment calculation, and value-based contract administration in payer sy',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the parent fee schedule contract that contains this line item. Links this rate to the overall fee schedule agreement.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Fee schedules include HCPCS rates for DME, supplies, and ancillary services. Essential for claims auto-pricing, provider reimbursement calculation, and contract rate validation in payer financial syst',
    `primary_superseded_by_fee_schedule_line_id` BIGINT COMMENT 'Reference to the fee_schedule_line_id that replaces this line when status is superseded. Enables tracking of rate history and lineage.',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'For anesthesia services, the base unit value assigned to the procedure used in calculating anesthesia reimbursement (base units + time units + modifying units) × conversion factor.',
    `assistant_surgeon_allowed` BOOLEAN COMMENT 'Indicates whether an assistant surgeon is allowed for this procedure and will be separately reimbursed according to the fee schedule.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required from the payer before performing this service at the contracted rate. True means authorization is mandatory.',
    `bilateral_indicator` STRING COMMENT 'Indicates whether the procedure can be performed bilaterally (on both sides of the body) and how it affects reimbursement.. Valid values are `not_applicable|bilateral_surgery|unilateral_surgery`',
    `bundled_indicator` BOOLEAN COMMENT 'Indicates whether this procedure code is part of a bundled payment arrangement where multiple services are reimbursed as a single package. True means this is bundled.',
    `case_rate_amount` DECIMAL(18,2) COMMENT 'When rate_basis is case_rate, this field contains the bundled payment amount for an entire episode of care or procedure (e.g., DRG-based payment, bundled surgical package).',
    `contract_reference_number` STRING COMMENT 'External reference number or identifier linking this fee schedule line to the source contract document or agreement section.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated reimbursement amount for this specific procedure code and modifier combination. Represents the dollar amount the payer will reimburse for the service.',
    `conversion_factor` DECIMAL(18,2) COMMENT 'The dollar multiplier applied to total RVUs to calculate the contracted rate amount. For example, if total RVU is 2.5 and conversion factor is $40.00, the rate is $100.00.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule line record was first created in the system. Part of audit trail.',
    `effective_date` DATE COMMENT 'The date on which this fee schedule line item becomes active and applicable for reimbursement calculations. Part of the temporal validity period.',
    `facility_type` STRING COMMENT 'Classification of the facility setting where the service is rendered, affecting reimbursement methodology and rates. [ENUM-REF-CANDIDATE: inpatient|outpatient|ambulatory_surgery|emergency|skilled_nursing|home_health|hospice — 7 candidates stripped; promote to reference product]',
    `geographic_modifier` STRING COMMENT 'Two-digit code representing the geographic locality for Medicare GPCI adjustments. Used to adjust RVU-based payments for regional cost variations.. Valid values are `^[0-9]{2}$`',
    `global_period_days` STRING COMMENT 'Number of days in the global surgical period during which follow-up care is included in the procedure payment and not separately reimbursable. Common values are 0, 10, or 90 days.',
    `line_number` STRING COMMENT 'Sequential line number within the parent fee schedule, used for ordering and reference purposes.',
    `maximum_reimbursement` DECIMAL(18,2) COMMENT 'The ceiling amount for reimbursement regardless of calculation method. Caps the payment level for the service.',
    `minimum_reimbursement` DECIMAL(18,2) COMMENT 'The floor amount for reimbursement regardless of calculation method. Ensures a minimum payment level for the service.',
    `modifier_1` STRING COMMENT 'Primary two-character CPT or HCPCS modifier that provides additional information about the service performed, affecting reimbursement calculation.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_2` STRING COMMENT 'Secondary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_3` STRING COMMENT 'Tertiary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_4` STRING COMMENT 'Quaternary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `multiple_procedure_reduction` DECIMAL(18,2) COMMENT 'Percentage reduction applied when multiple procedures are performed in the same session (e.g., 50.00 means second procedure is reimbursed at 50% of the fee schedule rate).',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or clarifications about this fee schedule line item (e.g., carve-outs, special conditions, negotiation context).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'When rate_basis is per_diem, this field contains the daily rate amount for inpatient or long-term care services.',
    `percent_of_charges` DECIMAL(18,2) COMMENT 'When rate_basis is percent_of_charges, this field contains the percentage multiplier applied to the providers billed charges (e.g., 65.00 means 65% of charges).',
    `percent_of_medicare` DECIMAL(18,2) COMMENT 'When rate_basis is percent_of_medicare, this field contains the percentage multiplier applied to the Medicare allowable amount (e.g., 110.00 means 110% of Medicare rates).',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the physical location where the service was rendered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Department). Affects reimbursement rates.. Valid values are `^[0-9]{2}$`',
    `procedure_code` STRING COMMENT 'The Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) code identifying the specific service, procedure, or supply item being priced. Five-character alphanumeric code.. Valid values are `^[0-9A-Z]{5}$`',
    `procedure_code_type` STRING COMMENT 'Classification of the procedure code system used: CPT (Current Procedural Terminology), HCPCS (Healthcare Common Procedure Coding System), CDT (Current Dental Terminology), or NDC (National Drug Code).. Valid values are `CPT|HCPCS|CDT|NDC`',
    `quality_reporting_required` BOOLEAN COMMENT 'Indicates whether quality measure reporting is required for this service as part of value-based payment programs (e.g., MIPS, APM).',
    `rate_basis` STRING COMMENT 'The methodology used to calculate the contracted rate: flat_rate (fixed dollar amount), rvu_based (Relative Value Unit multiplied by conversion factor), percent_of_charges (percentage of billed charges), percent_of_medicare (percentage of Medicare allowable), per_diem (daily rate), case_rate (bundled payment), or stop_loss (threshold-based). [ENUM-REF-CANDIDATE: flat_rate|rvu_based|percent_of_charges|percent_of_medicare|per_diem|case_rate|stop_loss — 7 candidates stripped; promote to reference product]',
    `rate_version` STRING COMMENT 'Version number tracking changes to this specific fee schedule line over time. Increments with each rate update or modification.',
    `revenue_code` STRING COMMENT 'Four-digit revenue code used primarily for facility billing (UB-04 claims) to classify the type of service or accommodation provided. Used in conjunction with procedure codes for hospital outpatient and inpatient services.. Valid values are `^[0-9]{4}$`',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'The malpractice component of the RVU representing professional liability insurance costs associated with the service.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'The practice expense component of the RVU representing overhead costs (staff, supplies, equipment) associated with providing the service.',
    `rvu_total` DECIMAL(18,2) COMMENT 'The total RVU value calculated as the sum of work, practice expense, and malpractice components. Used with conversion factor to determine reimbursement.',
    `rvu_work` DECIMAL(18,2) COMMENT 'The work component of the Relative Value Unit (RVU) representing physician time, skill, and intensity required to perform the service. Used in RVU-based reimbursement calculations.',
    `specialty_code` STRING COMMENT 'Code identifying the provider specialty for which this rate applies (e.g., cardiology, orthopedics, primary care). Some contracts have specialty-specific rates.',
    `fee_schedule_line_status` STRING COMMENT 'Current lifecycle status of the fee schedule line item: active (in use), inactive (not in use), pending (approved but not yet effective), superseded (replaced by newer version), expired (past termination date), or suspended (temporarily disabled).. Valid values are `active|inactive|pending|superseded|expired|suspended`',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'When rate_basis is stop_loss, this field contains the dollar threshold above which different reimbursement rules apply (e.g., outlier payments for high-cost cases).',
    `termination_date` DATE COMMENT 'The date on which this fee schedule line item is no longer active for reimbursement. Null indicates the rate is currently active with no planned end date.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this record. Supports audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule line record was last modified. Part of audit trail for tracking changes.',
    CONSTRAINT pk_fee_schedule_line PRIMARY KEY(`fee_schedule_line_id`)
) COMMENT 'Individual line-item rate record within a fee schedule, defining the contracted reimbursement rate for a specific procedure code, service, or supply item. Captures fee schedule ID, procedure code (CPT/HCPCS), modifier applicability, revenue code (for facility), place of service, contracted rate amount, rate basis (flat rate, RVU-based, % of Medicare allowable), RVU value, conversion factor, effective date, and termination date. Enables line-level contract modeling, expected reimbursement calculation, and underpayment variance analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` (
    `prior_auth_rule_id` BIGINT COMMENT 'Unique identifier for the prior authorization rule record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Prior authorization rules must reference organizational clinical policies that define medical necessity criteria, coverage determination frameworks, and appeals processes. This linkage ensures PA rule',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: PA rules govern HCPCS codes for DME, supplies, and specialty drugs. Critical for authorization workflow automation, step therapy enforcement, and utilization management in payer operations.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product under which this prior authorization rule applies.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that enforces this prior authorization requirement.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: PA rules often reference quality measures (e.g., require PA for procedures not meeting HEDIS/NQF criteria). Payers align PA requirements with evidence-based quality measure specifications.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: PA rules specify which consent forms must be completed before authorization (e.g., experimental treatment consent, genetic testing consent). Policy enforcement mechanism linking authorization requirem',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Prior authorization rules are specialty-specific (e.g., cardiology procedures, oncology treatments, orthopedic surgery). Critical for PA determination engines and clinical criteria application. Creati',
    `superseded_prior_auth_rule_id` BIGINT COMMENT 'Self-referencing FK on prior_auth_rule (superseded_prior_auth_rule_id)',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: PA rules reference NUCC taxonomy codes to determine which provider types can perform services (e.g., only board-certified surgeons for certain procedures). Essential for PA auto-adjudication and provi',
    `age_maximum` STRING COMMENT 'Maximum patient age in years for which this prior authorization rule applies. Null if no age restriction.',
    `age_minimum` STRING COMMENT 'Minimum patient age in years for which this prior authorization rule applies. Null if no age restriction.',
    `appeal_process_description` STRING COMMENT 'Description of the process for appealing a prior authorization denial under this rule, including timelines and contact information.',
    `auto_approval_criteria` STRING COMMENT 'Description of the criteria that must be met for automated approval of the prior authorization request.',
    `auto_approval_eligible` BOOLEAN COMMENT 'Indicates whether this prior authorization rule supports automated approval based on predefined criteria without manual review.',
    `clinical_criteria_reference` STRING COMMENT 'Reference to the clinical guideline, medical policy, or evidence-based criteria document that defines the medical necessity standards for this prior authorization rule.',
    `contact_fax` STRING COMMENT 'Payer fax number for prior authorization document submission related to this rule.. Valid values are `^+?[0-9]{10,15}$`',
    `contact_phone` STRING COMMENT 'Payer contact phone number for prior authorization inquiries and submissions related to this rule.. Valid values are `^+?[0-9]{10,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this prior authorization rule record was first created in the system.',
    `diagnosis_code` STRING COMMENT 'International Classification of Diseases 10th Revision (ICD-10) diagnosis code that qualifies or triggers the prior authorization requirement. May be null if rule applies regardless of diagnosis.. Valid values are `^[A-Z0-9.]{3,10}$`',
    `documentation_required` STRING COMMENT 'List or description of clinical documentation that must be submitted with the prior authorization request (e.g., chart notes, lab results, imaging reports).',
    `effective_date` DATE COMMENT 'Date on which this prior authorization rule becomes active and enforceable by the payer.',
    `exception_criteria` STRING COMMENT 'Description of circumstances under which exceptions to the prior authorization requirement may be granted (e.g., emergency situations, continuity of care).',
    `frequency_limit` STRING COMMENT 'Maximum number of times the service can be performed within the frequency period without prior authorization. Null if no frequency limit applies.',
    `frequency_limit_period_days` STRING COMMENT 'Time period in days over which the frequency limit is measured. Null if no period applies.',
    `gender_restriction` STRING COMMENT 'Gender-specific applicability of the prior authorization rule. Values: male, female, all (no restriction), or other.. Valid values are `male|female|all|other`',
    `medical_policy_number` STRING COMMENT 'Payer-specific medical policy document number or identifier that governs this prior authorization rule.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or special instructions related to this prior authorization rule.',
    `pa_requirement_type` STRING COMMENT 'Classification of the prior authorization requirement level: required (mandatory PA), not required, clinical review (medical necessity review), peer-to-peer (physician discussion), notification only, or retrospective review.. Valid values are `required|not_required|clinical_review|peer_to_peer|notification_only|retrospective_review`',
    `place_of_service_code` STRING COMMENT 'Two-digit CMS Place of Service code identifying the location where the service is rendered (e.g., 11=office, 21=inpatient hospital, 22=outpatient hospital).. Valid values are `^[0-9]{2}$`',
    `portal_url` STRING COMMENT 'Web address of the payer portal for electronic prior authorization submission, if applicable.. Valid values are `^https?://.*$`',
    `procedure_code` STRING COMMENT 'Current Procedural Terminology (CPT) or Healthcare Common Procedure Coding System (HCPCS) code identifying the procedure, service, or supply subject to prior authorization.. Valid values are `^[0-9A-Z]{5,10}$`',
    `procedure_code_type` STRING COMMENT 'Classification of the procedure code system used (CPT, HCPCS, or ICD-10-PCS).. Valid values are `CPT|HCPCS|ICD-10-PCS`',
    `quantity_limit` DECIMAL(18,2) COMMENT 'Maximum quantity or units of service allowed without prior authorization under this rule. Null if no quantity limit applies.',
    `quantity_limit_period_days` STRING COMMENT 'Time period in days over which the quantity limit is measured (e.g., 30 days, 90 days). Null if no period applies.',
    `regulatory_basis` STRING COMMENT 'Citation of the regulatory or statutory authority that permits or requires this prior authorization rule (e.g., CMS National Coverage Determination, state insurance law).',
    `rule_code` STRING COMMENT 'Unique business identifier code for this prior authorization rule, used for external reference and reporting.. Valid values are `^[A-Z0-9]{4,20}$`',
    `rule_name` STRING COMMENT 'Human-readable descriptive name of the prior authorization rule for display and reporting purposes.',
    `service_category` STRING COMMENT 'Broad classification of the healthcare service type subject to prior authorization (e.g., inpatient, outpatient, surgical, pharmacy, durable medical equipment). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|surgical|diagnostic|therapeutic|pharmacy|dme|home_health|behavioral_health — 10 candidates stripped; promote to reference product]',
    `prior_auth_rule_status` STRING COMMENT 'Current lifecycle status of the prior authorization rule: active (in effect), inactive (not enforced), pending (scheduled for activation), suspended (temporarily paused), or retired (permanently discontinued).. Valid values are `active|inactive|pending|suspended|retired`',
    `step_therapy_criteria` STRING COMMENT 'Description of the step therapy requirements, including which alternative treatments must be tried first and failure criteria.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of alternative treatments before approval) is required as part of the prior authorization criteria.',
    `submission_method` STRING COMMENT 'Allowed method(s) for submitting the prior authorization request: payer portal, fax, phone, EDI 278 transaction, email, or postal mail.. Valid values are `portal|fax|phone|edi_278|email|mail`',
    `termination_date` DATE COMMENT 'Date on which this prior authorization rule is no longer active. Null indicates the rule is currently in effect with no planned end date.',
    `turnaround_time_hours` STRING COMMENT 'Standard turnaround time in hours for the payer to respond to a prior authorization request under this rule.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this prior authorization rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this prior authorization rule record was last modified.',
    `urgent_turnaround_time_hours` STRING COMMENT 'Expedited turnaround time in hours for urgent or emergent prior authorization requests under this rule.',
    CONSTRAINT pk_prior_auth_rule PRIMARY KEY(`prior_auth_rule_id`)
) COMMENT 'Master record defining payer-specific prior authorization (PA) requirements for procedures, services, medications, and care settings. Captures payer ID, health plan ID, procedure code (CPT/HCPCS), diagnosis code applicability, service category, place of service, PA requirement type (required, not required, clinical review, peer-to-peer), clinical criteria reference, turnaround time standard (urgent vs standard), submission method (portal, fax, phone, EDI 278), effective date, and termination date. SSOT for PA requirement rules used by utilization management and order authorization workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` (
    `utilization_review_id` BIGINT COMMENT 'Unique identifier for the utilization review record. Primary key.',
    `claim_appeal_id` BIGINT COMMENT 'Identifier of the associated appeal record if an appeal was filed following the utilization review decision.',
    `appealed_utilization_review_id` BIGINT COMMENT 'Self-referencing FK on utilization_review (appealed_utilization_review_id)',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility where the service or admission occurred.',
    `clinician_id` BIGINT COMMENT 'Identifier of the physician or provider who rendered the service being reviewed.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Utilization review activities must comply with specific compliance programs: UM compliance program, clinical criteria adherence program, regulatory timeframe compliance. Linking UR to governing compli',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical reviewer (nurse, physician advisor, or UM specialist) who conducted the utilization review.',
    `encounter_authorization_id` BIGINT COMMENT 'Identifier of the associated prior authorization request, if this review is linked to a pre-certification or authorization workflow.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the health plan member (patient) whose care is being reviewed.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer or health plan conducting or requesting the utilization review.',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: UR decisions reference clinical quality measures for medical necessity determination. Payers use quality measure criteria (e.g., HEDIS, NQF) to define appropriateness and approve/deny services.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: UR reviewers must verify appropriate consent exists for the service under review (especially for experimental treatments, research procedures, genetic testing). Regulatory requirement for authorizatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Utilization review denials and approvals directly impact cost center financial performance. Finance teams reconcile UR decisions to departmental budgets and variance reports. Real-world healthcare CFO',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Utilization review applies specialty-specific clinical criteria (e.g., cardiology UR criteria, oncology treatment protocols). Essential for peer-to-peer matching, clinical appropriateness review, and ',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter (admission, visit, or service episode) subject to utilization review.',
    `admission_date` DATE COMMENT 'Date the patient was admitted to the facility, applicable for inpatient utilization reviews.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an appeal was filed by the member or provider in response to the utilization review decision.',
    `appeal_rights_notified` BOOLEAN COMMENT 'Indicates whether the member and provider were notified of their rights to appeal the utilization review decision, as required by ERISA and state regulations.',
    `approved_length_of_stay` STRING COMMENT 'Number of inpatient days approved by the utilization review, which may differ from the requested length of stay.',
    `clinical_criteria_applied` STRING COMMENT 'Name of the clinical guideline or criteria set used to evaluate medical necessity (e.g., InterQual, MCG, Milliman Care Guidelines).',
    `clinical_documentation_reviewed` STRING COMMENT 'Summary or list of clinical documentation reviewed during the UM process (e.g., H&P, progress notes, lab results, imaging reports).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the utilization review record was first created in the system.',
    `criteria_version` STRING COMMENT 'Version number or edition of the clinical criteria applied during the review.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for denial or modification of the service request (e.g., not medically necessary, experimental treatment, lack of documentation).',
    `denial_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for denial or modification, provided to the member and provider.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code (ICD-10) associated with the service or admission being reviewed.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged from the facility, applicable for inpatient utilization reviews.',
    `medical_record_number` STRING COMMENT 'Patients medical record number at the facility where the service was provided.',
    `notification_method` STRING COMMENT 'Method used to notify the member and provider of the review decision (mail, fax, email, patient portal, phone).. Valid values are `mail|fax|email|portal|phone`',
    `notification_sent_date` DATE COMMENT 'Date the review decision notification was sent to the member and provider.',
    `peer_to_peer_date` DATE COMMENT 'Date the peer-to-peer review discussion occurred between the treating provider and the payers medical reviewer.',
    `peer_to_peer_requested` BOOLEAN COMMENT 'Indicates whether the treating provider requested a peer-to-peer discussion with the medical director or physician reviewer to appeal or discuss the initial review decision.',
    `place_of_service_code` STRING COMMENT 'Two-digit code indicating the setting where the service was provided (e.g., 21 for inpatient hospital, 11 for office).',
    `procedure_code` STRING COMMENT 'Procedure code (CPT or HCPCS) for the service or treatment being reviewed for medical necessity.',
    `regulatory_timeframe_met` BOOLEAN COMMENT 'Indicates whether the utilization review was completed within the regulatory timeframe mandated by state or federal law (e.g., 72 hours for urgent pre-service, 30 days for retrospective).',
    `rendering_provider_npi` STRING COMMENT 'Ten-digit National Provider Identifier (NPI) of the rendering provider.. Valid values are `^[0-9]{10}$`',
    `requested_length_of_stay` STRING COMMENT 'Number of inpatient days requested or initially authorized for the admission.',
    `review_completion_date` DATE COMMENT 'Date the utilization review was completed and a final decision was rendered.',
    `review_decision` STRING COMMENT 'Final determination of the utilization review: approved (medical necessity met), denied (not medically necessary), modified (approved with changes), pended (additional information required), or partially approved.. Valid values are `approved|denied|modified|pended|partially approved`',
    `review_initiation_date` DATE COMMENT 'Date the utilization review process was initiated or the review request was received.',
    `review_number` STRING COMMENT 'Business identifier or case number assigned to this utilization review for tracking and reference by payers, providers, and UM teams.',
    `review_status` STRING COMMENT 'Current lifecycle status of the utilization review process.. Valid values are `pending|in progress|completed|cancelled|on hold`',
    `review_type` STRING COMMENT 'Type of utilization management review conducted: pre-certification (prospective), concurrent review (during stay), retrospective review (post-service), discharge planning, or continued stay review.. Valid values are `pre-certification|concurrent review|retrospective review|discharge planning|continued stay review`',
    `reviewer_credentials` STRING COMMENT 'Professional credentials of the reviewer (e.g., RN, MD, DO, NP) to demonstrate clinical qualifications for conducting the review.',
    `reviewer_notes` STRING COMMENT 'Free-text notes or comments entered by the clinical reviewer documenting the rationale for the review decision.',
    `service_date` DATE COMMENT 'Date of the service, procedure, or admission being reviewed for medical necessity.',
    `turnaround_time_hours` STRING COMMENT 'Number of hours elapsed between review initiation and completion, used to measure UM process efficiency and compliance with regulatory timeframes.',
    `updated_by` STRING COMMENT 'User ID or name of the person who last updated the utilization review record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the utilization review record was last updated.',
    CONSTRAINT pk_utilization_review PRIMARY KEY(`utilization_review_id`)
) COMMENT 'Transactional record of utilization management (UM) review activities conducted by payers or internal UM teams to evaluate medical necessity for inpatient admissions, continued stays, procedures, and high-cost services. Captures review type (pre-certification, concurrent review, retrospective review, discharge planning), payer ID, member ID, admission/service date, clinical criteria applied (InterQual, MCG), review decision (approved, denied, modified, pended), denial reason code, peer-to-peer review request flag, appeal rights notification, and reviewer credentials. Supports UM compliance, denial management, and length-of-stay optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` (
    `eligibility_span_id` BIGINT COMMENT 'Unique identifier for the eligibility span record. Primary key for the eligibility span entity.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary care physician assigned to or selected by the member. Populated when pcp_required_indicator is true.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the specific health plan product under which this eligibility span is established. Defines the benefit structure and coverage rules.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the member (patient) who holds this insurance coverage. Links to the patient domain master record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer organization responsible for adjudicating and paying claims under this coverage.',
    `prior_eligibility_span_id` BIGINT COMMENT 'Self-referencing FK on eligibility_span (prior_eligibility_span_id)',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network associated with this eligibility span. Defines which providers are in-network for this coverage.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the primary subscriber (policyholder) of the insurance plan. May be the same as member_id if the member is the subscriber, or different if the member is a dependent.',
    `benefit_period_end_date` DATE COMMENT 'The end date of the benefit period for deductible and out-of-pocket maximum accumulation. Deductibles and accumulators reset after this date.',
    `benefit_period_start_date` DATE COMMENT 'The start date of the benefit period for deductible and out-of-pocket maximum accumulation. Typically aligns with plan year or calendar year.',
    `cobra_indicator` BOOLEAN COMMENT 'Indicates whether this eligibility span represents COBRA continuation coverage. True if the member is continuing coverage under COBRA provisions after a qualifying event.',
    `cobra_qualifying_event` STRING COMMENT 'The qualifying event that triggered COBRA continuation coverage eligibility. Populated only when cobra_indicator is true.. Valid values are `termination|reduction_hours|death|divorce|dependent_ineligibility|medicare_entitlement`',
    `cobra_qualifying_event_date` DATE COMMENT 'The date on which the COBRA qualifying event occurred. Used to determine COBRA continuation period limits.',
    `coordination_of_benefits_indicator` BOOLEAN COMMENT 'Indicates whether coordination of benefits rules apply because the member has multiple insurance coverages. True if this is a secondary or tertiary payer.',
    `coverage_level` STRING COMMENT 'The tier of coverage indicating whether the plan covers only the subscriber or includes dependents.. Valid values are `individual|family|employee_spouse|employee_children|employee_family`',
    `coverage_order` STRING COMMENT 'Indicates the order of liability when multiple coverages exist. Primary coverage pays first; secondary and tertiary coverages pay after primary according to COB rules.. Valid values are `primary|secondary|tertiary`',
    `coverage_type` STRING COMMENT 'The type of healthcare services covered under this eligibility span. Defines the scope of benefits available to the member.. Valid values are `medical|dental|vision|pharmacy|behavioral_health|comprehensive`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this eligibility span record was first created in the system. Represents the audit trail for record creation.',
    `dual_eligibility_indicator` BOOLEAN COMMENT 'Indicates whether the member is dually eligible for both Medicare and Medicaid. True if the member qualifies for both programs simultaneously.',
    `dual_eligibility_type` STRING COMMENT 'Specifies the type of dual eligibility status. QMB (Qualified Medicare Beneficiary), SLMB (Specified Low-Income Medicare Beneficiary), QI (Qualifying Individual), QDWI (Qualified Disabled and Working Individual). Populated only when dual_eligibility_indicator is true.. Valid values are `full|partial|qmb|slmb|qi|qdwi`',
    `eligibility_end_date` DATE COMMENT 'The date on which the members insurance coverage terminates under this eligibility span. Null indicates open-ended active coverage.',
    `eligibility_start_date` DATE COMMENT 'The date on which the members insurance coverage becomes effective under this eligibility span. Represents the beginning of the continuous eligibility period.',
    `eligibility_status` STRING COMMENT 'Current lifecycle status of the eligibility span. Active indicates coverage is in force; terminated indicates coverage has ended; suspended indicates temporary hold; COBRA indicates continuation coverage under COBRA provisions; pending indicates coverage not yet effective.. Valid values are `active|terminated|suspended|cobra|pending`',
    `eligibility_verification_date` DATE COMMENT 'The date on which eligibility was last verified with the payer through a 270/271 transaction or other verification method.',
    `eligibility_verification_status` STRING COMMENT 'The status of the most recent eligibility verification attempt. Verified indicates successful confirmation; unverified indicates no recent verification; failed indicates verification was attempted but unsuccessful.. Valid values are `verified|unverified|pending|failed|expired`',
    `enrollment_method` STRING COMMENT 'The method by which the enrollment was submitted. Distinguishes between online enrollment, paper application, phone enrollment, in-person enrollment, or automatic enrollment.. Valid values are `online|paper|phone|in_person|automatic|other`',
    `enrollment_source` STRING COMMENT 'The source or channel through which the member enrolled in this coverage. Indicates whether enrollment was through an employer, exchange, direct purchase, broker, or government program.. Valid values are `employer|exchange|direct|broker|government|other`',
    `exchange_indicator` BOOLEAN COMMENT 'Indicates whether this coverage was purchased through a health insurance exchange (marketplace) established under the Affordable Care Act.',
    `group_number` STRING COMMENT 'Employer or sponsor group number under which the member is covered. Used to identify the employer or organization sponsoring the coverage.',
    `medicaid_indicator` BOOLEAN COMMENT 'Indicates whether the member has Medicaid coverage. True if the member is enrolled in a state Medicaid program.',
    `medicare_indicator` BOOLEAN COMMENT 'Indicates whether the member has Medicare coverage. True if the member is enrolled in Medicare Part A, B, C, or D.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this eligibility span. Used to capture context not represented in structured fields.',
    `pcp_assignment_date` DATE COMMENT 'The date on which the current primary care physician was assigned to or selected by the member.',
    `pcp_required_indicator` BOOLEAN COMMENT 'Indicates whether the member is required to select and maintain a primary care physician under this plan. True for HMO and POS plans that require PCP designation.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium amount charged for this coverage, typically per billing period. Represents the member or employer contribution for maintaining coverage.',
    `premium_payment_frequency` STRING COMMENT 'The frequency at which premium payments are due for this coverage.. Valid values are `monthly|quarterly|semi_annually|annually|weekly|bi_weekly`',
    `prior_authorization_required_indicator` BOOLEAN COMMENT 'Indicates whether certain services under this plan require prior authorization from the payer before services are rendered.',
    `referral_required_indicator` BOOLEAN COMMENT 'Indicates whether the member must obtain a referral from their PCP before seeing a specialist. True for HMO plans with referral requirements.',
    `relationship_to_subscriber` STRING COMMENT 'Defines the relationship of the member to the primary subscriber. Determines dependent status and eligibility rules. [ENUM-REF-CANDIDATE: self|spouse|child|other_dependent|life_partner|domestic_partner|parent|other — 8 candidates stripped; promote to reference product]',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'The amount of premium subsidy or tax credit applied to reduce the members premium cost. Applicable for exchange plans with Advanced Premium Tax Credits (APTC).',
    `subsidy_type` STRING COMMENT 'The type of subsidy applied to this coverage. APTC (Advanced Premium Tax Credit), CSR (Cost-Sharing Reduction), employer subsidy, state subsidy, or none.. Valid values are `aptc|csr|employer|state|none`',
    `termination_reason` STRING COMMENT 'The reason for termination of the eligibility span, if applicable. Populated only when eligibility_status is terminated. [ENUM-REF-CANDIDATE: voluntary|involuntary|employment_ended|non_payment|death|divorce|age_limit|other — 8 candidates stripped; promote to reference product]',
    `updated_by` STRING COMMENT 'The user or system identifier that last updated this eligibility span record. Used for audit and accountability purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this eligibility span record was last modified. Represents the audit trail for record updates.',
    CONSTRAINT pk_eligibility_span PRIMARY KEY(`eligibility_span_id`)
) COMMENT 'Master record representing a continuous period of insurance eligibility for a member under a specific health plan, serving as the SSOT for eligibility determination within the insurance domain. Captures member ID, subscriber ID, payer ID, health plan ID, group number, eligibility start date, eligibility end date, eligibility status (active, terminated, suspended, COBRA), coverage type (medical, dental, vision, pharmacy, behavioral health), Medicare/Medicaid dual eligibility indicator, and the 270/271 eligibility transaction reference. Distinct from patient.patient_eligibility_verification which tracks real-time verification transactions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` (
    `accumulator_id` BIGINT COMMENT 'Unique identifier for the accumulator record. Primary key for tracking member benefit accumulation.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan under which benefits are being accumulated. References the plan configuration and benefit structure.',
    `benefit_id` BIGINT COMMENT 'add column insurance_health_plan_benefit_id (BIGINT) with FK to insurance.benefit.benefit_id - accumulators track benefit-specific deductibles and out-of-pocket maximums but lack a direct benefit FK',
    `claim_id` BIGINT COMMENT 'Identifier of the most recent claim transaction that contributed to this accumulator. Provides audit trail for accumulation calculations.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the health plan member whose benefits are being accumulated. Links to the member master record.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer organization responsible for the health plan and benefit adjudication.',
    `prior_accumulator_id` BIGINT COMMENT 'Self-referencing FK on accumulator (prior_accumulator_id)',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the primary subscriber of the health plan. May differ from member_id for dependents.',
    `accumulated_amount` DECIMAL(18,2) COMMENT 'The year-to-date dollar amount or count that has been accumulated toward the benefit threshold. Represents member cost-sharing contributions or service utilization.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of manual adjustments applied to this accumulator due to claim reversals, appeals, or administrative corrections. May be positive or negative.',
    `adjustment_count` STRING COMMENT 'The number of adjustment transactions applied to this accumulator. Used for audit trail and data quality monitoring.',
    `benefit_period_end_date` DATE COMMENT 'The date when the benefit accumulation period ends. Typically December 31 or the plan termination date.',
    `benefit_period_start_date` DATE COMMENT 'The date when the benefit accumulation period begins. Typically January 1 or the plan effective date for mid-year enrollments.',
    `benefit_year` STRING COMMENT 'Calendar year for which the accumulator is tracking benefit utilization. Accumulators typically reset annually on the plan renewal date.',
    `carryover_amount` DECIMAL(18,2) COMMENT 'Dollar amount carried over from the previous benefit period, if the plan allows deductible or OOP carryover for services rendered near year-end.',
    `carryover_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this accumulator includes carryover amounts from a prior benefit period. True if carryover_amount is greater than zero.',
    `coverage_level` STRING COMMENT 'The tier of coverage for which the accumulator applies: individual, family, employee plus spouse, employee plus children, or full family.. Valid values are `individual|family|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this accumulator record was first created in the system. Typically at the start of a new benefit period or upon member enrollment.',
    `cross_accumulation_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether amounts in this accumulator also count toward other accumulator types. For example, deductible amounts may also count toward OOP max.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this accumulator. Typically USD for US-based healthcare plans.. Valid values are `USD`',
    `embedded_deductible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this family-level accumulator uses embedded individual deductibles. True means each family member has an individual deductible within the family deductible.',
    `last_adjustment_date` DATE COMMENT 'The date of the most recent adjustment transaction applied to this accumulator. Null if no adjustments have been made.',
    `last_claim_date` DATE COMMENT 'Service date of the most recent claim that updated this accumulator. Used for recency tracking and accumulator aging analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this accumulator record was last modified. Critical for real-time benefit calculation and member portal display.',
    `network_type` STRING COMMENT 'Indicates whether the accumulator tracks in-network services, out-of-network services, or a combined bucket for both network types.. Valid values are `in_network|out_of_network|both`',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or administrative notes related to this accumulator. May include explanations for manual adjustments or unusual accumulation patterns.',
    `plan_year_sequence` STRING COMMENT 'Sequential counter indicating which plan year this accumulator represents for the member. Value of 1 for first year, 2 for second year, etc. Used for multi-year trend analysis.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining balance before the threshold is met. Calculated as threshold_amount minus accumulated_amount. Critical for member cost-sharing estimates.',
    `reset_date` DATE COMMENT 'The date when this accumulator was last reset to zero, typically at the start of a new benefit period or upon plan change.',
    `service_category` STRING COMMENT 'The category of healthcare services to which this accumulator applies: medical, pharmacy, dental, vision, behavioral health, or all services combined.. Valid values are `medical|pharmacy|dental|vision|behavioral_health|all_services`',
    `accumulator_status` STRING COMMENT 'Current operational status of the accumulator: active (accumulating), suspended (temporarily paused), closed (benefit period ended), or pending reset (awaiting new benefit year initialization).. Valid values are `active|suspended|closed|pending_reset`',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The plan-defined maximum amount or limit for this accumulator type. Once reached, benefit rules change (e.g., deductible met, OOP max reached).',
    `threshold_met_date` DATE COMMENT 'The date on which the member first met the benefit threshold. Null if threshold has not been met. Used for benefit transition tracking and member communication.',
    `threshold_met_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the member has met or exceeded the benefit threshold for this accumulator type. True when accumulated_amount >= threshold_amount.',
    `transaction_count` STRING COMMENT 'The total number of claim transactions that have contributed to this accumulator balance. Used for utilization pattern analysis.',
    `accumulator_type` STRING COMMENT 'The category of benefit accumulation being tracked: individual deductible, family deductible, individual out-of-pocket (OOP) maximum, family OOP maximum, visit limit, or service-specific dollar limit.. Valid values are `individual_deductible|family_deductible|individual_oop_max|family_oop_max|visit_limit|service_limit`',
    CONSTRAINT pk_accumulator PRIMARY KEY(`accumulator_id`)
) COMMENT 'Transactional record tracking a members year-to-date accumulation of deductible, out-of-pocket maximum, and benefit limit utilization against their health plan thresholds. Captures member ID, health plan ID, benefit year, accumulator type (individual deductible, family deductible, individual OOP max, family OOP max, visit limit, dollar limit), in-network vs out-of-network bucket, accumulated amount to date, plan threshold amount, remaining balance, last updated date, and the claim transactions contributing to the accumulation. Critical for member cost-sharing calculation and benefit exhaustion determination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` (
    `capitation_contract_id` BIGINT COMMENT 'Unique identifier for the capitation contract record. Primary key for the capitation contract entity.',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - capitation contracts are site-specific but lack a care_site FK',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: Capitation contracts are executed with provider groups for PMPM payments and risk-sharing arrangements. Essential for VBC contract management, payment reconciliation, and performance tracking. No exis',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Capitation contracts executed with organizational providers (hospitals, health systems) for bundled payments and episode-based reimbursement. Critical for hospital VBC arrangements and payment reconci',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan organization that is party to this capitation contract.',
    `renewed_capitation_contract_id` BIGINT COMMENT 'Self-referencing FK on capitation_contract (renewed_capitation_contract_id)',
    `attributed_member_count` STRING COMMENT 'The current number of members attributed to this capitation contract for payment calculation purposes.',
    `attributed_population_definition` STRING COMMENT 'Textual description of the criteria and methodology used to define which members are attributed to this capitation contract for payment and performance measurement purposes.',
    `auto_assignment_eligible` BOOLEAN COMMENT 'Indicates whether members can be automatically assigned or attributed to this capitation contract based on utilization patterns and attribution logic.',
    `benchmark_methodology` STRING COMMENT 'Description of the methodology used to establish the cost and quality benchmarks against which performance is measured for shared savings and risk calculations.',
    `carve_out_services` STRING COMMENT 'List or description of specific high-cost or specialized services carved out from the capitation arrangement and reimbursed separately (e.g., transplants, oncology, behavioral health).',
    `contract_name` STRING COMMENT 'Human-readable name or title of the capitation contract for identification and reporting purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the capitation contract, used for reference in billing, claims, and financial reporting.',
    `contract_owner` STRING COMMENT 'Name or identifier of the individual or department within the healthcare organization responsible for managing this capitation contract.',
    `contract_signed_date` DATE COMMENT 'The date on which the capitation contract was executed and signed by authorized representatives of both parties.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the capitation contract indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the capitation arrangement defining the scope of services covered under the per-member-per-month payment structure. [ENUM-REF-CANDIDATE: global_capitation|professional_capitation|specialty_capitation|partial_capitation|primary_care_capitation|hospital_capitation — promote to reference product]. Valid values are `global_capitation|professional_capitation|specialty_capitation|partial_capitation|primary_care_capitation|hospital_capitation`',
    `covered_services_description` STRING COMMENT 'Comprehensive textual description of the scope of clinical services and care management activities covered under the capitation payment arrangement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this capitation contract record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which the capitation contract becomes binding and payment arrangements take effect.',
    `excluded_services_description` STRING COMMENT 'Textual description of services explicitly excluded from the capitation arrangement and subject to separate fee-for-service or other payment mechanisms.',
    `filing_reference_number` STRING COMMENT 'The reference number assigned by the regulatory authority for the contract filing submission.',
    `geographic_service_area` STRING COMMENT 'Description of the geographic region, counties, or zip codes covered by this capitation contract for member attribution and service delivery.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the capitation contract terms.',
    `maximum_shared_loss_cap` DECIMAL(18,2) COMMENT 'The maximum dollar amount of shared losses that the healthcare organization is responsible for in a performance period, expressed in USD.',
    `maximum_shared_savings_cap` DECIMAL(18,2) COMMENT 'The maximum dollar amount of shared savings that the healthcare organization can earn in a performance period, expressed in USD.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The minimum percentage of cost savings below the benchmark that must be achieved before shared savings payments are triggered, expressed as a percentage.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the capitation contract administration and management.',
    `performance_year` STRING COMMENT 'The calendar year during which performance is measured for quality metrics and financial reconciliation under this capitation contract.',
    `pmpm_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the PMPM rate. Typically USD for US healthcare organizations.. Valid values are `^[A-Z]{3}$`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'The fixed monthly payment amount per attributed member that the payer pays to the healthcare organization under the capitation arrangement, expressed in USD.',
    `quality_measure_set` STRING COMMENT 'The standardized set of quality performance measures used to evaluate care delivery and determine quality withhold return and incentive payments (e.g., HEDIS, MIPS, ACO quality measures).',
    `quality_withhold_amount` DECIMAL(18,2) COMMENT 'The total dollar amount withheld from capitation payments for quality performance measurement, expressed in USD.',
    `quality_withhold_percentage` DECIMAL(18,2) COMMENT 'The percentage of capitation payments withheld by the payer pending achievement of quality performance targets, to be returned upon meeting quality benchmarks.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this capitation contract requires filing with state insurance departments or CMS for regulatory approval and oversight.',
    `renewal_date` DATE COMMENT 'The date on which the contract is eligible for or scheduled for renewal negotiation.',
    `risk_adjustment_methodology` STRING COMMENT 'The clinical risk stratification model used to adjust capitation payments based on member acuity and complexity. HCC (Hierarchical Condition Category) is the most common model in Medicare and commercial populations.. Valid values are `hcc|cdps|rx_risk|acg|none`',
    `risk_corridor_lower_threshold` DECIMAL(18,2) COMMENT 'The lower percentage threshold defining the risk corridor below which the healthcare organization is protected from losses. Expressed as a percentage of target costs.',
    `risk_corridor_upper_threshold` DECIMAL(18,2) COMMENT 'The upper percentage threshold defining the risk corridor above which the healthcare organization shares in savings. Expressed as a percentage of target costs.',
    `settlement_frequency` STRING COMMENT 'The frequency at which financial reconciliation and settlement of capitation payments, shared savings, and quality withholds occurs between the payer and healthcare organization.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `shared_loss_percentage` DECIMAL(18,2) COMMENT 'The percentage of cost overruns above the target benchmark that the healthcare organization is responsible for under the risk-sharing arrangement.',
    `shared_savings_percentage` DECIMAL(18,2) COMMENT 'The percentage of cost savings below the target benchmark that the healthcare organization retains as shared savings under the value-based care arrangement.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The per-member cost threshold above which stop-loss insurance or reinsurance protection applies to limit the healthcare organizations financial exposure for high-cost cases, expressed in USD.',
    `termination_date` DATE COMMENT 'The date on which the capitation contract ends or is scheduled to end. Null for open-ended or evergreen contracts.',
    `termination_notice_days` STRING COMMENT 'The number of days advance notice required by either party to terminate the capitation contract.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this capitation contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this capitation contract record was last modified in the system.',
    `vbc_model` STRING COMMENT 'The value-based care payment model framework governing financial risk and reward sharing between the healthcare organization and payer.. Valid values are `shared_savings|shared_risk|full_risk|upside_only|two_sided_risk|bundled_payment`',
    CONSTRAINT pk_capitation_contract PRIMARY KEY(`capitation_contract_id`)
) COMMENT 'Master record for capitation and value-based care (VBC) contracts between the healthcare organization and payers, defining per-member-per-month (PMPM) payment arrangements, risk pool structures, and shared savings/risk parameters. Captures contract ID, payer ID, capitation type (global capitation, professional capitation, specialty capitation), attributed population definition, PMPM rate, risk adjustment methodology (HCC — Hierarchical Condition Category), risk corridor parameters, quality withhold percentage, shared savings/loss split, contract effective dates, and settlement frequency. Supports VBC financial modeling and capitation payment reconciliation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` (
    `capitation_payment_id` BIGINT COMMENT 'Unique identifier for the capitation payment transaction record. Primary key for the capitation payment entity.',
    `adjusted_capitation_payment_id` BIGINT COMMENT 'Self-referencing FK on capitation_payment (adjusted_capitation_payment_id)',
    `ar_transaction_id` BIGINT COMMENT 'The unique transaction identifier from the payment processing system or bank for the electronic funds transfer or check deposit.',
    `capitation_contract_id` BIGINT COMMENT 'Reference to the capitation or value-based care contract governing this payment arrangement.',
    `care_site_id` BIGINT COMMENT 'Reference to the primary service location or facility receiving the capitation payment for the attributed member population.',
    `group_id` BIGINT COMMENT 'Reference to the provider group or practice organization receiving the capitation payment under the value-based care arrangement.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan making the capitation payment under the value-based care contract.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional positive or negative adjustments applied to the capitation payment for retroactive attribution changes, prior period corrections, or contract amendments.',
    `adjustment_reason` STRING COMMENT 'Detailed explanation for any adjustment amount applied to the capitation payment, including retroactive attribution changes or contract modifications.',
    `attributed_member_count` STRING COMMENT 'The number of health plan members attributed to the provider organization for the payment period under the capitation contract.',
    `contract_year` STRING COMMENT 'The contract year of the capitation agreement to which this payment applies, used for multi-year contract tracking and performance measurement.',
    `cost_center` STRING COMMENT 'The organizational cost center or department to which the capitation payment revenue is allocated for internal financial management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this capitation payment record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the capitation payment. Typically USD for US healthcare organizations.. Valid values are `USD`',
    `days_to_payment` STRING COMMENT 'The number of days between the payment due date and the actual payment received date, used to track payer payment timeliness performance.',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which the capitation payment revenue is posted for financial reporting and accounting purposes.',
    `gross_capitation_amount` DECIMAL(18,2) COMMENT 'The total gross capitation payment amount calculated as attributed member count multiplied by PMPM rate, before any adjustments or withholds.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net capitation payment amount received after all adjustments, risk factors, and quality withholds have been applied.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the capitation payment, including special circumstances, disputes, or follow-up actions required.',
    `payment_due_date` DATE COMMENT 'The contractually agreed date by which the payer is required to remit the capitation payment to the provider organization.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used by the payer to remit the capitation payment.. Valid values are `eft|ach|wire|check|virtual_card`',
    `payment_period_month` STRING COMMENT 'The month (1-12) for which this capitation payment applies, representing the coverage period for attributed members.',
    `payment_period_year` STRING COMMENT 'The calendar year for which this capitation payment applies, representing the coverage period for attributed members.',
    `payment_received_date` DATE COMMENT 'The date on which the capitation payment was actually received by the provider organization, used for cash flow tracking and revenue recognition.',
    `payment_reference_number` STRING COMMENT 'External payment reference number or remittance identifier provided by the payer for reconciliation and tracking purposes.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the capitation payment transaction indicating processing state and reconciliation progress.. Valid values are `pending|received|reconciled|disputed|adjusted|reversed`',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'The contracted capitation rate paid per attributed member per month, expressed in dollars. This is the base rate before adjustments.',
    `quality_withhold_amount` DECIMAL(18,2) COMMENT 'The dollar amount withheld by the payer from the capitation payment pending achievement of quality performance metrics under the value-based care contract.',
    `quality_withhold_percentage` DECIMAL(18,2) COMMENT 'The percentage of the gross capitation amount withheld for quality performance, typically ranging from 0% to 20%.',
    `reconciliation_date` DATE COMMENT 'The date on which the capitation payment was successfully reconciled against expected amounts and attributed member rosters.',
    `reconciliation_status` STRING COMMENT 'Current status of the reconciliation process comparing the received capitation payment against expected amounts based on attributed member counts and contract terms.. Valid values are `unreconciled|reconciled|variance_identified|under_review|resolved`',
    `remittance_advice_date` DATE COMMENT 'The date on which the remittance advice document was received from the payer, used for payment reconciliation and audit trail purposes.',
    `remittance_advice_received` BOOLEAN COMMENT 'Indicates whether a formal remittance advice document (835 ERA or paper EOB) was received from the payer with the capitation payment.',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which the capitation payment revenue is recognized in the general ledger according to GAAP revenue recognition principles.',
    `revenue_recognition_period` STRING COMMENT 'The accounting period (month and year) in which the capitation payment revenue is recognized for financial reporting purposes.',
    `risk_adjusted_amount` DECIMAL(18,2) COMMENT 'The capitation payment amount after applying the risk adjustment factor to account for population health complexity.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment multiplier applied to the capitation payment based on the attributed populations health acuity and complexity. Values typically range from 0.5 to 3.0.',
    `updated_by` STRING COMMENT 'The user identifier or system account that last modified this capitation payment record, used for audit trail and accountability purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this capitation payment record was last modified, used for audit trail and change tracking purposes.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The dollar difference between the expected capitation payment and the actual payment received, used to identify discrepancies requiring investigation.',
    `variance_reason` STRING COMMENT 'Explanation for any variance between expected and actual capitation payment amounts, including attribution differences or rate discrepancies.',
    CONSTRAINT pk_capitation_payment PRIMARY KEY(`capitation_payment_id`)
) COMMENT 'Transactional record of monthly capitation payments received from payers under capitation and value-based care contracts. Captures payment period (month/year), payer ID, capitation contract ID, attributed member count, PMPM rate applied, gross capitation amount, risk adjustment factor, quality withhold amount, net payment amount, payment receipt date, payment method (EFT, check), payer remittance reference, and reconciliation status. Enables capitation revenue recognition, attributed population reconciliation, and VBC financial performance tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` (
    `risk_adjustment_id` BIGINT COMMENT 'Unique identifier for the risk adjustment submission record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the healthcare provider who documented the diagnosis codes submitted for risk adjustment.',
    `corrected_risk_adjustment_id` BIGINT COMMENT 'Self-referencing FK on risk_adjustment (corrected_risk_adjustment_id)',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Risk adjustment submissions must reference source clinical diagnoses for RADV audits and medical record validation. CMS requires linking HCC codes back to documented diagnoses. Essential for Medicare ',
    `employee_id` BIGINT COMMENT 'Unique identifier for the clinical coder or health information management professional who reviewed the medical record to validate this diagnosis submission.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the specific health plan under which the member is enrolled and for which risk adjustment applies.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the health plan member whose diagnoses are being submitted for risk adjustment.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Risk adjustment submissions track which organizational provider documented the HCC diagnosis for RADV audit trails and medical record retrieval. Essential for Medicare Advantage and ACA risk adjustmen',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer organization responsible for the risk adjustment submission.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the clinical encounter that generated the diagnosis codes submitted for risk adjustment.',
    `acceptance_date` DATE COMMENT 'The date on which CMS or the payer accepted this risk adjustment submission as valid and included it in payment calculations.',
    `chart_review_date` DATE COMMENT 'The date on which the medical chart supporting this diagnosis was reviewed for risk adjustment coding accuracy and completeness.',
    `contract_number` STRING COMMENT 'The CMS-assigned contract identifier for the Medicare Advantage or Part D plan under which this risk adjustment submission is made.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this risk adjustment record was first created in the system.',
    `data_collection_period_end` DATE COMMENT 'The end date of the period during which diagnosis data was collected for this risk adjustment submission, typically December 31 of the service year.',
    `data_collection_period_start` DATE COMMENT 'The start date of the period during which diagnosis data was collected for this risk adjustment submission, typically January 1 of the service year.',
    `deleted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this risk adjustment submission has been deleted or voided, typically due to coding errors or medical record review findings.',
    `deletion_date` DATE COMMENT 'The date on which this risk adjustment submission was deleted or voided from the payment calculation.',
    `deletion_reason` STRING COMMENT 'The explanation for why this risk adjustment submission was deleted, such as coding error, insufficient documentation, or duplicate submission.',
    `demographic_score` DECIMAL(18,2) COMMENT 'The portion of the total risk score attributable to demographic factors such as age, gender, Medicaid eligibility, and disability status.',
    `diagnosis_present_on_admission` BOOLEAN COMMENT 'Boolean flag indicating whether the diagnosis was present at the time of inpatient admission, required for certain risk adjustment and quality reporting programs.',
    `diagnosis_type` STRING COMMENT 'The classification of the diagnosis within the encounter documentation, indicating whether it was the principal reason for the encounter or a secondary condition.. Valid values are `Principal|Secondary|Admitting|Discharge`',
    `disease_score` DECIMAL(18,2) COMMENT 'The portion of the total risk score attributable to the submitted HCC categories representing chronic and acute conditions.',
    `hcc_code` STRING COMMENT 'The HCC category code to which the submitted diagnosis maps, representing a clinically and financially homogeneous group of conditions used in risk score calculation.',
    `hcc_description` STRING COMMENT 'The descriptive label for the HCC category, providing clinical context for the condition group (e.g., Diabetes with Chronic Complications, Congestive Heart Failure).',
    `interaction_score` DECIMAL(18,2) COMMENT 'The portion of the total risk score attributable to disease interaction factors, where the presence of multiple conditions results in higher expected costs than the sum of individual conditions.',
    `medical_record_review_status` STRING COMMENT 'The status of medical record documentation review supporting this diagnosis submission, critical for RADV audit compliance and internal quality assurance.. Valid values are `Not Required|Pending|In Review|Validated|Invalidated`',
    `model` STRING COMMENT 'The specific risk adjustment methodology applied to calculate the risk score. CMS-HCC (Hierarchical Condition Category) for Medicare Advantage, RxHCC for Part D, HHS-HCC for ACA marketplace plans, ESRD for end-stage renal disease, PACE for Program of All-Inclusive Care for the Elderly, CDPS for Chronic Illness and Disability Payment System. [ENUM-REF-CANDIDATE: CMS-HCC|RxHCC|HHS-HCC|ESRD|PACE|CDPS|Other — 7 candidates stripped; promote to reference product]',
    `model_version` STRING COMMENT 'The version year or release identifier of the risk adjustment model used for this submission (e.g., V24, V28 for CMS-HCC models).',
    `payment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of risk adjustment payment associated with this submission, calculated by multiplying the risk score by the base payment rate for the plan and geographic area.',
    `payment_impact_amount` DECIMAL(18,2) COMMENT 'The incremental payment impact of this specific HCC submission compared to baseline, representing the marginal revenue contribution of capturing this diagnosis.',
    `payment_year` STRING COMMENT 'The calendar year for which the risk adjustment payment applies, typically the year following the data collection year.',
    `plan_benefit_package` STRING COMMENT 'The specific benefit package identifier within the contract that applies to this member and risk adjustment submission.',
    `radv_audit_date` DATE COMMENT 'The date on which this submission was selected for or completed a RADV audit by CMS.',
    `radv_audit_status` STRING COMMENT 'The status of this submission in the CMS Risk Adjustment Data Validation audit process, which validates the accuracy of submitted diagnosis codes through medical record review.. Valid values are `Not Selected|Selected|In Progress|Passed|Failed|Appealed`',
    `recapture_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this diagnosis represents a recapture of a chronic condition that was documented in a prior year but not yet documented in the current payment year.',
    `rejection_date` DATE COMMENT 'The date on which CMS or the payer rejected this risk adjustment submission due to validation errors or policy violations.',
    `rejection_reason` STRING COMMENT 'The detailed explanation provided by CMS or the payer for why this risk adjustment submission was rejected, including error codes and corrective action guidance.',
    `risk_score` DECIMAL(18,2) COMMENT 'The calculated risk score (also known as RAF - Risk Adjustment Factor) for the member based on demographic factors and submitted HCC categories. A score of 1.0 represents average risk; higher scores indicate higher expected costs.',
    `service_date` DATE COMMENT 'The date of service on which the diagnosis was documented during the clinical encounter, used to determine eligibility for the risk adjustment payment year.',
    `submission_date` DATE COMMENT 'The date on which this risk adjustment submission was transmitted to CMS EDGE server or payer risk adjustment system.',
    `submission_number` STRING COMMENT 'Externally-known unique business identifier for this risk adjustment submission, used for tracking and reconciliation with CMS or payer systems.',
    `submission_status` STRING COMMENT 'The current processing status of the risk adjustment submission in the workflow from creation through final reconciliation with CMS or payer systems.. Valid values are `Draft|Submitted|Accepted|Rejected|Pending|Reconciled`',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when this risk adjustment submission was transmitted, used for audit trail and reconciliation purposes.',
    `submission_type` STRING COMMENT 'The type of risk adjustment submission. Initial for first-time submission, Supplemental for additional diagnoses, Deletion for removing previously submitted diagnoses, Correction for fixing errors, RAPS for Risk Adjustment Processing System (legacy), EDPS for Encounter Data Processing System (current).. Valid values are `Initial|Supplemental|Deletion|Correction|RAPS|EDPS`',
    `suspect_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this diagnosis has been identified as a suspect condition that should be documented and submitted for risk adjustment but has not yet been confirmed in the current year.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this risk adjustment record was last modified.',
    CONSTRAINT pk_risk_adjustment PRIMARY KEY(`risk_adjustment_id`)
) COMMENT 'Transactional record of risk adjustment submissions and reconciliations under CMS risk adjustment programs (HCC — Hierarchical Condition Category for Medicare Advantage, EDGE server submissions for ACA plans) and payer-specific risk adjustment methodologies. Captures member ID, payer ID, health plan ID, risk adjustment model (CMS-HCC, RxHCC, HHS-HCC), diagnosis codes submitted (HCC-mapped ICD-10), risk score, RAF (Risk Adjustment Factor), submission period, submission type (initial, supplemental, deletion), RADV audit status, and payment impact amount. Supports risk adjustment revenue optimization and CMS compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` (
    `coordination_of_benefits_id` BIGINT COMMENT 'Unique identifier for the coordination of benefits record. Primary key.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the member with multiple insurance coverages. Links to the patient/member master record.',
    `coordination_patient_mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: COB determination for claims adjudication with multiple payers requires patient identity linkage. Business process: primary/secondary payer sequencing depends on patient-specific coverage relationship',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan designated as primary coverage.',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer designated as primary in the coordination of benefits hierarchy.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the primary subscriber on the insurance policy.',
    `superseded_coordination_of_benefits_id` BIGINT COMMENT 'Self-referencing FK on coordination_of_benefits (superseded_coordination_of_benefits_id)',
    `tertiary_payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer designated as tertiary in the coordination of benefits hierarchy, if applicable.',
    `tertiary_plan_health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan designated as tertiary coverage, if applicable.',
    `auto_cob_update_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automatic updates to COB information are enabled through eligibility feeds or third-party vendors. True when automated updates are active.',
    `cob_agreement_type` STRING COMMENT 'The type of coordination agreement between payers. Standard COB allows combined benefits up to 100% of charges; non-duplication pays only what primary did not cover; carve-out excludes certain services; maintenance of benefits pays as if primary regardless of other coverage.. Valid values are `standard|non_duplication|carve_out|maintenance_of_benefits|coordination_of_benefits`',
    `cob_determination_method` STRING COMMENT 'The method or rule used to determine the order of benefit responsibility among multiple coverages. Common methods include birthday rule (parent with earlier birthday is primary for dependent children), gender rule (deprecated method using father as primary), NAIC COB rules, court order, separation agreement, or active/inactive employment status.. Valid values are `birthday_rule|gender_rule|naic_cob_rules|court_order|separation_agreement|active_inactive`',
    `cob_effective_date` DATE COMMENT 'The date when the coordination of benefits arrangement becomes effective and the payer order applies for claim adjudication.',
    `cob_notes` STRING COMMENT 'Free-text notes documenting special circumstances, exceptions, or additional context regarding the coordination of benefits arrangement.',
    `cob_priority_sequence` STRING COMMENT 'Numeric sequence indicating the order of benefit responsibility. 1 = primary, 2 = secondary, 3 = tertiary. Used for claim adjudication sequencing.',
    `cob_questionnaire_response_date` DATE COMMENT 'The date when the member returned the completed COB questionnaire with updated coverage information.',
    `cob_questionnaire_sent_date` DATE COMMENT 'The date when a COB questionnaire was sent to the member to verify or update other insurance coverage information.',
    `cob_status` STRING COMMENT 'Current lifecycle status of the coordination of benefits arrangement.. Valid values are `active|inactive|pending|suspended|terminated`',
    `cob_termination_date` DATE COMMENT 'The date when the coordination of benefits arrangement ends, typically due to loss of one coverage or change in member circumstances.',
    `cob_verification_date` DATE COMMENT 'The date when the coordination of benefits information was last verified with the member or through external sources.',
    `cob_verification_source` STRING COMMENT 'The source or method used to verify the coordination of benefits information, such as member attestation, employer report, eligibility file feed, claims data analysis, third-party COB vendor, or manual research.. Valid values are `member_attestation|employer_report|eligibility_file|claims_data|third_party_vendor|manual_research`',
    `court_order_date` DATE COMMENT 'The date of the court order that specifies the coordination of benefits arrangement, if applicable.',
    `court_order_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a court order specifies the coordination of benefits order, overriding standard COB rules. True when court order exists.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this coordination of benefits record was first created in the system.',
    `crossover_claim_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this COB arrangement involves automatic crossover claims between Medicare and Medicaid or other secondary payers. True indicates crossover claims are processed automatically.',
    `custody_arrangement` STRING COMMENT 'The custody arrangement for dependent children when parents are separated or divorced, which may override standard birthday rule COB determination per court order or separation agreement.. Valid values are `joint|sole_custodial_parent|non_custodial_parent|court_ordered|not_applicable`',
    `dependent_relationship_code` STRING COMMENT 'The relationship of the member to the subscriber, used in determining COB order under birthday rule or other dependent coverage rules.. Valid values are `self|spouse|child|other_dependent`',
    `last_cob_inquiry_date` DATE COMMENT 'The date when the most recent COB inquiry or verification was performed with external sources or the member.',
    `medicare_primary_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether Medicare is the primary payer in this coordination of benefits arrangement. True when Medicare pays first.',
    `msp_type` STRING COMMENT 'The type of Medicare Secondary Payer situation, if applicable. Identifies the reason Medicare is secondary: working aged (group health plan coverage), ESRD (end-stage renal disease coordination period), disability (large group health plan), no-fault insurance, workers compensation, or liability insurance. [ENUM-REF-CANDIDATE: working_aged|esrd|disability|no_fault|workers_comp|liability|not_applicable — 7 candidates stripped; promote to reference product]',
    `next_cob_verification_due_date` DATE COMMENT 'The date when the next periodic COB verification is scheduled to ensure accuracy of payer order information.',
    `other_subscriber_birth_date` DATE COMMENT 'Date of birth of the other parent or subscriber on the secondary coverage, used in birthday rule calculations for dependent COB determination.',
    `primary_coverage_type` STRING COMMENT 'The type of insurance coverage designated as primary in the COB hierarchy. [ENUM-REF-CANDIDATE: group|individual|medicare|medicaid|tricare|va|workers_comp|auto_insurance|other — 9 candidates stripped; promote to reference product]',
    `secondary_coverage_type` STRING COMMENT 'The type of insurance coverage designated as secondary in the COB hierarchy. [ENUM-REF-CANDIDATE: group|individual|medicare|medicaid|tricare|va|workers_comp|auto_insurance|other — 9 candidates stripped; promote to reference product]',
    `subscriber_birth_date` DATE COMMENT 'Date of birth of the primary subscriber, used in birthday rule calculations for dependent COB determination.',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this coordination of benefits record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this coordination of benefits record was last modified.',
    CONSTRAINT pk_coordination_of_benefits PRIMARY KEY(`coordination_of_benefits_id`)
) COMMENT 'Master record managing coordination of benefits (COB) rules and active COB relationships for members with multiple insurance coverages. Captures member ID, primary payer ID, primary plan ID, secondary payer ID, secondary plan ID, tertiary payer information, COB determination method (birthday rule, gender rule, NAIC COB rules), COB effective date, COB verification date, COB verification source, and crossover claim indicator (Medicare/Medicaid crossover). SSOT for COB order determination referenced during claim adjudication to prevent duplicate payment and ensure correct primary/secondary billing sequencing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` (
    `network_adequacy_id` BIGINT COMMENT 'Unique identifier for the network adequacy assessment record. Primary key for this transactional record of regulatory compliance assessment.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the specific health plan product associated with this network adequacy assessment.',
    `payer_id` BIGINT COMMENT 'Identifier of the insurance payer organization responsible for this network. Links to payer master data.',
    `prior_network_adequacy_id` BIGINT COMMENT 'Self-referencing FK on network_adequacy (prior_network_adequacy_id)',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network being assessed for adequacy. Links to the provider network master data.',
    `actual_average_appointment_wait_time_days` STRING COMMENT 'Measured average number of days members wait for an appointment with providers in this specialty.',
    `actual_average_distance_miles` DECIMAL(18,2) COMMENT 'Measured average distance in miles that members must travel to reach the nearest contracted provider in this specialty.',
    `actual_average_travel_time_minutes` STRING COMMENT 'Measured average travel time in minutes that members must travel to reach the nearest contracted provider in this specialty.',
    `actual_provider_to_member_ratio` DECIMAL(18,2) COMMENT 'Measured ratio of contracted providers to enrolled members for this specialty and service area at the time of assessment.',
    `adequacy_determination` STRING COMMENT 'Final determination of whether the provider network meets regulatory adequacy standards for this specialty and service area.. Valid values are `adequate|deficient|conditionally_adequate|under_review`',
    `assessment_date` TIMESTAMP COMMENT 'Date and time when the network adequacy assessment was performed or completed. Principal business event timestamp for this transaction.',
    `assessment_methodology` STRING COMMENT 'Description of the methodology used to conduct the network adequacy assessment, including data sources, calculation methods, and geographic analysis techniques.',
    `assessment_number` STRING COMMENT 'Business identifier for this network adequacy assessment, used for tracking and regulatory filing reference.',
    `assessment_period_end_date` DATE COMMENT 'Ending date of the time period covered by this network adequacy assessment.',
    `assessment_period_start_date` DATE COMMENT 'Beginning date of the time period covered by this network adequacy assessment.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the network adequacy assessment in the regulatory review and approval workflow. [ENUM-REF-CANDIDATE: draft|in_progress|completed|submitted|approved|deficient|remediation_required — 7 candidates stripped; promote to reference product]',
    `assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the network adequacy assessment.',
    `county_code` STRING COMMENT 'County FIPS code or county name for the geographic area being assessed. Used for county-level adequacy standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this network adequacy assessment record was first created in the system.',
    `deficiency_description` STRING COMMENT 'Detailed description of any network adequacy deficiencies identified during the assessment, including specific gaps and affected populations.',
    `essential_community_provider_flag` BOOLEAN COMMENT 'Indicates whether this assessment includes evaluation of Essential Community Provider participation, required for marketplace plans to serve vulnerable populations.',
    `filing_reference_number` STRING COMMENT 'Regulatory filing reference number or tracking identifier assigned by CMS or state Department of Insurance for this adequacy submission.',
    `geographic_service_area` STRING COMMENT 'Geographic region or service area covered by this adequacy assessment (e.g., county, ZIP code cluster, metropolitan statistical area).',
    `maximum_appointment_wait_time_days` STRING COMMENT 'Regulatory standard for maximum number of days members must wait for an appointment with this specialty.',
    `maximum_distance_miles` DECIMAL(18,2) COMMENT 'Regulatory standard for maximum distance in miles that members must travel to access this specialty.',
    `maximum_time_distance_standard` STRING COMMENT 'Regulatory standard for maximum travel time or distance members must travel to access this specialty (e.g., 30 minutes or 30 miles for primary care).',
    `maximum_travel_time_minutes` STRING COMMENT 'Regulatory standard for maximum travel time in minutes that members must travel to access this specialty.',
    `member_count` STRING COMMENT 'Total number of enrolled members in the health plan within the assessed geographic service area.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the network adequacy assessment, including special circumstances or exceptions.',
    `percentage_members_within_standard` DECIMAL(18,2) COMMENT 'Percentage of enrolled members who have access to a contracted provider within the time-and-distance standard for this specialty.',
    `provider_count` STRING COMMENT 'Total number of contracted providers in this specialty category within the assessed geographic service area.',
    `regulatory_approval_date` DATE COMMENT 'Date when the regulatory authority approved the network adequacy assessment and certified compliance.',
    `regulatory_body` STRING COMMENT 'Regulatory authority to which this network adequacy assessment is submitted (CMS for Medicare Advantage, state Department of Insurance for commercial plans, exchange for marketplace plans).. Valid values are `CMS|state_DOI|exchange|other`',
    `regulatory_submission_date` DATE COMMENT 'Date when the network adequacy assessment was submitted to the regulatory authority for review and approval.',
    `remediation_due_date` DATE COMMENT 'Target date by which network adequacy deficiencies must be corrected to meet regulatory requirements.',
    `remediation_plan` STRING COMMENT 'Corrective action plan to address identified network adequacy deficiencies, including recruitment targets and timelines.',
    `required_provider_to_member_ratio` DECIMAL(18,2) COMMENT 'Regulatory standard for the minimum ratio of providers to enrolled members for this specialty and service area (e.g., 1 PCP per 2000 members).',
    `reviewer_name` STRING COMMENT 'Name of the individual or team responsible for reviewing and approving the network adequacy assessment before regulatory submission.',
    `specialty_category` STRING COMMENT 'Provider specialty or service category being assessed for adequacy (e.g., primary care, cardiology, behavioral health, pediatrics). May reference specialty taxonomy codes.',
    `specialty_code` STRING COMMENT 'Standardized code representing the provider specialty being assessed, typically from NUCC taxonomy or CMS specialty codes.',
    `state_code` STRING COMMENT 'Two-letter state code for the geographic area being assessed. Used for state-level regulatory reporting.',
    `telehealth_included_flag` BOOLEAN COMMENT 'Indicates whether telehealth providers were included in the adequacy assessment calculations. True if telehealth access was counted toward meeting adequacy standards.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified this network adequacy assessment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this network adequacy assessment record was last modified in the system.',
    CONSTRAINT pk_network_adequacy PRIMARY KEY(`network_adequacy_id`)
) COMMENT 'Transactional record of network adequacy assessments and CMS/state regulatory filings documenting that a payers provider network meets time-and-distance and provider-to-member ratio standards. Captures network ID, payer ID, health plan ID, assessment period, specialty category assessed, geographic service area, required provider-to-member ratio, actual ratio, maximum time-to-appointment standard, actual average time-to-appointment, adequacy status (adequate, deficient), deficiency remediation plan, regulatory submission date, and regulatory body (CMS, state DOI). Supports network adequacy compliance and regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` (
    `formulary_tier_id` BIGINT COMMENT 'Unique identifier for the formulary tier record. Primary key for the formulary tier entity.',
    `formulary_id` BIGINT COMMENT 'Reference to the parent formulary that contains this tier structure. Links to the pharmacy formulary master data.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan to which this formulary tier structure applies. Links to the health plan master data.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Formulary tiers assign specific NDC drugs to cost-sharing levels (tier 1-4). Essential for pharmacy benefit administration, member cost calculation, and formulary management in payer pharmacy operatio',
    `primary_superseded_by_formulary_tier_id` BIGINT COMMENT 'Reference to the formulary tier record that replaces this tier structure. Used for tracking tier evolution and managing transitions during formulary updates. Null if this is the current active tier.',
    `cms_tier_category` STRING COMMENT 'CMS-defined tier category classification for Medicare Part D reporting and compliance. Maps internal tier structure to CMS standard tier definitions for regulatory submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this formulary tier record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_supply_mail_order` STRING COMMENT 'Standard number of days supply allowed per prescription fill for medications in this tier through mail order pharmacies. Typically 90 days to encourage mail order utilization.',
    `days_supply_standard` STRING COMMENT 'Standard number of days supply allowed per prescription fill for medications in this tier at retail pharmacies. Common values are 30, 60, or 90 days.',
    `deductible_applies` BOOLEAN COMMENT 'Indicates whether the plan deductible must be met before cost-sharing for this tier takes effect. True if deductible applies; False if tier cost-sharing is immediate.',
    `effective_date` DATE COMMENT 'Date when this formulary tier structure becomes active and applicable for member cost-sharing calculations. Aligns with benefit year or mid-year formulary updates.',
    `mail_order_eligible` BOOLEAN COMMENT 'Indicates whether medications in this tier are eligible for mail order pharmacy fulfillment, typically with extended days supply and potentially different cost-sharing. True if mail order is available; False otherwise.',
    `member_coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of the drug cost the member pays for medications in this tier. Represents percentage-based cost-sharing structure. Null if flat copay applies instead.',
    `member_communication_text` STRING COMMENT 'Standardized text used in member-facing communications to explain this tier, including Summary of Benefits and Coverage (SBC) documents, formulary guides, and member portals.',
    `member_copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the member pays per prescription fill for medications in this tier. Represents flat copayment cost-sharing structure. Null if coinsurance applies instead.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this formulary tier that does not fit into structured fields. Used for operational notes and exception documentation.',
    `out_of_pocket_applies` BOOLEAN COMMENT 'Indicates whether member cost-sharing for this tier counts toward the annual out-of-pocket maximum. True if costs accumulate toward OOP max; False otherwise.',
    `preferred_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier represents a preferred cost-sharing level, typically associated with lower member costs and plan-preferred medications. True for preferred tiers; False otherwise.',
    `preventive_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier is designated for preventive medications covered at zero or minimal cost-sharing under Affordable Care Act (ACA) preventive care requirements. True for preventive tiers; False otherwise.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether medications in this tier require prior authorization approval from the health plan before coverage is provided. True if PA is required; False otherwise.',
    `provider_communication_text` STRING COMMENT 'Standardized text used in provider-facing communications to explain this tier structure, cost-sharing rules, and utilization management requirements for prescribing decisions.',
    `quantity_limit_applies` BOOLEAN COMMENT 'Indicates whether medications in this tier are subject to quantity limits per fill or per time period. True if quantity limits apply; False otherwise. Specific limits are defined at the drug level.',
    `regulatory_approval_date` DATE COMMENT 'Date when the formulary tier structure received regulatory approval from CMS or other governing bodies. Null if no regulatory approval is required or if approval is pending.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this tier structure requires submission to regulatory bodies such as CMS for approval before implementation. True for Medicare Part D plans; may be False for commercial plans.',
    `retail_network_eligible` BOOLEAN COMMENT 'Indicates whether medications in this tier can be filled at retail network pharmacies. True if retail network access is available; False if restricted to specialty or mail order only.',
    `specialty_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier is designated for specialty medications, which typically have higher costs and may require special handling, distribution, or clinical management. True for specialty tiers; False otherwise.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether medications in this tier are subject to step therapy protocols, requiring members to try lower-cost alternatives before coverage is approved. True if step therapy applies; False otherwise.',
    `termination_date` DATE COMMENT 'Date when this formulary tier structure is no longer active. Null for open-ended tiers. Used for historical tracking and transition management during formulary updates.',
    `tier_code` STRING COMMENT 'Standardized code representing the formulary tier, used for system integration and claims processing. May align with NCPDP or internal coding standards.',
    `tier_description` STRING COMMENT 'Detailed explanation of the tier structure, including the types of medications covered, cost-sharing philosophy, and member guidance for understanding tier placement.',
    `tier_display_order` STRING COMMENT 'Numeric value controlling the display sequence of tiers in member-facing materials, formulary documents, and system interfaces. Lower values appear first.',
    `tier_name` STRING COMMENT 'Business-friendly name of the formulary tier that describes the category of medications and associated cost-sharing level. Common values include Generic, Preferred Brand, Non-Preferred Brand, Specialty, and Preventive.. Valid values are `Generic|Preferred Generic|Preferred Brand|Non-Preferred Brand|Specialty|Preventive`',
    `tier_number` STRING COMMENT 'Numeric sequence of the tier within the formulary structure, typically ranging from 1 (lowest cost-sharing) to 5 or 6 (highest cost-sharing). Used for ordering and display purposes.',
    `tier_status` STRING COMMENT 'Current lifecycle status of the formulary tier. Active tiers are in use for member cost-sharing; Inactive or Retired tiers are no longer applicable; Pending tiers are awaiting regulatory approval.. Valid values are `Active|Inactive|Pending|Retired|Suspended`',
    `tier_version` STRING COMMENT 'Version identifier for this tier structure configuration, used to track changes over time and manage mid-year formulary updates. Follows internal versioning conventions.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified this formulary tier record. Used for audit trail and accountability tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this formulary tier record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_formulary_tier PRIMARY KEY(`formulary_tier_id`)
) COMMENT 'Master record defining the pharmacy formulary tier structure for a health plan, establishing the cost-sharing tiers for covered medications. Captures health plan ID, formulary ID, tier number, tier name (Generic, Preferred Brand, Non-Preferred Brand, Specialty, Preventive), member copay amount, member coinsurance percentage, prior authorization requirement, step therapy requirement, quantity limit, and tier effective dates. Distinct from pharmacy.formulary which manages the drug-level formulary listing — this entity defines the tier structure and cost-sharing rules that govern member cost responsibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` (
    `premium_billing_id` BIGINT COMMENT 'Unique identifier for the premium billing invoice record. Primary key for the premium billing transaction.',
    `adjusted_premium_billing_id` BIGINT COMMENT 'Self-referencing FK on premium_billing (adjusted_premium_billing_id)',
    `employer_group_id` BIGINT COMMENT 'Reference to the employer group being billed for group health plan coverage. Null for individual or COBRA billing.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product for which premium is being billed.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or carrier issuing the health plan for which premium is being billed.',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber or primary member responsible for premium payment. Null for employer group billing.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustments applied to the premium billing such as retroactive enrollment changes, rate corrections, or credits from prior periods. Positive for additional charges, negative for credits. Expressed in USD.',
    `administrative_fee_amount` DECIMAL(18,2) COMMENT 'Additional administrative fee charged for premium processing, billing, or plan administration services. Expressed in USD.',
    `billing_address_line1` STRING COMMENT 'First line of the mailing address to which premium billing invoices and statements are sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing mailing address for suite, apartment, or additional address details.',
    `billing_city` STRING COMMENT 'City component of the billing mailing address.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact for electronic invoice delivery and payment correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the individual or organization contact responsible for premium payment and billing inquiries.',
    `billing_contact_phone` STRING COMMENT 'Phone number of the billing contact for premium payment inquiries and collection activities.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `billing_due_date` DATE COMMENT 'Date by which premium payment must be received to maintain active coverage and avoid grace period or lapse.',
    `billing_frequency` STRING COMMENT 'Frequency at which premium is billed to the responsible party: monthly, quarterly, semi-annually, or annually.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `billing_period_end_date` DATE COMMENT 'Last date of the coverage period for which premium is being billed.',
    `billing_period_start_date` DATE COMMENT 'First date of the coverage period for which premium is being billed.',
    `billing_postal_code` STRING COMMENT 'Postal code or ZIP code component of the billing mailing address.',
    `billing_state` STRING COMMENT 'State or province component of the billing mailing address. Two-letter state code for US addresses.',
    `billing_status` STRING COMMENT 'Current status of the premium billing invoice in its payment lifecycle: billed (invoice issued, payment pending), paid (fully paid), partially paid (partial payment received), delinquent (past due), lapsed (coverage terminated due to non-payment), cancelled (invoice voided), or refunded (payment returned). [ENUM-REF-CANDIDATE: billed|paid|partially_paid|delinquent|lapsed|cancelled|refunded — 7 candidates stripped; promote to reference product]',
    `billing_type` STRING COMMENT 'Classification of the premium billing arrangement indicating whether this is employer group, individual subscriber, COBRA continuation, Medicare Advantage, or Medicaid managed care billing.. Valid values are `employer_group|individual|cobra|medicare_advantage|medicaid_managed_care`',
    `cobra_premium_amount` DECIMAL(18,2) COMMENT 'Premium amount charged to COBRA participants, typically 102% of the group rate to cover administrative costs. Null for non-COBRA billing. Expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premium billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing record. Typically USD for US-based healthcare payers.. Valid values are `^[A-Z]{3}$`',
    `delinquency_date` DATE COMMENT 'Date on which this premium billing became delinquent due to non-payment past the due date. Null if payment is current or received.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Portion of the total premium paid by the employee or subscriber through payroll deduction or direct payment. Expressed in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Portion of the total premium paid by the employer group on behalf of enrolled members. Zero for individual and COBRA billing. Expressed in USD.',
    `enrolled_member_count` STRING COMMENT 'Total number of covered members (subscriber plus dependents) enrolled under this billing arrangement during the billing period.',
    `grace_period_end_date` DATE COMMENT 'Last date of the grace period during which coverage remains active despite non-payment. After this date, coverage may lapse. Typically 30-90 days per plan terms.',
    `invoice_generated_date` DATE COMMENT 'Date on which this premium billing invoice was generated and issued to the responsible party.',
    `invoice_number` STRING COMMENT 'Externally visible unique invoice number assigned to this premium billing statement for tracking and payment reconciliation.',
    `invoice_sent_date` DATE COMMENT 'Date on which the premium billing invoice was transmitted or mailed to the responsible party.',
    `lapse_date` DATE COMMENT 'Date on which health plan coverage lapsed or was terminated due to non-payment of premium. Null if coverage remains active or payment was received.',
    `net_premium_due` DECIMAL(18,2) COMMENT 'Net premium amount due after applying all contributions, subsidies, and adjustments. This is the amount the responsible party must remit. Expressed in USD.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this premium billing invoice, such as special payment arrangements, billing disputes, or administrative annotations.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this premium invoice after applying all payments. Zero indicates invoice is paid in full. Expressed in USD.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount of premium payment received and applied to this invoice. May differ from net premium due in cases of partial payment or overpayment. Expressed in USD.',
    `payment_method` STRING COMMENT 'Method by which premium payment was received: ACH, wire transfer, check, credit card, payroll deduction, or electronic funds transfer.. Valid values are `ach|wire_transfer|check|credit_card|payroll_deduction|electronic_funds_transfer`',
    `payment_received_date` DATE COMMENT 'Date on which premium payment was received and posted to the account. Null if payment has not been received.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier for the premium payment, such as check number, ACH trace number, or credit card authorization code.',
    `premium_rate_per_member` DECIMAL(18,2) COMMENT 'The per-member-per-month premium rate applied to calculate total premium for this billing period. Expressed in USD.',
    `reinstatement_eligible` BOOLEAN COMMENT 'Indicates whether the lapsed coverage is eligible for reinstatement upon payment of outstanding premium and any applicable fees. True if reinstatement is allowed per plan terms.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Government subsidy or premium tax credit amount applied to reduce the net premium owed by the subscriber. Applicable to exchange plans. Expressed in USD.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount billed for the coverage period before applying employer or subscriber contributions. Expressed in USD.',
    `updated_by` STRING COMMENT 'User identifier or system account that last updated this premium billing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this premium billing record was last modified or updated.',
    CONSTRAINT pk_premium_billing PRIMARY KEY(`premium_billing_id`)
) COMMENT 'Transactional record of premium billing invoices generated for employer groups, individual subscribers, and COBRA participants for health plan coverage. Captures billing period, employer group ID or subscriber ID, health plan ID, enrolled member count, premium rate per member, total premium billed, employer contribution amount, employee contribution amount, COBRA premium amount (102% of group rate), billing due date, payment received date, payment amount, outstanding balance, and billing status (billed, paid, partially paid, delinquent, lapsed). Supports premium revenue tracking and coverage lapse management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` (
    `payer_contact_id` BIGINT COMMENT 'Unique identifier for the payer contact record. Primary key for the payer contact entity.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization this contact represents. Links to the payer master record.',
    `primary_replacement_contact_payer_contact_id` BIGINT COMMENT 'Reference to the payer contact record that supersedes this contact. Used to maintain continuity when contacts are replaced or reorganized.',
    `accepts_electronic_submission` BOOLEAN COMMENT 'Indicates whether this contact accepts electronic document submission via portal, EDI, or email. True when electronic methods are supported.',
    `city` STRING COMMENT 'City name for the payer contacts mailing address.',
    `clearinghouse_name` STRING COMMENT 'Name of the clearinghouse intermediary used for electronic transactions with this payer contact. Applicable for EDI submission workflows.',
    `contact_name` STRING COMMENT 'Full name of the individual or department contact at the payer organization. May be a person name or department name depending on contact type.',
    `contact_status` STRING COMMENT 'Current operational status of this payer contact. Indicates whether the contact is currently available and should be used for outreach.. Valid values are `active|inactive|temporary|on_leave|replaced`',
    `contact_type` STRING COMMENT 'Functional area or department this contact serves. Categorizes the contact by their operational responsibility within the payer organization. [ENUM-REF-CANDIDATE: claims_submission|prior_authorization|provider_relations|credentialing|network_contracting|edi_clearinghouse|appeals|member_services|utilization_management|quality_reporting|billing_inquiries|technical_support — promote to reference product]. Valid values are `claims_submission|prior_authorization|provider_relations|credentialing|network_contracting|edi_clearinghouse`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the payer contacts mailing address. Primarily USA for domestic payers.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payer contact record was first created in the system. Supports audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when this payer contact became active and available for operational use. Marks the start of the contacts validity period.',
    `email_address` STRING COMMENT 'Email address for electronic communication with this payer contact. Used for non-urgent inquiries, document exchange, and operational correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_flag` BOOLEAN COMMENT 'Indicates whether this contact should be used for escalated issues or urgent matters. True for supervisory or management contacts designated for escalation workflows.',
    `fax_number` STRING COMMENT 'Fax number for document transmission to this payer contact. Commonly used for prior authorization submissions and medical records transmission.',
    `hours_of_operation` STRING COMMENT 'Business hours during which this payer contact is available for communication. Typically includes days of week and time ranges with time zone.',
    `language_preference` STRING COMMENT 'Primary language for communication with this payer contact. Supports multilingual provider relations and operational workflows.. Valid values are `English|Spanish|French|Chinese|Vietnamese|Korean`',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this payer contact. Used to track contact currency and relationship maintenance.',
    `last_verified_date` DATE COMMENT 'Date when the contact information was last verified as accurate and current. Supports data quality and contact maintenance workflows.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address for this payer contact. Used for physical mail correspondence and document submission.',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address including suite, department, or unit information for the payer contact.',
    `notes` STRING COMMENT 'Free-text field for additional information about this payer contact. May include special instructions, communication preferences, or operational context.',
    `npi` STRING COMMENT 'National Provider Identifier for the payer organization or contact entity. Used for identification in HIPAA-compliant transactions.. Valid values are `^[0-9]{10}$`',
    `phone_extension` STRING COMMENT 'Telephone extension number for direct routing to the contact within the payer organizations phone system.',
    `phone_number` STRING COMMENT 'Primary telephone number to reach this payer contact. Used for operational outreach including claims inquiries, prior authorization submissions, and provider relations.',
    `portal_login_instructions` STRING COMMENT 'Special instructions or notes for accessing the payer portal associated with this contact. May include registration requirements or access procedures.',
    `portal_url` STRING COMMENT 'Web address for the payers online portal or system associated with this contact function. Used for electronic submissions and inquiries.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the payer contacts mailing address. May include ZIP+4 format.',
    `preferred_contact_method` STRING COMMENT 'The payer contacts preferred communication channel for routine inquiries and operational workflows. Guides provider staff on optimal outreach method.. Valid values are `phone|email|fax|portal|mail`',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this is the primary or default contact for the specified contact type at this payer. True when this contact should be used first for the given function.',
    `requires_appointment` BOOLEAN COMMENT 'Indicates whether this contact requires scheduled appointments for meetings or calls. True when advance scheduling is necessary.',
    `service_level_agreement_days` STRING COMMENT 'Number of business days within which this contact commits to respond to inquiries or requests. Defines expected turnaround time for operational workflows.',
    `state` STRING COMMENT 'Two-letter state or territory code for the payer contacts mailing address. Follows USPS state abbreviation standards.',
    `termination_date` DATE COMMENT 'Date when this payer contact was deactivated or replaced. Null for currently active contacts. Marks the end of the contacts validity period.',
    `termination_reason` STRING COMMENT 'Explanation for why this payer contact was deactivated. May include staff departure, role change, department reorganization, or contact consolidation.',
    `time_zone` STRING COMMENT 'Time zone for the payer contacts business hours. Used to coordinate communication timing across geographic regions.. Valid values are `EST|CST|MST|PST|AKST|HST`',
    `title` STRING COMMENT 'Job title or role designation of the contact person within the payer organization. Provides context for the contacts authority and scope.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last modified this payer contact record. Supports audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payer contact record was last modified. Tracks the most recent change to any field in the record.',
    `verification_method` STRING COMMENT 'Method used to verify the accuracy of this contact information during the last verification cycle. Documents the validation approach.. Valid values are `phone_call|email_confirmation|portal_update|payer_notification|manual_review`',
    CONSTRAINT pk_payer_contact PRIMARY KEY(`payer_contact_id`)
) COMMENT 'Master record for operational contacts at insurance payers, capturing the individuals and departments responsible for specific payer functions. Captures payer ID, contact type (claims submission, prior authorization, provider relations, credentialing, network contracting, EDI/clearinghouse, appeals, member services), contact name, title, phone number, fax number, email address, mailing address, hours of operation, and preferred contact method. Supports operational workflows requiring payer outreach for claims resolution, PA submission, and contract negotiations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` (
    `vbc_performance_id` BIGINT COMMENT 'Unique identifier for the value-based care performance measurement record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: Value-based care performance is measured at provider group level for shared savings/losses, quality scores, and TCOC benchmarking. Essential for VBC settlement calculations and performance reporting. ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: VBC performance measured for organizational providers in bundled payment and episode-based arrangements (e.g., hospital joint replacement bundles). Critical for facility-level VBC settlement and quali',
    `payer_contract_id` BIGINT COMMENT 'Reference to the value-based care contract under which this performance is measured.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan associated with this VBC performance measurement.',
    `prior_vbc_performance_id` BIGINT COMMENT 'Self-referencing FK on vbc_performance (prior_vbc_performance_id)',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: VBC performance is measured against quality programs (MIPS, MSSP, Hospital VBP). Quality program defines the measure set, scoring methodology, and payment adjustment formula for VBC contracts.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Value-based care shared savings and losses are allocated to specific cost centers for performance reporting, budget variance analysis, and departmental accountability. Finance teams track VBC settleme',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustments made to the performance calculation or settlement amounts after initial calculation.',
    `attributed_member_count` STRING COMMENT 'The total number of health plan members attributed to the provider organization for this performance period under the VBC contract.',
    `benchmark_tcoc_amount` DECIMAL(18,2) COMMENT 'The target or benchmark total cost of care established by the payer for the attributed population, used to calculate savings or losses.',
    `calculation_methodology` STRING COMMENT 'Description of the methodology used to calculate performance metrics, savings, and quality scores for this measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC performance record was first created in the system.',
    `data_completeness_score` DECIMAL(18,2) COMMENT 'A score representing the completeness and quality of data submitted for performance measurement, expressed as a percentage.',
    `dispute_date` DATE COMMENT 'The date on which the provider organization formally disputed the performance settlement.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the provider organization has disputed the performance calculation or settlement amounts.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute was resolved between the payer and provider organization.',
    `measurement_year` STRING COMMENT 'The calendar year in which the performance measurement period falls, used for reporting and trending.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this VBC performance measurement record.',
    `performance_period_end_date` DATE COMMENT 'The ending date of the measurement period for this VBC performance evaluation.',
    `performance_period_start_date` DATE COMMENT 'The beginning date of the measurement period for this VBC performance evaluation.',
    `performance_year_type` STRING COMMENT 'The type of year used for performance measurement: calendar year, contract year, or benefit year.. Valid values are `calendar_year|contract_year|benefit_year`',
    `quality_measure_set` STRING COMMENT 'The specific set of quality measures used to evaluate performance (e.g., HEDIS, MIPS, ACO quality measures).',
    `quality_score` DECIMAL(18,2) COMMENT 'The composite quality performance score achieved during the measurement period, typically expressed as a percentage or points out of 100.',
    `quality_withhold_amount` DECIMAL(18,2) COMMENT 'The dollar amount withheld by the payer from shared savings distribution pending achievement of quality performance thresholds.',
    `quality_withhold_earned_amount` DECIMAL(18,2) COMMENT 'The portion of the quality withhold amount earned back by the provider organization based on achieved quality performance.',
    `quality_withhold_forfeited_amount` DECIMAL(18,2) COMMENT 'The portion of the quality withhold amount forfeited due to failure to meet quality performance thresholds.',
    `reconciliation_period` STRING COMMENT 'The frequency at which performance is measured and reconciled under the VBC contract: quarterly, semi-annual, or annual.. Valid values are `quarterly|semi_annual|annual`',
    `reporting_entity` STRING COMMENT 'The name or identifier of the entity responsible for reporting this VBC performance data (e.g., ACO, medical group, hospital system).',
    `risk_arrangement_type` STRING COMMENT 'The type of financial risk arrangement under the VBC contract: one-sided (upside only), two-sided (upside and downside), or other risk-sharing model.. Valid values are `one_sided|two_sided|upside_only|downside_risk`',
    `risk_corridor_applied_flag` BOOLEAN COMMENT 'Indicates whether risk corridor provisions were applied to limit the provider organizations financial exposure to savings or losses.',
    `risk_corridor_lower_threshold_amount` DECIMAL(18,2) COMMENT 'The minimum savings or loss amount that must be achieved before shared savings or losses are triggered, as defined in the contract.',
    `risk_corridor_upper_threshold_amount` DECIMAL(18,2) COMMENT 'The maximum savings or loss amount beyond which additional savings or losses are capped or shared at a different rate.',
    `savings_loss_amount` DECIMAL(18,2) COMMENT 'The calculated difference between benchmark TCOC and actual TCOC. Positive values indicate savings; negative values indicate losses.',
    `settlement_approval_date` DATE COMMENT 'The date on which the settlement calculation was approved by both the payer and provider organization for payment processing.',
    `settlement_calculation_date` DATE COMMENT 'The date on which the performance settlement amounts were calculated by the payer or third-party administrator.',
    `settlement_payment_date` DATE COMMENT 'The date on which the shared savings distribution or loss payment was processed and funds were transferred.',
    `settlement_payment_method` STRING COMMENT 'The method used to transfer settlement funds: electronic funds transfer (EFT), check, wire transfer, or offset against other payments.. Valid values are `eft|check|wire_transfer|offset`',
    `settlement_status` STRING COMMENT 'The current status of the performance settlement process: pending calculation, calculated, approved for payment, paid, disputed, or adjusted.. Valid values are `pending|calculated|approved|paid|disputed|adjusted`',
    `shared_loss_amount` DECIMAL(18,2) COMMENT 'The dollar amount of losses for which the provider organization is financially responsible under a two-sided risk arrangement.',
    `shared_loss_percentage` DECIMAL(18,2) COMMENT 'The percentage of total losses for which the provider organization is responsible as defined in the VBC contract terms.',
    `shared_savings_distribution_amount` DECIMAL(18,2) COMMENT 'The final dollar amount of shared savings distributed to the provider organization after applying quality adjustments and risk corridor rules.',
    `shared_savings_percentage` DECIMAL(18,2) COMMENT 'The percentage of total savings shared with the provider organization as defined in the VBC contract terms.',
    `stop_loss_applied_flag` BOOLEAN COMMENT 'Indicates whether stop-loss provisions were triggered to limit the provider organizations financial exposure to catastrophic losses.',
    `stop_loss_threshold_amount` DECIMAL(18,2) COMMENT 'The maximum loss amount the provider organization is responsible for before stop-loss protection is activated.',
    `total_cost_of_care_amount` DECIMAL(18,2) COMMENT 'The actual total cost of care incurred for attributed members during the performance period, including all medical and pharmacy claims.',
    `updated_by` STRING COMMENT 'The user or system identifier that last modified this VBC performance record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC performance record was last modified in the system.',
    CONSTRAINT pk_vbc_performance PRIMARY KEY(`vbc_performance_id`)
) COMMENT 'Transactional record capturing performance measurement results under value-based care (VBC) contracts, including shared savings calculations, quality measure performance, and risk pool settlements. Captures contract ID, payer ID, performance period, attributed member count, total cost of care (TCOC), benchmark TCOC, savings/loss amount, quality score, quality withhold earned/forfeited, shared savings distribution amount, risk corridor application, settlement status, and settlement payment date. Supports VBC contract performance monitoring, shared savings reconciliation, and population health financial management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` (
    `member_attribution_id` BIGINT COMMENT 'Unique identifier for the member attribution record. Primary key for this transactional entity tracking value-based care and ACO attribution assignments.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Attributed member panels drive cost center revenue forecasting and budget planning in capitated and value-based arrangements. Finance teams use attribution data to allocate capitation revenue, forecas',
    `care_team_id` BIGINT COMMENT 'Identifier for the care team to which the member is attributed, if attribution is at the team level rather than individual provider level.',
    `health_plan_id` BIGINT COMMENT 'Identifier for the specific health plan under which the member is attributed.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Value-based care attribution assigns patients to providers for ACO/MSSP quality and cost accountability. Business process: attribution rosters for shared savings programs require patient identity link',
    `payer_contract_id` BIGINT COMMENT 'Identifier for the value-based care, ACO, or managed care contract governing this attribution. May reference capitation or VBC contract.',
    `payer_id` BIGINT COMMENT 'Identifier for the insurance payer responsible for this attribution arrangement.',
    `clinician_id` BIGINT COMMENT 'Identifier for the primary care provider or care team to whom the member is attributed for performance measurement and capitation purposes.',
    `prior_member_attribution_id` BIGINT COMMENT 'Self-referencing FK on member_attribution (prior_member_attribution_id)',
    `quality_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_program. Business justification: Member attribution determines which provider is accountable for quality program performance (ACO, PCMH, VBC). Attribution method and eligibility criteria are defined by the quality program.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the health plan member being attributed. Links to the member master data.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to encounter.visit. Business justification: Attribution algorithms use visit patterns (plurality of care) to assign members to providers. Performance measurement and shared savings calculations require linking attribution records to specific en',
    `assignment_reason` STRING COMMENT 'Free-text or coded reason explaining why the member was attributed to this provider. Examples include highest visit count, patient selection, geographic proximity, or continuity of care.',
    `attributed_provider_npi` STRING COMMENT 'National Provider Identifier of the attributed primary care provider. Ten-digit unique identifier assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `attribution_algorithm_version` STRING COMMENT 'Version identifier of the attribution algorithm or business rules used to calculate this attribution assignment. Used for audit trail and reproducibility.',
    `attribution_change_reason` STRING COMMENT 'Reason for change in attribution from previous provider to current provider. Examples include member request, provider termination, change in utilization pattern, or annual re-attribution.',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'Numeric score representing the confidence level or strength of the attribution assignment, typically ranging from 0.00 to 100.00. Higher scores indicate stronger attribution based on visit frequency, continuity of care, or other factors.',
    `attribution_effective_date` DATE COMMENT 'Date when the member attribution assignment becomes effective and the attributed provider assumes responsibility for care coordination and performance measurement.',
    `attribution_end_date` DATE COMMENT 'Date when the member attribution assignment ends. Null for open-ended attributions. May be populated due to member disenrollment, provider termination, or contract end.',
    `attribution_lock_date` DATE COMMENT 'Date when the attribution assignment was locked for the performance year and can no longer be changed. Used to ensure stable attribution for performance measurement.',
    `attribution_method` STRING COMMENT 'Method used to assign the member to the attributed provider. Prospective attribution occurs before the performance period; retrospective attribution occurs after using claims data; voluntary attribution is patient-selected; claims-based uses utilization patterns; enrollment-based uses plan enrollment data; patient-designated is explicit patient choice; hybrid combines multiple methods. [ENUM-REF-CANDIDATE: prospective|retrospective|voluntary|claims_based|enrollment_based|patient_designated|hybrid — 7 candidates stripped; promote to reference product]',
    `attribution_period_end_date` DATE COMMENT 'End date of the measurement period used to calculate the attribution assignment. Typically the end of the performance year or lookback period.',
    `attribution_period_start_date` DATE COMMENT 'Start date of the measurement period used to calculate the attribution assignment. Typically the beginning of the performance year or lookback period.',
    `attribution_source` STRING COMMENT 'Source system or method that generated the attribution assignment. Claims-based uses historical utilization; enrollment-based uses plan enrollment data; patient-designated is explicit patient selection; provider-roster uses provider panel lists; ACO-assignment is CMS ACO attribution; manual-override is administrative assignment; system-calculated is algorithmic. [ENUM-REF-CANDIDATE: claims_based|enrollment_based|patient_designated|provider_roster|aco_assignment|manual_override|system_calculated — 7 candidates stripped; promote to reference product]',
    `attribution_status` STRING COMMENT 'Current lifecycle status of the attribution assignment. Active indicates the attribution is currently in effect; inactive indicates it is no longer valid; pending indicates it is awaiting approval or effective date; terminated indicates it was ended; suspended indicates temporary hold.. Valid values are `active|inactive|pending|terminated|suspended`',
    `attribution_type` STRING COMMENT 'Type of value-based care or managed care program under which the attribution is made. ACO is Accountable Care Organization; MSSP is Medicare Shared Savings Program; NextGen ACO is Next Generation ACO Model; managed care is HMO/PPO attribution; capitation is capitated payment model; VBC is value-based care contract; PCMH is Patient-Centered Medical Home; bundled payment is episode-based attribution. [ENUM-REF-CANDIDATE: aco|mssp|nextgen_aco|managed_care|capitation|vbc|pcmh|bundled_payment — 8 candidates stripped; promote to reference product]',
    `capitation_amount` DECIMAL(18,2) COMMENT 'Per-member per-month (PMPM) or per-member per-year (PMPY) capitation payment amount for this attributed member under the contract. Null if the contract is not capitated.',
    `capitation_frequency` STRING COMMENT 'Frequency at which capitation payments are made for this attributed member. Monthly is per-member per-month; quarterly is per-member per-quarter; annually is per-member per-year.. Valid values are `monthly|quarterly|annually`',
    `county_code` STRING COMMENT 'Five-digit FIPS county code where the member resides. Used for county-level performance reporting and geographic analysis.. Valid values are `^[0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution record was first created in the system. Used for audit trail and data lineage.',
    `geographic_service_area` STRING COMMENT 'Geographic region or service area code where the member resides and receives care. Used for network adequacy and regional performance reporting.',
    `notes` STRING COMMENT 'Free-text notes or comments about this attribution assignment. Used for documenting special circumstances, manual overrides, or additional context.',
    `opt_out_date` DATE COMMENT 'Date when the member opted out of attribution or data sharing. Null if opt-out indicator is false.',
    `opt_out_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the member has opted out of attribution or data sharing for performance measurement. True indicates opt-out; false indicates consent.',
    `performance_year` STRING COMMENT 'Calendar year for which this attribution is used for performance measurement and shared savings calculation. Four-digit year (e.g., 2023).',
    `plurality_of_care_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the attributed provider delivered a plurality (most) of the members primary care services during the measurement period. True indicates plurality was met; false indicates it was not.',
    `primary_care_visit_count` STRING COMMENT 'Number of primary care visits the member had with the attributed provider during the attribution measurement period. Used to calculate plurality and attribution strength.',
    `quality_measure_set` STRING COMMENT 'Name or identifier of the quality measure set applicable to this attribution for performance measurement. Examples include MSSP quality measures, HEDIS measures, or custom contract measures.',
    `risk_score` DECIMAL(18,2) COMMENT 'Hierarchical Condition Category (HCC) risk score or other risk adjustment score for the member at the time of attribution. Used for risk-adjusted performance measurement and capitation payment calculation.',
    `shared_savings_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this attributed member is eligible for inclusion in shared savings calculations. True indicates eligible; false indicates excluded (e.g., due to insufficient claims history or enrollment duration).',
    `state_code` STRING COMMENT 'Two-letter US state code where the member resides. Used for state-level reporting and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `tin` STRING COMMENT 'Tax Identification Number of the provider organization or practice to which the member is attributed. Used for payment and performance reporting at the TIN level.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `total_visit_count` STRING COMMENT 'Total number of primary care visits the member had with all providers during the attribution measurement period. Used to calculate plurality percentage.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this attribution record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this attribution record was last updated. Used for audit trail and change tracking.',
    CONSTRAINT pk_member_attribution PRIMARY KEY(`member_attribution_id`)
) COMMENT 'Transactional record of member attribution assignments under value-based care, ACO, and managed care contracts, linking members to a responsible primary care provider or care team for performance measurement and capitation purposes. Captures member ID, payer ID, health plan ID, capitation or VBC contract ID, attributed PCP NPI, attribution method (prospective, retrospective, voluntary), attribution effective date, attribution end date, attribution confidence score, plurality of care indicator, and attribution source (claims-based, enrollment-based, patient-designated). SSOT for VBC attributed population management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` (
    `insurance_payer_enrollment_id` BIGINT COMMENT 'Primary key for the payer_enrollment association',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to the clinician enrolled with this payer',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - payer enrollment is site-specific but insurance_payer_enrollment lacks a care_site FK',
    `payer_id` BIGINT COMMENT 'Foreign key linking to the payer with whom the clinician is enrolled',
    `provider_payer_enrollment_id` BIGINT COMMENT 'FK to SSOT owner provider.provider_payer_enrollment for the payer_enrollment entity.',
    `credentialing_status` STRING COMMENT 'Status of the payer-specific credentialing review for this clinician. Distinct from the clinicians internal credentialing_status - this reflects the payers own credentialing decision.',
    `effective_date` DATE COMMENT 'Date on which this clinicians enrollment with this payer became or will become active for billing purposes.',
    `enrollment_number` STRING COMMENT 'Unique identifier assigned by the payer to this specific clinician enrollment. Used in claim submissions and eligibility verification.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this clinicians enrollment with this specific payer. Determines billing eligibility and claim submission rights.',
    `network_tier` STRING COMMENT 'The network participation tier assigned to this clinician by this payer. Determines reimbursement rates and patient cost-sharing levels.',
    `ptan` STRING COMMENT 'CMS-issued PTAN (Provider Transaction Access Number) for Medicare billing. Specific to this clinician-payer enrollment relationship.',
    `termination_date` DATE COMMENT 'Date on which this clinicians enrollment with this payer ended or will end. Null for active enrollments.',
    CONSTRAINT pk_insurance_payer_enrollment PRIMARY KEY(`insurance_payer_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between a clinician and an insurance payer. It captures the operational enrollment status, credentialing requirements, network participation tier, and provider-specific identifiers (PTAN, enrollment number) that exist only in the context of this clinician-payer relationship. Each record links one clinician to one payer with attributes that govern billing eligibility, claim submission rights, and network participation terms.. Existence Justification: In healthcare operations, clinicians must enroll with multiple insurance payers (Medicare, Medicaid, commercial plans) to bill for services, and each payer maintains enrollment relationships with thousands of clinicians across their network. The enrollment relationship is an operational business entity actively managed by credentialing and billing departments, with payer-specific identifiers (PTAN, enrollment numbers), credentialing approvals, network tier assignments, and lifecycle status tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` (
    `payer_compliance_requirement_id` BIGINT COMMENT 'Unique identifier for this payer-program compliance requirement record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program that governs this payer relationship',
    `payer_id` BIGINT COMMENT 'Foreign key linking to the payer subject to this compliance program',
    `audit_frequency` STRING COMMENT 'Frequency at which compliance audits specific to this payer-program combination must be conducted. May be driven by payer contract terms or regulatory requirements specific to the payer type (e.g., Medicare requires annual HIPAA audits).',
    `compliance_status` STRING COMMENT 'Current compliance status for this payer under this program. Tracks whether the organization is meeting all requirements for this specific payer-program combination.',
    `findings_count` STRING COMMENT 'Number of open compliance findings or deficiencies identified for this payer under this program. Used to track remediation progress.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted for this specific payer-program combination.',
    `last_report_date` DATE COMMENT 'Date when the most recent compliance report was submitted for this payer-program combination.',
    `last_status_change_date` DATE COMMENT 'Date when the compliance_status was last updated for this payer-program combination.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit for this payer-program combination, calculated based on audit_frequency and last_audit_date.',
    `next_report_due_date` DATE COMMENT 'Date by which the next compliance report must be submitted for this payer-program combination.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, historical issues, or special considerations for this payer-program compliance relationship.',
    `payer_program_scope` STRING COMMENT 'Detailed description of how this compliance program applies specifically to this payer relationship. May include specific service lines, facilities, or transaction types covered (e.g., Applies to all Medicare Advantage claims submitted through EDI; excludes paper claims).',
    `payer_specific_requirements` STRING COMMENT 'Free-text field capturing any additional compliance requirements, attestations, certifications, or documentation that this specific payer requires beyond the standard program requirements. Examples: Payer requires quarterly attestation from Chief Compliance Officer, Annual HIPAA certification required for provider portal access.',
    `program_effective_date` DATE COMMENT 'Date when this compliance program became applicable to this specific payer relationship. May differ from the general program effective date if the payer contract was signed later or requirements phased in.',
    `program_expiration_date` DATE COMMENT 'Date when this compliance program ceases to apply to this payer, typically aligned with contract termination or regulatory sunset provisions.',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to this payer or regulatory body overseeing this payer relationship.',
    `reporting_requirements` STRING COMMENT 'Detailed description of compliance reporting obligations specific to this payer under this program. Includes report types, submission frequency, recipient (payer, CMS, state agency), and format requirements.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or department responsible for ensuring compliance with this program for this specific payer relationship. May be a payer relationship manager, compliance officer, or department head.',
    CONSTRAINT pk_payer_compliance_requirement PRIMARY KEY(`payer_compliance_requirement_id`)
) COMMENT 'This association product represents the compliance obligations between a specific payer relationship and a compliance program. It captures payer-specific compliance requirements, audit schedules, reporting obligations, and program scope as they apply to each unique payer-program combination. Each record links one compliance program to one payer with attributes that exist only in the context of this regulatory relationship.. Existence Justification: Healthcare organizations must apply multiple compliance programs (HIPAA, Stark Law, Anti-Kickback, False Claims Act, Medicare Conditions of Participation) across their entire payer portfolio, and each payer relationship is governed by multiple overlapping compliance programs. The compliance requirements, audit schedules, reporting obligations, and program scope vary by payer type (Medicare vs. commercial vs. Medicaid) and by specific contract terms, creating a genuine many-to-many operational relationship that compliance teams actively manage.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` (
    `plan_consent_requirement_id` BIGINT COMMENT 'Unique identifier for this plan consent requirement record. Primary key.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to the consent form template required by this health plan',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to the health insurance plan that has this consent requirement',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this plan consent requirement record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this consent form became required for this health plan. Typically aligns with benefit year start, regulatory change effective date, or plan amendment date.',
    `enrollment_trigger_flag` BOOLEAN COMMENT 'Indicates whether this consent form must be presented and completed during the initial enrollment process for this health plan. True means the form is part of the enrollment workflow.',
    `last_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this plan consent requirement record.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this plan consent requirement record was last modified.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this consent form is mandatory (true) or optional (false) for members of this health plan. Mandatory forms must be completed before enrollment can be finalized or services accessed.',
    `renewal_trigger_flag` BOOLEAN COMMENT 'Indicates whether this consent form must be re-presented and re-signed during annual plan renewal. True means members must re-consent each benefit year.',
    `requirement_basis` STRING COMMENT 'The legal or business basis for why this consent form is required for this plan. Values: federal_regulation (HIPAA, ACA mandate), state_law (state-specific consent requirements), plan_policy (payer business rule), payer_requirement (employer group requirement), accreditation_standard (NCQA, URAC requirement).',
    `requirement_notes` STRING COMMENT 'Free-text notes explaining special circumstances, exceptions, or additional context about why this consent form is required for this plan or how the requirement should be applied.',
    `termination_date` DATE COMMENT 'Date when this consent form is no longer required for this health plan. May occur due to regulatory changes, plan redesign, or form supersession by a newer version.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this plan consent requirement record.',
    CONSTRAINT pk_plan_consent_requirement PRIMARY KEY(`plan_consent_requirement_id`)
) COMMENT 'This association product represents the regulatory and operational requirement linking health insurance plans to the specific consent form templates that members must complete. It captures when each consent form became required for a plan, whether the consent is mandatory for enrollment or optional, and the business rules governing when the form must be presented (at enrollment, renewal, or triggered by specific events). Each record links one health_plan to one consent_form_template with attributes that exist only in the context of this plan-specific consent requirement.. Existence Justification: In healthcare operations, health insurance plans require multiple consent forms to comply with federal regulations (HIPAA), state laws, treatment protocols, and specialized services (telehealth, genetic testing, research participation). Conversely, a single consent form template (e.g., HIPAA authorization) applies across multiple health plans offered by different payers and plan types. Plan administrators actively manage these requirements, specifying which forms are mandatory vs optional, when they must be presented (enrollment, renewal, or event-triggered), and the regulatory basis for each requirement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key for broker',
    `payer_id` BIGINT COMMENT 'add column insurance_payer_id (BIGINT) with FK to insurance.payer.payer_id - broker has only a self-ref and inbound from employer_group; brokers represent payers and need this link',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `address_line_1` STRING COMMENT 'Primary street address line for the brokers business location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, unit, or building information.',
    `appointment_date` DATE COMMENT 'Date when the broker was formally appointed to sell the healthcare organizations insurance products.',
    `appointment_status` STRING COMMENT 'Status indicating whether the broker is formally appointed to represent the healthcare organizations insurance products.',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the broker.',
    `background_check_status` STRING COMMENT 'Status of the background check conducted on the broker for compliance and risk management purposes.',
    `city` STRING COMMENT 'City name for the brokers business address.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate percentage paid to the broker for new business sales.',
    `compliance_training_completion_date` DATE COMMENT 'Date when the broker completed required compliance and regulatory training programs.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the brokers business address.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the broker record was first created in the system.',
    `doing_business_as_name` STRING COMMENT 'Trade name or fictitious business name under which the broker operates, if different from legal name.',
    `errors_and_omissions_coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage amount in US dollars for the brokers errors and omissions liability insurance policy.',
    `errors_and_omissions_expiration_date` DATE COMMENT 'Expiration date of the brokers errors and omissions liability insurance policy.',
    `errors_and_omissions_insurance_carrier` STRING COMMENT 'Name of the insurance carrier providing errors and omissions liability coverage for the broker.',
    `errors_and_omissions_policy_number` STRING COMMENT 'Policy number for the brokers errors and omissions liability insurance coverage.',
    `hipaa_certification_date` DATE COMMENT 'Date when the broker completed HIPAA privacy and security certification training.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the broker is currently active and eligible to transact business.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the broker record was most recently updated in the system.',
    `legal_name` STRING COMMENT 'The official legal name of the broker or brokerage firm as registered with regulatory authorities.',
    `license_expiration_date` DATE COMMENT 'Date when the brokers primary insurance producer license expires and requires renewal.',
    `license_issue_date` DATE COMMENT 'Date when the brokers primary insurance producer license was originally issued.',
    `license_number` STRING COMMENT 'Primary state-issued insurance producer license number for the brokers home state of domicile.',
    `license_state` STRING COMMENT 'Two-letter state code where the broker holds their primary insurance producer license.',
    `market_segment` STRING COMMENT 'Primary market segment or line of business that the broker specializes in selling.',
    `national_producer_number` STRING COMMENT 'Unique 10-digit identifier assigned by the National Insurance Producer Registry (NIPR) to licensed insurance producers and brokers in the United States.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or important information about the broker.',
    `override_commission_rate_percentage` DECIMAL(18,2) COMMENT 'Additional override commission rate percentage for managing general agents or agency principals.',
    `payment_method` STRING COMMENT 'Preferred method for disbursing commission payments to the broker.',
    `performance_tier` STRING COMMENT 'Performance classification tier assigned to the broker based on sales volume and quality metrics.',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the brokers business address.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the brokerage firm for operational communications.',
    `primary_email` STRING COMMENT 'Primary email address for official communications with the broker or brokerage firm.',
    `primary_phone` STRING COMMENT 'Primary telephone number for contacting the broker or brokerage firm.',
    `secondary_phone` STRING COMMENT 'Alternate telephone number for contacting the broker, such as mobile or fax.',
    `state` STRING COMMENT 'Two-letter state code for the brokers business address.',
    `broker_status` STRING COMMENT 'Current operational status of the broker within the healthcare organizations network.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (FEIN) or Social Security Number (SSN) for tax reporting purposes.',
    `termination_date` DATE COMMENT 'Date when the brokers appointment or relationship with the healthcare organization was terminated.',
    `termination_reason` STRING COMMENT 'Explanation or code describing the reason for termination of the broker relationship.',
    `territory_code` STRING COMMENT 'Geographic territory or region code assigned to the broker for sales and service responsibilities.',
    `broker_type` STRING COMMENT 'Classification of the broker entity based on organizational structure and business model.',
    `website_url` STRING COMMENT 'Official website address of the broker or brokerage firm.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master reference table for broker. Referenced by broker_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` (
    `third_party_administrator_id` BIGINT COMMENT 'Primary key for third_party_administrator',
    `payer_id` BIGINT COMMENT 'Unique payer identification number used in electronic data interchange (EDI) transactions for claims and eligibility verification.',
    `parent_third_party_administrator_id` BIGINT COMMENT 'Self-referencing FK on third_party_administrator (parent_third_party_administrator_id)',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the TPA from recognized healthcare quality organizations such as NCQA, URAC, or AAAHC.',
    `address_line_1` STRING COMMENT 'First line of the TPAs primary business address including street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the TPAs business address for suite, floor, or building information.',
    `business_continuity_plan_verified` BOOLEAN COMMENT 'Indicates whether the TPAs business continuity and disaster recovery plan has been reviewed and verified to meet healthcare organization requirements.',
    `city` STRING COMMENT 'City name of the TPAs primary business location.',
    `claims_processing_capability` BOOLEAN COMMENT 'Indicates whether the TPA has the capability and authorization to process medical and pharmacy claims on behalf of the health plan.',
    `claims_submission_address` STRING COMMENT 'Mailing address where paper claims should be submitted to the TPA for processing.',
    `contract_effective_date` DATE COMMENT 'Date when the administrative services agreement between the healthcare organization and the TPA became effective.',
    `contract_termination_date` DATE COMMENT 'Date when the administrative services agreement with the TPA is scheduled to terminate or was actually terminated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the TPAs primary business location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the TPA record was first created in the master data management system.',
    `customer_service_phone` STRING COMMENT 'Toll-free or direct phone number for member and provider customer service inquiries handled by the TPA.',
    `data_breach_history` STRING COMMENT 'Summary of any reported data breaches or security incidents involving the TPA including dates, scope, and remediation actions taken.',
    `financial_rating` STRING COMMENT 'Credit or financial strength rating assigned to the TPA by independent rating agencies such as AM Best, Moodys, or Standard & Poors.',
    `hipaa_compliance_certified` BOOLEAN COMMENT 'Indicates whether the TPA has been certified as compliant with HIPAA privacy and security regulations through independent audit or attestation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the TPA record was most recently modified in the master data management system.',
    `last_verification_date` DATE COMMENT 'Date when the TPA information was last verified for accuracy and completeness through outreach or data quality review process.',
    `license_effective_date` DATE COMMENT 'Date when the TPAs license became effective and the TPA was authorized to begin operations.',
    `license_expiration_date` DATE COMMENT 'Date when the TPAs current license expires and must be renewed to continue operations.',
    `license_number` STRING COMMENT 'State-issued license number authorizing the TPA to conduct administrative services for health plans in the jurisdiction.',
    `license_state` STRING COMMENT 'State or jurisdiction that issued the TPA license using standard two-letter state abbreviations.',
    `member_services_capability` BOOLEAN COMMENT 'Indicates whether the TPA provides member-facing services including enrollment support, benefit inquiries, and grievance handling.',
    `national_provider_identifier` STRING COMMENT 'Ten-digit NPI assigned to the TPA if registered as a healthcare entity under HIPAA administrative simplification standards.',
    `network_management_capability` BOOLEAN COMMENT 'Indicates whether the TPA manages provider networks including credentialing, contracting, and network adequacy monitoring.',
    `notes` STRING COMMENT 'Free-text field for capturing additional administrative notes, special instructions, or contextual information about the TPA relationship.',
    `parent_organization_name` STRING COMMENT 'Name of the parent company or holding organization if the TPA is a subsidiary or division of a larger corporate entity.',
    `performance_guarantee_terms` STRING COMMENT 'Description of contractual performance guarantees and service level agreements (SLAs) the TPA must meet including claims turnaround time, accuracy rates, and customer service metrics.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the TPAs primary business address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the TPA for electronic communication and notifications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the TPA organization for operational coordination and issue resolution.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the TPA business contact during normal business operations.',
    `service_scope_description` STRING COMMENT 'Detailed description of the administrative services the TPA is contracted to provide including claims processing, utilization review, network management, and member services.',
    `soc2_certified` BOOLEAN COMMENT 'Indicates whether the TPA has achieved SOC 2 Type II certification demonstrating controls for security, availability, processing integrity, confidentiality, and privacy.',
    `state_province` STRING COMMENT 'State or province code of the TPAs primary business location using standard two-letter abbreviations.',
    `third_party_administrator_status` STRING COMMENT 'Current operational status of the TPA relationship indicating whether the TPA is actively servicing plans or has been suspended, terminated, or is pending approval.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN) for the TPA organization used for tax reporting and regulatory compliance.',
    `tpa_code` STRING COMMENT 'Unique business identifier code assigned to the TPA for operational reference and system integration.',
    `tpa_name` STRING COMMENT 'Legal business name of the third party administrator organization.',
    `tpa_type` STRING COMMENT 'Classification of the TPA based on the scope of administrative services provided (full service, claims processing only, utilization management, network management, specialty services, or hybrid).',
    `utilization_management_capability` BOOLEAN COMMENT 'Indicates whether the TPA provides utilization management services including prior authorization, concurrent review, and case management.',
    `website_url` STRING COMMENT 'Public website URL of the TPA organization for member and provider information access.',
    CONSTRAINT pk_third_party_administrator PRIMARY KEY(`third_party_administrator_id`)
) COMMENT 'Master reference table for third_party_administrator. Referenced by tpa_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` (
    `accountable_care_organization_id` BIGINT COMMENT 'Primary key for accountable_care_organization',
    `parent_accountable_care_organization_id` BIGINT COMMENT 'Self-referencing FK on accountable_care_organization (parent_accountable_care_organization_id)',
    `parent_organization_id` BIGINT COMMENT 'Identifier of the parent health system, integrated delivery network, or corporate entity that owns or governs the ACO, if applicable.',
    `payer_id` BIGINT COMMENT 'Identifier of the primary payer or health plan with which the ACO has contracted for value-based care arrangements.',
    `aco_identifier` STRING COMMENT 'External business identifier assigned by CMS or other regulatory body for the ACO. Used for regulatory reporting and cross-system identification.',
    `aco_name` STRING COMMENT 'Official legal name of the accountable care organization as registered with regulatory authorities.',
    `aco_type` STRING COMMENT 'Classification of the ACO based on the program model and payer type it operates under.',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Actual per-beneficiary expenditure amount incurred by the ACO during the performance period.',
    `address_line_1` STRING COMMENT 'First line of the ACO primary business address including street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the ACO primary business address for suite, floor, or building information.',
    `advance_payment_eligible` BOOLEAN COMMENT 'Indicates whether the ACO is eligible to receive advance or upfront payments to support care coordination infrastructure.',
    `agreement_end_date` DATE COMMENT 'Date when the ACO agreement or contract with the payer expires or is scheduled to terminate. Null for open-ended agreements.',
    `agreement_start_date` DATE COMMENT 'Date when the ACO agreement or contract with the payer becomes effective and the organization begins operating under the program.',
    `attributed_beneficiary_count` STRING COMMENT 'Number of Medicare or other payer beneficiaries attributed to the ACO for the current performance period.',
    `benchmark_expenditure_amount` DECIMAL(18,2) COMMENT 'Target per-beneficiary expenditure amount established as the cost benchmark for the ACO performance evaluation.',
    `city` STRING COMMENT 'City name of the ACO primary business address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the ACO primary business address.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the ACO record was first created in the system.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the corporate or organizational entity that holds the ACO agreement, which may differ from the ACO operating name.',
    `national_provider_identifier` STRING COMMENT 'Ten-digit NPI assigned to the ACO as an organizational provider for healthcare transactions and identification.',
    `organization_structure` STRING COMMENT 'Governance and ownership structure of the ACO indicating the primary organizational model and leadership.',
    `participating_provider_count` STRING COMMENT 'Total number of healthcare providers (physicians, specialists, facilities) participating in the ACO network.',
    `performance_year` STRING COMMENT 'Calendar year for which the ACO is currently being measured and evaluated for quality and cost performance.',
    `postal_code` STRING COMMENT 'Five or nine-digit ZIP code for the ACO primary business address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary administrative or executive contact for official ACO communications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary administrative or executive contact person for the ACO.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the ACO administrative or executive contact.',
    `program_model` STRING COMMENT 'Specific CMS or commercial program model under which the ACO operates, defining risk-sharing and payment arrangements.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score for the ACO based on CMS or payer-defined quality measures, typically expressed as a percentage.',
    `risk_adjustment_methodology` STRING COMMENT 'Name or description of the risk adjustment model used to normalize cost and quality performance for the ACO population case mix.',
    `service_area_description` STRING COMMENT 'Textual description of the geographic service area covered by the ACO, including counties, regions, or states served.',
    `shared_loss_amount` DECIMAL(18,2) COMMENT 'Dollar amount of shared losses owed by the ACO in the most recent performance period for two-sided risk models, if applicable.',
    `shared_savings_amount` DECIMAL(18,2) COMMENT 'Dollar amount of shared savings earned by the ACO in the most recent performance period, if applicable.',
    `shared_savings_eligible` BOOLEAN COMMENT 'Indicates whether the ACO is currently eligible to receive shared savings payments based on performance against cost and quality benchmarks.',
    `state_code` STRING COMMENT 'Two-letter state or territory code for the ACO primary business address.',
    `accountable_care_organization_status` STRING COMMENT 'Current operational status of the ACO in its lifecycle with the payer or regulatory program.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN) for the ACO legal entity used for financial and regulatory reporting.',
    `termination_date` DATE COMMENT 'Date when the ACO agreement was terminated or the organization ceased operations under the program, if applicable.',
    `termination_reason` STRING COMMENT 'Reason code or description explaining why the ACO agreement was terminated, such as voluntary withdrawal, performance issues, or regulatory action.',
    `track_level` STRING COMMENT 'Risk track or level within the program model indicating the degree of financial risk and reward sharing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the ACO record was last modified in the system.',
    CONSTRAINT pk_accountable_care_organization PRIMARY KEY(`accountable_care_organization_id`)
) COMMENT 'Master reference table for accountable_care_organization. Referenced by aco_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_parent_payer_id` FOREIGN KEY (`parent_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_primary_successor_payer_id` FOREIGN KEY (`primary_successor_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_predecessor_health_plan_id` FOREIGN KEY (`predecessor_health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_parent_benefit_id` FOREIGN KEY (`parent_benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_network_id` FOREIGN KEY (`network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_network_provider_network_id` FOREIGN KEY (`parent_network_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_provider_network_id` FOREIGN KEY (`parent_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_prior_insurance_network_participation_id` FOREIGN KEY (`prior_insurance_network_participation_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`insurance_network_participation`(`insurance_network_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ADD CONSTRAINT `fk_insurance_insurance_network_participation_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ADD CONSTRAINT `fk_insurance_plan_network_superseded_plan_network_id` FOREIGN KEY (`superseded_plan_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`plan_network`(`plan_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_primary_superseded_by_coverage_policy_id` FOREIGN KEY (`primary_superseded_by_coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_prior_member_enrollment_id` FOREIGN KEY (`prior_member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_employer_group_id` FOREIGN KEY (`employer_group_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_prior_subscriber_id` FOREIGN KEY (`prior_subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_primary_dependent_id` FOREIGN KEY (`primary_dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`broker`(`broker_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_parent_employer_group_id` FOREIGN KEY (`parent_employer_group_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ADD CONSTRAINT `fk_insurance_employer_group_third_party_administrator_id` FOREIGN KEY (`third_party_administrator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`third_party_administrator`(`third_party_administrator_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_contact_id` FOREIGN KEY (`payer_contact_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contact`(`payer_contact_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_renewed_payer_contract_id` FOREIGN KEY (`renewed_payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_primary_predecessor_schedule_fee_schedule_id` FOREIGN KEY (`primary_predecessor_schedule_fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_primary_superseded_by_fee_schedule_line_id` FOREIGN KEY (`primary_superseded_by_fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_superseded_prior_auth_rule_id` FOREIGN KEY (`superseded_prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_appealed_utilization_review_id` FOREIGN KEY (`appealed_utilization_review_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`utilization_review`(`utilization_review_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ADD CONSTRAINT `fk_insurance_utilization_review_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_prior_eligibility_span_id` FOREIGN KEY (`prior_eligibility_span_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`eligibility_span`(`eligibility_span_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ADD CONSTRAINT `fk_insurance_eligibility_span_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_prior_accumulator_id` FOREIGN KEY (`prior_accumulator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accumulator`(`accumulator_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ADD CONSTRAINT `fk_insurance_accumulator_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ADD CONSTRAINT `fk_insurance_capitation_contract_renewed_capitation_contract_id` FOREIGN KEY (`renewed_capitation_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_adjusted_capitation_payment_id` FOREIGN KEY (`adjusted_capitation_payment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_payment`(`capitation_payment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_capitation_contract_id` FOREIGN KEY (`capitation_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`capitation_contract`(`capitation_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ADD CONSTRAINT `fk_insurance_capitation_payment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_corrected_risk_adjustment_id` FOREIGN KEY (`corrected_risk_adjustment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`risk_adjustment`(`risk_adjustment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ADD CONSTRAINT `fk_insurance_risk_adjustment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_superseded_coordination_of_benefits_id` FOREIGN KEY (`superseded_coordination_of_benefits_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits`(`coordination_of_benefits_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_tertiary_payer_id` FOREIGN KEY (`tertiary_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ADD CONSTRAINT `fk_insurance_coordination_of_benefits_tertiary_plan_health_plan_id` FOREIGN KEY (`tertiary_plan_health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_prior_network_adequacy_id` FOREIGN KEY (`prior_network_adequacy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`network_adequacy`(`network_adequacy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ADD CONSTRAINT `fk_insurance_network_adequacy_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ADD CONSTRAINT `fk_insurance_formulary_tier_primary_superseded_by_formulary_tier_id` FOREIGN KEY (`primary_superseded_by_formulary_tier_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`formulary_tier`(`formulary_tier_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_adjusted_premium_billing_id` FOREIGN KEY (`adjusted_premium_billing_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`premium_billing`(`premium_billing_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_employer_group_id` FOREIGN KEY (`employer_group_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`employer_group`(`employer_group_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ADD CONSTRAINT `fk_insurance_premium_billing_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ADD CONSTRAINT `fk_insurance_payer_contact_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ADD CONSTRAINT `fk_insurance_payer_contact_primary_replacement_contact_payer_contact_id` FOREIGN KEY (`primary_replacement_contact_payer_contact_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contact`(`payer_contact_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ADD CONSTRAINT `fk_insurance_vbc_performance_prior_vbc_performance_id` FOREIGN KEY (`prior_vbc_performance_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`vbc_performance`(`vbc_performance_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_prior_member_attribution_id` FOREIGN KEY (`prior_member_attribution_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_attribution`(`member_attribution_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ADD CONSTRAINT `fk_insurance_member_attribution_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ADD CONSTRAINT `fk_insurance_insurance_payer_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ADD CONSTRAINT `fk_insurance_payer_compliance_requirement_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ADD CONSTRAINT `fk_insurance_plan_consent_requirement_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ADD CONSTRAINT `fk_insurance_broker_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ADD CONSTRAINT `fk_insurance_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`broker`(`broker_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ADD CONSTRAINT `fk_insurance_third_party_administrator_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ADD CONSTRAINT `fk_insurance_third_party_administrator_parent_third_party_administrator_id` FOREIGN KEY (`parent_third_party_administrator_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`third_party_administrator`(`third_party_administrator_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ADD CONSTRAINT `fk_insurance_accountable_care_organization_parent_accountable_care_organization_id` FOREIGN KEY (`parent_accountable_care_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ADD CONSTRAINT `fk_insurance_accountable_care_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`accountable_care_organization`(`accountable_care_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ADD CONSTRAINT `fk_insurance_accountable_care_organization_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_domain' = 'insurance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `parent_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `parent_payer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `primary_successor_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `accepts_assignment` SET TAGS ('dbx_business_glossary_term' = 'Accepts Assignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `appeal_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Appeal Limit in Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_category` SET TAGS ('dbx_business_glossary_term' = 'Payer Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_category` SET TAGS ('dbx_value_regex' = 'government|commercial|managed_care|tpa|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claim_scrubbing_vendor` SET TAGS ('dbx_business_glossary_term' = 'Claim Scrubbing Vendor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Inquiry Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_submission_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Endpoint');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `coordination_of_benefits_required` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `edi_payer_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `electronic_funds_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Funds Transfer (EFT) Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_value_regex' = 'edi_270_271|portal|phone|real_time_api');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `id_external` SET TAGS ('dbx_business_glossary_term' = 'External Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `inactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `inactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payer Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Payer Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_business_glossary_term' = 'Provider Relations Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_business_glossary_term' = 'Remittance City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Remittance Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_delivery_method` SET TAGS ('dbx_value_regex' = 'edi_835|era|paper_eob|portal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_business_glossary_term' = 'Remittance State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Short Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi|portal|direct|clearinghouse|paper');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Payer Tier Classification');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit in Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type Classification');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Order');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `cob_order` SET TAGS ('dbx_value_regex' = 'Primary|Secondary|Tertiary');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `emergency_room_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Emergency Room (ER) Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `family_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `family_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Out-of-Pocket (OOP) Maximum Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `fsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'Fully Insured|Self-Funded|Level Funded|Partially Self-Funded');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `hra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Health Reimbursement Arrangement (HRA) Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `hsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `individual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `individual_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Out-of-Pocket (OOP) Maximum Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `inpatient_hospital_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Hospital Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_business_glossary_term' = 'Issuer State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `metal_tier` SET TAGS ('dbx_business_glossary_term' = 'Metal Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `metal_tier` SET TAGS ('dbx_value_regex' = 'Bronze|Silver|Gold|Platinum|Catastrophic|Not Applicable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_coverage` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Coverage Available');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_coverage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Individual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Individual Out-of-Pocket (OOP) Maximum Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'Active|Suspended|Terminated|Pending Approval|Grandfathered|Closed to New Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Tier 1 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Tier 2 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Tier 3 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Tier 4 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `preventive_care_covered` SET TAGS ('dbx_business_glossary_term' = 'Preventive Care Covered at 100%');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `primary_care_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `requires_pcp_selection` SET TAGS ('dbx_business_glossary_term' = 'Requires Primary Care Physician (PCP) Selection');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `requires_referral_for_specialist` SET TAGS ('dbx_business_glossary_term' = 'Requires Referral for Specialist');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `specialist_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Specialist Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_business_glossary_term' = 'State Insurance Department Filing Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `urgent_care_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Urgent Care Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `parent_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Benefit Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `parent_benefit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `allowed_amount_basis` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `allowed_amount_basis` SET TAGS ('dbx_value_regex' = 'usual_customary_reasonable|medicare_rate|negotiated_rate|billed_charges');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment (Copay) Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cost_sharing_tier` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cost_sharing_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Day Limit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Day Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_period` SET TAGS ('dbx_value_regex' = 'per_admission|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `days_supply_limit` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `deductible_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_value_regex' = 'ICD10CM|ICD9CM');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Dollar Limit Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Dollar Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_period` SET TAGS ('dbx_value_regex' = 'per_visit|per_day|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Essential Health Benefit (EHB) Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `exclusions_text` SET TAGS ('dbx_business_glossary_term' = 'Benefit Exclusions Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hsa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `limitations_text` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limitations Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `mail_order_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `out_of_pocket_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `preventive_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_value_regex' = 'CPT|HCPCS|ICD10PCS|CDT|revenue_code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `service_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Benefit Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Visit Limit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Visit Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_period` SET TAGS ('dbx_value_regex' = 'per_day|per_week|per_month|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_id` SET TAGS ('dbx_relationship' = 'parent_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_network_provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Provider Network Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_provider_network_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_approval_date` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_date` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Filing Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_status` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Filing Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_status` SET TAGS ('dbx_value_regex' = 'filed|approved|rejected|pending|not_required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|shared_savings|bundled_payment|value_based|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `credentialing_standard` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `credentialing_standard` SET TAGS ('dbx_value_regex' = 'NCQA|URAC|AAAHC|TJC|state_specific|internal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `dental_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `directory_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|pending_review|conditionally_adequate|exempt');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('dbx_business_glossary_term' = 'Network Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_business_glossary_term' = 'Network Directory URL (Uniform Resource Locator)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_model` SET TAGS ('dbx_business_glossary_term' = 'Network Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_model` SET TAGS ('dbx_value_regex' = 'staff_model|group_model|network_model|IPA|direct_contract|rental_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'preferred|standard|out_of_network|tier_1|tier_2|tier_3');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `pharmacy_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `quality_tier_methodology` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `recredentialing_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Cycle Months');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_value_regex' = 'full_risk|shared_risk|upside_only|downside_risk|no_risk');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'statewide|regional|county|zip_code|msa|national');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `vision_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `insurance_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `prior_insurance_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Insurance Network Participation Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `prior_insurance_network_participation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `provider_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `provider_payer_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `accepting_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `attribution_eligible` SET TAGS ('dbx_business_glossary_term' = 'Attribution Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|clearinghouse|direct');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `contracted_specialty` SET TAGS ('dbx_business_glossary_term' = 'Contracted Specialty');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status with Payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|denied|in_review|recredentialing');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_listing_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Listing Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `directory_visible` SET TAGS ('dbx_business_glossary_term' = 'Directory Visible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `exclusion_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `exclusion_status` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `exclusion_status` SET TAGS ('dbx_value_regex' = 'clear|excluded|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_value_regex' = 'primary_care|specialty|hospital|ancillary|behavioral_health|dental');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_value_regex' = 'individual|group|facility|ancillary|hospital_based');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Panel Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'open|closed|limited|full');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|suspended|credentialing|inactive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `participation_tier` SET TAGS ('dbx_business_glossary_term' = 'Participation Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `participation_tier` SET TAGS ('dbx_value_regex' = 'preferred|standard|tiered|narrow|broad');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `payer_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Payer-Specific Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `payer_provider_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `quality_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|high_performance|standard|not_rated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled|value_based|per_diem|case_rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_value_regex' = 'none|shared_savings|shared_risk|full_risk|upside_only|two_sided');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_network_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `plan_network_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `superseded_plan_network_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Plan Network Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `superseded_plan_network_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `auto_assignment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto Assignment Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `claims_processing_priority` SET TAGS ('dbx_business_glossary_term' = 'Claims Processing Priority');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Network Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `copay_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Copay Tier Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_business_glossary_term' = 'County Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `county_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `deductible_applies` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `member_communication_required` SET TAGS ('dbx_business_glossary_term' = 'Member Communication Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_adequacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_adequacy_certified` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Certified Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_priority` SET TAGS ('dbx_business_glossary_term' = 'Network Priority Rank');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_role` SET TAGS ('dbx_business_glossary_term' = 'Network Role');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_role` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|out_of_area|specialty|behavioral_health');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Designation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Association Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `out_of_network_coverage` SET TAGS ('dbx_business_glossary_term' = 'Out of Network Coverage Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `out_of_network_coverage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `out_of_pocket_max_applies` SET TAGS ('dbx_business_glossary_term' = 'Out of Pocket Maximum Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `pcp_selection_required` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Selection Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled_payment|value_based|drg|per_diem');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `plan_network_status` SET TAGS ('dbx_business_glossary_term' = 'Association Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `plan_network_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `primary_superseded_by_coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `primary_superseded_by_coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `age_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Age Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `age_restrictions` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `appeals_allowed` SET TAGS ('dbx_business_glossary_term' = 'Appeals Allowed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `appeals_process_description` SET TAGS ('dbx_business_glossary_term' = 'Appeals Process Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Clinical Evidence Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_value_regex' = 'covered|non_covered|conditional|investigational|experimental|not_medically_necessary');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `frequency_limitations` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limitations');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Gender Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `network_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Network Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `network_restrictions` SET TAGS ('dbx_value_regex' = 'in_network_only|out_of_network_allowed|no_restriction');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `place_of_service_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Policy Approved By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|retired|superseded');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'medical_policy|coverage_determination|lcd|ncd|administrative_policy|clinical_guideline');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `provider_specialty_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `quantity_limitations` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limitations');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Assigned Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Member Enrollment Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `benefit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `benefit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `cobra_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `cobra_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'individual|individual_plus_spouse|individual_plus_children|family');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|phone|mail|in_person|broker');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|auto_enrollment|cobra|medicare|medicaid');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `last_premium_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_a_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part A Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_a_effective_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_b_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part B Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_b_effective_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `pcp_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|biweekly');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'current|past_due|grace_period|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|domestic_partner|other_dependent');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|csr|medicaid|chip|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `employer_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Subscriber Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Subscriber City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral_health|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber First Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Gender');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|U|O');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Last Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_eligible_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_eligible_flag` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI) Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|biweekly');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `primary_care_physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Insured');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_value_regex' = 'self|spouse|child|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Subscriber State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|non_payment|employment_ended|death|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Dependent Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_mpi_record_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'Disabled|Not Disabled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Disability Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Dependent Eligibility Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Terminated|Suspended|Deceased');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Other|Unknown');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'Spouse|Child|Domestic Partner|Disabled Dependent|Other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_business_glossary_term' = 'Student Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_value_regex' = 'Full-Time Student|Part-Time Student|Not a Student');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Student Status Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'Aged Out|Divorce|Loss of Eligibility|Death|Voluntary Termination|Other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `parent_employer_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Employer Group Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `parent_employer_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `third_party_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Administrator (TPA) ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `aca_applicable_large_employer_indicator` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Applicable Large Employer (ALE) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semi_annual');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `cobra_administrator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Administrator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `cobra_administrator` SET TAGS ('dbx_value_regex' = 'payer|employer|tpa|external_vendor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_contribution_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `employer_ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `erisa_plan_indicator` SET TAGS ('dbx_business_glossary_term' = 'Employee Retirement Income Security Act (ERISA) Plan Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `funding_type` SET TAGS ('dbx_value_regex' = 'fully_insured|self_funded|level_funded|minimum_premium|stop_loss_only');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Group Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled|lapsed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `hsa_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `industry_risk_class` SET TAGS ('dbx_business_glossary_term' = 'Industry Risk Class');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `industry_risk_class` SET TAGS ('dbx_value_regex' = 'low|moderate|high|hazardous');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `minimum_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `minimum_participation_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|payroll_deduction');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `plan_sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Sponsor Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `plan_sponsor_type` SET TAGS ('dbx_value_regex' = 'private_employer|union_trust|government_employer|association|taft_hartley|multiple_employer_welfare_arrangement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `rate_guarantee_months` SET TAGS ('dbx_business_glossary_term' = 'Rate Guarantee Months');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('dbx_business_glossary_term' = 'Situs State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `situs_state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `underwriting_tier` SET TAGS ('dbx_value_regex' = 'standard|preferred|substandard|declined');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`employer_group` ALTER COLUMN `wellness_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewed_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Payer Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewed_payer_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `base_reimbursement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Base Reimbursement Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `base_reimbursement_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `carve_out_services` SET TAGS ('dbx_business_glossary_term' = 'Carve-Out Services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|clearinghouse');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_document_location` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Location');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled_payment|shared_savings|pay_for_performance|value_based');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `credentialing_required` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Reference');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Bonus Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Penalty Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_value_regex' = 'no_risk|upside_only|downside_only|two_sided_risk|full_risk');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `stop_loss_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `primary_predecessor_schedule_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Fee Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `annual_inflation_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Inflation Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `billed_charges_percentage` SET TAGS ('dbx_business_glossary_term' = 'Billed Charges Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `billed_charges_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `carve_out_services` SET TAGS ('dbx_business_glossary_term' = 'Carve Out Services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|clearinghouse');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory_surgery_center|skilled_nursing_facility|home_health|hospice');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Practice Cost Index (GPCI) Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state|county|zip_code|facility_specific');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `inflation_adjustment_method` SET TAGS ('dbx_business_glossary_term' = 'Inflation Adjustment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `inflation_adjustment_method` SET TAGS ('dbx_value_regex' = 'cpi|medical_cpi|fixed_percentage|none|custom');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `interest_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Penalty Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `locality_code` SET TAGS ('dbx_business_glossary_term' = 'Locality Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `medicare_percentage` SET TAGS ('dbx_business_glossary_term' = 'Medicare Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `medicare_percentage` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `outlier_payment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_adjustment_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_incentive_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Incentive Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'percent_of_medicare|percent_of_billed_charges|case_rate|per_diem|fee_for_service|capitation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_value_regex' = 'fee_for_service|bundled_payment|value_based|shared_savings|capitation|per_diem');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'professional|facility|dme|laboratory|pharmacy|radiology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `primary_superseded_by_fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `anesthesia_base_units` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_business_glossary_term' = 'Assistant Surgeon Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bilateral_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bilateral_indicator` SET TAGS ('dbx_value_regex' = 'not_applicable|bilateral_surgery|unilateral_surgery');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bundled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bundled Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `case_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Case Rate Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `case_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_business_glossary_term' = 'Geographic Practice Cost Index (GPCI) Modifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `global_period_days` SET TAGS ('dbx_business_glossary_term' = 'Global Period Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `maximum_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Maximum Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `maximum_reimbursement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `minimum_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `minimum_reimbursement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_business_glossary_term' = 'Multiple Procedure Reduction Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_charges` SET TAGS ('dbx_business_glossary_term' = 'Percent of Billed Charges');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_charges` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_business_glossary_term' = 'Percent of Medicare Allowable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_value_regex' = 'CPT|HCPCS|CDT|NDC');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_total` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Total');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_subdomain' = 'utilization_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `superseded_prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Prior Auth Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `superseded_prior_auth_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age (Years)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_maximum` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age (Years)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_minimum` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `appeal_process_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Process Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `auto_approval_criteria` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `auto_approval_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Reference');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{3,10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `frequency_limit_period_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit Period (Days)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|all|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `pa_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Requirement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `pa_requirement_type` SET TAGS ('dbx_value_regex' = 'required|not_required|clinical_review|peer_to_peer|notification_only|retrospective_review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Payer Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `portal_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{5,10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_value_regex' = 'CPT|HCPCS|ICD-10-PCS');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `quantity_limit_period_days` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Period (Days)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|fax|phone|edi_278|email|mail');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `urgent_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Urgent Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` SET TAGS ('dbx_subdomain' = 'utilization_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `utilization_review_id` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review (UR) ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `claim_appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `appealed_utilization_review_id` SET TAGS ('dbx_business_glossary_term' = 'Appealed Utilization Review Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `appealed_utilization_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `encounter_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `appeal_rights_notified` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `approved_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Approved Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_criteria_applied` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Applied');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `clinical_documentation_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Clinical Documentation Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Criteria Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD-10)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `medical_record_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'mail|fax|email|portal|phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `peer_to_peer_date` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer (P2P) Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `peer_to_peer_requested` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer (P2P) Review Requested');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `regulatory_timeframe_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Timeframe Met');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Rendering Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `rendering_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `requested_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Requested Length of Stay (LOS)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|modified|pended|partially approved');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Review Initiation Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review (UR) Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in progress|completed|cancelled|on hold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Utilization Review (UR) Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'pre-certification|concurrent review|retrospective review|discharge planning|continued stay review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `reviewer_credentials` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Credentials');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`utilization_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Span Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `prior_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Eligibility Span Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `prior_eligibility_span_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `benefit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `benefit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `cobra_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `cobra_qualifying_event` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `cobra_qualifying_event` SET TAGS ('dbx_value_regex' = 'termination|reduction_hours|death|divorce|dependent_ineligibility|medicare_entitlement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `cobra_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'individual|family|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_level` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_order` SET TAGS ('dbx_business_glossary_term' = 'Coverage Order');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_order` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_order` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral_health|comprehensive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `dual_eligibility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligibility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `dual_eligibility_type` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligibility Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `dual_eligibility_type` SET TAGS ('dbx_value_regex' = 'full|partial|qmb|slmb|qi|qdwi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_start_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'active|terminated|suspended|cobra|pending');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed|expired');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|paper|phone|in_person|automatic|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'employer|exchange|direct|broker|government|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `exchange_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exchange Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `medicaid_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `medicaid_indicator` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `medicare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `medicare_indicator` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `pcp_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `pcp_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|weekly|bi_weekly');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `prior_authorization_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `referral_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|csr|employer|state|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` SET TAGS ('dbx_subdomain' = 'utilization_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulator_id` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `benefit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `benefit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `prior_accumulator_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Accumulator Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `prior_accumulator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulated_amount` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `adjustment_count` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `benefit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `benefit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `carryover_amount` SET TAGS ('dbx_business_glossary_term' = 'Carryover Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `carryover_indicator` SET TAGS ('dbx_business_glossary_term' = 'Carryover Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'individual|family|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `coverage_level` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `cross_accumulation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross Accumulation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `embedded_deductible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Embedded Deductible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `plan_year_sequence` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Sequence');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `reset_date` SET TAGS ('dbx_business_glossary_term' = 'Reset Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'medical|pharmacy|dental|vision|behavioral_health|all_services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_reset');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `threshold_met_date` SET TAGS ('dbx_business_glossary_term' = 'Threshold Met Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `threshold_met_indicator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Met Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('dbx_value_regex' = 'individual_deductible|family_deductible|individual_oop_max|family_oop_max|visit_limit|service_limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `capitation_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `renewed_capitation_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Capitation Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `renewed_capitation_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `attributed_population_definition` SET TAGS ('dbx_business_glossary_term' = 'Attributed Population Definition');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `auto_assignment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto-Assignment Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `carve_out_services` SET TAGS ('dbx_business_glossary_term' = 'Carve-Out Services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Capitation Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'global_capitation|professional_capitation|specialty_capitation|partial_capitation|primary_care_capitation|hospital_capitation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `covered_services_description` SET TAGS ('dbx_business_glossary_term' = 'Covered Services Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `excluded_services_description` SET TAGS ('dbx_business_glossary_term' = 'Excluded Services Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `maximum_shared_loss_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Shared Loss Cap Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `maximum_shared_savings_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Shared Savings Cap Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `minimum_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Savings Rate (MSR) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `pmpm_currency_code` SET TAGS ('dbx_business_glossary_term' = 'PMPM Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `pmpm_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per-Member-Per-Month (PMPM) Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `quality_withhold_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `quality_withhold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `quality_withhold_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `risk_adjustment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `risk_adjustment_methodology` SET TAGS ('dbx_value_regex' = 'hcc|cdps|rx_risk|acg|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `risk_corridor_lower_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Corridor Lower Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `risk_corridor_upper_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Corridor Upper Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `shared_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `shared_loss_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `shared_savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `shared_savings_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `vbc_model` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_contract` ALTER COLUMN `vbc_model` SET TAGS ('dbx_value_regex' = 'shared_savings|shared_risk|full_risk|upside_only|two_sided_risk|bundled_payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `capitation_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Payment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `adjusted_capitation_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Capitation Payment Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `adjusted_capitation_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `capitation_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `contract_year` SET TAGS ('dbx_business_glossary_term' = 'Contract Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `days_to_payment` SET TAGS ('dbx_business_glossary_term' = 'Days to Payment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `gross_capitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Capitation Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'eft|ach|wire|check|virtual_card');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_period_month` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Month');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_period_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|received|reconciled|disputed|adjusted|reversed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month (PMPM) Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `quality_withhold_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `quality_withhold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `quality_withhold_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|variance_identified|under_review|resolved');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `remittance_advice_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `remittance_advice_received` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Received Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `risk_adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjusted Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`capitation_payment` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `risk_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `corrected_risk_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Risk Adjustment Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `corrected_risk_adjustment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Reviewer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `chart_review_date` SET TAGS ('dbx_business_glossary_term' = 'Chart Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `data_collection_period_end` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `data_collection_period_start` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `deleted_flag` SET TAGS ('dbx_business_glossary_term' = 'Deleted Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `deletion_date` SET TAGS ('dbx_business_glossary_term' = 'Deletion Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `deletion_reason` SET TAGS ('dbx_business_glossary_term' = 'Deletion Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `demographic_score` SET TAGS ('dbx_business_glossary_term' = 'Demographic Risk Score Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_present_on_admission` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Present on Admission (POA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_present_on_admission` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_present_on_admission` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'Principal|Secondary|Admitting|Discharge');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `disease_score` SET TAGS ('dbx_business_glossary_term' = 'Disease Risk Score Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `hcc_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `hcc_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `interaction_score` SET TAGS ('dbx_business_glossary_term' = 'Disease Interaction Risk Score Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `medical_record_review_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Review Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `medical_record_review_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|In Review|Validated|Invalidated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `medical_record_review_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `medical_record_review_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Model Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Payment Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payment_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payment_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `payment_year` SET TAGS ('dbx_business_glossary_term' = 'Payment Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `plan_benefit_package` SET TAGS ('dbx_business_glossary_term' = 'Plan Benefit Package (PBP) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `plan_benefit_package` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `radv_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Data Validation (RADV) Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `radv_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Data Validation (RADV) Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `radv_audit_status` SET TAGS ('dbx_value_regex' = 'Not Selected|Selected|In Progress|Passed|Failed|Appealed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `recapture_flag` SET TAGS ('dbx_business_glossary_term' = 'Recapture Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF) Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'Draft|Submitted|Accepted|Rejected|Pending|Reconciled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'Initial|Supplemental|Deletion|Correction|RAPS|EDPS');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `suspect_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspect Diagnosis Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`risk_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` SET TAGS ('dbx_subdomain' = 'utilization_adjudication');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `coordination_of_benefits_id` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `coordination_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `superseded_coordination_of_benefits_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Coordination Of Benefits Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `superseded_coordination_of_benefits_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `tertiary_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `tertiary_plan_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `tertiary_plan_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `tertiary_plan_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `auto_cob_update_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Coordination of Benefits (COB) Update Enabled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Agreement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_agreement_type` SET TAGS ('dbx_value_regex' = 'standard|non_duplication|carve_out|maintenance_of_benefits|coordination_of_benefits');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Determination Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_determination_method` SET TAGS ('dbx_value_regex' = 'birthday_rule|gender_rule|naic_cob_rules|court_order|separation_agreement|active_inactive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_notes` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Priority Sequence');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_questionnaire_response_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Questionnaire Response Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_questionnaire_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Questionnaire Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Verification Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `cob_verification_source` SET TAGS ('dbx_value_regex' = 'member_attestation|employer_report|eligibility_file|claims_data|third_party_vendor|manual_research');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `court_order_date` SET TAGS ('dbx_business_glossary_term' = 'Court Order Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `court_order_indicator` SET TAGS ('dbx_business_glossary_term' = 'Court Order Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `crossover_claim_indicator` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `custody_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Custody Arrangement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `custody_arrangement` SET TAGS ('dbx_value_regex' = 'joint|sole_custodial_parent|non_custodial_parent|court_ordered|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `dependent_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Dependent Relationship Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `dependent_relationship_code` SET TAGS ('dbx_value_regex' = 'self|spouse|child|other_dependent');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `dependent_relationship_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `last_cob_inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Last Coordination of Benefits (COB) Inquiry Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `medicare_primary_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Primary Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `medicare_primary_indicator` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `msp_type` SET TAGS ('dbx_business_glossary_term' = 'Medicare Secondary Payer (MSP) Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `next_cob_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Coordination of Benefits (COB) Verification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `other_subscriber_birth_date` SET TAGS ('dbx_business_glossary_term' = 'Other Subscriber Birth Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `other_subscriber_birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `other_subscriber_birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `primary_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `primary_coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `secondary_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `secondary_coverage_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_birth_date` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Birth Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `subscriber_birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coordination_of_benefits` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `network_adequacy_id` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `prior_network_adequacy_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Network Adequacy Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `prior_network_adequacy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_appointment_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Average Appointment Wait Time Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_appointment_wait_time_days` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Actual Average Distance Miles');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_distance_miles` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Average Travel Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_average_travel_time_minutes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `actual_provider_to_member_ratio` SET TAGS ('dbx_business_glossary_term' = 'Actual Provider-to-Member Ratio');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `adequacy_determination` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Determination');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `adequacy_determination` SET TAGS ('dbx_value_regex' = 'adequate|deficient|conditionally_adequate|under_review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `county_code` SET TAGS ('dbx_business_glossary_term' = 'County Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `essential_community_provider_flag` SET TAGS ('dbx_business_glossary_term' = 'Essential Community Provider (ECP) Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `maximum_appointment_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointment Wait Time Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `maximum_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Distance Miles');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `maximum_time_distance_standard` SET TAGS ('dbx_business_glossary_term' = 'Maximum Time-and-Distance Standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `maximum_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `percentage_members_within_standard` SET TAGS ('dbx_business_glossary_term' = 'Percentage Members Within Standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `percentage_members_within_standard` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'CMS|state_DOI|exchange|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `required_provider_to_member_ratio` SET TAGS ('dbx_business_glossary_term' = 'Required Provider-to-Member Ratio');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `telehealth_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`network_adequacy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `formulary_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `primary_superseded_by_formulary_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tier Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `cms_tier_category` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Tier Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `days_supply_mail_order` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Mail Order');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `days_supply_standard` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `deductible_applies` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `mail_order_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `member_coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Member Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `member_coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `member_communication_text` SET TAGS ('dbx_business_glossary_term' = 'Member Communication Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `member_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Member Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `out_of_pocket_applies` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `preferred_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Tier Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `preventive_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Tier Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `provider_communication_text` SET TAGS ('dbx_business_glossary_term' = 'Provider Communication Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `quantity_limit_applies` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Applies');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `retail_network_eligible` SET TAGS ('dbx_business_glossary_term' = 'Retail Network Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `specialty_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Tier Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_display_order` SET TAGS ('dbx_business_glossary_term' = 'Tier Display Order');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_value_regex' = 'Generic|Preferred Generic|Preferred Brand|Non-Preferred Brand|Specialty|Preventive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Retired|Suspended');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `tier_version` SET TAGS ('dbx_business_glossary_term' = 'Tier Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`formulary_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `premium_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `adjusted_premium_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Premium Billing Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `adjusted_premium_billing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `employer_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `administrative_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Administrative Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'employer_group|individual|cobra|medicare_advantage|medicaid_managed_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `cobra_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `delinquency_date` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `enrolled_member_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Member Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `invoice_generated_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `invoice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `lapse_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Lapse Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `net_premium_due` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount Due');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Premium Billing Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Premium Balance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount Received');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|payroll_deduction|electronic_funds_transfer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `premium_rate_per_member` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Per Member Per Month (PMPM)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `reinstatement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `reinstatement_eligible` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Subsidy Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount Billed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`premium_billing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `payer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `primary_replacement_contact_payer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Contact Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `accepts_electronic_submission` SET TAGS ('dbx_business_glossary_term' = 'Accepts Electronic Submission Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporary|on_leave|replaced');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'claims_submission|prior_authorization|provider_relations|credentialing|network_contracting|edi_clearinghouse');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `escalation_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `hours_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Hours of Operation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'English|Spanish|French|Chinese|Vietnamese|Korean');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_business_glossary_term' = 'Phone Extension');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_extension` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `portal_login_instructions` SET TAGS ('dbx_business_glossary_term' = 'Portal Login Instructions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Payer Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|fax|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `requires_appointment` SET TAGS ('dbx_business_glossary_term' = 'Requires Appointment Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `service_level_agreement_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = 'EST|CST|MST|PST|AKST|HST');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contact` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'phone_call|email_confirmation|portal_update|payer_notification|manual_review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `vbc_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Performance ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `prior_vbc_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Vbc Performance Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `prior_vbc_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `benchmark_tcoc_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Total Cost of Care (TCOC) Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `data_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `measurement_year` SET TAGS ('dbx_business_glossary_term' = 'Measurement Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `performance_year_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Year Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `performance_year_type` SET TAGS ('dbx_value_regex' = 'calendar_year|contract_year|benefit_year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_withhold_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_withhold_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Earned Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `quality_withhold_forfeited_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Withhold Forfeited Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `reporting_entity` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_value_regex' = 'one_sided|two_sided|upside_only|downside_risk');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `risk_corridor_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Corridor Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `risk_corridor_lower_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Corridor Lower Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `risk_corridor_upper_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Corridor Upper Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `savings_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings or Loss Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Calculation Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_payment_method` SET TAGS ('dbx_value_regex' = 'eft|check|wire_transfer|offset');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|calculated|approved|paid|disputed|adjusted');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_loss_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_savings_distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Distribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `shared_savings_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `stop_loss_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `stop_loss_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `total_cost_of_care_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Care (TCOC) Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`vbc_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `member_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Member Attribution ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `care_team_id` SET TAGS ('dbx_business_glossary_term' = 'Care Team ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `prior_member_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Member Attribution Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `prior_member_attribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `quality_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Attributed Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attributed_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Attribution Algorithm Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Attribution Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Lock Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_business_glossary_term' = 'Attribution Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `attribution_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `capitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitation Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `capitation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `capitation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Capitation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `capitation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `county_code` SET TAGS ('dbx_business_glossary_term' = 'County Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `county_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `opt_out_indicator` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `plurality_of_care_indicator` SET TAGS ('dbx_business_glossary_term' = 'Plurality of Care Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `primary_care_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Visit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `shared_savings_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `tin` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `tin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `total_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Visit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('dbx_subdomain' = 'network_contracting');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` SET TAGS ('dbx_association_edges' = 'provider.clinician,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `insurance_payer_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment - Payer Enrollment Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment - Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment - Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `ptan` SET TAGS ('dbx_business_glossary_term' = 'Provider Transaction Access Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`insurance_payer_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` SET TAGS ('dbx_association_edges' = 'compliance.compliance_program,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `payer_compliance_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Compliance Requirement ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Compliance Requirement - Compliance Program Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Compliance Requirement - Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `last_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `last_status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `payer_program_scope` SET TAGS ('dbx_business_glossary_term' = 'Payer Program Scope');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `payer_specific_requirements` SET TAGS ('dbx_business_glossary_term' = 'Payer Specific Requirements');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `program_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `program_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_compliance_requirement` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` SET TAGS ('dbx_association_edges' = 'insurance.health_plan,consent.consent_form_template');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `plan_consent_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Consent Requirement ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Consent Requirement - Consent Form Template Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Consent Requirement - Health Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `enrollment_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Trigger Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `renewal_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Trigger Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `requirement_basis` SET TAGS ('dbx_business_glossary_term' = 'Requirement Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `requirement_notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`plan_consent_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Broker Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `compliance_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Errors And Omissions Coverage Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_coverage_amount` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors And Omissions Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Errors And Omissions Insurance Carrier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors And Omissions Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `errors_and_omissions_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `hipaa_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `national_producer_number` SET TAGS ('dbx_business_glossary_term' = 'National Producer Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `override_commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Override Commission Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `override_commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `override_commission_rate_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`broker` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `third_party_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Administrator Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `parent_third_party_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Third Party Administrator Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `parent_third_party_administrator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `business_continuity_plan_verified` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Plan Verified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `claims_processing_capability` SET TAGS ('dbx_business_glossary_term' = 'Claims Processing Capability');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `claims_submission_address` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `claims_submission_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `claims_submission_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `data_breach_history` SET TAGS ('dbx_business_glossary_term' = 'Data Breach History');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `data_breach_history` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `hipaa_compliance_certified` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Compliance Certified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `member_services_capability` SET TAGS ('dbx_business_glossary_term' = 'Member Services Capability');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `network_management_capability` SET TAGS ('dbx_business_glossary_term' = 'Network Management Capability');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `network_management_capability` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `parent_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `performance_guarantee_terms` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Terms');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `service_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `soc2_certified` SET TAGS ('dbx_business_glossary_term' = 'Soc2 Certified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `third_party_administrator_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_code` SET TAGS ('dbx_business_glossary_term' = 'Tpa Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_name` SET TAGS ('dbx_business_glossary_term' = 'Tpa Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `tpa_type` SET TAGS ('dbx_business_glossary_term' = 'Tpa Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `utilization_management_capability` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management Capability');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `utilization_management_capability` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`third_party_administrator` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `accountable_care_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `parent_accountable_care_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Accountable Care Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `parent_accountable_care_organization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_identifier` SET TAGS ('dbx_business_glossary_term' = 'Aco Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_name` SET TAGS ('dbx_business_glossary_term' = 'Aco Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `aco_type` SET TAGS ('dbx_business_glossary_term' = 'Aco Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `advance_payment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `attributed_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Beneficiary Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `attributed_beneficiary_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `benchmark_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Expenditure Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `benchmark_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `organization_structure` SET TAGS ('dbx_business_glossary_term' = 'Organization Structure');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `participating_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Provider Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `program_model` SET TAGS ('dbx_business_glossary_term' = 'Program Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `risk_adjustment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `shared_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `shared_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `shared_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `shared_savings_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `shared_savings_eligible` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `accountable_care_organization_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `track_level` SET TAGS ('dbx_business_glossary_term' = 'Track Level');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`accountable_care_organization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
