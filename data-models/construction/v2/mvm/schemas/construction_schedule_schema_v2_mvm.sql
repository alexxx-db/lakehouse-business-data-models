-- Schema for Domain: schedule | Business: Construction | Version: v2_mvm
-- Generated on: 2026-07-10 14:35:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`schedule` COMMENT 'Project scheduling domain managing CPM (Critical Path Method) networks, activity sequencing, resource leveling, critical path analysis, progress tracking, baseline comparisons, look-ahead plans, and schedule performance metrics (SPI). Integrates with Oracle Primavera P6 for schedule exports and EVM (Earned Value Management) for project control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`activity` (
    `activity_id` BIGINT COMMENT 'Unique system-generated identifier for the schedule activity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Interface Coordination Schedule uses interface_point_id to align multidisciplinary handover dates with activity sequencing.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: 4D BIM scheduling directly links schedule activities to BIM model elements for construction simulation, clash detection scheduling, and progress visualization. This link is a mandatory requirement in ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Each activity has a designated foreman/supervisor responsible for safety and execution; needed for safety incident reporting and activity oversight.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Construction activities are executed against specific IFC drawings. Schedulers and field engineers must confirm the correct drawing revision is active before work starts. This activity-to-drawing link',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: Earned Value Management (EVM) requires linking schedule activities to the estimate that budgeted them. Cost engineers reconcile planned cost (estimate) against schedule progress at activity level. A c',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost coding of schedule activities for budgeting and earned value reporting requires linking each activity to a finance cost_code entity.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Activities requiring hazardous work must reference the associated Permit‑to‑Work to manage authorization and control measures.',
    `review_id` BIGINT COMMENT 'Foreign key linking to design.review. Business justification: Design review milestones (30%, 60%, IFC reviews) are scheduled activities in construction programs. Linking the schedule activity to the design review record enables tracking of review completion agai',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Each scheduled activity must reference its governing risk assessment before work commences — required by WHS Act, CDM Regulations, and standard construction HSE management systems. Schedulers and HSE ',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: During planning, each activity is linked to its approved Safe Work Method Statement to ensure compliance with safety procedures.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Each scheduled activity is governed by a technical specification section (e.g., concrete pour activity references spec for concrete mix). QA/QC and schedule teams verify the correct spec version is cu',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: Toolbox meetings are conducted immediately before high-risk activities commence. Linking activity to its pre-commencement TBM supports HSE compliance reporting (was a TBM held before this activity st',
    `activity_status` STRING COMMENT 'Current lifecycle status of the activity.. Valid values are `not_started|in_progress|completed|suspended|cancelled`',
    `activity_type` STRING COMMENT 'Classification of the activity based on its nature (task‑dependent, resource‑dependent, level of effort, or milestone).. Valid values are `task_dependent|resource_dependent|level_of_effort|milestone`',
    `actual_finish_date` DATE COMMENT 'Date the activity actually finished.',
    `actual_start_date` DATE COMMENT 'Date the activity actually started.',
    `activity_code` STRING COMMENT 'Business identifier code assigned to the activity (e.g., unique activity number).',
    `constraint_date` DATE COMMENT 'Date associated with the scheduling constraint, if applicable.',
    `constraint_type` STRING COMMENT 'Scheduling constraint applied to the activity.. Valid values are `asap|start_no_earlier_than|finish_no_later_than|mandatory|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity record was first created.',
    `critical_path_flag` BOOLEAN COMMENT 'True if the activity lies on the critical path.',
    `activity_description` STRING COMMENT 'Detailed textual description of the work to be performed.',
    `free_float_days` STRING COMMENT 'Free float available for the activity in days.',
    `lookahead_finish_date` DATE COMMENT 'Finish date used in the look‑ahead planning window.',
    `lookahead_start_date` DATE COMMENT 'Start date used in the look‑ahead planning window.',
    `activity_name` STRING COMMENT 'Human‑readable name or title of the activity.',
    `original_duration_days` STRING COMMENT 'Planned duration of the activity in calendar days at creation.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percent complete of the activity (0‑100).',
    `planned_finish_date` DATE COMMENT 'Scheduled finish date as originally planned.',
    `planned_start_date` DATE COMMENT 'Scheduled start date as originally planned.',
    `remaining_duration_days` STRING COMMENT 'Remaining duration in days based on current progress.',
    `total_float_days` STRING COMMENT 'Total float available for the activity in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the activity record.',
    CONSTRAINT pk_activity PRIMARY KEY(`activity_id`)
) COMMENT 'Core CPM (Critical Path Method) schedule activity representing a discrete unit of work within a project WBS. Captures activity ID, name, WBS code, activity type (task-dependent, resource-dependent, level of effort, milestone), planned/actual start and finish dates, original duration, remaining duration, percent complete, calendar assignment, constraint types (start-no-earlier-than, finish-no-later-than, mandatory), float values (total float, free float), critical path flag, activity status (not started, in progress, completed, suspended), and activity code assignments for filtering and grouping. The foundational scheduling entity from which all schedule analysis, critical path calculation, and progress measurement derives.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` (
    `activity_relationship_id` BIGINT COMMENT 'System-generated unique identifier for the activity relationship record.',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - activity relationships (FS/FF/SS/SF) are project-specific schedule logic',
    `activity_id` BIGINT COMMENT 'Identifier of the predecessor activity in the CPM network.',
    `activity_relationship_status` STRING COMMENT 'Current lifecycle status of the relationship record.. Valid values are `active|inactive|deleted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the relationship record was first created in the system.',
    `activity_relationship_description` STRING COMMENT 'Free-text notes or comments describing the purpose or special conditions of the relationship.',
    `effective_from` DATE COMMENT 'Date when the relationship becomes effective in the schedule.',
    `effective_until` DATE COMMENT 'Date when the relationship expires or is no longer valid (nullable).',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether this relationship lies on the projects critical path (true) or not (false).',
    `is_driving` BOOLEAN COMMENT 'Flag indicating whether this relationship drives the schedule logic (true) or is a passive link (false).',
    `lag_duration` DECIMAL(18,2) COMMENT 'Numeric amount of lag (or lead if negative) applied to the relationship, expressed in the units defined by lag_time_unit.',
    `lag_time_unit` STRING COMMENT 'Unit of measure for lag_duration (e.g., days, hours, minutes).. Valid values are `days|hours|minutes`',
    `relationship_source` STRING COMMENT 'Origin of the relationship record: exported from scheduling tool or entered manually.. Valid values are `system_export|manual_entry`',
    `relationship_type` STRING COMMENT 'Logical dependency type defining how the predecessor and successor activities are linked.. Valid values are `FS|SS|FF|SF`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the relationship record.',
    CONSTRAINT pk_activity_relationship PRIMARY KEY(`activity_relationship_id`)
) COMMENT 'Logical dependency links between schedule activities defining the CPM network logic. Captures predecessor and successor activity references, relationship type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish), lag/lead duration, lag time unit, driving relationship flag, and relationship source (scheduling tool export, manual entry). Enables critical path calculation, schedule network analysis, and what-if scenario modeling for delay impact assessment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` (
    `schedule_baseline_id` BIGINT COMMENT 'System-generated unique identifier for the schedule baseline record.',
    `approval_date` DATE COMMENT 'Date on which the baseline was formally approved for use.',
    `baseline_type` STRING COMMENT 'Classification of the baseline indicating its purpose: original contract baseline, current working baseline, or supplemental revision.. Valid values are `original|current|supplemental`',
    `bcws_amount` DECIMAL(18,2) COMMENT 'Monetary value of work scheduled in the baseline, used for Earned Value calculations.',
    `change_reason` STRING COMMENT 'Reason or justification for creating a supplemental or revised baseline.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the baseline record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the baseline.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_date` DATE COMMENT 'The date representing the snapshot of schedule data used to create the baseline.',
    `schedule_baseline_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or notable characteristics of the baseline.',
    `finish_date` DATE COMMENT 'Planned finish date of the schedule baseline.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this baseline is the active baseline for schedule comparisons.',
    `schedule_baseline_name` STRING COMMENT 'Human‑readable name given to the schedule baseline (e.g., "Original Contract Baseline").',
    `revision_date` DATE COMMENT 'Date on which the baseline was last revised or re‑baselined.',
    `schedule_baseline_status` STRING COMMENT 'Current lifecycle state of the baseline record.. Valid values are `draft|approved|rejected|archived`',
    `schedule_tool_project_ref` STRING COMMENT 'External identifier of the project within the scheduling tool (e.g., Primavera project code).',
    `start_date` DATE COMMENT 'Planned start date of the schedule baseline.',
    `total_duration_days` STRING COMMENT 'Calculated total duration of the baseline in calendar days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the baseline record.',
    `version_number` STRING COMMENT 'Sequential version number indicating the order of baseline revisions.',
    CONSTRAINT pk_schedule_baseline PRIMARY KEY(`schedule_baseline_id`)
) COMMENT 'Approved project schedule baseline snapshot capturing the time-phased plan against which actual progress is measured. Stores baseline name, baseline type (original, current, supplemental), approval date, approved-by reference, baseline start and finish dates, total baseline duration, baseline data date, and scheduling tool baseline project reference. Supports EVM (Earned Value Management) calculations including BCWS (Budgeted Cost of Work Scheduled) and variance analysis. Multiple baselines per project are supported (original contract baseline, re-baselined approved revisions).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` (
    `baseline_activity_id` BIGINT COMMENT 'Unique surrogate key for the baseline activity record.',
    `activity_id` BIGINT COMMENT 'Reference to the master activity definition (work breakdown element).',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - baseline activities are project-specific schedule snapshots',
    `estimate_id` BIGINT COMMENT 'Foreign key linking to bid.estimate. Business justification: Baseline activities represent the cost-loaded schedule baseline. Tracing each baseline activity to the estimate version that informed it is essential for bid-vs-actual variance analysis and change ord',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Baseline activities carry baseline_cost values that must reconcile to project budget line items. Linking baseline_activity to project_budget enables budget-vs-baseline cost variance reporting at activ',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: baseline_activity is a frozen snapshot of an activitys planned dates and resources at a specific baseline. It currently references project.project_baseline (the project-domain baseline) but has NO FK',
    `baseline_activity_status` STRING COMMENT 'Current lifecycle status of the activity within the baseline.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `baseline_constraint_date` DATE COMMENT 'Date associated with the constraint type, if applicable.',
    `baseline_constraint_type` STRING COMMENT 'Scheduling constraint applied to the activity in the baseline.. Valid values are `as_soon_as_possible|start_on|finish_on|must_start_on|must_finish_on|none`',
    `baseline_cost` DECIMAL(18,2) COMMENT 'Planned cost for the activity as captured in the approved baseline.',
    `baseline_cost_variance` DECIMAL(18,2) COMMENT 'Difference between actual cost incurred and baseline cost estimate.',
    `baseline_early_finish` DATE COMMENT 'Earliest possible finish date for the activity in the approved baseline.',
    `baseline_early_start` DATE COMMENT 'Earliest possible start date for the activity in the approved baseline.',
    `baseline_is_critical` BOOLEAN COMMENT 'True if the activity lies on the critical path of the baseline schedule.',
    `baseline_late_finish` DATE COMMENT 'Latest permissible finish date for the activity in the approved baseline.',
    `baseline_late_start` DATE COMMENT 'Latest permissible start date for the activity in the approved baseline.',
    `baseline_milestone_flag` BOOLEAN COMMENT 'Indicates whether the activity is defined as a milestone in the baseline.',
    `baseline_original_duration` STRING COMMENT 'Planned duration of the activity at baseline approval, expressed in whole days.',
    `baseline_percent_complete` DECIMAL(18,2) COMMENT 'Planned percentage of work completed for the activity at the baseline snapshot.',
    `baseline_remaining_duration` STRING COMMENT 'Remaining planned duration as of the latest progress update, based on the baseline.',
    `baseline_resource_type` STRING COMMENT 'Category of resources assigned to the activity in the baseline.. Valid values are `labor|equipment|material|subcontractor`',
    `baseline_resource_units` DECIMAL(18,2) COMMENT 'Total resource units (e.g., labor hours, equipment hours) planned for the activity in the baseline.',
    `baseline_schedule_variance` STRING COMMENT 'Difference between actual start/finish and baseline dates, expressed in days.',
    `baseline_total_float` STRING COMMENT 'Amount of scheduling flexibility (float) for the activity in the baseline, expressed in days.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the baseline activity record was created in the data lake.',
    `line_sequence` STRING COMMENT 'Sequential order of the activity within the baseline schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the baseline activity record.',
    CONSTRAINT pk_baseline_activity PRIMARY KEY(`baseline_activity_id`)
) COMMENT 'Baseline-frozen snapshot of each activitys planned dates, durations, and resource assignments at the time a schedule baseline was approved. Stores baseline early start, baseline early finish, baseline late start, baseline late finish, baseline original duration, baseline remaining duration, baseline percent complete, and baseline total float for each activity within a specific baseline. Enables schedule variance analysis (SV = BCWP - BCWS) and start/finish variance reporting against the approved plan.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`resource` (
    `resource_id` BIGINT COMMENT 'Primary key for resource',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Resource Costing & Compliance: tying resource equipment_category to the master asset_category allows accurate cost rates, depreciation tracking, and regulatory reporting on equipment usage.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Schedule resources often represent individual workers; linking enables labor allocation reports and compliance with union and safety regulations.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Schedule resources of type material must reference the procurement material catalog for accurate unit pricing, lead times, and specification compliance. Construction schedulers use catalog data to v',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: RESOURCE PLANNING: External subcontractor/vendor provides the resource; procurement contracts vendor, schedule assigns resource to activities. Linking enables traceability of vendor‑supplied labor/equ',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Planned availability of the resource expressed as a percent of total time.',
    `billing_rate_per_hour` DECIMAL(18,2) COMMENT 'Rate used for billing external parties for labor resources.',
    `calendar_name` STRING COMMENT 'Name of the work calendar associated with the resource (defines working days/hours).',
    `certification_requirements` STRING COMMENT 'Required certifications or trainings for the resource (e.g., OSHA, LEED).',
    `resource_code` STRING COMMENT 'External identifier or catalogue number for the resource.',
    `compliance_requirements` STRING COMMENT 'Regulatory or safety compliance items applicable to the resource (e.g., OSHA training).',
    `cost_account_code` STRING COMMENT 'Accounting code used to charge resource costs.',
    `cost_center` STRING COMMENT 'Organizational cost centre responsible for the resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the resource record was first created in the system.',
    `default_units_per_time` DECIMAL(18,2) COMMENT 'Default allocation quantity when the resource is assigned without explicit units.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the resource over its useful life.. Valid values are `straight_line|declining_balance`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `resource_description` STRING COMMENT 'Free‑form description providing additional context about the resource.',
    `effective_end_date` DATE COMMENT 'Date when the resource is no longer available (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the resource becomes available for scheduling.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Score reflecting the resources environmental impact (e.g., emissions, waste).',
    `is_external` BOOLEAN COMMENT 'True if the resource is provided by an external subcontractor or supplier.',
    `is_overtime_allowed` BOOLEAN COMMENT 'Indicates whether overtime work is permitted for this resource.',
    `labor_category` STRING COMMENT 'Category of labor (e.g., skilled, unskilled, supervisory).',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the resource was last assigned to an activity.',
    `lead_time_days` STRING COMMENT 'Number of days required to procure or mobilize the resource.',
    `material_category` STRING COMMENT 'Classification of material (e.g., concrete, steel, piping).',
    `max_concurrent_assignments` STRING COMMENT 'Maximum number of activities the resource can be assigned to simultaneously.',
    `max_units_per_period` DECIMAL(18,2) COMMENT 'Maximum quantity of the resource that can be allocated in a scheduling period.',
    `resource_name` STRING COMMENT 'Human‑readable name of the resource as used in schedules.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the resource.',
    `overtime_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the price when the resource works overtime.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Cost charged for one unit of the resource, used for cost‑loaded schedules.',
    `procurement_source` STRING COMMENT 'Indicates whether the resource is sourced internally or from an external vendor.. Valid values are `internal|external`',
    `resource_role` STRING COMMENT 'Functional role of the resource in the project (e.g., carpenter, electrician).',
    `resource_status` STRING COMMENT 'Current lifecycle status of the resource.. Valid values are `active|inactive|retired|planned`',
    `resource_type` STRING COMMENT 'Classification of the resource (e.g., labor, material, equipment, subcontractor).. Valid values are `labor|material|equipment|subcontractor`',
    `safety_rating` STRING COMMENT 'Safety classification of the resource based on internal assessments.. Valid values are `A|B|C|D|E`',
    `site_location` STRING COMMENT 'Identifier of the construction site or location where the resource is primarily used.',
    `skill_set` STRING COMMENT 'Comma‑separated list of skills or competencies associated with the resource.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the resource (e.g., hour, day, kilogram).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the resource record.',
    `utilization_rate` DECIMAL(18,2) COMMENT 'Historical or planned utilization of the resource expressed as a percent.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Resource definitions assigned to schedule activities for resource-loaded scheduling and leveling. Captures resource name, resource type (labor, non-labor, material), unit of measure, max units per time period, default units per time, price per unit, resource calendar, overtime factor, and resource role. Sourced from the enterprise scheduling tool resource dictionary. Supports resource leveling, resource histograms, and cost-loaded schedule generation. Distinct from workforce employee records — this is the scheduling resource abstraction used for capacity planning and EVM cost loading.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` (
    `activity_resource_assignment_id` BIGINT COMMENT 'System-generated unique identifier for the resource assignment to an activity.',
    `activity_id` BIGINT COMMENT 'Identifier of the project activity to which the resource is assigned.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Equipment Assignment Planning: linking each activity resource assignment to a specific asset enables the Equipment Allocation Report and ensures compliance with the daily equipment utilization schedul',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Resource assignments drive cost account charges in construction cost control. activity_resource_assignment has denormalized cost_account_code (plain text). Linking to cost_account enables earned value',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource assignments are charged to cost centers; linking enables accurate cost allocation and financial reporting per cost center.',
    `estimate_line_id` BIGINT COMMENT 'Foreign key linking to bid.estimate_line. Business justification: Resource assignments in the cost-loaded schedule correspond directly to estimate line items. This link enables actual vs. budgeted cost tracking at line-item level — the core of construction cost cont',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posting resource assignment costs to GL accounts requires linking assignments to finance.gl_account for proper ledger entries.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: Resource Assignment Report requires linking each assignment to the responsible contract party (subcontractor) for cost and compliance tracking.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (labor, equipment, material, etc.) assigned to the activity.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Before mobilising a resource to a high-risk activity, the assignment record must reference the applicable risk assessment confirming controls are in place. HSE and planning teams use this link for pre',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Tracks which subcontract provides the assigned resources, enabling accurate cost allocation and subcontractor performance analysis.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Cost incurred to date for the resource consumption.',
    `actual_finish_date` DATE COMMENT 'Date when the resource actually completed work on the activity.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Resource units actually consumed to date.',
    `actual_start_date` DATE COMMENT 'Date when the resource actually began work on the activity.',
    `approval_status` STRING COMMENT 'Current approval state of the assignment.. Valid values are `pending|approved|rejected`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the resource assignment.. Valid values are `planned|active|completed|closed|cancelled|on_hold`',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this assignment.',
    `compliance_status` STRING COMMENT 'Indicates whether the assignment meets regulatory or contract compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `cost_rate` DECIMAL(18,2) COMMENT 'Standard cost per unit of the resource (e.g., $ per hour).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created.',
    `distribution_curve` STRING COMMENT 'Shape of the resource loading over time for the assignment.. Valid values are `front_loaded|back_loaded|bell|linear|custom|none`',
    `finish_date` DATE COMMENT 'Scheduled finish date for the resource on the activity.',
    `is_critical_path` BOOLEAN COMMENT 'True if the assignment lies on the project’s critical path.',
    `labor_category` STRING COMMENT 'Classification of labor skill level for the assigned resource.. Valid values are `skilled|unskilled|supervisor|foreman|other`',
    `line_sequence` STRING COMMENT 'Sequential order of the assignment within the activity.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the assignment.',
    `overtime_quantity` DECIMAL(18,2) COMMENT 'Additional resource units worked as overtime.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Cost per overtime unit of the resource.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost associated with the planned quantity of the resource.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Budgeted amount of resource units (e.g., hours, cubic meters) planned for the assignment.',
    `remaining_cost` DECIMAL(18,2) COMMENT 'Budgeted cost minus actual cost, representing cost remaining.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Planned units minus actual units, representing work left.',
    `resource_location` STRING COMMENT 'Site or location where the resource is deployed for the activity.',
    `resource_role` STRING COMMENT 'Specific role the resource performs on the activity.. Valid values are `foreman|operator|installer|inspector|supervisor|other`',
    `resource_type` STRING COMMENT 'Category of the assigned resource (e.g., labor, equipment).. Valid values are `labor|equipment|material|subcontractor|tool|other`',
    `safety_risk_level` STRING COMMENT 'Risk classification for safety associated with the assignment.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Scheduled start date for the resource on the activity.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., hours, cubic meters).. Valid values are `hours|days|m3|kg|units|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `wbs_code` STRING COMMENT 'WBS element to which the assignment belongs.',
    CONSTRAINT pk_activity_resource_assignment PRIMARY KEY(`activity_resource_assignment_id`)
) COMMENT 'Assignment of a schedule resource to a specific activity, capturing the planned and actual resource consumption. Stores assigned resource reference, activity reference, budgeted units, actual units to date, remaining units, budgeted cost, actual cost, remaining cost, resource distribution curve (front-loaded, back-loaded, bell, linear), overtime units, and assignment status. Enables resource-loaded schedule analysis, cost-loaded CPM, and EVM BCWP (Budgeted Cost of Work Performed) calculations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`progress_update` (
    `progress_update_id` BIGINT COMMENT 'Unique surrogate key for the schedule progress update record.',
    `activity_id` BIGINT COMMENT 'add column activity_id (BIGINT) with FK to schedule.activity.activity_id - progress updates must reference the specific schedule activity being updated',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this progress update belongs.',
    `field_progress_id` BIGINT COMMENT 'Foreign key linking to site.field_progress. Business justification: Earned Value Management and schedule performance reporting require traceability from schedule progress updates back to the field measurement records that sourced them. The progress_update is formally ',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: EVM reporting requires linking schedule progress updates (BCWP, SPI, SV) to the approved project budget to compute CPI and forecast-at-completion. Construction project controllers depend on this link ',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: progress_update captures EVM metrics (bcwp, bcws, spi, sv) which are meaningless without a reference baseline. The SPI (Schedule Performance Index) and SV (Schedule Variance) are computed against a sp',
    `actual_finish_date` DATE COMMENT 'Actual finish date of the activity or work package as of this reporting period.',
    `actual_start_date` DATE COMMENT 'Actual start date of the activity or work package as of this reporting period.',
    `actual_units` DECIMAL(18,2) COMMENT 'Actual quantity of work units performed (e.g., labor hours, cubic meters).',
    `bcwp` DECIMAL(18,2) COMMENT 'Earned Value (BCWP) in project currency.',
    `bcws` DECIMAL(18,2) COMMENT 'Planned Value (BCWS) in project currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the progress update record was initially created in the system.',
    `critical_activity_count` STRING COMMENT 'Number of activities currently on the critical path.',
    `critical_path_completion_date` DATE COMMENT 'Estimated completion date of the critical path at this reporting period.',
    `forecast_completion_date` DATE COMMENT 'Projected date for project completion based on current performance trends.',
    `is_critical_path_changed` BOOLEAN COMMENT 'Flag indicating whether the critical path has changed compared to the previous reporting period.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations related to the progress update.',
    `path_drift_indicator` STRING COMMENT 'Indicator of whether the critical path is on schedule, drifting, or off track.. Valid values are `on_track|drift|off_track`',
    `percent_complete_duration` DECIMAL(18,2) COMMENT 'Percentage of duration completed (0-100).',
    `percent_complete_units` DECIMAL(18,2) COMMENT 'Percentage of work units completed (0-100).',
    `period_number` STRING COMMENT 'Sequential number of the reporting period within the project schedule.',
    `progress_update_status` STRING COMMENT 'Current lifecycle status of the progress update record.. Valid values are `draft|submitted|approved|rejected`',
    `remaining_duration` STRING COMMENT 'Remaining duration in days for the activity or work package.',
    `remaining_units` DECIMAL(18,2) COMMENT 'Remaining quantity of work units to be performed.',
    `reporting_date` DATE COMMENT 'Date for which the progress update snapshot is recorded.',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress updates are generated for the project.. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period covered by this update.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period covered by this update.',
    `reporting_status` STRING COMMENT 'Current status of the reporting period (e.g., pending, completed, overdue).. Valid values are `pending|completed|overdue`',
    `spi` DECIMAL(18,2) COMMENT 'Schedule Performance Index calculated as BCWP divided by BCWS.',
    `sv` DECIMAL(18,2) COMMENT 'Schedule Variance (BCWP minus BCWS) in project currency.',
    `sv_percent` DECIMAL(18,2) COMMENT 'Schedule Variance expressed as a percentage of BCWS.',
    `total_float` DECIMAL(18,2) COMMENT 'Total float (slack) in days for the critical path.',
    `update_source` STRING COMMENT 'Origin of the data for this progress update (e.g., field report, Primavera P6 import, HCSS HeavyJob).. Valid values are `field_report|p6_import|heavyjob`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the progress update record.',
    CONSTRAINT pk_progress_update PRIMARY KEY(`progress_update_id`)
) COMMENT 'Periodic schedule progress update record capturing actual performance data, EVM metrics, and critical path state at a specific data date. Stores actual start/finish dates, remaining duration, percent complete (duration, units, physical), actual/remaining units, update source (field report, P6 import, HCSS HeavyJob), reporting period definition (period number, dates, frequency, status), EVM metrics (BCWP, BCWS, SPI, SV, SV%, forecast completion date), and critical path snapshot (project completion date, total float, critical activity count, path drift indicator). Represents the single transactional record of schedule state per reporting period. Enables schedule performance trending, SPI reporting, and critical path monitoring over time.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` (
    `lookahead_plan_id` BIGINT COMMENT 'Unique identifier for the lookahead plan record.',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: In Last Planner System, the lookahead plan must be reviewed against the active HSE plan to confirm planned work fronts comply with site safety requirements. HSE managers and planners cross-reference t',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: A lookahead plan (3-week or 6-week rolling window) is derived from and measured against the current approved schedule baseline. lookahead_plan already has project_baseline_id -> project.project_baseli',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Short-interval lookahead scheduling (Last Planner System) is organized by work front. The lookahead_plan.work_front plain-text column is a denormalized reference to site.work_front. Planners and forem',
    `change_order_flag` BOOLEAN COMMENT 'True if any change orders are expected within the lookahead window.',
    `constraint_description` STRING COMMENT 'Detailed description of the identified constraint.',
    `constraint_type` STRING COMMENT 'Primary constraint type affecting the planned work.. Valid values are `material|permit|crew|equipment|weather|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lookahead plan record was created in the system.',
    `crew_ready_flag` BOOLEAN COMMENT 'True if the necessary crew is confirmed available for the lookahead period.',
    `critical_path_flag` BOOLEAN COMMENT 'True if any activity in the lookahead is on the project critical path.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the plan.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `end_date` DATE COMMENT 'Last calendar date of the lookahead period.',
    `equipment_ready_flag` BOOLEAN COMMENT 'True if required equipment is confirmed available for the lookahead period.',
    `horizon_weeks` STRING COMMENT 'Number of weeks covered by the lookahead window.',
    `is_lps_enabled` BOOLEAN COMMENT 'True if the lookahead follows the Last Planner System methodology.',
    `material_ready_flag` BOOLEAN COMMENT 'True if all required materials are confirmed available for the lookahead period.',
    `notes` STRING COMMENT 'Free‑text comments or observations related to the lookahead plan.',
    `pending_activities` STRING COMMENT 'Number of activities still pending readiness.',
    `percent_plan_complete` DECIMAL(18,2) COMMENT 'Percentage of planned activities that are ready to be executed (0‑100).',
    `plan_date` DATE COMMENT 'Date on which the lookahead plan was generated.',
    `plan_number` STRING COMMENT 'External reference number for the lookahead plan, used in project documentation.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the lookahead plan.. Valid values are `draft|approved|active|completed|cancelled`',
    `planned_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for the activities in the lookahead period.',
    `ppc_actual_percent` DECIMAL(18,2) COMMENT 'Actual Percent Plan Complete achieved during the lookahead period.',
    `ppc_target_percent` DECIMAL(18,2) COMMENT 'Target Percent Plan Complete (PPC) for the lookahead period.',
    `readiness_status` STRING COMMENT 'Overall readiness status of the work front for execution.. Valid values are `ready|not_ready|partial`',
    `ready_activities` STRING COMMENT 'Number of activities marked as ready for execution.',
    `risk_level` STRING COMMENT 'Overall risk level associated with the lookahead plan.. Valid values are `low|medium|high|critical`',
    `schedule_version` STRING COMMENT 'Version identifier of the underlying master schedule used for this lookahead.',
    `start_date` DATE COMMENT 'First calendar date of the lookahead period.',
    `total_activities` STRING COMMENT 'Total number of activities scheduled in the lookahead window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lookahead plan record.',
    `weather_impact_flag` BOOLEAN COMMENT 'True if adverse weather conditions are expected to impact the lookahead activities.',
    `zone_code` STRING COMMENT 'Alphanumeric code representing the specific site zone for the plan.',
    CONSTRAINT pk_lookahead_plan PRIMARY KEY(`lookahead_plan_id`)
) COMMENT 'Short-interval look-ahead schedule (typically 3-week or 6-week rolling window) used for near-term construction planning and crew coordination. Captures look-ahead period dates, horizon (weeks), responsible superintendent/foreman, work front or zone, constraint identification, and readiness status (materials, permits, crew, equipment confirmed). Supports Last Planner System (LPS) and Percent Plan Complete (PPC) tracking. Bridges the gap between the master CPM schedule and daily site execution. The header record for lookahead_activity line items.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` (
    `schedule_milestone_id` BIGINT COMMENT 'System‑generated unique identifier for the schedule milestone. _canonical_skip_reason: Entity does not fit a predefined role, treated as OTHER.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: In CPM scheduling (Oracle Primavera P6), milestones ARE activities — specifically zero-duration activities that mark significant events. schedule_milestone currently has no FK to activity, creating a ',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which the milestone is tied.',
    `contract_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Milestone reconciliation report aligns contract milestones with schedule milestones for payment certification and performance monitoring.',
    `payment_certificate_id` BIGINT COMMENT 'Foreign key linking to contract.contract_payment_certificate. Business justification: Payment certification requires linking schedule milestones to the contract payment certificate for audit, retention release, and compliance reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to quality.quality_plan. Business justification: Handover, practical completion, and DLP commencement milestones are gated by quality plan sign-off. The quality plans handover_quality_requirements directly govern milestone achievement — linking the',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: schedule_milestone has a baseline_date field (denormalized baseline date for the milestone) but no FK to schedule_baseline. Milestones are tracked against specific approved baselines — the baseline_da',
    `actual_date` DATE COMMENT 'Date the milestone was actually achieved; null if not yet achieved.',
    `baseline_date` DATE COMMENT 'Original baseline date from the approved project schedule before any re‑baselines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'True if the milestone lies on the projects critical path, affecting overall project duration.',
    `schedule_milestone_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the milestone.',
    `forecast_date` DATE COMMENT 'Most recent forecasted date for milestone completion based on progress and risk analysis.',
    `ld_exposure_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers liquidated damages if missed.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Monetary amount charged per day of delay when the LD exposure flag is true.',
    `location` STRING COMMENT 'Physical site or geographic location where the milestone is to be achieved.',
    `schedule_milestone_name` STRING COMMENT 'Human‑readable name of the milestone as defined in the contract or project plan.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone according to the baseline CPM schedule.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the milestone based on impact and probability of delay.. Valid values are `low|medium|high`',
    `schedule_milestone_status` STRING COMMENT 'Current status of the milestone reflecting progress and risk.. Valid values are `not_started|at_risk|achieved|missed`',
    `schedule_milestone_type` STRING COMMENT 'Classification of the milestone (e.g., contract‑driven, internal project, client‑required, or regulatory).. Valid values are `contract|internal|client|regulatory`',
    `sequence` STRING COMMENT 'Ordinal position of the milestone within the overall schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `variance_days` STRING COMMENT 'Difference in days between planned (or baseline) date and actual/forecast date.',
    CONSTRAINT pk_schedule_milestone PRIMARY KEY(`schedule_milestone_id`)
) COMMENT 'Key project milestone records representing contractually significant or internally critical schedule events with zero duration. Captures milestone name, milestone type (contract milestone, internal milestone, client milestone, regulatory milestone), planned date, forecast date, actual achieved date, milestone status (not started, at risk, achieved, missed), contract reference, liquidated damages (LD) exposure flag, LD rate per day, and milestone owner. Derived from contract schedule requirements and master CPM schedule milestone activities. Enables contract compliance tracking, LD exposure monitoring, and executive schedule reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`delay_event` (
    `delay_event_id` BIGINT COMMENT 'System-generated unique identifier for the delay event record.',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: EOT (Extension of Time) claims and delay analysis require formal linkage between delay events and the daily log entries that evidence them. Daily logs are the primary contemporaneous record used to su',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Safety incidents are a recognised cause of schedule delay in construction. The delay event must reference the triggering incident so that EOT (Extension of Time) claims, delay analysis reports, and in',
    `eot_claim_id` BIGINT COMMENT 'Foreign key linking to contract.contract_eot_claim. Business justification: Delay events are the factual schedule records that substantiate formal EOT claims. Essential for claim preparation, linking schedule analysis to contractual claims, and providing audit trail. Construc',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Delay events affect a specific schedule baseline and may be tied to an EOT claim; linking creates proper relationships and removes string reference columns.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DELAY CLAIMS: Delay events often stem from vendor delivery or performance; linking to vendor supports root‑cause analysis and EOT claim justification.',
    `approval_date` DATE COMMENT 'Date when the delay event record was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the delay event record.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 currency code for the cost impact amount.',
    `created_by_user` STRING COMMENT 'System user who created the delay event record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delay event record was first created in the system.',
    `delay_category` STRING COMMENT 'Legal/contractual classification of the delay.. Valid values are `excusable_compensable|excusable_non_compensable|non_excusable`',
    `delay_duration_calendar_days` STRING COMMENT 'Total number of calendar days the event delayed the schedule.',
    `delay_duration_working_days` STRING COMMENT 'Total number of working days the event delayed the schedule, accounting for non‑working days.',
    `delay_event_status` STRING COMMENT 'Current processing status of the delay event record.. Valid values are `open|in_review|approved|rejected|closed`',
    `delay_event_description` STRING COMMENT 'Detailed narrative describing the cause and nature of the delay.',
    `eot_claim_status` STRING COMMENT 'Current status of the linked Extension of Time claim.. Valid values are `pending|approved|rejected`',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the delay event ended or is expected to end.',
    `event_name` STRING COMMENT 'Descriptive name given to the delay event.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the delay event began.',
    `event_type` STRING COMMENT 'Category of the delay event such as weather, design change, employer instruction, utility conflict, permit delay, labor dispute, material shortage, or force majeure. [ENUM-REF-CANDIDATE: weather|design_change|employer_instruction|utility_conflict|permit_delay|labor_dispute|material_shortage|force_majeure — promote to reference product]',
    `impact_on_cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost impact associated with the delay.',
    `impact_on_critical_path` BOOLEAN COMMENT 'Indicates whether the delay impacts the project critical path (true/false).',
    `last_modified_by_user` STRING COMMENT 'System user who last modified the delay event record.',
    `mitigation_measures` STRING COMMENT 'Actions taken to mitigate or recover from the delay.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the delay event.',
    `risk_rating` STRING COMMENT 'Risk rating associated with the delay event.. Valid values are `low|medium|high`',
    `severity_level` STRING COMMENT 'Severity rating of the delays impact on schedule and cost.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delay event record.',
    CONSTRAINT pk_delay_event PRIMARY KEY(`delay_event_id`)
) COMMENT 'Discrete delay event record capturing a specific occurrence that caused or is causing schedule delay. Stores event name, event type (weather, design change, employer instruction, utility conflict, permit delay, labor dispute, material shortage, force majeure), event start date, event end date, impacted activities, delay duration (calendar days, working days), responsibility party (employer, contractor, third party, neutral), delay category (excusable compensable, excusable non-compensable, non-excusable), linked EOT claim reference, and mitigation measures taken. Supports delay analysis (as-planned vs as-built, time impact analysis, windows analysis).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` (
    `lookahead_activity_id` BIGINT COMMENT 'Unique system-generated identifier for this lookahead activity commitment record',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the CPM schedule activity being committed to in this lookahead window',
    `lookahead_plan_id` BIGINT COMMENT 'Foreign key linking to the lookahead plan that includes this activity commitment',
    `actual_completion_flag` BOOLEAN COMMENT 'True if this activity was actually completed during the lookahead period, used to calculate actual PPC versus target',
    `commitment_date` DATE COMMENT 'Date when this activity was committed to the lookahead plan by the responsible foreman or superintendent',
    `constraint_description` STRING COMMENT 'Detailed description of the specific constraint affecting this activity in the lookahead period, captured during weekly planning meetings',
    `constraint_type` STRING COMMENT 'Primary constraint type preventing or delaying this activity within the lookahead window, used for constraint log analysis',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lookahead activity commitment record was created in the system',
    `notes` STRING COMMENT 'Free-text notes specific to this activitys inclusion in this lookahead plan, captured during planning meetings',
    `planned_finish_date` DATE COMMENT 'The finish date planned for this activity within the lookahead window, may differ from the master schedule baseline date due to near-term adjustments',
    `planned_start_date` DATE COMMENT 'The start date planned for this activity within the lookahead window, may differ from the master schedule baseline date due to near-term adjustments',
    `ppc_contribution_flag` BOOLEAN COMMENT 'True if this activity was committed to and successfully completed within the lookahead period, contributing positively to the Percent Plan Complete (PPC) metric',
    `readiness_status` STRING COMMENT 'Overall readiness status of this activity for execution within the lookahead period, drives the ready_activities count on the parent lookahead_plan',
    `removed_flag` BOOLEAN COMMENT 'True if this activity was removed from the lookahead plan after initial commitment due to constraints or reprioritization',
    `removed_reason` STRING COMMENT 'Explanation of why this activity was removed from the lookahead plan if removed_flag is true',
    CONSTRAINT pk_lookahead_activity PRIMARY KEY(`lookahead_activity_id`)
) COMMENT 'This association product represents the commitment of a specific CPM schedule activity within a short-interval lookahead plan window. It captures the Last Planner System (LPS) commitment tracking, readiness assessment, and Percent Plan Complete (PPC) contribution for each activity included in a lookahead planning cycle. Each record links one lookahead plan to one activity with attributes that exist only in the context of this near-term planning commitment.. Existence Justification: In Last Planner System (LPS) construction scheduling, a lookahead plan includes multiple CPM activities selected for near-term execution (typically 3-6 week window), and each activity can appear in multiple sequential lookahead plans as the rolling window advances. The business actively manages these commitments through weekly planning meetings, tracking readiness status, constraints, and PPC contribution for each activity-plan pairing. This is an operational M:N relationship with a recognized business name (lookahead activity or plan commitment) and relationship-specific data.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` (
    `delay_activity_impact_id` BIGINT COMMENT 'System-generated unique identifier for the delay-activity impact record',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the schedule activity that was impacted',
    `delay_event_id` BIGINT COMMENT 'Foreign key linking to the delay event that caused the impact',
    `activity_ids_impacted` STRING COMMENT 'Comma‑separated list of activity identifiers that are affected by the delay. [Moved from delay_event: This denormalized STRING field (comma-separated list of activity IDs) is direct evidence that the current model acknowledges multiple activities per delay event but has not properly normalized it. This field should be REMOVED from delay_event and replaced by the M:N association table, which provides proper normalization and enables per-activity impact quantification.]',
    `analysis_method` STRING COMMENT 'Delay analysis methodology used to establish this impact relationship',
    `cost_impact_allocation` DECIMAL(18,2) COMMENT 'Portion of the delay events total cost impact allocated to this specific activity',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this impact record was first created',
    `critical_path_contribution` BOOLEAN COMMENT 'Indicates whether this specific impact contributed to overall project critical path delay (true/false)',
    `eot_days_claimed` STRING COMMENT 'Number of Extension of Time days claimed for this specific activity impact in the EOT claim',
    `impact_duration_days` STRING COMMENT 'Number of days this specific delay event impacted this specific activity (calendar days)',
    `impact_recorded_date` DATE COMMENT 'Date when this delay-activity impact relationship was formally recorded in the system',
    `impact_type` STRING COMMENT 'Classification of how the delay impacted the activity: direct (activity directly delayed), indirect (downstream impact), concurrent (overlapping delays), pacing (activity became critical)',
    `mitigation_action` STRING COMMENT 'Specific mitigation measures taken for this activity in response to this delay event',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this impact record',
    CONSTRAINT pk_delay_activity_impact PRIMARY KEY(`delay_activity_impact_id`)
) COMMENT 'This association product represents the impact relationship between a delay event and a schedule activity. It captures the formal delay analysis linkage required for Time Impact Analysis (TIA), Windows Analysis, and As-Planned vs As-Built methodologies. Each record links one delay event to one impacted activity with attributes that quantify the specific impact on that activity, supporting EOT claim substantiation and critical path analysis per activity per delay.. Existence Justification: In construction project controls, delay events routinely impact multiple schedule activities simultaneously (e.g., a weather delay affects all outdoor activities in progress), and individual activities can be impacted by multiple distinct delay events over their lifecycle (e.g., an activity delayed first by design changes, then by material shortages). The relationship between delay events and impacted activities is a formally managed business concept called delay impact or delay-activity impact, which is the foundation of delay analysis methodologies (Time Impact Analysis, Windows Analysis, As-Planned vs As-Built) required for EOT claims and dispute resolution.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ADD CONSTRAINT `fk_schedule_delay_activity_impact_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ADD CONSTRAINT `fk_schedule_delay_activity_impact_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('dbx_domain' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('dbx_subdomain' = 'activity_management');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Point Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Review Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `swms_id` SET TAGS ('dbx_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `toolbox_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Toolbox Meeting Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'task_dependent|resource_dependent|level_of_effort|milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_date` SET TAGS ('dbx_business_glossary_term' = 'Constraint Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'asap|start_no_earlier_than|finish_no_later_than|mandatory|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `free_float_days` SET TAGS ('dbx_business_glossary_term' = 'Free Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `lookahead_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `lookahead_start_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `original_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Original Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `remaining_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('dbx_subdomain' = 'activity_management');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Relationship ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Relationship');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `is_driving` SET TAGS ('dbx_business_glossary_term' = 'Is Driving Relationship');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_duration` SET TAGS ('dbx_business_glossary_term' = 'Lag Duration');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('dbx_business_glossary_term' = 'Lag Time Unit');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('dbx_value_regex' = 'days|hours|minutes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'system_export|manual_entry');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'FS|SS|FF|SF');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('dbx_value_regex' = 'original|current|supplemental');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Baseline Change Reason');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Baseline Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `data_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_description` SET TAGS ('dbx_business_glossary_term' = 'Baseline Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Baseline Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_name` SET TAGS ('dbx_business_glossary_term' = 'Baseline Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Revision Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('dbx_value_regex' = 'draft|approved|rejected|archived');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_tool_project_ref` SET TAGS ('dbx_business_glossary_term' = 'Schedule Tool Project Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `total_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Baseline Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Activity Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Constraint Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('dbx_value_regex' = 'as_soon_as_possible|start_on|finish_on|must_start_on|must_finish_on|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cost Variance');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_finish` SET TAGS ('dbx_business_glossary_term' = 'Baseline Early Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Early Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_is_critical` SET TAGS ('dbx_business_glossary_term' = 'Baseline Critical Activity Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_finish` SET TAGS ('dbx_business_glossary_term' = 'Baseline Late Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_start` SET TAGS ('dbx_business_glossary_term' = 'Baseline Late Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_original_duration` SET TAGS ('dbx_business_glossary_term' = 'Baseline Original Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Baseline Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_remaining_duration` SET TAGS ('dbx_business_glossary_term' = 'Baseline Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Baseline Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('dbx_value_regex' = 'labor|equipment|material|subcontractor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_units` SET TAGS ('dbx_business_glossary_term' = 'Baseline Resource Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_schedule_variance` SET TAGS ('dbx_business_glossary_term' = 'Baseline Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_total_float` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `billing_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Calendar Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `calendar_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `calendar_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `default_units_per_time` SET TAGS ('dbx_business_glossary_term' = 'Default Units Per Time');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_description` SET TAGS ('dbx_business_glossary_term' = 'Resource Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Resource Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `is_overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_concurrent_assignments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_units_per_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Units Per Period');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `overtime_factor` SET TAGS ('dbx_business_glossary_term' = 'Overtime Factor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('dbx_business_glossary_term' = 'Procurement Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_role` SET TAGS ('dbx_business_glossary_term' = 'Resource Role');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontractor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `skill_set` SET TAGS ('dbx_business_glossary_term' = 'Skill Set');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_subdomain' = 'resource_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Resource Assignment ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|closed|cancelled|on_hold');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('dbx_business_glossary_term' = 'Distribution Curve');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('dbx_value_regex' = 'front_loaded|back_loaded|bell|linear|custom|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'skilled|unskilled|supervisor|foreman|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_quantity` SET TAGS ('dbx_business_glossary_term' = 'Overtime Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_cost` SET TAGS ('dbx_business_glossary_term' = 'Remaining Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_location` SET TAGS ('dbx_business_glossary_term' = 'Resource Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('dbx_business_glossary_term' = 'Resource Role');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('dbx_value_regex' = 'foreman|operator|installer|inspector|supervisor|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'labor|equipment|material|subcontractor|tool|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hours|days|m3|kg|units|percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `field_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Field Progress Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_units` SET TAGS ('dbx_business_glossary_term' = 'Actual Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `bcws` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `critical_activity_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Activity Count');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `critical_path_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Completion Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `is_critical_path_changed` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Change Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('dbx_business_glossary_term' = 'Path Drift Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('dbx_value_regex' = 'on_track|drift|off_track');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_duration` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (Duration)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_units` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (Units)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Update Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `remaining_duration` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `remaining_units` SET TAGS ('dbx_business_glossary_term' = 'Remaining Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `spi` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `sv` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `sv_percent` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Percent (SV%)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `total_float` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('dbx_business_glossary_term' = 'Update Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('dbx_value_regex' = 'field_report|p6_import|heavyjob');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Constraint Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'material|permit|crew|equipment|weather|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `crew_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `equipment_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Horizon Weeks');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `is_lps_enabled` SET TAGS ('dbx_business_glossary_term' = 'Last Planner System Enabled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `material_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `pending_activities` SET TAGS ('dbx_business_glossary_term' = 'Pending Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `percent_plan_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Plan Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Generation Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_actual_percent` SET TAGS ('dbx_business_glossary_term' = 'PPC Actual Percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_target_percent` SET TAGS ('dbx_business_glossary_term' = 'PPC Target Percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('dbx_value_regex' = 'ready|not_ready|partial');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ready_activities` SET TAGS ('dbx_business_glossary_term' = 'Ready Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `total_activities` SET TAGS ('dbx_business_glossary_term' = 'Total Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `weather_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` SET TAGS ('dbx_subdomain' = 'activity_management');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Milestone ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_id` SET TAGS ('dbx_ssot_ref' = 'contract.contract_milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `contract_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Payment Certificate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `ld_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Exposure Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `ld_rate_per_day` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate Per Day');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Milestone Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_status` SET TAGS ('dbx_value_regex' = 'not_started|at_risk|achieved|missed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `schedule_milestone_type` SET TAGS ('dbx_value_regex' = 'contract|internal|client|regulatory');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Related Eot Claim Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('dbx_business_glossary_term' = 'Delay Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('dbx_value_regex' = 'excusable_compensable|excusable_non_compensable|non_excusable');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_calendar_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Calendar Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_working_days` SET TAGS ('dbx_business_glossary_term' = 'Delay Duration (Working Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('dbx_value_regex' = 'open|in_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('dbx_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Event End Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('dbx_association_edges' = 'schedule.lookahead_plan,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `lookahead_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity - Activity Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Activity - Lookahead Plan Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `actual_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Constraint Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `ppc_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'PPC Contribution Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Readiness Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `removed_flag` SET TAGS ('dbx_business_glossary_term' = 'Removed Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `removed_reason` SET TAGS ('dbx_business_glossary_term' = 'Removed Reason');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` SET TAGS ('dbx_subdomain' = 'performance_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` SET TAGS ('dbx_association_edges' = 'schedule.delay_event,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `delay_activity_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Activity Impact ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Activity Impact - Activity Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Activity Impact - Delay Event Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `activity_ids_impacted` SET TAGS ('dbx_business_glossary_term' = 'Impacted Activity IDs');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analysis Method');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `cost_impact_allocation` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Allocation');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `critical_path_contribution` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Contribution');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `eot_days_claimed` SET TAGS ('dbx_business_glossary_term' = 'EOT Days Claimed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `impact_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Impact Duration Days');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `impact_recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Impact Recorded Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_activity_impact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
