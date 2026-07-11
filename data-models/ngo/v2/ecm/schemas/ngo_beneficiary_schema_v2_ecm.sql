-- Schema for Domain: beneficiary | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`beneficiary` COMMENT 'Single source of truth for all individuals, households, and communities served by humanitarian and development programs. Owns beneficiary identity, registration, vulnerability profiling, needs assessments, consent management, and case management. Covers IDPs, PoCs (Persons of Concern), GBV survivors, and all target populations tracked in CommCare and KoboToolbox.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` (
    `registrant_id` BIGINT COMMENT 'Unique surrogate identifier for each registrant record in the beneficiary domain. Serves as the primary key and identity anchor for all beneficiary-domain transactions across CommCare, KoboToolbox, and interoperability mappings to UNHCR proGres v4, WFP SCOPE, and RAIS.',
    `dedup_master_registrant_id` BIGINT COMMENT 'The beneficiary_id of the authoritative master record when this registrant has been identified as a duplicate. Null for unique records. Enables lineage tracing from duplicate to canonical record for audit and reporting.',
    `household_id` BIGINT COMMENT 'Identifier linking this registrant to their household unit. Enables household-level aggregation for NFI distribution, WASH targeting, and food security assessments. Household head registrant carries the authoritative household record.',
    `intervention_id` BIGINT COMMENT 'Externally-known unique beneficiary identifier assigned at registration, used for cross-system interoperability with UNHCR proGres v4, WFP SCOPE, and RAIS case records. Printed on beneficiary cards and referenced in all program transactions.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Beneficiary registration occurs at specific field sites (health posts, distribution points, registration centers). Essential for geographic program planning, site-level performance reporting, and link',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Nonprofits must screen beneficiaries against OFAC, UN, EU sanctions lists before providing assistance per donor compliance requirements (USAID, FCDO, EU). Mandatory regulatory process for counter-terr',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or community health worker who conducted the registration. Used for accountability, data quality audits, and field staff performance monitoring. Links to workforce.staff_member.',
    `age_years` STRING COMMENT 'Registrants age in whole years at the time of registration. Stored explicitly to support age-band analytics and program eligibility checks when date_of_birth is estimated or unavailable. Derived from date_of_birth where known; otherwise entered directly.',
    `completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0–100) reflecting the completeness of the registrants registration profile based on mandatory and recommended fields populated. Used for data quality monitoring, field staff performance tracking, and MEL data quality assessments.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the registrant or their legal guardian. Required for GDPR compliance audit trails and CHS accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the registrant (or legal guardian for minors) has provided informed consent for data collection, storage, and use per organizational data protection policy and applicable regulations. Mandatory for all registrations per CHS Commitment 4.',
    `country_of_origin_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the registrants country of origin. Distinct from nationality for stateless persons and IDPs. Used for displacement tracking, protection analysis, and OCHA SitRep reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registrant record was first created in the data platform (Silver Layer). Serves as the audit trail anchor for data lineage, GDPR data retention calculations, and compliance reporting.',
    `date_of_birth` DATE COMMENT 'The registrants date of birth in yyyy-MM-dd format. Used for age calculation, vulnerability profiling, child protection flags, and eligibility determination for age-targeted programs (e.g., SAM/GAM nutrition screening, PSS services).',
    `deduplication_status` STRING COMMENT 'Current status of the deduplication check for this registrant record. Duplicate records are suppressed from active program counts. Merged indicates the record was consolidated with a master record. Supports USAID and DFID double-counting prevention requirements.. Valid values are `pending|unique|duplicate|merged|flagged`',
    `disability_type` STRING COMMENT 'Classification of the registrants disability type per Washington Group Short Set categories. Used for targeted accommodation planning, assistive device provision, and inclusive program design. Only populated when has_disability is True. [ENUM-REF-CANDIDATE: mobility|vision|hearing|cognitive|psychosocial|multiple|other — 7 candidates stripped; promote to reference product]',
    `family_name` STRING COMMENT 'The registrants family name or surname as recorded at registration. Combined with given_name for full identity display and deduplication matching.',
    `given_name` STRING COMMENT 'The registrants given name (first name) as recorded at registration. Used for identity verification, case management, and beneficiary communication.',
    `has_disability` BOOLEAN COMMENT 'Indicates whether the registrant has a reported disability. Used for inclusive programming, accessibility accommodations, and Washington Group Short Set disaggregation in MEL reporting per IASC disability inclusion guidelines.',
    `is_gbv_survivor` BOOLEAN COMMENT 'Indicates whether the registrant has been identified as a Gender-Based Violence (GBV) survivor. Triggers GBV case management referral, PSS services, and safe space access. Stored with highest data protection classification per GBV information management principles.',
    `is_pregnant_or_lactating` BOOLEAN COMMENT 'Indicates whether the registrant is a pregnant or lactating woman (PLW). Triggers priority access to nutrition programs (SAM/GAM treatment, supplementary feeding), antenatal care referrals, and PLW-specific NFI kits.',
    `is_unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether the registrant is an unaccompanied or separated child (UASC). Triggers child protection protocols, best-interest assessments, and mandatory referral to child protection case management per UNHCR/UNICEF UASC guidelines.',
    `last_verification_date` DATE COMMENT 'Date of the most recent identity or liveness verification for this registrant. Used to flag records requiring re-verification per program cycle requirements and to support active beneficiary count accuracy for donor reporting.',
    `muac_cm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in centimetres recorded at registration or nutrition screening. Used to classify acute malnutrition status (SAM: <11.5cm, MAM: 11.5–12.5cm) per Sphere/WHO nutrition protocols. Applicable for children 6–59 months and PLW.',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the registrants nationality. Used for protection status determination, IDP/refugee classification, and donor reporting disaggregation.. Valid values are `^[A-Z]{3}$`',
    `poc_category` STRING COMMENT 'UNHCR-aligned classification of the registrants protection status as a Person of Concern (PoC). Drives protection programming, legal aid eligibility, and UNHCR/OCHA statistical reporting. [ENUM-REF-CANDIDATE: refugee|idp|returnee|stateless|asylum_seeker|host_community|other — promote to reference product]',
    `preferred_language_code` STRING COMMENT 'ISO 639 language code for the registrants preferred communication language. Used to assign appropriate interpreters, translated materials, and language-appropriate PSS services. Supports CHS Commitment 4 on accessible communication.. Valid values are `^[a-z]{2,3}$`',
    `protection_flag` BOOLEAN COMMENT 'Master protection concern flag indicating the registrant has one or more active protection risks (GBV, UASC, trafficking, detention risk, etc.). Triggers protection case management workflow and restricts data sharing per CHS data protection principles.',
    `re_registration_count` STRING COMMENT 'Number of times this registrant has been re-registered in the system (e.g., after displacement, camp relocation, or annual verification cycles). Supports re-registration tracking and historical registration event analysis.',
    `registration_date` DATE COMMENT 'The date on which the registrant was first formally registered into the beneficiary system. Used as the baseline date for program enrollment timelines, cohort analysis, and compliance reporting to donors (USAID BHA, DFID).',
    `registration_modality` STRING COMMENT 'The channel or method through which the registrant was enrolled. Distinguishes in-person field registration, mobile data collection (KoboToolbox/CommCare), remote registration (phone/online), and self-registration kiosks. Informs data quality scoring and verification requirements.. Valid values are `in_person|mobile|remote|self_registration`',
    `registration_source_system` STRING COMMENT 'The operational system of record from which this registrant record originated. Supports data lineage, deduplication across systems, and interoperability mapping to UNHCR proGres v4, WFP SCOPE, and RAIS.. Valid values are `commcare|kobotoolbox|progres_v4|wfp_scope|rais|manual`',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registrant record. Controls eligibility for program services, NFI distributions, and case management workflows. Duplicate status is set by the deduplication process; departed indicates the individual has left the program area.. Valid values are `active|inactive|deceased|departed|duplicate|suspended`',
    `registration_tool` STRING COMMENT 'The specific data collection tool or form used to capture the registration. Distinguishes KoboToolbox survey forms, CommCare mobile case forms, paper-based forms, and direct system entry. Informs data quality and field validation rules.. Valid values are `kobotoolbox|commcare|paper_form|progres_v4|scope|other`',
    `registration_type` STRING COMMENT 'Classifies the registrant as an individual, household head, household member, or community-level registration. Determines the unit of analysis for program targeting, NFI distribution, and beneficiary counting methodologies.. Valid values are `individual|household_head|household_member|community`',
    `sex` STRING COMMENT 'Biological sex of the registrant as recorded at registration. Used for DAC-compliant gender disaggregation in MEL reporting, GBV protection screening, and SPHERE-aligned needs assessments.. Valid values are `male|female|other|unknown`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., CommCare case_id, KoboToolbox submission UUID, proGres v4 individual_id). Enables bidirectional traceability and re-synchronization with operational systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this registrant record in the data platform. Used for incremental data processing, change data capture, and audit trail compliance.',
    `verification_document_number` STRING COMMENT 'The document number from the identity verification document presented at registration (e.g., national ID number, passport number, UNHCR card number). Stored encrypted; used for deduplication and re-registration identity matching.',
    `verification_document_type` STRING COMMENT 'Type of identity verification document presented at registration. Used for identity assurance scoring, fraud prevention, and compliance with donor KYB (Know Your Beneficiary) requirements. Community attestation applies where formal documents are unavailable.. Valid values are `national_id|passport|unhcr_card|birth_certificate|community_attestation|none`',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the registrants vulnerability level derived from the vulnerability_score. Drives program targeting decisions, priority service access, and donor reporting on most-vulnerable population coverage.. Valid values are `critical|high|medium|low`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite vulnerability index score calculated from the needs assessment, capturing food insecurity, protection risks, health status, and displacement severity. Used for program prioritization, targeting, and MEL outcome tracking. Score range and methodology defined per program LogFrame.',
    CONSTRAINT pk_registrant PRIMARY KEY(`registrant_id`)
) COMMENT 'Core master entity for every individual registered as a beneficiary or person of concern (PoC). Stores biographic data (name, date of birth, sex, nationality), unique beneficiary ID, registration source system (CommCare, KoboToolbox), protection flags, deduplication status, and full registration metadata including registration date, location, modality (in-person, mobile, remote), registration tool, registering staff, verification documents presented, completeness score, and deduplication check results. Supports re-registration tracking with historical registration events. Serves as the single identity anchor for all beneficiary-domain transactions. Interoperable with UNHCR proGres v4 individual records, WFP SCOPE beneficiary records, and RAIS case records via standard beneficiary ID mapping.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`household` (
    `household_id` BIGINT COMMENT 'Unique system-generated identifier for the household record. Primary key for the household master entity in the beneficiary domain. Role: MASTER_AGREEMENT — a household registration is a long-running binding container linking individuals to service delivery.',
    `community_id` BIGINT COMMENT 'Reference to the community or settlement record where the household is located. Supports geographic aggregation for WASH assessments, food security cluster reporting, and GIS-based programme planning via Humanitarian OpenStreetMap.',
    `intervention_id` BIGINT COMMENT 'Reference to the programme under which this household was registered and is receiving services. Links to the programme master product in the Program domain for LogFrame, Theory of Change, and donor grant alignment.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Households are registered and served at specific field locations. Critical for household-level service delivery tracking, geographic targeting analysis, and site-based program planning. Standard pract',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Household-level sanctions screening is standard practice for family-based assistance programs. Required by major donors (USAID, DFID, EU) to ensure no assistance reaches sanctioned entities or individ',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff or volunteer who conducted the household registration or most recent needs assessment. Used for data quality audits, enumerator performance tracking, and MEAL accountability reviews.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Households are assigned to specific warehouses/distribution points for assistance collection based on geographic proximity. Essential for last-mile distribution planning, beneficiary mobilization, and',
    `registrant_id` BIGINT COMMENT 'Reference to the individual registrant record designated as the head of household. The head of household is the primary contact and consent holder for the household unit. Links to the beneficiary registrant product for identity, biographic, and contact details.',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (region, province, or state) where the household is located. Aligns with OCHA Common Operational Datasets (CODs) administrative boundary layer 1 for GIS mapping and cluster reporting.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (district, county, or department) where the household is located. Used for sub-national programme targeting, cluster coordination, and DHIS2 geographic disaggregation.',
    `children_under5_count` STRING COMMENT 'Number of children aged 0–4 years in the household. Critical for nutrition programme targeting (Global Acute Malnutrition / Severe Acute Malnutrition screening), UNICEF child protection reporting, and SPHERE minimum standards for child-specific NFI distributions.',
    `commcare_case_reference` STRING COMMENT 'Unique case identifier from CommCare mobile case management system for this household. Enables bidirectional synchronisation between the lakehouse silver layer and CommCare for community health worker follow-up, beneficiary tracking, and case status updates.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the head of household. Required for GDPR data processing records, CHS accountability documentation, and audit trails for data protection compliance reviews.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for data collection and processing was obtained from the head of household at the time of registration. Mandatory for GDPR compliance, CHS Commitment 4 accountability, and HAP Standard data protection requirements.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the households country of origin or habitual residence prior to displacement. Required for UNHCR refugee population statistics, OCHA Humanitarian Response Plan disaggregation, and IATI geographic coding.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system. Serves as the audit trail creation marker for data governance, GDPR data processing records, and silver layer lineage tracking in the Databricks Lakehouse.',
    `current_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the household is currently residing. Used for cross-border programme coordination, OCHA SitRep geographic disaggregation, and IATI location reporting.. Valid values are `^[A-Z]{3}$`',
    `deregistration_date` DATE COMMENT 'Calendar date on which the household exited or was closed from the programme. Nullable for active households. Used to calculate programme duration, exit analysis, and MEL outcome tracking. Corresponds to the effective-until date of the household registration agreement.',
    `displacement_date` DATE COMMENT 'Date on which the household was displaced from their place of habitual residence. Used for durable solutions planning, return and reintegration programming, and UNHCR proGres displacement history tracking.',
    `displacement_status` STRING COMMENT 'Classification of the households displacement situation. Internally Displaced Person (IDP), refugee, returnee, host community, stateless, or asylum seeker. Determines eligibility for specific UNHCR, OCHA, and WFP programme streams and drives proGres v4 population group assignment. [ENUM-REF-CANDIDATE: idp|refugee|returnee|host_community|stateless|asylum_seeker — promote to reference product]. Valid values are `idp|refugee|returnee|host_community|stateless|asylum_seeker`',
    `elderly_count` STRING COMMENT 'Number of household members aged 60 years or older. Used for vulnerability scoring, priority targeting in food security and health programmes, and age-disaggregated donor reporting per OCHA and IASC standards.',
    `exit_reason` STRING COMMENT 'Reason for the households exit or closure from the programme. Used for MEL outcome analysis, durable solutions tracking, and donor reporting on programme completion rates. Nullable for active households. [ENUM-REF-CANDIDATE: graduated|relocated|deceased|voluntary_withdrawal|ineligible|duplicate|lost_to_followup — promote to reference product]',
    `female_count` STRING COMMENT 'Number of female individuals in the household. Required for sex-disaggregated reporting to OCHA, USAID, and DFID donors. Supports gender analysis in MEL frameworks and IASC gender marker compliance.',
    `food_security_status` STRING COMMENT 'Household-level food security classification based on the Integrated Food Security Phase Classification (IPC) or Household Food Insecurity Access Scale (HFIAS). Drives WFP food assistance targeting, cash transfer programme eligibility, and OCHA food security cluster reporting.. Valid values are `food_secure|mildly_insecure|moderately_insecure|severely_insecure`',
    `gbv_risk_flag` BOOLEAN COMMENT 'Indicates whether the household has been identified as at elevated risk of or affected by Gender-Based Violence (GBV). Classified restricted due to sensitivity. Triggers referral to GBV case management, PSS (Psychosocial Support) services, and safe space programming. Access strictly controlled per GBV information management protocols.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the households physical location in decimal degrees (WGS84). Captured via KoboToolbox GPS widget during field registration. Used for GIS mapping, proximity analysis, and Humanitarian OpenStreetMap integration. Classified confidential as precise location of vulnerable individuals.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the households physical location in decimal degrees (WGS84). Captured via KoboToolbox GPS widget during field registration. Used for GIS mapping, proximity analysis, and Humanitarian OpenStreetMap integration. Classified confidential as precise location of vulnerable individuals.',
    `has_pregnant_lactating` BOOLEAN COMMENT 'Indicates whether the household includes at least one pregnant or lactating woman (PLW). Critical flag for nutrition programme targeting (supplementary feeding, micronutrient supplementation), SPHERE nutrition standards compliance, and UNICEF/WFP PLW-specific assistance eligibility.',
    `has_unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether the household includes an unaccompanied or separated child (UASC). Triggers child protection case management protocols in CommCare, UNHCR UASC registration procedures, and UNICEF child protection programme referrals.',
    `is_female_headed` BOOLEAN COMMENT 'Indicates whether the household is headed by a woman. Key targeting criterion for GBV (Gender-Based Violence) prevention programmes, womens economic empowerment initiatives, and IASC gender marker reporting. Required for USAID gender equality disaggregation.',
    `kobo_submission_reference` STRING COMMENT 'Unique identifier of the KoboToolbox form submission that created or last updated this household record. Enables traceability back to the original field data collection form for data quality audits, MEAL verification, and source system reconciliation.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent household-level needs assessment or vulnerability re-assessment conducted. Used to identify households overdue for reassessment, track MEL data currency, and ensure programme targeting reflects current conditions per MEAL cycle requirements.',
    `male_count` STRING COMMENT 'Number of male individuals in the household. Required for sex-disaggregated reporting to OCHA, USAID, and DFID donors. Supports gender analysis in MEL frameworks and IASC gender marker compliance.',
    `notes` STRING COMMENT 'Free-text field for field staff to record contextual observations, special circumstances, or case management notes about the household that do not fit structured fields. Classified confidential due to potential sensitivity of recorded information. Supports CommCare case notes and KoboToolbox open-text responses.',
    `pwd_count` STRING COMMENT 'Number of household members with a physical, sensory, intellectual, or psychosocial disability. Required for IASC disability inclusion reporting, Washington Group Short Set disaggregation, and inclusive programming compliance under the CRPD.',
    `registration_date` DATE COMMENT 'Calendar date on which the household was first formally registered into the programme. Serves as the effective start date of the household agreement with the organisation. Used for cohort analysis, programme duration calculations, and donor reporting.',
    `registration_number` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the household at point of registration. Used across field operations, NFI distribution lists, WASH assessments, and food security programming as the primary cross-system reference. Corresponds to the SCOPE household token or proGres case number.',
    `registration_status` STRING COMMENT 'Current lifecycle state of the household registration. Active indicates the household is enrolled and eligible for services. Suspended indicates a temporary hold pending verification. Closed indicates the household has exited programming. Drives eligibility checks in CommCare and Microsoft Dynamics 365 case management.. Valid values are `active|suspended|closed|pending_verification|archived`',
    `registration_type` STRING COMMENT 'Classification of the registration event that created or last updated this household record. Distinguishes initial intake from periodic re-verification exercises required by UNHCR and WFP programme cycles.. Valid values are `initial|re-registration|update|verification`',
    `sanitation_facility_type` STRING COMMENT 'Classification of the households primary sanitation facility. Core WASH indicator for SPHERE minimum standards, OCHA WASH cluster reporting, and WHO/UNICEF Joint Monitoring Programme (JMP) SDG 6 tracking. [ENUM-REF-CANDIDATE: flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none — promote to reference product]. Valid values are `flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none`',
    `shelter_ownership` STRING COMMENT 'Tenure status of the households current shelter. Distinguishes owned, rented, informal/squatter, organisation-provided, or communal arrangements. Used for durable solutions planning, land rights programming, and UNHCR shelter vulnerability assessments.. Valid values are `owned|rented|informal|provided_by_org|communal`',
    `shelter_type` STRING COMMENT 'Classification of the households current shelter situation. Used for SPHERE shelter standard compliance assessments, NFI kit targeting (shelter kits vs. core relief items), and OCHA shelter cluster reporting. [ENUM-REF-CANDIDATE: permanent|semi-permanent|temporary|makeshift|collective_centre|host_family|none — promote to reference product]',
    `size` STRING COMMENT 'Total count of individuals residing in the household at the time of last registration or update. Used for NFI distribution quantity calculations, food ration sizing, WASH facility planning, and WFP SCOPE entitlement computation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the household record. Used for incremental data pipeline processing, change data capture in the Databricks Lakehouse silver layer, and audit trail compliance.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of household vulnerability derived from the vulnerability score or direct assessment. Used for programme targeting tiers, priority service delivery sequencing, and donor reporting on most-vulnerable population reach.. Valid values are `low|medium|high|critical`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the households overall vulnerability level, calculated from a standardised vulnerability assessment tool (e.g., Proxy Means Test, Household Economy Analysis). Used for priority targeting, programme tiering, and MEL outcome baseline establishment. Score range and methodology defined per programme.',
    `water_source_type` STRING COMMENT 'Classification of the households primary drinking water source. Core WASH (Water, Sanitation and Hygiene) indicator required for SPHERE minimum standards compliance, OCHA WASH cluster reporting, and DHIS2 WASH indicator tracking. [ENUM-REF-CANDIDATE: piped|borehole|protected_spring|unprotected_spring|surface_water|trucked|rainwater — promote to reference product]',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Master record for a household unit as the primary unit of registration and service delivery in humanitarian contexts. Captures household composition count, head-of-household reference (FK to registrant), geographic location, community/settlement reference, shelter type, displacement status, and household-level vulnerability indicators. Links individual registrants to their household grouping via household_member association for NFI distribution, WASH assessments, and food security programming. Supports WFP SCOPE household registration and UNHCR proGres family composition interoperability.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Unique surrogate identifier for each household member association record in the beneficiary domain. Primary key for this entity.',
    `case_record_id` BIGINT COMMENT 'Reference to the CommCare or Microsoft Dynamics 365 case management record associated with this household member. Used for case follow-up, service delivery tracking, and MEL (Monitoring Evaluation and Learning) outcome measurement.',
    `household_id` BIGINT COMMENT 'Reference to the household to which this individual belongs. Links the member record to the household registration unit for NFI distribution sizing and vulnerability scoring.',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary registration record for this household member. Links to the beneficiary master record captured in CommCare or KoboToolbox.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the field enumerator or data collector who registered this household member. Used for data quality audits, enumerator performance monitoring, and traceability of field data in KoboToolbox and CommCare.',
    `age_estimated` BOOLEAN COMMENT 'Indicates whether the recorded age or date of birth is an estimate rather than a verified value. Common in humanitarian field contexts where documentation is unavailable. Affects data quality scoring for MEL reporting.',
    `age_years` STRING COMMENT 'Recorded or estimated age of the household member in years at time of registration. Used when exact date of birth is unknown, which is common in humanitarian contexts. Supports age-band disaggregation for NFI sizing and program targeting.',
    `household_member_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this household member association, used in field operations, PDM (Post-Distribution Monitoring) forms, and inter-agency data sharing.. Valid values are `^HHM-[A-Z0-9]{6,12}$`',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from this household member or their legal guardian. Required for GDPR compliance audit trails and CHS (Core Humanitarian Standard) accountability reporting.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether this household member (or their guardian) has provided informed consent for data collection, storage, and use in program delivery. Mandatory per CHS (Core Humanitarian Standard) and GDPR data protection requirements.',
    `consent_withdrawal_date` DATE COMMENT 'Date on which this household member or their guardian withdrew consent for data processing. Triggers data anonymisation or deletion workflows per GDPR Article 17 right to erasure.',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 code for the country from which the household member originates. Distinct from nationality; used for refugee and IDP classification, UNHCR PoC (Person of Concern) reporting, and cross-border displacement analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member association record was first created in the system. Used for audit trails, data lineage, and MEL (Monitoring Evaluation and Learning) data quality reporting.',
    `data_collection_method` STRING COMMENT 'Method used to collect this household members registration data. FGD (Focus Group Discussion), KII (Key Informant Interview), KoboToolbox survey, or CommCare mobile form. Used for data quality assessment and MEL methodology documentation.. Valid values are `kobo_survey|commcare_mobile|paper_form|fgd|kii|other`',
    `date_of_birth` DATE COMMENT 'Date of birth of the household member. Used to calculate age for program eligibility (e.g., child nutrition programs, elderly support), dependency ratio, and demographic disaggregation in MEL reporting.',
    `disability_status` STRING COMMENT 'Recorded disability classification for the household member using the Washington Group Short Set framework. Used for inclusive programming, NFI adaptation, and SPHERE accessibility compliance reporting. [ENUM-REF-CANDIDATE: none|physical|sensory|cognitive|psychosocial|multiple|prefer_not_to_say — 7 candidates stripped; promote to reference product]',
    `displacement_status` STRING COMMENT 'Classification of the household members displacement situation. IDP (Internally Displaced Person), refugee, returnee, or host community member. Drives program eligibility, UNHCR PoC (Person of Concern) reporting, and OCHA SitRep (Situation Report) disaggregation. [ENUM-REF-CANDIDATE: idp|refugee|returnee|host_community|stateless|asylum_seeker|other — 7 candidates stripped; promote to reference product]',
    `education_level` STRING COMMENT 'Highest level of education attained by this household member. Used for livelihood program targeting, literacy-based service adaptation, and SDG (Sustainable Development Goal) 4 education indicator reporting. [ENUM-REF-CANDIDATE: none|primary_incomplete|primary_complete|secondary_incomplete|secondary_complete|tertiary|vocational|other — promote to reference product]',
    `family_name` STRING COMMENT 'Surname or family name of the household member as recorded during beneficiary registration. Combined with given_name for full identity verification.',
    `gender_identity` STRING COMMENT 'Self-identified gender of the household member, captured where programmatically relevant (e.g., GBV programs, PSS (Psychosocial Support) services). Distinct from biological sex. Collected only with informed consent per data protection standards.',
    `given_name` STRING COMMENT 'First or given name of the household member as recorded during beneficiary registration. Used for identity verification during distributions and case management follow-up.',
    `is_female_headed` BOOLEAN COMMENT 'Indicates whether this member is the head of a female-headed household. Used for gender-disaggregated reporting, targeted programming for female-headed households, and DAC (Development Assistance Committee) gender marker compliance.',
    `is_head_of_household` BOOLEAN COMMENT 'Indicates whether this member is the designated head of household. Only one member per household should have this flag set to true. Used for primary contact identification, distribution authorization, and household-level reporting.',
    `livelihood_status` STRING COMMENT 'Current livelihood or employment status of the household member. Used for economic vulnerability assessment, cash transfer program eligibility, and livelihoods program targeting.. Valid values are `employed|self_employed|unemployed|student|unable_to_work|not_applicable`',
    `membership_end_date` DATE COMMENT 'Date on which this individuals membership in the household ended, due to departure, transfer, death, or administrative closure. Null if membership is currently active.',
    `membership_end_reason` STRING COMMENT 'Reason code explaining why this individuals household membership ended. Required for attrition analysis, household composition tracking, and MEL (Monitoring Evaluation and Learning) reporting.. Valid values are `deceased|transferred_household|relocated|voluntary_exit|administrative_closure|other`',
    `membership_start_date` DATE COMMENT 'Date on which this individual formally joined or was registered as a member of the household. Used to determine eligibility windows for program benefits and historical household composition analysis.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this individuals membership in the household. Drives eligibility for household-level distributions and services. transferred indicates movement to another household; departed indicates voluntary exit.. Valid values are `active|inactive|transferred|deceased|departed`',
    `muac_assessment_date` DATE COMMENT 'Date on which the MUAC (Mid-Upper Arm Circumference) measurement was recorded for this household member. Used to determine recency of nutritional screening and trigger follow-up assessments per SPHERE protocols.',
    `muac_cm` DECIMAL(18,2) COMMENT 'MUAC (Mid-Upper Arm Circumference) measurement in centimetres recorded for this household member. Primary screening indicator for acute malnutrition (SAM/GAM). Values below 11.5cm indicate SAM (Severe Acute Malnutrition); 11.5–12.5cm indicate MAM (Moderate Acute Malnutrition).',
    `nationality_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the nationality of the household member. Used for IDP (Internally Displaced Person) and PoC (Person of Concern) classification, cross-border program eligibility, and UNHCR reporting.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for field staff to record additional observations, special circumstances, or case notes relevant to this household members situation. Classified as confidential due to potential sensitivity of recorded information.',
    `pregnant_or_lactating` BOOLEAN COMMENT 'Indicates whether this household member is currently pregnant or lactating. Used for nutrition program targeting (e.g., SAM/GAM treatment), supplementary feeding eligibility, and SPHERE maternal health standards compliance.',
    `primary_language_code` STRING COMMENT 'ISO 639-1/639-2 language code for the primary language spoken by this household member. Used for communication planning, interpreter assignment, and ensuring informed consent is obtained in the members language per CHS (Core Humanitarian Standard).. Valid values are `^[a-z]{2,3}$`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether this household member has an active protection concern (e.g., GBV risk, child protection issue, trafficking risk). Triggers case escalation in CommCare and referral to protection cluster. Stored as restricted due to sensitivity.',
    `registration_date` DATE COMMENT 'Date on which this household member was formally registered in the beneficiary management system (CommCare or KoboToolbox). Establishes the start of the individuals program eligibility timeline.',
    `registration_location_code` STRING COMMENT 'Code identifying the geographic location (camp, settlement, community, or administrative unit) where this household member was registered. Used for geographic disaggregation in MEL reporting and GIS (Geographic Information System) mapping.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{3,10}$`',
    `relationship_to_head` STRING COMMENT 'Describes the kinship or social relationship of this member to the designated head of household. Used for dependency ratio calculations, vulnerability scoring, and NFI distribution entitlement. [ENUM-REF-CANDIDATE: head|spouse|child|parent|sibling|dependent|other_relative|non_relative — promote to reference product]',
    `role` STRING COMMENT 'Functional role of this individual within the household structure, used for program targeting, NFI kit sizing, and household vulnerability profiling. Distinct from relationship_to_head which captures kinship; this captures programmatic classification.. Valid values are `head|spouse|child|dependent|elderly|other`',
    `school_enrollment_status` STRING COMMENT 'Current school enrollment status for household members of school age. Used for education program targeting, out-of-school children identification, and SDG 4 indicator tracking in DHIS2.. Valid values are `enrolled|not_enrolled|dropout|graduated|not_applicable`',
    `sex` STRING COMMENT 'Biological sex of the household member as recorded at registration. Used for gender disaggregation in MEL reporting, GBV (Gender-Based Violence) program targeting, and SPHERE/DAC (Development Assistance Committee) compliance reporting.. Valid values are `male|female|intersex|prefer_not_to_say`',
    `unaccompanied_minor` BOOLEAN COMMENT 'Indicates whether this household member is an unaccompanied or separated child (UASC). Triggers child protection protocols, case management escalation in CommCare, and mandatory reporting to child protection clusters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this household member association record was last modified. Used for change tracking, data synchronisation between CommCare/KoboToolbox and the lakehouse, and audit compliance.',
    `verification_date` DATE COMMENT 'Date on which the identity and eligibility verification was completed for this household member. Used for audit trails and determining when re-verification is due.',
    `verification_status` STRING COMMENT 'Status of identity and eligibility verification for this household member. verified indicates documentation has been reviewed and confirmed; rejected indicates the member failed verification and is ineligible for program benefits.. Valid values are `unverified|pending|verified|rejected`',
    `vulnerability_category` STRING COMMENT 'Primary vulnerability classification for this household member, used for program targeting, priority distribution, and MEL (Monitoring Evaluation and Learning) disaggregation. GBV (Gender-Based Violence) survivors and unaccompanied minors receive heightened protection protocols. [ENUM-REF-CANDIDATE: child_under_5|unaccompanied_minor|pregnant_lactating|elderly|gbv_survivor|disability|chronic_illness|other — promote to reference product]',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Association entity linking an individual registrant to their household. Captures role (head, spouse, child, dependent, elderly), relationship to head-of-household, membership start/end dates, and demographic attributes relevant to household composition analysis. Enables NFI distribution sizing, dependency ratio calculations, and vulnerability scoring at household level.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` (
    `vulnerability_profile_id` BIGINT COMMENT 'Unique system-generated identifier for the vulnerability profile record. Primary key for this entity.',
    `household_id` BIGINT COMMENT 'Reference to the household unit associated with this vulnerability profile. Enables household-level aggregation and targeting for program interventions.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary humanitarian or development program under which this vulnerability profile was generated or is being used for targeting. Links the profile to program-specific eligibility criteria and Theory of Change (ToC) outcomes.',
    `previous_profile_vulnerability_profile_id` BIGINT COMMENT 'Reference to the immediately preceding vulnerability profile record for this registrant, enabling longitudinal tracking of vulnerability changes over time. Populated when profile_status is superseded or when a new profile replaces an existing one.',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary or household head registered in the beneficiary registry. Links this vulnerability profile to the specific Person of Concern (PoC) or Internally Displaced Person (IDP) record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or field worker who conducted the vulnerability assessment. Used for quality assurance, accountability, and inter-rater reliability analysis in MEL processes.',
    `assessment_date` DATE COMMENT 'Date on which the most recent vulnerability assessment was conducted that materially changed or established this profile. Used for timeliness tracking and MEL reporting cycles.',
    `assessment_tool` STRING COMMENT 'Data collection tool or platform used to conduct the vulnerability assessment that generated this profile. Supports data quality tracking and source system lineage. Aligned with operational systems including KoboToolbox and CommCare.. Valid values are `KoboToolbox|CommCare|DHIS2|ODK|paper_based|other`',
    `children_under5_count` STRING COMMENT 'Number of children under 5 years of age in the household. Children under 5 are the primary target group for acute malnutrition screening (MUAC), vaccination campaigns, and early childhood development programs. Used for nutrition and child protection program sizing.',
    `chronic_illness_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has one or more documented chronic illnesses (e.g., HIV/AIDS, tuberculosis, diabetes, hypertension) that increase vulnerability and require sustained health service access. Drives health program targeting and DHIS2 health indicator reporting.',
    `chronic_illness_type` STRING COMMENT 'Coded description of the primary chronic illness condition affecting the beneficiary (e.g., HIV_AIDS, tuberculosis, diabetes, hypertension, malnutrition_chronic). Populated only when chronic_illness_flag is True. Aligned with ICD-11 coding where applicable.',
    `vulnerability_profile_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this vulnerability profile record, used in field operations, donor reporting, and inter-agency data sharing (e.g., VP-SOM-000123456).. Valid values are `^VP-[A-Z]{2,4}-[0-9]{6,10}$`',
    `composite_vulnerability_score` DECIMAL(18,2) COMMENT 'Aggregated multi-dimensional vulnerability score derived from weighted combination of food insecurity (IPC phase), protection risk, disability, nutritional status, displacement category, and other assessed indicators. Used for program targeting, beneficiary prioritization, and Results-Based Management (RBM) reporting. Score range typically 0.00–100.00.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary or their legal guardian. Required for data protection compliance and audit trail purposes.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or their legal guardian prior to data collection and vulnerability profiling. Mandatory for compliance with data protection regulations and CHS accountability standards.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the beneficiary is located. Used for multi-country program management, IATI reporting, and donor country-level disaggregation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vulnerability profile record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to their vulnerability data being shared with partner organizations and inter-agency coordination bodies (e.g., UNHCR, OCHA clusters). Governs data sharing under inter-agency data sharing agreements.',
    `disability_classification` STRING COMMENT 'Functional difficulty domain identified using the Washington Group Short Set on Functioning (WG-SS) questions. Captures the primary domain of disability: seeing, hearing, mobility, cognition, self-care, or communication. Used for inclusive programming and disability-disaggregated reporting per CRPD. [ENUM-REF-CANDIDATE: none|seeing|hearing|mobility|cognition|self_care|communication|multiple — promote to reference product]',
    `disability_severity` STRING COMMENT 'Severity of functional difficulty as measured by the Washington Group Short Set (WG-SS) response scale: no difficulty, some difficulty, a lot of difficulty, or cannot do at all. Used alongside disability_classification for disaggregated disability reporting.. Valid values are `no_difficulty|some_difficulty|a_lot_of_difficulty|cannot_do`',
    `displacement_category` STRING COMMENT 'Classification of the beneficiarys displacement status per UNHCR definitions. Internally Displaced Person (IDP) refers to those displaced within their country; refugee refers to those who have crossed international borders; returnee refers to those who have returned to their place of origin. Drives program eligibility and UNHCR/OCHA reporting.. Valid values are `IDP|refugee|returnee|stateless|asylum_seeker|host_community`',
    `elderly_member_flag` BOOLEAN COMMENT 'Indicates whether the household includes one or more elderly members (typically aged 60+). Elderly individuals are a recognized vulnerable group requiring targeted assistance per SPHERE and IASC age and disability inclusion guidelines.',
    `female_headed_household_flag` BOOLEAN COMMENT 'Indicates whether the household is headed by a woman. Female-headed households are recognized as a priority vulnerability category in humanitarian programming due to heightened protection risks and reduced access to resources. Used for gender-disaggregated reporting.',
    `gbv_exposure_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has been identified as a survivor or at-risk individual for Gender-Based Violence (GBV). Triggers referral to GBV case management services and specialized support programs. Handled with strict confidentiality per GBV information management protocols.',
    `geographic_area_code` STRING COMMENT 'Standardized code identifying the geographic area (admin level 2 or 3) where the beneficiary is located at the time of assessment. Used for geographic targeting, GIS mapping, and OCHA cluster reporting. Aligned with OCHA Common Operational Datasets (COD) administrative boundary codes.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{2,10}(-[A-Z0-9]{2,10})?$`',
    `ipc_phase` STRING COMMENT 'Food insecurity severity classification using the Integrated Food Security Phase Classification (IPC) scale: 1=Minimal, 2=Stressed, 3=Crisis, 4=Emergency, 5=Famine/Catastrophe. Used for food assistance targeting and donor reporting to BHA/USAID.',
    `livelihood_status` STRING COMMENT 'Assessment of the beneficiary households livelihood and income-generating capacity. none indicates complete loss of livelihood; disrupted indicates significant reduction; partial indicates some income sources remain; stable indicates adequate livelihood. Used for cash and voucher assistance (CVA) targeting.. Valid values are `none|disrupted|partial|stable`',
    `muac_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres, used as the primary anthropometric indicator for acute malnutrition screening in children under 5 and pregnant/lactating women. Thresholds: <115mm = SAM, 115–124mm = MAM, ≥125mm = normal. Collected via KoboToolbox or CommCare field surveys.',
    `next_reassessment_date` DATE COMMENT 'Scheduled date for the next vulnerability reassessment to ensure the profile reflects the beneficiarys current vulnerability state. Drives field operations scheduling and MEL monitoring cycles. Typically set based on program-specific reassessment frequency protocols.',
    `notes` STRING COMMENT 'Free-text field for field officers to record contextual observations, qualitative vulnerability factors, or case-specific notes that are not captured by structured indicators. Handled as confidential due to potential sensitivity of content.',
    `nutritional_status` STRING COMMENT 'Nutritional status classification based on anthropometric screening. Severe Acute Malnutrition (SAM) indicates MUAC < 115mm or WHZ < -3; Moderate Acute Malnutrition (MAM) indicates MUAC 115–124mm or WHZ -2 to -3; normal indicates adequate nutritional status. Used for therapeutic feeding program targeting and Global Acute Malnutrition (GAM) rate reporting.. Valid values are `SAM|MAM|normal|overweight`',
    `pregnant_lactating_flag` BOOLEAN COMMENT 'Indicates whether the household includes a pregnant or lactating woman (PLW). PLWs are a priority group for nutrition programming (supplementary feeding), antenatal care, and maternal health services. Used for CMAM and nutrition program targeting.',
    `protection_risk_level` STRING COMMENT 'Assessed level of protection risk for the individual or household, encompassing threats of violence, exploitation, abuse, and discrimination. Classified by a trained protection officer. Drives case prioritization and referral pathways per UNHCR Protection Framework.. Valid values are `critical|high|medium|low|none`',
    `pss_need_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary has been assessed as requiring Psychosocial Support (PSS) services, including mental health support, trauma counselling, or community-based psychosocial activities. Triggers referral to PSS programming.',
    `shelter_adequacy` STRING COMMENT 'Assessment of the beneficiarys shelter situation against SPHERE minimum standards. none indicates no shelter; inadequate indicates shelter below minimum standards; transitional indicates temporary/emergency shelter; adequate indicates shelter meeting minimum standards. Drives NFI and shelter program targeting.. Valid values are `adequate|inadequate|none|transitional`',
    `source` STRING COMMENT 'Indicates the operational process or event that triggered the creation or update of this vulnerability profile. post_distribution_monitoring refers to Post-Distribution Monitoring (PDM) assessments; emergency_screening refers to rapid assessments during acute crises. Used for MEL data quality analysis.. Valid values are `initial_registration|periodic_reassessment|post_distribution_monitoring|emergency_screening|referral|other`',
    `vulnerability_profile_status` STRING COMMENT 'Current lifecycle state of the vulnerability profile record. active indicates the current consolidated vulnerability state; superseded indicates a newer profile has replaced this one; pending_review indicates awaiting validation by a protection or MEL officer.. Valid values are `active|archived|pending_review|superseded|draft`',
    `unaccompanied_minor_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary is an unaccompanied or separated child (UASC) — a child under 18 separated from both parents and other relatives and not being cared for by a responsible adult. Triggers child protection case management and family tracing and reunification (FTR) services.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vulnerability profile was last modified, reflecting the most recent update to any vulnerability indicator. Triggers downstream re-targeting and prioritization workflows.',
    `vulnerability_tier` STRING COMMENT 'Categorical tier derived from the composite vulnerability score, used for operational targeting and prioritization decisions. critical indicates immediate life-saving intervention required; high indicates priority program enrollment; medium and low indicate standard program eligibility. Distinct from composite_vulnerability_score which is the numeric value.. Valid values are `critical|high|medium|low`',
    `wash_access_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary household has adequate access to safe water, sanitation, and hygiene (WASH) facilities meeting SPHERE minimum standards. False indicates a WASH vulnerability requiring intervention. Used for WASH sector targeting and OCHA cluster reporting.',
    CONSTRAINT pk_vulnerability_profile PRIMARY KEY(`vulnerability_profile_id`)
) COMMENT 'Structured vulnerability assessment record for a registrant or household capturing multi-dimensional vulnerability indicators including food insecurity score (IPC phase classification), protection risk level, disability classification (Washington Group questions), chronic illness flags, GAM/SAM nutritional status (MUAC measurement), GBV exposure flag, displacement category (IDP, refugee, returnee), and composite vulnerability score used for program targeting and prioritization. Distinct from needs_assessment which captures point-in-time sector-specific assessment findings — vulnerability_profile represents the beneficiarys current consolidated vulnerability state derived from multiple assessment inputs. Updated when new assessment data materially changes vulnerability classification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` (
    `beneficiary_needs_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each needs assessment record. Primary key for the needs_assessment data product within the beneficiary domain.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to the beneficiary compliance corrective action plan associated with this needs assessment',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Needs assessments identify specific commodity requirements (NFI kits, food baskets, WASH items, shelter materials) for beneficiaries. Essential for humanitarian needs-based procurement planning and Sp',
    `community_engagement_event_id` BIGINT COMMENT 'Foreign key linking to communication.community_engagement_event. Business justification: Needs assessments are frequently conducted during community engagement events (focus group discussions, community consultations, participatory assessments). Links assessment data to the event context,',
    `community_id` BIGINT COMMENT 'Reference to the community or settlement unit that is the subject of this assessment when assessment_level is community. Nullable when assessment_level is individual or household.',
    `data_collection_tool_id` BIGINT COMMENT 'The unique identifier of the data collection instrument used to conduct this assessment. For KoboToolbox, this is the form UID (e.g., aXmK3p9QrT). For CommCare, this is the module ID. Enables traceability back to the specific questionnaire version and supports data quality audits.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers conduct needs assessments in many NGO operations (household surveys, vulnerability assessments, rapid assessments). Standard practice for community-based data collection. Required for track',
    `household_id` BIGINT COMMENT 'Reference to the household unit that is the subject of this assessment when assessment_level is household. Nullable when assessment_level is individual or community.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this needs assessment was commissioned. Links the assessment to the programs Theory of Change (ToC) and LogFrame targeting criteria.',
    `mel_needs_assessment_id` BIGINT COMMENT 'FK to SSOT owner mel.mel_needs_assessment for entity needs_assessment',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partners conduct needs assessments in their operational areas under consortium or sub-award arrangements. Tracking the assessing partner is required for data quality oversight, capacity assessment val',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or volunteer who conducted the field assessment. Used for quality assurance, inter-rater reliability checks, and enumerator performance monitoring.',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (IDP, PoC, GBV survivor, or other target population member) who is the subject of this assessment when assessment_level is individual. Nullable when assessment_level is household or community.',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (e.g., province, state, region) where the assessment was conducted. Sourced from OCHA Common Operational Datasets (CODs) administrative boundary reference. Used for geographic aggregation in SitReps and donor reports.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (e.g., district, county, department) where the assessment was conducted. Sourced from OCHA CODs. Enables sub-national geographic disaggregation for targeting and cluster coordination reporting.',
    `children_under5_count` STRING COMMENT 'Number of children under 5 years of age in the assessed household. Key vulnerability indicator for nutrition (SAM/GAM screening), WASH (diarrhoea risk), and child protection programming. Required for UNICEF and WFP programme targeting.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or household head prior to conducting the assessment. Mandatory per CHS Commitment 4 (Accountability to Affected Populations) and GDPR Article 6 for data processing lawfulness. Must be TRUE for the record to be validated.',
    `consent_type` STRING COMMENT 'The form of informed consent obtained. verbal is spoken consent recorded by enumerator; written is signed consent form; proxy is consent given by a guardian or community leader on behalf of a vulnerable individual (e.g., child, person with disability). Relevant for legal compliance and data protection audits.. Valid values are `verbal|written|proxy`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the assessment was conducted (e.g., SOM, SSD, HTI). Used for IATI reporting, donor country-level aggregation, and cross-country comparative analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this needs assessment record was first created in the data platform (Silver layer ingestion timestamp). Distinct from assessment_date (field event date). Used for data pipeline monitoring and audit trail compliance.',
    `data_collection_method` STRING COMMENT 'The primary method used to gather assessment data. face_to_face is direct in-person interview; remote_phone is telephone-based; fgd is a Focus Group Discussion (FGD); kii is a Key Informant Interview (KII); observation is direct field observation without interview; secondary_data is derived from existing records. Affects data quality weighting in vulnerability scoring.. Valid values are `face_to_face|remote_phone|fgd|kii|observation|secondary_data`',
    `beneficiary_needs_assessment_date` DATE COMMENT 'The calendar date on which the needs assessment was physically conducted in the field. This is the principal real-world event date, distinct from the record submission or validation timestamps. Used for temporal targeting analysis and periodic reassessment scheduling.',
    `displacement_status` STRING COMMENT 'The displacement classification of the assessed individual or household at the time of assessment. idp = Internally Displaced Person (IDP); refugee = person with international protection status; returnee = person returning to place of origin; host_community = non-displaced community member hosting displaced persons. Critical for UNHCR/OCHA population movement tracking.. Valid values are `idp|refugee|returnee|host_community|stateless|non_displaced`',
    `education_score` DECIMAL(18,2) COMMENT 'Numeric score for the education sector assessment findings. Null if education was not included in sectors_assessed. Covers school access, enrollment barriers, learning environment safety, and teacher availability against SPHERE/INEE minimum standards.',
    `enumerator_notes` STRING COMMENT 'Free-text qualitative observations recorded by the field enumerator during the assessment. Captures contextual information not covered by structured questions (e.g., security constraints, access limitations, observed conditions). Used by supervisors during validation review.',
    `female_headed_household` BOOLEAN COMMENT 'Indicates whether the assessed household is headed by a female. Female-headed households are a standard vulnerability marker in humanitarian targeting criteria and are required for gender disaggregation in donor reports (USAID, DFID/FCDO, UN Women standards).',
    `gbv_risk_flag` BOOLEAN COMMENT 'Indicates whether the assessment identified elevated Gender-Based Violence (GBV) risk for the assessed individual or household. When TRUE, triggers referral to GBV case management pathway and PSS services. Classified as restricted PHI due to extreme sensitivity of GBV disclosure data.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated GPS accuracy in meters at the time of coordinate capture, as reported by the mobile device. KoboToolbox and CommCare record this automatically. Values above 30 meters may indicate unreliable location data and trigger data quality flags.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the assessment location captured by the field enumerators device via KoboToolbox or CommCare GPS capture. Used for GIS mapping, cluster analysis, and geographic targeting in humanitarian response planning.',
    `beneficiary_needs_assessment_level` STRING COMMENT 'The unit of analysis at which this needs assessment was conducted. individual targets a single beneficiary (e.g., GBV survivor, SAM case); household targets a family unit; community targets a settlement or geographic cluster. Determines which of beneficiary_id, household_id, or community_id is populated.. Valid values are `individual|household|community`',
    `livelihoods_score` DECIMAL(18,2) COMMENT 'Numeric score for the livelihoods sector assessment findings. Null if livelihoods was not included in sectors_assessed. Covers income sources, asset ownership, market access, and economic vulnerability indicators.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the assessment location captured by the field enumerators device. Used alongside latitude for GIS mapping, spatial clustering, and geographic targeting in humanitarian response planning.',
    `muac_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres for children under 5 or pregnant/lactating women, used to screen for acute malnutrition. MUAC < 115mm indicates SAM; 115–125mm indicates MAM. Classified as PHI as it is a direct health measurement linked to an individual. Null if not applicable to assessment subject.',
    `nutrition_score` DECIMAL(18,2) COMMENT 'Numeric score for the nutrition sector assessment findings. Null if nutrition was not included in sectors_assessed. Incorporates Global Acute Malnutrition (GAM) and Severe Acute Malnutrition (SAM) indicators where applicable. Feeds into DHIS2 nutrition indicator tracking.',
    `overall_vulnerability_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the assessed subjects overall vulnerability level, calculated from sector-specific findings using the programs scoring methodology (e.g., 0–100 scale). Feeds into vulnerability_profile updates when the score materially changes vulnerability classification. This is a raw assessment output, not a derived KPI.',
    `persons_with_disability_count` STRING COMMENT 'Number of household members with a physical, sensory, intellectual, or psychosocial disability. Required for disability-inclusive programming per IASC Guidelines on Inclusion of Persons with Disabilities in Humanitarian Action and CRPD compliance reporting.',
    `protection_score` DECIMAL(18,2) COMMENT 'Numeric score for the protection sector assessment findings. Null if protection was not included in sectors_assessed. Covers GBV risk, child protection, housing land and property rights, and documentation status. Sensitive findings are handled per GBV information management protocols.',
    `reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this needs assessment, used in field reports, SitReps, and donor communications. Format: NA-{COUNTRY}-{YEAR}-{SEQUENCE}. Sourced from KoboToolbox or CommCare submission ID.. Valid values are `^NA-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `referral_recommended` BOOLEAN COMMENT 'Indicates whether the assessment findings recommend referral of the beneficiary or household to one or more service providers or program interventions. When TRUE, a referral pathway is initiated in CommCare case management. Drives downstream case management workflow.',
    `referral_sectors` STRING COMMENT 'Pipe-delimited list of sectors to which the beneficiary or household is being referred based on assessment findings (e.g., nutrition|PSS|WASH). Populated only when referral_recommended is TRUE. Drives service pathway activation in CommCare and Microsoft Dynamics 365 case management.',
    `sectors_assessed` STRING COMMENT 'Pipe-delimited list of humanitarian/development sectors covered in this assessment (e.g., WASH|nutrition|shelter|protection|livelihoods|education). Sectors align with IASC cluster system. Determines which sector-specific scored findings fields are populated. [ENUM-REF-CANDIDATE: WASH|nutrition|shelter|protection|livelihoods|education|health|food_security|NFI|PSS — promote to reference product]',
    `shelter_score` DECIMAL(18,2) COMMENT 'Numeric score for the shelter sector assessment findings. Null if shelter was not included in sectors_assessed. Assessed against SPHERE minimum standards for covered living space, structural safety, and thermal comfort.',
    `source_submission_reference` STRING COMMENT 'The native submission or case ID from the originating source system (KoboToolbox submission UUID or CommCare case ID). Enables exact record traceability back to the source system for data reconciliation, duplicate detection, and audit purposes.',
    `beneficiary_needs_assessment_status` STRING COMMENT 'Current workflow lifecycle state of the needs assessment record. draft indicates field data entry in progress; submitted indicates enumerator submission pending review; validated indicates supervisor-approved and usable for targeting; rejected indicates data quality failure requiring re-assessment.. Valid values are `draft|submitted|under_review|validated|rejected|archived`',
    `supervisor_validation_notes` STRING COMMENT 'Free-text notes entered by the supervising data manager or MEL officer during the assessment review and validation process. Documents reasons for rejection, data quality concerns, or approval rationale. Populated when assessment_status transitions to validated or rejected.',
    `tool_version` STRING COMMENT 'Version number or deployment date of the assessment tool/form used. Critical for longitudinal comparability — when a KoboToolbox form or CommCare module is updated, findings from different versions may not be directly comparable without version-aware analysis.',
    `beneficiary_needs_assessment_type` STRING COMMENT 'Classification of the assessments purpose and methodology. initial_registration is conducted at first beneficiary contact; periodic_reassessment is a scheduled follow-up to update vulnerability status; post_crisis_rapid is an emergency rapid assessment following a shock event; sector_specific_deep is an in-depth assessment for a single sector (e.g., nutrition MUAC screening, WASH facility survey).. Valid values are `initial_registration|periodic_reassessment|post_crisis_rapid|sector_specific_deep`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this needs assessment record was most recently modified in the data platform. Tracks post-ingestion corrections, validation status changes, and supervisor note additions. Required for Silver layer change data capture (CDC) processing.',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the assessment record was validated or rejected by the supervising staff member. Distinct from assessment_date (field event) and created_timestamp (record creation). Used for SLA monitoring of data quality review turnaround.',
    `vulnerability_category` STRING COMMENT 'Categorical classification of the assessed subjects vulnerability level derived from the overall_vulnerability_score and program-specific thresholds. Used for beneficiary targeting, prioritization, and service referral decisions. critical triggers immediate case management escalation.. Valid values are `critical|high|medium|low|not_vulnerable`',
    `wash_score` DECIMAL(18,2) COMMENT 'Numeric score for the Water, Sanitation and Hygiene (WASH) sector assessment findings. Null if WASH was not included in sectors_assessed. Scored against SPHERE minimum standards for water access, sanitation facilities, and hygiene promotion.',
    CONSTRAINT pk_beneficiary_needs_assessment PRIMARY KEY(`beneficiary_needs_assessment_id`)
) COMMENT 'Transactional record of a formal needs assessment conducted for an individual beneficiary, household, or community to determine eligibility, vulnerability level, and appropriate service referrals. Captures assessment date, assessment level (individual, household, community), assessment type (initial registration assessment, periodic reassessment, post-crisis rapid assessment, sector-specific deep assessment), sectors assessed (WASH, nutrition, shelter, protection, livelihoods, education), assessment tool identifier (KoboToolbox form ID, CommCare module), field enumerator, geographic coordinates, and scored findings per sector. Owned by beneficiary domain as it determines beneficiary status and targeting — distinct from MEL post-distribution monitoring which measures program effectiveness. Assessment findings feed into vulnerability_profile updates when they materially change vulnerability classification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique system-generated identifier for each consent record. Primary key for the consent_record data product within the beneficiary domain.',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program for which consent is being obtained. Enables program-level consent tracking and MEL reporting.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Specific donor agreements mandate consent collection standards (GDPR for EU donors, safeguarding protocols, data sharing permissions). Consent records demonstrate fulfillment of these contractual comp',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or field worker who witnessed the consent process. Links to the workforce staff_member record for accountability and audit trail purposes.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary (individual, household head, or community representative) whose consent is being recorded. Links to the beneficiary master record in CommCare or KoboToolbox.',
    `biometric_enrollment_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to biometric data enrollment (fingerprint, iris scan, facial recognition) for identity verification and deduplication purposes. True = biometric enrollment permitted; False = not permitted.',
    `chs_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent record meets all requirements of the Core Humanitarian Standard (CHS) Commitment 4 on accountability to affected populations. True = CHS compliant; False = non-compliant or pending review. Used in CHS certification audits.',
    `collection_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where consent was collected (e.g., SOM for Somalia, SSD for South Sudan). Supports multi-country program reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `collection_location` STRING COMMENT 'Name or description of the physical location where consent was collected (e.g., registration site name, health facility, IDP camp name, community center). Supports geographic analysis and field operations reporting.',
    `consent_date` DATE COMMENT 'The calendar date on which the beneficiary provided, withdrew, or refused consent. This is the principal real-world event date for the consent transaction, distinct from the record creation timestamp.',
    `consent_form_version` STRING COMMENT 'Version identifier of the consent form template used at the time of consent collection (e.g., v1.0, v2.3). Enables tracking of which version of the consent language and terms the beneficiary agreed to, critical for compliance audits.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `consent_language` STRING COMMENT 'ISO 639-1 or ISO 639-3 language code representing the language in which consent was communicated and obtained. Ensures accountability that consent was given in the beneficiarys understood language (e.g., ar for Arabic, fr for French, so for Somali). Critical for CHS accountability compliance.. Valid values are `^[a-z]{2,3}(-[A-Z]{2,3})?$`',
    `consent_method` STRING COMMENT 'The method by which consent was obtained from the beneficiary. verbal for spoken agreement (audio-recorded or witnessed); written for signed paper form; digital for electronic signature or mobile app confirmation; thumbprint for biometric ink impression; proxy for consent given by a guardian or authorized representative on behalf of a minor or incapacitated individual.. Valid values are `verbal|written|digital|thumbprint|proxy`',
    `consent_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to this consent record, used in field operations, case referrals, and compliance reporting. Format: CNS-[COUNTRY]-[YEAR]-[SEQUENCE].. Valid values are `^CNS-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. given indicates active informed consent; withdrawn indicates the beneficiary has revoked consent; pending indicates consent is awaited; expired indicates the consent period has lapsed; refused indicates explicit refusal.. Valid values are `given|withdrawn|pending|expired|refused`',
    `consent_type` STRING COMMENT 'Classification of the specific type of consent being recorded. Covers data processing consent (GDPR/privacy), photography and media use, inter-agency case referral, biometric enrollment, program participation, and research/survey participation. [ENUM-REF-CANDIDATE: data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey — promote to reference product]. Valid values are `data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was first created in the system. Audit trail field supporting data lineage, compliance reporting, and GDPR accountability obligations.',
    `data_retention_period_days` STRING COMMENT 'The number of days for which the beneficiarys data may be retained under this consent, as agreed at the time of consent collection. Drives automated data retention and deletion workflows. Aligned with GDPR storage limitation principle.',
    `data_scope` STRING COMMENT 'Description of the specific data elements, activities, or purposes covered by this consent record (e.g., collection and storage of household survey data, sharing of case data with UNHCR for referral). Defines the boundaries of what the beneficiary has consented to.',
    `digital_signature_reference` STRING COMMENT 'Reference identifier or hash of the digital signature captured when consent_method is digital. Links to the secure digital signature storage system. Not the signature itself — a reference token for audit trail purposes.',
    `effective_from_date` DATE COMMENT 'The date from which the consent becomes legally and operationally binding. May differ from consent_date if there is a processing delay or a future-dated consent arrangement.',
    `expiry_date` DATE COMMENT 'The date on which the consent expires and must be renewed. Nullable for open-ended consents. Supports automated consent renewal workflows and compliance with data retention policies.',
    `form_attachment_reference` STRING COMMENT 'File path, URL, or document management system reference to the scanned or digital copy of the signed consent form. Enables retrieval of the original consent document for audit and legal purposes.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether the EU General Data Protection Regulation (GDPR) applies to this consent record based on the beneficiarys location, the organizations jurisdiction, or the data controllers domicile. True = GDPR applies; False = GDPR does not apply.',
    `informed_consent_verified` BOOLEAN COMMENT 'Indicates whether a supervisor or quality assurance officer has verified that the consent was truly informed (i.e., the beneficiary understood the purpose, scope, and their rights before consenting). True = verified; False = pending verification.',
    `is_proxy_consent` BOOLEAN COMMENT 'Indicates whether consent was given by a proxy (guardian, parent, or authorized representative) on behalf of a minor, elderly, or incapacitated beneficiary. True = proxy consent; False = direct consent from the beneficiary.',
    `notes` STRING COMMENT 'Free-text field for additional contextual notes about the consent process, any special circumstances, beneficiary concerns raised, or follow-up actions required. Used by field staff and MEL officers for qualitative documentation.',
    `photography_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to being photographed or filmed for organizational communications, donor reporting, or advocacy purposes. True = photography/media use permitted; False = not permitted.',
    `proxy_name` STRING COMMENT 'Full name of the proxy individual (guardian, parent, or authorized representative) who provided consent on behalf of the beneficiary. Populated only when is_proxy_consent is True.',
    `proxy_relationship` STRING COMMENT 'The relationship of the proxy consent giver to the beneficiary (e.g., parent, guardian, legal representative). Populated only when is_proxy_consent is True. [ENUM-REF-CANDIDATE: parent|guardian|spouse|sibling|community_leader|legal_representative|other — promote to reference product]',
    `sharing_permitted` BOOLEAN COMMENT 'Indicates whether the beneficiary has consented to their data being shared with third-party organizations (e.g., partner NGOs, UN agencies, government bodies). True = sharing permitted; False = sharing not permitted. Critical for inter-agency data sharing compliance.',
    `sharing_restrictions` STRING COMMENT 'Free-text description of any specific restrictions or conditions placed by the beneficiary on data sharing (e.g., not to be shared with government authorities, only for health program purposes). Populated when sharing_permitted is True but with conditions.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this consent record in the originating operational system (CommCare case ID, KoboToolbox submission UUID, Dynamics 365 record ID). Enables traceability and reconciliation between the lakehouse silver layer and source systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this consent record was most recently modified. Tracks consent status changes, withdrawals, and verification updates for audit trail and data governance purposes.',
    `verification_date` DATE COMMENT 'The date on which a supervisor or quality assurance officer verified that the consent was properly informed and documented. Populated only when informed_consent_verified is True.',
    `withdrawal_date` DATE COMMENT 'The date on which the beneficiary formally withdrew their previously given consent. Populated only when consent_status is withdrawn. Triggers downstream data deletion or anonymization workflows per GDPR right to erasure.',
    `withdrawal_reason` STRING COMMENT 'Free-text description of the reason provided by the beneficiary or their representative for withdrawing consent. Populated only when consent_status is withdrawn. Used for accountability reporting and program improvement.',
    `witness_name` STRING COMMENT 'Full name of the field staff member or community witness who witnessed the consent process. Required for verbal and thumbprint consent methods to ensure accountability and legal validity.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Formal consent management record capturing a beneficiarys informed consent for data collection, storage, sharing, and program participation. Stores consent type (data processing, photography, case referral, biometric enrollment), consent status (given, withdrawn, pending), consent date, consent method (verbal, written, digital), language of consent, witness details, and CHS (Core Humanitarian Standard) accountability compliance flags.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` (
    `case_record_id` BIGINT COMMENT 'Unique surrogate identifier for the longitudinal case management record within the beneficiary domain. Primary key for all case-level joins and lineage tracking.',
    `award_id` BIGINT COMMENT 'Reference to the donor grant funding the program under which this case is managed. Required for donor accountability reporting, BvA tracking, and compliance with grant conditions (e.g., USAID BHA, CERF, DFID).',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Case management systems track compliance incidents (fraud, safeguarding, misconduct allegations) that trigger beneficiary case records. Essential for safeguarding workflows and incident response docum',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Case management reviews identify quality issues (incomplete documentation, missed follow-ups, protocol violations). CAPs reference specific cases as examples and track remediation. Required for intern',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic location (camp, settlement, district, or facility) where the case is being managed. Supports GIS-based field operations mapping and geographic disaggregation in MEL reporting.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this case is managed (e.g., GBV response, child protection, nutrition, PSS, livelihoods).',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Case management services are frequently delivered by partner organizations under sub-awards or consortium agreements. Tracking which partner manages each case is essential for performance monitoring, ',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Case management services (protection, health, psychosocial support) are delivered at specific field facilities. Required for service delivery reporting, referral pathway management, and site-level cas',
    `registrant_id` BIGINT COMMENT 'Reference to the individual beneficiary (Person of Concern / IDP / GBV survivor) who is the subject of this case record. Core party linkage for the case.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or community health worker assigned as the primary caseworker responsible for managing and following up on this case.',
    `case_narrative` STRING COMMENT 'Free-text longitudinal narrative documenting the beneficiarys situation, interventions provided, progress notes, and caseworker observations. Contains sensitive personal and protection information. Restricted access per data protection protocols.',
    `case_number` STRING COMMENT 'Human-readable, externally-known unique case reference code assigned at registration. Used in field communications, referral letters, and donor/compliance reporting. Format: CASE-{PROGRAM_CODE}-{YEAR}-{SEQUENCE}.. Valid values are `^CASE-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `case_plan_developed` BOOLEAN COMMENT 'Indicates whether a formal individualized case plan has been developed and documented for this beneficiary. A case plan is a mandatory element of structured case management per IASC standards.',
    `case_stage` STRING COMMENT 'Current stage within the structured case management workflow cycle (intake → assessment → planning → intervention → monitoring → closure). Distinct from case_status; represents the process phase rather than the operational state.. Valid values are `intake|assessment|planning|intervention|monitoring|closure`',
    `case_status` STRING COMMENT 'Current lifecycle state of the case record within the CommCare case management workflow. Drives operational dashboards, caseload reporting, and MEL tracking.. Valid values are `open|in_progress|on_hold|closed|cancelled`',
    `case_type` STRING COMMENT 'Classification of the case by humanitarian sector or service modality. Drives workflow routing, referral pathways, and MEL indicator disaggregation. [ENUM-REF-CANDIDATE: protection|gbv|child_protection|pss|nutrition|health|livelihoods — promote to reference product]',
    `close_date` DATE COMMENT 'Calendar date on which the case was formally closed. Null if the case remains open or in-progress. Used to calculate case duration and throughput metrics.',
    `closure_reason` STRING COMMENT 'Standardized reason for case closure. Used for caseload quality analysis, MEL outcome disaggregation, and donor accountability reporting. [ENUM-REF-CANDIDATE: services_completed|voluntary_withdrawal|lost_to_followup|transferred|deceased|duplicate|other — promote to reference product]',
    `commcare_case_reference` STRING COMMENT 'Source system case identifier from CommCare mobile case management platform. Used for data lineage, reconciliation, and integration with field data collection workflows.',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary or legal guardian. Required for data protection compliance and audit trail.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary (or guardian) prior to case registration and data collection, in compliance with data protection and humanitarian accountability standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the case record was first created in the data platform. Used for audit trail, data lineage, and compliance with GDPR and OMB Uniform Guidance record-keeping requirements.',
    `data_collection_method` STRING COMMENT 'Method used to collect and register case data (e.g., CommCare mobile form, KoboToolbox survey, paper form, phone interview, FGD, KII). Used for data quality assessment and ICT4D performance monitoring. [ENUM-REF-CANDIDATE: commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii — promote to reference product]. Valid values are `commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii`',
    `is_child_case` BOOLEAN COMMENT 'Indicates whether the beneficiary is a child (under 18 years of age). Triggers child protection protocols, guardian consent requirements, and UNICEF/child protection cluster reporting obligations.',
    `is_gbv_case` BOOLEAN COMMENT 'Indicates whether this case involves Gender-Based Violence (GBV). Enables secure, disaggregated GBV caseload reporting while maintaining strict data protection protocols per IASC GBV guidelines.',
    `is_idp_case` BOOLEAN COMMENT 'Indicates whether the beneficiary is an Internally Displaced Person (IDP). Used for OCHA displacement tracking, Cluster reporting, and disaggregated humanitarian response analysis.',
    `last_followup_date` DATE COMMENT 'Date of the most recent caseworker interaction or follow-up visit recorded for this case. Used to identify inactive cases and trigger escalation workflows.',
    `legal_aid_required` BOOLEAN COMMENT 'Indicates whether the beneficiary requires legal aid services as part of the case management plan (e.g., documentation, asylum claims, GBV legal redress). Triggers referral to legal service providers.',
    `muac_cm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in centimetres recorded at case intake for nutrition cases. Used to classify Severe Acute Malnutrition (SAM) and Global Acute Malnutrition (GAM) per SPHERE/WHO thresholds. Applicable to nutrition case types only.',
    `next_followup_date` DATE COMMENT 'Scheduled date for the next planned caseworker interaction or home visit. Drives field scheduling and caseload management in CommCare.',
    `nutrition_status` STRING COMMENT 'Classified nutritional status of the beneficiary based on MUAC and/or weight-for-height z-score. SAM = Severe Acute Malnutrition; MAM = Moderate Acute Malnutrition. Drives therapeutic feeding program enrollment and DHIS2 health indicator reporting.. Valid values are `sam|mam|normal|at_risk`',
    `on_hold_reason` STRING COMMENT 'Free-text or coded reason explaining why the case has been placed on hold (e.g., beneficiary unreachable, security access constraints, awaiting referral response). Populated only when case_status = on_hold.',
    `open_date` DATE COMMENT 'Calendar date on which the case was formally opened and registered in the case management system. Used for caseload aging analysis and response time measurement.',
    `outcome_classification` STRING COMMENT 'Standardized classification of the case result at closure. Used for MEL outcome reporting, donor accountability, and Theory of Change (ToC) validation. [ENUM-REF-CANDIDATE: goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased — promote to reference product]. Valid values are `goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased`',
    `presenting_issue` STRING COMMENT 'Primary issue or need presented by the beneficiary at case intake, as documented by the caseworker (e.g., acute malnutrition, GBV incident, displacement, lack of shelter, psychosocial distress).',
    `priority_level` STRING COMMENT 'Urgency classification assigned to the case based on vulnerability assessment, protection risk, or medical severity. Determines response time SLAs and caseworker allocation.. Valid values are `critical|high|medium|low`',
    `protection_risk_level` STRING COMMENT 'Assessed level of protection risk for the beneficiary at the time of case opening, based on IASC protection risk analysis. Drives escalation protocols and inter-agency coordination.. Valid values are `extreme|high|medium|low|none`',
    `pss_session_count` STRING COMMENT 'Number of Psychosocial Support (PSS) sessions attended by the beneficiary under this case. Used for MEL output tracking, minimum dose compliance, and donor reporting on PSS program reach.',
    `referral_date` DATE COMMENT 'Date on which the beneficiary was referred to an external service or organization. Used to measure referral response time and inter-agency coordination effectiveness.',
    `referral_destination` STRING COMMENT 'Name or code of the organization, facility, or service to which the beneficiary was referred out from this case (e.g., health clinic, legal aid, shelter). Supports inter-agency referral pathway tracking.',
    `referral_source` STRING COMMENT 'Channel or entity through which the beneficiary was referred into this case. Used for referral pathway analysis and community outreach effectiveness reporting. [ENUM-REF-CANDIDATE: self_referral|community_referral|health_facility|partner_org|government|hotline|other — promote to reference product]',
    `safety_plan_in_place` BOOLEAN COMMENT 'Indicates whether a formal safety plan has been developed and agreed with the beneficiary, particularly for GBV and protection cases. Required element of minimum case management standards.',
    `service_modality` STRING COMMENT 'Mode of service delivery used for this case (e.g., in-person clinic visit, remote counselling, mobile outreach, group PSS session, home visit). Used for operational planning and cost analysis.. Valid values are `in_person|remote|mobile_outreach|group_session|home_visit`',
    `supervisor_review_required` BOOLEAN COMMENT 'Indicates whether this case has been flagged for mandatory supervisory review, typically due to critical priority, complex protection risk, or escalation trigger. Supports quality assurance and safeguarding protocols.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the case record. Used for change detection, incremental data loading in the Databricks Silver layer, and audit compliance.',
    `vulnerability_score` STRING COMMENT 'Composite numeric score derived from the beneficiary needs assessment, reflecting overall vulnerability level (e.g., 0–100 scale). Used for prioritization, targeting, and MEL disaggregation. Higher scores indicate greater vulnerability.',
    CONSTRAINT pk_case_record PRIMARY KEY(`case_record_id`)
) COMMENT 'Longitudinal case management record for an individual beneficiary requiring structured follow-up. Captures case type (protection, GBV, child protection, PSS, nutrition, health, livelihoods), status (open, in-progress, on-hold, closed), priority level, assigned caseworker, opening/closing dates, referral pathway, outcome classification, and case narrative. Primary operational entity for CommCare case management workflows.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` (
    `case_action_id` BIGINT COMMENT 'Unique system-generated identifier for each case action record within the beneficiary case management system. Primary key for the case_action data product.',
    `case_record_id` BIGINT COMMENT 'Reference to the parent beneficiary case to which this action belongs. Links the action to the overarching case record for the individual, household, or community being served.',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this case action is being delivered. Enables program-level aggregation of service delivery activities.',
    `constituent_message_id` BIGINT COMMENT 'Foreign key linking to communication.constituent_message. Business justification: Case workers send SMS/email confirmations, appointment reminders, and follow-up messages during case actions (home visits, counseling). Tracking which message was sent during which action is essential',
    `feedback_submission_id` BIGINT COMMENT 'Foreign key linking to communication.feedback_submission. Business justification: Post-service satisfaction surveys and feedback collection are triggered by case actions (service delivery, counseling sessions). Links feedback to the specific action being evaluated, enabling service',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Individual case actions (counseling sessions, referrals, service delivery) are often executed by partner staff. Tracking the implementing partner per action enables activity-based costing, partner per',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Individual case actions (counseling sessions, health consultations, legal aid) occur at field sites. Essential for activity-based reporting, service utilization analysis, and site performance monitori',
    `registrant_id` BIGINT COMMENT 'Reference to the primary beneficiary (individual, household head, or community representative) who is the subject of this case action. Enables direct beneficiary-level reporting without joining through the case.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or case worker responsible for executing this case action. Supports workload management, supervision, and accountability tracking.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Case management actions are frequently performed by trained volunteers (community health workers, protection monitors, PSS facilitators). Essential for tracking who delivered services, accountability,',
    `admin_level1_code` STRING COMMENT 'ISO 3166-2 or OCHA P-Code for the first administrative division (e.g., state, province, region) where the action was conducted. Used for geographic disaggregation in donor and cluster reports.',
    `admin_level2_code` STRING COMMENT 'OCHA P-Code for the second administrative division (e.g., district, county, woreda) where the action was conducted. Enables sub-national geographic disaggregation for MEL and cluster reporting.',
    `case_action_category` STRING COMMENT 'Humanitarian sector or thematic category under which this action falls, aligned with OCHA cluster system and IATI sector codes. Enables cross-sector analysis and cluster reporting. [ENUM-REF-CANDIDATE: protection|health|nutrition|wash|shelter|education|livelihoods|psychosocial|food_security|cash_and_voucher — promote to reference product]',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary prior to conducting this case action, in compliance with data protection and humanitarian accountability standards.',
    `consent_type` STRING COMMENT 'Method by which informed consent was obtained from the beneficiary for this case action. Supports accountability and protection mainstreaming requirements.. Valid values are `verbal|written|digital|proxy|not_required`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where the case action was conducted. Required for multi-country INGO operations and IATI reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this case action record was first created in the system. Used for audit trail, data lineage, and Silver Layer ingestion tracking.',
    `data_collection_method` STRING COMMENT 'Method used to collect data for this case action. FGD = Focus Group Discussion, KII = Key Informant Interview. Supports data quality assessment and ICT4D (Information and Communication Technology for Development) tracking.. Valid values are `mobile_app|paper_form|phone_interview|direct_observation|fgd|kii`',
    `case_action_date` DATE COMMENT 'The actual calendar date on which the case action was performed or delivered in the field. This is the principal real-world event date used for MEL reporting, PDM analysis, and donor reporting.',
    `duration_minutes` STRING COMMENT 'Duration in minutes of the case action or intervention session. Used for workload analysis, staff time tracking, and service intensity measurement in MEL frameworks.',
    `escalation_reason` STRING COMMENT 'Free-text description of the reason this case action was escalated to a higher authority or inter-agency body. Confidential case management information.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this case action has triggered an escalation to a supervisor, protection officer, or inter-agency coordination body due to severity, risk, or unresolved needs.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up action is required after this case action. When true, next_action_due_date must be populated. Drives automated task creation in CommCare and Dynamics 365.',
    `follow_up_type` STRING COMMENT 'Type of follow-up action planned for this case after the current action is completed. Used to pre-populate the next case action record and support case worker scheduling.. Valid values are `home_visit|phone_call|facility_visit|group_session|referral_follow_up`',
    `is_sensitive_case` BOOLEAN COMMENT 'Indicates whether this case action relates to a sensitive protection case such as GBV, child protection, or trafficking. Triggers enhanced data access controls and confidentiality protocols.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the location where the case action was conducted, captured via mobile device GPS. Enables GIS mapping and geographic analysis of service delivery.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the location where the case action was conducted, captured via mobile device GPS. Enables GIS mapping and geographic analysis of service delivery.',
    `muac_measurement_mm` DECIMAL(18,2) COMMENT 'Mid-Upper Arm Circumference (MUAC) measurement in millimetres recorded during a nutrition screening action. Used to classify Global Acute Malnutrition (GAM) and Severe Acute Malnutrition (SAM) status per SPHERE standards.',
    `next_action_due_date` DATE COMMENT 'The date by which the next follow-up action or intervention for this case must be completed. Drives case worker task queues and escalation alerts in CommCare and Dynamics 365.',
    `nutrition_status` STRING COMMENT 'Nutritional status classification of the beneficiary as assessed during this action, based on MUAC or weight-for-height z-score. SAM = Severe Acute Malnutrition, MAM = Moderate Acute Malnutrition, per SPHERE and WHO standards.. Valid values are `sam|mam|normal|not_assessed`',
    `outcome` STRING COMMENT 'The result or outcome of the case action as assessed by the case worker at the time of completion. Used for MEL indicator tracking, Results-Based Management (RBM) reporting, and LogFrame output measurement.. Valid values are `successful|partially_successful|unsuccessful|pending|referred_out`',
    `outcome_notes` STRING COMMENT 'Free-text narrative describing the outcome of the case action, observations made during the visit or session, and any contextual information relevant to case progress. Confidential case management information.',
    `protection_concern_type` STRING COMMENT 'Specific protection concern category associated with this case action, used for disaggregated protection cluster reporting. Confidential and access-restricted. [ENUM-REF-CANDIDATE: gbv|child_protection|trafficking|idp_displacement|statelessness|forced_recruitment|detention|none — promote to reference product]. Valid values are `gbv|child_protection|trafficking|idp_displacement|statelessness|none`',
    `pss_session_number` STRING COMMENT 'Sequential session number for Psychosocial Support (PSS) interventions, tracking the beneficiarys progression through a structured PSS program. Applicable when action_type is counseling_session.',
    `reference_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this case action for use in field reports, SitReps, and donor reporting. Follows the format CA-YYYY-NNNNNN.. Valid values are `^CA-[0-9]{4}-[0-9]{6}$`',
    `referral_destination` STRING COMMENT 'Name or identifier of the organization, facility, or service to which the beneficiary was referred during this action. Applicable when action_type is referral. Supports referral pathway tracking and inter-agency coordination.',
    `referral_reason` STRING COMMENT 'Description of the reason the beneficiary was referred to another service or organization. Confidential case management information used for inter-agency coordination and case continuity.',
    `scheduled_date` DATE COMMENT 'The originally planned date on which this case action was scheduled to occur. Compared against action_date to measure timeliness and adherence to case plans.',
    `service_items_provided` STRING COMMENT 'Description of specific Non-Food Items (NFIs), services, or assistance items provided to the beneficiary during this action (e.g., hygiene kit, food ration, cash transfer amount). Used for distribution tracking and PDM.',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating operational system (CommCare case_id, KoboToolbox submission_id, or Dynamics 365 activityid). Enables traceability back to the source system for reconciliation.',
    `case_action_status` STRING COMMENT 'Current lifecycle status of the case action, tracking progression from planning through completion or cancellation. Used for workload management and case progress monitoring.. Valid values are `planned|in_progress|completed|cancelled|missed|rescheduled`',
    `supervisor_review_date` DATE COMMENT 'Date on which a supervisor reviewed and validated this case action record. Populated when supervisor_reviewed is true.',
    `supervisor_reviewed` BOOLEAN COMMENT 'Indicates whether a supervisor or team leader has reviewed and validated this case action record. Supports quality assurance, accountability, and CHS compliance verification.',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time at which the case action was recorded or submitted in the system, including timezone offset. Used for audit trails, data quality checks, and real-time field monitoring.',
    `case_action_type` STRING COMMENT 'Classification of the type of intervention or activity performed during this case action. Drives workflow routing, reporting disaggregation, and MEL indicator tracking. [ENUM-REF-CANDIDATE: home_visit|counseling_session|referral|service_provision|follow_up_call|group_session|needs_assessment|distribution|medical_consultation|legal_aid|psychosocial_support|community_mobilization — promote to reference product]. Valid values are `home_visit|counseling_session|referral|service_provision|follow_up_call|group_session`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this case action record was last modified in the system. Used for change data capture, audit trails, and incremental Silver Layer processing.',
    CONSTRAINT pk_case_action PRIMARY KEY(`case_action_id`)
) COMMENT 'Transactional log of individual actions, interventions, and follow-up activities taken within a beneficiary case. Captures action type (home visit, counseling session, referral, service provision, follow-up call), action date, action outcome, responsible staff or volunteer, next action due date, and action notes. Enables case progress tracking and workload management for case workers.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique identifier for the referral transaction. Primary key for the referral data product.',
    `case_record_id` BIGINT COMMENT 'Identifier of the case management record associated with this referral, if applicable.',
    `constituent_message_id` BIGINT COMMENT 'Foreign key linking to communication.constituent_message. Business justification: Referral coordination requires messaging beneficiaries with appointment details, location instructions, and follow-up reminders. Tracking which message was sent for which referral enables referral com',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: When audits identify referral pathway failures (delays, incomplete follow-up, partner coordination gaps), corrective action plans document remediation. Links specific referrals to quality improvement ',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program within the referring organization that is making the referral.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the organization or partner that is initiating and submitting the referral.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or case worker who initiated the referral on behalf of the beneficiary.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Referrals specify destination field facilities for service delivery. Core to protection and health referral pathway management, inter-agency coordination, and service accessibility analysis. Role-pref',
    `receiving_organization_partner_org_id` BIGINT COMMENT 'Identifier of the organization or service provider that is receiving and expected to act on the referral.',
    `receiving_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member at the receiving organization who is assigned to handle this referral.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Community volunteers identify and refer beneficiaries to specialized services (health, protection, legal aid). Critical for community-based protection, health outreach, and early identification progra',
    `registrant_id` BIGINT COMMENT 'Identifier of the beneficiary being referred to another service provider or program.',
    `acceptance_date` DATE COMMENT 'Date when the receiving organization formally accepted the referral and committed to providing services.',
    `beneficiary_satisfaction_rating` STRING COMMENT 'Numeric rating provided by the beneficiary indicating their satisfaction with the referral process and services received, typically on a scale of 1-5.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the referral was cancelled before completion, including beneficiary circumstances or organizational constraints.',
    `referral_category` STRING COMMENT 'Primary service category or sector for which the beneficiary is being referred. Aligned with humanitarian cluster system and Sphere standards. [ENUM-REF-CANDIDATE: health|protection|shelter|wash|nutrition|education|livelihoods|psychosocial|legal|other — 10 candidates stripped; promote to reference product]',
    `completion_date` DATE COMMENT 'Date when the referral was marked as completed, indicating that all required services have been delivered and documented.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity of the referral case, particularly important for Gender-Based Violence (GBV) and protection cases requiring special handling.. Valid values are `standard|sensitive|highly_sensitive`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the beneficiary for the referral and information sharing.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or their guardian before making the referral, in compliance with protection and data privacy standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this referral record originated, such as CommCare, KoboToolbox, or Microsoft Dynamics 365.',
    `referral_date` DATE COMMENT 'The date when the referral was initiated and submitted to the receiving organization or service provider.',
    `decline_reason` STRING COMMENT 'Explanation provided when a referral is declined by the receiving organization or rejected by the beneficiary.',
    `expected_response_date` DATE COMMENT 'Target date by which the receiving organization is expected to acknowledge or respond to the referral.',
    `feedback_received_flag` BOOLEAN COMMENT 'Indicates whether feedback was received from the beneficiary regarding their satisfaction with the referral process and services received.',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Indicates whether the scheduled follow-up with the beneficiary or receiving organization has been completed.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up contact with the beneficiary or receiving organization to verify service delivery and outcome.',
    `gbv_case_flag` BOOLEAN COMMENT 'Indicates whether this referral is related to a Gender-Based Violence (GBV) case, requiring adherence to specialized GBV referral pathways and confidentiality protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context about the referral that may be relevant for case management and coordination.',
    `number` STRING COMMENT 'Human-readable business identifier for the referral, used for tracking and communication across organizations.. Valid values are `^REF-[0-9]{8}$`',
    `outcome` STRING COMMENT 'Detailed description of the outcome of the referral, including services provided, beneficiary response, and any follow-up actions required.',
    `outcome_category` STRING COMMENT 'Standardized classification of the referral outcome for reporting and analysis purposes.. Valid values are `successful|partially_successful|unsuccessful|beneficiary_declined|service_unavailable|lost_to_follow_up`',
    `priority_level` STRING COMMENT 'Urgency classification of the referral indicating how quickly the beneficiary needs to receive services.. Valid values are `low|medium|high|critical`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether the referral involves protection concerns such as child protection, trafficking, exploitation, or other safeguarding issues.',
    `reason` STRING COMMENT 'Detailed explanation of why the beneficiary is being referred, including specific needs, conditions, or circumstances that necessitate the referral.',
    `receiving_organization_name` STRING COMMENT 'Name of the organization or service provider receiving the referral, for tracking and reporting purposes.',
    `receiving_service_type` STRING COMMENT 'Specific type of service or program that the beneficiary is being referred to at the receiving organization.',
    `receiving_staff_name` STRING COMMENT 'Full name of the staff member at the receiving organization who accepted or is processing the referral.',
    `referring_staff_contact` STRING COMMENT 'Phone number or email address of the referring staff member for coordination and follow-up communication.',
    `referring_staff_name` STRING COMMENT 'Full name of the staff member who initiated the referral, for contact and follow-up purposes.',
    `service_delivery_date` DATE COMMENT 'Date when the service was actually delivered to the beneficiary by the receiving organization.',
    `referral_status` STRING COMMENT 'Current lifecycle status of the referral indicating whether it has been accepted, is being processed, completed, or declined by the receiving organization.. Valid values are `pending|accepted|in_progress|completed|declined|cancelled`',
    `referral_type` STRING COMMENT 'Classification of the referral based on organizational scope and urgency. Internal referrals are within the same organization, external are to partner organizations, emergency referrals require immediate action.. Valid values are `internal|external|emergency|routine|urgent`',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Transactional record of a formal referral of a beneficiary from one service provider, program, or organization to another. Captures referral date, referring organization, receiving organization or service, referral reason, referral type (internal, external, emergency), referral status (pending, accepted, completed, declined), follow-up date, and outcome. Supports inter-agency coordination, GBV referral pathways, and protection case management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` (
    `biometric_record_id` BIGINT COMMENT 'Unique identifier for the biometric enrollment record.',
    `component_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this biometric enrollment was conducted.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Biometric enrollment often required by specific donor compliance frameworks (WFP SCOPE, UNHCR ProGres). Links biometric records to the specific donor requirement they fulfill for audit verification an',
    `duplicate_record_biometric_record_id` BIGINT COMMENT 'Reference to another biometric record that was identified as a potential duplicate during deduplication processing.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary individual or household whose biometric data was captured.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or volunteer who performed the biometric enrollment.',
    `biometric_modality` STRING COMMENT 'Type of biometric characteristic captured for identity verification (fingerprint, iris scan, facial recognition, palm vein, voice recognition, or multimodal combination).. Valid values are `fingerprint|iris_scan|facial_recognition|palm_vein|voice_recognition|multimodal`',
    `capture_method` STRING COMMENT 'Technical method used to capture the biometric sample (optical, capacitive, ultrasonic, thermal, camera-based, or scanner-based).. Valid values are `optical|capacitive|ultrasonic|thermal|camera|scanner`',
    `consent_date` DATE COMMENT 'Date when informed consent for biometric enrollment was obtained from the beneficiary.',
    `consent_method` STRING COMMENT 'Method by which consent was obtained (written signature, verbal acknowledgment, digital acceptance, or witnessed consent).. Valid values are `written|verbal|digital|witnessed`',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether informed consent was obtained from the beneficiary for biometric data collection and processing.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this biometric record was first created in the database.',
    `data_retention_period_days` STRING COMMENT 'Number of days the biometric data will be retained before deletion, based on organizational policy and regulatory requirements.',
    `deduplication_match_found` BOOLEAN COMMENT 'Boolean flag indicating whether a potential duplicate match was found during deduplication processing.',
    `deduplication_match_score` DECIMAL(18,2) COMMENT 'Numerical similarity score from deduplication matching, indicating the likelihood that this record matches an existing beneficiary record. Higher scores indicate stronger matches.',
    `deduplication_performed` BOOLEAN COMMENT 'Boolean flag indicating whether deduplication matching was performed against existing biometric records to prevent duplicate registrations.',
    `device_identifier` STRING COMMENT 'Unique identifier of the biometric capture device used for enrollment (serial number, MAC address, or device registration code).',
    `device_manufacturer` STRING COMMENT 'Name of the manufacturer of the biometric capture device.',
    `device_model` STRING COMMENT 'Model number or name of the biometric capture device.',
    `encryption_algorithm` STRING COMMENT 'Name of the encryption algorithm used to secure the biometric template (e.g., AES-256, RSA-2048).',
    `encryption_applied` BOOLEAN COMMENT 'Boolean flag indicating whether the biometric template is stored with encryption for enhanced security.',
    `enrollment_date` DATE COMMENT 'Date when the biometric data was captured and enrolled into the system.',
    `enrollment_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the enrollment location in decimal degrees.',
    `enrollment_location` STRING COMMENT 'Name or description of the physical location where biometric enrollment took place (distribution site, registration center, field office).',
    `enrollment_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the enrollment location in decimal degrees.',
    `enrollment_number` STRING COMMENT 'Externally-known unique enrollment identifier assigned during biometric capture session.',
    `enrollment_purpose` STRING COMMENT 'Business purpose or use case for which the biometric data was collected (e.g., cash distribution, NFI distribution, health service access, education enrollment).',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the biometric enrollment was completed, including timezone information.',
    `expiry_date` DATE COMMENT 'Date when the biometric enrollment expires and requires re-enrollment, based on organizational policy or data retention requirements.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this biometric record is currently active and available for verification. Inactive records are retained for audit but not used for matching.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this biometric record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the enrollment operator regarding special circumstances, quality issues, or beneficiary concerns during enrollment.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality assessment score of the captured biometric sample, typically ranging from 0 to 100, indicating suitability for matching and verification.',
    `quality_threshold_met` BOOLEAN COMMENT 'Boolean flag indicating whether the captured biometric sample met the minimum quality threshold required for enrollment and verification.',
    `template_format` STRING COMMENT 'Standard format specification used for storing the biometric template (e.g., ISO/IEC 19794-2 for fingerprint, ISO/IEC 19794-6 for iris).',
    `template_reference` STRING COMMENT 'Secure reference identifier or pointer to the stored biometric template in the biometric database. Does not contain the actual biometric data but links to it.',
    `template_size_bytes` STRING COMMENT 'Size of the biometric template in bytes, indicating storage requirements.',
    `verification_count` STRING COMMENT 'Total number of times this biometric record has been successfully used for identity verification.',
    `verification_date` DATE COMMENT 'Date when the biometric record was last successfully verified during a distribution or service access event.',
    `verification_status` STRING COMMENT 'Current status of the biometric record in the verification lifecycle (enrolled, verified, failed, pending review, expired, or revoked).. Valid values are `enrolled|verified|failed|pending|expired|revoked`',
    CONSTRAINT pk_biometric_record PRIMARY KEY(`biometric_record_id`)
) COMMENT 'Secure record of biometric enrollment data for identity verification during distributions and service access. Captures biometric modality (fingerprint, iris scan, facial recognition), enrollment date, device identifier, quality score, template reference, verification status, and deduplication match results. Critical for preventing duplicate registrations and ghost beneficiaries in large-scale responses.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` (
    `protection_flag_id` BIGINT COMMENT 'Unique identifier for the protection flag record. Primary key.',
    `case_record_id` BIGINT COMMENT 'Reference to the case management record if this flag is part of an active case. Links to CommCare case management system.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Protection concerns (GBV, child abuse, exploitation, SEA) trigger formal compliance incidents requiring investigation per safeguarding policies. Essential for linking beneficiary protection flags to o',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic location where the protection concern was identified. Links to field operations location master.',
    `feedback_submission_id` BIGINT COMMENT 'Foreign key linking to communication.feedback_submission. Business justification: Protection concerns (GBV, child abuse, exploitation) are frequently reported through feedback mechanisms (hotlines, suggestion boxes, community meetings). Links the feedback submission that triggered ',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this protection flag is being managed and tracked.',
    `staff_member_id` BIGINT COMMENT 'Reference to the protection officer or case worker currently responsible for managing this protection flag and coordinating response.',
    `user_account_id` BIGINT COMMENT 'Reference to the user account that created this protection flag record. Used for audit trail and accountability.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary or household associated with this protection flag. Links to the beneficiary master record.',
    `protection_flag_code` STRING COMMENT 'Standardized code identifying the protection flag type. Used for system integration and reporting aggregation.. Valid values are `^[A-Z]{3,6}$`',
    `confidentiality_level` STRING COMMENT 'Data classification level for this protection flag record. Most protection flags are Restricted due to sensitive nature of protection concerns.. Valid values are `Restricted|Confidential|Internal|Public`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the beneficiary or guardian for protection case management.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the beneficiary or guardian for recording and managing this protection flag.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection flag record was first created in the system. Audit trail field for data governance.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this protection flag record originated. Typically CommCare, KoboToolbox, or partner case management systems.',
    `protection_flag_date` DATE COMMENT 'Date when the protection concern was first identified or flagged. Represents the business event timestamp for this protection record.',
    `escalation_date` DATE COMMENT 'Date when the protection flag was escalated to higher authority or specialized protection services.',
    `escalation_reason` STRING COMMENT 'Explanation of why the protection flag required escalation, including severity factors or complexity of the case.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this protection flag requires escalation to senior management, specialized protection teams, or external authorities.',
    `external_reference_code` STRING COMMENT 'External identifier from the source system or partner organization. Used for cross-system reconciliation and data integration.',
    `flagging_source` STRING COMMENT 'Name of the organization, program, or system that originally flagged this protection concern. May reference partner organizations or internal programs.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether ongoing follow-up monitoring or case management is required for this protection flag.',
    `identification_method` STRING COMMENT 'Method or channel through which the protection concern was identified. FGD (Focus Group Discussion), KII (Key Informant Interview). [ENUM-REF-CANDIDATE: Field Assessment|Community Referral|Self-Reported|Partner Organization|Health Screening|Household Survey|Focus Group Discussion|Key Informant Interview — 8 candidates stripped; promote to reference product]',
    `immediate_needs` STRING COMMENT 'Description of immediate protection needs or interventions required to address the flagged concern. Used for rapid response planning.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this protection flag is currently active and requires ongoing attention. Derived from flag_status but provided for simplified querying.',
    `last_follow_up_date` DATE COMMENT 'Date of the most recent follow-up visit or assessment conducted for this protection flag.',
    `legal_action_required` BOOLEAN COMMENT 'Indicates whether the protection concern requires legal intervention, law enforcement involvement, or judicial proceedings.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection flag record was last modified. Audit trail field for data governance and change tracking.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next follow-up visit or assessment to monitor the protection concern and beneficiary status.',
    `notes` STRING COMMENT 'Additional case notes, observations, or contextual information related to the protection flag. Contains sensitive case management details.',
    `pss_provided` BOOLEAN COMMENT 'Indicates whether Psychosocial Support (PSS) services have been provided to the beneficiary as part of protection response.',
    `referral_date` DATE COMMENT 'Date when the referral to specialized protection services was made.',
    `referral_made` BOOLEAN COMMENT 'Indicates whether the beneficiary has been referred to specialized protection services or partner organizations for support.',
    `referral_organization` STRING COMMENT 'Name of the organization or service provider to which the beneficiary was referred for specialized protection support.',
    `reporting_period` STRING COMMENT 'Reporting period during which this protection flag was active or recorded. Format: YYYY-QN for quarterly or YYYY-MM for monthly reporting.. Valid values are `^d{4}-Q[1-4]$|^d{4}-d{2}$`',
    `resolution_date` DATE COMMENT 'Date when the protection concern was resolved or the flag was closed. Null if the flag is still active or under monitoring.',
    `resolution_notes` STRING COMMENT 'Narrative description of how the protection concern was resolved, interventions provided, and outcomes achieved.',
    `risk_description` STRING COMMENT 'Detailed narrative description of the specific protection risk or concern. Contains sensitive information about the nature of the threat or vulnerability.',
    `severity` STRING COMMENT 'Severity level of the protection concern indicating urgency of response and level of risk to the beneficiary.. Valid values are `Critical|High|Medium|Low`',
    `protection_flag_status` STRING COMMENT 'Current lifecycle status of the protection flag indicating whether it requires active intervention, ongoing monitoring, or has been resolved.. Valid values are `Active|Monitoring|Resolved|Closed|Escalated|Referred`',
    `protection_flag_type` STRING COMMENT 'Category of protection concern. GBV (Gender-Based Violence), SGBV (Sexual and Gender-Based Violence), UASC (Unaccompanied and Separated Children). [ENUM-REF-CANDIDATE: GBV Risk|Child Protection|SGBV Survivor|Unaccompanied Minor|UASC|Trafficking Risk|Forced Recruitment|Disability Protection|Elderly at Risk|Medical Vulnerability — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_protection_flag PRIMARY KEY(`protection_flag_id`)
) COMMENT 'Master record of active protection concerns and risk flags associated with a beneficiary or household. Captures flag type (GBV risk, child protection, SGBV survivor, unaccompanied minor, UASC, trafficking risk, forced recruitment), flag severity, flag date, flagging source, current status (active, resolved, monitoring), assigned protection officer, and confidentiality classification. Enables protection mainstreaming across all program sectors.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` (
    `registration_event_id` BIGINT COMMENT 'Unique identifier for the beneficiary registration event. Primary key for the registration event record.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this registration was conducted.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Registration events are held at specific field sites. Direct business relationship for event management, site capacity planning, and registration campaign tracking. Replaces denormalized location name',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary who was registered or re-registered in this event.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or field worker who conducted the registration session.',
    `biometric_captured` BOOLEAN COMMENT 'Indicates whether biometric data (fingerprint, iris scan, facial recognition) was captured during this registration event.',
    `biometric_type` STRING COMMENT 'Type of biometric data captured during registration: fingerprint, iris scan, facial recognition, or none.. Valid values are `fingerprint|iris_scan|facial_recognition|none`',
    `consent_date` DATE COMMENT 'Date on which informed consent was obtained from the beneficiary.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for data collection and processing was obtained from the beneficiary during registration.',
    `consent_type` STRING COMMENT 'Type of consent obtained: verbal, written, digital signature, or guardian consent (for minors or vulnerable individuals).. Valid values are `verbal|written|digital_signature|guardian_consent`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration event record was first created in the data system.',
    `data_quality_flag` BOOLEAN COMMENT 'Assessment of the overall data quality for this registration event: high, medium, low, or needs review.',
    `data_source_system` STRING COMMENT 'Name of the source system or application from which this registration event data was extracted (e.g., CommCare, KoboToolbox, UNHCR PRIMES).',
    `deduplication_check_performed` BOOLEAN COMMENT 'Indicates whether a deduplication check was performed during registration to prevent duplicate beneficiary records.',
    `deduplication_method` STRING COMMENT 'Method used for deduplication check: biometric matching, demographic matching, document number verification, manual review, or none.. Valid values are `biometric|demographic|document_number|manual_review|none`',
    `duplicate_found` BOOLEAN COMMENT 'Indicates whether a potential duplicate beneficiary record was identified during the deduplication check.',
    `duplicate_resolution_status` STRING COMMENT 'Status of duplicate resolution: no duplicate found, duplicate confirmed and merged, duplicate resolved, or pending manual review.. Valid values are `no_duplicate|duplicate_confirmed|duplicate_resolved|pending_review`',
    `household_head` BOOLEAN COMMENT 'Indicates whether the registered beneficiary is designated as the head of household for program purposes.',
    `household_registration` BOOLEAN COMMENT 'Indicates whether this registration event was part of a household-level registration (true) or individual-only registration (false).',
    `interpreter_used` BOOLEAN COMMENT 'Indicates whether an interpreter was used during the registration session due to language barriers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration event record was last updated or modified in the data system.',
    `referral_required` BOOLEAN COMMENT 'Indicates whether the beneficiary requires referral to specialized services (protection, health, psychosocial support) based on registration screening.',
    `referral_type` STRING COMMENT 'Type of referral service required: protection, health, psychosocial support (PSS), legal aid, livelihood, education, or other specialized services. [ENUM-REF-CANDIDATE: protection|health|pss|legal_aid|livelihood|education|nutrition|wash|shelter|none — promote to reference product]',
    `registering_organization` STRING COMMENT 'Name of the organization (INGO, CBO, CSO) that conducted the registration, relevant for consortium or partnership programs.',
    `registering_staff_name` STRING COMMENT 'Full name of the staff member or field worker who conducted the registration for audit and accountability purposes.',
    `registration_completeness_score` DECIMAL(18,2) COMMENT 'Percentage score (0-100) indicating the completeness of data captured during registration based on required and optional fields.',
    `registration_date` DATE COMMENT 'The date on which the beneficiary registration or re-registration event occurred.',
    `registration_language` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language used during the registration interview or data collection.. Valid values are `^[a-z]{3}$`',
    `registration_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the registration location in decimal degrees format.',
    `registration_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the registration location in decimal degrees format.',
    `registration_modality` STRING COMMENT 'The modality or method through which the registration was conducted: in-person at center, mobile outreach, remote digital, phone interview, or community-based registration.. Valid values are `in_person|mobile_outreach|remote_digital|phone_interview|community_based`',
    `registration_notes` STRING COMMENT 'Free-text field for registering staff to capture additional observations, special circumstances, or contextual information about the registration event.',
    `registration_number` STRING COMMENT 'Externally visible unique registration number assigned to the beneficiary during this event. Format: Country-Year-Sequence (e.g., SYR-2024-000123).. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{6}$`',
    `registration_status` STRING COMMENT 'Current status of the registration event in the workflow: draft, pending verification, verified, approved, rejected, or incomplete.. Valid values are `draft|pending_verification|verified|approved|rejected|incomplete`',
    `registration_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the registration session was initiated, including time zone information.',
    `registration_tool` STRING COMMENT 'The data collection tool or system used to capture registration information: KoboToolbox, CommCare, paper form, UNHCR PRIMES, custom application, or other.. Valid values are `kobotoolbox|commcare|paper_form|unhcr_primes|custom_app|other`',
    `registration_type` STRING COMMENT 'Type of registration event: initial registration, re-registration, profile update, verification visit, or biometric enrollment.. Valid values are `initial|re-registration|update|verification|biometric_enrollment`',
    `verification_document_number` STRING COMMENT 'The document number or identifier from the verification document presented during registration.',
    `verification_document_type` STRING COMMENT 'Type of identity or verification document presented during registration (e.g., national ID, passport, birth certificate, ration card, IDP card). [ENUM-REF-CANDIDATE: national_id|passport|birth_certificate|ration_card|idp_card|refugee_certificate|voter_id|driver_license|none — promote to reference product]',
    `vulnerability_assessment_conducted` BOOLEAN COMMENT 'Indicates whether a vulnerability or needs assessment was conducted as part of this registration event.',
    CONSTRAINT pk_registration_event PRIMARY KEY(`registration_event_id`)
) COMMENT 'Transactional record of a beneficiary registration or re-registration event capturing the specific registration session details. Stores registration date, registration location, registration modality (in-person, mobile, remote), registration tool (KoboToolbox, CommCare, paper), registering staff, verification documents presented, registration completeness score, and any deduplication checks performed. Provides full audit trail of how and when a beneficiary entered the system.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` (
    `displacement_history_id` BIGINT COMMENT 'Unique identifier for each displacement episode record. Primary key for the displacement history tracking system.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary registrant who experienced this displacement episode. Links to the master beneficiary registry.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the field staff member or enumerator who collected this displacement history record. Used for data quality audits and enumerator performance tracking.',
    `current_admin1_code` STRING COMMENT 'First-level administrative division code of current displacement location. Supports sub-national operational planning and resource allocation.',
    `current_admin2_code` STRING COMMENT 'Second-level administrative division code of current displacement location. Enables district-level service delivery planning.',
    `current_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the current displacement location. Used for asylum country statistics and cross-border displacement tracking.. Valid values are `^[A-Z]{3}$`',
    `current_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the current displacement location. Enables real-time displacement mapping and proximity analysis to services.',
    `current_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the current displacement location. Enables real-time displacement mapping and proximity analysis to services.',
    `current_settlement_name` STRING COMMENT 'Name of the camp, collective center, or settlement where the beneficiary currently resides. Links to site-level service provision and infrastructure data.',
    `current_settlement_type` STRING COMMENT 'Type of settlement where the displaced person currently resides. Determines applicable assistance modalities and service delivery approaches.. Valid values are `camp|collective_center|host_community|informal_settlement|urban_area|rural_area`',
    `data_collection_date` DATE COMMENT 'Date when this displacement history record was collected in the field. Distinct from displacement date; used for data currency assessment.',
    `data_collection_tool` STRING COMMENT 'Digital or manual tool used to collect this displacement history record. Supports data quality assessment and system interoperability.. Valid values are `kobotoolbox|commcare|odk|unhcr_progres|iom_dtm|manual_entry`',
    `displacement_date` DATE COMMENT 'Date when the beneficiary was displaced from their origin location. Key timestamp for calculating displacement duration and eligibility for time-bound assistance programs.',
    `displacement_duration_days` STRING COMMENT 'Number of days since the displacement date. Calculated field used to classify protracted vs. acute displacement and determine eligibility for durable solutions programs.',
    `displacement_episode_number` STRING COMMENT 'Sequential number of this displacement episode for the registrant. Enables tracking of multiple displacement events over time (1st displacement, 2nd displacement, etc.).',
    `displacement_status` STRING COMMENT 'Current displacement status of the beneficiary per IASC (Inter-Agency Standing Committee) framework. Tracks the stage in the displacement journey and informs durable solutions planning.. Valid values are `newly_displaced|protracted_displaced|returned|resettled|locally_integrated|in_transit`',
    `displacement_trigger` STRING COMMENT 'Primary cause or trigger event that forced the displacement. Critical for root cause analysis, advocacy, and targeted intervention design.. Valid values are `armed_conflict|generalized_violence|human_rights_violations|natural_disaster|climate_event|development_project`',
    `displacement_verification_status` STRING COMMENT 'Status of field verification of the displacement claim. Verified status is required for eligibility determination in most assistance programs.. Valid values are `verified|pending_verification|unverified|disputed`',
    `hdx_dataset_reference` STRING COMMENT 'Reference to the OCHA HDX dataset from which this displacement record was sourced or to which it was contributed. Supports open data sharing and interoperability.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this is the current active displacement episode for the registrant. False for historical/closed episodes. Supports temporal queries.',
    `is_cross_border` BOOLEAN COMMENT 'Flag indicating whether the displacement crossed an international border (refugee) or remained within the country of origin (IDP). Determines applicable legal frameworks and assistance mandates.',
    `is_protracted` BOOLEAN COMMENT 'Flag indicating whether the displacement has lasted 5 or more years, meeting UNHCR definition of protracted displacement. Triggers eligibility for long-term development programming.',
    `local_integration_status` STRING COMMENT 'Status of local integration as a durable solution. Tracks progress toward legal, economic, and social integration in the host community.. Valid values are `not_applicable|in_progress|achieved|citizenship_granted`',
    `origin_admin1_code` STRING COMMENT 'First-level administrative division code (state/province/region) of origin location. Enables sub-national displacement pattern analysis.',
    `origin_admin2_code` STRING COMMENT 'Second-level administrative division code (district/county) of origin location. Provides granular displacement origin tracking for targeted return programming.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country from which the beneficiary was displaced. Used for population statistics and country-of-origin analysis.. Valid values are `^[A-Z]{3}$`',
    `origin_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the origin location. Enables GIS mapping of displacement flows and spatial analysis.',
    `origin_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the origin location. Enables GIS mapping of displacement flows and spatial analysis.',
    `origin_settlement_name` STRING COMMENT 'Name of the village, town, or settlement from which the beneficiary was displaced. Supports community-level return and reintegration planning.',
    `poc_category` STRING COMMENT 'UNHCR Person of Concern category classification. Determines eligibility for specific protection and assistance programs.. Valid values are `idp|refugee|asylum_seeker|returnee|stateless|host_community`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this displacement history record was first created in the lakehouse. System audit field for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this displacement history record was last updated in the lakehouse. System audit field for change tracking.',
    `resettlement_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the third country to which the beneficiary was resettled, if applicable. Null for non-resettlement cases.. Valid values are `^[A-Z]{3}$`',
    `resettlement_date` DATE COMMENT 'Date when the beneficiary was resettled to a third country. Null for non-resettlement cases. Marks the end of the displacement episode.',
    `return_date` DATE COMMENT 'Date when the beneficiary returned to their origin location, if applicable. Null for ongoing displacement. Used to calculate return rates and monitor return sustainability.',
    `return_intention` STRING COMMENT 'Beneficiary stated intention regarding return to origin location. Informs durable solutions planning and return program design.. Valid values are `intends_to_return|no_return_intention|undecided|return_not_safe`',
    `return_type` STRING COMMENT 'Classification of the return modality. Voluntary return is the preferred durable solution per international humanitarian standards.. Valid values are `voluntary|facilitated|spontaneous|forced|not_applicable`',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this record in the originating operational system (proGres, DTM, KoboToolbox). Enables traceability and data lineage tracking.',
    `transit_locations` STRING COMMENT 'Comma-separated list of intermediate locations or waypoints during the displacement journey. Documents the full displacement route for protection risk analysis.',
    `verification_date` DATE COMMENT 'Date when the displacement episode was verified through field assessment or documentation review. Null for unverified cases.',
    `verification_method` STRING COMMENT 'Method used to verify the displacement episode. Field visit and document review are considered most reliable.. Valid values are `field_visit|document_review|key_informant|community_leader|self_reported`',
    CONSTRAINT pk_displacement_history PRIMARY KEY(`displacement_history_id`)
) COMMENT 'Longitudinal record tracking the displacement journey of an IDP, refugee, or asylum-seeker beneficiary over time. Each record represents a displacement episode with origin location, displacement trigger (armed conflict, generalized violence, natural disaster, climate event, development project), displacement date, transit locations, current settlement/camp/host community, displacement status per IASC framework (newly displaced, protracted displaced, returned, resettled, locally integrated), and duration. Multiple records per registrant enable full journey mapping. Supports durable solutions planning, return and reintegration programming, OCHA displacement tracking, UNHCR population statistics reporting, and IOM Displacement Tracking Matrix (DTM) data exchange. Interoperable with UNHCR proGres displacement records and OCHA HDX displacement datasets.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` (
    `exit_record_id` BIGINT COMMENT 'Unique identifier for the beneficiary exit record. Primary key for the exit_record product.',
    `household_id` BIGINT COMMENT 'Reference to the household unit to which the exiting beneficiary belonged at time of exit. Used for household-level impact analysis and to track whether entire household exited or only individual members.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary program from which the beneficiary is exiting. Links to the program product in the program domain. Note that this represents registry-level exit, distinct from program-specific graduation.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary who is exiting the registry. Links to the registrant product in the beneficiary domain.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who processed and approved the beneficiary exit. Links to the staff_member product in the workforce domain for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exit record was first created in the data lakehouse. Part of standard audit trail for data governance and compliance.',
    `data_deletion_scheduled_date` DATE COMMENT 'Calculated date when beneficiary data is scheduled for deletion or anonymization based on exit date and retention period. Used by data governance processes to enforce retention policies.',
    `data_retention_classification` STRING COMMENT 'Classification determining how beneficiary data should be handled post-exit per data minimization and privacy requirements. Retain full means keep all data for ongoing monitoring; retain anonymized means remove PII but keep aggregated data; archive means move to long-term storage; delete means purge per right to be forgotten.. Valid values are `retain_full|retain_anonymized|archive|delete`',
    `data_retention_period_months` STRING COMMENT 'Number of months that beneficiary data will be retained post-exit before archival or deletion. Determined by donor requirements, legal obligations, and organizational data retention policies.',
    `death_certificate_verified` BOOLEAN COMMENT 'Boolean flag indicating whether a death certificate or official mortality documentation was verified for exits due to death. Required for audit and fraud prevention.',
    `death_date` DATE COMMENT 'Date of death as documented in official records or reported by family members. Populated only for exits with exit_reason_category of death.',
    `exit_assessment_conducted` BOOLEAN COMMENT 'Boolean flag indicating whether a formal exit assessment or interview was conducted with the beneficiary prior to exit. Required for program graduation and voluntary withdrawal cases per Core Humanitarian Standard (CHS) accountability requirements.',
    `exit_assessment_date` DATE COMMENT 'Date when the exit assessment or final interview was conducted with the beneficiary. Used for Monitoring Evaluation and Learning (MEL) tracking and accountability reporting.',
    `exit_assessment_notes` STRING COMMENT 'Detailed notes and observations from the exit assessment interview. Captures beneficiary feedback, lessons learned, and recommendations for program improvement per Monitoring Evaluation Accountability and Learning (MEAL) requirements.',
    `exit_assessment_outcome` STRING COMMENT 'Overall outcome classification from the exit assessment. Positive indicates beneficiary achieved program objectives; neutral indicates partial achievement; negative indicates unmet objectives; not applicable for exits without assessment (death, loss of contact).. Valid values are `positive|neutral|negative|not_applicable`',
    `exit_consent_date` DATE COMMENT 'Date when beneficiary consent for exit was obtained. Used for legal compliance and audit trail of consent management.',
    `exit_consent_method` STRING COMMENT 'Method by which exit consent was obtained from the beneficiary. Verbal for in-person oral consent; written for signed paper forms; digital for electronic signature; proxy for consent obtained through authorized representative.. Valid values are `verbal|written|digital|proxy`',
    `exit_consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether explicit consent was obtained from the beneficiary for the exit and associated data handling. Required for voluntary withdrawals and data deletion per GDPR and CHS standards.',
    `exit_date` DATE COMMENT 'The date on which the beneficiary formally exited the beneficiary registry. Represents the effective date of deactivation from active registrant status.',
    `exit_facility_name` STRING COMMENT 'Name of the field office, distribution center, or facility where the exit was processed. Used for operational tracking and geographic analysis of exit patterns.',
    `exit_location_code` STRING COMMENT 'Three-letter code representing the geographic location where the exit was processed. Follows ISO 3166-1 alpha-3 country code standard or internal location coding scheme.. Valid values are `^[A-Z]{3}$`',
    `exit_number` STRING COMMENT 'Human-readable business identifier for the exit record, formatted as EXT- followed by 8 digits. Used for tracking and reference in case management systems.. Valid values are `^EXT-[0-9]{8}$`',
    `exit_reason_category` STRING COMMENT 'Primary category describing why the beneficiary is exiting the registry. Program graduation indicates successful completion of assistance; voluntary withdrawal is beneficiary-initiated; relocation means moved out of service area; death is confirmed mortality; loss of contact means unable to reach beneficiary; loss of eligibility means no longer meets program criteria.. Valid values are `program_graduation|voluntary_withdrawal|relocation|death|loss_of_contact|loss_of_eligibility`',
    `exit_reason_detail` STRING COMMENT 'Detailed narrative explanation of the specific circumstances surrounding the beneficiary exit. Provides context beyond the category for case management and Monitoring Evaluation and Learning (MEL) purposes.',
    `exit_status` STRING COMMENT 'Current workflow status of the exit record. Pending indicates awaiting supervisor approval; approved means exit authorized but not yet finalized; completed means exit fully processed and beneficiary deactivated; reversed means exit was cancelled and beneficiary reactivated.. Valid values are `pending|approved|completed|reversed`',
    `exit_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exit record was created in the system, capturing the exact moment of registry deactivation.',
    `is_duplicate_merge` BOOLEAN COMMENT 'Boolean flag indicating whether this exit was triggered by a duplicate record merge operation. True means this record was identified as a duplicate and merged into another master record; false means exit was for other reasons.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this exit record was last modified in the data lakehouse. Updated whenever any attribute value changes. Part of standard audit trail.',
    `post_exit_followup_date` DATE COMMENT 'Scheduled date for the next post-exit follow-up contact or assessment. Used to track ongoing monitoring obligations for graduated beneficiaries.',
    `post_exit_followup_plan` STRING COMMENT 'Detailed plan for post-exit monitoring activities including timeline, methods, and Key Performance Indicators (KPIs) to be tracked. Used for Post-Distribution Monitoring (PDM) and impact assessment.',
    `post_exit_followup_required` BOOLEAN COMMENT 'Boolean flag indicating whether post-exit follow-up monitoring is required for this beneficiary. Typically true for program graduation cases to assess sustainability of outcomes per Results-Based Management (RBM) frameworks.',
    `reactivation_conditions` STRING COMMENT 'Description of the conditions or criteria under which the beneficiary could be reactivated in the registry. Used for case management decision-making if beneficiary returns to service area.',
    `reactivation_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary is eligible for reactivation in the registry if circumstances change. True for voluntary withdrawals and relocations; false for deaths and duplicate merges.',
    `referral_organization_name` STRING COMMENT 'Name of the organization or service provider to which the beneficiary was referred at exit. Supports coordination and continuity of care in the humanitarian ecosystem.',
    `referral_provided` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary was provided with referrals to other services or organizations at exit. Part of responsible exit protocol per Core Humanitarian Standard (CHS) commitment to do no harm.',
    `referral_service_type` STRING COMMENT 'Type of service or assistance the beneficiary was referred to (e.g., health, education, livelihood, protection, legal aid). Enables tracking of referral pathways and inter-agency collaboration. [ENUM-REF-CANDIDATE: health|education|livelihood|protection|legal_aid|psychosocial_support|shelter|wash|nutrition — promote to reference product]',
    `relocation_destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country to which the beneficiary relocated. Populated for exits due to relocation out of service area.. Valid values are `^[A-Z]{3}$`',
    `relocation_destination_location` STRING COMMENT 'Detailed location information (city, district, camp name) where the beneficiary relocated. Used for potential referrals and inter-agency coordination.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this exit record in the source operational system. Enables traceability and reconciliation between lakehouse and operational systems.',
    CONSTRAINT pk_exit_record PRIMARY KEY(`exit_record_id`)
) COMMENT 'Transactional record documenting a beneficiarys formal deactivation from the beneficiary registry. Captures exit date, exit reason (program graduation, voluntary withdrawal, relocation out of service area, death, loss of contact, loss of eligibility, duplicate record merge), exit assessment outcome, data retention classification per CHS and GDPR data minimization requirements, post-exit follow-up plan, and responsible staff. Distinct from program-level graduation — this records the beneficiary ceasing to be an active registrant in the system.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` (
    `document_record_id` BIGINT COMMENT 'Unique identifier for the document record. Primary key for the document_record product.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements mandate specific document verification standards (identity verification, legal status, eligibility documentation). Links document records to the compliance requirements they fulfill',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program under which this document was collected or verified.',
    `user_account_id` BIGINT COMMENT 'Reference to the user or staff member who created this document record in the system. Supports accountability and audit trail.',
    `registrant_id` BIGINT COMMENT 'Reference to the beneficiary who owns or is associated with this document.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who performed the document verification.',
    `capture_device_code` STRING COMMENT 'Unique identifier of the mobile device, scanner, or workstation used to capture the document. Supports audit trail and data quality tracking.',
    `capture_method` STRING COMMENT 'The method used to capture the document information into the system (e.g., mobile scan via KoboToolbox, flatbed scanner, photograph, manual data entry).. Valid values are `mobile_scan|flatbed_scan|photograph|manual_entry|digital_upload`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity of the document and the access controls required. Aligns with organizational data governance policies.. Valid values are `public|internal|confidential|restricted`',
    `consent_date` DATE COMMENT 'The date on which the beneficiary provided consent for document collection and processing. Format: yyyy-MM-dd.',
    `consent_method` STRING COMMENT 'The method by which consent was obtained from the beneficiary (e.g., written signature, verbal consent recorded, digital signature, biometric confirmation).. Valid values are `written|verbal|digital_signature|biometric|proxy`',
    `consent_obtained` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary provided informed consent for the collection, storage, and use of this document. True if consent was obtained.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `data_sharing_consent` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary consented to sharing this document with partner organizations or coordination bodies. True if sharing consent was obtained.',
    `document_condition` STRING COMMENT 'Physical condition of the document at the time of registration or verification. Impacts reliability for identity verification.. Valid values are `excellent|good|fair|poor|damaged|illegible`',
    `document_image_reference` STRING COMMENT 'File path, URL, or storage reference to the scanned or photographed image of the document. Used for audit and verification purposes.',
    `document_language_code` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the primary language in which the document is written.. Valid values are `^[a-z]{2,3}$`',
    `document_number` STRING COMMENT 'The unique alphanumeric identifier printed on the document by the issuing authority. Used for identity verification and legal status determination.',
    `document_type` STRING COMMENT 'Classification of the identity or legal document. Common types include UNHCR registration certificates, national ID cards, birth certificates, marriage certificates, asylum seeker cards, and travel documents.. Valid values are `unhcr_registration|national_id|birth_certificate|marriage_certificate|asylum_seeker_card|travel_document`',
    `expiry_date` DATE COMMENT 'The date on which the document expires and is no longer valid for legal or identification purposes. Nullable for documents without expiration (e.g., birth certificates). Format: yyyy-MM-dd.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems, partner organizations, or coordination platforms (e.g., UNHCR proGres ID, OCHA reference number) to cross-reference this document.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this document record is currently active and valid for use in program operations. False if the record has been superseded, invalidated, or archived.',
    `is_primary_identity_document` BOOLEAN COMMENT 'Boolean flag indicating whether this document is the primary identity document for the beneficiary. True if this is the main document used for identity verification.',
    `issue_date` DATE COMMENT 'The date on which the document was officially issued by the authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'The government agency, international organization, or official body that issued the document (e.g., Ministry of Interior, UNHCR, National Registration Bureau).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country or territory where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `legal_status_indicator` STRING COMMENT 'The legal status of the beneficiary as evidenced by this document. Supports protection case management and eligibility determination for humanitarian assistance. [ENUM-REF-CANDIDATE: refugee|asylum_seeker|idp|stateless|citizen|resident|undocumented — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional observations, comments, or context about the document that do not fit into structured fields. Used by case workers and protection officers.',
    `registration_location_code` STRING COMMENT 'Code or identifier of the field location, camp, or registration center where the document was recorded into the system.',
    `retention_period_days` STRING COMMENT 'The number of days for which this document record must be retained according to organizational policy, donor requirements, or legal obligations. After this period, the record may be archived or deleted.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this document record in the source operational system. Supports data lineage and reconciliation.',
    `verification_date` DATE COMMENT 'The date on which the document was last verified by authorized staff. Format: yyyy-MM-dd.',
    `verification_method` STRING COMMENT 'The method or process used to verify the authenticity of the document (e.g., visual inspection, biometric matching, confirmation with issuing authority).. Valid values are `visual_inspection|biometric_match|authority_confirmation|third_party_validation|digital_verification`',
    `verification_status` STRING COMMENT 'Current verification state of the document. Indicates whether the document has been authenticated by program staff or partner organizations.. Valid values are `verified|pending|unverified|expired|invalid|under_review`',
    CONSTRAINT pk_document_record PRIMARY KEY(`document_record_id`)
) COMMENT 'Master record of identity and legal documents associated with a beneficiary, including UNHCR registration certificates, national ID cards, birth certificates, marriage certificates, asylum seeker cards, and travel documents. Captures document type, document number, issuing authority, issue date, expiry date, verification status, and document image reference. Supports identity verification, legal status determination, and protection documentation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`community` (
    `community_id` BIGINT COMMENT 'Unique identifier for the community, settlement, camp, or geographic area registered as a collective beneficiary unit. Primary key for the community entity.',
    `parent_community_id` BIGINT COMMENT 'Self-referencing FK on community (parent_community_id)',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: In consortium and area-based approaches, partners are assigned responsibility for specific communities or geographic zones. Tracking the lead partner per community enables coordination, avoids duplica',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or enumerator who registered the community in the system. Used for data quality accountability and field operations management.',
    `access_constraint_level` STRING COMMENT 'Level of operational access constraints affecting the community due to security incidents, administrative restrictions, natural barriers, or conflict dynamics. No constraint: full access. Low: minor delays. Medium: significant restrictions. High: severely constrained. No access: inaccessible. Used for operational planning and risk management.. Valid values are `no_constraint|low|medium|high|no_access`',
    `active_program_count` STRING COMMENT 'Number of active humanitarian or development programs currently operating in the community. Used for coordination, gap analysis, and 3W (Who does What Where) reporting.',
    `admin1_code` STRING COMMENT 'First-level administrative division code (province, state, governorate) where the community is located. Aligns with OCHA Common Operational Dataset Administrative Boundaries (COD-AB) P-codes for standardized geographic reporting.',
    `admin1_name` STRING COMMENT 'Name of the first-level administrative division (province, state, governorate) where the community is located. Human-readable complement to admin1_code.',
    `admin2_code` STRING COMMENT 'Second-level administrative division code (district, county, department) where the community is located. Aligns with OCHA COD-AB P-codes for standardized geographic reporting.',
    `admin2_name` STRING COMMENT 'Name of the second-level administrative division (district, county, department) where the community is located. Human-readable complement to admin2_code.',
    `admin3_code` STRING COMMENT 'Third-level administrative division code (sub-district, municipality) where the community is located. Aligns with OCHA COD-AB P-codes where available.',
    `admin3_name` STRING COMMENT 'Name of the third-level administrative division (sub-district, municipality) where the community is located. Human-readable complement to admin3_code.',
    `admin4_code` STRING COMMENT 'Fourth-level administrative division code (village, neighborhood, locality) where the community is located. Aligns with OCHA COD-AB P-codes where available.',
    `admin4_name` STRING COMMENT 'Name of the fourth-level administrative division (village, neighborhood, locality) where the community is located. Human-readable complement to admin4_code.',
    `community_code` STRING COMMENT 'Externally-known unique business identifier or code for the community, used in field operations, 3W (Who does What Where) reporting, and inter-agency coordination. May align with OCHA P-codes or agency-specific community identifiers.',
    `consent_date` DATE COMMENT 'Date when community consent was obtained for data collection and program activities. Used for consent tracking and compliance documentation.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from community leadership or representatives for data collection, program implementation, and data sharing. True if consent obtained, False otherwise. Supports CHS (Core Humanitarian Standard) accountability commitments and GDPR compliance where applicable.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code where the community is located. Used for country-level aggregation, compliance reporting, and IATI (International Aid Transparency Initiative) transparency reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the community has consented to sharing of community-level data with partner organizations, clusters, or coordination bodies. True if data sharing permitted, False otherwise. Supports inter-agency coordination while respecting community preferences.',
    `displacement_status` STRING COMMENT 'Classification of the community based on displacement dynamics. Host community: existing community hosting displaced populations. IDP settlement: community primarily composed of Internally Displaced Persons. Refugee camp: formal refugee settlement. Returnee community: community of returned displaced persons. Mixed: combination of host and displaced populations.. Valid values are `host_community|idp_settlement|refugee_camp|returnee_community|mixed`',
    `estimated_population` STRING COMMENT 'Estimated total number of individuals residing in or associated with the community. This is the principal quantitative measurement for the community resource, used for needs calculations, resource allocation, and coverage reporting.',
    `gbv_risk_level` STRING COMMENT 'Assessment of GBV risk level in the community based on safety audits, incident reports, and vulnerability indicators. Used for GBV prevention programming, safe space establishment, and referral pathway planning.. Valid values are `low|medium|high|critical`',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GPS coordinates in meters. Indicates the precision of the latitude and longitude measurements, important for field data quality assessment and spatial analysis reliability.',
    `health_facility_distance_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the community to the nearest functional health facility. Used for health access analysis, referral planning, and mobile health outreach prioritization.',
    `household_count` STRING COMMENT 'Estimated or verified number of households within the community. Used for household-level targeting and distribution planning in WASH, shelter, and NFI (Non-Food Item) programs.',
    `ipc_phase` STRING COMMENT 'IPC acute food insecurity phase classification for the community. Phase 1: Minimal/None. Phase 2: Stressed. Phase 3: Crisis. Phase 4: Emergency. Phase 5: Catastrophe/Famine. Used for food security targeting and early warning.. Valid values are `phase_1|phase_2|phase_3|phase_4|phase_5`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent needs assessment or monitoring visit conducted in the community. Used to track data currency and schedule follow-up assessments.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the community centroid or primary access point. Used for GIS (Geographic Information System) mapping, spatial analysis, and proximity-based service planning.',
    `leader_contact` STRING COMMENT 'Primary contact information (phone number or other communication channel) for the community leader or representative. Used for coordination, consultation, and feedback mechanisms. Classified as confidential PII.',
    `leader_name` STRING COMMENT 'Name of the primary community leader, elder, or representative. Used for community engagement, consultation, and accountability mechanisms. Classified as confidential to protect community leadership in sensitive contexts.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the community centroid or primary access point. Used for GIS mapping, spatial analysis, and proximity-based service planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community record was last modified. Used for audit trail, change tracking, and data currency assessment.',
    `community_name` STRING COMMENT 'Official or commonly-used name of the community, settlement, camp, or geographic area. This is the primary human-readable identifier used in field reports, SitReps (Situation Reports), and beneficiary communications.',
    `notes` STRING COMMENT 'Free-text field for additional contextual information, operational notes, or special considerations about the community. Used for qualitative context that does not fit structured fields.',
    `primary_language_code` STRING COMMENT 'ISO 639-3 three-letter code for the primary language spoken in the community. Used for communication planning, translation needs, and culturally appropriate programming.. Valid values are `^[a-z]{3}$`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicates whether the community has been flagged for protection concerns such as GBV (Gender-Based Violence) risk, child protection issues, or other safety and security threats. True if protection concerns exist, False otherwise. Used for protection mainstreaming and specialized protection interventions.',
    `registration_date` DATE COMMENT 'Date when the community was first registered in the system as a collective beneficiary unit for area-based programming. This is the principal business event timestamp for the community entity.',
    `registration_source` STRING COMMENT 'Source system or tool used to register the community (e.g., KoboToolbox, CommCare, DHIS2, manual field assessment). Used for data lineage tracking and quality assessment.',
    `sanitation_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of households in the community with access to adequate sanitation facilities (latrines, toilets) meeting Sphere minimum standards (1 toilet per 20 people). Used for WASH gap analysis and intervention planning.',
    `settlement_type` STRING COMMENT 'Classification of the community or settlement type. Formal camp: officially designated refugee or IDP (Internally Displaced Person) camp. Informal settlement: spontaneous or unplanned settlement. Host community: existing community hosting displaced populations. Collective center: shared facility (school, warehouse) used for temporary shelter. Transit site: temporary waypoint for displaced populations. Urban area: city or town neighborhood.. Valid values are `formal_camp|informal_settlement|host_community|collective_center|transit_site|urban_area`',
    `community_status` STRING COMMENT 'Current lifecycle status of the community registration. Active: community is currently served by programs. Inactive: temporarily not served. Closed: community no longer exists or is no longer a target. Planned: community identified for future programming. Suspended: operations temporarily halted due to access constraints or security incidents.. Valid values are `active|inactive|closed|planned|suspended`',
    `vulnerability_category` STRING COMMENT 'Categorical classification of community vulnerability level derived from vulnerability_score. Critical: immediate life-saving assistance required. High: urgent multi-sectoral needs. Medium: moderate needs requiring monitoring. Low: stable with minimal humanitarian needs. Used for targeting and resource allocation decisions.. Valid values are `critical|high|medium|low`',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Composite vulnerability score for the community based on multi-sectoral needs assessment indicators (WASH, shelter, food security, protection, health). Higher scores indicate greater vulnerability and higher priority for humanitarian assistance. Scoring methodology aligns with agency-specific vulnerability assessment frameworks.',
    `water_access_flag` BOOLEAN COMMENT 'Indicates whether the community has adequate access to safe water sources according to Sphere minimum standards (15 liters per person per day within 500 meters). True if adequate access exists, False otherwise. Used for WASH (Water Sanitation and Hygiene) needs prioritization.',
    CONSTRAINT pk_community PRIMARY KEY(`community_id`)
) COMMENT 'Master record for a community, settlement, camp, or geographic area registered as a collective beneficiary unit for area-based humanitarian programming. Captures community name, geographic coordinates, administrative boundaries (admin1-admin4), settlement type (formal camp, informal settlement, host community, collective center, transit site), estimated population, community leadership contacts, community-level vulnerability indicators (access to water, sanitation coverage, health facility proximity), registration date, and active program associations. Enables community-based targeting for WASH, shelter, food security, and livelihoods interventions where the unit of assistance is the community rather than individual or household. Supports OCHA Common Operational Dataset (COD) alignment and 3W (Who does What Where) reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` (
    `service_assignment_id` BIGINT COMMENT 'Unique identifier for each volunteer-beneficiary service assignment record. Primary key for the association.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to the beneficiary registrant receiving services from the volunteer',
    `staff_member_id` BIGINT COMMENT 'Identifier of the program coordinator or case manager who made this volunteer-beneficiary assignment.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to the volunteer providing services to the beneficiary',
    `case_load_priority` STRING COMMENT 'Priority level of this beneficiary within the volunteers caseload. Explicitly identified in detection reasoning as relationship data.',
    `service_assignment_date` DATE COMMENT 'The date when this volunteer was formally assigned to this beneficiary by program coordination staff.',
    `end_date` DATE COMMENT 'The date when the volunteer stopped or is scheduled to stop providing services to this beneficiary. Null indicates ongoing service. Explicitly identified in detection reasoning as relationship data.',
    `frequency` STRING COMMENT 'How frequently the volunteer provides services to this beneficiary. Explicitly identified in detection reasoning as relationship data.',
    `location` STRING COMMENT 'The location where services are delivered (community center, home visit, health post, etc.). Explicitly identified in detection reasoning as relationship data.',
    `notes` STRING COMMENT 'Free-text notes about this specific service assignment, including special considerations, beneficiary preferences, or coordination details.',
    `service_delivery_status` STRING COMMENT 'Current status of the service delivery relationship between this volunteer and beneficiary. Explicitly identified in detection reasoning as relationship data.',
    `service_type` STRING COMMENT 'The type of service the volunteer is providing to this beneficiary. Explicitly identified in detection reasoning as relationship data.',
    `start_date` DATE COMMENT 'The date when the volunteer began providing services to this beneficiary. Explicitly identified in detection reasoning as relationship data.',
    `supervision_level` STRING COMMENT 'The level of supervision required for this volunteer-beneficiary service relationship. Explicitly identified in detection reasoning as relationship data.',
    CONSTRAINT pk_service_assignment PRIMARY KEY(`service_assignment_id`)
) COMMENT 'This association product represents the operational assignment of volunteers to beneficiaries for service delivery in community-based programming. It captures the service relationship between a volunteer and a registrant, including service type, duration, frequency, and delivery status. Each record links one volunteer to one beneficiary they are actively serving or have served, with attributes that exist only in the context of this service delivery relationship. This is the operational record that case managers and program coordinators use to track volunteer caseloads and beneficiary service coverage.. Existence Justification: In nonprofit community-based programming, volunteers serve multiple beneficiaries simultaneously as part of their caseload (a community health worker serves 20-30 households, a PSS counselor supports 15-20 individuals), and beneficiaries receive services from multiple volunteers over time and across service types (one beneficiary may have a nutrition monitor, a case manager, and a community health worker). Program coordinators actively manage these service assignments, tracking who serves whom, with what service type, at what frequency, and with what status.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` (
    `household_volunteer_assignment_id` BIGINT COMMENT 'Primary key for household_volunteer_assignment',
    `household_id` BIGINT COMMENT 'Foreign key linking to the household receiving volunteer services',
    `service_assignment_id` BIGINT COMMENT 'Unique system-generated identifier for the household-volunteer assignment record. Primary key.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to the volunteer assigned to provide services',
    `household_volunteer_assignment_date` DATE COMMENT 'Calendar date when the volunteer was formally assigned to this household for service delivery. Marks the beginning of the assignment relationship.',
    `end_date` DATE COMMENT 'Calendar date when the assignment was formally ended or closed. Null for active assignments. Used for historical tracking and volunteer engagement reporting.',
    `geographic_area` STRING COMMENT 'Geographic zone, sector, or catchment area identifier for this assignment. Used to group households by volunteer service area for workload balancing and geographic coverage planning.',
    `last_visit_date` DATE COMMENT 'Calendar date of the most recent visit by this volunteer to this household. Updated after each completed visit for monitoring and follow-up scheduling.',
    `next_visit_date` DATE COMMENT 'Calendar date of the next scheduled visit by this volunteer to this household. Used for volunteer scheduling and workload planning.',
    `notes` STRING COMMENT 'Free-text field for capturing assignment-specific notes, special instructions, household preferences, or contextual information relevant to service delivery.',
    `household_volunteer_assignment_status` STRING COMMENT 'Current lifecycle state of the volunteer-household assignment. Active indicates ongoing service delivery, Suspended indicates temporary pause, Completed indicates assignment ended successfully, Transferred indicates household reassigned to another volunteer.',
    `household_volunteer_assignment_type` STRING COMMENT 'Classification of the service delivery type for this assignment. Defines the primary program area or service category the volunteer provides to the household.',
    `visit_frequency` STRING COMMENT 'Expected frequency of volunteer visits to the household based on program requirements and household needs assessment.',
    CONSTRAINT pk_household_volunteer_assignment PRIMARY KEY(`household_volunteer_assignment_id`)
) COMMENT 'This association product represents the assignment relationship between households and volunteers in community-based service delivery programs. It captures the operational assignment of volunteers to specific households for ongoing service delivery, visit tracking, and workload management. Each record links one household to one volunteer with attributes that track assignment lifecycle, visit schedules, and service delivery context.. Existence Justification: In community-based humanitarian service delivery, volunteers are operationally assigned to multiple households within their geographic catchment area (a community health worker may serve 20-30 households), and households receive services from multiple volunteers over time across different program areas (health, nutrition, protection, livelihoods). The assignment relationship is actively managed by program coordinators who create assignments, track visit schedules, monitor service delivery, and reassign households based on volunteer availability and workload balancing.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` (
    `community_intervention_id` BIGINT COMMENT 'Unique identifier for this specific community-intervention implementation record',
    `community_id` BIGINT COMMENT 'Foreign key linking to the community where this intervention is being implemented',
    `award_id` BIGINT COMMENT 'add column grant_award_id (BIGINT) with FK to grant.award.award_id - community interventions are funded by grants and this financial traceability link is missing',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to the intervention being implemented in this community',
    `end_date` DATE COMMENT 'Date when intervention activities concluded or are planned to conclude in this specific community. Explicitly identified in detection phase as relationship data.',
    `geographic_coverage_type` STRING COMMENT 'Classification of how the intervention covers this community. Explicitly identified in detection phase as relationship data. Full community: all households eligible; Partial - targeted households: specific vulnerability-based targeting; Partial - geographic zone: specific neighborhoods/sectors; Pilot: test implementation.',
    `implementation_status` STRING COMMENT 'Current status of intervention implementation in this specific community. Explicitly identified in detection phase as relationship data. Values: Planned (not yet started), Active (ongoing), Suspended (temporarily halted), Completed (activities finished), Closed (administratively closed).',
    `reached_household_count` STRING COMMENT 'Actual number of households reached by this intervention in this specific community. Explicitly identified in detection phase as relationship data. Used for coverage calculation and donor reporting.',
    `start_date` DATE COMMENT 'Date when intervention activities commenced in this specific community. Explicitly identified in detection phase as relationship data.',
    `target_household_count` STRING COMMENT 'Number of households this intervention aims to reach in this specific community. Explicitly identified in detection phase as relationship data.',
    CONSTRAINT pk_community_intervention PRIMARY KEY(`community_intervention_id`)
) COMMENT 'This association product represents the implementation relationship between a community and an intervention. It captures the operational deployment of a humanitarian or development intervention to a specific community, including implementation timeline, household targeting and reach metrics, coverage status, and geographic implementation type. Each record links one community to one intervention with attributes that exist only in the context of this specific implementation deployment.. Existence Justification: In humanitarian operations, one intervention is routinely deployed across multiple communities (multi-site implementation is standard for area-based programming), and one community simultaneously receives multiple interventions from different sectors (integrated programming is a core humanitarian principle - e.g., a refugee camp receives WASH, health, nutrition, and education interventions concurrently). NGOs actively manage these implementation relationships as operational entities, tracking start/end dates, household targeting vs. reach, and coverage status for each community-intervention pairing to support geographic reporting, cluster coordination (3W reporting), and community-level program monitoring required by humanitarian coordination mechanisms.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'Unique identifier for this enrollment record. Primary key for the enrollment association.',
    `component_id` BIGINT COMMENT 'Foreign key to program.component. Identifies the program component in which the beneficiary is enrolled.',
    `award_id` BIGINT COMMENT 'add column grant_award_id (BIGINT) with FK to grant.award.award_id - beneficiary enrollments into program components are funded by specific grants',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to the beneficiary registrant participating in this component enrollment',
    `staff_member_id` BIGINT COMMENT 'Identifier of the NGO staff member or partner organization staff who processed this enrollment. Used for accountability, quality assurance, and workload tracking.',
    `program_id` BIGINT COMMENT '',
    `attendance_rate` DECIMAL(18,2) COMMENT 'Percentage of scheduled component activities or sessions that the registrant attended. Calculated as (sessions_attended / sessions_scheduled) * 100. Used for engagement monitoring, outcome correlation analysis, and donor reporting on program participation quality. Explicitly identified in detection phase.',
    `completion_date` DATE COMMENT 'The date on which the registrant completed or exited this component enrollment. Null for active enrollments. Used for outcome tracking, retention analysis, and donor reporting on program completion rates. Explicitly identified in detection phase.',
    `consent_for_component` BOOLEAN COMMENT 'Indicates whether the registrant (or guardian) provided informed consent specifically for participation in this component. Some components (e.g., health screening, psychosocial support) require additional consent beyond general registration consent.',
    `created_at` TIMESTAMP COMMENT 'System timestamp when this enrollment record was created in the database. Used for audit trail and data lineage.',
    `enrollment_date` DATE COMMENT 'The date on which the registrant was formally enrolled into this program component. Used for cohort analysis, eligibility determination, and donor reporting on enrollment timelines. Explicitly identified in detection phase as enrollment_date.',
    `exit_reason` STRING COMMENT 'Classification of the reason for enrollment termination or exit. Used for attrition analysis, program improvement, and donor reporting on retention and completion. Values include: completed (successfully finished), relocated (moved out of service area), deceased, ineligible (no longer meets criteria), voluntary-withdrawal, lost-to-follow-up, program-closure, other. Null for active enrollments. Explicitly identified in detection phase.',
    `location` STRING COMMENT 'Geographic location (site, camp, community, district) where this enrollment was processed. Used for geographic disaggregation in MEL reporting and operational planning.',
    `referral_source` STRING COMMENT 'Source of referral into this component enrollment (self-referral, community health worker, partner organization, internal program referral, vulnerability assessment). Used for referral pathway analysis and partnership coordination.',
    `service_delivery_modality` STRING COMMENT 'The method or channel through which this components services are delivered to the registrant. Distinguishes in-person group sessions, mobile outreach, remote/digital delivery, hybrid approaches, cash transfers, vouchers, or direct provision of goods/services. Critical for modality-disaggregated MEL reporting required by donors. Explicitly identified in detection phase.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment record. Controls eligibility for component-specific services and activities. Values: enrolled (registered but not yet active), active (currently participating), suspended (temporarily paused), completed (successfully finished component), withdrawn (voluntarily left), exited (administratively removed). Explicitly identified in detection phase as enrollment_status.',
    `updated_at` TIMESTAMP COMMENT 'System timestamp when this enrollment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between a registrant and a program component. It captures the operational record of a beneficiarys participation in a specific component of a program intervention, including enrollment lifecycle, service delivery tracking, and component-specific outcome data required for donor reporting and MEL frameworks. Each record links one registrant to one component with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In NGO operations, a single beneficiary registrant participates in multiple program components simultaneously or over time (e.g., a child receives nutrition screening, education support, and WASH services as separate component enrollments). Conversely, each program component serves multiple registrants. The enrollment relationship is actively managed by program staff who track enrollment dates, participation status, attendance, service delivery modality, and exit reasons for each registrant-component pairing. This enrollment data is essential for component-level reach reporting, disaggregated MEL indicators, and donor logframe reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for each beneficiary-commodity entitlement record',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to the humanitarian commodity that the beneficiary is entitled to receive',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user or program officer who created this entitlement record. Used for accountability and audit purposes.',
    `entitlement_last_modified_by_user_user_account_id` BIGINT COMMENT 'Identifier of the system user who most recently modified this entitlement record. Used for accountability and audit purposes.',
    `intervention_id` BIGINT COMMENT 'Identifier of the humanitarian program or intervention under which this entitlement is granted (e.g., General Food Distribution, Blanket Supplementary Feeding, Emergency NFI Distribution). Links entitlement to funding source and program reporting.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to the beneficiary registrant who holds this commodity entitlement',
    `approving_user_account_id` BIGINT COMMENT '',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this entitlement record was created in the system. Used for audit trail and entitlement history tracking.',
    `end_date` DATE COMMENT 'The date on which this entitlement expires or is scheduled to end. Null indicates ongoing entitlement subject to program continuation. Used for entitlement lifecycle management and program phase-out planning.',
    `frequency` STRING COMMENT 'The frequency at which the beneficiary is entitled to receive this commodity (e.g., monthly food ration, one-time NFI kit, weekly fresh food distribution). Drives distribution cycle planning.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this entitlement record. Used for change tracking and synchronization.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the commodity that the beneficiary is entitled to receive per distribution cycle, expressed in the commoditys standard unit of measure. Used for ration calculation and distribution planning.',
    `special_dietary_requirement` STRING COMMENT 'Free-text description of any special dietary requirements, restrictions, or substitutions applicable to this beneficiary-commodity entitlement (e.g., halal, kosher, allergen-free, therapeutic food for MAM/SAM cases). Used for commodity substitution and specialized ration planning.',
    `start_date` DATE COMMENT 'The date from which this entitlement becomes active and the beneficiary is eligible to receive the commodity. Used for entitlement verification and distribution eligibility checks.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of this entitlement record. Controls whether the beneficiary is currently eligible to receive this commodity in distribution operations.',
    `vulnerability_based_adjustment` DECIMAL(18,2) COMMENT 'Multiplier or adjustment factor applied to the base entitlement quantity based on the beneficiarys vulnerability category, protection status, or special needs (e.g., 1.5x for pregnant/lactating women, 2.0x for severely malnourished children). Applied during ration calculation.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'This association product represents the entitlement relationship between registrant and commodity. It captures the humanitarian assistance entitlement rules that define which commodities each beneficiary is entitled to receive, in what quantities, at what frequency, and for what duration. Each record links one registrant to one commodity with entitlement-specific parameters including quantity per distribution cycle, distribution frequency, entitlement validity period, vulnerability-based adjustments, and special dietary requirements. This is the operational SSOT for ration planning, distribution planning, and beneficiary entitlement verification in food security and NFI distribution programs.. Existence Justification: In humanitarian operations, beneficiaries are entitled to receive multiple commodities simultaneously as part of their assistance package (e.g., a monthly food basket includes rice, oil, beans, salt, and a household receives multiple NFI items like blankets, jerry cans, soap). Each commodity is entitled to thousands of beneficiaries across the program. The entitlement relationship is an operational business entity actively managed by program officers, carrying specific data about quantity per distribution cycle, frequency, validity period, vulnerability-based adjustments, and special dietary requirements that belong to neither the beneficiary nor the commodity alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_dedup_master_registrant_id` FOREIGN KEY (`dedup_master_registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ADD CONSTRAINT `fk_beneficiary_registrant_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ADD CONSTRAINT `fk_beneficiary_household_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ADD CONSTRAINT `fk_beneficiary_household_member_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_previous_profile_vulnerability_profile_id` FOREIGN KEY (`previous_profile_vulnerability_profile_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile`(`vulnerability_profile_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ADD CONSTRAINT `fk_beneficiary_vulnerability_profile_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ADD CONSTRAINT `fk_beneficiary_beneficiary_needs_assessment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ADD CONSTRAINT `fk_beneficiary_consent_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ADD CONSTRAINT `fk_beneficiary_case_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ADD CONSTRAINT `fk_beneficiary_case_action_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ADD CONSTRAINT `fk_beneficiary_referral_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ADD CONSTRAINT `fk_beneficiary_biometric_record_duplicate_record_biometric_record_id` FOREIGN KEY (`duplicate_record_biometric_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`biometric_record`(`biometric_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ADD CONSTRAINT `fk_beneficiary_biometric_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_case_record_id` FOREIGN KEY (`case_record_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`case_record`(`case_record_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ADD CONSTRAINT `fk_beneficiary_protection_flag_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ADD CONSTRAINT `fk_beneficiary_registration_event_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ADD CONSTRAINT `fk_beneficiary_displacement_history_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ADD CONSTRAINT `fk_beneficiary_exit_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ADD CONSTRAINT `fk_beneficiary_exit_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ADD CONSTRAINT `fk_beneficiary_document_record_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ADD CONSTRAINT `fk_beneficiary_community_parent_community_id` FOREIGN KEY (`parent_community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ADD CONSTRAINT `fk_beneficiary_service_assignment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ADD CONSTRAINT `fk_beneficiary_household_volunteer_assignment_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`household`(`household_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ADD CONSTRAINT `fk_beneficiary_household_volunteer_assignment_service_assignment_id` FOREIGN KEY (`service_assignment_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`service_assignment`(`service_assignment_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ADD CONSTRAINT `fk_beneficiary_community_intervention_community_id` FOREIGN KEY (`community_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`community`(`community_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ADD CONSTRAINT `fk_beneficiary_enrollment_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ADD CONSTRAINT `fk_beneficiary_entitlement_registrant_id` FOREIGN KEY (`registrant_id`) REFERENCES `vibe_ngo_v1`.`beneficiary`.`registrant`(`registrant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`beneficiary` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`beneficiary` SET TAGS ('dbx_domain' = 'beneficiary');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `dedup_master_registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Master Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `intervention_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Registering Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `age_years` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Given Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `deduplication_status` SET TAGS ('dbx_value_regex' = 'pending|unique|duplicate|merged|flagged');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_business_glossary_term' = 'Disability Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `disability_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name (Surname)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name (First Name)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_business_glossary_term' = 'Disability Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `has_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Survivor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_gbv_survivor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `is_unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `poc_category` SET TAGS ('dbx_business_glossary_term' = 'Person of Concern (PoC) Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code (ISO 639)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `protection_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `re_registration_count` SET TAGS ('dbx_business_glossary_term' = 'Re-Registration Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_business_glossary_term' = 'Registration Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_modality` SET TAGS ('dbx_value_regex' = 'in_person|mobile|remote|self_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Registration Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_value_regex' = 'commcare|kobotoolbox|progres_v4|wfp_scope|rais|manual');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|departed|duplicate|suspended');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_business_glossary_term' = 'Registration Tool');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_tool` SET TAGS ('dbx_value_regex' = 'kobotoolbox|commcare|paper_form|progres_v4|scope|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'individual|household_head|household_member|community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `sex` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_value_regex' = 'national_id|passport|unhcr_card|birth_certificate|community_attestation|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registrant` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community / Settlement ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Programme ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator / Field Staff ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Head of Household Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name (Region/Province)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name (District/County)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_business_glossary_term' = 'Current Country of Residence (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `current_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `deregistration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Deregistration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_date` SET TAGS ('dbx_business_glossary_term' = 'Displacement Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|asylum_seeker');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `elderly_count` SET TAGS ('dbx_business_glossary_term' = 'Elderly Member Count (60+)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Programme Exit Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `female_count` SET TAGS ('dbx_business_glossary_term' = 'Female Member Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_business_glossary_term' = 'Food Security Status (IPC Phase)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `food_security_status` SET TAGS ('dbx_value_regex' = 'food_secure|mildly_insecure|moderately_insecure|severely_insecure');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_pregnant_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman Present Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `has_unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied or Separated Child (UASC) Present Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Submission ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Needs Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `male_count` SET TAGS ('dbx_business_glossary_term' = 'Male Member Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Household Case Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `pwd_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disabilities (PWD) Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_verification|archived');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'initial|re-registration|update|verification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Facility Type (WASH)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `sanitation_facility_type` SET TAGS ('dbx_value_regex' = 'flush_toilet|pit_latrine|ventilated_pit|open_defecation|communal_latrine|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_business_glossary_term' = 'Shelter Ownership Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_ownership` SET TAGS ('dbx_value_regex' = 'owned|rented|informal|provided_by_org|communal');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `shelter_type` SET TAGS ('dbx_business_glossary_term' = 'Shelter Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size (Total Members)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Household Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Water Source Type (WASH)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_business_glossary_term' = 'Household Member ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_business_glossary_term' = 'Age Estimated Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_estimated` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Age in Years');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `age_years` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_code` SET TAGS ('dbx_business_glossary_term' = 'Household Member Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `household_member_code` SET TAGS ('dbx_value_regex' = '^HHM-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'kobo_survey|commcare_mobile|paper_form|fgd|kii|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_female_headed` SET TAGS ('dbx_business_glossary_term' = 'Is Female-Headed Household Member Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_business_glossary_term' = 'Is Head of Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `is_head_of_household` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'employed|self_employed|unemployed|student|unable_to_work|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_business_glossary_term' = 'Household Membership End Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_end_reason` SET TAGS ('dbx_value_regex' = 'deceased|transferred_household|relocated|voluntary_exit|administrative_closure|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Household Membership Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|transferred|deceased|departed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'MUAC Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `muac_cm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Member Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `pregnant_or_lactating` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Location Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `relationship_to_head` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Head of Household');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Household Member Role');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `role` SET TAGS ('dbx_value_regex' = 'head|spouse|child|dependent|elderly|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'School Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `school_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|dropout|graduated|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_business_glossary_term' = 'Sex');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_value_regex' = 'male|female|intersex|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `sex` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `unaccompanied_minor` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|rejected');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_member` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` SET TAGS ('dbx_subdomain' = 'protection_assessment');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `previous_profile_vulnerability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Vulnerability Profile ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_value_regex' = 'KoboToolbox|CommCare|DHIS2|ODK|paper_based|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `chronic_illness_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_code` SET TAGS ('dbx_value_regex' = '^VP-[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `composite_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Inter-Agency Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_business_glossary_term' = 'Disability Classification (Washington Group Questions)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_classification` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_business_glossary_term' = 'Disability Severity Level (Washington Group Questions)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_value_regex' = 'no_difficulty|some_difficulty|a_lot_of_difficulty|cannot_do');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `disability_severity` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_business_glossary_term' = 'Displacement Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `displacement_category` SET TAGS ('dbx_value_regex' = 'IDP|refugee|returnee|stateless|asylum_seeker|host_community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `elderly_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Elderly Household Member Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `female_headed_household_flag` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Exposure Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `gbv_exposure_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{2,10}(-[A-Z0-9]{2,10})?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_business_glossary_term' = 'Integrated Food Security Phase Classification (IPC) Phase');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'none|disrupted|partial|stable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `next_reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reassessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Status (GAM/SAM Classification)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_value_regex' = 'SAM|MAM|normal|overweight');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `nutritional_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnant or Lactating Woman (PLW) Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pregnant_lactating_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Need Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `pss_need_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_business_glossary_term' = 'Shelter Adequacy Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `shelter_adequacy` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|none|transitional');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Profile Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_distribution_monitoring|emergency_screening|referral|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Profile Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_profile_status` SET TAGS ('dbx_value_regex' = 'active|archived|pending_review|superseded|draft');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Tier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `vulnerability_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`vulnerability_profile` ALTER COLUMN `wash_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Access Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` SET TAGS ('dbx_subdomain' = 'protection_assessment');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Needs Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_description_cleaned' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `community_engagement_event_id` SET TAGS ('dbx_business_glossary_term' = 'Community Engagement Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Field Enumerator ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `children_under5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'face_to_face|remote_phone|fgd|kii|observation|secondary_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|stateless|non_displaced');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `education_score` SET TAGS ('dbx_business_glossary_term' = 'Education Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `enumerator_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Enumerator Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `female_headed_household` SET TAGS ('dbx_business_glossary_term' = 'Female-Headed Household Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `gbv_risk_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Assessment Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_level` SET TAGS ('dbx_value_regex' = 'individual|household|community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `livelihoods_score` SET TAGS ('dbx_business_glossary_term' = 'Livelihoods Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `muac_mm` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `nutrition_score` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `overall_vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_business_glossary_term' = 'Persons with Disability Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `persons_with_disability_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `protection_score` SET TAGS ('dbx_business_glossary_term' = 'Protection Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `reference_code` SET TAGS ('dbx_value_regex' = '^NA-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `referral_recommended` SET TAGS ('dbx_business_glossary_term' = 'Service Referral Recommended');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `referral_sectors` SET TAGS ('dbx_business_glossary_term' = 'Referral Sectors');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `sectors_assessed` SET TAGS ('dbx_business_glossary_term' = 'Sectors Assessed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `shelter_score` SET TAGS ('dbx_business_glossary_term' = 'Shelter Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `source_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Submission ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|validated|rejected|archived');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `supervisor_validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Validation Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `beneficiary_needs_assessment_type` SET TAGS ('dbx_value_regex' = 'initial_registration|periodic_reassessment|post_crisis_rapid|sector_specific_deep');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_vulnerable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`beneficiary_needs_assessment` ALTER COLUMN `wash_score` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Sector Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` SET TAGS ('dbx_subdomain' = 'protection_assessment');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `biometric_enrollment_permitted` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `collection_country_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `collection_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `collection_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Location');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2,3})?$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|thumbprint|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_value_regex' = '^CNS-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'given|withdrawn|pending|expired|refused');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|photography_media|case_referral|biometric_enrollment|program_participation|research_survey');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Data Scope');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Attachment Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `form_attachment_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'GDPR Applicable Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `informed_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `is_proxy_consent` SET TAGS ('dbx_business_glossary_term' = 'Is Proxy Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_business_glossary_term' = 'Photography and Media Use Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `photography_permitted` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Proxy Consent Giver Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `proxy_relationship` SET TAGS ('dbx_business_glossary_term' = 'Proxy Relationship to Beneficiary');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `sharing_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Restrictions');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Witness Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`consent_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Service Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Caseworker ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_business_glossary_term' = 'Case Narrative');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_narrative` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CASE-[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_plan_developed` SET TAGS ('dbx_business_glossary_term' = 'Case Plan Developed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_business_glossary_term' = 'Case Stage');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_value_regex' = 'intake|assessment|planning|intervention|monitoring|closure');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|on_hold|closed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `commcare_case_reference` SET TAGS ('dbx_business_glossary_term' = 'CommCare Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'commcare_mobile|kobo_form|paper_form|phone_interview|fgd|kii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_business_glossary_term' = 'Child Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_child_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_gbv_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `is_idp_case` SET TAGS ('dbx_business_glossary_term' = 'Internally Displaced Person (IDP) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `last_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Aid Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) in Centimetres');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `muac_cm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `next_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'sam|mam|normal|at_risk');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'On-Hold Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_business_glossary_term' = 'Case Outcome Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `outcome_classification` SET TAGS ('dbx_value_regex' = 'goal_achieved|partially_achieved|not_achieved|lost_to_followup|referred_out|deceased');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_business_glossary_term' = 'Presenting Issue');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `presenting_issue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Protection Risk Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_value_regex' = 'extreme|high|medium|low|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `protection_risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `pss_session_count` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Session Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan In Place Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_business_glossary_term' = 'Service Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `service_modality` SET TAGS ('dbx_value_regex' = 'in_person|remote|mobile_outreach|group_session|home_visit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `supervisor_review_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_record` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_id` SET TAGS ('dbx_business_glossary_term' = 'Case Action ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `constituent_message_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Message Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `feedback_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `admin_level1_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `admin_level2_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_category` SET TAGS ('dbx_business_glossary_term' = 'Case Action Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|proxy|not_required');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'mobile_app|paper_form|phone_interview|direct_observation|fgd|kii');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_date` SET TAGS ('dbx_business_glossary_term' = 'Case Action Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Action Duration (Minutes)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_type` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `follow_up_type` SET TAGS ('dbx_value_regex' = 'home_visit|phone_call|facility_visit|group_session|referral_follow_up');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `is_sensitive_case` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Action GPS Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Action GPS Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `muac_measurement_mm` SET TAGS ('dbx_business_glossary_term' = 'Mid-Upper Arm Circumference (MUAC) Measurement (mm)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `muac_measurement_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Status Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_value_regex' = 'sam|mam|normal|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `nutrition_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Action Outcome');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|pending|referred_out');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Action Outcome Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_value_regex' = 'gbv|child_protection|trafficking|idp_displacement|statelessness|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `pss_session_number` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Session Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Action Reference Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `referral_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Action Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `service_items_provided` SET TAGS ('dbx_business_glossary_term' = 'Service Items Provided');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_status` SET TAGS ('dbx_business_glossary_term' = 'Case Action Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|missed|rescheduled');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `supervisor_review_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `supervisor_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Reviewed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Action Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_type` SET TAGS ('dbx_business_glossary_term' = 'Case Action Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `case_action_type` SET TAGS ('dbx_value_regex' = 'home_visit|counseling_session|referral|service_provision|follow_up_call|group_session');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`case_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `constituent_message_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Message Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Organization Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Member Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Staff Member Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `beneficiary_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_category` SET TAGS ('dbx_business_glossary_term' = 'Referral Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|sensitive|highly_sensitive');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `expected_response_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Response Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `feedback_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `gbv_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Referral Outcome');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'successful|partially_successful|unsuccessful|beneficiary_declined|service_unavailable|lost_to_follow_up');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_organization_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_service_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Service Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Staff Member Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `receiving_staff_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Contact Information');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff Member Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referring_staff_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `service_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|in_progress|completed|declined|cancelled');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'internal|external|emergency|routine|urgent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_record_id` SET TAGS ('dbx_business_glossary_term' = 'Biometric Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_record_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `duplicate_record_biometric_record_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Biometric Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `duplicate_record_biometric_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `duplicate_record_biometric_record_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Operator Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_business_glossary_term' = 'Biometric Modality Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_value_regex' = 'fingerprint|iris_scan|facial_recognition|palm_vein|voice_recognition|multimodal');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `biometric_modality` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Biometric Capture Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_value_regex' = 'optical|capacitive|ultrasonic|thermal|camera|scanner');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Biometric Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|digital|witnessed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Biometric Consent Obtained Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Days');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `deduplication_match_found` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Match Found Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `deduplication_match_score` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Match Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `deduplication_performed` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Check Performed Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Biometric Device Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_digital' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `device_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `device_model` SET TAGS ('dbx_business_glossary_term' = 'Device Model Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `encryption_applied` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_latitude` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Geographic Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_latitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_location` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_longitude` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Geographic Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_longitude` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_purpose` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Purpose');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enrollment Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Biometric Record Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Biometric Quality Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `quality_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Quality Threshold Met Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `template_format` SET TAGS ('dbx_business_glossary_term' = 'Biometric Template Format Standard');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `template_reference` SET TAGS ('dbx_business_glossary_term' = 'Biometric Template Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `template_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `template_reference` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `template_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Template Size in Bytes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `verification_count` SET TAGS ('dbx_business_glossary_term' = 'Verification Event Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Biometric Verification Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`biometric_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'enrolled|verified|failed|pending|expired|revoked');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` SET TAGS ('dbx_subdomain' = 'protection_assessment');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `feedback_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submission Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Protection Officer ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_code` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Restricted|Confidential|Internal|Public');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_date` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `flagging_source` SET TAGS ('dbx_business_glossary_term' = 'Flagging Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Required');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Identification Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `immediate_needs` SET TAGS ('dbx_business_glossary_term' = 'Immediate Needs');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `immediate_needs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `last_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Last Follow-up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `legal_action_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Required');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `pss_provided` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Provided');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_made` SET TAGS ('dbx_business_glossary_term' = 'Referral Made');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `referral_organization` SET TAGS ('dbx_business_glossary_term' = 'Referral Organization');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}-d{2}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `risk_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Severity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_status` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_status` SET TAGS ('dbx_value_regex' = 'Active|Monitoring|Resolved|Closed|Escalated|Referred');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`protection_flag` ALTER COLUMN `protection_flag_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Flag Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Event ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Registering Staff ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_business_glossary_term' = 'Biometric Captured Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_captured` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_business_glossary_term' = 'Biometric Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_value_regex' = 'fingerprint|iris_scan|facial_recognition|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `biometric_type` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'verbal|written|digital_signature|guardian_consent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Check Performed Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `deduplication_method` SET TAGS ('dbx_value_regex' = 'biometric|demographic|document_number|manual_review|none');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_found` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Found Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Resolution Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `duplicate_resolution_status` SET TAGS ('dbx_value_regex' = 'no_duplicate|duplicate_confirmed|duplicate_resolved|pending_review');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_business_glossary_term' = 'Household Head Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_head` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `household_registration` SET TAGS ('dbx_business_glossary_term' = 'Household Registration Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_required` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registering_organization` SET TAGS ('dbx_business_glossary_term' = 'Registering Organization');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registering_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Registering Staff Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registering_staff_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Registration Completeness Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_business_glossary_term' = 'Registration Language');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_business_glossary_term' = 'Registration Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_business_glossary_term' = 'Registration Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_modality` SET TAGS ('dbx_business_glossary_term' = 'Registration Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_modality` SET TAGS ('dbx_value_regex' = 'in_person|mobile_outreach|remote_digital|phone_interview|community_based');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'draft|pending_verification|verified|approved|rejected|incomplete');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_tool` SET TAGS ('dbx_business_glossary_term' = 'Registration Tool');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_tool` SET TAGS ('dbx_value_regex' = 'kobotoolbox|commcare|paper_form|unhcr_primes|custom_app|other');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'initial|re-registration|update|verification|biometric_enrollment');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `verification_document_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`registration_event` ALTER COLUMN `vulnerability_assessment_conducted` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Assessment Conducted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_history_id` SET TAGS ('dbx_business_glossary_term' = 'Displacement History ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enumerator ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_admin1_code` SET TAGS ('dbx_business_glossary_term' = 'Current Administrative Level 1 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_admin2_code` SET TAGS ('dbx_business_glossary_term' = 'Current Administrative Level 2 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_country_code` SET TAGS ('dbx_business_glossary_term' = 'Current Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_latitude` SET TAGS ('dbx_business_glossary_term' = 'Current Location Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_longitude` SET TAGS ('dbx_business_glossary_term' = 'Current Location Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_settlement_name` SET TAGS ('dbx_business_glossary_term' = 'Current Settlement Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_settlement_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Current Settlement Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `current_settlement_type` SET TAGS ('dbx_value_regex' = 'camp|collective_center|host_community|informal_settlement|urban_area|rural_area');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `data_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `data_collection_tool` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `data_collection_tool` SET TAGS ('dbx_value_regex' = 'kobotoolbox|commcare|odk|unhcr_progres|iom_dtm|manual_entry');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_date` SET TAGS ('dbx_business_glossary_term' = 'Displacement Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Displacement Duration in Days');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_episode_number` SET TAGS ('dbx_business_glossary_term' = 'Displacement Episode Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'newly_displaced|protracted_displaced|returned|resettled|locally_integrated|in_transit');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_trigger` SET TAGS ('dbx_business_glossary_term' = 'Displacement Trigger');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_trigger` SET TAGS ('dbx_value_regex' = 'armed_conflict|generalized_violence|human_rights_violations|natural_disaster|climate_event|development_project');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Verification Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `displacement_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|disputed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `hdx_dataset_reference` SET TAGS ('dbx_business_glossary_term' = 'Humanitarian Data Exchange (HDX) Dataset ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Border Displacement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `is_protracted` SET TAGS ('dbx_business_glossary_term' = 'Is Protracted Displacement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `local_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Local Integration Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `local_integration_status` SET TAGS ('dbx_value_regex' = 'not_applicable|in_progress|achieved|citizenship_granted');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_admin1_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Administrative Level 1 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_admin2_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Administrative Level 2 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_settlement_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Settlement Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `origin_settlement_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `poc_category` SET TAGS ('dbx_business_glossary_term' = 'Person of Concern (PoC) Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `poc_category` SET TAGS ('dbx_value_regex' = 'idp|refugee|asylum_seeker|returnee|stateless|host_community');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `resettlement_country_code` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `resettlement_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `resettlement_date` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `return_intention` SET TAGS ('dbx_business_glossary_term' = 'Return Intention');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `return_intention` SET TAGS ('dbx_value_regex' = 'intends_to_return|no_return_intention|undecided|return_not_safe');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `return_type` SET TAGS ('dbx_business_glossary_term' = 'Return Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `return_type` SET TAGS ('dbx_value_regex' = 'voluntary|facilitated|spontaneous|forced|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `transit_locations` SET TAGS ('dbx_business_glossary_term' = 'Transit Locations');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`displacement_history` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'field_visit|document_review|key_informant|community_leader|self_reported');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_record_id` SET TAGS ('dbx_business_glossary_term' = 'Exit Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `data_deletion_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Data Deletion Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `data_retention_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Classification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `data_retention_classification` SET TAGS ('dbx_value_regex' = 'retain_full|retain_anonymized|archive|delete');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `data_retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Months');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `death_certificate_verified` SET TAGS ('dbx_business_glossary_term' = 'Death Certificate Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `death_date` SET TAGS ('dbx_business_glossary_term' = 'Death Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_assessment_conducted` SET TAGS ('dbx_business_glossary_term' = 'Exit Assessment Conducted Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Exit Assessment Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Exit Assessment Outcome');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_assessment_outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_consent_method` SET TAGS ('dbx_business_glossary_term' = 'Exit Consent Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_consent_method` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Exit Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Exit Facility Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_facility_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_location_code` SET TAGS ('dbx_business_glossary_term' = 'Exit Location Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_number` SET TAGS ('dbx_business_glossary_term' = 'Exit Record Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_number` SET TAGS ('dbx_value_regex' = '^EXT-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_value_regex' = 'program_graduation|voluntary_withdrawal|relocation|death|loss_of_contact|loss_of_eligibility');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason Detail');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_status` SET TAGS ('dbx_business_glossary_term' = 'Exit Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|reversed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `exit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exit Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `is_duplicate_merge` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Merge Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `post_exit_followup_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Exit Follow-up Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `post_exit_followup_plan` SET TAGS ('dbx_business_glossary_term' = 'Post-Exit Follow-up Plan');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `post_exit_followup_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Exit Follow-up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `reactivation_conditions` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Conditions');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `reactivation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Reactivation Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `referral_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Organization Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `referral_organization_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `referral_provided` SET TAGS ('dbx_business_glossary_term' = 'Referral Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `referral_service_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Service Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `relocation_destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Relocation Destination Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `relocation_destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `relocation_destination_location` SET TAGS ('dbx_business_glossary_term' = 'Relocation Destination Location');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`exit_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` SET TAGS ('dbx_subdomain' = 'identity_registration');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_record_id` SET TAGS ('dbx_business_glossary_term' = 'Document Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_business_glossary_term' = 'Capture Device Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `capture_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Capture Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_value_regex' = 'mobile_scan|flatbed_scan|photograph|manual_entry|digital_upload');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'written|verbal|digital_signature|biometric|proxy');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_condition` SET TAGS ('dbx_business_glossary_term' = 'Document Condition');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|illegible');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_image_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Image Reference');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_image_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_image_reference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_language_code` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'unhcr_registration|national_id|birth_certificate|marriage_certificate|asylum_seeker_card|travel_document');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `is_primary_identity_document` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identity Document Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `legal_status_indicator` SET TAGS ('dbx_business_glossary_term' = 'Legal Status Indicator');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `registration_location_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Location Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Days');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|biometric_match|authority_confirmation|third_party_validation|digital_verification');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`document_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|unverified|expired|invalid|under_review');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` SET TAGS ('dbx_subdomain' = 'community_engagement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `parent_community_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Community Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `parent_community_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `access_constraint_level` SET TAGS ('dbx_business_glossary_term' = 'Access Constraint Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `access_constraint_level` SET TAGS ('dbx_value_regex' = 'no_constraint|low|medium|high|no_access');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `active_program_count` SET TAGS ('dbx_business_glossary_term' = 'Active Program Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin1_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin1_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin2_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin2_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin3_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin3_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin3_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin4_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 4 Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin4_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 4 Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `admin4_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_code` SET TAGS ('dbx_business_glossary_term' = 'Community Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'host_community|idp_settlement|refugee_camp|returnee_community|mixed');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `estimated_population` SET TAGS ('dbx_business_glossary_term' = 'Estimated Population');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `gbv_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Gender-Based Violence (GBV) Risk Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `gbv_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy in Meters');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Health Facility Distance in Kilometers (km)');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `health_facility_distance_km` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_business_glossary_term' = 'Integrated Food Security Phase Classification (IPC) Phase');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `ipc_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|phase_5');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_business_glossary_term' = 'Community Leader Contact');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_name` SET TAGS ('dbx_business_glossary_term' = 'Community Leader Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `leader_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_name` SET TAGS ('dbx_business_glossary_term' = 'Community Name');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Community Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Community Registration Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `sanitation_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Coverage Percentage');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `sanitation_coverage_percent` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'formal_camp|informal_settlement|host_community|collective_center|transit_site|urban_area');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_status` SET TAGS ('dbx_business_glossary_term' = 'Community Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `community_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|planned|suspended');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Community Vulnerability Category');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Community Vulnerability Score');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community` ALTER COLUMN `water_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Access Flag');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` SET TAGS ('dbx_subdomain' = 'community_engagement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` SET TAGS ('dbx_association_edges' = 'beneficiary.registrant,volunteer.volunteer');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `service_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment - Registrant Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigning Staff Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment - Volunteer Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `case_load_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Load Priority');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `service_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Location');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `service_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`service_assignment` ALTER COLUMN `supervision_level` SET TAGS ('dbx_business_glossary_term' = 'Supervision Level');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` SET TAGS ('dbx_subdomain' = 'community_engagement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` SET TAGS ('dbx_association_edges' = 'beneficiary.household,volunteer.volunteer');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `household_volunteer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'household_volunteer_assignment Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Volunteer Assignment - Household Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `service_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Household Volunteer Assignment - Volunteer Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `household_volunteer_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Catchment Area');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `next_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Visit Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `household_volunteer_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `household_volunteer_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`household_volunteer_assignment` ALTER COLUMN `visit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Visit Frequency');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` SET TAGS ('dbx_subdomain' = 'community_engagement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` SET TAGS ('dbx_association_edges' = 'beneficiary.community,program.intervention');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `community_intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Community Intervention Implementation ID');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Intervention - Community Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Community Intervention - Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `geographic_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Type');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `geographic_coverage_type` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `reached_household_count` SET TAGS ('dbx_business_glossary_term' = 'Reached Household Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`community_intervention` ALTER COLUMN `target_household_count` SET TAGS ('dbx_business_glossary_term' = 'Target Household Count');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` SET TAGS ('dbx_association_edges' = 'beneficiary.registrant,program.component');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Registrant Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolling Staff Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `attendance_rate` SET TAGS ('dbx_business_glossary_term' = 'Attendance Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `consent_for_component` SET TAGS ('dbx_business_glossary_term' = 'Component-Specific Consent');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `service_delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`enrollment` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` SET TAGS ('dbx_association_edges' = 'beneficiary.registrant,supply.commodity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Record Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement - Commodity Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Creating User Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `user_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `user_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_last_modified_by_user_user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modifying User Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_last_modified_by_user_user_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_last_modified_by_user_user_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement - Registrant Id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `approving_user_account_id` SET TAGS ('dbx_renamed_from' = 'user_account_id');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement End Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Quantity');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `special_dietary_requirement` SET TAGS ('dbx_business_glossary_term' = 'Special Dietary Requirement');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Start Date');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_ngo_v1`.`beneficiary`.`entitlement` ALTER COLUMN `vulnerability_based_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Adjustment Factor');
