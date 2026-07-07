-- Schema for Domain: schedule | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-27 01:56:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`schedule` COMMENT 'Project scheduling domain managing CPM (Critical Path Method) networks, activity sequencing, resource leveling, critical path analysis, progress tracking, baseline comparisons, look-ahead plans, and schedule performance metrics (SPI). Integrates with Oracle Primavera P6 for schedule exports and EVM (Earned Value Management) for project control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`activity` (
    `activity_id` BIGINT COMMENT 'Unique system-generated identifier for the schedule activity.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost coding of schedule activities for budgeting and earned value reporting requires linking each activity to a finance cost_code entity.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: ITP‑tracking report requires each activity to reference its ITP; activity references itp_id for planning and compliance.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Activities requiring hazardous work must reference the associated Permit‑to‑Work to manage authorization and control measures.',
    `project_baseline_id` BIGINT COMMENT 'Identifier of the schedule baseline to which this activity belongs.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Pre-task safety planning requires each scheduled activity to reference its governing risk assessment. Construction schedulers and HSE officers cross-reference these daily for work pack approvals, regu',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: During planning, each activity is linked to its approved Safe Work Method Statement to ensure compliance with safety procedures.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: QA/QC and construction execution: each activity (e.g., concrete pour, structural steel erection) is governed by a specific specification section. Project controls and quality teams link activities to ',
    `toolbox_meeting_id` BIGINT COMMENT 'Foreign key linking to safety.toolbox_meeting. Business justification: Toolbox meetings are conducted immediately before high-risk activities commence. Linking activity to its pre-task TBM enables verification that mandatory safety briefings occurred before work started ',
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
    `construction_project_id` BIGINT COMMENT 'Foreign key to project.construction_project.construction_project_id',
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
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to client.client_opportunity. Business justification: Project controls teams trace schedule baselines to the originating opportunity for scope change analysis and earned value reporting. The opportunity defines the original scope, duration, and contract ',
    `project_baseline_id` BIGINT COMMENT 'Foreign key linking to project.project_baseline. Business justification: EVM requires pairing a schedule baseline with a project (cost+scope) baseline. Construction PMO baseline approval processes treat cost and schedule baselines as a unified project baseline. schedule_ba',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: The schedule baseline and project budget baseline are established together as the Project Control Baseline (PCB). Linking enables time-phased BCWS generation, S-curve production, and EVM reporting — a',
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
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Baseline activity costs (baseline_cost) must reconcile with approved project budget line items. Linking enables schedule-to-budget variance analysis, cost-loaded schedule validation, and EVM baseline ',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: baseline_activity is a frozen snapshot of an activitys planned dates and metrics at a specific baseline point. It already references the cross-domain schedule.project_baseline, but within the schedule',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resources belong to a cost center for overhead allocation and internal charging. The plain cost_center attribute on resource is a denormalized reference. Normalizing to FK enables resource cost center',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Resources carry a default cost code for cost allocation in estimating and scheduling. The denormalized cost_account_code plain attribute on resource should be normalized to a proper FK. Enables resour',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: RESOURCE PLANNING: External subcontractor/vendor provides the resource; procurement contracts vendor, schedule assigns resource to activities. Linking enables traceability of vendor‑supplied labor/equ',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Planned availability of the resource expressed as a percent of total time.',
    `billing_rate_per_hour` DECIMAL(18,2) COMMENT 'Rate used for billing external parties for labor resources.',
    `calendar_name` STRING COMMENT 'Name of the work calendar associated with the resource (defines working days/hours).',
    `certification_requirements` STRING COMMENT 'Required certifications or trainings for the resource (e.g., OSHA, LEED).',
    `resource_code` STRING COMMENT 'External identifier or catalogue number for the resource.',
    `compliance_requirements` STRING COMMENT 'Regulatory or safety compliance items applicable to the resource (e.g., OSHA training).',
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
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Resource assignments must post costs to project cost accounts for EVM and cost control reporting. Construction cost engineers track actual resource costs against cost accounts. activity_resource_assig',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource assignments are charged to cost centers; linking enables accurate cost allocation and financial reporting per cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posting resource assignment costs to GL accounts requires linking assignments to finance.gl_account for proper ledger entries.',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: Rental cost verification in scheduling: when a resource assignment involves rented equipment, the rental agreement governs applicable rates, minimum hire periods, and billing terms. Project controls t',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (labor, equipment, material, etc.) assigned to the activity.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: Resource assignments for high-risk tasks (confined space, hot work, elevated work) must reference the applicable risk assessment to confirm controls are in place before deployment. HSE compliance repo',
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
    `activity_id` BIGINT COMMENT 'Foreign key to schedule.activity.activity_id',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: EVM metrics stored on progress_update (bcwp, bcws, spi, sv, sv_percent) are computed relative to a specific schedule baseline. Without a FK to schedule_baseline, it is impossible to determine which ba',
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
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this lookahead plan belongs.',
    `fleet_assignment_id` BIGINT COMMENT 'Foreign key linking to equipment.fleet_assignment. Business justification: Last Planner System equipment readiness check: lookahead_plan.equipment_ready_flag requires verification against a specific fleet assignment record to confirm the equipment is formally deployed and av',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: Last Planner System lookahead planning explicitly checks ITP hold/witness point clearance as a constraint before committing work to the weekly plan. A construction scheduler must verify ITP readiness ',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Last Planner System / lookahead planning: before committing activities to the weekly work plan, planners must confirm the governing design package is approved and issued. This link enables automated r',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: A lookahead plan (3-week or 6-week rolling window) is derived from and measured against the current approved schedule baseline. The lookahead_plan already references schedule.project_baseline (cross-do',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.staffing_plan. Business justification: Last Planner System (LPS) lookahead planning requires confirming workforce readiness against the active staffing plan. The lookahead_plan.crew_ready_flag and readiness_status are assessed against the ',
    `wbs_element_id` BIGINT COMMENT 'add column wbs_element_id (BIGINT) with FK to project.wbs_element.wbs_element_id - lookahead plans typically scope to a WBS branch',
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
    `work_front` STRING COMMENT 'Name or code of the work front or zone covered by the lookahead plan.',
    `zone_code` STRING COMMENT 'Alphanumeric code representing the specific site zone for the plan.',
    CONSTRAINT pk_lookahead_plan PRIMARY KEY(`lookahead_plan_id`)
) COMMENT 'Short-interval look-ahead schedule (typically 3-week or 6-week rolling window) used for near-term construction planning and crew coordination. Captures look-ahead period dates, horizon (weeks), responsible superintendent/foreman, work front or zone, constraint identification, and readiness status (materials, permits, crew, equipment confirmed). Supports Last Planner System (LPS) and Percent Plan Complete (PPC) tracking. Bridges the gap between the master CPM schedule and daily site execution. The header record for lookahead_activity line items.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`delay_event` (
    `delay_event_id` BIGINT COMMENT 'System-generated unique identifier for the delay event record.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to project.project_milestone. Business justification: Delay events directly threaten contractual milestones — the basis for LD exposure and EOT claims. Construction contracts require demonstrating which milestone a delay event impacts. delay_event has no',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Delay events in construction are reported at phase level for EOT claims and gate review impacts (e.g., design phase delayed by permit). Phase-level delay reporting is a contractual requirement. delay_',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Delay events affect a specific schedule baseline and may be tied to an EOT claim; linking creates proper relationships and removes string reference columns.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DELAY CLAIMS: Delay events often stem from vendor delivery or performance; linking to vendor supports root‑cause analysis and EOT claim justification.',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: EOT claim and delay analysis reports identify which work fronts were impacted by each delay event, enabling zone-level schedule impact assessment. Construction delay claims require spatial attribution',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` (
    `plan_commitment_id` BIGINT COMMENT 'Primary key for the plan_commitment association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the CPM schedule activity being committed to in this plan window',
    `lookahead_plan_id` BIGINT COMMENT 'Foreign key linking to the lookahead plan that contains this commitment',
    `commitment_status` STRING COMMENT 'Lifecycle status of this plan commitment record — whether the activity was committed, completed as planned, or not completed (used for PPC calculation).',
    `constraint_type` STRING COMMENT 'Type of constraint blocking or affecting this activity within this lookahead window. Distinct from the master schedule constraint_type on the activity record.',
    `crew_ready_flag` BOOLEAN COMMENT 'True if the required crew is confirmed available for this activity within this lookahead plan window.',
    `equipment_ready_flag` BOOLEAN COMMENT 'True if required equipment is confirmed available for this activity within this lookahead plan window.',
    `lookahead_finish_date` DATE COMMENT 'Finish date used in the look‑ahead planning window. [Moved from activity: Same reasoning as lookahead_start_date — this is a per-window planned date that belongs to the plan_commitment association as window_planned_finish_date, not a static property of the activity itself.]',
    `lookahead_start_date` DATE COMMENT 'Start date used in the look‑ahead planning window. [Moved from activity: This date is specific to a particular lookahead plan window, not a permanent property of the activity. When an activity appears in multiple lookahead plans, storing a single lookahead_start_date on the activity record causes data loss — only the most recent window date is retained. The correct location is window_planned_start_date on the plan_commitment association.]',
    `material_ready_flag` BOOLEAN COMMENT 'True if all required materials are confirmed available for this activity within this lookahead plan window.',
    `readiness_status` STRING COMMENT 'Readiness status of this specific activity within this specific lookahead plan window. Tracks whether the activity has cleared all prerequisites for execution in this window.',
    `window_planned_finish_date` DATE COMMENT 'Planned finish date for this activity as scheduled within this specific lookahead window. May differ from the master schedule planned_finish_date.',
    `window_planned_start_date` DATE COMMENT 'Planned start date for this activity as scheduled within this specific lookahead window. May differ from the master schedule planned_start_date due to near-term replanning.',
    CONSTRAINT pk_plan_commitment PRIMARY KEY(`plan_commitment_id`)
) COMMENT 'This association product represents the formal commitment between a lookahead_plan and an activity within the Last Planner System (LPS). It captures the per-window readiness state, constraint tracking, and planned execution dates for a specific activity as it appears in a specific lookahead plan period. Each record links one lookahead_plan to one activity and carries attributes that exist only in the context of that plan-window/activity pairing — readiness flags, window-specific dates, and constraint details that change from one rolling window to the next.. Existence Justification: In Last Planner System (LPS) construction scheduling, a lookahead plan explicitly manages a curated set of activities for a rolling planning window (typically 3–6 weeks). A single lookahead plan covers multiple activities, AND a single activity can appear in multiple successive lookahead plans (e.g., a multi-week activity spans plan week 1, week 2, and week 3 rolling windows). The relationship itself — called a lookahead commitment or plan commitment — carries its own data: window-specific readiness flags, constraint tracking, and planned dates within that specific window that differ from the master schedule dates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ADD CONSTRAINT `fk_schedule_lookahead_plan_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ADD CONSTRAINT `fk_schedule_plan_commitment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ADD CONSTRAINT `fk_schedule_plan_commitment_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('dbx_domain' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline ID');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `original_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Original Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `remaining_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `total_float_days` SET TAGS ('dbx_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Relationship ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_business_glossary_term' = 'Relationship Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('dbx_value_regex' = 'system_export|manual_entry');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'FS|SS|FF|SF');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `project_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Project Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `billing_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Calendar Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_concurrent_assignments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_units_per_period` SET TAGS ('dbx_business_glossary_term' = 'Maximum Units Per Period');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `overtime_factor` SET TAGS ('dbx_business_glossary_term' = 'Overtime Factor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('dbx_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Resource Assignment ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('dbx_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_id` SET TAGS ('dbx_business_glossary_term' = 'Progress Update ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lookahead Plan ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Assignment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `itp_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Staffing Plan Id (Foreign Key)');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `work_front` SET TAGS ('dbx_business_glossary_term' = 'Work Front');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_id` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Phase Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `schedule_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
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
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Delay Event Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` SET TAGS ('dbx_subdomain' = 'execution_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` SET TAGS ('dbx_association_edges' = 'schedule.lookahead_plan,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `plan_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Commitment - Plan Commitment Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Commitment - Activity Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `lookahead_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Commitment - Lookahead Plan Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `crew_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `equipment_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `lookahead_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `lookahead_start_date` SET TAGS ('dbx_business_glossary_term' = 'Look‑Ahead Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `material_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Readiness Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `window_planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Window Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`plan_commitment` ALTER COLUMN `window_planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Planned Start Date');
