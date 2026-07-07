-- Schema for Domain: safety | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`safety` COMMENT 'HSE (Health Safety Environment) domain managing incident reports, LTI (Lost Time Injury), TRIR (Total Recordable Incident Rate), near-miss records, SWMS (Safe Work Method Statements), PTW (Permit to Work), TBM (Toolbox Meeting) records, safety audits, corrective actions, PPE compliance, and environmental compliance records. Integrates with Intelex for incident management and OSHA/ISO 45001 regulatory reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique system-generated identifier for each HSE safety event record. Primary key for the incident master register sourced from Intelex incident management module.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Incident reports must reference the scheduled activity where the event occurred for root‑cause analysis and schedule impact assessment.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Incident Management process requires linking each incident to the governing contract agreement for liability, insurance, and regulatory reporting.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Incident investigation requires recording the specific equipment involved for root‑cause analysis and OSHA reporting.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory incident reports must attribute each incident to the owning client account for liability and contract compliance.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which the incident occurred. Links the incident to the project master for site-level TRIR and LTIFR calculations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incident cost allocation for insurance and budgeting; safety team records cost_center to charge incident expenses to the appropriate financial ledger.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the injured or involved party (employee, subcontractor worker, or visitor) from the workforce master. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Incident reports capture the crew responsible for the work area, supporting root‑cause analysis and crew‑level safety metrics.',
    `interface_point_id` BIGINT COMMENT 'Foreign key linking to design.interface_point. Business justification: Root‑cause analysis links incidents to the specific interface point where failure occurred; required for HSE reporting.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Incident investigations record the material that caused the event; linking to material master supports root‑cause analysis and corrective action.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Incident investigations need to identify the responsible contract party (e.g., subcontractor) for corrective actions and claim settlement.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Permit Condition Violation Tracking: incidents are linked to the specific permit condition that was breached.',
    `permit_to_work_id` BIGINT COMMENT 'Reference to the active Permit to Work (PTW) that was in place at the time of the incident. Critical for determining whether the incident occurred under a valid permit and whether permit controls were adequate or breached.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Traceability from safety incident to the purchase order of the material involved is required for root cause analysis and audit compliance.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Incident logging captures the client contact who reported the event, enabling audit trails and follow‑up communication.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.bid_submission. Business justification: Incidents are associated with the awarded contract (bid submission) to monitor safety performance per contract.',
    `swms_id` BIGINT COMMENT 'Reference to the Safe Work Method Statement (SWMS) applicable to the task being performed at the time of the incident. Used to assess whether the SWMS was adequate, followed, or requires revision as a corrective action.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Incident investigation requires identifying the responsible vendor for equipment/material causing the incident, mandated by OSHA incident reporting.',
    `body_part_affected` STRING COMMENT 'Specific body part injured (e.g., right hand, lower back, left eye, head). Required field for OSHA 300 log and BLS injury classification. Supports ergonomic and PPE gap analysis. [ENUM-REF-CANDIDATE: head|eye|neck|back|shoulder|arm|hand|finger|leg|knee|foot|toe|multiple|other — promote to reference product]',
    `corrective_action_count` STRING COMMENT 'Number of corrective actions raised against this incident. Provides a quick indicator of investigation depth and systemic response. Detailed corrective actions are tracked in the corrective_action product linked to this incident.',
    `created_at` TIMESTAMP COMMENT 'System audit timestamp recording when the incident record was first created in the data platform. Supports data lineage and Silver layer audit trail requirements.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured worker was away from work due to the incident, excluding the day of injury. Core component of the DART (Days Away, Restricted, or Transferred) rate calculation and OSHA 300 log column G.',
    `days_restricted_or_transferred` STRING COMMENT 'Number of calendar days the injured worker was on restricted work duty or transferred to another job due to the incident. Combined with days_away_from_work to compute the DART (Days Away, Restricted, or Transferred) rate. Maps to OSHA 300 log column H.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident including what happened, the sequence of events, conditions at the time, and any immediate actions taken. Core field for OSHA 300 log column F and investigation reports.',
    `environmental_media_affected` STRING COMMENT 'Environmental media impacted by the incident (soil, groundwater, surface water, air). Populated only when is_environmental_event is true. Required for EPA reportable quantity determination and ISO 14001 environmental incident reporting.. Valid values are `soil|groundwater|surface_water|air|none|multiple`',
    `immediate_cause` STRING COMMENT 'Direct, proximate cause of the incident as determined during initial investigation (e.g., struck by falling object, slip on wet surface, equipment malfunction, electrical contact). Supports causal pattern analysis.',
    `incident_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the incident at the time of reporting (e.g., INC-2024-000123). Used in correspondence, regulatory submissions, and OSHA 300 log entries.. Valid values are `^INC-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident record within the Intelex workflow. Drives investigation assignment, corrective action tracking, and regulatory notification obligations.. Valid values are `open|under_investigation|pending_review|closed|void`',
    `incident_type` STRING COMMENT 'Primary classification of the safety event (e.g., injury, near_miss, unsafe_condition, property_damage, environmental_event, dangerous_occurrence, behavioral_observation). Drives OSHA recordability determination and TRIR contribution. [ENUM-REF-CANDIDATE: injury|near_miss|unsafe_condition|property_damage|environmental_event|dangerous_occurrence|behavioral_observation — promote to reference product]',
    `injured_party_job_title` STRING COMMENT 'Job title or trade classification of the injured party at the time of the incident (e.g., Ironworker, Electrician, Crane Operator). Used for occupational injury pattern analysis and targeted safety training.',
    `injured_party_name` STRING COMMENT 'Full name of the person injured or involved in the incident. Required for OSHA 300 log, workers compensation claim, and medical case management. Classified as restricted PII.',
    `injured_party_type` STRING COMMENT 'Classification of the person involved in the incident. Determines OSHA recordability scope (employees and supervised workers are recordable; visitors may not be). Affects workers compensation claim eligibility.. Valid values are `employee|subcontractor|visitor|public|third_party`',
    `injury_nature` STRING COMMENT 'Nature or type of the injury or illness sustained (e.g., laceration, fracture, sprain, burn, crush injury, chemical exposure, heat stress). Required for OSHA 300 log and BLS OIICS coding. [ENUM-REF-CANDIDATE: laceration|fracture|sprain_strain|burn|crush|chemical_exposure|heat_stress|contusion|amputation|other — promote to reference product]',
    `intelex_record_reference` STRING COMMENT 'Native record identifier from the Intelex HSE Management system from which this incident record was sourced. Enables bi-directional traceability between the Silver layer data product and the operational system of record for reconciliation and audit purposes.',
    `investigation_completed_date` DATE COMMENT 'Date on which the formal incident investigation was completed and root cause analysis finalized. Used to measure investigation cycle time compliance (typically 5–10 business days per HSE policy) and trigger corrective action issuance.',
    `investigation_lead` STRING COMMENT 'Name or identifier of the HSE officer or supervisor assigned as lead investigator for the incident. Supports investigation accountability tracking and workload management within the HSE team.',
    `is_environmental_event` BOOLEAN COMMENT 'Indicates whether the incident involved an environmental impact such as a spill, release, or contamination event. Triggers EPA reporting obligations and ISO 14001 environmental management corrective action workflows.',
    `is_fit_for_duty` BOOLEAN COMMENT 'Indicates whether the injured worker has been medically cleared for full unrestricted duty upon return to work. Prevents premature return to hazardous tasks and supports site access control decisions.',
    `is_lti` BOOLEAN COMMENT 'Indicates whether the incident resulted in at least one full calendar day away from work beyond the day of injury. LTI (Lost Time Injury) flag is the primary driver of LTIFR (Lost Time Injury Frequency Rate) calculations and executive safety KPI dashboards.',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria under 29 CFR 1904.7 (medical treatment beyond first aid, days away, restricted work, job transfer, loss of consciousness, or diagnosis of a significant injury). Drives OSHA 300 log inclusion and TRIR calculation.',
    `occurred_at` TIMESTAMP COMMENT 'The precise date and time the safety event occurred on site. Principal business event timestamp used for OSHA 300 log date, TRIR period attribution, and trend analysis. Distinct from the report creation timestamp.',
    `ppe_compliance` STRING COMMENT 'Indicates whether the injured party was wearing required Personal Protective Equipment (PPE) at the time of the incident. Non-compliance is a key causal factor and triggers disciplinary and training corrective actions.. Valid values are `compliant|non_compliant|not_applicable|unknown`',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of property, plant, or equipment damage resulting from the incident in USD. Used for insurance claim valuation, project cost impact reporting, and safety cost of poor quality (COPQ) analysis.',
    `regulatory_notification_date` DATE COMMENT 'Date on which the regulatory authority (OSHA, EPA, or other) was formally notified of the incident. Used to verify compliance with mandatory notification timeframes and document regulatory correspondence.',
    `regulatory_notification_status` STRING COMMENT 'Status of mandatory regulatory notification to OSHA or other governing bodies. OSHA requires fatality notification within 8 hours and inpatient hospitalization within 24 hours. Tracks compliance with notification deadlines.. Valid values are `not_required|pending|notified|overdue`',
    `reported_at` TIMESTAMP COMMENT 'Date and time the incident was formally reported and entered into the Intelex system. Used to measure reporting lag compliance (OSHA requires reporting of fatalities within 8 hours and hospitalizations within 24 hours).',
    `return_to_work_date` DATE COMMENT 'Date the injured worker returned to full or modified duty following the incident. Used to calculate actual days away from work, close the LTI case, and update DART rate calculations. Triggers fitness-for-duty clearance workflow.',
    `root_cause_category` STRING COMMENT 'High-level root cause category identified through formal investigation (e.g., inadequate_procedure, equipment_failure, human_error, environmental_condition, inadequate_supervision, training_deficiency). Drives systemic corrective action programs. [ENUM-REF-CANDIDATE: inadequate_procedure|equipment_failure|human_error|environmental_condition|inadequate_supervision|training_deficiency|design_deficiency — promote to reference product]',
    `severity` STRING COMMENT 'Severity level of the incident aligned to the OSHA recordability hierarchy and HSE severity matrix. LTI (Lost Time Injury) and fatality cases trigger mandatory regulatory notifications. Drives DART rate and TRIR calculations. [ENUM-REF-CANDIDATE: fatality|lti|medical_treatment|restricted_work|first_aid|near_miss|property_damage|environmental — 8 candidates stripped; promote to reference product]',
    `shift` STRING COMMENT 'Work shift during which the incident occurred (day, night, swing). Shift-based incident analysis identifies fatigue-related patterns and informs shift rotation and supervision scheduling decisions.. Valid values are `day|night|swing|not_applicable`',
    `site_area` STRING COMMENT 'Specific area, zone, or work front within the project site where the incident occurred (e.g., Zone A – Excavation, Level 3 Formwork, Laydown Yard). Supports spatial incident density analysis and targeted safety interventions.',
    `treating_physician` STRING COMMENT 'Name of the physician or medical professional who provided treatment to the injured party. Required for OSHA 300 log and workers compensation case management. Classified as confidential due to medical case sensitivity.',
    `treatment_type` STRING COMMENT 'Type of medical treatment provided to the injured party. Distinguishes first aid cases (non-recordable) from medical treatment cases (OSHA recordable). Drives case management workflow and workers compensation claim initiation.. Valid values are `first_aid|medical_treatment|hospitalization|fatality|restricted_work|no_treatment`',
    `updated_at` TIMESTAMP COMMENT 'System audit timestamp recording the most recent modification to the incident record. Used to detect stale investigations and track investigation progress velocity.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the site at the time of the incident. Environmental factors such as rain, high winds, or extreme heat are frequently contributing causes in construction incidents and are required for thorough root cause analysis. [ENUM-REF-CANDIDATE: clear|rain|wind|fog|extreme_heat|extreme_cold|not_applicable — 7 candidates stripped; promote to reference product]',
    `workers_comp_claim_ref` STRING COMMENT 'Reference number of the workers compensation insurance claim associated with this incident. Links the safety event record to the financial claims management system for cost tracking and insurance reporting.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Core master record for ALL HSE safety events on construction sites, encompassing the full severity spectrum: Lost Time Injuries (LTI), medical treatment cases (including body part affected, treatment type, treating physician, return-to-work date, fitness-for-duty status), first aid cases, restricted work cases, near-misses, unsafe conditions, behavioral safety observations, property damage, dangerous occurrences, and environmental events. Captures incident classification/type, severity, location (project/site/area), date/time, injured party details, immediate cause, root cause category, OSHA recordability flag, TRIR contribution, days away/restricted/transferred (DART), regulatory notification status, environmental media affected, and workers compensation claim reference. Serves as the single unified safety event register supporting OSHA 300/300A log generation, TRIR/LTIFR/DART rate calculations, leading indicator trending, and ISO 45001 reporting. Sourced from Intelex incident management module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`incident_investigation` (
    `incident_investigation_id` BIGINT COMMENT 'Unique system-generated identifier for the incident investigation record. Primary key for this entity in the Databricks Silver Layer.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which the incident under investigation occurred. Used to associate investigation findings with project-level Health Safety and Environment (HSE) performance.',
    `incident_id` BIGINT COMMENT 'Reference to the parent Health Safety and Environment (HSE) incident record that triggered this investigation. Links the investigation to the originating incident report in Intelex.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee or Health Safety and Environment (HSE) professional designated as the lead investigator responsible for conducting and managing the investigation.',
    `site_id` BIGINT COMMENT 'Reference to the construction site or work location where the incident under investigation occurred. Enables site-level Health Safety and Environment (HSE) performance reporting.',
    `tertiary_incident_approved_by_employee_id` BIGINT COMMENT 'Reference to the manager or executive who formally approved and signed off the completed investigation report, confirming acceptance of findings and corrective actions.',
    `contributing_factors` STRING COMMENT 'Narrative description of secondary factors that contributed to the incident, such as environmental conditions, equipment state, worker fatigue, or inadequate supervision. Supports multi-causal analysis.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date by which all corrective actions arising from the investigation must be implemented and verified. Used for tracking overdue actions and management escalation.',
    `corrective_action_status` STRING COMMENT 'Aggregate status of corrective actions arising from this investigation, indicating whether actions have been initiated, completed, or verified as effective.. Valid values are `not_started|in_progress|completed|overdue|verified`',
    `corrective_action_summary` STRING COMMENT 'Summary description of the corrective and preventive actions recommended by the investigation team to address root causes and prevent recurrence. Detailed individual actions are tracked in the corrective action register.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident investigation record was first created in the system. Used for audit trail, data lineage, and compliance with record-keeping requirements.',
    `immediate_cause` STRING COMMENT 'Direct, observable cause of the incident — the unsafe act or unsafe condition that directly resulted in the event. Captured as a narrative description from the investigation findings.',
    `incident_category` STRING COMMENT 'High-level category of the incident type such as fall from height, struck-by, caught-in/between, electrical, chemical exposure, vehicle collision, or fire. Used for trend analysis and targeted safety interventions. [ENUM-REF-CANDIDATE: fall_from_height|struck_by|caught_in_between|electrical|chemical_exposure|vehicle|fire|ergonomic|other — promote to reference product]',
    `incident_classification` STRING COMMENT 'Severity classification of the incident under investigation per OSHA and ISO 45001 reporting categories. Lost Time Injury (LTI) and fatality classifications trigger mandatory regulatory reporting. [ENUM-REF-CANDIDATE: fatality|lti|medical_treatment|first_aid|near_miss|property_damage|environmental — promote to reference product]',
    `incident_date` DATE COMMENT 'Calendar date on which the original Health Safety and Environment (HSE) incident occurred. Used as the principal business event date for regulatory reporting and trend analysis.',
    `injured_party_type` STRING COMMENT 'Classification of the employment or affiliation status of the person(s) involved in the incident — distinguishing between direct employees, subcontractor workers, site visitors, or members of the public.. Valid values are `direct_employee|subcontractor|visitor|public|other`',
    `intelex_record_reference` STRING COMMENT 'Source system record identifier from the Intelex Health Safety and Environment (HSE) Management platform. Used for data lineage, reconciliation, and traceability back to the operational system of record.',
    `investigation_close_date` DATE COMMENT 'Date on which the investigation was formally closed following completion of root cause analysis, corrective action assignment, and management sign-off. Nullable until closure.',
    `investigation_findings` STRING COMMENT 'Comprehensive narrative summary of all findings from the investigation, including evidence gathered, witness statements reviewed, site conditions observed, and conclusions drawn by the investigation team.',
    `investigation_methodology` STRING COMMENT 'Root cause analysis methodology applied during the investigation. Common methods include 5-Why analysis, Fishbone (Ishikawa) diagram, Bowtie analysis, Fault Tree Analysis, and TapRooT. [ENUM-REF-CANDIDATE: 5_why|fishbone|bowtie|fault_tree|taproot|other — promote to reference product]. Valid values are `5_why|fishbone|bowtie|fault_tree|taproot|other`',
    `investigation_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to the investigation, used in correspondence, regulatory submissions, and audit trails. Format: INV-YYYY-NNNNNN.. Valid values are `^INV-[0-9]{4}-[0-9]{6}$`',
    `investigation_start_date` DATE COMMENT 'Date on which the formal investigation was initiated. Used to measure investigation response time and compliance with regulatory timelines for incident investigation commencement.',
    `investigation_status` STRING COMMENT 'Current lifecycle state of the incident investigation workflow, tracking progress from initial opening through root cause analysis, review, and formal closure.. Valid values are `open|in_progress|pending_review|closed|cancelled`',
    `investigation_team_members` STRING COMMENT 'Names and roles of all personnel who participated in the investigation team, including the lead investigator, HSE representative, site supervisor, and any subject matter experts. Stored as a structured text list.',
    `investigation_type` STRING COMMENT 'Classification of the investigation scope and formality level. Formal investigations are conducted for Lost Time Injuries (LTI), fatalities, and high-potential incidents. Informal investigations cover minor incidents and near-misses.. Valid values are `formal|informal|regulatory|internal`',
    `is_lti` BOOLEAN COMMENT 'Indicates whether the incident resulted in a Lost Time Injury (LTI), defined as any work-related injury or illness that results in at least one full day away from work beyond the day of the incident.',
    `is_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria and must be entered on the OSHA 300 Log. Recordable incidents include work-related fatalities, injuries, and illnesses meeting specific severity thresholds.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether the incident requires mandatory notification to a regulatory authority such as OSHA, EPA, or local government within a prescribed timeframe (e.g., OSHA requires fatality reporting within 8 hours).',
    `lessons_learned` STRING COMMENT 'Key lessons identified from the investigation that should be communicated across the organisation and other project sites to prevent similar incidents. Used in Toolbox Meeting (TBM) communications and safety alerts.',
    `lost_time_days` STRING COMMENT 'Number of calendar days lost due to the incident as determined by the investigation. Used in calculating Lost Time Injury (LTI) frequency rates and Total Recordable Incident Rate (TRIR) for OSHA regulatory reporting.',
    `management_review_date` DATE COMMENT 'Date on which senior management formally reviewed and accepted the investigation report and corrective action plan. Required for ISO 45001 management review compliance.',
    `ppe_compliance_flag` BOOLEAN COMMENT 'Indicates whether the injured party was wearing the required Personal Protective Equipment (PPE) at the time of the incident. Non-compliance is a key contributing factor captured in the investigation.',
    `ptw_reference` STRING COMMENT 'Reference number of the Permit to Work (PTW) that was active or should have been active for the work activity at the time of the incident. Used to assess whether permit controls were adequate or absent.',
    `recurrence_prevention_measures` STRING COMMENT 'Narrative description of specific engineering controls, administrative controls, or procedural changes recommended to prevent recurrence of the incident type. Aligned with the hierarchy of controls.',
    `regulatory_reference_number` STRING COMMENT 'Reference or case number assigned by the regulatory authority (e.g., OSHA case number) upon submission of the incident report. Used for tracking regulatory correspondence and compliance status.',
    `regulatory_submission_date` DATE COMMENT 'Date on which the incident investigation report or notification was formally submitted to the relevant regulatory authority (e.g., OSHA, EPA). Nullable for non-reportable incidents.',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the fundamental systemic root cause(s) identified through the investigation methodology (e.g., 5-Why, Fishbone). Represents the deepest causal factor that, if corrected, would prevent recurrence.',
    `swms_in_place_flag` BOOLEAN COMMENT 'Indicates whether a valid Safe Work Method Statement (SWMS) was in place and accessible for the work activity being performed at the time of the incident. Absence of SWMS is a key systemic cause indicator.',
    `systemic_cause` STRING COMMENT 'Organisational or management system failure that allowed the immediate and root causes to exist, such as inadequate procedures, insufficient training, or failed management controls. Distinct from immediate and root causes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident investigation record. Supports audit trail requirements and change tracking for regulatory compliance.',
    `witness_count` STRING COMMENT 'Number of witnesses interviewed during the investigation. Indicates the breadth of evidence gathering and supports completeness assessment of the investigation.',
    `work_area_description` STRING COMMENT 'Specific work area, zone, or location within the construction site where the incident occurred, such as excavation zone, scaffolding level, electrical room, or crane operating radius.',
    CONSTRAINT pk_incident_investigation PRIMARY KEY(`incident_investigation_id`)
) COMMENT 'Detailed investigation record linked to a reported HSE incident. Captures investigation team members, root cause analysis methodology (5-Why, Fishbone), contributing factors, immediate causes, systemic causes, investigation findings, corrective action recommendations, and regulatory submission details. Tracks investigation status from open through closed. Sourced from Intelex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`swms` (
    `swms_id` BIGINT COMMENT 'Unique system-generated identifier for the Safe Work Method Statement (SWMS) record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: SWMS documents list required plant/equipment; linking ensures equipment compliance and traceability for each method statement.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this SWMS was prepared. Links the SWMS to the project master record for site-level HSE reporting and compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SWMS implementation incurs labor and material costs; assigning a cost_center allows these costs to flow into project financials.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor entity responsible for performing the high-risk activity described in this SWMS. Null if the activity is performed by the principal contractors own workforce.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the HSE Manager or authorised approver who formally approved this SWMS for use on site. Approval is a mandatory step before work can commence.',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site or work front where the SWMS applies. Enables site-level HSE compliance reporting and audit trail.',
    `tertiary_swms_prepared_by_employee_id` BIGINT COMMENT 'Reference to the workforce record of the HSE professional or site engineer who prepared and authored this SWMS document. Provides accountability for document authorship.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element in Oracle Primavera P6 that this SWMS activity is associated with, enabling linkage between safety documentation and project schedule activities.',
    `aconex_document_reference` STRING COMMENT 'The unique document identifier assigned by the Aconex document management system for this SWMS record. Used for cross-system traceability and transmittal tracking.',
    `activity_description` STRING COMMENT 'Detailed narrative description of the high-risk construction activity covered by this SWMS, including scope, location, and method of work. Provides the foundational context for all hazard and control entries.',
    `activity_type` STRING COMMENT 'Classification of the high-risk construction activity category covered by this SWMS (e.g., working at heights, confined space entry, excavation, demolition, crane lifts, hot works, electrical works). [ENUM-REF-CANDIDATE: working_at_heights|confined_space|excavation|demolition|crane_lift|hot_works|electrical|trenching|scaffolding|explosive_use — promote to reference product]',
    `applicable_legislation` STRING COMMENT 'List of applicable legislation, regulations, codes of practice, and industry standards that govern the high-risk activity described in this SWMS (e.g., OSHA 29 CFR 1926, IBC, NFPA, AISC, ACI). Required for regulatory compliance documentation.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the SWMS document within the approval workflow. Controls whether the SWMS is valid for use on site. Only approved SWMS documents may be used to authorise work commencement.. Valid values are `draft|under_review|approved|rejected|superseded|archived`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time at which the SWMS was formally approved by the authorised approver. Distinct from issue_date — captures the precise approval event for audit trail purposes.',
    `competency_requirements` STRING COMMENT 'Description of mandatory competency, certification, and licence requirements for workers performing the activity (e.g., Working at Heights certificate, Confined Space Entry certificate, Crane Operator licence). Supports workforce compliance verification.',
    `control_measures` STRING COMMENT 'Detailed description of all control measures to be implemented to eliminate or minimise the identified hazards, following the hierarchy of controls (elimination, substitution, engineering, administrative, PPE). Core content of the SWMS.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this SWMS record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes.',
    `document_url` STRING COMMENT 'URL or file path reference to the full SWMS document stored in the document management system (Aconex or Autodesk BIM 360). Provides direct access to the source document for audit and compliance purposes.',
    `emergency_procedures` STRING COMMENT 'Description of emergency response procedures specific to the high-risk activity, including evacuation routes, first aid requirements, emergency contacts, and incident notification protocols.',
    `environmental_controls` STRING COMMENT 'Description of environmental control measures required during the activity to prevent environmental harm, including spill containment, dust suppression, noise management, and waste disposal procedures.',
    `expiry_date` DATE COMMENT 'The date after which the SWMS is no longer valid for use and must be re-approved or superseded. Distinct from review_date — expiry renders the document invalid, whereas review_date triggers a re-assessment.',
    `hazard_description` STRING COMMENT 'Narrative description of all identified hazards associated with the high-risk activity, including physical, chemical, biological, ergonomic, and environmental hazards. Captured as a consolidated summary at the SWMS header level.',
    `initial_risk_consequence` STRING COMMENT 'Consequence severity rating of the identified hazard before any control measures are applied (inherent risk). Combined with initial_risk_likelihood to produce the initial risk rating score.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `initial_risk_likelihood` STRING COMMENT 'Likelihood rating of the identified hazard materialising before any control measures are applied (inherent risk). Used in conjunction with initial_risk_consequence to derive the initial risk rating per the risk matrix.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `initial_risk_rating` STRING COMMENT 'Overall risk rating derived from the combination of initial_risk_likelihood and initial_risk_consequence before any control measures are applied. Represents the inherent risk level of the activity.. Valid values are `low|medium|high|extreme`',
    `intelex_record_reference` STRING COMMENT 'The unique record identifier assigned by the Intelex HSE Management system for this SWMS. Enables bidirectional traceability between the lakehouse silver layer and the operational system of record.',
    `issue_date` DATE COMMENT 'The date on which the SWMS was formally issued and approved for use on site. Represents the principal business event date for this document.',
    `last_reviewed_date` DATE COMMENT 'The date on which the SWMS was most recently reviewed and confirmed as current and applicable. Updated each time a formal review is completed, even if no changes are made to the document content.',
    `plant_equipment_required` STRING COMMENT 'List of plant, equipment, and tools required to perform the high-risk activity safely as described in this SWMS (e.g., EWP, crane, excavator, scaffolding, welding equipment). Supports equipment deployment planning.',
    `ppe_requirements` STRING COMMENT 'Enumerated list of mandatory Personal Protective Equipment (PPE) items required for personnel performing the activity covered by this SWMS (e.g., hard hat, safety harness, respirator, face shield, cut-resistant gloves). Aligns with PPE compliance tracking in Intelex.',
    `ptw_required` BOOLEAN COMMENT 'Indicates whether a Permit to Work (PTW) must be issued and active before the activity described in this SWMS can commence. True for activities such as confined space entry, hot works, and electrical isolation.',
    `ptw_type` STRING COMMENT 'Type of Permit to Work (PTW) required in conjunction with this SWMS. Populated only when ptw_required is True. Drives the PTW issuance workflow in Intelex.. Valid values are `hot_work|confined_space|electrical|excavation|working_at_heights|general`',
    `residual_risk_consequence` STRING COMMENT 'Consequence severity rating after all control measures have been applied. Combined with residual_risk_likelihood to produce the residual risk rating.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `residual_risk_likelihood` STRING COMMENT 'Likelihood rating of the hazard materialising after all control measures have been applied. Used to assess the effectiveness of controls and determine if the residual risk is acceptable.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `residual_risk_rating` STRING COMMENT 'Overall risk rating after all control measures have been applied. Represents the residual risk level that must be accepted or further mitigated before work can proceed. Extreme residual risk requires escalation to HSE Manager.. Valid values are `low|medium|high|extreme`',
    `review_date` DATE COMMENT 'The scheduled date by which the SWMS must be reviewed and re-validated for continued applicability. Triggers review workflow in Intelex when the date is reached or when site conditions change materially.',
    `revision_number` STRING COMMENT 'Sequential revision number of the SWMS document, incremented each time the document is formally revised and re-approved. Revision 0 represents the initial issue.',
    `swms_number` STRING COMMENT 'Externally-known unique document reference number for the SWMS, used for document control, transmittals, and regulatory submissions. Typically formatted as SWMS-[ProjectCode]-[Sequence]. Sourced from Intelex or Aconex document management.. Valid values are `^SWMS-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `tbm_required` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) must be conducted with all workers before commencing the activity. TBMs are used to communicate SWMS content and obtain worker acknowledgement.',
    `title` STRING COMMENT 'Descriptive title of the Safe Work Method Statement identifying the high-risk construction activity covered (e.g., Elevated Work Platform Operations, Confined Space Entry – Stormwater Pit).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this SWMS record was most recently modified in the system. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks lakehouse.',
    `work_steps` STRING COMMENT 'Sequential step-by-step description of the work procedure for the high-risk activity, detailing the specific actions workers must follow to complete the task safely. Core operational content of the SWMS.',
    `worker_acknowledgement_required` BOOLEAN COMMENT 'Indicates whether all workers performing the activity must sign the SWMS to confirm they have read, understood, and agree to comply with the documented procedures and controls.',
    CONSTRAINT pk_swms PRIMARY KEY(`swms_id`)
) COMMENT 'Safe Work Method Statement (SWMS) master records defining step-by-step work procedures for high-risk construction activities. Captures activity description, identified hazards, risk rating (before and after controls), control measures, PPE requirements, responsible supervisor, approval status, review date, and applicable legislation. SSOT for SWMS documentation across all projects and sites.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'Unique system-generated identifier for the Permit to Work record. Primary key for the permit_to_work data product in the Databricks Silver Layer.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Permit‑to‑Work administration tracks permits against the specific contract agreement to ensure compliance and cost allocation.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Permit‑to‑Work authorizations often isolate or operate specific equipment; linking records which asset the permit applies to for safety compliance.',
    `regulatory_permit_id` BIGINT COMMENT 'Source system identifier for this permit record in the Intelex HSE Management platform. Used for data lineage, reconciliation, and integration with the operational system of record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this permit is issued. Links the PTW to the project context for cost, schedule, and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit issuance may involve fees or cost allocations; cost_center linkage enables proper expense recording in permit cost reports.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: PTW is assigned to a specific crew for execution; tracking crew_id enables compliance reporting and work‑scope verification.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor organization performing the permitted work, if applicable. Enables subcontractor HSE performance tracking and compliance reporting.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Permits are issued to a contract party (sub‑contractor) and must be linked for audit trails and responsibility tracking.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Permit issuance must record the authorized employee performing the work for compliance reporting.',
    `site_id` BIGINT COMMENT 'Reference to the physical construction site where the permitted work is to be performed. Supports site-level HSE reporting and geographic risk analysis.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element representing the work package or activity under which this permit is issued. Enables cost and schedule integration with Oracle Primavera P6 and SAP PS.',
    `approval_level` STRING COMMENT 'The organizational authority level required to approve this permit, determined by the risk level and permit type. Enforces the sign-off hierarchy in the PTW system.. Valid values are `supervisor|hse_manager|project_manager|site_director`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time at which the permit received final approval from the designated authority. Distinct from issued_timestamp; represents the formal authorization event.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time at which the permit was formally closed upon completion or cancellation of the permitted work. Triggers site reinstatement and isolation removal procedures.',
    `concurrent_permit_flag` BOOLEAN COMMENT 'Indicates whether this permit is being executed concurrently with other active permits in the same work area. Triggers additional interface risk assessment requirements.',
    `control_measures` STRING COMMENT 'Detailed description of all hazard control measures required before and during the permitted work, including engineering controls, administrative controls, and PPE requirements. Sourced from Intelex PTW control measures field.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was first created in the system. Audit trail field for data lineage and compliance reporting in the Databricks Silver Layer.',
    `emergency_rescue_plan` STRING COMMENT 'Reference to or description of the emergency rescue and evacuation plan applicable to the permitted work. Mandatory for confined space entry and working at heights permits.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the permitted work has potential environmental impacts requiring additional controls or regulatory notifications (e.g., soil disturbance, chemical handling, noise).',
    `extension_count` STRING COMMENT 'Number of times the permit validity period has been extended beyond the original valid_until timestamp. Tracks permit lifecycle management and potential compliance risk.',
    `gas_test_required` BOOLEAN COMMENT 'Indicates whether atmospheric gas testing is required prior to and during the permitted work (mandatory for confined space entry and hot work near flammable materials).',
    `gas_test_result` STRING COMMENT 'Result of the atmospheric gas test conducted prior to commencing the permitted work. Must be pass before work can proceed when gas_test_required is True.. Valid values are `pass|fail|not_required`',
    `hazard_description` STRING COMMENT 'Narrative description of all identified hazards associated with the permitted work activity, as documented during the hazard identification process. Core HSE compliance field.',
    `isolation_details` STRING COMMENT 'Description of the specific isolation points, energy sources, and lockout/tagout procedures required for the permitted work. Populated when isolation_required is True.',
    `isolation_required` BOOLEAN COMMENT 'Indicates whether energy isolation (lockout/tagout) is required before commencing the permitted work. Mandatory for electrical, mechanical, and process isolation scenarios.',
    `issued_timestamp` TIMESTAMP COMMENT 'The date and time at which the permit was formally issued and authorized by the issuing authority. Represents the principal real-world business event time for this transaction. Sourced from Intelex.',
    `issuing_authority_name` STRING COMMENT 'Full name of the qualified person (typically HSE Manager, Area Authority, or Responsible Engineer) who issued and authorized the permit. Required for regulatory audit and sign-off chain documentation.',
    `issuing_authority_role` STRING COMMENT 'Job title or role designation of the person who issued the permit (e.g., HSE Manager, Area Authority, Electrical Supervisor). Validates competency and authorization level.',
    `last_extended_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent extension of the permit validity period. Populated when extension_count is greater than zero.',
    `performing_authority_name` STRING COMMENT 'Full name of the person responsible for executing the permitted work (typically the Supervisor or Foreman accepting the permit). Part of the mandatory sign-off chain.',
    `performing_authority_role` STRING COMMENT 'Job title or role of the person accepting and executing the permitted work (e.g., Foreman, Tradesperson, Subcontractor Supervisor). Validates competency for the work type.',
    `permit_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the permit by the issuing authority. Used for field reference, correspondence, and regulatory audit trails. Sourced from Intelex Permit to Work module.. Valid values are `^PTW-[A-Z0-9]{3,10}-[0-9]{4,8}$`',
    `permit_status` STRING COMMENT 'Current lifecycle state of the permit within the approval and execution workflow. Drives field access control and compliance dashboards. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on the category of high-risk work being authorized. Drives the applicable hazard controls, sign-off chain, and regulatory requirements. [ENUM-REF-CANDIDATE: hot_work|confined_space|working_at_heights|electrical_isolation|excavation|radiography|lifting_operations|general_work — promote to reference product]',
    `ppe_requirements` STRING COMMENT 'Specific PPE items mandated for the permitted work activity (e.g., hard hat, harness, SCBA, arc flash suit, gas monitor). Derived from hazard assessment and regulatory requirements.',
    `reinstatement_details` STRING COMMENT 'Description of site reinstatement actions completed upon permit closure, including removal of isolations, restoration of services, and area clearance confirmation.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the permitted work activity based on the hazard identification and risk assessment process. Determines the approval authority level required.. Valid values are `low|medium|high|critical`',
    `suspension_reason` STRING COMMENT 'Narrative reason for suspending the permit mid-execution (e.g., weather change, equipment failure, emergency evacuation). Populated when permit_status is suspended.',
    `swms_reference` STRING COMMENT 'Document reference number of the Safe Work Method Statement (SWMS) associated with this permit. Links the PTW to the detailed procedural safety document governing the work.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted with the work crew prior to commencing the permitted work. Mandatory pre-work safety briefing requirement.',
    `tbm_record_reference` BIGINT COMMENT 'Reference to the Toolbox Meeting record conducted prior to commencing the permitted work. Links the PTW to the pre-work safety briefing documentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was last modified in the system. Supports change tracking, audit compliance, and incremental data loading in the Silver Layer.',
    `valid_from_timestamp` TIMESTAMP COMMENT '',
    `valid_to_timestamp` TIMESTAMP COMMENT '',
    `valid_until` TIMESTAMP COMMENT 'The date and time at which the permit expires and work must cease unless renewed. Critical for field enforcement and compliance auditing.',
    `work_description` STRING COMMENT '',
    `work_location` STRING COMMENT '',
    `work_location_description` STRING COMMENT 'Specific location within the site where the permitted work is to be performed, including zone, level, grid reference, or equipment tag. Supplements the site_id with granular location detail.',
    `work_scope` STRING COMMENT 'Detailed narrative description of the specific work activities authorized under this permit, including methods, equipment, and materials involved. Sourced from Intelex PTW work description field.',
    `worker_count` STRING COMMENT 'Number of workers authorized to perform work under this permit. Used for site headcount control, emergency muster, and HSE exposure tracking.',
    `valid_from` TIMESTAMP COMMENT 'The date and time from which the permit is valid and work may commence. Must not precede the issued_timestamp. Used to enforce temporal access controls on site.',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Permit to Work (PTW) records authorizing high-risk construction activities such as hot work, confined space entry, working at heights, electrical isolation, and excavation. Captures permit type, issuing authority, work scope, hazard identification, control measures, validity period, site location, isolations required, and sign-off chain. Sourced from Intelex Permit to Work module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` (
    `toolbox_meeting_id` BIGINT COMMENT 'Primary key for toolbox_meeting',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Toolbox meetings are scheduled per client project; linking to the client account supports client‑level meeting calendars and compliance reporting.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this Toolbox Meeting was conducted. Links the TBM to the project for HSE performance reporting and compliance tracking.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee (supervisor, HSE officer, or foreman) who conducted and facilitated the Toolbox Meeting. Required for accountability and competency verification under ISO 45001.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor whose crew attended this Toolbox Meeting, if applicable. Enables subcontractor HSE compliance tracking and performance reporting.',
    `risk_assessment_id` BIGINT COMMENT 'Reference to the risk assessment record whose identified hazards and controls were communicated during this Toolbox Meeting. Links TBM content to the formal risk register.',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site or work front where the Toolbox Meeting was held. Enables site-level HSE compliance reporting and incident correlation.',
    `actual_attendee_count` STRING COMMENT 'Actual number of workers who attended and signed off on the Toolbox Meeting. Used to compute attendance rate and demonstrate safety communication compliance under OSHA and ISO 45001.',
    `attendance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of planned attendees who actually attended and signed off on the Toolbox Meeting (actual_attendee_count / planned_attendee_count × 100). Key HSE KPI for safety communication coverage reporting.',
    `control_measures_communicated` STRING COMMENT 'Description of the specific hazard control measures (elimination, substitution, engineering controls, administrative controls, PPE) communicated to attendees. Demonstrates hierarchy-of-controls compliance per ISO 45001 Clause 8.1.2.',
    `corrective_action_raised` BOOLEAN COMMENT 'Indicates whether any corrective actions or follow-up items were raised as a result of the Toolbox Meeting (e.g., identified hazards requiring remediation, equipment defects reported). Triggers workflow in Intelex for corrective action tracking.',
    `corrective_action_reference` STRING COMMENT 'Reference number of the corrective action record raised in Intelex as a result of issues identified during the Toolbox Meeting. Enables traceability between TBM findings and corrective action closure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the Toolbox Meeting record was first created in the source system (Intelex) or ingested into the lakehouse silver layer. Supports audit trail and data lineage requirements.',
    `document_attachment_reference` STRING COMMENT 'Reference identifier or URL to supporting documents attached to the Toolbox Meeting record in Intelex or Aconex (e.g., signed attendance sheet, topic handout, SWMS extract). Supports document control under ISO 45001 Clause 7.5.',
    `duration_minutes` STRING COMMENT 'Actual duration of the Toolbox Meeting in minutes as recorded by the facilitator. Supports quality assurance checks to ensure meetings meet minimum required duration thresholds.',
    `emergency_procedures_reviewed` BOOLEAN COMMENT 'Indicates whether emergency response procedures (evacuation routes, muster points, emergency contacts) were reviewed with attendees during the Toolbox Meeting.',
    `end_time` TIMESTAMP COMMENT 'Date and timestamp when the Toolbox Meeting concluded. Used in conjunction with start_time to compute actual meeting duration for compliance and quality reporting.',
    `facilitator_name` STRING COMMENT 'Full name of the person who facilitated the Toolbox Meeting (supervisor, HSE officer, or foreman). Retained for accountability and regulatory audit purposes. Classified as confidential as it identifies an employee.',
    `facilitator_qualification` STRING COMMENT 'HSE qualification or certification held by the meeting facilitator (e.g., OSHA 30-Hour, ISO 45001 Lead Auditor, First Aid). Supports competency verification requirements under ISO 45001 Clause 7.2.',
    `hazards_highlighted` STRING COMMENT 'Description of the specific site hazards communicated to attendees during the Toolbox Meeting, drawn from the linked risk assessment or SWMS (Safe Work Method Statement). Supports evidence of hazard communication under OSHA and ISO 45001.',
    `hse_topic_category` STRING COMMENT 'Primary HSE topic category covered in the Toolbox Meeting (e.g., Working at Heights, Confined Space, Electrical Safety, Manual Handling, Environmental Compliance). Used for topic frequency analysis and gap identification. [ENUM-REF-CANDIDATE: working_at_heights|confined_space|electrical_safety|manual_handling|environmental|fire_prevention|excavation|crane_lifting|ppe_compliance|chemical_handling — promote to reference product]',
    `incident_review_included` BOOLEAN COMMENT 'Indicates whether a review of recent incidents, near-misses, or LTI (Lost Time Injury) events was included in the Toolbox Meeting agenda. Supports learning-from-incidents culture and ISO 45001 Clause 10.2 requirements.',
    `intelex_record_reference` STRING COMMENT 'Native record identifier from the Intelex HSE Management system from which this Toolbox Meeting record was sourced. Used for data lineage, reconciliation, and back-reference to the operational system of record.',
    `interpreter_required` BOOLEAN COMMENT 'Indicates whether an interpreter or translator was required and used during the Toolbox Meeting to communicate safety information to non-English-speaking workers.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this Toolbox Meeting record is required to be included in regulatory compliance reports submitted to OSHA, EPA, or other governing bodies. Drives automated regulatory reporting workflows.',
    `language_conducted` STRING COMMENT 'ISO 639-2 three-letter language code for the primary language in which the Toolbox Meeting was conducted. Supports multilingual workforce compliance and OSHA Hazard Communication requirements for non-English-speaking workers.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the Toolbox Meeting record in the source system or lakehouse. Supports change tracking, audit compliance, and incremental data loading.',
    `meeting_date` DATE COMMENT 'Calendar date on which the Toolbox Meeting was conducted. Used for scheduling compliance checks, frequency reporting, and OSHA recordkeeping.',
    `meeting_location` STRING COMMENT 'Physical location or area on the construction site where the Toolbox Meeting was held (e.g., site office, work front, laydown area, specific grid reference). Supports site-level HSE reporting.',
    `meeting_reference_number` STRING COMMENT 'Externally-known unique business identifier for the Toolbox Meeting as assigned by the HSE management system (Intelex). Used for cross-referencing in safety registers, audit trails, and regulatory submissions.. Valid values are `^TBM-[A-Z0-9]{2,10}-[0-9]{4,8}$`',
    `meeting_status` STRING COMMENT 'Current lifecycle status of the Toolbox Meeting record. Drives workflow in Intelex and determines whether the meeting counts toward HSE compliance metrics.. Valid values are `draft|scheduled|completed|cancelled|pending_review`',
    `meeting_type` STRING COMMENT 'Classification of the Toolbox Meeting by its operational purpose. Pre-shift meetings occur at the start of each work shift; pre-task meetings are conducted immediately before a specific high-risk activity begins.. Valid values are `pre_shift|pre_task|weekly_safety|emergency|visitor_induction`',
    `planned_attendee_count` STRING COMMENT 'Number of workers expected to attend the Toolbox Meeting based on the crew deployment plan. Used to calculate attendance rate and identify gaps in safety communication coverage.',
    `ppe_requirements_communicated` BOOLEAN COMMENT 'Indicates whether PPE (Personal Protective Equipment) requirements specific to the work activity were communicated to attendees during the Toolbox Meeting. Supports PPE compliance tracking under OSHA PPE standards.',
    `ptw_reference_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) associated with this Toolbox Meeting, where the meeting was conducted as part of the PTW pre-work briefing process.',
    `sign_off_method` STRING COMMENT 'Method used to capture attendee acknowledgement and sign-off for the Toolbox Meeting. Determines the evidentiary value of the attendance record for regulatory compliance purposes.. Valid values are `paper_signature|digital_signature|biometric|verbal_acknowledgement`',
    `start_time` TIMESTAMP COMMENT 'Date and timestamp when the Toolbox Meeting commenced. Used to verify pre-shift or pre-task timing compliance and to calculate meeting duration.',
    `swms_reference_number` STRING COMMENT 'Reference number of the Safe Work Method Statement (SWMS) reviewed or communicated during this Toolbox Meeting. Links the TBM to the formal SWMS document for high-risk construction work.',
    `topics_discussed` STRING COMMENT 'Free-text or structured summary of the safety topics covered during the Toolbox Meeting, including hazard types, regulatory requirements, and site-specific risks communicated to the crew. Sourced from Intelex TBM topic fields.',
    `trade_group` STRING COMMENT 'The trade or crew group attending the Toolbox Meeting (e.g., Civil, Structural Steel, MEP (Mechanical Electrical Plumbing), Concrete, Earthworks). Used to segment HSE communication effectiveness by trade.',
    `wbs_element_code` STRING COMMENT 'WBS (Work Breakdown Structure) element code from Oracle Primavera P6 identifying the specific work package or activity for which this Toolbox Meeting was conducted. Enables linkage of HSE communication to project schedule activities.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the time of the Toolbox Meeting. Relevant for outdoor construction sites where weather-related hazards (heat stress, lightning, high winds) are discussed as part of the meeting agenda. [ENUM-REF-CANDIDATE: clear|cloudy|rain|high_wind|extreme_heat|fog|storm — 7 candidates stripped; promote to reference product]',
    `work_area_description` STRING COMMENT 'Description of the specific work area, zone, or work front covered by this Toolbox Meeting. Provides context for the hazards and controls discussed, aligned to the WBS (Work Breakdown Structure) or site zone plan.',
    CONSTRAINT pk_toolbox_meeting PRIMARY KEY(`toolbox_meeting_id`)
) COMMENT 'Toolbox Meeting (TBM) records capturing pre-shift and pre-task safety briefings conducted on construction sites. Records meeting date, time, location, project/site, crew/trade group, topics discussed (linked to site hazards from risk_assessment), hazards highlighted, specific control measures communicated, attendee list with sign-off confirmation, facilitator name, and duration. Supports demonstration of safety communication compliance under OSHA and ISO 45001 clause 7.4 (Communication). Attendance records are embedded as line items within the meeting record. Sourced from Intelex.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`safety_audit` (
    `safety_audit_id` BIGINT COMMENT 'Unique system-generated identifier for the safety audit record. Primary key for the safety_audit data product. Entity role: TRANSACTION_HEADER — represents a discrete formal HSE audit event with its own lifecycle, scope, team, findings, and close-out status.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Safety audits are performed against specific contracts to verify contractual HSE clauses and performance metrics.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project against which this audit was conducted. Links the audit to the project master for project-level HSE performance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit findings often generate corrective‑action costs; linking to cost_center supports audit cost tracking and financial impact analysis.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Audits are scoped to a crews practices; linking crew_id allows audit findings to be tied to specific crews for corrective action.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee record of the lead auditor in the workforce/HR system (SAP SuccessFactors). Enables cross-domain linking to auditor qualifications and competency records.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor record when the audit is conducted on a subcontractors operations. Null for internal audits. Enables subcontractor HSE performance tracking.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Safety audit is performed against a specific HSE plan; linking audit to plan eliminates the free‑text reference and enables joins for plan details.',
    `site_id` BIGINT COMMENT 'Reference to the physical construction site where the audit was conducted. Enables site-level HSE compliance tracking and benchmarking across multiple sites.',
    `aconex_document_ref` STRING COMMENT 'Document reference number in the Aconex document management system for the formal audit report. Enables direct retrieval of the audit report from the document control system.',
    `audit_category` STRING COMMENT 'Functional category of the audit defining the primary subject matter: HSE management system, site safety operations, environmental compliance, fire safety, process safety, or contractor/subcontractor compliance. [ENUM-REF-CANDIDATE: hse_management_system|site_safety|environmental|fire_safety|process_safety|contractor_compliance — promote to reference product]. Valid values are `hse_management_system|site_safety|environmental|fire_safety|process_safety|contractor_compliance`',
    `audit_date` DATE COMMENT 'The principal date on which the audit was conducted (or the start date for multi-day audits). This is the primary business event date used for regulatory reporting and trend analysis.',
    `audit_number` STRING COMMENT 'Externally-known unique reference number assigned to the audit, used in correspondence, regulatory submissions, and Intelex Audits module. Format: AUD-YYYY-NNNNN.. Valid values are `^AUD-[0-9]{4}-[0-9]{5}$`',
    `audit_scope` STRING COMMENT 'Narrative description of the boundaries and subject matter of the audit, including work areas, activities, processes, and standards covered. Sourced from the Intelex audit scope field.',
    `audit_status` STRING COMMENT 'Current lifecycle state of the audit record: planned (scheduled but not started), in_progress (audit underway), completed (fieldwork done, report pending), closed (all findings resolved and signed off), or cancelled.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit by its origin and authority: internal (conducted by company HSE team), external (third-party), regulatory (OSHA/EPA enforcement), surveillance (ISO certification body), or certification (initial ISO certification audit).. Valid values are `internal|external|regulatory|surveillance|certification`',
    `auditee_name` STRING COMMENT 'Name of the individual, department, or subcontractor organisation being audited. Represents the PARTY_REFERENCE for this transaction — the primary counterparty subject to the audit.',
    `auditee_organisation` STRING COMMENT 'Name of the company or organisational unit being audited (e.g., subcontractor company name, internal business unit). Distinguishes between audits of internal teams versus subcontractors.',
    `closeout_date` DATE COMMENT 'Date on which all audit findings were resolved, verified, and the audit was formally closed. Null if the audit has not yet been closed. Key metric for HSE management system effectiveness.',
    `compliance_rating` STRING COMMENT 'Qualitative rating derived from the compliance score, providing a standardised categorical assessment of overall audit performance: satisfactory (≥90%), acceptable (75–89%), marginal (60–74%), unsatisfactory (40–59%), critical (<40%).. Valid values are `satisfactory|acceptable|marginal|unsatisfactory|critical`',
    `compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance score expressed as a percentage (0.00–100.00) calculated from the ratio of compliant audit criteria to total criteria assessed. The principal quantitative result of the audit. Used for trend analysis and HSE KPI dashboards.',
    `corrective_action_plan_due_date` DATE COMMENT 'Deadline by which the auditee must submit a formal corrective action plan (CAPA) addressing all non-conformances raised in the audit. Drives CAPA workflow in Intelex.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the data platform (Silver layer ingestion). Supports data lineage, audit trail, and SLA monitoring for data freshness.',
    `criteria_compliant` STRING COMMENT 'Number of audit criteria assessed as fully compliant. Together with total_criteria_assessed, provides the raw data for compliance score calculation and trend reporting.',
    `end_date` DATE COMMENT 'The date on which fieldwork for the audit was completed. Populated for multi-day audits to capture the full audit duration. Null for single-day audits.',
    `finding_detail` STRING COMMENT 'Embedded narrative summary of key audit findings captured at the header level for quick reference. Full individual finding records with severity, standard clause, responsible party, and due date are managed in the linked audit_finding child entity.',
    `immediate_action_required` BOOLEAN COMMENT 'Indicates whether the audit identified at least one finding requiring immediate corrective action due to imminent risk to worker safety or regulatory non-compliance. Triggers escalation workflow in Intelex.',
    `intelex_audit_reference` STRING COMMENT 'Source system identifier for this audit record in the Intelex HSE Management platform. Used for data lineage, reconciliation, and drill-back to the operational system of record.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for planning, conducting, and reporting the audit. Retained for accountability and regulatory traceability. Classified confidential as it identifies a named individual in a professional capacity.',
    `location_description` STRING COMMENT 'Free-text description of the specific location(s) within the site where the audit was conducted (e.g., North excavation zone, concrete batching plant, welfare facilities). Supplements the site_id reference.',
    `major_nc_count` STRING COMMENT 'Number of major non-conformances (NCRs) identified during the audit. Major NCs represent significant failures against a standard clause that could result in regulatory action or certification suspension.',
    `minor_nc_count` STRING COMMENT 'Number of minor non-conformances identified during the audit. Minor NCs represent isolated or partial failures against a standard clause that do not immediately threaten system integrity.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of the same scope and auditee, derived from the audit frequency plan. Used to drive the audit schedule and ensure compliance with ISO 45001 internal audit programme requirements.',
    `observation_count` STRING COMMENT 'Number of observations raised during the audit. Observations are potential risks or areas of concern that do not yet constitute non-conformances but warrant monitoring.',
    `ofi_count` STRING COMMENT 'Number of opportunities for improvement (OFIs) identified during the audit. OFIs are positive suggestions for enhancing HSE performance beyond current compliance requirements.',
    `open_findings_count` STRING COMMENT 'Number of audit findings that remain open (not yet resolved and verified) at the time of the last record update. Key metric for audit close-out tracking and corrective action management.',
    `programme_ref` STRING COMMENT 'Reference to the annual or project-level audit programme under which this audit was scheduled. Enables tracking of audit programme completion and coverage across the organisation.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether findings from this audit require formal notification to a regulatory authority (e.g., OSHA, EPA). Drives compliance reporting obligations and legal review workflows.',
    `regulatory_standard` STRING COMMENT 'Primary regulatory or management system standard against which the audit was conducted (e.g., OSHA 29 CFR 1926, ISO 45001:2018, ISO 14001:2015, site-specific HSE plan). Multiple standards may be listed separated by semicolons.',
    `report_issue_date` DATE COMMENT 'Date on which the formal audit report was issued to the auditee and relevant stakeholders. Used to track reporting timeliness and trigger finding response deadlines.',
    `stop_work_issued` BOOLEAN COMMENT 'Indicates whether a stop-work order was issued as a result of critical findings identified during the audit. Triggers mandatory escalation to project management and HSE leadership.',
    `team_members` STRING COMMENT 'Comma-separated list of names or employee IDs of additional audit team members who participated in the audit. Stored as a denormalised string for reporting convenience; detailed team composition is managed in Intelex.',
    `title` STRING COMMENT 'Descriptive title of the audit, summarising its scope and focus area (e.g., Q3 Site Safety Compliance Audit – Highway Project Alpha). Used for identification in reports and dashboards.',
    `total_criteria_assessed` STRING COMMENT 'Total number of audit criteria or checklist items evaluated during the audit. Used as the denominator for compliance score calculation and for comparing audit rigour across audits.',
    `total_findings` STRING COMMENT 'Total number of audit findings raised across all severity levels (non-conformances, observations, and opportunities for improvement). Provides a headline count for executive reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record in the data platform. Used for incremental load detection, change data capture, and data quality monitoring.',
    CONSTRAINT pk_safety_audit PRIMARY KEY(`safety_audit_id`)
) COMMENT 'Formal HSE audit records with embedded findings, conducted on construction sites or at corporate level. Covers compliance with OSHA regulations, ISO 45001, ISO 14001, site-specific HSE plans, and internal safety standards. Header captures audit type (internal/external/regulatory/surveillance), scope, audit team, audit date, site/project, overall compliance score, and close-out status. Finding details capture individual non-conformances, observations, and opportunities for improvement including finding type, severity, reference standard clause, responsible party, due date, and closure status. Findings link to corrective_action for formal CAPA tracking. Sourced from Intelex Audits module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`hse_inspection` (
    `hse_inspection_id` BIGINT COMMENT 'Unique system-generated identifier for each HSE inspection record. Primary key for the hse_inspection data product. Entity role: TRANSACTION_HEADER — represents a discrete field inspection event with a defined lifecycle.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: HSE inspections include equipment checks; linking inspection records to the asset enables tracking inspection status and regulatory compliance.',
    `checklist_id` BIGINT COMMENT 'Reference to the standardised checklist template used to conduct the inspection. Templates are aligned to inspection scope and regulatory requirements (e.g., OSHA scaffold checklist, excavation safety checklist).',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project against which this inspection was conducted. Links inspection records to project-level HSE performance reporting and EVM analysis. PARTY_REFERENCE category.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Inspection reports must identify the subcontractor whose work is being inspected to enforce contract HSE clauses.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: HSE inspection evaluates the HSE plan; adding a FK provides direct navigation from inspection to the plan it reviews.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the HSE officer, supervisor, or manager who conducted the inspection. Enables inspector workload tracking, competency verification, and accountability reporting. PARTY_REFERENCE category.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory Inspection Management: each HSE inspection validates compliance with a particular regulatory obligation.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element representing the work package or activity area being inspected. Aligns HSE inspection data with project schedule and cost control structures.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether one or more formal corrective actions have been raised as a result of deficiencies identified during this inspection. When True, corrective action records are linked via the corrective_action product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system. Supports audit trail and data lineage. RECORD_AUDIT_CREATED category.',
    `critical_deficiency_count` STRING COMMENT 'Number of deficiencies classified as critical or high severity — those posing immediate risk to life, health, or structural integrity. Triggers mandatory stop-work authority and escalation protocols.',
    `deficiency_count` STRING COMMENT 'Total number of distinct deficiencies or non-conformances identified during the inspection. Each deficiency may link to a corrective action record for remediation tracking.',
    `drill_evacuation_complete` BOOLEAN COMMENT 'Indicates whether all personnel in the drill area were successfully evacuated and accounted for at the muster point during an emergency drill. Null for non-drill inspection types.',
    `drill_muster_accuracy_pct` DECIMAL(18,2) COMMENT 'Percentage of expected personnel correctly accounted for at the designated muster point during an emergency drill. Expressed as a decimal percentage (e.g., 98.00 = 98%). Null for non-drill inspection types.',
    `drill_response_time_seconds` STRING COMMENT 'Measured response time in seconds from drill initiation to full muster point assembly during an emergency drill exercise. Used to assess emergency preparedness against target response time benchmarks.',
    `drill_type` STRING COMMENT 'For inspections of type emergency_drill, specifies the category of drill exercise conducted. Null for non-drill inspection types.. Valid values are `fire_evacuation|medical_emergency|spill_response|structural_collapse|muster_drill`',
    `general_observations` STRING COMMENT 'Free-text field capturing the inspectors overall field observations, positive findings, and contextual notes not captured by structured checklist items. Supports qualitative safety culture assessment.',
    `highest_deficiency_severity` STRING COMMENT 'The most severe deficiency classification recorded during the inspection. Used for risk prioritisation, escalation routing, and executive safety dashboards.. Valid values are `critical|high|medium|low|observation`',
    `immediate_action_description` STRING COMMENT 'Narrative description of any immediate corrective actions taken on site during the inspection to mitigate identified hazards or deficiencies before formal remediation.',
    `immediate_action_taken` BOOLEAN COMMENT 'Indicates whether immediate corrective action was taken on site at the time of inspection to address identified deficiencies, prior to formal corrective action workflow initiation.',
    `inspection_date` DATE COMMENT 'Calendar date on which the HSE inspection was conducted in the field. Principal real-world event date for scheduling, trending, and regulatory reporting. BUSINESS_EVENT_TIMESTAMP category.',
    `inspection_end_time` TIMESTAMP COMMENT 'Precise date and time when the inspection was concluded on site. Combined with start time to derive inspection duration for workload and thoroughness analytics.',
    `inspection_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the inspection, used in correspondence, corrective action linkage, and regulatory submissions. Sourced from Intelex Inspections module. BUSINESS_IDENTIFIER category.',
    `inspection_scope` STRING COMMENT 'Primary subject area or hazard category that the inspection focused on. Drives checklist template selection and enables trend analysis by hazard type. [ENUM-REF-CANDIDATE: housekeeping|ppe_compliance|scaffolding_formwork|excavation|crane_rigging|electrical|fire_prevention|emergency_preparedness|work_practice — promote to reference product]',
    `inspection_start_time` TIMESTAMP COMMENT 'Precise date and time when the inspection commenced on site. Used for duration calculation and scheduling compliance verification.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record. Tracks workflow progression from field data capture through review and closure. LIFECYCLE_STATUS category.. Valid values are `draft|in_progress|completed|closed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection by its purpose and trigger. Routine = scheduled periodic check; Targeted = focused on a specific hazard or area; Pre-task = conducted before high-risk work commences; Emergency drill = evacuation or emergency response exercise; Management walk = senior leadership safety observation. CLASSIFICATION_OR_TYPE category.. Valid values are `routine|targeted|pre_task|emergency_drill|management_walk`',
    `intelex_inspection_ref` STRING COMMENT 'Source system reference identifier from the Intelex HSE Management platform Inspections module. Enables traceability back to the operational system of record for audit and reconciliation purposes.',
    `is_scheduled` BOOLEAN COMMENT 'Indicates whether the inspection was pre-planned and scheduled (True) or conducted on an ad-hoc/unannounced basis (False). Supports analysis of proactive vs reactive inspection activity.',
    `items_failed` STRING COMMENT 'Number of checklist items found to be non-compliant or deficient during the inspection. Drives corrective action generation and severity classification.',
    `items_not_applicable` STRING COMMENT 'Number of checklist items marked as not applicable for the specific site conditions or work scope at the time of inspection. Ensures accurate compliance rate calculation.',
    `items_passed` STRING COMMENT 'Number of checklist items that were found to be compliant or satisfactory during the inspection. Used with total_items_checked to derive pass rate for trend reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inspection record. Supports change tracking and data governance. RECORD_AUDIT_UPDATED category.',
    `overall_result` STRING COMMENT 'Summary outcome of the inspection based on the aggregate of checklist item results and deficiency severity. Determines whether immediate stop-work or corrective action is required.. Valid values are `pass|pass_with_observations|fail|conditional_pass`',
    `photo_evidence_count` STRING COMMENT 'Number of photographs attached to the inspection record as evidence of conditions observed, deficiencies identified, or positive practices noted. Supports dispute resolution and regulatory submissions.',
    `photo_evidence_reference` STRING COMMENT 'Document management system reference or folder path pointing to photographic evidence files associated with this inspection. Typically links to Aconex or Intelex document store.',
    `ppe_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of workers observed wearing required Personal Protective Equipment (PPE) correctly at the time of inspection. Expressed as a decimal percentage (e.g., 95.50 = 95.5%). Key leading indicator for HSE performance dashboards.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the findings of this inspection require formal notification to a regulatory authority (e.g., OSHA, EPA). Triggers compliance workflow for mandatory reporting obligations.',
    `review_date` DATE COMMENT 'Date on which the completed inspection report was reviewed and approved by the responsible HSE manager. Used to measure review turnaround time and compliance with internal governance requirements.',
    `scheduled_date` DATE COMMENT 'The originally planned date for the inspection as per the HSE inspection schedule. Compared against inspection_date to identify overdue or rescheduled inspections.',
    `site_area` STRING COMMENT 'Specific physical area, zone, or work front on the construction site where the inspection was conducted (e.g., Zone A – Excavation, Level 3 Formwork, North Laydown Yard). Enables spatial analysis of safety performance.',
    `stop_work_issued` BOOLEAN COMMENT 'Indicates whether a stop-work order was issued as a result of critical deficiencies identified during the inspection. Triggers immediate escalation and mandatory corrective action before work resumes.',
    `total_items_checked` STRING COMMENT 'Total number of checklist line items assessed during the inspection. Used as the denominator for compliance rate calculations and inspection thoroughness metrics.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions recorded at the time of inspection. Relevant for contextualising safety observations, particularly for outdoor work activities such as crane operations, excavation, and scaffolding. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|extreme_heat|cold — 8 candidates stripped; promote to reference product]',
    `worker_count_observed` STRING COMMENT 'Number of workers present in the inspected area at the time of the inspection. Used to contextualise exposure levels and normalise deficiency rates per worker.',
    CONSTRAINT pk_hse_inspection PRIMARY KEY(`hse_inspection_id`)
) COMMENT 'Routine, scheduled, and ad-hoc HSE site inspection records including emergency drill exercises and management safety walks. Captures field observations of safety conditions, housekeeping, PPE compliance, equipment safety, scaffolding/formwork integrity, excavation stability, crane setup, work practice compliance, and emergency preparedness. Records inspection type (routine/targeted/emergency drill/pre-task/management walk), inspector, site area, checklist template used, pass/fail items with photographic evidence references, deficiencies noted with severity classification, immediate actions taken, and drill-specific metrics (response time, evacuation completeness, muster accuracy). Distinct from formal audits — inspections are operational field checks and exercises performed by site safety officers and supervisors. Deficiencies link to corrective_action for remediation tracking. Sourced from Intelex Inspections module.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`ppe_register` (
    `ppe_register_id` BIGINT COMMENT 'Unique system-generated identifier for each PPE issuance record in the master register. Primary key for the ppe_register data product. Entity role: MASTER_RESOURCE — represents a physical PPE item assigned to a worker.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project or site to which this PPE issuance is associated. Enables project-level PPE compliance reporting and cost allocation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PPE procurement costs must be allocated to the responsible cost_center for financial tracking and compliance reporting.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the construction worker to whom this PPE item is issued. Links to the workforce domain for worker identity, role, and trade classification. Supports per-worker PPE compliance tracking.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: PPE issuance is often recorded for a specific incident to track compliance; linking PPE register to incident consolidates records.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: PPE issuance must be signed off by the issuing employee to satisfy audit and regulatory PPE traceability.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: PPE issuance is tracked against the responsible contract party for cost recovery and safety audits.',
    `acknowledgement_date` DATE COMMENT 'Date on which the worker signed or digitally acknowledged receipt of the PPE item and understanding of its correct use. Provides legal evidence of compliance with OSHA training and issuance requirements.',
    `batch_number` STRING COMMENT 'Manufacturers batch or lot number for the PPE item. Critical for recall management — enables rapid identification of all workers issued items from a recalled batch.',
    `certification_class` STRING COMMENT 'Specific class, type, or rating within the certification standard (e.g., Type I, Type II, Class E, Class G, Level A, P100, N95, FFP3). Provides granular compliance detail beyond the standard name.',
    `certification_standard` STRING COMMENT 'Applicable safety certification or standard the PPE item is certified to (e.g., ANSI Z87.1-2020, ANSI/ISEA Z89.1 Type II Class E, EN 166:2002, AS/NZS 1801:1997, NIOSH TC-84A, ANSI/ASSE Z359.1). Validates regulatory compliance of the item.',
    `colour` STRING COMMENT 'Colour of the PPE item. Used for site-specific colour-coding schemes (e.g., hard hat colour denoting trade or visitor status) and high-visibility garment compliance verification.',
    `compliance_status` STRING COMMENT 'Overall regulatory and site-policy compliance status of this PPE issuance record. non_compliant triggers corrective action in Intelex. Used for OSHA 1926 Subpart E and ISO 45001 compliance reporting.. Valid values are `compliant|non_compliant|pending_inspection|expired|recalled`',
    `condition_status` STRING COMMENT 'Current physical condition assessment of the PPE item as determined during the most recent inspection. condemned indicates the item must be immediately withdrawn from service. Drives replacement and corrective action workflows.. Valid values are `serviceable|requires_inspection|damaged|condemned|lost`',
    `cost_code` STRING COMMENT 'Project cost code or Work Breakdown Structure (WBS) element to which the PPE cost is allocated. Enables job costing and HSE cost tracking in SAP S/4HANA Project Systems and Viewpoint Vista.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PPE register record was first created in the system. Provides audit trail for record creation and supports data lineage in the Databricks lakehouse silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit_cost value (e.g., USD, AUD, GBP). Required for multi-currency project environments.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Date on which the PPE item expires or must be replaced, based on manufacturers shelf-life, regulatory requirements, or site policy. Null for items with no fixed expiry. Drives automated replacement scheduling and compliance alerts.',
    `fit_test_date` DATE COMMENT 'Date on which the most recent fit test was conducted for this PPE item and worker combination. Applicable to tight-fitting respirators. Null if fit_test_required is False.',
    `fit_test_required` BOOLEAN COMMENT 'Indicates whether a formal fit test is required for this PPE item (True for tight-fitting respirators per OSHA 29 CFR 1910.134, False for loose-fitting or non-respiratory items). Drives fit-test scheduling workflows.',
    `hazard_type` STRING COMMENT 'Primary workplace hazard that this PPE item is intended to protect against (e.g., falling objects, chemical splash, noise above 85dB, fall from height, electrical arc flash). Links PPE issuance to the hazard register and SWMS requirements.',
    `inspection_frequency_days` STRING COMMENT 'Required interval in calendar days between formal inspections of this PPE item, as mandated by the applicable standard or site HSE policy (e.g., 30 days for fall-arrest harnesses, 90 days for hard hats). Drives next_inspection_date calculation.',
    `inspection_notes` STRING COMMENT 'Free-text notes recorded during the most recent inspection, describing observed condition, defects, or maintenance actions taken. Supports audit trail and corrective action documentation in Intelex.',
    `intelex_record_reference` STRING COMMENT 'Source system record identifier from the Intelex HSE Management platform for this PPE issuance record. Enables data lineage traceability and reconciliation between the lakehouse silver layer and the operational system of record.',
    `issuance_status` STRING COMMENT 'Current lifecycle status of this PPE issuance record. Tracks whether the item is currently issued to the worker, has been returned, replaced, condemned, or reported lost. Distinct from condition_status (physical state) and compliance_status (regulatory state).. Valid values are `issued|returned|replaced|condemned|lost`',
    `issue_date` DATE COMMENT 'Date on which the PPE item was formally issued to the assigned worker. Marks the start of the items service life for the worker and triggers replacement scheduling calculations.',
    `item_code` STRING COMMENT 'Unique catalogue or stock-keeping code identifying the specific PPE item type in the materials management system (SAP S/4HANA Materials Management). Used for procurement, inventory, and replacement scheduling.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `item_name` STRING COMMENT 'Human-readable name of the PPE item (e.g., Hard Hat Type II, Safety Harness Full Body, Anti-Fog Safety Goggles). Used in reports, compliance dashboards, and worker-facing documentation.',
    `item_type` STRING COMMENT 'Specific type or sub-classification of the PPE item within its category (e.g., Full-Face Respirator, Half-Mask Respirator, P100 Filter, Class E Hard Hat, Cut-Resistant Glove Level 4). Provides granular classification for hazard-specific compliance checks.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection or condition assessment of the PPE item. Supports periodic inspection scheduling and compliance verification per OSHA and ISO 45001 requirements.',
    `manufacture_date` DATE COMMENT 'Date of manufacture as stated on the PPE item or packaging. Used to calculate age-based retirement for items such as hard hats (typically 5-year service life from manufacture) and harnesses.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or brand of the PPE item (e.g., 3M, MSA Safety, Honeywell, DuPont). Used for recall management, warranty claims, and supplier performance tracking.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the PPE item. Enables precise identification for reordering, recall tracking, and certification verification.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next formal inspection of the PPE item. Calculated from last inspection date and inspection frequency policy. Drives proactive compliance scheduling in Intelex.',
    `ppe_category` STRING COMMENT 'Primary body-protection category of the PPE item per OSHA 1926 Subpart E classification. Drives category-level compliance monitoring and ensures all hazard zones are covered. [ENUM-REF-CANDIDATE: head|eye_face|hearing|respiratory|fall_protection|hand|foot|body|high_visibility — promote to reference product]',
    `purchase_order_number` STRING COMMENT 'Reference to the Purchase Order (PO) under which this PPE item was procured. Links to the procurement domain for supplier and delivery traceability. Sourced from SAP S/4HANA MM.',
    `replacement_date` DATE COMMENT 'Date on which the PPE item was replaced with a new item, either due to expiry, damage, or scheduled replacement. Links to the new issuance record for traceability.',
    `return_date` DATE COMMENT 'Date on which the PPE item was returned by the worker (e.g., upon project completion, employment termination, or item replacement). Null if item is still in active use. Closes the issuance lifecycle.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for individually serialised PPE items such as fall-arrest harnesses, self-retracting lifelines, and SCBA units. Null for non-serialised consumable items (gloves, disposable respirators). Critical for fall-protection equipment traceability per OSHA 1926.502.',
    `service_life_months` STRING COMMENT 'Maximum service life of the PPE item in months from manufacture date, as specified by the manufacturer or applicable standard (e.g., 60 months for hard hats per ANSI Z89.1, 120 months for harnesses per ANSI Z359.1). Used to calculate mandatory retirement date.',
    `site_location` STRING COMMENT 'Specific site, zone, or work area within the project where the PPE item is assigned for use (e.g., Zone A - Excavation, Level 3 - Formwork, Substation Building). Supports site-specific PPE requirement enforcement.',
    `size` STRING COMMENT 'Size designation of the PPE item as issued to the worker (e.g., M, L, XL, universal). Ensures correct fit for effective protection. Incorrect sizing is a common compliance failure. [ENUM-REF-CANDIDATE: XS|S|M|L|XL|XXL|XXXL|universal|custom — 9 candidates stripped; promote to reference product]',
    `training_completed` BOOLEAN COMMENT 'Indicates whether the assigned worker has completed the required PPE usage and maintenance training for this item type (True/False). Mandatory for compliance with OSHA 1926 Subpart E and ISO 45001 competency requirements.',
    `training_date` DATE COMMENT 'Date on which the worker completed PPE training for this item type. Used to verify training currency and schedule refresher training. Sourced from SAP SuccessFactors Learning module.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Procurement cost per unit of the PPE item in the projects base currency. Used for PPE budget tracking, cost allocation to project cost codes, and replacement cost forecasting. Sourced from SAP S/4HANA Materials Management purchase orders.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this PPE register record. Supports change tracking, incremental data loading in the lakehouse, and audit compliance.',
    `worker_acknowledgement` BOOLEAN COMMENT 'Indicates whether the worker has formally acknowledged receipt and understanding of correct usage requirements for this PPE item (True/False). Signed acknowledgement is a legal requirement under OSHA 1926 Subpart E and site HSE procedures.',
    CONSTRAINT pk_ppe_register PRIMARY KEY(`ppe_register_id`)
) COMMENT 'Master register of Personal Protective Equipment (PPE) items issued to construction workers. Tracks PPE category (head/eye/hearing/respiratory/fall/hand/foot), specific item type, standard/certification (ANSI Z87, EN 166, AS/NZS 1801), serial number where applicable, issue date, expiry/replacement date, condition assessment, assigned worker, project/site, and compliance status. Supports PPE compliance monitoring, replacement scheduling, and ensures workers are equipped per OSHA 1926 Subpart E and site-specific requirements. Links to workforce domain for worker identity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`hse_plan` (
    `hse_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the project-level HSE Plan record. Primary key for the hse_plan data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: HSE plans are contract‑specific documents required for client‑mandated safety standards and regulatory approvals.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: HSE plans are client‑specific documents; associating them with the client account enables client‑wide HSE performance dashboards.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this HSE Plan is the governing safety management framework document.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: HSE plan budgeting is tracked per cost_center; linking enables consolidation of HSE expenditures in financial statements.',
    `design_scope_id` BIGINT COMMENT 'Foreign key linking to design.design_scope. Business justification: HSE plans are aligned to the approved design scope; linking ensures plan coverage matches design deliverables.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the Project HSE Manager who is the primary responsible party for implementing and maintaining this HSE Plan on the project.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Project HSE plans are subcontractor‑specific; linking to the firm enables compliance tracking and audit.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: HSE Plan Compliance Mapping: HSE plans are authored to address specific regulatory obligations.',
    `sustainability_plan_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_plan. Business justification: Integrated HSE and sustainability planning aligns safety objectives with sustainability goals; linking HSE plan to its corresponding sustainability plan supports coordinated target tracking.',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of regulatory frameworks, standards, and governing body requirements applicable to this HSE Plan (e.g., OSHA 29 CFR 1926, ISO 45001:2018, ISO 14001:2015, NFPA 70E, local jurisdiction building codes). Drives compliance obligation tracking.',
    `approval_date` DATE COMMENT 'Date on which the HSE Plan was formally approved by the authorised approver (typically the Project HSE Manager or Client representative). Marks the transition from draft/review to approved status.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorised person who formally approved this version of the HSE Plan. Typically the Project Director, HSE Director, or Client HSE Representative.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which formal HSE audits must be conducted on the project as specified in the HSE Plan. Drives the audit schedule in Intelex and ensures compliance with ISO 45001 internal audit requirements.',
    `client_hse_requirements` STRING COMMENT 'Summary of client-specific HSE requirements and standards that must be incorporated into the project HSE Plan, beyond the contractors standard requirements. Sourced from the contract HSE specification or client HSE management system.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which the construction site operates. Determines the applicable national HSE regulatory framework (e.g., USA, GBR, AUS, ARE).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HSE Plan record was first created in the system. Provides audit trail for record creation and supports data lineage tracking in the Databricks Silver Layer.',
    `document_reference` STRING COMMENT 'Document management system reference or URL pointing to the full HSE Plan document stored in Aconex or the project document management system. Provides traceability to the source document.',
    `effective_date` DATE COMMENT 'Date from which this version of the HSE Plan becomes the binding governing document for the project. Aligns with the Notice to Proceed (NTP) or project mobilisation date for initial versions.',
    `emergency_contact_name` STRING COMMENT 'Name of the primary emergency response coordinator or HSE emergency contact for the project site. Referenced during incident response and emergency drills.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number for the site emergency response coordinator. Must be accessible 24/7 during active construction phases for incident notification and emergency mobilisation.',
    `environmental_aspects` STRING COMMENT 'Description of the significant environmental aspects and impacts identified for the project (e.g., noise, dust, stormwater runoff, waste management, soil contamination, protected species). Informs the environmental management controls within the HSE Plan.',
    `expiry_date` DATE COMMENT 'Date on which this version of the HSE Plan expires and must be reviewed or superseded. Nullable for open-ended plans that remain valid until explicitly superseded.',
    `hse_objective_description` STRING COMMENT 'Narrative description of the project-level HSE objectives and targets established for this plan period (e.g., zero LTI, TRIR below 0.5, 100% PPE compliance, zero environmental non-conformances). Aligns with corporate HSE KPI framework.',
    `incident_reporting_procedure` STRING COMMENT 'Description or document reference number for the incident reporting and investigation procedure defined in the HSE Plan. Specifies notification timelines, investigation requirements, and regulatory reporting obligations (e.g., OSHA 300 log, fatality notification within 8 hours).',
    `induction_required` BOOLEAN COMMENT 'Indicates whether all personnel must complete a formal site HSE induction before commencing work on the project, as mandated by the HSE Plan. When true, no worker may access the site without a valid induction record.',
    `leed_applicable` BOOLEAN COMMENT 'Indicates whether the project is targeting LEED (Leadership in Energy and Environmental Design) certification, which imposes additional environmental management requirements on the HSE Plan including construction waste management, indoor air quality, and erosion control.',
    `lti_target` DECIMAL(18,2) COMMENT 'Target number of Lost Time Injuries (LTI) for the project duration as defined in the HSE Plan. Typically set to zero for major construction projects. Used as a benchmark for HSE performance reporting.',
    `muster_point_description` STRING COMMENT 'Description and location of the designated emergency assembly/muster point(s) for the construction site. Critical for emergency evacuation procedures and headcount verification.',
    `nearest_hospital` STRING COMMENT 'Name and address of the nearest hospital or medical facility to the construction site. Mandatory field for emergency response planning and first aid procedures documentation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the HSE Plan. Drives the review calendar and ensures the plan remains current with site conditions, regulatory changes, and project phase transitions.',
    `plan_number` STRING COMMENT 'Externally-known unique document control number assigned to the HSE Plan, used for referencing in correspondence, audits, and regulatory submissions. Typically follows the project document numbering convention (e.g., HSE-PRJ001-2024-001).. Valid values are `^HSE-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the HSE Plan document. Controls whether the plan is the active governing document for site operations. approved indicates the plan is the current SSOT for project HSE governance.. Valid values are `draft|under_review|approved|superseded|cancelled`',
    `plan_title` STRING COMMENT 'Official title of the HSE Plan document as it appears on the cover page and in the document register (e.g., Project HSE Management Plan — Highway 7 Extension).',
    `plan_type` STRING COMMENT 'Classification of the HSE Plan by scope and purpose. Distinguishes between overarching project-level plans, site-specific plans, environmental management plans, emergency response plans, and construction phase plans. [ENUM-REF-CANDIDATE: project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan|occupational_health_plan — promote to reference product]. Valid values are `project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan`',
    `plan_version` STRING COMMENT 'Document version number of the HSE Plan following the project document control versioning convention (e.g., 1.0, 2.1, 3.0). Incremented upon each approved revision.. Valid values are `^[0-9]{1,3}.[0-9]{1,2}$`',
    `ppe_requirements` STRING COMMENT 'Description of the mandatory Personal Protective Equipment (PPE) requirements applicable across the project site as defined in the HSE Plan (e.g., hard hat, safety boots, hi-vis vest, safety glasses, gloves). Site-wide minimum PPE standard.',
    `prepared_by` STRING COMMENT 'Name or employee identifier of the HSE professional who authored and prepared this version of the HSE Plan. Typically the Project HSE Manager or HSE Coordinator.',
    `project_phase` STRING COMMENT 'Construction project phase to which this HSE Plan version primarily applies. HSE requirements and hazard profiles differ significantly across project phases.. Valid values are `pre_construction|mobilisation|construction|commissioning|demobilisation`',
    `ptw_required` BOOLEAN COMMENT 'Indicates whether a formal Permit to Work (PTW) system is mandated on this project as per the HSE Plan. When true, designated high-risk activities (hot work, confined space entry, electrical isolation, working at height) require a PTW before commencement.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which the HSE Plan must be formally reviewed and updated. Typically 6 or 12 months, or triggered by significant project phase changes, incidents, or regulatory updates.',
    `risk_rating` STRING COMMENT 'Overall HSE risk rating assigned to the project based on the site hazard assessment. Drives the level of HSE oversight, inspection frequency, and resource allocation required.. Valid values are `low|medium|high|critical`',
    `site_location` STRING COMMENT 'Physical address or geographic description of the primary construction site covered by this HSE Plan. Used for emergency response coordination and regulatory jurisdiction determination.',
    `site_specific_hazards` STRING COMMENT 'Narrative description of the key site-specific hazards identified for this project (e.g., working at height, confined spaces, high-voltage proximity, ground contamination, extreme weather, traffic management). Informs the risk control hierarchy documented in the plan.',
    `subcontractor_hse_requirements` STRING COMMENT 'Description of the HSE requirements imposed on subcontractors working under this project HSE Plan, including pre-qualification criteria, SWMS submission requirements, induction obligations, and compliance monitoring expectations.',
    `swms_required` BOOLEAN COMMENT 'Indicates whether Safe Work Method Statements (SWMS) are mandated for high-risk construction work activities on this project as per the HSE Plan. When true, SWMS must be prepared and approved before commencing designated high-risk activities.',
    `tbm_frequency` STRING COMMENT 'Required frequency of Toolbox Meetings (TBM) as mandated by the HSE Plan. TBMs are pre-work safety briefings conducted with the workforce to communicate hazards, controls, and daily work instructions.. Valid values are `daily|weekly|per_shift|as_required`',
    `trir_target` DECIMAL(18,2) COMMENT 'Target Total Recordable Incident Rate (TRIR) for the project as defined in the HSE Plan. Expressed per 200,000 man-hours worked. Used as the primary lagging indicator for HSE performance benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HSE Plan record was last modified in the system. Supports change tracking, audit trail requirements, and incremental data loading in the Databricks Silver Layer.',
    CONSTRAINT pk_hse_plan PRIMARY KEY(`hse_plan_id`)
) COMMENT 'Project-level HSE (Health Safety Environment) Plan master record defining the safety management framework for a specific construction project. Captures plan version, approval status, applicable regulations, site-specific hazards, emergency response procedures, HSE objectives and targets, organizational responsibilities, and review schedule. SSOT for project HSE governance documentation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each risk assessment record in the hazard and risk register. Primary key for the risk_assessment data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Risk assessments are tied to the contract agreement to align risk registers with contractual obligations and insurance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Risk assessments for tasks must reference the exact equipment used to evaluate equipment‑related risks and control measures.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Risk assessments are performed for client projects; linking to the client account allows aggregation of risk metrics at the client level.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project against which this risk assessment is registered. Links the hazard record to the project portfolio.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Risk mitigation actions have budgeted costs; assigning a cost_center allows integration with risk‑based budgeting reports.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor organisation whose workforce or activities are subject to this risk assessment. Supports subcontractor HSE performance monitoring and compliance tracking.',
    `incident_id` BIGINT COMMENT 'Reference to an incident or near-miss record that triggered or is associated with this risk assessment. Enables bidirectional traceability between incidents and the hazard register.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Risk assessments evaluate hazards of specific materials; linking provides material specs for accurate risk calculations.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Risk assessments assign a responsible employee; required for accountability and HSE audit trails.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element or work package to which this hazard and risk assessment applies, enabling task-level risk traceability.',
    `activity_description` STRING COMMENT 'Description of the specific construction activity, task, or work scope during which the hazard is present or could be realised. Supports Job Hazard Analysis (JHA) documentation.',
    `approval_date` DATE COMMENT 'Date on which the risk assessment was formally reviewed and approved by the authorised approver.',
    `approved_by` STRING COMMENT 'Name of the authorised approver (typically HSE Manager or Project Manager) who reviewed and formally approved this risk assessment record.',
    `assessed_by` STRING COMMENT 'Name of the HSE professional, engineer, or competent person who conducted and documented this risk assessment.',
    `assessment_date` DATE COMMENT 'The date on which this risk assessment was formally conducted and documented. Represents the principal business event date for this record.',
    `assessment_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to this risk assessment record, used in SWMS, PTW, and HSE correspondence. Format: RA-{ProjectCode}-{Sequence}.. Valid values are `^RA-[A-Z0-9]{3,10}-[0-9]{4,6}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment record: Open (hazard identified, controls not yet fully implemented), Controlled (controls in place, residual risk tolerable), Eliminated (hazard fully removed), Closed (no longer applicable), or Under Review (being reassessed).. Valid values are `open|controlled|eliminated|closed|under_review`',
    `assessment_type` STRING COMMENT 'Classification of the purpose and context of this risk assessment: Job Hazard Analysis (JHA) for task-level evaluation, SWMS support, PTW issuance support, design review, field inspection, or derived from an incident investigation.. Valid values are `jha|swms|ptw_support|design_review|inspection|incident_derived`',
    `control_hierarchy` STRING COMMENT 'Highest level of the Hierarchy of Controls applied to this hazard: Eliminate, Substitute, Engineering controls, Administrative controls, or Personal Protective Equipment (PPE). Reflects the most effective control measure in place.. Valid values are `eliminate|substitute|engineering|administrative|ppe`',
    `control_measures` STRING COMMENT 'Detailed narrative of all control measures implemented to eliminate or reduce the risk, including engineering controls, administrative procedures, PPE requirements, and any combination of controls applied.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action has been raised against this risk assessment due to inadequate controls or elevated residual risk (True = corrective action required). Triggers workflow in Intelex.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system. Supports audit trail and data lineage requirements.',
    `environmental_aspect` BOOLEAN COMMENT 'Indicates whether this risk assessment includes an environmental aspect or impact in addition to occupational health and safety considerations (True = environmental component present). Supports ISO 14001 compliance.',
    `environmental_impact_description` STRING COMMENT 'Description of the environmental impact or aspect associated with this hazard, where applicable (e.g., soil contamination from chemical spill, noise pollution, stormwater runoff). Populated when environmental_aspect is True.',
    `hazard_description` STRING COMMENT 'Detailed narrative description of the identified hazard, including the source, agent, or condition that has the potential to cause harm or adverse health effects.',
    `hazard_type` STRING COMMENT 'Classification of the hazard category identified in this assessment. [ENUM-REF-CANDIDATE: fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure|environmental|fire_explosion|manual_handling|noise_vibration|biological|radiation — promote to reference product]',
    `initial_consequence` STRING COMMENT 'Consequence/severity score assigned before control measures are applied, rated on the project risk matrix scale (typically 1–5: 1=Insignificant, 2=Minor, 3=Moderate, 4=Major, 5=Catastrophic).',
    `initial_likelihood` STRING COMMENT 'Likelihood score assigned before control measures are applied, rated on the project risk matrix scale (typically 1–5: 1=Rare, 2=Unlikely, 3=Possible, 4=Likely, 5=Almost Certain).',
    `initial_risk_level` STRING COMMENT 'Qualitative risk band derived from the initial risk score using the project risk matrix (e.g., Low, Medium, High, Extreme). Used for prioritisation and reporting before controls are applied.. Valid values are `low|medium|high|extreme`',
    `initial_risk_score` STRING COMMENT 'Pre-control risk score calculated as the product of initial likelihood and initial consequence ratings (Likelihood × Consequence). Represents the inherent risk level before any controls are applied.',
    `intelex_record_reference` STRING COMMENT 'Unique identifier of the corresponding record in the Intelex HSE Management system, used for data lineage, reconciliation, and cross-system traceability between the lakehouse and the operational system of record.',
    `last_reviewed_date` DATE COMMENT 'Date on which this risk assessment record was most recently reviewed and updated. Supports audit trail and demonstrates ongoing management of the living hazard register.',
    `linked_ptw_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) issued in conjunction with this risk assessment. Supports traceability between hazard controls and formal work authorisation.',
    `linked_swms_number` STRING COMMENT 'Reference number of the Safe Work Method Statement (SWMS) document that was developed using or references this risk assessment. Enables traceability between risk assessments and SWMS documentation.',
    `next_review_date` DATE COMMENT 'Scheduled date by which this risk assessment must be reviewed and updated to ensure continued relevance and effectiveness of control measures. Triggered by elapsed time, scope change, or incident.',
    `ppe_requirements` STRING COMMENT 'Specific Personal Protective Equipment (PPE) items mandated for personnel performing the activity associated with this hazard (e.g., hard hat, safety harness, chemical-resistant gloves, respirator, safety glasses).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard, clause, or legal obligation that this risk assessment addresses (e.g., OSHA 29 CFR 1926.502 Fall Protection, ISO 45001 Clause 6.1.2, EPA 40 CFR). Supports compliance reporting.',
    `residual_consequence` STRING COMMENT 'Consequence/severity score after all control measures have been applied, rated on the project risk matrix scale (typically 1–5). Reflects the remaining severity of harm post-control.',
    `residual_likelihood` STRING COMMENT 'Likelihood score after all control measures have been applied, rated on the project risk matrix scale (typically 1–5). Reflects the remaining probability of the hazard being realised post-control.',
    `residual_risk_level` STRING COMMENT 'Qualitative risk band derived from the residual risk score using the project risk matrix (e.g., Low, Medium, High, Extreme). Determines whether the risk is tolerable and whether additional controls are required.. Valid values are `low|medium|high|extreme`',
    `residual_risk_score` STRING COMMENT 'Post-control risk score calculated as the product of residual likelihood and residual consequence ratings (Likelihood × Consequence). Represents the remaining risk after all controls are applied.',
    `responsible_party_role` STRING COMMENT 'Job role or organisational function of the person responsible for implementing and monitoring the control measures associated with this risk assessment.. Valid values are `hse_officer|site_supervisor|project_manager|subcontractor|engineer|foreman`',
    `risk_matrix_version` STRING COMMENT 'Version identifier of the project or corporate risk matrix used to score likelihood and consequence for this assessment. Ensures consistent interpretation of risk scores across assessments and over time.',
    `site_zone` STRING COMMENT 'Specific site area, zone, level, or grid reference where the hazard exists or the activity is performed (e.g., Zone A, Level 3, Grid B4, Excavation Area 2).',
    `source_type` STRING COMMENT 'Origin or trigger that led to the identification and recording of this hazard — e.g., field inspection, incident investigation, design review, JHA session, HSE audit, near-miss report, or Toolbox Meeting (TBM). [ENUM-REF-CANDIDATE: inspection|incident|design_review|jha|audit|near_miss|toolbox_meeting — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was most recently modified. Supports change tracking, audit trail, and the living hazard register update cycle.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Unified hazard and risk register serving as the single source of truth for all identified hazards and their risk evaluations across construction project sites. Captures hazard identification (type: fall, struck-by, caught-between, electrocution, excavation collapse, chemical exposure, environmental), activity/task scope, site location/zone, initial risk rating (likelihood x consequence matrix), control hierarchy applied (eliminate/substitute/engineer/admin/PPE), residual risk rating, control measures in place, responsible party, status (open/controlled/eliminated/closed), source (inspection/incident/design review/JHA), review date, and approver. Serves triple purpose: (1) formal risk assessment for specific activities supporting SWMS development and PTW issuance, (2) live site hazard inventory (hazard register) supporting daily pre-start briefings and toolbox meeting topic selection, and (3) Job Hazard Analysis (JHA) documentation for task-level risk evaluation. Maintains hazard register entries as living records updated through inspections, incidents, and periodic reviews. SSOT for all identified hazards, risk evaluations, and control effectiveness across the project portfolio.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`hazard_register` (
    `hazard_register_id` BIGINT COMMENT 'Unique system-generated identifier for each hazard record in the site hazard register. Primary key for the hazard_register data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Hazard registers are linked to the governing contract agreement for compliance reporting and contractual risk allocation.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Hazard register tracks equipment‑specific hazards to manage risk and comply with safety regulations.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project on which this hazard was identified. Links the hazard to the project master record for site-level hazard visibility and project-level HSE reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hazard mitigation budgets are charged to specific cost_centers; linking enables hazard‑related cost roll‑up in financial statements.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor whose work activities are the primary source of or are most exposed to this hazard. Supports subcontractor HSE performance monitoring and pre-qualification compliance.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Captures which employee identified a hazard; essential for traceability in incident investigations.',
    `incident_id` BIGINT COMMENT 'Reference to an incident record in the Intelex HSE system that triggered or is associated with this hazard entry. Enables traceability between reactive incident data and proactive hazard management records.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Required for Hazard Register to associate each hazard entry with the master material record for regulatory reporting and traceability.',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site where the hazard exists. Supports site-level hazard visibility and pre-start briefing content selection.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element associated with the work activity generating this hazard. Enables linkage between hazard exposure and project schedule activities in Oracle Primavera P6.',
    `actual_closure_date` DATE COMMENT 'Date on which the hazard was verified as eliminated or controlled to an acceptable residual risk level and the record was formally closed. Null if the hazard remains open or controlled.',
    `affected_workers_count` STRING COMMENT 'Estimated number of workers potentially exposed to this hazard during normal site operations. Used for exposure assessment, risk prioritisation, and OSHA regulatory reporting.',
    `control_measures_description` STRING COMMENT 'Narrative description of all control measures currently in place to manage the hazard, including engineering controls, administrative procedures, PPE requirements, and permit conditions. Sourced from Intelex corrective actions and SWMS documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the hazard record was first created in the data platform. Supports audit trail, data lineage, and regulatory record-keeping requirements.',
    `environmental_aspect` BOOLEAN COMMENT 'Indicates whether this hazard also constitutes an environmental aspect with potential environmental impact (e.g., chemical spill risk, dust generation, noise pollution). True = environmental aspect present. Supports ISO 14001 environmental management integration.',
    `hazard_category` STRING COMMENT 'Broad category grouping the hazard by agent type for aggregate HSE reporting and trend analysis. Supports ISO 45001 hazard identification and risk assessment processes.. Valid values are `physical|chemical|biological|ergonomic|environmental|psychosocial`',
    `hazard_description` STRING COMMENT 'Detailed narrative describing the nature of the hazard, the conditions under which it exists, and the potential harm it could cause. Supports risk assessment documentation and SWMS (Safe Work Method Statement) preparation.',
    `hazard_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the hazard record, used in HSE correspondence, toolbox meeting (TBM) briefings, and regulatory submissions. Sourced from Intelex HSE Management system.. Valid values are `^HAZ-[A-Z0-9]{3,10}-[0-9]{4,6}$`',
    `hazard_status` STRING COMMENT 'Current lifecycle status of the hazard record. open = identified but controls not yet fully implemented; controlled = controls in place and residual risk is tolerable; eliminated = hazard has been fully removed; closed = record closed after verification. Drives the live hazard inventory for site visibility.. Valid values are `open|controlled|eliminated|closed`',
    `hazard_title` STRING COMMENT 'Short, human-readable title describing the hazard (e.g., Unguarded floor opening — Level 3, Overhead power line proximity — Zone B). Used in pre-start briefings and toolbox meeting topic selection.',
    `hazard_type` STRING COMMENT 'Classification of the hazard by primary injury mechanism aligned with OSHA Fatal Four and construction industry taxonomy. Values: fall (working at height), struck_by (moving objects/vehicles), caught_between (pinch/crush points), electrocution (electrical contact), excavation_collapse (trench/shoring failure), chemical_exposure (hazardous substances). [ENUM-REF-CANDIDATE: fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure|fire_explosion|noise|manual_handling|biological — promote to reference product]. Valid values are `fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure`',
    `hierarchy_of_controls` STRING COMMENT 'Highest level of the hierarchy of controls applied to manage this hazard, per ISO 45001 and OSHA guidance. Values: elimination (remove hazard), substitution (replace with lesser hazard), engineering (physical barriers/guards), administrative (procedures/training), ppe (Personal Protective Equipment). Drives control effectiveness assessment.. Valid values are `elimination|substitution|engineering|administrative|ppe`',
    `identification_source` STRING COMMENT 'The originating activity or process through which the hazard was identified. Supports root-cause analysis and evaluation of hazard identification program effectiveness. Values: risk_assessment, inspection, incident, audit, near_miss, worker_report.. Valid values are `risk_assessment|inspection|incident|audit|near_miss|worker_report`',
    `identified_date` DATE COMMENT 'Calendar date on which the hazard was first identified and recorded. Used for ageing analysis, regulatory compliance timelines, and trend reporting.',
    `initial_consequence_rating` STRING COMMENT 'Numeric consequence/severity score assigned during initial risk assessment before controls are applied, typically on a 1–5 scale (1=Insignificant, 5=Catastrophic). Component of the initial risk rating matrix (likelihood × consequence).',
    `initial_likelihood_rating` STRING COMMENT 'Numeric likelihood score assigned during initial risk assessment before controls are applied, typically on a 1–5 scale (1=Rare, 5=Almost Certain). Component of the initial risk rating matrix (likelihood × consequence).',
    `initial_risk_level` STRING COMMENT 'Qualitative risk band derived from the initial risk score (e.g., low, medium, high, critical). Used for risk prioritisation, escalation thresholds, and executive HSE dashboards.. Valid values are `low|medium|high|critical`',
    `initial_risk_score` STRING COMMENT 'Pre-control risk score calculated as the product of initial_likelihood_rating × initial_consequence_rating. Represents the inherent risk level before any control measures are applied. Used to prioritise hazard treatment actions.',
    `intelex_record_reference` STRING COMMENT 'Source system record identifier from the Intelex HSE Management platform. Used for data lineage, reconciliation, and bi-directional synchronisation between the Databricks Silver layer and the operational Intelex system.',
    `last_review_date` DATE COMMENT 'Date on which the hazard record was most recently reviewed and updated by the responsible HSE officer or site supervisor. Supports periodic review compliance requirements under ISO 45001 and regulatory obligations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the hazard record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `location_description` STRING COMMENT 'Free-text description of the precise physical location of the hazard within the site zone (e.g., North face of pier 3, 2m from edge, Adjacent to transformer substation). Complements site_zone for field navigation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this hazard record. Drives automated review reminders and overdue review reporting in the Intelex HSE system.',
    `permit_to_work_required` BOOLEAN COMMENT 'Indicates whether a Permit to Work (PTW) is mandatory before any work activity associated with this hazard can commence. True = PTW required (e.g., confined space entry, hot work, electrical isolation). Integrates with Intelex Permit to Work module.',
    `ppe_requirements` STRING COMMENT 'Specific PPE items mandated for workers operating in proximity to this hazard (e.g., Hard hat, safety harness, hi-vis vest, safety glasses). Supports PPE compliance checks during pre-start briefings and site inspections.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this hazard requires formal notification to a regulatory authority (e.g., OSHA, EPA) due to its nature or severity. True = notification required. Supports regulatory compliance workflow management.',
    `residual_consequence_rating` STRING COMMENT 'Numeric consequence/severity score after all control measures have been applied, on the same 1–5 scale as initial_consequence_rating. Reflects the effectiveness of controls in reducing severity of potential harm.',
    `residual_likelihood_rating` STRING COMMENT 'Numeric likelihood score after all control measures have been applied, on the same 1–5 scale as initial_likelihood_rating. Reflects the effectiveness of controls in reducing probability of harm.',
    `residual_risk_level` STRING COMMENT 'Qualitative risk band derived from the residual risk score after controls are applied. Determines whether the hazard is tolerable (low/medium) or requires escalation and further treatment (high/critical).. Valid values are `low|medium|high|critical`',
    `residual_risk_score` STRING COMMENT 'Post-control risk score calculated as residual_likelihood_rating × residual_consequence_rating. Represents the remaining risk after controls are applied. Used to determine if the risk is tolerable or requires further treatment.',
    `responsible_party` STRING COMMENT 'Name or role of the individual or team accountable for implementing and maintaining the control measures for this hazard (e.g., Site Supervisor — Civil Works, HSE Manager). Supports accountability tracking and corrective action follow-up.',
    `site_zone` STRING COMMENT 'Designated zone, area, or work front on the construction site where the hazard is located (e.g., Zone A — Excavation, Level 4 — Formwork, Laydown Area 2). Used for spatial hazard mapping and pre-start briefing targeting.',
    `swms_reference` STRING COMMENT 'Document reference number of the Safe Work Method Statement (SWMS) that addresses this hazard and its control measures. Links the hazard register to the SWMS document library in Aconex or Procore.',
    `target_closure_date` DATE COMMENT 'Target date by which the hazard is expected to be eliminated or reduced to a tolerable residual risk level. Used for corrective action scheduling and overdue hazard reporting.',
    `tbm_topic_flag` BOOLEAN COMMENT 'Indicates whether this hazard has been selected or is recommended as a topic for an upcoming Toolbox Meeting (TBM). True = flagged for TBM discussion. Supports automated TBM topic selection from the live hazard register.',
    CONSTRAINT pk_hazard_register PRIMARY KEY(`hazard_register_id`)
) COMMENT 'Site-level hazard register maintaining a live inventory of identified hazards across construction project sites. Captures hazard type (fall, struck-by, caught-between, electrocution, excavation collapse, chemical exposure), location/zone, initial risk rating (likelihood x consequence), control measures in place, hierarchy of controls applied, responsible party, status (open/controlled/eliminated/closed), last review date, and source (risk assessment/inspection/incident). Serves as the operational SSOT for site hazard visibility, supports daily pre-start briefings, and feeds toolbox meeting topic selection.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` (
    `environmental_monitoring_id` BIGINT COMMENT 'Primary key for environmental_monitoring',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project at which this environmental monitoring measurement was taken. Links monitoring records to project-level environmental compliance tracking.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Environmental monitoring often targets a specific hazard; linking to hazard_register enables hazard‑centric reporting.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Environmental monitoring must record the employee overseeing the measurement for regulatory compliance.',
    `site_id` BIGINT COMMENT 'Reference to the specific construction site where the environmental measurement was recorded. Supports site-level environmental permit compliance and regulatory reporting.',
    `corrective_action_reference` STRING COMMENT 'Reference number of the corrective action record raised in Intelex HSE management system in response to this monitoring exceedance. Provides traceability between the environmental measurement and the remediation workflow.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action has been raised or is required as a result of this monitoring record. True = corrective action initiated in Intelex; False = no corrective action required. Populated automatically when exceedance_flag is True or manually by the HSE officer.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this environmental monitoring record was first created and entered into the system (Intelex or source system). Audit trail field for data governance and regulatory record-keeping requirements.',
    `data_quality_flag` STRING COMMENT 'Quality assurance flag indicating the reliability and validity of the measurement value. Suspect indicates potential instrument malfunction or anomalous conditions; Below Detection Limit indicates the parameter was not detectable at the instruments minimum detection level. Used in QA/QC review.. Valid values are `valid|suspect|invalid|estimated|below_detection_limit`',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum detection limit (MDL) of the instrument or analytical method for this parameter, expressed in the same unit as measurement_value. Used to contextualise results flagged as below_detection_limit and for regulatory reporting of non-detects.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the recorded measurement value has exceeded (or fallen below, for minimum thresholds) the applicable regulatory or permit threshold limit. True = exceedance detected; False = within acceptable limits. Triggers corrective action workflow in Intelex.',
    `exceedance_magnitude` DECIMAL(18,2) COMMENT 'The absolute difference between the measured value and the threshold limit when an exceedance is detected. Null when exceedance_flag is False. Used to prioritise severity of environmental non-compliance and escalation response.',
    `instrument_calibration_date` DATE COMMENT 'The date on which the monitoring instrument was last calibrated prior to this measurement. Used to verify that measurements were taken with a calibrated instrument within the required calibration interval, supporting regulatory defensibility.',
    `instrument_calibration_due_date` DATE COMMENT 'The date by which the monitoring instrument must next be calibrated to remain within its valid calibration period. Measurements taken after this date may be flagged as non-compliant for regulatory reporting purposes.',
    `instrument_code` STRING COMMENT 'Unique identifier or asset tag of the instrument, sensor, or analyser used to take the measurement (e.g., dust monitor serial number, noise meter ID, water quality probe ID). Supports instrument calibration traceability and equipment maintenance records.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `instrument_type` STRING COMMENT 'Classification of the instrument or sensor type used for the measurement (e.g., Dust Monitor, Sound Level Meter, Vibration Meter, Multi-parameter Water Quality Probe, Gas Analyser). Used for equipment management and calibration scheduling. [ENUM-REF-CANDIDATE: dust_monitor|sound_level_meter|vibration_meter|water_quality_probe|gas_analyser|turbidimeter|pH_meter|portable_gas_detector — promote to reference product]',
    `laboratory_name` STRING COMMENT 'Name of the accredited analytical laboratory that performed sample analysis, where applicable (e.g., for water quality, soil contamination, or chemical air quality samples sent for laboratory analysis). Null for field-measured parameters.',
    `laboratory_report_number` STRING COMMENT 'The unique report or chain-of-custody number issued by the analytical laboratory for the sample analysis. Provides traceability from the field sample to the laboratory result and supports regulatory audit documentation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this environmental monitoring record was most recently modified. Used for data lineage tracking, change auditing, and incremental data pipeline processing in the Databricks silver layer.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the monitoring point where the measurement was taken. Supports GIS-based environmental impact mapping and spatial analytics.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the monitoring point where the measurement was taken. Supports GIS-based environmental impact mapping and spatial analytics.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time at which the environmental measurement or reading was taken in the field. This is the principal real-world event time, distinct from record creation audit timestamps. Stored in ISO 8601 format with timezone offset.',
    `measurement_unit` STRING COMMENT 'The unit of measure for the recorded measurement value (e.g., µg/m³, mg/L, dB(A), mm/s, NTU, pH, ppm, mg/kg). Must align with the unit specified in the applicable environmental permit or regulatory standard for the parameter. [ENUM-REF-CANDIDATE: µg/m³|mg/L|dB(A)|mm/s|NTU|pH|ppm|mg/kg|µS/cm|°C — promote to reference product]',
    `measurement_value` DECIMAL(18,2) COMMENT 'The numeric reading or measured value recorded for the environmental parameter at the monitoring location and timestamp. This is the principal quantitative observation for this record. Precision to 6 decimal places to accommodate trace-level contaminant readings.',
    `monitoring_frequency` STRING COMMENT 'The required or actual frequency at which measurements are taken at this monitoring location for this parameter, as specified in the environmental monitoring plan or regulatory permit. Used to verify compliance with permit monitoring schedules. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|event_triggered — 7 candidates stripped; promote to reference product]',
    `monitoring_location_code` STRING COMMENT 'Unique alphanumeric code identifying the designated monitoring point or station as defined in the environmental monitoring plan or permit. Used as the externally-known identifier in regulatory submissions and Intelex records.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `monitoring_location_name` STRING COMMENT 'Descriptive name or label of the specific monitoring point or station where the measurement was taken (e.g., North Perimeter Fence Line, Discharge Point DP-01, Borehole BH-03). Used in permit compliance reports and environmental monitoring plans.',
    `monitoring_method` STRING COMMENT 'The analytical or measurement method used to obtain the reading (e.g., EPA Method 40 CFR Part 50, ISO 10523 for pH, AS/NZS 4360 for noise). Ensures traceability and regulatory defensibility of measurement results.',
    `monitoring_parameter` STRING COMMENT 'The specific environmental parameter being measured at this monitoring point (e.g., PM10, PM2.5, NO2, SO2, noise level dB(A), vibration velocity, pH, turbidity, TSS, BOD, lead, arsenic). Aligned with EPA and ISO 14001 environmental monitoring parameter classifications. [ENUM-REF-CANDIDATE: PM10|PM2.5|NO2|SO2|CO|noise_dba|vibration_velocity|pH|turbidity|TSS|BOD|COD|lead|arsenic|benzene|TPH — promote to reference product]',
    `monitoring_record_status` STRING COMMENT 'Current workflow status of the environmental monitoring record within the Intelex HSE management system. Tracks the record through data entry, verification by the environmental manager, regulatory submission, and closure.. Valid values are `draft|submitted|verified|approved|rejected|closed`',
    `monitoring_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to this monitoring record, used in regulatory submissions, permit compliance reports, and Intelex HSE management system. Format: ENV-{SITE_CODE}-{SEQUENCE}.. Valid values are `^ENV-[A-Z0-9]{3,10}-[0-9]{4,8}$`',
    `parameter_category` STRING COMMENT 'High-level classification of the environmental monitoring parameter into the primary environmental media or impact category. Used for domain-level reporting and ISO 14001 environmental aspect categorisation.. Valid values are `air_quality|noise|vibration|water_quality|soil_contamination|dust`',
    `permit_reference_number` STRING COMMENT 'The reference number of the environmental permit, consent, or licence under which this monitoring is required. Links the measurement to the specific regulatory instrument that mandates monitoring at this location for this parameter.',
    `regulator_notification_date` DATE COMMENT 'The date on which the exceedance or monitoring result was formally notified to the relevant regulatory authority. Null if reported_to_regulator is False. Used to verify compliance with permit notification timeframes.',
    `regulatory_standard_reference` STRING COMMENT 'The specific regulatory standard, guideline, or code of practice that defines the threshold limit for this parameter (e.g., EPA NAAQS PM10 150 µg/m³ 24-hr, OSHA PEL 1910.1000 Table Z-1, ISO 14001:2015 Clause 9.1.1). Provides traceability for threshold values used in exceedance determination.',
    `remarks` STRING COMMENT 'Free-text field for the monitoring officer to record contextual observations, anomalies, site conditions, or explanatory notes relevant to this measurement (e.g., Elevated reading attributed to adjacent demolition activity, Instrument battery low during measurement). Supports regulatory audit and investigation.',
    `reported_to_regulator` BOOLEAN COMMENT 'Indicates whether this monitoring result (particularly exceedances) has been formally reported to the relevant regulatory authority (e.g., EPA, state environmental agency) as required by the environmental permit or applicable legislation.',
    `sample_duration_minutes` STRING COMMENT 'The duration in minutes over which the sample or measurement was collected or averaged. Relevant for time-averaged parameters such as noise (LAeq), air quality (24-hour PM10), and vibration. Null for instantaneous grab samples.',
    `sample_type` STRING COMMENT 'Indicates the sampling methodology used to obtain the measurement — whether it is a grab sample (instantaneous), composite sample (time-averaged), continuous real-time reading, passive diffusion sample, or integrated sample over a defined period. Affects interpretation of results.. Valid values are `grab|composite|continuous|passive|integrated`',
    `threshold_limit` DECIMAL(18,2) COMMENT 'The maximum permissible value (or minimum, for parameters like pH) for the monitored parameter as defined by the applicable environmental permit, regulatory standard, or project-specific environmental management plan. Used to determine exceedance status.',
    `threshold_type` STRING COMMENT 'Indicates whether the threshold limit represents a maximum permissible value, minimum required value, action level trigger, or alert level for the monitored parameter. Determines the logic used to evaluate exceedance.. Valid values are `maximum|minimum|range_upper|range_lower|action_level|alert_level`',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the time of measurement. Relevant for contextualising air quality, dust, and noise readings, as weather significantly influences environmental parameter levels and regulatory defensibility of results. [ENUM-REF-CANDIDATE: clear|cloudy|overcast|light_rain|heavy_rain|windy|foggy|storm — 8 candidates stripped; promote to reference product]',
    `wind_direction` STRING COMMENT 'Cardinal or intercardinal wind direction at the time of measurement. Used in conjunction with wind speed for air quality dispersion analysis and to determine whether site activities are the source of elevated readings at downwind monitoring points. [ENUM-REF-CANDIDATE: N|NE|E|SE|S|SW|W|NW — 8 candidates stripped; promote to reference product]',
    `wind_speed_ms` DECIMAL(18,2) COMMENT 'Wind speed in metres per second recorded at or near the monitoring location at the time of measurement. Critical contextual data for air quality and dust dispersion modelling and for assessing whether exceedances are attributable to site activities.',
    CONSTRAINT pk_environmental_monitoring PRIMARY KEY(`environmental_monitoring_id`)
) COMMENT 'Environmental monitoring measurement records capturing periodic readings for air quality, noise levels, vibration, water quality, and soil contamination at construction sites. Captures monitoring parameter, measurement value, unit, threshold limit, exceedance flag, monitoring location, instrument used, and responsible party. Supports ISO 14001 environmental management and regulatory permit compliance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the safety training record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Training records must be tied to the client contract to verify compliance with client‑mandated safety training requirements.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which the training was conducted. Links to project master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training expenses are charged to a cost_center for budgeting and cost control; required for monthly training cost reports.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the construction worker who received the training. Links to workforce master data.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Safety training is frequently delivered in response to an incident; linking training to the incident provides traceability.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Training compliance is reported per contract party to satisfy client and regulatory HSE requirements.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: When training is delivered by an internal trainer, the trainers employee ID is required for training records and competency tracking.',
    `assessment_method` STRING COMMENT 'Method used to assess the workers competency after training: written examination, practical hands-on test, direct observation, verbal interview, or no formal assessment.. Valid values are `written_exam|practical_test|observation|interview|no_assessment`',
    `assessment_result` STRING COMMENT 'Overall result of the competency assessment: pass (met requirements), fail (did not meet requirements), conditional_pass (passed with conditions or retraining required), or not_assessed (no formal assessment conducted).. Valid values are `pass|fail|conditional_pass|not_assessed`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by the worker in the competency assessment (e.g., 85.50 out of 100). Null if no assessment was conducted.',
    `attendance_status` STRING COMMENT 'Workers attendance status for the training session: attended (full participation), absent (did not attend), partial (attended part of the session), or excused (authorized absence).. Valid values are `attended|absent|partial|excused`',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certification expires and requires renewal or refresher training. Format: yyyy-MM-dd. Null if certification does not expire or was not issued.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was officially issued to the worker. Format: yyyy-MM-dd. Null if no certificate was issued.',
    `certificate_number` STRING COMMENT 'Unique identification number printed on the issued training certificate or card (e.g., OSHA 10-hour card number). Null if no certificate was issued.',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a formal certificate or card was issued to the worker upon successful completion of the training. True if issued, False if not.',
    `training_code` STRING COMMENT 'Unique alphanumeric code identifying the specific training course or module (e.g., OSHA10, OSHA30, INDUCT01, HEIGHTS01).. Valid values are `^[A-Z0-9]{4,12}$`',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the training session (e.g., Worker required additional coaching on fall protection harness fitting, Training postponed due to weather).',
    `compliance_status` STRING COMMENT 'Current compliance status of the workers training record: compliant (training valid and up-to-date), non_compliant (required training not completed or failed), expired (certification has expired), pending_renewal (approaching expiry, renewal in progress), or waived (exempted by authorized personnel).. Valid values are `compliant|non_compliant|expired|pending_renewal|waived`',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the training session, including instructor fees, materials, facility rental, and travel expenses. Null if cost tracking is not applicable.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost (e.g., USD, EUR, GBP). Null if cost is not tracked.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered: classroom instruction, online e-learning, on-site field training, blended (combination), simulator-based, or hands-on practical demonstration.. Valid values are `classroom|online|on_site|blended|simulator|hands_on`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training session in hours (e.g., 8.00 for an 8-hour OSHA course, 0.50 for a 30-minute toolbox talk).',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the training session ended. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `language_of_instruction` STRING COMMENT 'Primary language in which the training was delivered (e.g., English, Spanish, Mandarin). Important for multilingual workforce compliance.',
    `location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., site office, training center address, online platform name).',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for the workers role or project assignment. True if mandatory, False if optional or voluntary.',
    `materials_provided` STRING COMMENT 'Description of training materials provided to the worker (e.g., OSHA handbook, safety manual, PPE (Personal Protective Equipment) checklist, online access credentials).',
    `next_refresher_due_date` DATE COMMENT 'Date by which the worker must complete refresher training to maintain compliance. Format: yyyy-MM-dd. Null if no refresher is required.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified in the source system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refresher_frequency_months` STRING COMMENT 'Number of months between required refresher training sessions (e.g., 12 for annual refresher, 36 for three-year renewal). Null if no refresher is required.',
    `refresher_required` BOOLEAN COMMENT 'Indicates whether periodic refresher training is required to maintain competency and compliance. True if refresher is required, False if one-time training is sufficient.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard or legal requirement that mandates this training (e.g., OSHA 29 CFR 1926.1053 - Ladder Safety, ISO 45001 Clause 7.2 - Competence, State-specific confined space regulation).',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the training session started. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `title` STRING COMMENT 'Full descriptive title of the training course or session (e.g., OSHA 30-Hour Construction Safety, Site-Specific Induction for Highway Project XYZ).',
    `trainer_certification_number` STRING COMMENT 'Certification or accreditation number of the trainer, verifying their authorization to deliver the specific training (e.g., OSHA Outreach Trainer ID).',
    `training_date` DATE COMMENT 'Date on which the training session was conducted or completed. Format: yyyy-MM-dd.',
    `training_type` STRING COMMENT 'Category of Health Safety and Environment (HSE) training provided. Includes site induction, OSHA (Occupational Safety and Health Administration) 10/30 hour certifications, first aid, confined space entry, working at heights, scaffolding, excavation safety, fall protection, electrical safety, hot work permits, rigging and lifting, hazardous materials handling, PPE (Personal Protective Equipment) usage, emergency response, fire safety, and TBM (Toolbox Meeting) sessions. [ENUM-REF-CANDIDATE: site_induction|osha_10|osha_30|first_aid|confined_space|working_at_heights|scaffolding|excavation|fall_protection|electrical_safety|hot_work|rigging_lifting|hazmat|ppe_usage|emergency_response|fire_safety|toolbox_meeting — 17 candidates stripped; promote to reference product]',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Safety training and induction records for construction workers, capturing training type (site induction, OSHA 10/30, first aid, confined space, working at heights), delivery date, trainer, duration, competency assessment result, certification issued, expiry date, and compliance status. Distinct from general workforce training — this is the SSOT for HSE-specific training compliance. Sourced from Intelex and SAP SuccessFactors HSE training modules.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`chemical_register` (
    `chemical_register_id` BIGINT COMMENT 'System‑generated unique identifier for each chemical register record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor responsible for the chemicals safe management.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: Chemical registers are tied to hazards they address; linking to hazard_register creates a direct relationship for hazard‑chemical mapping.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Ensures chemical inventory aligns with material master specifications, enabling consistent safety data sheets and compliance audits.',
    `site_id` BIGINT COMMENT 'Identifier of the construction site to which the chemical inventory belongs.',
    `superseded_chemical_register_id` BIGINT COMMENT 'Self-referencing FK on chemical_register (superseded_chemical_register_id)',
    `cas_number` STRING COMMENT 'Unique Chemical Abstracts Service identifier used internationally to reference the chemical.',
    `chemical_family` STRING COMMENT 'Broad chemical family or class (e.g., solvents, acids, bases).',
    `chemical_name` STRING COMMENT 'Common or trade name of the hazardous chemical.',
    `chemical_register_status` STRING COMMENT 'Current lifecycle status of the chemical record.. Valid values are `active|inactive|retired|pending`',
    `control_measures` STRING COMMENT 'Engineering or administrative controls applied to mitigate the chemicals hazards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the chemical register record was first created.',
    `disposal_method` STRING COMMENT 'Approved method for disposing of the chemical or its waste.',
    `emergency_procedure` STRING COMMENT 'Step‑by‑step actions to take in case of a spill, fire, or exposure.',
    `expiration_date` DATE COMMENT 'Date after which the chemical is considered expired and must not be used.',
    `exposure_limit_ple` DECIMAL(18,2) COMMENT 'Maximum time‑weighted average exposure limit for an 8‑hour workday, as defined by OSHA.',
    `exposure_limit_tlv` DECIMAL(18,2) COMMENT 'Recommended exposure limit for an 8‑hour workday, as defined by ACGIH.',
    `exposure_limit_unit` STRING COMMENT 'Unit of measure for the exposure limits.. Valid values are `ppm|mg/m3|%`',
    `ghs_classification` STRING COMMENT 'GHS hazard classes and pictograms applicable to the chemical. [ENUM-REF-CANDIDATE: acute_toxicity|skin_corrosion|serious_eyes_damage|environmental_hazard|flammable|oxidizing|carcinogenic|reproductive_toxicity|specific_target_organs|hazardous_to_the_environment|other — promote to reference product]',
    `hazard_category` STRING COMMENT 'Broad category describing the type of hazard (e.g., toxic, flammable, corrosive). [ENUM-REF-CANDIDATE: toxic|flammable|corrosive|reactive|environmental|oxidizer|explosive|other — promote to reference product]',
    `hazard_statement` STRING COMMENT 'Standardized statement describing the nature of the hazard (e.g., H301).',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending`',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the chemical is classified as hazardous under OSHA/HSE regulations.',
    `is_quantities_verified` BOOLEAN COMMENT 'Indicates whether the on‑site quantity has been physically verified.',
    `last_inspection_date` DATE COMMENT 'Date when the chemical storage area was last inspected for compliance.',
    `manufacturer` STRING COMMENT 'Legal name of the company that produces or supplies the chemical.',
    `manufacturer_contact` STRING COMMENT 'Primary email address for the chemical manufacturer or supplier.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the chemical.',
    `precautionary_statement` STRING COMMENT 'Standardized precautionary measures recommended for the chemical (e.g., P210).',
    `product_code` STRING COMMENT 'Internal catalogue or SKU code used by the organization to track the chemical.',
    `quantity_on_site` DECIMAL(18,2) COMMENT 'Total amount of the chemical currently stored at the site.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity on site.. Valid values are `kg|l|gal|lb|ft3|m3`',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with OSHA Hazard Communication Standard and other applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `required_ppe` STRING COMMENT 'PPE items that must be worn when handling the chemical (e.g., gloves, goggles, respirator).',
    `risk_level` STRING COMMENT 'Overall risk rating based on hazard classification, quantity, and control measures.. Valid values are `low|medium|high`',
    `safety_data_sheet_url` STRING COMMENT 'Web link or intranet path to the electronic SDS.',
    `sds_document_reference` STRING COMMENT 'Reference (e.g., file path or document ID) to the current SDS for the chemical.',
    `sds_last_updated` DATE COMMENT 'Date when the SDS was last reviewed or revised.',
    `sds_version` STRING COMMENT 'Version number or revision identifier of the SDS.',
    `storage_location` STRING COMMENT 'Physical location or area within the site where the chemical is stored.',
    `storage_requirements` STRING COMMENT 'Special storage conditions such as ventilation, segregation, or humidity control.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature range in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the chemical register record.',
    `verification_date` DATE COMMENT 'Date of the most recent quantity verification.',
    CONSTRAINT pk_chemical_register PRIMARY KEY(`chemical_register_id`)
) COMMENT 'Master register of hazardous chemicals and Safety Data Sheets (SDS) present on construction sites, supporting OSHA Hazard Communication Standard (29 CFR 1910.1200) compliance. Captures chemical product name, manufacturer, GHS classification, hazard category, SDS document reference, storage location, quantity on site, exposure limits (PEL/TLV), required PPE, emergency procedures, and responsible person. Tracks SDS currency (must be updated within 3 years), site-level chemical inventories, and worker right-to-know accessibility. Links to project/site for location context and to safety_training for HazCom training verification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` (
    `incident_subcontractor_involvement_id` BIGINT COMMENT 'Primary key for the incident_subcontractor_involvement association',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - incident involvement records are project-scoped',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to the subcontractor firm profile',
    `incident_id` BIGINT COMMENT 'Foreign key linking to the incident record',
    `subcontract_id` BIGINT COMMENT 'add column subcontract_id (BIGINT) with FK to contract.subcontract.subcontract_id - subcontractor involvement should reference the subcontract under which they were working',
    `acknowledgement_status` STRING COMMENT '',
    `back_charge_amount` DECIMAL(18,2) COMMENT 'Back charge amount.',
    `corrective_action` STRING COMMENT '',
    `corrective_action_assigned` STRING COMMENT '',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action required.',
    `corrective_actions_assigned` STRING COMMENT 'Corrective actions assigned to the subcontractor.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `fault_determination` STRING COMMENT '',
    `incident_subcontractor_involvement_status` STRING COMMENT '',
    `involvement_description` STRING COMMENT 'Description of involvement.',
    `involvement_notes` STRING COMMENT 'Notes on the subcontractors involvement.',
    `involvement_role` STRING COMMENT 'The role of the subcontractor in the incident (e.g., contractor, equipment provider, laborer)',
    `involvement_status` STRING COMMENT 'Status of involvement record.',
    `involvement_type` STRING COMMENT 'Type of involvement (direct, indirect, witness).',
    `is_responsible_party` BOOLEAN COMMENT 'Whether the subcontractor is a responsible party.',
    `liability_assessed` BOOLEAN COMMENT '',
    `liability_assessment` STRING COMMENT '',
    `liability_percentage` DECIMAL(18,2) COMMENT 'Percentage of liability assigned to the subcontractor for the incident',
    `notes` STRING COMMENT '',
    `notified_date` DATE COMMENT '',
    `personnel_count_involved` STRING COMMENT '',
    `remarks` STRING COMMENT 'Additional remarks.',
    `reported_date` DATE COMMENT '',
    `responsibility_pct` DECIMAL(18,2) COMMENT '',
    `responsibility_percent` DECIMAL(18,2) COMMENT '',
    `responsibility_share` DECIMAL(18,2) COMMENT '',
    `role_in_incident` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `workers_affected` STRING COMMENT 'Number of subcontractor workers affected.',
    CONSTRAINT pk_incident_subcontractor_involvement PRIMARY KEY(`incident_subcontractor_involvement_id`)
) COMMENT 'Represents the participation of a subcontractor firm in a safety incident, capturing the subcontractors role and liability percentage for that incident.. Existence Justification: A safety incident can involve multiple subcontractor firms (e.g., multiple trades present on site) and each subcontractor firm can be involved in many incidents across projects. The incident team records the subcontractors role (e.g., contractor, equipment provider) and the liability percentage for each involvement, which are managed as part of the incident investigation process.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ADD CONSTRAINT `fk_safety_hse_inspection_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ADD CONSTRAINT `fk_safety_ppe_register_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ADD CONSTRAINT `fk_safety_environmental_monitoring_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ADD CONSTRAINT `fk_safety_chemical_register_superseded_chemical_register_id` FOREIGN KEY (`superseded_chemical_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ADD CONSTRAINT `fk_safety_incident_subcontractor_involvement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`safety` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`safety` SET TAGS ('pii_domain' = 'safety');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `interface_point_id` SET TAGS ('pii_business_glossary_term' = 'Interface Point Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Reporter Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `swms_id` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `body_part_affected` SET TAGS ('pii_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `corrective_action_count` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `days_away_from_work` SET TAGS ('pii_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `days_restricted_or_transferred` SET TAGS ('pii_business_glossary_term' = 'Days Restricted or Transferred (DART)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('pii_business_glossary_term' = 'Environmental Media Affected');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `environmental_media_affected` SET TAGS ('pii_value_regex' = 'soil|groundwater|surface_water|air|none|multiple');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `immediate_cause` SET TAGS ('pii_business_glossary_term' = 'Immediate Cause of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('pii_value_regex' = '^INC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('pii_value_regex' = 'open|under_investigation|pending_review|closed|void');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `incident_type` SET TAGS ('pii_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_job_title` SET TAGS ('pii_business_glossary_term' = 'Injured Party Job Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('pii_business_glossary_term' = 'Injured Party Full Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('pii_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injured_party_type` SET TAGS ('pii_value_regex' = 'employee|subcontractor|visitor|public|third_party');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `injury_nature` SET TAGS ('pii_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `investigation_lead` SET TAGS ('pii_business_glossary_term' = 'Investigation Lead Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_environmental_event` SET TAGS ('pii_business_glossary_term' = 'Environmental Event Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_fit_for_duty` SET TAGS ('pii_business_glossary_term' = 'Fitness for Duty Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_lti` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `is_osha_recordable` SET TAGS ('pii_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `occurred_at` SET TAGS ('pii_business_glossary_term' = 'Incident Occurred At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `ppe_compliance` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `ppe_compliance` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|not_applicable|unknown');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `property_damage_amount` SET TAGS ('pii_business_glossary_term' = 'Property Damage Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `property_damage_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('pii_value_regex' = 'not_required|pending|notified|overdue');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `reported_at` SET TAGS ('pii_business_glossary_term' = 'Incident Reported At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `return_to_work_date` SET TAGS ('pii_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `severity` SET TAGS ('pii_business_glossary_term' = 'Incident Severity Classification');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('pii_business_glossary_term' = 'Work Shift at Time of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('pii_value_regex' = 'day|night|swing|not_applicable');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `site_area` SET TAGS ('pii_business_glossary_term' = 'Site Area / Zone');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treating_physician` SET TAGS ('pii_business_glossary_term' = 'Treating Physician Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treating_physician` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treatment_type` SET TAGS ('pii_business_glossary_term' = 'Medical Treatment Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `treatment_type` SET TAGS ('pii_value_regex' = 'first_aid|medical_treatment|hospitalization|fatality|restricted_work|no_treatment');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions at Time of Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_ref` SET TAGS ('pii_business_glossary_term' = 'Workers Compensation Claim Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ALTER COLUMN `workers_comp_claim_ref` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('pii_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_investigation_id` SET TAGS ('pii_business_glossary_term' = 'Incident Investigation ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Investigator ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `tertiary_incident_approved_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `tertiary_incident_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `tertiary_incident_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `contributing_factors` SET TAGS ('pii_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|overdue|verified');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `corrective_action_summary` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `immediate_cause` SET TAGS ('pii_business_glossary_term' = 'Immediate Cause');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_category` SET TAGS ('pii_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_classification` SET TAGS ('pii_business_glossary_term' = 'Incident Classification');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `incident_date` SET TAGS ('pii_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `injured_party_type` SET TAGS ('pii_business_glossary_term' = 'Injured Party Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `injured_party_type` SET TAGS ('pii_value_regex' = 'direct_employee|subcontractor|visitor|public|other');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_close_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_findings` SET TAGS ('pii_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('pii_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_methodology` SET TAGS ('pii_value_regex' = '5_why|fishbone|bowtie|fault_tree|taproot|other');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('pii_business_glossary_term' = 'Investigation Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_number` SET TAGS ('pii_value_regex' = '^INV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_start_date` SET TAGS ('pii_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('pii_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_status` SET TAGS ('pii_value_regex' = 'open|in_progress|pending_review|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_team_members` SET TAGS ('pii_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('pii_business_glossary_term' = 'Investigation Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `investigation_type` SET TAGS ('pii_value_regex' = 'formal|informal|regulatory|internal');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_lti` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_recordable` SET TAGS ('pii_business_glossary_term' = 'OSHA Recordable Incident Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `lessons_learned` SET TAGS ('pii_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `lost_time_days` SET TAGS ('pii_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `management_review_date` SET TAGS ('pii_business_glossary_term' = 'Management Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `ppe_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `ptw_reference` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `recurrence_prevention_measures` SET TAGS ('pii_business_glossary_term' = 'Recurrence Prevention Measures');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_reference_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `regulatory_submission_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `root_cause_description` SET TAGS ('pii_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `swms_in_place_flag` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) In Place Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `systemic_cause` SET TAGS ('pii_business_glossary_term' = 'Systemic Cause');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `witness_count` SET TAGS ('pii_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ALTER COLUMN `work_area_description` SET TAGS ('pii_business_glossary_term' = 'Work Area Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('pii_subdomain' = 'hazard_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_id` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By (Employee ID)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `tertiary_swms_prepared_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Prepared By (Employee ID)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `tertiary_swms_prepared_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `tertiary_swms_prepared_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `aconex_document_reference` SET TAGS ('pii_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `activity_description` SET TAGS ('pii_business_glossary_term' = 'High-Risk Activity Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'High-Risk Construction Activity Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `applicable_legislation` SET TAGS ('pii_business_glossary_term' = 'Applicable Legislation and Standards');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'SWMS Approval Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|rejected|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'SWMS Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `competency_requirements` SET TAGS ('pii_business_glossary_term' = 'Worker Competency and Licence Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `control_measures` SET TAGS ('pii_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'SWMS Document URL');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `emergency_procedures` SET TAGS ('pii_business_glossary_term' = 'Emergency Response Procedures');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `environmental_controls` SET TAGS ('pii_business_glossary_term' = 'Environmental Control Measures');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'SWMS Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `hazard_description` SET TAGS ('pii_business_glossary_term' = 'Identified Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_consequence` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_consequence` SET TAGS ('pii_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_likelihood` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_likelihood` SET TAGS ('pii_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Rating (Before Controls)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `initial_risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex HSE Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'SWMS Issue Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `plant_equipment_required` SET TAGS ('pii_business_glossary_term' = 'Plant and Equipment Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_required` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_type` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `ptw_type` SET TAGS ('pii_value_regex' = 'hot_work|confined_space|electrical|excavation|working_at_heights|general');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_consequence` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_consequence` SET TAGS ('pii_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_likelihood` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_likelihood` SET TAGS ('pii_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Rating (After Controls)');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `residual_risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'SWMS Scheduled Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'SWMS Revision Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_number` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `swms_number` SET TAGS ('pii_value_regex' = '^SWMS-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `tbm_required` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'SWMS Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `work_steps` SET TAGS ('pii_business_glossary_term' = 'Step-by-Step Work Procedure');
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ALTER COLUMN `worker_acknowledgement_required` SET TAGS ('pii_business_glossary_term' = 'Worker Acknowledgement Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('pii_subdomain' = 'hazard_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Intelex Permit to Work System ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Performing Authority Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approval_level` SET TAGS ('pii_business_glossary_term' = 'Permit Approval Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approval_level` SET TAGS ('pii_value_regex' = 'supervisor|hse_manager|project_manager|site_director');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Permit Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Permit Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `concurrent_permit_flag` SET TAGS ('pii_business_glossary_term' = 'Concurrent Permit Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `control_measures` SET TAGS ('pii_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `emergency_rescue_plan` SET TAGS ('pii_business_glossary_term' = 'Emergency Rescue Plan Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `environmental_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `extension_count` SET TAGS ('pii_business_glossary_term' = 'Permit Extension Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_required` SET TAGS ('pii_business_glossary_term' = 'Gas Test Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('pii_business_glossary_term' = 'Gas Test Result');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `gas_test_result` SET TAGS ('pii_value_regex' = 'pass|fail|not_required');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `hazard_description` SET TAGS ('pii_business_glossary_term' = 'Hazard Identification Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `isolation_details` SET TAGS ('pii_business_glossary_term' = 'Isolation Details Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `isolation_required` SET TAGS ('pii_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issued_timestamp` SET TAGS ('pii_business_glossary_term' = 'Permit Issued Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `issuing_authority_role` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `last_extended_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Permit Extension Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `performing_authority_name` SET TAGS ('pii_business_glossary_term' = 'Performing Authority Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `performing_authority_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `performing_authority_role` SET TAGS ('pii_business_glossary_term' = 'Performing Authority Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('pii_value_regex' = '^PTW-[A-Z0-9]{3,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_status` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `reinstatement_details` SET TAGS ('pii_business_glossary_term' = 'Site Reinstatement Details');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Permit Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Permit Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `swms_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `tbm_record_reference` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_from_timestamp` SET TAGS ('pii_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_to_timestamp` SET TAGS ('pii_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_until` SET TAGS ('pii_business_glossary_term' = 'Permit Validity Expiry');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_description` SET TAGS ('pii_business_glossary_term' = 'Work Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_location` SET TAGS ('pii_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_location_description` SET TAGS ('pii_business_glossary_term' = 'Work Location Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `work_scope` SET TAGS ('pii_business_glossary_term' = 'Permitted Work Scope Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `worker_count` SET TAGS ('pii_business_glossary_term' = 'Permitted Worker Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ALTER COLUMN `valid_from` SET TAGS ('pii_business_glossary_term' = 'Permit Validity Start');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('pii_subdomain' = 'field_compliance');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting Identifier');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Facilitator Employee ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `actual_attendee_count` SET TAGS ('pii_business_glossary_term' = 'Actual Attendee Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `attendance_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Attendance Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `control_measures_communicated` SET TAGS ('pii_business_glossary_term' = 'Control Measures Communicated');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `corrective_action_raised` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Raised');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `corrective_action_reference` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `document_attachment_reference` SET TAGS ('pii_business_glossary_term' = 'Document Attachment Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Duration (Minutes)');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `emergency_procedures_reviewed` SET TAGS ('pii_business_glossary_term' = 'Emergency Procedures Reviewed');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `end_time` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) End Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Facilitator Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `facilitator_qualification` SET TAGS ('pii_business_glossary_term' = 'Facilitator HSE Qualification');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hazards_highlighted` SET TAGS ('pii_business_glossary_term' = 'Hazards Highlighted');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `hse_topic_category` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Topic Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `incident_review_included` SET TAGS ('pii_business_glossary_term' = 'Incident Review Included');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `interpreter_required` SET TAGS ('pii_business_glossary_term' = 'Interpreter Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `language_conducted` SET TAGS ('pii_business_glossary_term' = 'Language Conducted');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `language_conducted` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_date` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_location` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_reference_number` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_reference_number` SET TAGS ('pii_value_regex' = '^TBM-[A-Z0-9]{2,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_status` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_status` SET TAGS ('pii_value_regex' = 'draft|scheduled|completed|cancelled|pending_review');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_type` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `meeting_type` SET TAGS ('pii_value_regex' = 'pre_shift|pre_task|weekly_safety|emergency|visitor_induction');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `planned_attendee_count` SET TAGS ('pii_business_glossary_term' = 'Planned Attendee Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `ppe_requirements_communicated` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements Communicated');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `ptw_reference_number` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `sign_off_method` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Sign-Off Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `sign_off_method` SET TAGS ('pii_value_regex' = 'paper_signature|digital_signature|biometric|verbal_acknowledgement');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `start_time` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Start Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `swms_reference_number` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `topics_discussed` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Topics Discussed');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `trade_group` SET TAGS ('pii_business_glossary_term' = 'Trade Group');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions at Meeting');
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ALTER COLUMN `work_area_description` SET TAGS ('pii_business_glossary_term' = 'Work Area Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` SET TAGS ('pii_subdomain' = 'field_compliance');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `safety_audit_id` SET TAGS ('pii_business_glossary_term' = 'Safety Audit ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Employee ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `hse_plan_id` SET TAGS ('pii_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `aconex_document_ref` SET TAGS ('pii_business_glossary_term' = 'Aconex Audit Report Document Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_category` SET TAGS ('pii_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_category` SET TAGS ('pii_value_regex' = 'hse_management_system|site_safety|environmental|fire_safety|process_safety|contractor_compliance');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_value_regex' = '^AUD-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'internal|external|regulatory|surveillance|certification');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `auditee_name` SET TAGS ('pii_business_glossary_term' = 'Auditee Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `auditee_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `auditee_organisation` SET TAGS ('pii_business_glossary_term' = 'Auditee Organisation');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `closeout_date` SET TAGS ('pii_business_glossary_term' = 'Audit Close-Out Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `compliance_rating` SET TAGS ('pii_value_regex' = 'satisfactory|acceptable|marginal|unsatisfactory|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `compliance_score` SET TAGS ('pii_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `criteria_compliant` SET TAGS ('pii_business_glossary_term' = 'Criteria Compliant Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Audit End Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `finding_detail` SET TAGS ('pii_business_glossary_term' = 'Audit Finding Detail');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `immediate_action_required` SET TAGS ('pii_business_glossary_term' = 'Immediate Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `intelex_audit_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Audit System ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Audit Location Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `major_nc_count` SET TAGS ('pii_business_glossary_term' = 'Major Non-Conformance (NC) Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `minor_nc_count` SET TAGS ('pii_business_glossary_term' = 'Minor Non-Conformance (NC) Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `observation_count` SET TAGS ('pii_business_glossary_term' = 'Observation Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `ofi_count` SET TAGS ('pii_business_glossary_term' = 'Opportunity for Improvement (OFI) Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `open_findings_count` SET TAGS ('pii_business_glossary_term' = 'Open Findings Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `programme_ref` SET TAGS ('pii_business_glossary_term' = 'Audit Programme Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `regulatory_notification_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `regulatory_standard` SET TAGS ('pii_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `report_issue_date` SET TAGS ('pii_business_glossary_term' = 'Audit Report Issue Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `stop_work_issued` SET TAGS ('pii_business_glossary_term' = 'Stop Work Order Issued Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `team_members` SET TAGS ('pii_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `team_members` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Audit Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `total_criteria_assessed` SET TAGS ('pii_business_glossary_term' = 'Total Criteria Assessed');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `total_findings` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`safety_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` SET TAGS ('pii_subdomain' = 'field_compliance');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `hse_inspection_id` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Inspection ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `checklist_id` SET TAGS ('pii_business_glossary_term' = 'Inspection Checklist Template ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `hse_plan_id` SET TAGS ('pii_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `deficiency_count` SET TAGS ('pii_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `drill_evacuation_complete` SET TAGS ('pii_business_glossary_term' = 'Drill Evacuation Completeness Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `drill_muster_accuracy_pct` SET TAGS ('pii_business_glossary_term' = 'Drill Muster Accuracy Percentage');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `drill_response_time_seconds` SET TAGS ('pii_business_glossary_term' = 'Emergency Drill Response Time (Seconds)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `drill_type` SET TAGS ('pii_business_glossary_term' = 'Emergency Drill Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `drill_type` SET TAGS ('pii_value_regex' = 'fire_evacuation|medical_emergency|spill_response|structural_collapse|muster_drill');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `general_observations` SET TAGS ('pii_business_glossary_term' = 'General Inspection Observations');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `highest_deficiency_severity` SET TAGS ('pii_business_glossary_term' = 'Highest Deficiency Severity');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `highest_deficiency_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|observation');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `immediate_action_description` SET TAGS ('pii_business_glossary_term' = 'Immediate Action Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `immediate_action_taken` SET TAGS ('pii_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_end_time` SET TAGS ('pii_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('pii_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_start_time` SET TAGS ('pii_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'draft|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `inspection_type` SET TAGS ('pii_value_regex' = 'routine|targeted|pre_task|emergency_drill|management_walk');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `intelex_inspection_ref` SET TAGS ('pii_business_glossary_term' = 'Intelex Inspection System Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `is_scheduled` SET TAGS ('pii_business_glossary_term' = 'Scheduled Inspection Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `items_failed` SET TAGS ('pii_business_glossary_term' = 'Checklist Items Failed');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `items_not_applicable` SET TAGS ('pii_business_glossary_term' = 'Checklist Items Not Applicable');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `items_passed` SET TAGS ('pii_business_glossary_term' = 'Checklist Items Passed');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `overall_result` SET TAGS ('pii_business_glossary_term' = 'Overall Inspection Result');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `overall_result` SET TAGS ('pii_value_regex' = 'pass|pass_with_observations|fail|conditional_pass');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `photo_evidence_count` SET TAGS ('pii_business_glossary_term' = 'Photographic Evidence Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `photo_evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Photographic Evidence Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `ppe_compliance_rate` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Rate');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `regulatory_notification_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `site_area` SET TAGS ('pii_business_glossary_term' = 'Site Area / Zone');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `stop_work_issued` SET TAGS ('pii_business_glossary_term' = 'Stop Work Authority Issued');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `total_items_checked` SET TAGS ('pii_business_glossary_term' = 'Total Checklist Items Checked');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions at Inspection');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_inspection` ALTER COLUMN `worker_count_observed` SET TAGS ('pii_business_glossary_term' = 'Worker Count Observed');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` SET TAGS ('pii_subdomain' = 'worker_protection');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `ppe_register_id` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Register ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Issued By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'PPE Acknowledgement Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'PPE Batch Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `certification_class` SET TAGS ('pii_business_glossary_term' = 'PPE Certification Class');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `certification_standard` SET TAGS ('pii_business_glossary_term' = 'PPE Certification Standard');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `colour` SET TAGS ('pii_business_glossary_term' = 'PPE Colour');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'PPE Compliance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending_inspection|expired|recalled');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `condition_status` SET TAGS ('pii_business_glossary_term' = 'PPE Condition Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `condition_status` SET TAGS ('pii_value_regex' = 'serviceable|requires_inspection|damaged|condemned|lost');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'PPE Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `fit_test_date` SET TAGS ('pii_business_glossary_term' = 'PPE Fit Test Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `fit_test_required` SET TAGS ('pii_business_glossary_term' = 'PPE Fit Test Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `hazard_type` SET TAGS ('pii_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `inspection_frequency_days` SET TAGS ('pii_business_glossary_term' = 'PPE Inspection Frequency (Days)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `inspection_notes` SET TAGS ('pii_business_glossary_term' = 'PPE Inspection Notes');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `issuance_status` SET TAGS ('pii_business_glossary_term' = 'PPE Issuance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `issuance_status` SET TAGS ('pii_value_regex' = 'issued|returned|replaced|condemned|lost');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'PPE Issue Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `item_code` SET TAGS ('pii_business_glossary_term' = 'PPE Item Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `item_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `item_name` SET TAGS ('pii_business_glossary_term' = 'PPE Item Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `item_type` SET TAGS ('pii_business_glossary_term' = 'PPE Item Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'PPE Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `manufacture_date` SET TAGS ('pii_business_glossary_term' = 'PPE Manufacture Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'PPE Manufacturer');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `model_number` SET TAGS ('pii_business_glossary_term' = 'PPE Model Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `next_inspection_date` SET TAGS ('pii_business_glossary_term' = 'PPE Next Inspection Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `ppe_category` SET TAGS ('pii_business_glossary_term' = 'PPE Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `replacement_date` SET TAGS ('pii_business_glossary_term' = 'PPE Replacement Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `return_date` SET TAGS ('pii_business_glossary_term' = 'PPE Return Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'PPE Serial Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `service_life_months` SET TAGS ('pii_business_glossary_term' = 'PPE Service Life (Months)');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `site_location` SET TAGS ('pii_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `size` SET TAGS ('pii_business_glossary_term' = 'PPE Size');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `training_completed` SET TAGS ('pii_business_glossary_term' = 'PPE Training Completed');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `training_date` SET TAGS ('pii_business_glossary_term' = 'PPE Training Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'PPE Unit Cost');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `unit_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`ppe_register` ALTER COLUMN `worker_acknowledgement` SET TAGS ('pii_business_glossary_term' = 'Worker PPE Acknowledgement');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('pii_subdomain' = 'worker_protection');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `design_scope_id` SET TAGS ('pii_business_glossary_term' = 'Design Scope Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Manager ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `sustainability_plan_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `applicable_regulations` SET TAGS ('pii_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Approval Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Approved By');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `audit_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Audit Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `client_hse_requirements` SET TAGS ('pii_business_glossary_term' = 'Client Health Safety Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Document Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Effective Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `environmental_aspects` SET TAGS ('pii_business_glossary_term' = 'Environmental Aspects');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `hse_objective_description` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Objective Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `incident_reporting_procedure` SET TAGS ('pii_business_glossary_term' = 'Incident Reporting Procedure');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `induction_required` SET TAGS ('pii_business_glossary_term' = 'Site HSE Induction Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `leed_applicable` SET TAGS ('pii_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Applicable');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `lti_target` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Target');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `muster_point_description` SET TAGS ('pii_business_glossary_term' = 'Muster Point Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `nearest_hospital` SET TAGS ('pii_business_glossary_term' = 'Nearest Hospital');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_value_regex' = '^HSE-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|superseded|cancelled');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_title` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'project_hse_plan|site_specific_hse_plan|environmental_management_plan|emergency_response_plan|construction_phase_plan');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Version');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_value_regex' = '^[0-9]{1,3}.[0-9]{1,2}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Prepared By');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `project_phase` SET TAGS ('pii_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `project_phase` SET TAGS ('pii_value_regex' = 'pre_construction|mobilisation|construction|commissioning|demobilisation');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `ptw_required` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Health Safety Environment (HSE) Plan Review Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Project Health Safety Environment (HSE) Risk Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `site_location` SET TAGS ('pii_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `site_specific_hazards` SET TAGS ('pii_business_glossary_term' = 'Site-Specific Hazards');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `subcontractor_hse_requirements` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Health Safety Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `swms_required` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `tbm_frequency` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Frequency');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `tbm_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|per_shift|as_required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `trir_target` SET TAGS ('pii_business_glossary_term' = 'Total Recordable Incident Rate (TRIR) Target');
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('pii_subdomain' = 'hazard_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Linked Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Person Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `activity_description` SET TAGS ('pii_business_glossary_term' = 'Activity / Task Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By (Person Name)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `approved_by` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessed_by` SET TAGS ('pii_business_glossary_term' = 'Assessed By (Person Name)');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessed_by` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_value_regex' = '^RA-[A-Z0-9]{3,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'open|controlled|eliminated|closed|under_review');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'jha|swms|ptw_support|design_review|inspection|incident_derived');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy` SET TAGS ('pii_business_glossary_term' = 'Control Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_hierarchy` SET TAGS ('pii_value_regex' = 'eliminate|substitute|engineering|administrative|ppe');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `control_measures` SET TAGS ('pii_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `environmental_aspect` SET TAGS ('pii_business_glossary_term' = 'Environmental Aspect Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `environmental_impact_description` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hazard_description` SET TAGS ('pii_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `hazard_type` SET TAGS ('pii_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_consequence` SET TAGS ('pii_business_glossary_term' = 'Initial Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_likelihood` SET TAGS ('pii_business_glossary_term' = 'Initial Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `initial_risk_score` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Source Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `linked_ptw_number` SET TAGS ('pii_business_glossary_term' = 'Linked Permit to Work (PTW) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `linked_swms_number` SET TAGS ('pii_business_glossary_term' = 'Linked Safe Work Method Statement (SWMS) Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `regulatory_requirement` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_consequence` SET TAGS ('pii_business_glossary_term' = 'Residual Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_likelihood` SET TAGS ('pii_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `responsible_party_role` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `responsible_party_role` SET TAGS ('pii_value_regex' = 'hse_officer|site_supervisor|project_manager|subcontractor|engineer|foreman');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `risk_matrix_version` SET TAGS ('pii_business_glossary_term' = 'Risk Matrix Version');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `site_zone` SET TAGS ('pii_business_glossary_term' = 'Site Zone / Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `source_type` SET TAGS ('pii_business_glossary_term' = 'Hazard Source Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('pii_subdomain' = 'hazard_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_register_id` SET TAGS ('pii_business_glossary_term' = 'Hazard Register ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Identified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Linked Incident ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `actual_closure_date` SET TAGS ('pii_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `affected_workers_count` SET TAGS ('pii_business_glossary_term' = 'Affected Workers Count');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `control_measures_description` SET TAGS ('pii_business_glossary_term' = 'Control Measures Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `environmental_aspect` SET TAGS ('pii_business_glossary_term' = 'Environmental Aspect Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('pii_business_glossary_term' = 'Hazard Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_category` SET TAGS ('pii_value_regex' = 'physical|chemical|biological|ergonomic|environmental|psychosocial');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_description` SET TAGS ('pii_business_glossary_term' = 'Hazard Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('pii_business_glossary_term' = 'Hazard Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_reference_number` SET TAGS ('pii_value_regex' = '^HAZ-[A-Z0-9]{3,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('pii_business_glossary_term' = 'Hazard Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_status` SET TAGS ('pii_value_regex' = 'open|controlled|eliminated|closed');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_title` SET TAGS ('pii_business_glossary_term' = 'Hazard Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_type` SET TAGS ('pii_business_glossary_term' = 'Hazard Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hazard_type` SET TAGS ('pii_value_regex' = 'fall|struck_by|caught_between|electrocution|excavation_collapse|chemical_exposure');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('pii_business_glossary_term' = 'Hierarchy of Controls');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `hierarchy_of_controls` SET TAGS ('pii_value_regex' = 'elimination|substitution|engineering|administrative|ppe');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identification_source` SET TAGS ('pii_business_glossary_term' = 'Hazard Identification Source');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identification_source` SET TAGS ('pii_value_regex' = 'risk_assessment|inspection|incident|audit|near_miss|worker_report');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `identified_date` SET TAGS ('pii_business_glossary_term' = 'Hazard Identified Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_consequence_rating` SET TAGS ('pii_business_glossary_term' = 'Initial Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Initial Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_level` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `initial_risk_score` SET TAGS ('pii_business_glossary_term' = 'Initial Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `intelex_record_reference` SET TAGS ('pii_business_glossary_term' = 'Intelex Record ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `permit_to_work_required` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `regulatory_notification_required` SET TAGS ('pii_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_consequence_rating` SET TAGS ('pii_business_glossary_term' = 'Residual Consequence Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Residual Likelihood Rating');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `residual_risk_score` SET TAGS ('pii_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `responsible_party` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `site_zone` SET TAGS ('pii_business_glossary_term' = 'Site Zone');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `swms_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `target_closure_date` SET TAGS ('pii_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ALTER COLUMN `tbm_topic_flag` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Topic Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` SET TAGS ('pii_subdomain' = 'field_compliance');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Monitoring Identifier');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `hazard_register_id` SET TAGS ('pii_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `corrective_action_reference` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'valid|suspect|invalid|estimated|below_detection_limit');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `detection_limit` SET TAGS ('pii_business_glossary_term' = 'Instrument Detection Limit');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('pii_business_glossary_term' = 'Threshold Exceedance Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `exceedance_magnitude` SET TAGS ('pii_business_glossary_term' = 'Exceedance Magnitude');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `instrument_calibration_date` SET TAGS ('pii_business_glossary_term' = 'Instrument Last Calibration Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `instrument_calibration_due_date` SET TAGS ('pii_business_glossary_term' = 'Instrument Calibration Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `instrument_code` SET TAGS ('pii_business_glossary_term' = 'Monitoring Instrument ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `instrument_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `instrument_type` SET TAGS ('pii_business_glossary_term' = 'Monitoring Instrument Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `laboratory_name` SET TAGS ('pii_business_glossary_term' = 'Analytical Laboratory Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `laboratory_report_number` SET TAGS ('pii_business_glossary_term' = 'Laboratory Report Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Monitoring Location Latitude');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Monitoring Location Longitude');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `measurement_timestamp` SET TAGS ('pii_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `measurement_unit` SET TAGS ('pii_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `measurement_value` SET TAGS ('pii_business_glossary_term' = 'Measurement Value');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_location_code` SET TAGS ('pii_business_glossary_term' = 'Monitoring Location Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_location_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_location_name` SET TAGS ('pii_business_glossary_term' = 'Monitoring Location Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_method` SET TAGS ('pii_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_parameter` SET TAGS ('pii_business_glossary_term' = 'Environmental Monitoring Parameter');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_record_status` SET TAGS ('pii_business_glossary_term' = 'Monitoring Record Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_record_status` SET TAGS ('pii_value_regex' = 'draft|submitted|verified|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_reference_number` SET TAGS ('pii_business_glossary_term' = 'Environmental Monitoring Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `monitoring_reference_number` SET TAGS ('pii_value_regex' = '^ENV-[A-Z0-9]{3,10}-[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `parameter_category` SET TAGS ('pii_business_glossary_term' = 'Environmental Parameter Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `parameter_category` SET TAGS ('pii_value_regex' = 'air_quality|noise|vibration|water_quality|soil_contamination|dust');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `permit_reference_number` SET TAGS ('pii_business_glossary_term' = 'Environmental Permit Reference Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `regulator_notification_date` SET TAGS ('pii_business_glossary_term' = 'Regulator Notification Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `regulatory_standard_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Standard Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Monitoring Remarks');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `reported_to_regulator` SET TAGS ('pii_business_glossary_term' = 'Reported to Regulator Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `sample_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Sample Duration (Minutes)');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `sample_type` SET TAGS ('pii_business_glossary_term' = 'Sample Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `sample_type` SET TAGS ('pii_value_regex' = 'grab|composite|continuous|passive|integrated');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `threshold_limit` SET TAGS ('pii_business_glossary_term' = 'Regulatory Threshold Limit');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `threshold_type` SET TAGS ('pii_business_glossary_term' = 'Threshold Limit Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `threshold_type` SET TAGS ('pii_value_regex' = 'maximum|minimum|range_upper|range_lower|action_level|alert_level');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Prevailing Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `wind_direction` SET TAGS ('pii_business_glossary_term' = 'Wind Direction');
ALTER TABLE `vibe_construction_v1`.`safety`.`environmental_monitoring` ALTER COLUMN `wind_speed_ms` SET TAGS ('pii_business_glossary_term' = 'Wind Speed (m/s)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` SET TAGS ('pii_subdomain' = 'worker_protection');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `training_id` SET TAGS ('pii_business_glossary_term' = 'Safety Training ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Trainer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `assessment_method` SET TAGS ('pii_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `assessment_method` SET TAGS ('pii_value_regex' = 'written_exam|practical_test|observation|interview|no_assessment');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `assessment_result` SET TAGS ('pii_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `assessment_result` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass|not_assessed');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `attendance_status` SET TAGS ('pii_business_glossary_term' = 'Attendance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `attendance_status` SET TAGS ('pii_value_regex' = 'attended|absent|partial|excused');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `certification_issued` SET TAGS ('pii_business_glossary_term' = 'Certification Issued');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `training_code` SET TAGS ('pii_business_glossary_term' = 'Training Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `training_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|expired|pending_renewal|waived');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `cost` SET TAGS ('pii_business_glossary_term' = 'Training Cost');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Training Currency');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'classroom|online|on_site|blended|simulator|hands_on');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `end_time` SET TAGS ('pii_business_glossary_term' = 'Training End Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `language_of_instruction` SET TAGS ('pii_business_glossary_term' = 'Language of Instruction');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `mandatory_flag` SET TAGS ('pii_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `materials_provided` SET TAGS ('pii_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `next_refresher_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Refresher Due Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `refresher_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Refresher Frequency Months');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `refresher_required` SET TAGS ('pii_business_glossary_term' = 'Refresher Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `regulatory_requirement` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `start_time` SET TAGS ('pii_business_glossary_term' = 'Training Start Time');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Training Title');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `trainer_certification_number` SET TAGS ('pii_business_glossary_term' = 'Trainer Certification Number');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `training_date` SET TAGS ('pii_business_glossary_term' = 'Training Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`training` ALTER COLUMN `training_type` SET TAGS ('pii_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` SET TAGS ('pii_subdomain' = 'hazard_control');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `chemical_register_id` SET TAGS ('pii_business_glossary_term' = 'Chemical Register ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hazard_register_id` SET TAGS ('pii_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `superseded_chemical_register_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Chemical Register Id');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `superseded_chemical_register_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `cas_number` SET TAGS ('pii_business_glossary_term' = 'CAS Registry Number (CAS)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `chemical_family` SET TAGS ('pii_business_glossary_term' = 'Chemical Family');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `chemical_name` SET TAGS ('pii_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `chemical_register_status` SET TAGS ('pii_business_glossary_term' = 'Chemical Register Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `chemical_register_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `control_measures` SET TAGS ('pii_business_glossary_term' = 'Control Measures');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `emergency_procedure` SET TAGS ('pii_business_glossary_term' = 'Emergency Procedure');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `exposure_limit_ple` SET TAGS ('pii_business_glossary_term' = 'Permissible Exposure Limit (PEL)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `exposure_limit_tlv` SET TAGS ('pii_business_glossary_term' = 'Threshold Limit Value (TLV)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `exposure_limit_unit` SET TAGS ('pii_business_glossary_term' = 'Exposure Limit Unit');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `exposure_limit_unit` SET TAGS ('pii_value_regex' = 'ppm|mg/m3|%');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `ghs_classification` SET TAGS ('pii_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hazard_category` SET TAGS ('pii_business_glossary_term' = 'Hazard Category');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `hazard_statement` SET TAGS ('pii_business_glossary_term' = 'Hazard Statement');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `inspection_status` SET TAGS ('pii_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Is Hazardous Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `is_quantities_verified` SET TAGS ('pii_business_glossary_term' = 'Quantities Verified Flag');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `manufacturer_contact` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Contact Email');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `manufacturer_contact` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `manufacturer_contact` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `precautionary_statement` SET TAGS ('pii_business_glossary_term' = 'Precautionary Statement');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `product_code` SET TAGS ('pii_business_glossary_term' = 'Product Code');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `quantity_on_site` SET TAGS ('pii_business_glossary_term' = 'Quantity On Site');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `quantity_unit` SET TAGS ('pii_business_glossary_term' = 'Quantity Unit');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `quantity_unit` SET TAGS ('pii_value_regex' = 'kg|l|gal|lb|ft3|m3');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `required_ppe` SET TAGS ('pii_business_glossary_term' = 'Required Personal Protective Equipment (PPE)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `sds_document_reference` SET TAGS ('pii_business_glossary_term' = 'Safety Data Sheet (SDS) Document Reference');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `sds_last_updated` SET TAGS ('pii_business_glossary_term' = 'SDS Last Updated Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `sds_version` SET TAGS ('pii_business_glossary_term' = 'SDS Version');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `storage_location` SET TAGS ('pii_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `storage_requirements` SET TAGS ('pii_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `storage_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`chemical_register` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_subdomain' = 'incident_management');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_association_edges' = 'safety.incident,subcontractor.firm_profile');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `incident_subcontractor_involvement_id` SET TAGS ('pii_business_glossary_term' = 'Incident Subcontractor Involvement - Incident Subcontractor Involvement Id');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Incident Subcontractor Involvement - Sub Firm Id');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Subcontractor Involvement - Incident Id');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `acknowledgement_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `back_charge_amount` SET TAGS ('pii_business_glossary_term' = 'Back Charge Amount');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `corrective_action_assigned` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Assigned');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `corrective_actions_assigned` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions Assigned');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `fault_determination` SET TAGS ('pii_business_glossary_term' = 'Fault Determination');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `incident_subcontractor_involvement_status` SET TAGS ('pii_business_glossary_term' = 'Incident Subcontractor Involvement Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `involvement_description` SET TAGS ('pii_business_glossary_term' = 'Involvement Description');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `involvement_notes` SET TAGS ('pii_business_glossary_term' = 'Involvement Notes');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `involvement_role` SET TAGS ('pii_business_glossary_term' = 'Involvement Role');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `involvement_status` SET TAGS ('pii_business_glossary_term' = 'Involvement Status');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `involvement_type` SET TAGS ('pii_business_glossary_term' = 'Involvement Type');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `is_responsible_party` SET TAGS ('pii_business_glossary_term' = 'Is Responsible Party');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `liability_assessed` SET TAGS ('pii_business_glossary_term' = 'Liability Assessed');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `liability_assessment` SET TAGS ('pii_business_glossary_term' = 'Liability Assessment');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `liability_percentage` SET TAGS ('pii_business_glossary_term' = 'Liability Percentage');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `notified_date` SET TAGS ('pii_business_glossary_term' = 'Notified Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `personnel_count_involved` SET TAGS ('pii_business_glossary_term' = 'Personnel Count Involved');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `responsibility_pct` SET TAGS ('pii_business_glossary_term' = 'Responsibility Pct');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `responsibility_percent` SET TAGS ('pii_business_glossary_term' = 'Responsibility Percent');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `responsibility_share` SET TAGS ('pii_business_glossary_term' = 'Responsibility Share');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `role_in_incident` SET TAGS ('pii_business_glossary_term' = 'Role In Incident');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_subcontractor_involvement` ALTER COLUMN `workers_affected` SET TAGS ('pii_business_glossary_term' = 'Workers Affected');
