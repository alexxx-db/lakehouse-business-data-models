-- Schema for Domain: compliance | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-02 05:00:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`compliance` COMMENT 'Regulatory compliance management including permit tracking (NPDES, IUP, state primacy agency permits), MOR/DMR preparation and submission, violation management, enforcement action tracking, audit trails, environmental reporting, SDWA and CWA compliance, CCR publication tracking, and regulatory correspondence. Ensures adherence to all federal, state, and local water and wastewater regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` (
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance_permit data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `treatment_permit_id` BIGINT COMMENT 'treatment permit id for compliance_permit. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency that issued this permit, supporting multi-jurisdictional agency tracking (US EPA, ANSES, DWI, UBA). Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Primary regulatory requirement. Ref: EPA SDWA.',
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
    `compliance_permit_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `compliance_permit_type` STRING COMMENT 'The compliance permit type value recorded for each compliance permit in the compliance domain.',
    `compliance_schedule_flag` BOOLEAN COMMENT 'compliance schedule flag for compliance_permit. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'In Compliance, Violation, Consent Order, Enforcement. Ref: EPA SDWA.',
    `conditions_count` STRING COMMENT 'The permit conditions count value recorded for each compliance permit in the compliance domain.',
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
    `fee_amount` DECIMAL(18,2) COMMENT 'The permit fee amount value recorded for each compliance permit in the compliance domain.',
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
    `permit_description` STRING COMMENT 'Description of permit scope and conditions. Ref: EPA SDWA.',
    `permit_name` STRING COMMENT 'Descriptive name of the permit. Ref: EPA SDWA.',
    `permit_number` STRING COMMENT 'Official permit number. Ref: EPA SDWA.',
    `permit_status` STRING COMMENT 'Status (active, expired, pending_renewal, suspended, revoked). Ref: EPA SDWA.',
    `permit_type` STRING COMMENT 'Type (NPDES, SDWA, air, stormwater, pretreatment, EU_WFD). Ref: EPA SDWA.',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'permitted capacity mgd for compliance_permit. Ref: EPA SDWA.',
    `permitted_flow_mgd` STRING COMMENT 'Permitted flow in MGD. Ref: EPA SDWA.',
    `priority_level` STRING COMMENT 'The priority level value recorded for each compliance permit in the compliance domain.',
    `program` STRING COMMENT 'permit program for compliance_permit. Ref: EPA SDWA.',
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
    `treatment_facility_code` STRING COMMENT 'Facility code from treatment domain. Ref: EPA SDWA.',
    `unit_of_measure` STRING COMMENT 'The unit of measure value recorded for each compliance permit in the compliance domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `uwwtd_compliance_route` STRING COMMENT 'Compliance pathway under EU Urban Wastewater Treatment Directive 91/271/EEC: normal_area, sensitive_area, less_sensitive_area. Determines permit emission limit stringency. Ref: EPA SDWA.',
    CONSTRAINT pk_compliance_permit PRIMARY KEY(`compliance_permit_id`)
) COMMENT 'Master record for all regulatory operating permits held by the utility, including NPDES discharge permits, state drinking water permits, IUPs (Industrial User Permits), air quality permits, and stormwater permits. Tracks permit number, issuing authority (EPA, state primacy agency, NPDES), permit type, facility covered, effective and expiration dates, permitted limits, renewal status, and associated regulatory program (SDWA, CWA). Serves as the authoritative registry of all regulatory authorizations required to operate water and wastewater facilities. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for permits.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition record. Primary key. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each permit condition is derived from and enforces a specific regulatory requirement (e.g., an effluent limit tied to a CWA/NPDES rule). This FK normalizes the relationship so that the authoritative r',
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
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether violations of this condition require public notification (e.g., inclusion in Consumer Confidence Report (CCR), public notice in local newspaper, notification to downstream water users). True if public notification is required, False otherwise. Ref: EPA SDWA.',
    `quality_assurance_requirement` STRING COMMENT 'Specific quality assurance and quality control (QA/QC) requirements for monitoring and sampling (e.g., EPA Method 1664A for FOG, Standard Methods 5210B for BOD, EPA Method 200.8 for metals, Chain of custody required, Laboratory must be state-certified, Duplicate samples required quarterly). Ref: EPA SDWA.',
    `receiving_water_body` STRING COMMENT 'The name of the receiving water body (river, stream, lake, estuary, ocean, groundwater) into which the discharge occurs and for which this condition is designed to protect water quality (e.g., Mississippi River, Lake Michigan, Chesapeake Bay, Atlantic Ocean, Groundwater Aquifer Zone IIA). Ref: EPA SDWA.',
    `record_retention_period_days` STRING COMMENT 'The number of days that monitoring records, laboratory results, and compliance documentation for this condition must be retained by the permittee. Typically 3 years (1095 days) for NPDES permits, but may be longer for certain parameters or enforcement actions. Ref: EPA SDWA.',
    `record_status` STRING COMMENT 'Record lifecycle status. Ref: EPA SDWA.',
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
    `regulatory_agency_id` BIGINT COMMENT 'Governing agency. Ref: EPA SDWA.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` (
    `dmr_id` BIGINT COMMENT 'Unique identifier for the discharge monitoring report record. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this discharge monitoring report is filed. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the wastewater treatment plant or water treatment plant facility that generated this discharge monitoring report. Ref: EPA SDWA.',
    `original_dmr_id` BIGINT COMMENT 'Reference to the original discharge monitoring report record if this is a resubmission or correction. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to the regulatory agency receiving this DMR submission, enabling multi-jurisdictional routing (US EPA, ANSES, DWI, UBA, European Commission). Ref: EPA SDWA.',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: DMRs reference specific monitoring locations where samples were collected. Linking dmr to quality_sampling_point replaces the denormalized monitoring_location_code text column with a proper FK, enabli',
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
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: DMR results submitted to regulators are derived from laboratory analytical results. Linking dmr_result to analytical_result provides the mandatory audit trail from regulatory submission back to the va',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this discharge monitoring result is reported. Establishes the regulatory framework and limits applicable to this measurement. Ref: EPA SDWA.',
    `dmr_id` BIGINT COMMENT 'Parent DMR. Ref: EPA SDWA.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Each DMR result is a measurement taken against a specific permit condition (effluent limitation or monitoring requirement). The permit_condition table is the authoritative source for limit_value and l',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: DMR results must be traceable to the source water sample for chain-of-custody documentation required by NPDES permits. This direct link supports regulatory audit verification of sample collection date',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`violation` (
    `violation_id` BIGINT COMMENT 'Unique identifier for the compliance_violation data product (auto-inserted pre-linking). Ref: EPA SDWA.',
    `analytical_result_id` BIGINT COMMENT 'Unique identifier for the analytical result referenced by each compliance violation record in the compliance domain.',
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance permit referenced by each compliance violation record in the compliance domain.',
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant referenced by each compliance violation record in the compliance domain.',
    `dmr_result_id` BIGINT COMMENT 'Foreign key linking to compliance.dmr_result. Business justification: A compliance violation is frequently triggered by a specific DMR result that shows an exceedance (dmr_result.exceedance_flag = true, dmr_result.is_violation = true). Linking compliance_violation direc',
    `facility_id` BIGINT COMMENT 'Unique identifier for the facility referenced by each compliance violation record in the compliance domain.',
    `regulatory_agency_id` BIGINT COMMENT 'FK to compliance.regulatory_agency. Ref: EPA SDWA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement referenced by each compliance violation record in the compliance domain.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The amount usd value recorded for each compliance violation in the compliance domain.',
    `begin_date` TIMESTAMP COMMENT 'Date violation period began. Ref: EPA SDWA.',
    `violation_category` STRING COMMENT 'Category (health_based, non_health_based, procedural). Ref: EPA SDWA.',
    `classification` STRING COMMENT 'The classification value recorded for each compliance violation in the compliance domain.',
    `violation_code` STRING COMMENT 'Regulatory violation code per EPA SDWIS classification. Ref: EPA SDWA.',
    `comments` STRING COMMENT 'Additional notes or context. Ref: EPA SDWA.',
    `compliance_period` STRING COMMENT 'compliance period for compliance_violation. Ref: EPA SDWA.',
    `compliance_period_begin` DATE COMMENT 'Start of compliance period. Ref: EPA SDWA.',
    `compliance_period_begin_date` TIMESTAMP COMMENT 'Start of compliance monitoring period. Ref: EPA SDWA.',
    `compliance_period_end` STRING COMMENT 'End of compliance period. Ref: EPA SDWA.',
    `compliance_period_end_date` TIMESTAMP COMMENT 'End of compliance monitoring period. Ref: EPA SDWA.',
    `compliance_period_start` STRING COMMENT 'Start of compliance period. Ref: EPA SDWA.',
    `compliance_status` STRING COMMENT 'Current status (open, resolved, returned_to_compliance, under_enforcement). Ref: EPA SDWA.',
    `compliance_violation_category` STRING COMMENT 'The compliance violation category value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_code` STRING COMMENT 'code for compliance_violation. Ref: EPA SDWA.',
    `compliance_violation_description` STRING COMMENT 'The compliance violation description value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_name` STRING COMMENT 'name for compliance_violation. Ref: EPA SDWA.',
    `compliance_violation_number` STRING COMMENT 'The compliance violation number value recorded for each compliance violation in the compliance domain.',
    `compliance_violation_status` STRING COMMENT 'Lifecycle status of the record. Ref: EPA SDWA.',
    `compliance_violation_type` STRING COMMENT 'The compliance violation type value recorded for each compliance violation in the compliance domain.',
    `corrective_action_completed_date` TIMESTAMP COMMENT 'Date corrective action was completed. Ref: EPA SDWA.',
    `corrective_action_deadline` DATE COMMENT 'Deadline for corrective action. Ref: EPA SDWA.',
    `corrective_action_description` STRING COMMENT 'Description of corrective action. Ref: EPA SDWA.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is mandated. Ref: EPA SDWA.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp. Ref: EPA SDWA.',
    `data_source_system` STRING COMMENT 'System of record from which this violation data originated. Ref: EPA SDWA.',
    `violation_description` STRING COMMENT 'The violation description value recorded for each compliance violation in the compliance domain.',
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
    `unit_of_measure` STRING COMMENT 'Unit of measure. Ref: EPA SDWA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp. Ref: EPA SDWA.',
    `violation_date` TIMESTAMP COMMENT 'The violation date associated with each compliance violation record in the compliance domain.',
    `violation_number` STRING COMMENT 'Unique violation reference number. Ref: EPA SDWA.',
    `violation_status` STRING COMMENT 'Status (open, under_review, resolved, closed, appealed). Ref: EPA SDWA.',
    `violation_type` STRING COMMENT 'Type (MCL, monitoring, reporting, treatment_technique, operational). Ref: EPA SDWA.',
    CONSTRAINT pk_violation PRIMARY KEY(`violation_id`)
) COMMENT 'Formal record of a regulatory violation identified at a utility facility or in a regulatory submission, including MCL exceedances, permit limit violations, monitoring and reporting violations (MRVs), treatment technique violations, and public notification failures. Tracks violation type, regulatory citation, affected facility, detection date, parameter and measured value, applicable limit, violation severity, notification requirements triggered, and current resolution status. Central record for all compliance failures requiring regulatory response. [SSOT: Canonical source of truth for this concept across domains.] SSOT master for violations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the enforcement action record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which the violation and enforcement action occurred (NPDES permit, drinking water permit, IUP, etc.). Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility subject to the enforcement action. Ref: EPA SDWA.',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `violation_id` BIGINT COMMENT 'Reference to the primary violation record that triggered this enforcement action. Links to the violation tracking system. Ref: EPA SDWA.',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key. Ref: EPA SDWA.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the permit under which the inspection was conducted (NPDES, IUP, state primacy permit). Ref: EPA SDWA.',
    `enforcement_action_id` BIGINT COMMENT 'Identifier linking to the enforcement action record if formal enforcement was initiated. Ref: EPA SDWA.',
    `facility_id` BIGINT COMMENT 'Identifier of the water or wastewater facility that was inspected (WTP, WWTP, pumping station, etc.). Ref: EPA SDWA.',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Regulatory inspections (sanitary surveys, state compliance inspections) are conducted on pump stations. Inspectors record findings against specific pump station assets. regulatory_inspection.facility_',
    `regulatory_agency_id` BIGINT COMMENT 'Agency. Ref: EPA SDWA.',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks undergo mandatory regulatory inspections (state sanitary surveys, AWWA-based inspection programs). storage_tank.regulatory_inspection_status confirms this process. Inspection records mus',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` (
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency record. Primary key. Ref: EPA SDWA.',
    `parent_regulatory_agency_id` BIGINT COMMENT 'Self-referencing FK on regulatory_agency (parent_regulatory_agency_id). Ref: EPA SDWA.',
    `parent_regulatory_agency_regulatory_agency_id` BIGINT COMMENT 'Reference to the parent or umbrella agency if this agency is a regional office, division, or sub-agency (e.g., EPA Region 5 parent is EPA). Null if this is a top-level agency. Ref: EPA SDWA.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_original_dmr_id` FOREIGN KEY (`original_dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_dmr_id` FOREIGN KEY (`dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_dmr_result_id` FOREIGN KEY (`dmr_result_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr_result`(`dmr_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_id` FOREIGN KEY (`parent_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_regulatory_agency_id` FOREIGN KEY (`parent_regulatory_agency_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `quality_assurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `record_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Period (Days)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_subdomain' = 'enforcement_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `original_dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Original Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` SET TAGS ('dbx_subdomain' = 'enforcement_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `dmr_result_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_subdomain' = 'enforcement_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `dmr_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dmr Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_begin` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Begin');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_business_glossary_term' = 'ECM/MVM Depth Reconciliation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_metadata' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_depth_reconciled' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ecm_mvm_depth_reconciliation_note` SET TAGS ('dbx_ecm_mvm_reconciliation' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_initiated` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Initiated');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `enforcement_action_pending` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Pending');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Health-Based Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `health_based_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_business_glossary_term' = 'Health-Based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_health_based` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_repeat_violation` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `is_significant_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Is Significant Noncompliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `mcl_limit` SET TAGS ('dbx_business_glossary_term' = 'MCL Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_money' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `population_served_affected` SET TAGS ('dbx_business_glossary_term' = 'Population Served Affected');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `primacy_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_issued` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Issued');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Issued Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `public_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PN Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Pwsid');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `reported_to_agency_date` SET TAGS ('dbx_business_glossary_term' = 'Reported To Agency Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `reporting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rtc_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Compliance Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rule_citation` SET TAGS ('dbx_business_glossary_term' = 'Rule Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `sdwis_violation_code` SET TAGS ('dbx_business_glossary_term' = 'SDWIS Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ssot_role` SET TAGS ('dbx_ssot' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `ssot_role` SET TAGS ('dbx_cross_domain_resolution' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'enforcement_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Violation Identifier (ID)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'enforcement_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Regulatory Agency Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agency Identifier (ID)');
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
