-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:34:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`compliance` COMMENT 'Regulatory compliance management including permit tracking (NPDES, IUP, state primacy agency permits), MOR/DMR preparation and submission, violation management, enforcement action tracking, audit trails, environmental reporting, SDWA and CWA compliance, CCR publication tracking, and regulatory correspondence. Ensures adherence to all federal, state, and local water and wastewater regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` (
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance_permit data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the compliance created by employee referenced by each compliance permit record in the compliance domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency that issued this permit, supporting multi-jurisdictional agency tracking (US EPA, ANSES, DWI, UBA). Ref: EPA SDWA.',
    `compliance_regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the compliance regulatory agency referenced by each compliance permit record in the compliance domain.',
    `compliance_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the compliance responsible employee referenced by each compliance permit record in the compliance domain.',
    `compliance_responsible_operator_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Water utility permits require designated responsible operator in charge per state regulations. This operator must hold appropriate license grade and is legally accountable for permit compliance. Criti. Ref: EPA SDWA.',
    `treatment_permit_id` BIGINT COMMENT 'treatment permit id for compliance_permit. Ref: EPA SDWA.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Water/wastewater permits are funded through enterprise funds. Essential for tracking permit fees, monitoring costs, and compliance expenditures against fund budgets for rate case and GASB reporting. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Primary regulatory requirement. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Permits mandate specific sampling plans to demonstrate compliance. Compliance officers need to reference which sampling plan satisfies each permits monitoring requirements for regulatory defensibilit. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'water system id for compliance_permit. Ref: EPA SDWA.',
    `project_permit_id` BIGINT COMMENT 'Canonical reference to project.project_permit. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'FK to wastewater.outfall. Ref: EPA SDWA.',
    `administrative_extension_flag` BOOLEAN COMMENT 'administrative extension flag for compliance_permit. Ref: EPA SDWA.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each compliance permit in the compliance domain.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual permit fee. Ref: EPA SDWA.',
    `annual_fee_usd` DECIMAL(18,2) COMMENT 'The annual fee usd value recorded for each compliance permit in the compliance domain.',
    `application_date` TIMESTAMP COMMENT 'Date the permit application was submitted. Ref: EPA SDWA.',
    `compliance_permit_category` STRING COMMENT 'The compliance permit category value recorded for each compliance permit in the compliance domain.',
    `classification` STRING COMMENT 'The classification value recorded for each compliance permit in the compliance domain.',
    `compliance_permit_code` STRING COMMENT 'code for compliance_permit. Ref: EPA SDWA.',
    `comments` STRING COMMENT 'The comments value recorded for each compliance permit in the compliance domain.',
    `compliance_permit_number` STRING COMMENT 'The compliance permit number value recorded for each compliance permit in the compliance domain.',
    `compliance_permit_type` STRING COMMENT 'The compliance permit type value recorded for each compliance permit in the compliance domain.',
    `compliance_project_permit_id` BIGINT COMMENT 'project permit id for compliance_permit. Ref: EPA SDWA.',
    `compliance_schedule_flag` BOOLEAN COMMENT 'compliance schedule flag for compliance_permit. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'In Compliance, Violation, Consent Order, Enforcement. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each compliance permit in the compliance domain.',
    `compliance_permit_description` STRING COMMENT 'The compliance permit description value recorded for each compliance permit in the compliance domain.',
    `directive_reference` STRING COMMENT 'EU directive or international regulation reference (e.g. 2000/60/EC, 91/271/EEC) under which this permit obligation arises. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Permit effective date. Ref: EPA SDWA.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each compliance permit record in the compliance domain.',
    `eu_directive_basis` STRING COMMENT 'For EU permits: underlying directive such as Water Framework Directive 2000/60/EC, Urban Wastewater Treatment Directive 91/271/EEC, or Drinking Water Directive 2020/2184. Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (e.g. DWD 2020/2184, WFD 2000/60/EC). Ref: EPA SDWA.',
    `eu_ied_permit_number` STRING COMMENT 'EU Industrial Emissions Directive 2010/75/EU permit number, applicable to large wastewater treatment installations in EU jurisdictions. Ref: EPA SDWA.',
    `eu_permit_directive_reference` STRING COMMENT 'EU directive reference (Water Framework Directive 2000/60/EC, Urban Wastewater Treatment Directive 91/271/EEC, Drinking Water Directive 2020/2184) where applicable. Ref: EPA SDWA.',
    `eu_uwwtd_agglomeration_size` DECIMAL(18,2) COMMENT 'EU Urban Wastewater Treatment Directive 91/271/EEC agglomeration population equivalent category. Ref: EPA SDWA.',
    `eu_wfd_water_body_status` STRING COMMENT 'EU Water Framework Directive 2000/60/EC water body ecological/chemical status classification. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'Permit expiration date. Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Whether permit is currently active. Ref: EPA SDWA.',
    `is_general_permit` BOOLEAN COMMENT 'Whether this is a general permit. Ref: EPA SDWA.',
    `is_major_permit` BOOLEAN COMMENT 'Whether this is a major permit (EPA classification). Ref: EPA SDWA.',
    `issuance_date` TIMESTAMP COMMENT 'The issuance date associated with each compliance permit record in the compliance domain.',
    `issue_date` TIMESTAMP COMMENT 'The issue date associated with each compliance permit record in the compliance domain.',
    `issued_date` TIMESTAMP COMMENT 'The issued date associated with each compliance permit record in the compliance domain.',
    `issuing_agency` STRING COMMENT 'Regulatory agency that issued the permit. Ref: EPA SDWA.',
    `issuing_agency_name` STRING COMMENT 'Name of the regulatory agency that issued the permit. Ref: EPA SDWA.',
    `issuing_agency_region` STRING COMMENT 'Issuing agency region: EPA (US), EU Commission, ANSES/DWI/UBA (national). Ref: EPA SDWA.',
    `issuing_authority` STRING COMMENT 'The issuing authority value recorded for each compliance permit in the compliance domain.',
    `issuing_authority_name` STRING COMMENT 'Name of the regulatory authority that issued the permit (e.g. US EPA Region X, Environment Agency (UK), Agence de leau (FR), Landesumweltamt (DE)). Ref: EPA SDWA.',
    `issuing_member_state` STRING COMMENT 'For EU permits: ISO country code of member state issuing the permit (DE, FR, UK, etc.)',
    `jurisdiction` STRING COMMENT 'The jurisdiction value recorded for each compliance permit in the compliance domain.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code or regional code (e.g. US, EU, GB, DE, FR) identifying the regulatory jurisdiction. Supports multi-national regulatory frameworks including US EPA SDWA, EU Drinking Water Directive 2020/2184, and Water Framework Directive 2000/60/EC.',
    `jurisdiction_framework` STRING COMMENT 'Framework governing the permit: US SDWA/NPDWR/LCRR (EPA); EU Drinking Water Directive 2020/2184; REACH PFAS restriction (ECHA); Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC; FR ANSES national implementation; UK DWI national implementation; DE UBA national implementation',
    `jurisdiction_region` STRING COMMENT 'Sub-national or supra-national region qualifier, e.g. US state abbreviation, EU member state, UK nation (England/Wales/Scotland), German Bundesland. Supports multi-level regulatory hierarchy. Ref: EPA SDWA.',
    `jurisdiction_region_code` STRING COMMENT 'ISO region code for the permit jurisdiction (US, EU, FR, UK, DE). US permits reference NPDES/SDWA; EU permits reference DWD 2020/2184 or WFD 2000/60/EC authorizations.',
    `last_inspection_date` TIMESTAMP COMMENT 'Date of last regulatory inspection. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each compliance permit record in the compliance domain.',
    `major_minor_flag` BOOLEAN COMMENT 'Major or minor permit classification. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'modified timestamp for compliance_permit. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'Daily, weekly, monthly, quarterly, annual. Ref: EPA SDWA.',
    `monitoring_requirements_count` STRING COMMENT 'The monitoring requirements count value recorded for each compliance permit in the compliance domain.',
    `compliance_permit_name` STRING COMMENT 'name for compliance_permit. Ref: EPA SDWA.',
    `national_competent_authority` STRING COMMENT 'National agency issuing permit: EPA (US), ANSES (FR), DWI (UK), UBA (DE), or state/regional equivalent. Ref: EPA SDWA.',
    `next_inspection_date` TIMESTAMP COMMENT 'Date of next scheduled inspection. Ref: EPA SDWA.',
    `next_reporting_due_date` TIMESTAMP COMMENT 'next reporting due date for compliance_permit. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes. Ref: EPA SDWA.',
    `npdes_permit_number` STRING COMMENT 'NPDES permit number if applicable. Ref: EPA SDWA.',
    `outfall_count` STRING COMMENT 'outfall count for compliance_permit. Ref: EPA SDWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each compliance permit in the compliance domain.',
    `permit_category` STRING COMMENT 'permit category for compliance_permit. Ref: EPA SDWA.',
    `permit_conditions_count` STRING COMMENT 'The permit conditions count value recorded for each compliance permit in the compliance domain.',
    `permit_description` STRING COMMENT 'Description of permit scope and conditions. Ref: EPA SDWA.',
    `permit_document_id` BIGINT COMMENT 'Unique identifier for the permit document referenced by each compliance permit record in the compliance domain.',
    `permit_fee_amount` DECIMAL(18,2) COMMENT 'The permit fee amount value recorded for each compliance permit in the compliance domain.',
    `permit_name` STRING COMMENT 'Descriptive name of the permit. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Official permit number. Ref: EPA SDWA.',
    `permit_program` STRING COMMENT 'permit program for compliance_permit. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Status (active, expired, pending_renewal, suspended, revoked). Ref: EPA SDWA.',
    `permit_type` STRING COMMENT 'Type (NPDES, SDWA, air, stormwater, pretreatment, EU_WFD). Ref: EPA SDWA.',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'permitted capacity mgd for compliance_permit. Ref: EPA SDWA.',
    `permitted_flow_mgd` STRING COMMENT 'Permitted flow in MGD. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each compliance permit in the compliance domain.',
    `public_notice_date` DATE COMMENT 'Date of public notice for permit. Ref: EPA SDWA.',
    `pwsid` STRING COMMENT 'The pwsid value recorded for each compliance permit in the compliance domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each compliance permit in the compliance domain.',
    `receiving_water_body` STRING COMMENT 'Receiving water body name. Ref: EPA SDWA.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each compliance permit in the compliance domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each compliance permit in the compliance domain.',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory agency or body with oversight, e.g. US EPA, state primacy agency, European Commission DG Environment, French ANSES, UK DWI (Drinking Water Inspectorate), German UBA (Umweltbundesamt), Australian NHMRC. Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'The regulatory citation value recorded for each compliance permit in the compliance domain.',
    `regulatory_directive_reference` STRING COMMENT 'Specific directive, rule, or regulation citation, e.g. 40 CFR 141 (US NPDWR), Directive 2020/2184/EU Article 13, Directive 91/271/EEC Annex I, REACH Annex XVII PFAS restriction, French Code de la sante publique R.1321.',
    `regulatory_framework` STRING COMMENT 'Name of the governing regulatory framework (e.g. US_SDWA, EU_DWD_2020_2184, EU_WFD_2000_60_EC, EU_UWWTD_91_271_EEC, REACH_PFAS_RESTRICTION). Enables multi-jurisdictional compliance tracking where EU Water Framework Directive defines surface-water ecological/chemical status differently from US CWA frameworks. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Governing framework, e.g. EU DWD 2020/2184, UWWTD 91/271/EEC, WFD 2000/60/EC or US SDWA/CWA. Ref: EU Drinking Water Directive 2020/2184; REACH PFAS restriction; Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `regulatory_program` STRING COMMENT 'The regulatory program value recorded for each compliance permit in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each compliance permit in the compliance domain.',
    `regulatory_region` STRING COMMENT 'Region of the permit (DE|EU|FR|UK|US) for parallel US / EU reference paths. Ref: EPA SDWA.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for permit jurisdiction (US, EU, FR, UK, DE)',
    `renewal_application_date` DATE COMMENT 'Date renewal application was submitted. Ref: EPA SDWA.',
    `renewal_application_due_date` TIMESTAMP COMMENT 'The renewal application due date associated with each compliance permit record in the compliance domain.',
    `renewal_deadline_date` TIMESTAMP COMMENT 'Deadline for renewal application. Ref: EPA SDWA.',
    `renewal_due_date` TIMESTAMP COMMENT 'The renewal due date associated with each compliance permit record in the compliance domain.',
    `reporting_frequency` STRING COMMENT 'The reporting frequency value recorded for each compliance permit in the compliance domain.',
    `resolution_date` TIMESTAMP COMMENT 'The resolution date associated with each compliance permit record in the compliance domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each compliance permit in the compliance domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each compliance permit in the compliance domain.',
    `ssot_resolution_type` STRING COMMENT 'ssot resolution type for compliance_permit. Ref: EPA SDWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'ssot sync timestamp for compliance_permit. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each compliance permit record in the compliance domain.',
    `compliance_permit_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `treatment_facility_code` STRING COMMENT 'Facility code from treatment domain. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each compliance permit in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `uwwtd_compliance_route` STRING COMMENT 'Compliance pathway under EU Urban Wastewater Treatment Directive 91/271/EEC: normal_area, sensitive_area, less_sensitive_area. Determines permit emission limit stringency. Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_permit PRIMARY KEY(`compliance_permit_id`)
) COMMENT 'Master record for all regulatory operating permits held by the utility, including NPDES discharge permits, state drinking water permits, IUPs (Industrial User Permits), air quality permits, and stormwater permits. Tracks permit number, issuing authority (EPA, state primacy agency, NPDES), permit type, facility covered, effective and expiration dates, permitted limits, renewal status, and associated regulatory program (SDWA, CWA). Serves as the authoritative registry of all regulatory authorizations required to operate water and wastewater facilities. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for permits.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition record. Primary key. Ref: EPA SDWA.',
    `analyte_id` BIGINT COMMENT 'Foreign key linking to laboratory.analyte. Business justification: Permit conditions regulate specific contaminants. Direct link to analyte master enables automated compliance limit evaluation, eliminates denormalized parameter_name, and ensures consistent contaminan. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each permit condition record in the compliance domain.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_method. Business justification: Permit conditions specify required analytical methods (e.g., EPA 200.8 for metals). Direct link enables automated validation that laboratory results used approved methods for regulatory compliance eva. Ref: EPA SDWA.',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Permit conditions define operational limits enforced at treatment facilities. Business process: permit compliance tracking where specific numeric limits (turbidity <0.3 NTU, CT >15 mg-min/L, flow <10. Ref: EPA SDWA.',
    `analytical_method` STRING COMMENT 'The specific EPA-approved or Standard Methods analytical procedure required for measuring this parameter (e.g., EPA Method 1664A, Standard Methods 5210B, EPA Method 200.8, EPA Method 537.1 for PFAS, SM 2540D for TDS, SM 4500-H+ for pH). Ref: EPA SDWA.',
    `compliance_evaluation_method` STRING COMMENT 'The method used to determine compliance with this condition: single value comparison (each result compared to limit), rolling average (moving average over specified period), statistical analysis (percentile or confidence interval), narrative assessment (qualitative evaluation), or best professional judgment (case-by-case determination).. Valid values are `single_value_comparison|rolling_average|statistical_analysis|narrative_assessment|best_professional_judgment`',
    `compliance_schedule_flag` BOOLEAN COMMENT 'Indicates whether this condition is subject to a compliance schedule (phased implementation plan) that allows the permittee additional time to achieve full compliance. True if a compliance schedule is in effect, False otherwise. Ref: EPA SDWA.',
    `compliance_schedule_milestone` STRING COMMENT 'Description of the compliance schedule milestone associated with this condition (e.g., Submit engineering plans by 2024-06-30, Complete construction by 2025-12-31, Achieve interim limit of 30 mg/L BOD by 2024-12-31). Null if no compliance schedule applies. Ref: EPA SDWA.',
    `condition_number` STRING COMMENT 'The official condition number or identifier as stated in the permit document (e.g., I.A.1, II.B.3, Condition 5). Ref: EPA SDWA.',
    `condition_status` STRING COMMENT 'Current lifecycle status of the permit condition: active (currently enforceable), suspended (temporarily not enforced due to variance or stay), superseded (replaced by modified condition), expired (no longer in effect), or under appeal (contested by permittee). Ref: EPA SDWA.. Valid values are `active|suspended|superseded|expired|under_appeal`',
    `condition_text` STRING COMMENT 'The full verbatim text of the permit condition as written in the permit document. Includes all narrative requirements, qualifications, and regulatory language. Ref: EPA SDWA.',
    `condition_type` STRING COMMENT 'Classification of the permit condition: effluent limit (numeric discharge limit), monitoring requirement (sampling frequency and method), reporting requirement (MOR/DMR submission), technology-based standard (treatment technology mandate), narrative condition (qualitative requirement), or best management practice (operational control). Ref: EPA SDWA.. Valid values are `effluent_limit|monitoring_requirement|reporting_requirement|technology_based_standard|narrative_condition|best_management_practice`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was first created in the system. Audit trail field for data governance and compliance tracking. Ref: EPA SDWA.',
    `detection_limit_requirement` DECIMAL(18,2) COMMENT 'The minimum detection limit (MDL) or practical quantitation limit (PQL) required for the analytical method. Ensures that the laboratory can measure the parameter at levels sufficiently below the permit limit to demonstrate compliance. Null if no specific detection limit is mandated. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The date on which this permit condition becomes enforceable. May differ from the parent permit effective date if the condition has a phased implementation schedule. Ref: EPA SDWA.',
    `enforcement_priority` STRING COMMENT 'The priority level assigned by the regulatory agency for enforcement of this condition. Critical conditions (e.g., public health parameters like coliform, lead, PFAS) trigger immediate enforcement action upon violation. High priority conditions (e.g., BOD, TSS, pH) require prompt corrective action. Medium and low priority conditions may allow for compliance schedules. Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `expiration_date` DATE COMMENT 'The date on which this permit condition expires or is superseded. Typically aligns with the parent permit expiration date unless the condition is time-limited or subject to modification. Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Active flag. Ref: EPA SDWA.',
    `limit_type` STRING COMMENT 'The statistical basis for the effluent limit: daily maximum (highest single-day value), monthly average (arithmetic mean over calendar month), weekly average (arithmetic mean over 7-day period), instantaneous maximum (single grab sample), annual average, or minimum (for parameters like dissolved oxygen). Ref: EPA SDWA.. Valid values are `daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average|minimum`',
    `limit_unit` STRING COMMENT 'Limit unit. Ref: EPA SDWA.',
    `limit_value` DECIMAL(18,2) COMMENT 'Limit value. Ref: EPA SDWA.',
    `mixing_zone_allowed_flag` BOOLEAN COMMENT 'Indicates whether a mixing zone (limited area where discharge is allowed to exceed water quality standards before achieving full dilution and compliance) is authorized for this condition. True if mixing zone is allowed, False if end-of-pipe compliance is required. Ref: EPA SDWA.',
    `mixing_zone_description` STRING COMMENT 'Description of the authorized mixing zone including dimensions, boundaries, and compliance monitoring points (e.g., 100 meters downstream of Outfall 001, Within 50-foot radius of discharge point, Compliance measured at edge of mixing zone). Null if no mixing zone is allowed. Ref: EPA SDWA.',
    `modification_date` DATE COMMENT 'The date on which this permit condition was last modified through permit amendment, administrative order, or consent decree. Null if the condition has never been modified since the original permit issuance. Ref: EPA SDWA.',
    `modification_reason` STRING COMMENT 'The reason for the most recent modification to this condition (e.g., Updated water quality standards, New analytical method approved, Compliance schedule adjustment, Facility upgrade completed, Enforcement action settlement, Anti-backsliding provision waiver). Null if never modified. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'The required frequency for monitoring or sampling this parameter: continuous (real-time SCADA monitoring), daily, weekly, monthly, quarterly, annually, or as needed (event-driven). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|as_needed — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `monitoring_location` STRING COMMENT 'The specific location where monitoring or sampling must occur (e.g., Outfall 001, Effluent Discharge Point A, Influent to Primary Treatment, Final Effluent). May reference a specific outfall, sampling point, or monitoring station. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or operational guidance related to this permit condition. May include cross-references to other permit sections, special instructions for compliance staff, or historical context. Ref: EPA SDWA.',
    `numeric_limit` DECIMAL(18,2) COMMENT 'The numeric threshold value for the effluent limit or monitoring requirement. Null for narrative conditions or qualitative requirements. Ref: EPA SDWA.',
    `parameter` STRING COMMENT 'Regulated parameter. Ref: EPA SDWA.',
    `parameter_code` STRING COMMENT 'Standardized code for the regulated parameter (e.g., 00310 for BOD, 00530 for TSS, 00400 for pH, 00600 for TDS). Uses EPA STORET or equivalent parameter coding system. Ref: EPA SDWA.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether violations of this condition require public notification (e.g., inclusion in Consumer Confidence Report (CCR), public notice in local newspaper, notification to downstream water users). True if public notification is required, False otherwise. Ref: EPA SDWA.',
    `quality_assurance_requirement` STRING COMMENT 'Specific quality assurance and quality control (QA/QC) requirements for monitoring and sampling (e.g., EPA Method 1664A for FOG, Standard Methods 5210B for BOD, EPA Method 200.8 for metals, Chain of custody required, Laboratory must be state-certified, Duplicate samples required quarterly). Ref: EPA SDWA.',
    `receiving_water_body` STRING COMMENT 'The name of the receiving water body (river, stream, lake, estuary, ocean, groundwater) into which the discharge occurs and for which this condition is designed to protect water quality (e.g., Mississippi River, Lake Michigan, Chesapeake Bay, Atlantic Ocean, Groundwater Aquifer Zone IIA). Ref: EPA SDWA.',
    `record_retention_period_days` STRING COMMENT 'The number of days that monitoring records, laboratory results, and compliance documentation for this condition must be retained by the permittee. Typically 3 years (1095 days) for NPDES permits, but may be longer for certain parameters or enforcement actions. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_basis` STRING COMMENT 'The legal or regulatory authority for this condition (e.g., Clean Water Act Section 301, SDWA Section 1412, 40 CFR 122.44, State Water Quality Standard Chapter 62-302, Technology-Based Effluent Limitation, Water Quality-Based Effluent Limitation, Best Available Technology (BAT), Best Conventional Pollutant Control Technology (BCT)). Ref: EPA SDWA.',
    `reporting_frequency` STRING COMMENT 'The required frequency for reporting monitoring results to the regulatory agency via Monthly Operating Report (MOR) or Discharge Monitoring Report (DMR): monthly, quarterly, annually, event-based (for spills or exceedances), or not required (internal monitoring only). Ref: EPA SDWA.. Valid values are `monthly|quarterly|annually|event_based|not_required`',
    `sample_type` STRING COMMENT 'The type of sample required for compliance monitoring: grab (single instantaneous sample), composite (time-weighted or flow-weighted composite over specified period), continuous (real-time monitoring), or flow-weighted (proportional to flow rate). Ref: EPA SDWA.. Valid values are `grab|composite|continuous|flow_weighted`',
    `seasonal_period` STRING COMMENT 'The time period during which seasonal variations apply (e.g., May 1 - September 30, Winter: November 1 - March 31, Low Flow Season: June - August). Null if no seasonal variation applies. Ref: EPA SDWA.',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates whether this condition has seasonal variations in limits or monitoring requirements (e.g., more stringent limits during low-flow summer months, reduced monitoring during winter). True if seasonal variations apply, False otherwise. Ref: EPA SDWA.',
    `technology_requirement` STRING COMMENT 'Specific treatment technology or operational practice mandated by this condition (e.g., Secondary Treatment, Ultraviolet (UV) Disinfection, Granular Activated Carbon (GAC) Filtration, Reverse Osmosis (RO), Microfiltration (MF), Ultrafiltration (UF), Fats Oils and Grease (FOG) Pretreatment, Best Management Practice (BMP) for Stormwater). Null for non-technology-based conditions. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the numeric limit (e.g., mg/L for milligrams per liter, ug/L for micrograms per liter, NTU for Nephelometric Turbidity Units, SU for Standard Units (pH), MPN/100mL for Most Probable Number per 100 milliliters, lbs/day for pounds per day, MGD for Million Gallons per Day). Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was last updated in the system. Audit trail field for data governance and compliance tracking. Ref: EPA SDWA.',
    `violation_threshold` DECIMAL(18,2) COMMENT 'The numeric value at which a violation is triggered. May differ from the numeric limit if the permit allows for measurement uncertainty, rounding conventions, or compliance margins. Null for narrative conditions. Ref: EPA SDWA.',
    `water_quality_standard_basis` STRING COMMENT 'The specific water quality standard or criterion that this condition is designed to protect (e.g., Aquatic Life Chronic Criterion, Human Health - Fish Consumption, Drinking Water Maximum Contaminant Level (MCL), Recreational Water Quality Standard, Anti-Degradation Policy Tier II). Null for technology-based conditions. Ref: EPA SDWA.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Individual enforceable conditions and limitations attached to a regulatory permit, including effluent limits (BOD, TSS, TDS, pH, COD), monitoring frequencies, reporting requirements, technology-based standards, and narrative conditions. Each condition is linked to its parent permit and tracks the parameter, limit type (daily max, monthly average), numeric threshold, units, monitoring location, and compliance evaluation method. Enables automated compliance checking against actual discharge monitoring results.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement record. Primary key. Ref: EPA SDWA.',
    `analyte_id` BIGINT COMMENT 'Foreign key linking to laboratory.analyte. Business justification: Regulatory requirements define which contaminants must be monitored (e.g., SDWA MCLs). Direct link to analyte master is foundational for compliance program design and eliminates denormalized contamina. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Governing agency. Ref: EPA SDWA.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Many regulatory requirements mandate specific position types (e.g., Grade IV operator for large systems, certified backflow tester). Links regulatory mandates to workforce planning and ensures proper. Ref: EPA SDWA.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_method. Business justification: Regulations specify approved analytical methods for compliance monitoring. Essential for laboratory method selection, accreditation scope definition, and ensuring regulatory defensibility of analytica. Ref: EPA SDWA.',
    `applicable_facility_type` STRING COMMENT 'Type of facility or system to which this requirement applies. WTP = Water Treatment Plant, WWTP = Wastewater Treatment Plant, STP = Sewage Treatment Plant. Ref: EPA SDWA.. Valid values are `WTP|WWTP|STP|distribution_system|collection_system|all_facilities`',
    `applicable_system_size` STRING COMMENT 'System size classification to which this requirement applies (e.g., large system >50,000 population, medium system 3,301-50,000, small system <=3,300). Null if applies to all sizes. Ref: EPA SDWA.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this requirement must be included in the annual Consumer Confidence Report (CCR). Ref: EPA SDWA.',
    `citation` STRING COMMENT 'Regulatory citation. Ref: EPA SDWA.',
    `compliance_deadline` DATE COMMENT 'Date by which the utility must achieve full compliance with the requirement. Null if no specific deadline or if compliance is ongoing. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current compliance status of the utility with respect to this regulatory requirement. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|pending|not_applicable|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was first created in the system. Ref: EPA SDWA.',
    `directive_reference` STRING COMMENT 'Specific directive or regulation reference number (e.g. 2020/2184, 2000/60/EC, 91/271/EEC, 40 CFR 141). Used for EU and international regulatory cross-referencing. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date on which the regulatory requirement became or will become effective and enforceable. Ref: EPA SDWA.',
    `enforcement_priority` STRING COMMENT 'Priority level assigned by the utility or regulator for enforcement and compliance tracking. Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `eu_directive_article` STRING COMMENT 'Specific article/annex reference within EU directives (e.g. Annex I Part B of DWD 2020/2184, Article 5 of WFD 2000/60/EC). NULL for non-EU requirements. Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU Directive reference (e.g., 2020/2184 Drinking Water Directive). Ref: EPA SDWA.',
    `eu_parametric_value` DECIMAL(18,2) COMMENT 'EU Drinking Water Directive parametric value equivalent to US MCL. Stored separately to support dual-jurisdiction compliance for utilities operating under both US EPA and EU/national frameworks (ANSES, DWI, UBA). Ref: EPA SDWA.',
    `eu_parametric_value_unit` DECIMAL(18,2) COMMENT 'Unit of measure for the EU parametric value (e.g. ug/L, mg/L, Bq/L). Ref: EPA SDWA.',
    `internal_policy_reference` STRING COMMENT 'Reference to the utilitys internal policy, procedure, or standard operating procedure (SOP) that implements this regulatory requirement. Ref: EPA SDWA.',
    `international_standard_reference` STRING COMMENT 'ISO or WHO guideline reference',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory requirement is currently active and enforceable. False if the requirement has been superseded, repealed, or is no longer applicable. Ref: EPA SDWA.',
    `issuing_authority` STRING COMMENT 'The governing body or agency that issued the regulatory requirement (e.g., EPA, state primacy agency, local municipality, AWWA, WEF, OSHA, ISO). [ENUM-REF-CANDIDATE: EPA|state_primacy_agency|local_municipality|AWWA|WEF|OSHA|ISO — 7 candidates stripped; promote to reference product]',
    `issuing_body_reference` STRING COMMENT 'Issuing regulatory body per region: ANSES; DWI; ECHA; EPA; European Commission; UBA. Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'The geographic or administrative jurisdiction to which this requirement applies (e.g., federal, state name, county, municipality). Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code or regional code (e.g. US, EU, GB, DE, FR) identifying the regulatory jurisdiction. Supports multi-national regulatory frameworks including US EPA SDWA, EU Drinking Water Directive 2020/2184, and Water Framework Directive 2000/60/EC.',
    `jurisdiction_framework` STRING COMMENT 'Governing framework for the region. Refs: US SDWA/NPDWR/LCRR (EPA); EU Drinking Water Directive 2020/2184; REACH PFAS restriction (ECHA); Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC; FR ANSES national implementation; UK DWI national implementation; DE UBA national implementation',
    `jurisdiction_region_code` STRING COMMENT 'ISO region code identifying the regulatory jurisdiction (e.g. US, EU, FR, UK, DE). Enables parallel US/EU/international regulatory coverage per DWD 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC.',
    `last_compliance_assessment_date` DATE COMMENT 'Date of the most recent internal or external compliance assessment or audit for this requirement. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was last updated or modified. Ref: EPA SDWA.',
    `mcl_unit` STRING COMMENT 'Unit of measure for the MCL value (e.g., mg/L, ug/L, pCi/L, NTU). Null if not applicable. Ref: EPA SDWA.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The enforceable maximum contaminant level (MCL) specified by the requirement. Null if not applicable. Ref: EPA SDWA.',
    `mclg_unit` STRING COMMENT 'Unit of measure for the MCLG value (e.g., mg/L, ug/L, pCi/L). Null if not applicable. Ref: EPA SDWA.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The non-enforceable maximum contaminant level goal (MCLG) specified by the requirement. Null if not applicable. Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of monitoring or sampling for compliance (e.g., daily, weekly, monthly, quarterly, annually). Null if not applicable. Ref: EPA SDWA.',
    `national_regulation_reference` STRING COMMENT 'National-level (FR/UK/DE) regulation reference; e.g. ANSES, DWI, UBA guidance. Ref: EPA SDWA.',
    `national_transposition_reference` STRING COMMENT 'Reference to national law transposing EU directive or national-specific regulation (e.g., French Code de la sante publique, German TrinkwV, UK Water Supply Regulations). Ref: EPA SDWA.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment of this requirement. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the regulatory requirement, including implementation challenges, variances granted, or special conditions. Ref: EPA SDWA.',
    `parametric_value_eu` DECIMAL(18,2) COMMENT 'EU Drinking Water Directive parametric value equivalent to US MCL. Stored alongside mcl_value for cross-jurisdictional comparison.',
    `parametric_value_eu_unit` STRING COMMENT 'Unit of measurement for the EU parametric value (e.g. ug/L, mg/L). Ref: EPA SDWA.',
    `penalty_description` STRING COMMENT 'Description of penalties or enforcement actions that may result from non-compliance (e.g., fines, consent orders, public notification requirements). Ref: EPA SDWA.',
    `public_notification_required` BOOLEAN COMMENT 'Indicates whether public notification is required in the event of non-compliance with this requirement. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulation_url` STRING COMMENT 'Web URL or hyperlink to the official regulatory text or guidance document. Ref: EPA SDWA.',
    `regulatory_body_name` STRING COMMENT 'Name of regulatory body (EPA for US, European Commission, ECHA, ANSES for FR, DWI for UK, UBA for DE). Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'Full legal citation or reference to the regulation in the Code of Federal Regulations (CFR), state code, or local ordinance (e.g., 40 CFR 141.80). Ref: EPA SDWA.',
    `regulatory_framework` STRING COMMENT 'Name of the governing regulatory framework (e.g. US_SDWA, EU_DWD_2020_2184, EU_WFD_2000_60_EC, EU_UWWTD_91_271_EEC, REACH_PFAS_RESTRICTION). Enables multi-jurisdictional compliance tracking where EU Water Framework Directive defines surface-water ecological/chemical status differently from US CWA frameworks. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Citation to the governing directive/statute, e.g. EU Drinking Water Directive 2020/2184; REACH PFAS restriction; Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `regulatory_program` STRING COMMENT 'The regulatory program or framework under which this requirement is issued. SDWA = Safe Drinking Water Act, CWA = Clean Water Act, NPDES = National Pollutant Discharge Elimination System, LCRR = Lead and Copper Rule Revisions, DBP = Disinfection Byproduct, SWTR = Surface Water Treatment Rule, GWR = Ground Water Rule, TCR = Total Coliform Rule, RTCR = Revised Total Coliform Rule. [ENUM-REF-CANDIDATE: SDWA|CWA|NPDES|LCRR|DBP|SWTR|GWR|TCR|RTCR|pretreatment|state_primacy|local_ordinance — 12 candidates stripped; promote to reference product]',
    `regulatory_region` STRING COMMENT 'Regulatory region or framework (e.g., EU DWD 2020/2184, REACH, WFD 2000/60/EC). Ref: EPA SDWA.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for regulatory jurisdiction (US, EU, FR, UK, DE, etc.)',
    `reporting_frequency` STRING COMMENT 'Required frequency of regulatory reporting (e.g., monthly, quarterly, annually). Null if not applicable. Ref: EPA SDWA.',
    `requirement_category` STRING COMMENT 'Classification of the type of regulatory obligation. MCL = Maximum Contaminant Level, MCLG = Maximum Contaminant Level Goal. [ENUM-REF-CANDIDATE: monitoring|reporting|operational_standard|MCL|MCLG|treatment_technique|permit_condition|discharge_limit — 8 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `requirement_code` STRING COMMENT 'Unique business identifier or citation code for the regulatory requirement (e.g., 40 CFR 141.80, LCRR-2021, NPDES-001).',
    `requirement_description` STRING COMMENT 'Detailed description of the regulatory requirement, including the specific obligation imposed on the utility (e.g., monitoring frequency, reporting format, operational standard). Ref: EPA SDWA.',
    `requirement_name` STRING COMMENT 'Requirement name. Ref: EPA SDWA.',
    `requirement_title` STRING COMMENT 'Official title or short name of the regulatory requirement (e.g., Lead and Copper Rule Revisions, Maximum Contaminant Level for Arsenic). Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Name of the internal department or business unit responsible for ensuring compliance with this requirement (e.g., Water Quality, Wastewater Operations, Environmental Compliance). Ref: EPA SDWA.',
    `revision_date` DATE COMMENT 'Date of the most recent revision or amendment to the regulatory requirement. Null if never revised. Ref: EPA SDWA.',
    `superseded_requirement_code` STRING COMMENT 'Citation or code of the previous regulatory requirement that this requirement supersedes or replaces. Null if not applicable. Ref: EPA SDWA.',
    `treatment_technique_description` STRING COMMENT 'Description of the required treatment technique or operational standard when an MCL is not feasible (e.g., filtration, disinfection contact time). Null if not applicable. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `us_cfr_reference` STRING COMMENT 'US Code of Federal Regulations reference. Ref: EPA SDWA.',
    `us_regulation_reference` STRING COMMENT 'US federal/state regulation citation e.g. 40 CFR Part 141 (NPDWR), LCRR.',
    `wfd_environmental_quality_standard` DECIMAL(18,2) COMMENT 'Numeric Environmental Quality Standard (EQS) value as defined under EU WFD Annex V or Priority Substances Directive 2013/39/EU. EQS are expressed as annual average (AA-EQS) or maximum allowable concentration (MAC-EQS), differing from US water quality criteria which use CMC/CCC terminology. Ref: EPA SDWA.',
    `wfd_quality_element_category` STRING COMMENT 'EU Water Framework Directive quality element category: biological (phytoplankton, macrophytes, benthic invertebrates, fish), hydromorphological, or physico-chemical. The WFD one-out-all-out principle means the worst-scoring element determines overall surface-water status, unlike US impairment listing which is parameter-specific. Ref: EPA SDWA.',
    `wfd_surface_water_status_class` STRING COMMENT 'EU WFD ecological status classification: High, Good, Moderate, Poor, Bad. Under WFD Article 4, member states must achieve Good status for all water bodies. This five-class system differs from US CWA designated-use attainment which is binary (attaining/not attaining). Ref: EPA SDWA.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Catalog of all applicable federal, state, and local regulatory requirements that the utility must comply with, including SDWA rules (LCRR, DBP rules, Surface Water Treatment Rule), CWA requirements, EPA MCLs/MCLGs, state primacy agency rules, NPDES general permits, and local pretreatment standards. Tracks the regulation citation, regulatory program, effective date, compliance deadline, applicable facility types, and the specific operational or reporting obligation imposed. Serves as the master compliance obligation registry.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the specific permit (NPDES, IUP, state primacy agency permit) associated with this obligation, if applicable. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance obligations incur costs tracked to specific cost centers (lab, operations, regulatory affairs). Critical for activity-based costing, budget allocation, and cost recovery in rate cases. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility to which this obligation applies. Ref: EPA SDWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Compliance obligations require budget appropriations for monitoring, reporting, and capital improvements. Essential for compliance budget planning and tracking expenditures against regulatory deadline. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance obligations (sampling, reporting, inspections) must be assigned to specific employees for accountability. Tracks who is responsible for completing each regulatory task and supports workload. Ref: EPA SDWA.',
    `obligation_responsible_employee_id` BIGINT COMMENT 'Responsible party. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Reference to the parent regulatory requirement or permit condition from which this obligation is derived. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Compliance obligations (e.g., consent order milestones) often require execution of specific sampling plans. Direct link tracks fulfillment mechanism and enables automated obligation status reporting b. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Compliance obligations frequently require vendor services (laboratory testing, equipment calibration, consulting) to fulfill regulatory requirements. Tracks which vendor is responsible for obligation. Ref: EPA SDWA.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to fulfill this compliance obligation, in US dollars, captured for budget tracking and cost analysis. Ref: EPA SDWA.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours expended to complete this compliance obligation, captured for performance analysis and future estimation accuracy. Ref: EPA SDWA.',
    `completed_by` STRING COMMENT 'Name or identifier of the individual who completed and documented the compliance obligation, for accountability and audit purposes. Ref: EPA SDWA.',
    `completion_date` DATE COMMENT 'The actual date on which the compliance obligation was fulfilled and documented. Null if not yet completed. Ref: EPA SDWA.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the compliance obligation was marked as completed in the system, including time zone information for audit trail purposes. Ref: EPA SDWA.',
    `contact_email` STRING COMMENT 'Email address of the regulatory agency contact person for correspondence related to this compliance obligation. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person` STRING COMMENT 'Name of the regulatory agency contact person or inspector associated with this obligation, for coordination and communication purposes. Ref: EPA SDWA.',
    `contact_phone` STRING COMMENT 'Phone number of the regulatory agency contact person for inquiries and coordination related to this compliance obligation. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance obligation record was first created in the system, for audit trail and lifecycle tracking. Ref: EPA SDWA.',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation, including specific actions required, parameters to be monitored or reported, and any special conditions or instructions. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'The date by which this compliance obligation must be completed or submitted to the regulatory authority. Ref: EPA SDWA.',
    `effective_end_date` DATE COMMENT 'The date on which this compliance obligation expires or is superseded, often aligned with permit expiration or regulatory sunset. Null for ongoing obligations. Ref: EPA SDWA.',
    `effective_start_date` DATE COMMENT 'The date from which this compliance obligation becomes active and enforceable, typically aligned with permit issuance or regulatory effective date. Ref: EPA SDWA.',
    `escalation_required` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation requires escalation to senior management or regulatory affairs due to complexity, risk, or overdue status. Ref: EPA SDWA.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost (labor, materials, contractor fees, laboratory analysis fees) to fulfill this compliance obligation, in US dollars. Ref: EPA SDWA.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete this compliance obligation, used for resource planning and workload management. Ref: EPA SDWA.',
    `evidence_of_fulfillment` STRING COMMENT 'Description or reference to documentation proving completion of the obligation (e.g., laboratory report number, DMR submission confirmation, training certificate number, inspection report ID). Ref: EPA SDWA.',
    `is_critical_path` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation is on the critical path for permit renewal, regulatory approval, or operational continuity. True if delay would have cascading regulatory or operational consequences. Ref: EPA SDWA.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this compliance obligation record. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance obligation record was last updated, for change tracking and audit purposes. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, historical notes, or clarifications related to this compliance obligation. Ref: EPA SDWA.',
    `obligation_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the compliance obligation, used in operational communications and reporting. Ref: EPA SDWA.',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation: pending (not yet started), in-progress (work underway), completed (fulfilled and documented), overdue (past due date without completion), waived (exempted by regulatory authority), or cancelled (no longer required). Ref: EPA SDWA.. Valid values are `pending|in-progress|completed|overdue|waived|cancelled`',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by activity type: monitoring (water quality testing, effluent sampling), reporting (MOR, DMR, CCR), operational (process control, treatment standards), training (operator certification, safety), inspection (regulatory site visits, internal audits), or maintenance (asset upkeep, preventive maintenance). Ref: EPA SDWA.. Valid values are `monitoring|reporting|operational|training|inspection|maintenance`',
    `priority_level` STRING COMMENT 'Business priority assigned to this compliance obligation based on regulatory significance, potential enforcement consequences, and operational impact: critical (immediate regulatory risk), high (significant risk), medium (moderate risk), or low (routine compliance). Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `recurrence_interval` STRING COMMENT 'Numeric interval for recurring obligations (e.g., 1 for monthly, 3 for quarterly, 12 for annually). Used in conjunction with recurrence_pattern for scheduling. Ref: EPA SDWA.',
    `recurrence_pattern` STRING COMMENT 'Frequency with which this obligation recurs: one-time (single event), daily, weekly, monthly (e.g., MOR submission), quarterly, annually (e.g., CCR publication), or as-needed (triggered by specific events). [ENUM-REF-CANDIDATE: one-time|daily|weekly|monthly|quarterly|annually|as-needed — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory agency or authority to which this obligation must be reported or demonstrated (e.g., EPA Region 5, State Department of Environmental Quality, County Health Department). Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'Specific citation to the regulatory source (SDWA section, CWA section, CFR part, state regulation, permit condition number) that mandates this obligation. Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Department or division within the organization accountable for fulfilling this obligation (e.g., Operations, Environmental Compliance, Laboratory, Maintenance). Ref: EPA SDWA.',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual, role, or organizational unit responsible for completing this compliance obligation (e.g., Chief Operator, Environmental Compliance Manager, Laboratory Director). Ref: EPA SDWA.',
    `risk_category` STRING COMMENT 'Primary risk domain associated with non-compliance: public-health (drinking water safety, MCL violations), environmental (discharge limits, ecosystem impact), financial (penalties, fines), operational (permit suspension, operational restrictions), or reputational (public trust, media exposure). Ref: EPA SDWA.. Valid values are `public-health|environmental|financial|operational|reputational`',
    `submission_confirmation_number` STRING COMMENT 'Confirmation or tracking number received from the regulatory authority upon successful submission of the compliance deliverable (e.g., NetDMR confirmation ID). Ref: EPA SDWA.',
    `submission_method` STRING COMMENT 'Method by which the compliance obligation deliverable was submitted to the regulatory authority: electronic (e.g., NetDMR, state portal), paper (mailed hard copy), in-person (hand-delivered), or not-applicable (internal obligation with no external submission). Ref: EPA SDWA.. Valid values are `electronic|paper|in-person|not-applicable`',
    `title` STRING COMMENT 'Short descriptive title of the compliance obligation for quick identification and reporting purposes. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this compliance obligation record in the system. Ref: EPA SDWA.',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational compliance task or obligation derived from a regulatory requirement or permit condition, assigned to a specific facility, system, or organizational unit. Tracks the obligation type (monitoring, reporting, operational, training, inspection), responsible party, due date, recurrence schedule, associated regulatory requirement or permit condition, completion status, and evidence of fulfillment. Bridges the gap between abstract regulatory requirements and day-to-day compliance activities.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` (
    `dmr_id` BIGINT COMMENT 'Unique identifier for the discharge monitoring report record. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: DMRs document operational changes due to capital projects during the reporting period (plant expansion impacting discharge flow/quality, new treatment process affecting effluent characteristics). Requ. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this discharge monitoring report is filed. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: DMR preparation involves lab analysis, staff time, and submission costs tracked to cost centers. Needed for activity-based costing and regulatory compliance cost allocation in rate cases. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the wastewater treatment plant or water treatment plant facility that generated this discharge monitoring report. Ref: EPA SDWA.',
    `original_dmr_id` BIGINT COMMENT 'Reference to the original discharge monitoring report record if this is a resubmission or correction. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'Reference to the specific discharge outfall or monitoring point where effluent samples were collected for this report. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency receiving this DMR submission, enabling multi-jurisdictional routing (US EPA, ANSES, DWI, UBA, European Commission). Ref: EPA SDWA.',
    `regulatory_submission_id` BIGINT COMMENT 'The unique submission identifier assigned by the EPA NetDMR electronic reporting system when this discharge monitoring report was submitted electronically. Ref: EPA SDWA.',
    `acknowledgment_date` DATE COMMENT 'The date on which the regulatory authority acknowledged receipt of this discharge monitoring report. Ref: EPA SDWA.',
    `certification_date` DATE COMMENT 'The date on which the certifying official signed and certified this discharge monitoring report, attesting to its accuracy under penalty of law. Ref: EPA SDWA.',
    `certification_statement` STRING COMMENT 'The full text of the legal certification statement signed by the certifying official, typically stating that the report was prepared under their direction and supervision and that the information is true, accurate, and complete to the best of their knowledge. Ref: EPA SDWA.',
    `certifying_official_name` STRING COMMENT 'The full name of the authorized signatory who certified the accuracy and completeness of this discharge monitoring report (typically a principal executive officer or ranking elected official). Ref: EPA SDWA.',
    `certifying_official_title` STRING COMMENT 'The job title or position of the authorized signatory who certified this discharge monitoring report (e.g., General Manager, Mayor, Director of Public Works). Ref: EPA SDWA.',
    `comments` STRING COMMENT 'Additional comments, explanations, or notes provided by the facility regarding this discharge monitoring report, including explanations for exceedances, operational issues, or data quality concerns. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge monitoring report record was first created in the system. Ref: EPA SDWA.',
    `directive_reference` STRING COMMENT 'Specific EU directive reference (91/271/EEC, 2000/60/EC) or US CFR citation (40 CFR 122.41) governing this discharge monitoring submission. Ref: EPA SDWA.',
    `dmr_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this discharge monitoring report, often assigned by the regulatory authority or internal tracking system. Ref: EPA SDWA.',
    `dmr_status` STRING COMMENT 'DMR status. Ref: EPA SDWA.',
    `eu_competent_authority_code` STRING COMMENT 'Code of EU member state competent authority receiving the report (e.g., ANSES, DWI, UBA regional offices). Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (Drinking Water Directive 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC, REACH PFAS restriction). Ref: EPA SDWA.',
    `eu_discharge_directive_reference` STRING COMMENT 'EU discharge framework (Urban Wastewater Treatment Directive 91/271/EEC, Water Framework Directive 2000/60/EC) for EU-flavor DMR-equivalent submissions. Ref: EPA SDWA.',
    `eu_reporting_directive` STRING COMMENT 'EU directive under which this report is submitted (e.g. UWWTD 91/271/EEC Article 15, WFD 2000/60/EC Article 15). NULL for US DMRs. Ref: EPA SDWA.',
    `eu_uwwtd_reference` STRING COMMENT 'EU Urban Wastewater Treatment Directive 91/271/EEC / WFD 2000/60/EC reference. Ref: EPA SDWA.',
    `eu_uwwtd_reporting_flag` BOOLEAN COMMENT 'Indicates if report satisfies EU Urban Wastewater Treatment Directive 91/271/EEC Article 15 reporting requirements. Ref: EPA SDWA.',
    `exceedance_count` STRING COMMENT 'The total number of individual parameter measurements within this discharge monitoring report that exceeded their respective permit limits. Ref: EPA SDWA.',
    `is_no_discharge` BOOLEAN COMMENT 'No discharge flag. Ref: EPA SDWA.',
    `issuing_authority_name` STRING COMMENT 'Name of the regulatory authority receiving this DMR (US EPA, Environment Agency (UK), Agence de leau (FR), Landesumweltamt (DE)). Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'Reporting jurisdiction (US NPDES vs EU UWWTD 91/271/EEC / WFD 2000/60/EC self-monitoring). Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction for this DMR submission. US utilities submit to EPA/state; EU utilities submit equivalent self-monitoring reports under UWWTD 91/271/EEC to national competent authorities. Ref: EPA SDWA.',
    `jurisdiction_region` STRING COMMENT 'Sub-national or supra-national region qualifier, e.g. US state abbreviation, EU member state, UK nation (England/Wales/Scotland), German Bundesland. Supports multi-level regulatory hierarchy. Ref: EPA SDWA.',
    `jurisdiction_region_code` STRING COMMENT 'ISO region code for DMR jurisdiction (US, EU, FR, UK, DE). US DMRs submitted to EPA/state; EU equivalents submitted under UWWTD 91/271/EEC or WFD 2000/60/EC reporting.',
    `jurisdictional_report_type` STRING COMMENT 'Report flavor: US NPDES DMR vs EU UWWTD self-monitoring report. Ref: EPA SDWA.',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report was submitted after the regulatory deadline (True if late, False if on time). Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this discharge monitoring report record. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge monitoring report record was last modified or updated. Ref: EPA SDWA.',
    `monitoring_location_code` STRING COMMENT 'The alphanumeric code identifying the specific monitoring location or sampling point as designated in the NPDES permit (e.g., 001, 002, EFF-1). Ref: EPA SDWA.',
    `no_discharge_flag` BOOLEAN COMMENT 'Indicates whether there was no discharge from the outfall during the reporting period (True if no discharge occurred, False if discharge occurred). Ref: EPA SDWA.',
    `no_discharge_reason` STRING COMMENT 'Explanation for why no discharge occurred during the reporting period (e.g., facility shutdown, seasonal operations, maintenance outage). Ref: EPA SDWA.',
    `noncompliance_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report contains any parameter measurements that exceeded permitted limits, triggering a noncompliance event (True if noncompliance detected, False if all parameters within limits). Ref: EPA SDWA.',
    `preparer_email` STRING COMMENT 'The email address of the individual who prepared this discharge monitoring report. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The full name of the individual who prepared and compiled this discharge monitoring report. Ref: EPA SDWA.',
    `preparer_phone` STRING COMMENT 'The contact phone number for the individual who prepared this discharge monitoring report. Ref: EPA SDWA.',
    `preparer_title` STRING COMMENT 'The job title or position of the individual who prepared this discharge monitoring report (e.g., Environmental Compliance Manager, Laboratory Supervisor).',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_authority` STRING COMMENT 'The regulatory body to which this discharge monitoring report was submitted (EPA for direct federal permits or state primacy agency for delegated state programs). Ref: EPA SDWA.. Valid values are `epa|state_primacy_agency`',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory agency or body with oversight, e.g. US EPA, state primacy agency, European Commission DG Environment, French ANSES, UK DWI (Drinking Water Inspectorate), German UBA (Umweltbundesamt), Australian NHMRC. Ref: EPA SDWA.',
    `regulatory_directive_reference` STRING COMMENT 'Specific directive, rule, or regulation citation, e.g. 40 CFR 141 (US NPDWR), Directive 2020/2184/EU Article 13, Directive 91/271/EEC Annex I, REACH Annex XVII PFAS restriction, French Code de la sante publique R.1321.',
    `regulatory_framework` STRING COMMENT 'Governing framework for discharge monitoring: US_CWA_NPDES, EU_UWWTD_91_271_EEC, EU_WFD_2000_60_EC, or national transposition (e.g. DE_AbwV, FR_Arrete_2015). EU UWWTD requires different parameters and agglomeration-based reporting vs US facility-based DMR. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Framework under which the monitoring report is filed, e.g. EU Drinking Water Directive 2020/2184; REACH PFAS restriction; Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'The regulatory region value recorded for each dmr in the compliance domain.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for DMR jurisdiction (US, EU, FR, UK, DE)',
    `rejection_reason` STRING COMMENT 'Explanation provided by the regulatory authority if this discharge monitoring report was rejected, including specific deficiencies or errors that must be corrected. Ref: EPA SDWA.',
    `reporting_frequency` STRING COMMENT 'The frequency at which this discharge monitoring report must be submitted as specified in the NPDES permit (monthly, quarterly, annual, semi-annual, or weekly). Ref: EPA SDWA.. Valid values are `monthly|quarterly|annual|semi-annual|weekly`',
    `reporting_period_end` DATE COMMENT 'Period end. Ref: EPA SDWA.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the monitoring period covered by this discharge monitoring report (typically the last day of the month or quarter). Ref: EPA SDWA.',
    `reporting_period_start` DATE COMMENT 'Period start. Ref: EPA SDWA.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the monitoring period covered by this discharge monitoring report (typically the first day of the month or quarter). Ref: EPA SDWA.',
    `resubmission_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report is a resubmission of a previously rejected or corrected report (True if resubmission, False if original submission). Ref: EPA SDWA.',
    `state_agency_name` STRING COMMENT 'The name of the state environmental or water quality agency that received this discharge monitoring report if submitted under a state-delegated NPDES program. Ref: EPA SDWA.',
    `submission_date` DATE COMMENT 'The date on which this discharge monitoring report was submitted to the EPA or state NPDES authority. Ref: EPA SDWA.',
    `submission_due_date` DATE COMMENT 'The regulatory deadline by which this discharge monitoring report must be submitted (typically the 28th day of the month following the reporting period). Ref: EPA SDWA.',
    `submission_method` STRING COMMENT 'The method by which this discharge monitoring report was submitted to the regulatory authority (NetDMR electronic system, paper mail, email, state-specific portal, or other). Ref: EPA SDWA.. Valid values are `netdmr|paper|email|state_portal|other`',
    `submission_status` STRING COMMENT 'The current status of this discharge monitoring report in the submission and review workflow (draft, submitted, accepted by authority, rejected, under review, or resubmitted after corrections). Ref: EPA SDWA.. Valid values are `draft|submitted|accepted|rejected|under_review|resubmitted`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `uwwtd_agglomeration_code` DECIMAL(18,2) COMMENT 'EU Urban Wastewater Treatment Directive 91/271/EEC agglomeration identifier. Used for EU discharge monitoring reports submitted to the European Commission under Article 15. Ref: EPA SDWA.',
    `uwwtd_treatment_level` STRING COMMENT 'Treatment level classification per UWWTD 91/271/EEC: primary, secondary, more_stringent (nutrient removal). Determines applicable emission limit values in EU jurisdictions. Ref: EPA SDWA.',
    `wfd_water_body_code` STRING COMMENT 'EU Water Framework Directive 2000/60/EC receiving water body identifier. Links discharge monitoring to WFD environmental quality standards and good ecological status objectives. Ref: EPA SDWA.',
    `wfd_water_body_status_impact` STRING COMMENT 'Impact assessment on receiving water body status per Water Framework Directive 2000/60/EC: GOOD, MODERATE, POOR, BAD. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this discharge monitoring report record. Ref: EPA SDWA.',
    CONSTRAINT pk_dmr PRIMARY KEY(`dmr_id`)
) COMMENT 'Discharge Monitoring Report (DMR) submitted to the EPA or state NPDES authority documenting actual effluent quality measurements against permitted limits for a specific reporting period. Tracks the permit number, outfall or monitoring point, reporting period (monthly, quarterly), parameter results (BOD, TSS, pH, flow in MGD), exceedance flags, submission date, submission method (NetDMR, paper), preparer, and certifying official. Core regulatory reporting artifact for WWTP and WTP discharge compliance under CWA/NPDES.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` (
    `dmr_result_id` BIGINT COMMENT 'Unique identifier for the individual parameter measurement result recorded on a Discharge Monitoring Report. Primary key for granular compliance tracking at the parameter level. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this discharge monitoring result is reported. Establishes the regulatory framework and limits applicable to this measurement. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this record. Required for regulatory audit trails and accountability in compliance reporting. Ref: EPA SDWA.',
    `dmr_id` BIGINT COMMENT 'Parent DMR. Ref: EPA SDWA.',
    `dmr_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this record. Required for regulatory audit trails and accountability in compliance reporting. Ref: EPA SDWA.',
    `dmr_submission_id` BIGINT COMMENT 'Reference to the parent DMR submission that contains this parameter result. Links the individual measurement to the overall monthly or quarterly discharge report. Ref: EPA SDWA.',
    `finished_water_production_id` BIGINT COMMENT 'Foreign key linking to treatment.finished_water_production. Business justification: DMR results report finished water quality parameters from treatment production records. Business process: NPDES discharge monitoring where finished water quality data (turbidity, chlorine residual, pH. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'The unique identifier assigned by the laboratory to this sample. Enables traceability to laboratory records, chain of custody documentation, and quality control data. Ref: EPA SDWA.',
    `laboratory_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the analysis. Required for audit trails and quality assurance verification. Ref: EPA SDWA.',
    `outfall_id` BIGINT COMMENT 'Reference to the specific discharge outfall or monitoring point where this sample was collected. Critical for tracking location-specific compliance. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Reference to the certified laboratory that performed the analysis. Required for audit trails and quality assurance verification. Ref: EPA SDWA.',
    `analysis_date` DATE COMMENT 'The date on which the laboratory analysis was performed. Used to verify compliance with holding time requirements for various parameters. Ref: EPA SDWA.',
    `analytical_method` STRING COMMENT 'The EPA-approved analytical method used to measure this parameter (e.g., SM 5210B for BOD, EPA 410.4 for COD, SM 2540D for TSS, EPA 300.0 for nitrate). Ensures measurement accuracy and regulatory acceptance. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for this parameter result (compliant, non-compliant, not applicable, pending review). Drives enforcement workflows and regulatory reporting. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|not_applicable|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this DMR result record was first created in the system. Supports audit trails and data lineage tracking. Ref: EPA SDWA.',
    `data_quality_flag` BOOLEAN COMMENT 'Internal quality assurance flag indicating the reliability of this measurement result (valid, suspect, invalid, pending review). Used for data validation workflows before regulatory submission. Ref: EPA SDWA.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration that can be reliably detected by the analytical method used. Important for interpreting results below detection limits and assessing method adequacy. Ref: EPA SDWA.',
    `enforcement_action_required` BOOLEAN COMMENT 'Boolean indicator of whether this result triggers a mandatory enforcement action under the permit or regulatory framework. True initiates enforcement workflows. Ref: EPA SDWA.',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measured value exceeded the permit limit. True indicates a violation requiring reporting and potential enforcement action. Ref: EPA SDWA.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the measured value exceeded the permit limit, calculated as ((measured_value - permit_limit) / permit_limit) * 100. Quantifies the severity of violations. Ref: EPA SDWA.',
    `is_violation` BOOLEAN COMMENT 'Violation flag. Ref: EPA SDWA.',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value. Ref: EPA SDWA.',
    `measurement_frequency` STRING COMMENT 'The frequency at which this parameter is required to be monitored under the permit (daily, weekly, monthly, quarterly, annual, continuous). Determines sampling schedule and compliance evaluation periods. Ref: EPA SDWA.. Valid values are `daily|weekly|monthly|quarterly|annual|continuous`',
    `measurement_value` DECIMAL(18,2) COMMENT 'The actual numeric value measured for this parameter during the monitoring period. Precision supports a wide range of parameter types from trace contaminants to high-volume flow measurements. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this DMR result record was last modified. Tracks data quality corrections, resubmissions, and audit trail requirements. Ref: EPA SDWA.',
    `monitoring_location_code` STRING COMMENT 'The specific monitoring point or location code as designated in the NPDES permit. May differ from outfall_id for internal monitoring points or upstream/downstream reference locations. Ref: EPA SDWA.',
    `nodi_code` STRING COMMENT 'EPA code indicating why no measurement data is reported for a required parameter (e.g., 9 for no discharge, C for facility not operational, Q for quality assurance issue). Used when measurement_value is null. Ref: EPA SDWA.',
    `number_of_exceedances` STRING COMMENT 'The count of individual samples that exceeded the permit limit during the reporting period. Used for compliance tracking and violation severity assessment. Ref: EPA SDWA.',
    `number_of_samples` STRING COMMENT 'The total number of individual samples collected and analyzed during the reporting period for this parameter. Used to calculate statistical bases like monthly averages. Ref: EPA SDWA.',
    `parameter` STRING COMMENT 'Parameter. Ref: EPA SDWA.',
    `parameter_code` STRING COMMENT 'Standardized code identifying the specific effluent parameter being measured (e.g., 00310 for BOD, 00340 for COD, 00530 for TSS, 00600 for TDS, 00400 for pH, 50050 for flow, 31616 for fecal coliform, 00620 for nitrate, 00665 for phosphorus). Uses EPA parameter codes from the STORET database. Ref: EPA SDWA.',
    `parameter_name` STRING COMMENT 'Human-readable name of the effluent parameter being measured (e.g., Biochemical Oxygen Demand, Chemical Oxygen Demand, Total Suspended Solids, Total Dissolved Solids, pH, Flow, Fecal Coliform, Nitrate, Phosphorus). Ref: EPA SDWA.',
    `permit_limit_type` STRING COMMENT 'The type of limit specified in the permit (maximum concentration, minimum value, acceptable range, or narrative standard). Determines how compliance is evaluated. Ref: EPA SDWA.. Valid values are `maximum|minimum|range|narrative`',
    `permit_limit_value` DECIMAL(18,2) COMMENT 'The numeric limit specified in the NPDES permit for this parameter and statistical base. Used for direct comparison with the measured value to determine compliance status.',
    `qa_qc_notes` STRING COMMENT 'Free-text notes documenting quality assurance or quality control issues, corrective actions, or special circumstances affecting this measurement. Supports audit trails and regulatory inquiries. Ref: EPA SDWA.',
    `qualifier_code` STRING COMMENT 'Code indicating special conditions affecting the measurement (e.g., < for below detection limit, > for above quantification limit, E for estimated value, J for value below reporting limit but above detection limit). Ref: EPA SDWA.',
    `quantification_limit` DECIMAL(18,2) COMMENT 'The minimum concentration that can be reliably quantified by the analytical method. Typically higher than the detection limit and used for regulatory compliance evaluation. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the monitoring period covered by this DMR result (typically the last day of the month for monthly reporting). Ref: EPA SDWA.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the monitoring period covered by this DMR result (typically the first day of the month for monthly reporting). Ref: EPA SDWA.',
    `sample_collection_date` DATE COMMENT 'The date on which the sample was collected from the outfall for laboratory analysis or field measurement. Critical for tracking temporal compliance patterns. Ref: EPA SDWA.',
    `sample_collection_time` TIMESTAMP COMMENT 'The precise timestamp when the sample was collected. Important for grab samples and instantaneous measurements where timing affects results. Ref: EPA SDWA.',
    `sample_type` STRING COMMENT 'The type of sample collected for this measurement (grab sample, composite sample, or continuous monitoring). Affects data interpretation and compliance evaluation. Ref: EPA SDWA.. Valid values are `grab|composite|continuous`',
    `statistical_base` STRING COMMENT 'The statistical qualifier or basis for the reported value (e.g., daily maximum, monthly average, weekly average, annual average, instantaneous, geometric mean). Determines how the measurement is compared against permit limits. [ENUM-REF-CANDIDATE: daily_maximum|daily_minimum|monthly_average|weekly_average|annual_average|instantaneous|geometric_mean — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when this result was submitted to the regulatory agency through NetDMR or other electronic reporting system. Establishes the official compliance record timestamp. Ref: EPA SDWA.',
    `submitted_to_regulator_flag` BOOLEAN COMMENT 'Boolean indicator of whether this result has been officially submitted to the regulatory agency as part of the DMR. True indicates the data is part of the official compliance record. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measurement value is expressed (e.g., mg/L for BOD/COD/TSS/TDS, standard units for pH, MGD or GPM for flow, MPN/100mL for fecal coliform, mg/L as N for nitrate, mg/L as P for phosphorus). Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `violation_category` STRING COMMENT 'Classification of the type of violation if non-compliant (effluent limit exceedance, monitoring frequency violation, reporting violation, or none). Used for enforcement prioritization and trend analysis. Ref: EPA SDWA.. Valid values are `effluent_limit|monitoring_frequency|reporting|none`',
    CONSTRAINT pk_dmr_result PRIMARY KEY(`dmr_result_id`)
) COMMENT 'Individual parameter measurement result recorded on a Discharge Monitoring Report, capturing the specific effluent parameter (BOD, COD, TSS, TDS, pH, flow, fecal coliform, nitrate, phosphorus), measured value, units, measurement frequency, statistical qualifier (daily max, monthly average, weekly average), permit limit for comparison, exceedance indicator, and analytical method used. Enables granular compliance tracking at the parameter level for each DMR submission.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`mor` (
    `mor_id` BIGINT COMMENT 'Unique identifier for the Monthly Operating Report record. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Monthly operating reports document operational changes due to capital projects (new treatment process online, capacity increase, process modifications). Required for explaining operational variations. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Permit. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility. Ref: EPA SDWA.',
    `mor_wtp_facility_id` BIGINT COMMENT 'Identifier of the water treatment plant facility for which this MOR is submitted. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Monthly Operating Reports must be prepared by licensed operators. Links MOR to specific employee for license verification, training tracking, and regulatory audit trail. Replaces denormalized preparer. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency receiving this MOR, supporting multi-jurisdictional submission (state primacy agencies, ANSES, DWI, UBA). Ref: EPA SDWA.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: The Monthly Operating Report (MOR) is a recurring regulatory submission to the state primacy agency. The mor table tracks submission_date and submission_method, which are submission metadata that belo. Ref: EPA SDWA.',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: Monthly Operating Reports aggregate treatment performance data from specific sampling locations (raw water intake, finished water, distribution system). Essential for correlating operational data with. Ref: EPA SDWA.',
    `agency_response_date` DATE COMMENT 'Date on which the state primacy agency responded to or acknowledged the submitted MOR. Ref: EPA SDWA.',
    `agency_response_received` BOOLEAN COMMENT 'Indicates whether a response or acknowledgment was received from the state primacy agency after submission. Ref: EPA SDWA.',
    `alkalinity_avg_mg_l` DECIMAL(18,2) COMMENT 'Average alkalinity of finished water during the reporting month. Ref: EPA SDWA.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow rate of treated water produced during the reporting month. Ref: EPA SDWA.',
    `certification_date` DATE COMMENT 'The date on which the certified operator signed and certified the MOR. Ref: EPA SDWA.',
    `certification_status` STRING COMMENT 'Current status of the MOR in the certification and submission workflow. Ref: EPA SDWA.. Valid values are `draft|certified|submitted|accepted|rejected|under_review`',
    `certifier_license_number` STRING COMMENT 'State-issued water treatment operator license number of the certifying operator. Ref: EPA SDWA.',
    `certifier_name` STRING COMMENT 'Full name of the certified operator who reviewed and certified the accuracy of the MOR. Ref: EPA SDWA.',
    `coagulant_dosage_avg_mg_l` DECIMAL(18,2) COMMENT 'Average coagulant dosage applied during the reporting month. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOR record was first created in the system. Ref: EPA SDWA.',
    `ct_compliance_status` STRING COMMENT 'Indicates whether the achieved CT value met or exceeded the required CT value for the reporting month. Ref: EPA SDWA.. Valid values are `compliant|non_compliant`',
    `ct_value_achieved` DECIMAL(18,2) COMMENT 'Calculated CT value (disinfectant concentration multiplied by contact time) achieved for pathogen inactivation during the reporting month. Ref: EPA SDWA.',
    `ct_value_required` DECIMAL(18,2) COMMENT 'Regulatory CT value required for adequate pathogen inactivation based on water temperature and pH. Ref: EPA SDWA.',
    `directive_reference` STRING COMMENT 'Specific directive or regulation reference (EU DWD 2020/2184, UK Water Supply Regulations 2016, German TrinkwV 2023) governing this operational report. Ref: EPA SDWA.',
    `disinfectant_residual_avg_mg_l` DECIMAL(18,2) COMMENT 'Average disinfectant residual concentration in the distribution system during the reporting month. Ref: EPA SDWA.',
    `disinfectant_residual_min_mg_l` DECIMAL(18,2) COMMENT 'Minimum disinfectant residual concentration recorded in the distribution system during the reporting month. Ref: EPA SDWA.',
    `disinfectant_type` STRING COMMENT 'Primary disinfection method used at the treatment plant during the reporting month. Ref: EPA SDWA.. Valid values are `chlorine|chloramine|chlorine_dioxide|ozone|uv`',
    `eu_competent_authority_code` STRING COMMENT 'Code of EU member state competent authority: ANSES (FR), DWI (UK), UBA (DE), or regional equivalent. Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (Drinking Water Directive 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC, REACH PFAS restriction). Ref: EPA SDWA.',
    `eu_dwd_operational_monitoring_flag` DECIMAL(18,2) COMMENT 'Indicates if report satisfies EU Drinking Water Directive 2020/2184 operational monitoring requirements. Ref: EPA SDWA.',
    `eu_dwd_parametric_compliance_flag` BOOLEAN COMMENT 'Indicates whether all parametric values per EU Drinking Water Directive 2020/2184 Annex I were met during the reporting month. EU equivalent of US MOR compliance status. Ref: EPA SDWA.',
    `eu_dwd_reference` STRING COMMENT 'EU Drinking Water Directive 2020/2184 operational monitoring reference. Ref: EPA SDWA.',
    `eu_operating_directive_reference` STRING COMMENT 'EU operating-report basis under Drinking Water Directive 2020/2184 / Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `eu_operational_monitoring_compliance_flag` DECIMAL(18,2) COMMENT 'Flag indicating compliance with EU DWD 2020/2184 Article 13 operational monitoring requirements. Null for non-EU jurisdictions. Ref: EPA SDWA.',
    `eu_operational_monitoring_reference` STRING COMMENT 'Reference to EU DWD 2020/2184 Annex II Part A operational monitoring parameters or equivalent national transposition article. NULL for US MORs. Ref: EPA SDWA.',
    `eu_risk_assessment_reference` STRING COMMENT 'Reference to the EU DWD 2020/2184 Article 7 risk-based approach assessment (catchment to tap) applicable to this operational reporting period. Ref: EPA SDWA.',
    `finished_water_turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Average turbidity of finished treated water leaving the plant during the reporting month. Ref: EPA SDWA.',
    `finished_water_turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Maximum turbidity of finished treated water recorded during the reporting month. Ref: EPA SDWA.',
    `fluoride_avg_mg_l` DECIMAL(18,2) COMMENT 'Average fluoride concentration in finished water during the reporting month. Ref: EPA SDWA.',
    `international_framework_reference` STRING COMMENT 'Applicable international framework: US SDWA/SWTR, EU DWD 2020/2184, EU WFD 2000/60/EC, or national regulation. Ref: EPA SDWA.',
    `issuing_authority_name` STRING COMMENT 'Name of the regulatory authority receiving this MOR (state primacy agency, DWI, ANSES, UBA, Gesundheitsamt). Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'Reporting jurisdiction (US SDWA/state MOR vs EU DWD 2020/2184 operational reporting). Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction for this Monthly Operating Report. US state primacy agencies require MORs; EU equivalents include operational monitoring reports under DWD 2020/2184 Article 13. Ref: EPA SDWA.',
    `jurisdiction_region` STRING COMMENT 'Sub-national or supra-national region qualifier, e.g. US state abbreviation, EU member state, UK nation (England/Wales/Scotland), German Bundesland. Supports multi-level regulatory hierarchy. Ref: EPA SDWA.',
    `jurisdiction_region_code` STRING COMMENT 'ISO region code for MOR jurisdiction (US, EU, FR, UK, DE). US MORs follow state primacy agency formats; EU equivalents follow DWD 2020/2184 operational monitoring requirements.',
    `jurisdictional_report_type` STRING COMMENT 'Report flavor: US monthly operating report vs EU DWD operational monitoring report. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOR record was last modified. Ref: EPA SDWA.',
    `mor_status` STRING COMMENT 'MOR status. Ref: EPA SDWA.',
    `operational_events_count` STRING COMMENT 'Number of significant operational events (equipment failures, process upsets, maintenance shutdowns) recorded during the reporting month. Ref: EPA SDWA.',
    `operational_events_description` STRING COMMENT 'Narrative description of significant operational events that occurred during the reporting month. Ref: EPA SDWA.',
    `peak_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Maximum daily flow rate of treated water produced during the reporting month. Ref: EPA SDWA.',
    `ph_avg` DECIMAL(18,2) COMMENT 'Average pH level of finished water during the reporting month. Ref: EPA SDWA.',
    `preparer_license_number` STRING COMMENT 'State-issued water treatment operator license number of the preparer. Ref: EPA SDWA.',
    `preparer_title` STRING COMMENT 'Job title or role of the individual who prepared the MOR. Ref: EPA SDWA.',
    `raw_water_turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Average turbidity of raw source water entering the treatment plant during the reporting month. Ref: EPA SDWA.',
    `raw_water_turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Maximum turbidity of raw source water recorded during the reporting month. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_body_name` STRING COMMENT 'Name of the regulatory agency or body with oversight, e.g. US EPA, state primacy agency, European Commission DG Environment, French ANSES, UK DWI (Drinking Water Inspectorate), German UBA (Umweltbundesamt), Australian NHMRC. Ref: EPA SDWA.',
    `regulatory_directive_reference` STRING COMMENT 'Specific directive, rule, or regulation citation, e.g. 40 CFR 141 (US NPDWR), Directive 2020/2184/EU Article 13, Directive 91/271/EEC Annex I, REACH Annex XVII PFAS restriction, French Code de la sante publique R.1321.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for operational reporting: US_SDWA_MOR, EU_DWD_2020_2184_OPERATIONAL, or national transposition. EU DWD requires risk-based monitoring (Water Safety Plans) vs US prescriptive monitoring schedules. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Framework under which the operating report is filed, e.g. EU Drinking Water Directive 2020/2184; REACH PFAS restriction; Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC. Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'The regulatory region value recorded for each mor in the compliance domain.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for MOR jurisdiction (US, EU, FR, UK, DE)',
    `report_number` STRING COMMENT 'Externally-known unique report number assigned by the state primacy agency or internal tracking system. Ref: EPA SDWA.',
    `reporting_month` DATE COMMENT 'The calendar month for which this MOR documents water treatment plant operations. Ref: EPA SDWA.',
    `reporting_period` STRING COMMENT 'Reporting period. Ref: EPA SDWA.',
    `reporting_year` STRING COMMENT 'The calendar year for which this MOR is submitted. Ref: EPA SDWA.',
    `source_water_type` STRING COMMENT 'Primary type of source water used by the treatment plant during the reporting month. Ref: EPA SDWA.. Valid values are `surface|groundwater|purchased|blended`',
    `submission_date` DATE COMMENT 'Submission date. Ref: EPA SDWA.',
    `total_water_produced_mgd` DECIMAL(18,2) COMMENT 'Total volume of treated water produced by the WTP during the reporting month, measured in million gallons per day. Ref: EPA SDWA.',
    `turbidity_compliance_status` STRING COMMENT 'Indicates whether turbidity levels met regulatory Maximum Contaminant Level (MCL) requirements during the reporting month. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|exceedance`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `violations_count` STRING COMMENT 'Number of regulatory violations (MCL exceedances, monitoring failures, reporting failures) recorded during the reporting month. Ref: EPA SDWA.',
    `violations_description` STRING COMMENT 'Narrative description of regulatory violations that occurred during the reporting month. Ref: EPA SDWA.',
    CONSTRAINT pk_mor PRIMARY KEY(`mor_id`)
) COMMENT 'Monthly Operating Report (MOR) submitted to the state primacy agency documenting drinking water treatment plant operations, including treatment process performance, chemical dosing, CT (Contact Time for Disinfection) calculations, turbidity (NTU) compliance, disinfection residuals, source water quality, and operational events. Tracks the WTP facility, reporting month, preparer, submission date, certification status, and key operational parameters required by the state drinking water program under SDWA.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` (
    `compliance_violation_id` BIGINT COMMENT 'Unique identifier for the compliance_violation data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `analytical_result_id` BIGINT COMMENT 'Unique identifier for the analytical result referenced by each compliance violation record in the compliance domain.',
    `treatment_violation_id` BIGINT COMMENT 'Canonical reference to treatment.treatment_violation. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the compliance created by employee referenced by each compliance violation record in the compliance domain.',
    `compliance_discovered_by_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Violations are discovered during operations by specific employees (operators, lab staff, inspectors). Tracks who identified the issue for follow-up, training needs assessment, and internal audit trail. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each compliance violation record in the compliance domain.',
    `compliance_responsible_employee_id` BIGINT COMMENT 'Unique identifier for the compliance responsible employee referenced by each compliance violation record in the compliance domain.',
    `compliance_treatment_violation_id` BIGINT COMMENT 'treatment violation id for compliance_violation. Ref: EPA SDWA.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each compliance violation record in the compliance domain.',
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility referenced by each compliance violation record in the compliance domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to compliance.regulatory_agency. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each compliance violation record in the compliance domain.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Violations are triggered by specific test results exceeding regulatory limits. Direct link provides enforcement traceability, enables automated violation detection, and supports legal defensibility by. Ref: EPA SDWA.',
    `water_system_id` BIGINT COMMENT 'water system id for compliance_violation. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the enforcement action referenced by each compliance violation record in the compliance domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_category` STRING COMMENT 'The compliance violation category value recorded for each compliance violation in the compliance domain.',
    `classification` STRING COMMENT 'The classification value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_code` STRING COMMENT 'code for compliance_violation. Ref: EPA SDWA.',
    `comments` STRING COMMENT 'Additional notes or context. Ref: EPA SDWA.',
    `compliance_corrective_action_id` BIGINT COMMENT 'corrective action id for compliance_violation. Ref: EPA SDWA.',
    `compliance_period` STRING COMMENT 'compliance period for compliance_violation. Ref: EPA SDWA.',
    `compliance_period_begin` DATE COMMENT 'Start of compliance period. Ref: EPA SDWA.',
    `compliance_period_begin_date` TIMESTAMP COMMENT 'Start of compliance monitoring period. Ref: EPA SDWA.',
    `compliance_period_end` STRING COMMENT 'End of compliance period. Ref: EPA SDWA.',
    `compliance_period_end_date` TIMESTAMP COMMENT 'End of compliance monitoring period. Ref: EPA SDWA.',
    `compliance_period_start` STRING COMMENT 'Start of compliance period. Ref: EPA SDWA.',
    `compliance_public_notification_id` BIGINT COMMENT 'public notification id for compliance_violation. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current status (open, resolved, returned_to_compliance, under_enforcement). Ref: EPA SDWA.',
    `compliance_violation_number` STRING COMMENT 'The compliance violation number value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_type` STRING COMMENT 'The compliance violation type value recorded for each compliance violation in the compliance domain.',
    `corrective_action_completed_date` TIMESTAMP COMMENT 'Date corrective action was completed. Ref: EPA SDWA.',
    `corrective_action_deadline` DATE COMMENT 'Deadline for corrective action. Ref: EPA SDWA.',
    `corrective_action_description` STRING COMMENT 'Description of corrective action. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is mandated. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'System of record from which this violation data originated. Ref: EPA SDWA.',
    `compliance_violation_description` STRING COMMENT 'The compliance violation description value recorded for each compliance violation in the compliance domain.',
    `detected_date` TIMESTAMP COMMENT 'The detected date associated with each compliance violation record in the compliance domain.',
    `detection_date` DATE COMMENT 'Date violation was detected. Ref: EPA SDWA.',
    `determination_date` TIMESTAMP COMMENT 'determination date for compliance_violation. Ref: EPA SDWA.',
    `discovered_date` TIMESTAMP COMMENT 'The discovered date associated with each compliance violation record in the compliance domain.',
    `discovery_date` TIMESTAMP COMMENT 'The discovery date associated with each compliance violation record in the compliance domain.',
    `ecm_mvm_depth_reconciliation_note` STRING COMMENT 'ECM attribute depth reconciled to match or exceed MVM (prior ecm_depth=3, mvm_depth=7). ECM now carries the full backbone attribute set. Ref: EPA SDWA.',
    `effective_date` TIMESTAMP COMMENT 'The effective date associated with each compliance violation record in the compliance domain.',
    `effective_end_date` TIMESTAMP COMMENT 'Effective end date. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'Effective start date. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'The end date associated with each compliance violation record in the compliance domain.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether a formal enforcement action was issued. Ref: EPA SDWA.',
    `enforcement_action_initiated` BOOLEAN COMMENT 'Whether enforcement action was initiated. Ref: EPA SDWA.',
    `enforcement_action_pending` BOOLEAN COMMENT 'Flag indicating whether formal enforcement action is pending. Ref: EPA SDWA.',
    `enforcement_action_required` BOOLEAN COMMENT 'enforcement action required for compliance_violation. Ref: EPA SDWA.',
    `enforcement_action_taken` STRING COMMENT 'Whether enforcement action was taken. Ref: EPA SDWA.',
    `engineering_unit` STRING COMMENT 'Unit of measurement (mg/L, ug/L, NTU, pCi/L). Ref: EPA SDWA.',
    `expiration_date` TIMESTAMP COMMENT 'The expiration date associated with each compliance violation record in the compliance domain.',
    `health_based_flag` BOOLEAN COMMENT 'Whether the violation is health-based (acute or chronic health risk). Ref: EPA SDWA.',
    `is_active` BOOLEAN COMMENT 'Whether the record is currently active. Ref: EPA SDWA.',
    `is_health_based` BOOLEAN COMMENT 'Whether the violation is health-based (acute or chronic). Ref: EPA SDWA.',
    `is_repeat_violation` BOOLEAN COMMENT 'Whether this is a repeat violation within the compliance period. Ref: EPA SDWA.',
    `is_resolved` BOOLEAN COMMENT 'Boolean flag indicating whether the is resolved condition applies to the compliance violation record.',
    `is_return_to_compliance` BOOLEAN COMMENT 'is return to compliance for compliance_violation. Ref: EPA SDWA.',
    `is_significant_noncompliance` BOOLEAN COMMENT 'Flag indicating significant non-compliance (SNC) designation. Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'US federal, US state, EU, UK, other. Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each compliance violation record in the compliance domain.',
    `limit_value` DECIMAL(18,2) COMMENT 'The limit value value recorded for each compliance violation in the compliance domain.',
    `mcl_limit` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level limit that was exceeded. Ref: EPA SDWA.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Maximum Contaminant Level that was exceeded. Ref: EPA SDWA.',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value that caused violation. Ref: EPA SDWA.',
    `measurement_unit` STRING COMMENT 'Unit of measurement for measured and limit values. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Record last modification timestamp. Ref: EPA SDWA.',
    `monitoring_period` STRING COMMENT 'monitoring period for compliance_violation. Ref: EPA SDWA.',
    `compliance_violation_name` STRING COMMENT 'name for compliance_violation. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes. Ref: EPA SDWA.',
    `notification_date` DATE COMMENT 'Date regulatory agency was notified. Ref: EPA SDWA.',
    `parameter` STRING COMMENT 'Parameter. Ref: EPA SDWA.',
    `parameter_code` STRING COMMENT 'The parameter code value recorded for each compliance violation in the compliance domain.',
    `parameter_name` STRING COMMENT 'The parameter name used to identify each compliance violation record in the compliance domain.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount assessed. Ref: EPA SDWA.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'The penalty amount usd value recorded for each compliance violation in the compliance domain.',
    `penalty_assessed` BOOLEAN COMMENT 'penalty assessed for compliance_violation. Ref: EPA SDWA.',
    `percentage_value` DECIMAL(18,2) COMMENT 'The percentage value value recorded for each compliance violation in the compliance domain.',
    `population_affected` STRING COMMENT 'Estimated population affected by the violation. Ref: EPA SDWA.',
    `population_served` STRING COMMENT 'Population served by the system at time of violation. Ref: EPA SDWA.',
    `population_served_affected` STRING COMMENT 'Estimated population affected by the violation. Ref: EPA SDWA.',
    `primacy_agency_code` STRING COMMENT 'State primacy agency code. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each compliance violation in the compliance domain.',
    `public_notification_date` TIMESTAMP COMMENT 'The public notification date associated with each compliance violation record in the compliance domain.',
    `public_notification_deadline` DATE COMMENT 'Deadline for issuing public notification. Ref: EPA SDWA.',
    `public_notification_issued` BOOLEAN COMMENT 'Whether public notification was issued. Ref: EPA SDWA.',
    `public_notification_issued_date` TIMESTAMP COMMENT 'Date public notification was issued. Ref: EPA SDWA.',
    `public_notification_required` STRING COMMENT 'Whether public notification is required. Ref: EPA SDWA.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Whether public notification is required. Ref: EPA SDWA.',
    `public_notification_tier` STRING COMMENT 'public notification tier for compliance_violation. Ref: EPA SDWA.',
    `pwsid` STRING COMMENT 'Public Water System ID. Ref: EPA SDWA.',
    `quantity_value` DECIMAL(18,2) COMMENT 'The quantity value value recorded for each compliance violation in the compliance domain.',
    `record_number` STRING COMMENT 'Standard operational attribute. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each compliance violation in the compliance domain.',
    `reference_number` STRING COMMENT 'The reference number value recorded for each compliance violation in the compliance domain.',
    `regulation_citation` STRING COMMENT 'Cited regulation (NPDWR/SDWA/LCRR reference).',
    `regulatory_citation` STRING COMMENT 'Regulatory citation for violation. Ref: EPA SDWA.',
    `regulatory_framework` STRING COMMENT 'regulatory framework for compliance_violation. Ref: EPA SDWA.',
    `regulatory_limit` STRING COMMENT 'Applicable regulatory limit. Ref: EPA SDWA.',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'The applicable regulatory limit that was exceeded. Ref: EPA SDWA.',
    `regulatory_notification_date` TIMESTAMP COMMENT 'Date regulator was notified. Ref: EPA SDWA.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference value recorded for each compliance violation in the compliance domain.',
    `reported_date` TIMESTAMP COMMENT 'Date violation was reported to regulator. Ref: EPA SDWA.',
    `reported_flag` BOOLEAN COMMENT 'The reported flag value recorded for each compliance violation in the compliance domain.',
    `reported_to_agency_date` TIMESTAMP COMMENT 'Date the violation was reported to the regulatory agency. Ref: EPA SDWA.',
    `reporting_deadline_date` TIMESTAMP COMMENT 'Regulatory reporting deadline. Ref: EPA SDWA.',
    `resolution_date` DATE COMMENT 'Date violation was resolved. Ref: EPA SDWA.',
    `resolution_description` STRING COMMENT 'The resolution description value recorded for each compliance violation in the compliance domain.',
    `resolution_status` STRING COMMENT 'The resolution status value recorded for each compliance violation in the compliance domain.',
    `resolved_date` TIMESTAMP COMMENT 'The resolved date associated with each compliance violation record in the compliance domain.',
    `resolved_flag` BOOLEAN COMMENT 'The resolved flag value recorded for each compliance violation in the compliance domain.',
    `return_to_compliance_date` DATE COMMENT 'Date returned to compliance. Ref: EPA SDWA.',
    `root_cause` STRING COMMENT 'Root cause analysis findings. Ref: EPA SDWA.',
    `rtc_date` TIMESTAMP COMMENT 'Date system returned to compliance. Ref: EPA SDWA.',
    `rtc_deadline_date` TIMESTAMP COMMENT 'rtc deadline date for compliance_violation. Ref: EPA SDWA.',
    `rule_citation` STRING COMMENT 'Regulatory rule citation (e.g., 40 CFR 141.63). Ref: EPA SDWA.',
    `rule_code` STRING COMMENT 'Regulatory rule code (e.g., SWTR, LCR, TCR, Stage 2 DBPR). Ref: EPA SDWA.',
    `rule_name` STRING COMMENT 'Full name of the regulatory rule violated. Ref: EPA SDWA.',
    `sdwis_violation_code` STRING COMMENT 'EPA SDWIS violation identifier for federal tracking. Ref: EPA SDWA.',
    `severity` STRING COMMENT 'The severity value recorded for each compliance violation in the compliance domain.',
    `severity_level` STRING COMMENT 'Severity (minor, significant, serious, critical). Ref: EPA SDWA.',
    `severity_score` STRING COMMENT 'Numeric severity score assigned to the violation for prioritization. Ref: EPA SDWA.',
    `ssot_resolution_type` STRING COMMENT 'ssot resolution type for compliance_violation. Ref: EPA SDWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `ssot_sync_timestamp` TIMESTAMP COMMENT 'ssot sync timestamp for compliance_violation. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'The start date associated with each compliance violation record in the compliance domain.',
    `compliance_violation_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measure. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `violation_begin_date` TIMESTAMP COMMENT 'Date violation period began. Ref: EPA SDWA.',
    `violation_category` STRING COMMENT 'Category (health_based, non_health_based, procedural). Ref: EPA SDWA.',
    `violation_code` STRING COMMENT 'Regulatory violation code per EPA SDWIS classification. Ref: EPA SDWA.',
    `violation_date` TIMESTAMP COMMENT 'The violation date associated with each compliance violation record in the compliance domain.',
    `violation_description` STRING COMMENT 'The violation description value recorded for each compliance violation in the compliance domain.',
    `violation_end_date` TIMESTAMP COMMENT 'Date violation period ended (return to compliance). Ref: EPA SDWA.',
    `violation_number` STRING COMMENT 'Unique violation reference number. Ref: EPA SDWA.',
    `violation_status` STRING COMMENT 'Status (open, under_review, resolved, closed, appealed). Ref: EPA SDWA.',
    `violation_type` STRING COMMENT 'Type (MCL, monitoring, reporting, treatment_technique, operational). Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_violation PRIMARY KEY(`compliance_violation_id`)
) COMMENT 'Formal record of a regulatory violation identified at a utility facility or in a regulatory submission, including MCL exceedances, permit limit violations, monitoring and reporting violations (MRVs), treatment technique violations, and public notification failures. Tracks violation type, regulatory citation, affected facility, detection date, parameter and measured value, applicable limit, violation severity, notification requirements triggered, and current resolution status. Central record for all compliance failures requiring regulatory response. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for violations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the enforcement action record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Enforcement actions (consent decrees, administrative orders) mandate capital projects with specific completion deadlines. Tracking this link is essential for compliance schedule management, regulatory. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which the violation and enforcement action occurred (NPDES permit, drinking water permit, IUP, etc.). Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Reference to the primary violation record that triggered this enforcement action. Links to the violation tracking system. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility subject to the enforcement action. Ref: EPA SDWA.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Penalty accruals and payments require journal entries for proper GASB accounting. Mandatory for financial statement preparation and audit trail of enforcement-related expenses. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Enforcement actions often reference specific samples as evidence (e.g., NOVs citing sample collection dates). Legal defensibility requires chain of custody from enforcement action back to physical sam. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Enforcement actions often require specialized vendor services (engineering studies, equipment upgrades, environmental consulting) to achieve compliance. Tracks vendor responsible for remediation work. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Enforcement actions require designated management oversight for response coordination, legal liaison, and board reporting. Links to employee for accountability tracking and workload management. Replac',
    `action_date` DATE COMMENT 'Action date. Ref: EPA SDWA.',
    `action_number` STRING COMMENT 'Official enforcement action number or case number assigned by the regulatory agency (EPA, state primacy agency, NPDES authority). This is the externally-known identifier used in all regulatory correspondence and legal documents. Ref: EPA SDWA.',
    `action_status` STRING COMMENT 'Current lifecycle status of the enforcement action. Tracks progression from issuance through utility response, negotiation, and final resolution. Ref: EPA SDWA.. Valid values are `issued|under_review|response_submitted|in_negotiation|resolved|closed`',
    `action_summary` STRING COMMENT 'Brief summary of the enforcement action, including the nature of the violation, regulatory basis, and key requirements. Provides context for reporting and management review. Ref: EPA SDWA.',
    `action_type` STRING COMMENT 'Type of formal enforcement action initiated by the regulatory agency. Includes Notice of Violation (NOV), Administrative Order (AO), Consent Order, Compliance Schedule, civil penalty assessment, or criminal referral. Ref: EPA SDWA.. Valid values are `notice_of_violation|administrative_order|consent_order|compliance_schedule|civil_penalty|criminal_referral`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the utility filed a formal appeal or contested the enforcement action through administrative or judicial proceedings. Ref: EPA SDWA.',
    `appeal_filing_date` DATE COMMENT 'Date the utility filed its appeal or petition for review. Null if no appeal was filed. Ref: EPA SDWA.',
    `board_notification_date` DATE COMMENT 'Date the utilitys Board of Directors or governing body was notified of the enforcement action. Tracks governance and executive oversight requirements. Ref: EPA SDWA.',
    `civil_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by the regulatory agency in U.S. dollars. Null if no civil penalty was imposed. Ref: EPA SDWA.',
    `compliance_schedule_final_deadline` DATE COMMENT 'Final deadline by which all corrective actions and compliance milestones must be completed. Null if no compliance schedule is required. Ref: EPA SDWA.',
    `compliance_schedule_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a formal compliance schedule with milestones and deadlines for corrective actions. Ref: EPA SDWA.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective actions required by the enforcement action. May include operational changes, infrastructure upgrades, process improvements, or enhanced monitoring. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was first created in the system. Audit trail for data lineage. Ref: EPA SDWA.',
    `document_reference_number` STRING COMMENT 'Internal document management system reference number for the enforcement action file. Links to stored correspondence, legal documents, and supporting materials. Ref: EPA SDWA.',
    `issue_date` DATE COMMENT 'Date the enforcement action was officially issued or signed by the regulatory agency. This is the principal business event timestamp for the enforcement action lifecycle. Ref: EPA SDWA.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory agency that issued the enforcement action (e.g., U.S. Environmental Protection Agency, State Department of Environmental Quality, Regional Water Quality Control Board). Ref: EPA SDWA.',
    `issuing_agency_region` STRING COMMENT 'Regional office, district, or jurisdiction of the issuing agency (e.g., EPA Region 5, Northwest Regional Office). Identifies the specific regulatory authority within the agency structure. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was last updated. Audit trail for change tracking. Ref: EPA SDWA.',
    `legal_counsel_assigned` STRING COMMENT 'Name of the internal or external legal counsel assigned to manage the utilitys response to the enforcement action. Business-confidential information. Ref: EPA SDWA.',
    `legal_firm_name` STRING COMMENT 'Name of the external law firm representing the utility, if external counsel is engaged. Null if handled internally. Ref: EPA SDWA.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this enforcement action record. Audit trail for accountability. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, internal discussions, negotiation history, or other relevant information not captured in structured fields. Ref: EPA SDWA.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount. Ref: EPA SDWA.',
    `penalty_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the utility toward the civil penalty. May differ from assessed amount due to negotiated settlements or payment plans. Ref: EPA SDWA.',
    `penalty_payment_date` DECIMAL(18,2) COMMENT 'Date the civil penalty payment was made to the regulatory agency. Tracks compliance with payment deadlines. Ref: EPA SDWA.',
    `public_notice_date` DATE COMMENT 'Date public notice of the enforcement action was issued. Null if public notice is not required. Ref: EPA SDWA.',
    `public_notice_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action requires public notification under regulatory or consent order terms. Drives public communication and transparency obligations. Ref: EPA SDWA.',
    `received_date` DATE COMMENT 'Date the utility officially received the enforcement action notice. Used to calculate response deadlines and compliance timelines. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory statute, rule, or permit condition cited in the enforcement action (e.g., Clean Water Act Section 301, 40 CFR 122.41, NPDES Permit Condition III.A.1). Identifies the legal basis for the enforcement. Ref: EPA SDWA.',
    `resolution_date` DATE COMMENT 'Date the enforcement action was formally resolved or closed. Indicates completion of all required corrective actions, penalty payments, and regulatory obligations. Ref: EPA SDWA.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the enforcement action. Indicates how the action was resolved (compliance achieved, consent order executed, penalty paid, dismissed, or under appeal). Ref: EPA SDWA.. Valid values are `compliance_achieved|consent_order_executed|penalty_paid|dismissed|under_appeal`',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response to the enforcement action. Typically specified in the enforcement notice or calculated based on regulatory timelines. Ref: EPA SDWA.',
    `response_submitted_date` DATE COMMENT 'Date the utility submitted its formal response to the enforcement action. Tracks compliance with response deadlines. Ref: EPA SDWA.',
    `sep_description` STRING COMMENT 'Description of the Supplemental Environmental Project (SEP) agreed to as part of the enforcement settlement. Null if no SEP is included. Ref: EPA SDWA.',
    `sep_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the Supplemental Environmental Project (SEP) in U.S. dollars. Used to calculate penalty offsets and track SEP investment. Ref: EPA SDWA.',
    `supplemental_environmental_project_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a Supplemental Environmental Project (SEP) as part of the settlement. SEPs are environmentally beneficial projects that go beyond compliance requirements and may offset civil penalties. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_enforcement_action PRIMARY KEY(`enforcement_action_id`)
) COMMENT 'Formal enforcement action initiated by a regulatory agency (EPA, state primacy agency, NPDES authority) against the utility in response to violations, including Notices of Violation (NOVs), Administrative Orders (AOs), Consent Orders, Compliance Schedules, civil penalties, and criminal referrals. Tracks the issuing agency, action type, associated violations, compliance schedule milestones, penalty amounts, response deadlines, legal counsel assigned, and resolution outcome. Drives the utilitys formal regulatory response process.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` (
    `compliance_public_notification_id` BIGINT COMMENT 'Unique identifier for the public notification record. Primary key. Ref: EPA SDWA.',
    `quality_public_notification_id` BIGINT COMMENT 'Canonical reference to quality.quality_public_notification. Ref: EPA SDWA.',
    `ccr_id` BIGINT COMMENT 'Foreign key linking to compliance.ccr. Business justification: SDWA requires that public notifications for MCL violations be included in the annual Consumer Confidence Report (CCR). The public_notification table tracks individual notifications, and the ccr table. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Public notifications about violations include corrective action project information ("Utility is constructing new filtration plant to address turbidity violations"). Required for public transparency a. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Identifier of the utility manager or compliance officer who approved the public notification for distribution. Ref: EPA SDWA.',
    `compliance_employee_id` BIGINT COMMENT 'Identifier of the utility staff member who prepared the public notification content and documentation. Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Reference to the specific water quality or treatment technique violation that triggered this public notification requirement. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Public notification costs (printing, mailing, advertising) are tracked to cost centers for regulatory compliance budgeting and demonstrating compliance expenditures in rate cases. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility. Ref: EPA SDWA.',
    `primary_compliance_employee_id` BIGINT COMMENT 'Identifier of the utility staff member who prepared the public notification content and documentation. Ref: EPA SDWA.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Public notifications cite specific test results that triggered the notice (e.g., MCL exceedance). Regulatory transparency requirement mandates direct link from public notice to laboratory result for c. Ref: EPA SDWA.',
    `affected_customer_count` STRING COMMENT 'Total number of customer accounts or service connections in the affected service area that must receive the public notification. Ref: EPA SDWA.',
    `affected_service_area` STRING COMMENT 'Geographic description or identifier of the service area, distribution zone, or District Metered Area (DMA) affected by the violation and subject to the public notification. Ref: EPA SDWA.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the public notification was approved for distribution by the responsible manager or compliance officer. Ref: EPA SDWA.',
    `certification_number` STRING COMMENT 'Tracking number or reference identifier assigned by the primacy agency upon receipt of the public notification certification submission. Ref: EPA SDWA.',
    `certification_submitted_date` DATE COMMENT 'Date on which the certification of public notification completion was submitted to the state primacy agency, as required by SDWA regulations. Ref: EPA SDWA.',
    `contact_email_address` STRING COMMENT 'Email address provided in the public notification for customers to contact the utility for additional information. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the utility contact person provided in the public notification for customers to obtain additional information about the violation and corrective actions. Ref: EPA SDWA.',
    `contact_phone_number` STRING COMMENT 'Phone number provided in the public notification for customers to contact the utility for additional information. Ref: EPA SDWA.',
    `contaminant_name` STRING COMMENT 'Name of the specific contaminant or parameter that exceeded regulatory limits or was subject to the violation (e.g., Total Coliform, Lead, Copper, Trihalomethanes (THM), Haloacetic Acids (HAA5), Nitrate, PFAS). Ref: EPA SDWA.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions being taken by the water utility to address the violation and prevent recurrence, as required to be included in the public notification. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this public notification record was first created in the system. Ref: EPA SDWA.',
    `deadline_met_flag` BOOLEAN COMMENT 'Boolean indicator of whether the public notification was completed within the regulatory deadline. True if deadline was met, False if deadline was missed. Ref: EPA SDWA.',
    `delivery_method` STRING COMMENT 'Delivery method. Ref: EPA SDWA.',
    `distribution_completion_date` DATE COMMENT 'Date on which the public notification distribution was completed to all affected customers and required public channels. Ref: EPA SDWA.',
    `distribution_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for distributing the public notification, including printing, postage, media advertising, and other distribution expenses. Ref: EPA SDWA.',
    `distribution_start_date` DATE COMMENT 'Date on which the public notification distribution began to affected customers and the public. Ref: EPA SDWA.',
    `health_effects_language` STRING COMMENT 'Mandatory health effects language as prescribed by EPA for the specific contaminant or violation type, describing potential health risks to consumers. Ref: EPA SDWA.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The regulatory Maximum Contaminant Level (MCL) threshold that was exceeded, expressed in the appropriate unit of measure (mg/L, ug/L, pCi/L, NTU, etc.). Ref: EPA SDWA.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual measured value of the contaminant that triggered the violation, expressed in the same unit of measure as the MCL. Ref: EPA SDWA.',
    `media_outlet_list` STRING COMMENT 'List of media outlets (newspapers, radio stations, television stations) to which the public notification was distributed for broadcast or publication, as required for Tier 1 notifications. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this public notification record was last modified or updated. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or special circumstances related to the public notification process, distribution challenges, or customer feedback. Ref: EPA SDWA.',
    `notification_content` STRING COMMENT 'Full text of the public notification message as distributed to customers, including mandatory elements: description of violation, potential health effects, population at risk, corrective actions, and contact information. Ref: EPA SDWA.',
    `notification_date` DATE COMMENT 'Notification date. Ref: EPA SDWA.',
    `notification_language` STRING COMMENT 'Primary language(s) in which the notification was issued to ensure accessibility for the affected population. May include multiple languages based on community demographics. Ref: EPA SDWA.',
    `notification_method` STRING COMMENT 'Method(s) used to deliver the public notification to affected customers and the public. May include multiple methods such as bill insert, direct mail, hand delivery, posting, newspaper publication, broadcast media (radio/TV), website posting, social media, or email. [ENUM-REF-CANDIDATE: Bill Insert|Direct Mail|Hand Delivery|Posted Notice|Newspaper|Radio|Television|Website|Social Media|Email|Press Release — promote to reference product]. Ref: EPA SDWA.',
    `notification_number` STRING COMMENT 'Business identifier for the public notification, typically formatted as PN-YYYY-NNNNNN for tracking and regulatory submission purposes. Ref: EPA SDWA.. Valid values are `^PN-[0-9]{4}-[0-9]{6}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the public notification: Draft (being prepared), Pending Approval (awaiting management review), Approved (ready for distribution), Distributed (sent to customers), Certified (submitted to primacy agency), or Closed (violation resolved and notification cycle complete). Ref: EPA SDWA.. Valid values are `Draft|Pending Approval|Approved|Distributed|Certified|Closed`',
    `notification_tier` STRING COMMENT 'Classification of notification urgency and timeline as defined by EPA: Tier 1 (immediate, within 24 hours for acute health risks), Tier 2 (within 30 days for less urgent violations), Tier 3 (annual notice via Consumer Confidence Report for monitoring or reporting violations). Ref: EPA SDWA.. Valid values are `Tier 1|Tier 2|Tier 3`',
    `population_notified` STRING COMMENT 'Population notified. Ref: EPA SDWA.',
    `primacy_agency_acknowledgment_date` DATE COMMENT 'Date on which the state primacy agency acknowledged receipt and acceptance of the public notification certification. Ref: EPA SDWA.',
    `primacy_agency_name` STRING COMMENT 'Name of the state or tribal primacy agency to which the public notification certification and documentation must be submitted (e.g., State Department of Environmental Quality, State Health Department). Ref: EPA SDWA.',
    `public_meeting_date` DATE COMMENT 'Date on which the public meeting was held to discuss the violation with affected customers and community stakeholders. Ref: EPA SDWA.',
    `public_meeting_held_flag` BOOLEAN COMMENT 'Boolean indicator of whether a public meeting was held to discuss the violation and corrective actions with affected customers and community stakeholders. True if meeting was held. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_deadline_date` DATE COMMENT 'The regulatory deadline by which the public notification must be completed based on the notification tier: 24 hours for Tier 1, 30 days for Tier 2, or annual CCR publication for Tier 3. Ref: EPA SDWA.',
    `repeat_notification_frequency` STRING COMMENT 'Frequency at which repeat public notifications must be issued for ongoing violations, as specified by the notification tier and primacy agency requirements. Ref: EPA SDWA.. Valid values are `Daily|Weekly|Monthly|Quarterly|As Required`',
    `repeat_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether repeat public notifications are required for ongoing violations. True if repeat notifications must be issued at specified intervals until the violation is resolved. Ref: EPA SDWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the contaminant level: milligrams per liter (mg/L), micrograms per liter (ug/L), picocuries per liter (pCi/L), Nephelometric Turbidity Units (NTU), Most Probable Number per 100 milliliters (MPN/100mL), or Colony Forming Units per 100 milliliters (CFU/100mL). Ref: EPA SDWA.. Valid values are `mg/L|ug/L|pCi/L|NTU|MPN/100mL|CFU/100mL`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `violation_date` DATE COMMENT 'The date on which the violation occurred or was first identified through water quality testing or monitoring. Ref: EPA SDWA.',
    `violation_type` STRING COMMENT 'Category of the violation that triggered the notification: Maximum Contaminant Level (MCL) exceedance, Maximum Contaminant Level Goal (MCLG) exceedance, Treatment Technique violation, Monitoring violation, or Reporting violation. Ref: EPA SDWA.. Valid values are `MCL|MCLG|Treatment Technique|Monitoring|Reporting`',
    `website_posting_url` STRING COMMENT 'URL of the utility website page where the public notification was posted for public access and transparency. Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_public_notification PRIMARY KEY(`compliance_public_notification_id`)
) COMMENT 'Record of public notifications issued to customers and the public as required by SDWA when MCL violations, treatment technique violations, or other health-based violations occur. Tracks the notification type (Tier 1 immediate, Tier 2 within 30 days, Tier 3 annual), associated violation, affected service area, notification method (bill insert, direct mail, media, website), distribution date, number of customers notified, regulatory submission confirmation, and certification to the state primacy agency. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for public notifications.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` (
    `ccr_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report record. Primary key. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Consumer Confidence Report preparation, printing, and distribution costs are tracked to cost centers for regulatory compliance budgeting and cost allocation. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Facility. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Consumer Confidence Reports require designated preparer for regulatory compliance and quality assurance. Links to employee for training verification, workload tracking, and audit trail of who compiled. Ref: EPA SDWA.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: The Consumer Confidence Report (CCR) is an annual regulatory submission required by SDWA. The ccr table tracks certification_submitted_date, certification_method, and state_certification_number, which. Ref: EPA SDWA.',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: Consumer Confidence Reports summarize monitoring data by location (source water, entry points, distribution system). Annual reporting requirement needs direct link to sampling locations for automated. Ref: EPA SDWA.',
    `additional_languages` STRING COMMENT 'List of additional languages in which CCR information or translations were provided to serve non-English speaking customers. Pipe-separated list (e.g., Spanish|Chinese|Vietnamese). Ref: EPA SDWA.',
    `board_meeting_info` STRING COMMENT 'Information about public meetings where customers can participate in decisions affecting drinking water quality, including meeting times, locations, and how to attend. Required CCR content for community water systems. Ref: EPA SDWA.',
    `ccr_status` STRING COMMENT 'CCR status. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Overall compliance status of this CCR with EPA and state requirements. Compliant indicates all requirements met. Non-compliant indicates violations. Pending review indicates state review in progress. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|pending_review`',
    `contact_email` STRING COMMENT 'Email address for customer inquiries about the Consumer Confidence Report and water quality information. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the water system contact person for customer questions about the CCR. Required CCR content per EPA rule. Ref: EPA SDWA.',
    `contact_phone` STRING COMMENT 'Phone number for customer inquiries about the Consumer Confidence Report and water quality information. Required CCR content per EPA rule. Ref: EPA SDWA.',
    `contaminant_detection_count` STRING COMMENT 'Total number of regulated contaminants detected in the water system during the report year. All detected contaminants must be reported in the CCR regardless of whether they exceed Maximum Contaminant Levels (MCL). Ref: EPA SDWA.',
    `copper_90th_percentile_ppm` DECIMAL(18,2) COMMENT '90th percentile value for copper in parts per million from tap water sampling. Action level is 1.3 PPM. Required reporting for systems that conducted lead and copper monitoring. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR record was first created in the system. Part of audit trail for regulatory compliance tracking. Ref: EPA SDWA.',
    `delivery_method` STRING COMMENT 'Primary method used to deliver this CCR to customers. Mail is direct postal delivery. Electronic includes email and online posting. Hand delivery for small systems. Newspaper publication for certain systems. Combination indicates multiple methods used. Ref: EPA SDWA.. Valid values are `mail|electronic|hand_delivery|newspaper|combination`',
    `disinfection_byproduct_monitoring_flag` BOOLEAN COMMENT 'Indicates whether disinfection byproduct monitoring for Total Trihalomethanes (THM) and Haloacetic Acids (HAA5) was conducted during the report year. True if monitoring was performed. Ref: EPA SDWA.',
    `document_file_path` STRING COMMENT 'File system path or document management system location where the published CCR PDF or document is stored for archival and retrieval purposes. Ref: EPA SDWA.',
    `educational_information_included_flag` BOOLEAN COMMENT 'Indicates whether mandatory educational information about contaminants and health effects was included in the CCR. Required content includes information about immunocompromised persons, sources of contamination, and EPA Safe Drinking Water Hotline. Ref: EPA SDWA.',
    `electronic_delivery_count` STRING COMMENT 'Number of customers who received the CCR electronically via email or online portal access. Systems must obtain customer consent for electronic delivery. Ref: EPA SDWA.',
    `language_accessibility_flag` BOOLEAN COMMENT 'Indicates whether the CCR includes information in languages other than English to serve non-English speaking populations. Systems must provide multilingual outreach when a significant portion of the population speaks another language. Ref: EPA SDWA.',
    `lead_90th_percentile_ppb` DECIMAL(18,2) COMMENT '90th percentile value for lead in parts per billion from tap water sampling. Action level is 15 PPB. Required reporting for systems that conducted lead and copper monitoring. Ref: EPA SDWA.',
    `lead_copper_monitoring_flag` BOOLEAN COMMENT 'Indicates whether lead and copper monitoring was conducted during the report year per Lead and Copper Rule Revisions (LCRR) requirements. True if monitoring was performed.',
    `mailed_count` STRING COMMENT 'Number of physical CCR copies mailed to customers. Used to document delivery compliance and calculate distribution costs. Ref: EPA SDWA.',
    `mcl_exceedance_flag` BOOLEAN COMMENT 'Indicates whether any detected contaminants exceeded their Maximum Contaminant Level during the report year. True if any MCL exceedances occurred. Ref: EPA SDWA.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this CCR record. Part of audit trail for regulatory compliance tracking. Ref: EPA SDWA.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR record was last modified. Part of audit trail for regulatory compliance tracking. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes or comments about this Consumer Confidence Report, including internal documentation of special circumstances, state feedback, or customer inquiries. Ref: EPA SDWA.',
    `population_served` STRING COMMENT 'Total number of people served by this water system during the report year. Used to determine CCR delivery requirements and system classification. Ref: EPA SDWA.',
    `publication_date` DATE COMMENT 'Date on which this Consumer Confidence Report was published and made available to customers. Must be by July 1 of the year following the report year. Ref: EPA SDWA.',
    `pws_code` STRING COMMENT 'EPA-assigned Public Water System identification number. Format: two-letter state code followed by seven digits (e.g., CA1234567). Links this CCR to the specific water system. Ref: EPA SDWA.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `pwsid` STRING COMMENT 'Public water system ID. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'The regulatory region value recorded for each ccr in the compliance domain.',
    `report_year` STRING COMMENT 'Calendar year for which this Consumer Confidence Report covers water quality data and compliance information. CCRs must be published annually by July 1 of the following year. Ref: EPA SDWA.',
    `reporting_year` STRING COMMENT 'Reporting year. Ref: EPA SDWA.',
    `service_area_description` STRING COMMENT 'Geographic description of the area served by this water system, including municipalities, counties, or districts covered by this CCR. Ref: EPA SDWA.',
    `source_water_description` STRING COMMENT 'Detailed description of the source water including specific water bodies, aquifers, wells, or treatment plant intake locations. Required CCR content per EPA rule. Ref: EPA SDWA.',
    `source_water_type` STRING COMMENT 'Classification of the primary source water for this system. Surface water includes rivers, lakes, and reservoirs. Groundwater includes wells and aquifers. GWUDI is groundwater under direct influence of surface water. Mixed indicates multiple source types. Ref: EPA SDWA.. Valid values are `surface_water|groundwater|groundwater_under_direct_influence_of_surface_water|mixed`',
    `special_notice_required_flag` BOOLEAN COMMENT 'Indicates whether special public notice was required due to violations or other circumstances. Systems with certain violations must include additional notification language in the CCR. Ref: EPA SDWA.',
    `special_notice_text` STRING COMMENT 'Text of any special public notice included in the CCR due to violations, variances, exemptions, or other circumstances requiring additional customer notification. Ref: EPA SDWA.',
    `system_name` STRING COMMENT 'Official name of the public water system issuing this Consumer Confidence Report. Ref: EPA SDWA.',
    `treatment_domain_added_flag` BOOLEAN COMMENT 'Indicates that the treatment domain was added via batch mutation. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `violation_included_flag` BOOLEAN COMMENT 'Indicates whether this CCR includes reporting of any Maximum Contaminant Level (MCL), Maximum Residual Disinfectant Level (MRDL), treatment technique, or monitoring violations during the report year. True if violations are reported. Ref: EPA SDWA.',
    `violation_summary` STRING COMMENT 'Summary description of any water quality violations, treatment technique violations, or monitoring violations that occurred during the report year. Must include health effects language and corrective actions taken. Ref: EPA SDWA.',
    `website_url` STRING COMMENT 'Web address where the Consumer Confidence Report is posted for public access. Required for systems serving more than 100,000 people. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR record. Part of audit trail for regulatory compliance tracking. Ref: EPA SDWA.',
    CONSTRAINT pk_ccr PRIMARY KEY(`ccr_id`)
) COMMENT 'Consumer Confidence Report (CCR) — the annual water quality report required by SDWA that utilities must deliver to all customers, documenting source water information, detected contaminants, MCL comparisons, health effects language, and system information. Tracks the report year, service area covered, publication date, delivery method (mailed, electronic, website), certification submission to the state, detected contaminant summary, and compliance with EPA CCR Rule requirements. Authoritative record of annual CCR publication compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Regulatory inspections during construction verify permit compliance and design standards adherence. Inspectors reference the project for context, and inspection findings may require project scope modi. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the permit under which the inspection was conducted (NPDES, IUP, state primacy permit). Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inspection preparation and response activities are tracked to cost centers for cost recovery and rate case support. Essential for documenting regulatory compliance costs. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Identifier linking to the enforcement action record if formal enforcement was initiated. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Identifier of the water or wastewater facility that was inspected (WTP, WWTP, pumping station, etc.). Ref: EPA SDWA.',
    `document_id` BIGINT COMMENT 'Identifier linking to the stored inspection report document in the document management system. Ref: EPA SDWA.',
    `lab_accreditation_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_accreditation. Business justification: Regulatory inspections verify laboratory accreditation status and scope. Direct link enables inspectors to validate that laboratory is accredited for methods used in compliance monitoring, supports re. Ref: EPA SDWA.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Sanitary surveys and compliance inspections evaluate specific treatment process units for regulatory compliance. Business process: regulatory inspections where state inspectors assess individual treat. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory inspections require utility representative present during site visit. Links to employee for scheduling, certification verification, and follow-up coordination. Replaces denormalized utility. Ref: EPA SDWA.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all required corrective actions must be completed and verified. Ref: EPA SDWA.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required by the utility in response to inspection findings. Ref: EPA SDWA.',
    `corrective_action_summary` STRING COMMENT 'Summary of the corrective actions required to address deficiencies and achieve compliance. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the compliance management system. Ref: EPA SDWA.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies or non-compliance items identified during the inspection. Ref: EPA SDWA.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether formal enforcement action (administrative order, consent decree, penalty) was initiated as a result of this inspection. Ref: EPA SDWA.',
    `findings_summary` STRING COMMENT 'High-level summary of the inspection findings, deficiencies identified, and overall compliance status. Ref: EPA SDWA.',
    `follow_up_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up inspection by the regulatory agency is required to verify corrective action completion. Ref: EPA SDWA.',
    `follow_up_inspection_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up inspection if required. Ref: EPA SDWA.',
    `inspecting_agency` STRING COMMENT 'Name of the regulatory body or agency that conducted the inspection (EPA, state primacy agency, local health department, etc.). Ref: EPA SDWA.',
    `inspection_date` DATE COMMENT 'Date on which the regulatory inspection was conducted at the facility. Ref: EPA SDWA.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity concluded. Ref: EPA SDWA.',
    `inspection_notes` STRING COMMENT 'Internal notes and observations recorded by utility staff during or after the inspection for follow-up and documentation purposes. Ref: EPA SDWA.',
    `inspection_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the regulatory agency for this inspection. Ref: EPA SDWA.',
    `inspection_report_received_date` DATE COMMENT 'Date on which the utility received the official inspection report from the regulatory agency. Ref: EPA SDWA.',
    `inspection_report_status` STRING COMMENT 'Current status of the official inspection report (draft, final, under review, accepted, disputed). Ref: EPA SDWA.. Valid values are `draft|final|under_review|accepted|disputed`',
    `inspection_result` STRING COMMENT 'Result. Ref: EPA SDWA.',
    `inspection_scope` STRING COMMENT 'Description of the areas, processes, or systems covered during the inspection (e.g., treatment processes, discharge monitoring, pretreatment program, laboratory practices). Ref: EPA SDWA.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity began. Ref: EPA SDWA.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection (scheduled, in progress, completed, report pending, closed, cancelled). Ref: EPA SDWA.. Valid values are `scheduled|in_progress|completed|report_pending|closed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection, routine inspection, follow-up inspection, complaint investigation). [ENUM-REF-CANDIDATE: sanitary_survey|compliance_inspection|pretreatment_audit|npdes_inspection|routine_inspection|follow_up_inspection|complaint_investigation — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `inspector_contact_email` STRING COMMENT 'Email address of the lead inspector for official correspondence. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `inspector_contact_phone` STRING COMMENT 'Phone number of the lead inspector for follow-up communication. Ref: EPA SDWA.',
    `inspector_name` STRING COMMENT 'Full name of the lead inspector or compliance officer who conducted the inspection. Ref: EPA SDWA.',
    `inspector_title` STRING COMMENT 'Job title or role of the lead inspector (e.g., Environmental Compliance Officer, Sanitary Survey Specialist). Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated or modified. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response or corrective action plan to the regulatory agency. Ref: EPA SDWA.',
    `significant_deficiency_classification` STRING COMMENT 'Classification or category of the significant deficiency if identified (e.g., treatment process failure, monitoring inadequacy, operational deficiency). Ref: EPA SDWA.',
    `significant_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any significant deficiencies (as defined by SDWA) were identified that could affect water quality or public health. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `utility_representative_title` STRING COMMENT 'Job title of the utility representative who coordinated the inspection (e.g., Compliance Manager, Plant Superintendent). Ref: EPA SDWA.',
    `violation_identified_flag` BOOLEAN COMMENT 'Indicates whether any regulatory violations (SDWA, CWA, NPDES permit) were formally identified during the inspection. Ref: EPA SDWA.',
    CONSTRAINT pk_regulatory_inspection PRIMARY KEY(`regulatory_inspection_id`)
) COMMENT 'Record of regulatory inspections and audits conducted by EPA, state primacy agencies, or other regulatory bodies at utility facilities. Tracks the inspection type (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection), inspecting agency, facility inspected, inspection date, inspector name, findings and deficiencies identified, significant deficiency classifications, required corrective actions, response deadlines, and final inspection report status. Drives post-inspection corrective action tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` (
    `inspection_finding_id` BIGINT COMMENT 'Unique identifier for the inspection finding record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Inspection findings during project construction require corrective action within project scope. Links findings to the project for resolution tracking, change order justification, and demonstrating com. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Reference to the formal enforcement action record associated with this finding, if enforcement was initiated. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Reference to the specific asset, equipment, or infrastructure component directly related to this finding, if applicable. Ref: EPA SDWA.',
    `inspection_event_id` BIGINT COMMENT 'Reference to the parent regulatory inspection or sanitary survey event during which this finding was identified. Ref: EPA SDWA.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Inspection findings may reference specific samples with quality issues (e.g., holding time violations, preservation failures). Audit trail requirement links regulatory findings to physical samples for. Ref: EPA SDWA.',
    `previous_finding_inspection_finding_id` BIGINT COMMENT 'Reference to the prior inspection finding record if this is a recurrence of a previously documented deficiency. Ref: EPA SDWA.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Inspection findings identify deficiencies in specific treatment processes requiring corrective action. Business process: inspection follow-up where findings (inadequate baffling, insufficient contact. Ref: EPA SDWA.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Inspection findings can originate from two types of inspections: asset inspections (tracked in compliance.inspection_event) and regulatory compliance inspections (tracked in compliance.regulatory_inspectio. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Reference to the employee record of the individual assigned primary responsibility for corrective action implementation. Ref: EPA SDWA.',
    `test_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_method. Business justification: Inspection findings often cite method compliance issues (e.g., unapproved method, expired accreditation). Direct link to test method enables targeted corrective actions and tracks method-specific comp. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance or capital work order created to execute the corrective action for this finding. Ref: EPA SDWA.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost in U.S. dollars (USD) incurred to implement the corrective action and resolve the finding. Ref: EPA SDWA.',
    `affected_system` STRING COMMENT 'The water or wastewater system, process, facility, or operational area affected by this finding (e.g., Water Treatment Plant (WTP) Filtration, Distribution Network Zone 3, Wastewater Treatment Plant (WWTP) Primary Clarifier, Laboratory Quality Assurance/Quality Control (QA/QC)). Ref: EPA SDWA.',
    `corrective_action_deadline` DATE COMMENT 'Regulatory deadline or target date by which the corrective action must be completed to achieve compliance. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Corrective action flag. Ref: EPA SDWA.',
    `correspondence_reference` STRING COMMENT 'Reference number or identifier for official regulatory correspondence, letters, or communications related to this finding (e.g., EPA Notice of Violation (NOV) number, State Agency Letter Reference). Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection finding record was first created in the system. Ref: EPA SDWA.',
    `inspection_finding_description` STRING COMMENT 'Detailed narrative description of the non-conformance, deficiency, or observation identified during the inspection, including specific conditions observed and context. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'Due date. Ref: EPA SDWA.',
    `enforcement_action_required` BOOLEAN COMMENT 'Indicates whether this finding triggered or requires formal enforcement action (administrative order, consent decree, penalty assessment, or other regulatory enforcement mechanism). Ref: EPA SDWA.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost in U.S. dollars (USD) to implement the required corrective action and resolve the finding. Ref: EPA SDWA.',
    `finding_category` STRING COMMENT 'Classification of the finding severity and regulatory significance. Significant deficiency indicates a failure or deficiency in treatment, distribution, or monitoring that could adversely affect water quality or public health. Ref: EPA SDWA.. Valid values are `significant_deficiency|minor_deficiency|recommendation|observation|violation|best_practice`',
    `finding_description` STRING COMMENT 'Finding description. Ref: EPA SDWA.',
    `finding_number` STRING COMMENT 'Sequential or structured identifier assigned to this finding within the inspection event (e.g., F-001, 2023-INS-12-F03). Ref: EPA SDWA.',
    `finding_type` STRING COMMENT 'Specific type or nature of the finding (e.g., treatment process deficiency, monitoring inadequacy, recordkeeping failure, operational practice issue, infrastructure condition). Ref: EPA SDWA.',
    `identified_date` DATE COMMENT 'Date on which the finding was identified during the inspection or sanitary survey. Ref: EPA SDWA.',
    `inspector_agency` STRING COMMENT 'Regulatory agency or organization that conducted the inspection (e.g., U.S. Environmental Protection Agency (EPA), State Department of Environmental Quality, County Health Department). Ref: EPA SDWA.',
    `inspector_name` STRING COMMENT 'Name of the regulatory inspector or auditor who identified and documented this finding. Ref: EPA SDWA.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this inspection finding record. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection finding record was last updated or modified. Ref: EPA SDWA.',
    `location_description` STRING COMMENT 'Physical location or geographic description where the finding was observed (e.g., Building 2 Chemical Feed Room, Main Street Pump Station, Laboratory Sample Storage Area). Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the finding, corrective action, or resolution process. Ref: EPA SDWA.',
    `public_health_impact` STRING COMMENT 'Assessment of the actual or potential impact of this finding on public health and drinking water safety. Ref: EPA SDWA.. Valid values are `immediate|potential|minimal|none`',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this finding is a recurrence of a previously identified and supposedly corrected deficiency, suggesting systemic or persistent compliance issues. Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'Specific federal, state, or local regulation, code section, or permit condition that is the basis for this finding (e.g., 40 CFR 141.21, State Primacy Code Section 12.3.4, NPDES Permit Condition IV.A.2). Ref: EPA SDWA.',
    `required_corrective_action` STRING COMMENT 'Detailed description of the corrective action, remediation, or improvement required to address and resolve the finding, as specified by the inspector or regulatory authority. Ref: EPA SDWA.',
    `resolution_date` DATE COMMENT 'Date on which the corrective action was completed and the finding was resolved to the satisfaction of the regulatory authority. Ref: EPA SDWA.',
    `resolution_description` STRING COMMENT 'Detailed narrative describing the corrective actions taken, remediation steps implemented, and evidence demonstrating resolution of the finding. Ref: EPA SDWA.',
    `resolution_status` STRING COMMENT 'Current status of the finding in the corrective action lifecycle, tracking progress from identification through closure. Ref: EPA SDWA.. Valid values are `open|in_progress|pending_verification|resolved|closed|overdue`',
    `responsible_party` STRING COMMENT 'Name or title of the individual, department, or organizational unit assigned responsibility for implementing the corrective action (e.g., Operations Manager, Maintenance Supervisor, Laboratory Director).',
    `risk_level` STRING COMMENT 'Assessment of the potential risk to public health, environmental quality, or regulatory compliance posed by this finding if not corrected. Ref: EPA SDWA.. Valid values are `critical|high|medium|low|negligible`',
    `severity` STRING COMMENT 'Severity. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `verification_date` DATE COMMENT 'Date on which the corrective action was verified and confirmed by the regulatory authority or internal quality assurance team. Ref: EPA SDWA.',
    `verification_method` STRING COMMENT 'Method or process used to verify and confirm that the corrective action was effective and the finding has been satisfactorily resolved (e.g., follow-up inspection, photographic evidence, laboratory test results, operational data review). Ref: EPA SDWA.',
    `verified_by` STRING COMMENT 'Name or title of the individual or agency that verified the corrective action and confirmed resolution of the finding. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this inspection finding record. Ref: EPA SDWA.',
    CONSTRAINT pk_inspection_finding PRIMARY KEY(`inspection_finding_id`)
) COMMENT 'Individual deficiency or finding identified during a regulatory inspection or sanitary survey, including the finding category (significant deficiency, minor deficiency, recommendation), regulatory citation, description of the non-conformance, affected system or process, required corrective action, corrective action deadline, responsible party, and resolution status. Enables systematic tracking of all inspection findings through to closure and provides evidence for regulatory follow-up correspondence.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` (
    `compliance_corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key. Ref: EPA SDWA.',
    `laboratory_corrective_action_id` BIGINT COMMENT 'Canonical reference to laboratory.quality_corrective_action. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Regulatory violations trigger capital improvement projects (consent decree requiring new treatment capacity, enforcement action mandating infrastructure upgrades). Corrective actions reference the imp. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corrective actions must be assigned to specific employees for completion tracking and accountability. Supports workload management, deadline monitoring, and regulatory reporting of corrective action s. Ref: EPA SDWA.',
    `compliance_responsible_employee_id` BIGINT COMMENT 'Owner. Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Violation. Ref: EPA SDWA.',
    `encumbrance_id` BIGINT COMMENT 'Foreign key linking to finance.encumbrance. Business justification: Corrective action contracts create encumbrances against budgets when purchase orders or contracts are issued. Standard governmental accounting practice for commitment tracking. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Reference to the enforcement action that mandated this corrective action, if applicable. Ref: EPA SDWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Corrective actions require budget allocation for implementation (equipment, consulting, construction). Essential for capital and operating budget planning and tracking compliance-driven expenditures. Ref: EPA SDWA.',
    `inspection_finding_id` BIGINT COMMENT 'Reference to the inspection finding that identified the compliance gap requiring corrective action. Ref: EPA SDWA.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: Corrective actions can be triggered by SSO/CSO overflow events. The overflow_event table has text fields for corrective_action_taken and preventive_action_planned, but no structured link to the correc. Ref: EPA SDWA.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Corrective actions requiring equipment, materials, or services are procured via purchase orders. Links compliance remediation to procurement for cost tracking and completion verification. Ref: EPA SDWA.',
    `treatment_violation_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_violation. Business justification: Corrective actions respond to treatment violations requiring resolution. Business process: violation resolution workflows where compliance-tracked corrective actions (equipment repairs, process adjust. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Corrective actions frequently engage vendors for specialized services, equipment supply, or consulting to resolve violations. Tracks vendor accountability for compliance restoration. Ref: EPA SDWA.',
    `action_description` STRING COMMENT 'Detailed description of the corrective action to be taken, including specific tasks, procedures, and deliverables required to address the compliance gap. Ref: EPA SDWA.',
    `action_number` STRING COMMENT 'Business identifier for the corrective action, typically formatted as a human-readable reference number for tracking and reporting. Ref: EPA SDWA.',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective action, tracking progress from planning through completion and verification. Ref: EPA SDWA.. Valid values are `planned|in_progress|pending_verification|completed|overdue|cancelled`',
    `action_title` STRING COMMENT 'Brief descriptive title summarizing the corrective action for quick identification and reporting. Ref: EPA SDWA.',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was fully implemented and completed, used to track compliance with regulatory deadlines. Ref: EPA SDWA.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action, tracked for budget management and regulatory reporting. Ref: EPA SDWA.',
    `actual_start_date` DATE COMMENT 'Actual date when implementation of the corrective action commenced. Ref: EPA SDWA.',
    `agency_notification_date` DATE COMMENT 'Date when the regulatory agency was formally notified of the corrective action plan or completion, fulfilling reporting requirements. Ref: EPA SDWA.',
    `agency_notification_method` STRING COMMENT 'Method used to notify the regulatory agency of the corrective action, such as formal letter, email, portal submission, phone, or in-person meeting. Ref: EPA SDWA.. Valid values are `formal_letter|email|portal_submission|phone|in_person_meeting`',
    `agency_response` STRING COMMENT 'Summary of the regulatory agencys response to the corrective action notification, including any feedback, approval, or additional requirements. Ref: EPA SDWA.',
    `closure_notes` STRING COMMENT 'Final notes documenting the closure of the corrective action, including lessons learned and recommendations for future compliance management. Ref: EPA SDWA.',
    `completion_date` DATE COMMENT 'Completion date. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system, establishing the audit trail. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'Due date. Ref: EPA SDWA.',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess the long-term effectiveness of the corrective action and any preventive measures. Ref: EPA SDWA.',
    `effectiveness_review_outcome` STRING COMMENT 'Summary of the effectiveness review findings, documenting whether the corrective action achieved sustained compliance improvement. Ref: EPA SDWA.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action, including labor, materials, equipment, and any third-party services. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was last updated, supporting audit trail and change tracking requirements. Ref: EPA SDWA.',
    `planned_completion_date` DATE COMMENT 'Target date by which the corrective action must be fully implemented and completed, often driven by regulatory deadlines or consent decree requirements. Ref: EPA SDWA.',
    `planned_start_date` DATE COMMENT 'Scheduled date when implementation of the corrective action is planned to begin. Ref: EPA SDWA.',
    `preventive_action_description` STRING COMMENT 'Description of preventive measures implemented to address systemic issues and prevent future occurrences of similar compliance gaps. Ref: EPA SDWA.',
    `preventive_action_implemented` BOOLEAN COMMENT 'Indicates whether preventive actions were implemented to prevent recurrence of the compliance gap or violation. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'Priority classification indicating the urgency and importance of the corrective action based on risk, regulatory requirements, and potential impact. Ref: EPA SDWA.. Valid values are `critical|high|medium|low`',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_agency_notified` BOOLEAN COMMENT 'Indicates whether the relevant regulatory agency (EPA, state primacy agency, etc.) was notified of the corrective action as required by enforcement orders or consent decrees. Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Name of the department or organizational unit responsible for implementing and completing the corrective action. Ref: EPA SDWA.',
    `responsible_individual` STRING COMMENT 'Name of the individual assigned accountability for ensuring the corrective action is completed on time and meets all requirements. Ref: EPA SDWA.',
    `root_cause_analysis` STRING COMMENT 'Documented analysis identifying the underlying root cause(s) of the compliance gap or violation, supporting effective corrective action design. Ref: EPA SDWA.',
    `ssot_role` STRING COMMENT 'SSOT cross-domain reconciliation link. Ref: EPA SDWA.',
    `supporting_evidence_location` STRING COMMENT 'File path, document management system reference, or physical location where supporting evidence and documentation for the corrective action is stored for audit trail purposes. Ref: EPA SDWA.',
    `triggering_event_description` STRING COMMENT 'Narrative description of the specific event or condition that triggered the need for corrective action, providing context for the compliance response. Ref: EPA SDWA.',
    `triggering_event_type` STRING COMMENT 'Classification of the event that initiated this corrective action, such as regulatory violation, enforcement action, inspection finding, internal audit, self-disclosure, or customer complaint. Ref: EPA SDWA.. Valid values are `regulatory_violation|enforcement_action|inspection_finding|internal_audit|self_disclosure|customer_complaint`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective through the specified verification method. Ref: EPA SDWA.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was implemented effectively and achieved the intended compliance outcome, such as internal audit, third-party audit, regulatory inspection, documentation review, testing, or monitoring. Ref: EPA SDWA.. Valid values are `internal_audit|third_party_audit|regulatory_inspection|documentation_review|testing|monitoring`',
    `verification_notes` STRING COMMENT 'Detailed notes documenting the verification process, findings, and any additional observations regarding the effectiveness of the corrective action. Ref: EPA SDWA.',
    `verification_status` STRING COMMENT 'Status of the verification process indicating whether the corrective action has been confirmed as effective in addressing the compliance gap. Ref: EPA SDWA.. Valid values are `pending|verified_effective|verified_ineffective|requires_additional_action`',
    CONSTRAINT pk_compliance_corrective_action PRIMARY KEY(`compliance_corrective_action_id`)
) COMMENT 'Formal corrective action plan or individual corrective action item initiated in response to a regulatory violation, enforcement action, inspection finding (including sanitary survey significant deficiencies), or internal compliance gap. Tracks the triggering event type and reference, corrective action description, priority classification, responsible department and individual, planned and actual completion dates, interim milestones, verification method, supporting evidence documentation, cost estimate, regulatory agency notification requirements, and closure approval. Provides the auditable trail demonstrating the utilitys good-faith compliance response and is the primary artifact reviewed during follow-up inspections. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for corrective actions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which this submission is being made (NPDES permit, IUP, state discharge permit, etc.). Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory submissions (permit applications, engineering reports, compliance plans) often prepared by consulting vendors. Tracks vendor responsibility for submission quality and timeliness. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the water or wastewater facility (WTP, WWTP, pumping station, etc.) that this submission pertains to. Ref: EPA SDWA.',
    `lab_work_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_work_order. Business justification: Regulatory submissions (DMRs, MORs, compliance reports) often fulfill laboratory work orders for compliance monitoring. Direct link tracks regulatory deliverable completion and enables cost allocation. Ref: EPA SDWA.',
    `original_submission_regulatory_submission_id` BIGINT COMMENT 'Reference to the original submission record if this submission is a correction, amendment, or resubmission. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who prepared and submitted the regulatory report. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Reference to the regulatory agency receiving this submission (EPA, state primacy agency, local health department, etc.). Ref: EPA SDWA.',
    `acknowledgment_received_date` DATE COMMENT 'The date on which the regulatory agency acknowledged receipt of the submission (via NetDMR confirmation, email reply, or other means). Ref: EPA SDWA.',
    `acknowledgment_reference_number` STRING COMMENT 'The confirmation or tracking number provided by the regulatory agency upon receipt of the submission. Ref: EPA SDWA.',
    `agency_comments` STRING COMMENT 'Comments, feedback, or instructions provided by the regulatory agency regarding the submission. Ref: EPA SDWA.',
    `agency_response_date` DATE COMMENT 'The date on which the regulatory agency provided a formal response, feedback, or determination regarding the submission. Ref: EPA SDWA.',
    `agency_response_type` STRING COMMENT 'The type of response or action taken by the regulatory agency in response to the submission. Ref: EPA SDWA.. Valid values are `accepted|rejected|request_for_information|notice_of_violation|enforcement_action|no_response`',
    `amendment_reason` STRING COMMENT 'Explanation of why the submission was amended or corrected, including the nature of the error or omission in the original submission. Ref: EPA SDWA.',
    `certification_date` DATE COMMENT 'The date on which the certifying official signed and certified the submission. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was first created in the system. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'The regulatory deadline by which this submission must be filed to remain in compliance. Ref: EPA SDWA.',
    `exceedance_count` STRING COMMENT 'The number of parameter exceedances (values above permit limits but not necessarily violations) reported in this submission. Ref: EPA SDWA.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this submission is an amendment or correction to a previously submitted report. Ref: EPA SDWA.',
    `is_late_submission` BOOLEAN COMMENT 'Indicates whether the submission was filed after the regulatory due date, which may trigger enforcement action or violation notices. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was last updated or modified. Ref: EPA SDWA.',
    `noncompliance_explanation` STRING COMMENT 'Narrative explanation provided by the utility for any violations, exceedances, or non-compliance events reported in the submission, including corrective actions taken or planned. Ref: EPA SDWA.',
    `public_notice_date` DATE COMMENT 'The date on which public notification was issued, if required. Ref: EPA SDWA.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether this submission requires public notification (e.g., CCR publication, SSO public notice, boil water advisory).',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `reference_number` STRING COMMENT 'Reference number. Ref: EPA SDWA.',
    `reporting_period_end_date` DATE COMMENT 'The ending date of the time period covered by this regulatory submission. Ref: EPA SDWA.',
    `reporting_period_start_date` DATE COMMENT 'The beginning date of the time period covered by this regulatory submission. Ref: EPA SDWA.',
    `resubmission_required` BOOLEAN COMMENT 'Indicates whether the regulatory agency has requested a corrected or amended resubmission of the report. Ref: EPA SDWA.',
    `submission_date` DATE COMMENT 'The date on which the regulatory submission was formally submitted to the regulatory agency. This is the principal business event timestamp for the submission. Ref: EPA SDWA.',
    `submission_file_format` STRING COMMENT 'The file format or media type of the submitted report. Ref: EPA SDWA.. Valid values are `PDF|XML|CSV|Excel|paper|other`',
    `submission_file_path` STRING COMMENT 'The file system path or document management system reference to the submitted report document (PDF, XML, CSV, etc.). Ref: EPA SDWA.',
    `submission_method` STRING COMMENT 'The method or channel used to submit the report to the regulatory agency. NetDMR is the EPA electronic discharge monitoring reporting system. Ref: EPA SDWA.. Valid values are `NetDMR|state_portal|email|paper|fax|hand_delivery`',
    `submission_notes` STRING COMMENT 'Internal notes, comments, or additional context regarding the preparation, submission, or follow-up actions for this regulatory submission. Ref: EPA SDWA.',
    `submission_number` STRING COMMENT 'Business identifier or tracking number assigned to the regulatory submission, often used for external reference and correspondence with regulatory agencies. Ref: EPA SDWA.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission indicating its progress through the submission and review workflow. Ref: EPA SDWA.. Valid values are `draft|submitted|acknowledged|accepted|rejected|under_review`',
    `submission_type` STRING COMMENT 'Category of regulatory submission. DMR = Discharge Monitoring Report, MOR = Monthly Operating Report, CCR = Consumer Confidence Report, SSO = Sanitary Sewer Overflow, CSO = Combined Sewer Overflow, PFAS = Per- and Polyfluoroalkyl Substances, LCRR = Lead and Copper Rule Revisions. [ENUM-REF-CANDIDATE: DMR|MOR|CCR|SSO_notification|CSO_notification|pretreatment_report|annual_report|PFAS_report|LCRR_inventory|permit_application|variance_request|other — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `violation_count` STRING COMMENT 'The number of permit limit violations or non-compliance events reported in this submission. Ref: EPA SDWA.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Master record of all formal regulatory submissions made by the utility to regulatory agencies, serving as the single audit trail for submission compliance. Covers DMR submissions (via NetDMR), MOR submissions, CCR certifications, annual compliance reports, pretreatment program reports, SSO/CSO notifications, PFAS reporting, LCRR service line inventory submissions, and Lead Service Line Replacement (LSLR) progress reports. Tracks submission type, receiving agency, submission date, submission method (NetDMR, state portal, paper, email), reporting period, submitter, certifying official, certification status, acknowledgment receipt, late submission flags, and resubmission history. Enables monitoring of submission timeliness — a key compliance metric tracked by state primacy agencies.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` (
    `regulatory_correspondence_id` BIGINT COMMENT 'Unique identifier for the regulatory correspondence record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key reference to the permit record associated with this correspondence, if applicable (e.g., NPDES permit, IUP, state primacy agency permit). Ref: EPA SDWA.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key reference to the violation record associated with this correspondence, if applicable (e.g., response to Notice of Violation (NOV), enforcement action correspondence). Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Regulatory correspondence can be about enforcement actions (notices of violation, consent orders, penalty assessments, compliance agreements). The regulatory_correspondence table has enforcement_actio. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Foreign key reference to the facility (Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pumping station, etc.) that is the subject of the correspondence. Ref: EPA SDWA.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: SSO/CSO events require regulatory notification and often generate correspondence with EPA or state agencies. The overflow_event table tracks regulatory_notification_date and regulatory_agency_notified. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspections generate correspondence including inspection reports, responses to findings, and follow-up communications. The regulatory_correspondence table currently links to permit, violati. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory correspondence requires designated utility contact for continuity and accountability. Links to employee for contact information, response tracking, and workload management. Replaces denorma. Ref: EPA SDWA.',
    `agency_contact_email` STRING COMMENT 'Email address of the agency contact person for follow-up communication. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the regulatory agency representative or contact person who authored or is responsible for the correspondence. Ref: EPA SDWA.',
    `agency_contact_phone` STRING COMMENT 'Phone number of the agency contact person for direct communication. Ref: EPA SDWA.',
    `agency_contact_title` STRING COMMENT 'Job title or position of the agency contact person (e.g., Compliance Officer, Regional Administrator, Program Manager). Ref: EPA SDWA.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the correspondence contains confidential business information (CBI) or trade secrets that are protected from public disclosure (True/False). Ref: EPA SDWA.',
    `correspondence_date` DATE COMMENT 'Date the correspondence was sent (for outgoing) or received (for incoming). This is the principal business event timestamp for the correspondence. Ref: EPA SDWA.',
    `correspondence_number` STRING COMMENT 'Business identifier or reference number assigned to the correspondence for tracking and filing purposes. May follow agency or internal numbering conventions. Ref: EPA SDWA.',
    `correspondence_status` STRING COMMENT 'Current lifecycle status of the correspondence record (e.g., active, closed, archived, under review). Ref: EPA SDWA.. Valid values are `active|closed|archived|under_review`',
    `correspondence_type` STRING COMMENT 'Classification of the correspondence document type (e.g., letter, notice, response to Notice of Violation (NOV), request for information, variance application, waiver request, extension request, agency response, inspection report, technical memorandum). [ENUM-REF-CANDIDATE: letter|notice|response|request_for_information|variance_application|waiver_request|extension_request|nov_response|agency_response|inspection_report|technical_memorandum — 11 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondence record was first created in the system. Ref: EPA SDWA.',
    `direction` STRING COMMENT 'Indicates whether the correspondence is incoming (received from regulatory agency) or outgoing (sent by the utility to regulatory agency). Ref: EPA SDWA.. Valid values are `incoming|outgoing`',
    `disposition_date` DATE COMMENT 'Date on which the correspondence record is eligible for disposition (archival or destruction) per records retention policy. Null if not yet determined. Ref: EPA SDWA.',
    `document_format` STRING COMMENT 'Format of the correspondence document (e.g., PDF, DOCX, email, paper, other). Ref: EPA SDWA.. Valid values are `pdf|docx|email|paper|other`',
    `document_reference` STRING COMMENT 'Reference identifier, file path, or URL to the stored correspondence document (e.g., document management system reference, SharePoint path, network drive location). Ref: EPA SDWA.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether the correspondence is related to a regulatory enforcement action (e.g., Notice of Violation (NOV), consent decree, administrative order) (True/False). Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondence record was last updated or modified. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for internal notes, comments, or additional context regarding the correspondence, follow-up actions, or related discussions. Ref: EPA SDWA.',
    `priority` STRING COMMENT 'Priority level assigned to the correspondence based on urgency, regulatory significance, or potential enforcement implications (e.g., low, medium, high, critical). Ref: EPA SDWA.. Valid values are `low|medium|high|critical`',
    `public_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether the correspondence or its content must be disclosed to the public (e.g., as part of Consumer Confidence Report (CCR), public notice, or Freedom of Information Act (FOIA) request) (True/False). Ref: EPA SDWA.',
    `received_date` DATE COMMENT 'Date the incoming correspondence was officially received and logged by the utility. Null for outgoing correspondence. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency involved in the correspondence (e.g., U.S. Environmental Protection Agency (EPA), State Drinking Water Program, State Department of Environmental Quality, Public Utilities Commission). Ref: EPA SDWA.',
    `regulatory_program` STRING COMMENT 'The regulatory program or framework to which the correspondence pertains (e.g., Safe Drinking Water Act (SDWA), Clean Water Act (CWA), National Pollutant Discharge Elimination System (NPDES), Industrial User Permit (IUP), Consumer Confidence Report (CCR), Lead and Copper Rule Revisions (LCRR), Disinfection Byproduct (DBP) Rule, Groundwater Rule, Surface Water Treatment Rule). [ENUM-REF-CANDIDATE: sdwa|cwa|npdes|iup|ccr|lcrr|dbp|groundwater_rule|surface_water_treatment_rule|other — 10 candidates stripped; promote to reference product]',
    `response_deadline_date` DATE COMMENT 'Date by which the utility must submit a response to the regulatory agency, if a response is required. Null if no response deadline applies. Ref: EPA SDWA.',
    `response_required_flag` BOOLEAN COMMENT 'Indicates whether a formal response from the utility is required for this correspondence (True/False). Ref: EPA SDWA.',
    `response_status` STRING COMMENT 'Current status of the utilitys response to the correspondence (e.g., not required, pending, in progress, submitted, accepted by agency, rejected by agency, overdue). [ENUM-REF-CANDIDATE: not_required|pending|in_progress|submitted|accepted|rejected|overdue — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `response_submitted_date` DATE COMMENT 'Date the utility submitted its response to the regulatory agency. Null if no response has been submitted or is not required. Ref: EPA SDWA.',
    `retention_period_years` STRING COMMENT 'Number of years the correspondence record must be retained per regulatory or internal records retention policy. Ref: EPA SDWA.',
    `sent_date` DATE COMMENT 'Date the outgoing correspondence was officially sent or transmitted by the utility. Null for incoming correspondence. Ref: EPA SDWA.',
    `subject` STRING COMMENT 'Subject line or title of the correspondence describing the primary topic or purpose. Ref: EPA SDWA.',
    `summary` STRING COMMENT 'Brief summary or abstract of the correspondence content, key points, and any actions requested or required. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `utility_contact_title` STRING COMMENT 'Job title or position of the utility contact person (e.g., Compliance Manager, Director of Operations, Environmental Manager). Ref: EPA SDWA.',
    CONSTRAINT pk_regulatory_correspondence PRIMARY KEY(`regulatory_correspondence_id`)
) COMMENT 'Record of all formal written correspondence exchanged between the utility and regulatory agencies, including letters, notices, responses to NOVs, requests for extensions, variance applications, waiver requests, and agency responses. Tracks the correspondence type, direction (incoming/outgoing), agency, contact person, date sent or received, subject matter, associated permit or violation, response deadline, and document reference. Maintains the complete regulatory communication audit trail.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` (
    `pretreatment_iup_id` BIGINT COMMENT 'Unique identifier for the Industrial User Permit record in the pretreatment program. Ref: EPA SDWA.',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Industrial user permit fees generate AR transactions for billing and collection. Direct revenue link essential for pretreatment program cost recovery and accounts receivable management. Ref: EPA SDWA.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Industrial user permits under pretreatment programs require dedicated billing accounts to track monitoring fees, inspection costs, surcharges for permit exceedances, and administrative charges. Pretre. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Federal pretreatment regulations require designated coordinator for each industrial user permit. Links to employee for certification verification, workload tracking, and regulatory accountability. Rep. Ref: EPA SDWA.',
    `industrial_user_id` BIGINT COMMENT 'Reference to the industrial user (customer/facility) to whom this permit is issued. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Industrial user permits reference vendors providing pretreatment equipment or monitoring services. Essential for tracking approved vendors and equipment compliance with categorical standards. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: Industrial user permits specify sampling locations for compliance monitoring (e.g., pretreatment system effluent). Pretreatment program requirement links permit to physical sampling point, eliminates. Ref: EPA SDWA.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The average permitted daily wastewater discharge flow rate from the industrial user, measured in Million Gallons per Day (MGD). Ref: EPA SDWA.',
    `bmp_requirements` STRING COMMENT 'Description of the Best Management Practices (BMPs) the industrial user must implement to minimize pollutant discharge and ensure compliance. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current compliance status of the industrial user with permit discharge limits and reporting requirements: Compliant, Non-Compliant, Significant Non-Compliance (SNC), or Under Review. Ref: EPA SDWA.. Valid values are `compliant|non_compliant|significant_non_compliance|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this Industrial User Permit record was first created in the system. Ref: EPA SDWA.',
    `discharge_point_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate of the industrial users discharge point to the sewer system. Ref: EPA SDWA.',
    `discharge_point_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate of the industrial users discharge point to the sewer system. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'The date on which the Industrial User Permit becomes legally effective and enforceable. Ref: EPA SDWA.',
    `enforcement_action_pending` BOOLEAN COMMENT 'Indicates whether there is an active enforcement action (notice of violation, administrative order, consent decree, or legal action) pending against the industrial user. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'The date on which the Industrial User Permit expires and must be renewed or reissued. Ref: EPA SDWA.',
    `facility_address` STRING COMMENT 'The physical street address of the industrial facility discharging to the municipal sewer system. Ref: EPA SDWA.',
    `facility_city` STRING COMMENT 'The city where the industrial facility is located. Ref: EPA SDWA.',
    `facility_name` STRING COMMENT 'The legal or trade name of the industrial facility covered by this permit. Ref: EPA SDWA.',
    `facility_postal_code` STRING COMMENT 'The postal or ZIP code of the industrial facility location. Ref: EPA SDWA.',
    `facility_state` STRING COMMENT 'The state or province where the industrial facility is located. Ref: EPA SDWA.',
    `inspection_frequency` STRING COMMENT 'The frequency at which the utility must conduct on-site inspections of the industrial users facility and pretreatment equipment. Ref: EPA SDWA.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `issuance_date` DATE COMMENT 'The date on which the permit was officially issued by the utility to the industrial user. Ref: EPA SDWA.',
    `issue_date` DATE COMMENT 'Issue date. Ref: EPA SDWA.',
    `iup_status` STRING COMMENT 'Status. Ref: EPA SDWA.',
    `last_compliance_assessment_date` DATE COMMENT 'The date of the most recent compliance assessment or evaluation conducted by the utility for this industrial user. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent on-site inspection conducted by the utility at the industrial users facility. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this Industrial User Permit record was last updated or modified in the system. Ref: EPA SDWA.',
    `last_renewal_date` DATE COMMENT 'The date of the most recent permit renewal or modification. Ref: EPA SDWA.',
    `maximum_daily_flow_mgd` DECIMAL(18,2) COMMENT 'The maximum permitted daily wastewater discharge flow rate from the industrial user to the municipal sewer system, measured in Million Gallons per Day (MGD). Ref: EPA SDWA.',
    `monitoring_frequency` STRING COMMENT 'The required frequency at which the industrial user must sample and analyze wastewater discharge for compliance with permit limits. Ref: EPA SDWA.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `naics_code` STRING COMMENT 'The six-digit NAICS code classifying the industrial users business sector and activity. Ref: EPA SDWA.',
    `next_report_due_date` DATE COMMENT 'The date by which the industrial user must submit the next compliance monitoring report to the utility. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the Industrial User Permit, compliance history, or facility operations. Ref: EPA SDWA.',
    `permit_conditions` STRING COMMENT 'Detailed text of special conditions, requirements, or restrictions imposed on the industrial user as part of this permit. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'The externally-known unique permit number assigned to the industrial user by the utility under the NPDES pretreatment program. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the Industrial User Permit: Active, Expired, Suspended, Revoked, Pending Renewal, or Terminated. Ref: EPA SDWA.. Valid values are `active|expired|suspended|revoked|pending_renewal|terminated`',
    `permit_type` STRING COMMENT 'Type of Industrial User Permit: Individual (facility-specific), General (standard conditions for a category), or Conditional (temporary or limited scope). Ref: EPA SDWA.. Valid values are `individual|general|conditional`',
    `pretreatment_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to pretreat wastewater before discharge to the municipal sewer system. Ref: EPA SDWA.',
    `pretreatment_technology_description` STRING COMMENT 'Description of the pretreatment technologies and processes the industrial user must employ to meet discharge limits (e.g., pH adjustment, oil-water separation, metals precipitation). Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `reporting_frequency` STRING COMMENT 'The required frequency at which the industrial user must submit compliance monitoring reports to the utility. Ref: EPA SDWA.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `sic_code` STRING COMMENT 'The four-digit SIC code classifying the industrial users primary business activity and process type. Ref: EPA SDWA.',
    `siu_classification` STRING COMMENT 'Classification of the industrial user under the pretreatment program: Significant Industrial User (SIU), Categorical Industrial User (CIU), Non-Significant Categorical User (NSCIU), or Non-Categorical User. Ref: EPA SDWA.. Valid values are `significant_industrial_user|categorical_industrial_user|non_significant_categorical_user|non_categorical_user`',
    `slug_control_plan_approval_date` DATE COMMENT 'The date on which the utilitys pretreatment coordinator approved the industrial users slug discharge control plan. Ref: EPA SDWA.',
    `slug_control_plan_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to develop and maintain a slug discharge control plan to prevent accidental or intentional spills. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_pretreatment_iup PRIMARY KEY(`pretreatment_iup_id`)
) COMMENT 'Industrial User Permit (IUP) issued by the utilitys pretreatment program to significant industrial users (SIUs) and categorical industrial users (CIUs), authorizing discharge of industrial wastewater to the publicly owned treatment works (POTW). Tracks the industrial user identity, SIC/NAICS code, permit number, categorical standards applicable (40 CFR 400-471), permitted discharge limits by pollutant (metals, BOD, TSS, FOG, pH), self-monitoring requirements, reporting schedule (semi-annual compliance reports), best management practices (BMPs), slug control plan requirements, permit effective and expiration dates, compliance status, and enforcement history. Supports the utilitys federally-mandated pretreatment program administration under 40 CFR Part 403.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` (
    `industrial_user_id` BIGINT COMMENT 'Unique identifier for the industrial user record in the pretreatment program registry. Primary key. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Industrial users have approved vendors for pretreatment system maintenance, monitoring, and sampling. Tracks vendor qualifications and service agreements for pretreatment program compliance. Ref: EPA SDWA.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Each industrial user in the pretreatment program must have a billing account for cost recovery of monitoring, sampling, inspection, and enforcement activities. Federal pretreatment regulations require. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key reference to the Industrial User Permit (IUP) assigned to this industrial user under the pretreatment program. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each industrial user requires assigned pretreatment coordinator for compliance monitoring, sampling coordination, and regulatory reporting. Links to employee for workload management and certification. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Industrial users follow specific sampling plans for permit compliance (frequency, parameters, methods). Pretreatment oversight requires direct link from industrial user to their assigned sampling plan. Ref: EPA SDWA.',
    `address` STRING COMMENT 'Address. Ref: EPA SDWA.',
    `annual_certification_due_date` DATE COMMENT 'Due date for the industrial users annual certification of compliance with applicable pretreatment standards. Ref: EPA SDWA.',
    `baseline_monitoring_report_date` DATE COMMENT 'Date the Baseline Monitoring Report (BMR) was submitted by the industrial user. Ref: EPA SDWA.',
    `baseline_monitoring_report_submitted` BOOLEAN COMMENT 'Indicates whether the industrial user has submitted the required Baseline Monitoring Report (BMR) for categorical users. Ref: EPA SDWA.',
    `categorical_flag` BOOLEAN COMMENT 'Categorical user flag. Ref: EPA SDWA.',
    `categorical_standard_applicable` BOOLEAN COMMENT 'Indicates whether the industrial user is subject to EPA categorical pretreatment standards for a specific industry category. Ref: EPA SDWA.',
    `categorical_standard_reference` STRING COMMENT 'Citation of the specific EPA categorical pretreatment standard applicable to this industrial user (e.g., 40 CFR Part 433 for Metal Finishing). Ref: EPA SDWA.',
    `city` STRING COMMENT 'City where the industrial facility is located. Ref: EPA SDWA.',
    `classification` STRING COMMENT 'Classification of the industrial user under the pretreatment program: Significant Industrial User (SIU), Categorical Industrial User (CIU), Non-Significant Industrial User, or Exempt. Ref: EPA SDWA.. Valid values are `Significant Industrial User (SIU)|Categorical Industrial User (CIU)|Non-Significant Industrial User|Exempt`',
    `compliance_status` STRING COMMENT 'Current compliance status of the industrial user with respect to pretreatment standards and permit conditions. Ref: EPA SDWA.. Valid values are `In Compliance|Non-Compliance|Significant Non-Compliance (SNC)|Under Review|Enforcement Action`',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person for pretreatment program correspondence and reporting. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Full name of the primary contact person at the industrial facility responsible for pretreatment program compliance. Ref: EPA SDWA.',
    `contact_person_phone` STRING COMMENT 'Primary phone number of the contact person at the industrial facility. Ref: EPA SDWA.',
    `contact_person_title` STRING COMMENT 'Job title or role of the primary contact person at the industrial facility. Ref: EPA SDWA.',
    `contact_phone` STRING COMMENT 'Contact phone. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user record was first created in the system. Ref: EPA SDWA.',
    `discharge_connection_point` STRING COMMENT 'Identifier or description of the physical connection point where the industrial user discharges wastewater into the utilitys collection system (e.g., manhole ID, GPS coordinates). Ref: EPA SDWA.',
    `enforcement_action_pending` BOOLEAN COMMENT 'Indicates whether an enforcement action (administrative order, civil penalty, consent decree) is currently pending against this industrial user. Ref: EPA SDWA.',
    `estimated_discharge_volume_gpd` DECIMAL(18,2) COMMENT 'Estimated average daily wastewater discharge volume from the industrial facility in gallons per day (GPD). Ref: EPA SDWA.',
    `facility_address_line1` STRING COMMENT 'Primary street address of the industrial facility discharging to the wastewater collection system. Ref: EPA SDWA.',
    `facility_address_line2` STRING COMMENT 'Secondary address information (suite, building, floor) for the industrial facility. Ref: EPA SDWA.',
    `facility_name` STRING COMMENT 'Legal or trade name of the industrial or commercial facility subject to pretreatment requirements. Ref: EPA SDWA.',
    `inspection_frequency` STRING COMMENT 'Required frequency of compliance inspections for this industrial user as specified in the IUP or local pretreatment ordinance. Ref: EPA SDWA.. Valid values are `Annual|Semi-Annual|Quarterly|Monthly|As Needed`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the industrial user is currently active in the pretreatment program registry. False if the facility has closed or is no longer discharging. Ref: EPA SDWA.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection conducted at the industrial facility. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user record was last updated. Ref: EPA SDWA.',
    `last_sampling_date` DATE COMMENT 'Date of the most recent wastewater discharge sampling event for this industrial user. Ref: EPA SDWA.',
    `last_violation_date` DATE COMMENT 'Date of the most recent documented violation of pretreatment standards or permit limits by this industrial user. Ref: EPA SDWA.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code identifying the primary industrial activity of the facility, replacing SIC in modern classifications. Ref: EPA SDWA.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next compliance inspection of the industrial user. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this industrial user. Ref: EPA SDWA.',
    `pollutants_of_concern` STRING COMMENT 'Comma-separated list of key pollutants of concern discharged by this industrial user (e.g., Fats Oils and Grease (FOG), heavy metals, Biochemical Oxygen Demand (BOD), Total Suspended Solids (TSS), pH). Ref: EPA SDWA.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the industrial facility address. Ref: EPA SDWA.',
    `pretreatment_system_description` STRING COMMENT 'Description of the on-site pretreatment system, including technology type (e.g., oil-water separator, pH adjustment, metals precipitation). Ref: EPA SDWA.',
    `pretreatment_system_installed` BOOLEAN COMMENT 'Indicates whether the industrial user has installed on-site pretreatment equipment to reduce pollutant concentrations before discharge. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `sampling_frequency` STRING COMMENT 'Required frequency of wastewater discharge sampling for this industrial user as specified in the IUP. Ref: EPA SDWA.. Valid values are `Annual|Semi-Annual|Quarterly|Monthly|Weekly|As Required`',
    `sic_code` STRING COMMENT 'Four-digit Standard Industrial Classification code identifying the primary industrial activity of the facility. Ref: EPA SDWA.',
    `significant_industrial_user_flag` BOOLEAN COMMENT 'SIU flag. Ref: EPA SDWA.',
    `slug_discharge_notification_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to notify the utility immediately of any slug discharge or accidental spill that could cause interference or pass-through. Ref: EPA SDWA.',
    `state` STRING COMMENT 'State or province where the industrial facility is located. Ref: EPA SDWA.',
    `termination_date` DATE COMMENT 'Date the industrial user ceased operations or was removed from the pretreatment program registry. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `user_name` STRING COMMENT 'Industrial user name. Ref: EPA SDWA.',
    `violation_count_last_12_months` STRING COMMENT 'Total number of documented violations by this industrial user in the past 12 months. Ref: EPA SDWA.',
    `zero_discharge_certification` BOOLEAN COMMENT 'Indicates whether the industrial user has certified that they have no process wastewater discharge (zero discharge facility). Ref: EPA SDWA.',
    CONSTRAINT pk_industrial_user PRIMARY KEY(`industrial_user_id`)
) COMMENT 'Master record of industrial and commercial users subject to the utilitys pretreatment program, including Significant Industrial Users (SIUs), Categorical Industrial Users (CIUs), and non-significant industrial users. Tracks the business name, facility address, SIC/NAICS code, industrial user classification, assigned IUP, discharge connection point, estimated discharge volume (GPD), key pollutants of concern (FOG, heavy metals, BOD, TSS), inspection frequency, and compliance history. Authoritative registry for pretreatment program management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` (
    `overflow_event_id` BIGINT COMMENT 'Unique identifier for the overflow event referenced by each overflow event record in the compliance domain.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the permit compliance permit referenced by each overflow event record in the compliance domain.',
    `compliance_violation_id` BIGINT COMMENT 'compliance violation id for overflow_event. Ref: EPA SDWA.',
    `cso_event_id` BIGINT COMMENT 'cso event id for overflow_event. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility referenced by each overflow event record in the compliance domain.',
    `lift_station_id` BIGINT COMMENT 'Unique identifier for the lift station referenced by each overflow event record in the compliance domain.',
    `manhole_id` BIGINT COMMENT 'Unique identifier for the manhole referenced by each overflow event record in the compliance domain.',
    `outfall_id` BIGINT COMMENT 'Unique identifier for the outfall referenced by each overflow event record in the compliance domain.',
    `overflow_compliance_permit_id` BIGINT COMMENT 'Unique identifier for the overflow compliance permit referenced by each overflow event record in the compliance domain.',
    `employee_id` BIGINT COMMENT 'created by employee id for overflow_event. Ref: EPA SDWA.',
    `overflow_reported_by_employee_id` BIGINT COMMENT 'Unique identifier for the overflow reported by employee referenced by each overflow event record in the compliance domain.',
    `overflow_responsible_employee_id` BIGINT COMMENT 'responsible employee id for overflow_event. Ref: EPA SDWA.',
    `quality_public_notification_id` BIGINT COMMENT 'Unique identifier for the quality public notification referenced by each overflow event record in the compliance domain.',
    `registry_id` BIGINT COMMENT 'Unique identifier for the registry referenced by each overflow event record in the compliance domain.',
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency referenced by each overflow event record in the compliance domain.',
    `sso_event_id` BIGINT COMMENT 'sso event id for overflow_event. Ref: EPA SDWA.',
    `water_sample_id` BIGINT COMMENT 'Unique identifier for the water sample referenced by each overflow event record in the compliance domain.',
    `water_system_id` BIGINT COMMENT 'water system id for overflow_event. Ref: EPA SDWA.',
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order referenced by each overflow event record in the compliance domain.',
    `affected_service_connections` STRING COMMENT 'The affected service connections value recorded for each overflow event in the compliance domain.',
    `affected_zones` STRING COMMENT 'The affected zones value recorded for each overflow event in the compliance domain.',
    `agency_report_date` DATE COMMENT 'The agency report date associated with each overflow event record in the compliance domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'amount usd for overflow_event. Ref: EPA SDWA.',
    `beach_closure_required` BOOLEAN COMMENT 'The beach closure required value recorded for each overflow event in the compliance domain.',
    `building_backup_occurred` BOOLEAN COMMENT 'The building backup occurred value recorded for each overflow event in the compliance domain.',
    `overflow_event_category` STRING COMMENT 'category for overflow_event. Ref: EPA SDWA.',
    `cause` STRING COMMENT 'The cause value recorded for each overflow event in the compliance domain.',
    `cause_category` STRING COMMENT 'The cause category value recorded for each overflow event in the compliance domain.',
    `cause_code` STRING COMMENT 'The cause code value recorded for each overflow event in the compliance domain.',
    `cause_description` STRING COMMENT 'The cause description value recorded for each overflow event in the compliance domain.',
    `classification` STRING COMMENT 'classification for overflow_event. Ref: EPA SDWA.',
    `cleanup_completed` BOOLEAN COMMENT 'cleanup completed for overflow_event. Ref: EPA SDWA.',
    `cleanup_completed_date` DATE COMMENT 'The cleanup completed date associated with each overflow event record in the compliance domain.',
    `cleanup_completed_flag` BOOLEAN COMMENT 'The cleanup completed flag value recorded for each overflow event in the compliance domain.',
    `cleanup_completion_date` DATE COMMENT 'The cleanup completion date associated with each overflow event record in the compliance domain.',
    `cleanup_cost_usd` DECIMAL(18,2) COMMENT 'The cleanup cost usd value recorded for each overflow event in the compliance domain.',
    `comments` STRING COMMENT 'The comments value recorded for each overflow event in the compliance domain.',
    `compliance_corrective_action_id` BIGINT COMMENT 'corrective action id for overflow_event. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'compliance status for overflow_event. Ref: EPA SDWA.',
    `containment_actions` STRING COMMENT 'The containment actions value recorded for each overflow event in the compliance domain.',
    `containment_method` STRING COMMENT 'The containment method value recorded for each overflow event in the compliance domain.',
    `corrective_action_completed_date` DATE COMMENT 'The corrective action completed date associated with each overflow event record in the compliance domain.',
    `corrective_action_description` STRING COMMENT 'The corrective action description value recorded for each overflow event in the compliance domain.',
    `corrective_action_taken` STRING COMMENT 'The corrective action taken value recorded for each overflow event in the compliance domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each overflow event record in the compliance domain.',
    `data_source_system` STRING COMMENT 'The data source system value recorded for each overflow event in the compliance domain.',
    `overflow_event_description` STRING COMMENT 'description for overflow_event. Ref: EPA SDWA.',
    `detection_timestamp` TIMESTAMP COMMENT 'detection timestamp for overflow_event. Ref: EPA SDWA.',
    `discharge_location` STRING COMMENT 'The discharge location value recorded for each overflow event in the compliance domain.',
    `discharge_location_description` STRING COMMENT 'The discharge location description value recorded for each overflow event in the compliance domain.',
    `discharge_point_description` STRING COMMENT 'The discharge point description value recorded for each overflow event in the compliance domain.',
    `discovery_timestamp` TIMESTAMP COMMENT 'The discovery timestamp associated with each overflow event record in the compliance domain.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The duration hours value recorded for each overflow event in the compliance domain.',
    `duration_minutes` STRING COMMENT 'The duration minutes value recorded for each overflow event in the compliance domain.',
    `ecm_mvm_depth_reconciliation_note` STRING COMMENT 'ECM attribute depth reconciled to match or exceed MVM (prior ecm_depth=3, mvm_depth=8). ECM now carries the full backbone attribute set. Ref: EPA SDWA.',
    `effective_date` TIMESTAMP COMMENT 'effective date for overflow_event. Ref: EPA SDWA.',
    `effective_end_date` TIMESTAMP COMMENT 'effective end date for overflow_event. Ref: EPA SDWA.',
    `effective_start_date` TIMESTAMP COMMENT 'effective start date for overflow_event. Ref: EPA SDWA.',
    `end_date` TIMESTAMP COMMENT 'end date for overflow_event. Ref: EPA SDWA.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp associated with each overflow event record in the compliance domain.',
    `environmental_impact_assessment` STRING COMMENT 'The environmental impact assessment value recorded for each overflow event in the compliance domain.',
    `estimated_cleanup_cost_usd` DECIMAL(18,2) COMMENT 'The estimated cleanup cost usd value recorded for each overflow event in the compliance domain.',
    `estimated_volume_gallons` DECIMAL(18,2) COMMENT 'The estimated volume gallons value recorded for each overflow event in the compliance domain.',
    `estimated_volume_liters` DECIMAL(18,2) COMMENT 'The estimated volume liters value recorded for each overflow event in the compliance domain.',
    `event_cause` STRING COMMENT 'The event cause value recorded for each overflow event in the compliance domain.',
    `event_date` DATE COMMENT 'The event date associated with each overflow event record in the compliance domain.',
    `event_description` STRING COMMENT 'The event description value recorded for each overflow event in the compliance domain.',
    `event_duration_hours` DECIMAL(18,2) COMMENT 'The event duration hours value recorded for each overflow event in the compliance domain.',
    `event_end_timestamp` TIMESTAMP COMMENT 'The event end timestamp associated with each overflow event record in the compliance domain.',
    `event_number` STRING COMMENT 'The event number value recorded for each overflow event in the compliance domain.',
    `event_start_timestamp` TIMESTAMP COMMENT 'The event start timestamp associated with each overflow event record in the compliance domain.',
    `event_status` STRING COMMENT 'The event status value recorded for each overflow event in the compliance domain.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp associated with each overflow event record in the compliance domain.',
    `event_type` STRING COMMENT 'The event type value recorded for each overflow event in the compliance domain.',
    `expected_restoration_at` TIMESTAMP COMMENT 'The expected restoration at associated with each overflow event record in the compliance domain.',
    `expected_restoration_timestamp` TIMESTAMP COMMENT 'The expected restoration timestamp associated with each overflow event record in the compliance domain.',
    `expiration_date` TIMESTAMP COMMENT 'expiration date for overflow_event. Ref: EPA SDWA.',
    `health_advisory_issued` BOOLEAN COMMENT 'The health advisory issued value recorded for each overflow event in the compliance domain.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the overflow event record.',
    `is_recurring_location` BOOLEAN COMMENT 'Boolean flag indicating whether the is recurring location condition applies to the overflow event record.',
    `is_repeat_location` BOOLEAN COMMENT 'Boolean flag indicating whether the is repeat location condition applies to the overflow event record.',
    `is_resolved` BOOLEAN COMMENT 'Boolean flag indicating whether the is resolved condition applies to the overflow event record.',
    `is_wet_weather_event` BOOLEAN COMMENT 'Boolean flag indicating whether the is wet weather event condition applies to the overflow event record.',
    `jurisdiction` STRING COMMENT 'jurisdiction for overflow_event. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each overflow event record in the compliance domain.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the overflow event location.',
    `location_description` STRING COMMENT 'The location description value recorded for each overflow event in the compliance domain.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the overflow event location.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp associated with each overflow event record in the compliance domain.',
    `notes` STRING COMMENT 'The notes value recorded for each overflow event in the compliance domain.',
    `overflow_cause` STRING COMMENT 'The overflow cause value recorded for each overflow event in the compliance domain.',
    `overflow_event_code` STRING COMMENT 'overflow event code for overflow_event. Ref: EPA SDWA.',
    `overflow_event_name` STRING COMMENT 'overflow event name for overflow_event. Ref: EPA SDWA.',
    `overflow_event_number` STRING COMMENT 'The overflow event number value recorded for each overflow event in the compliance domain.',
    `overflow_event_status` STRING COMMENT 'overflow event status for overflow_event. Ref: EPA SDWA.',
    `overflow_event_type` STRING COMMENT 'overflow event type for overflow_event. Ref: EPA SDWA.',
    `overflow_location_description` STRING COMMENT 'The overflow location description value recorded for each overflow event in the compliance domain.',
    `overflow_status` STRING COMMENT 'The overflow status value recorded for each overflow event in the compliance domain.',
    `overflow_type` STRING COMMENT 'The overflow type value recorded for each overflow event in the compliance domain.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'The penalty amount usd value recorded for each overflow event in the compliance domain.',
    `percentage_value` DECIMAL(18,2) COMMENT 'percentage value for overflow_event. Ref: EPA SDWA.',
    `population_at_risk` STRING COMMENT 'The population at risk value recorded for each overflow event in the compliance domain.',
    `priority_level` STRING COMMENT 'priority level for overflow_event. Ref: EPA SDWA.',
    `public_notification_date` DATE COMMENT 'The public notification date associated with each overflow event record in the compliance domain.',
    `public_notification_issued` BOOLEAN COMMENT 'The public notification issued value recorded for each overflow event in the compliance domain.',
    `public_notification_required` BOOLEAN COMMENT 'The public notification required value recorded for each overflow event in the compliance domain.',
    `public_notification_required_flag` BOOLEAN COMMENT 'The public notification required flag value recorded for each overflow event in the compliance domain.',
    `public_notified_flag` BOOLEAN COMMENT 'The public notified flag value recorded for each overflow event in the compliance domain.',
    `quantity_value` DECIMAL(18,2) COMMENT 'quantity value for overflow_event. Ref: EPA SDWA.',
    `rainfall_duration_hours` DECIMAL(18,2) COMMENT 'The rainfall duration hours value recorded for each overflow event in the compliance domain.',
    `rainfall_inches` DECIMAL(18,2) COMMENT 'The rainfall inches value recorded for each overflow event in the compliance domain.',
    `reached_private_property` BOOLEAN COMMENT 'The reached private property value recorded for each overflow event in the compliance domain.',
    `reached_storm_drain` BOOLEAN COMMENT 'The reached storm drain value recorded for each overflow event in the compliance domain.',
    `reached_surface_water` BOOLEAN COMMENT 'The reached surface water value recorded for each overflow event in the compliance domain.',
    `reached_surface_water_flag` BOOLEAN COMMENT 'The reached surface water flag value recorded for each overflow event in the compliance domain.',
    `reached_water_body_flag` BOOLEAN COMMENT 'The reached water body flag value recorded for each overflow event in the compliance domain.',
    `reached_waters_flag` BOOLEAN COMMENT 'The reached waters flag value recorded for each overflow event in the compliance domain.',
    `reached_waters_of_state` BOOLEAN COMMENT 'The reached waters of state value recorded for each overflow event in the compliance domain.',
    `reached_waters_of_us` BOOLEAN COMMENT 'The reached waters of us value recorded for each overflow event in the compliance domain.',
    `receiving_water_body` STRING COMMENT 'The receiving water body value recorded for each overflow event in the compliance domain.',
    `record_number` STRING COMMENT 'record number for overflow_event. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'The record status value recorded for each overflow event in the compliance domain.',
    `recovered_volume_gallons` DECIMAL(18,2) COMMENT 'The recovered volume gallons value recorded for each overflow event in the compliance domain.',
    `reference_number` STRING COMMENT 'reference number for overflow_event. Ref: EPA SDWA.',
    `regulatory_citation` STRING COMMENT 'regulatory citation for overflow_event. Ref: EPA SDWA.',
    `regulatory_notification_date` DATE COMMENT 'The regulatory notification date associated with each overflow event record in the compliance domain.',
    `regulatory_notified_flag` BOOLEAN COMMENT 'The regulatory notified flag value recorded for each overflow event in the compliance domain.',
    `regulatory_reference` STRING COMMENT 'regulatory reference for overflow_event. Ref: EPA SDWA.',
    `regulatory_report_date` DATE COMMENT 'The regulatory report date associated with each overflow event record in the compliance domain.',
    `regulatory_report_method` STRING COMMENT 'The regulatory report method value recorded for each overflow event in the compliance domain.',
    `regulatory_report_required` BOOLEAN COMMENT 'The regulatory report required value recorded for each overflow event in the compliance domain.',
    `regulatory_report_required_hours` STRING COMMENT 'The regulatory report required hours value recorded for each overflow event in the compliance domain.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'The regulatory report submitted value recorded for each overflow event in the compliance domain.',
    `regulatory_report_submitted_date` DATE COMMENT 'The regulatory report submitted date associated with each overflow event record in the compliance domain.',
    `regulatory_reported_flag` BOOLEAN COMMENT 'The regulatory reported flag value recorded for each overflow event in the compliance domain.',
    `released_volume_gallons` DECIMAL(18,2) COMMENT 'released volume gallons for overflow_event. Ref: EPA SDWA.',
    `reported_date` DATE COMMENT 'The reported date associated with each overflow event record in the compliance domain.',
    `reported_flag` BOOLEAN COMMENT 'The reported flag value recorded for each overflow event in the compliance domain.',
    `reported_to_agency` BOOLEAN COMMENT 'The reported to agency value recorded for each overflow event in the compliance domain.',
    `reported_to_agency_date` TIMESTAMP COMMENT 'reported to agency date for overflow_event. Ref: EPA SDWA.',
    `reported_to_agency_flag` BOOLEAN COMMENT 'The reported to agency flag value recorded for each overflow event in the compliance domain.',
    `reported_to_agency_timestamp` TIMESTAMP COMMENT 'The reported to agency timestamp associated with each overflow event record in the compliance domain.',
    `reported_to_regulator_date` DATE COMMENT 'The reported to regulator date associated with each overflow event record in the compliance domain.',
    `reported_within_24hr` BOOLEAN COMMENT 'reported within 24hr for overflow_event. Ref: EPA SDWA.',
    `reported_within_deadline` BOOLEAN COMMENT 'The reported within deadline value recorded for each overflow event in the compliance domain.',
    `reporting_deadline_date` DATE COMMENT 'The reporting deadline date associated with each overflow event record in the compliance domain.',
    `resolution_date` TIMESTAMP COMMENT 'resolution date for overflow_event. Ref: EPA SDWA.',
    `resolution_status` STRING COMMENT 'resolution status for overflow_event. Ref: EPA SDWA.',
    `resolved_flag` BOOLEAN COMMENT 'resolved flag for overflow_event. Ref: EPA SDWA.',
    `response_time_minutes` STRING COMMENT 'The response time minutes value recorded for each overflow event in the compliance domain.',
    `root_cause_analysis` STRING COMMENT 'The root cause analysis value recorded for each overflow event in the compliance domain.',
    `service_connections_affected` STRING COMMENT 'service connections affected for overflow_event. Ref: EPA SDWA.',
    `start_date` TIMESTAMP COMMENT 'start date for overflow_event. Ref: EPA SDWA.',
    `start_time` TIMESTAMP COMMENT 'The start time associated with each overflow event record in the compliance domain.',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp associated with each overflow event record in the compliance domain.',
    `storm_recurrence_interval` STRING COMMENT 'The storm recurrence interval value recorded for each overflow event in the compliance domain.',
    `unit_of_measure` STRING COMMENT 'unit of measure for overflow_event. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp associated with each overflow event record in the compliance domain.',
    `volume_calculation_method` STRING COMMENT 'The volume calculation method value recorded for each overflow event in the compliance domain.',
    `volume_estimation_method` STRING COMMENT 'The volume estimation method value recorded for each overflow event in the compliance domain.',
    `volume_gallons` DECIMAL(18,2) COMMENT 'The volume gallons value recorded for each overflow event in the compliance domain.',
    `volume_ml` DECIMAL(18,2) COMMENT 'The volume ml value recorded for each overflow event in the compliance domain.',
    `volume_recovered_gallons` DECIMAL(18,2) COMMENT 'The volume recovered gallons value recorded for each overflow event in the compliance domain.',
    `volume_to_waters_gallons` DECIMAL(18,2) COMMENT 'The volume to waters gallons value recorded for each overflow event in the compliance domain.',
    `water_quality_sample_collected` BOOLEAN COMMENT 'The water quality sample collected value recorded for each overflow event in the compliance domain.',
    `water_quality_samples_collected` BOOLEAN COMMENT 'The water quality samples collected value recorded for each overflow event in the compliance domain.',
    `weather_condition` STRING COMMENT 'The weather condition value recorded for each overflow event in the compliance domain.',
    `weather_conditions` STRING COMMENT 'weather conditions for overflow_event. Ref: EPA SDWA.',
    `weather_related` BOOLEAN COMMENT 'The weather related value recorded for each overflow event in the compliance domain.',
    CONSTRAINT pk_overflow_event PRIMARY KEY(`overflow_event_id`)
) COMMENT 'Record of Sanitary Sewer Overflow (SSO) and Combined Sewer Overflow (CSO) events that must be reported to regulatory agencies under NPDES and state requirements. Tracks the event type (SSO or CSO), location (manhole, lift station, outfall), start and end date/time, estimated overflow volume (gallons), receiving water body, cause (I&I, blockage, equipment failure, capacity), corrective actions taken, public notification issued, regulatory notification date and method, and post-event investigation findings.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` (
    `compliance_schedule_id` BIGINT COMMENT 'Unique identifier for the compliance schedule record. Primary key. Ref: EPA SDWA.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Compliance schedules (consent decree milestones, enforcement order deadlines) are directly tied to CIP project delivery dates. Regulatory agencies track project completion as compliance milestones. Es. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit associated with this compliance schedule, if the schedule is tied to a specific permit condition rather than an enforcement action. Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Reference to the enforcement action or consent order that established this compliance schedule. Ref: EPA SDWA.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Compliance schedules require multi-year budget commitments for milestone completion. Critical for long-term financial planning and tracking progress against consent decree or enforcement order require. Ref: EPA SDWA.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Compliance schedules are created to fulfill specific compliance obligations. The compliance_schedule table already links to regulatory_requirement (the general requirement) and enforcement_action (if. Ref: EPA SDWA.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Compliance schedules mandate specific asset upgrades/installations (e.g., consent order requiring new filtration by deadline). Links schedule milestones to capital projects and asset commissioning, tr. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Reference to the specific regulatory requirement or permit condition that is the subject of this compliance schedule. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance schedules require designated responsible party for milestone tracking and regulatory reporting. Links to employee for accountability, workload management, and contact information. Replaces. Ref: EPA SDWA.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_plan. Business justification: Compliance schedules (consent orders, administrative orders) often include sampling plan implementation as milestones. Direct link tracks schedule fulfillment and enables automated milestone completio. Ref: EPA SDWA.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to date in executing the compliance schedule, including all capital and operating expenditures. Ref: EPA SDWA.',
    `completion_date` DATE COMMENT 'Completion date. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance schedule record was first created in the system. Ref: EPA SDWA.',
    `document_url` STRING COMMENT 'URL or file path to the official compliance schedule document, consent order, or administrative order that formally establishes the schedule and its milestones. Ref: EPA SDWA.',
    `due_date` DATE COMMENT 'Due date. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date on which the compliance schedule becomes effective and the utility is obligated to begin executing the scheduled milestones. Ref: EPA SDWA.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to complete all milestones and achieve full compliance under this schedule, including capital expenditures (CAPEX) and operating expenditures (OPEX). Ref: EPA SDWA.',
    `extension_approval_date` DATE COMMENT 'Date on which the regulatory authority formally approved the extension request. Ref: EPA SDWA.',
    `extension_approved_flag` BOOLEAN COMMENT 'Indicates whether the regulatory authority approved the requested extension to the compliance schedule. Ref: EPA SDWA.',
    `extension_justification` STRING COMMENT 'Detailed explanation or justification provided by the utility for requesting an extension to the compliance schedule, including any unforeseen circumstances, technical challenges, or resource constraints. Ref: EPA SDWA.',
    `extension_request_date` DATE COMMENT 'Date on which the utility submitted a formal request to extend the compliance schedule deadlines. Ref: EPA SDWA.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicates whether the utility has requested an extension to the compliance schedule deadlines. Ref: EPA SDWA.',
    `final_compliance_deadline` DATE COMMENT 'The ultimate deadline by which the utility must achieve full compliance with the regulatory requirement or permit condition. This is the final milestone in the schedule. Ref: EPA SDWA.',
    `funding_source` STRING COMMENT 'Source of funding for the compliance schedule activities (e.g., rate revenue, bond proceeds, state revolving fund loan, grant, Capital Improvement Program (CIP) budget). Ref: EPA SDWA.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory agency or authority that issued or approved the compliance schedule (e.g., EPA Region, State Primacy Agency, local environmental department). Ref: EPA SDWA.',
    `jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction of the regulatory authority overseeing this compliance schedule (e.g., state, county, EPA region). Ref: EPA SDWA.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this compliance schedule record. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance schedule record was last modified or updated. Ref: EPA SDWA.',
    `last_status_update_date` DATE COMMENT 'Date of the most recent status update or progress report submitted to the regulatory authority regarding the compliance schedule. Ref: EPA SDWA.',
    `milestone_count` STRING COMMENT 'Total number of milestones defined within this compliance schedule. Milestones are typically tracked in a separate related table. Ref: EPA SDWA.',
    `milestone_description` STRING COMMENT 'Milestone. Ref: EPA SDWA.',
    `milestones_completed_count` STRING COMMENT 'Number of milestones that have been completed as of the current date. Used to track progress toward full compliance. Ref: EPA SDWA.',
    `milestones_overdue_count` STRING COMMENT 'Number of milestones that are past their due date and have not been completed. Indicates potential non-compliance with the schedule. Ref: EPA SDWA.',
    `next_status_update_due_date` DATE COMMENT 'Date by which the next status update or progress report is due to be submitted to the regulatory authority. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the compliance schedule, including any special conditions, challenges, or coordination requirements. Ref: EPA SDWA.',
    `on_schedule_flag` BOOLEAN COMMENT 'Indicates whether the compliance schedule is currently on track to meet all milestone deadlines and the final compliance deadline. False if any milestones are overdue or at risk. Ref: EPA SDWA.',
    `original_final_deadline` DATE COMMENT 'The original final compliance deadline as initially agreed upon, preserved for audit and tracking purposes even if the schedule is later extended. Ref: EPA SDWA.',
    `overall_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the compliance schedule that has been completed, calculated as (milestones_completed_count / milestone_count) * 100. Provides a high-level progress indicator. Ref: EPA SDWA.',
    `public_notification_date` DATE COMMENT 'Date on which the utility provided public notification regarding the compliance schedule, if required. Ref: EPA SDWA.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the utility is required to provide public notification regarding the compliance schedule, such as inclusion in the Consumer Confidence Report (CCR) or public notices. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `regulatory_correspondence_count` STRING COMMENT 'Number of formal correspondence items (letters, emails, reports) exchanged between the utility and the regulatory authority regarding this compliance schedule. Ref: EPA SDWA.',
    `responsible_department` STRING COMMENT 'Name of the internal department or business unit responsible for executing the compliance schedule and ensuring all milestones are met (e.g., Operations and Maintenance (O&M), Engineering, Environmental Compliance). Ref: EPA SDWA.',
    `schedule_description` STRING COMMENT 'Detailed description of the compliance schedule, including the nature of the non-compliance, the corrective actions required, and the overall scope of work to achieve compliance. Ref: EPA SDWA.',
    `schedule_name` STRING COMMENT 'Descriptive name or title of the compliance schedule, summarizing the primary compliance objective or requirement being addressed. Ref: EPA SDWA.',
    `schedule_number` STRING COMMENT 'Business identifier or reference number for the compliance schedule, often assigned by the regulatory agency or utility for tracking purposes. Ref: EPA SDWA.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the compliance schedule. Indicates whether the schedule is in draft, actively being executed, completed, extended, terminated, or suspended. [ENUM-REF-CANDIDATE: draft|active|in_progress|completed|extended|terminated|suspended — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `schedule_type` STRING COMMENT 'Classification of the compliance schedule based on its legal or regulatory origin (e.g., consent order, administrative order, permit condition, settlement agreement, voluntary schedule). Ref: EPA SDWA.. Valid values are `consent_order|administrative_order|permit_condition|settlement_agreement|voluntary|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this compliance schedule record. Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_schedule PRIMARY KEY(`compliance_schedule_id`)
) COMMENT 'Formal compliance schedule agreed upon between the utility and a regulatory agency, typically as part of an enforcement action or consent order, establishing milestone dates for achieving compliance with a regulatory requirement or permit condition. Tracks the schedule name, associated enforcement action or permit, regulatory agency, milestone descriptions and due dates, milestone completion status, extension requests, and final compliance deadline. Provides the structured roadmap for returning to compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` (
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency record. Primary key. Ref: EPA SDWA.',
    `parent_regulatory_agency_id` BIGINT COMMENT 'Self-referencing FK on regulatory_agency (parent_regulatory_agency_id). Ref: EPA SDWA.',
    `parent_regulatory_agency_id_legacy` BIGINT COMMENT 'Reference to the parent or umbrella agency if this agency is a regional office, division, or sub-agency (e.g., EPA Region 5 parent is EPA). Null if this is a top-level agency. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each regulatory agency relationship requires designated utility liaison for communication continuity, relationship management, and coordination of submissions and inspections. Links to employee for wo',
    `regulatory_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this regulatory agency record. Ref: EPA SDWA.',
    `additional_programs_administered` STRING COMMENT 'Comma-separated list of additional regulatory programs or statutes administered by this agency that apply to the utility (e.g., IUP, FOG, SSO, LCRR).',
    `address_line1` STRING COMMENT 'Primary street address line for the regulatory agency headquarters or regional office. Ref: EPA SDWA.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building information. Ref: EPA SDWA.',
    `address_line_1` STRING COMMENT 'First line of the agencys physical mailing address (street number and name). Ref: EPA SDWA.',
    `address_line_2` STRING COMMENT 'Second line of the agencys physical mailing address (suite, floor, building, etc.). Nullable. Ref: EPA SDWA.',
    `agency_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the regulatory agency within the utilitys systems (e.g., EPA_R5, STATE_DNR, PUC_WI). Ref: EPA SDWA.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `agency_level` STRING COMMENT 'The agency level value recorded for each regulatory agency in the compliance domain.',
    `agency_main_email` STRING COMMENT 'General inquiry or main email address for the regulatory agency. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_main_phone` STRING COMMENT 'Main switchboard or general inquiry phone number for the regulatory agency. Ref: EPA SDWA.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `agency_name` STRING COMMENT 'Full legal name of the regulatory agency or governing body (e.g., U.S. Environmental Protection Agency Region 5, Wisconsin Department of Natural Resources). Ref: EPA SDWA.',
    `agency_short_name` STRING COMMENT 'Abbreviated or commonly used name for the agency (e.g., EPA Region 5, WI DNR, OSHA).',
    `agency_status` STRING COMMENT 'Current operational status of the regulatory agency (active, inactive, merged, dissolved). Ref: EPA SDWA.. Valid values are `active|inactive|merged|dissolved`',
    `agency_type` STRING COMMENT 'Classification of the regulatory agency by its primary regulatory focus (environmental, health, safety, rate regulatory, labor, quality standards, other). [ENUM-REF-CANDIDATE: environmental|health|safety|rate_regulatory|labor|quality_standards|other — 7 candidates stripped; promote to reference product]. Ref: EPA SDWA.',
    `agency_website_url` STRING COMMENT 'Official website URL for the regulatory agency. Ref: EPA SDWA.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `business_hours` STRING COMMENT 'Standard business hours of operation for the regulatory agency office (e.g., Monday-Friday 8:00 AM - 5:00 PM PST). Ref: EPA SDWA.',
    `city` STRING COMMENT 'City name for the agencys physical mailing address. Ref: EPA SDWA.',
    `country` STRING COMMENT 'The country component of the address for each regulatory agency record.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the agencys physical mailing address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was first created in the system. Ref: EPA SDWA.',
    `directive_transposition_status` STRING COMMENT 'For EU member state agencies, status of EU directive transposition into national law (transposed, pending, partial). Relevant for DWD 2020/2184 and WFD 2000/60/EC implementation tracking. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility became effective. Ref: EPA SDWA.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency contact phone number for reporting spills, violations, or urgent compliance matters. Ref: EPA SDWA.',
    `enforcement_authority_level` STRING COMMENT 'Level of enforcement authority this agency holds over the utility (primary, delegated, advisory, none). Primary indicates direct enforcement power; delegated indicates authority granted by a higher-level agency; advisory indicates no direct enforcement.. Valid values are `primary|delegated|advisory|none`',
    `eu_agency_flag` BOOLEAN COMMENT 'Whether agency operates under EU framework. Ref: EPA SDWA.',
    `eu_agency_type` STRING COMMENT 'For EU/EEA agencies: SUPRANATIONAL (European Commission, ECHA), NATIONAL_COMPETENT_AUTHORITY (ANSES, DWI, UBA), or REGIONAL. Ref: EPA SDWA.',
    `eu_directive_reference` STRING COMMENT 'EU directive reference (Drinking Water Directive 2020/2184, WFD 2000/60/EC, UWWTD 91/271/EEC, REACH PFAS restriction). Ref: EPA SDWA.',
    `eu_member_state_code` STRING COMMENT 'ISO 3166-1 alpha-2 code for EU/EEA member state where agency operates (e.g. FR for ANSES, DE for UBA, GB for DWI pre-Brexit). NULL for non-EU agencies.',
    `eu_member_state_flag` BOOLEAN COMMENT 'Indicates whether this agency operates within an EU member state, relevant for DWD 2020/2184 national transposition requirements. Ref: EPA SDWA.',
    `fax_number` STRING COMMENT 'Fax number for document submission to the regulatory agency, if applicable. Ref: EPA SDWA.',
    `governing_framework_reference` STRING COMMENT 'Framework the agency administers: US SDWA/NPDWR/LCRR (EPA); EU Drinking Water Directive 2020/2184; REACH PFAS restriction (ECHA); Water Framework Directive 2000/60/EC; Urban Wastewater Treatment Directive 91/271/EEC; FR ANSES national implementation; UK DWI national implementation; DE UBA national implementation',
    `inspection_frequency_months` STRING COMMENT 'Typical frequency in months at which this regulatory agency conducts inspections of utility facilities under its jurisdiction. Ref: EPA SDWA.',
    `inspection_frequency_typical` STRING COMMENT 'Typical frequency at which this agency conducts inspections or audits of utility facilities (annual, biennial, triennial, as-needed, risk-based). Ref: EPA SDWA.. Valid values are `annual|biennial|triennial|as_needed|risk_based`',
    `international_agency_role` STRING COMMENT 'Role of agency: EPA (US), EU Commission, ECHA, ANSES (FR), DWI (UK), UBA (DE). Ref: EPA SDWA.',
    `international_body_name` STRING COMMENT 'Named international/EU regulatory body, e.g. French ANSES; UK DWI; German UBA. Ref: EPA SDWA.',
    `international_body_type` STRING COMMENT 'Body type by region: US EPA / EU European Commission / EU ECHA / FR ANSES / UK DWI / DE UBA. Ref: EPA SDWA.',
    `international_cooperation_body` STRING COMMENT 'International body this agency cooperates with (e.g. WHO, OECD, ECHA) for cross-border regulatory alignment. Ref: EPA SDWA.',
    `international_framework` STRING COMMENT 'Primary international regulatory framework administered: SDWA/NPDWR (US), DWD 2020/2184 (EU), WFD 2000/60/EC (EU), UWWTD 91/271/EEC (EU), REACH (EU), or national equivalent',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the is active condition applies to the regulatory agency record.',
    `iso_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code for the agency jurisdiction (US, FR, GB, DE, etc.). Enables international regulatory body identification for ANSES (FR), DWI (GB), UBA (DE).',
    `jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction of the regulatory agency (e.g., United States, California, Los Angeles County). Ref: EPA SDWA.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code or regional code (e.g. US, EU, GB, DE, FR) identifying the regulatory jurisdiction. Supports multi-national regulatory frameworks including US EPA SDWA, EU Drinking Water Directive 2020/2184, and Water Framework Directive 2000/60/EC.',
    `jurisdiction_geographic_area` STRING COMMENT 'Geographic area or service territory over which the agency has regulatory authority (e.g., EPA Region 5 covers IL, IN, MI, MN, OH, WI; or specific county/municipality names). Ref: EPA SDWA.',
    `jurisdiction_level` STRING COMMENT 'The governmental level at which the agency operates (federal, state, regional, local, international). Ref: EPA SDWA.. Valid values are `federal|state|regional|local|international`',
    `jurisdiction_region_code` STRING COMMENT 'ISO-style region/country code for parallel US/EU/other reference paths.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection conducted by this regulatory agency at any utility facility. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was last updated or modified. Ref: EPA SDWA.',
    `main_email` STRING COMMENT 'The main email value recorded for each regulatory agency in the compliance domain.',
    `main_phone` STRING COMMENT 'The main phone value recorded for each regulatory agency in the compliance domain.',
    `mutual_recognition_agreements` STRING COMMENT 'Comma-separated list of mutual recognition or equivalence agreements with other jurisdictions for lab accreditation, monitoring data, or compliance determinations. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the regulatory agency relationship. Ref: EPA SDWA.',
    `notification_deadline_hours` STRING COMMENT 'Standard number of hours within which the utility must notify this agency of reportable incidents or violations (e.g., 24 hours for SSO events). Ref: EPA SDWA.',
    `npdes_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to issue and enforce NPDES permits under the Clean Water Act. True if authorized, False otherwise. Ref: EPA SDWA.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agencys physical mailing address. Ref: EPA SDWA.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pretreatment_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to oversee industrial pretreatment programs. True if authorized, False otherwise. Ref: EPA SDWA.',
    `primacy_agency_flag` BOOLEAN COMMENT 'Indicates whether this agency has primacy authority for Safe Drinking Water Act (SDWA) enforcement in its jurisdiction. True if primacy agency, False otherwise. Ref: EPA SDWA.',
    `primacy_status` STRING COMMENT 'Indicates whether this agency is a primacy agency under the Safe Drinking Water Act (SDWA) or Clean Water Act (CWA), meaning it has been delegated primary enforcement authority by EPA (primacy_agency, non_primacy, not_applicable). Ref: EPA SDWA.. Valid values are `primacy_agency|non_primacy|not_applicable`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the agency contact. Ref: EPA SDWA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the agency for utility compliance matters. Ref: EPA SDWA.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact. Ref: EPA SDWA.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the agency. Ref: EPA SDWA.',
    `primary_program` STRING COMMENT 'The primary program value recorded for each regulatory agency in the compliance domain.',
    `primary_regulatory_program` STRING COMMENT 'The main regulatory program or statute administered by this agency relevant to water utilities (e.g., SDWA, CWA, NPDES, OSHA, Rate Regulation).',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `region_code` STRING COMMENT 'Regional designation or code if the agency operates within a specific region (e.g., EPA Region 9, Water Board Region 4). Ref: EPA SDWA.',
    `regulatory_body_name` STRING COMMENT 'Name of regulatory body (EPA for US, European Commission, ECHA, ANSES for FR, DWI for UK, UBA for DE). Ref: EPA SDWA.',
    `regulatory_framework` STRING COMMENT 'Name of the governing regulatory framework (e.g. US_SDWA, EU_DWD_2020_2184, EU_WFD_2000_60_EC, EU_UWWTD_91_271_EEC, REACH_PFAS_RESTRICTION). Enables multi-jurisdictional compliance tracking where EU Water Framework Directive defines surface-water ecological/chemical status differently from US CWA frameworks. Ref: EPA SDWA.',
    `regulatory_framework_administered` STRING COMMENT 'Framework administered by this agency across US/EU jurisdictions. Ref: EPA SDWA.',
    `regulatory_framework_reference` STRING COMMENT 'Citation of the governing regulatory framework or directive. Ref: EPA SDWA.',
    `regulatory_program` STRING COMMENT 'Primary regulatory program or framework administered by the agency (e.g., NPDES, SDWA Primacy, Pretreatment, Lead and Copper Rule). Ref: EPA SDWA.',
    `regulatory_region` STRING COMMENT 'Sub-national or supra-national regulatory region (e.g. EU Member State, US State, River Basin District under WFD). Recognizes that EU WFD Article 4 environmental objectives and surface-water status classification (high/good/moderate/poor/bad) differ fundamentally from US designated-use/impairment approach. Ref: EPA SDWA.',
    `regulatory_region_code` STRING COMMENT 'ISO region code for regulatory jurisdiction (US, EU, FR, UK, DE, etc.)',
    `reporting_frequency_default` STRING COMMENT 'Default or most common reporting frequency required by this agency for compliance reports (monthly, quarterly, semi-annual, annual, event-driven, as-required). Ref: EPA SDWA.. Valid values are `monthly|quarterly|semi_annual|annual|event_driven|as_required`',
    `reporting_system_name` STRING COMMENT 'Name of the electronic reporting system used by the agency (e.g., NetDMR, SDWIS, state-specific portal). Ref: EPA SDWA.',
    `secondary_contact_phone` STRING COMMENT 'Secondary or alternate telephone number for the regulatory agency. Ref: EPA SDWA.',
    `state` STRING COMMENT 'Two-letter state or province code where the regulatory agency office is located. Ref: EPA SDWA.. Valid values are `^[A-Z]{2}$`',
    `state_province` STRING COMMENT 'Two-letter state or province code for the agencys physical mailing address (e.g., WI, IL, CA). Ref: EPA SDWA.. Valid values are `^[A-Z]{2}$`',
    `submission_credentials_reference` STRING COMMENT 'Reference identifier or location for stored login credentials or API keys used to access the agencys submission portal. Should reference a secure credential vault, not store actual credentials. Ref: EPA SDWA.',
    `submission_portal_name` STRING COMMENT 'Name of the online submission portal or system (e.g., NetDMR, State Environmental Portal, OSHA Injury Tracking Application).',
    `submission_portal_url` STRING COMMENT 'URL for the online portal or system used to submit compliance reports, permits, or other regulatory documents to this agency (e.g., NetDMR, state e-reporting system). Ref: EPA SDWA.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `supranational_body_flag` BOOLEAN COMMENT 'Indicates whether this agency is a supranational body (e.g. European Commission, ECHA) as opposed to a national or sub-national regulator. Ref: EPA SDWA.',
    `termination_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility ended or will end. Null if still active. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `website_url` STRING COMMENT 'Official website URL for the regulatory agency. Ref: EPA SDWA.',
    CONSTRAINT pk_regulatory_agency PRIMARY KEY(`regulatory_agency_id`)
) COMMENT 'Master reference table for regulatory_agency. Referenced by: compliance.regulatory_submission.regulatory_agency_id, treatment.mor_submission.regulatory_agency_id, treatment.treatment_permit.regulatory_agency_id, treatment.treatment_violation.regulatory_agency_id';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` (
    `permit_vendor_service_id` BIGINT COMMENT 'Unique identifier for the permit vendor service relationship record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to the compliance permit requiring vendor services. Ref: EPA SDWA.',
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract referenced by each permit vendor service record in the compliance domain.',
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order referenced by each permit vendor service record in the compliance domain.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services for the permit. Ref: EPA SDWA.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost value recorded for each permit vendor service in the compliance domain.',
    `contract_amount` DECIMAL(18,2) COMMENT 'Total contracted dollar amount for vendor services specific to this permit engagement. Ref: EPA SDWA.',
    `contract_amount_usd` DECIMAL(18,2) COMMENT 'Contract amount. Ref: EPA SDWA.',
    `contract_end_date` DATE COMMENT 'Date when the vendor service agreement for this permit expires or was terminated. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `contract_start_date` DATE COMMENT 'Date when the vendor service agreement for this permit became effective. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this permit vendor service record was created in the system. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each permit vendor service record in the compliance domain.',
    `deliverable_status` STRING COMMENT 'Current status of the vendor deliverables for this permit service engagement. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each permit vendor service record in the compliance domain.',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this permit vendor service record was last modified. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'The notes value recorded for each permit vendor service in the compliance domain.',
    `performance_rating` STRING COMMENT 'Evaluation of the vendor performance specific to this permit service engagement. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `service_description` STRING COMMENT 'The service description value recorded for each permit vendor service in the compliance domain.',
    `service_end_date` TIMESTAMP COMMENT 'The service end date associated with each permit vendor service record in the compliance domain.',
    `service_scope` STRING COMMENT 'Detailed description of the scope of work and deliverables the vendor is contracted to provide for this specific permit. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `service_start_date` TIMESTAMP COMMENT 'The service start date associated with each permit vendor service record in the compliance domain.',
    `service_status` STRING COMMENT 'Current lifecycle status of the vendor service relationship for this permit. Ref: EPA SDWA.',
    `service_type` STRING COMMENT 'Classification of the service provided by the vendor in support of the permit. Identified in detection phase as relationship-specific data. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_permit_vendor_service PRIMARY KEY(`permit_vendor_service_id`)
) COMMENT 'This association product represents the service contract between compliance_permit and vendor. It captures the specific services provided by vendors in support of regulatory permit compliance, including engineering consulting, legal counsel, laboratory testing, environmental monitoring, and permit application preparation. Each record links one compliance_permit to one vendor with attributes that describe the service relationship, contract terms, deliverables, and performance metrics specific to that permit-vendor engagement.. Existence Justification: In water utility operations, regulatory permits require multiple specialized vendors providing distinct services: engineering consultants for permit applications, legal counsel for regulatory compliance, laboratories for water quality testing, and environmental monitoring firms for ongoing compliance reporting. Each permit-vendor relationship represents a specific service engagement with its own contract terms, deliverables, scope, and performance metrics. Conversely, vendors (especially specialized consulting firms and testing laboratories) serve multiple permits across different facilities and regulatory programs (NPDES, SDWA, air quality). The utility actively manages these service relationships, tracking contract dates, deliverable status, and vendor performance for each permit-vendor engagement.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` (
    `material_compliance_certification_id` BIGINT COMMENT 'Unique identifier for this material-requirement compliance certification record. Primary key. Ref: EPA SDWA.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the certifying employee referenced by each material compliance certification record in the compliance domain.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material or chemical subject to this regulatory requirement. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the regulatory requirement that applies to this material. Ref: EPA SDWA.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor referenced by each material compliance certification record in the compliance domain.',
    `approval_status` STRING COMMENT 'Current regulatory approval status for this material under this specific requirement. CERTIFIED = material meets requirement and is approved for use; PENDING = certification in progress; EXPIRED = certification lapsed; REVOKED = approval withdrawn; NOT_REQUIRED = requirement does not mandate certification for this material type. Ref: EPA SDWA.',
    `certification_date` DATE COMMENT 'Cert date. Ref: EPA SDWA.',
    `certification_document_url` STRING COMMENT 'URL or file path to the official certification document, approval letter, or compliance attestation for this material-requirement pair. Ref: EPA SDWA.',
    `certification_number` STRING COMMENT 'Unique certification or approval number issued by the certifying body (NSF, state primacy agency, EPA) for this material-requirement combination. Ref: EPA SDWA.',
    `certification_standard` STRING COMMENT 'e.g. NSF/ANSI 61. Ref: EPA SDWA.',
    `certification_status` STRING COMMENT 'The certification status value recorded for each material compliance certification in the compliance domain.',
    `certification_type` STRING COMMENT 'Type of regulatory certification or approval obtained for this material-requirement combination (e.g., NSF/ANSI 60 for treatment chemicals, NSF/ANSI 61 for materials in contact with drinking water, state-specific approvals). Ref: EPA SDWA.',
    `certifying_body` STRING COMMENT 'Name of the organization or regulatory agency that issued the certification or approval (e.g., NSF International, state Department of Health, EPA). Ref: EPA SDWA.',
    `compliance_certification_date` DATE COMMENT 'Date on which the material received regulatory certification or approval for compliance with this specific requirement. Ref: EPA SDWA.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting special conditions, restrictions, or operational considerations for using this material in compliance with this regulatory requirement. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each material compliance certification record in the compliance domain.',
    `document_reference` STRING COMMENT 'The document reference value recorded for each material compliance certification in the compliance domain.',
    `dosage_unit` STRING COMMENT 'Unit of measure for the maximum dosage rate (e.g., mg/L, ppm, lbs/day). Null if maximum_dosage_rate is not applicable. Ref: EPA SDWA.',
    `effective_date` DATE COMMENT 'Date from which the certification or approval becomes valid and the material may be used in compliance with this regulatory requirement. Ref: EPA SDWA.',
    `expiration_date` DATE COMMENT 'Date on which the certification or approval expires and must be renewed. Null if certification does not expire or is perpetual pending regulatory changes. Ref: EPA SDWA.',
    `is_valid` BOOLEAN COMMENT 'Valid flag. Ref: EPA SDWA.',
    `issue_date` TIMESTAMP COMMENT 'The issue date associated with each material compliance certification record in the compliance domain.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit verifying that this material remains in compliance with this regulatory requirement. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each material compliance certification record in the compliance domain.',
    `lead_free_compliant_flag` BOOLEAN COMMENT 'The lead free compliant flag value recorded for each material compliance certification in the compliance domain.',
    `maximum_dosage_rate` DECIMAL(18,2) COMMENT 'Maximum allowable dosage or application rate for this material as specified by the regulatory requirement certification. Applicable primarily to treatment chemicals. Null if not applicable. Ref: EPA SDWA.',
    `next_renewal_date` DATE COMMENT 'Scheduled date for renewal or recertification of this material under this regulatory requirement. Used for compliance calendar and proactive renewal management. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'The notes value recorded for each material compliance certification in the compliance domain.',
    `nsf_ansi_standard` STRING COMMENT 'Specific NSF/ANSI standard number and version under which this material is certified for use in drinking water systems (e.g., NSF/ANSI 60-2021, NSF/ANSI 61-2020). Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `responsible_compliance_officer` STRING COMMENT 'Name or employee ID of the compliance officer responsible for maintaining and monitoring this material-requirement certification. Ref: EPA SDWA.',
    `standard_reference` STRING COMMENT 'The standard reference value recorded for each material compliance certification in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_material_compliance_certification PRIMARY KEY(`material_compliance_certification_id`)
) COMMENT 'This association product represents the regulatory compliance certification relationship between regulatory requirements and materials/chemicals used in water treatment. It captures the NSF/ANSI 60/61 certification status, state approvals, and regulatory compliance documentation for each material-requirement pair. Each record links one regulatory requirement to one material with certification dates, approval status, and applicable standards that exist only in the context of this compliance relationship.. Existence Justification: In water utility operations, regulatory requirements (such as Lead and Copper Rule, DBP rules, SDWA MCLs, PFAS standards) apply to multiple treatment chemicals and materials, and each chemical/material must comply with multiple regulatory requirements. Utilities actively manage NSF/ANSI 60/61 certifications, state approvals, and regulatory compliance status for each material-requirement pair as a distinct operational record with certification dates, approval status, expiration tracking, and dosage limits. This is a genuine operational M:N relationship where compliance officers create, monitor, and renew certifications as part of regulatory compliance workflows.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` (
    `permit_grant_allocation_id` BIGINT COMMENT 'Unique identifier for this permit-grant allocation record. Primary key. Ref: EPA SDWA.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center referenced by each permit grant allocation record in the compliance domain.',
    `fund_id` BIGINT COMMENT 'Unique identifier for the fund referenced by each permit grant allocation record in the compliance domain.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to the grant providing funding for permit compliance activities. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key to compliance.compliance_permit identifying the permit receiving grant funding. Ref: EPA SDWA.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount value recorded for each permit grant allocation in the compliance domain.',
    `allocated_amount_usd` DECIMAL(18,2) COMMENT 'Allocated amount. Ref: EPA SDWA.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Dollar amount of grant funds allocated to this specific permit for compliance activities and capital improvements. Subset of the total grant award amount. Ref: EPA SDWA.',
    `allocation_date` DATE COMMENT 'Allocation date. Ref: EPA SDWA.',
    `allocation_end_date` DATE COMMENT 'Date when this permit-grant allocation ends, after which no additional costs may be charged to this allocation. May differ from the overall grant period of performance. Ref: EPA SDWA.',
    `allocation_notes` STRING COMMENT 'Free-text notes documenting special conditions, restrictions, or coordination requirements for this permit-grant allocation (e.g., matching fund requirements, specific grantor approval needed for certain activities). Ref: EPA SDWA.',
    `allocation_number` STRING COMMENT 'The allocation number value recorded for each permit grant allocation in the compliance domain.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage value recorded for each permit grant allocation in the compliance domain.',
    `allocation_start_date` DATE COMMENT 'Date when this permit-grant allocation became active and eligible costs could begin to be charged against the allocated funds. Ref: EPA SDWA.',
    `allocation_status` STRING COMMENT 'Current status of this permit-grant allocation: planned (allocation approved but not yet active), active (funds being drawn), completed (all funds expended and milestones met), suspended (temporarily on hold), closed (allocation formally closed out). Ref: EPA SDWA.',
    `amount_expended_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount of the allocation that has been expended on permit compliance activities as of the current date. Used to track spending against the allocation_amount. Ref: EPA SDWA.',
    `compliance_milestone` STRING COMMENT 'Key compliance milestones tied to this grant allocation, such as permit renewal dates, discharge limit achievement targets, or infrastructure completion deadlines required by the grant agreement. Ref: EPA SDWA.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this permit-grant allocation record was created in the system. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp associated with each permit grant allocation record in the compliance domain.',
    `drawdown_schedule` STRING COMMENT 'Schedule or milestones for drawing down allocated grant funds for this permit, including quarterly targets, project phase gates, or compliance milestone triggers. Ref: EPA SDWA.',
    `eligible_activities` STRING COMMENT 'Description of the specific compliance activities and capital projects eligible for funding under this permit-grant allocation (e.g., NPDES discharge monitoring equipment, drinking water treatment upgrades, stormwater infrastructure). Ref: EPA SDWA.',
    `expended_amount` DECIMAL(18,2) COMMENT 'The expended amount value recorded for each permit grant allocation in the compliance domain.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this permit-grant allocation record was last updated. Ref: EPA SDWA.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each permit grant allocation record in the compliance domain.',
    `notes` STRING COMMENT 'The notes value recorded for each permit grant allocation in the compliance domain.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `remaining_allocation_balance` DECIMAL(18,2) COMMENT 'Dollar amount of the allocation still available for permit compliance expenditures. Calculated as allocation_amount minus amount_expended_to_date. Ref: EPA SDWA.',
    `reporting_period` STRING COMMENT 'Reporting period or frequency for this permit-grant allocation (e.g., quarterly, semi-annual), specifying when the utility must report permit compliance progress and grant expenditures to the grantor agency. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    CONSTRAINT pk_permit_grant_allocation PRIMARY KEY(`permit_grant_allocation_id`)
) COMMENT 'This association product represents the funding allocation between compliance permits and grants in water utilities. It captures the financial relationship where grants fund permit-related compliance activities and capital improvements. Each record links one compliance permit to one grant with allocation amounts, eligible activities, drawdown schedules, compliance milestones, and reporting periods that exist only in the context of this funding relationship.. Existence Justification: In water utility operations, compliance permits frequently require capital improvements and ongoing compliance activities funded by multiple grants (e.g., a NPDES discharge permit may receive funding from both CWSRF for treatment upgrades and EPA grants for monitoring equipment). Conversely, single grants commonly fund compliance activities across multiple permits (e.g., a DWSRF loan funds upgrades for both drinking water permits and NPDES permits at the same facility). Utilities actively manage these allocations, tracking specific dollar amounts, eligible activities, drawdown schedules, compliance milestones, and reporting periods for each permit-grant pairing to ensure grant compliance and audit readiness.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique identifier for this compliance crew assignment record. Primary key. Ref: EPA SDWA.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Unique identifier for the compliance corrective action referenced by each crew assignment record in the compliance domain.',
    `compliance_schedule_id` BIGINT COMMENT 'Unique identifier for the compliance schedule referenced by each crew assignment record in the compliance domain.',
    `employee_id` BIGINT COMMENT 'Employee. Ref: EPA SDWA.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the field service crew assigned to this compliance obligation. Ref: EPA SDWA.',
    `crew_supervisor_employee_id` BIGINT COMMENT 'Unique identifier for the crew supervisor employee referenced by each crew assignment record in the compliance domain.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to the compliance obligation being fulfilled by this crew assignment. Ref: EPA SDWA.',
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection referenced by each crew assignment record in the compliance domain.',
    `actual_end_date` TIMESTAMP COMMENT 'The actual end date associated with each crew assignment record in the compliance domain.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours expended by this crew on this compliance obligation, captured from work order time tracking and used for compliance cost allocation and crew productivity analysis. Ref: EPA SDWA.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'The actual labor hours value recorded for each crew assignment in the compliance domain.',
    `actual_start_date` TIMESTAMP COMMENT 'The actual start date associated with each crew assignment record in the compliance domain.',
    `assignment_date` DATE COMMENT 'Date when this crew was assigned to work on this compliance obligation. Explicitly identified in detection phase relationship data. Ref: EPA SDWA.',
    `assignment_description` STRING COMMENT 'The assignment description value recorded for each crew assignment in the compliance domain.',
    `assignment_end_date` DATE COMMENT 'End date. Ref: EPA SDWA.',
    `assignment_number` STRING COMMENT 'The assignment number value recorded for each crew assignment in the compliance domain.',
    `assignment_role` STRING COMMENT 'Role. Ref: EPA SDWA.',
    `assignment_start_date` DATE COMMENT 'Start date. Ref: EPA SDWA.',
    `assignment_status` STRING COMMENT 'Current status of this crew assignment: assigned (crew assigned but work not started), in_progress (crew actively working), completed (crew finished their portion), cancelled (assignment cancelled), on_hold (work paused pending external factors). Ref: EPA SDWA.',
    `assignment_type` STRING COMMENT 'The assignment type value recorded for each crew assignment in the compliance domain.',
    `completion_date` DATE COMMENT 'Date when this crew completed their portion of the compliance obligation. Used to track crew-level completion even when overall obligation requires multiple crews. Ref: EPA SDWA.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of this compliance obligation completed by this specific crew, ranging from 0.00 to 100.00. Explicitly identified in detection phase relationship data. Used for tracking progress when multiple crews contribute to a single obligation. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew assignment record was created in the system. Ref: EPA SDWA.',
    `crew_role` STRING COMMENT 'Role of this crew in fulfilling the compliance obligation: primary (main crew responsible), support (assisting crew), specialist (crew with specific certification required), backup (standby crew), emergency_response (crew responding to compliance-related emergency). Explicitly identified in detection phase relationship data. Ref: EPA SDWA.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours for this specific crew to complete their portion of the compliance obligation. Explicitly identified in detection phase relationship data. Differs from compliance_obligation.estimated_effort_hours which is total across all crews. Ref: EPA SDWA.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'The estimated labor hours value recorded for each crew assignment in the compliance domain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp associated with each crew assignment record in the compliance domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew assignment record was last modified, used for audit trail and synchronization with field service systems. Ref: EPA SDWA.',
    `notes` STRING COMMENT 'Free-text notes specific to this crew assignment, capturing crew-specific challenges, equipment used, site conditions, or coordination details relevant to this compliance obligation. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
    `scheduled_end_date` TIMESTAMP COMMENT 'The scheduled end date associated with each crew assignment record in the compliance domain.',
    `scheduled_start_date` TIMESTAMP COMMENT 'The scheduled start date associated with each crew assignment record in the compliance domain.',
    `start_date` DATE COMMENT 'Date when this crew began work on this compliance obligation. May differ from assignment_date if crew was assigned in advance. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp. Ref: EPA SDWA.',
    `work_order_reference` STRING COMMENT 'Reference to the work order number in Microsoft Dynamics 365 Field Service or IBM Maximo CMMS that tracks this crews work on this compliance obligation. Links compliance tracking to operational work management.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'This association product represents the Assignment between compliance_obligation and crew. It captures the operational assignment of field service crews to specific compliance obligations, tracking crew-specific progress, effort allocation, and role in fulfilling regulatory requirements. Each record links one compliance_obligation to one crew with attributes that exist only in the context of this assignment relationship.. Existence Justification: In water utility operations, complex compliance obligations (such as system-wide valve exercising programs, annual hydrant flushing campaigns, or multi-site NPDES monitoring) routinely require multiple specialized crews working concurrently or sequentially, each contributing specific expertise or covering different geographic areas. Simultaneously, field service crews are assigned to multiple compliance obligations throughout the year, balancing regulatory work with emergency response and routine maintenance. The business actively manages these assignments, tracking crew-specific progress, effort allocation, roles, and completion status for regulatory reporting and labor cost allocation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_compliance_regulatory_agency_id` FOREIGN KEY (`compliance_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_original_dmr_id` FOREIGN KEY (`original_dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_dmr_id` FOREIGN KEY (`dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_ccr_id` FOREIGN KEY (`ccr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`ccr`(`ccr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_previous_finding_inspection_finding_id` FOREIGN KEY (`previous_finding_inspection_finding_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_original_submission_regulatory_submission_id` FOREIGN KEY (`original_submission_regulatory_submission_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_overflow_compliance_permit_id` FOREIGN KEY (`overflow_compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_id` FOREIGN KEY (`parent_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_id_legacy` FOREIGN KEY (`parent_regulatory_agency_id_legacy`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ADD CONSTRAINT `fk_compliance_permit_vendor_service_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ADD CONSTRAINT `fk_compliance_material_compliance_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ADD CONSTRAINT `fk_compliance_permit_grant_allocation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_compliance_schedule_id` FOREIGN KEY (`compliance_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_schedule`(`compliance_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_duplicate_of' = 'project.project_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_pair' = 'treatment.treatment_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_ssot_master_for' = 'project.project_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_responsible_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operator Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_responsible_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_responsible_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_basis` SET TAGS ('dbx_business_glossary_term' = 'EU Directive Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Eu Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_ied_permit_number` SET TAGS ('dbx_business_glossary_term' = 'EU IED Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_permit_directive_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_uwwtd_agglomeration_size` SET TAGS ('dbx_business_glossary_term' = 'EU UWWTD Agglomeration Size');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `eu_wfd_water_body_status` SET TAGS ('dbx_business_glossary_term' = 'EU WFD Water Body Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_agency_region` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_agency_region` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_agency_region` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `issuing_member_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing Member State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_framework` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction region code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `national_competent_authority` SET TAGS ('dbx_business_glossary_term' = 'National Competent Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Npdes Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `permit_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `renewal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_facility_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_facility_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `uwwtd_compliance_route` SET TAGS ('dbx_business_glossary_term' = 'UWWTD Compliance Route');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evaluation Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_evaluation_method` SET TAGS ('dbx_value_regex' = 'single_value_comparison|rolling_average|statistical_analysis|narrative_assessment|best_professional_judgment');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_schedule_milestone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Milestone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|suspended|superseded|expired|under_appeal');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_text` SET TAGS ('dbx_business_glossary_term' = 'Condition Text');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'effluent_limit|monitoring_requirement|reporting_requirement|technology_based_standard|narrative_condition|best_management_practice');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `detection_limit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average|minimum');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `mixing_zone_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixing Zone Allowed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `mixing_zone_description` SET TAGS ('dbx_business_glossary_term' = 'Mixing Zone Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Modification Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `numeric_limit` SET TAGS ('dbx_business_glossary_term' = 'Numeric Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `quality_assurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `record_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period (Days)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|event_based|not_required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous|flow_weighted');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `technology_requirement` SET TAGS ('dbx_business_glossary_term' = 'Technology Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `violation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Violation Threshold');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `water_quality_standard_basis` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Standard Basis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `analyte_id` SET TAGS ('dbx_business_glossary_term' = 'Analyte Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Required Position Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_facility_type` SET TAGS ('dbx_value_regex' = 'WTP|WWTP|STP|distribution_system|collection_system|all_facilities');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_system_size` SET TAGS ('dbx_business_glossary_term' = 'Applicable System Size');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|not_applicable|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_article` SET TAGS ('dbx_business_glossary_term' = 'EU Directive article reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'EU Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_directive_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_parametric_value` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `eu_parametric_value_unit` SET TAGS ('dbx_business_glossary_term' = 'EU Parametric Value Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `international_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Standard');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `issuing_body_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_framework` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction region code (US, EU, FR, UK, DE, etc.)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `national_regulation_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `national_regulation_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `national_regulation_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `national_transposition_reference` SET TAGS ('dbx_business_glossary_term' = 'National Transposition Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parametric_value_eu` SET TAGS ('dbx_business_glossary_term' = 'EU parametric value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `parametric_value_eu_unit` SET TAGS ('dbx_business_glossary_term' = 'EU parametric value unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation URL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_category` SET TAGS ('dbx_business_glossary_term' = 'Requirement Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `superseded_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded Requirement Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'US CFR Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_regulation_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_regulation_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `us_regulation_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `wfd_environmental_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'WFD Environmental Quality Standard');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `wfd_quality_element_category` SET TAGS ('dbx_business_glossary_term' = 'WFD Quality Element Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `wfd_surface_water_status_class` SET TAGS ('dbx_business_glossary_term' = 'WFD Surface Water Status Class');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `actual_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Effort Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completed_by` SET TAGS ('dbx_business_glossary_term' = 'Completed By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_person` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `estimated_effort_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Effort Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_of_fulfillment` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Fulfillment');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|completed|overdue|waived|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'monitoring|reporting|operational|training|inspection|maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'public-health|environmental|financial|operational|reputational');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|in-person|not-applicable');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `original_dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Original Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'NetDMR Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `dmr_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_competent_authority_code` SET TAGS ('dbx_business_glossary_term' = 'EU Competent Authority Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_discharge_directive_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_reporting_directive` SET TAGS ('dbx_business_glossary_term' = 'EU reporting directive');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_uwwtd_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_uwwtd_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_uwwtd_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `eu_uwwtd_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'EU UWWTD Reporting Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `exceedance_count` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction region code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `late_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `monitoring_location_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `no_discharge_flag` SET TAGS ('dbx_business_glossary_term' = 'No Discharge Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `no_discharge_reason` SET TAGS ('dbx_business_glossary_term' = 'No Discharge Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `noncompliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Noncompliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Preparer Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'epa|state_primacy_agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semi-annual|weekly');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `resubmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_business_glossary_term' = 'State Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'netdmr|paper|email|state_portal|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|under_review|resubmitted');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `uwwtd_agglomeration_code` SET TAGS ('dbx_business_glossary_term' = 'UWWTD Agglomeration Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `uwwtd_treatment_level` SET TAGS ('dbx_business_glossary_term' = 'UWWTD Treatment Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `uwwtd_treatment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `uwwtd_treatment_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `wfd_water_body_code` SET TAGS ('dbx_business_glossary_term' = 'WFD Water Body ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `wfd_water_body_status_impact` SET TAGS ('dbx_business_glossary_term' = 'WFD Water Body Status Impact');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_result_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `enforcement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `monitoring_location_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `nodi_code` SET TAGS ('dbx_business_glossary_term' = 'No Data Indicator (NODI) Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `number_of_exceedances` SET TAGS ('dbx_business_glossary_term' = 'Number of Exceedances');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `number_of_samples` SET TAGS ('dbx_business_glossary_term' = 'Number of Samples');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_value_regex' = 'maximum|minimum|range|narrative');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `permit_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `qa_qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance / Quality Control (QA/QC) Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `qualifier_code` SET TAGS ('dbx_business_glossary_term' = 'Data Qualifier Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `quantification_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Quantification Limit (MQL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `statistical_base` SET TAGS ('dbx_business_glossary_term' = 'Statistical Base');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `submitted_to_regulator_flag` SET TAGS ('dbx_business_glossary_term' = 'Submitted to Regulator Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `violation_category` SET TAGS ('dbx_value_regex' = 'effluent_limit|monitoring_frequency|reporting|none');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `mor_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Operating Report (MOR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `mor_wtp_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `agency_response_received` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Received');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `alkalinity_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Alkalinity Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'draft|certified|submitted|accepted|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_license_number` SET TAGS ('dbx_business_glossary_term' = 'Certifier License Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_business_glossary_term' = 'Certifier Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `coagulant_dosage_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Coagulant Dosage Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_value_achieved` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Value Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_value_required` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Value Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_residual_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Residual Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_residual_min_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Residual Minimum Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_value_regex' = 'chlorine|chloramine|chlorine_dioxide|ozone|uv');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_competent_authority_code` SET TAGS ('dbx_business_glossary_term' = 'EU Competent Authority Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_dwd_operational_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Operational Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_dwd_parametric_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Parametric Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_dwd_reference` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_operating_directive_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_operational_monitoring_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Operational Monitoring Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_operational_monitoring_reference` SET TAGS ('dbx_business_glossary_term' = 'EU operational monitoring reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `eu_risk_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'EU Risk Assessment Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `finished_water_turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Turbidity Average Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `finished_water_turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Turbidity Maximum Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `fluoride_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Fluoride Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `international_framework_reference` SET TAGS ('dbx_business_glossary_term' = 'International Framework Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction region code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `jurisdictional_report_type` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `operational_events_count` SET TAGS ('dbx_business_glossary_term' = 'Operational Events Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `operational_events_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Events Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `peak_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ph_avg` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Average');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Preparer License Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `raw_water_turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Raw Water Turbidity Average Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `raw_water_turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Raw Water Turbidity Maximum Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_directive_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Directive Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `reporting_month` SET TAGS ('dbx_business_glossary_term' = 'Reporting Month');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `source_water_type` SET TAGS ('dbx_business_glossary_term' = 'Source Water Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `source_water_type` SET TAGS ('dbx_value_regex' = 'surface|groundwater|purchased|blended');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `total_water_produced_mgd` SET TAGS ('dbx_business_glossary_term' = 'Total Water Produced Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `turbidity_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `turbidity_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `violations_count` SET TAGS ('dbx_business_glossary_term' = 'Violations Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `violations_description` SET TAGS ('dbx_business_glossary_term' = 'Violations Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_duplicate_of' = 'treatment.treatment_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_status' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_pair' = 'treatment.treatment_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ssot_master_for' = 'treatment.treatment_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` SET TAGS ('dbx_ecm_depth_target' = '7');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_discovered_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Discovered By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_discovered_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_discovered_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_period_begin` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_business_glossary_term' = 'ECM/MVM Depth Reconciliation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_mvm_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `enforcement_action_initiated` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Initiated');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `enforcement_action_pending` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Pending');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Health-Based Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_business_glossary_term' = 'Health-Based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `is_repeat_violation` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `is_significant_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Is Significant Noncompliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `mcl_limit` SET TAGS ('dbx_business_glossary_term' = 'MCL Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `population_served_affected` SET TAGS ('dbx_business_glossary_term' = 'Population Served Affected');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `primacy_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `public_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `public_notification_issued` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Issued');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `public_notification_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Issued Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PN Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Pwsid');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `reported_to_agency_date` SET TAGS ('dbx_business_glossary_term' = 'Reported To Agency Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `reporting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `rtc_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Compliance Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `rule_citation` SET TAGS ('dbx_business_glossary_term' = 'Rule Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `sdwis_violation_code` SET TAGS ('dbx_business_glossary_term' = 'SDWIS Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Violation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'issued|under_review|response_submitted|in_negotiation|resolved|closed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_summary` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'notice_of_violation|administrative_order|consent_order|compliance_schedule|civil_penalty|criminal_referral');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `appeal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `board_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Board Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `civil_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Civil Penalty Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `civil_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_schedule_final_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Final Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_schedule_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `issuing_agency_region` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Region or District');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Legal Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `penalty_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `public_notice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'compliance_achieved|consent_order_executed|penalty_paid|dismissed|under_appeal');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_description` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `sep_estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `supplemental_environmental_project_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Environmental Project (SEP) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_pair' = 'quality.quality_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_duplicate_of' = 'quality.quality_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_ssot_master_for' = 'quality.quality_public_notification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `ccr_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `affected_service_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Area');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `certification_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `deadline_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Deadline Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `distribution_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `distribution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `distribution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `health_effects_language` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Contaminant Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `media_outlet_list` SET TAGS ('dbx_business_glossary_term' = 'Media Outlet List');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notification Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_content` SET TAGS ('dbx_business_glossary_term' = 'Notification Content');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_language` SET TAGS ('dbx_business_glossary_term' = 'Notification Language');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^PN-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Approval|Approved|Distributed|Certified|Closed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Tier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `notification_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primacy_agency_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Acknowledgment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primacy_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `primacy_agency_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `public_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Public Meeting Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `public_meeting_held_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Meeting Held Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `regulatory_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `repeat_notification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Repeat Notification Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `repeat_notification_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|Quarterly|As Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `repeat_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'mg/L|ug/L|pCi/L|NTU|MPN/100mL|CFU/100mL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'MCL|MCLG|Treatment Technique|Monitoring|Reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_public_notification` ALTER COLUMN `website_posting_url` SET TAGS ('dbx_business_glossary_term' = 'Website Posting Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `ccr_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `additional_languages` SET TAGS ('dbx_business_glossary_term' = 'Additional Languages');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `board_meeting_info` SET TAGS ('dbx_business_glossary_term' = 'Board Meeting Information');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `contaminant_detection_count` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Detection Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `copper_90th_percentile_ppm` SET TAGS ('dbx_business_glossary_term' = 'Copper 90th Percentile (PPM - Parts Per Million)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|electronic|hand_delivery|newspaper|combination');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `disinfection_byproduct_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Byproduct (DBP) Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `educational_information_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Educational Information Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `electronic_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `language_accessibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Accessibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `lead_90th_percentile_ppb` SET TAGS ('dbx_business_glossary_term' = 'Lead 90th Percentile (PPB - Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `lead_copper_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Monitoring Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `mailed_count` SET TAGS ('dbx_business_glossary_term' = 'Mailed Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `mcl_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Exceedance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `pws_code` SET TAGS ('dbx_business_glossary_term' = 'Public Water System (PWS) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `pws_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `report_year` SET TAGS ('dbx_business_glossary_term' = 'Report Year');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `source_water_description` SET TAGS ('dbx_business_glossary_term' = 'Source Water Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `source_water_type` SET TAGS ('dbx_business_glossary_term' = 'Source Water Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `source_water_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|groundwater_under_direct_influence_of_surface_water|mixed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `special_notice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `special_notice_text` SET TAGS ('dbx_business_glossary_term' = 'Special Notice Text');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'Water System Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `system_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `treatment_domain_added_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `treatment_domain_added_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `violation_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (Uniform Resource Locator)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`ccr` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Document ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `lab_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Accreditation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Utility Representative Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Scheduled Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspecting_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspecting Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_received_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_report_status` SET TAGS ('dbx_value_regex' = 'draft|final|under_review|accepted|disputed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|report_pending|closed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Inspector Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Inspector Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_title` SET TAGS ('dbx_business_glossary_term' = 'Inspector Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Classification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `utility_representative_title` SET TAGS ('dbx_business_glossary_term' = 'Utility Representative Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `violation_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Identified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_system_of_record' = 'IBM_Maximo');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `previous_finding_inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Corrective Action Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System or Process');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `correspondence_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspection_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `enforcement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Corrective Action Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'significant_deficiency|minor_deficiency|recommendation|observation|violation|best_practice');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_agency` SET TAGS ('dbx_business_glossary_term' = 'Inspector Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `inspector_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `public_health_impact` SET TAGS ('dbx_business_glossary_term' = 'Public Health Impact');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `public_health_impact` SET TAGS ('dbx_value_regex' = 'immediate|potential|minimal|none');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `public_health_impact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `public_health_impact` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `required_corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Required Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|resolved|closed|overdue');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`inspection_finding` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_role' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_pair' = 'laboratory.laboratory_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_status' = 'duplicate_of');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_duplicate_of' = 'quality.quality_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_master' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_ssot_master_for' = 'laboratory.laboratory_corrective_action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `compliance_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `encumbrance_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `inspection_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|pending_verification|completed|overdue|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `agency_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `agency_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `agency_notification_method` SET TAGS ('dbx_value_regex' = 'formal_letter|email|portal_submission|phone|in_person_meeting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `agency_response` SET TAGS ('dbx_business_glossary_term' = 'Agency Response');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `preventive_action_implemented` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Implemented');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `regulatory_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Notified');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `responsible_individual` SET TAGS ('dbx_business_glossary_term' = 'Responsible Individual');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `responsible_individual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `supporting_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Location');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `triggering_event_description` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_value_regex' = 'regulatory_violation|enforcement_action|inspection_finding|internal_audit|self_disclosure|customer_complaint');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'internal_audit|third_party_audit|regulatory_inspection|documentation_review|testing|monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified_effective|verified_ineffective|requires_additional_action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Consulting Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `lab_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Work Order Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `original_submission_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_comments` SET TAGS ('dbx_business_glossary_term' = 'Agency Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agency_response_type` SET TAGS ('dbx_value_regex' = 'accepted|rejected|request_for_information|notice_of_violation|enforcement_action|no_response');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `exceedance_count` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_late_submission` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `noncompliance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Noncompliance Explanation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `resubmission_required` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_format` SET TAGS ('dbx_business_glossary_term' = 'Submission File Format');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_format` SET TAGS ('dbx_value_regex' = 'PDF|XML|CSV|Excel|paper|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_path` SET TAGS ('dbx_business_glossary_term' = 'Submission File Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'NetDMR|state_portal|email|paper|fax|hand_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|accepted|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Violation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Utility Contact Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Person Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `agency_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Person Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Business Information Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_date` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_value_regex' = 'active|closed|archived|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Direction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'incoming|outgoing');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Records Disposition Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|email|paper|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference or File Path');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `public_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Date Received by Utility');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Records Retention Period (Years)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Date Sent by Utility');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_correspondence` ALTER COLUMN `utility_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Utility Contact Person Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Industrial User Permit (IUP) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Equipment Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `bmp_requirements` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|significant_non_compliance|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `enforcement_action_pending` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Pending Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_city` SET TAGS ('dbx_business_glossary_term' = 'Facility City');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_state` SET TAGS ('dbx_business_glossary_term' = 'Facility State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `facility_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `maximum_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|terminated');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'individual|general|conditional');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `pretreatment_required` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `pretreatment_technology_description` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Technology Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `siu_classification` SET TAGS ('dbx_business_glossary_term' = 'Significant Industrial User (SIU) Classification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `siu_classification` SET TAGS ('dbx_value_regex' = 'significant_industrial_user|categorical_industrial_user|non_significant_categorical_user|non_categorical_user');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `slug_control_plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Slug Control Plan Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`pretreatment_iup` ALTER COLUMN `slug_control_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Slug Control Plan Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Service Vendor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `annual_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Certification Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `baseline_monitoring_report_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Monitoring Report (BMR) Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `baseline_monitoring_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'Baseline Monitoring Report (BMR) Submitted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `categorical_standard_applicable` SET TAGS ('dbx_business_glossary_term' = 'Categorical Standard Applicable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `categorical_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Categorical Standard Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Facility City');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Classification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'Significant Industrial User (SIU)|Categorical Industrial User (CIU)|Non-Significant Industrial User|Exempt');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'In Compliance|Non-Compliance|Significant Non-Compliance (SNC)|Under Review|Enforcement Action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_person_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `discharge_connection_point` SET TAGS ('dbx_business_glossary_term' = 'Discharge Connection Point');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `enforcement_action_pending` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Pending Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `estimated_discharge_volume_gpd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Discharge Volume in Gallons Per Day (GPD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Industrial Facility Business Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `facility_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly|As Needed');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Industrial User Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `last_sampling_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sampling Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `last_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Violation Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `pollutants_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Pollutants of Concern');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `pretreatment_system_description` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `pretreatment_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Installed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly|Weekly|As Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `slug_discharge_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Slug Discharge Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Facility State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `violation_count_last_12_months` SET TAGS ('dbx_business_glossary_term' = 'Violation Count in Last 12 Months');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`industrial_user` ALTER COLUMN `zero_discharge_certification` SET TAGS ('dbx_business_glossary_term' = 'Zero Discharge Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_subdomain' = 'enforcement_oversight');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` SET TAGS ('dbx_ecm_depth_target' = '8');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_renamed_from' = 'compliance_permit_id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `overflow_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `overflow_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `overflow_responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `overflow_responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_business_glossary_term' = 'ECM/MVM Depth Reconciliation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_mvm_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `health_advisory_issued` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `health_advisory_issued` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`overflow_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `compliance_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `extension_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `extension_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Approved Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `extension_justification` SET TAGS ('dbx_business_glossary_term' = 'Extension Request Justification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `extension_request_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Request Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `final_compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Final Compliance Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `last_status_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Status Update Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Total Milestone Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `milestones_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestones Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `milestones_overdue_count` SET TAGS ('dbx_business_glossary_term' = 'Overdue Milestones Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `next_status_update_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Status Update Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `on_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'On Schedule Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `original_final_deadline` SET TAGS ('dbx_business_glossary_term' = 'Original Final Compliance Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `overall_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Completion Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `public_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `regulatory_correspondence_count` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'consent_order|administrative_order|permit_condition|settlement_agreement|voluntary|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Regulatory Agency Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id_legacy` SET TAGS ('dbx_business_glossary_term' = 'Parent Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Liaison Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `additional_programs_administered` SET TAGS ('dbx_business_glossary_term' = 'Additional Programs Administered');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|dissolved');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_website_url` SET TAGS ('dbx_business_glossary_term' = 'Agency Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `business_hours` SET TAGS ('dbx_business_glossary_term' = 'Business Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `directive_transposition_status` SET TAGS ('dbx_business_glossary_term' = 'Directive Transposition Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Authority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_value_regex' = 'primary|delegated|advisory|none');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_agency_type` SET TAGS ('dbx_business_glossary_term' = 'EU Agency Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_member_state_code` SET TAGS ('dbx_business_glossary_term' = 'EU Member State Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `eu_member_state_flag` SET TAGS ('dbx_business_glossary_term' = 'EU member state flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `governing_framework_reference` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Months');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Typical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|as_needed|risk_based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_agency_role` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_agency_role` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_agency_role` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_body_type` SET TAGS ('dbx_regional' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_cooperation_body` SET TAGS ('dbx_business_glossary_term' = 'International cooperation body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `international_framework` SET TAGS ('dbx_business_glossary_term' = 'International Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `iso_country_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Geographic Area');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|regional|local|international');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_region_code` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `main_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `main_email` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `main_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `main_phone` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `mutual_recognition_agreements` SET TAGS ('dbx_business_glossary_term' = 'Mutual Recognition Agreements');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `notification_deadline_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `npdes_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Authority Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `pretreatment_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Authority Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_status` SET TAGS ('dbx_business_glossary_term' = 'Primacy Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primacy_status` SET TAGS ('dbx_value_regex' = 'primacy_agency|non_primacy|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_framework_administered` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_framework_administered` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_framework_administered` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_jurisdiction' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_regulatory_region' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_i18n' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency Default');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|event_driven|as_required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting System Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Secondary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `secondary_contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Credentials Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `supranational_body_flag` SET TAGS ('dbx_business_glossary_term' = 'Supranational Body Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_association_edges' = 'compliance.compliance_permit,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `permit_vendor_service_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Vendor Service ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Vendor Service - Compliance Permit Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Vendor Service - Vendor Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `deliverable_status` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_vendor_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_requirement,supply.material_master');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `material_compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Compliance Certification ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Compliance Certification - Material Master Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Compliance Certification - Regulatory Requirement Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `dosage_unit` SET TAGS ('dbx_business_glossary_term' = 'Dosage Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `maximum_dosage_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dosage Rate');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `nsf_ansi_standard` SET TAGS ('dbx_business_glossary_term' = 'NSF/ANSI Standard');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`material_compliance_certification` ALTER COLUMN `responsible_compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Officer');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_association_edges' = 'compliance.compliance_permit,finance.grant');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `permit_grant_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Grant Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Grant Allocation - Grant Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `amount_expended_to_date` SET TAGS ('dbx_business_glossary_term' = 'Amount Expended to Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `compliance_milestone` SET TAGS ('dbx_business_glossary_term' = 'Compliance Milestone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `drawdown_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `eligible_activities` SET TAGS ('dbx_business_glossary_term' = 'Eligible Activities');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `remaining_allocation_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Allocation Balance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_grant_allocation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'permit_authorization');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_association_edges' = 'compliance.compliance_obligation,workforce.crew');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_cites' = 'EPA_SDWA');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_v1_preserved' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_citation_discipline' = 'maintained');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` SET TAGS ('dbx_mvm_included' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Crew Assignment ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Crew Assignment - Crew Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `crew_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `crew_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Crew Assignment - Compliance Obligation Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`crew_assignment` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference');
