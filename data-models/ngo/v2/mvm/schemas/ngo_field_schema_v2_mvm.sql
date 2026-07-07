-- Schema for Domain: field | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-03 06:20:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`field` COMMENT 'Systems of record: Kobo Toolbox (assessments & surveys), DHIS2 (health data), RAM (WFP real-time assessment monitoring), ActivityInfo (cluster coordination), ReliefWeb (sitreps). Field operations span project sites, distributions, WASH, and emergency response.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`project_site` (
    `project_site_id` BIGINT COMMENT 'Unique identifier for the project site. Primary key for the project site entity.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Project sites are established and funded per program component (e.g., a nutrition stabilization center under a nutrition component). Component-level site management is required for budget tracking, do',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: project_site has country_code (STRING) but no FK to the country reference table. The country table contains authoritative country metadata including codes, names, region, operational status, and human',
    `country_office_id` BIGINT COMMENT 'Reference to the country office that oversees operations at this project site.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Project sites (camps, distribution points, health facilities) are often established in direct response to declared humanitarian emergencies. Linking project_site to emergency enables emergency-level s',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization responsible for or collaborating on operations at this project site.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Project sites operate under legal registrations in their jurisdictions. Site establishment requires verification that the organization has legal operating authority (MOU, registration) in that locatio',
    `accessibility_rating` STRING COMMENT 'Assessment of physical accessibility to the project site considering road conditions, security, terrain, and seasonal factors.. Valid values are `easily_accessible|moderately_accessible|difficult|very_difficult|inaccessible`',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the project site is located.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county, department) where the project site is located.',
    `admin_level_3` STRING COMMENT 'Third-level administrative division (e.g., municipality, sub-district, commune) where the project site is located.',
    `closure_date` DATE COMMENT 'Date when the project site was officially closed or decommissioned. Null for active sites.',
    `cluster_affiliation` STRING COMMENT 'OCHA humanitarian cluster(s) that this project site is affiliated with for coordination purposes. [ENUM-REF-CANDIDATE: health|nutrition|wash|shelter|protection|education|food_security|logistics|emergency_telecom|camp_coordination|early_recovery — promote to reference product]',
    `contact_email` STRING COMMENT 'Primary email address for official communication with the project site.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the project site or site manager.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this project site record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this project site record originated (e.g., KoboToolbox, Dynamics 365, OpenStreetMap).',
    `electricity_available` BOOLEAN COMMENT 'Indicates whether electrical power is available at the project site.',
    `establishment_date` DATE COMMENT 'Date when the project site was officially established and became operational.',
    `facility_ownership` STRING COMMENT 'Legal ownership or usage arrangement for the physical facility at the project site.. Valid values are `owned|leased|borrowed|government|partner|temporary`',
    `gis_data_source` STRING COMMENT 'Source system or method used to capture GIS coordinates for this project site (e.g., GPS device, OpenStreetMap, satellite imagery).',
    `internet_connectivity` STRING COMMENT 'Type of internet connectivity available at the project site for data collection and reporting.. Valid values are `none|mobile_data|satellite|broadband|fiber`',
    `kobo_collection_enabled` BOOLEAN COMMENT 'Indicates whether mobile data collection via KoboToolbox is enabled and operational at this site.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent field assessment (FGD, KII, or site visit) conducted at this project site.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the project site in decimal degrees format. Used for GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the project site in decimal degrees format. Used for GIS mapping and spatial analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this project site record was last modified in the system.',
    `operational_status` STRING COMMENT 'Current operational state of the project site in its lifecycle.. Valid values are `active|inactive|suspended|planned|closed`',
    `pcode` STRING COMMENT 'OCHA-assigned unique place code (P-code) for standardized geographic referencing in humanitarian operations and reporting.. Valid values are `^[A-Z]{2}[0-9]{4,8}$`',
    `population_catchment` STRING COMMENT 'Estimated number of beneficiaries or persons of concern (PoC) within the service catchment area of this project site.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the project site location, if applicable.',
    `security_level` STRING COMMENT 'Current security risk assessment level for the project site based on threat analysis and security incidents.. Valid values are `minimal|low|moderate|substantial|critical`',
    `site_address` STRING COMMENT 'Physical street address or location description of the project site.',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total physical area of the project site measured in square meters.',
    `site_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the project site for field operations and reporting. Used in SitReps and OCHA coordination.. Valid values are `^[A-Z0-9]{6,12}$`',
    `site_description` STRING COMMENT 'Detailed narrative description of the project site including physical characteristics, surrounding environment, and operational context.',
    `site_manager_name` STRING COMMENT 'Name of the staff member responsible for managing operations at this project site.',
    `site_name` STRING COMMENT 'Human-readable name of the project site or operational location.',
    `site_type` STRING COMMENT 'Classification of the project site based on its primary function and service delivery model.. Valid values are `health_post|distribution_point|wash_facility|school|camp|community_center`',
    `water_source_available` BOOLEAN COMMENT 'Indicates whether a reliable water source is available at or near the project site for WASH operations.',
    CONSTRAINT pk_project_site PRIMARY KEY(`project_site_id`)
) COMMENT 'Represents a physical humanitarian project site (camp, distribution point, health facility, school, WASH point) with OCHA P-code geographic referencing. Supports 3W (Who does What Where) reporting, cluster coordination, and HDX spatial data. Source systems: Kobo Toolbox (GPS), eTools, CCCM site management. Systems-of-record: eTools (field monitoring), InSight, SAP PS. Framework: IATI v2.03 location elements / UN p-codes (OCHA CODs).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`country_office` (
    `country_office_id` BIGINT COMMENT 'Unique identifier for the country office record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: country_office has iso_country_code and country_name as STRING attributes but no FK to the country reference table. The country table contains authoritative country data including country_code_alpha2,',
    `parent_office_country_office_id` BIGINT COMMENT 'Reference to the parent country office or regional office to which this office reports, enabling hierarchical office structure.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Each country office is a legal entity requiring statutory registration in its jurisdiction. Compliance officers track registration status, renewal dates, and operating authority per office. country_of',
    `address_line_1` STRING COMMENT 'Primary street address or building location of the country office.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building name.',
    `city` STRING COMMENT 'City or municipality where the country office is located.',
    `closure_date` DATE COMMENT 'Date when the country office ceased operations or was officially closed.',
    `country_director_email` STRING COMMENT 'Email address of the country director for official communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `country_director_name` STRING COMMENT 'Full name of the senior management official responsible for leading the country office operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this country office record was first created in the system.',
    `email_address` STRING COMMENT 'Primary email address for official correspondence with the country office.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `establishment_date` DATE COMMENT 'Date when the country office was first established and began operations.',
    `is_emergency_response` BOOLEAN COMMENT 'Indicates whether this office was established specifically for emergency or humanitarian crisis response operations.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the office location in decimal degrees for Geographic Information System (GIS) mapping and field coordination.',
    `legal_entity_name` STRING COMMENT 'Official legal name under which the country office is registered with host government authorities, which may differ from the operational office name.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the office location in decimal degrees for Geographic Information System (GIS) mapping and field coordination.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this country office record was last modified in the system.',
    `mou_effective_date` DATE COMMENT 'Date when the Memorandum of Understanding (MoU) with the host government became effective.',
    `mou_expiry_date` DATE COMMENT 'Date when the current Memorandum of Understanding (MoU) with the host government expires.',
    `mou_with_government` BOOLEAN COMMENT 'Indicates whether a formal Memorandum of Understanding (MoU) is in place with the host government defining the terms of operation.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the country office, including operational context, special considerations, or historical information.',
    `ocha_cluster_participation` STRING COMMENT 'List of Office for the Coordination of Humanitarian Affairs (OCHA) humanitarian clusters in which this country office actively participates (e.g., WASH, Health, Protection, Education).',
    `office_code` STRING COMMENT 'Unique business identifier for the country office following organizational naming convention (e.g., KEN-NAI01 for Nairobi office in Kenya).. Valid values are `^[A-Z]{3}-[A-Z0-9]{3,6}$`',
    `office_name` STRING COMMENT 'Official name of the country office or sub-office (e.g., Kenya Country Office, Nairobi Sub-Office).',
    `office_type` STRING COMMENT 'Classification of the office based on its operational mandate and scope within the organizational hierarchy.. Valid values are `country_office|sub_office|field_hub|liaison_office|regional_office|emergency_response_office`',
    `operational_mandate` STRING COMMENT 'Description of the offices operational mandate, including sectors of focus (e.g., Water Sanitation and Hygiene (WASH), health, education, protection) and target populations served.',
    `operational_status` STRING COMMENT 'Current operational state of the country office indicating whether it is actively managing field operations.. Valid values are `active|inactive|suspended|transitioning|closing|planned`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the country office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the office location.',
    `security_level` STRING COMMENT 'Current security risk assessment level for the country office location, informing operational protocols and staff safety measures.. Valid values are `minimal|low|moderate|substantial|high|critical`',
    `staff_count` STRING COMMENT 'Total number of staff members (national and international) currently assigned to this country office.',
    `state_province` STRING COMMENT 'State, province, or administrative region within the host country.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the country office location (e.g., Africa/Nairobi, Asia/Damascus) for scheduling and coordination purposes.',
    CONSTRAINT pk_country_office PRIMARY KEY(`country_office_id`)
) COMMENT 'Represents a humanitarian organization country office operating under OCHA coordination frameworks. Maps to eTools country programme structure, UNDSS security management, and UNICEF/WFP/UNHCR field presence. Source systems: SAP S/4HANA (cost center), eTools (programme), UNDSS (security level).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`distribution_event` (
    `distribution_event_id` BIGINT COMMENT 'Unique identifier for the distribution event. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Distributions are often governed by specific partnership agreements defining scope, modalities, beneficiary targeting, and compliance requirements. Linking enables agreement-level expenditure tracking',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this distribution event.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Distribution events are funded and managed at the component level in NGO supply chain operations. Component-level distribution tracking is required for budget accountability, donor reporting, and comp',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: distribution_event has country_code (STRING) but no FK to the country reference table. Distribution events are country-specific operations requiring linkage to country-level operational context includ',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Distribution events (NFI, food, cash, voucher) are conducted as part of emergency response operations. The distribution_event table has sitrep_included_flag and incident_reported_flag which are emerge',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program under which this distribution event is conducted.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Distribution events are frequently implemented by partner organizations in humanitarian operations. Tracking the implementing partner is essential for accountability reporting, partner performance man',
    `project_site_id` BIGINT COMMENT 'Reference to the project site where the distribution event took place.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Distribution events must be aggregated within MEL reporting periods for donor reporting and results tracking. NGOs report distributions per period; this link enables period-level distribution performa',
    `team_id` BIGINT COMMENT 'Reference to the field team responsible for implementing this distribution event.',
    `actual_beneficiary_count` STRING COMMENT 'Actual number of beneficiaries who received assistance in this distribution event, verified through registration or biometric verification.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the distribution event concluded.',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for this distribution event, including commodity costs, logistics, and operational expenses.',
    `actual_household_count` STRING COMMENT 'Actual number of households that received assistance in this distribution event.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the distribution event commenced on the ground.',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., governorate, province, state) where the distribution event took place.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the distribution event took place.',
    `admin_level_3` STRING COMMENT 'Third-level administrative division (e.g., sub-district, municipality) where the distribution event took place.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the distribution event plan was approved by the program manager or field coordinator.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated for this distribution event, used for Budget versus Actual (BvA) reconciliation.',
    `distribution_event_code` STRING COMMENT 'Externally-known unique business identifier for the distribution event, typically formatted as country-cluster-sequence (e.g., SYR-WASH-000123).. Valid values are `^[A-Z]{3}-[A-Z]{2,4}-[0-9]{6}$`',
    `commodity_category` STRING COMMENT 'Primary category of items distributed in this event. For NFI distributions may include shelter materials, hygiene kits, blankets; for food distributions may include staple foods, fortified foods; for WASH may include water containers, purification tablets. Pipe-enum overflow candidate with 15+ standard categories.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution event record was first created in the system.',
    `cva_transfer_modality` STRING COMMENT 'Transfer modality for this distribution event: cash, voucher, in-kind, hybrid.',
    `data_collection_method` STRING COMMENT 'Tool or method used to collect field data during the distribution event: KoboToolbox, CommCare, ODK (Open Data Kit), paper form, mobile app, or tablet-based system.. Valid values are `kobo_toolbox|commcare|odk|paper_form|mobile_app|tablet`',
    `distribution_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution event location, captured via GPS or GIS system.',
    `distribution_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution event location, captured via GPS or GIS system.',
    `distribution_location_name` STRING COMMENT 'Human-readable name of the distribution location (e.g., community center, camp sector, village name).',
    `distribution_modality` STRING COMMENT 'Method of assistance delivery: in-kind (physical goods), cash (physical currency), voucher (paper/card voucher), mobile money (digital wallet), e-transfer (bank transfer), or hybrid (combination of modalities).. Valid values are `in_kind|cash|voucher|mobile_money|e_transfer|hybrid`',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the distribution event in the operational workflow. [ENUM-REF-CANDIDATE: planned|approved|in_progress|completed|cancelled|suspended|under_review — 7 candidates stripped; promote to reference product]',
    `distribution_type` STRING COMMENT 'Classification of the distribution approach: general (universal coverage), targeted (specific beneficiary criteria), blanket (entire population segment), voucher redemption (voucher exchange), emergency response (rapid onset), or seasonal (recurring planned distribution).. Valid values are `general|targeted|blanket|voucher_redemption|emergency_response|seasonal`',
    `incident_description` STRING COMMENT 'Narrative description of any incident, disruption, or complaint that occurred during the distribution event.',
    `incident_reported_flag` BOOLEAN COMMENT 'Indicates whether any security incident, operational disruption, or beneficiary complaint was reported during this distribution event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this distribution event record was last updated in the system.',
    `distribution_event_name` STRING COMMENT 'Human-readable name or title of the distribution event for reporting and communication purposes.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, observations, or context about the distribution event.',
    `pdm_completion_date` DATE COMMENT 'Date when the Post-Distribution Monitoring activity for this distribution event was completed.',
    `pdm_scheduled_flag` BOOLEAN COMMENT 'Indicates whether a Post-Distribution Monitoring activity has been scheduled for this distribution event to assess beneficiary satisfaction and assistance effectiveness.',
    `planned_beneficiary_count` STRING COMMENT 'Target number of beneficiaries planned to receive assistance in this distribution event.',
    `planned_household_count` STRING COMMENT 'Target number of households planned to receive assistance in this distribution event.',
    `scheduled_date` DATE COMMENT 'Planned date for the distribution event to take place.',
    `sitrep_included_flag` BOOLEAN COMMENT 'Indicates whether this distribution event has been included in a Situation Report (SitRep) submitted to OCHA or other coordination bodies.',
    `verification_method` STRING COMMENT 'Method used to verify beneficiary identity and eligibility at the distribution point: biometric (fingerprint/iris), token (physical token), ID card (government ID), beneficiary list (pre-registered list), household head (representative), or mobile verification (SMS/app-based).. Valid values are `biometric|token|id_card|beneficiary_list|household_head|mobile_verification`',
    CONSTRAINT pk_distribution_event PRIMARY KEY(`distribution_event_id`)
) COMMENT 'Transactional record of a single distribution event (NFI, food, cash, or voucher) conducted at a project site. Captures event date, site, distribution type (general, targeted, blanket, voucher redemption), planned vs. actual beneficiary count, commodity categories, distribution modality (in-kind, cash, voucher, mobile money), responsible cluster, implementing field team, verification method, and PDM scheduling status. Core operational transaction for field service delivery and the primary unit of work for BvA reconciliation against supply pipeline.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`distribution_line` (
    `distribution_line_id` BIGINT COMMENT 'Unique identifier for the distribution line item. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that financed this distribution line item. Enables grant-level expenditure tracking and compliance reporting.',
    `commodity_id` BIGINT COMMENT 'FK to supply.commodity for the distributed item. Present in MVM stub, carried forward for ECM completeness.',
    `distribution_event_id` BIGINT COMMENT 'Reference to the parent distribution event header. Links this line item to the overall distribution activity.',
    `registrant_id` BIGINT COMMENT 'FK to the beneficiary registrant receiving this distribution line. Present in MVM stub, carried forward for ECM completeness.',
    `warehouse_id` BIGINT COMMENT 'FK to the source warehouse from which goods were dispatched. Present in MVM stub, carried forward for ECM completeness.',
    `actual_quantity_distributed` DECIMAL(18,2) COMMENT 'The actual quantity of the item that was distributed to beneficiaries. Used for BvA (Budget versus Actual) reconciliation and MEL reporting.',
    `batch_number` STRING COMMENT 'Batch or lot number of the distributed item. Critical for traceability, quality control, and recall management, especially for food, health, and pharmaceutical items.',
    `beneficiary_count` STRING COMMENT 'Number of individual beneficiaries or households who received this specific item in this distribution line. Supports disaggregated MEL reporting.',
    `cluster_sector` STRING COMMENT 'OCHA humanitarian cluster or sector to which this distribution line item is attributed (e.g., Food Security, WASH, Shelter, Health, Protection).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution line record was first created in the system. Supports audit trail and data lineage.',
    `cva_transfer_modality` STRING COMMENT 'Transfer modality for this distribution line: cash, voucher, in-kind, hybrid.',
    `delivery_confirmation_date` DATE COMMENT 'Date the beneficiary confirmed receipt. Present in MVM stub, carried forward for ECM completeness.',
    `distribution_method` STRING COMMENT 'The method or modality used to distribute this item (e.g., direct hand distribution, voucher redemption, cash transfer for purchase, mobile distribution unit, fixed distribution site).. Valid values are `direct_hand|voucher|cash_transfer|mobile_distribution|fixed_site`',
    `distribution_status` STRING COMMENT 'Current status of this distribution line item within the distribution event lifecycle.. Valid values are `planned|in_progress|completed|cancelled|partially_distributed`',
    `donor_earmark` STRING COMMENT 'Identifier or name of the donor whose funds were earmarked for this specific item distribution. Supports restricted fund accounting and donor reporting.',
    `expiry_date` DATE COMMENT 'Expiration or best-before date of the distributed item. Relevant for perishable goods, food, medicines, and time-sensitive NFIs.',
    `iati_transaction_type` STRING COMMENT 'IATI-compliant transaction type code for this distribution line, supporting international aid transparency and reporting.',
    `item_category` STRING COMMENT 'High-level category of the distributed item. NFI = Non-Food Item, WASH = Water Sanitation and Hygiene.. Valid values are `NFI|Food|WASH|Shelter|Health|Education`',
    `item_code` STRING COMMENT 'Standardized code identifying the specific commodity or NFI item. May align with supply chain master item codes or donor-specific item catalogs.',
    `item_description` STRING COMMENT 'Detailed textual description of the distributed item including specifications, brand, quality grade, or other distinguishing characteristics.',
    `line_number` STRING COMMENT 'Sequential line number within the distribution event. Used for ordering and referencing specific items within the distribution.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this distribution line record. Supports accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution line record was last modified. Supports audit trail and change tracking.',
    `mvm_migration_reference` STRING COMMENT 'Reference code linking this record to the legacy MVM distribution_line stub for migration traceability.',
    `notes` STRING COMMENT 'Free-text field for additional contextual information, special instructions, or observations related to this distribution line item.',
    `pipeline_source` STRING COMMENT 'Identifier of the supply pipeline or procurement source from which the item was drawn (e.g., central warehouse, local procurement, in-kind donation, CERF allocation).',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of the item that was planned or targeted for distribution in this line item, as per the distribution plan or LogFrame target.',
    `quality_check_date` DATE COMMENT 'Date when the quality inspection was performed on this distribution line item.',
    `quality_check_status` STRING COMMENT 'Result of quality inspection performed on this item batch before or during distribution. Ensures compliance with SPHERE and CHS standards.. Valid values are `passed|failed|not_checked|conditional`',
    `rejection_reason` STRING COMMENT 'Reason for partial/full rejection of distributed items. Present in MVM stub, carried forward for ECM completeness.',
    `sdg_alignment` STRING COMMENT 'Reference to the UN Sustainable Development Goal(s) that this distribution line item contributes to (e.g., SDG 2: Zero Hunger, SDG 6: Clean Water and Sanitation).',
    `substitution_flag` BOOLEAN COMMENT 'Whether this line represents a substituted commodity. Present in MVM stub, carried forward for ECM completeness.',
    `total_value` DECIMAL(18,2) COMMENT 'The total monetary value of this distribution line (typically unit_value × actual_quantity_distributed). Supports financial reconciliation and grant expenditure tracking.',
    `unit_of_measure` STRING COMMENT 'The unit in which the item quantity is measured (e.g., pieces, kilograms, liters, boxes, kits, households).',
    `unit_value` DECIMAL(18,2) COMMENT 'The monetary value per unit of the distributed item. Used for financial tracking and donor reporting.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between planned_quantity and actual_quantity_distributed. Positive values indicate over-distribution, negative values indicate under-distribution. Used for BvA analysis.',
    `variance_reason` STRING COMMENT 'Explanation for any significant variance between planned and actual quantities. Supports accountability and learning in MEL processes.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this distribution line record. Supports accountability and audit trail.',
    CONSTRAINT pk_distribution_line PRIMARY KEY(`distribution_line_id`)
) COMMENT 'ECM-canonical distribution line item entity. Supersedes the MVM-tier stub distribution_line and is a strict superset of its attributes. Source systems: SAP/ICON procurement, VISION, eTools, WFP LESS/COMET, SCOPE. Tracks individual line items within a distribution event including commodity, quantity, value, and beneficiary counts.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`assessment` (
    `assessment_id` BIGINT COMMENT 'Unique identifier for the field assessment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: HACT field assessments, PDM assessments, and post-distribution monitoring are mandated by specific partnership agreements. Field monitoring officers must link each assessment to the governing agreemen',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Assessments (needs, baseline, endline, PDM) are typically award-funded activities requiring donor reporting and cost tracking. Critical for MEL frameworks, donor compliance, and linking assessment fin',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Assessments are conducted within the scope of specific program components (e.g., WASH component needs assessment). Component-level assessment tracking is required for component performance reporting t',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Assessments are conducted within the operational scope of a country office. While assessment already links to project_site (and project_site links to country_office), some assessments may be country-o',
    `distribution_event_id` BIGINT COMMENT 'Reference to the distribution event being monitored. Applicable for Post-Distribution Monitoring (PDM) assessments only.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Assessments — particularly rapid assessments and needs assessments — are triggered by and conducted in response to declared humanitarian emergencies. Linking assessment to emergency enables emergency-',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Assessments (baseline, endline, needs) directly measure indicator progress. Nonprofit M&E requires linking assessment findings to specific indicators for results reporting and donor compliance. No exi',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Assessments (needs assessments, PDM, post-distribution monitoring) inform intervention design, measure intervention effectiveness, and provide evidence for program amendments. While some assessments l',
    `logframe_row_id` BIGINT COMMENT 'Foreign key linking to program.logframe_row. Business justification: Assessments provide evidence for specific logframe results in NGO M&E. Linking assessments to logframe rows enables direct data flow from field evidence to results reporting, required for donor M&E fr',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Assessments are activities mandated by and defined within a MEAL plan. Linking assessment to meal_plan enables tracking which assessments fulfill MEAL plan requirements — essential for MEAL plan compl',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Assessments (needs assessments, PDM, evaluations) are frequently conducted by or jointly with partner organizations. Tracking the partner assessor enables data quality control, capacity building plann',
    `project_site_id` BIGINT COMMENT 'Reference to the project site where this assessment was conducted.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Assessments are planned and conducted within specific MEL reporting periods. This link enables scheduling, aggregating, and reporting assessments per MEL calendar period — a core MEL operational plann',
    `team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Assessments are conducted by field teams. The assessment table has a team_size attribute (assessment-specific headcount) but no FK to the field_team entity. Adding field_team_id enables traceability o',
    `adequacy_score` DECIMAL(18,2) COMMENT 'For PDM assessments: score representing beneficiary assessment of whether the distributed items met their needs in terms of quantity, quality, and timeliness. Typically on a scale of 1-5 or 1-10.',
    `assessment_date` DATE COMMENT 'The date when the field assessment was conducted or initiated. Principal business event timestamp for this assessment.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment. Tracks progression from planning through validation.. Valid values are `planned|in_progress|completed|validated|cancelled`',
    `assessment_type` STRING COMMENT 'Classification of the assessment methodology. FGD (Focus Group Discussion), KII (Key Informant Interview), PDM (Post-Distribution Monitoring), MUAC (Mid-Upper Arm Circumference) screening for malnutrition. [ENUM-REF-CANDIDATE: FGD|KII|household_survey|rapid_needs_assessment|PDM|market_assessment|MUAC_screening|baseline_assessment|endline_assessment|midterm_review — 10 candidates stripped; promote to reference product]',
    `beneficiary_satisfaction_score` DECIMAL(18,2) COMMENT 'Overall satisfaction rating provided by beneficiaries regarding the program or distribution. Supports Accountability to Affected Populations (AAP) and CHS compliance.',
    `cluster_coordination_body` STRING COMMENT 'The OCHA cluster or sector coordination group to which this assessment is reported (e.g., WASH Cluster, Health Cluster, Food Security Cluster).',
    `assessment_code` STRING COMMENT 'Externally-known unique business identifier for the assessment, used in reporting and coordination with partners.. Valid values are `^[A-Z0-9]{6,20}$`',
    `complaints_received_count` STRING COMMENT 'Number of complaints or grievances raised by beneficiaries during the assessment. Critical for accountability and feedback mechanisms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this assessment record was first created in the system.',
    `data_collection_tool` STRING COMMENT 'The digital or physical tool used to capture assessment data in the field. [ENUM-REF-CANDIDATE: KoboToolbox|CommCare|ODK|paper_form|mobile_app|DHIS2|other — 7 candidates stripped; promote to reference product]',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Internal quality score assessing completeness, accuracy, and reliability of the assessment data. Used for MEL quality control.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this assessment is designated for inclusion in donor reports and external visibility materials.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the assessment fieldwork was completed.',
    `geographic_scope` STRING COMMENT 'The geographic coverage level of the assessment.. Valid values are `single_site|multi_site|district|region|national`',
    `key_findings_summary` STRING COMMENT 'Executive summary of the main findings, insights, and observations from the assessment. Used for SitRep generation and donor reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this assessment record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the primary assessment location. Supports GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the primary assessment location. Supports GIS mapping and spatial analysis.',
    `mel_indicator_linked` BOOLEAN COMMENT 'Flag indicating whether this assessment is linked to specific MEL indicators in the logical framework (LogFrame) or results framework.',
    `methodology` STRING COMMENT 'The research methodology employed for data collection and analysis.. Valid values are `qualitative|quantitative|mixed_methods|participatory|rapid_appraisal`',
    `assessment_name` STRING COMMENT 'Human-readable name or title of the assessment, describing its purpose and scope.',
    `notes` STRING COMMENT 'Additional contextual notes, observations, or operational details about the assessment not captured in structured fields.',
    `protection_concerns_description` STRING COMMENT 'Detailed description of any protection concerns identified, including nature of risk and affected population. Confidential to ensure beneficiary safety.',
    `protection_concerns_noted` BOOLEAN COMMENT 'Flag indicating whether any protection concerns (GBV, child protection, safety risks) were identified during the assessment. Triggers referral protocols.',
    `recommendations` STRING COMMENT 'Actionable recommendations derived from the assessment findings for program adjustments, response planning, or advocacy.',
    `report_url` STRING COMMENT 'Link to the full assessment report document stored in the document management system or shared drive.',
    `sample_methodology` STRING COMMENT 'The sampling approach used to select assessment participants. Particularly important for PDM assessments to ensure representativeness.. Valid values are `random|stratified|cluster|purposive|convenience|census`',
    `sample_size` STRING COMMENT 'The number of individuals, households, or units included in the assessment sample.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the assessment fieldwork began.',
    `target_population` STRING COMMENT 'Description of the population segment or beneficiary group targeted by this assessment (e.g., IDPs, host community, women-headed households, children under 5).',
    `team_size` STRING COMMENT 'Number of enumerators, facilitators, or team members who participated in conducting the assessment.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'For PDM assessments: percentage of beneficiaries who reported using the distributed items as intended. Key indicator of program effectiveness.',
    `validated_by` STRING COMMENT 'Name or identifier of the staff member who validated the assessment data and findings.',
    `validation_date` DATE COMMENT 'Date when the assessment data was validated and approved by the MEL team or program management.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Field assessment capturing multi-sector data collection activities at project sites, including methodology, sample size, key findings, and protection concerns. Sourced from Kobo Toolbox, ODK, or field team submissions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`assessment_response` (
    `assessment_response_id` BIGINT COMMENT 'Unique identifier for the assessment response record. Primary key for individual survey or interview responses collected during field assessments.',
    `assessment_id` BIGINT COMMENT 'Reference to the assessment form or questionnaire template used for this response. Links to the specific KoboToolbox or CommCare form definition.',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Assessment responses are collected using specific data collection tools (KoBoToolbox, ODK, etc.). Linking assessment_response to data_collection_tool enables data quality tracking by tool version and ',
    `household_id` BIGINT COMMENT 'Foreign key linking to beneficiary.household. Business justification: Household-level assessments link responses to household units. Standard for food security assessments, household economy analysis, and vulnerability assessments. Enables household-level analysis of ne',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: PDM and assessment surveys collect individual beneficiary responses. Required for beneficiary satisfaction tracking, accountability to affected populations (AAP), and individual-level feedback analysi',
    `project_site_id` BIGINT COMMENT 'Reference to the project site or field location where the assessment was conducted. Links to geographic and operational site master data.',
    `children_under_5_count` STRING COMMENT 'Number of children under 5 years of age in the household. Critical for nutrition, health, and protection program targeting.',
    `chronic_illness_flag` BOOLEAN COMMENT 'Indicator that one or more household members have a chronic illness requiring ongoing medical care. Informs health service delivery planning.',
    `consent_data_sharing` BOOLEAN COMMENT 'Indicator that the respondent has provided informed consent for their data to be shared with partner organizations for service delivery purposes.',
    `consent_follow_up` BOOLEAN COMMENT 'Indicator that the respondent has consented to be contacted for follow-up assessments or post-distribution monitoring activities.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assessment response record was first created in the data warehouse. Used for data lineage and audit trail.',
    `data_collection_method` STRING COMMENT 'Method used to collect the assessment response data. Distinguishes between face-to-face interviews, phone surveys, and other modalities.. Valid values are `face_to_face|phone|remote_digital|focus_group|key_informant`',
    `debt_burden_flag` BOOLEAN COMMENT 'Indicator that the household is experiencing significant debt burden affecting their ability to meet basic needs. Used for economic vulnerability profiling.',
    `disability_present_flag` BOOLEAN COMMENT 'Indicator that one or more household members have a disability. Used for inclusive programming and accessibility considerations.',
    `displacement_duration_months` STRING COMMENT 'Number of months the household has been displaced from their place of origin. Indicates protractedness of displacement and informs durable solutions programming.',
    `displacement_status` STRING COMMENT 'Classification of the respondent household displacement situation. Critical for targeting humanitarian assistance and understanding population movements.. Valid values are `host_community|idp|refugee|returnee|asylum_seeker|stateless`',
    `education_access_flag` BOOLEAN COMMENT 'Indicator that school-age children in the household have access to education services. Monitors education in emergencies programming effectiveness.',
    `elderly_over_60_count` STRING COMMENT 'Number of elderly individuals over 60 years of age in the household. Used for vulnerability assessment and targeted assistance programs.',
    `female_count` STRING COMMENT 'Number of female individuals in the household. Enables sex-disaggregated analysis as required by humanitarian accountability standards.',
    `food_security_score` DECIMAL(18,2) COMMENT 'Calculated food security index based on household consumption patterns and coping strategies. Higher scores indicate greater food insecurity.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy radius of the GPS coordinates in meters. Indicates the precision and reliability of the location data captured during submission.',
    `household_size` STRING COMMENT 'Total number of individuals in the respondent household. Key demographic indicator for needs assessment and resource allocation calculations.',
    `interview_duration_minutes` STRING COMMENT 'Total time in minutes taken to complete the assessment interview. Used for quality control and enumerator performance monitoring.',
    `interview_language` STRING COMMENT 'Language in which the assessment interview was conducted. Important for data quality assessment and ensuring linguistic accessibility.',
    `livelihood_status` STRING COMMENT 'Current employment and income generation status of the household. Critical for economic recovery and livelihoods programming.. Valid values are `employed|unemployed|self_employed|casual_labor|no_income`',
    `male_count` STRING COMMENT 'Number of male individuals in the household. Enables sex-disaggregated analysis as required by humanitarian accountability standards.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this assessment response record was last modified. Tracks data quality corrections and validation updates.',
    `monthly_income_usd` DECIMAL(18,2) COMMENT 'Estimated total monthly household income in United States Dollars. Used for economic vulnerability assessment and cash transfer program targeting.',
    `primary_need_category` STRING COMMENT 'The most urgent need identified by the respondent household. Used for prioritization and resource allocation in humanitarian response. [ENUM-REF-CANDIDATE: food|water|shelter|health|protection|education|nfi|wash|livelihoods|psychosocial — promote to reference product]. Valid values are `food|water|shelter|health|protection|education`',
    `protection_concern_flag` BOOLEAN COMMENT 'Indicator that the household has reported protection concerns requiring specialized follow-up. Triggers referral to protection case management services.',
    `protection_concern_type` STRING COMMENT 'Classification of the protection concern reported. Highly sensitive field requiring strict confidentiality and ethical data handling protocols.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicator that the assessment identified needs requiring referral to specialized services such as protection, health, or case management.',
    `response_status` STRING COMMENT 'Current lifecycle status of the assessment response indicating data quality validation state and approval workflow position.. Valid values are `submitted|validated|rejected|pending_review|approved|flagged`',
    `shelter_condition` STRING COMMENT 'Assessment of the physical condition and habitability of the household shelter. Used for prioritizing shelter repair and upgrade interventions.. Valid values are `good|fair|poor|critical`',
    `shelter_type` STRING COMMENT 'Classification of the household current shelter arrangement. Critical for shelter and NFI (Non-Food Item) programming and vulnerability assessment.. Valid values are `permanent|temporary|tent|collective_center|makeshift|open_air`',
    `submission_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate captured at the time and location of survey submission. Used for spatial analysis and verification of field coverage.',
    `submission_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate captured at the time and location of survey submission. Used for spatial analysis and verification of field coverage.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the assessment response was submitted by the enumerator. Represents the principal business event time for this transaction.',
    `validation_notes` STRING COMMENT 'Free-text notes from data validation and quality assurance review. Documents any data quality issues, corrections, or contextual information.',
    `water_access_minutes` STRING COMMENT 'Time in minutes required for household members to access safe drinking water. Key WASH (Water Sanitation and Hygiene) indicator for service delivery monitoring.',
    CONSTRAINT pk_assessment_response PRIMARY KEY(`assessment_response_id`)
) COMMENT 'Individual survey or interview response record collected during a field assessment, sourced from KoboToolbox or CommCare mobile data collection. Captures respondent anonymized ID, assessment form ID, submission timestamp, GPS coordinates of submission, enumerator ID, response status (submitted, validated, rejected), and key structured response fields (household size, displacement status, primary needs, protection concerns). Enables disaggregated analysis by sex, age, IDP status, and vulnerability category.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`sitrep` (
    `sitrep_id` BIGINT COMMENT 'Unique identifier for the situation report record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Sitreps are frequently produced as a contractual reporting obligation under a specific partnership agreement. Program managers need to link sitreps to the governing agreement to track reporting compli',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Situation reports are produced as deliverables under specific awards. The donor_submission_required flag on sitrep requires knowing which awards donor to submit to. Award-level sitrep tracking is ess',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: sitrep has country_iso3_code (STRING) but no FK to the country reference table. Situation reports are country-specific operational summaries requiring linkage to authoritative country data including h',
    `country_office_id` BIGINT COMMENT 'Reference to the country office issuing this situation report.',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Sitreps report on distribution activities against planned targets. Linking sitrep to distribution_plan enables plan-vs-actual reporting, progress tracking against planned beneficiary counts, and donor',
    `emergency_id` BIGINT COMMENT 'Reference to the crisis or emergency context this situation report addresses.',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Situation reports document operational progress and constraints for specific program interventions. Donors and cluster leads require sitreps to show intervention-level implementation status, beneficia',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Situation reports often consolidate partner-implemented activities for cluster coordination and donor reporting. Linking enables tracking partner contributions to overall response, supports 3W reporti',
    `project_site_id` BIGINT COMMENT 'Reference to the primary project site or field location covered by this report.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Sitreps are published on a defined MEL reporting cycle. Linking sitrep to reporting_period enables alignment of situation report publication with the MEL calendar — a standard NGO donor reporting and ',
    `team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Situation Reports (SitReps) are authored and submitted by field teams. The field_team table has a last_sitrep_date attribute confirming this operational relationship. Adding field_team_id to sitrep en',
    `access_impediments_count` STRING COMMENT 'Number of access impediments or incidents that restricted humanitarian operations during the reporting period.',
    `admin_level_1_name` STRING COMMENT 'Name of the first-level administrative division (province, state, region) covered by this report.',
    `admin_level_2_name` STRING COMMENT 'Name of the second-level administrative division (district, county) covered by this report.',
    `cerf_application_status` STRING COMMENT 'Status of any CERF funding application related to operations covered by this report.. Valid values are `not_applicable|planned|submitted|approved|rejected`',
    `cluster_coordination_updates` STRING COMMENT 'Summary of cluster coordination activities, inter-agency meetings, and coordination outcomes during the reporting period.',
    `cluster_lead_agency` STRING COMMENT 'Name of the lead agency for the primary cluster or sector covered by this report.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this situation report record was first created in the system.',
    `crisis_context_summary` STRING COMMENT 'Brief narrative summary of the emergency or crisis context, including key developments during the reporting period.',
    `data_collection_method` STRING COMMENT 'Description of the primary data collection methods used to compile this report (e.g., KoboToolbox surveys, FGD, KII, mobile data collection, field assessments).',
    `donor_submission_required` BOOLEAN COMMENT 'Indicates whether this situation report is required to be submitted to donors as part of grant reporting obligations.',
    `education_beneficiaries_reached` STRING COMMENT 'Number of children and youth reached through education programs during the reporting period.',
    `food_distributions_completed` STRING COMMENT 'Number of food distribution events completed during the reporting period.',
    `funding_gap_usd` DECIMAL(18,2) COMMENT 'Estimated funding gap in US dollars for operations covered by this report.',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of this situation report (national, regional, district, camp, site, multi-country).. Valid values are `national|regional|district|camp|site|multi-country`',
    `health_consultations_completed` STRING COMMENT 'Number of health consultations or medical encounters completed during the reporting period.',
    `hrp_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of Humanitarian Response Plan targets achieved as of the end of the reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this situation report record was last modified.',
    `nfi_distributions_completed` STRING COMMENT 'Number of non-food item distribution events completed during the reporting period.',
    `nfi_kits_distributed` STRING COMMENT 'Total number of NFI kits or packages distributed during the reporting period.',
    `ocha_submission_required` BOOLEAN COMMENT 'Indicates whether this situation report is required to be submitted to OCHA for coordination purposes.',
    `operational_constraints` STRING COMMENT 'Narrative description of operational constraints, access issues, security incidents, or logistical challenges encountered during the reporting period.',
    `protection_cases_registered` STRING COMMENT 'Number of new protection cases registered during the reporting period, including GBV, child protection, and other protection concerns.',
    `publication_date` DATE COMMENT 'Date when the situation report was officially published or released.',
    `report_number` STRING COMMENT 'Externally-known unique identifier for this situation report, typically following organizational numbering convention.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,4}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the situation report (draft, under review, approved, submitted to OCHA/donors, published, archived).. Valid values are `draft|under_review|approved|submitted|published|archived`',
    `report_title` STRING COMMENT 'Descriptive title of the situation report, typically including crisis name and reporting period.',
    `reporting_frequency` STRING COMMENT 'Frequency at which this situation report is issued (daily, weekly, bi-weekly, monthly, ad-hoc for special events, flash for immediate crisis updates).. Valid values are `daily|weekly|bi-weekly|monthly|ad-hoc|flash`',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this situation report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this situation report.',
    `resource_gaps_summary` STRING COMMENT 'Narrative description of critical resource gaps, funding shortfalls, or supply needs identified during the reporting period.',
    `security_incidents_count` STRING COMMENT 'Number of security incidents affecting staff, operations, or beneficiaries during the reporting period.',
    `shelter_units_provided` STRING COMMENT 'Number of shelter units (tents, transitional shelters, housing units) provided during the reporting period.',
    `submission_date` DATE COMMENT 'Date when the situation report was submitted to OCHA, donors, or coordination bodies.',
    `total_beneficiaries_reached` STRING COMMENT 'Total number of unique beneficiaries reached across all sectors during the reporting period.',
    `wash_beneficiaries_reached` STRING COMMENT 'Number of beneficiaries reached through WASH interventions during the reporting period.',
    CONSTRAINT pk_sitrep PRIMARY KEY(`sitrep_id`)
) COMMENT 'Situation Report (SitRep) following OCHA reporting standards for humanitarian operations. Captures cluster-level response metrics, beneficiary reach, funding gaps, and operational constraints. Feeds into HRP progress tracking and donor reporting. Source systems: eTools, OCHA reporting templates, ReliefWeb.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the field team or mobile unit. Primary key.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office or field office to which this team is administratively assigned.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Field teams are deployed specifically in response to declared humanitarian emergencies. The field_team table has deployment_start_date and deployment_end_date attributes that align with emergency resp',
    `funding_source_id` BIGINT COMMENT 'Reference to the grant or funding source that finances this teams operations.',
    `partner_org_id` BIGINT COMMENT 'Reference to a partner organization (CBO, CSO, INGO) if this team operates under a partnership or consortium arrangement.',
    `project_site_id` BIGINT COMMENT 'Reference to the project site or field office serving as the teams operational base or home location.',
    `activities_completed_count` STRING COMMENT 'Total number of field activities, distributions, assessments, or service delivery events completed by this team.',
    `beneficiaries_served_count` STRING COMMENT 'Cumulative number of unique beneficiaries or PoC (Persons of Concern) served by this team since deployment start.',
    `budget_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the monthly operational budget (e.g., USD, EUR, GBP).',
    `cluster_affiliation` STRING COMMENT 'OCHA (Office for the Coordination of Humanitarian Affairs) cluster or sector to which this teams activities are aligned for coordination purposes. [ENUM-REF-CANDIDATE: health|nutrition|wash|shelter|protection|education|logistics|food_security|early_recovery|camp_coordination|emergency_telecommunications — 11 candidates stripped; promote to reference product]',
    `team_code` STRING COMMENT 'Short alphanumeric code used for operational identification and reporting (e.g., DT-001, MHU-03, WASH-A).. Valid values are `^[A-Z0-9]{3,12}$`',
    `communication_equipment` STRING COMMENT 'Description of communication equipment assigned to the team (e.g., satellite phones, radios, mobile devices, GPS units) to maintain contact with coordination centers and ensure safety.',
    `coverage_area_description` STRING COMMENT 'Textual description of the geographic area or communities covered by this team (e.g., Northern District villages, IDP (Internally Displaced Person) camps in Region 3).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was first created in the system.',
    `deployment_end_date` DATE COMMENT 'Planned or actual date when the team deployment concluded or is scheduled to conclude. Null for ongoing deployments.',
    `deployment_start_date` DATE COMMENT 'Date when the team was first deployed or became operational.',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency contact person for this team (typically a field coordinator or security officer).',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the primary emergency contact for this team, used for urgent communication and security incidents.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether GPS tracking is enabled for this teams movements and field activities for safety monitoring and activity verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was most recently updated.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or evaluation conducted for this team.',
    `last_sitrep_date` DATE COMMENT 'Date when the team last submitted a SitRep (Situation Report) to the coordination center or country office.',
    `mobile_data_collection_platform` STRING COMMENT 'Name of the mobile data collection tool or platform used by this team (e.g., KoboToolbox, CommCare, ODK, DHIS2 mobile).',
    `monthly_operational_budget` DECIMAL(18,2) COMMENT 'Planned monthly operational budget allocated for this teams activities, including salaries, transport, supplies, and per diems.',
    `team_name` STRING COMMENT 'Human-readable name or designation of the field team (e.g., Delta Distribution Team, Mobile Health Unit 3, WASH Response Team Alpha).',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special considerations, or context about the teams deployment and activities.',
    `operational_status` STRING COMMENT 'Current operational state of the team. Active: currently deployed and operational; Standby: ready for deployment; Deployed: in field assignment; Resting: between deployments; Disbanded: team dissolved; Suspended: temporarily inactive.. Valid values are `active|standby|deployed|resting|disbanded|suspended`',
    `performance_rating` STRING COMMENT 'Most recent performance assessment rating for the team based on MEL (Monitoring Evaluation and Learning) indicators, service delivery quality, and beneficiary feedback.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary language spoken by the team for beneficiary communication (e.g., ENG for English, ARA for Arabic, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `safety_clearance_level` STRING COMMENT 'Security risk level classification for the teams operational area, aligned with UN security phase system. Determines safety protocols and movement restrictions.. Valid values are `minimal|low|moderate|substantial|severe|critical`',
    `size` STRING COMMENT 'Total number of staff and volunteers currently assigned to this team.',
    `team_type` STRING COMMENT 'Classification of the team based on its primary operational function. Distribution teams handle NFI (Non-Food Item) distributions; CHW (Community Health Worker) teams provide mobile health outreach; WASH (Water Sanitation and Hygiene) teams deliver water and sanitation interventions; assessment teams conduct FGD (Focus Group Discussion) and KII (Key Informant Interview); protection teams address GBV (Gender-Based Violence) and child protection; rapid response teams handle emergency deployments; nutrition teams manage SAM (Severe Acute Malnutrition) and GAM (Global Acute Malnutrition) programs; education teams deliver learning programs; shelter teams provide housing assistance; logistics teams manage supply chain and transport. [ENUM-REF-CANDIDATE: distribution|community_health_worker|wash|assessment|protection|rapid_response|nutrition|education|shelter|logistics — 10 candidates stripped; promote to reference product]',
    `training_certifications` STRING COMMENT 'Comma-separated list of key training certifications held by team members (e.g., SPHERE, CHS, PSS (Psychosocial Support), GBV Response, First Aid).',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'SSOT for field operations teams deployed to project sites for humanitarian response, including staff-led teams with security clearances, equipment, and operational budgets. Distinct from volunteer.volunteer_team which manages volunteer-led community teams.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`security_incident` (
    `security_incident_id` BIGINT COMMENT 'Unique identifier for the security incident record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Security incidents affecting award implementation trigger donor notification requirements, force majeure clauses, and no-cost extension requests. Linking incidents to awards enables award-level incide',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: security_incident has country_code (STRING) but no FK to the country reference table. Security incidents are country-specific events requiring linkage to authoritative country data including security_',
    `country_office_id` BIGINT COMMENT 'Reference to the country office under whose jurisdiction the security incident occurred.',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Security incidents occur within the operational context of declared humanitarian emergencies. Linking security_incident to emergency enables emergency-level security analysis, supports UNDSS Security ',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which the affected staff or activities were operating at the time of the security incident, if applicable.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Security incidents involving partner staff or assets must be tracked by partner organization for duty of care obligations, insurance claims, risk register updates, and partner capacity assessment. Cri',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the security incident occurred, if applicable.',
    `team_id` BIGINT COMMENT 'Foreign key linking to field.field_team. Business justification: Security incidents directly affect field teams deployed in the area. The security_incident table tracks affected_personnel_count and staff_fatality_count which are field team personnel metrics. Linkin',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the incident occurred.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the incident occurred.',
    `affected_personnel_count` STRING COMMENT 'Total number of NGO staff, volunteers, or contractors directly affected by the security incident (injured, detained, threatened, or otherwise impacted).',
    `asset_damage_description` STRING COMMENT 'Narrative description of damage to organizational assets (vehicles, equipment, facilities, supplies) resulting from the security incident.',
    `case_closed_date` DATE COMMENT 'Date when the security incident case was formally closed after investigation and resolution (yyyy-MM-dd format).',
    `corrective_actions_taken` STRING COMMENT 'Description of corrective or preventive actions implemented following the security incident to mitigate future risk (e.g., enhanced security protocols, staff training, route changes).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the security incident record was first created in the database (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `data_source_system` STRING COMMENT 'Name of the operational system or platform from which the security incident record was sourced (e.g., security management system, field data collection tool).',
    `estimated_asset_loss_usd` DECIMAL(18,2) COMMENT 'Estimated monetary value of asset damage or loss in United States Dollars (USD) resulting from the security incident.',
    `immediate_response_actions` STRING COMMENT 'Description of immediate actions taken by field staff or security personnel in response to the security incident (e.g., evacuation, medical assistance, notification of authorities, lockdown).',
    `incident_date` DATE COMMENT 'Date when the security incident occurred in the field (yyyy-MM-dd format).',
    `incident_description` STRING COMMENT 'Detailed narrative description of the security incident, including sequence of events, circumstances, and context.',
    `incident_location_name` STRING COMMENT 'Descriptive name or address of the specific location where the security incident occurred (e.g., village name, road name, facility name).',
    `incident_number` STRING COMMENT 'Externally-known unique incident reference number assigned by security management system, following format SI-YYYY-NNNNNN.. Valid values are `^SI-[0-9]{4}-[0-9]{6}$`',
    `incident_severity` STRING COMMENT 'Severity classification of the security incident based on impact to personnel, assets, and operations. Critical = life-threatening or major asset loss; Major = serious injury or significant damage; Moderate = minor injury or moderate damage; Minor = no injury, minimal damage.. Valid values are `critical|major|moderate|minor`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the security incident case in the investigation and resolution workflow.. Valid values are `reported|under_investigation|escalated|resolved|closed`',
    `incident_time` TIMESTAMP COMMENT 'Precise date and time when the security incident occurred, in local time zone (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `incident_type` STRING COMMENT 'Classification of the security incident by nature of threat or event. [ENUM-REF-CANDIDATE: armed_robbery|carjacking|kidnapping|staff_detention|explosive_hazard|civil_unrest|armed_conflict|theft|burglary|assault|sexual_violence|harassment|vehicle_accident|fire|natural_disaster|health_emergency|other — promote to reference product]',
    `inso_report_date` DATE COMMENT 'Date when the security incident was reported to INSO, if applicable (yyyy-MM-dd format).',
    `investigation_findings` STRING COMMENT 'Summary of findings from the security incident investigation, including root causes, contributing factors, and lessons learned.',
    `investigation_status` STRING COMMENT 'Current status of the internal or external investigation into the security incident.. Valid values are `not_started|in_progress|completed|suspended`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the incident location in decimal degrees (WGS84 datum).',
    `local_authorities_report_date` DATE COMMENT 'Date when the security incident was reported to local authorities, if applicable (yyyy-MM-dd format).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the incident location in decimal degrees (WGS84 datum).',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the security incident record was last modified or updated (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `pcode` STRING COMMENT 'OCHA-standardized place code (P-Code) uniquely identifying the administrative location of the incident for humanitarian coordination.',
    `police_case_number` STRING COMMENT 'Official case or reference number assigned by local law enforcement authorities for the security incident, if reported.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the security incident was first reported to the organizations security management system (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `reported_to_inso` BOOLEAN COMMENT 'Indicates whether the security incident was formally reported to the International NGO Safety Organisation (INSO) for coordination and information sharing among NGOs.',
    `reported_to_local_authorities` BOOLEAN COMMENT 'Indicates whether the security incident was reported to local law enforcement or government authorities.',
    `reported_to_undss` BOOLEAN COMMENT 'Indicates whether the security incident was formally reported to the United Nations Department of Safety and Security (UNDSS) for coordination and situational awareness.',
    `sitrep_included` BOOLEAN COMMENT 'Indicates whether the security incident was included in a formal Situation Report (SitRep) distributed to stakeholders, donors, or coordination bodies.',
    `staff_fatality_count` STRING COMMENT 'Number of staff members who died as a result of the security incident.',
    `staff_injured_count` STRING COMMENT 'Number of staff members who sustained physical injuries as a result of the security incident.',
    `undss_report_date` DATE COMMENT 'Date when the security incident was reported to UNDSS, if applicable (yyyy-MM-dd format).',
    CONSTRAINT pk_security_incident PRIMARY KEY(`security_incident_id`)
) COMMENT 'Records security incidents affecting humanitarian operations per UNDSS Security Level System (SLS) and INSO reporting standards. Tracks staff safety events, asset losses, and coordination with UNDSS/INSO. Supports Aid Worker Security Database (AWSD) reporting. Source systems: UNDSS SSIRS, INSO, internal security management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`country` (
    `country_id` BIGINT COMMENT 'Primary key for country',
    `parent_country_id` BIGINT COMMENT 'Self-referencing FK on country (parent_country_id)',
    `access_constraints` STRING COMMENT 'Primary type of access constraints affecting humanitarian operations in the country. Used for operational planning and risk mitigation.',
    `active_clusters` STRING COMMENT 'Comma-separated list of active humanitarian clusters in the country (e.g., WASH, Health, Nutrition, Shelter, Protection). Used for coordination and reporting alignment.',
    `capital_city` STRING COMMENT 'Name of the capital city of the country. Often the location of the country office headquarters.',
    `cluster_coordination_active` BOOLEAN COMMENT 'Indicates whether the OCHA cluster coordination system is active in this country. Affects reporting obligations and inter-agency coordination requirements.',
    `country_code` STRING COMMENT 'Standardized code representing the country classification or category.',
    `code_alpha2` STRING COMMENT 'Two-letter country code as defined by ISO 3166-1 alpha-2 standard. Used for international identification and data exchange.',
    `code_alpha3` STRING COMMENT 'Three-letter country code as defined by ISO 3166-1 alpha-3 standard. Commonly used in humanitarian reporting and OCHA coordination.',
    `code_numeric` STRING COMMENT 'Three-digit numeric country code as defined by ISO 3166-1 numeric standard.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this country record was first created in the system. Used for audit trail and data lineage.',
    `customs_procedures` STRING COMMENT 'Summary of customs clearance procedures and requirements for importing humanitarian supplies. Critical for supply chain and logistics planning.',
    `emergency_declared_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the emergency declared condition applies.',
    `fragility_status` STRING COMMENT 'Classification of the countrys fragility and conflict status. Critical for risk assessment, security planning, and humanitarian response prioritization.',
    `gis_data_available` BOOLEAN COMMENT 'Indicates whether comprehensive GIS data layers (administrative boundaries, roads, facilities) are available for this country to support location-based analysis.',
    `government_partnership_status` STRING COMMENT 'Level of partnership and collaboration with the national government. Affects program implementation modalities and coordination mechanisms.',
    `humanitarian_context_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the humanitarian context condition applies.',
    `humanitarian_response_plan_active` BOOLEAN COMMENT 'Indicates whether an active Humanitarian Response Plan coordinated by OCHA exists for this country. Used to determine cluster coordination requirements and reporting obligations.',
    `income_classification` STRING COMMENT 'World Bank income classification category for the country. Used for program eligibility, funding allocation, and needs assessment.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this country record is currently active in the system. Used for filtering and data quality management.',
    `iso_alpha2_code` STRING COMMENT 'Standardized code representing the iso alpha2 classification or category.',
    `iso_alpha3_code` STRING COMMENT 'Standardized code representing the iso alpha3 classification or category.',
    `kobo_deployment_active` BOOLEAN COMMENT 'Indicates whether KoboToolbox mobile data collection is actively deployed for field assessments and monitoring in this country.',
    `land_area_sq_km` DECIMAL(18,2) COMMENT 'Total land area of the country in square kilometers. Used for logistics planning, geographic information system (GIS) analysis, and distribution coverage calculations.',
    `landlocked` BOOLEAN COMMENT 'Indicates whether the country is landlocked with no direct access to the sea. Critical for supply chain and logistics planning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this country record was last modified. Used for audit trail and change tracking.',
    `least_developed_country` BOOLEAN COMMENT 'Indicates whether the country is classified as a Least Developed Country by the United Nations. Affects funding eligibility and program prioritization.',
    `memorandum_of_understanding_signed` BOOLEAN COMMENT 'Indicates whether a formal Memorandum of Understanding has been signed with the national government for humanitarian operations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this country.',
    `mou_expiry_date` DATE COMMENT 'Expiry date of the current Memorandum of Understanding with the national government. Null if no MOU exists or if MOU is indefinite.',
    `country_name` STRING COMMENT 'Official full name of the country as recognized by the United Nations.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, context, or special considerations for this country. Used for knowledge management and operational guidance.',
    `ocha_presence` BOOLEAN COMMENT 'Indicates whether OCHA has an active presence in the country. Determines cluster coordination mechanisms and humanitarian reporting requirements.',
    `office_established` BOOLEAN COMMENT 'Indicates whether the organization has an established country office with permanent presence in this country.',
    `office_establishment_date` DATE COMMENT 'Date when the country office was officially established. Null if no country office exists.',
    `official_language` STRING COMMENT 'Attribute capturing the official language information for the country entity.',
    `official_languages` STRING COMMENT 'Comma-separated list of official languages spoken in the country. Used for translation requirements, field staff recruitment, and beneficiary communication planning.',
    `operational_status` STRING COMMENT 'Current operational status of the country for field operations. Indicates whether the organization has active programs, suspended operations, or restricted access.',
    `population` BIGINT COMMENT 'Total population of the country based on the most recent census or UN estimate. Used for needs assessment and program scale planning.',
    `population_year` STRING COMMENT 'Year of the population estimate or census data. Indicates the currency of population data.',
    `primary_donor_countries` STRING COMMENT 'Comma-separated list of primary donor countries or institutions funding operations in this country. Used for donor reporting and relationship management.',
    `region` STRING COMMENT 'Geographic region classification for the country. Used for regional program coordination and reporting aggregation.',
    `region_name` STRING COMMENT 'Human-readable name or label for the region.',
    `security_risk_level` STRING COMMENT 'Current security risk assessment level for the country. Determines staff travel restrictions, security protocols, and operational modalities.',
    `small_island_developing_state` BOOLEAN COMMENT 'Indicates whether the country is classified as a Small Island Developing State. Relevant for climate adaptation and disaster risk reduction programs.',
    `sub_region` STRING COMMENT 'Geographic sub-region classification providing more granular regional grouping for operational planning and analysis.',
    `sub_region_name` STRING COMMENT 'Human-readable name or label for the sub region.',
    `tax_exemption_status` STRING COMMENT 'Tax exemption status granted to the organization by the national government. Affects financial planning and procurement.',
    `un_member_state_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the un member state condition applies.',
    `visa_requirements` STRING COMMENT 'Description of visa requirements and procedures for international staff deployment to this country. Used for staff travel planning and compliance.',
    CONSTRAINT pk_country PRIMARY KEY(`country_id`)
) COMMENT 'Master reference table for country. Referenced by country_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`field`.`emergency` (
    `emergency_id` BIGINT COMMENT 'Primary key for emergency',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: emergency has primary_country_code (STRING) but no FK to the country reference table. The country table is the authoritative source for country data. Adding country_id FK normalizes the country refere',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Humanitarian emergencies are managed and coordinated by country offices. The emergency table already has country_id but lacks a direct link to the country_office responsible for the emergency response',
    `escalated_from_emergency_id` BIGINT COMMENT 'Self-referencing FK on emergency (escalated_from_emergency_id)',
    `affected_population_count` BIGINT COMMENT 'Estimated total number of individuals directly affected by the emergency event.',
    `affected_regions` STRING COMMENT 'Comma-separated list of administrative regions, provinces, or districts affected by the emergency.',
    `cerf_allocation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the cerf allocation condition applies.',
    `cerf_allocation_received` BOOLEAN COMMENT 'Indicates whether the organization received funding from the UN Central Emergency Response Fund for this emergency.',
    `closure_date` DATE COMMENT 'Date when the emergency was officially closed and all operations ceased.',
    `cluster_coordination_mechanism` STRING COMMENT 'Description of the OCHA cluster coordination structure activated for this emergency (e.g., Full cluster activation with 11 sectors).',
    `emergency_code` STRING COMMENT 'Externally-known unique business identifier for the emergency, following organizational coding standards (e.g., SYR-2023-EQKE01).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency record was first created in the system.',
    `declaration_date` DATE COMMENT 'Date when the emergency was officially declared by the organization or governing authority.',
    `emergency_description` STRING COMMENT 'Detailed narrative description of the emergency context, impact, and response strategy.',
    `disaster_category` STRING COMMENT 'Specific disaster category providing granular classification of the emergency event type.',
    `displaced_population_count` BIGINT COMMENT 'Estimated number of individuals displaced or forced to leave their homes due to the emergency.',
    `emergency_status` STRING COMMENT 'Current lifecycle status of the emergency response operation.',
    `emergency_type` STRING COMMENT 'Classification of the emergency by its primary cause or nature.',
    `fgd_conducted_count` STRING COMMENT 'Number of Focus Group Discussions conducted as part of field assessments for this emergency.',
    `flash_appeal_issued` BOOLEAN COMMENT 'Indicates whether an OCHA Flash Appeal was issued for this emergency to mobilize rapid funding.',
    `funding_received_usd` DECIMAL(18,2) COMMENT 'Total funding received in US Dollars for the emergency response as of the last update.',
    `funding_requirement_usd` DECIMAL(18,2) COMMENT 'Total funding requirement in US Dollars for the organizations emergency response operations.',
    `geographic_scope` STRING COMMENT 'Geographic scale of the emergency impact and response operations.',
    `gis_mapping_completed` BOOLEAN COMMENT 'Indicates whether GIS-based location mapping and spatial analysis were completed for affected areas.',
    `glide_number` STRING COMMENT 'Count or number of glide items associated with this record.',
    `hrp_issued` BOOLEAN COMMENT 'Indicates whether a formal Humanitarian Response Plan was developed and issued for this emergency.',
    `implementing_partners_count` STRING COMMENT 'Number of local and international partner organizations collaborating in the emergency response.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this emergency record is currently active and operational in the system.',
    `kii_conducted_count` STRING COMMENT 'Number of Key Informant Interviews conducted as part of field assessments for this emergency.',
    `kobo_survey_deployed` BOOLEAN COMMENT 'Indicates whether mobile data collection surveys via KoboToolbox were deployed for field assessments in this emergency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emergency record was last updated in the system.',
    `lead_clusters` STRING COMMENT 'Comma-separated list of humanitarian clusters where the organization holds lead or co-lead responsibility (e.g., WASH, Shelter, Protection).',
    `lessons_learned` STRING COMMENT 'Summary of key lessons learned and best practices documented during or after the emergency response.',
    `mobile_health_outreach_planned` BOOLEAN COMMENT 'Indicates whether mobile health clinics or outreach services are planned as part of the health response.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this emergency.',
    `emergency_name` STRING COMMENT 'Human-readable name or title of the emergency event (e.g., Syria Earthquake Response 2023, Bangladesh Flood Relief).',
    `nfi_distribution_planned` BOOLEAN COMMENT 'Indicates whether distribution of non-food items (shelter materials, hygiene kits, household items) is planned.',
    `ocha_appeal_reference` STRING COMMENT 'Attribute capturing the ocha appeal reference information for the emergency entity.',
    `onset_date` DATE COMMENT 'Date when the emergency event first occurred or began impacting the affected population.',
    `people_in_need_count` STRING COMMENT 'Count or number of people in need items associated with this record.',
    `people_targeted_count` STRING COMMENT 'Count or number of people targeted items associated with this record.',
    `protection_concerns_identified` STRING COMMENT 'Summary of key protection concerns identified during assessments (e.g., GBV risk, child protection, housing land property rights).',
    `rapid_assessment_completed` BOOLEAN COMMENT 'Indicates whether a rapid needs assessment was completed within the first 72 hours of the emergency.',
    `response_end_date` DATE COMMENT 'Date when the emergency response operations were concluded or transitioned to recovery phase.',
    `response_modality` STRING COMMENT 'Description of the primary response delivery mechanisms employed (e.g., In-kind distribution, Cash and Voucher Assistance (CVA), Service delivery).',
    `response_start_date` DATE COMMENT 'Date when the organization initiated its emergency response operations.',
    `severity_level` STRING COMMENT 'IASC system-wide emergency classification level indicating scale and required response capacity (Level 1: country-led, Level 2: UN coordination, Level 3: system-wide mobilization).',
    `sitrep_frequency` STRING COMMENT 'Frequency at which situation reports are generated and disseminated for this emergency.',
    `targeted_beneficiaries_count` BIGINT COMMENT 'Number of beneficiaries the organization plans to reach through its emergency response interventions.',
    `wash_interventions_planned` BOOLEAN COMMENT 'Indicates whether WASH sector interventions are included in the emergency response plan.',
    CONSTRAINT pk_emergency PRIMARY KEY(`emergency_id`)
) COMMENT 'Represents a declared humanitarian emergency (L1/L2/L3 or IASC System-Wide Scale-Up) triggering coordinated response under OCHA. Tracks HRP/Flash Appeal issuance, CERF allocations, cluster activations, and response modalities. Source systems: OCHA FTS, ReliefWeb, Humanitarian InSight, GDACS.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ADD CONSTRAINT `fk_field_project_site_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ADD CONSTRAINT `fk_field_country_office_parent_office_country_office_id` FOREIGN KEY (`parent_office_country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ADD CONSTRAINT `fk_field_distribution_event_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ADD CONSTRAINT `fk_field_distribution_line_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_distribution_event_id` FOREIGN KEY (`distribution_event_id`) REFERENCES `vibe_ngo_v1`.`field`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ADD CONSTRAINT `fk_field_assessment_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_ngo_v1`.`field`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ADD CONSTRAINT `fk_field_assessment_response_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ADD CONSTRAINT `fk_field_sitrep_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ADD CONSTRAINT `fk_field_team_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ADD CONSTRAINT `fk_field_team_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ADD CONSTRAINT `fk_field_team_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_emergency_id` FOREIGN KEY (`emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_ngo_v1`.`field`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ADD CONSTRAINT `fk_field_security_incident_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_ngo_v1`.`field`.`team`(`team_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ADD CONSTRAINT `fk_field_country_parent_country_id` FOREIGN KEY (`parent_country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_country_id` FOREIGN KEY (`country_id`) REFERENCES `vibe_ngo_v1`.`field`.`country`(`country_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_country_office_id` FOREIGN KEY (`country_office_id`) REFERENCES `vibe_ngo_v1`.`field`.`country_office`(`country_office_id`);
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ADD CONSTRAINT `fk_field_emergency_escalated_from_emergency_id` FOREIGN KEY (`escalated_from_emergency_id`) REFERENCES `vibe_ngo_v1`.`field`.`emergency`(`emergency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`field` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`field` SET TAGS ('dbx_domain' = 'field');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `accessibility_rating` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Rating');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `accessibility_rating` SET TAGS ('dbx_value_regex' = 'easily_accessible|moderately_accessible|difficult|very_difficult|inaccessible');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `admin_level_1` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `admin_level_2` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `admin_level_3` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `cluster_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Cluster Affiliation');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `electricity_available` SET TAGS ('dbx_business_glossary_term' = 'Electricity Available');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `facility_ownership` SET TAGS ('dbx_business_glossary_term' = 'Facility Ownership');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `facility_ownership` SET TAGS ('dbx_value_regex' = 'owned|leased|borrowed|government|partner|temporary');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `gis_data_source` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Data Source');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Internet Connectivity');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_value_regex' = 'none|mobile_data|satellite|broadband|fiber');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `kobo_collection_enabled` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Collection Enabled');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|closed');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `pcode` SET TAGS ('dbx_business_glossary_term' = 'Place Code (P-code)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `pcode` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{4,8}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `population_catchment` SET TAGS ('dbx_business_glossary_term' = 'Population Catchment Area');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'minimal|low|moderate|substantial|critical');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Site Area (Square Meters)');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Site Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_manager_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'health_post|distribution_point|wash_facility|school|camp|community_center');
ALTER TABLE `vibe_ngo_v1`.`field`.`project_site` ALTER COLUMN `water_source_available` SET TAGS ('dbx_business_glossary_term' = 'Water Source Available');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `parent_office_country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Office Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Office Closure Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_email` SET TAGS ('dbx_business_glossary_term' = 'Country Director Email Address');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_email` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_name` SET TAGS ('dbx_business_glossary_term' = 'Country Director Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `country_director_name` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Office Email Address');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Office Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `is_emergency_response` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Office Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `mou_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Memorandum of Understanding (MoU) Effective Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `mou_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Memorandum of Understanding (MoU) Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `mou_with_government` SET TAGS ('dbx_business_glossary_term' = 'Memorandum of Understanding (MoU) with Government');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Office Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `ocha_cluster_participation` SET TAGS ('dbx_business_glossary_term' = 'Office for the Coordination of Humanitarian Affairs (OCHA) Cluster Participation');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_name` SET TAGS ('dbx_business_glossary_term' = 'Office Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_type` SET TAGS ('dbx_business_glossary_term' = 'Office Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `office_type` SET TAGS ('dbx_value_regex' = 'country_office|sub_office|field_hub|liaison_office|regional_office|emergency_response_office');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `operational_mandate` SET TAGS ('dbx_business_glossary_term' = 'Operational Mandate');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|transitioning|closing|planned');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Risk Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'minimal|low|moderate|substantial|high|critical');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `staff_count` SET TAGS ('dbx_business_glossary_term' = 'Staff Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country_office` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` SET TAGS ('dbx_subdomain' = 'distribution_assessment');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `actual_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `actual_household_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Household Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `admin_level_1` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `admin_level_2` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `admin_level_3` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 3');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z]{2,4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `cva_transfer_modality` SET TAGS ('dbx_business_glossary_term' = 'CVA Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'kobo_toolbox|commcare|odk|paper_form|mobile_app|tablet');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Distribution Location Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Distribution Location Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Location Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_location_name` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_modality` SET TAGS ('dbx_business_glossary_term' = 'Distribution Modality');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_modality` SET TAGS ('dbx_value_regex' = 'in_kind|cash|voucher|mobile_money|e_transfer|hybrid');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_type` SET TAGS ('dbx_value_regex' = 'general|targeted|blanket|voucher_redemption|emergency_response|seasonal');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `incident_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `distribution_event_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `pdm_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Distribution Monitoring (PDM) Completion Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `pdm_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Distribution Monitoring (PDM) Scheduled Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `planned_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `planned_household_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Household Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `sitrep_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) Included Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_event` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'biometric|token|id_card|beneficiary_list|household_head|mobile_verification');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` SET TAGS ('dbx_subdomain' = 'distribution_assessment');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_line_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Line ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `actual_quantity_distributed` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Distributed');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `cluster_sector` SET TAGS ('dbx_business_glossary_term' = 'Cluster Sector');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `cva_transfer_modality` SET TAGS ('dbx_business_glossary_term' = 'CVA Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'direct_hand|voucher|cash_transfer|mobile_distribution|fixed_site');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|partially_distributed');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `donor_earmark` SET TAGS ('dbx_business_glossary_term' = 'Donor Earmark');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `iati_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Transaction Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'NFI|Food|WASH|Shelter|Health|Education');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `mvm_migration_reference` SET TAGS ('dbx_business_glossary_term' = 'MVM Migration Reference');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `mvm_migration_reference` SET TAGS ('dbx_ecm_reconciliation' = 'mvm_stub_distribution_line');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `pipeline_source` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Source');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `quality_check_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_checked|conditional');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `unit_value` SET TAGS ('dbx_business_glossary_term' = 'Unit Value');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `vibe_ngo_v1`.`field`.`distribution_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` SET TAGS ('dbx_subdomain' = 'distribution_assessment');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `logframe_row_id` SET TAGS ('dbx_business_glossary_term' = 'Logframe Row Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `adequacy_score` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Score');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|validated|cancelled');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `beneficiary_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Satisfaction Score');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `cluster_coordination_body` SET TAGS ('dbx_business_glossary_term' = 'Cluster Coordination Body');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `complaints_received_count` SET TAGS ('dbx_business_glossary_term' = 'Complaints Received Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `data_collection_tool` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'single_site|multi_site|district|region|national');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `mel_indicator_linked` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Indicator Linked');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative|mixed_methods|participatory|rapid_appraisal');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `protection_concerns_description` SET TAGS ('dbx_business_glossary_term' = 'Protection Concerns Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `protection_concerns_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `protection_concerns_noted` SET TAGS ('dbx_business_glossary_term' = 'Protection Concerns Noted');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `sample_methodology` SET TAGS ('dbx_business_glossary_term' = 'Sample Methodology');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `sample_methodology` SET TAGS ('dbx_value_regex' = 'random|stratified|cluster|purposive|convenience|census');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Size');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percent');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` SET TAGS ('dbx_subdomain' = 'distribution_assessment');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `assessment_response_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Response ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Form ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `children_under_5_count` SET TAGS ('dbx_business_glossary_term' = 'Children Under 5 Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `chronic_illness_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Illness Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `consent_data_sharing` SET TAGS ('dbx_business_glossary_term' = 'Consent Data Sharing');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `consent_follow_up` SET TAGS ('dbx_business_glossary_term' = 'Consent Follow-Up');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'face_to_face|phone|remote_digital|focus_group|key_informant');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `debt_burden_flag` SET TAGS ('dbx_business_glossary_term' = 'Debt Burden Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `disability_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Present Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `disability_present_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `disability_present_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `displacement_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Displacement Duration Months');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'host_community|idp|refugee|returnee|asylum_seeker|stateless');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `education_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Education Access Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `elderly_over_60_count` SET TAGS ('dbx_business_glossary_term' = 'Elderly Over 60 Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `female_count` SET TAGS ('dbx_business_glossary_term' = 'Female Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `food_security_score` SET TAGS ('dbx_business_glossary_term' = 'Food Security Score');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy Meters');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `interview_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interview Duration Minutes');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `interview_language` SET TAGS ('dbx_business_glossary_term' = 'Interview Language');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `livelihood_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|self_employed|casual_labor|no_income');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `male_count` SET TAGS ('dbx_business_glossary_term' = 'Male Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `monthly_income_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Income USD (United States Dollar)');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `monthly_income_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `monthly_income_usd` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `primary_need_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Need Category');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `primary_need_category` SET TAGS ('dbx_value_regex' = 'food|water|shelter|health|protection|education');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `protection_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Concern Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `protection_concern_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|validated|rejected|pending_review|approved|flagged');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `shelter_condition` SET TAGS ('dbx_business_glossary_term' = 'Shelter Condition');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `shelter_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `shelter_type` SET TAGS ('dbx_business_glossary_term' = 'Shelter Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `shelter_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|tent|collective_center|makeshift|open_air');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_latitude` SET TAGS ('dbx_business_glossary_term' = 'Submission Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_longitude` SET TAGS ('dbx_business_glossary_term' = 'Submission Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`assessment_response` ALTER COLUMN `water_access_minutes` SET TAGS ('dbx_business_glossary_term' = 'Water Access Minutes');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` SET TAGS ('dbx_subdomain' = 'distribution_assessment');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `sitrep_id` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `access_impediments_count` SET TAGS ('dbx_business_glossary_term' = 'Access Impediments Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_1_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1 Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_1_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_1_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_2_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2 Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_2_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `admin_level_2_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `cerf_application_status` SET TAGS ('dbx_business_glossary_term' = 'Central Emergency Response Fund (CERF) Application Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `cerf_application_status` SET TAGS ('dbx_value_regex' = 'not_applicable|planned|submitted|approved|rejected');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `cluster_coordination_updates` SET TAGS ('dbx_business_glossary_term' = 'Cluster Coordination Updates');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `cluster_lead_agency` SET TAGS ('dbx_business_glossary_term' = 'Cluster Lead Agency');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `crisis_context_summary` SET TAGS ('dbx_business_glossary_term' = 'Crisis Context Summary');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `donor_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Submission Required');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `education_beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Education Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `food_distributions_completed` SET TAGS ('dbx_business_glossary_term' = 'Food Distributions Completed');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `funding_gap_usd` SET TAGS ('dbx_business_glossary_term' = 'Funding Gap (USD)');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|district|camp|site|multi-country');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `health_consultations_completed` SET TAGS ('dbx_business_glossary_term' = 'Health Consultations Completed');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `health_consultations_completed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `health_consultations_completed` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `hrp_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humanitarian Response Plan (HRP) Progress Percentage');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `nfi_distributions_completed` SET TAGS ('dbx_business_glossary_term' = 'Non-Food Item (NFI) Distributions Completed');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `nfi_kits_distributed` SET TAGS ('dbx_business_glossary_term' = 'Non-Food Item (NFI) Kits Distributed');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `ocha_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Office for the Coordination of Humanitarian Affairs (OCHA) Submission Required');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `operational_constraints` SET TAGS ('dbx_business_glossary_term' = 'Operational Constraints');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `protection_cases_registered` SET TAGS ('dbx_business_glossary_term' = 'Protection Cases Registered');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3,4}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|submitted|published|archived');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) Title');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi-weekly|monthly|ad-hoc|flash');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `resource_gaps_summary` SET TAGS ('dbx_business_glossary_term' = 'Resource Gaps Summary');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `security_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Security Incidents Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `shelter_units_provided` SET TAGS ('dbx_business_glossary_term' = 'Shelter Units Provided');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `total_beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Total Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`field`.`sitrep` ALTER COLUMN `wash_beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Water Sanitation and Hygiene (WASH) Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Organization ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Base Location ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `activities_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Activities Completed Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `beneficiaries_served_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Served Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `cluster_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Cluster Affiliation');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `communication_equipment` SET TAGS ('dbx_business_glossary_term' = 'Communication Equipment');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `coverage_area_description` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `deployment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `deployment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_type' = 'contact');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Tracking Enabled');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `last_sitrep_date` SET TAGS ('dbx_business_glossary_term' = 'Last SitRep (Situation Report) Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `mobile_data_collection_platform` SET TAGS ('dbx_business_glossary_term' = 'Mobile Data Collection Platform');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `mobile_data_collection_platform` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `mobile_data_collection_platform` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `mobile_data_collection_platform` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `mobile_data_collection_platform` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `monthly_operational_budget` SET TAGS ('dbx_business_glossary_term' = 'Monthly Operational Budget');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|standby|deployed|resting|disbanded|suspended');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `safety_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `safety_clearance_level` SET TAGS ('dbx_value_regex' = 'minimal|low|moderate|substantial|severe|critical');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`team` ALTER COLUMN `training_certifications` SET TAGS ('dbx_business_glossary_term' = 'Training Certifications');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `admin_level_1` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `admin_level_2` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `affected_personnel_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Personnel Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `asset_damage_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Damage Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `corrective_actions_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `estimated_asset_loss_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Asset Loss (USD)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `estimated_asset_loss_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions Taken');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_location_name` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_location_name` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^SI-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|escalated|resolved|closed');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `inso_report_date` SET TAGS ('dbx_business_glossary_term' = 'INSO Report Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Incident Latitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `local_authorities_report_date` SET TAGS ('dbx_business_glossary_term' = 'Local Authorities Report Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Incident Longitude');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `pcode` SET TAGS ('dbx_business_glossary_term' = 'Place Code (P-Code)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `police_case_number` SET TAGS ('dbx_business_glossary_term' = 'Police Case Number');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `reported_to_inso` SET TAGS ('dbx_business_glossary_term' = 'Reported to International NGO Safety Organisation (INSO)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `reported_to_local_authorities` SET TAGS ('dbx_business_glossary_term' = 'Reported to Local Authorities');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `reported_to_undss` SET TAGS ('dbx_business_glossary_term' = 'Reported to United Nations Department of Safety and Security (UNDSS)');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `sitrep_included` SET TAGS ('dbx_business_glossary_term' = 'Situation Report (SitRep) Included');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `staff_fatality_count` SET TAGS ('dbx_business_glossary_term' = 'Staff Fatality Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `staff_injured_count` SET TAGS ('dbx_business_glossary_term' = 'Staff Injured Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`security_incident` ALTER COLUMN `undss_report_date` SET TAGS ('dbx_business_glossary_term' = 'UNDSS Report Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Identifier');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `parent_country_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Country Id');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `parent_country_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `access_constraints` SET TAGS ('dbx_business_glossary_term' = 'Access Constraints');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `active_clusters` SET TAGS ('dbx_business_glossary_term' = 'Active Clusters');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `capital_city` SET TAGS ('dbx_business_glossary_term' = 'Capital City');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `capital_city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `cluster_coordination_active` SET TAGS ('dbx_business_glossary_term' = 'Cluster Coordination Active');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `code_alpha2` SET TAGS ('dbx_business_glossary_term' = 'Country Code Alpha2');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `code_alpha3` SET TAGS ('dbx_business_glossary_term' = 'Country Code Alpha3');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `code_numeric` SET TAGS ('dbx_business_glossary_term' = 'Country Code Numeric');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `customs_procedures` SET TAGS ('dbx_business_glossary_term' = 'Customs Procedures');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `fragility_status` SET TAGS ('dbx_business_glossary_term' = 'Fragility Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `gis_data_available` SET TAGS ('dbx_business_glossary_term' = 'Gis Data Available');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `government_partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Government Partnership Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `humanitarian_response_plan_active` SET TAGS ('dbx_business_glossary_term' = 'Humanitarian Response Plan Active');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `income_classification` SET TAGS ('dbx_business_glossary_term' = 'Income Classification');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `income_classification` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `kobo_deployment_active` SET TAGS ('dbx_business_glossary_term' = 'Kobo Deployment Active');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `land_area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Land Area Sq Km');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `landlocked` SET TAGS ('dbx_business_glossary_term' = 'Landlocked');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `least_developed_country` SET TAGS ('dbx_business_glossary_term' = 'Least Developed Country');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `memorandum_of_understanding_signed` SET TAGS ('dbx_business_glossary_term' = 'Memorandum Of Understanding Signed');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `mou_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Mou Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `ocha_presence` SET TAGS ('dbx_business_glossary_term' = 'Ocha Presence');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `office_established` SET TAGS ('dbx_business_glossary_term' = 'Country Office Established');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `office_establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Office Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `official_languages` SET TAGS ('dbx_business_glossary_term' = 'Official Languages');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Population');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `population_year` SET TAGS ('dbx_business_glossary_term' = 'Population Year');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `primary_donor_countries` SET TAGS ('dbx_business_glossary_term' = 'Primary Donor Countries');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `primary_donor_countries` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `region_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `security_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Security Risk Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `security_risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `small_island_developing_state` SET TAGS ('dbx_business_glossary_term' = 'Small Island Developing State');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `sub_region` SET TAGS ('dbx_business_glossary_term' = 'Sub Region');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `sub_region_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`country` ALTER COLUMN `visa_requirements` SET TAGS ('dbx_business_glossary_term' = 'Visa Requirements');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` SET TAGS ('dbx_subdomain' = 'site_operations');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Identifier');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `escalated_from_emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated From Emergency Id');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `escalated_from_emergency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `affected_population_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Population Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `affected_regions` SET TAGS ('dbx_business_glossary_term' = 'Affected Regions');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `cerf_allocation_received` SET TAGS ('dbx_business_glossary_term' = 'Cerf Allocation Received');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `cluster_coordination_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Cluster Coordination Mechanism');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_code` SET TAGS ('dbx_business_glossary_term' = 'Emergency Code');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `disaster_category` SET TAGS ('dbx_business_glossary_term' = 'Disaster Category');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `displaced_population_count` SET TAGS ('dbx_business_glossary_term' = 'Displaced Population Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Type');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `fgd_conducted_count` SET TAGS ('dbx_business_glossary_term' = 'Fgd Conducted Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `flash_appeal_issued` SET TAGS ('dbx_business_glossary_term' = 'Flash Appeal Issued');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `funding_received_usd` SET TAGS ('dbx_business_glossary_term' = 'Funding Received Usd');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `funding_received_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `funding_requirement_usd` SET TAGS ('dbx_business_glossary_term' = 'Funding Requirement Usd');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `funding_requirement_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `gis_mapping_completed` SET TAGS ('dbx_business_glossary_term' = 'Gis Mapping Completed');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `hrp_issued` SET TAGS ('dbx_business_glossary_term' = 'Hrp Issued');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `implementing_partners_count` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partners Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `kii_conducted_count` SET TAGS ('dbx_business_glossary_term' = 'Kii Conducted Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `kobo_survey_deployed` SET TAGS ('dbx_business_glossary_term' = 'Kobo Survey Deployed');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `lead_clusters` SET TAGS ('dbx_business_glossary_term' = 'Lead Clusters');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `mobile_health_outreach_planned` SET TAGS ('dbx_business_glossary_term' = 'Mobile Health Outreach Planned');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `mobile_health_outreach_planned` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `mobile_health_outreach_planned` SET TAGS ('dbx_pii_de_identified' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Name');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `emergency_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `nfi_distribution_planned` SET TAGS ('dbx_business_glossary_term' = 'Nfi Distribution Planned');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Onset Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `protection_concerns_identified` SET TAGS ('dbx_business_glossary_term' = 'Protection Concerns Identified');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `protection_concerns_identified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `rapid_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Rapid Assessment Completed');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `response_end_date` SET TAGS ('dbx_business_glossary_term' = 'Response End Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `response_modality` SET TAGS ('dbx_business_glossary_term' = 'Response Modality');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `response_start_date` SET TAGS ('dbx_business_glossary_term' = 'Response Start Date');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `sitrep_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sitrep Frequency');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `targeted_beneficiaries_count` SET TAGS ('dbx_business_glossary_term' = 'Targeted Beneficiaries Count');
ALTER TABLE `vibe_ngo_v1`.`field`.`emergency` ALTER COLUMN `wash_interventions_planned` SET TAGS ('dbx_business_glossary_term' = 'Wash Interventions Planned');
