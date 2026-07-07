-- Schema for Domain: site | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`site` COMMENT 'Owns daily site execution data including daily logs, production tracking, work fronts, crew assignments, site logistics, mobilization/demobilization, concrete pours, earthworks volumes, and field progress measurements. Integrates with HCSS HeavyJob for cost coding and production tracking and Procore for daily logs and field management. Supports earned value computation feeding the project domain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`work_front` (
    `work_front_id` BIGINT COMMENT 'Unique surrogate identifier for the work front record. Primary key for the work_front master entity in the site domain.',
    `design_scope_id` BIGINT COMMENT 'Foreign key linking to design.design_scope. Business justification: Each work front operates under a defined design scope package; linking supports scope‑freeze and change‑control processes.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the foreman assigned as the primary supervisor responsible for day-to-day execution at this work front.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost allocation reports require each work front to reference the central cost code for budgeting and variance analysis.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor entity responsible for executing work at this work front when is_subcontracted is True. Null for self-performed work fronts.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Each work front is assigned a primary contract party (sub‑contractor or client) for responsibility, invoicing and performance tracking.',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A work front belongs to a single construction site; adding work_front.site_id creates the required parent relationship and eliminates site isolation.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Work fronts are executed under specific subcontract contracts; linking enables schedule, cost and risk integration.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element that governs the scope of work executed at this work front. Aligns spatial execution with the project schedule hierarchy.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this work front is executed. Enables roll-up of work front data to project-level reporting and earned value computation.',
    `work_site_construction_project_id` BIGINT COMMENT 'Reference to the parent construction site to which this work front belongs. Every work front must be anchored to a site.',
    `access_restriction` STRING COMMENT 'The access control classification for this work front. permit_required indicates a Permit to Work (PTW) is mandatory before entry; restricted_zone limits access to authorised personnel; exclusion_zone prohibits all non-essential access. Supports HSE compliance.. Valid values are `unrestricted|permit_required|restricted_zone|exclusion_zone`',
    `actual_crew_size` STRING COMMENT 'The actual number of direct labour workers present at this work front on the most recent reporting day. Compared against planned_crew_size to identify under-manning and productivity risks.',
    `actual_production_qty` DECIMAL(18,2) COMMENT 'Cumulative actual production quantity achieved at this work front to date, expressed in the production_unit. Sourced from HCSS HeavyJob production tracking and field measurements. Used to compute earned value.',
    `actual_start_date` DATE COMMENT 'The actual date on which work commenced at this work front. Compared against planned_start_date to compute schedule variance. Sourced from Procore daily logs or HCSS HeavyJob time tracking.',
    `area_sqm` DECIMAL(18,2) COMMENT 'Total plan area of the work front in square metres. Used as the principal quantitative measure of the resource for production rate calculations, crew density planning, and progress measurement.',
    `bim_model_reference` STRING COMMENT 'Reference identifier linking this work front to the corresponding spatial object or zone in the Autodesk BIM 360 model. Enables clash detection results and design revisions to be associated with the correct work front.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this work front record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes.',
    `current_phase` STRING COMMENT 'The current construction phase being executed at this work front (e.g., Earthworks, Foundation, Structural, MEP Rough-In, Finishing, Commissioning). Aligns with the project schedule phase hierarchy in Oracle Primavera P6. [ENUM-REF-CANDIDATE: earthworks|foundation|structural|mep_rough_in|finishing|commissioning|handover — promote to reference product]',
    `demobilization_date` DATE COMMENT 'The date on which all resources were demobilized from this work front and active work ceased. Null if the work front is still active. Used to calculate work front duration and close out cost codes.',
    `drawing_reference` STRING COMMENT 'The primary engineering drawing number(s) or revision reference applicable to the work front. Used to ensure field execution aligns with the current approved-for-construction (AFC) drawings managed in Aconex or Autodesk BIM 360.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Reference elevation of the work front above mean sea level in metres. Critical for earthworks volume calculations, drainage design, and structural level control.',
    `environmental_sensitivity` STRING COMMENT 'Classification of the environmental sensitivity of the work front location. sensitive and protected areas require additional environmental controls and monitoring per ISO 14001 and EPA requirements. remediation_required indicates contaminated ground conditions.. Valid values are `standard|sensitive|protected|remediation_required`',
    `forecast_finish_date` DATE COMMENT 'Current forecast date for completion of all work at this work front, updated based on actual progress and remaining work. Supports look-ahead scheduling and early warning of delays.',
    `front_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the work front within the project or site. Used in daily logs, production reports, and cost coding in HCSS HeavyJob and Procore.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `front_name` STRING COMMENT 'Human-readable descriptive name of the work front (e.g., Zone A – Pile Cap Excavation, North Abutment Face). Used in daily logs, progress reports, and field management interfaces.',
    `front_status` STRING COMMENT 'Current lifecycle status of the work front. mobilizing indicates resources are being deployed; active indicates concurrent work is in progress; suspended indicates a temporary hold; demobilized indicates resources have been withdrawn; completed indicates all planned work is finished.. Valid values are `active|inactive|mobilizing|demobilized|suspended|completed`',
    `front_type` STRING COMMENT 'Classification of the spatial unit represented by this work front. Distinguishes between zone (broad area), area (defined boundary), face (excavation or structural face), sector, corridor, level (floor/elevation), or bay. [ENUM-REF-CANDIDATE: zone|area|face|sector|corridor|level|bay — promote to reference product if additional types are required]',
    `grid_reference` STRING COMMENT 'Site-specific grid reference or chainage notation (e.g., Grid E5-F6, CH 1+200 to CH 1+450) used in engineering drawings and BIM models to locate the work front. Complements GPS coordinates for internal site navigation.',
    `heavyjob_cost_center` STRING COMMENT 'The cost center identifier in HCSS HeavyJob associated with this work front. Used for field-level cost allocation, equipment hour tracking, and production rate reporting.',
    `hse_risk_level` STRING COMMENT 'The assessed HSE risk level for this work front based on the activities being performed, proximity to hazards, and environmental conditions. Drives frequency of safety inspections and toolbox meetings (TBM) requirements.. Valid values are `low|medium|high|critical`',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this work front contains activities on the project critical path as determined by the CPM schedule in Oracle Primavera P6. Critical path work fronts receive priority resource allocation and daily progress monitoring.',
    `is_subcontracted` BOOLEAN COMMENT 'Indicates whether the work at this work front is executed by a subcontractor rather than the general contractors own workforce. Drives subcontractor management workflows and contract administration processes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this work front record was most recently modified. Used for incremental data loading in the Databricks Silver Layer and audit trail maintenance.',
    `latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the work front centroid or reference point in decimal degrees (WGS84). Enables spatial aggregation and GIS-based reporting of production and progress data.',
    `longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the work front centroid or reference point in decimal degrees (WGS84). Used alongside latitude for spatial mapping and IoT sensor integration.',
    `mobilization_date` DATE COMMENT 'The date on which resources (crew, equipment, materials) were first mobilized to this work front and active work commenced. Marks the start of the work front lifecycle for scheduling and cost tracking.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current physical percent complete of all planned work at this work front, expressed as a value between 0.00 and 100.00. Sourced from field progress measurements and used as input to earned value computation in the project domain.',
    `planned_crew_size` STRING COMMENT 'The planned number of direct labour workers assigned to this work front per shift as defined in the resource-loaded schedule. Used for crew density analysis and productivity benchmarking.',
    `planned_finish_date` DATE COMMENT 'Baseline-scheduled finish date for all work activities at this work front as defined in the project schedule. Used for schedule performance index (SPI) calculation and look-ahead planning.',
    `planned_production_qty` DECIMAL(18,2) COMMENT 'Total planned production quantity for this work front expressed in the production_unit. Derived from the Bill of Quantities (BOQ) and used as the budget quantity for earned value computation.',
    `planned_start_date` DATE COMMENT 'Baseline-scheduled start date for work activities at this work front as defined in the project schedule (Oracle Primavera P6). Used for schedule variance analysis and earned value computation.',
    `procore_location_reference` STRING COMMENT 'The location identifier assigned to this work front in the Procore construction management system. Used to link daily logs, RFIs, submittals, and change orders to the correct spatial location.',
    `production_unit` STRING COMMENT 'The primary unit of measure used to track production output at this work front (e.g., m3 for earthworks, LM for piling, m2 for formwork, tonnes for steel erection). Aligns with the Bill of Quantities (BOQ) unit for earned value computation.',
    `quality_itp_reference` STRING COMMENT 'Document reference number of the Inspection and Test Plan (ITP) applicable to the primary activities at this work front. Links field execution to the QA/QC management system and NCR tracking.',
    `shift_pattern` STRING COMMENT 'The shift working pattern applied at this work front. Determines daily productive hours available for scheduling and cost rate calculations.. Valid values are `single|double|rotating|night_only|continuous`',
    `swms_reference` STRING COMMENT 'Document reference number of the approved Safe Work Method Statement (SWMS) applicable to the primary activities at this work front. Links field execution to the HSE management system in Intelex.',
    `weather_sensitivity` STRING COMMENT 'Classification of how sensitive the work activities at this work front are to adverse weather conditions. high sensitivity work fronts (e.g., concrete pours, earthworks) require weather monitoring and contingency planning.. Valid values are `low|medium|high`',
    `zone_classification` STRING COMMENT 'Discipline-based classification of the work front zone indicating the primary trade or engineering discipline active at this location. Supports resource planning and subcontractor assignment. [ENUM-REF-CANDIDATE: civil|structural|mep|architectural|earthworks|piling|finishing|commissioning — promote to reference product]',
    CONSTRAINT pk_work_front PRIMARY KEY(`work_front_id`)
) COMMENT 'Master record for each active work front (zone, area, or face) on a construction site where concurrent work activities are executed. Tracks work front identity, location coordinates (GPS/grid reference), zone classification, active/inactive status, assigned foreman, mobilization date, demobilization date, current phase, associated WBS element, and parent site reference. Serves as the primary spatial and organizational anchor for all site-level transactional records — every operational product in this domain holds a mandatory or optional FK to work_front. The work_front-centric topology enables spatial aggregation of production, cost, progress, and resource data by zone.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`daily_log` (
    `daily_log_id` BIGINT COMMENT 'Unique surrogate identifier for the daily site log record. Primary key for the daily_log data product in the Databricks Silver Layer.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Daily Log records activities performed each day; linking to schedule.activity enables daily progress reports and variance analysis.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Daily logs are billed to the governing contract; linking enables cost allocation and compliance reporting per agreement.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Daily logs must reference the active permit governing that days work to satisfy HSE audit trails and permit compliance verification.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project this daily log belongs to. Links the site log to the master project record for earned value and cost control reporting.',
    `daily_site_construction_project_id` BIGINT COMMENT 'Reference to the physical construction site or work front location where this daily log was recorded. Supports multi-site project tracking.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Daily Log reports reference the specific design drawing used for the days work; required for progress audit and compliance.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: REQUIRED: Daily logs capture any incident that occurred that day; the FK enables quick incident lookup from the log.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the site superintendent responsible for completing and signing off this daily log. The accountable party for the legal and operational record of site activity.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the daily log was formally approved by the project manager or designated reviewer. Marks the transition from submitted to approved status in the log lifecycle.',
    `concrete_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of concrete poured on site for the log date in cubic metres. Critical production metric for structural progress tracking, QA/QC compliance (ITP), and earned value computation. Sourced from Procore and HCSS HeavyJob.',
    `cost_code` STRING COMMENT 'HCSS HeavyJob cost code assigned to the primary work activity recorded in this daily log. Enables direct integration between field production data and job costing in Viewpoint Vista and SAP S/4HANA Project Systems.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether any event recorded in this daily log has been flagged as having a potential cost impact requiring a Change Order (CO) or variation claim. True triggers cost impact assessment and contract administration workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this daily log record was first created in the system. Audit trail timestamp for data lineage and Silver Layer ingestion tracking.',
    `direct_labour_count` STRING COMMENT 'Number of direct (GC-employed) workers on site for the log date, excluding subcontractor personnel. Used for workforce planning, payroll reconciliation, and labour productivity benchmarking.',
    `earthworks_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of earthworks (cut, fill, or excavation) completed on site for the log date in cubic metres. Key production quantity for earned value computation, BOQ progress measurement, and HCSS HeavyJob production tracking.',
    `eot_impact_flag` BOOLEAN COMMENT 'Indicates whether any event recorded in this daily log has been flagged as having a potential Extension of Time (EOT) impact on the project programme. True initiates EOT substantiation documentation under FIDIC Clause 8.4 or applicable contract conditions.',
    `equipment_count` STRING COMMENT 'Total number of major equipment units (plant and machinery) present and operational on site for the log date. Used for equipment utilisation tracking, cost coding in HCSS HeavyJob, and mobilisation/demobilisation records.',
    `event_count` STRING COMMENT 'Total number of embedded line-item events (delay events, weather stoppages, utility strikes, design holds, access restrictions, safety observations) recorded within this daily log header. Supports event density analytics and claim complexity assessment.',
    `has_delay_event` BOOLEAN COMMENT 'Indicates whether one or more delay events were recorded in the embedded line-item events for this daily log. True triggers downstream delay analysis workflows and EOT claim tracking. Key filter for delay analytics.',
    `has_safety_observation` BOOLEAN COMMENT 'Indicates whether one or more HSE safety observations or incidents were recorded in the embedded line-item events for this daily log. True triggers integration with Intelex HSE management for incident reporting and corrective action workflows.',
    `hcss_log_reference` STRING COMMENT 'Reference identifier linking this daily log to the corresponding field operations record in HCSS HeavyJob. Supports production tracking reconciliation and cost code validation between Procore and HCSS.',
    `log_date` DATE COMMENT 'The calendar date for which this daily site log records field activities. The principal business event date — one log per project site per calendar day. Drives schedule performance and delay analysis.',
    `log_number` STRING COMMENT 'Externally-known sequential log number assigned by the construction management system (Procore) for this daily log. Used as the human-readable business identifier in correspondence, delay claims, and EOT substantiation. Format: DL-{ProjectCode}-{Year}-{Sequence}.. Valid values are `^DL-[A-Z0-9]+-[0-9]{4}-[0-9]{5}$`',
    `log_status` STRING COMMENT 'Current workflow state of the daily log record. Draft indicates in-progress field entry; submitted indicates superintendent sign-off pending review; approved indicates accepted by project management; rejected indicates returned for correction; void indicates cancelled/superseded entry.. Valid values are `draft|submitted|approved|rejected|void`',
    `lti_occurred_flag` BOOLEAN COMMENT 'Indicates whether a Lost Time Injury (LTI) occurred on site on this log date. True triggers mandatory incident reporting to Intelex HSE system, regulatory notification under OSHA, and TRIR (Total Recordable Incident Rate) calculation update.',
    `ncr_raised_flag` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was raised on this log date. True triggers integration with the QA/QC management workflow and requires corrective action documentation per ISO 9001.',
    `overall_site_status` STRING COMMENT 'High-level classification of site productivity for the log date. Productive indicates full operations; partially_productive indicates reduced output due to delays or restrictions; non_productive indicates no billable work performed; shutdown indicates planned or emergency site closure.. Valid values are `productive|partially_productive|non_productive|shutdown`',
    `permit_to_work_count` STRING COMMENT 'Number of active Permits to Work (PTW) issued and in force on site for the log date. Supports HSE compliance monitoring, Intelex PTW tracking, and regulatory audit evidence for high-risk work activities.',
    `planned_activities_narrative` STRING COMMENT 'Free-text description of the construction activities that were planned for the log date per the project schedule. Compared against work_performed_narrative to identify schedule variances and support look-ahead planning.',
    `precipitation_mm` DECIMAL(18,2) COMMENT 'Total rainfall or precipitation recorded at the site in millimetres for the log date. Key metric for weather delay claims, earthworks productivity assessment, and EOT substantiation under FIDIC Clause 8.4.',
    `procore_log_reference` STRING COMMENT 'Source system identifier for this daily log record in the Procore Construction Management platform. Enables traceability and reconciliation between the Silver Layer data product and the operational system of record.',
    `remarks` STRING COMMENT 'Additional free-text remarks or notes entered by the superintendent for items not captured in structured fields or the work performed narrative. Provides supplementary context for project management review and legal record completeness.',
    `shift_type` STRING COMMENT 'Type of work shift recorded in this daily log. Distinguishes day, night, double-shift, or split-shift operations. Relevant for overtime cost tracking, HSE fatigue management, and productivity benchmarking.. Valid values are `day|night|double_shift|split`',
    `site_access_status` STRING COMMENT 'Operational access status of the construction site for the log date. Closed or restricted access directly impacts productivity and supports delay claim documentation. Partial indicates some work fronts accessible.. Valid values are `open|restricted|closed|partial`',
    `subcontractor_count` STRING COMMENT 'Number of subcontractor personnel on site for the log date. Supports subcontractor performance monitoring, site coordination, and contract administration.',
    `superintendent_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the site superintendent formally signed off and submitted the daily log. Establishes the legal record timestamp for the site activity log. Critical for delay claim and EOT substantiation timelines.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted on site for the log date. Mandatory HSE compliance indicator. True confirms daily safety briefing was held per SWMS (Safe Work Method Statement) requirements.',
    `temperature_high_c` DECIMAL(18,2) COMMENT 'Highest recorded ambient temperature at the site in degrees Celsius for the log date. Used for concrete pour suitability assessment, HSE heat stress monitoring, and weather delay substantiation.',
    `temperature_low_c` DECIMAL(18,2) COMMENT 'Lowest recorded ambient temperature at the site in degrees Celsius for the log date. Used for cold weather concreting assessment, frost protection requirements, and weather delay substantiation.',
    `total_delay_duration_hrs` DECIMAL(18,2) COMMENT 'Aggregate duration in hours of all delay events recorded in the embedded line-item events for this daily log. Used for schedule impact quantification, EOT claim substantiation, and SPI (Schedule Performance Index) computation.',
    `total_manpower_count` STRING COMMENT 'Total number of workers (all trades combined) present on site for the log date. Includes direct labour and subcontractor personnel. Key input for productivity analysis, earned value computation, and labour cost reconciliation against HCSS HeavyJob cost codes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this daily log record was last modified. Supports incremental data loading in the Databricks Silver Layer and audit trail for record changes.',
    `visitor_count` STRING COMMENT 'Number of authorised visitors (client representatives, inspectors, auditors, regulatory officials) on site for the log date. Supports site access management, HSE induction compliance, and client engagement tracking.',
    `wbs_code` STRING COMMENT 'Primary WBS (Work Breakdown Structure) code associated with the dominant work activity performed on this log date. Links site production data to the project schedule in Oracle Primavera P6 for earned value and progress reporting.',
    `weather_condition` STRING COMMENT 'Observed general weather condition at the site for the log date. Used to substantiate weather-related delay claims, EOT applications, and force majeure events under FIDIC contract provisions. [ENUM-REF-CANDIDATE: clear|partly_cloudy|overcast|rain|heavy_rain|snow|fog|storm|extreme_heat — promote to reference product]',
    `wind_speed_kmh` DECIMAL(18,2) COMMENT 'Recorded wind speed at the site in kilometres per hour for the log date. Used to assess crane and elevated work restrictions, HSE compliance, and weather-related work stoppages.',
    `work_performed_narrative` STRING COMMENT 'Free-text superintendent narrative describing all construction activities performed on site during the log date. Serves as the primary operational record and legal evidence base for progress claims, delay substantiation, and EOT applications. Sourced from Procore Daily Logs.',
    CONSTRAINT pk_daily_log PRIMARY KEY(`daily_log_id`)
) COMMENT 'Official daily site log (header + line-item structure) capturing all field activities for a given project site and date. The header records weather conditions (temperature, precipitation, wind), site access status, manpower headcount by trade, equipment on site, work performed narrative, superintendent sign-off, and overall site status. Embedded line-item events capture each notable occurrence including delay events, weather stoppages, utility strikes, design holds, access restrictions, and safety observations — each with event type, start/end time, duration, affected work fronts, root cause classification, responsible party, and EOT/cost impact flags. This is the SSOT for all site event data — no separate event entity exists. Sourced from Procore Daily Logs module. Serves as the legal and operational record of site activity and the primary evidence base for delay claims and EOT substantiation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`production_entry` (
    `production_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each granular production tracking record in the silver layer lakehouse. Primary key for the production_entry data product.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity (Work Breakdown Structure task) against which production quantities are being reported. Sourced from Oracle Primavera P6 activity planning module.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Production reports require linking installed quantities to the specific equipment used for cost allocation and utilization analysis.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this production entry is recorded. Links production quantities to the project domain for earned value computation.',
    `cost_code_id` BIGINT COMMENT 'Reference to the cost code used to classify and track the financial dimension of this production entry. Sourced from HCSS HeavyJob cost coding module and aligned with SAP S/4HANA job costing.',
    `crew_id` BIGINT COMMENT 'Reference to the crew or gang assigned to execute the production work for this entry. Links to workforce domain for labor cost and productivity analysis.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: production_entry contains a daily_log_reference string that points to a daily log; adding a proper FK (daily_log_id) normalizes the model and eliminates the redundant column.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Production entry must record the foreman responsible for the work; required for safety audit and accountability in daily production reports.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Production entries track installed quantities against technical specifications to ensure quality and contractual compliance.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone on site where production was executed. Enables spatial breakdown of production progress across the site.',
    `approved_by` STRING COMMENT 'Name or identifier of the site engineer, superintendent, or project manager who approved this production entry. Required for audit trail and progress billing authorization.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was formally approved by the authorized reviewer. Marks the transition from submitted to approved status and triggers downstream earned value and billing computations.',
    `budgeted_production_rate` DECIMAL(18,2) COMMENT 'The planned or budgeted production rate for this activity and cost code expressed as units per labor-hour. Sourced from the project estimate and HCSS HeavyJob budget. Used to compute production efficiency variance against actual production_rate.',
    `budgeted_quantity` DECIMAL(18,2) COMMENT 'The total budgeted or planned quantity for this activity and cost code as established in the project budget and BOQ (Bill of Quantities). Used as the denominator for percent complete calculation and EVM (Earned Value Management) analysis.',
    `change_order_reference` STRING COMMENT 'Reference number of the approved Change Order (CO) that authorized a scope or quantity revision reflected in this production entry. Links production tracking to contract administration for cost and schedule impact analysis.',
    `cost_code` STRING COMMENT 'The alphanumeric cost code string from HCSS HeavyJob used to classify the type of work for job costing and budget tracking. Aligns with SAP S/4HANA cost element structure.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry record was first created in the source system (HCSS HeavyJob). Serves as the audit trail creation marker for data lineage and compliance purposes.',
    `crew_size` STRING COMMENT 'The number of workers (headcount) assigned to this production activity on the entry date. Used for labor productivity analysis, crew efficiency benchmarking, and workforce planning.',
    `cumulative_quantity` DECIMAL(18,2) COMMENT 'The total quantity of work installed to date for this activity and cost code, inclusive of the current entry. Represents the running total used for percent complete and progress billing milestone verification.',
    `entry_date` DATE COMMENT 'The calendar date on which the production quantities were recorded. Represents the actual field execution date, not the data entry date. Core dimension for daily progress reporting and schedule performance analysis.',
    `entry_number` STRING COMMENT 'Externally-known alphanumeric identifier for this production entry as assigned by the source system (HCSS HeavyJob). Used for cross-system traceability and field reference. Format: PE-[YYYYMMDD]-[SEQ].',
    `entry_status` STRING COMMENT 'Current workflow lifecycle state of the production entry record. Drives approval routing and determines whether quantities are included in earned value and progress billing computations.. Valid values are `draft|submitted|approved|rejected|voided`',
    `equipment_hours` DECIMAL(18,2) COMMENT 'Total equipment operating hours consumed on this production activity for the entry date. Aggregated across all equipment units deployed. Used for equipment cost allocation, utilization analysis, and maintenance scheduling.',
    `installed_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of work physically installed or completed during the entry date for this activity and cost code. This is the primary production measurement used to compute earned value and progress billing. Expressed in the unit of measure defined by unit_of_measure.',
    `is_baseline_revision` BOOLEAN COMMENT 'Indicates whether this production entry reflects a revision to the baseline budgeted quantity due to an approved Change Order (CO) or scope change. When true, the budgeted_quantity reflects the revised baseline.',
    `is_rework` BOOLEAN COMMENT 'Indicates whether this production entry represents rework (corrective re-execution of previously completed work) rather than new production. Rework quantities are tracked separately for quality cost analysis and NCR (Non-Conformance Report) linkage.',
    `itp_reference` STRING COMMENT 'Reference to the Inspection and Test Plan (ITP) checkpoint associated with this production entry. Confirms that quality hold points or witness points have been satisfied before production quantities are accepted for earned value credit.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended by the crew on this production activity for the entry date. Includes all direct labor hours charged to this cost code. Used as the denominator for production rate calculation and labor cost analysis.',
    `ncr_reference` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) associated with this production entry when is_rework is true. Enables traceability between rework production and quality non-conformances for QA/QC reporting.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The percentage of the total budgeted quantity that has been physically installed as of this entry date, calculated as (cumulative_quantity / budgeted_quantity) × 100. Feeds schedule performance index (SPI) and earned value computation in the project domain.',
    `production_rate` DECIMAL(18,2) COMMENT 'The measured production rate for this entry expressed as units of work completed per labor-hour (e.g., CY/hr, LF/hr). Calculated from installed_quantity divided by total labor hours. Used for productivity benchmarking, crew efficiency analysis, and future bid estimation.',
    `production_type` STRING COMMENT 'Classification of the type of construction production activity being tracked. Enables domain-specific productivity benchmarking and reporting across earthworks, concrete, structural, MEP (Mechanical Electrical and Plumbing), and other work categories. [ENUM-REF-CANDIDATE: earthworks|concrete|structural_steel|paving|MEP|formwork|rebar|masonry|finishing|demolition|other — promote to reference product]',
    `remarks` STRING COMMENT 'Free-text field for field supervisors or engineers to record contextual notes about the production entry, including reasons for production variances, site conditions, delays, or other relevant observations not captured in structured fields.',
    `shift_type` STRING COMMENT 'The work shift during which this production was executed. Enables shift-based productivity analysis and supports overtime cost tracking and labor compliance reporting.. Valid values are `day|night|swing|overtime`',
    `source_record_reference` STRING COMMENT 'The native primary key or record identifier of this production entry in the originating source system (e.g., HCSS HeavyJob internal ID). Enables reverse traceability from the lakehouse silver layer back to the operational system of record.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry was submitted for approval by the field team. Used for workflow SLA tracking and audit trail.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Recorded ambient temperature in degrees Celsius at the work front on the entry date. Used to assess weather-related productivity impacts, validate concrete pour conditions per ACI standards, and support EOT (Extension of Time) claims.',
    `unit_of_measure` STRING COMMENT 'The unit of measure applicable to the installed_quantity and budgeted_quantity fields (e.g., CY for cubic yards, LF for linear feet, SF for square feet, EA for each, TON, M3, M2). Sourced from the BOQ (Bill of Quantities) and HCSS HeavyJob. [ENUM-REF-CANDIDATE: CY|LF|SF|EA|TON|M3|M2|LM|KG|HR — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this production entry record was last modified. Tracks revisions to production quantities, status changes, or corrections. Used for data lineage and change audit trail.',
    `wbs_code` STRING COMMENT 'The Work Breakdown Structure code identifying the hierarchical position of the work item within the project scope. Enables roll-up of production quantities to WBS summary levels for EVM reporting.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site during the production entry date. Recorded to support analysis of weather impacts on productivity, substantiate Extension of Time (EOT) claims, and validate production rate variances. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|snow|fog|extreme_heat|wind — 8 candidates stripped; promote to reference product]',
    `work_front_location` STRING COMMENT 'Descriptive location identifier for the work front or zone where production was executed (e.g., Zone A — Grid 1-5, Pier 3 Foundation, Runway 2 Subbase). Supports spatial analysis and site logistics planning.',
    `work_item_description` STRING COMMENT 'Human-readable description of the specific work item or scope of work being tracked in this production entry (e.g., Concrete pour — Column Grid A1-A5, Earthworks cut — Zone 3). Sourced from BOQ (Bill of Quantities) or activity description.',
    CONSTRAINT pk_production_entry PRIMARY KEY(`production_entry_id`)
) COMMENT 'Granular production tracking record capturing quantities of work completed per activity, cost code, and work front for a specific date. Sourced from HCSS HeavyJob production tracking module. Stores installed quantity, unit of measure, production rate (units/hour), budgeted quantity, percent complete, crew size, equipment hours consumed, and cost code. Feeds earned value computation and progress billing in the project and finance domains.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`crew_deployment` (
    `crew_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each daily crew deployment record. Primary key for the crew_deployment data product in the site domain Silver layer.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity (Work Breakdown Structure task) from Oracle Primavera P6 to which this crew is assigned. Enables schedule performance tracking and earned value computation.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Crew deployment plans include equipment assigned to each crew; needed for resource planning and equipment utilisation tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this crew deployment is recorded. Links deployment records to project-level earned value and cost control.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: crew_deployment records reference a daily log via the string field daily_log_reference; converting to a proper FK (daily_log_id) enforces referential integrity and removes the redundant string column.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Crew deployment cost tracking uses finance cost codes to aggregate labor costs per activity for payroll and project costing.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor entity if this crew is supplied by a subcontractor rather than the general contractors direct workforce. Null for self-performed work. Supports subcontractor cost tracking and performance management.',
    `hr_employee_id` BIGINT COMMENT 'Employee identifier of the lead foreman from the workforce system (SAP SuccessFactors). Enables linkage to workforce domain records without duplicating personal data.',
    `work_front_id` BIGINT COMMENT 'Mandatory reference to the work front (spatial zone or work face) to which this crew is deployed. Establishes the spatial allocation of the crew on site for the given date.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total man-hours actually worked by the crew on this deployment date, as recorded in HCSS HeavyJob time tracking. Compared against planned_hours to compute productivity variance and feed EVM calculations.',
    `actual_production_qty` DECIMAL(18,2) COMMENT 'Actual quantity of work output achieved by the crew on this deployment date, as recorded in HCSS HeavyJob production tracking. Compared against planned_production_qty for productivity analysis and earned value computation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this crew deployment record was first created in the data platform. Audit trail field for data governance and lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_code` STRING COMMENT 'Alphanumeric business identifier for the crew or gang as defined in HCSS HeavyJob (e.g., CIV-A, CONC-03). Used for cost coding and production tracking lookups.',
    `crew_name` STRING COMMENT 'Human-readable name or designation of the crew or gang being deployed (e.g., Civil Gang A, Concrete Pour Crew 3, Steel Erection Team North). Sourced from HCSS HeavyJob crew master.',
    `crew_size` STRING COMMENT 'Total number of workers (headcount) in the deployed crew or gang for this date. Used for productivity analysis, labour cost coding, and HSE compliance checks.',
    `crew_type` STRING COMMENT 'Classification of the crew by trade discipline. Drives resource planning, productivity benchmarking, and cost code allocation. [ENUM-REF-CANDIDATE: civil|mep|concrete|steel_erection|earthworks|finishing|specialist|formwork|rebar|waterproofing — promote to reference product]',
    `delay_reason_code` STRING COMMENT 'Standardised code identifying the primary reason for any production delay or underperformance on this deployment (e.g., WEATHER, MATERIAL_SHORTAGE, EQUIPMENT_BREAKDOWN, DESIGN_CHANGE, PERMIT_DELAY). Supports delay analysis and EOT claims. [ENUM-REF-CANDIDATE: WEATHER|MATERIAL_SHORTAGE|EQUIPMENT_BREAKDOWN|DESIGN_CHANGE|PERMIT_DELAY|LABOUR_SHORTAGE|REWORK|SAFETY_STOP — promote to reference product]',
    `deployment_date` DATE COMMENT 'Calendar date on which the crew is deployed to the work front. The principal business event date for this daily deployment record. Format: yyyy-MM-dd.',
    `deployment_number` STRING COMMENT 'Externally-known business identifier for this crew deployment record, typically generated by HCSS HeavyJob (e.g., CD-2024-00123). Used for cross-system referencing and field reporting.',
    `deployment_status` STRING COMMENT 'Current lifecycle state of the crew deployment record. Tracks whether the deployment is planned, actively in progress, completed, cancelled, or suspended due to site conditions.. Valid values are `planned|active|completed|cancelled|suspended`',
    `hse_toolbox_meeting_held` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted with this crew prior to commencing work on this deployment date (True) or not (False). Mandatory HSE compliance check per OSHA and ISO 45001 requirements.',
    `is_overtime` BOOLEAN COMMENT 'Indicates whether this crew deployment involved overtime work (True) or was a standard shift (False). Sourced from HCSS HeavyJob. Used for payroll flagging and cost escalation alerts.',
    `is_subcontractor_crew` BOOLEAN COMMENT 'Indicates whether this crew is supplied by a subcontractor (True) or is part of the general contractors direct workforce (False). Drives cost segregation between self-performed and subcontracted labour.',
    `is_weather_impacted` BOOLEAN COMMENT 'Indicates whether adverse weather conditions materially impacted crew productivity or caused a work stoppage on this deployment date (True) or not (False). Supports Extension of Time (EOT) and delay claim substantiation.',
    `lead_foreman_name` STRING COMMENT 'Full name of the lead foreman or gang leader responsible for supervising this crew deployment. Captured from HCSS HeavyJob time tracking. Classified confidential as it identifies a named employee in a supervisory role.',
    `mobilization_status` STRING COMMENT 'Indicates the mobilization lifecycle stage of the crew relative to the project site. Tracks whether the crew is in the process of mobilizing, fully on site, demobilizing, or has fully demobilized. Supports site logistics planning.. Valid values are `mobilizing|on_site|demobilizing|demobilized`',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked by the crew beyond the standard shift duration on this deployment date. Sourced from HCSS HeavyJob payroll records. Feeds Viewpoint Vista payroll and job costing.',
    `permit_to_work_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) issued for this crew deployment, where the work activity requires a formal permit (e.g., hot work, confined space, excavation). Sourced from Intelex HSE management system.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Total man-hours planned for this crew deployment on the given date, as scheduled in Oracle Primavera P6. Used as the baseline for earned value computation and productivity variance analysis.',
    `planned_production_qty` DECIMAL(18,2) COMMENT 'Target quantity of work output planned for this crew deployment (e.g., cubic metres of concrete, linear metres of pipe, tonnes of steel). Defined in HCSS HeavyJob production tracking against the cost code.',
    `ppe_compliance` BOOLEAN COMMENT 'Indicates whether all crew members were observed to be wearing required Personal Protective Equipment (PPE) at the start of this deployment (True) or a non-compliance was recorded (False). Sourced from Procore or Intelex field inspection.',
    `production_unit_of_measure` STRING COMMENT 'Unit of measure for the planned and actual production quantities (e.g., m3, LM, tonne, m2, EA). Sourced from the HCSS HeavyJob cost code definition and aligned with the Bill of Quantities (BOQ).',
    `productivity_notes` STRING COMMENT 'Free-text field capturing foreman or site supervisor observations about crew productivity, constraints, delays, or notable events during this deployment. Sourced from HCSS HeavyJob or Procore daily log narrative.',
    `productivity_rate` DECIMAL(18,2) COMMENT 'Actual production output per man-hour achieved by this crew on this deployment date (actual_production_qty / actual_hours). Sourced from HCSS HeavyJob production tracking. Used for benchmarking and Schedule Performance Index (SPI) analysis.',
    `shift_end_time` TIMESTAMP COMMENT 'Actual date and time the crew shift ended on site. Sourced from HCSS HeavyJob time tracking. Used in conjunction with shift_start_time to compute actual hours worked. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_start_time` TIMESTAMP COMMENT 'Actual date and time the crew shift commenced on site. Sourced from HCSS HeavyJob time tracking. Used for hours calculation, overtime determination, and HSE compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_type` STRING COMMENT 'Classification of the work shift for this deployment (day, night, swing, or weekend). Drives overtime calculations, HSE fatigue management, and payroll processing.. Valid values are `day|night|swing|weekend`',
    `source_record_reference` STRING COMMENT 'The native record identifier from the originating source system (HCSS HeavyJob or Procore) for this crew deployment entry. Enables reverse traceability from the Silver layer back to the operational system of record.',
    `swms_reference` STRING COMMENT 'Document reference number of the Safe Work Method Statement (SWMS) applicable to this crew deployment and work activity. Confirms that the required HSE documentation was in place before work commenced.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this crew deployment record was last modified in the data platform. Supports incremental data processing, audit trails, and change detection in the Silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure code from Oracle Primavera P6 identifying the project deliverable or work package to which this crew deployment is charged. Supports earned value management (EVM) computation.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition recorded on site for this deployment date, as captured in the Procore daily log. Impacts productivity analysis, delay claims, and Extension of Time (EOT) documentation. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|wind|fog|snow|extreme_heat — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_crew_deployment PRIMARY KEY(`crew_deployment_id`)
) COMMENT 'Daily assignment record linking a named crew or gang to a specific work front, activity, and cost code for a given date. Captures crew type (civil, MEP, concrete, steel erection), crew size, lead foreman, shift start/end times, overtime flag, productivity notes, and planned vs actual hours. Sourced from HCSS HeavyJob time tracking. Holds mandatory FK to work_front for spatial allocation. Distinct from workforce domain employee records — this entity tracks the operational deployment of crews to site activities, not individual labor records.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`concrete_pour` (
    `concrete_pour_id` BIGINT COMMENT 'Unique system-generated identifier for each concrete pour event on site. Primary key for the concrete_pour data product.',
    `activity_id` BIGINT COMMENT 'Reference to the Primavera P6 schedule activity associated with this concrete pour, enabling earned value computation and schedule performance tracking.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Each concrete pour is performed with a concrete pump or mixer; linking to the asset enables equipment performance and maintenance reporting.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this concrete pour event is executed.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Concrete pour records must be linked to the structural drawing defining pour locations for inspection and handover.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Concrete pour entries are charged to specific cost codes; linking enables accurate cost tracking and progress billing.',
    `itp_id` BIGINT COMMENT 'Reference to the Inspection and Test Plan (ITP) record in the quality domain governing the quality hold and inspection requirements for this pour.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: REQUIRED: Concrete pour supervision is assigned to a qualified foreman; FK supports QC, safety audit trails and traceability of pour responsibility.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Concrete pour supervision is a safety‑critical role; linking to employee satisfies HSE compliance and incident investigation.',
    `daily_log_id` BIGINT COMMENT 'Reference identifier of the Procore daily log entry in which this pour event was recorded. Enables cross-system traceability between the lakehouse silver layer and the Procore source system.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element under which this pour activity is tracked for cost and schedule control.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Recorded ambient air temperature in degrees Celsius at the time of the pour. Critical for hot and cold weather concreting compliance, curing regime decisions, and QA/QC records.',
    `batch_plant_name` STRING COMMENT 'Name or identifier of the concrete batching plant that supplied the concrete for this pour. Used for supplier traceability, quality audits, and material domain batch traceability.',
    `concrete_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the fresh concrete measured at point of delivery (truck discharge), in degrees Celsius. Must comply with specification limits for hot/cold weather concreting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this concrete pour record was first created in the system. Used for audit trail, data lineage, and silver layer ingestion tracking.',
    `curing_method` STRING COMMENT 'Method applied to cure the concrete after placement to ensure adequate hydration and strength development. Compliance with specified curing method is a QA/QC requirement.. Valid values are `wet_hessian|curing_compound|ponding|steam|membrane|other`',
    `curing_start_time` TIMESTAMP COMMENT 'Date and time when curing operations commenced after completion of the pour. Used to calculate curing duration compliance against specification requirements.',
    `cylinder_set_reference` STRING COMMENT 'Unique reference number or label assigned to the set of test cylinders cast from this pour, used to track specimens through the laboratory testing process and link results back to the pour event.',
    `delivery_docket_numbers` STRING COMMENT 'Comma-separated list of concrete delivery docket (batch ticket) numbers associated with this pour event. Provides full traceability from batch plant to placement location per QA/QC requirements.',
    `formwork_drawing_ref` STRING COMMENT 'Reference number of the approved formwork or structural drawing used for this pour, as registered in Autodesk BIM 360 or Aconex document management. Provides design traceability.',
    `grid_reference` STRING COMMENT 'Structural grid reference (e.g., A3-B4) or coordinate reference identifying the precise location of the pour on the site drawing or BIM model. Enables spatial traceability and clash detection correlation.',
    `hcss_production_code` STRING COMMENT 'Reference identifier of the HCSS HeavyJob production tracking record associated with this pour event. Enables cross-system traceability for cost coding and production rate analysis.',
    `mix_design_code` STRING COMMENT 'Approved mix design code referencing the specific concrete formulation used for this pour, as registered in the material domain batch traceability records. Links to approved mix design submittals.. Valid values are `^[A-Z0-9]{2,20}$`',
    `ncr_number` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) raised against this pour event if a quality non-conformance was identified. Null if no NCR has been raised.',
    `placement_method` STRING COMMENT 'Method used to place the concrete into the formwork. Affects production rate, quality, and equipment resource planning. Examples: pump (boom pump or line pump), crane and bucket, conveyor belt, direct chute.. Valid values are `pump|crane_bucket|conveyor|direct_chute|other`',
    `pour_date` DATE COMMENT 'Calendar date on which the concrete pour was executed on site. Used for daily log correlation, schedule progress reporting, and curing period calculations.',
    `pour_end_time` TIMESTAMP COMMENT 'Date and time when the last concrete delivery was placed and finishing operations completed, marking the end of the pour event. Used for duration calculation and curing start time.',
    `pour_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the pour event, used in daily logs, QA/QC records, and delivery dockets. Sourced from Procore daily logs and HCSS HeavyJob production tracking.. Valid values are `^PC-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `pour_start_time` TIMESTAMP COMMENT 'Date and time when the first concrete delivery was placed into the formwork, marking the official start of the pour event. Used for duration calculation and ambient condition correlation.',
    `pour_status` STRING COMMENT 'Current lifecycle status of the concrete pour event. on_hold indicates a QC hold has been applied pending inspection release. Drives QA/QC workflow and earned value computation.. Valid values are `planned|in_progress|completed|on_hold|cancelled|rejected`',
    `pour_type` STRING COMMENT 'Classification of the structural element type being poured. Used for production benchmarking, resource planning, and QA/QC ITP selection. [ENUM-REF-CANDIDATE: slab|column|beam|wall|footing|pile_cap|bridge_deck|other — promote to reference product]',
    `qc_hold_status` STRING COMMENT 'Quality Control (QC) hold status for this pour event. hold_applied means the pour is under QC review pending inspection or test results. hold_released means the hold has been cleared by the QA/QC engineer. rejected means the pour has been condemned and remediation is required.. Valid values are `no_hold|hold_applied|hold_released|rejected`',
    `qc_inspector` STRING COMMENT 'Name of the Quality Control (QC) inspector who witnessed the pour, conducted slump tests, and cast test cylinders. Required for QA/QC traceability and ITP sign-off.',
    `relative_humidity_pct` DECIMAL(18,2) COMMENT 'Recorded relative humidity percentage at the pour location at time of placement. Relevant for evaporation rate calculations and plastic shrinkage cracking risk assessment per ACI 305R.',
    `slump_compliant` BOOLEAN COMMENT 'Indicates whether the measured slump result falls within the specified minimum and maximum limits. True = compliant; False = non-compliant, triggering QC review or NCR.',
    `slump_specified_max_mm` DECIMAL(18,2) COMMENT 'Maximum allowable slump value in millimetres as specified in the concrete mix design or project specification. Exceedance triggers rejection or NCR issuance.',
    `slump_specified_min_mm` DECIMAL(18,2) COMMENT 'Minimum allowable slump value in millimetres as specified in the concrete mix design or project specification. Used for QC acceptance/rejection decisions.',
    `slump_test_result_mm` DECIMAL(18,2) COMMENT 'Measured slump value in millimetres from the slump cone test performed on a representative sample of fresh concrete at point of delivery. Indicates workability and water-cement ratio compliance.',
    `specified_strength_mpa` DECIMAL(18,2) COMMENT 'Design-specified characteristic compressive strength of the concrete in megapascals (MPa) at 28 days, as defined in the structural drawings and specification. Used for QC acceptance criteria.',
    `structure_element` STRING COMMENT 'Name or designation of the structural element being poured, such as Pile Cap PC-01, Column C3, Slab Level 4, Retaining Wall RW-02. Provides traceability to design drawings and BIM model elements.',
    `test_cylinders_cast` STRING COMMENT 'Number of concrete test cylinders (or cubes) cast from this pour for compressive strength testing at specified curing ages (e.g., 7-day, 28-day). Minimum count is governed by specification and ACI/ASTM standards.',
    `truck_load_count` STRING COMMENT 'Total number of ready-mix concrete truck loads (agitator trucks) delivered and placed during this pour event. Used for logistics planning, docket reconciliation, and production rate analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this concrete pour record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks lakehouse silver layer.',
    `volume_poured_m3` DECIMAL(18,2) COMMENT 'Total volume of concrete placed during this pour event, measured in cubic metres (m³). Derived from delivery docket quantities and used for earned value computation, material reconciliation, and production tracking in HCSS HeavyJob.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition recorded at the time of the pour. Used for hot/cold weather concreting compliance assessment and daily log documentation.. Valid values are `clear|cloudy|rain|high_wind|extreme_heat|extreme_cold`',
    `wind_speed_kmh` DECIMAL(18,2) COMMENT 'Recorded wind speed in kilometres per hour at the pour location at time of placement. Used in evaporation rate nomograph calculations to assess plastic shrinkage cracking risk.',
    CONSTRAINT pk_concrete_pour PRIMARY KEY(`concrete_pour_id`)
) COMMENT 'Detailed record of each concrete pour event on site, capturing pour date, pour location (structure element, grid reference), mix design code, specified compressive strength (MPa/PSI), volume poured (m³/yd³), batch plant source, delivery docket numbers, pour start/end time, ambient temperature, slump test results, number of test cylinders cast, and QC hold status. Integrates with quality domain ITP records and material domain batch traceability.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`earthwork_volume` (
    `earthwork_volume_id` BIGINT COMMENT 'Unique system-generated identifier for each earthwork volume measurement record. Primary key for the earthwork_volume data product in the site domain.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Earthwork volume measurements are tied to earthwork activities in the schedule; linking supports earned‑value and quantity tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this earthwork volume measurement was recorded. Links earthwork progress to project-level earned value computation.',
    `firm_profile_id` BIGINT COMMENT 'Reference to the subcontractor responsible for executing the earthwork activity. Used for subcontractor quantity verification and progress billing reconciliation.',
    `daily_log_id` BIGINT COMMENT 'Reference identifier linking this earthwork volume measurement to the corresponding daily log entry in Procore Construction Management system. Supports traceability between field measurements and daily site records.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Survey data must be attributed to the responsible surveyor employee for QA/QC and regulatory reporting.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure (WBS) element under which this earthwork activity is classified. Enables cost coding and earned value management (EVM) at the WBS level.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the engineer or quantity surveyor who approved the earthwork volume measurement record for progress billing and earned value reporting.',
    `boq_item_code` STRING COMMENT 'Reference code linking this earthwork volume measurement to the corresponding Bill of Quantities (BOQ) line item in the contract. Enables direct reconciliation between measured quantities and contracted quantities for progress billing.',
    `change_order_reference` STRING COMMENT 'Reference number of the approved Change Order (CO) or variation order authorising earthwork quantities beyond the original contracted scope. Populated only when is_variation_order is true.',
    `compaction_factor` DECIMAL(18,2) COMMENT 'Dimensionless ratio representing the degree of compaction applied to fill material, expressed as the ratio of compacted volume to loose volume. Used to convert loose measure volumes to compacted measure for billing and quality compliance. Typical range 0.70–1.00.',
    `contracted_volume_m3` DECIMAL(18,2) COMMENT 'The total earthwork volume (m³) contracted for this work area and material classification as per the BOQ (Bill of Quantities). Used as the baseline for progress measurement and earned value computation.',
    `coordinate_easting` DECIMAL(18,2) COMMENT 'Easting coordinate (X-axis) of the centroid or reference point of the measured earthwork area in the project coordinate system. Supports GIS (Geographic Information System) integration and spatial reporting.',
    `coordinate_northing` DECIMAL(18,2) COMMENT 'Northing coordinate (Y-axis) of the centroid or reference point of the measured earthwork area in the project coordinate system. Supports GIS (Geographic Information System) integration and spatial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this earthwork volume measurement record was first created in the system. Provides the audit trail creation marker for data lineage and compliance purposes.',
    `cumulative_cut_volume_m3` DECIMAL(18,2) COMMENT 'Total cut volume measured from project commencement to the end of the current reporting period, in cubic metres (m³). Used for progress billing certificates and earned value management (EVM) calculations.',
    `cumulative_fill_volume_m3` DECIMAL(18,2) COMMENT 'Total fill volume measured from project commencement to the end of the current reporting period, in cubic metres (m³). Used for progress billing certificates and earned value management (EVM) calculations.',
    `cut_volume_m3` DECIMAL(18,2) COMMENT 'Volume of material excavated or cut from the natural ground level, measured in cubic metres (m³). Used in earthworks progress billing, BOQ (Bill of Quantities) reconciliation, and subcontractor quantity verification.',
    `disposal_distance_km` DECIMAL(18,2) COMMENT 'Average haul distance in kilometres from the excavation area to the designated spoil disposal site. Used for mass haul cost estimation and subcontractor haulage billing verification.',
    `disposal_site_reference` STRING COMMENT 'Identifier or name of the approved spoil disposal site where surplus or unsuitable excavated material is transported. Required for environmental compliance, EPA reporting, and spoil tracking under ISO 14001.',
    `engineer_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the resident engineer or project engineer formally approved the earthwork volume measurement for inclusion in the progress payment certificate.',
    `fill_volume_m3` DECIMAL(18,2) COMMENT 'Volume of material placed and compacted as fill to raise ground levels, measured in cubic metres (m³). Used in earthworks progress billing and subcontractor quantity verification.',
    `heavyjob_cost_code` STRING COMMENT 'Cost code from HCSS HeavyJob used to classify this earthwork production activity for job costing, production tracking, and earned value computation. Aligns field production data with financial cost control.',
    `is_variation_order` BOOLEAN COMMENT 'Indicates whether this earthwork volume measurement relates to a Change Order (CO) / variation order outside the original contracted scope. When true, the measurement must be linked to an approved variation for billing purposes.',
    `itp_reference` STRING COMMENT 'Reference number of the Inspection and Test Plan (ITP) under which this earthwork volume measurement was conducted. Links the measurement to the applicable QA/QC (Quality Assurance/Quality Control) inspection regime.',
    `material_classification` STRING COMMENT 'Classification of the earthwork material type being measured. Drives compaction factors, disposal requirements, and unit rates for progress billing. Common values: topsoil, clay, rock, sand, gravel, mixed. [ENUM-REF-CANDIDATE: topsoil|clay|rock|sand|gravel|mixed|silt|fill_material|contaminated — promote to reference product]. Valid values are `topsoil|clay|rock|sand|gravel|mixed`',
    `measurement_accuracy_m` DECIMAL(18,2) COMMENT 'Stated positional accuracy of the survey measurement in metres, as reported by the survey instrument or method. Used to assess measurement reliability and compliance with project QA/QC (Quality Assurance/Quality Control) tolerances.',
    `measurement_date` DATE COMMENT 'The calendar date on which the earthwork volume survey measurement was physically conducted on site. Represents the real-world event date, distinct from record creation timestamp.',
    `measurement_reference_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to this earthwork volume measurement record, used in field reports, progress billing certificates, and subcontractor payment applications.',
    `measurement_status` STRING COMMENT 'Current workflow status of the earthwork volume measurement record. Tracks the lifecycle from initial field capture through surveyor submission, engineer review, approval, and payment certification. Values: draft, submitted, under_review, approved, rejected, certified.. Valid values are `draft|submitted|under_review|approved|rejected|certified`',
    `ncr_reference` STRING COMMENT 'Reference number of any Non-Conformance Report (NCR) raised against this earthwork volume measurement. Populated when measurement results fall outside specified tolerances or acceptance criteria.',
    `net_movement_m3` DECIMAL(18,2) COMMENT 'Net earthwork volume movement calculated as cut volume minus fill volume, measured in cubic metres (m³). A positive value indicates net cut (more excavation than fill); negative indicates net fill. Supports mass haul planning and earthworks balance analysis.',
    `rejection_reason` STRING COMMENT 'Free-text description of the reason for rejecting a submitted earthwork volume measurement. Populated when measurement_status is set to rejected. Supports NCR (Non-Conformance Report) tracking and re-measurement workflows.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or qualifications recorded by the surveyor or engineer regarding this earthwork volume measurement. May include site conditions, anomalies, or instructions for re-measurement.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by this earthwork volume measurement. Paired with reporting_period_start to define the billing and progress measurement window.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by this earthwork volume measurement. Used for periodic progress billing and earned value reporting cycles.',
    `spoil_volume_m3` DECIMAL(18,2) COMMENT 'Volume of excavated material classified as spoil (surplus or unsuitable material) that must be removed from site and disposed of, measured in cubic metres (m³). Drives disposal cost tracking and environmental compliance reporting.',
    `survey_instrument_code` STRING COMMENT 'Identifier of the survey instrument or equipment (e.g., total station serial number, drone registration ID, GPS unit ID) used to conduct the measurement. Supports equipment calibration traceability and QA/QC compliance.',
    `survey_method` STRING COMMENT 'The technique used to measure earthwork volumes on site. Accepted values include GPS (Global Positioning System), drone photogrammetry, total station, LiDAR, manual survey, and cross-section method. Affects measurement accuracy and acceptance criteria. [ENUM-REF-CANDIDATE: GPS|drone_photogrammetry|total_station|LiDAR|manual_survey|cross_section|RTK_GPS|BIM_model_comparison — promote to reference product]. Valid values are `GPS|drone_photogrammetry|total_station|LiDAR|manual_survey|cross_section`',
    `surveyor_license_number` STRING COMMENT 'Professional license or registration number of the surveyor who conducted the measurement. Required for regulatory compliance and quality assurance sign-off validation.',
    `surveyor_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the surveyor formally signed off on the earthwork volume measurement, confirming the accuracy of recorded quantities. Critical for audit trail and payment certification.',
    `swell_factor` DECIMAL(18,2) COMMENT 'Dimensionless ratio representing the increase in volume of excavated material compared to its in-situ volume (bank measure). Used to calculate haul volumes and truck load quantities for mass haul planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this earthwork volume measurement record was last modified. Supports audit trail, data lineage tracking, and incremental data loading in the Databricks Lakehouse Silver Layer.',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the time of the earthwork survey measurement. Relevant for assessing measurement reliability, site productivity, and HSE (Health Safety and Environment) compliance. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|storm|snow — promote to reference product]',
    `work_area_code` STRING COMMENT 'Alphanumeric code identifying the defined site area or work front where the earthwork activity was performed. Aligns with site logistics zoning and HCSS HeavyJob cost coding.',
    `work_area_description` STRING COMMENT 'Human-readable description of the site area or work front where the earthwork measurement was taken, providing geographic and operational context for field teams and quantity surveyors.',
    CONSTRAINT pk_earthwork_volume PRIMARY KEY(`earthwork_volume_id`)
) COMMENT 'Earthworks measurement record capturing cut, fill, and spoil volumes for a defined area and reporting period. Stores survey method (GPS, drone photogrammetry, total station), measurement date, cut volume (m³), fill volume (m³), net movement, compaction factor, material classification (topsoil, rock, clay), disposal site reference, and surveyor sign-off. Supports earthworks progress billing and subcontractor quantity verification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`field_progress` (
    `field_progress_id` BIGINT COMMENT 'Unique surrogate identifier for each field progress measurement record in the silver layer lakehouse. Primary key for the field_progress data product.',
    `bid_pricing_line_id` BIGINT COMMENT 'Reference to the BOQ line item from the contract or estimate against which installed quantities are measured. Enables reconciliation of field-installed quantities against contracted scope.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project under which this field progress measurement is captured. Enables project-level aggregation of earned value and progress reporting.',
    `cost_code_id` BIGINT COMMENT 'Reference to the HCSS HeavyJob cost code associated with this progress measurement. Enables cost-to-progress reconciliation and production rate analysis by cost code.',
    `hr_employee_id` BIGINT COMMENT 'System identifier for the field engineer who performed the measurement, referencing the workforce/employee master. Enables linkage to SAP SuccessFactors workforce records for competency and certification validation.',
    `itp_line_id` BIGINT COMMENT 'Reference to the ITP (Inspection and Test Plan) checkpoint that must be satisfied before this progress measurement can be approved. Ensures QA/QC hold points are cleared prior to progress being recognised in EVM.',
    `daily_log_id` BIGINT COMMENT 'The source system identifier of the Procore daily log entry from which this field progress measurement was derived or linked. Enables traceability back to the originating daily log record in Procore for audit and reconciliation purposes.',
    `production_entry_id` BIGINT COMMENT 'The source system identifier of the HCSS HeavyJob production tracking record associated with this field progress measurement. Enables reconciliation between field production data and cost coding in HeavyJob.',
    `activity_id` BIGINT COMMENT 'Reference to the WBS activity or schedule activity in Oracle Primavera P6 against which this field progress measurement is recorded. Links field measurement to the schedule domain for EVM computation.',
    `activity_type` STRING COMMENT 'The construction discipline or work type category of the WBS activity being measured (e.g., earthworks, concrete, structural steel, MEP). Enables discipline-level progress aggregation and resource productivity benchmarking. [ENUM-REF-CANDIDATE: earthworks|concrete|structural_steel|mep|civil|finishing|commissioning|piling|roofing|other — promote to reference product]',
    `approval_status` STRING COMMENT 'Current workflow state of the field progress measurement record. Controls whether the measurement is eligible to feed EVM (Earned Value Management) calculations in the project domain. Draft and rejected records are excluded from BCWP computation.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the field progress measurement was formally approved by the designated approver. Marks the record as eligible for inclusion in EVM calculations. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approver_name` STRING COMMENT 'Full name of the supervisor, project engineer, or quantity surveyor who reviewed and approved the field progress measurement. Required for audit trail and QA/QC compliance.',
    `bcwp` DECIMAL(18,2) COMMENT 'The Budgeted Cost of Work Performed (BCWP), also known as Earned Value, computed as reported_percent_complete multiplied by the budget at completion for the activity. Expressed in project currency. Feeds CPI and SPI calculations in the project domain EVM module.',
    `bim_element_reference` STRING COMMENT 'The BIM (Building Information Modeling) element or object identifier from Autodesk BIM 360 corresponding to the physical work being measured. Enables 4D BIM progress visualization by linking field measurements to the 3D model.',
    `budget_at_completion` DECIMAL(18,2) COMMENT 'The total approved budget allocated to the WBS activity or BOQ line item as of this measurement date. Used as the basis for BCWP computation. Classified as confidential as it contains project financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this field progress measurement record was first created in the system. Audit trail timestamp for data lineage and silver layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_size` STRING COMMENT 'The number of workers deployed on the work front for the activity during the measurement period. Used to compute production rates per worker and benchmark crew productivity against planned norms in HCSS HeavyJob.',
    `data_date` DATE COMMENT 'The official schedule data date or progress cut-off date as defined in Oracle Primavera P6 for the reporting period in which this measurement falls. Aligns field measurements with the schedule baseline for SPI computation.',
    `equipment_hours` DECIMAL(18,2) COMMENT 'Total equipment operating hours logged against this activity during the measurement period. Sourced from HCSS HeavyJob equipment hour tracking. Used for equipment productivity analysis and cost-to-progress reconciliation.',
    `field_engineer_name` STRING COMMENT 'Full name of the field engineer or site engineer who physically performed and recorded the progress measurement. Provides accountability and traceability for the measurement. Classified as confidential PII as it identifies an individual employee.',
    `installed_quantity` DECIMAL(18,2) COMMENT 'The cumulative physical quantity of work installed or completed as measured in the field at the time of this measurement (e.g., cubic metres of concrete poured, linear metres of pipe installed, tonnes of steel erected). Reconciles against the BOQ planned quantity.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether the WBS activity is on the Critical Path Method (CPM) schedule critical path (True) or has float (False). Critical path activities require priority attention as delays directly impact project completion date.',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether the WBS activity associated with this progress measurement is a contract or schedule milestone (True) or a regular work activity (False). Milestone completion triggers contractual notifications and potential payment events.',
    `measurement_date` DATE COMMENT 'The calendar date on which the physical field progress measurement was taken by the field engineer or surveyor. This is the principal real-world event date used for EVM period calculations and schedule reconciliation.',
    `measurement_method` STRING COMMENT 'The technique used to determine the percent complete or installed quantity in the field. Drives confidence weighting in EVM calculations. [ENUM-REF-CANDIDATE: visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps|engineering_estimate — promote to reference product if additional methods are added]. Valid values are `visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps`',
    `measurement_notes` STRING COMMENT 'Free-text field for the field engineer to record observations, constraints, or qualifications relevant to the progress measurement (e.g., partial pour due to rain, access restriction, rework in progress). Supports contextual interpretation of progress data.',
    `measurement_number` STRING COMMENT 'Externally-known unique business identifier for this progress measurement record, typically formatted as a sequential reference number (e.g., FPM-2024-00123) used in Procore daily logs and field management reports.',
    `measurement_period_type` STRING COMMENT 'The reporting frequency or period type for this progress measurement (e.g., daily, weekly, monthly). Determines how the measurement aligns with project reporting cycles and EVM period cut-offs in Oracle Primavera P6.. Valid values are `daily|weekly|fortnightly|monthly`',
    `ncr_reference` STRING COMMENT 'Reference number of any active Non-Conformance Report (NCR) associated with the work being measured. If an NCR is open, the progress measurement may be withheld from EVM until the NCR is closed and rework is verified.',
    `period_installed_quantity` DECIMAL(18,2) COMMENT 'The incremental quantity of work physically installed during the current measurement period only (not cumulative). Used for production rate tracking and period-over-period productivity analysis in HCSS HeavyJob.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The total planned or budgeted quantity for the WBS activity or BOQ line item as per the approved schedule and BOQ. Used as the denominator for quantity-based percent complete calculations and production rate analysis.',
    `previous_percent_complete` DECIMAL(18,2) COMMENT 'The cumulative percent complete recorded in the immediately preceding measurement period for the same WBS activity or BOQ line item. Used to compute the incremental progress delta and validate that progress is monotonically increasing.',
    `progress_delta` DECIMAL(18,2) COMMENT 'The incremental percent complete gained in this measurement period, calculated as reported_percent_complete minus previous_percent_complete. Represents the period productivity for the activity and is used in period-based EVM reporting.',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure applicable to the installed_quantity field (e.g., m3 for concrete, lm for linear metres of pipe, tonne for structural steel). Must align with the BOQ line item unit of measure. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|kg|nr|ls|hr|m — 9 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when a field progress measurement is rejected (approval_status = rejected). Documents the basis for rejection to guide the field engineer in correcting and resubmitting the measurement.',
    `reported_percent_complete` DECIMAL(18,2) COMMENT 'The cumulative percent complete for the WBS activity or BOQ line item as physically measured and reported by the field engineer at the time of this measurement. Expressed as a percentage (0.00–100.00). This is the ground-truth value used to compute BCWP in EVM.',
    `revision_number` STRING COMMENT 'Sequential revision counter for this field progress measurement record. Increments each time the measurement is revised and resubmitted after rejection. Enables version tracking and audit trail of measurement history.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time at which the field engineer submitted the progress measurement record for review and approval. Used to track measurement reporting timeliness and workflow cycle time.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this field progress measurement record was last modified. Supports incremental data loading in the Databricks lakehouse silver layer and audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition on site at the time of the field progress measurement. Used to contextualise productivity rates and support EOT (Extension of Time) claims where adverse weather impacted progress. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|storm|snow|fog|extreme_heat — 8 candidates stripped; promote to reference product]',
    `work_front` STRING COMMENT 'The physical work front, zone, or area of the site where the measured work is being executed (e.g., Zone A, Pier 3, Level 2 North Wing). Enables spatial disaggregation of progress for site logistics and crew assignment analysis.',
    CONSTRAINT pk_field_progress PRIMARY KEY(`field_progress_id`)
) COMMENT 'Periodic field progress measurement record capturing percent complete and installed quantities for a WBS activity or BOQ line item as physically measured in the field. Stores measurement date, measurement method (visual estimate, quantity survey, milestone completion, 3D scan comparison), reported percent complete, previous percent complete, incremental progress delta, field engineer name, and approval status. Feeds EVM (Earned Value Management) calculations including BCWP, CPI, and SPI in the project domain. Provides the ground-truth measurement that reconciles against schedule domain planned progress.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`site_mobilization` (
    `site_mobilization_id` BIGINT COMMENT 'Unique surrogate identifier for the site mobilization record. Primary key for the site_mobilization data product in the Databricks Silver Layer.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Mobilization Cost & Schedule reports are generated per client account; linking site_mobilization to client.account enables billing and performance tracking.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this site mobilization is authorized. Ties mobilization activities to the governing contractual instrument.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Site mobilization records which equipment is moved to the site; essential for mobilization cost accounting and asset location management.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Site mobilization is contingent on a mobilization permit; linking tracks permit approval status against mobilization schedule.',
    `construction_project_id` BIGINT COMMENT 'Reference to the parent project for which this site mobilization record is created. Links site mobilization lifecycle to the overarching project entity.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the Site Manager responsible for overseeing mobilization and site operations. Accountable for HSE compliance, daily logs, and progress reporting.',
    `activity_id` BIGINT COMMENT 'Activity identifier from Oracle Primavera P6 corresponding to the mobilization WBS activity. Enables direct traceability between this mobilization record and the project schedule baseline.',
    `procurement_framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_framework_agreement. Business justification: REQUIRED: Mobilisation activities are often covered under a framework agreement with a vendor; linking enables compliance and spend tracking.',
    `site_id` BIGINT COMMENT 'FK to site.site',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.bid_submission. Business justification: Mobilization plans are executed only after a bid is awarded; linking to the winning bid_submission enables cost tracking and audit of mobilization against the awarded contract.',
    `access_road_established` BOOLEAN COMMENT 'Indicates whether the primary site access road and entry/exit gates have been constructed and are operational for heavy vehicle and workforce ingress/egress.',
    `actual_demobilization_date` DATE COMMENT 'Date on which site demobilization was physically completed and the site was vacated. Compared against planned_demobilization_date to assess demobilization schedule performance.',
    `actual_mobilization_date` DATE COMMENT 'Date on which site mobilization physically commenced (first crew or equipment on site). Compared against planned_mobilization_date to compute mobilization schedule variance.',
    `building_permit_number` STRING COMMENT 'Reference number of the building or construction permit issued by the local authority. Required before commencement of structural works and tracked for regulatory compliance.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual costs incurred for site mobilization activities as recorded in the job costing system (Viewpoint Vista / SAP S/4HANA). Used for cost variance analysis against mobilization_cost_budget.',
    `cost_budget` DECIMAL(18,2) COMMENT 'Approved budget allocated for site mobilization activities including site establishment, temporary facilities, equipment transport, and initial workforce deployment. Expressed in the project currency.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country in which the construction site is located (e.g., USA, AUS, GBR, ARE). Drives regulatory compliance framework selection and reporting jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site mobilization record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this mobilization record (e.g., USD, AUD, GBP, AED). Ensures consistent financial reporting across multi-currency international projects.. Valid values are `^[A-Z]{3}$`',
    `dlp_end_date` DATE COMMENT 'Date on which the Defects Liability Period (DLP) for site establishment works expires. After this date, the contractor is no longer obligated to rectify defects in temporary site infrastructure.',
    `environmental_permit_number` STRING COMMENT 'Reference number of the primary environmental permit issued by the regulatory authority (e.g., EPA NPDES permit number). Required for regulatory compliance tracking and audit.',
    `environmental_permit_obtained` BOOLEAN COMMENT 'Indicates whether all required environmental permits and approvals (e.g., EPA stormwater NPDES permit, land disturbance permit) have been obtained prior to ground disturbance.',
    `hse_plan_approval_date` DATE COMMENT 'Date on which the site HSE plan was formally approved by the HSE Manager and client representative. Required for regulatory compliance and Intelex HSE management system records.',
    `hse_plan_approved` BOOLEAN COMMENT 'Indicates whether the site-specific HSE plan has been reviewed and approved prior to mobilization commencement. Mandatory pre-mobilization gate per ISO 45001 and OSHA requirements.',
    `laydown_area_established` BOOLEAN COMMENT 'Indicates whether the designated materials laydown and storage area has been prepared, demarcated, and made operational for receiving deliveries and storing equipment.',
    `leed_certification_target` STRING COMMENT 'Target LEED certification level for the project site as specified in the contract or client brief. Influences site establishment requirements for waste management, stormwater control, and sustainable practices.. Valid values are `certified|silver|gold|platinum|none`',
    `mobilization_number` STRING COMMENT 'Externally-known business identifier for this mobilization record, used in correspondence, Procore daily logs, and Aconex transmittals. Follows the enterprise MOB-XXXXXX numbering convention.. Valid values are `^MOB-[A-Z0-9]{3,20}$`',
    `mobilization_status` STRING COMMENT 'Current lifecycle state of the site mobilization record: planned (NTP received, not yet started), in_progress (site establishment underway), completed (fully mobilized and operational), demobilized (site closed and handed back), cancelled (mobilization voided), on_hold (temporarily suspended).. Valid values are `planned|in_progress|completed|demobilized|cancelled|on_hold`',
    `mobilization_type` STRING COMMENT 'Classification of the mobilization scope: full_site (complete site establishment), work_package (specific WBS package), temporary_camp (workforce accommodation), equipment_only (plant and machinery deployment), or partial (phased mobilization). [ENUM-REF-CANDIDATE: full_site|work_package|temporary_camp|equipment_only|partial|phased — promote to reference product]. Valid values are `full_site|work_package|temporary_camp|equipment_only|partial`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, constraints, special conditions, or observations related to the site mobilization that are not captured in structured fields (e.g., access restrictions, community liaison requirements).',
    `ntp_date` DATE COMMENT 'Date on which the Notice to Proceed (NTP) was issued by the client or engineer, authorizing the contractor to commence site mobilization and construction activities. Critical contractual milestone.',
    `peak_workforce_actual` STRING COMMENT 'Maximum number of workers (direct and subcontractor) actually recorded on site simultaneously during the mobilization period, as tracked in HCSS HeavyJob time records.',
    `peak_workforce_planned` STRING COMMENT 'Maximum number of workers (direct and subcontractor) planned to be on site simultaneously at peak mobilization, as per the resource-loaded schedule in Oracle Primavera P6.',
    `planned_demobilization_date` DATE COMMENT 'Baseline-scheduled date on which site demobilization was planned to be completed, as per the approved project schedule. Used for resource release planning and contract completion forecasting.',
    `planned_mobilization_date` DATE COMMENT 'Baseline-scheduled date on which site mobilization activities were planned to commence, as recorded in Oracle Primavera P6. Used for schedule variance analysis and earned value management (EVM).',
    `procore_project_reference` STRING COMMENT 'External system identifier for this site in Procore Construction Management platform. Used for cross-system reconciliation of daily logs, RFIs, and field management records.',
    `schedule_variance_days` STRING COMMENT 'Number of calendar days difference between actual_mobilization_date and planned_mobilization_date. Positive value indicates delay; negative value indicates early mobilization. Used for schedule performance reporting.',
    `site_address` STRING COMMENT 'Physical street address or location description of the construction site. Used for logistics coordination, regulatory notifications, and emergency response planning.',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total area of the construction site in square metres as defined in the site establishment plan. Used for site logistics planning, laydown area allocation, and HSE zone management.',
    `site_closure_signoff_date` DATE COMMENT 'Date on which the formal site closure sign-off was completed by the client, engineer, and contractor, confirming all demobilization obligations have been fulfilled and the site has been restored.',
    `site_fencing_complete` BOOLEAN COMMENT 'Indicates whether site perimeter fencing and hoarding have been fully erected as part of site establishment. Key safety milestone required before workforce deployment.',
    `site_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the construction site centroid in decimal degrees (WGS84). Supports GIS-based site mapping, logistics routing, and spatial analytics.',
    `site_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the construction site centroid in decimal degrees (WGS84). Supports GIS-based site mapping, logistics routing, and spatial analytics.',
    `site_office_established` BOOLEAN COMMENT 'Indicates whether the temporary site office (including communications, IT infrastructure, and welfare facilities) has been established and is operational.',
    `temporary_utilities_connected` BOOLEAN COMMENT 'Indicates whether temporary site utilities (power, water, telecommunications, sewage) have been connected and are operational. Prerequisite for sustained site operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this site mobilization record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental ETL processing, and audit compliance.',
    `wbs_code` STRING COMMENT 'WBS element code from SAP S/4HANA or Oracle Primavera P6 assigned to the mobilization cost centre. Enables cost allocation and earned value management (EVM) reporting at the mobilization level.. Valid values are `^[A-Z0-9.-]{3,30}$`',
    CONSTRAINT pk_site_mobilization PRIMARY KEY(`site_mobilization_id`)
) COMMENT 'Master record tracking the mobilization and demobilization lifecycle of a construction site or major work package. Captures planned mobilization date, actual mobilization date, NTP (Notice to Proceed) date, site establishment milestones (fencing, laydown area, site office, utilities), demobilization plan date, actual demobilization date, and site closure sign-off. Provides the temporal and logistical anchor for all site operations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`logistics_plan` (
    `logistics_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the site logistics plan record in the Databricks Silver Layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client approval is required for site logistics plans; the FK ties the plan to the responsible client account for compliance and invoicing.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Logistics plan approval requires a responsible manager; employee link provides accountability and audit of plan changes.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this logistics plan governs. Links to the project master entity.',
    `aconex_document_reference` STRING COMMENT 'Document number assigned in the Aconex Document Management system for this logistics plan, used for formal transmittal, correspondence tracking, and revision control across project stakeholders.',
    `approved_date` DATE COMMENT 'The date on which the logistics plan was formally approved by the designated authority (e.g., HSE Manager, Project Manager, or Client Representative).',
    `bim_model_ref` STRING COMMENT 'Reference to the BIM 360 model or federated model file that contains the 3D site logistics layout, including crane positions, laydown areas, and temporary works modeled in the BIM environment.',
    `client_approval_required` BOOLEAN COMMENT 'Indicates whether this logistics plan requires formal approval from the client or clients representative before implementation, as stipulated in the contract (e.g., FIDIC Engineers consent).',
    `client_approved_date` DATE COMMENT 'Date on which the client or clients representative formally approved this logistics plan. Populated only when client_approval_required is True.',
    `concrete_washout_area_included` BOOLEAN COMMENT 'Indicates whether a designated concrete washout and truck washdown area is included in this logistics plan. Required for concrete pour operations to prevent cement slurry from entering stormwater drains.',
    `construction_phase` STRING COMMENT 'The construction phase or stage this logistics plan applies to (e.g., Mobilization, Substructure, Superstructure, MEP Fit-Out, Commissioning, Demobilization). [ENUM-REF-CANDIDATE: mobilization|substructure|superstructure|mep_fit_out|finishing|commissioning|demobilization — promote to reference product]',
    `crane_lift_zone_count` STRING COMMENT 'Number of designated crane lift zones defined in this logistics plan. Crane lift zones are exclusion and operating areas for tower cranes, mobile cranes, and other lifting equipment, governed by lift plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site logistics plan record was first created in the system. Supports audit trail and data lineage requirements.',
    `delivery_time_window_end` STRING COMMENT 'Latest permitted time for material and equipment deliveries to the site gate, in HH:MM 24-hour format. Deliveries outside this window require special approval and may incur liquidated damages (LD) under planning conditions.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `delivery_time_window_start` STRING COMMENT 'Earliest permitted time for material and equipment deliveries to the site gate, in HH:MM 24-hour format. Restricts deliveries to avoid peak traffic periods and comply with local authority conditions.. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `effective_date` DATE COMMENT 'The date from which this version of the site logistics plan becomes the governing document on site. Personnel and subcontractors must comply from this date forward.',
    `emergency_egress_route_count` STRING COMMENT 'Number of designated emergency egress and evacuation routes defined in this logistics plan. Must comply with fire safety and emergency response regulations and be communicated via site induction.',
    `expiry_date` DATE COMMENT 'The date on which this version of the logistics plan ceases to be valid and must be reviewed or superseded. Nullable for open-ended plans that remain valid until explicitly superseded.',
    `first_aid_facility_count` STRING COMMENT 'Number of first aid stations and medical response points defined in this logistics plan. Must meet OSHA minimum ratios relative to peak site workforce headcount.',
    `fuel_storage_included` BOOLEAN COMMENT 'Indicates whether this logistics plan includes a designated fuel storage and bunded refuelling area for plant and equipment on site. Triggers additional environmental and fire safety controls.',
    `hoarding_perimeter_m` DECIMAL(18,2) COMMENT 'Total length in metres of site hoarding (perimeter security fencing and public protection barriers) defined in this logistics plan. Used for cost estimation and compliance with public safety requirements.',
    `hse_risk_level` STRING COMMENT 'Overall HSE risk classification assigned to this logistics plan based on the complexity of site movements, proximity to live traffic, overhead hazards, and concurrent operations. Drives the frequency of logistics plan reviews.. Valid values are `low|medium|high|critical`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this site logistics plan record was most recently modified. Used for change tracking, incremental data loads in the Databricks Silver Layer, and audit compliance.',
    `laydown_area_count` STRING COMMENT 'Number of designated material laydown and staging zones defined in this logistics plan. Each laydown area is a controlled zone for temporary storage of materials and equipment awaiting installation.',
    `material_staging_zones` STRING COMMENT 'Narrative description of the designated material staging zones on site, including their locations, intended materials (e.g., rebar, formwork, precast elements), and capacity constraints as defined in the logistics plan.',
    `max_vehicle_speed_kmh` STRING COMMENT 'Maximum permitted vehicle speed in kilometres per hour within the site boundary as defined in this logistics plan. Typically 10–15 km/h on construction sites to protect pedestrian workers.',
    `peak_workforce_headcount` STRING COMMENT 'Maximum number of workers (direct and subcontractor) expected on site simultaneously during the period covered by this logistics plan. Drives welfare facility sizing, emergency egress capacity, and traffic management intensity.',
    `plan_number` STRING COMMENT 'Externally-known unique alphanumeric code assigned to this logistics plan, used in correspondence, transmittals, and document control systems such as Aconex and Procore.. Valid values are `^SLP-[A-Z0-9]{3,10}-[0-9]{3,6}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the logistics plan. draft indicates initial preparation; under_review means submitted for approval; approved is the active governing version; superseded means replaced by a newer revision; void means cancelled.. Valid values are `draft|under_review|approved|superseded|void`',
    `plan_title` STRING COMMENT 'Descriptive title of the site logistics plan, typically referencing the construction phase or area it covers (e.g., Phase 2 Substructure Logistics Plan).',
    `plan_type` STRING COMMENT 'Classification of the logistics plan by its purpose or trigger. initial covers site mobilization; phase_specific covers a defined construction phase; emergency addresses unplanned site conditions; temporary_works focuses on temporary structures; revised reflects a major re-plan.. Valid values are `initial|phase_specific|emergency|temporary_works|revised`',
    `prepared_by` STRING COMMENT 'Name or identifier of the individual who authored and prepared this version of the logistics plan, typically the Site Engineer or HSE Coordinator.',
    `procore_submittal_reference` STRING COMMENT 'Reference identifier for the submittal record in Procore Construction Management system through which this logistics plan was submitted for review and approval. Enables traceability to the source system workflow.',
    `revision_description` STRING COMMENT 'Narrative description of the changes made in this revision compared to the previous version, capturing the reason for revision (e.g., crane relocation, new access road, phase transition).',
    `revision_number` STRING COMMENT 'Alphanumeric revision identifier for this version of the logistics plan (e.g., A, B, 01, Rev3). Increments each time the plan is formally revised and reissued.. Valid values are `^[A-Z0-9]{1,5}$`',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total area of the construction site in square metres covered by this logistics plan. Used for planning material staging density, welfare facility ratios, and emergency egress capacity.',
    `site_gate_count` STRING COMMENT 'Number of controlled access gates defined in this logistics plan for entry and exit of personnel, vehicles, and materials. Includes separate pedestrian and vehicle gates where applicable.',
    `site_layout_drawing_ref` STRING COMMENT 'Document reference number or BIM 360 / Aconex document ID for the site layout drawing that accompanies this logistics plan, showing the physical arrangement of zones, routes, and facilities.',
    `swms_reference` STRING COMMENT 'Document reference number for the Safe Work Method Statement (SWMS) associated with this logistics plan. The SWMS details the high-risk construction work activities and controls for site logistics operations.',
    `temp_access_road_count` STRING COMMENT 'Number of temporary access roads established within the site logistics plan for movement of vehicles, plant, and personnel. Includes haul roads, delivery routes, and internal circulation roads.',
    `temporary_works_included` BOOLEAN COMMENT 'Indicates whether this logistics plan includes temporary works arrangements such as shoring, hoarding, temporary bridges, or scaffolding that require a separate temporary works design and approval.',
    `temporary_works_ref` STRING COMMENT 'Document reference number for the temporary works design package associated with this logistics plan. Populated only when temporary_works_included is True.',
    `traffic_management_scheme` STRING COMMENT 'Type of traffic management arrangement implemented on site to separate pedestrian and vehicle movements. segregated means fully separated pedestrian and vehicle routes; controlled_crossing uses marshalled crossing points.. Valid values are `one_way|two_way|segregated|controlled_crossing|mixed`',
    `waste_management_zone_count` STRING COMMENT 'Number of designated waste segregation and skip areas defined in this logistics plan for construction waste, hazardous materials, and recyclables. Supports compliance with EPA and ISO 14001 waste management requirements.',
    `welfare_facility_count` STRING COMMENT 'Number of welfare facility units (site offices, canteens, toilets, first aid rooms, drying rooms) included in this logistics plan. Welfare provision must meet regulatory minimums per workforce headcount.',
    CONSTRAINT pk_logistics_plan PRIMARY KEY(`logistics_plan_id`)
) COMMENT 'Master logistics plan for a construction site defining traffic management routes, laydown areas, material staging zones, crane lift zones, temporary access roads, welfare facilities, emergency egress paths, and temporary works arrangements. Stores plan version, effective date, expiry date, site layout drawing reference, approved-by details, and revision history. Governs how materials, equipment, and personnel move safely and efficiently across the site. Typically versioned as site conditions evolve through construction phases.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`equipment_deployment` (
    `equipment_deployment_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment deployment record in the site domain. Primary key for the equipment_deployment data product.',
    `activity_id` BIGINT COMMENT 'Reference to the scheduled activity or Work Breakdown Structure (WBS) element in the project schedule to which this equipment deployment is assigned.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment master record in the equipment domain. Identifies the specific piece of construction equipment (e.g., excavator, crane, compactor) deployed to site.',
    `construction_project_id` BIGINT COMMENT 'Reference to the project master record. Links the equipment deployment to the construction project under which the equipment is being utilized.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the equipment operator assigned to this deployment. Links to the workforce domain for operator qualification and certification tracking.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment usage charges are posted to finance cost codes; linking enables equipment cost reporting and asset depreciation.',
    `hours_id` BIGINT COMMENT 'The source system record identifier from HCSS HeavyJob equipment hours module. Used for data lineage, reconciliation, and incremental load processing from the operational system of record.',
    `daily_log_id` BIGINT COMMENT 'Reference identifier of the Procore daily log entry from which this equipment deployment record was sourced. Enables traceability back to the source construction management system.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Equipment rental or purchase orders are linked to each deployment for cost allocation and compliance reporting.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone on site where the equipment is deployed. A work front represents a distinct area of concurrent construction activity.',
    `breakdown_description` STRING COMMENT 'Free-text description of the nature of the equipment breakdown or mechanical failure, as recorded by the site supervisor or equipment operator. Populated only when breakdown_flag is True.',
    `breakdown_flag` BOOLEAN COMMENT 'Indicates whether the equipment experienced a mechanical breakdown or unplanned failure during this deployment period. True = breakdown occurred; False = no breakdown. Triggers maintenance workflow in SAP S/4HANA Plant Maintenance.',
    `breakdown_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was unavailable due to mechanical breakdown or unplanned maintenance during the shift or reporting period. Feeds into equipment reliability and maintenance KPI reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the hourly rate and cost values recorded in this deployment record (e.g., USD, AUD, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `deployment_date` DATE COMMENT 'The calendar date on which the equipment was mobilized and deployed to the designated work front or activity. Represents the start of the deployment period for daily or period-based tracking.',
    `deployment_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for this equipment deployment record, as assigned in HCSS HeavyJob or the site daily log system. Used for cross-system traceability and field reporting.',
    `deployment_status` STRING COMMENT 'Current operational lifecycle status of the equipment deployment record. active indicates equipment is in productive use; idle indicates on-site but not producing; breakdown indicates mechanical failure; demobilized indicates equipment has left site; standby indicates awaiting assignment; transferred indicates moved to another work front or project.. Valid values are `active|idle|breakdown|demobilized|standby|transferred`',
    `equipment_type` STRING COMMENT 'Classification of the equipment by functional category (e.g., Excavator, Bulldozer, Crane, Compactor, Concrete Pump, Dump Truck, Grader). Sourced from the equipment master but denormalized here for site-level reporting. [ENUM-REF-CANDIDATE: excavator|bulldozer|crane|compactor|concrete_pump|dump_truck|grader|loader|paver|roller|generator|pump|forklift|drill_rig — promote to reference product]',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed by the equipment during the shift or reporting period, measured in liters. Used for cost tracking, environmental reporting, and fuel efficiency benchmarking.',
    `fuel_type` STRING COMMENT 'Type of fuel consumed by the equipment. Used for environmental emissions reporting and fuel cost categorization.. Valid values are `diesel|petrol|lpg|electric|hybrid`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The contracted or internal charge rate for the equipment per operating hour, in the project currency. Used for job costing and cost-to-complete calculations. Confidential as it reflects commercial pricing.',
    `hse_permit_number` STRING COMMENT 'Reference number of the Permit to Work (PTW) or HSE permit associated with this equipment deployment, where required by site safety regulations (e.g., crane lifts, confined space operations). Links to the Intelex HSE management system.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was on-site but not in productive operation (e.g., waiting for materials, weather delays, operator breaks). Idle hours are tracked separately from operating hours for utilization analysis.',
    `maintenance_order_number` STRING COMMENT 'Reference number of the corrective maintenance work order raised in SAP S/4HANA Plant Maintenance as a result of a breakdown during this deployment. Links field breakdown events to the maintenance management system.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was in productive operation during the shift or reporting period. Used for earned value computation, equipment cost allocation, and maintenance scheduling.',
    `operator_license_number` STRING COMMENT 'The certification or license number of the equipment operator, required for regulated equipment types (e.g., crane operators, forklift operators). Supports OSHA and ISO 45001 compliance verification.',
    `operator_name` STRING COMMENT 'Full name of the equipment operator assigned to this deployment record, as recorded in the daily field log. Retained for field-level traceability and OSHA compliance reporting.',
    `ownership_type` STRING COMMENT 'Indicates whether the deployed equipment is company-owned, rented from an external supplier, leased under a finance or operating lease, or provided by a subcontractor. Affects cost coding and financial treatment.. Valid values are `owned|rented|leased|subcontractor`',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'The target or budgeted production quantity for the equipment during this shift or reporting period, as derived from the project schedule and production plan. Enables variance analysis against actual production.',
    `pre_start_check_flag` BOOLEAN COMMENT 'Indicates whether a pre-start safety inspection was completed for the equipment prior to commencement of operations on this shift. True = pre-start check completed; False = not completed. Required for ISO 45001 and OSHA compliance.',
    `production_quantity` DECIMAL(18,2) COMMENT 'The measured quantity of work produced by the equipment during the shift or reporting period (e.g., cubic meters of earth moved, linear meters of paving laid, cubic meters of concrete poured). The unit is defined by production_unit_of_measure.',
    `production_unit_of_measure` STRING COMMENT 'The unit of measure for the production quantity recorded in this deployment (e.g., m3 for earthworks, lm for linear paving, tonne for material placement). Aligns with the cost code and activity unit of measure. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|each|load|hour — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment deployment record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment deployment record was last modified, in ISO 8601 format with timezone offset. Supports incremental data processing and audit trail requirements in the Databricks Silver Layer.',
    `release_date` DATE COMMENT 'The calendar date on which the equipment was released from the work front or activity and demobilized or reassigned. Null if the equipment is still actively deployed.',
    `remarks` STRING COMMENT 'Free-text field for site supervisor or equipment manager to record additional observations, instructions, or notes relevant to this equipment deployment record (e.g., special operating conditions, partial shift reasons, safety observations).',
    `rental_order_number` STRING COMMENT 'The Purchase Order (PO) or rental agreement reference number for externally rented or leased equipment. Links the deployment record to the procurement and accounts payable process.',
    `shift_date` DATE COMMENT 'The specific working date (shift date) for which this equipment utilization record is reported. Enables daily granularity within a multi-day deployment period.',
    `shift_type` STRING COMMENT 'The work shift during which the equipment was operated. Distinguishes day, night, swing, or double shifts for accurate labor and equipment cost allocation.. Valid values are `day|night|swing|double`',
    `site_location_description` STRING COMMENT 'Descriptive reference to the physical location on site where the equipment is deployed (e.g., Zone A — North Embankment, Pier 3 Foundation, Runway 2 Subbase). Supports spatial tracking and site logistics management.',
    `standby_hours` DECIMAL(18,2) COMMENT 'Total number of hours the equipment was on standby — available and ready but not assigned to active work. Relevant for contract billing where standby rates differ from operating rates.',
    `supplier_name` STRING COMMENT 'Name of the external equipment supplier, rental company, or subcontractor providing the equipment, when ownership_type is rented, leased, or subcontractor. Null for company-owned equipment.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition at the site during the equipment deployment shift. Recorded to support analysis of weather-related productivity impacts and Extension of Time (EOT) claims. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|storm|snow — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_equipment_deployment PRIMARY KEY(`equipment_deployment_id`)
) COMMENT 'Daily or period-based record of construction equipment deployed to a specific work front or activity on site. Captures equipment ID (FK to equipment domain), deployment date, release date, operating hours, idle hours, cost code, operator name, fuel consumption, and breakdown flag. Sourced from HCSS HeavyJob equipment hours module. Distinct from equipment domain master records — this entity tracks the operational utilization of equipment at the site level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`material_delivery` (
    `material_delivery_id` BIGINT COMMENT 'Unique surrogate identifier for each material delivery receipt event recorded at the construction site. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Material deliveries are scheduled against specific construction activities; the FK enables material‑to‑activity traceability for cost and progress.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Material deliveries are executed by specific vehicles; tracking the asset supports logistics, cost, and compliance audits.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Delivery of hazardous or regulated materials requires a specific permit; linking validates compliance before receipt.',
    `engineering_submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Deliveries are matched to approved design submittals to verify material compliance before acceptance.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material delivery records must map to finance cost codes for material cost allocation and inventory valuation.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Materials are frequently delivered by subcontractors; linking delivery to the subcontractor enables accountability, invoicing and quality traceability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this material delivery belongs. Links the physical receipt event to the project context for cost coding and earned value computation.',
    `material_site_construction_project_id` BIGINT COMMENT 'Reference to the construction site where the material delivery was physically received. Supports site-level logistics and laydown area management.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the materials. Links to the procurement domain supplier master for vendor performance tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the procurement domain Purchase Order (PO) against which this delivery was made. Enables reconciliation between the physical receipt event and the contractual procurement record.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee record of the site personnel who received and signed off on the delivery. Links to the workforce domain for accountability and audit trail purposes.',
    `batch_number` STRING COMMENT 'The manufacturers batch or lot number for the delivered material. Critical for quality traceability, enabling recall or investigation of specific production batches if non-conformance is identified post-installation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this material delivery record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which the delivery value and unit rate are expressed (e.g., USD, AUD, GBP). Required for multi-currency project financial management and IFRS/GAAP reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The calendar date on which the material physically arrived at the site gate or designated laydown area. This is the principal real-world event date for the delivery transaction, distinct from the PO expected delivery date.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the material delivery receipt event. Indicates whether the delivery was fully accepted, rejected at the gate, partially accepted, pending quality inspection, or placed on hold pending resolution of a discrepancy.. Valid values are `accepted|rejected|partial|pending_inspection|on_hold`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the delivery vehicle arrived at the site gate or laydown area. Supports site logistics scheduling, gate management, and time-stamped audit trails.',
    `delivery_value` DECIMAL(18,2) COMMENT 'The total monetary value of the accepted delivery, calculated as quantity_accepted multiplied by unit_rate. Used for goods receipt posting, cost accrual, and three-way matching against the supplier invoice. Expressed in the project currency.',
    `discrepancy_notes` STRING COMMENT 'Free-text field capturing details of any discrepancy identified at the point of receipt, including quantity shortfalls, damage descriptions, specification mismatches, or incorrect materials. Used to support NCR (Non-Conformance Report) creation and supplier claims.',
    `docket_number` STRING COMMENT 'The externally-issued delivery docket or delivery note number provided by the supplier on the physical delivery documentation. Used as the primary business identifier for the delivery event and for three-way matching against the PO and invoice.',
    `driver_name` STRING COMMENT 'The name of the delivery driver as recorded on the delivery docket or site gate register. Captured for site security, access control, and delivery audit trail purposes.',
    `expected_delivery_date` DATE COMMENT 'The date on which the delivery was originally scheduled or expected to arrive at site as per the Purchase Order (PO) or procurement schedule. Used to calculate delivery schedule variance and supplier on-time delivery performance.',
    `goods_receipt_number` STRING COMMENT 'The SAP S/4HANA Goods Receipt (GR) document number generated upon posting of the material receipt in the ERP system. Provides the formal financial and inventory accounting reference for the delivery event.',
    `hazardous_material` BOOLEAN COMMENT 'Indicates whether the delivered material is classified as hazardous under applicable regulations (e.g., chemicals, solvents, fuels, asbestos-containing materials). When True, triggers HSE compliance protocols including MSDS verification and segregated storage.',
    `itp_reference` STRING COMMENT 'Reference to the Inspection and Test Plan (ITP) hold or witness point associated with this material delivery. Links the receipt event to the project quality plan to confirm that required inspections were completed before material acceptance.',
    `laydown_zone` STRING COMMENT 'The designated receiving location or laydown area on the site logistics plan where the delivered material was stored upon receipt (e.g., Zone A - Steel Yard, Zone C - Concrete Batching Area). Supports site logistics management and material traceability.',
    `material_category` STRING COMMENT 'High-level classification of the material type delivered. Supports site logistics planning, laydown zone assignment, and HSE compliance for hazardous materials. MEP refers to Mechanical, Electrical, and Plumbing materials. [ENUM-REF-CANDIDATE: concrete|steel|timber|aggregates|MEP|civil|finishing|hazardous|other — promote to reference product]',
    `material_code` STRING COMMENT 'The internal material catalogue code or SAP material number identifying the type of material delivered. Used for stock updates in the materials domain and reconciliation with the Bill of Quantities (BOQ).',
    `material_description` STRING COMMENT 'Free-text description of the material delivered as stated on the delivery docket. Captures the specific grade, specification, or product name (e.g., Ready-Mix Concrete 40MPa, Structural Steel Grade 350, HDPE Pipe DN200).',
    `msds_verified` BOOLEAN COMMENT 'Indicates whether the Material Safety Data Sheet (MSDS) or Safety Data Sheet (SDS) was verified and on file at the time of receipt for hazardous materials. Required for OSHA HazCom compliance and site HSE management.',
    `ncr_reference` STRING COMMENT 'The reference number of the Non-Conformance Report (NCR) raised as a result of a rejected or non-conforming delivery. Links the physical receipt event to the quality management process for corrective action tracking.',
    `po_line_number` STRING COMMENT 'The specific line item number on the Purchase Order (PO) to which this delivery relates. Enables precise three-way matching at the line level between the PO, goods receipt, and supplier invoice.',
    `procore_log_reference` STRING COMMENT 'The reference identifier of the associated Procore daily log entry in which this material delivery was recorded. Enables traceability back to the source system of record for field management and audit purposes.',
    `quantity_accepted` DECIMAL(18,2) COMMENT 'The quantity of material formally accepted after inspection at the point of receipt. May be less than quantity_delivered in cases of partial acceptance due to damage, non-conformance, or specification mismatch. Triggers stock update in the materials domain.',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'The actual quantity of material physically received at the site as measured or counted at the point of receipt. This is the principal quantitative fact for the delivery event and is used to update material stock records and reconcile against the PO quantity.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material that was ordered on the associated Purchase Order (PO) line for this delivery. Enables immediate over/under delivery variance calculation at the point of receipt without requiring a join to the procurement domain.',
    `quantity_rejected` DECIMAL(18,2) COMMENT 'The quantity of material rejected at the point of receipt due to damage, non-conformance with specification, or incorrect material. Triggers a Non-Conformance Report (NCR) and return-to-supplier process.',
    `receipt_condition` STRING COMMENT 'The physical condition of the material as assessed at the point of receipt. Drives the acceptance/rejection decision and informs quality control processes. [ENUM-REF-CANDIDATE: good|damaged|wet|contaminated|incorrect_spec|short_delivered — promote to reference product]. Valid values are `good|damaged|wet|contaminated|incorrect_spec|short_delivered`',
    `receiving_inspector` STRING COMMENT 'The full name of the site personnel who physically received and inspected the delivery at the site gate or laydown area. This individual is accountable for the acceptance/rejection decision recorded on the delivery docket.',
    `temperature_sensitive` BOOLEAN COMMENT 'Indicates whether the delivered material requires temperature-controlled storage conditions (e.g., epoxy resins, certain adhesives, bituminous products, or cold-chain materials). When True, triggers special handling and storage protocols on site.',
    `test_certificate_number` STRING COMMENT 'The reference number of the material test certificate or mill certificate provided by the supplier with the delivery. Confirms that the material meets the specified engineering standards and is required for quality assurance sign-off.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the delivered quantity is expressed (e.g., cubic metres for concrete, tonnes for steel, each for prefabricated elements). Must align with the unit specified on the Purchase Order (PO) for reconciliation. [ENUM-REF-CANDIDATE: m3|tonne|kg|m|m2|EA|L|bag|roll|set — promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'The agreed unit price for the material as per the Purchase Order (PO), expressed in the project currency. Used to calculate the value of the delivery for goods receipt posting and cost accrual in the project financial management system.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this material delivery record was most recently modified. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `vehicle_registration` STRING COMMENT 'The registration plate number of the delivery vehicle. Recorded at the site gate for security, access control, and logistics tracking purposes.',
    `wbs_code` STRING COMMENT 'The Work Breakdown Structure (WBS) code to which the cost of this material delivery is allocated. Enables project cost control, earned value management (EVM), and cost performance index (CPI) computation at the WBS element level.',
    CONSTRAINT pk_material_delivery PRIMARY KEY(`material_delivery_id`)
) COMMENT 'Site-level record of material deliveries received at the construction site gate or designated laydown area. Captures delivery date, supplier name, PO reference (FK to procurement domain), delivery docket number, material description, quantity delivered, unit of measure, receiving location (laydown zone per site_logistics_plan), condition on receipt (accepted/rejected/partial), receiver name, temperature-sensitive storage flag, and discrepancy notes. Distinct from procurement domain PO records — this entity captures the physical receipt event at the site and triggers material domain stock updates.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`instruction` (
    `instruction_id` BIGINT COMMENT 'Unique surrogate identifier for the site instruction record in the silver layer lakehouse. Primary key for this entity.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Site Instructions are issued for specific scheduled activities (e.g., change orders); the link supports instruction tracking against the activity schedule.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract under which this site instruction is issued. Feeds the contract administration and change order process in the contract domain.',
    `change_notice_id` BIGINT COMMENT 'Foreign key linking to design.change_notice. Business justification: Site instructions often stem from formal change notices; linking tracks the originating change for audit.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Site instructions often stem from permit conditions; linking ties each instruction to its governing permit for traceability.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this site instruction was issued. Links to the project domain for earned value and cost control context.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Site instructions are issued to a designated subcontractor to carry out the work; essential for work‑order control and cost allocation.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: REQUIRED: Site instructions must be issued by a responsible craft worker (foreman/supervisor); FK provides accountability and audit trail for instruction enforcement.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Internal site instructions are issued by a designated employee; linking records the issuer for traceability and compliance.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.bid_submission. Business justification: Site instructions (change orders) are issued against the awarded bid; linking provides traceability of instruction impact to the original bid submission.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or site zone affected by this instruction. Supports site operations tracking and resource allocation.',
    `aconex_mail_reference` STRING COMMENT 'Reference number of the formal correspondence or transmittal in the Aconex Document Management system through which this site instruction was officially transmitted to the contractor.',
    `affected_drawing_reference` STRING COMMENT 'Reference number(s) of the engineering drawings or BIM model elements affected by this site instruction, enabling traceability to design documents and supporting RFI and submittal processes.',
    `affected_wbs_code` STRING COMMENT 'Work Breakdown Structure (WBS) code identifying the specific work package or activity affected by this site instruction. Enables cost and schedule impact traceability within the project control framework.',
    `contractor_acknowledgment_date` DATE COMMENT 'Date on which the contractor formally acknowledged receipt of the site instruction. Contractually significant as it starts the clock for contractor response obligations and EOT notice periods under FIDIC.',
    `contractor_dispute_flag` BOOLEAN COMMENT 'Indicates whether the contractor has formally disputed the validity, scope, or commercial basis of this site instruction, triggering the contract dispute resolution process.',
    `contractor_response_date` DATE COMMENT 'Actual date on which the contractor submitted their formal response or cost/time claim in relation to this site instruction. Used to assess compliance with contractual response obligations.',
    `contractor_response_due_date` DATE COMMENT 'Contractually required date by which the contractor must submit a formal response, cost estimate, or notice of claim in relation to this site instruction, calculated from the acknowledgment date per contract conditions.',
    `cost_impact_flag` BOOLEAN COMMENT 'Indicates whether the site instruction is expected to result in a cost variation to the contract. When true, triggers the change order (CO) valuation process in the contract domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time at which this site instruction record was first created in the data platform, providing the audit trail creation marker for data governance and lineage purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the estimated cost impact amount, aligned with the contract currency for financial reporting and EVM calculations.. Valid values are `^[A-Z]{3}$`',
    `instruction_description` STRING COMMENT 'Full narrative description of the work, method change, or site condition to be addressed as directed by the issuing authority. This is the primary contractual content of the instruction.',
    `dispute_reason` STRING COMMENT 'Narrative description of the contractors stated grounds for disputing this site instruction, captured for contract administration and potential adjudication or arbitration proceedings.',
    `document_revision` STRING COMMENT 'Revision identifier of the site instruction document, tracking amendments or superseding versions issued after the original. Supports document control and audit trail requirements.. Valid values are `^[A-Z0-9]{1,5}$`',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Preliminary estimated monetary value of the cost variation associated with this site instruction, expressed in the contract currency. Used for budget forecasting and change order (CO) initiation prior to formal valuation.',
    `estimated_time_impact_days` STRING COMMENT 'Preliminary estimate of the number of calendar days by which this site instruction may extend the contract completion date, used for Extension of Time (EOT) assessment and CPM schedule analysis.',
    `hse_implication_flag` BOOLEAN COMMENT 'Indicates whether this site instruction has Health, Safety, and Environment (HSE) implications requiring a Safe Work Method Statement (SWMS) update, permit to work review, or HSE authority notification before execution.',
    `implementation_completion_date` DATE COMMENT 'Date on which the contractor completed execution of all work directed by the site instruction, enabling closure of the instruction and final cost/time impact confirmation.',
    `implementation_start_date` DATE COMMENT 'Date on which the contractor commenced execution of the work directed by the site instruction. Used for progress tracking and earned value computation.',
    `instruction_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the site instruction by the issuing authority. Used for correspondence, filing, and cross-referencing with contract documents and RFIs. Format: SI-[ProjectCode]-[SequenceNumber].. Valid values are `^SI-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `instruction_status` STRING COMMENT 'Current workflow lifecycle status of the site instruction from issuance through contractor acknowledgment to implementation and closure. [ENUM-REF-CANDIDATE: draft|issued|acknowledged|under_review|implemented|closed|disputed|cancelled — promote to reference product]',
    `instruction_type` STRING COMMENT 'Classification of the nature and purpose of the site instruction, determining the downstream contractual and commercial treatment. [ENUM-REF-CANDIDATE: variation_order|method_change|safety_directive|quality_directive|access_instruction|suspension|acceleration|remedial_work — promote to reference product]',
    `issue_date` DATE COMMENT 'The calendar date on which the site instruction was formally issued by the engineer or client representative to the contractor. This is the principal business event date for the instruction.',
    `issued_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the site instruction was formally transmitted or published to the contractor, capturing the exact moment of issuance for audit and contractual timeline purposes.',
    `issuing_authority_role` STRING COMMENT 'Contractual role or designation of the person who issued the site instruction, determining the authority level and contractual validity of the instruction under the applicable contract conditions.. Valid values are `engineer|client_representative|resident_engineer|project_manager|site_supervisor|clerk_of_works`',
    `issuing_organisation` STRING COMMENT 'Name of the organisation (client, engineer, or consultant firm) on behalf of which the site instruction was issued. Relevant for joint venture and multi-party project structures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time at which this site instruction record was most recently modified in the data platform, supporting change tracking, data quality monitoring, and incremental ETL processing.',
    `linked_change_order_number` STRING COMMENT 'Reference number of the formal Change Order (CO) raised in the contract domain as a result of this site instruction, enabling traceability between field directives and contractual variations.',
    `linked_rfi_number` STRING COMMENT 'Reference number of the Request for Information (RFI) that preceded or triggered this site instruction, providing traceability from field queries to formal directives.',
    `ncr_reference` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) that triggered this site instruction, where the instruction is issued as a corrective action directive in response to a quality non-conformance.',
    `physical_location_description` STRING COMMENT 'Textual description of the specific physical location, chainage, grid reference, or site zone where the instructed work is to be carried out, supporting field crew navigation and site logistics.',
    `procore_instruction_reference` STRING COMMENT 'Native identifier of this site instruction record in the Procore Construction Management system, used for data lineage, reconciliation, and integration with the source system of record.',
    `quality_hold_required` BOOLEAN COMMENT 'Indicates whether a quality hold point or inspection is required before or after execution of the work directed by this site instruction, triggering an Inspection and Test Plan (ITP) checkpoint.',
    `specification_clause_reference` STRING COMMENT 'Reference to the relevant contract specification clause, standard, or technical requirement that the site instruction relates to or invokes, supporting contractual compliance and dispute resolution.',
    `superseded_by_instruction_number` STRING COMMENT 'Instruction number of the subsequent site instruction that supersedes or replaces this one, enabling version chain traceability in the instruction register.',
    `time_impact_flag` BOOLEAN COMMENT 'Indicates whether the site instruction is expected to result in a schedule delay or Extension of Time (EOT) claim. When true, triggers schedule impact assessment in the project domain.',
    `title` STRING COMMENT 'Short descriptive title summarising the subject matter of the site instruction, used for quick identification in registers and dashboards.',
    `urgency_classification` STRING COMMENT 'Priority level assigned to the site instruction indicating the required response timeframe. Emergency instructions may require immediate contractor action to address safety or critical path impacts.. Valid values are `routine|urgent|emergency`',
    CONSTRAINT pk_instruction PRIMARY KEY(`instruction_id`)
) COMMENT 'Formal site instruction issued by the engineer or client representative directing the contractor to carry out specific work, vary a method, or address a site condition. Captures instruction number, issue date, issuing authority, instruction description, affected work front, urgency classification, contractor acknowledgment date, and cost/time impact flag. Feeds the contract administration and change order process in the contract domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`lift_plan` (
    `lift_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the engineered lift plan record. Primary key for the lift_plan data product in the site domain.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Lift Plans are prepared for a scheduled lift activity; associating them with schedule.activity enables lift‑safety coordination and critical‑path analysis.',
    `asset_id` BIGINT COMMENT 'Reference to the specific crane asset record in the equipment register. Links to crane certification, inspection history, and rated capacity documentation.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Lift plans are authorized by a lift permit; linking ensures the plan is executed under the correct regulatory permit.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: REQUIRED: Crane operators are skilled craft workers; linking enables equipment‑operator assignment, certification tracking and labor cost allocation.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Lift plans are prepared/executed by a specific subcontractor providing crane services; required for safety compliance, cost tracking, and contract billing.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project under which this lift plan is executed. Links the lift plan to project cost, schedule, and WBS context.',
    `lift_site_construction_project_id` BIGINT COMMENT 'Reference to the physical construction site where the crane and rigging operation is to be performed.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the workforce record of the appointed person responsible for the lift plan. Used to verify competency certification and training records.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Lift plans reference crane rental purchase orders; the link is needed for safety permits and financial tracking.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: REQUIRED: Lift plans are executed only when a Safe Work Method Statement is approved; the FK ties the plan to its SWMS.',
    `tertiary_lift_rigger_in_charge_employee_id` BIGINT COMMENT 'Reference to the workforce record of the qualified rigger-in-charge responsible for rigging the load and directing the lift operation.',
    `appointed_person_name` STRING COMMENT 'Full name of the appointed person (lift supervisor or lift director) who is responsible for planning and supervising the crane lift operation. Required under ASME P30.1 and OSHA regulations.',
    `approval_status` STRING COMMENT 'Current workflow state of the lift plan through the review and approval lifecycle. Approved status is required before any lift operation may commence.. Valid values are `draft|submitted|approved|rejected|cancelled|superseded`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the lift plan was formally approved by the authorising person. Establishes the validity window for the permit-to-lift.',
    `boom_length_m` DECIMAL(18,2) COMMENT 'Configured boom length in metres used for the lift operation. Together with lift radius, determines the applicable rated capacity from the manufacturer load chart.',
    `capacity_utilisation_pct` DECIMAL(18,2) COMMENT 'Percentage of the crane rated capacity utilised by the planned load weight at the specified radius and boom configuration. Lifts exceeding 75% trigger critical lift classification per ASME P30.1.',
    `crane_make` STRING COMMENT 'Manufacturer name of the crane equipment (e.g., Liebherr, Manitowoc, Terex). Used for load chart reference and manufacturer-specific operating procedures.',
    `crane_model` STRING COMMENT 'Model designation of the crane equipment as specified by the manufacturer. Required for load chart identification and rated capacity verification.',
    `crane_rated_capacity_t` DECIMAL(18,2) COMMENT 'Maximum rated lifting capacity of the crane in metric tonnes as specified in the manufacturer load chart for the configured boom length and radius. Basis for critical lift classification.',
    `crane_type` STRING COMMENT 'Classification of the crane equipment to be used for the lift operation. Determines applicable ASME B30 volume and OSHA regulatory requirements. [ENUM-REF-CANDIDATE: mobile_crawler|mobile_rough_terrain|mobile_all_terrain|tower_luffing|tower_hammerhead|overhead_bridge|gantry|derrick|knuckle_boom — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the lift plan record was first created in the system. Supports audit trail and data lineage requirements.',
    `exclusion_zone_radius_m` DECIMAL(18,2) COMMENT 'Radius in metres of the exclusion zone to be established around the crane and lift area during the operation. No unauthorised personnel permitted within this zone during the lift.',
    `ground_bearing_capacity_kpa` DECIMAL(18,2) COMMENT 'Allowable ground bearing capacity in kilopascals at the crane setup location as determined by geotechnical investigation or site assessment. Must exceed the calculated ground bearing pressure.',
    `ground_bearing_pressure_kpa` DECIMAL(18,2) COMMENT 'Calculated ground bearing pressure in kilopascals at the crane outrigger or crawler pad positions. Must be verified against site geotechnical data to confirm ground stability for the lift.',
    `hook_height_m` DECIMAL(18,2) COMMENT 'Maximum hook height in metres above ground level required for the lift operation. Used to verify clearance from overhead obstructions, power lines, and structures.',
    `hse_risk_level` STRING COMMENT 'Risk classification of the lift operation as assessed in the lift plan risk assessment. Determines the level of management authorisation required prior to lift commencement.. Valid values are `low|medium|high|extreme`',
    `lift_date` DATE COMMENT 'Scheduled or actual calendar date on which the crane lift operation is planned to be executed. Used for permit-to-lift validity and site scheduling.',
    `lift_description` STRING COMMENT 'Narrative description of the lift operation including the nature of the load, purpose of the lift, and any special conditions or constraints relevant to the engineered lift plan.',
    `lift_drawing_reference` STRING COMMENT 'Document reference number for the engineered lift plan drawing showing crane position, load path, pick and set points, exclusion zone, and rigging arrangement. Stored in Aconex or Autodesk BIM 360.',
    `lift_end_time` TIMESTAMP COMMENT 'Planned or actual date and time when the crane lift operation is completed and the exclusion zone is released. Used for permit-to-lift closure.',
    `lift_radius_m` DECIMAL(18,2) COMMENT 'Horizontal distance in metres from the crane centreline of rotation to the centre of the load at the pick point. Determines rated capacity from the manufacturer load chart.',
    `lift_start_time` TIMESTAMP COMMENT 'Planned or actual date and time when the crane lift operation commences. Used for shift scheduling, exclusion zone activation, and permit-to-lift window management.',
    `lift_type` STRING COMMENT 'Classification of the lift operation per ASME B30 and OSHA criteria. Critical lifts involve loads exceeding 75% of crane rated capacity or lifts over energised equipment. Complex lifts involve multiple cranes or unusual conditions. [ENUM-REF-CANDIDATE: routine|critical|complex|tandem|blind — promote to reference product if additional types are required]. Valid values are `routine|critical|complex|tandem|blind`',
    `load_weight_t` DECIMAL(18,2) COMMENT 'Total weight of the load to be lifted in metric tonnes, including the load itself, rigging hardware, spreader bars, and any attached accessories. Used to calculate percentage of rated capacity.',
    `method_statement_reference` STRING COMMENT 'Document reference number for the Safe Work Method Statement (SWMS) associated with this lift plan. The SWMS details the step-by-step safe work procedure for the crane operation.',
    `outrigger_mat_required` BOOLEAN COMMENT 'Indicates whether crane outrigger mats or cribbing are required to distribute ground bearing pressure to within the allowable site capacity. Mandatory field for mobile crane setups.',
    `overhead_obstruction_present` BOOLEAN COMMENT 'Indicates whether overhead obstructions such as power lines, structures, or other cranes are present within the lift envelope. Triggers additional clearance assessment and OSHA power line safety requirements.',
    `permit_to_lift_number` STRING COMMENT 'Reference number of the permit-to-lift issued under the site HSE permit-to-work system. The permit-to-lift must be active and valid before the crane operation commences.',
    `pick_point_description` STRING COMMENT 'Description of the load pick-up location including grid reference, elevation, and any access or ground condition constraints at the pick point.',
    `plan_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the lift plan, used in permit-to-lift documentation, site registers, and correspondence. Format: LP-{ProjectCode}-{Sequence}.. Valid values are `^LP-[A-Z0-9]{2,10}-[0-9]{4,6}$`',
    `power_line_clearance_m` DECIMAL(18,2) COMMENT 'Minimum clearance distance in metres between the crane boom, load line, or load and the nearest energised power line. Null if no power lines are present in the lift envelope.',
    `procore_lift_plan_reference` STRING COMMENT 'External reference identifier for this lift plan record in the Procore construction management system. Used for cross-system traceability between the lakehouse silver layer and the operational source system.',
    `rigging_configuration` STRING COMMENT 'Description of the rigging arrangement including sling type, number of legs, sling angle, shackle sizes, spreader bar details, and attachment points. Must be engineered for the specific load.',
    `set_point_description` STRING COMMENT 'Description of the load set-down or installation location including grid reference, elevation, and any structural or access constraints at the set point.',
    `sling_type` STRING COMMENT 'Primary sling type used in the rigging configuration. Determines applicable ASME B30 volume for inspection and working load limit requirements.. Valid values are `wire_rope|chain|synthetic_web|synthetic_round|shackle_only|spreader_bar`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the lift plan record was most recently modified. Used to detect changes and support version control of the engineered lift plan.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure (WBS) code from Oracle Primavera P6 identifying the project activity or work package to which this lift operation is assigned for schedule and cost tracking.',
    `wind_speed_limit_kmh` DECIMAL(18,2) COMMENT 'Maximum allowable wind speed in kilometres per hour at which the lift operation may proceed, as specified in the crane manufacturer operating manual and lift plan engineering assessment.',
    CONSTRAINT pk_lift_plan PRIMARY KEY(`lift_plan_id`)
) COMMENT 'Engineered lift plan record for crane and rigging operations on site. Captures lift plan number, lift date, crane type and capacity, load weight, lift radius, pick and set points, rigging configuration, ground bearing pressure check, exclusion zone dimensions, appointed person name, approval status, and permit-to-lift reference. Required under OSHA and ASME B30 standards for critical and complex lifts.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`shift_report` (
    `shift_report_id` BIGINT COMMENT 'Unique system-generated identifier for the shift report record. Primary key for the shift_report data product in the site domain. Entity role: TRANSACTION_HEADER.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Shift reports capture permit‑related delays; linking provides direct reference to the permit affecting the shift.',
    `daily_log_id` BIGINT COMMENT 'Reference to the parent daily log record that this shift report rolls up into. Multiple shift reports (day/night/swing) may feed a single daily log for 24-hour continuous operations such as tunnel boring or continuous concrete pours.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the shift supervisor responsible for overseeing all activities, safety, and production during this shift. Accountable party for shift handover and sign-off.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Shift reports feed daily cost roll‑ups; associating each shift with a finance cost code supports daily cost variance analysis.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: REQUIRED: Shift reports record incidents during the shift; linking provides direct reference to the incident record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project this shift report belongs to. Links shift-level operational data to the parent project for earned value and cost control reporting.',
    `shift_site_construction_project_id` BIGINT COMMENT 'Reference to the physical construction site where this shift was executed. Supports site-level aggregation and logistics reporting.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or work zone where shift activities were executed. Enables production tracking and resource allocation analysis by work front.',
    `activities_narrative` STRING COMMENT 'Free-text description of the principal work activities performed during the shift, including scope completed, methods used, and notable observations. Sourced from HCSS HeavyJob field notes and Procore daily log entries.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report was formally approved by the authorised reviewer (typically the site superintendent or project manager). Marks the record as authoritative for earned value and cost reporting.',
    `concrete_volume_m3` DECIMAL(18,2) COMMENT 'Volume of concrete placed during the shift in cubic metres. Specifically tracked for continuous pour operations where shift-level granularity is critical for quality control, mix design compliance, and ACI/IBC structural requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report record was first created in the system. Audit trail field for data lineage and compliance with GDPR data management requirements.',
    `delay_cause` STRING COMMENT 'Primary cause category for any delay experienced during the shift. Supports EOT claim substantiation, delay analysis, and root cause reporting. [ENUM-REF-CANDIDATE: weather|equipment_breakdown|material_shortage|access_restriction|design_change|labour_shortage|utility_conflict|other — promote to reference product]',
    `delay_duration_hrs` DECIMAL(18,2) COMMENT 'Total hours of productive time lost during the shift due to delays (weather, equipment breakdown, material shortage, access restrictions, etc.). Used for Extension of Time (EOT) claims, Liquidated Damages (LD) assessment, and schedule impact analysis.',
    `direct_labour_count` STRING COMMENT 'Number of direct labour personnel (company-employed workers) present and working during the shift. Excludes subcontractor personnel. Used for workforce planning and productivity benchmarking.',
    `earthworks_volume_m3` DECIMAL(18,2) COMMENT 'Volume of earthworks (cut, fill, or excavation) completed during the shift in cubic metres. Key production metric for night-shift earthworks and bulk earthmoving operations. Feeds into MTO reconciliation and earned value reporting.',
    `equipment_count` STRING COMMENT 'Total number of equipment units deployed and operational during the shift. Supports equipment utilization analysis and plant maintenance scheduling in SAP S/4HANA.',
    `equipment_utilisation_pct` DECIMAL(18,2) COMMENT 'Percentage of deployed equipment that was actively productive during the shift, calculated as productive equipment hours divided by total available equipment hours multiplied by 100. Key indicator for plant efficiency and idle cost identification.',
    `handover_notes` STRING COMMENT 'Free-text notes prepared by the outgoing shift supervisor for the incoming shift team. Covers outstanding work, active risks, equipment status, pending permits, and critical instructions. Essential for 24-hour continuous operations continuity.',
    `hcss_shift_reference` STRING COMMENT 'Source system reference identifier from HCSS HeavyJob for this shift record. Enables bi-directional traceability between the lakehouse silver layer and the operational field management system for reconciliation and audit.',
    `incident_count` STRING COMMENT 'Number of safety incidents (near misses, first aid, recordable, or Lost Time Injuries) that occurred during the shift. Distinct from safety observations. Triggers mandatory reporting to Intelex and regulatory notification under OSHA/ISO 45001.',
    `issues_count` STRING COMMENT 'Total number of open issues, constraints, or blockers identified during the shift that require resolution before or during the next shift. Drives issue escalation workflows and handover briefings.',
    `lti_flag` BOOLEAN COMMENT 'Indicates whether a Lost Time Injury (LTI) occurred during this shift. An LTI is a work-related injury or illness resulting in the worker being unable to return to work on the next scheduled shift. Triggers mandatory regulatory reporting and executive escalation.',
    `ncr_raised_flag` BOOLEAN COMMENT 'Indicates whether a Non-Conformance Report (NCR) was raised during this shift for a quality defect or deviation from the Inspection and Test Plan (ITP). Triggers QA/QC workflow in Procore and links to the quality domain.',
    `permit_to_work_number` STRING COMMENT 'Reference number of the active Permit to Work (PTW) authorising high-risk activities during the shift (e.g., hot work, confined space entry, excavation). Links to Intelex permit management for compliance audit trails.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled end time for the shift as defined in the project schedule. Compared against shift_end_timestamp to measure shift overrun and overtime exposure.',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'Target production quantity for the shift as defined in the project schedule and production plan. Compared against production_quantity to compute shift-level production variance and Schedule Performance Index (SPI).',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled start time for the shift as defined in the project schedule. Compared against shift_start_timestamp to measure schedule adherence and identify mobilization delays.',
    `procore_log_reference` STRING COMMENT 'Source system reference identifier from Procore Construction Management for the corresponding daily log or field report entry. Supports cross-system reconciliation between shift-level HCSS data and Procore document management.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Measured quantity of work completed during the shift against the primary production activity (e.g., cubic metres of earthworks excavated, linear metres of pipe laid, cubic metres of concrete poured). The principal quantitative result for the shift. Unit defined in production_unit.',
    `production_unit` STRING COMMENT 'Unit of measure for the production_quantity field (e.g., m3 for earthworks or concrete, lm for linear metres of pipeline, tonne for bulk materials). Ensures dimensional consistency for productivity benchmarking and earned value calculations. [ENUM-REF-CANDIDATE: m3|m2|lm|tonne|each|kg|m|hr — 8 candidates stripped; promote to reference product]',
    `report_number` STRING COMMENT 'Externally-known alphanumeric identifier for the shift report, typically formatted as SR-[ProjectCode]-[Year]-[Sequence]. Used for document control, correspondence, and cross-system referencing in Procore and Aconex.. Valid values are `^SR-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$`',
    `report_status` STRING COMMENT 'Current workflow lifecycle state of the shift report. Tracks progression from field data entry (draft) through supervisor submission, review, and formal approval. Drives downstream integration with daily log consolidation.. Valid values are `draft|submitted|reviewed|approved|rejected`',
    `safety_observation_count` STRING COMMENT 'Number of HSE safety observations (positive or negative) recorded during the shift. Feeds into TRIR (Total Recordable Incident Rate) trending and Intelex HSE management reporting.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred. Used for temporal aggregation, daily log linkage, and schedule performance analysis. Formatted as yyyy-MM-dd per model conventions.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shift concluded on site. Combined with shift_start_timestamp to derive total shift duration and labor hours. Null if shift is still in progress.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shift commenced on site. Principal business event timestamp for the shift lifecycle. Used for labor hour calculation, schedule adherence, and overtime analysis.',
    `shift_type` STRING COMMENT 'Classification of the shift period indicating the operational window. Day shifts typically cover 06:00–18:00, night shifts 18:00–06:00, swing shifts overlap transitions, and extended shifts apply to continuous 24-hour operations such as tunnel boring or continuous concrete pours.. Valid values are `day|night|swing|extended`',
    `subcontractor_count` STRING COMMENT 'Number of subcontractor personnel present and working during the shift. Tracked separately from direct labour for contract administration, cost coding, and subcontractor performance management.',
    `supervisor_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the shift supervisor formally signed off and submitted the shift report. Marks the transition from draft to submitted status and initiates the review and approval workflow.',
    `tbm_conducted_flag` BOOLEAN COMMENT 'Indicates whether a Toolbox Meeting (TBM) was conducted at the start of the shift. TBMs are mandatory pre-shift safety briefings covering hazards, Safe Work Method Statements (SWMS), and permit-to-work requirements. Compliance tracked for ISO 45001 and OSHA audits.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature recorded on site during the shift in degrees Celsius. Relevant for concrete curing compliance (ACI 305/306), heat stress risk management (ISO 45001), and cold weather work procedures.',
    `total_headcount` STRING COMMENT 'Total number of all personnel on site during the shift, including direct labour, subcontractors, supervisors, and visitors. Used for site access control, emergency muster, and HSE compliance reporting.',
    `total_labour_hours` DECIMAL(18,2) COMMENT 'Total man-hours worked across all crew members during the shift, including direct labour and subcontractor labour. Core input for earned value management (EVM) cost performance index (CPI) calculations and labour productivity analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the shift report record was last modified. Supports incremental data loading in the Databricks lakehouse silver layer and audit trail requirements.',
    `wbs_code` STRING COMMENT 'Work Breakdown Structure (WBS) code identifying the project deliverable or work package to which this shifts activities are attributed. Enables cost and schedule integration with Oracle Primavera P6 and SAP PS.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition observed on site during the shift. Impacts productivity, safety risk assessment, and supports weather-related delay and EOT claim documentation. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|fog|wind|storm|snow — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shift_report PRIMARY KEY(`shift_report_id`)
) COMMENT 'Shift-level operational report summarizing activities, headcount, production achieved, issues encountered, and safety observations for a specific shift (day/night/swing) on a work front. Captures shift type, shift supervisor, start/end time, total labor hours, production summary by cost code, equipment utilization summary, open issues count, and shift handover notes. Distinct from daily_log in that it provides finer temporal granularity for 24-hour continuous operations (e.g., tunnel boring, continuous concrete pours, night-shift earthworks) where a single daily log is insufficient. Multiple shift_reports may feed into one daily_log.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`site_permit` (
    `site_permit_id` BIGINT COMMENT 'System generated unique identifier for the site permit record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Permit compliance and cost allocation are reported against the owning client account; linking permits to client.account provides traceability.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Permits (e.g., crane, excavation) are required for particular scheduled activities; linking permits to activity supports compliance reporting.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Required for regulatory reporting: each internal site permit record must be linked to the official regulatory permit to synchronize status, conditions, and renewal tracking.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Permits are generally obtained by the subcontractor responsible for the work front; required for regulatory compliance tracking and reporting.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: REQUIRED: Site permits are recorded in the central PTW system; linking ensures consistency and auditability.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person accountable for compliance with the permit.',
    `renewed_site_permit_id` BIGINT COMMENT 'Self-referencing FK on site_permit (renewed_site_permit_id)',
    `submission_id` BIGINT COMMENT 'Foreign key linking to bid.bid_submission. Business justification: Permits are typically obtained after award; associating each permit with the winning bid_submission supports regulatory compliance reporting and audit.',
    `tertiary_site_close_out_by_employee_id` BIGINT COMMENT 'Identifier of the person who signed off the permit close‑out.',
    `work_front_id` BIGINT COMMENT 'Identifier of the work front to which the permit applies.',
    `application_date` DATE COMMENT 'Date the permit application was submitted.',
    `approval_date` DATE COMMENT 'Date the permit was approved and became effective.',
    `attached_document_reference` STRING COMMENT 'Identifier of the digital file storing the original permit document.',
    `change_order_number` STRING COMMENT 'Reference to a change order that modifies the permit scope or conditions.',
    `close_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit was formally closed after work completion.',
    `compliance_reference` STRING COMMENT 'Reference to the specific regulation or standard (e.g., OSHA 29 CFR 1926.55).',
    `conditions` STRING COMMENT 'Textual description of conditions or restrictions imposed by the authority.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code used for accounting the permit fee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `expiration_notice_sent` BOOLEAN COMMENT 'True if an expiry notice has been sent to the responsible party.',
    `expiry_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `extension_approved_date` DATE COMMENT 'Date an extension to the permit was approved.',
    `extension_requested` BOOLEAN COMMENT 'Indicates whether an extension to the permit expiry has been requested.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the permit, if applicable.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the permit fee.',
    `is_environmental` BOOLEAN COMMENT 'True if the permit involves environmental impact (e.g., discharge, noise).',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether the permit relates to a safety‑critical activity.',
    `issuing_authority` STRING COMMENT 'Regulatory body or organization that issued the permit.. Valid values are `OSHA|local_building_department|environmental_agency|other`',
    `permit_category` STRING COMMENT 'High‑level classification of the permit purpose.. Valid values are `safety|environment|operational`',
    `permit_number` STRING COMMENT 'External reference number assigned by the issuing authority.',
    `permit_type` STRING COMMENT 'Category of work the permit authorizes. Includes common types; other types are captured in the conditions field.. Valid values are `hot_work|excavation|confined_space|crane_operation|road_closure|environmental_discharge`',
    `restrictions` STRING COMMENT 'Specific operational restrictions (e.g., temperature limits, PPE requirements).',
    `revision_number` STRING COMMENT 'Sequential revision number for amended permits.',
    `scope_description` STRING COMMENT 'Narrative describing the specific work scope covered by the permit.',
    `site_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `applied|active|suspended|closed|revoked`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit record.',
    `version` STRING COMMENT 'Alphanumeric version label (e.g., v1, v2a).',
    CONSTRAINT pk_site_permit PRIMARY KEY(`site_permit_id`)
) COMMENT 'Regulatory permit or access authorization record governing permission to execute specific work activities on a construction site. Captures permit type (hot work, excavation, confined space entry, crane operation, road closure, environmental discharge, noise variance), permit number, issuing authority, application date, approval date, expiry date, conditions/restrictions, associated work front, responsible person, permit status (applied/active/suspended/closed), and close-out sign-off. Required under OSHA 29 CFR 1926, local building codes, and environmental regulations. Provides the compliance gate that must be satisfied before work commences on regulated activities. [SSOT: distinct source of truth for site domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`work_front_assignment` (
    `work_front_assignment_id` BIGINT COMMENT 'Primary key for the work_front_assignment association',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - work front assignments must scope to a project',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to the craft worker',
    `crew_id` BIGINT COMMENT 'add column crew_id (BIGINT) with FK to workforce.crew.crew_id - crew assignments to work fronts are core to the entity',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to the work front',
    `actual_finish` DATE COMMENT '',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual labor hours recorded.',
    `actual_start` DATE COMMENT '',
    `allocated_hours` DECIMAL(18,2) COMMENT 'Hours allocated.',
    `allocation_percentage` DECIMAL(18,2) COMMENT '',
    `assigned_quantity` DECIMAL(18,2) COMMENT '',
    `assignment_date` DATE COMMENT '',
    `assignment_end_date` DATE COMMENT 'Date the workers assignment to the work front ends',
    `assignment_start_date` DATE COMMENT 'Date the workers assignment to the work front begins',
    `assignment_status` STRING COMMENT '',
    `completion_pct` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `is_active` BOOLEAN COMMENT 'Whether the assignment is currently active.',
    `notes` STRING COMMENT '',
    `planned_finish` DATE COMMENT '',
    `planned_hours` DECIMAL(18,2) COMMENT 'Planned hours for the assignment.',
    `planned_start` DATE COMMENT '',
    `priority` STRING COMMENT '',
    `progress_percent` DECIMAL(18,2) COMMENT '',
    `remarks` STRING COMMENT '',
    `role` STRING COMMENT 'The workers role on the work front (e.g., foreman, electrician, plumber)',
    `shift` STRING COMMENT 'Shift assigned.',
    `supervisor_name` STRING COMMENT 'Supervising person.',
    `unit_of_measure` STRING COMMENT '',
    `uom` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `work_front_assignment_status` STRING COMMENT '',
    CONSTRAINT pk_work_front_assignment PRIMARY KEY(`work_front_assignment_id`)
) COMMENT 'This association records the staffing of craft workers on work fronts. Each record links one work_front to one craft_worker and captures the assignments start date, end date, and the workers role on that front.. Existence Justification: A work front can have multiple craft workers (foremen, tradespeople) assigned at the same time, and a craft worker can be assigned to multiple work fronts across projects or shifts. The assignment is actively managed by scheduling teams and includes start/end dates and a role for each worker on a front.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the site belongs.',
    `current_location_site_id` BIGINT COMMENT 'Self-referencing FK on site (current_location_site_id)',
    `hr_employee_id` BIGINT COMMENT 'Unique identifier of the person responsible for site management.',
    `site_manager_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or building).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total built‑up area of the site in square feet.',
    `site_category` STRING COMMENT 'High‑level business category of the site.',
    `city` STRING COMMENT 'City where the site is located.',
    `site_code` STRING COMMENT 'External business identifier or code assigned to the site.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code used for financial tracking of the site.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the site location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `crew_capacity` STRING COMMENT 'Maximum number of crew members that can be assigned to the site simultaneously.',
    `demobilization_date` DATE COMMENT 'Date when the site was demobilized.',
    `site_description` STRING COMMENT 'Free‑form description of the site, including notes on purpose or special characteristics.',
    `end_date` DATE COMMENT 'Date when the site was closed or demobilized (nullable).',
    `environmental_permit_number` STRING COMMENT 'Identifier of the environmental permit associated with the site.',
    `gps_accuracy_m` STRING COMMENT 'Estimated accuracy of the GPS coordinates in meters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_mobilized` BOOLEAN COMMENT 'Indicates whether the site is currently mobilized for work.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site location.',
    `mobilization_date` DATE COMMENT 'Date when the site was mobilized.',
    `site_name` STRING COMMENT 'Human‑readable name of the construction site.',
    `owner` STRING COMMENT 'Organization that owns the site.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the environmental permit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address.',
    `region` STRING COMMENT 'Broad geographic region where the site is located.',
    `safety_incident_count` STRING COMMENT 'Cumulative number of safety incidents recorded at the site.',
    `site_status` STRING COMMENT 'Current lifecycle state of the site.',
    `site_type` STRING COMMENT 'Classification of the site based on its primary function.',
    `start_date` DATE COMMENT 'Date when the site became operational or was mobilized.',
    `state` STRING COMMENT 'State or province of the site location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by current_location_site_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`site`.`site_location` (
    `site_location_id` BIGINT COMMENT 'Primary key for site_location',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the site belongs.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee managing the site.',
    `parent_site_location_id` BIGINT COMMENT 'Self-referencing FK on site_location (parent_site_location_id)',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: A site location is defined within a specific site; adding site_location.site_id links locations to their parent site, removing the silo.',
    `address_line1` STRING COMMENT 'Primary street address of the site.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite, building).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total usable area of the site in square feet.',
    `city` STRING COMMENT 'City where the site is located.',
    `construction_end_date` DATE COMMENT 'Date when construction of the site was completed.',
    `construction_start_date` DATE COMMENT 'Date when construction of the site began.',
    `country_code` STRING COMMENT 'Three-letter ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the site became operational or was officially opened.',
    `effective_until` DATE COMMENT 'Date when the site ceased operations or is scheduled to close (nullable).',
    `environmental_zone` STRING COMMENT 'Environmental zoning classification for the site.',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated accuracy of the GPS coordinates.',
    `has_security_system` BOOLEAN COMMENT 'Indicates if the site is equipped with a security system.',
    `inspection_status` STRING COMMENT 'Result of the last inspection.',
    `is_active` BOOLEAN COMMENT 'Indicates if the site record is currently active in the system.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the site is in a remote location (true) or not (false).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the site location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the site location.',
    `site_location_name` STRING COMMENT 'Human readable name of the site location.',
    `number_of_floors` STRING COMMENT 'Total number of floors or levels at the site.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the site.',
    `power_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity of the site in kilowatts.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary site contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the site.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the primary site contact.',
    `security_system_type` STRING COMMENT 'Type of security system installed at the site.',
    `site_category` STRING COMMENT 'Broad classification of the site based on its usage.',
    `site_classification` STRING COMMENT 'Risk or importance classification of the site.',
    `site_description` STRING COMMENT 'Free-text description of the site, including notable features.',
    `site_location_status` STRING COMMENT 'Current operational status of the site.',
    `site_owner` STRING COMMENT 'Legal owner entity of the site.',
    `site_type` STRING COMMENT 'Category of the site based on its primary function.',
    `state_province` STRING COMMENT 'State or province of the site.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    `utility_provider` STRING COMMENT 'Primary utility provider for the site (e.g., electricity, water).',
    `waste_management_plan` STRING COMMENT 'Reference to the waste management plan document or identifier.',
    `water_supply_type` STRING COMMENT 'Source of water supply for the site.',
    CONSTRAINT pk_site_location PRIMARY KEY(`site_location_id`)
) COMMENT 'Master reference table for site_location. Referenced by site_location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ADD CONSTRAINT `fk_site_earthwork_volume_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_production_entry_id` FOREIGN KEY (`production_entry_id`) REFERENCES `vibe_construction_v1`.`site`.`production_entry`(`production_entry_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ADD CONSTRAINT `fk_site_site_mobilization_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ADD CONSTRAINT `fk_site_instruction_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ADD CONSTRAINT `fk_site_shift_report_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_renewed_site_permit_id` FOREIGN KEY (`renewed_site_permit_id`) REFERENCES `vibe_construction_v1`.`site`.`site_permit`(`site_permit_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ADD CONSTRAINT `fk_site_site_permit_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ADD CONSTRAINT `fk_site_work_front_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_current_location_site_id` FOREIGN KEY (`current_location_site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_parent_site_location_id` FOREIGN KEY (`parent_site_location_id`) REFERENCES `vibe_construction_v1`.`site`.`site_location`(`site_location_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ADD CONSTRAINT `fk_site_site_location_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`site` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`site` SET TAGS ('pii_domain' = 'site');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_subdomain' = 'field_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `design_scope_id` SET TAGS ('pii_business_glossary_term' = 'Design Scope Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Foreman ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `work_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('pii_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `access_restriction` SET TAGS ('pii_value_regex' = 'unrestricted|permit_required|restricted_zone|exclusion_zone');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_crew_size` SET TAGS ('pii_business_glossary_term' = 'Actual Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_production_qty` SET TAGS ('pii_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `area_sqm` SET TAGS ('pii_business_glossary_term' = 'Work Front Area (Square Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `bim_model_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `current_phase` SET TAGS ('pii_business_glossary_term' = 'Current Construction Phase');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `drawing_reference` SET TAGS ('pii_business_glossary_term' = 'Engineering Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `elevation_m` SET TAGS ('pii_business_glossary_term' = 'Elevation (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('pii_business_glossary_term' = 'Environmental Sensitivity Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `environmental_sensitivity` SET TAGS ('pii_value_regex' = 'standard|sensitive|protected|remediation_required');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `forecast_finish_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Finish Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('pii_business_glossary_term' = 'Work Front Code');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_name` SET TAGS ('pii_business_glossary_term' = 'Work Front Name');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('pii_business_glossary_term' = 'Work Front Status');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_status` SET TAGS ('pii_value_regex' = 'active|inactive|mobilizing|demobilized|suspended|completed');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `front_type` SET TAGS ('pii_business_glossary_term' = 'Work Front Type');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `grid_reference` SET TAGS ('pii_business_glossary_term' = 'Site Grid Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `heavyjob_cost_center` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Cost Center');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Method (CPM) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `is_subcontracted` SET TAGS ('pii_business_glossary_term' = 'Subcontracted Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `percent_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_crew_size` SET TAGS ('pii_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_finish_date` SET TAGS ('pii_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_production_qty` SET TAGS ('pii_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `procore_location_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Location ID');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `production_unit` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `quality_itp_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('pii_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `shift_pattern` SET TAGS ('pii_value_regex' = 'single|double|rotating|night_only|continuous');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `swms_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('pii_business_glossary_term' = 'Weather Sensitivity Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `weather_sensitivity` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ALTER COLUMN `zone_classification` SET TAGS ('pii_business_glossary_term' = 'Zone Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_subdomain' = 'field_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `daily_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Superintendent ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `concrete_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Volume (Cubic Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `direct_labour_count` SET TAGS ('pii_business_glossary_term' = 'Direct Labour Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `earthworks_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Earthworks Volume (Cubic Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `eot_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Extension of Time (EOT) Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `equipment_count` SET TAGS ('pii_business_glossary_term' = 'Equipment Count On Site');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `event_count` SET TAGS ('pii_business_glossary_term' = 'Line-Item Event Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `has_delay_event` SET TAGS ('pii_business_glossary_term' = 'Has Delay Event Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `has_safety_observation` SET TAGS ('pii_business_glossary_term' = 'Has Safety Observation Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `hcss_log_reference` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Log Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_date` SET TAGS ('pii_business_glossary_term' = 'Log Date');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('pii_business_glossary_term' = 'Daily Log Number');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_number` SET TAGS ('pii_value_regex' = '^DL-[A-Z0-9]+-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('pii_business_glossary_term' = 'Daily Log Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `log_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|void');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `lti_occurred_flag` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Occurred Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `ncr_raised_flag` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('pii_business_glossary_term' = 'Overall Site Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `overall_site_status` SET TAGS ('pii_value_regex' = 'productive|partially_productive|non_productive|shutdown');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `permit_to_work_count` SET TAGS ('pii_business_glossary_term' = 'Permit to Work Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `planned_activities_narrative` SET TAGS ('pii_business_glossary_term' = 'Planned Activities Narrative');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `precipitation_mm` SET TAGS ('pii_business_glossary_term' = 'Precipitation (Millimetres)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `procore_log_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Superintendent Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|double_shift|split');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('pii_business_glossary_term' = 'Site Access Status');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `site_access_status` SET TAGS ('pii_value_regex' = 'open|restricted|closed|partial');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `subcontractor_count` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `superintendent_sign_off_timestamp` SET TAGS ('pii_business_glossary_term' = 'Superintendent Sign-Off Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `temperature_high_c` SET TAGS ('pii_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `temperature_low_c` SET TAGS ('pii_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `total_delay_duration_hrs` SET TAGS ('pii_business_glossary_term' = 'Total Delay Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `total_manpower_count` SET TAGS ('pii_business_glossary_term' = 'Total Manpower Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `visitor_count` SET TAGS ('pii_business_glossary_term' = 'Site Visitor Count');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `wind_speed_kmh` SET TAGS ('pii_business_glossary_term' = 'Wind Speed (Kilometres per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ALTER COLUMN `work_performed_narrative` SET TAGS ('pii_business_glossary_term' = 'Work Performed Narrative');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_subdomain' = 'field_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_entry_id` SET TAGS ('pii_business_glossary_term' = 'Production Entry ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Foreman Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `technical_specification_id` SET TAGS ('pii_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `budgeted_production_rate` SET TAGS ('pii_business_glossary_term' = 'Budgeted Production Rate (Units per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `budgeted_quantity` SET TAGS ('pii_business_glossary_term' = 'Budgeted Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `change_order_reference` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `crew_size` SET TAGS ('pii_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `cumulative_quantity` SET TAGS ('pii_business_glossary_term' = 'Cumulative Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_date` SET TAGS ('pii_business_glossary_term' = 'Production Entry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_number` SET TAGS ('pii_business_glossary_term' = 'Production Entry Number');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_business_glossary_term' = 'Production Entry Status');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `entry_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|voided');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `equipment_hours` SET TAGS ('pii_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `installed_quantity` SET TAGS ('pii_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `is_baseline_revision` SET TAGS ('pii_business_glossary_term' = 'Is Baseline Revision Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `is_rework` SET TAGS ('pii_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `itp_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `labor_hours` SET TAGS ('pii_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `percent_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Complete (%)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_rate` SET TAGS ('pii_business_glossary_term' = 'Production Rate (Units per Hour)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `production_type` SET TAGS ('pii_business_glossary_term' = 'Production Type');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Production Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `temperature_c` SET TAGS ('pii_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_front_location` SET TAGS ('pii_business_glossary_term' = 'Work Front Location');
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ALTER COLUMN `work_item_description` SET TAGS ('pii_business_glossary_term' = 'Work Item Description');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_subdomain' = 'field_operations');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Crew Deployment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Lead Foreman Employee ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `actual_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `actual_production_qty` SET TAGS ('pii_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_code` SET TAGS ('pii_business_glossary_term' = 'Crew Code');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_name` SET TAGS ('pii_business_glossary_term' = 'Crew Name');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_size` SET TAGS ('pii_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `crew_type` SET TAGS ('pii_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `delay_reason_code` SET TAGS ('pii_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_date` SET TAGS ('pii_business_glossary_term' = 'Deployment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_number` SET TAGS ('pii_business_glossary_term' = 'Deployment Number');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('pii_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `deployment_status` SET TAGS ('pii_value_regex' = 'planned|active|completed|cancelled|suspended');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `hse_toolbox_meeting_held` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Toolbox Meeting (TBM) Held Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_overtime` SET TAGS ('pii_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_subcontractor_crew` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Crew Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `is_weather_impacted` SET TAGS ('pii_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `lead_foreman_name` SET TAGS ('pii_business_glossary_term' = 'Lead Foreman Name');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `lead_foreman_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'mobilizing|on_site|demobilizing|demobilized');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `permit_to_work_number` SET TAGS ('pii_business_glossary_term' = 'Permit to Work Number');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `planned_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `planned_production_qty` SET TAGS ('pii_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `ppe_compliance` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `productivity_notes` SET TAGS ('pii_business_glossary_term' = 'Productivity Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `productivity_rate` SET TAGS ('pii_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_end_time` SET TAGS ('pii_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_start_time` SET TAGS ('pii_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|weekend');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `swms_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_subdomain' = 'construction_activity');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `concrete_pour_id` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `drawing_id` SET TAGS ('pii_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Pour Supervisor Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Pour Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `ambient_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `batch_plant_name` SET TAGS ('pii_business_glossary_term' = 'Batch Plant Name');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `concrete_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Concrete Temperature at Delivery (°C)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_method` SET TAGS ('pii_business_glossary_term' = 'Concrete Curing Method');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_method` SET TAGS ('pii_value_regex' = 'wet_hessian|curing_compound|ponding|steam|membrane|other');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `curing_start_time` SET TAGS ('pii_business_glossary_term' = 'Curing Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `cylinder_set_reference` SET TAGS ('pii_business_glossary_term' = 'Test Cylinder Set Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `delivery_docket_numbers` SET TAGS ('pii_business_glossary_term' = 'Delivery Docket Numbers');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `formwork_drawing_ref` SET TAGS ('pii_business_glossary_term' = 'Formwork Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `grid_reference` SET TAGS ('pii_business_glossary_term' = 'Grid Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `hcss_production_code` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Production Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `mix_design_code` SET TAGS ('pii_business_glossary_term' = 'Concrete Mix Design Code');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `mix_design_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `ncr_number` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `placement_method` SET TAGS ('pii_business_glossary_term' = 'Concrete Placement Method');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `placement_method` SET TAGS ('pii_value_regex' = 'pump|crane_bucket|conveyor|direct_chute|other');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_date` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Date');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_end_time` SET TAGS ('pii_business_glossary_term' = 'Pour End Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_number` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Number');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_number` SET TAGS ('pii_value_regex' = '^PC-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_start_time` SET TAGS ('pii_business_glossary_term' = 'Pour Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_status` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Status');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|on_hold|cancelled|rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `pour_type` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Type');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_hold_status` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Hold Status');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_hold_status` SET TAGS ('pii_value_regex' = 'no_hold|hold_applied|hold_released|rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `qc_inspector` SET TAGS ('pii_business_glossary_term' = 'Quality Control (QC) Inspector Name');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `relative_humidity_pct` SET TAGS ('pii_business_glossary_term' = 'Relative Humidity Percentage (%)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_compliant` SET TAGS ('pii_business_glossary_term' = 'Slump Test Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_specified_max_mm` SET TAGS ('pii_business_glossary_term' = 'Specified Maximum Slump (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_specified_min_mm` SET TAGS ('pii_business_glossary_term' = 'Specified Minimum Slump (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `slump_test_result_mm` SET TAGS ('pii_business_glossary_term' = 'Slump Test Result (mm)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `specified_strength_mpa` SET TAGS ('pii_business_glossary_term' = 'Specified Compressive Strength (MPa)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `structure_element` SET TAGS ('pii_business_glossary_term' = 'Structure Element');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `test_cylinders_cast` SET TAGS ('pii_business_glossary_term' = 'Test Cylinders Cast Count');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `truck_load_count` SET TAGS ('pii_business_glossary_term' = 'Concrete Truck Load Count');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `volume_poured_m3` SET TAGS ('pii_business_glossary_term' = 'Volume Poured (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition at Pour');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `weather_condition` SET TAGS ('pii_value_regex' = 'clear|cloudy|rain|high_wind|extreme_heat|extreme_cold');
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ALTER COLUMN `wind_speed_kmh` SET TAGS ('pii_business_glossary_term' = 'Wind Speed (km/h)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_subdomain' = 'construction_activity');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `earthwork_volume_id` SET TAGS ('pii_business_glossary_term' = 'Earthwork Volume ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Surveyor Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `boq_item_code` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities (BOQ) Item Code');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `change_order_reference` SET TAGS ('pii_business_glossary_term' = 'Change Order (CO) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `compaction_factor` SET TAGS ('pii_business_glossary_term' = 'Compaction Factor');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `contracted_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Contracted Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `coordinate_easting` SET TAGS ('pii_business_glossary_term' = 'Coordinate Easting');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `coordinate_northing` SET TAGS ('pii_business_glossary_term' = 'Coordinate Northing');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `cumulative_cut_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Cumulative Cut Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `cumulative_fill_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Cumulative Fill Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `cut_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Cut Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `disposal_distance_km` SET TAGS ('pii_business_glossary_term' = 'Disposal Haul Distance (km)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `disposal_site_reference` SET TAGS ('pii_business_glossary_term' = 'Disposal Site Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `engineer_approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Engineer Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `fill_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Fill Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `heavyjob_cost_code` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Cost Code');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `is_variation_order` SET TAGS ('pii_business_glossary_term' = 'Is Variation Order (CO) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `itp_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `material_classification` SET TAGS ('pii_business_glossary_term' = 'Material Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `material_classification` SET TAGS ('pii_value_regex' = 'topsoil|clay|rock|sand|gravel|mixed');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `measurement_accuracy_m` SET TAGS ('pii_business_glossary_term' = 'Measurement Accuracy (m)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `measurement_date` SET TAGS ('pii_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `measurement_reference_number` SET TAGS ('pii_business_glossary_term' = 'Measurement Reference Number');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `measurement_status` SET TAGS ('pii_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `measurement_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|certified');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `net_movement_m3` SET TAGS ('pii_business_glossary_term' = 'Net Movement Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `spoil_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Spoil Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `survey_instrument_code` SET TAGS ('pii_business_glossary_term' = 'Survey Instrument ID');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `survey_method` SET TAGS ('pii_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `survey_method` SET TAGS ('pii_value_regex' = 'GPS|drone_photogrammetry|total_station|LiDAR|manual_survey|cross_section');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `surveyor_license_number` SET TAGS ('pii_business_glossary_term' = 'Surveyor License Number');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `surveyor_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `surveyor_signoff_timestamp` SET TAGS ('pii_business_glossary_term' = 'Surveyor Sign-Off Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `swell_factor` SET TAGS ('pii_business_glossary_term' = 'Swell Factor');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `work_area_code` SET TAGS ('pii_business_glossary_term' = 'Work Area Code');
ALTER TABLE `vibe_construction_v1`.`site`.`earthwork_volume` ALTER COLUMN `work_area_description` SET TAGS ('pii_business_glossary_term' = 'Work Area Description');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_subdomain' = 'construction_activity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_progress_id` SET TAGS ('pii_business_glossary_term' = 'Field Progress ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `bid_pricing_line_id` SET TAGS ('pii_business_glossary_term' = 'Bill of Quantities (BOQ) Line Item ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Field Engineer Employee ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `itp_line_id` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Checkpoint ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `production_entry_id` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Production Record ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Activity Type / Discipline');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('pii_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `approver_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `bcwp` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `bim_element_reference` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Element ID');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('pii_business_glossary_term' = 'Budget at Completion (BAC)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `budget_at_completion` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `crew_size` SET TAGS ('pii_business_glossary_term' = 'Crew Size (Headcount)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `data_date` SET TAGS ('pii_business_glossary_term' = 'Data Date (Progress Cut-Off Date)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `equipment_hours` SET TAGS ('pii_business_glossary_term' = 'Equipment Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('pii_business_glossary_term' = 'Field Engineer Name');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `field_engineer_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `installed_quantity` SET TAGS ('pii_business_glossary_term' = 'Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Is Critical Path (CPM) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `is_milestone` SET TAGS ('pii_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_date` SET TAGS ('pii_business_glossary_term' = 'Field Measurement Date');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Field Measurement Method');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'visual_estimate|quantity_survey|milestone_completion|3d_scan_comparison|weighted_steps');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_notes` SET TAGS ('pii_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_number` SET TAGS ('pii_business_glossary_term' = 'Field Progress Measurement Number');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('pii_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `measurement_period_type` SET TAGS ('pii_value_regex' = 'daily|weekly|fortnightly|monthly');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `period_installed_quantity` SET TAGS ('pii_business_glossary_term' = 'Period Installed Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `planned_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `previous_percent_complete` SET TAGS ('pii_business_glossary_term' = 'Previous Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `progress_delta` SET TAGS ('pii_business_glossary_term' = 'Progress Delta (Incremental Percent Complete)');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `reported_percent_complete` SET TAGS ('pii_business_glossary_term' = 'Reported Percent Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition at Measurement');
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ALTER COLUMN `work_front` SET TAGS ('pii_business_glossary_term' = 'Work Front / Work Zone');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_subdomain' = 'site_setup');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Site Mobilization ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Site Manager ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Oracle Primavera P6 Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `procurement_framework_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Procurement Framework Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `access_road_established` SET TAGS ('pii_business_glossary_term' = 'Access Road Established');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `actual_demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Actual Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `actual_mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Actual Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `building_permit_number` SET TAGS ('pii_business_glossary_term' = 'Building Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `cost_actual` SET TAGS ('pii_business_glossary_term' = 'Mobilization Cost Actual');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `cost_actual` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `cost_budget` SET TAGS ('pii_business_glossary_term' = 'Mobilization Cost Budget');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `cost_budget` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `dlp_end_date` SET TAGS ('pii_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `environmental_permit_number` SET TAGS ('pii_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `environmental_permit_obtained` SET TAGS ('pii_business_glossary_term' = 'Environmental Permit Obtained');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `hse_plan_approval_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Approval Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `hse_plan_approved` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Approved');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `laydown_area_established` SET TAGS ('pii_business_glossary_term' = 'Laydown Area Established');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `leed_certification_target` SET TAGS ('pii_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Target');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `leed_certification_target` SET TAGS ('pii_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_value_regex' = '^MOB-[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|demobilized|cancelled|on_hold');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('pii_business_glossary_term' = 'Mobilization Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('pii_value_regex' = 'full_site|work_package|temporary_camp|equipment_only|partial');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Mobilization Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `ntp_date` SET TAGS ('pii_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `peak_workforce_actual` SET TAGS ('pii_business_glossary_term' = 'Peak Workforce Actual');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `peak_workforce_planned` SET TAGS ('pii_business_glossary_term' = 'Peak Workforce Planned');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `planned_demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Planned Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `planned_mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Planned Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `procore_project_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `schedule_variance_days` SET TAGS ('pii_business_glossary_term' = 'Mobilization Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('pii_business_glossary_term' = 'Site Address');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_area_sqm` SET TAGS ('pii_business_glossary_term' = 'Site Area (Square Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_closure_signoff_date` SET TAGS ('pii_business_glossary_term' = 'Site Closure Sign-Off Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_fencing_complete` SET TAGS ('pii_business_glossary_term' = 'Site Fencing Complete');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('pii_business_glossary_term' = 'Site Latitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('pii_business_glossary_term' = 'Site Longitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `site_office_established` SET TAGS ('pii_business_glossary_term' = 'Site Office Established');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `temporary_utilities_connected` SET TAGS ('pii_business_glossary_term' = 'Temporary Utilities Connected');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_mobilization` ALTER COLUMN `wbs_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9.-]{3,30}$');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_subdomain' = 'site_setup');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `logistics_plan_id` SET TAGS ('pii_business_glossary_term' = 'Site Logistics Plan ID');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `aconex_document_reference` SET TAGS ('pii_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Plan Approved Date');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `bim_model_ref` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `client_approval_required` SET TAGS ('pii_business_glossary_term' = 'Client Approval Required Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `client_approved_date` SET TAGS ('pii_business_glossary_term' = 'Client Approved Date');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `concrete_washout_area_included` SET TAGS ('pii_business_glossary_term' = 'Concrete Washout Area Included Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `construction_phase` SET TAGS ('pii_business_glossary_term' = 'Construction Phase');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `crane_lift_zone_count` SET TAGS ('pii_business_glossary_term' = 'Crane Lift Zone Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `delivery_time_window_end` SET TAGS ('pii_business_glossary_term' = 'Delivery Time Window End');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `delivery_time_window_end` SET TAGS ('pii_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `delivery_time_window_start` SET TAGS ('pii_business_glossary_term' = 'Delivery Time Window Start');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `delivery_time_window_start` SET TAGS ('pii_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `emergency_egress_route_count` SET TAGS ('pii_business_glossary_term' = 'Emergency Egress Route Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Plan Expiry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `first_aid_facility_count` SET TAGS ('pii_business_glossary_term' = 'First Aid Facility Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `fuel_storage_included` SET TAGS ('pii_business_glossary_term' = 'Fuel Storage Included Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hoarding_perimeter_m` SET TAGS ('pii_business_glossary_term' = 'Hoarding Perimeter Length (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `laydown_area_count` SET TAGS ('pii_business_glossary_term' = 'Laydown Area Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `material_staging_zones` SET TAGS ('pii_business_glossary_term' = 'Material Staging Zones Description');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `max_vehicle_speed_kmh` SET TAGS ('pii_business_glossary_term' = 'Maximum Vehicle Speed (km/h)');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `peak_workforce_headcount` SET TAGS ('pii_business_glossary_term' = 'Peak Workforce Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Site Logistics Plan Number');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_value_regex' = '^SLP-[A-Z0-9]{3,10}-[0-9]{3,6}$');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Site Logistics Plan Status');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|under_review|approved|superseded|void');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_title` SET TAGS ('pii_business_glossary_term' = 'Site Logistics Plan Title');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Site Logistics Plan Type');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'initial|phase_specific|emergency|temporary_works|revised');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `prepared_by` SET TAGS ('pii_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `procore_submittal_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Submittal ID');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `revision_description` SET TAGS ('pii_business_glossary_term' = 'Plan Revision Description');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Plan Revision Number');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `revision_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `site_area_sqm` SET TAGS ('pii_business_glossary_term' = 'Site Area (Square Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `site_gate_count` SET TAGS ('pii_business_glossary_term' = 'Site Gate Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `site_layout_drawing_ref` SET TAGS ('pii_business_glossary_term' = 'Site Layout Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `swms_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `temp_access_road_count` SET TAGS ('pii_business_glossary_term' = 'Temporary Access Road Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `temporary_works_included` SET TAGS ('pii_business_glossary_term' = 'Temporary Works Included Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `temporary_works_ref` SET TAGS ('pii_business_glossary_term' = 'Temporary Works Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `traffic_management_scheme` SET TAGS ('pii_business_glossary_term' = 'Traffic Management Scheme');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `traffic_management_scheme` SET TAGS ('pii_value_regex' = 'one_way|two_way|segregated|controlled_crossing|mixed');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `waste_management_zone_count` SET TAGS ('pii_business_glossary_term' = 'Waste Management Zone Count');
ALTER TABLE `vibe_construction_v1`.`site`.`logistics_plan` ALTER COLUMN `welfare_facility_count` SET TAGS ('pii_business_glossary_term' = 'Welfare Facility Count');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_subdomain' = 'construction_activity');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `equipment_deployment_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Deployment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hours_id` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Equipment Hours ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_description` SET TAGS ('pii_business_glossary_term' = 'Breakdown Description');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_flag` SET TAGS ('pii_business_glossary_term' = 'Breakdown Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `breakdown_hours` SET TAGS ('pii_business_glossary_term' = 'Breakdown Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_date` SET TAGS ('pii_business_glossary_term' = 'Deployment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_reference_number` SET TAGS ('pii_business_glossary_term' = 'Deployment Reference Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('pii_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `deployment_status` SET TAGS ('pii_value_regex' = 'active|idle|breakdown|demobilized|standby|transferred');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `equipment_type` SET TAGS ('pii_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('pii_business_glossary_term' = 'Fuel Consumption (Liters)');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('pii_business_glossary_term' = 'Fuel Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `fuel_type` SET TAGS ('pii_value_regex' = 'diesel|petrol|lpg|electric|hybrid');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hourly_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `hse_permit_number` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `idle_hours` SET TAGS ('pii_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `maintenance_order_number` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('pii_business_glossary_term' = 'Operator License Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_name` SET TAGS ('pii_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `operator_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'owned|rented|leased|subcontractor');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `planned_production_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `pre_start_check_flag` SET TAGS ('pii_business_glossary_term' = 'Pre-Start Check Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `production_quantity` SET TAGS ('pii_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `production_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `release_date` SET TAGS ('pii_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Deployment Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `rental_order_number` SET TAGS ('pii_business_glossary_term' = 'Rental Order Number');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_date` SET TAGS ('pii_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|double');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `site_location_description` SET TAGS ('pii_business_glossary_term' = 'Site Location Description');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `standby_hours` SET TAGS ('pii_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_subdomain' = 'permit_compliance');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_delivery_id` SET TAGS ('pii_business_glossary_term' = 'Material Delivery ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Receiver Employee ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_date` SET TAGS ('pii_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('pii_business_glossary_term' = 'Delivery Receipt Status');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_status` SET TAGS ('pii_value_regex' = 'accepted|rejected|partial|pending_inspection|on_hold');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delivery Arrival Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('pii_business_glossary_term' = 'Delivery Value');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `delivery_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `discrepancy_notes` SET TAGS ('pii_business_glossary_term' = 'Delivery Discrepancy Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `docket_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Docket Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('pii_business_glossary_term' = 'Delivery Driver Name');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `driver_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `expected_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `goods_receipt_number` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `hazardous_material` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `itp_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection and Test Plan (ITP) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `laydown_zone` SET TAGS ('pii_business_glossary_term' = 'Laydown Zone');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_code` SET TAGS ('pii_business_glossary_term' = 'Material Code');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `material_description` SET TAGS ('pii_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `msds_verified` SET TAGS ('pii_business_glossary_term' = 'Material Safety Data Sheet (MSDS) Verified Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `po_line_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `procore_log_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Daily Log Reference ID');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_accepted` SET TAGS ('pii_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_delivered` SET TAGS ('pii_business_glossary_term' = 'Quantity Delivered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_ordered` SET TAGS ('pii_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `quantity_rejected` SET TAGS ('pii_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('pii_business_glossary_term' = 'Material Receipt Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receipt_condition` SET TAGS ('pii_value_regex' = 'good|damaged|wet|contaminated|incorrect_spec|short_delivered');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receiving_inspector` SET TAGS ('pii_business_glossary_term' = 'Receiving Inspector Name');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `receiving_inspector` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `temperature_sensitive` SET TAGS ('pii_business_glossary_term' = 'Temperature-Sensitive Storage Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `test_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Material Test Certificate Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('pii_business_glossary_term' = 'Material Unit Rate');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `unit_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_business_glossary_term' = 'Delivery Vehicle Registration Number');
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_subdomain' = 'permit_compliance');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_id` SET TAGS ('pii_business_glossary_term' = 'Site Instruction ID');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `change_notice_id` SET TAGS ('pii_business_glossary_term' = 'Change Notice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `aconex_mail_reference` SET TAGS ('pii_business_glossary_term' = 'Aconex Mail Register Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `affected_drawing_reference` SET TAGS ('pii_business_glossary_term' = 'Affected Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `affected_wbs_code` SET TAGS ('pii_business_glossary_term' = 'Affected Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `contractor_acknowledgment_date` SET TAGS ('pii_business_glossary_term' = 'Contractor Acknowledgment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `contractor_dispute_flag` SET TAGS ('pii_business_glossary_term' = 'Contractor Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `contractor_response_date` SET TAGS ('pii_business_glossary_term' = 'Contractor Response Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `contractor_response_due_date` SET TAGS ('pii_business_glossary_term' = 'Contractor Response Due Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `cost_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_description` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Description');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `document_revision` SET TAGS ('pii_business_glossary_term' = 'Document Revision');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `document_revision` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `estimated_time_impact_days` SET TAGS ('pii_business_glossary_term' = 'Estimated Time Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `hse_implication_flag` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Implication Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `implementation_completion_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `implementation_start_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_number` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Number');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_number` SET TAGS ('pii_value_regex' = '^SI-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_status` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Status');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `instruction_type` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Type');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `issued_timestamp` SET TAGS ('pii_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `issuing_authority_role` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority Role');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `issuing_authority_role` SET TAGS ('pii_value_regex' = 'engineer|client_representative|resident_engineer|project_manager|site_supervisor|clerk_of_works');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `issuing_organisation` SET TAGS ('pii_business_glossary_term' = 'Issuing Organisation');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `linked_change_order_number` SET TAGS ('pii_business_glossary_term' = 'Linked Change Order (CO) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `linked_rfi_number` SET TAGS ('pii_business_glossary_term' = 'Linked Request for Information (RFI) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `ncr_reference` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `physical_location_description` SET TAGS ('pii_business_glossary_term' = 'Physical Location Description');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `procore_instruction_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Site Instruction ID');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `quality_hold_required` SET TAGS ('pii_business_glossary_term' = 'Quality Hold Required Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `specification_clause_reference` SET TAGS ('pii_business_glossary_term' = 'Specification Clause Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `superseded_by_instruction_number` SET TAGS ('pii_business_glossary_term' = 'Superseded By Instruction Number');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `time_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Time Impact Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Site Instruction Title');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `urgency_classification` SET TAGS ('pii_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`instruction` ALTER COLUMN `urgency_classification` SET TAGS ('pii_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_subdomain' = 'site_setup');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_plan_id` SET TAGS ('pii_business_glossary_term' = 'Lift Plan ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Crane Equipment ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Crane Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Appointed Person Worker ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `swms_id` SET TAGS ('pii_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `tertiary_lift_rigger_in_charge_employee_id` SET TAGS ('pii_business_glossary_term' = 'Rigger-in-Charge Worker ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `tertiary_lift_rigger_in_charge_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `tertiary_lift_rigger_in_charge_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `appointed_person_name` SET TAGS ('pii_business_glossary_term' = 'Appointed Person Name');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `appointed_person_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Lift Plan Approval Status');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|cancelled|superseded');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Lift Plan Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `boom_length_m` SET TAGS ('pii_business_glossary_term' = 'Boom Length (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `capacity_utilisation_pct` SET TAGS ('pii_business_glossary_term' = 'Crane Capacity Utilisation Percentage');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `crane_make` SET TAGS ('pii_business_glossary_term' = 'Crane Make');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `crane_model` SET TAGS ('pii_business_glossary_term' = 'Crane Model');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `crane_rated_capacity_t` SET TAGS ('pii_business_glossary_term' = 'Crane Rated Capacity (Tonnes)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `crane_type` SET TAGS ('pii_business_glossary_term' = 'Crane Type');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `exclusion_zone_radius_m` SET TAGS ('pii_business_glossary_term' = 'Exclusion Zone Radius (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `ground_bearing_capacity_kpa` SET TAGS ('pii_business_glossary_term' = 'Ground Bearing Capacity (kPa)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `ground_bearing_pressure_kpa` SET TAGS ('pii_business_glossary_term' = 'Ground Bearing Pressure (kPa)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hook_height_m` SET TAGS ('pii_business_glossary_term' = 'Hook Height (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|extreme');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_date` SET TAGS ('pii_business_glossary_term' = 'Lift Date');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_description` SET TAGS ('pii_business_glossary_term' = 'Lift Description');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_drawing_reference` SET TAGS ('pii_business_glossary_term' = 'Lift Drawing Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_end_time` SET TAGS ('pii_business_glossary_term' = 'Lift End Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_radius_m` SET TAGS ('pii_business_glossary_term' = 'Lift Radius (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_start_time` SET TAGS ('pii_business_glossary_term' = 'Lift Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_type` SET TAGS ('pii_business_glossary_term' = 'Lift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `lift_type` SET TAGS ('pii_value_regex' = 'routine|critical|complex|tandem|blind');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `load_weight_t` SET TAGS ('pii_business_glossary_term' = 'Load Weight (Tonnes)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `method_statement_reference` SET TAGS ('pii_business_glossary_term' = 'Safe Work Method Statement (SWMS) Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `outrigger_mat_required` SET TAGS ('pii_business_glossary_term' = 'Outrigger Mat Required Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `overhead_obstruction_present` SET TAGS ('pii_business_glossary_term' = 'Overhead Obstruction Present Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `permit_to_lift_number` SET TAGS ('pii_business_glossary_term' = 'Permit-to-Lift (PTL) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `pick_point_description` SET TAGS ('pii_business_glossary_term' = 'Pick Point Description');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Lift Plan Number');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_value_regex' = '^LP-[A-Z0-9]{2,10}-[0-9]{4,6}$');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `power_line_clearance_m` SET TAGS ('pii_business_glossary_term' = 'Power Line Clearance (Metres)');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `procore_lift_plan_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Lift Plan Reference ID');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `rigging_configuration` SET TAGS ('pii_business_glossary_term' = 'Rigging Configuration');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `set_point_description` SET TAGS ('pii_business_glossary_term' = 'Set Point Description');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `sling_type` SET TAGS ('pii_business_glossary_term' = 'Sling Type');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `sling_type` SET TAGS ('pii_value_regex' = 'wire_rope|chain|synthetic_web|synthetic_round|shackle_only|spreader_bar');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`lift_plan` ALTER COLUMN `wind_speed_limit_kmh` SET TAGS ('pii_business_glossary_term' = 'Maximum Wind Speed Limit (km/h)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_subdomain' = 'site_setup');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_report_id` SET TAGS ('pii_business_glossary_term' = 'Shift Report ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `daily_log_id` SET TAGS ('pii_business_glossary_term' = 'Daily Log ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Shift Supervisor ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `activities_narrative` SET TAGS ('pii_business_glossary_term' = 'Shift Activities Narrative');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `concrete_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Concrete Pour Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `delay_cause` SET TAGS ('pii_business_glossary_term' = 'Delay Cause Category');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `delay_duration_hrs` SET TAGS ('pii_business_glossary_term' = 'Delay Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `direct_labour_count` SET TAGS ('pii_business_glossary_term' = 'Direct Labour Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `earthworks_volume_m3` SET TAGS ('pii_business_glossary_term' = 'Earthworks Volume (m³)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `equipment_count` SET TAGS ('pii_business_glossary_term' = 'Equipment Count');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `equipment_utilisation_pct` SET TAGS ('pii_business_glossary_term' = 'Equipment Utilisation Percentage');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `handover_notes` SET TAGS ('pii_business_glossary_term' = 'Shift Handover Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `hcss_shift_reference` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Shift Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `incident_count` SET TAGS ('pii_business_glossary_term' = 'Incident Count');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `issues_count` SET TAGS ('pii_business_glossary_term' = 'Open Issues Count');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `lti_flag` SET TAGS ('pii_business_glossary_term' = 'Lost Time Injury (LTI) Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `ncr_raised_flag` SET TAGS ('pii_business_glossary_term' = 'Non-Conformance Report (NCR) Raised Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `permit_to_work_number` SET TAGS ('pii_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `planned_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Planned Shift End Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `planned_production_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `planned_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Planned Shift Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `procore_log_reference` SET TAGS ('pii_business_glossary_term' = 'Procore Log Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `production_quantity` SET TAGS ('pii_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `production_unit` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Shift Report Number');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('pii_value_regex' = '^SR-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `report_status` SET TAGS ('pii_business_glossary_term' = 'Shift Report Status');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `report_status` SET TAGS ('pii_value_regex' = 'draft|submitted|reviewed|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `safety_observation_count` SET TAGS ('pii_business_glossary_term' = 'Safety Observation Count');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_date` SET TAGS ('pii_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|extended');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `subcontractor_count` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `supervisor_sign_off_timestamp` SET TAGS ('pii_business_glossary_term' = 'Supervisor Sign-Off Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `tbm_conducted_flag` SET TAGS ('pii_business_glossary_term' = 'Toolbox Meeting (TBM) Conducted Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `temperature_c` SET TAGS ('pii_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `total_headcount` SET TAGS ('pii_business_glossary_term' = 'Total Shift Headcount');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `total_labour_hours` SET TAGS ('pii_business_glossary_term' = 'Total Labour Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`site`.`shift_report` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_subdomain' = 'permit_compliance');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_master' = 'compliance.compliance_permit');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_scope' = 'site');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_counterpart' = 'compliance.compliance_permit');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `site_permit_id` SET TAGS ('pii_business_glossary_term' = 'Site Permit ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_ssot' = 'compliance.compliance_permit');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `renewed_site_permit_id` SET TAGS ('pii_business_glossary_term' = 'Renewed Site Permit Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `renewed_site_permit_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `submission_id` SET TAGS ('pii_business_glossary_term' = 'Bid Submission Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `tertiary_site_close_out_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Close‑out By ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `tertiary_site_close_out_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `tertiary_site_close_out_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `application_date` SET TAGS ('pii_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `attached_document_reference` SET TAGS ('pii_business_glossary_term' = 'Attached Document Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `close_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Close‑out Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `compliance_reference` SET TAGS ('pii_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `conditions` SET TAGS ('pii_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `expiration_notice_sent` SET TAGS ('pii_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `extension_approved_date` SET TAGS ('pii_business_glossary_term' = 'Extension Approved Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `extension_requested` SET TAGS ('pii_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `fee_currency` SET TAGS ('pii_business_glossary_term' = 'Fee Currency');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `is_environmental` SET TAGS ('pii_business_glossary_term' = 'Environmental Permit Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `is_safety_critical` SET TAGS ('pii_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `issuing_authority` SET TAGS ('pii_value_regex' = 'OSHA|local_building_department|environmental_agency|other');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_category` SET TAGS ('pii_business_glossary_term' = 'Permit Category');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_category` SET TAGS ('pii_value_regex' = 'safety|environment|operational');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_type` SET TAGS ('pii_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `permit_type` SET TAGS ('pii_value_regex' = 'hot_work|excavation|confined_space|crane_operation|road_closure|environmental_discharge');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `restrictions` SET TAGS ('pii_business_glossary_term' = 'Permit Restrictions');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `revision_number` SET TAGS ('pii_business_glossary_term' = 'Permit Revision Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Permit Scope Description');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `site_permit_status` SET TAGS ('pii_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `site_permit_status` SET TAGS ('pii_value_regex' = 'applied|active|suspended|closed|revoked');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_permit` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Permit Version');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_subdomain' = 'permit_compliance');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_association_edges' = 'site.work_front,workforce.craft_worker');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `work_front_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Work Front Assignment Id');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Craft Worker Id');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Work Front Id');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `actual_finish` SET TAGS ('pii_business_glossary_term' = 'Actual Finish');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `actual_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `actual_start` SET TAGS ('pii_business_glossary_term' = 'Actual Start');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `allocated_hours` SET TAGS ('pii_business_glossary_term' = 'Allocated Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `assigned_quantity` SET TAGS ('pii_business_glossary_term' = 'Assigned Quantity');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `completion_pct` SET TAGS ('pii_business_glossary_term' = 'Completion Pct');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `planned_finish` SET TAGS ('pii_business_glossary_term' = 'Planned Finish');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `planned_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `planned_start` SET TAGS ('pii_business_glossary_term' = 'Planned Start');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `progress_percent` SET TAGS ('pii_business_glossary_term' = 'Progress Percent');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `role` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment - Role');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `shift` SET TAGS ('pii_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `supervisor_name` SET TAGS ('pii_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `uom` SET TAGS ('pii_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`work_front_assignment` ALTER COLUMN `work_front_assignment_status` SET TAGS ('pii_business_glossary_term' = 'Work Front Assignment Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_subdomain' = 'location_reference');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`site` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site Identifier');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `current_location_site_id` SET TAGS ('pii_business_glossary_term' = 'Current Location Site Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `current_location_site_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_manager_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager Employee Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_manager_employee_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `area_sqft` SET TAGS ('pii_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_category` SET TAGS ('pii_business_glossary_term' = 'Site Category');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `crew_capacity` SET TAGS ('pii_business_glossary_term' = 'Crew Capacity');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `environmental_permit_number` SET TAGS ('pii_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `gps_accuracy_m` SET TAGS ('pii_business_glossary_term' = 'Gps Accuracy M');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `is_mobilized` SET TAGS ('pii_business_glossary_term' = 'Is Mobilized');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `owner` SET TAGS ('pii_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `permit_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `region` SET TAGS ('pii_business_glossary_term' = 'Region');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `safety_incident_count` SET TAGS ('pii_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `site_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_subdomain' = 'location_reference');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_preserved' = 'required-structure');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_location_id` SET TAGS ('pii_business_glossary_term' = 'Site Location Identifier');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `parent_site_location_id` SET TAGS ('pii_business_glossary_term' = 'Parent Site Location Id');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `parent_site_location_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `area_sqft` SET TAGS ('pii_business_glossary_term' = 'Area Sqft');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `construction_end_date` SET TAGS ('pii_business_glossary_term' = 'Construction End Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `construction_start_date` SET TAGS ('pii_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `country_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `environmental_zone` SET TAGS ('pii_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `gps_accuracy_m` SET TAGS ('pii_business_glossary_term' = 'Gps Accuracy M');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `has_security_system` SET TAGS ('pii_business_glossary_term' = 'Has Security System');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `is_remote` SET TAGS ('pii_business_glossary_term' = 'Is Remote');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_location_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `number_of_floors` SET TAGS ('pii_business_glossary_term' = 'Number Of Floors');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `power_capacity_kw` SET TAGS ('pii_business_glossary_term' = 'Power Capacity Kw');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `security_system_type` SET TAGS ('pii_business_glossary_term' = 'Security System Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_category` SET TAGS ('pii_business_glossary_term' = 'Site Category');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_classification` SET TAGS ('pii_business_glossary_term' = 'Site Classification');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_description` SET TAGS ('pii_business_glossary_term' = 'Site Description');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_location_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_owner` SET TAGS ('pii_business_glossary_term' = 'Site Owner');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `site_type` SET TAGS ('pii_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `state_province` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `timezone` SET TAGS ('pii_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `utility_provider` SET TAGS ('pii_business_glossary_term' = 'Utility Provider');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `waste_management_plan` SET TAGS ('pii_business_glossary_term' = 'Waste Management Plan');
ALTER TABLE `vibe_construction_v1`.`site`.`site_location` ALTER COLUMN `water_supply_type` SET TAGS ('pii_business_glossary_term' = 'Water Supply Type');
