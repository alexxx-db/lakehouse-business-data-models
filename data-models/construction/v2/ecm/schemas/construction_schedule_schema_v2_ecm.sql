-- Schema for Domain: schedule | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`schedule` COMMENT 'Project scheduling domain managing CPM (Critical Path Method) networks, activity sequencing, resource leveling, critical path analysis, progress tracking, baseline comparisons, look-ahead plans, and schedule performance metrics (SPI). Integrates with Oracle Primavera P6 for schedule exports and EVM (Earned Value Management) for project control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`activity` (
    `activity_id` BIGINT COMMENT 'Unique system-generated identifier for the schedule activity.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Permit compliance tracking: each scheduled activity must reference the required construction permit to ensure legal start and permit status monitoring.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Needed for project status dashboards that aggregate activity progress per construction project; each activity must be directly linked to its project.',
    `engineering_submittal_id` BIGINT COMMENT 'Foreign key linking to design.design_submittal. Business justification: Submittal Review Gate process blocks activity start until the related submittal is approved; linking provides the Submittal Status Dashboard.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental impact assessments are tied to specific construction activities (e.g., earthworks) for regulatory reporting and mitigation planning.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Cost coding of schedule activities for budgeting and earned value reporting requires linking each activity to a finance cost_code entity.',
    `interface_point_id` BIGINT COMMENT 'Foreign key linking to design.interface_point. Business justification: Interface Coordination Schedule uses interface_point_id to align multidisciplinary handover dates with activity sequencing.',
    `itp_id` BIGINT COMMENT 'Foreign key linking to quality.itp. Business justification: ITP‑tracking report requires each activity to reference its ITP; activity references itp_id for planning and compliance.',
    `mep_coordination_zone_id` BIGINT COMMENT 'Foreign key linking to design.mep_coordination_zone. Business justification: MEP Coordination Zone planning links activities to specific zones; zone_id is required for zone‑based resource allocation and clash resolution.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Activity ownership is needed for accountability, performance tracking, and audit of who is responsible for each scheduled task.',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Activities requiring hazardous work must reference the associated Permit‑to‑Work to manage authorization and control measures.',
    `project_baseline_id` BIGINT COMMENT 'Identifier of the schedule baseline to which this activity belongs.',
    `schedule_calendar_id` BIGINT COMMENT 'Identifier of the calendar to which the activity is assigned.',
    `swms_id` BIGINT COMMENT 'Foreign key linking to safety.swms. Business justification: During planning, each activity is linked to its approved Safe Work Method Statement to ensure compliance with safety procedures.',
    `wbs_element_id` BIGINT COMMENT 'FK to project.wbs_element.wbs_element_id — Core project-centric reporting spine: every schedule activity must link to a WBS element for earned value, progress reporting, and cost integration. Without this FK, schedule-to-project reporting is b',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Activities belong to a WBS node; linking provides hierarchy and removes redundant wbs_code column.',
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
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Baseline approval audit requires recording the employee who approved the baseline for governance and compliance.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this baseline belongs.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Baseline schedules are updated when new regulatory changes affect project timelines; linking captures the change that triggered baseline revision.',
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
    `project_baseline_id` BIGINT COMMENT 'Identifier of the schedule baseline to which this activity belongs.',
    `wbs_node_id` BIGINT COMMENT 'Identifier of the WBS element that groups this activity.',
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
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Labor allocation report and payroll integration require linking each labor resource to the employee performing the work.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: REQUIRED: Resource allocation reports must attribute external resources to the subcontractor providing them, enabling cost and performance tracking.',
    `activity_id` BIGINT COMMENT 'Identifier of the most recent activity to which the resource was assigned.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Resource assignments are charged to cost centers; linking enables accurate cost allocation and financial reporting per cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Posting resource assignment costs to GL accounts requires linking assignments to finance.gl_account for proper ledger entries.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (labor, equipment, material, etc.) assigned to the activity.',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Tracks which subcontract provides the assigned resources, enabling accurate cost allocation and subcontractor performance analysis.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Cost incurred to date for the resource consumption.',
    `actual_finish_date` DATE COMMENT 'Date when the resource actually completed work on the activity.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Resource units actually consumed to date.',
    `actual_start_date` DATE COMMENT 'Date when the resource actually began work on the activity.',
    `approval_status` STRING COMMENT 'Current approval state of the assignment.. Valid values are `pending|approved|rejected`',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the resource assignment.. Valid values are `planned|active|completed|closed|cancelled|on_hold`',
    `change_order_number` STRING COMMENT 'Reference to a change order that modified this assignment.',
    `compliance_status` STRING COMMENT 'Indicates whether the assignment meets regulatory or contract compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `cost_account_code` STRING COMMENT 'Accounting code used for cost allocation of this assignment.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`wbs_node` (
    `wbs_node_id` BIGINT COMMENT 'System-generated unique identifier for the WBS node.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the parent project to which the WBS belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WBS nodes are allocated to cost centers for budgeting; linking provides cost‑center roll‑up for each WBS element.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the primary individual responsible for the node.',
    `hr_org_unit_id` BIGINT COMMENT 'Identifier of the organization accountable for the node.',
    `parent_wbs_wbs_node_id` BIGINT COMMENT 'Identifier of the immediate parent WBS node; null for top‑level nodes.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Cost incurred to date for the node.',
    `actual_duration_days` STRING COMMENT 'Actual elapsed days from start to finish.',
    `actual_finish_date` DATE COMMENT 'Date when work actually completed for the node.',
    `actual_start_date` DATE COMMENT 'Date when work actually commenced on the node.',
    `baseline_finish_date` DATE COMMENT 'Baseline finish date used for Earned Value Management comparisons.',
    `baseline_start_date` DATE COMMENT 'Baseline start date used for Earned Value Management comparisons.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Original cost estimate for the node before any revisions.',
    `change_order_indicator` BOOLEAN COMMENT 'True if the node has been impacted by a change order.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the WBS node record was created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether the node lies on the projects critical path.',
    `deleted_flag` BOOLEAN COMMENT 'True if the node has been logically deleted; false otherwise.',
    `wbs_node_description` STRING COMMENT 'Detailed textual description of the scope element.',
    `earned_value_method` STRING COMMENT 'Technique used to calculate earned value for the node.. Valid values are `fixed_formula|percent_complete|weighted_milestones|level_of_effort`',
    `external_reference` STRING COMMENT 'Identifier of the node in external systems (e.g., Primavera activity ID).',
    `is_milestone` BOOLEAN COMMENT 'True if the node represents a project milestone.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by planners.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current progress expressed as a percentage of total planned effort.',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost allocated to the node.',
    `planned_duration_days` STRING COMMENT 'Planned duration of the node in calendar days.',
    `planned_finish_date` DATE COMMENT 'Scheduled finish date as originally planned.',
    `planned_start_date` DATE COMMENT 'Scheduled start date as originally planned.',
    `risk_level` STRING COMMENT 'Qualitative risk rating assigned to the node.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the WBS node record.',
    `wbs_code` STRING COMMENT 'Unique hierarchical code assigned to the WBS node, used for identification and reporting.',
    `wbs_level` STRING COMMENT 'Depth of the node within the WBS hierarchy (1 = top level).',
    `wbs_name` STRING COMMENT 'Descriptive name of the WBS node representing the scope element.',
    `wbs_node_status` STRING COMMENT 'Current lifecycle status of the WBS node.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `wbs_type` STRING COMMENT 'Classification of the node (e.g., project summary, work package, activity, milestone).. Valid values are `project_summary|wbs_summary|work_package|control_account|activity|milestone`',
    CONSTRAINT pk_wbs_node PRIMARY KEY(`wbs_node_id`)
) COMMENT 'Work Breakdown Structure (WBS) hierarchy node defining the decomposition of project scope into manageable components. Captures WBS code, WBS name, WBS level, parent WBS reference, WBS type (project summary, WBS summary, work package), anticipated start and finish dates, earned value technique (fixed formula, percent complete, weighted milestones, level of effort), and WBS status. Provides the hierarchical framework for schedule organization, cost control, progress reporting, and EVM roll-up calculations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` (
    `schedule_calendar_id` BIGINT COMMENT 'System-generated unique identifier for the work calendar.',
    `construction_project_id` BIGINT COMMENT 'Foreign key to project.construction_project.construction_project_id',
    `break_time_minutes_per_day` STRING COMMENT 'Total minutes of mandatory break time deducted from the workday.',
    `calendar_category` STRING COMMENT 'Higher‑level grouping of calendars for reporting (standard, custom, or regional).. Valid values are `standard|custom|regional`',
    `calendar_code` STRING COMMENT 'Business identifier or code assigned to the calendar (e.g., "CAL‑US‑NY").',
    `calendar_name` STRING COMMENT 'Human‑readable name of the calendar used in scheduling tools.',
    `calendar_type` STRING COMMENT 'Classification of the calendar: global (company‑wide), project‑specific, or resource‑specific.. Valid values are `global|project|resource`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was first created in the source system.',
    `schedule_calendar_description` STRING COMMENT 'Free‑form description providing additional context about the calendar.',
    `effective_end_date` DATE COMMENT 'Date on which the calendar ceases to be active; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the calendar becomes active for scheduling calculations.',
    `holiday_exceptions` STRING COMMENT 'Comma‑separated list or description of holidays and non‑working dates that override the regular schedule.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this calendar is the default for its scope.',
    `max_overtime_hours_per_day` DECIMAL(18,2) COMMENT 'Upper limit of overtime hours that can be applied in a single day.',
    `overtime_allowed` BOOLEAN COMMENT 'Indicates if overtime hours may be scheduled under this calendar.',
    `schedule_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar.. Valid values are `active|inactive|archived|pending`',
    `shift_pattern` STRING COMMENT 'Definition of work shifts applied to the calendar.. Valid values are `single|double|custom`',
    `timezone` STRING COMMENT 'IANA time‑zone identifier (e.g., "America/New_York") that the calendar operates in.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calendar record.',
    `version_number` STRING COMMENT 'Incremental version of the calendar definition for change tracking.',
    `work_days_per_week` STRING COMMENT 'Number of days in a week that are considered working days.',
    `work_hours_per_day` DECIMAL(18,2) COMMENT 'Standard number of productive hours defined for a typical workday.',
    `work_week_definition` STRING COMMENT 'Encoded representation (e.g., JSON string) of which days of the week are working days.',
    CONSTRAINT pk_schedule_calendar PRIMARY KEY(`schedule_calendar_id`)
) COMMENT 'Work calendars defining working and non-working time periods used in schedule calculations. Captures calendar name, calendar type (global, project, resource), standard work hours per day, work week definition (working days per week), holiday exceptions, shift patterns, and time zone. Imported from the enterprise scheduling tool calendar configuration. Determines activity duration calculations, float computations, and resource availability windows. Critical for multi-site international projects operating across different regional calendars and public holiday schedules. [SSOT: distinct source of truth for schedule domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`progress_update` (
    `progress_update_id` BIGINT COMMENT 'Unique surrogate key for the schedule progress update record.',
    `activity_id` BIGINT COMMENT 'Foreign key to schedule.activity.activity_id',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this progress update belongs.',
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
    `hr_employee_id` BIGINT COMMENT 'Identifier of the superintendent or foreman responsible for this lookahead period.',
    `project_baseline_id` BIGINT COMMENT 'Identifier of the schedule baseline referenced by the lookahead plan.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` (
    `lookahead_activity_id` BIGINT COMMENT 'Unique identifier for the lookahead activity record.',
    `asset_id` BIGINT COMMENT 'Identifier of primary equipment assigned to the activity.',
    `activity_id` BIGINT COMMENT 'Reference to the CPM activity in Primavera P6 that this lookahead activity maps to.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Lookahead planning assigns specific crews to upcoming activities; required for crew dispatch, resource leveling, and labor budgeting.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the foreman responsible for the activity.',
    `firm_profile_id` BIGINT COMMENT 'Identifier of subcontractor responsible for the activity, if any.',
    `lookahead_plan_id` BIGINT COMMENT 'Reference to the parent look-ahead plan.',
    `master_id` BIGINT COMMENT 'Identifier of primary material required for the activity.',
    `project_change_order_id` BIGINT COMMENT 'Reference to the related change order, if applicable.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the activity.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration of the activity in hours.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end time recorded when work finished.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start time recorded when work began.',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if the activity is associated with a change order.',
    `commitment_status` STRING COMMENT 'Current commitment status of the activity.. Valid values are `planned|committed|completed|not_completed`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost for the activity.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between estimated and actual cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lookahead activity record was created.',
    `crew_size` STRING COMMENT 'Number of crew members planned to work on the activity.',
    `equipment_quantity` STRING COMMENT 'Quantity of equipment units planned for the activity.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating if the activity is on the project critical path.',
    `is_equipment_intensive` BOOLEAN COMMENT 'Indicates if the activity relies heavily on equipment.',
    `is_labor_intensive` BOOLEAN COMMENT 'Indicates if the activity is primarily labor intensive.',
    `is_milestone` BOOLEAN COMMENT 'Indicates if the activity is a project milestone.',
    `location_zone` STRING COMMENT 'Work location or zone code where the activity will be performed.',
    `lookahead_sequence` STRING COMMENT 'Sequence order of the activity within the look‑ahead plan.',
    `material_quantity` DECIMAL(18,2) COMMENT 'Planned quantity of material required (units).',
    `milestone_name` STRING COMMENT 'Name of the milestone when the activity represents a milestone.',
    `non_completion_reason_code` STRING COMMENT 'Code indicating the reason for non‑completion when status is not completed.',
    `notes` STRING COMMENT 'Additional free‑text notes or comments for the activity.',
    `planned_date` DATE COMMENT 'Planned execution date for the activity within the look-ahead window.',
    `planned_duration_hours` DECIMAL(18,2) COMMENT 'Planned duration of the activity in hours.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time for the activity.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for the activity.',
    `ppc_contribution_flag` BOOLEAN COMMENT 'Indicates if the activity contributes to Percent Plan Complete (PPC).',
    `required_permits` STRING COMMENT 'Comma‑separated list of permits required for the activity.',
    `required_skill_level` STRING COMMENT 'Skill level required for the crew (e.g., apprentice, journeyman, specialist).',
    `safety_risk_level` STRING COMMENT 'Safety risk classification for the activity.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `variance_duration_hours` DECIMAL(18,2) COMMENT 'Difference between planned and actual duration.',
    `weather_constraint_description` STRING COMMENT 'Description of weather constraints (e.g., rain, temperature).',
    `weather_constraint_flag` BOOLEAN COMMENT 'Indicates if weather conditions affect the activity.',
    CONSTRAINT pk_lookahead_activity PRIMARY KEY(`lookahead_activity_id`)
) COMMENT 'Individual planned task within a look-ahead plan, representing a specific work item committed for execution within the short-interval planning window. Captures parent look-ahead plan reference, linked CPM activity reference, planned execution date, planned crew size, planned equipment, planned material requirements, responsible foreman, work location/zone, commitment status (planned, committed, completed, not completed), reason for non-completion code, and PPC (Percent Plan Complete) contribution flag. Enables weekly work plan tracking and constraint removal workflows.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`delay_event` (
    `delay_event_id` BIGINT COMMENT 'System-generated unique identifier for the delay event record.',
    `firm_profile_id` BIGINT COMMENT 'Party held responsible for the delay.',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Delay events affect a specific schedule baseline and may be tied to an EOT claim; linking creates proper relationships and removes string reference columns.',
    `schedule_impact_claim_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_eot_claim. Business justification: Link delay events to the EOT claim they support, enabling traceability.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DELAY CLAIMS: Delay events often stem from vendor delivery or performance; linking to vendor supports root‑cause analysis and EOT claim justification.',
    `activity_ids_impacted` STRING COMMENT 'Comma‑separated list of activity identifiers that are affected by the delay.',
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

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` (
    `schedule_risk_id` BIGINT COMMENT 'Unique identifier for the schedule risk entry. _canonical_skip_reason: Entity does not fit predefined role categories, classified as OTHER.',
    `pursuit_risk_id` BIGINT COMMENT 'SSOT reference to canonical bid.bid_risk resolving cross-domain duplicate.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Risk management processes assign a responsible employee; linking enables tracking mitigation responsibility.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Risk register links each schedule risk to the underlying regulatory obligation that creates the risk, enabling compliance‑driven risk mitigation.',
    `schedule_baseline_id` BIGINT COMMENT 'Foreign key linking to schedule.schedule_baseline. Business justification: Schedule risks are evaluated against a specific baseline; linking provides context.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: RISK MANAGEMENT: Schedule risk register tracks vendor‑related performance risks; linking to vendor allows risk owner identification and contractual mitigation.',
    `assessment_date` DATE COMMENT 'Date on which the risk was formally assessed.',
    `contingency_reserve_days` STRING COMMENT 'Number of days of schedule contingency set aside for this risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the risk becomes active or applicable.',
    `effective_until` DATE COMMENT 'Date when the risk is no longer considered active, if applicable.',
    `mitigation_plan` STRING COMMENT 'Planned actions and strategies to reduce the probability or impact of the risk.',
    `monte_carlo_p50_date` DATE COMMENT 'Projected completion date at the 50th percentile from Monte Carlo simulation.',
    `monte_carlo_p80_date` DATE COMMENT 'Projected completion date at the 80th percentile from Monte Carlo simulation.',
    `monte_carlo_p85_date` DATE COMMENT 'Projected completion date at the 85th percentile from Monte Carlo simulation.',
    `owner_department` STRING COMMENT 'Department or business unit responsible for the risk.',
    `owner_role` STRING COMMENT 'Job role or title of the risk owner (e.g., Project Scheduler, Construction Manager).',
    `priority` STRING COMMENT 'Priority level used to rank the risk for mitigation planning.. Valid values are `low|medium|high|critical`',
    `probability_rating` STRING COMMENT 'Qualitative rating of the likelihood that the risk will materialize.. Valid values are `low|medium|high|very_high`',
    `response_type` STRING COMMENT 'Chosen strategy for responding to the risk.. Valid values are `avoid|mitigate|transfer|accept`',
    `risk_category` STRING COMMENT 'Classification of the risk based on its origin or domain.. Valid values are `design|procurement|construction|external|weather|regulatory`',
    `risk_description` STRING COMMENT 'Detailed description of the schedule risk, including cause and context.',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk.. Valid values are `identified|assessed|mitigated|closed|realized`',
    `schedule_impact_days` STRING COMMENT 'Estimated number of days the schedule could be delayed if the risk occurs.',
    `score` DECIMAL(18,2) COMMENT 'Calculated score combining probability and schedule impact to prioritize risks.',
    `source_system_reference` STRING COMMENT 'Unique identifier of the risk in the source system.',
    `title` STRING COMMENT 'Short descriptive title of the schedule risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk record.',
    CONSTRAINT pk_schedule_risk PRIMARY KEY(`schedule_risk_id`)
) COMMENT 'Schedule risk register entry identifying threats and opportunities that may impact project schedule performance. Captures risk ID, risk title, risk description, risk category (design, procurement, construction, external, weather, regulatory), probability rating, schedule impact (days), risk score, risk status (identified, assessed, mitigated, closed, realized), risk owner, mitigation plan, contingency reserve days, Monte Carlo simulation P50/P80/P85 completion date outputs, and risk response type (avoid, mitigate, transfer, accept). Supports quantitative schedule risk analysis (QSRA) and schedule contingency management. [SSOT: distinct source of truth for schedule domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` (
    `scheduled_event_id` BIGINT COMMENT 'System‑generated unique identifier for the schedule milestone. _canonical_skip_reason: Entity does not fit a predefined role, treated as OTHER.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract to which the milestone is tied.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the milestone belongs.',
    `payment_milestone_id` BIGINT COMMENT 'Foreign key linking to contract.contract_milestone. Business justification: Milestone reconciliation report aligns contract milestones with schedule milestones for payment certification and performance monitoring.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Milestones are owned by a responsible foreman; linking supports accountability, progress reporting, and compliance audits.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person or role responsible for delivering the milestone.',
    `project_milestone_id` BIGINT COMMENT 'SSOT reference to canonical project.project_milestone (single source of truth).',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: Milestones are part of the WBS hierarchy; linking removes redundant wbs_code.',
    `actual_date` DATE COMMENT 'Date the milestone was actually achieved; null if not yet achieved.',
    `baseline_date` DATE COMMENT 'Original baseline date from the approved project schedule before any re‑baselines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'True if the milestone lies on the projects critical path, affecting overall project duration.',
    `forecast_date` DATE COMMENT 'Most recent forecasted date for milestone completion based on progress and risk analysis.',
    `ld_exposure_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers liquidated damages if missed.',
    `ld_rate_per_day` DECIMAL(18,2) COMMENT 'Monetary amount charged per day of delay when the LD exposure flag is true.',
    `location` STRING COMMENT 'Physical site or geographic location where the milestone is to be achieved.',
    `planned_date` DATE COMMENT 'Date originally scheduled for the milestone according to the baseline CPM schedule.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the milestone based on impact and probability of delay.. Valid values are `low|medium|high`',
    `schedule_milestone_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the milestone.',
    `schedule_milestone_name` STRING COMMENT 'Human‑readable name of the milestone as defined in the contract or project plan.',
    `schedule_milestone_status` STRING COMMENT 'Current status of the milestone reflecting progress and risk.. Valid values are `not_started|at_risk|achieved|missed`',
    `schedule_milestone_type` STRING COMMENT 'Classification of the milestone (e.g., contract‑driven, internal project, client‑required, or regulatory).. Valid values are `contract|internal|client|regulatory`',
    `sequence` STRING COMMENT 'Ordinal position of the milestone within the overall schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `variance_days` STRING COMMENT 'Difference in days between planned (or baseline) date and actual/forecast date.',
    CONSTRAINT pk_scheduled_event PRIMARY KEY(`scheduled_event_id`)
) COMMENT 'Key project milestone records representing contractually significant or internally critical schedule events with zero duration. Captures milestone name, milestone type (contract milestone, internal milestone, client milestone, regulatory milestone), planned date, forecast date, actual achieved date, milestone status (not started, at risk, achieved, missed), contract reference, liquidated damages (LD) exposure flag, LD rate per day, and milestone owner. Derived from contract schedule requirements and master CPM schedule milestone activities. Enables contract compliance tracking, LD exposure monitoring, and executive schedule reporting. [SSOT: distinct source of truth for schedule domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` (
    `schedule_impact_claim_id` BIGINT COMMENT 'System-generated unique identifier for the EOT claim record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Links EOT claim to the client account responsible for the delay, required for claim justification and regulatory reporting of party responsibilities.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the claim relates.',
    `prime_eot_claim_id` BIGINT COMMENT 'SSOT reference to canonical contract.contract_eot_claim (single source of truth).',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: EOT claim creation audit needs the employee identifier to ensure traceability and accountability.',
    `schedule_baseline_id` BIGINT COMMENT 'Identifier of the baseline schedule against which the delay is measured.',
    `approval_date` DATE COMMENT 'Date the claim was approved (or partially approved) by the employer.',
    `approved_extension_days` STRING COMMENT 'Number of days approved by the employer after claim evaluation.',
    `claim_reference_number` STRING COMMENT 'External business identifier assigned to the claim, used in contract administration and communications.',
    `claim_status` STRING COMMENT 'Current lifecycle state of the claim within the contract administration workflow.. Valid values are `draft|submitted|under_review|approved|rejected|partially_approved`',
    `claim_submission_date` DATE COMMENT 'Date the claim was formally submitted to the employer or client.',
    `claim_type` STRING COMMENT 'Classification of the delay event triggering the claim, aligned with contract clauses such as FIDIC Sub‑Clause 8.4.. Valid values are `employer_risk|force_majeure|concurrent_delay|neutral_event`',
    `claimed_extension_days` STRING COMMENT 'Number of calendar days the claimant requests to extend the contract completion date.',
    `contract_clause_reference` STRING COMMENT 'Reference to the contractual clause (e.g., FIDIC Sub‑Clause 8.4) that governs the claim.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `delay_end_date` DATE COMMENT 'Planned end date of the delay event as recorded in the project schedule.',
    `delay_event_description` STRING COMMENT 'Narrative description of the excusable delay event that caused the time extension request.',
    `delay_start_date` DATE COMMENT 'Planned start date of the delay event as recorded in the project schedule.',
    `impact_on_schedule` STRING COMMENT 'Qualitative assessment of how the delay affects overall project schedule performance.. Valid values are `none|minor|major`',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether the delayed activity lies on the projects critical path (true) or not (false).',
    `justification_document_reference` STRING COMMENT 'Reference (e.g., document number or URL) to supporting documentation submitted with the claim.',
    `supporting_schedule_analysis_reference` STRING COMMENT 'Identifier of the schedule analysis (e.g., critical path report) that substantiates the claim.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the claim record.',
    CONSTRAINT pk_schedule_impact_claim PRIMARY KEY(`schedule_impact_claim_id`)
) COMMENT 'Extension of Time (EOT) claim record documenting a formal request to extend the contract completion date due to excusable delay events. Captures claim reference number, claim type (employer risk, force majeure, concurrent delay, neutral event), delay event description, delay start and end dates, claimed extension days, approved extension days, claim status (draft, submitted, under review, approved, rejected, partially approved), contract clause reference (FIDIC Sub-Clause 8.4), supporting schedule analysis reference, and claim submission date. Critical for contract administration and schedule recovery planning. [SSOT: distinct source of truth for schedule domain]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_schedule_calendar_id` FOREIGN KEY (`schedule_calendar_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_calendar`(`schedule_calendar_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `vibe_construction_v1`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ADD CONSTRAINT `fk_schedule_baseline_activity_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `vibe_construction_v1`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ADD CONSTRAINT `fk_schedule_wbs_node_parent_wbs_wbs_node_id` FOREIGN KEY (`parent_wbs_wbs_node_id`) REFERENCES `vibe_construction_v1`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ADD CONSTRAINT `fk_schedule_lookahead_activity_lookahead_plan_id` FOREIGN KEY (`lookahead_plan_id`) REFERENCES `vibe_construction_v1`.`schedule`.`lookahead_plan`(`lookahead_plan_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_schedule_impact_claim_id` FOREIGN KEY (`schedule_impact_claim_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_impact_claim`(`schedule_impact_claim_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ADD CONSTRAINT `fk_schedule_schedule_risk_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ADD CONSTRAINT `fk_schedule_scheduled_event_wbs_node_id` FOREIGN KEY (`wbs_node_id`) REFERENCES `vibe_construction_v1`.`schedule`.`wbs_node`(`wbs_node_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ADD CONSTRAINT `fk_schedule_schedule_impact_claim_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`schedule` SET TAGS ('pii_domain' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `engineering_submittal_id` SET TAGS ('pii_business_glossary_term' = 'Design Submittal Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `interface_point_id` SET TAGS ('pii_business_glossary_term' = 'Interface Point Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `itp_id` SET TAGS ('pii_business_glossary_term' = 'Itp Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `mep_coordination_zone_id` SET TAGS ('pii_business_glossary_term' = 'Mep Coordination Zone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `permit_to_work_id` SET TAGS ('pii_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `project_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `schedule_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Calendar ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `swms_id` SET TAGS ('pii_business_glossary_term' = 'Swms Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Element Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `wbs_node_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('pii_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_status` SET TAGS ('pii_value_regex' = 'not_started|in_progress|completed|suspended|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_type` SET TAGS ('pii_value_regex' = 'task_dependent|resource_dependent|level_of_effort|milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `actual_finish_date` SET TAGS ('pii_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_code` SET TAGS ('pii_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_date` SET TAGS ('pii_business_glossary_term' = 'Constraint Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('pii_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `constraint_type` SET TAGS ('pii_value_regex' = 'asap|start_no_earlier_than|finish_no_later_than|mandatory|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_description` SET TAGS ('pii_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `free_float_days` SET TAGS ('pii_business_glossary_term' = 'Free Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `lookahead_finish_date` SET TAGS ('pii_business_glossary_term' = 'Look‑Ahead Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `lookahead_start_date` SET TAGS ('pii_business_glossary_term' = 'Look‑Ahead Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `activity_name` SET TAGS ('pii_business_glossary_term' = 'Activity Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `original_duration_days` SET TAGS ('pii_business_glossary_term' = 'Original Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `percent_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_finish_date` SET TAGS ('pii_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `remaining_duration_days` SET TAGS ('pii_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `total_float_days` SET TAGS ('pii_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_id` SET TAGS ('pii_business_glossary_term' = 'Activity Relationship ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Predecessor Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('pii_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_status` SET TAGS ('pii_value_regex' = 'active|inactive|deleted');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `activity_relationship_description` SET TAGS ('pii_business_glossary_term' = 'Relationship Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Is Critical Path Relationship');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `is_driving` SET TAGS ('pii_business_glossary_term' = 'Is Driving Relationship');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_duration` SET TAGS ('pii_business_glossary_term' = 'Lag Duration');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('pii_business_glossary_term' = 'Lag Time Unit');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `lag_time_unit` SET TAGS ('pii_value_regex' = 'days|hours|minutes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('pii_business_glossary_term' = 'Relationship Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_source` SET TAGS ('pii_value_regex' = 'system_export|manual_entry');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('pii_business_glossary_term' = 'Relationship Type (Finish-to-Start, Start-to-Start, Finish-to-Finish, Start-to-Finish)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `relationship_type` SET TAGS ('pii_value_regex' = 'FS|SS|FF|SF');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('pii_business_glossary_term' = 'Baseline Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `baseline_type` SET TAGS ('pii_value_regex' = 'original|current|supplemental');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `bcws_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Baseline Change Reason');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Baseline Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Baseline Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `data_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Data Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_description` SET TAGS ('pii_business_glossary_term' = 'Baseline Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `finish_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `is_current` SET TAGS ('pii_business_glossary_term' = 'Is Current Baseline Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_name` SET TAGS ('pii_business_glossary_term' = 'Baseline Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `revision_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Revision Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('pii_business_glossary_term' = 'Baseline Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_baseline_status` SET TAGS ('pii_value_regex' = 'draft|approved|rejected|archived');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `schedule_tool_project_ref` SET TAGS ('pii_business_glossary_term' = 'Schedule Tool Project Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `total_duration_days` SET TAGS ('pii_business_glossary_term' = 'Baseline Total Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Baseline Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Baseline Version Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_id` SET TAGS ('pii_business_glossary_term' = 'Baseline Activity Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `project_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Baseline Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `wbs_node_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('pii_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_activity_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Constraint Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('pii_business_glossary_term' = 'Baseline Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_constraint_type` SET TAGS ('pii_value_regex' = 'as_soon_as_possible|start_on|finish_on|must_start_on|must_finish_on|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost` SET TAGS ('pii_business_glossary_term' = 'Baseline Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_cost_variance` SET TAGS ('pii_business_glossary_term' = 'Baseline Cost Variance');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_finish` SET TAGS ('pii_business_glossary_term' = 'Baseline Early Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_early_start` SET TAGS ('pii_business_glossary_term' = 'Baseline Early Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_is_critical` SET TAGS ('pii_business_glossary_term' = 'Baseline Critical Activity Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_finish` SET TAGS ('pii_business_glossary_term' = 'Baseline Late Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_late_start` SET TAGS ('pii_business_glossary_term' = 'Baseline Late Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_milestone_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_original_duration` SET TAGS ('pii_business_glossary_term' = 'Baseline Original Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_percent_complete` SET TAGS ('pii_business_glossary_term' = 'Baseline Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_remaining_duration` SET TAGS ('pii_business_glossary_term' = 'Baseline Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('pii_business_glossary_term' = 'Baseline Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_type` SET TAGS ('pii_value_regex' = 'labor|equipment|material|subcontractor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_resource_units` SET TAGS ('pii_business_glossary_term' = 'Baseline Resource Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_schedule_variance` SET TAGS ('pii_business_glossary_term' = 'Baseline Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `baseline_total_float` SET TAGS ('pii_business_glossary_term' = 'Baseline Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`baseline_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_id` SET TAGS ('pii_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `asset_category_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Last Assigned Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `availability_percentage` SET TAGS ('pii_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `billing_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'Billing Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `calendar_name` SET TAGS ('pii_business_glossary_term' = 'Resource Calendar Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `certification_requirements` SET TAGS ('pii_business_glossary_term' = 'Certification Requirements');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_code` SET TAGS ('pii_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_account_code` SET TAGS ('pii_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `cost_center` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `default_units_per_time` SET TAGS ('pii_business_glossary_term' = 'Default Units Per Time');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `depreciation_rate` SET TAGS ('pii_business_glossary_term' = 'Depreciation Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_description` SET TAGS ('pii_business_glossary_term' = 'Resource Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `environmental_impact_score` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `is_external` SET TAGS ('pii_business_glossary_term' = 'External Resource Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `is_overtime_allowed` SET TAGS ('pii_business_glossary_term' = 'Overtime Allowed Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `labor_category` SET TAGS ('pii_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `last_used_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `material_category` SET TAGS ('pii_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_concurrent_assignments` SET TAGS ('pii_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `max_units_per_period` SET TAGS ('pii_business_glossary_term' = 'Maximum Units Per Period');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_name` SET TAGS ('pii_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Resource Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `overtime_factor` SET TAGS ('pii_business_glossary_term' = 'Overtime Factor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `price_per_unit` SET TAGS ('pii_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('pii_business_glossary_term' = 'Procurement Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `procurement_source` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_role` SET TAGS ('pii_business_glossary_term' = 'Resource Role');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('pii_business_glossary_term' = 'Resource Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('pii_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `resource_type` SET TAGS ('pii_value_regex' = 'labor|material|equipment|subcontractor');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('pii_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `safety_rating` SET TAGS ('pii_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `site_location` SET TAGS ('pii_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `skill_set` SET TAGS ('pii_business_glossary_term' = 'Skill Set');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ALTER COLUMN `utilization_rate` SET TAGS ('pii_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_resource_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Activity Resource Assignment ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_id` SET TAGS ('pii_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `subcontract_id` SET TAGS ('pii_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_finish_date` SET TAGS ('pii_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_quantity` SET TAGS ('pii_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'planned|active|completed|closed|cancelled|on_hold');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `change_order_number` SET TAGS ('pii_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_account_code` SET TAGS ('pii_business_glossary_term' = 'Cost Account Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `cost_rate` SET TAGS ('pii_business_glossary_term' = 'Cost Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('pii_business_glossary_term' = 'Distribution Curve');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `distribution_curve` SET TAGS ('pii_value_regex' = 'front_loaded|back_loaded|bell|linear|custom|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `finish_date` SET TAGS ('pii_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('pii_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `labor_category` SET TAGS ('pii_value_regex' = 'skilled|unskilled|supervisor|foreman|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `line_sequence` SET TAGS ('pii_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_quantity` SET TAGS ('pii_business_glossary_term' = 'Overtime Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `overtime_rate` SET TAGS ('pii_business_glossary_term' = 'Overtime Rate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_cost` SET TAGS ('pii_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `planned_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_cost` SET TAGS ('pii_business_glossary_term' = 'Remaining Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `remaining_quantity` SET TAGS ('pii_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_location` SET TAGS ('pii_business_glossary_term' = 'Resource Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('pii_business_glossary_term' = 'Resource Role');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('pii_value_regex' = 'foreman|operator|installer|inspector|supervisor|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('pii_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `resource_type` SET TAGS ('pii_value_regex' = 'labor|equipment|material|subcontractor|tool|other');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('pii_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `safety_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'hours|days|m3|kg|units|percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_subdomain' = 'activity_planning');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Node ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Organization ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `parent_wbs_wbs_node_id` SET TAGS ('pii_business_glossary_term' = 'Parent WBS Node ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `actual_duration_days` SET TAGS ('pii_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `actual_finish_date` SET TAGS ('pii_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `baseline_finish_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `baseline_start_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `budgeted_cost` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `change_order_indicator` SET TAGS ('pii_business_glossary_term' = 'Change Order Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `deleted_flag` SET TAGS ('pii_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_description` SET TAGS ('pii_business_glossary_term' = 'WBS Node Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `earned_value_method` SET TAGS ('pii_business_glossary_term' = 'Earned Value Method');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `earned_value_method` SET TAGS ('pii_value_regex' = 'fixed_formula|percent_complete|weighted_milestones|level_of_effort');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `external_reference` SET TAGS ('pii_business_glossary_term' = 'External System Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `is_milestone` SET TAGS ('pii_business_glossary_term' = 'Milestone Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'WBS Node Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `percent_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `planned_cost` SET TAGS ('pii_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `planned_duration_days` SET TAGS ('pii_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `planned_finish_date` SET TAGS ('pii_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_level` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_name` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_status` SET TAGS ('pii_business_glossary_term' = 'WBS Node Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_node_status` SET TAGS ('pii_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_type` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`wbs_node` ALTER COLUMN `wbs_type` SET TAGS ('pii_value_regex' = 'project_summary|wbs_summary|work_package|control_account|activity|milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_subdomain' = 'baseline_control');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot_scope' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot_counterpart' = 'compliance.compliance_calendar');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Calendar ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `break_time_minutes_per_day` SET TAGS ('pii_business_glossary_term' = 'Break Time Minutes Per Day');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_category` SET TAGS ('pii_business_glossary_term' = 'Calendar Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_category` SET TAGS ('pii_value_regex' = 'standard|custom|regional');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_code` SET TAGS ('pii_business_glossary_term' = 'Calendar Code (CAL_CODE)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_business_glossary_term' = 'Calendar Name (CAL_NAME)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_type` SET TAGS ('pii_business_glossary_term' = 'Calendar Type (CAL_TYPE)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `calendar_type` SET TAGS ('pii_value_regex' = 'global|project|resource');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_description` SET TAGS ('pii_business_glossary_term' = 'Calendar Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `holiday_exceptions` SET TAGS ('pii_business_glossary_term' = 'Holiday Exceptions');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `is_default` SET TAGS ('pii_business_glossary_term' = 'Is Default Calendar');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `max_overtime_hours_per_day` SET TAGS ('pii_business_glossary_term' = 'Maximum Overtime Hours Per Day');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `overtime_allowed` SET TAGS ('pii_business_glossary_term' = 'Overtime Allowed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_status` SET TAGS ('pii_business_glossary_term' = 'Calendar Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `schedule_calendar_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `shift_pattern` SET TAGS ('pii_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `shift_pattern` SET TAGS ('pii_value_regex' = 'single|double|custom');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `timezone` SET TAGS ('pii_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `work_days_per_week` SET TAGS ('pii_business_glossary_term' = 'Work Days Per Week');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `work_hours_per_day` SET TAGS ('pii_business_glossary_term' = 'Work Hours Per Day');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_calendar` ALTER COLUMN `work_week_definition` SET TAGS ('pii_business_glossary_term' = 'Work Week Definition');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_subdomain' = 'progress_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_id` SET TAGS ('pii_business_glossary_term' = 'Progress Update ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_finish_date` SET TAGS ('pii_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `actual_units` SET TAGS ('pii_business_glossary_term' = 'Actual Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `bcwp` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `bcws` SET TAGS ('pii_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `critical_activity_count` SET TAGS ('pii_business_glossary_term' = 'Critical Activity Count');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `critical_path_completion_date` SET TAGS ('pii_business_glossary_term' = 'Critical Path Completion Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `forecast_completion_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `is_critical_path_changed` SET TAGS ('pii_business_glossary_term' = 'Critical Path Change Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Progress Update Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('pii_business_glossary_term' = 'Path Drift Indicator');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `path_drift_indicator` SET TAGS ('pii_value_regex' = 'on_track|drift|off_track');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_duration` SET TAGS ('pii_business_glossary_term' = 'Percent Complete (Duration)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `percent_complete_units` SET TAGS ('pii_business_glossary_term' = 'Percent Complete (Units)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `period_number` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('pii_business_glossary_term' = 'Progress Update Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `progress_update_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `remaining_duration` SET TAGS ('pii_business_glossary_term' = 'Remaining Duration (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `remaining_units` SET TAGS ('pii_business_glossary_term' = 'Remaining Units');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('pii_business_glossary_term' = 'Reporting Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `reporting_status` SET TAGS ('pii_value_regex' = 'pending|completed|overdue');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `spi` SET TAGS ('pii_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `sv` SET TAGS ('pii_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `sv_percent` SET TAGS ('pii_business_glossary_term' = 'Schedule Variance Percent (SV%)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `total_float` SET TAGS ('pii_business_glossary_term' = 'Total Float (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('pii_business_glossary_term' = 'Update Source');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `update_source` SET TAGS ('pii_value_regex' = 'field_report|p6_import|heavyjob');
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_subdomain' = 'progress_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `lookahead_plan_id` SET TAGS ('pii_business_glossary_term' = 'Lookahead Plan ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Superintendent ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `project_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `change_order_flag` SET TAGS ('pii_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_description` SET TAGS ('pii_business_glossary_term' = 'Constraint Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('pii_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `constraint_type` SET TAGS ('pii_value_regex' = 'material|permit|crew|equipment|weather|none');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `crew_ready_flag` SET TAGS ('pii_business_glossary_term' = 'Crew Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Lookahead End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `equipment_ready_flag` SET TAGS ('pii_business_glossary_term' = 'Equipment Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `horizon_weeks` SET TAGS ('pii_business_glossary_term' = 'Horizon Weeks');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `is_lps_enabled` SET TAGS ('pii_business_glossary_term' = 'Last Planner System Enabled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `material_ready_flag` SET TAGS ('pii_business_glossary_term' = 'Material Ready Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `pending_activities` SET TAGS ('pii_business_glossary_term' = 'Pending Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `percent_plan_complete` SET TAGS ('pii_business_glossary_term' = 'Percent Plan Complete');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_date` SET TAGS ('pii_business_glossary_term' = 'Plan Generation Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Lookahead Plan Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Lookahead Plan Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `planned_cost` SET TAGS ('pii_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_actual_percent` SET TAGS ('pii_business_glossary_term' = 'PPC Actual Percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ppc_target_percent` SET TAGS ('pii_business_glossary_term' = 'PPC Target Percent');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('pii_business_glossary_term' = 'Readiness Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `readiness_status` SET TAGS ('pii_value_regex' = 'ready|not_ready|partial');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `ready_activities` SET TAGS ('pii_business_glossary_term' = 'Ready Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `schedule_version` SET TAGS ('pii_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Lookahead Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `total_activities` SET TAGS ('pii_business_glossary_term' = 'Total Activities');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `weather_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Weather Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `work_front` SET TAGS ('pii_business_glossary_term' = 'Work Front');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_plan` ALTER COLUMN `zone_code` SET TAGS ('pii_business_glossary_term' = 'Zone Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_subdomain' = 'progress_tracking');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `lookahead_activity_id` SET TAGS ('pii_business_glossary_term' = 'Lookahead Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'CPM Activity ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Foreman ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `lookahead_plan_id` SET TAGS ('pii_business_glossary_term' = 'Lookahead Plan ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `project_change_order_id` SET TAGS ('pii_business_glossary_term' = 'Change Order ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `actual_cost` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `actual_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `actual_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `actual_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `change_order_flag` SET TAGS ('pii_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `commitment_status` SET TAGS ('pii_business_glossary_term' = 'Commitment Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `commitment_status` SET TAGS ('pii_value_regex' = 'planned|committed|completed|not_completed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `cost_variance` SET TAGS ('pii_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `crew_size` SET TAGS ('pii_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `equipment_quantity` SET TAGS ('pii_business_glossary_term' = 'Equipment Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `is_equipment_intensive` SET TAGS ('pii_business_glossary_term' = 'Equipment Intensive Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `is_labor_intensive` SET TAGS ('pii_business_glossary_term' = 'Labor Intensive Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `is_milestone` SET TAGS ('pii_business_glossary_term' = 'Milestone Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `location_zone` SET TAGS ('pii_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `lookahead_sequence` SET TAGS ('pii_business_glossary_term' = 'Lookahead Sequence');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `material_quantity` SET TAGS ('pii_business_glossary_term' = 'Material Quantity');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `milestone_name` SET TAGS ('pii_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `non_completion_reason_code` SET TAGS ('pii_business_glossary_term' = 'Non-Completion Reason Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_date` SET TAGS ('pii_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Duration (Hours)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `planned_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `ppc_contribution_flag` SET TAGS ('pii_business_glossary_term' = 'PPC Contribution Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `required_permits` SET TAGS ('pii_business_glossary_term' = 'Required Permits');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `required_skill_level` SET TAGS ('pii_business_glossary_term' = 'Required Skill Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `safety_risk_level` SET TAGS ('pii_business_glossary_term' = 'Safety Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `safety_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `variance_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Duration Variance (Hours)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `weather_constraint_description` SET TAGS ('pii_business_glossary_term' = 'Weather Constraint Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`lookahead_activity` ALTER COLUMN `weather_constraint_flag` SET TAGS ('pii_business_glossary_term' = 'Weather Constraint Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_subdomain' = 'risk_delay');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_id` SET TAGS ('pii_business_glossary_term' = 'Delay Event Identifier');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Responsibility Party');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `schedule_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `schedule_impact_claim_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Eot Claim Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `activity_ids_impacted` SET TAGS ('pii_business_glossary_term' = 'Impacted Activity IDs');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_by_user` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('pii_business_glossary_term' = 'Delay Category');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_category` SET TAGS ('pii_value_regex' = 'excusable_compensable|excusable_non_compensable|non_excusable');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_calendar_days` SET TAGS ('pii_business_glossary_term' = 'Delay Duration (Calendar Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_duration_working_days` SET TAGS ('pii_business_glossary_term' = 'Delay Duration (Working Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('pii_business_glossary_term' = 'Delay Event Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_status` SET TAGS ('pii_value_regex' = 'open|in_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `delay_event_description` SET TAGS ('pii_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('pii_business_glossary_term' = 'EOT Claim Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `eot_claim_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delay Event End Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_name` SET TAGS ('pii_business_glossary_term' = 'Delay Event Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Delay Event Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Delay Event Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `impact_on_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `last_modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_subdomain' = 'risk_delay');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot_scope' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot_counterpart' = 'bid.bid_risk');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `schedule_risk_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Risk ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `pursuit_risk_id` SET TAGS ('pii_business_glossary_term' = 'Bid Risk Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `pursuit_risk_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `pursuit_risk_id` SET TAGS ('pii_ssot' = 'bid.bid_risk');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `schedule_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Baseline Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Date (Date When Risk Was Evaluated)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `contingency_reserve_days` SET TAGS ('pii_business_glossary_term' = 'Contingency Reserve (Days Allocated for Risk Mitigation)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Risk Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Risk Effective End Date (If Applicable)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Mitigation Plan (Planned Actions to Reduce Risk Impact)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `monte_carlo_p50_date` SET TAGS ('pii_business_glossary_term' = 'Monte Carlo P50 Completion Date (50th Percentile Forecast)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `monte_carlo_p80_date` SET TAGS ('pii_business_glossary_term' = 'Monte Carlo P80 Completion Date (80th Percentile Forecast)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `monte_carlo_p85_date` SET TAGS ('pii_business_glossary_term' = 'Monte Carlo P85 Completion Date (85th Percentile Forecast)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `owner_department` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Department (Organizational Unit Responsible)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `owner_role` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Role (Job Role of the Owner)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Risk Priority (Relative Importance of the Risk)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `probability_rating` SET TAGS ('pii_business_glossary_term' = 'Probability Rating (Likelihood of Occurrence)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `probability_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `response_type` SET TAGS ('pii_business_glossary_term' = 'Risk Response Type (Strategy to Address the Risk)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `response_type` SET TAGS ('pii_value_regex' = 'avoid|mitigate|transfer|accept');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category (e.g., Design, Procurement, Construction, External, Weather, Regulatory)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'design|procurement|construction|external|weather|regulatory');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `risk_status` SET TAGS ('pii_business_glossary_term' = 'Risk Status (Current Lifecycle State of the Risk)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `risk_status` SET TAGS ('pii_value_regex' = 'identified|assessed|mitigated|closed|realized');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `schedule_impact_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Impact (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `score` SET TAGS ('pii_business_glossary_term' = 'Risk Score (Composite Impact-Probability Score)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `source_system_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Reference (Identifier in the Originating System)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_subdomain' = 'risk_delay');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_master' = 'contract.contract_milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot' = 'schedule.schedule_milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_scope' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_ssot_resolved' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `scheduled_event_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Milestone ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `payment_milestone_id` SET TAGS ('pii_business_glossary_term' = 'Contract Milestone Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `payment_milestone_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `payment_milestone_id` SET TAGS ('pii_ssot' = 'contract.contract_milestone');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Milestone Owner ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `project_milestone_id` SET TAGS ('pii_business_glossary_term' = 'Project Milestone Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `project_milestone_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `project_milestone_id` SET TAGS ('pii_ssot_link' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `wbs_node_id` SET TAGS ('pii_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `actual_date` SET TAGS ('pii_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `baseline_date` SET TAGS ('pii_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `critical_path_flag` SET TAGS ('pii_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `forecast_date` SET TAGS ('pii_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `ld_exposure_flag` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages Exposure Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `ld_rate_per_day` SET TAGS ('pii_business_glossary_term' = 'Liquidated Damages Rate Per Day');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Milestone Location');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `planned_date` SET TAGS ('pii_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_description` SET TAGS ('pii_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_name` SET TAGS ('pii_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_status` SET TAGS ('pii_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_status` SET TAGS ('pii_value_regex' = 'not_started|at_risk|achieved|missed');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_type` SET TAGS ('pii_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `schedule_milestone_type` SET TAGS ('pii_value_regex' = 'contract|internal|client|regulatory');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `sequence` SET TAGS ('pii_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`scheduled_event` ALTER COLUMN `variance_days` SET TAGS ('pii_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_subdomain' = 'risk_delay');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_master' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_resolved_against' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_scope' = 'schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_ssot_counterpart' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `schedule_impact_claim_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Extension of Time (EOT) Claim ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_business_glossary_term' = 'Contract Eot Claim Id');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `prime_eot_claim_id` SET TAGS ('pii_ssot' = 'contract.contract_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `schedule_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Baseline ID');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Claim Approval Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `approved_extension_days` SET TAGS ('pii_business_glossary_term' = 'Approved Extension Days');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('pii_business_glossary_term' = 'Claim Reference Number');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_reference_number` SET TAGS ('pii_ssot_source' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|partially_approved');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_status` SET TAGS ('pii_ssot_source' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_submission_date` SET TAGS ('pii_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_type` SET TAGS ('pii_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claim_type` SET TAGS ('pii_value_regex' = 'employer_risk|force_majeure|concurrent_delay|neutral_event');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `claimed_extension_days` SET TAGS ('pii_business_glossary_term' = 'Claimed Extension Days');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `contract_clause_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Clause Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_end_date` SET TAGS ('pii_business_glossary_term' = 'Delay End Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_end_date` SET TAGS ('pii_ssot_source' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_event_description` SET TAGS ('pii_business_glossary_term' = 'Delay Event Description');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_event_description` SET TAGS ('pii_ssot_source' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_start_date` SET TAGS ('pii_business_glossary_term' = 'Delay Start Date');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `delay_start_date` SET TAGS ('pii_ssot_source' = 'subcontractor.subcontractor_eot_claim');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `impact_on_schedule` SET TAGS ('pii_business_glossary_term' = 'Impact on Schedule');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `impact_on_schedule` SET TAGS ('pii_value_regex' = 'none|minor|major');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `is_critical_path` SET TAGS ('pii_business_glossary_term' = 'Critical Path Impact Flag');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `justification_document_reference` SET TAGS ('pii_business_glossary_term' = 'Justification Document Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `supporting_schedule_analysis_reference` SET TAGS ('pii_business_glossary_term' = 'Supporting Schedule Analysis Reference');
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_impact_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
