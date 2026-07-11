-- Schema for Domain: compliance | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-07-10 20:15:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`compliance` COMMENT 'Regulatory compliance management including permit tracking (NPDES, IUP, state primacy agency permits), MOR/DMR preparation and submission, violation management, enforcement action tracking, audit trails, environmental reporting, SDWA and CWA compliance, CCR publication tracking, and regulatory correspondence. Ensures adherence to all federal, state, and local water and wastewater regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` (
    `compliance_permit_id` BIGINT COMMENT 'Unique identifier for the compliance_permit data product (auto-inserted pre-linking).',
    `facility_id` BIGINT COMMENT 'FK to treatment.facility',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Every compliance permit is issued by a specific regulatory agency (e.g., EPA Region, state environmental agency for NPDES; state primacy agency for drinking water operating permits). compliance_permit',
    CONSTRAINT pk_compliance_permit PRIMARY KEY(`compliance_permit_id`)
) COMMENT 'Master record for all regulatory operating permits held by the utility, including NPDES discharge permits, state drinking water permits, IUPs (Industrial User Permits), air quality permits, and stormwater permits. Tracks permit number, issuing authority (EPA, state primacy agency, NPDES), permit type, facility covered, effective and expiration dates, permitted limits, renewal status, and associated regulatory program (SDWA, CWA). Serves as the authoritative registry of all regulatory authorizations required to operate water and wastewater facilities.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: A permit_condition is an enforceable condition attached to a regulatory operating permit. The compliance_permit table is the master permit record in this domain. Adding compliance_permit_id to permit_',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each permit condition is derived from or based on a specific regulatory requirement (e.g., an MCL under SDWA, an effluent limit under CWA/NPDES). permit_condition has a regulatory_basis STRING column ',
    `analytical_method` STRING COMMENT 'The specific EPA-approved or Standard Methods analytical procedure required for measuring this parameter (e.g., EPA Method 1664A, Standard Methods 5210B, EPA Method 200.8, EPA Method 537.1 for PFAS, SM 2540D for TDS, SM 4500-H+ for pH).',
    `compliance_evaluation_method` STRING COMMENT 'The method used to determine compliance with this condition: single value comparison (each result compared to limit), rolling average (moving average over specified period), statistical analysis (percentile or confidence interval), narrative assessment (qualitative evaluation), or best professional judgment (case-by-case determination).. Valid values are `single_value_comparison|rolling_average|statistical_analysis|narrative_assessment|best_professional_judgment`',
    `compliance_schedule_flag` BOOLEAN COMMENT 'Indicates whether this condition is subject to a compliance schedule (phased implementation plan) that allows the permittee additional time to achieve full compliance. True if a compliance schedule is in effect, False otherwise.',
    `compliance_schedule_milestone` STRING COMMENT 'Description of the compliance schedule milestone associated with this condition (e.g., Submit engineering plans by 2024-06-30, Complete construction by 2025-12-31, Achieve interim limit of 30 mg/L BOD by 2024-12-31). Null if no compliance schedule applies.',
    `condition_number` STRING COMMENT 'The official condition number or identifier as stated in the permit document (e.g., I.A.1, II.B.3, Condition 5).',
    `condition_status` STRING COMMENT 'Current lifecycle status of the permit condition: active (currently enforceable), suspended (temporarily not enforced due to variance or stay), superseded (replaced by modified condition), expired (no longer in effect), or under appeal (contested by permittee).. Valid values are `active|suspended|superseded|expired|under_appeal`',
    `condition_text` STRING COMMENT 'The full verbatim text of the permit condition as written in the permit document. Includes all narrative requirements, qualifications, and regulatory language.',
    `condition_type` STRING COMMENT 'Classification of the permit condition: effluent limit (numeric discharge limit), monitoring requirement (sampling frequency and method), reporting requirement (MOR/DMR submission), technology-based standard (treatment technology mandate), narrative condition (qualitative requirement), or best management practice (operational control).. Valid values are `effluent_limit|monitoring_requirement|reporting_requirement|technology_based_standard|narrative_condition|best_management_practice`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was first created in the system. Audit trail field for data governance and compliance tracking.',
    `detection_limit_requirement` DECIMAL(18,2) COMMENT 'The minimum detection limit (MDL) or practical quantitation limit (PQL) required for the analytical method. Ensures that the laboratory can measure the parameter at levels sufficiently below the permit limit to demonstrate compliance. Null if no specific detection limit is mandated.',
    `effective_date` DATE COMMENT 'The date on which this permit condition becomes enforceable. May differ from the parent permit effective date if the condition has a phased implementation schedule.',
    `enforcement_priority` STRING COMMENT 'The priority level assigned by the regulatory agency for enforcement of this condition. Critical conditions (e.g., public health parameters like coliform, lead, PFAS) trigger immediate enforcement action upon violation. High priority conditions (e.g., BOD, TSS, pH) require prompt corrective action. Medium and low priority conditions may allow for compliance schedules.. Valid values are `critical|high|medium|low`',
    `expiration_date` DATE COMMENT 'The date on which this permit condition expires or is superseded. Typically aligns with the parent permit expiration date unless the condition is time-limited or subject to modification.',
    `limit_type` STRING COMMENT 'The statistical basis for the effluent limit: daily maximum (highest single-day value), monthly average (arithmetic mean over calendar month), weekly average (arithmetic mean over 7-day period), instantaneous maximum (single grab sample), annual average, or minimum (for parameters like dissolved oxygen).. Valid values are `daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average|minimum`',
    `mixing_zone_allowed_flag` BOOLEAN COMMENT 'Indicates whether a mixing zone (limited area where discharge is allowed to exceed water quality standards before achieving full dilution and compliance) is authorized for this condition. True if mixing zone is allowed, False if end-of-pipe compliance is required.',
    `mixing_zone_description` STRING COMMENT 'Description of the authorized mixing zone including dimensions, boundaries, and compliance monitoring points (e.g., 100 meters downstream of Outfall 001, Within 50-foot radius of discharge point, Compliance measured at edge of mixing zone). Null if no mixing zone is allowed.',
    `modification_date` DATE COMMENT 'The date on which this permit condition was last modified through permit amendment, administrative order, or consent decree. Null if the condition has never been modified since the original permit issuance.',
    `modification_reason` STRING COMMENT 'The reason for the most recent modification to this condition (e.g., Updated water quality standards, New analytical method approved, Compliance schedule adjustment, Facility upgrade completed, Enforcement action settlement, Anti-backsliding provision waiver). Null if never modified.',
    `monitoring_frequency` STRING COMMENT 'The required frequency for monitoring or sampling this parameter: continuous (real-time SCADA monitoring), daily, weekly, monthly, quarterly, annually, or as needed (event-driven). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|as_needed — 7 candidates stripped; promote to reference product]',
    `monitoring_location` STRING COMMENT 'The specific location where monitoring or sampling must occur (e.g., Outfall 001, Effluent Discharge Point A, Influent to Primary Treatment, Final Effluent). May reference a specific outfall, sampling point, or monitoring station.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or operational guidance related to this permit condition. May include cross-references to other permit sections, special instructions for compliance staff, or historical context.',
    `numeric_limit` DECIMAL(18,2) COMMENT 'The numeric threshold value for the effluent limit or monitoring requirement. Null for narrative conditions or qualitative requirements.',
    `parameter_code` STRING COMMENT 'Standardized code for the regulated parameter (e.g., 00310 for BOD, 00530 for TSS, 00400 for pH, 00600 for TDS). Uses EPA STORET or equivalent parameter coding system.',
    `public_notification_required_flag` BOOLEAN COMMENT 'Indicates whether violations of this condition require public notification (e.g., inclusion in Consumer Confidence Report (CCR), public notice in local newspaper, notification to downstream water users). True if public notification is required, False otherwise.',
    `quality_assurance_requirement` STRING COMMENT 'Specific quality assurance and quality control (QA/QC) requirements for monitoring and sampling (e.g., EPA Method 1664A for FOG, Standard Methods 5210B for BOD, EPA Method 200.8 for metals, Chain of custody required, Laboratory must be state-certified, Duplicate samples required quarterly).',
    `receiving_water_body` STRING COMMENT 'The name of the receiving water body (river, stream, lake, estuary, ocean, groundwater) into which the discharge occurs and for which this condition is designed to protect water quality (e.g., Mississippi River, Lake Michigan, Chesapeake Bay, Atlantic Ocean, Groundwater Aquifer Zone IIA).',
    `record_retention_period_days` STRING COMMENT 'The number of days that monitoring records, laboratory results, and compliance documentation for this condition must be retained by the permittee. Typically 3 years (1095 days) for NPDES permits, but may be longer for certain parameters or enforcement actions.',
    `reporting_frequency` STRING COMMENT 'The required frequency for reporting monitoring results to the regulatory agency via Monthly Operating Report (MOR) or Discharge Monitoring Report (DMR): monthly, quarterly, annually, event-based (for spills or exceedances), or not required (internal monitoring only).. Valid values are `monthly|quarterly|annually|event_based|not_required`',
    `sample_type` STRING COMMENT 'The type of sample required for compliance monitoring: grab (single instantaneous sample), composite (time-weighted or flow-weighted composite over specified period), continuous (real-time monitoring), or flow-weighted (proportional to flow rate).. Valid values are `grab|composite|continuous|flow_weighted`',
    `seasonal_period` STRING COMMENT 'The time period during which seasonal variations apply (e.g., May 1 - September 30, Winter: November 1 - March 31, Low Flow Season: June - August). Null if no seasonal variation applies.',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates whether this condition has seasonal variations in limits or monitoring requirements (e.g., more stringent limits during low-flow summer months, reduced monitoring during winter). True if seasonal variations apply, False otherwise.',
    `technology_requirement` STRING COMMENT 'Specific treatment technology or operational practice mandated by this condition (e.g., Secondary Treatment, Ultraviolet (UV) Disinfection, Granular Activated Carbon (GAC) Filtration, Reverse Osmosis (RO), Microfiltration (MF), Ultrafiltration (UF), Fats Oils and Grease (FOG) Pretreatment, Best Management Practice (BMP) for Stormwater). Null for non-technology-based conditions.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the numeric limit (e.g., mg/L for milligrams per liter, ug/L for micrograms per liter, NTU for Nephelometric Turbidity Units, SU for Standard Units (pH), MPN/100mL for Most Probable Number per 100 milliliters, lbs/day for pounds per day, MGD for Million Gallons per Day).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this permit condition record was last updated in the system. Audit trail field for data governance and compliance tracking.',
    `violation_threshold` DECIMAL(18,2) COMMENT 'The numeric value at which a violation is triggered. May differ from the numeric limit if the permit allows for measurement uncertainty, rounding conventions, or compliance margins. Null for narrative conditions.',
    `water_quality_standard_basis` STRING COMMENT 'The specific water quality standard or criterion that this condition is designed to protect (e.g., Aquatic Life Chronic Criterion, Human Health - Fish Consumption, Drinking Water Maximum Contaminant Level (MCL), Recreational Water Quality Standard, Anti-Degradation Policy Tier II). Null for technology-based conditions.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Individual enforceable conditions and limitations attached to a regulatory permit, including effluent limits (BOD, TSS, TDS, pH, COD), monitoring frequencies, reporting requirements, technology-based standards, and narrative conditions. Each condition is linked to its parent permit and tracks the parameter, limit type (daily max, monthly average), numeric threshold, units, monitoring location, and compliance evaluation method. Enables automated compliance checking against actual discharge monitoring results.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Many regulatory requirements mandate specific position types (e.g., Grade IV operator for large systems, certified backflow tester). Links regulatory mandates to workforce planning and ensures proper',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Every regulatory requirement is issued and enforced by a specific regulatory agency (EPA, state primacy agency, local authority). regulatory_requirement has an issuing_authority STRING column that is ',
    `applicable_facility_type` STRING COMMENT 'Type of facility or system to which this requirement applies. WTP = Water Treatment Plant, WWTP = Wastewater Treatment Plant, STP = Sewage Treatment Plant.. Valid values are `WTP|WWTP|STP|distribution_system|collection_system|all_facilities`',
    `applicable_system_size` STRING COMMENT 'System size classification to which this requirement applies (e.g., large system >50,000 population, medium system 3,301-50,000, small system <=3,300). Null if applies to all sizes.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this requirement must be included in the annual Consumer Confidence Report (CCR).',
    `compliance_deadline` DATE COMMENT 'Date by which the utility must achieve full compliance with the requirement. Null if no specific deadline or if compliance is ongoing.',
    `compliance_status` STRING COMMENT 'Current compliance status of the utility with respect to this regulatory requirement.. Valid values are `compliant|non_compliant|pending|not_applicable|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the regulatory requirement became or will become effective and enforceable.',
    `enforcement_priority` STRING COMMENT 'Priority level assigned by the utility or regulator for enforcement and compliance tracking.. Valid values are `critical|high|medium|low`',
    `internal_policy_reference` STRING COMMENT 'Reference to the utilitys internal policy, procedure, or standard operating procedure (SOP) that implements this regulatory requirement.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this regulatory requirement is currently active and enforceable. False if the requirement has been superseded, repealed, or is no longer applicable.',
    `jurisdiction` STRING COMMENT 'The geographic or administrative jurisdiction to which this requirement applies (e.g., federal, state name, county, municipality).',
    `last_compliance_assessment_date` DATE COMMENT 'Date of the most recent internal or external compliance assessment or audit for this requirement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory requirement record was last updated or modified.',
    `mcl_unit` STRING COMMENT 'Unit of measure for the MCL value (e.g., mg/L, ug/L, pCi/L, NTU). Null if not applicable.',
    `mcl_value` DECIMAL(18,2) COMMENT 'The enforceable maximum contaminant level (MCL) specified by the requirement. Null if not applicable.',
    `mclg_unit` STRING COMMENT 'Unit of measure for the MCLG value (e.g., mg/L, ug/L, pCi/L). Null if not applicable.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The non-enforceable maximum contaminant level goal (MCLG) specified by the requirement. Null if not applicable.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of monitoring or sampling for compliance (e.g., daily, weekly, monthly, quarterly, annually). Null if not applicable.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or assessment of this requirement.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the regulatory requirement, including implementation challenges, variances granted, or special conditions.',
    `penalty_description` STRING COMMENT 'Description of penalties or enforcement actions that may result from non-compliance (e.g., fines, consent orders, public notification requirements).',
    `public_notification_required` BOOLEAN COMMENT 'Indicates whether public notification is required in the event of non-compliance with this requirement.',
    `regulation_url` STRING COMMENT 'Web URL or hyperlink to the official regulatory text or guidance document.',
    `regulatory_citation` STRING COMMENT 'Full legal citation or reference to the regulation in the Code of Federal Regulations (CFR), state code, or local ordinance (e.g., 40 CFR 141.80).',
    `regulatory_program` STRING COMMENT 'The regulatory program or framework under which this requirement is issued. SDWA = Safe Drinking Water Act, CWA = Clean Water Act, NPDES = National Pollutant Discharge Elimination System, LCRR = Lead and Copper Rule Revisions, DBP = Disinfection Byproduct, SWTR = Surface Water Treatment Rule, GWR = Ground Water Rule, TCR = Total Coliform Rule, RTCR = Revised Total Coliform Rule. [ENUM-REF-CANDIDATE: SDWA|CWA|NPDES|LCRR|DBP|SWTR|GWR|TCR|RTCR|pretreatment|state_primacy|local_ordinance — 12 candidates stripped; promote to reference product]',
    `reporting_frequency` STRING COMMENT 'Required frequency of regulatory reporting (e.g., monthly, quarterly, annually). Null if not applicable.',
    `requirement_category` STRING COMMENT 'Classification of the type of regulatory obligation. MCL = Maximum Contaminant Level, MCLG = Maximum Contaminant Level Goal. [ENUM-REF-CANDIDATE: monitoring|reporting|operational_standard|MCL|MCLG|treatment_technique|permit_condition|discharge_limit — 8 candidates stripped; promote to reference product]',
    `requirement_code` STRING COMMENT 'Unique business identifier or citation code for the regulatory requirement (e.g., 40 CFR 141.80, LCRR-2021, NPDES-001).',
    `requirement_description` STRING COMMENT 'Detailed description of the regulatory requirement, including the specific obligation imposed on the utility (e.g., monitoring frequency, reporting format, operational standard).',
    `requirement_title` STRING COMMENT 'Official title or short name of the regulatory requirement (e.g., Lead and Copper Rule Revisions, Maximum Contaminant Level for Arsenic).',
    `responsible_department` STRING COMMENT 'Name of the internal department or business unit responsible for ensuring compliance with this requirement (e.g., Water Quality, Wastewater Operations, Environmental Compliance).',
    `revision_date` DATE COMMENT 'Date of the most recent revision or amendment to the regulatory requirement. Null if never revised.',
    `superseded_requirement_code` STRING COMMENT 'Citation or code of the previous regulatory requirement that this requirement supersedes or replaces. Null if not applicable.',
    `treatment_technique_description` STRING COMMENT 'Description of the required treatment technique or operational standard when an MCL is not feasible (e.g., filtration, disinfection contact time). Null if not applicable.',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Catalog of all applicable federal, state, and local regulatory requirements that the utility must comply with, including SDWA rules (LCRR, DBP rules, Surface Water Treatment Rule), CWA requirements, EPA MCLs/MCLGs, state primacy agency rules, NPDES general permits, and local pretreatment standards. Tracks the regulation citation, regulatory program, effective date, compliance deadline, applicable facility types, and the specific operational or reporting obligation imposed. Serves as the master compliance obligation registry.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` (
    `dmr_id` BIGINT COMMENT 'Unique identifier for the discharge monitoring report record.',
    `amended_dmr_id` BIGINT COMMENT 'Reference to the original discharge monitoring report record if this is a resubmission or correction.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this discharge monitoring report is filed.',
    `facility_id` BIGINT COMMENT 'Reference to the wastewater treatment plant or water treatment plant facility that generated this discharge monitoring report.',
    `regulatory_agency_id` BIGINT COMMENT 'The unique submission identifier assigned by the EPA NetDMR electronic reporting system when this discharge monitoring report was submitted electronically.',
    `acknowledgment_date` DATE COMMENT 'The date on which the regulatory authority acknowledged receipt of this discharge monitoring report.',
    `certification_date` DATE COMMENT 'The date on which the certifying official signed and certified this discharge monitoring report, attesting to its accuracy under penalty of law.',
    `certification_statement` STRING COMMENT 'The full text of the legal certification statement signed by the certifying official, typically stating that the report was prepared under their direction and supervision and that the information is true, accurate, and complete to the best of their knowledge.',
    `certifying_official_name` STRING COMMENT 'The full name of the authorized signatory who certified the accuracy and completeness of this discharge monitoring report (typically a principal executive officer or ranking elected official).',
    `certifying_official_title` STRING COMMENT 'The job title or position of the authorized signatory who certified this discharge monitoring report (e.g., General Manager, Mayor, Director of Public Works).',
    `comments` STRING COMMENT 'Additional comments, explanations, or notes provided by the facility regarding this discharge monitoring report, including explanations for exceedances, operational issues, or data quality concerns.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge monitoring report record was first created in the system.',
    `dmr_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this discharge monitoring report, often assigned by the regulatory authority or internal tracking system.',
    `exceedance_count` STRING COMMENT 'The total number of individual parameter measurements within this discharge monitoring report that exceeded their respective permit limits.',
    `late_submission_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report was submitted after the regulatory deadline (True if late, False if on time).',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this discharge monitoring report record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this discharge monitoring report record was last modified or updated.',
    `monitoring_location_code` STRING COMMENT 'The alphanumeric code identifying the specific monitoring location or sampling point as designated in the NPDES permit (e.g., 001, 002, EFF-1).',
    `no_discharge_flag` BOOLEAN COMMENT 'Indicates whether there was no discharge from the outfall during the reporting period (True if no discharge occurred, False if discharge occurred).',
    `no_discharge_reason` STRING COMMENT 'Explanation for why no discharge occurred during the reporting period (e.g., facility shutdown, seasonal operations, maintenance outage).',
    `noncompliance_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report contains any parameter measurements that exceeded permitted limits, triggering a noncompliance event (True if noncompliance detected, False if all parameters within limits).',
    `preparer_email` STRING COMMENT 'The email address of the individual who prepared this discharge monitoring report.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preparer_name` STRING COMMENT 'The full name of the individual who prepared and compiled this discharge monitoring report.',
    `preparer_phone` STRING COMMENT 'The contact phone number for the individual who prepared this discharge monitoring report.',
    `preparer_title` STRING COMMENT 'The job title or position of the individual who prepared this discharge monitoring report (e.g., Environmental Compliance Manager, Laboratory Supervisor).',
    `regulatory_authority` STRING COMMENT 'The regulatory body to which this discharge monitoring report was submitted (EPA for direct federal permits or state primacy agency for delegated state programs).. Valid values are `epa|state_primacy_agency`',
    `rejection_reason` STRING COMMENT 'Explanation provided by the regulatory authority if this discharge monitoring report was rejected, including specific deficiencies or errors that must be corrected.',
    `reporting_frequency` STRING COMMENT 'The frequency at which this discharge monitoring report must be submitted as specified in the NPDES permit (monthly, quarterly, annual, semi-annual, or weekly).. Valid values are `monthly|quarterly|annual|semi-annual|weekly`',
    `reporting_period_end_date` DATE COMMENT 'The last day of the monitoring period covered by this discharge monitoring report (typically the last day of the month or quarter).',
    `reporting_period_start_date` DATE COMMENT 'The first day of the monitoring period covered by this discharge monitoring report (typically the first day of the month or quarter).',
    `resubmission_flag` BOOLEAN COMMENT 'Indicates whether this discharge monitoring report is a resubmission of a previously rejected or corrected report (True if resubmission, False if original submission).',
    `state_agency_name` STRING COMMENT 'The name of the state environmental or water quality agency that received this discharge monitoring report if submitted under a state-delegated NPDES program.',
    `submission_date` DATE COMMENT 'The date on which this discharge monitoring report was submitted to the EPA or state NPDES authority.',
    `submission_due_date` DATE COMMENT 'The regulatory deadline by which this discharge monitoring report must be submitted (typically the 28th day of the month following the reporting period).',
    `submission_method` STRING COMMENT 'The method by which this discharge monitoring report was submitted to the regulatory authority (NetDMR electronic system, paper mail, email, state-specific portal, or other).. Valid values are `netdmr|paper|email|state_portal|other`',
    `submission_status` STRING COMMENT 'The current status of this discharge monitoring report in the submission and review workflow (draft, submitted, accepted by authority, rejected, under review, or resubmitted after corrections).. Valid values are `draft|submitted|accepted|rejected|under_review|resubmitted`',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this discharge monitoring report record.',
    CONSTRAINT pk_dmr PRIMARY KEY(`dmr_id`)
) COMMENT 'Discharge Monitoring Report (DMR) submitted to the EPA or state NPDES authority documenting actual effluent quality measurements against permitted limits for a specific reporting period. Tracks the permit number, outfall or monitoring point, reporting period (monthly, quarterly), parameter results (BOD, TSS, pH, flow in MGD), exceedance flags, submission date, submission method (NetDMR, paper), preparer, and certifying official. Core regulatory reporting artifact for WWTP and WTP discharge compliance under CWA/NPDES.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`mor` (
    `mor_id` BIGINT COMMENT 'Unique identifier for the Monthly Operating Report record.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: A Monthly Operating Report (MOR) is submitted under a specific operating permit issued by the state primacy agency. The compliance_permit table is the master record for all regulatory operating permit',
    `finished_water_production_id` BIGINT COMMENT 'Foreign key linking to treatment.finished_water_production. Business justification: MOR (Monthly Operating Report) summarizes finished water production data including total_water_produced_mgd, turbidity, CT values — all sourced from finished_water_production records. Regulators and o',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: The Monthly Operating Report (MOR) is a recurring regulatory submission to the state primacy agency. The mor table tracks submission_date and submission_method, which are submission metadata that belo',
    `facility_id` BIGINT COMMENT 'Identifier of the water treatment plant facility for which this MOR is submitted.',
    `agency_response_date` DATE COMMENT 'Date on which the state primacy agency responded to or acknowledged the submitted MOR.',
    `agency_response_received` BOOLEAN COMMENT 'Indicates whether a response or acknowledgment was received from the state primacy agency after submission.',
    `alkalinity_avg_mg_l` DECIMAL(18,2) COMMENT 'Average alkalinity of finished water during the reporting month.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow rate of treated water produced during the reporting month.',
    `certification_date` DATE COMMENT 'The date on which the certified operator signed and certified the MOR.',
    `certification_status` STRING COMMENT 'Current status of the MOR in the certification and submission workflow.. Valid values are `draft|certified|submitted|accepted|rejected|under_review`',
    `certifier_license_number` STRING COMMENT 'State-issued water treatment operator license number of the certifying operator.',
    `certifier_name` STRING COMMENT 'Full name of the certified operator who reviewed and certified the accuracy of the MOR.',
    `coagulant_dosage_avg_mg_l` DECIMAL(18,2) COMMENT 'Average coagulant dosage applied during the reporting month.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOR record was first created in the system.',
    `ct_compliance_status` STRING COMMENT 'Indicates whether the achieved CT value met or exceeded the required CT value for the reporting month.. Valid values are `compliant|non_compliant`',
    `ct_value_achieved` DECIMAL(18,2) COMMENT 'Calculated CT value (disinfectant concentration multiplied by contact time) achieved for pathogen inactivation during the reporting month.',
    `ct_value_required` DECIMAL(18,2) COMMENT 'Regulatory CT value required for adequate pathogen inactivation based on water temperature and pH.',
    `disinfectant_residual_avg_mg_l` DECIMAL(18,2) COMMENT 'Average disinfectant residual concentration in the distribution system during the reporting month.',
    `disinfectant_residual_min_mg_l` DECIMAL(18,2) COMMENT 'Minimum disinfectant residual concentration recorded in the distribution system during the reporting month.',
    `disinfectant_type` STRING COMMENT 'Primary disinfection method used at the treatment plant during the reporting month.. Valid values are `chlorine|chloramine|chlorine_dioxide|ozone|uv`',
    `finished_water_turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Average turbidity of finished treated water leaving the plant during the reporting month.',
    `finished_water_turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Maximum turbidity of finished treated water recorded during the reporting month.',
    `fluoride_avg_mg_l` DECIMAL(18,2) COMMENT 'Average fluoride concentration in finished water during the reporting month.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOR record was last modified.',
    `operational_events_count` STRING COMMENT 'Number of significant operational events (equipment failures, process upsets, maintenance shutdowns) recorded during the reporting month.',
    `operational_events_description` STRING COMMENT 'Narrative description of significant operational events that occurred during the reporting month.',
    `peak_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Maximum daily flow rate of treated water produced during the reporting month.',
    `ph_avg` DECIMAL(18,2) COMMENT 'Average pH level of finished water during the reporting month.',
    `preparer_license_number` STRING COMMENT 'State-issued water treatment operator license number of the preparer.',
    `preparer_title` STRING COMMENT 'Job title or role of the individual who prepared the MOR.',
    `raw_water_turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Average turbidity of raw source water entering the treatment plant during the reporting month.',
    `raw_water_turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Maximum turbidity of raw source water recorded during the reporting month.',
    `report_number` STRING COMMENT 'Externally-known unique report number assigned by the state primacy agency or internal tracking system.',
    `reporting_month` DATE COMMENT 'The calendar month for which this MOR documents water treatment plant operations.',
    `reporting_year` STRING COMMENT 'The calendar year for which this MOR is submitted.',
    `source_water_type` STRING COMMENT 'Primary type of source water used by the treatment plant during the reporting month.. Valid values are `surface|groundwater|purchased|blended`',
    `total_water_produced_mgd` DECIMAL(18,2) COMMENT 'Total volume of treated water produced by the WTP during the reporting month, measured in million gallons per day.',
    `turbidity_compliance_status` STRING COMMENT 'Indicates whether turbidity levels met regulatory Maximum Contaminant Level (MCL) requirements during the reporting month.. Valid values are `compliant|non_compliant|exceedance`',
    `violations_count` STRING COMMENT 'Number of regulatory violations (MCL exceedances, monitoring failures, reporting failures) recorded during the reporting month.',
    `violations_description` STRING COMMENT 'Narrative description of regulatory violations that occurred during the reporting month.',
    CONSTRAINT pk_mor PRIMARY KEY(`mor_id`)
) COMMENT 'Monthly Operating Report (MOR) submitted to the state primacy agency documenting drinking water treatment plant operations, including treatment process performance, chemical dosing, CT (Contact Time for Disinfection) calculations, turbidity (NTU) compliance, disinfection residuals, source water quality, and operational events. Tracks the WTP facility, reporting month, preparer, submission date, certification status, and key operational parameters required by the state drinking water program under SDWA.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`violation` (
    `violation_id` BIGINT COMMENT 'Unique identifier for the compliance_violation data product (auto-inserted pre-linking).',
    `accuracy_test_id` BIGINT COMMENT 'Foreign key linking to metering.accuracy_test. Business justification: Meter accuracy test failures directly constitute compliance violations under state PUC metering accuracy regulations. Linking compliance_violation to the triggering accuracy_test provides regulatory e',
    `compliance_permit_id` BIGINT COMMENT 'add column compliance_permit_id (BIGINT) with FK to compliance.compliance_permit.compliance_permit_id - violations occur under specific permits and this direct link is essential for compliance tracking',
    `facility_id` BIGINT COMMENT 'add column facility_id (BIGINT) with FK to treatment.facility.facility_id - violations occur at specific facilities',
    `mor_id` BIGINT COMMENT 'Foreign key linking to compliance.mor. Business justification: A compliance violation in the drinking water context is frequently identified through a Monthly Operating Report (MOR) submission (mor.violations_count, mor.violations_description confirm this). Linki',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Violations are triggered by specific test results exceeding regulatory limits. Direct link provides enforcement traceability, enables automated violation detection, and supports legal defensibility by',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspections frequently identify compliance violations (regulatory_inspection.violation_identified_flag = true, regulatory_inspection.findings_summary). Linking compliance_violation to the r',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: A compliance_violation is a formal record of a regulatory violation — it must reference which specific regulatory_requirement was violated. This is a fundamental compliance domain relationship: violat',
    CONSTRAINT pk_violation PRIMARY KEY(`violation_id`)
) COMMENT 'Formal record of a regulatory violation identified at a utility facility or in a regulatory submission, including MCL exceedances, permit limit violations, monitoring and reporting violations (MRVs), treatment technique violations, and public notification failures. Tracks violation type, regulatory citation, affected facility, detection date, parameter and measured value, applicable limit, violation severity, notification requirements triggered, and current resolution status. Central record for all compliance failures requiring regulatory response.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Unique identifier for the enforcement action record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Enforcement actions in water utilities can directly target a service agreement — e.g., mandatory service termination or restriction for industrial user permit non-compliance or backflow violations. Co',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the permit under which the violation and enforcement action occurred (NPDES permit, drinking water permit, IUP, etc.).',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility subject to the enforcement action.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Every enforcement action is initiated by a specific regulatory agency. enforcement_action has issuing_agency (STRING) and issuing_agency_region (STRING) which are denormalized text references to the a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Enforcement actions (consent decrees, administrative orders) mandate capital projects with specific completion deadlines. Tracking this link is essential for compliance schedule management, regulatory',
    `violation_id` BIGINT COMMENT 'Reference to the primary violation record that triggered this enforcement action. Links to the violation tracking system.',
    `action_number` STRING COMMENT 'Official enforcement action number or case number assigned by the regulatory agency (EPA, state primacy agency, NPDES authority). This is the externally-known identifier used in all regulatory correspondence and legal documents.',
    `action_status` STRING COMMENT 'Current lifecycle status of the enforcement action. Tracks progression from issuance through utility response, negotiation, and final resolution.. Valid values are `issued|under_review|response_submitted|in_negotiation|resolved|closed`',
    `action_summary` STRING COMMENT 'Brief summary of the enforcement action, including the nature of the violation, regulatory basis, and key requirements. Provides context for reporting and management review.',
    `action_type` STRING COMMENT 'Type of formal enforcement action initiated by the regulatory agency. Includes Notice of Violation (NOV), Administrative Order (AO), Consent Order, Compliance Schedule, civil penalty assessment, or criminal referral.. Valid values are `notice_of_violation|administrative_order|consent_order|compliance_schedule|civil_penalty|criminal_referral`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the utility filed a formal appeal or contested the enforcement action through administrative or judicial proceedings.',
    `appeal_filing_date` DATE COMMENT 'Date the utility filed its appeal or petition for review. Null if no appeal was filed.',
    `board_notification_date` DATE COMMENT 'Date the utilitys Board of Directors or governing body was notified of the enforcement action. Tracks governance and executive oversight requirements.',
    `civil_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by the regulatory agency in U.S. dollars. Null if no civil penalty was imposed.',
    `compliance_schedule_final_deadline` DATE COMMENT 'Final deadline by which all corrective actions and compliance milestones must be completed. Null if no compliance schedule is required.',
    `compliance_schedule_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a formal compliance schedule with milestones and deadlines for corrective actions.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective actions required by the enforcement action. May include operational changes, infrastructure upgrades, process improvements, or enhanced monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was first created in the system. Audit trail for data lineage.',
    `document_reference_number` STRING COMMENT 'Internal document management system reference number for the enforcement action file. Links to stored correspondence, legal documents, and supporting materials.',
    `issue_date` DATE COMMENT 'Date the enforcement action was officially issued or signed by the regulatory agency. This is the principal business event timestamp for the enforcement action lifecycle.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was last updated. Audit trail for change tracking.',
    `legal_counsel_assigned` STRING COMMENT 'Name of the internal or external legal counsel assigned to manage the utilitys response to the enforcement action. Business-confidential information.',
    `legal_firm_name` STRING COMMENT 'Name of the external law firm representing the utility, if external counsel is engaged. Null if handled internally.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this enforcement action record. Audit trail for accountability.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, internal discussions, negotiation history, or other relevant information not captured in structured fields.',
    `penalty_paid_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the utility toward the civil penalty. May differ from assessed amount due to negotiated settlements or payment plans.',
    `penalty_payment_date` DATE COMMENT 'Date the civil penalty payment was made to the regulatory agency. Tracks compliance with payment deadlines.',
    `public_notice_date` DATE COMMENT 'Date public notice of the enforcement action was issued. Null if public notice is not required.',
    `public_notice_required_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action requires public notification under regulatory or consent order terms. Drives public communication and transparency obligations.',
    `received_date` DATE COMMENT 'Date the utility officially received the enforcement action notice. Used to calculate response deadlines and compliance timelines.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory statute, rule, or permit condition cited in the enforcement action (e.g., Clean Water Act Section 301, 40 CFR 122.41, NPDES Permit Condition III.A.1). Identifies the legal basis for the enforcement.',
    `resolution_date` DATE COMMENT 'Date the enforcement action was formally resolved or closed. Indicates completion of all required corrective actions, penalty payments, and regulatory obligations.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the enforcement action. Indicates how the action was resolved (compliance achieved, consent order executed, penalty paid, dismissed, or under appeal).. Valid values are `compliance_achieved|consent_order_executed|penalty_paid|dismissed|under_appeal`',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response to the enforcement action. Typically specified in the enforcement notice or calculated based on regulatory timelines.',
    `response_submitted_date` DATE COMMENT 'Date the utility submitted its formal response to the enforcement action. Tracks compliance with response deadlines.',
    `sep_description` STRING COMMENT 'Description of the Supplemental Environmental Project (SEP) agreed to as part of the enforcement settlement. Null if no SEP is included.',
    `sep_estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the Supplemental Environmental Project (SEP) in U.S. dollars. Used to calculate penalty offsets and track SEP investment.',
    `supplemental_environmental_project_flag` BOOLEAN COMMENT 'Indicates whether the enforcement action includes a Supplemental Environmental Project (SEP) as part of the settlement. SEPs are environmentally beneficial projects that go beyond compliance requirements and may offset civil penalties.',
    CONSTRAINT pk_enforcement_action PRIMARY KEY(`enforcement_action_id`)
) COMMENT 'Formal enforcement action initiated by a regulatory agency (EPA, state primacy agency, NPDES authority) against the utility in response to violations, including Notices of Violation (NOVs), Administrative Orders (AOs), Consent Orders, Compliance Schedules, civil penalties, and criminal referrals. Tracks the issuing agency, action type, associated violations, compliance schedule milestones, penalty amounts, response deadlines, legal counsel assigned, and resolution outcome. Drives the utilitys formal regulatory response process.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` (
    `regulatory_inspection_id` BIGINT COMMENT 'Unique identifier for the regulatory inspection record. Primary key.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the permit under which the inspection was conducted (NPDES, IUP, state primacy permit).',
    `facility_id` BIGINT COMMENT 'Identifier of the water or wastewater facility that was inspected (WTP, WWTP, pumping station, etc.).',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Every regulatory inspection is conducted by a specific regulatory agency (EPA, state primacy agency, NPDES authority). regulatory_inspection has an inspecting_agency STRING column that is a denormaliz',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: Regulatory agencies conduct collection system inspections targeting specific sewer network segments for I/I compliance, SSO investigations, and capacity assessments. Linking regulatory_inspection to s',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Regulatory inspections during construction verify permit compliance and design standards adherence. Inspectors reference the project for context, and inspection findings may require project scope modi',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all required corrective actions must be completed and verified.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required by the utility in response to inspection findings.',
    `corrective_action_summary` STRING COMMENT 'Summary of the corrective actions required to address deficiencies and achieve compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the compliance management system.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies or non-compliance items identified during the inspection.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether formal enforcement action (administrative order, consent decree, penalty) was initiated as a result of this inspection.',
    `findings_summary` STRING COMMENT 'High-level summary of the inspection findings, deficiencies identified, and overall compliance status.',
    `follow_up_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up inspection by the regulatory agency is required to verify corrective action completion.',
    `follow_up_inspection_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up inspection if required.',
    `inspection_date` DATE COMMENT 'Date on which the regulatory inspection was conducted at the facility.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity concluded.',
    `inspection_notes` STRING COMMENT 'Internal notes and observations recorded by utility staff during or after the inspection for follow-up and documentation purposes.',
    `inspection_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned by the regulatory agency for this inspection.',
    `inspection_report_received_date` DATE COMMENT 'Date on which the utility received the official inspection report from the regulatory agency.',
    `inspection_report_status` STRING COMMENT 'Current status of the official inspection report (draft, final, under review, accepted, disputed).. Valid values are `draft|final|under_review|accepted|disputed`',
    `inspection_scope` STRING COMMENT 'Description of the areas, processes, or systems covered during the inspection (e.g., treatment processes, discharge monitoring, pretreatment program, laboratory practices).',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the on-site inspection activity began.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection (scheduled, in progress, completed, report pending, closed, cancelled).. Valid values are `scheduled|in_progress|completed|report_pending|closed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection, routine inspection, follow-up inspection, complaint investigation). [ENUM-REF-CANDIDATE: sanitary_survey|compliance_inspection|pretreatment_audit|npdes_inspection|routine_inspection|follow_up_inspection|complaint_investigation — 7 candidates stripped; promote to reference product]',
    `inspector_contact_email` STRING COMMENT 'Email address of the lead inspector for official correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `inspector_contact_phone` STRING COMMENT 'Phone number of the lead inspector for follow-up communication.',
    `inspector_name` STRING COMMENT 'Full name of the lead inspector or compliance officer who conducted the inspection.',
    `inspector_title` STRING COMMENT 'Job title or role of the lead inspector (e.g., Environmental Compliance Officer, Sanitary Survey Specialist).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated or modified.',
    `response_due_date` DATE COMMENT 'Deadline by which the utility must submit a formal response or corrective action plan to the regulatory agency.',
    `significant_deficiency_classification` STRING COMMENT 'Classification or category of the significant deficiency if identified (e.g., treatment process failure, monitoring inadequacy, operational deficiency).',
    `significant_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any significant deficiencies (as defined by SDWA) were identified that could affect water quality or public health.',
    `utility_representative_title` STRING COMMENT 'Job title of the utility representative who coordinated the inspection (e.g., Compliance Manager, Plant Superintendent).',
    `violation_identified_flag` BOOLEAN COMMENT 'Indicates whether any regulatory violations (SDWA, CWA, NPDES permit) were formally identified during the inspection.',
    CONSTRAINT pk_regulatory_inspection PRIMARY KEY(`regulatory_inspection_id`)
) COMMENT 'Record of regulatory inspections and audits conducted by EPA, state primacy agencies, or other regulatory bodies at utility facilities. Tracks the inspection type (sanitary survey, compliance inspection, pretreatment audit, NPDES inspection), inspecting agency, facility inspected, inspection date, inspector name, findings and deficiencies identified, significant deficiency classifications, required corrective actions, response deadlines, and final inspection report status. Drives post-inspection corrective action tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Unique identifier for the corrective action record. Primary key.',
    `enforcement_action_id` BIGINT COMMENT 'Reference to the enforcement action that mandated this corrective action, if applicable.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Corrective actions mandated for cross-connection control, backflow device installation, or service point compliance deficiencies must be tied to the specific service point. This enables point-level co',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Corrective actions mandated by regulators target specific process units (e.g., repair a dosing pump, replace filter media). Compliance managers need to link corrective actions to the process unit bein',
    `registry_id` BIGINT COMMENT 'Reference to the inspection finding that identified the compliance gap requiring corrective action.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Corrective actions respond to treatment violations requiring resolution. Business process: violation resolution workflows where compliance-tracked corrective actions (equipment repairs, process adjust',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspections with corrective_action_required_flag = true generate corrective action plans. compliance_corrective_action has triggering_event_type which can be inspection, but no direct FK ',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: Corrective actions can be triggered by SSO/CSO overflow events. The overflow_event table has text fields for corrective_action_taken and preventive_action_planned, but no structured link to the correc',
    `sso_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.sso_event. Business justification: SSO events are a primary trigger for compliance corrective actions under NPDES and state regulations. triggering_event_type and triggering_event_description are denormalized; a direct FK to sso_event ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Regulatory violations trigger capital improvement projects (consent decree requiring new treatment capacity, enforcement action mandating infrastructure upgrades). Corrective actions reference the imp',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: A compliance_corrective_action is initiated in response to a regulatory violation. While compliance_corrective_action already has enforcement_action_id (linking to enforcement actions), corrective act',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Corrective action contracts create encumbrances against budgets when purchase orders or contracts are issued. Standard governmental accounting practice for commitment tracking.',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Corrective actions are frequently directed at specific WWTPs following NPDES violations, DMR exceedances, or regulatory inspections. compliance_corrective_action already links to sewer_network; a para',
    `action_description` STRING COMMENT 'Detailed description of the corrective action to be taken, including specific tasks, procedures, and deliverables required to address the compliance gap.',
    `action_number` STRING COMMENT 'Business identifier for the corrective action, typically formatted as a human-readable reference number for tracking and reporting.',
    `action_status` STRING COMMENT 'Current lifecycle status of the corrective action, tracking progress from planning through completion and verification.. Valid values are `planned|in_progress|pending_verification|completed|overdue|cancelled`',
    `action_title` STRING COMMENT 'Brief descriptive title summarizing the corrective action for quick identification and reporting.',
    `actual_completion_date` DATE COMMENT 'Actual date when the corrective action was fully implemented and completed, used to track compliance with regulatory deadlines.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to implement the corrective action, tracked for budget management and regulatory reporting.',
    `actual_start_date` DATE COMMENT 'Actual date when implementation of the corrective action commenced.',
    `agency_notification_date` DATE COMMENT 'Date when the regulatory agency was formally notified of the corrective action plan or completion, fulfilling reporting requirements.',
    `agency_notification_method` STRING COMMENT 'Method used to notify the regulatory agency of the corrective action, such as formal letter, email, portal submission, phone, or in-person meeting.. Valid values are `formal_letter|email|portal_submission|phone|in_person_meeting`',
    `agency_response` STRING COMMENT 'Summary of the regulatory agencys response to the corrective action notification, including any feedback, approval, or additional requirements.',
    `closure_notes` STRING COMMENT 'Final notes documenting the closure of the corrective action, including lessons learned and recommendations for future compliance management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was first created in the system, establishing the audit trail.',
    `effectiveness_review_date` DATE COMMENT 'Scheduled date for follow-up review to assess the long-term effectiveness of the corrective action and any preventive measures.',
    `effectiveness_review_outcome` STRING COMMENT 'Summary of the effectiveness review findings, documenting whether the corrective action achieved sustained compliance improvement.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the corrective action, including labor, materials, equipment, and any third-party services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the corrective action record was last updated, supporting audit trail and change tracking requirements.',
    `planned_completion_date` DATE COMMENT 'Target date by which the corrective action must be fully implemented and completed, often driven by regulatory deadlines or consent decree requirements.',
    `planned_start_date` DATE COMMENT 'Scheduled date when implementation of the corrective action is planned to begin.',
    `preventive_action_description` STRING COMMENT 'Description of preventive measures implemented to address systemic issues and prevent future occurrences of similar compliance gaps.',
    `preventive_action_implemented` BOOLEAN COMMENT 'Indicates whether preventive actions were implemented to prevent recurrence of the compliance gap or violation.',
    `priority_level` STRING COMMENT 'Priority classification indicating the urgency and importance of the corrective action based on risk, regulatory requirements, and potential impact.. Valid values are `critical|high|medium|low`',
    `regulatory_agency_notified` BOOLEAN COMMENT 'Indicates whether the relevant regulatory agency (EPA, state primacy agency, etc.) was notified of the corrective action as required by enforcement orders or consent decrees.',
    `responsible_department` STRING COMMENT 'Name of the department or organizational unit responsible for implementing and completing the corrective action.',
    `responsible_individual` STRING COMMENT 'Name of the individual assigned accountability for ensuring the corrective action is completed on time and meets all requirements.',
    `root_cause_analysis` STRING COMMENT 'Documented analysis identifying the underlying root cause(s) of the compliance gap or violation, supporting effective corrective action design.',
    `supporting_evidence_location` STRING COMMENT 'File path, document management system reference, or physical location where supporting evidence and documentation for the corrective action is stored for audit trail purposes.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective through the specified verification method.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was implemented effectively and achieved the intended compliance outcome, such as internal audit, third-party audit, regulatory inspection, documentation review, testing, or monitoring.. Valid values are `internal_audit|third_party_audit|regulatory_inspection|documentation_review|testing|monitoring`',
    `verification_notes` STRING COMMENT 'Detailed notes documenting the verification process, findings, and any additional observations regarding the effectiveness of the corrective action.',
    `verification_status` STRING COMMENT 'Status of the verification process indicating whether the corrective action has been confirmed as effective in addressing the compliance gap.. Valid values are `pending|verified_effective|verified_ineffective|requires_additional_action`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Formal corrective action plan or individual corrective action item initiated in response to a regulatory violation, enforcement action, inspection finding (including sanitary survey significant deficiencies), or internal compliance gap. Tracks the triggering event type and reference, corrective action description, priority classification, responsible department and individual, planned and actual completion dates, interim milestones, verification method, supporting evidence documentation, cost estimate, regulatory agency notification requirements, and closure approval. Provides the auditable trail demonstrating the utilitys good-faith compliance response and is the primary artifact reviewed during follow-up inspections.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` (
    `regulatory_agency_id` BIGINT COMMENT 'Unique identifier for the regulatory agency record. Primary key.',
    `parent_regulatory_agency_regulatory_agency_id` BIGINT COMMENT 'Reference to the parent or umbrella agency if this agency is a regional office, division, or sub-agency (e.g., EPA Region 5 parent is EPA). Null if this is a top-level agency.',
    `primary_parent_regulatory_agency_id` BIGINT COMMENT 'Self-referencing FK on regulatory_agency (parent_regulatory_agency_id)',
    `address_line1` STRING COMMENT 'Primary street address line for the regulatory agency headquarters or regional office.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `address_line_1` STRING COMMENT 'First line of the agencys physical mailing address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the agencys physical mailing address (suite, floor, building, etc.). Nullable.',
    `agency_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the regulatory agency within the utilitys systems (e.g., EPA_R5, STATE_DNR, PUC_WI).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `agency_main_email` STRING COMMENT 'General inquiry or main email address for the regulatory agency.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_main_phone` STRING COMMENT 'Main switchboard or general inquiry phone number for the regulatory agency.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `agency_name` STRING COMMENT 'Full legal name of the regulatory agency or governing body (e.g., U.S. Environmental Protection Agency Region 5, Wisconsin Department of Natural Resources).',
    `agency_short_name` STRING COMMENT 'Abbreviated or commonly used name for the agency (e.g., EPA Region 5, WI DNR, OSHA).',
    `agency_status` STRING COMMENT 'Current operational status of the regulatory agency (active, inactive, merged, dissolved).. Valid values are `active|inactive|merged|dissolved`',
    `agency_type` STRING COMMENT 'Classification of the regulatory agency by its primary regulatory focus (environmental, health, safety, rate regulatory, labor, quality standards, other). [ENUM-REF-CANDIDATE: environmental|health|safety|rate_regulatory|labor|quality_standards|other — 7 candidates stripped; promote to reference product]',
    `agency_website_url` STRING COMMENT 'Official website URL for the regulatory agency.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `business_hours` STRING COMMENT 'Standard business hours of operation for the regulatory agency office (e.g., Monday-Friday 8:00 AM - 5:00 PM PST).',
    `city` STRING COMMENT 'City name for the agencys physical mailing address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the agencys physical mailing address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility became effective.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency contact phone number for reporting spills, violations, or urgent compliance matters.',
    `enforcement_authority_level` STRING COMMENT 'Level of enforcement authority this agency holds over the utility (primary, delegated, advisory, none). Primary indicates direct enforcement power; delegated indicates authority granted by a higher-level agency; advisory indicates no direct enforcement.. Valid values are `primary|delegated|advisory|none`',
    `fax_number` STRING COMMENT 'Fax number for document submission to the regulatory agency, if applicable.',
    `inspection_frequency_months` STRING COMMENT 'Typical frequency in months at which this regulatory agency conducts inspections of utility facilities under its jurisdiction.',
    `inspection_frequency_typical` STRING COMMENT 'Typical frequency at which this agency conducts inspections or audits of utility facilities (annual, biennial, triennial, as-needed, risk-based).. Valid values are `annual|biennial|triennial|as_needed|risk_based`',
    `jurisdiction` STRING COMMENT 'Geographic or administrative jurisdiction of the regulatory agency (e.g., United States, California, Los Angeles County).',
    `jurisdiction_geographic_area` STRING COMMENT 'Geographic area or service territory over which the agency has regulatory authority (e.g., EPA Region 5 covers IL, IN, MI, MN, OH, WI; or specific county/municipality names).',
    `jurisdiction_level` STRING COMMENT 'The governmental level at which the agency operates (federal, state, regional, local, international).. Valid values are `federal|state|regional|local|international`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection conducted by this regulatory agency at any utility facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory agency record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the regulatory agency relationship.',
    `notification_deadline_hours` STRING COMMENT 'Standard number of hours within which the utility must notify this agency of reportable incidents or violations (e.g., 24 hours for SSO events).',
    `npdes_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to issue and enforce NPDES permits under the Clean Water Act. True if authorized, False otherwise.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agencys physical mailing address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pretreatment_authority_flag` BOOLEAN COMMENT 'Indicates whether this agency has authority to oversee industrial pretreatment programs. True if authorized, False otherwise.',
    `primacy_agency_flag` BOOLEAN COMMENT 'Indicates whether this agency has primacy authority for Safe Drinking Water Act (SDWA) enforcement in its jurisdiction. True if primacy agency, False otherwise.',
    `primacy_status` STRING COMMENT 'Indicates whether this agency is a primacy agency under the Safe Drinking Water Act (SDWA) or Clean Water Act (CWA), meaning it has been delegated primary enforcement authority by EPA (primacy_agency, non_primacy, not_applicable).. Valid values are `primacy_agency|non_primacy|not_applicable`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the agency contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the agency for utility compliance matters.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact.. Valid values are `^+?[0-9s-()]{10,20}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the agency.',
    `primary_regulatory_program` STRING COMMENT 'The main regulatory program or statute administered by this agency relevant to water utilities (e.g., SDWA, CWA, NPDES, OSHA, Rate Regulation).',
    `region_code` STRING COMMENT 'Regional designation or code if the agency operates within a specific region (e.g., EPA Region 9, Water Board Region 4).',
    `regulatory_program` STRING COMMENT 'Primary regulatory program or framework administered by the agency (e.g., NPDES, SDWA Primacy, Pretreatment, Lead and Copper Rule).',
    `reporting_frequency_default` STRING COMMENT 'Default or most common reporting frequency required by this agency for compliance reports (monthly, quarterly, semi-annual, annual, event-driven, as-required).. Valid values are `monthly|quarterly|semi_annual|annual|event_driven|as_required`',
    `reporting_system_name` STRING COMMENT 'Name of the electronic reporting system used by the agency (e.g., NetDMR, SDWIS, state-specific portal).',
    `state` STRING COMMENT 'Two-letter state or province code where the regulatory agency office is located.. Valid values are `^[A-Z]{2}$`',
    `state_province` STRING COMMENT 'Two-letter state or province code for the agencys physical mailing address (e.g., WI, IL, CA).. Valid values are `^[A-Z]{2}$`',
    `submission_credentials_reference` STRING COMMENT 'Reference identifier or location for stored login credentials or API keys used to access the agencys submission portal. Should reference a secure credential vault, not store actual credentials.',
    `submission_portal_name` STRING COMMENT 'Name of the online submission portal or system (e.g., NetDMR, State Environmental Portal, OSHA Injury Tracking Application).',
    `submission_portal_url` STRING COMMENT 'URL for the online portal or system used to submit compliance reports, permits, or other regulatory documents to this agency (e.g., NetDMR, state e-reporting system).. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `termination_date` DATE COMMENT 'Date when this agencys jurisdiction or regulatory authority over the utility ended or will end. Null if still active.',
    `website_url` STRING COMMENT 'Official website URL for the regulatory agency.',
    CONSTRAINT pk_regulatory_agency PRIMARY KEY(`regulatory_agency_id`)
) COMMENT 'Master reference table for regulatory_agency. Referenced by: compliance.regulatory_submission.regulatory_agency_id, treatment.mor_submission.regulatory_agency_id, treatment.treatment_permit.regulatory_agency_id, treatment.treatment_violation.regulatory_agency_id';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_amended_dmr_id` FOREIGN KEY (`amended_dmr_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_mor_id` FOREIGN KEY (`mor_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`mor`(`mor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_parent_regulatory_agency_regulatory_agency_id` FOREIGN KEY (`parent_regulatory_agency_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_primary_parent_regulatory_agency_id` FOREIGN KEY (`primary_parent_regulatory_agency_id`) REFERENCES `vibe_water_utilities_v1`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`compliance_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Required Position Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_facility_type` SET TAGS ('dbx_value_regex' = 'WTP|WWTP|STP|distribution_system|collection_system|all_facilities');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicable_system_size` SET TAGS ('dbx_business_glossary_term' = 'Applicable System Size');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|not_applicable|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Value');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulation_url` SET TAGS ('dbx_business_glossary_term' = 'Regulation URL');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `amended_dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Original Discharge Monitoring Report (DMR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'NetDMR Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Certification Statement');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `certifying_official_title` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `dmr_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `exceedance_count` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Count');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Preparer Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'epa|state_primacy_agency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|semi-annual|weekly');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `resubmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_business_glossary_term' = 'State Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `state_agency_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'netdmr|paper|email|state_portal|other');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|under_review|resubmitted');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`dmr` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `mor_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Operating Report (MOR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `agency_response_received` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Received');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `alkalinity_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Alkalinity Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'draft|certified|submitted|accepted|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_license_number` SET TAGS ('dbx_business_glossary_term' = 'Certifier License Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_license_number` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_business_glossary_term' = 'Certifier Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `certifier_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `coagulant_dosage_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Coagulant Dosage Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_value_achieved` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Value Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ct_value_required` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Value Required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_residual_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Residual Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_residual_min_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Residual Minimum Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_value_regex' = 'chlorine|chloramine|chlorine_dioxide|ozone|uv');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `finished_water_turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Turbidity Average Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `finished_water_turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Turbidity Maximum Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `fluoride_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Fluoride Average Milligrams per Liter (mg/L)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `operational_events_count` SET TAGS ('dbx_business_glossary_term' = 'Operational Events Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `operational_events_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Events Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `peak_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `ph_avg` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Average');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Preparer License Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_license_number` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `preparer_title` SET TAGS ('dbx_business_glossary_term' = 'Preparer Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `raw_water_turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Raw Water Turbidity Average Nephelometric Turbidity Units (NTU)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`mor` ALTER COLUMN `raw_water_turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Raw Water Turbidity Maximum Nephelometric Turbidity Units (NTU)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_violation');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `accuracy_test_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Test Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `mor_id` SET TAGS ('dbx_business_glossary_term' = 'Mor Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`violation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Legal Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`enforcement_action` ALTER COLUMN `legal_firm_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `follow_up_inspection_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Inspection Scheduled Date');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Inspector Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `inspector_title` SET TAGS ('dbx_business_glossary_term' = 'Inspector Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Classification');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `significant_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `utility_representative_title` SET TAGS ('dbx_business_glossary_term' = 'Utility Representative Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_inspection` ALTER COLUMN `violation_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Identified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` SET TAGS ('dbx_subdomain' = 'enforcement_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Finding ID');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sso Event Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|pending_verification|completed|overdue|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `agency_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `agency_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `agency_notification_method` SET TAGS ('dbx_value_regex' = 'formal_letter|email|portal_submission|phone|in_person_meeting');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `agency_response` SET TAGS ('dbx_business_glossary_term' = 'Agency Response');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `preventive_action_implemented` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Implemented');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `regulatory_agency_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Notified');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `responsible_individual` SET TAGS ('dbx_business_glossary_term' = 'Responsible Individual');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `responsible_individual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `supporting_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Location');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'internal_audit|third_party_audit|regulatory_inspection|documentation_review|testing|monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`corrective_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified_effective|verified_ineffective|requires_additional_action');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `parent_regulatory_agency_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agency Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_parent_regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Regulatory Agency Id');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_parent_regulatory_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Main Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_main_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `agency_short_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Authority Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `enforcement_authority_level` SET TAGS ('dbx_value_regex' = 'primary|delegated|advisory|none');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Months');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Typical');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `inspection_frequency_typical` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|as_needed|risk_based');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Geographic Area');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|regional|local|international');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
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
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-()]{10,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `primary_regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency Default');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_frequency_default` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|event_driven|as_required');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting System Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `reporting_system_name` SET TAGS ('dbx_pii_ssn' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Credentials Reference');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_credentials_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Name');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`compliance`.`regulatory_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
