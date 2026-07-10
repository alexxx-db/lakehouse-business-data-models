-- Schema for Domain: project | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`project` COMMENT 'Project management domain governing capital projects, engineering projects, plant construction, commissioning, and project-based manufacturing execution including WBS, milestones, resource allocation, and project cost tracking';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_header` (
    `project_header_id` BIGINT COMMENT 'Unique system-generated identifier for the project header record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Project execution location is tied to a specific customer site for safety, compliance, and resource planning.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi‑entity manufacturing groups consolidate project results by company code for regulatory and internal reporting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Project ownership & billing require linking each project to the customer account for financial reporting and contract management.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Project sponsor/primary contact is a customer contact; needed for stakeholder registers and communication plans.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee managing the project.',
    `parent_project_header_id` BIGINT COMMENT 'Self-referencing FK on project_header (parent_project_header_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Project profitability reporting is done per profit center; linking enables profit‑center based P&L statements.',
    `plan_id` BIGINT COMMENT 'Reference to the health and safety plan document.',
    `project_supply_plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Project Execution Dashboard requires the supply plan used to meet project material needs.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Project charter defines target product SKU for which the project delivers a new manufacturing line; essential for product‑specific reporting.',
    `automation_project_id` BIGINT COMMENT 'Foreign key linking to automation.automation_project. Business justification: Automation Implementation Tracking report requires linking each overall project to its specific automation project for budgeting and schedule alignment.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to date.',
    `actual_end_date` TIMESTAMP COMMENT 'Date when the project actually completed.',
    `actual_oee_percent` DECIMAL(18,2) COMMENT 'Measured OEE achieved.',
    `actual_start_date` TIMESTAMP COMMENT 'Date when the project actually started.',
    `actual_work_hours` DECIMAL(18,2) COMMENT 'Actual labor hours recorded.',
    `approval_date` DATE COMMENT 'Date when the project received formal approval.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the project.',
    `change_order_count` STRING COMMENT 'Total number of engineering change orders (ECO/ECN) associated.',
    `closeout_date` DATE COMMENT 'Date when the project was officially closed.',
    `completed_milestone_count` STRING COMMENT 'Number of milestones completed.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the project.. Valid values are `compliant|non_compliant|exempt`',
    `contract_number` STRING COMMENT 'Associated contract number for EPC or procurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was created.',
    `critical_path_duration_days` DECIMAL(18,2) COMMENT 'Duration of the projects critical path.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for budget and cost. [ENUM-REF-CANDIDATE: USD|EUR|JPY|GBP|CNY|CHF — promote to reference product]',
    `project_header_description` STRING COMMENT 'Detailed description of the projects scope and objectives.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Score assessing environmental impact per ISO 14001.',
    `expected_oee_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness for the project.',
    `external_project_code` STRING COMMENT 'Identifier used in external systems (e.g., ERP, PLM).',
    `funding_source` STRING COMMENT 'Source of funding for the project.. Valid values are `internal|external|joint_venture`',
    `governance_approval_status` STRING COMMENT 'Status of governance approval for the project.. Valid values are `pending|approved|rejected`',
    `is_template` BOOLEAN COMMENT 'Indicates whether this project record is a reusable template.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT 'Average lead time for critical materials in days.',
    `location` STRING COMMENT 'Primary geographic location of the project (city, site).',
    `milestone_count` STRING COMMENT 'Number of milestones defined for the project.',
    `notes` STRING COMMENT '',
    `planned_end_date` TIMESTAMP COMMENT 'Scheduled end date for the project.',
    `planned_start_date` TIMESTAMP COMMENT 'Scheduled start date for the project.',
    `priority` STRING COMMENT 'Priority level assigned to the project.. Valid values are `low|medium|high|critical`',
    `procurement_strategy` DECIMAL(18,2) COMMENT 'Strategy used for procuring materials.',
    `project_category` STRING COMMENT 'Broad category of the project.. Valid values are `capital|operational|research|maintenance`',
    `project_code` STRING COMMENT 'Unique business identifier or code for the project.',
    `project_header_status` STRING COMMENT 'Current lifecycle status of the project.. Valid values are `planned|active|on_hold|completed|cancelled`',
    `project_name` STRING COMMENT 'Descriptive name of the project.',
    `project_phase` STRING COMMENT 'Current phase of the project lifecycle.. Valid values are `initiation|planning|execution|monitoring|closure`',
    `project_type` STRING COMMENT 'Classification of the project type.. Valid values are `EPC|CapEx|NPI|MTO`',
    `record_status` STRING COMMENT '',
    `region_code` STRING COMMENT 'Internal region code for reporting.',
    `risk_level` STRING COMMENT 'Overall risk assessment of the project.. Valid values are `low|moderate|high|critical`',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents recorded for the project.',
    `sponsor_business_unit` STRING COMMENT 'Business unit that sponsors the project.',
    `total_work_hours` DECIMAL(18,2) COMMENT 'Total labor hours planned for the project.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    `wbs_code` STRING COMMENT 'Hierarchical code representing the projects WBS element.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_header PRIMARY KEY(`project_header_id`)
) COMMENT 'Master record for all capital projects, engineering projects, plant construction initiatives, and project-based manufacturing engagements. Serves as the SSOT for project identity, classification, lifecycle stage, budget baseline, schedule baseline, sponsoring business unit, project manager assignment, priority, and governance attributes. Covers EPC (Engineering, Procurement, Construction), CapEx, NPI, and MTO project types.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'System-generated unique identifier for the WBS element.',
    `capacity_plan_id` BIGINT COMMENT 'Foreign key linking to supply.capacity_plan. Business justification: Enables Capacity Utilization Report per WBS element, linking work center capacity to project breakdown.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WBS cost tracking requires cost‑center assignment for budgeting and reporting; cost_center_code is denormalized.',
    `employee_id` BIGINT COMMENT 'Identifier of the person accountable for delivering the WBS element.',
    `parent_wbs_element_id` BIGINT COMMENT 'Self-referencing FK on wbs_element (parent_wbs_element_id)',
    `parent_wbs_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent WBS element; null for top‑level elements.',
    `project_header_id` BIGINT COMMENT 'Identifier of the overarching project to which this WBS element belongs.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: WBS elements track material requirements; linking to SKU enables accurate material planning and cost allocation per product.',
    `account_assignment_category` STRING COMMENT 'Category used for financial posting (e.g., cost, revenue, internal order, asset).. Valid values are `cost|revenue|internal_order|asset`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Incurred cost amount recorded against the WBS element.',
    `actual_end_date` DATE COMMENT 'Date when work on the WBS element was completed.',
    `actual_start_date` DATE COMMENT 'Date when work on the WBS element actually commenced.',
    `billing_element_flag` BOOLEAN COMMENT 'True if the WBS element is billable to a customer or external party.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between planned and actual cost (planned_cost - actual_cost).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost amounts.. Valid values are `^[A-Z]{3}$`',
    `wbs_element_description` STRING COMMENT 'Full textual description of the WBS elements scope and purpose.',
    `is_billing_element` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `wbs_element_level` STRING COMMENT 'Numeric depth of the element within the WBS hierarchy (root = 1).',
    `milestone_flag` BOOLEAN COMMENT 'True if the element represents a project milestone.',
    `notes` STRING COMMENT '',
    `percent_complete` DECIMAL(18,2) COMMENT 'Progress of the WBS element expressed as a percentage (0‑100).',
    `planned_cost` DECIMAL(18,2) COMMENT 'Budgeted cost amount allocated to the WBS element.',
    `planned_end_date` TIMESTAMP COMMENT 'Scheduled finish date for the WBS element as per project plan.',
    `planned_start_date` TIMESTAMP COMMENT 'Scheduled start date for the WBS element as per project plan.',
    `record_status` STRING COMMENT '',
    `responsible_department_code` STRING COMMENT 'Organizational department that owns the WBS element.',
    `schedule_status` STRING COMMENT 'Current schedule performance relative to the baseline.. Valid values are `on_schedule|behind|ahead`',
    `short_description` STRING COMMENT 'Brief description (max 100 characters) for UI listings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the WBS element record.',
    `wbs_code` STRING COMMENT 'External business identifier for the WBS element, typically hierarchical (e.g., 1.2.3).',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `wbs_level` STRING COMMENT '',
    `wbs_name` STRING COMMENT '',
    `wbs_status` STRING COMMENT '',
    `wbs_type` STRING COMMENT 'Classification of the WBS element by business purpose.. Valid values are `internal|external|contract|support`',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element master record representing a discrete node in the hierarchical project decomposition tree. Captures WBS code, description, level, parent WBS reference, responsible cost center, billing element flag, account assignment category, planned cost, actual cost, and status. Aligns with SAP PS WBS element (PRPS) and PMI WBS standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'System-generated unique identifier for the project milestone.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Control System Commissioning Milestone ties a project milestone to the specific control system being commissioned, used in status dashboards.',
    `employee_id` BIGINT COMMENT 'Identifier of the party (person or organization) accountable for delivering the milestone.',
    `predecessor_milestone_id` BIGINT COMMENT 'Self-referencing FK on milestone (predecessor_milestone_id)',
    `project_header_id` BIGINT COMMENT 'Identifier of the parent project containing this milestone.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the Work Breakdown Structure element to which the milestone belongs.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to complete the milestone.',
    `actual_date` TIMESTAMP COMMENT 'Date when the milestone was actually completed.',
    `actual_duration_days` DECIMAL(18,2) COMMENT 'Actual number of calendar days taken to complete the milestone.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Planned cost budget allocated for the milestone.',
    `milestone_code` STRING COMMENT 'Business identifier or code assigned to the milestone (e.g., M-001, M-002).',
    `completion_criteria` STRING COMMENT 'Specific criteria that must be satisfied for the milestone to be considered complete.',
    `completion_percentage` DECIMAL(18,2) COMMENT '',
    `compliance_requirement` STRING COMMENT 'Regulatory or contractual requirement linked to the milestone.',
    `compliance_status` STRING COMMENT 'Current compliance status of the milestone against its requirement.. Valid values are `compliant|non_compliant|pending|exempt`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost center to which the milestone costs are charged.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual cost (budgeted_cost - actual_cost).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `milestone_description` STRING COMMENT 'Detailed description of the milestone scope and deliverables.',
    `forecast_date` DATE COMMENT 'Updated forecast date based on latest project outlook.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is classified as critical for project success.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `planned|in_progress|completed|delayed|cancelled`',
    `milestone_type` STRING COMMENT 'Category of the milestone indicating its purpose (e.g., contractual, internal, payment trigger).. Valid values are `contractual|internal|payment|regulatory|technical`',
    `milestone_name` STRING COMMENT 'Human‑readable name of the milestone.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by project team members.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the milestone payment trigger.',
    `payment_trigger` DECIMAL(18,2) COMMENT 'Indicates whether the milestone serves as a trigger for invoicing or payment.',
    `planned_date` TIMESTAMP COMMENT 'Scheduled date when the milestone is expected to be achieved.',
    `planned_duration_days` DECIMAL(18,2) COMMENT 'Planned number of calendar days allocated to complete the milestone.',
    `record_status` STRING COMMENT '',
    `responsible_party_role` STRING COMMENT 'Role of the responsible party with respect to the milestone.. Valid values are `project_manager|engineer|contractor|client`',
    `risk_description` STRING COMMENT 'Narrative description of risks associated with the milestone.',
    `risk_level` STRING COMMENT 'Qualitative risk rating assigned to the milestone.. Valid values are `low|medium|high`',
    `sequence` STRING COMMENT 'Ordinal position of the milestone within the project schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Project milestone master record defining key schedule gates, contractual delivery checkpoints, payment trigger events, and phase-completion criteria within a project or WBS element. Captures milestone name, type (contractual, internal, payment), planned date, forecast date, actual completion date, responsible party, completion criteria, and linked billing schedule reference.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`activity` (
    `activity_id` BIGINT COMMENT 'Unique surrogate key for the project activity record.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Device Installation Activity logs which physical device is being installed, needed for work order execution and traceability.',
    `predecessor_activity_id` BIGINT COMMENT 'Self-referencing FK on activity (predecessor_activity_id)',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: Activities such as build or test reference a specific product configuration; needed for configuration‑level progress and quality tracking.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: EXECUTION TRACKING: Links a project activity to the actual production work order that executes it, required for activity status and cost roll‑up.',
    `project_contract_id` BIGINT COMMENT 'Identifier of an external contract or subcontract linked to the activity.',
    `project_header_id` BIGINT COMMENT 'Identifier of the parent project to which this activity belongs.',
    `wbs_element_id` BIGINT COMMENT '',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: CAPACITY PLANNING: Project activities need a specific work center assignment for scheduling and capacity load reports.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the activity.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `activity_type` STRING COMMENT 'Classification of the activity (e.g., internal work, external subcontract, cost‑only, or milestone).. Valid values are `internal|external|cost|milestone`',
    `actual_duration_days` DECIMAL(18,2) COMMENT '',
    `actual_finish_date` TIMESTAMP COMMENT '',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Timestamp when work on the activity actually finished.',
    `actual_start_date` TIMESTAMP COMMENT '',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when work on the activity actually began.',
    `activity_code` STRING COMMENT 'Business identifier for the activity, used in schedules and reports.. Valid values are `^ACT-[0-9]{5}$`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center responsible for the activitys expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `activity_description` STRING COMMENT 'Detailed description of the work to be performed.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Planned duration of the activity expressed in hours.',
    `earned_value_acwp` DECIMAL(18,2) COMMENT 'Actual cost incurred for the work performed on the activity.',
    `earned_value_bcwp` DECIMAL(18,2) COMMENT 'Value of work actually performed, expressed as budgeted cost.',
    `earned_value_bcws` DECIMAL(18,2) COMMENT 'Planned cost of work scheduled for the activity (Earned Value Management).',
    `equipment_cost_actual` DECIMAL(18,2) COMMENT 'Actual cost incurred for equipment during the activity.',
    `equipment_cost_estimated` DECIMAL(18,2) COMMENT 'Planned cost of equipment usage for the activity.',
    `float_days` DECIMAL(18,2) COMMENT 'Available scheduling float for the activity in days.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether the activity lies on the project critical path.',
    `is_on_critical_path` BOOLEAN COMMENT '',
    `labor_hours_actual` DECIMAL(18,2) COMMENT 'Labor hours actually recorded for the activity.',
    `labor_hours_estimated` DECIMAL(18,2) COMMENT 'Planned labor effort for the activity in hours.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `material_cost_actual` DECIMAL(18,2) COMMENT 'Actual cost of materials consumed by the activity.',
    `material_cost_estimated` DECIMAL(18,2) COMMENT 'Planned cost of materials required for the activity.',
    `milestone_flag` BOOLEAN COMMENT 'True if the activity represents a project milestone.',
    `activity_name` STRING COMMENT 'Human‑readable name or title of the activity.',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by planners.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current progress of the activity expressed as a percentage.',
    `planned_duration_days` DECIMAL(18,2) COMMENT '',
    `planned_finish_date` TIMESTAMP COMMENT 'Planned calendar date for activity completion.',
    `planned_start_date` TIMESTAMP COMMENT 'Planned calendar date for activity start.',
    `predecessor_activity_ids` STRING COMMENT 'Comma‑separated list of activity IDs that must finish before this activity can start.',
    `record_status` STRING COMMENT '',
    `resource_requirements` STRING COMMENT 'Free‑text description of labor, material, and equipment needed.',
    `successor_activity_ids` STRING COMMENT 'Comma‑separated list of activity IDs that follow this activity in the schedule.',
    `total_cost_estimated` DECIMAL(18,2) COMMENT 'Sum of estimated labor, material, and equipment costs for the activity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the activity record.',
    `wbs_element` STRING COMMENT 'Identifier of the WBS element to which the activity belongs.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_activity PRIMARY KEY(`activity_id`)
) COMMENT 'Granular project activity (network activity) record representing a discrete work package or task within the project schedule network. Captures activity ID, description, activity type (internal, external, cost), work center assignment, planned start/finish, actual start/finish, duration, float, predecessor/successor relationships, resource requirements, and earned value data (BCWS, BCWP, ACWP).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record.',
    `cost_center_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for the budget.',
    `planning_parameter_id` BIGINT COMMENT 'Foreign key linking to supply.planning_parameter. Business justification: Aligns budgeting assumptions with supply planning parameters for accurate project budgeting.',
    `primary_project_employee_id` BIGINT COMMENT 'Identifier of the user who created the budget record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Budget allocations are often planned per product family to align financial planning with product strategy.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this budget belongs.',
    `transferred_from_project_budget_id` BIGINT COMMENT 'Self-referencing FK on project_budget (transferred_from_project_budget_id)',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element associated with this budget line.',
    `allocation_method` STRING COMMENT 'Method used to allocate the budget (manual, automatic, roll‑up).. Valid values are `manual|automatic|rollup`',
    `approval_date` DATE COMMENT 'Date on which the budget was formally approved.',
    `budget_amount` DECIMAL(18,2) COMMENT '',
    `budget_category` STRING COMMENT 'High‑level classification of the budget (e.g., capital project, maintenance, R&D).',
    `budget_number` DECIMAL(18,2) COMMENT 'External budget number or code used for reference in financial systems.',
    `budget_source` DECIMAL(18,2) COMMENT 'Origin of the budget funds.',
    `budget_status` STRING COMMENT '',
    `budget_type` DECIMAL(18,2) COMMENT 'Classification of the budget as Capital Expenditure, Operational Expenditure, or mixed.',
    `budget_version` STRING COMMENT '',
    `change_reason` STRING COMMENT 'Reason or justification for the latest budget change.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Portion of the budget that has been committed to purchase orders or contracts.',
    `cost_element_code` DECIMAL(18,2) COMMENT 'Code representing the cost element (e.g., labor, material, overhead).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the budget amounts.. Valid values are `^[A-Z]{3}$`',
    `project_budget_description` DECIMAL(18,2) COMMENT 'Free‑text description of the budget line purpose or scope.',
    `effective_end_date` DATE COMMENT 'Date when the budget expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the budget becomes effective for spending.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the budget applies.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the budget is locked from further changes.',
    `last_approval_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent budget approval action.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Approved original budget amount at the time of creation.',
    `owner_role` STRING COMMENT 'Role or title of the budget owner (e.g., Project Manager, Finance Lead).',
    `project_budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget.',
    `record_status` STRING COMMENT '',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Budget amount still available after commitments and spend.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'Budget amount after approved revisions or supplements.',
    `spent_amount` DECIMAL(18,2) COMMENT 'Actual expenditures recorded against the budget.',
    `transferred_in_amount` DECIMAL(18,2) COMMENT 'Amount transferred into this budget from other budgets.',
    `transferred_out_amount` DECIMAL(18,2) COMMENT 'Amount transferred out of this budget to other budgets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    `version` STRING COMMENT 'Version identifier for the budget (e.g., initial, revised).',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Project budget record capturing the approved cost baseline for a project or WBS element by cost element, fiscal year, and budget version. Tracks original budget, approved supplements, transfers, returns, current budget, and commitment values. Supports CapEx/OpEx split, budget availability control, and multi-year capital planning. Aligns with SAP PS budget management (BPGE/BPJA).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` (
    `cost_actual_id` BIGINT COMMENT 'System-generated unique identifier for each actual cost posting record.',
    `activity_id` BIGINT COMMENT 'Identifier of the specific project activity or task associated with the cost.',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Applying cost‑allocation rules to actual project cost lines is required for internal cost distribution reporting.',
    `cost_center_id` BIGINT COMMENT 'Surrogate key of the cost center entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Actual project cost lines must be posted to GL accounts for statutory financial statements and audit trails.',
    `employee_id` BIGINT COMMENT 'System user who created the cost line record.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this cost line belongs.',
    `resource_assignment_id` BIGINT COMMENT 'Identifier of the material, labor, or service resource charged.',
    `reversal_cost_actual_id` BIGINT COMMENT 'Self-referencing FK on cost_actual (reversal_cost_actual_id)',
    `tertiary_cost_posting_user_employee_id` BIGINT COMMENT 'User who performed the cost posting operation.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element charged with this cost.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value posted in the transaction currency.',
    `amount_controlling_currency` DECIMAL(18,2) COMMENT 'Posted amount converted to the company’s controlling currency.',
    `approval_status` STRING COMMENT 'Current approval state of the cost line.. Valid values are `approved|rejected|awaiting`',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to the detailed audit trail for this cost line.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned amount for this cost line according to the budget.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the cost allocated to this line based on the rule.',
    `cost_allocation_rule` DECIMAL(18,2) COMMENT 'Name or code of the rule used to allocate overhead or indirect costs.',
    `cost_category` DECIMAL(18,2) COMMENT 'High‑level classification of the cost (direct, indirect, etc.).',
    `cost_element` DECIMAL(18,2) COMMENT '',
    `cost_element_code` DECIMAL(18,2) COMMENT 'Code representing the type of cost (e.g., labor, material, overhead).',
    `cost_type` DECIMAL(18,2) COMMENT 'Classification of the cost (e.g., labor, material, service).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cost line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the posting currency.. Valid values are `USD|EUR|GBP|JPY|CNY|CHF`',
    `cost_actual_description` DECIMAL(18,2) COMMENT 'Free‑text description or notes for the cost line.',
    `document_number` STRING COMMENT 'Reference number of the source document (e.g., invoice, goods receipt).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert posting currency to controlling currency.',
    `external_reference` STRING COMMENT 'Reference to an external document or system (e.g., vendor invoice).',
    `fiscal_period` STRING COMMENT 'Fiscal quarter of the posting.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the cost was posted.',
    `internal_order_number` STRING COMMENT 'Internal order identifier linked to the cost posting.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether the cost line was part of the approved budget.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the cost line was entered manually rather than via interface.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the posting document.',
    `notes` STRING COMMENT '',
    `overhead_allocation_flag` BOOLEAN COMMENT 'Indicates whether the cost line includes overhead allocation.',
    `posting_date` TIMESTAMP COMMENT 'Calendar date on which the cost was posted.',
    `posting_status` STRING COMMENT 'Current processing status of the cost line.. Valid values are `posted|pending|reversed|rejected`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the cost posting was recorded.',
    `project_phase` STRING COMMENT 'Lifecycle phase of the project when the cost was incurred.. Valid values are `initiation|planning|execution|monitoring|closing`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the resource consumed (e.g., hours, units, kilograms).',
    `record_status` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the posted amount, if applicable.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., EA, KG, HOUR).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual amount and budgeted amount.',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance relative to the budgeted amount.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_cost_actual PRIMARY KEY(`cost_actual_id`)
) COMMENT 'Actual cost posting record capturing all cost transactions charged to a WBS element or project activity, including labor confirmations, material goods issues, purchase order commitments, service entry sheet postings, and overhead allocations. Captures cost element, cost center origin, posting date, document reference, quantity, and amount in project and controlling currency.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`commitment` (
    `commitment_id` BIGINT COMMENT 'Unique system-generated identifier for the project commitment record.',
    `activity_id` BIGINT COMMENT 'Identifier of the specific project activity or task the commitment funds.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Procurement commitments are booked against internal orders to control budget and cost allocation.',
    `originating_commitment_id` BIGINT COMMENT 'Self-referencing FK on commitment (originating_commitment_id)',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Project commitments (fund reservations) are tied to procurement contracts; the FK enables commitment‑to‑contract reconciliation.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which the commitment belongs.',
    `purchase_order_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or supplier associated with the commitment.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element linked to the commitment.',
    `actual_delivery_date` DATE COMMENT 'Date when the goods or services were actually delivered.',
    `actual_spent_amount` DECIMAL(18,2) COMMENT 'Actual monetary amount spent against the commitment.',
    `approval_status` STRING COMMENT 'Current approval state of the commitment.. Valid values are `approved|rejected|pending`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the commitment was approved.',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'Planned monetary amount allocated for the commitment.',
    `commitment_date` TIMESTAMP COMMENT 'Date and time when the commitment was recorded or became effective.',
    `commitment_number` STRING COMMENT 'External reference number assigned to the commitment by the source system.',
    `commitment_status` STRING COMMENT 'Current lifecycle state of the commitment.. Valid values are `open|closed|pending|cancelled`',
    `commitment_type` STRING COMMENT 'Indicates the origin of the commitment such as purchase order, requisition, or fund reservation.. Valid values are `purchase_order|requisition|fund_reservation`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the commitment before taxes or adjustments.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services committed.',
    `consumed_amount` DECIMAL(18,2) COMMENT '',
    `cost_element_code` DECIMAL(18,2) COMMENT 'Accounting cost element code used for budgeting and expense tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.. Valid values are `^[A-Z]{3}$`',
    `commitment_description` STRING COMMENT 'Free‑form description of the commitment purpose or details.',
    `expected_delivery_date` DATE COMMENT 'Planned date for delivery of the committed goods or services.',
    `is_funds_reserved` BOOLEAN COMMENT 'Indicates whether funds have been reserved for this commitment.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `net_committed_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and adjustments.',
    `notes` STRING COMMENT 'Supplementary remarks or comments related to the commitment.',
    `open_amount` DECIMAL(18,2) COMMENT '',
    `record_status` STRING COMMENT '',
    `reservation_number` BIGINT COMMENT 'Identifier of the fund reservation record linked to the commitment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the committed amount.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the committed quantity (e.g., EA, KG, L).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the commitment record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spent amounts.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_commitment PRIMARY KEY(`commitment_id`)
) COMMENT 'Open commitment record tracking purchase order commitments, purchase requisition commitments, and funds reservations against WBS elements and project activities. Captures commitment type, originating document, vendor, cost element, committed quantity, committed value, expected delivery date, and open/closed status. Critical for budget availability control and cash flow forecasting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`plan_version` (
    `plan_version_id` BIGINT COMMENT 'Unique surrogate key for each version of a project plan.',
    `baseline_plan_version_id` BIGINT COMMENT 'Self-referencing FK on plan_version (baseline_plan_version_id)',
    `project_header_id` BIGINT COMMENT 'Identifier of the parent project to which this plan version belongs.',
    `approval_date` DATE COMMENT 'Date on which the version received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the version after review by governance.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the version.',
    `baseline_indicator` BOOLEAN COMMENT 'Flag indicating whether this version is the active baseline for earned‑value management.',
    `change_control_number` STRING COMMENT 'Reference to the engineering change order or change request that triggered this version.',
    `compliance_status` STRING COMMENT 'Indicates whether the version complies with relevant regulatory and internal standards.. Valid values are `compliant|non-compliant|pending`',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Difference between total planned cost and actual cost incurred to date.',
    `created_by_department` STRING COMMENT 'Organizational department responsible for creating the version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the version record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the cost fields.',
    `plan_version_description` STRING COMMENT 'Free‑form textual description of the purpose or scope of this version.',
    `effective_date` TIMESTAMP COMMENT '',
    `effective_end_date` DATE COMMENT 'Date on which this version ceases to be operative (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which this version becomes the operative baseline.',
    `freeze_date` DATE COMMENT 'Date on which the plan version was frozen and became immutable for reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the version is currently active for reporting.',
    `is_baseline` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_by` STRING COMMENT 'Identifier of the reviewer who performed the latest review.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent formal review of the version.',
    `milestone_count` STRING COMMENT 'Number of defined milestones captured in this version of the plan.',
    `notes` STRING COMMENT '',
    `plan_version_status` STRING COMMENT 'Lifecycle status of the version record.. Valid values are `draft|active|archived`',
    `planned_duration_days` DECIMAL(18,2) COMMENT 'Planned overall duration of the project plan version expressed in calendar days.',
    `record_status` STRING COMMENT '',
    `risk_level` STRING COMMENT 'Overall risk classification assigned to this version during planning.. Valid values are `low|medium|high`',
    `schedule_variance_days` STRING COMMENT 'Difference in days between planned schedule and actual schedule at the time of snapshot.',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Aggregated cost budget for the entire project plan version, expressed in the selected currency.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the version record.',
    `version_code` STRING COMMENT '',
    `version_comment` STRING COMMENT 'Additional comments or notes entered by the planner during version creation.',
    `version_name` STRING COMMENT '',
    `version_number` STRING COMMENT 'Sequential integer indicating the version order of the project plan.',
    `version_status` STRING COMMENT '',
    `version_type` STRING COMMENT 'Indicates whether the version is the original baseline, a re-baseline, or a what‑if scenario.. Valid values are `original|rebaseline|what-if`',
    `wbs_code` STRING COMMENT 'Hierarchical code representing the WBS element associated with this version.',
    `created_by` STRING COMMENT 'User or system identifier that created the version record.',
    CONSTRAINT pk_plan_version PRIMARY KEY(`plan_version_id`)
) COMMENT 'Versioned project plan snapshot record capturing the full schedule and cost plan baseline at a specific point in time. Supports baseline management (original baseline, re-baseline, what-if scenarios), earned value management (EVM) reference, and schedule variance tracking. Captures version number, version type, freeze date, total planned cost, planned duration, and approval status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` (
    `resource_assignment_id` BIGINT COMMENT 'Unique surrogate key for each resource assignment record.',
    `activity_id` BIGINT COMMENT 'Unique identifier of the project activity or WBS element to which the resource is assigned.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the assigned resource (personnel, equipment, or contractor).',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where the resource performs the work.',
    `project_header_id` BIGINT COMMENT '',
    `replaced_resource_assignment_id` BIGINT COMMENT 'Self-referencing FK on resource_assignment (replaced_resource_assignment_id)',
    `wbs_element_id` BIGINT COMMENT '',
    `actual_hours` DECIMAL(18,2) COMMENT 'Number of work hours actually logged for the assignment.',
    `allocation_percent` DECIMAL(18,2) COMMENT '',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager who approved the assignment.',
    `assignment_role` STRING COMMENT 'Role performed by the resource on the activity (e.g., Engineer, Technician).. Valid values are `engineer|technician|foreman|contractor|manager`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `assignment_type` STRING COMMENT 'Indicates whether the resource is internal staff or external contractor.. Valid values are `internal|external`',
    `billing_rate_type` DECIMAL(18,2) COMMENT 'Type of billing rate applied to the assignment.',
    `billing_status` STRING COMMENT 'Indicates whether the assignment is billable to a customer.. Valid values are `billable|non_billable|pending`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost center to which the assignment cost is charged.',
    `cost_rate` DECIMAL(18,2) COMMENT '',
    `cost_rate_amount` DECIMAL(18,2) COMMENT 'Monetary rate (per hour or per unit) charged for the resource.',
    `cost_rate_currency` DECIMAL(18,2) COMMENT 'Currency of the cost rate applied to the resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created.',
    `department_code` STRING COMMENT 'Code of the department responsible for the resource.',
    `effective_from` DATE COMMENT 'Date when the assignment becomes effective.',
    `effective_until` DATE COMMENT 'Date when the assignment ends or expires (null if open‑ended).',
    `end_date` TIMESTAMP COMMENT '',
    `is_overtime` BOOLEAN COMMENT 'Flag indicating whether the assignment includes overtime work.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the assignment.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours logged for the assignment.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Number of work hours originally planned for the assignment.',
    `priority_level` STRING COMMENT 'Business priority assigned to the resource assignment.. Valid values are `low|medium|high|critical`',
    `record_status` STRING COMMENT 'Logical status of the record for soft‑delete handling.',
    `resource_utilization_category` STRING COMMENT 'Classification of the resources employment type for utilization reporting.. Valid values are `full_time|part_time|temp|contract`',
    `role` STRING COMMENT '',
    `shift_code` STRING COMMENT 'Code representing the work shift for the assignment.. Valid values are `day|night|swing`',
    `skill_level` STRING COMMENT 'Declared skill proficiency of the resource for the assigned role.. Valid values are `beginner|intermediate|advanced|expert`',
    `start_date` TIMESTAMP COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assignment record.',
    `utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of the resources available capacity consumed by this assignment.',
    `version_number` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_resource_assignment PRIMARY KEY(`resource_assignment_id`)
) COMMENT 'Project resource assignment record linking workforce personnel, work centers, equipment, or external contractors to specific project activities or WBS elements. Captures resource type, assigned resource identity, planned hours/quantity, actual hours/quantity, assignment period, role, skill requirement, utilization percentage, and cost rate applied.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` (
    `procurement_item_id` BIGINT COMMENT 'System-generated unique identifier for the procurement line item within a project.',
    `blanket_procurement_item_id` BIGINT COMMENT 'Self-referencing FK on procurement_item (blanket_procurement_item_id)',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Needed for Project Procurement Tracking report, showing which planned order fulfills each procurement item.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the parent procurement transaction header that groups line items for the same purchase request.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Project procurement items originate from a purchase requisition; linking enables traceability from project spend back to the original requisition.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Project procurement items are fulfilled by purchase orders; the FK allows project cost roll‑up and PO status monitoring.',
    `procurement_purchase_requisition_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Procurement items belong to a specific project; linking enables aggregation, reporting and eliminates the need for any ad‑hoc project identifiers stored elsewhere.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Procurement lines must be tied to a definitive SKU for inventory, cost, and compliance tracking; replaces denormalized material_number.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the external supplier providing the item.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: The string column wbs_element_code is a duplicate of the WBS element identifier; adding a proper foreign key to wbs_element provides full hierarchy access and removes the redundant code column.',
    `actual_cost` DECIMAL(18,2) COMMENT '',
    `actual_lead_time_days` STRING COMMENT 'Observed number of days between order and receipt.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the procurement line.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `compliance_status` STRING COMMENT 'Indicates whether the procurement complies with internal and external regulations.. Valid values are `compliant|non_compliant|exempt|pending`',
    `contract_number` STRING COMMENT 'Reference to a master contract or agreement governing the purchase.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Financial cost center responsible for the expense of this procurement item.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the line record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `delivery_date` DATE COMMENT 'Date the supplier is expected to deliver the item.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discounts granted on the line item.',
    `estimated_cost` DECIMAL(18,2) COMMENT '',
    `expected_lead_time_days` STRING COMMENT 'Planned number of days between order and delivery.',
    `invoice_date` DATE COMMENT 'Date the supplier issued the invoice.',
    `invoice_number` STRING COMMENT 'Supplier invoice identifier for this line item.',
    `invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `pending|approved|rejected|paid|cancelled`',
    `is_invoiced` BOOLEAN COMMENT 'True when an invoice has been recorded for the line.',
    `is_received` BOOLEAN COMMENT 'Indicates whether the goods have been received (true) or not (false).',
    `item_description` STRING COMMENT 'Free‑text description of the material, service, or equipment being procured.',
    `item_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Overall state of the procurement line from creation to closure.. Valid values are `planned|released|ordered|received|invoiced|closed`',
    `line_quantity` DECIMAL(18,2) COMMENT 'Requested quantity of the item in the unit of measure.',
    `line_sequence` STRING COMMENT 'Sequential order of the line item within the procurement header.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and discount (total_price + tax_amount - discount_amount).',
    `notes` STRING COMMENT '',
    `payment_due_date` TIMESTAMP COMMENT 'Date by which payment must be made to the vendor.',
    `payment_status` DECIMAL(18,2) COMMENT 'Payment settlement status for the invoice.',
    `procurement_category` STRING COMMENT 'Classification of the spend type for reporting and compliance.. Valid values are `capital|services|materials|equipment|software|other`',
    `procurement_method` STRING COMMENT 'Method used to acquire the item, e.g., internal requisition or external purchase.. Valid values are `internal|external|direct|indirect`',
    `quantity` DECIMAL(18,2) COMMENT '',
    `receipt_date` DATE COMMENT 'Date the item was actually received on site.',
    `receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item actually received.',
    `record_status` STRING COMMENT '',
    `remarks` STRING COMMENT 'Free‑form notes or comments entered by users.',
    `required_date` TIMESTAMP COMMENT '',
    `risk_rating` STRING COMMENT 'Risk assessment of the procurement item (e.g., supplier risk, safety risk).. Valid values are `low|medium|high|critical`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the line item.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or rate code applied to the line.',
    `total_price` DECIMAL(18,2) COMMENT 'Line quantity multiplied by unit price (gross amount).',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity (e.g., EA, KG, L).',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the item before taxes and discounts.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_procurement_item PRIMARY KEY(`procurement_item_id`)
) COMMENT 'Project-specific procurement item record tracking purchase requisitions and purchase orders raised against WBS elements for capital equipment, construction services, and engineering materials. Captures item description, vendor, quantity, unit price, total value, delivery date, WBS assignment, goods receipt status, and invoice verification status. Bridges project management and procurement domains.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` (
    `project_status_event_id` BIGINT COMMENT 'Surrogate primary key for each immutable project status event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who triggered the status change.',
    `preceding_project_status_event_id` BIGINT COMMENT 'Self-referencing FK on project_status_event (preceding_project_status_event_id)',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this status event belongs.',
    `approval_document_reference` STRING COMMENT 'Reference (e.g., document number or URL) to the approval document associated with the event, if applicable.',
    `comments` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `event_comment` STRING COMMENT 'Additional notes or comments captured at the time of the event.',
    `event_reason` STRING COMMENT 'Free‑text reason explaining why the status change was made.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the status event occurred.',
    `event_type` STRING COMMENT 'Category of the event indicating the nature of the status transition or related action.. Valid values are `status_change|approval|milestone|cancellation`',
    `is_audit_trail` BOOLEAN COMMENT 'Flag indicating whether this record is part of the compliance audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `new_status` STRING COMMENT 'Project status value after this event was applied.',
    `notes` STRING COMMENT '',
    `previous_status` STRING COMMENT 'Project status value before this event was applied.',
    `reason_code` STRING COMMENT '',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was first inserted into the lakehouse.',
    `record_source_system` STRING COMMENT 'Name of the source system (e.g., SAP S/4HANA, Siemens Opcenter) that generated the event.',
    `record_status` STRING COMMENT '',
    `source_system_event_code` STRING COMMENT 'Original identifier of the event in the source system.',
    `triggered_by_user_name` STRING COMMENT 'Display name of the user who triggered the event.',
    `changed_by` STRING COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_status_event PRIMARY KEY(`project_status_event_id`)
) COMMENT 'Immutable event log capturing every status transition and lifecycle milestone in the project lifecycle including project creation, approval, release, execution start, suspension, completion, settlement, and closure. Captures event type, previous status, new status, event timestamp, triggered by user, and associated approval document reference. Supports project governance audit trail.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`issue` (
    `issue_id` BIGINT COMMENT 'System-generated unique identifier for the project issue record.',
    `alarm_event_id` BIGINT COMMENT 'Foreign key linking to automation.alarm_event. Business justification: Issue Management process records the originating alarm event to support root‑cause analysis and compliance reporting.',
    `employee_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT '',
    `issue_related_project_project_header_id` BIGINT COMMENT 'Identifier of the project to which this issue belongs.',
    `parent_issue_id` BIGINT COMMENT 'Self-referencing FK on issue (parent_issue_id)',
    `primary_issue_employee_id` BIGINT COMMENT 'Person or role accountable for resolving the issue.',
    `wbs_element_id` BIGINT COMMENT 'WBS code linking the issue to a specific work package.',
    `action_items` STRING COMMENT 'List of concrete actions assigned to resolve the issue.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Real cost incurred after issue resolution.',
    `actual_resolution_date` DATE COMMENT 'Date the issue was actually closed or resolved.',
    `issue_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `issue_description` STRING COMMENT 'Detailed narrative of the problem, risk, or change request.',
    `escalation_status` STRING COMMENT 'Indicates whether the issue has been escalated for higher‑level attention.. Valid values are `none|escalated|pending_review`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected financial impact if the issue materializes.',
    `identified_timestamp` TIMESTAMP COMMENT 'Exact time the issue was first recorded in the system.',
    `impact` STRING COMMENT 'Potential effect on schedule, cost, or scope if the issue materializes.. Valid values are `low|medium|high|critical`',
    `issue_number` BOOLEAN COMMENT 'Human‑readable unique code assigned to the issue for tracking across systems.',
    `issue_status` STRING COMMENT 'Current state of the issue within its lifecycle.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `issue_type` STRING COMMENT 'Category describing the nature of the record.. Valid values are `risk|issue|change_request|blocker`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `mitigation_plan` STRING COMMENT 'Planned actions to reduce probability or impact.',
    `notes` STRING COMMENT '',
    `priority` STRING COMMENT 'Combined assessment of severity, probability, and impact used for triage.. Valid values are `low|medium|high|critical`',
    `probability_percent` DECIMAL(18,2) COMMENT 'Likelihood of the issue occurring, expressed as a percentage.',
    `raised_date` TIMESTAMP COMMENT '',
    `record_status` STRING COMMENT '',
    `resolution` STRING COMMENT '',
    `resolved_date` TIMESTAMP COMMENT '',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite numeric score derived from severity, probability, and impact.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the issue.',
    `severity` STRING COMMENT 'Impact severity rating assigned by the project team.. Valid values are `low|medium|high|critical`',
    `target_resolution_date` TIMESTAMP COMMENT 'Planned date by which the issue should be closed.',
    `title` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_issue PRIMARY KEY(`issue_id`)
) COMMENT 'Project issue and risk register record capturing identified risks, open issues, blockers, and action items that threaten project schedule, cost, or scope. Captures issue type (risk, issue, change request, blocker), severity, probability, impact, owner, mitigation plan, target resolution date, actual resolution date, and escalation status. Supports PMO governance and project health reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` (
    `project_change_request_id` BIGINT COMMENT 'System-generated unique identifier for the project change request record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who originated the change request.',
    `project_header_id` BIGINT COMMENT 'Identifier of the parent project to which the change request belongs.',
    `project_requested_by_employee_id` BIGINT COMMENT '',
    `superseded_project_change_request_id` BIGINT COMMENT 'Self-referencing FK on project_change_request (superseded_project_change_request_id)',
    `tertiary_project_created_by_employee_id` BIGINT COMMENT 'Identifier of the employee who initially created the change request record.',
    `wbs_element_id` BIGINT COMMENT 'Work‑breakdown‑structure element that will be affected by the change.',
    `approval_date` TIMESTAMP COMMENT '',
    `approval_status` STRING COMMENT 'Current approval outcome of the change request.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the change request was approved or rejected.',
    `change_description` STRING COMMENT '',
    `change_reason` STRING COMMENT 'Root cause or business driver prompting the change request.',
    `change_request_number` STRING COMMENT 'Human‑readable reference number assigned to the change request, used in communications and tracking.',
    `change_status` STRING COMMENT '',
    `change_title` STRING COMMENT '',
    `change_type` STRING COMMENT 'Category of the change request indicating what aspect of the project is affected.. Valid values are `scope|schedule|cost|technical|other`',
    `compliance_requirements` STRING COMMENT 'List of regulatory or internal compliance items impacted by the change.',
    `cost_delta_amount` DECIMAL(18,2) COMMENT 'Net change in project budget resulting from the request (positive for increase, negative for decrease).',
    `cost_delta_currency` DECIMAL(18,2) COMMENT 'Three‑letter ISO 4217 currency code for the cost delta. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|CAD|AUD|NZD|SEK|NOK|DKK|ZAR|INR|BRL — promote to reference product]',
    `cost_impact_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the change request record was first created in the system.',
    `currency_code` STRING COMMENT '',
    `project_change_request_description` STRING COMMENT 'Detailed narrative of the requested change, including rationale and scope.',
    `impact_assessment` STRING COMMENT 'Qualitative and quantitative analysis of how the change will affect cost, schedule, scope, and risk.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the change request is deemed critical to project success.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `priority` STRING COMMENT 'Business‑defined urgency level for processing the change request.. Valid values are `low|medium|high|critical`',
    `project_change_request_status` STRING COMMENT 'Current workflow state of the change request.. Valid values are `draft|submitted|approved|rejected|implemented|closed`',
    `record_status` STRING COMMENT '',
    `regulatory_impact` STRING COMMENT 'Description of how the change affects regulatory reporting or certifications.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the change request was formally submitted.',
    `requested_date` TIMESTAMP COMMENT '',
    `revised_baseline_reference` STRING COMMENT 'Identifier of the new project baseline version that incorporates this change.',
    `risk_level` STRING COMMENT 'Assessed risk impact of the change on project objectives.. Valid values are `low|medium|high`',
    `schedule_delta_days` STRING COMMENT 'Planned change in project duration expressed in calendar days (positive for extension, negative for compression).',
    `schedule_impact_days` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the change request record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_change_request PRIMARY KEY(`project_change_request_id`)
) COMMENT 'Project change request (PCR) record governing scope changes, schedule changes, and budget amendments to an approved project baseline. Captures change request number, description, change type (scope, schedule, cost, technical), impact assessment, requested by, approval workflow status, approved/rejected date, cost delta, schedule delta, and revised baseline reference.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique surrogate key for each timesheet entry.',
    `activity_id` BIGINT COMMENT '',
    `corrected_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (corrected_timesheet_id)',
    `location_id` BIGINT COMMENT 'Identifier of the plant or site where work was performed.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the entry.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which the labor is allocated.',
    `tertiary_timesheet_entered_by_employee_id` BIGINT COMMENT 'Identifier of the user who entered the timesheet data.',
    `timesheet_employee_id` BIGINT COMMENT '',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the Work Breakdown Structure element the labor is charged to.',
    `activity_description` STRING COMMENT 'Free‑text description of the work performed.',
    `activity_type` STRING COMMENT 'Category of work performed for the timesheet entry. [ENUM-REF-CANDIDATE: design|assembly|testing|maintenance|inspection|setup|other — 7 candidates stripped; promote to reference product]',
    `approval_status` STRING COMMENT 'Current approval state of the timesheet line.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the entry was approved.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit log entry for this record.',
    `batch_reference` BIGINT COMMENT 'Identifier of the timesheet batch or header that groups related line entries.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the labor entry is billable to the customer.',
    `compliance_code` STRING COMMENT 'Code referencing the specific compliance requirement (e.g., ISO45001).',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the labor entry is subject to regulatory compliance tracking.',
    `cost_amount` DECIMAL(18,2) COMMENT '',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost‑center code for financial allocation.',
    `cost_rate` DECIMAL(18,2) COMMENT 'Hourly billing or cost rate applicable to the employee for this activity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the timesheet line was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Organizational department responsible for the labor.',
    `entry_timestamp` TIMESTAMP COMMENT 'Date‑time when the line was entered into the system.',
    `expense_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the expense component.',
    `expense_currency_code` STRING COMMENT 'Currency of the expense amount.. Valid values are `^[A-Z]{3}$`',
    `expense_flag` BOOLEAN COMMENT 'Indicates if the entry includes a reimbursable expense.',
    `expense_type` STRING COMMENT 'Category of the expense, if expense_flag is true.. Valid values are `travel|material|tool|other`',
    `external_reference` STRING COMMENT 'Identifier from an external timesheet or payroll system.',
    `hourly_rate` DECIMAL(18,2) COMMENT '',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total regular labor hours recorded for the activity.',
    `is_deleted` BOOLEAN COMMENT 'Soft‑delete flag indicating logical removal.',
    `labor_category` STRING COMMENT 'Classification of labor for costing and compliance purposes.. Valid values are `regular|overtime|holiday|sick|training|other`',
    `labor_grade` STRING COMMENT 'Skill or pay grade of the labor resource.. Valid values are `A|B|C|D|E|F`',
    `labor_rate_type` DECIMAL(18,2) COMMENT 'Classification of the rate applied to the labor.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the timesheet batch.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Additional hours worked beyond regular schedule, if any.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to cost_rate for overtime hours.',
    `record_status` STRING COMMENT 'Current lifecycle status of the timesheet line.. Valid values are `active|inactive|deleted`',
    `shift_code` STRING COMMENT 'Work shift during which the labor was performed.. Valid values are `day|night|swing|custom`',
    `source_system_record_code` STRING COMMENT 'Native identifier of the record in the source system.',
    `total_cost` DECIMAL(18,2) COMMENT 'Calculated cost = (hours_worked + overtime_hours) * cost_rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    `version_number` STRING COMMENT 'Optimistic lock version for concurrency control.',
    `work_date` TIMESTAMP COMMENT 'Calendar date on which the labor was performed.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Project labor time recording document capturing hours worked by employees and contractors against specific WBS elements and project activities. Captures employee/contractor identity, work date, WBS element, activity type, hours worked, activity description, approval status, and cost rate. Feeds actual labor cost postings to project cost accounting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` (
    `commissioning_checklist_id` BIGINT COMMENT 'Unique surrogate key for the commissioning checklist record.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Commissioning Checklist must reference the exact device being commissioned to verify configuration and safety sign‑offs.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the specific equipment or asset being commissioned.',
    `parent_commissioning_checklist_id` BIGINT COMMENT 'Self-referencing FK on commissioning_checklist (parent_commissioning_checklist_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer accountable for completing the checklist.',
    `project_header_id` BIGINT COMMENT 'Reference to the capital or engineering project associated with the checklist.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external vendor, if applicable.',
    `wbs_element_id` BIGINT COMMENT '',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Measured effort duration from actual start to actual end.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Timestamp when work on the checklist actually finished.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Timestamp when work on the checklist actually began.',
    `approval_status` STRING COMMENT 'Current approval state of the checklist after review.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist received formal approval.',
    `change_order_reference` STRING COMMENT 'Reference to any engineering change order that impacts the checklist.',
    `checklist_name` STRING COMMENT '',
    `checklist_number` STRING COMMENT 'Human‑readable identifier assigned to the checklist for tracking and reference.',
    `checklist_status` STRING COMMENT '',
    `checklist_type` STRING COMMENT 'Category of the checklist reflecting the phase of plant commissioning.. Valid values are `mechanical_completion|pre_commissioning|commissioning|startup`',
    `comments` STRING COMMENT 'Free‑form notes entered by the engineer or reviewers.',
    `commissioning_checklist_status` STRING COMMENT 'Current lifecycle state of the checklist.. Valid values are `draft|in_progress|completed|closed|rejected`',
    `commissioning_date` TIMESTAMP COMMENT '',
    `completed_items` STRING COMMENT '',
    `completion_date` DATE COMMENT 'Date on which the checklist was formally completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT '',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the commissioning activity.. Valid values are `ISO9001|ISO14001|ISO45001|IEC62443|NIST|OSHA`',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Three‑letter ISO currency code for the cost estimate.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Financial estimate for the commissioning work.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist record was first created in the system.',
    `documentation_reference` STRING COMMENT 'Identifier or URL linking to detailed supporting documents (e.g., test reports).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Planned effort duration for completing the checklist.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist execution was initiated.',
    `failed_item_count` STRING COMMENT 'How many checklist items have been marked as failed.',
    `is_critical_path` BOOLEAN COMMENT 'True if the checklist is on the projects critical path.',
    `is_environmental_review_done` BOOLEAN COMMENT 'True if an environmental compliance review was performed and closed.',
    `is_external_vendor_involved` BOOLEAN COMMENT 'Indicates whether an external supplier contributed to the commissioning.',
    `is_overtime_required` BOOLEAN COMMENT 'True if overtime work is needed to meet the schedule.',
    `is_training_required` BOOLEAN COMMENT 'Indicates whether specialized training is required for the commissioning task.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_item_count` STRING COMMENT 'Count of individual verification items defined in the checklist.',
    `notes` STRING COMMENT '',
    `overall_pass` BOOLEAN COMMENT 'Indicates whether the entire checklist met the pass criteria (true = pass).',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours planned or used.',
    `passed_item_count` STRING COMMENT 'How many checklist items have been marked as passed.',
    `punch_list_item_count` STRING COMMENT 'Number of open punch‑list items remaining after the checklist execution.',
    `quality_sign_off` BOOLEAN COMMENT 'Indicates whether quality sign‑off was obtained (true = yes).',
    `record_status` STRING COMMENT '',
    `revision_number` STRING COMMENT 'Version number of the checklist document, incremented on each change.',
    `risk_level` STRING COMMENT 'Qualitative risk rating associated with the commissioning activity.. Valid values are `low|medium|high`',
    `safety_sign_off` BOOLEAN COMMENT 'Indicates whether safety sign‑off was obtained (true = yes).',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the checklist execution.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the checklist execution.',
    `signed_off_by` STRING COMMENT '',
    `system_scope` STRING COMMENT 'Name or code of the system/subsystem that the checklist covers (e.g., HVAC, Control System).',
    `total_items` DECIMAL(18,2) COMMENT '',
    `training_completion_date` DATE COMMENT 'Date when required training was completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the checklist record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_commissioning_checklist PRIMARY KEY(`commissioning_checklist_id`)
) COMMENT 'Plant commissioning and startup checklist record tracking the structured verification activities required to bring a new production asset, automation system, or facility into operational service. Captures checklist type (mechanical completion, pre-commissioning, commissioning, startup), system/subsystem scope, line items with pass/fail status, responsible engineer, completion date, and punch list item count.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` (
    `punch_list_item_id` BIGINT COMMENT 'System generated unique identifier for the punch list item.',
    `employee_id` BIGINT COMMENT '',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Punch‑list items for equipment require linking to the specific device to track resolution and cost impact.',
    `parent_punch_list_item_id` BIGINT COMMENT 'Self-referencing FK on punch_list_item (parent_punch_list_item_id)',
    `project_header_id` BIGINT COMMENT '',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the punch item is linked.',
    `actual_closure_date` TIMESTAMP COMMENT '',
    `actual_completion_date` DATE COMMENT 'Date the punch item was actually closed.',
    `comments` STRING COMMENT 'Free‑form notes added by inspectors or contractors.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the punch item.. Valid values are `compliant|non_compliant|pending`',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred to resolve the punch item.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost to resolve the punch item.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch list record was created in the source system.',
    `punch_list_item_description` STRING COMMENT 'Detailed textual description of the deficiency or corrective action required.',
    `identified_date` TIMESTAMP COMMENT '',
    `inspection_date` DATE COMMENT 'Date the deficiency was identified during inspection.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the punch item is deemed critical to project safety or schedule.',
    `item_description` STRING COMMENT '',
    `item_number` STRING COMMENT 'Business visible identifier assigned to the punch list item, e.g., PLI-000123.. Valid values are `^PLI-d{6}$`',
    `item_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `location` STRING COMMENT '',
    `location_code` STRING COMMENT 'Plant or area code where the punch item is located.. Valid values are `^[A-Z]{3}-[A-Z0-9]{2,5}$`',
    `notes` STRING COMMENT '',
    `priority` STRING COMMENT 'Priority level indicating urgency: A (critical), B (high), C (normal).. Valid values are `A|B|C`',
    `punch_list_item_category` STRING COMMENT 'High‑level classification of the punch item type.. Valid values are `safety|quality|mechanical|electrical|civil`',
    `punch_list_item_status` STRING COMMENT 'Current lifecycle status of the punch item.. Valid values are `open|in_progress|closed|rejected|deferred`',
    `record_status` STRING COMMENT '',
    `resolution_type` STRING COMMENT 'Method used to close the punch item.. Valid values are `repair|replace|rework|none`',
    `responsible_contractor` STRING COMMENT 'Name of the contractor responsible for addressing the punch item.',
    `severity` STRING COMMENT 'Severity of the issue impacting safety, quality, or schedule.. Valid values are `high|medium|low`',
    `sign_off_by` STRING COMMENT 'Name of the individual who signed off the punch item.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Timestamp when the punch item was formally signed off as completed.',
    `target_closure_date` TIMESTAMP COMMENT '',
    `target_completion_date` DATE COMMENT 'Planned date by which the punch item should be resolved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the punch list record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_punch_list_item PRIMARY KEY(`punch_list_item_id`)
) COMMENT 'Individual punch list item record representing an outstanding deficiency, incomplete work item, or corrective action identified during construction inspection, pre-commissioning, or commissioning walkdowns. Captures item number, description, category (A/B/C priority), responsible contractor, target completion date, actual completion date, and sign-off status. Critical for mechanical completion and handover management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`handover` (
    `handover_id` BIGINT COMMENT 'Unique system-generated identifier for each project handover record.',
    `customer_account_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organization that receives the handover.',
    `handover_org_unit_id` BIGINT COMMENT 'Identifier of the organization that performed the handover.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Identifies the physical network node (site) where handover occurs, supporting Handover Checklist.',
    `partial_handover_id` BIGINT COMMENT 'Self-referencing FK on handover (partial_handover_id)',
    `employee_id` BIGINT COMMENT 'System identifier of the approver.',
    `project_header_id` BIGINT COMMENT 'Reference to the project whose deliverables are being transferred.',
    `tertiary_handover_updated_by_user_employee_id` BIGINT COMMENT 'System identifier of the user who last updated the record.',
    `acceptance_date` DATE COMMENT 'Date when the accepting organization formally accepted the handover.',
    `acceptance_status` STRING COMMENT '',
    `accepted_by` STRING COMMENT '',
    `actual_handover_date` TIMESTAMP COMMENT '',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the handover received formal approval.',
    `approved_by_user_name` STRING COMMENT 'Full name of the user who approved the handover.',
    `as_built_document_status` STRING COMMENT 'Indicates whether as‑built drawings and documents are complete.. Valid values are `complete|incomplete|pending`',
    `change_order_reference` STRING COMMENT 'Identifier of any Engineering Change Order linked to the handover.',
    `comments` STRING COMMENT 'Any supplemental remarks entered by users.',
    `compliance_check_date` DATE COMMENT 'Date of the most recent compliance verification.',
    `compliance_check_passed` BOOLEAN COMMENT 'True if all regulatory and internal compliance checks were satisfied.',
    `created_by_user_name` STRING COMMENT 'Full name of the user who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the handover record was initially entered into the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary amounts.',
    `documentation_complete_flag` BOOLEAN COMMENT '',
    `documentation_package_status` STRING COMMENT 'Indicates completeness of the documentation handed over.. Valid values are `complete|partial|missing`',
    `final_cost_amount` DECIMAL(18,2) COMMENT 'Total cost captured at handover closure.',
    `final_cost_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 currency code for the final cost amount.',
    `handover_date` DATE COMMENT 'The calendar date on which the handover took place.',
    `handover_number` STRING COMMENT 'Business-visible handover number assigned by the project management system.',
    `handover_status` STRING COMMENT 'Current processing state of the handover record.. Valid values are `draft|in_review|approved|rejected|completed`',
    `handover_type` STRING COMMENT 'Indicates whether the handover is a partial or final transfer of deliverables.. Valid values are `partial|final`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `location` STRING COMMENT 'Site or plant identifier where the handover was executed.',
    `maintenance_plan_details` STRING COMMENT 'Summary of the maintenance schedule, scope, and responsibilities.',
    `maintenance_plan_transfer_flag` BOOLEAN COMMENT 'True if the ongoing maintenance plan is handed over.',
    `notes` STRING COMMENT '',
    `outstanding_items_description` STRING COMMENT 'Narrative description of remaining issues or actions.',
    `outstanding_items_flag` BOOLEAN COMMENT 'True if any punch‑list items are still open at handover.',
    `planned_handover_date` TIMESTAMP COMMENT '',
    `record_source_system` STRING COMMENT 'Name of the source application (e.g., SAP S/4HANA, Siemens Teamcenter).',
    `record_status` STRING COMMENT '',
    `review_meeting_attendees` TIMESTAMP COMMENT 'Comma‑separated list of participants in the review meeting.',
    `review_meeting_date` DATE COMMENT 'Scheduled date for the post‑handover review meeting.',
    `risk_assessment_status` STRING COMMENT 'Overall risk rating assigned during handover review.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Free‑text description of what is included in the handover.',
    `signature_captured` BOOLEAN COMMENT 'True when a signed handover acknowledgment is on file.',
    `signature_timestamp` TIMESTAMP COMMENT 'Date‑time when the handover signature was recorded.',
    `signoff_approvals` STRING COMMENT 'List of approvers and timestamps for handover sign‑off.',
    `source_system_record_code` STRING COMMENT 'Native primary key from the originating system.',
    `training_completion_status` STRING COMMENT 'Status of required training for the receiving team.. Valid values are `completed|partial|not_started`',
    `updated_by_user_name` STRING COMMENT 'Full name of the user who performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the handover record.',
    `value_amount` DECIMAL(18,2) COMMENT 'Financial value assigned to the handed‑over deliverables.',
    `warranty_expiration_date` DATE COMMENT 'Date when the transferred warranty period ends.',
    `warranty_transfer_flag` BOOLEAN COMMENT 'True when warranty obligations are passed to the receiving organization.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_handover PRIMARY KEY(`handover_id`)
) COMMENT 'Project handover record documenting the formal transfer of a completed project deliverable, facility, or system from the project team to the operations/maintenance organization. Captures handover type (partial, final), scope of handover, handover date, accepting organization, outstanding items, as-built documentation status, training completion status, and sign-off approvals.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_contract` (
    `project_contract_id` BIGINT COMMENT 'System-generated unique identifier for the project contract record.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Contracts must be associated with the customer account for legal, billing, and compliance purposes.',
    `master_project_contract_id` BIGINT COMMENT 'Self-referencing FK on project_contract (master_project_contract_id)',
    `employee_id` BIGINT COMMENT 'Internal employee responsible for contract administration.',
    `primary_project_employee_id` BIGINT COMMENT 'Identifier of the system user who created the contract record.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the external contractor or vendor.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this contract belongs.',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Provides sourcing policy for contract items in Project Contract Management process.',
    `wbs_element_id` BIGINT COMMENT 'Work Breakdown Structure element linked to the contract.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `contract_category` STRING COMMENT 'Business domain of the contract (e.g., EPC, consulting).. Valid values are `epc|subcontract|consulting|equipment_vendor|other`',
    `contract_number` STRING COMMENT 'External contract reference number assigned by the contracting party.',
    `contract_status` STRING COMMENT '',
    `contract_type` STRING COMMENT 'Classification of the contract pricing model.. Valid values are `lump_sum|cost_plus|unit_rate|time_and_materials|other`',
    `contract_value` DECIMAL(18,2) COMMENT '',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Accounting cost center associated with the contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the contract currency.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `document_url` STRING COMMENT 'Link to the stored electronic contract document.',
    `effective_from` DATE COMMENT 'Date when the contract becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or terminates (nullable for open‑ended).',
    `end_date` TIMESTAMP COMMENT '',
    `expiration_date` DATE COMMENT 'Date the contract is scheduled to expire, if different from effective_until.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `liquidated_damages_clause` STRING COMMENT 'Text of the clause defining penalties for delayed performance.',
    `notes` STRING COMMENT '',
    `payment_terms` DECIMAL(18,2) COMMENT 'Agreed payment schedule and conditions (e.g., Net 30, milestone based).',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond, if required.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond is required for the contract.',
    `project_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|active|suspended|terminated|closed|pending`',
    `record_status` STRING COMMENT '',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a renewal option.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months, if renewal_option_flag is true.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount held as retention based on the retention percentage.',
    `retention_percent` DECIMAL(18,2) COMMENT '',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of contract value retained until final acceptance.',
    `scope_of_work` STRING COMMENT 'Brief description of the work, deliverables, and responsibilities covered by the contract.',
    `signed_date` DATE COMMENT 'Date the contract was formally signed by all parties.',
    `start_date` TIMESTAMP COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross contract value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `value_gross` DECIMAL(18,2) COMMENT 'Total contract amount before taxes, discounts, or retentions.',
    `value_net` DECIMAL(18,2) COMMENT 'Contract amount after taxes, discounts, and retentions.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_contract PRIMARY KEY(`project_contract_id`)
) COMMENT 'Project-specific contract record governing agreements with EPC contractors, construction subcontractors, engineering consultants, and equipment vendors for project execution. Captures contract number, contract type (lump sum, cost-plus, unit rate, T&M), contractor identity, scope of work, contract value, payment terms, retention percentage, performance bond, liquidated damages clause, and contract status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` (
    `invoice_request_id` BIGINT COMMENT 'Unique identifier for the project invoice request record.',
    `credited_invoice_request_id` BIGINT COMMENT 'Self-referencing FK on invoice_request (credited_invoice_request_id)',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to be billed.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Invoice requests must be linked to the actual invoice issued for audit, reconciliation, and compliance reporting.',
    `milestone_id` BIGINT COMMENT '',
    `project_contract_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Identifier of the project associated with the invoice request.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element linked to the billing.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before taxes and discounts.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after tax and discounts.',
    `approval_status` STRING COMMENT 'Current approval state of the invoice request.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'User identifier of the person who approved the invoice request.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice request was approved.',
    `billing_basis` STRING COMMENT 'Method used to calculate the billable amount.. Valid values are `milestone|percentage|time_and_material|fixed_price`',
    `billing_period_end` TIMESTAMP COMMENT 'End date of the billing period covered by the request.',
    `billing_period_start` TIMESTAMP COMMENT 'Start date of the billing period covered by the request.',
    `contract_number` STRING COMMENT 'Reference to the governing contract or agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the invoice amounts.',
    `invoice_request_description` STRING COMMENT 'Free‑form description or notes for the invoice request.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the invoice.',
    `discount_reason` STRING COMMENT 'Explanation for the discount granted.',
    `due_date` DATE COMMENT 'Date by which payment is expected.',
    `invoice_request_status` STRING COMMENT 'Current lifecycle status of the invoice request.. Valid values are `pending|approved|rejected|cancelled|issued`',
    `is_advance` BOOLEAN COMMENT 'Flag indicating whether this is an advance (pre‑payment) invoice.',
    `is_final` BOOLEAN COMMENT 'Flag indicating whether this invoice request represents the final billing for the project.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms associated with the invoice.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage of project completion used for percentage‑based billing.',
    `record_status` STRING COMMENT '',
    `request_date` TIMESTAMP COMMENT '',
    `request_number` STRING COMMENT 'Business identifier assigned to the invoice request.',
    `request_status` STRING COMMENT '',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice request was generated.',
    `requested_amount` DECIMAL(18,2) COMMENT '',
    `revenue_recognition_method` DECIMAL(18,2) COMMENT 'Method used for recognizing revenue from this invoice.',
    `source_system_code` STRING COMMENT 'Original identifier of the record in the source system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the invoice.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `updated_by` BIGINT COMMENT 'User identifier who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `created_by` STRING COMMENT 'User identifier who initially created the record.',
    CONSTRAINT pk_invoice_request PRIMARY KEY(`invoice_request_id`)
) COMMENT 'Project billing and invoice request record capturing milestone-based or progress-based billing events triggered by project milestone completion, percentage completion, or contractual billing schedule. Captures billing basis (milestone, POC, time-and-material), billing period, billable amount, WBS billing element, customer reference, revenue recognition method, and billing document status.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` (
    `earned_value_record_id` BIGINT COMMENT 'Unique identifier for the earned value performance record.',
    `previous_earned_value_record_id` BIGINT COMMENT 'Self-referencing FK on earned_value_record (previous_earned_value_record_id)',
    `project_header_id` BIGINT COMMENT '',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which this earned value data applies.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for work performed up to the reporting date.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the earned value record was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the earned value record.',
    `baseline_version` STRING COMMENT 'Identifier of the project baseline version against which the metrics are measured.',
    `cost_performance_index` DECIMAL(18,2) COMMENT 'Ratio of earned value to actual cost (EV/AC). Values >1 indicate cost efficiency.',
    `cost_type` DECIMAL(18,2) COMMENT 'Classification of costs represented in the record.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between earned value and actual cost (EV‑AC). Positive indicates under budget.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the earned value record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `earned_value` DECIMAL(18,2) COMMENT 'Monetary value of work actually performed by the reporting date.',
    `earned_value_record_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the earned value record.',
    `estimate_at_completion` TIMESTAMP COMMENT 'Forecasted total cost of the project at completion based on current performance.',
    `estimate_to_complete` DECIMAL(18,2) COMMENT 'Projected cost required to finish the remaining work.',
    `forecast_method` STRING COMMENT 'Methodology used to generate forecasted earned value figures.. Valid values are `parametric|expert|historical|none`',
    `is_forecast` BOOLEAN COMMENT 'True if the record represents a forecasted value rather than actual measured data.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `measurement_date` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the earned value record.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage of the WBS element work that has been completed to date.',
    `planned_value` DECIMAL(18,2) COMMENT 'Planned monetary value of work scheduled to be performed by the reporting date.',
    `record_status` STRING COMMENT '',
    `reporting_date` DATE COMMENT 'Date on which the earned value record is reported (typically the period end date).',
    `reporting_period_end_date` DATE COMMENT 'Last day of the reporting period for which the earned value metrics are calculated.',
    `reporting_period_start_date` DATE COMMENT 'First day of the reporting period for which the earned value metrics are calculated.',
    `schedule_performance_index` DECIMAL(18,2) COMMENT 'Ratio of earned value to planned value (EV/PV). Values >1 indicate schedule efficiency.',
    `schedule_variance` DECIMAL(18,2) COMMENT 'Difference between earned value and planned value (EV‑PV). Positive indicates ahead of schedule.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the earned value record.',
    `variance_at_completion` TIMESTAMP COMMENT 'Difference between the original budget and the estimate at completion (BAC‑EAC).',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_earned_value_record PRIMARY KEY(`earned_value_record_id`)
) COMMENT 'Earned Value Management (EVM) performance record capturing periodic EVM metrics for a WBS element or project. Stores BCWS (Planned Value), BCWP (Earned Value), ACWP (Actual Cost), Schedule Variance (SV), Cost Variance (CV), SPI, CPI, EAC, ETC, and VAC per reporting period. Enables project performance trending and forecasting at WBS and project level.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`project_document` (
    `project_document_id` BIGINT COMMENT 'System-generated unique identifier for the project document record.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which the document belongs.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element associated with the document.',
    `project_wbs_element_id` BIGINT COMMENT '',
    `superseded_project_document_id` BIGINT COMMENT 'Self-referencing FK on project_document (superseded_project_document_id)',
    `approval_date` DATE COMMENT 'Date the document received formal approval.',
    `approver` STRING COMMENT 'Name of the person who approved the document.',
    `archive_date` DATE COMMENT 'Date the document was archived.',
    `author` STRING COMMENT 'Name of the person who authored the document.',
    `checksum` STRING COMMENT 'Hash value (e.g., SHA‑256) used to verify file integrity.',
    `compliance_requirement` STRING COMMENT 'Specific regulatory or standard requirement the document satisfies.',
    `compliance_status` STRING COMMENT 'Current compliance status of the document.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_level` STRING COMMENT 'Classification indicating the sensitivity of the document.. Valid values are `public|internal|confidential|restricted`',
    `control_number` STRING COMMENT 'Unique identifier assigned to controlled documents for traceability.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 code indicating the country where the document originated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `distribution_list` STRING COMMENT 'Comma‑separated list of parties who receive the document.',
    `document_category` STRING COMMENT 'High‑level grouping of the document (e.g., Engineering, Legal, Safety).',
    `document_description` STRING COMMENT 'Brief free‑text description summarizing the documents purpose.',
    `document_name` STRING COMMENT '',
    `document_number` STRING COMMENT 'Business identifier assigned to the document, often used for tracking and reference.',
    `document_status` STRING COMMENT '',
    `document_type` STRING COMMENT 'Category of the document indicating its purpose or content. [ENUM-REF-CANDIDATE: drawing|specification|contract|permit|inspection_report|test_record|as_built|procedure|policy — 9 candidates stripped; promote to reference product]',
    `document_url` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Date from which the documents content becomes effective.',
    `electronic_signature_present` BOOLEAN COMMENT 'Indicates whether the document includes an electronic signature.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid.',
    `file_path` STRING COMMENT 'File system or repository path where the document is stored.',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored file in bytes.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the document has been moved to archive storage.',
    `is_controlled` BOOLEAN COMMENT 'True if the document is subject to formal control and change management.',
    `is_electronic` BOOLEAN COMMENT 'True if the document exists in electronic form.',
    `issue_date` TIMESTAMP COMMENT 'Date the document was officially issued.',
    `keywords` STRING COMMENT 'Comma‑separated list of keywords for search and classification.',
    `language` STRING COMMENT 'ISO 639‑2 language code of the document content.. Valid values are `ENG|SPA|FRE|GER|CHN|JPN`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT 'Date the document was last reviewed for relevance or compliance.',
    `mime_type` STRING COMMENT 'Standard MIME type describing the file format (e.g., application/pdf).',
    `notes` STRING COMMENT '',
    `originator` STRING COMMENT 'Name of the individual or department that originated the document.',
    `project_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|issued|approved|archived|retracted`',
    `record_status` STRING COMMENT '',
    `regulatory_reference` STRING COMMENT 'Identifier of the external regulation or filing that references this document.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per policy.',
    `review_cycle_days` STRING COMMENT 'Number of days between scheduled reviews of the document.',
    `revision` STRING COMMENT 'Revision identifier (e.g., A, B, 1.0, 2.1) indicating the version of the document.',
    `signed_by` STRING COMMENT 'Name of the person who signed the document electronically or physically.',
    `signed_date` DATE COMMENT 'Date the document was signed.',
    `storage_location` STRING COMMENT 'Logical storage area or bucket name (e.g., Azure Blob container).',
    `subcategory` STRING COMMENT 'More specific classification within the main category.',
    `title` STRING COMMENT 'Descriptive title of the document as shown to users.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `upload_date` TIMESTAMP COMMENT '',
    `uploaded_by` STRING COMMENT '',
    `version_number` STRING COMMENT 'Sequential numeric version of the document.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_project_document PRIMARY KEY(`project_document_id`)
) COMMENT 'Project document register record tracking all formal project documents including engineering drawings, specifications, contracts, permits, inspection reports, test records, and as-built documentation. Captures document number, title, document type, revision, originator, issue date, distribution list, approval status, and document management system reference. Supports project document control per ISO 9001.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`phase` (
    `phase_id` BIGINT COMMENT 'System-generated unique identifier for the project phase record.',
    `predecessor_phase_id` BIGINT COMMENT 'Self-referencing FK on phase (predecessor_phase_id)',
    `project_header_id` BIGINT COMMENT 'Identifier of the parent project to which this phase belongs.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the phase to date.',
    `actual_duration_days` DECIMAL(18,2) COMMENT 'Number of calendar days the phase actually took to complete.',
    `actual_end_date` TIMESTAMP COMMENT 'Date the phase was completed or closed.',
    `actual_start_date` TIMESTAMP COMMENT 'Date the phase actually commenced on the shop floor or in engineering.',
    `approval_date` DATE COMMENT 'Date on which the phase gate was approved.',
    `approval_status` STRING COMMENT 'Result of the formal approval process for the phase gate.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the person or role that approved the phase.',
    `change_control_number` STRING COMMENT 'Reference number for any change control associated with the phase.',
    `phase_code` STRING COMMENT 'Short alphanumeric code used to identify the phase in project documentation and systems.',
    `compliance_requirement` STRING COMMENT 'Specific regulatory or internal compliance requirement applicable to the phase.',
    `compliance_status` STRING COMMENT 'Current compliance status for the phase.. Valid values are `compliant|non_compliant|pending`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Budgeted cost for the phase as originally planned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the phase record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for cost fields.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `phase_description` STRING COMMENT 'Detailed description of the phase scope, objectives, and deliverables.',
    `effective_from` DATE COMMENT 'Date from which the phase definition becomes effective (often same as actual_start_date).',
    `effective_until` DATE COMMENT 'Date after which the phase definition is superseded or closed (often same as actual_end_date).',
    `gate_approval_status` STRING COMMENT '',
    `gate_review_criteria` STRING COMMENT 'Key criteria that must be satisfied for the phase gate to be approved.',
    `is_critical` BOOLEAN COMMENT 'True if the phase is deemed critical to project success.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `milestone_flag` BOOLEAN COMMENT 'True if the phase includes a major project milestone.',
    `phase_name` STRING COMMENT 'Human‑readable name of the phase (e.g., Concept, FEED, Detailed Engineering).',
    `notes` STRING COMMENT 'Free‑form comments or observations about the phase.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage of work completed for the phase, expressed with two decimal precision.',
    `phase_sequence` STRING COMMENT '',
    `phase_status` STRING COMMENT 'Current lifecycle status of the phase.. Valid values are `planned|in_progress|completed|closed|on_hold`',
    `planned_duration_days` DECIMAL(18,2) COMMENT 'Number of calendar days originally planned for the phase.',
    `planned_end_date` TIMESTAMP COMMENT 'Scheduled end date for the phase as defined in the project plan.',
    `planned_start_date` TIMESTAMP COMMENT 'Scheduled start date for the phase as defined in the project plan.',
    `record_status` STRING COMMENT '',
    `risk_description` STRING COMMENT 'Narrative description of identified risks for the phase.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the phase.. Valid values are `low|medium|high|critical`',
    `sequence` STRING COMMENT 'Numeric order of the phase within the overall project lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the phase record.',
    `version_number` STRING COMMENT 'Version of the phase definition, incremented on each redesign.',
    `wbs_element_code` STRING COMMENT 'Code of the associated Work Breakdown Structure element.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_phase PRIMARY KEY(`phase_id`)
) COMMENT 'Project phase master record defining the structured lifecycle phases of a capital or engineering project (e.g., Concept, FEED, Detailed Engineering, Procurement, Construction, Commissioning, Startup, Closeout). Captures phase name, phase code, sequence, planned start/end dates, actual start/end dates, gate review criteria, approval status, and phase completion percentage.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`team_member` (
    `team_member_id` BIGINT COMMENT 'Surrogate primary key for the project team member assignment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the person assigned to the project (links to master party/person record).',
    `project_header_id` BIGINT COMMENT 'Unique identifier of the project to which the team member is assigned.',
    `reports_to_team_member_id` BIGINT COMMENT 'Self-referencing FK on team_member (reports_to_team_member_id)',
    `team_employee_id` BIGINT COMMENT '',
    `access_level` STRING COMMENT 'System access level assigned to the team member for project data and tools.. Valid values are `read|write|admin`',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the persons effort allocated to the project (0-100).',
    `authority_level` STRING COMMENT 'Level of decision‑making authority granted to the team member for this project.. Valid values are `low|medium|high|executive`',
    `cost_rate_amount` DECIMAL(18,2) COMMENT 'Hourly cost rate for the team members labor on the project, expressed in the specified currency.',
    `cost_rate_currency` DECIMAL(18,2) COMMENT 'ISO 4217 currency code for the cost rate associated with the team members allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was created.',
    `end_date` TIMESTAMP COMMENT 'Date when the team members assignment to the project ends (null if ongoing).',
    `is_lead` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `member_status` STRING COMMENT '',
    `notes` STRING COMMENT 'Free‑text notes regarding the assignment, such as special conditions or comments.',
    `record_status` STRING COMMENT '',
    `role` STRING COMMENT 'Role of the team member within the project organization. [ENUM-REF-CANDIDATE: project_manager|project_engineer|cost_controller|scheduler|site_manager|quality_engineer|procurement_lead|safety_officer — 8 candidates stripped; promote to reference product]',
    `start_date` TIMESTAMP COMMENT 'Date when the team members assignment to the project begins.',
    `team_member_status` STRING COMMENT 'Current status of the team members assignment.. Valid values are `active|inactive|on_hold|completed|terminated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_team_member PRIMARY KEY(`team_member_id`)
) COMMENT 'Project team member assignment record defining the project organizational structure by linking personnel to specific project roles, responsibilities, and authority levels. Captures team member identity, project role (PM, project engineer, cost controller, scheduler, site manager), assignment start/end dates, allocation percentage, reporting line within project, and access authorization level.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`progress_report` (
    `progress_report_id` BIGINT COMMENT 'Unique identifier for each project progress report record.',
    `previous_progress_report_id` BIGINT COMMENT 'Self-referencing FK on progress_report (previous_progress_report_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who authored the progress report.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this progress report belongs.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total cost incurred during the reporting period.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the report was approved.',
    `approved_by_name` STRING COMMENT 'Full name of the employee who approved the report.',
    `author_name` STRING COMMENT 'Full name of the employee who authored the report.',
    `budgeted_cost` DECIMAL(18,2) COMMENT 'Total cost originally budgeted for the reporting period.',
    `change_control_number` STRING COMMENT 'Reference number for any change control request associated with this report.',
    `comments` STRING COMMENT 'Free‑form comments or notes added by the author.',
    `compliance_requirement` STRING COMMENT 'Specific regulatory or quality requirement applicable to the project.',
    `compliance_status` STRING COMMENT 'Indicates whether the project complies with relevant standards and regulations.. Valid values are `compliant|non_compliant|pending`',
    `cost_status` DECIMAL(18,2) COMMENT 'Cost performance relative to budget (on budget, over budget, under budget).',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Monetary difference between budgeted and actual cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the progress report record was first created in the system.',
    `forecast_completion_date` DATE COMMENT 'Projected date when the project is expected to be fully completed.',
    `forecast_percent_complete` DECIMAL(18,2) COMMENT 'Projected overall percent complete at forecast completion date.',
    `is_critical` BOOLEAN COMMENT 'True if the reporting period includes a critical milestone or decision point.',
    `issues_and_risks` BOOLEAN COMMENT 'Summary of current issues, risks, and mitigation actions.',
    `key_accomplishments` STRING COMMENT 'Narrative description of major achievements during the reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `overall_percent_complete` DECIMAL(18,2) COMMENT '',
    `overall_status` STRING COMMENT 'Overall health of the project using Red/Amber/Green (RAG) coding.. Valid values are `red|amber|green`',
    `percent_complete` DECIMAL(18,2) COMMENT 'Overall percentage of work completed to date.',
    `prepared_by` STRING COMMENT '',
    `record_status` STRING COMMENT '',
    `report_date` TIMESTAMP COMMENT 'Date on which the progress report was submitted or finalized.',
    `report_number` STRING COMMENT '',
    `report_status` STRING COMMENT 'Current lifecycle status of the report (draft, submitted, approved, rejected).. Valid values are `draft|submitted|approved|rejected`',
    `report_summary` STRING COMMENT '',
    `reporting_cadence` STRING COMMENT 'Frequency at which the report is generated (e.g., weekly, monthly, quarterly).. Valid values are `weekly|monthly|quarterly`',
    `reporting_period_end` TIMESTAMP COMMENT 'Last day of the reporting period covered by this progress report.',
    `reporting_period_start` TIMESTAMP COMMENT 'First day of the reporting period covered by this progress report.',
    `risk_description` STRING COMMENT 'Detailed description of identified risks and their potential impact.',
    `risk_level` STRING COMMENT 'Overall risk rating for the project during the reporting period.. Valid values are `low|medium|high|critical`',
    `schedule_status` STRING COMMENT 'Current schedule performance relative to the baseline (on track, behind, ahead).. Valid values are `on_track|behind|ahead`',
    `schedule_variance_days` STRING COMMENT 'Difference in days between planned and actual schedule milestones.',
    `upcoming_activities` STRING COMMENT 'Planned work and milestones for the next reporting period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the progress report record.',
    `version_number` STRING COMMENT 'Sequential version number of the report for change tracking.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_progress_report PRIMARY KEY(`progress_report_id`)
) COMMENT 'Periodic project progress report record capturing the formal status update submitted by the project team at a defined reporting cadence (weekly, monthly). Captures reporting period, overall project health (RAG status), schedule performance summary, cost performance summary, key accomplishments, upcoming activities, issues and risks summary, and forecast completion date.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique surrogate key for each project settlement record.',
    `cost_center_id` BIGINT COMMENT '',
    `fixed_asset_id` BIGINT COMMENT '',
    `primary_reversal_of_settlement_id` BIGINT COMMENT 'Reference to the original settlement that is being reversed.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the settlement.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Settlement records are always associated with a project; linking to project_header provides context for financial reporting and eliminates the need for external project look‑ups.',
    `wbs_element_id` BIGINT COMMENT 'WBS element from which costs are being settled.',
    `settlement_wbs_element_id` BIGINT COMMENT '',
    `amount` DECIMAL(18,2) COMMENT '',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before tax or adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount after tax and adjustments.',
    `approval_status` STRING COMMENT 'Current approval state of the settlement.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement was approved.',
    `cost_element_code` DECIMAL(18,2) COMMENT 'Cost element used for the settlement (e.g., L001 for labor).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the settlement amounts.',
    `settlement_description` STRING COMMENT 'Free‑text description or notes about the settlement.',
    `external_document_reference` STRING COMMENT 'Reference to an external document (e.g., invoice, contract) linked to the settlement.',
    `is_manual_settlement` BOOLEAN COMMENT 'Flag indicating whether the settlement was entered manually (true) or generated automatically (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `posting_period` STRING COMMENT 'Fiscal period identifier (e.g., 2023Q1) for the settlement posting.',
    `receiver_object_reference` BIGINT COMMENT 'Identifier of the receiving cost object (e.g., cost center, asset, order).',
    `receiver_object_type` STRING COMMENT 'Type of the cost object receiving the settled amount.. Valid values are `cost_center|fixed_asset|internal_order|profitability_segment`',
    `record_status` STRING COMMENT '',
    `reversal_indicator` BOOLEAN COMMENT 'True if this record represents a reversal of a prior settlement.',
    `rule` STRING COMMENT 'Name or code of the settlement rule used to allocate costs.',
    `settlement_date` TIMESTAMP COMMENT 'Date on which the settlement was executed or posted.',
    `settlement_number` STRING COMMENT 'External reference number assigned to the settlement document by the source system.',
    `settlement_rule` STRING COMMENT '',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement.. Valid values are `pending|posted|reversed|cancelled`',
    `settlement_type` STRING COMMENT '',
    `source_system_settlement_code` STRING COMMENT 'Identifier of the settlement in the source system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the settlement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Project cost settlement record capturing the periodic or final allocation of project costs from WBS elements to receiving cost objects (fixed assets, cost centers, orders, profitability segments). Captures settlement rule, sender WBS element, receiver object type and identity, settlement amount by cost element, settlement period, and settlement document reference. Aligns with SAP PS settlement (KO88/CJ88).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`project`.`gate_review` (
    `gate_review_id` BIGINT COMMENT 'Unique identifier for the gate review record.',
    `deferred_gate_review_id` BIGINT COMMENT 'Self-referencing FK on gate_review (deferred_gate_review_id)',
    `phase_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Identifier of the project to which this gate review belongs.',
    `compliance_status` STRING COMMENT 'Indicates whether the project meets relevant compliance requirements at this gate.. Valid values are `compliant|non_compliant|pending`',
    `conditions_attached` TIMESTAMP COMMENT 'Specific conditions or actions required for the project to proceed to the next gate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gate review record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the reauthorized amount.. Valid values are `^[A-Z]{3}$`',
    `decision` STRING COMMENT '',
    `decision_outcome` STRING COMMENT 'Formal outcome of the gate review governing the next project step.. Valid values are `proceed|hold|kill|recycle`',
    `decision_rationale` DECIMAL(18,2) COMMENT '',
    `decision_reason` STRING COMMENT 'Narrative explanation for the decision outcome.',
    `financial_status` STRING COMMENT 'Current financial approval status of the gate.. Valid values are `approved|pending|rejected`',
    `gate_name` STRING COMMENT 'Human‑readable name of the gate (e.g., Concept, Design, Production).',
    `gate_number` STRING COMMENT 'Numeric identifier indicating the gate sequence within the project lifecycle.',
    `gate_sequence` STRING COMMENT 'Ordinal position of the gate within the overall project schedule.',
    `gate_type` STRING COMMENT 'Category of the gate based on the project methodology.',
    `is_critical` BOOLEAN COMMENT 'Flag indicating if this gate is deemed critical for project success.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_gate_target_date` DATE COMMENT 'Planned date for the next gate review.',
    `notes` STRING COMMENT 'Free‑form field for any additional comments or observations.',
    `reauthorized_amount` DECIMAL(18,2) COMMENT 'Monetary amount re‑approved for the project at this gate.',
    `record_status` STRING COMMENT '',
    `review_board` STRING COMMENT 'Comma‑separated list of individuals or groups that formed the review board.',
    `review_date` TIMESTAMP COMMENT '',
    `review_status` STRING COMMENT '',
    `review_timestamp` TIMESTAMP COMMENT 'Exact date and time when the gate review decision was made.',
    `reviewer` STRING COMMENT '',
    `risk_assessment_summary` STRING COMMENT 'Brief summary of risks identified at this gate.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned during the gate review.. Valid values are `low|medium|high`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this gate review record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_gate_review PRIMARY KEY(`gate_review_id`)
) COMMENT 'Stage-gate review event record capturing the formal governance decision point at each project phase boundary. Captures gate number, gate name, review date, review board members, decision outcome (proceed, hold, kill, recycle), conditions attached to approval, risk assessment summary, financial re-authorization status, and next gate target date. Supports CapEx governance and investment committee oversight.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ADD CONSTRAINT `fk_project_project_header_parent_project_header_id` FOREIGN KEY (`parent_project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_wbs_element_id` FOREIGN KEY (`parent_wbs_wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_predecessor_milestone_id` FOREIGN KEY (`predecessor_milestone_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_predecessor_activity_id` FOREIGN KEY (`predecessor_activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ADD CONSTRAINT `fk_project_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_transferred_from_project_budget_id` FOREIGN KEY (`transferred_from_project_budget_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_resource_assignment_id` FOREIGN KEY (`resource_assignment_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_reversal_cost_actual_id` FOREIGN KEY (`reversal_cost_actual_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`cost_actual`(`cost_actual_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ADD CONSTRAINT `fk_project_cost_actual_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_originating_commitment_id` FOREIGN KEY (`originating_commitment_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`commitment`(`commitment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ADD CONSTRAINT `fk_project_commitment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ADD CONSTRAINT `fk_project_plan_version_baseline_plan_version_id` FOREIGN KEY (`baseline_plan_version_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`plan_version`(`plan_version_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ADD CONSTRAINT `fk_project_plan_version_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_replaced_resource_assignment_id` FOREIGN KEY (`replaced_resource_assignment_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`resource_assignment`(`resource_assignment_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ADD CONSTRAINT `fk_project_resource_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_blanket_procurement_item_id` FOREIGN KEY (`blanket_procurement_item_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`procurement_item`(`procurement_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ADD CONSTRAINT `fk_project_procurement_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ADD CONSTRAINT `fk_project_project_status_event_preceding_project_status_event_id` FOREIGN KEY (`preceding_project_status_event_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_status_event`(`project_status_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ADD CONSTRAINT `fk_project_project_status_event_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_issue_related_project_project_header_id` FOREIGN KEY (`issue_related_project_project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_parent_issue_id` FOREIGN KEY (`parent_issue_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`issue`(`issue_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ADD CONSTRAINT `fk_project_project_change_request_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ADD CONSTRAINT `fk_project_project_change_request_superseded_project_change_request_id` FOREIGN KEY (`superseded_project_change_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_change_request`(`project_change_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ADD CONSTRAINT `fk_project_project_change_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`activity`(`activity_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_corrected_timesheet_id` FOREIGN KEY (`corrected_timesheet_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ADD CONSTRAINT `fk_project_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_parent_commissioning_checklist_id` FOREIGN KEY (`parent_commissioning_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`commissioning_checklist`(`commissioning_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ADD CONSTRAINT `fk_project_commissioning_checklist_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_parent_punch_list_item_id` FOREIGN KEY (`parent_punch_list_item_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`punch_list_item`(`punch_list_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ADD CONSTRAINT `fk_project_punch_list_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_partial_handover_id` FOREIGN KEY (`partial_handover_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`handover`(`handover_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ADD CONSTRAINT `fk_project_handover_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_master_project_contract_id` FOREIGN KEY (`master_project_contract_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ADD CONSTRAINT `fk_project_project_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_credited_invoice_request_id` FOREIGN KEY (`credited_invoice_request_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`invoice_request`(`invoice_request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_project_contract_id` FOREIGN KEY (`project_contract_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_contract`(`project_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ADD CONSTRAINT `fk_project_invoice_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ADD CONSTRAINT `fk_project_earned_value_record_previous_earned_value_record_id` FOREIGN KEY (`previous_earned_value_record_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`earned_value_record`(`earned_value_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ADD CONSTRAINT `fk_project_earned_value_record_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ADD CONSTRAINT `fk_project_earned_value_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ADD CONSTRAINT `fk_project_project_document_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ADD CONSTRAINT `fk_project_project_document_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ADD CONSTRAINT `fk_project_project_document_project_wbs_element_id` FOREIGN KEY (`project_wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ADD CONSTRAINT `fk_project_project_document_superseded_project_document_id` FOREIGN KEY (`superseded_project_document_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_document`(`project_document_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_predecessor_phase_id` FOREIGN KEY (`predecessor_phase_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ADD CONSTRAINT `fk_project_team_member_reports_to_team_member_id` FOREIGN KEY (`reports_to_team_member_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`team_member`(`team_member_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ADD CONSTRAINT `fk_project_progress_report_previous_progress_report_id` FOREIGN KEY (`previous_progress_report_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`progress_report`(`progress_report_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ADD CONSTRAINT `fk_project_progress_report_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ADD CONSTRAINT `fk_project_settlement_primary_reversal_of_settlement_id` FOREIGN KEY (`primary_reversal_of_settlement_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`settlement`(`settlement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ADD CONSTRAINT `fk_project_settlement_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ADD CONSTRAINT `fk_project_settlement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ADD CONSTRAINT `fk_project_settlement_settlement_wbs_element_id` FOREIGN KEY (`settlement_wbs_element_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ADD CONSTRAINT `fk_project_gate_review_deferred_gate_review_id` FOREIGN KEY (`deferred_gate_review_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`gate_review`(`gate_review_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ADD CONSTRAINT `fk_project_gate_review_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ADD CONSTRAINT `fk_project_gate_review_project_header_id` FOREIGN KEY (`project_header_id`) REFERENCES `vibe_manufacturing_v1`.`project`.`project_header`(`project_header_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`project` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `parent_project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Project Header Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `parent_project_header_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Plan Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `actual_oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual OEE Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `actual_work_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Work Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `completed_milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestone Count');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `critical_path_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_header_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `expected_oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected OEE Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `external_project_code` SET TAGS ('dbx_business_glossary_term' = 'External Project Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|joint_venture');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `governance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Governance Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `governance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `procurement_strategy` SET TAGS ('dbx_business_glossary_term' = 'Procurement Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_category` SET TAGS ('dbx_value_regex' = 'capital|operational|research|maintenance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_header_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_header_status` SET TAGS ('dbx_value_regex' = 'planned|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|planning|execution|monitoring|closure');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'EPC|CapEx|NPI|MTO');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `sponsor_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `total_work_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Work Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_header` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wbs Element Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost|revenue|internal_order|asset');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `billing_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_level` SET TAGS ('dbx_business_glossary_term' = 'WBS Hierarchy Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `responsible_department_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'on_schedule|behind|ahead');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Short Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'WBS Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_business_glossary_term' = 'WBS Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_type` SET TAGS ('dbx_value_regex' = 'internal|external|contract|support');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `predecessor_milestone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `completion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Completion Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|delayed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'contractual|internal|payment|regulatory|technical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `responsible_party_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Role');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `responsible_party_role` SET TAGS ('dbx_value_regex' = 'project_manager|engineer|contractor|client');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Identifier (PAI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `predecessor_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Activity Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `predecessor_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Configuration Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'External Contract Identifier (ECI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Status (PAS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Type (PAT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'internal|external|cost|milestone');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp (AFT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (AST)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Code (PAC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^ACT-[0-9]{5}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CCC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CCY)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description (AD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Hours) (PDH)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `earned_value_acwp` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Work Performed (ACWP)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `earned_value_bcwp` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `earned_value_bcws` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `equipment_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Equipment Cost (AEC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `equipment_cost_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Equipment Cost (EEC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `float_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Float (Days) (SFD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator (CPI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `labor_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours (ALH)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `labor_hours_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours (ELH)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `material_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost (AMC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `material_cost_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost (EMC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone Indicator (MI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Name (PAN)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes (AN)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete (PC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date (PFD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date (PSD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `predecessor_activity_ids` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Activity IDs (PAIDs)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `resource_requirements` SET TAGS ('dbx_business_glossary_term' = 'Resource Requirements Description (RRD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `successor_activity_ids` SET TAGS ('dbx_business_glossary_term' = 'Successor Activity IDs (SAIDs)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `total_cost_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost (ETC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`activity` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element (WBS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Identifier (PBI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Identifier (BOI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `planning_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Parameter Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CBUI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `transferred_from_project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Transferred From Project Budget Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `transferred_from_project_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method (AM)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'manual|automatic|rollup');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date (BAD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category (BCAT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number (BN)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_business_glossary_term' = 'Budget Source (BSRC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (CapEx/OpEx) (BT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Reason (BCR)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Budget Amount (CBA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code (CEC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `project_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description (BLD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective End Date (BEED)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Start Date (BESD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Flag (BLF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `last_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Approval Timestamp (LAT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount (OBA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Role (BOR)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `project_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status (BS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount (RBA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount (RBA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Budget Amount (SBA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `transferred_in_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Transfer In Amount (BTIA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `transferred_out_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Transfer Out Amount (BTOA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version (BV)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_actual_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Actual ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `reversal_cost_actual_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Cost Actual Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `reversal_cost_actual_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `tertiary_cost_posting_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `tertiary_cost_posting_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `tertiary_cost_posting_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Posted Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `amount_controlling_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Controlling Currency');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|awaiting');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_allocation_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Rule');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CHF');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `cost_actual_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Line Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `overhead_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|planning|execution|monitoring|closing');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`cost_actual` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Percent');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Project Commitment Identifier (PRJ_CMT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Identifier (ACT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `originating_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Commitment Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `originating_commitment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJ_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (VEND_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Identifier (WBS_ELEM_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACT_DELIV_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `actual_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spent Amount (ACT_SPENT_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount (BUDGET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date (CMT_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number (CMT_NUM)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status (CMT_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type (CMT_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'purchase_order|requisition|fund_reservation');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount (CMT_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity (CMT_QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code (COST_ELEM_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Commitment Description (CMT_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date (EXP_DELIV_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `is_funds_reserved` SET TAGS ('dbx_business_glossary_term' = 'Funds Reserved Indicator (FUND_RESVD_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `net_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Committed Amount (NET_CMT_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (CMT_NOTES)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier (RESV_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commitment` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (VAR_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Project Plan Version Identifier (PPVID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `baseline_plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Plan Version Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `baseline_plan_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Approver)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `baseline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Baseline Indicator (BI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number (CCN)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount (CVA)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `created_by_department` SET TAGS ('dbx_business_glossary_term' = 'Created By Department (CBD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CCY)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `plan_version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description (VD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `freeze_date` SET TAGS ('dbx_business_glossary_term' = 'Version Freeze Date (VFD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (IAF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (LRB)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LRT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count (MC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `plan_version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status (VS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `plan_version_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration (Days) (PDD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days) (SVD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost (TPC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `version_comment` SET TAGS ('dbx_business_glossary_term' = 'Version Comment (VC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `version_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Project Plan Version Number (VPN)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Project Plan Version Type (PVT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'original|rebaseline|what-if');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Code (WBS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`plan_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Assignment Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Project Activity Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `replaced_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Resource Assignment Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `replaced_resource_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role (ROLE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'engineer|technician|foreman|contractor|manager');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `billing_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'billable|non_billable|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `cost_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `cost_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate Currency (CUR)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Overtime Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `resource_utilization_category` SET TAGS ('dbx_business_glossary_term' = 'Resource Utilization Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `resource_utilization_category` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temp|contract');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level (LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`resource_assignment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_item_id` SET TAGS ('dbx_business_glossary_term' = 'Project Procurement Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `blanket_procurement_item_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Procurement Item Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `blanket_procurement_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Header ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `actual_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `expected_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expected Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|paid|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `is_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `is_received` SET TAGS ('dbx_business_glossary_term' = 'Received Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|released|ordered|received|invoiced|closed');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'capital|services|materials|equipment|software|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'internal|external|direct|indirect');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Receipt Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`procurement_item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `project_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Project Status Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `preceding_project_status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Project Status Event Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `preceding_project_status_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `approval_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `event_comment` SET TAGS ('dbx_business_glossary_term' = 'Event Comment');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Reason');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|approval|milestone|cancellation');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `is_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Is Audit Trail');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Project Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Project Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Project Issue ID (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `alarm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Event Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_related_project_project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier (Project ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `parent_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Issue Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `parent_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `primary_issue_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier (Owner ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `primary_issue_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `primary_issue_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element ID (WBS ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `action_items` SET TAGS ('dbx_business_glossary_term' = 'Action Items (Action Items)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Impact (Actual Cost)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date (Actual Date)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created At)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description (Description)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status (Escalation Status)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'none|escalated|pending_review');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact (Estimated Cost)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Identified Timestamp (Identified At)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Impact Level (Impact)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `impact` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Identifier (ISSUE_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status (Status)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type (e.g., Risk, Issue, Change Request, Blocker)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'risk|issue|change_request|blocker');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan (Mitigation Plan)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (Priority)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage (Prob%)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Risk Score)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (Root Cause)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (Severity)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date (Target Date)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated At)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Project Change Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `superseded_project_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Project Change Request Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `superseded_project_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `tertiary_project_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `tertiary_project_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `tertiary_project_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Related WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'scope|schedule|cost|technical|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `cost_delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Delta Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `cost_delta_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Delta Currency');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_change_request_description` SET TAGS ('dbx_business_glossary_term' = 'Change Request Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Request Priority');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `project_change_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|implemented|closed');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `revised_baseline_reference` SET TAGS ('dbx_business_glossary_term' = 'Revised Baseline Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Change Request Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `schedule_delta_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Delta (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_change_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Project Timesheet ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `corrected_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Timesheet Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `corrected_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `tertiary_timesheet_entered_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Entered By ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `tertiary_timesheet_entered_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `tertiary_timesheet_entered_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `timesheet_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `timesheet_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate (Currency per Hour)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Expense Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_flag` SET TAGS ('dbx_business_glossary_term' = 'Expense Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'travel|material|tool|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'regular|overtime|holiday|sick|training|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `labor_grade` SET TAGS ('dbx_business_glossary_term' = 'Labor Grade');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `labor_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `labor_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing|custom');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` SET TAGS ('dbx_subdomain' = 'delivery_closeout');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `commissioning_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Checklist Identifier (CHKLIST_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQUIP_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `parent_commissioning_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Commissioning Checklist Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `parent_commissioning_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ENG_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Identifier (VENDOR_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Hours (ACT_DURATION_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (ACT_END_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (ACT_START_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status of Checklist (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference Identifier (CO_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `checklist_number` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Checklist Number (CHKLIST_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Checklist Type (CHKLIST_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_value_regex' = 'mechanical_completion|pre_commissioning|commissioning|startup');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments or Remarks (COMMENTS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `commissioning_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Lifecycle Status (CHKLIST_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `commissioning_checklist_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|closed|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Checklist Completion Date (COMPLETION_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Standard (COMPLIANCE_STD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'ISO9001|ISO14001|ISO45001|IEC62443|NIST|OSHA');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code for Cost (COST_CURR_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (COST_ESTIMATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reference to Supporting Documentation (DOC_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Hours (EST_DURATION_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checklist Execution Timestamp (CHKLIST_EVENT_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `failed_item_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Failed Checklist Items (FAILED_ITEM_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator (CRITICAL_PATH_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `is_environmental_review_done` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Completion Flag (ENV_REVIEW_DONE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `is_external_vendor_involved` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Involvement Flag (VENDOR_INVOLVED)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `is_overtime_required` SET TAGS ('dbx_business_glossary_term' = 'Overtime Requirement Flag (OVERTIME_REQUIRED)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `is_training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Flag (TRAINING_REQUIRED)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Checklist Items (LINE_ITEM_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `overall_pass` SET TAGS ('dbx_business_glossary_term' = 'Overall Checklist Pass Indicator (OVERALL_PASS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Required (OVERTIME_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `passed_item_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Passed Checklist Items (PASSED_ITEM_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `punch_list_item_count` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Count (PUNCH_LIST_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `quality_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Quality Sign‑Off Confirmation (QUALITY_SIGN_OFF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Checklist Revision Number (REVISION_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Assessment (RISK_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `safety_sign_off` SET TAGS ('dbx_business_glossary_term' = 'Safety Sign‑Off Confirmation (SAFETY_SIGN_OFF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date (SCHED_END_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date (SCHED_START_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `system_scope` SET TAGS ('dbx_business_glossary_term' = 'System or Subsystem Scope (SYSTEM_SCOPE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date (TRAINING_COMP_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`commissioning_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` SET TAGS ('dbx_subdomain' = 'delivery_closeout');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `parent_punch_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Punch List Item Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `parent_punch_list_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Punch List Comments');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_description` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `item_number` SET TAGS ('dbx_value_regex' = '^PLI-d{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z0-9]{2,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Punch List Priority');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_category` SET TAGS ('dbx_business_glossary_term' = 'Punch List Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_category` SET TAGS ('dbx_value_regex' = 'safety|quality|mechanical|electrical|civil');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_status` SET TAGS ('dbx_business_glossary_term' = 'Punch List Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `punch_list_item_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'repair|replace|rework|none');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `responsible_contractor` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contractor');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Punch List Severity');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `sign_off_by` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Person Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `sign_off_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `sign_off_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`punch_list_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` SET TAGS ('dbx_subdomain' = 'delivery_closeout');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_id` SET TAGS ('dbx_business_glossary_term' = 'Project Handover ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Accepting Organization ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Delivering Organization ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `partial_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Partial Handover Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `partial_handover_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `tertiary_handover_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `tertiary_handover_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `tertiary_handover_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `as_built_document_status` SET TAGS ('dbx_business_glossary_term' = 'As‑Built Document Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `as_built_document_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `change_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Order Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Created By User Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_by_user_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `documentation_package_status` SET TAGS ('dbx_business_glossary_term' = 'Documentation Package Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `documentation_package_status` SET TAGS ('dbx_value_regex' = 'complete|partial|missing');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `final_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `final_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Final Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_number` SET TAGS ('dbx_business_glossary_term' = 'Handover Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_status` SET TAGS ('dbx_business_glossary_term' = 'Handover Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|completed');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_type` SET TAGS ('dbx_business_glossary_term' = 'Handover Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `handover_type` SET TAGS ('dbx_value_regex' = 'partial|final');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Handover Location');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `maintenance_plan_details` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Details');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `maintenance_plan_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Transfer Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `outstanding_items_description` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Items Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `outstanding_items_flag` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Items Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `review_meeting_attendees` SET TAGS ('dbx_business_glossary_term' = 'Handover Review Meeting Attendees');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Review Meeting Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Handover Signature Captured');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `signoff_approvals` SET TAGS ('dbx_business_glossary_term' = 'Sign‑off Approvals');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|not_started');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_by_user_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_by_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Handover Value Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`handover` ALTER COLUMN `warranty_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transfer Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` SET TAGS ('dbx_subdomain' = 'delivery_closeout');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `master_project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Master Project Contract Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `master_project_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `primary_project_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'epc|subcontract|consulting|equipment_vendor|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|cost_plus|unit_rate|time_and_materials|other');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `liquidated_damages_clause` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Clause');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `project_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `project_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Contract Value (GCV)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_net` SET TAGS ('dbx_business_glossary_term' = 'Net Contract Value (NCV)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_contract` ALTER COLUMN `value_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `invoice_request_id` SET TAGS ('dbx_business_glossary_term' = 'Project Invoice Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `credited_invoice_request_id` SET TAGS ('dbx_business_glossary_term' = 'Credited Invoice Request Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `credited_invoice_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount (Currency Amount)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount (After Tax)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `billing_basis` SET TAGS ('dbx_business_glossary_term' = 'Billing Basis (e.g., Milestone, Percentage, Time and Material, Fixed Price)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `billing_basis` SET TAGS ('dbx_value_regex' = 'milestone|percentage|time_and_material|fixed_price');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `invoice_request_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Request Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `discount_reason` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `invoice_request_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Request Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `invoice_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|issued');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `is_advance` SET TAGS ('dbx_business_glossary_term' = 'Advance Invoice Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Project Percent Complete for Billing');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Request Number (REQ_NUM)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Request Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`invoice_request` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `earned_value_record_id` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `previous_earned_value_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Earned Value Record Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `previous_earned_value_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Work Performed (ACWP) – Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `baseline_version` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `cost_performance_index` SET TAGS ('dbx_business_glossary_term' = 'Cost Performance Index (CPI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance (CV)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Performed (BCWP) – Earned Value');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `earned_value_record_status` SET TAGS ('dbx_business_glossary_term' = 'Earned Value Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `estimate_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Estimate at Completion (EAC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `estimate_to_complete` SET TAGS ('dbx_business_glossary_term' = 'Estimate to Complete (ETC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'parametric|expert|historical|none');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `is_forecast` SET TAGS ('dbx_business_glossary_term' = 'Forecast Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost of Work Scheduled (BCWS) – Planned Value');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `schedule_performance_index` SET TAGS ('dbx_business_glossary_term' = 'Schedule Performance Index (SPI)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `schedule_variance` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (SV)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`earned_value_record` ALTER COLUMN `variance_at_completion` SET TAGS ('dbx_business_glossary_term' = 'Variance at Completion (VAC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` SET TAGS ('dbx_subdomain' = 'delivery_closeout');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `project_document_id` SET TAGS ('dbx_business_glossary_term' = 'Project Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Related WBS Element ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `superseded_project_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Project Document Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `superseded_project_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Document Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `approver` SET TAGS ('dbx_business_glossary_term' = 'Document Approver');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `approver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `approver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Document Archive Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Document Author');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `author` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `author` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Document Checksum');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Document Country of Origin');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Document Distribution List');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `document_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `electronic_signature_present` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Present Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (Bytes)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Document Archived Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `is_controlled` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `is_electronic` SET TAGS ('dbx_business_glossary_term' = 'Electronic Document Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Document Keywords');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRE|GER|CHN|JPN');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'Document MIME Type');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `originator` SET TAGS ('dbx_business_glossary_term' = 'Document Originator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `originator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `originator` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `project_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `project_document_status` SET TAGS ('dbx_value_regex' = 'draft|issued|approved|archived|retracted');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period (Years)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Document Review Cycle (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Document Revision');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Document Signed By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Document Signed Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Document Subcategory');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`project_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `predecessor_phase_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Phase Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `predecessor_phase_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Phase Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Phase Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Phase End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Phase Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Phase Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Phase Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Phase Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_description` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `gate_review_criteria` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Criteria');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Phase Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Milestone Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Project Phase Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Phase Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Phase Completion Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `planned_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Phase Duration (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Phase End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Phase Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Phase Risk Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Phase Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Phase Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Phase Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`phase` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Code');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Project Team Member ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Person Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `reports_to_team_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Team Member Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `reports_to_team_member_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `reports_to_team_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `reports_to_team_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'System Access Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read|write|admin');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `authority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|executive');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `cost_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `cost_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate Currency');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_member_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `team_member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|completed|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`team_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` SET TAGS ('dbx_subdomain' = 'schedule_execution');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `progress_report_id` SET TAGS ('dbx_business_glossary_term' = 'Project Progress Report ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `previous_progress_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Progress Report Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `previous_progress_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Report Author ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Report Author Name');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `author_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `author_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `budgeted_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Cost');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `forecast_percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Forecast Percent Complete');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `issues_and_risks` SET TAGS ('dbx_business_glossary_term' = 'Issues and Risks Summary');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `key_accomplishments` SET TAGS ('dbx_business_glossary_term' = 'Key Accomplishments');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall RAG Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'red|amber|green');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Cadence');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `reporting_cadence` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'on_track|behind|ahead');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `upcoming_activities` SET TAGS ('dbx_business_glossary_term' = 'Upcoming Activities');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`progress_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` SET TAGS ('dbx_subdomain' = 'cost_control');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Settlement ID (PROJECT_SETTLEMENT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `primary_reversal_of_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Settlement ID (REVERSAL_OF_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID (APPROVER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Work Breakdown Structure (WBS) Element ID (SENDER_WBS_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount (GROSS_AMOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount (NET_AMOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status of Settlement (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code (COST_ELEMENT_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURRENCY_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Description (SETTLEMENT_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `external_document_reference` SET TAGS ('dbx_business_glossary_term' = 'External Document Reference (EXT_DOC_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `is_manual_settlement` SET TAGS ('dbx_business_glossary_term' = 'Manual Settlement Indicator (IS_MANUAL)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period (POSTING_PERIOD)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `receiver_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Receiver Object Identifier (RECEIVER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `receiver_object_type` SET TAGS ('dbx_business_glossary_term' = 'Receiver Object Type (RECEIVER_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `receiver_object_type` SET TAGS ('dbx_value_regex' = 'cost_center|fixed_asset|internal_order|profitability_segment');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (IS_REVERSAL)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Applied (SETTLEMENT_RULE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SETTLEMENT_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Project Settlement Document Number (SETTLEMENT_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status (SETTLEMENT_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `source_system_settlement_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Settlement Identifier (SRC_SYS_SETTLEMENT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Tax Amount (TAX_AMOUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` SET TAGS ('dbx_subdomain' = 'project_governance');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_review_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Review ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `deferred_gate_review_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Gate Review Id');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `deferred_gate_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Regulatory Compliance State at Review)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Conditions Attached (Requirements for Proceeding)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (When the Gate Review Record Was Created)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217 Currency Identifier)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome (Result of Gate Review)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'proceed|hold|kill|recycle');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason (Explanation for Outcome)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `financial_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Re‑Authorization Status (Financial Approval State)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `financial_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_name` SET TAGS ('dbx_business_glossary_term' = 'Gate Name (Descriptive Phase Name)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_number` SET TAGS ('dbx_business_glossary_term' = 'Gate Number (Sequential Identifier)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_sequence` SET TAGS ('dbx_business_glossary_term' = 'Gate Sequence (Order of Gates in Project Lifecycle)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_business_glossary_term' = 'Gate Type (Category of Review Phase)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_value_regex' = 'concept');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_design' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_prototype' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_production' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `gate_type` SET TAGS ('dbx_commissioning' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical (Indicates Whether Gate Is Critical to Project Success)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `next_gate_target_date` SET TAGS ('dbx_business_glossary_term' = 'Next Gate Target Date (Planned Date for Subsequent Gate Review)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Additional Free‑Form Comments Regarding the Gate Review)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `reauthorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Reauthorized Amount (Financial Amount Re‑Authorized at Gate)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `review_board` SET TAGS ('dbx_business_glossary_term' = 'Review Board Members (Names of Decision Makers)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `review_board` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `review_board` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Timestamp (Date and Time of Review Decision)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary (High-Level Risk Evaluation)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (Risk Rating for the Gate)');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`project`.`gate_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (When the Gate Review Record Was Last Modified)');
