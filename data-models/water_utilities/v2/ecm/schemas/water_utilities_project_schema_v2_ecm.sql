-- Schema for Domain: project | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`project` COMMENT 'Capital improvement program (CIP) and project management including project planning, design management, construction management, contractor coordination, project budgeting and cost control, schedule tracking, change order management, commissioning, and asset handover. Manages infrastructure expansion, rehabilitation, and renewal projects from concept through operational turnover.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`cip_project` (
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the CIP project. Primary key for the cip_project data product.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned as project manager, responsible for planning, execution, and delivery. Links to workforce or employee master data.',
    `cip_project_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: CIP projects require environmental/discharge permits before construction. Project managers track permit compliance for regulatory approval and construction authorization. Essential for permit complian',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Capital projects are justified by service capacity needs for specific offerings (e.g., potable water treatment expansion, industrial wastewater service). Project business cases and regulatory filings',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capital projects are often mandated by regulatory requirements (Lead and Copper Rule, SDWA standards, consent decrees). Tracking the driving requirement justifies capital expenditure and enables compl',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Every capital project serves or expands a specific service territory. Project planning, regulatory permit applications, rate case justifications, and asset handover to operations all require territory',
    `actual_completion_date` DATE COMMENT 'Actual date the project was completed and accepted for operational turnover. Null if project is not yet complete.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred on the project from inception through the current reporting period. Includes committed and paid amounts.',
    `actual_start_date` DATE COMMENT 'Actual date the project or construction phase commenced. Null if project has not yet started.',
    `asset_class` STRING COMMENT 'Type of asset being constructed, rehabilitated, or replaced (e.g., water_main, pump_station, treatment_plant, storage_tank, meter_infrastructure, SCADA_system). Aligns with asset registry classification.',
    `authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount authorized for the project by governing board or executive approval. Represents the funding ceiling for all project expenditures including design, construction, contingency, and administrative costs.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all project financial amounts (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `change_order_count` STRING COMMENT 'Total number of approved change orders issued for the project. Indicates scope changes, unforeseen conditions, or design modifications.',
    `cip_program_year` STRING COMMENT 'Fiscal year in which the project was authorized and budgeted within the CIP plan (e.g., 2024). Used for multi-year CIP planning and tracking.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Dollar amount the project is under (negative) or over (positive) budget. Calculated as estimated total cost minus authorized budget amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CIP project record was first created in the system. Represents the initial capture of the project in the data platform.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity of the asset being constructed or upgraded, measured in million gallons per day (MGD). Applicable to treatment plants, pump stations, and conveyance infrastructure. Null for non-capacity projects.',
    `environmental_review_status` STRING COMMENT 'Status of environmental review process (NEPA, CEQA, or state equivalent): not_required (no review needed), pending (not yet started), in_progress (under review), completed (review finished), approved (clearance granted).. Valid values are `not_required|pending|in_progress|completed|approved`',
    `estimated_customers_impacted` STRING COMMENT 'Estimated number of customer accounts or service connections affected by the project during construction or upon completion. Used for outreach planning and benefit analysis.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Current estimate of total project cost including all phases, change orders, and contingencies. Updated throughout project lifecycle as scope and conditions evolve.',
    `forecast_completion_date` DATE COMMENT 'Current forecast for project completion based on progress, schedule changes, and known delays. Updated regularly throughout project lifecycle.',
    `funding_source` STRING COMMENT 'Primary source of project funding (e.g., revenue_bonds, general_obligation_bonds, state_revolving_fund, federal_grant, rate_revenue, developer_contribution). May reference multiple sources for blended financing.',
    `infrastructure_category` STRING COMMENT 'Primary infrastructure system served by the project: water (treatment and distribution), wastewater (collection and treatment), shared (benefits both systems), stormwater (drainage and management), or other.. Valid values are `water|wastewater|shared|stormwater|other`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the CIP project record. Used for change tracking and data freshness monitoring.',
    `operational_turnover_date` DATE COMMENT 'Date the completed asset was formally transferred from the project team to operations and maintenance for ongoing management. Marks the end of the project lifecycle and start of asset operational life.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage of project completion based on earned value, milestones achieved, or physical progress. Range 0.00 to 100.00.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether the project requires regulatory permits (e.g., construction permits, environmental permits, discharge permits). True if permits are required; false otherwise.',
    `planned_completion_date` DATE COMMENT 'Originally planned date for project completion and operational turnover. Used for baseline schedule tracking and variance analysis.',
    `planned_start_date` DATE COMMENT 'Originally planned date for project initiation or construction start. Used for baseline schedule tracking and variance analysis.',
    `priority_tier` STRING COMMENT 'Business priority ranking for the project based on risk, regulatory mandate, service impact, and strategic alignment. Critical projects address immediate safety or compliance issues; deferred projects are postponed pending funding.. Valid values are `critical|high|medium|low|deferred`',
    `project_description` STRING COMMENT 'Detailed narrative describing the project scope, objectives, and expected outcomes. Includes technical specifications, service area impact, and business justification.',
    `project_manager_name` STRING COMMENT 'Full name of the project manager assigned to lead the CIP project. Denormalized for reporting convenience.',
    `project_name` STRING COMMENT 'Full descriptive name of the CIP project (e.g., Main Street Water Main Replacement Phase 2, North WWTP Clarifier Upgrade).',
    `project_number` STRING COMMENT 'Business identifier for the CIP project, typically formatted as program code followed by sequential number (e.g., WTP-2024-001). Used in external communications, contracts, and regulatory filings.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,6}$`',
    `project_phase` STRING COMMENT 'Current lifecycle phase of the CIP project: concept (initial scoping), planning (feasibility and alternatives analysis), design (engineering drawings and specifications), procurement (contractor selection), construction (field execution), commissioning (testing and startup), closeout (final documentation and handover), operational (asset in service). [ENUM-REF-CANDIDATE: concept|planning|design|procurement|construction|commissioning|closeout|operational — 8 candidates stripped; promote to reference product]',
    `project_status` STRING COMMENT 'Current operational status of the project: active (work progressing), on_hold (temporarily paused), delayed (behind schedule), cancelled (terminated before completion), completed (finished and closed).. Valid values are `active|on_hold|delayed|cancelled|completed`',
    `project_type` STRING COMMENT 'Classification of the CIP project by nature of work: expansion (capacity increase), rehabilitation (restore to original condition), renewal (extend useful life), replacement (like-for-like), upgrade (improve performance), new_construction (greenfield), or regulatory_compliance (mandated by regulation). [ENUM-REF-CANDIDATE: expansion|rehabilitation|renewal|replacement|upgrade|new_construction|regulatory_compliance — 7 candidates stripped; promote to reference product]',
    `regulatory_driver` STRING COMMENT 'Regulatory mandate or compliance requirement driving the project (e.g., SDWA Lead and Copper Rule Revisions, NPDES permit condition, consent decree requirement, state water quality standard). Null for non-compliance projects.',
    `schedule_variance_days` STRING COMMENT 'Number of days the project is ahead (negative) or behind (positive) the baseline schedule. Calculated as forecast completion date minus planned completion date.',
    `service_area_description` STRING COMMENT 'Geographic description of the service area or customer base impacted by the project (e.g., Downtown District, North Service Zone, Industrial Park customers). Used for customer communication and impact analysis.',
    `sponsoring_department` STRING COMMENT 'Organizational department or division that owns and sponsors the project (e.g., Water Operations, Wastewater Treatment, Engineering, Asset Management). Responsible for project outcomes and operational handover.',
    `substantial_completion_date` DATE COMMENT 'Date the project reached substantial completion per contract terms, meaning the asset is functional and can be used for its intended purpose, though minor punch-list items may remain.',
    `warranty_expiration_date` DATE COMMENT 'Date the contractor warranty period expires for the completed project. Typically one year from substantial completion for construction work.',
    CONSTRAINT pk_cip_project PRIMARY KEY(`cip_project_id`)
) COMMENT 'Master record for Capital Improvement Program (CIP) projects covering infrastructure expansion, rehabilitation, and renewal initiatives. Tracks project identity, scope, classification (water/wastewater/shared), CIP program year, funding authorization, project phase (planning, design, construction, commissioning, closeout), priority tier, sponsoring department, project manager assignment, phase classification, project type classification, and lifecycle dates from concept through operational turnover. The authoritative SSOT for all CIP project identity, classification, and status within the utility.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique identifier for the WBS element. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class to which completed work from this WBS element will be capitalized. Used for asset handover and capitalization.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project to which this WBS element belongs.',
    `parent_wbs_element_id` BIGINT COMMENT 'Reference to the parent WBS element in the hierarchy. Null for top-level elements.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for executing and managing this WBS element.',
    `account_assignment_category` STRING COMMENT 'Classification of costs for this WBS element as capital expenditure (CAPEX), operating expenditure (OPEX), or mixed.. Valid values are `capital|operating|mixed`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual costs incurred to date for this WBS element. Includes labor, materials, equipment, and contractor costs.',
    `actual_finish_date` DATE COMMENT 'Actual date when this WBS element was completed. Null if not yet finished.',
    `actual_start_date` DATE COMMENT 'Actual date when work on this WBS element commenced. Null if not yet started.',
    `baseline_finish_date` DATE COMMENT 'Baseline (original approved) finish date for this WBS element, used for schedule variance analysis.',
    `baseline_start_date` DATE COMMENT 'Baseline (original approved) start date for this WBS element, used for schedule variance analysis.',
    `billing_element_flag` BOOLEAN COMMENT 'Indicates whether this WBS element is a billing element (True) or a planning element only (False). Billing elements can be invoiced to external parties or internal cost centers.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to this WBS element. Supports granular cost control at the work package level.',
    `change_order_count` STRING COMMENT 'Number of approved change orders affecting this WBS element. Used for change management tracking and trend analysis.',
    `wbs_element_code` STRING COMMENT 'Externally visible unique code for the WBS element, typically hierarchical (e.g., P-12345.01.02). Used for reporting and integration with financial systems.',
    `commissioning_required_flag` BOOLEAN COMMENT 'Indicates whether formal commissioning and testing are required before this WBS element can be closed (True/False).',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total committed costs (purchase orders, contracts) against this WBS element. Used for funds reservation tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this WBS element (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `wbs_element_description` STRING COMMENT 'Detailed description of the scope, deliverables, and objectives of this WBS element.',
    `earned_value` DECIMAL(18,2) COMMENT 'Earned Value (EV) for Earned Value Management (EVM). Represents the budgeted cost of work actually completed to date.',
    `functional_area` STRING COMMENT 'Functional area classification for this WBS element (e.g., Water Treatment, Distribution, Wastewater, Asset Management). Supports cross-functional reporting.',
    `geographic_location` STRING COMMENT 'Geographic location or service area where this WBS element work is being performed (e.g., district, municipality, facility name).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the WBS hierarchy (1 = top-level phase, 2 = deliverable, 3 = work package, etc.). Supports multi-level decomposition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this WBS element record was last modified.',
    `wbs_element_name` STRING COMMENT 'Short descriptive name of the WBS element (e.g., Design Phase, Pipeline Installation, Pump Station Construction).',
    `notes` STRING COMMENT 'Free-text notes and comments related to this WBS element. Used for documenting decisions, issues, and coordination details.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Physical percent complete of this WBS element (0.00 to 100.00). Used for progress tracking and earned value calculation.',
    `planned_finish_date` DATE COMMENT 'Planned completion date for this WBS element.',
    `planned_start_date` DATE COMMENT 'Planned start date for work on this WBS element.',
    `planned_value` DECIMAL(18,2) COMMENT 'Planned Value (PV) for Earned Value Management (EVM). Represents the budgeted cost of work scheduled to be completed by a given date.',
    `priority_code` STRING COMMENT 'Priority classification for this WBS element (critical, high, medium, low). Used for resource allocation and schedule conflict resolution.. Valid values are `critical|high|medium|low`',
    `regulatory_permit_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory permits or approvals are required for this WBS element (True/False). Relevant for environmental compliance and construction permits.',
    `responsible_manager_name` STRING COMMENT 'Name of the manager or project lead responsible for this WBS element.',
    `risk_level` STRING COMMENT 'Risk assessment level for this WBS element (high, medium, low). Reflects technical, schedule, and cost risk exposure.. Valid values are `high|medium|low`',
    `settlement_rule` STRING COMMENT 'Rule defining how costs from this WBS element are settled to fixed assets, cost centers, or other receivers upon project completion.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element (planned, released, in progress, completed, closed, cancelled).. Valid values are `planned|released|in_progress|completed|closed|cancelled`',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element by its role in the project structure (phase, deliverable, work package, milestone, planning element).. Valid values are `phase|deliverable|work_package|milestone|planning_element`',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element representing a hierarchical decomposition of a CIP project into manageable work packages. Each WBS element carries its own budget, schedule, and cost tracking. Supports multi-level hierarchy (phase, deliverable, work package) aligned to SAP PS WBS structure. Tracks element code, description, level, responsible cost center, planned/actual start and finish dates, and budget allocation. Enables granular cost control and earned value management (EVM) at the work package level.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the project milestone record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project to which this milestone belongs. Links milestone to the overall infrastructure expansion, rehabilitation, or renewal project.',
    `primary_predecessor_milestone_id` BIGINT COMMENT 'Reference to the preceding milestone that must be completed before this milestone can begin. Used for schedule dependency tracking. Null if no predecessor.',
    `acceptance_criteria` STRING COMMENT 'Specific criteria or conditions that must be met for the milestone to be considered complete and accepted. Used for quality control and stakeholder sign-off.',
    `actual_date` DATE COMMENT 'Actual date when the milestone was achieved or completed. Null if milestone is not yet completed. Used for schedule performance measurement.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved the milestone completion. Used for accountability and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the milestone completion was formally approved. Null if not yet approved. Used for audit trail and compliance documentation.',
    `baseline_date` DATE COMMENT 'Original planned date for milestone completion as established in the approved project baseline schedule. Used as the reference point for schedule variance analysis.',
    `budget_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact or cost associated with achieving this milestone, expressed in US dollars. May include design fees, permit costs, contractor payments, or other milestone-specific expenditures.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed toward achieving this milestone, expressed as a decimal (0.00 to 100.00). Used for progress tracking and earned value analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was first created in the system. Used for audit trail and data lineage.',
    `deliverable_description` STRING COMMENT 'Description of the tangible deliverable or outcome associated with this milestone (e.g., signed design drawings, issued permit, executed contract, commissioned asset). Defines what constitutes milestone completion.',
    `forecast_date` DATE COMMENT 'Current projected date for milestone completion based on latest schedule updates and progress assessments. May differ from baseline due to delays or accelerations.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether this milestone is on the project critical path. True if any delay to this milestone will delay the overall project completion; false otherwise.',
    `is_regulatory_milestone` BOOLEAN COMMENT 'Flag indicating whether this milestone is tied to a regulatory requirement or consent order deadline (e.g., EPA consent decree, state compliance order). True if regulatory; false otherwise.',
    `milestone_number` STRING COMMENT 'Business identifier or sequence number for the milestone within the project (e.g., M-001, M-002). Used for external reporting and communication.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone. Indicates whether the milestone is planned, in progress, completed, delayed, cancelled, or on hold.. Valid values are `planned|in_progress|completed|delayed|cancelled|on_hold`',
    `milestone_type` STRING COMMENT 'Category of milestone within the project lifecycle. Classifies the phase or functional area of the milestone event.. Valid values are `design|permitting|procurement|construction|commissioning|closeout`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was last updated. Used for audit trail and change tracking.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone event (e.g., Design Completion, Permit Issuance, Notice to Proceed, Substantial Completion, Final Completion, Asset Handover).',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the milestone. May include lessons learned, stakeholder feedback, or other relevant information for project team reference.',
    `regulatory_reference` STRING COMMENT 'Reference number or citation for the regulatory requirement or consent order associated with this milestone (e.g., consent decree docket number, permit condition reference). Null if not a regulatory milestone.',
    `responsible_party` STRING COMMENT 'Name or identifier of the party responsible for achieving this milestone (e.g., design consultant, contractor, utility staff, regulatory agency). May be individual or organization.',
    `responsible_party_type` STRING COMMENT 'Classification of the responsible party. Indicates whether the party is internal utility staff, external contractor, consultant, vendor, or regulatory agency.. Valid values are `internal|contractor|consultant|vendor|regulatory_agency`',
    `risk_level` STRING COMMENT 'Assessment of the risk level associated with achieving this milestone on schedule. Considers factors such as complexity, dependencies, resource availability, and external constraints.. Valid values are `low|medium|high|critical`',
    `variance_commentary` STRING COMMENT 'Narrative explanation of any schedule variance, including root causes of delays or early completions, corrective actions taken, and impact on downstream milestones. Used for project status reporting.',
    `variance_days` STRING COMMENT 'Number of days between baseline date and actual or forecast date. Positive values indicate delay; negative values indicate early completion. Used for schedule performance reporting.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Scheduled and actual milestone events within a CIP project lifecycle including design completion, permit issuance, notice to proceed (NTP), substantial completion, final completion, and asset handover. Tracks milestone type, baseline date, forecast date, actual date, responsible party, completion status, and any variance commentary. Used for schedule performance reporting and regulatory deadline tracking (e.g., consent order milestones).';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key for the project budget entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent Capital Improvement Program (CIP) project or capital project for which this budget is authorized.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgets allocate to cost centers for overhead allocation, departmental accountability, and indirect cost recovery calculations required for rate-making and grant compliance.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Project budgets must tie to specific utility funds for GASB fund accounting compliance, rate case documentation, and fund balance management. Essential for governmental accounting standards.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Project budgets map to GL accounts for financial reporting, budget-to-actual variance analysis, and GASB capital asset classification. Critical for financial statement preparation.',
    `finance_budget_id` BIGINT COMMENT '',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditures posted to this budget to date. Sum of all invoices, payments, and costs charged against this project budget.',
    `appropriation_ordinance_number` STRING COMMENT 'Municipal ordinance or resolution number that legally authorized this budget appropriation. Required for public sector utilities subject to legislative budget approval.',
    `approval_date` DATE COMMENT 'Date on which this budget was formally approved by the governing authority such as the utility board, city council, or public utilities commission.',
    `approved_amendments_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount of approved budget amendments, change orders, and supplemental appropriations that have been added to or subtracted from the original budget.',
    `bond_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded by municipal bonds, revenue bonds, or general obligation bonds issued to finance capital improvements.',
    `budget_category` STRING COMMENT 'High-level budget category classification such as treatment plant upgrades, distribution system expansion, wastewater collection rehabilitation, or meter replacement program.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record indicating approval state and whether the budget is active for expenditure tracking.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `capex_amount` DECIMAL(18,2) COMMENT 'Portion of the budget classified as capital expenditure (CAPEX) that will be capitalized as a fixed asset. Represents investment in long-term infrastructure assets.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Budget amount set aside as contingency reserve for unforeseen costs, scope changes, or risk mitigation. Typically a percentage of the base construction budget.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Contingency reserve expressed as a percentage of the base project budget. Common practice is 10-20% for water utility CIP projects depending on project complexity and risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system. Supports audit trail and budget lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `current_approved_budget_amount` DECIMAL(18,2) COMMENT 'Current total authorized budget amount including original budget plus all approved amendments. This is the active budget ceiling for expenditure control.',
    `effective_date` DATE COMMENT 'Date from which this budget becomes effective and available for expenditure authorization. May differ from approval date due to fiscal year or appropriation timing.',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'Total amount of budget that has been encumbered through purchase orders, contracts, or commitments but not yet expended. Represents committed but unspent funds.',
    `expiration_date` DATE COMMENT 'Date on which this budget authorization expires if not fully expended or encumbered. Multi-year CIP budgets may have extended expiration dates.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this budget is authorized, typically a four-digit year (e.g., 2024). Aligns with municipal or utility fiscal calendar.',
    `funding_source_primary` STRING COMMENT 'Primary funding source for this budget allocation such as revenue bonds, general obligation bonds, grants, rate revenue, developer contributions, or state revolving fund loans.',
    `funding_source_secondary` STRING COMMENT 'Secondary or supplemental funding source if the project budget is financed from multiple sources. Supports blended financing structures common in large CIP projects.',
    `grant_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded by federal, state, or local grants such as EPA Water Infrastructure Finance and Innovation Act (WIFIA) or state drinking water revolving fund grants.',
    `is_multi_year_budget` BOOLEAN COMMENT 'Flag indicating whether this budget spans multiple fiscal years. True for large CIP projects with multi-year appropriations; false for single-year budgets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated or modified. Tracks most recent change to budget amounts, status, or attributes.',
    `last_revision_date` DATE COMMENT 'Date of the most recent budget revision, amendment, or change order that modified the approved budget amount or allocation.',
    `notes` STRING COMMENT 'Free-text notes documenting budget assumptions, constraints, special conditions, or explanations for amendments and revisions. Supports audit trail and budget justification.',
    `opex_amount` DECIMAL(18,2) COMMENT 'Portion of the budget classified as operating expenditure (OPEX) that will be expensed in the current period. Represents operational costs not capitalized.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Initial authorized budget amount at the time of project appropriation or budget approval. Baseline budget before any amendments or revisions.',
    `owner` STRING COMMENT 'Name or identifier of the project manager, department head, or budget owner responsible for managing expenditures against this budget allocation.',
    `phase` STRING COMMENT 'Project phase to which this budget allocation applies. CIP projects typically have budgets segmented by planning, design, construction, contingency, and inspection phases.. Valid values are `planning|design|construction|contingency|inspection|closeout`',
    `rate_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded directly from water and wastewater rate revenue collected from customers. Pay-as-you-go financing from operating cash flow.',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Remaining unencumbered and unexpended budget available for future commitments. Calculated as current approved budget minus encumbrances minus actual expenditures.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking the count of budget amendments or changes. Starts at 0 for original budget and increments with each approved revision.',
    `version` STRING COMMENT 'Version type of the budget record indicating whether this is the original appropriation, a revised budget after amendments, or the current approved budget.. Valid values are `original|revised|amended|current|forecast`',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element code from SAP PS representing the project phase or deliverable to which this budget applies. Hierarchical project structure identifier.',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Authorized budget record for a CIP project or WBS element capturing total project appropriation, budget by phase (planning, design, construction, contingency, inspection), CAPEX vs OPEX split, funding source allocations, budget revision history, and current approved budget. Tracks original budget, approved amendments, current budget, encumbrances, actual expenditures, and remaining budget. Integrates with SAP FI/CO for financial control and Tyler Munis for municipal budget appropriation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` (
    `budget_amendment_id` BIGINT COMMENT 'Unique identifier for the budget amendment record. Primary key for the budget amendment entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project for which this budget amendment applies. Links the amendment to the parent capital project.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget amendments adjust cost center budgets and require cost center manager approval for budget reallocation. Essential for departmental budget control.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Budget amendments adjust fund appropriations and require fund manager approval. Critical for fund balance management and compliance with appropriation ordinances.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budget amendments adjust GL account budgets for financial planning and control. Required for budget-to-actual reporting and variance analysis.',
    `amendment_amount` DECIMAL(18,2) COMMENT 'The dollar value of the budget change. Positive values indicate budget increases; negative values indicate budget decreases or deobligations.',
    `amendment_number` STRING COMMENT 'Sequential or coded identifier for this amendment within the project lifecycle. Used for tracking and referencing specific budget modifications.. Valid values are `^[A-Z0-9]{2,20}$`',
    `amendment_status` STRING COMMENT 'Current state of the amendment in the approval workflow. Tracks progression from draft through final approval or rejection. [ENUM-REF-CANDIDATE: draft|pending_review|pending_approval|approved|rejected|withdrawn|superseded — 7 candidates stripped; promote to reference product]',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the budget change. Indicates whether the amendment is due to scope changes, contingency usage, emergency needs, cost overruns, schedule adjustments, or funding reallocations.. Valid values are `scope_change|contingency_draw|emergency_authorization|cost_overrun|schedule_adjustment|funding_reallocation`',
    `approval_authority` STRING COMMENT 'The governance level or role authorized to approve this amendment. Indicates whether board/commission approval was required or if the amendment was within delegated authority thresholds.. Valid values are `board|commission|executive_director|finance_director|project_manager|delegated_authority`',
    `approval_date` DATE COMMENT 'The date on which the budget amendment received final approval from the designated authority. Establishes the effective date for the revised budget.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The dollar threshold that determines the required approval authority level for this amendment. Amendments exceeding this threshold require higher-level governance approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or governance body that granted final approval for the amendment. Documents authorization in the approval workflow.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for capturing additional audit and compliance notes related to the amendment. Supports regulatory reporting and internal controls documentation.',
    `board_resolution_number` STRING COMMENT 'Official resolution or ordinance number issued by the governing board or commission authorizing the amendment. Required for amendments exceeding delegated authority thresholds.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `contingency_amount_used` DECIMAL(18,2) COMMENT 'The dollar amount of project contingency reserve consumed by this amendment. Tracks depletion of risk mitigation funds.',
    `contingency_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment draws from or affects the project contingency reserve. True if contingency funds are utilized; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was first created in the system. Provides audit trail for record inception.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which the amended budget is in force and governs project financial management. May differ from approval date based on governance rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was most recently updated. Tracks the latest change to the record for audit and data quality purposes.',
    `meeting_date` DATE COMMENT 'The date of the board or commission meeting at which the amendment was presented and approved. Provides governance audit trail.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The project budget amount prior to this amendment. Provides baseline for calculating the revised budget and tracking cumulative changes.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the budget amendment. Used for categorization, reporting, and trend analysis of budget modifications.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the business justification and circumstances necessitating the budget amendment. Provides context for audit and governance review.',
    `remaining_contingency` DECIMAL(18,2) COMMENT 'The balance of contingency funds available after this amendment. Provides visibility into remaining risk buffer for the project.',
    `request_date` DATE COMMENT 'The date on which the budget amendment was formally requested. Marks the initiation of the amendment approval workflow.',
    `requested_by` STRING COMMENT 'Name or identifier of the individual or role who initiated the budget amendment request. Provides accountability and audit trail.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The resulting total project budget after applying this amendment. Calculated as original budget plus amendment amount.',
    `schedule_impact_days` STRING COMMENT 'The number of calendar days by which the project schedule is extended or compressed as a result of this amendment. Positive values indicate delays; negative values indicate acceleration.',
    `scope_change_description` STRING COMMENT 'Detailed description of any project scope modifications associated with this budget amendment. Documents changes to deliverables, specifications, or project boundaries.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation for the amendment, such as cost estimates, change orders, engineering reports, or board memos.',
    CONSTRAINT pk_budget_amendment PRIMARY KEY(`budget_amendment_id`)
) COMMENT 'Formal record of an approved change to a project budget appropriation including amendment number, reason code (scope change, contingency draw, emergency authorization), amount delta (increase or decrease), approval authority, approval date, and resulting revised budget total. Maintains a complete audit trail of all budget modifications from original appropriation through project closeout. Supports board/commission approval workflows for amendments exceeding threshold amounts.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`design_contract` (
    `design_contract_id` BIGINT COMMENT 'Unique identifier for the engineering and design services contract record. Primary key for the design contract entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project for which this design contract was executed. Links the design services agreement to the infrastructure project it supports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Design contracts charge to cost centers for project overhead allocation and departmental budget tracking. Required for indirect cost recovery.',
    `employee_id` BIGINT COMMENT 'Reference to the utility employee responsible for contract administration, including invoice review, amendment processing, and compliance monitoring. Links to the workforce or employee master record.',
    `design_employee_id` BIGINT COMMENT 'Reference to the utility employee serving as project manager responsible for overseeing the design contract. Links to the workforce or employee master record.',
    `vendor_id` BIGINT COMMENT 'Reference to the professional engineering firm or consultant providing design services under this contract. Links to the vendor or party master record.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Design contracts are funded from specific utility funds and require fund commitment tracking for multi-year appropriation control. Essential for fund accounting.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Design contracts for pressure zone improvements (PRV stations, pump stations, storage tanks) must reference the specific pressure zone being served for hydraulic modeling, design criteria selection, a',
    `primary_design_employee_id` BIGINT COMMENT 'Reference to the utility employee serving as project manager responsible for overseeing the design contract. Links to the workforce or employee master record.',
    `primary_design_vendor_id` BIGINT COMMENT 'Reference to the professional engineering firm or consultant providing design services under this contract. Links to the vendor or party master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Design contracts must incorporate specific regulatory standards (Ten States Standards, EPA design criteria, state-specific requirements). Engineers reference requirements during design review and subm',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Design contracts specify the service territory for regulatory compliance (jurisdiction-specific design standards, permit requirements) and cost allocation. Engineering firms need territory context for',
    `actual_completion_date` DATE COMMENT 'Actual date on which all design services were completed and final deliverables were accepted by the utility. Used to measure schedule performance.',
    `amendment_value` DECIMAL(18,2) COMMENT 'Cumulative value in US dollars of all executed contract amendments and change orders. Positive values represent scope additions; negative values represent reductions. Sum of all amendment amounts applied to the original contract value.',
    `construction_administration_included` BOOLEAN COMMENT 'Boolean flag indicating whether the design contract includes construction administration (CA) services during the build phase. CA services typically include shop drawing review, site visits, request for information (RFI) responses, and substantial completion certification.',
    `contract_duration_days` STRING COMMENT 'Total number of calendar days allocated for completion of design services, from notice to proceed to scheduled completion. Baseline duration established at contract execution.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the design services contract. Used in procurement documents, invoices, and regulatory filings.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the design services contract. Draft contracts are being prepared; pending approval awaits authorization; executed contracts are signed but work has not started; active contracts have ongoing work; suspended contracts are temporarily paused; completed contracts have delivered all services; closed contracts are administratively finalized; terminated contracts were ended early. [ENUM-REF-CANDIDATE: draft|pending_approval|executed|active|suspended|completed|closed|terminated — 8 candidates stripped; promote to reference product]',
    `contract_title` STRING COMMENT 'Descriptive title of the design services contract, typically including the project name and scope summary (e.g., Preliminary Engineering Report and Design for Main Street Water Treatment Plant (WTP) Expansion).',
    `contract_type` STRING COMMENT 'Classification of the professional services contract pricing structure. Lump sum contracts have a fixed price for defined deliverables; time and materials (T&M) contracts bill actual hours and expenses; cost-plus contracts reimburse costs plus a fee or percentage; unit price contracts pay per defined unit of work; indefinite delivery contracts establish rates for on-call services.. Valid values are `lump_sum|time_and_materials|cost_plus_fixed_fee|cost_plus_percentage|unit_price|indefinite_delivery`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design contract record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value in US dollars, calculated as original contract value plus all executed amendments. Represents the current authorized budget for design services.',
    `deliverable_schedule` STRING COMMENT 'Structured schedule of key design deliverables and their due dates. Typically includes milestones such as preliminary engineering report (PER) submission, 30% design review, 60% design review, 90% design review, final construction documents, and permit applications.',
    `design_phase` STRING COMMENT 'Current or primary phase of design services covered by this contract. Preliminary engineering includes feasibility studies and PER; conceptual and schematic design establish project approach; detailed design produces technical specifications; construction documents are bid-ready plans; bidding support assists procurement; construction administration provides oversight during build. [ENUM-REF-CANDIDATE: preliminary_engineering|conceptual_design|schematic_design|detailed_design|construction_documents|bidding_support|construction_administration — 7 candidates stripped; promote to reference product]',
    `design_standard_reference` STRING COMMENT 'Reference to the primary design standards and codes governing the engineering work. Typically includes AWWA standards, Ten States Standards (for water and wastewater), state-specific design manuals, and local utility design criteria.',
    `disadvantaged_business_enterprise_participation` DECIMAL(18,2) COMMENT 'Percentage of contract value committed to disadvantaged business enterprise (DBE) or minority/women-owned business enterprise (M/WBE) participation. Required for federally-funded projects to meet EPA and USDA diversity goals.',
    `engineering_firm_name` STRING COMMENT 'Legal name of the engineering firm or consultant providing design services. Captured for reporting and audit purposes.',
    `environmental_review_status` STRING COMMENT 'Status of environmental review and compliance documentation required for the project. May include National Environmental Policy Act (NEPA) review, State Environmental Quality Review Act (SEQRA), or equivalent state-level environmental assessment.. Valid values are `not_required|pending|in_progress|completed|approved`',
    `execution_date` DATE COMMENT 'Date on which the design services contract was fully executed (signed by all parties). Establishes the legal effective date of the agreement.',
    `grant_number` STRING COMMENT 'Identifier for any federal or state grant funding supporting this design contract. Used for compliance tracking and reporting to funding agencies such as EPA, USDA, or state environmental agencies.',
    `insurance_certificate_received` BOOLEAN COMMENT 'Boolean flag indicating whether the engineering firm has provided required professional liability insurance and general liability insurance certificates. Required before notice to proceed can be issued.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the engineering firms professional liability insurance policy. Monitored to ensure continuous coverage throughout the contract period.',
    `invoiced_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount in US dollars invoiced by the engineering firm to date. Used to track contract spend and remaining budget.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design contract record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, comments, or special conditions related to the design contract. May include lessons learned, performance observations, or administrative notes.',
    `notice_to_proceed_date` DATE COMMENT 'Date on which the utility issued formal notice to proceed (NTP) authorizing the engineering firm to begin design work. Triggers contract performance period and milestone schedule.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'Initial total contract value in US dollars as executed at contract award, before any amendments or change orders. Represents the baseline budget for design services.',
    `paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount in US dollars paid to the engineering firm to date. May differ from invoiced amount due to payment processing lag or retainage.',
    `performance_bond_required` BOOLEAN COMMENT 'Boolean flag indicating whether a performance bond is required for this design services contract. Typically not required for professional services but may be mandated for high-value or high-risk projects.',
    `permit_support_included` BOOLEAN COMMENT 'Boolean flag indicating whether the design contract includes services for preparing and submitting regulatory permit applications. Common permits include NPDES discharge permits, Safe Drinking Water Act (SDWA) construction permits, wetland permits, and local building permits.',
    `procurement_method` STRING COMMENT 'Method used to select and award the design services contract. Qualifications-based selection (QBS) is the standard for professional engineering services per Brooks Act; competitive sealed proposals may be used for design-build; sole source for unique expertise; emergency for urgent needs; cooperative purchasing leverages existing contracts.. Valid values are `qualifications_based_selection|competitive_sealed_proposals|sole_source|emergency_procurement|cooperative_purchasing`',
    `quality_assurance_review_required` BOOLEAN COMMENT 'Boolean flag indicating whether an independent quality assurance (QA) or quality control (QC) review of design documents is required. Often mandated for large or complex projects, or when using federal funding.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Amount in US dollars withheld from payments as retainage to ensure contract performance and deliverable quality. Typically released upon final acceptance of design documents.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of each invoice withheld as retainage. Common values are 5% or 10% for professional services contracts.',
    `scheduled_completion_date` DATE COMMENT 'Contractually scheduled date for completion of all design services and delivery of final deliverables. Baseline date established at contract execution.',
    `scope_of_services` STRING COMMENT 'Detailed description of the engineering and design services to be provided under this contract. Typically includes phases such as preliminary engineering report (PER), conceptual design, detailed design, construction documents, permitting support, bidding assistance, and construction administration.',
    `subconsultant_list` STRING COMMENT 'List of subconsultants and specialty firms engaged by the prime engineering firm to support design services. May include geotechnical engineers, environmental consultants, surveying firms, and other specialists.',
    CONSTRAINT pk_design_contract PRIMARY KEY(`design_contract_id`)
) COMMENT 'Engineering and design services contract record for a CIP project covering professional services agreements with engineering firms for preliminary engineering reports (PER), design development, construction documents, and construction administration. Tracks contract number, engineering firm, contract type (lump sum, T&M, cost-plus), original contract value, executed amendments, current contract value, scope of services, deliverable schedule, and NTP/completion dates. Distinct from construction contracts — design contracts follow a professional services procurement workflow.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` (
    `construction_contract_id` BIGINT COMMENT 'Unique identifier for the construction contract record. Primary key for the construction contract entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project for which this construction contract was awarded. Links the contract to the broader capital project scope.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Construction contracts must comply with permit conditions (NPDES discharge limits during construction, erosion control, stormwater management). Contract administrators track permit compliance and ensu',
    `vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor awarded this construction contract. Links to the vendor/contractor master record.',
    `employee_id` BIGINT COMMENT 'Reference to the utility employee serving as project manager responsible for contract administration, progress monitoring, and contractor coordination.',
    `construction_project_manager_employee_id` BIGINT COMMENT 'Reference to the utility employee serving as project manager responsible for contract administration, progress monitoring, and contractor coordination.',
    `construction_vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor awarded this construction contract. Links to the vendor/contractor master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Construction contracts charge to cost centers for project cost allocation and overhead recovery. Essential for full-cost accounting and departmental performance measurement.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA-specific construction (meter installations, valve replacements, main rehabilitation) requires DMA attribution for NRW program tracking, performance measurement, and before/after leakage comparison',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Construction contracts are funded from specific utility funds and require multi-year fund commitment tracking for appropriation control and cash flow planning.',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Construction contracts for zone-specific infrastructure need pressure zone attribution for operations coordination, isolation planning, SCADA integration, and hydraulic model updates during constructi',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Construction contracts are executed within specific service territories for permitting, prevailing wage compliance (varies by jurisdiction), and asset handover to the correct operations district. Cont',
    `award_date` DATE COMMENT 'Date the construction contract was officially awarded to the contractor by the utilitys governing authority (board, commission, or management).',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Contract value at the time of award, after any bid negotiations or adjustments. This is the baseline contract amount before any change orders.',
    `bid_advertisement_date` DATE COMMENT 'Date the construction contract opportunity was publicly advertised for competitive bidding. Marks the start of the procurement process.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Original bid amount submitted by the contractor during the competitive bidding process, before any negotiations or adjustments. Represents the contractors initial price proposal.',
    `bid_opening_date` DATE COMMENT 'Date when sealed bids were publicly opened and read. Establishes the official bid prices for evaluation.',
    `change_order_count` STRING COMMENT 'Total number of change orders issued against this construction contract. Indicates scope volatility and contract management complexity.',
    `contract_description` STRING COMMENT 'Detailed description of the construction scope of work, including infrastructure type (water main, wastewater treatment, pump station), work type (new construction, rehabilitation, replacement), and key deliverables.',
    `contract_duration_days` STRING COMMENT 'Original contract duration in calendar days from NTP to substantial completion. Used to calculate original completion date and assess schedule performance.',
    `contract_name` STRING COMMENT 'Descriptive name of the construction contract, typically reflecting the scope of work (e.g., Main Street Water Main Replacement, WWTP Clarifier Rehabilitation).',
    `contract_number` STRING COMMENT 'Externally-known unique contract identifier assigned by the utility for procurement tracking and reference. Used in all contract documentation, invoices, and correspondence.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the construction contract. Tracks progression from bid advertisement through contract closeout and final payment. [ENUM-REF-CANDIDATE: draft|advertised|bid_received|awarded|executed|active|substantially_complete|final_complete|closed — 9 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Type of construction contract pricing structure. Lump sum = fixed price for entire scope; unit price = payment per measured unit of work; GMP = guaranteed maximum price with cost sharing; cost plus = reimbursable costs plus fee; time and materials = hourly labor plus materials.. Valid values are `lump_sum|unit_price|cost_plus_fixed_fee|cost_plus_percentage|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this construction contract record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract. Typically USD for U.S. water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `current_completion_date` DATE COMMENT 'Current contractual deadline for substantial completion, adjusted for any approved time extensions due to change orders, weather delays, or other contract modifications.',
    `current_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value including all approved change orders and amendments. Represents the up-to-date financial commitment for the construction work.',
    `execution_date` DATE COMMENT 'Date the construction contract was fully executed (signed by both parties). Establishes the legally binding agreement.',
    `final_completion_date` DATE COMMENT 'Actual date all contract work including punch list items was completed and accepted by the utility. Triggers final payment and contract closeout.',
    `insurance_certificate_received` BOOLEAN COMMENT 'Indicates whether the contractor has provided proof of required insurance coverage (general liability, workers compensation, auto liability) per contract requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this construction contract record was last updated. Tracks most recent change for audit and synchronization purposes.',
    `liquidated_damages_assessed` DECIMAL(18,2) COMMENT 'Total dollar amount of liquidated damages assessed against the contractor for late completion. Calculated as days late multiplied by daily rate.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Daily dollar amount of liquidated damages assessed for each calendar day the contractor fails to achieve substantial completion by the contract deadline. Pre-agreed damages for delay, not a penalty.',
    `ntp_date` DATE COMMENT 'Date the utility issued the Notice to Proceed authorizing the contractor to begin construction work. Starts the contract time clock for completion deadlines.',
    `original_completion_date` DATE COMMENT 'Original contractual deadline for substantial completion of the work, calculated from NTP date plus contract duration. Baseline for schedule performance tracking.',
    `payment_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the payment bond, typically 100% of the contract value. Ensures subcontractors and material suppliers are paid.',
    `payment_bond_required` BOOLEAN COMMENT 'Indicates whether a payment bond (labor and material bond) is required to protect subcontractors and suppliers from non-payment by the general contractor.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage of contract work completed based on earned value or physical progress assessment. Used for progress reporting and payment calculations.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the performance bond, typically 100% of the contract value. Provides financial protection if contractor fails to complete the work.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond is required from the contractor to guarantee completion of the work per contract terms. Typically required for contracts above a threshold amount.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Total dollar amount currently held in retainage. Calculated as cumulative payments multiplied by retainage percentage, less any retainage released.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of each progress payment withheld by the utility until substantial or final completion to ensure contractor performance and warranty obligations. Typical range 5-10%.',
    `substantial_completion_date` DATE COMMENT 'Actual date the work reached substantial completion, meaning the facility can be used for its intended purpose despite minor punch list items remaining. Triggers warranty period start and retainage release milestones.',
    `time_extensions_days` STRING COMMENT 'Total number of calendar days of approved time extensions granted through change orders or contract modifications. Adjusts the completion deadline.',
    `total_change_order_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar value of all approved change orders (positive and negative). Represents the net change from awarded contract value to current contract value.',
    `total_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount paid to the contractor through all progress payments and partial payments, excluding retainage. Used to track payment status and remaining contract balance.',
    `warranty_expiration_date` DATE COMMENT 'Date the contractors warranty period expires. Calculated as substantial completion date plus warranty period months. After this date, the utility assumes full maintenance responsibility.',
    `warranty_period_months` STRING COMMENT 'Duration in months of the contractors warranty period for workmanship and materials, starting from substantial completion date. Typical range 12-24 months for water utility construction.',
    CONSTRAINT pk_construction_contract PRIMARY KEY(`construction_contract_id`)
) COMMENT 'Construction contract record for a CIP project covering agreements with general contractors and specialty subcontractors for infrastructure construction, rehabilitation, or renewal work. Tracks contract number, contractor, contract type (lump sum, unit price, GMP), bid amount, awarded contract value, current contract value (including change orders), retainage percentage, bonding and insurance requirements, NTP date, substantial completion date, final completion date, and liquidated damages provisions. Manages the full construction procurement lifecycle from bid advertisement through final payment.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Unique identifier for the change order record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor responsible for executing the work described in the change order.',
    `employee_id` BIGINT COMMENT 'Reference to the engineering firm or design professional who reviewed or prepared technical specifications for the change order, if applicable.',
    `change_employee_id` BIGINT COMMENT 'Reference to the engineering firm or design professional who reviewed or prepared technical specifications for the change order, if applicable.',
    `change_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor responsible for executing the work described in the change order.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project under which this change order is issued.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the originating construction or design contract to which this change order applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Change orders affect cost center budgets and require cost center manager approval for budget reallocation. Essential for departmental budget control.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Change orders impact fund budgets and require fund availability verification before approval. Critical for fund balance management and appropriation control.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Change orders adjust GL account budgets and require GL coding for proper capitalization vs. expense classification. Required for accurate financial reporting.',
    `work_order_id` BIGINT COMMENT 'Reference to the associated work order or field service ticket in the CMMS that tracks the physical execution of the change order scope, if applicable.',
    `approval_authority` STRING COMMENT 'Name, title, or role of the individual or governing body authorized to approve this change order (e.g., Director of Engineering, Board of Commissioners, City Council) based on approval thresholds and delegation of authority.',
    `approval_date` DATE COMMENT 'Date on which the change order was formally approved by the designated approval authority, authorizing execution of the modified scope.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the change order record, such as revised drawings, cost estimates, technical specifications, or approval memos.',
    `change_order_number` STRING COMMENT 'Business-assigned unique identifier for the change order, typically sequential within a contract (e.g., CO-001, CO-002).',
    `change_order_status` STRING COMMENT 'Current lifecycle status of the change order: draft (being prepared), submitted (sent for review), under review (being evaluated by stakeholders), approved (authorized for execution), rejected (denied), executed (work completed and invoiced), or closed (final reconciliation complete). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|executed|closed — 7 candidates stripped; promote to reference product]',
    `change_order_type` STRING COMMENT 'Classification of the change order by originating cause: owner-directed modifications, differing site conditions discovered during construction, design errors or omissions, unforeseen subsurface or environmental conditions, scope additions or deletions, time extensions without cost impact, value engineering proposals, or force majeure events. [ENUM-REF-CANDIDATE: owner_directed|differing_site_conditions|design_error|unforeseen_conditions|scope_change|time_extension|value_engineering|force_majeure — 8 candidates stripped; promote to reference product]',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the change order on the contract value. Positive values represent cost additions; negative values represent cost deductions or credits to the owner.',
    `cost_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was first created in the system.',
    `cumulative_change_order_value` DECIMAL(18,2) COMMENT 'Running total of all approved change order cost impacts for this contract through the current change order, used to track total contract growth or reduction.',
    `change_order_description` STRING COMMENT 'Detailed narrative description of the scope change, including work to be added, deleted, or substituted, technical specifications, and justification for the modification.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the change order has environmental implications requiring additional permitting, mitigation, or compliance documentation. True if environmental impact exists; False otherwise.',
    `execution_date` DATE COMMENT 'Date on which the change order was fully executed by all parties (owner and contractor signatures obtained) and became a binding contract amendment.',
    `initiated_by` STRING COMMENT 'Name or identifier of the individual or role who originated the change order request (e.g., project manager, contractor, design engineer, regulatory inspector).',
    `initiated_date` DATE COMMENT 'Date on which the change order request was formally initiated or drafted.',
    `justification` STRING COMMENT 'Business and technical rationale for the change order, including regulatory requirements, operational needs, safety considerations, or cost-benefit analysis supporting the modification.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified the change order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, clarifications, or internal coordination notes related to the change order processing and execution.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline contract value at the time of original award, before any change orders. Used to calculate cumulative change order percentage for cost control reporting.',
    `priority` STRING COMMENT 'Business priority level assigned to the change order based on urgency, regulatory compliance requirements, safety impact, or operational criticality.. Valid values are `critical|high|medium|low`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the change order is driven by a regulatory compliance requirement (e.g., EPA mandate, state permit condition, SDWA or CWA obligation). True if regulatory-driven; False otherwise.',
    `rejection_date` DATE COMMENT 'Date on which the change order was formally rejected or denied by the approval authority, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation or rationale provided for the rejection of the change order, including budgetary constraints, scope misalignment, or technical concerns.',
    `revised_completion_date` DATE COMMENT 'Updated contract substantial completion date after applying the schedule impact of this change order.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the change order addresses a safety hazard or improves worker or public safety conditions. True if safety-related; False otherwise.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days added to or subtracted from the contract completion date as a result of this change order. Positive values extend the schedule; negative values accelerate it.',
    `scope_addition_flag` BOOLEAN COMMENT 'Indicates whether the change order adds new work scope to the contract. True if scope is added; False if scope is deleted or substituted.',
    `scope_deletion_flag` BOOLEAN COMMENT 'Indicates whether the change order removes or deletes work scope from the contract. True if scope is deleted; False otherwise.',
    `submitted_date` DATE COMMENT 'Date on which the change order was formally submitted to the owner or approval authority for review.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the change order for quick identification and reporting.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the change order record.',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Formal change order record documenting approved modifications to a construction or design contract including scope additions, deletions, or substitutions, time extensions, and associated cost adjustments. Tracks change order number, originating contract, change order type (owner-directed, differing site conditions, design error, unforeseen conditions), description of change, cost impact (add/deduct), schedule impact (days), approval status, approval authority, and execution date. Maintains running total of all change orders against original contract value for cost control reporting.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`pay_application` (
    `pay_application_id` BIGINT COMMENT 'Unique identifier for the contractor payment application record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement program (CIP) project for which work is being billed.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the construction contract under which this payment application is submitted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contractor payments charge to cost centers for project cost allocation and overhead recovery. Required for full-cost accounting and departmental budget tracking.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Contractor payment applications draw from specific funds and require fund balance verification before payment authorization. Essential for cash flow management and fund accounting.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Contractor payments post to GL accounts for cash flow management, financial reporting, and construction-in-progress tracking. Required for accurate financial statements.',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor submitting the payment application.',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or architect who certified this payment application.',
    `pay_engineer_employee_id` BIGINT COMMENT 'Reference to the engineer or architect who certified this payment application.',
    `pay_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor submitting the payment application.',
    `application_number` STRING COMMENT 'Sequential payment application number assigned by the contractor for this billing period (e.g., Pay App #5).',
    `application_status` STRING COMMENT 'Current workflow status of the payment application in the approval and payment process. [ENUM-REF-CANDIDATE: draft|submitted|under_review|certified|approved|rejected|paid|void — 8 candidates stripped; promote to reference product]',
    `approved_change_orders_amount` DECIMAL(18,2) COMMENT 'Net total of all approved change orders that modify the contract sum.',
    `balance_to_finish_amount` DECIMAL(18,2) COMMENT 'Remaining contract value yet to be earned, calculated as current contract amount minus total earned to date.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this payment application.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this payment application.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payment application (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `current_contract_amount` DECIMAL(18,2) COMMENT 'Current total contract sum including original contract amount plus approved change orders.',
    `current_payment_due_amount` DECIMAL(18,2) COMMENT 'Net amount due to the contractor for this payment application, calculated as total earned less retainage minus previous payments.',
    `engineer_certification_date` DATE COMMENT 'Date the engineer or architect certified the payment application as accurate and compliant with contract requirements.',
    `engineer_certified_amount` DECIMAL(18,2) COMMENT 'Amount certified by the engineer or architect for payment, which may differ from the contractor-requested amount if adjustments are made.',
    `materials_stored_amount` DECIMAL(18,2) COMMENT 'Value of materials and equipment suitably stored on-site or off-site but not yet incorporated into the work.',
    `notes` STRING COMMENT 'Additional comments, clarifications, or special instructions related to this payment application.',
    `original_contract_amount` DECIMAL(18,2) COMMENT 'The original total contract sum before any approved change orders.',
    `owner_approval_date` DATE COMMENT 'Date the owner or authorized representative approved the payment application for disbursement.',
    `owner_approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved by the owner for payment, which may differ from engineer-certified amount due to owner adjustments or disputes.',
    `payment_date` DATE COMMENT 'Date the payment was actually disbursed to the contractor through accounts payable.',
    `payment_reference_number` STRING COMMENT 'Check number, wire transfer reference, or electronic payment confirmation number for the disbursed payment.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage of the total contract work completed as of this billing period, calculated as total earned to date divided by current contract amount.',
    `previous_payments_amount` DECIMAL(18,2) COMMENT 'Sum of all payments previously made to the contractor on this contract through prior payment applications.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the engineer or owner if the payment application was rejected or returned for correction.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of retainage withheld from the total earned to date based on the retainage percentage.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of earned amount withheld by the owner as retainage to ensure contract completion and quality (typically 5-10%).',
    `submission_date` DATE COMMENT 'Date the contractor submitted the payment application to the owner or engineer for review.',
    `total_earned_less_retainage_amount` DECIMAL(18,2) COMMENT 'Total earned to date minus retainage withheld, representing the gross amount eligible for payment.',
    `total_earned_to_date_amount` DECIMAL(18,2) COMMENT 'Sum of work completed to date and materials stored, representing total amount earned by the contractor through this billing period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was last modified.',
    `work_completed_to_date_amount` DECIMAL(18,2) COMMENT 'Total value of work completed and in place as of the end of this billing period, based on the schedule of values (AIA G703).',
    CONSTRAINT pk_pay_application PRIMARY KEY(`pay_application_id`)
) COMMENT 'Contractor payment application (pay app) record submitted for work completed during a billing period on a construction contract. Tracks application number, contract reference, billing period, scheduled value by cost item, work completed to date, materials stored on-site, total earned to date, retainage withheld, previous payments, and net amount due. Supports the AIA G702/G703 schedule of values workflow including engineer certification, owner approval, and payment processing. Integrates with SAP FI accounts payable for payment disbursement.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Unique identifier for the project cost transaction record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this cost transaction for posting. Null for transactions that do not require approval or are auto-approved.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project or WBS element against which this cost transaction is posted. Links to the parent capital project for infrastructure expansion, rehabilitation, or renewal.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project costs allocate to cost centers for indirect cost recovery, overhead distribution, and departmental performance tracking. Essential for full-cost pricing and rate-making.',
    `cost_employee_id` BIGINT COMMENT 'Reference to the employee who approved this cost transaction for posting. Null for transactions that do not require approval or are auto-approved.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Project costs must be charged to specific funds for regulatory reporting, rate base calculations, and fund financial statements. Required for GASB 34 compliance.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Project costs post to GL accounts for financial statement preparation, audit trails, and asset capitalization decisions. Required for proper GAAP/GASB accounting.',
    `original_cost_transaction_id` BIGINT COMMENT 'Reference to the original project cost transaction ID that this reversal transaction is correcting. Null for original postings; populated only for reversal entries.',
    `primary_cost_employee_id` BIGINT COMMENT 'Reference to the employee who performed the labor charged in this transaction. Applicable only for labor cost types. Null for material, equipment, or subcontract costs.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who provided the materials, equipment, or services for this cost transaction. Null for internal labor charges.',
    `approval_date` DATE COMMENT 'The date on which this cost transaction was approved for posting by the project manager or financial controller. Null for transactions that do not require approval.',
    `asset_class` STRING COMMENT 'The asset class code to which this cost will be capitalized upon project closeout (e.g., water treatment plant, distribution mains, pumping stations). Null for non-capitalizable costs.',
    `capitalization_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost transaction is eligible for capitalization as a fixed asset upon project completion. True indicates the cost will be capitalized; False indicates it will be expensed.',
    `change_order_number` STRING COMMENT 'The change order number associated with this cost transaction if it results from a project scope or budget change. Enables change order cost tracking and variance analysis.',
    `commitment_item` STRING COMMENT 'Reference to the budget commitment or encumbrance item that this actual cost is drawn against. Enables commitment vs. actual cost tracking for budget control.',
    `cost_element` STRING COMMENT 'The SAP CO cost element code that categorizes the nature of the expense (e.g., direct labor, materials, external services). Maps to the chart of accounts for financial reporting.',
    `cost_type` STRING COMMENT 'Classification of the cost transaction by type: labor charges, material purchases, equipment rentals, subcontractor invoices, overhead allocations, or other miscellaneous costs.. Valid values are `labor|material|equipment|subcontract|overhead|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost transaction record was first created in the lakehouse silver layer. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, CAD, EUR). Supports multi-currency project accounting for international projects or vendors.. Valid values are `^[A-Z]{3}$`',
    `cost_transaction_description` STRING COMMENT 'Free-text description of the cost transaction providing additional context about the work performed, materials purchased, or services rendered. Supports audit and cost review processes.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which this cost transaction was posted. Supports monthly cost control and earned value reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this cost transaction was posted. Enables year-over-year cost analysis and budget variance reporting.',
    `invoice_date` DATE COMMENT 'The date on the vendor invoice or billing document. Used for payment terms calculation and aging analysis.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or billing document number that supports this cost transaction. Provides audit trail for accounts payable reconciliation.',
    `payment_date` DATE COMMENT 'The date on which payment was made to the vendor for this cost transaction. Supports cash flow analysis and vendor payment tracking.',
    `posting_status` STRING COMMENT 'Current status of the cost transaction in the financial system. Posted indicates the transaction is final; Pending indicates it is awaiting approval; Reversed indicates it has been reversed; Rejected indicates it was not accepted.. Valid values are `posted|pending|reversed|rejected`',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this cost transaction for materials, equipment, or services procured from external vendors. Enables procurement traceability.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the resource consumed or purchased in this transaction (e.g., labor hours, material units, equipment rental days). Enables unit cost analysis and earned value calculations.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this transaction is a reversal or correction of a previously posted cost. True indicates a reversal entry; False indicates an original posting.',
    `source_document_reference` STRING COMMENT 'The unique document identifier in the source system (e.g., SAP document number, Maximo work order ID). Enables traceability back to the originating transaction.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the cost transaction in the project currency. Represents the actual cost incurred for labor, materials, equipment, or services.',
    `transaction_date` DATE COMMENT 'The date on which the cost transaction was posted to the project ledger. This is the accounting date for financial reporting and cost control purposes.',
    `transaction_number` STRING COMMENT 'The externally-known document number or voucher number from the source financial system (SAP FI/CO) that uniquely identifies this cost posting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the transaction quantity (e.g., hours, each, linear feet, cubic yards). Standardizes quantity reporting across different cost types.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost transaction record was last updated in the lakehouse silver layer. Tracks the most recent modification for change data capture and audit purposes.',
    `wbs_element` STRING COMMENT 'The specific WBS element code within the project hierarchy to which this cost is allocated. Enables granular cost tracking at the work package or task level.',
    `work_order_number` STRING COMMENT 'The work order or maintenance order number that generated this cost transaction. Links project costs to field work execution and asset maintenance activities.',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Individual cost transaction posted against a CIP project or WBS element including labor charges, material purchases, equipment rentals, contractor invoices, and overhead allocations. Tracks transaction date, cost type (labor, material, equipment, subcontract, overhead), vendor or employee reference, purchase order or work order reference, amount, cost center, fund, GL account, and posting period. Provides the granular cost ledger for project cost control, earned value management, budget vs actual reporting, and capitalization at project closeout. Sourced from SAP FI/CO actual cost postings and integrated with pay application approvals.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_permit` (
    `project_permit_id` BIGINT COMMENT 'Unique identifier for the project permit record. Primary key for the project permit entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project requiring this permit. Links permit to the capital project for which regulatory approval is required.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Project-specific construction/discharge permits reference master operational permits held by the utility. Links temporary project permits to permanent facility permits for comprehensive compliance tra',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Regulatory permits for new water infrastructure often specify required sampling point locations and monitoring frequencies. Permit compliance tracking requires linking permit conditions to established',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Permits are issued by regulatory agencies with jurisdiction over specific service territories. Compliance tracking, renewal management, and regulatory reporting require linking permits to the territor',
    `secondary_ssot_permit_id` BIGINT COMMENT '',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original permit. Tracks permit change history and complexity.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Recurring annual fee required to maintain the permit. Common for environmental permits such as NPDES. Recorded in US dollars. Null if no annual fee applies.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an administrative appeal or legal challenge was filed against the permit decision. Appeals can delay permit effectiveness and project schedules.',
    `appeal_status` STRING COMMENT 'Current status of any administrative appeal or legal challenge. Null if no appeal was filed.. Valid values are `pending|upheld|overturned|withdrawn|settled`',
    `application_date` DATE COMMENT 'Date the permit application was submitted to the issuing agency. Critical for tracking permit processing timelines and schedule impacts.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the issuing agency for processing the permit application. Recorded in US dollars.',
    `application_submitted_by` STRING COMMENT 'Name of the individual or organization that submitted the permit application on behalf of the utility. May be internal staff, consultant, or contractor.',
    `bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the required performance or surety bond. Null if no bond is required. Recorded in US dollars.',
    `bond_required` BOOLEAN COMMENT 'Indicates whether a performance or surety bond is required as a condition of the permit. Common for construction and right-of-way permits.',
    `compliance_requirements` STRING COMMENT 'Specific compliance obligations the permit holder must meet, including monitoring, reporting, record-keeping, and operational requirements. Distinct from permit conditions in that these are ongoing obligations during permit validity.',
    `conditions` STRING COMMENT 'Detailed text of conditions, restrictions, and requirements imposed by the issuing agency as part of the permit. May include construction methods, environmental protections, monitoring requirements, reporting obligations, and mitigation measures.',
    `contact_email` STRING COMMENT 'Email address of the primary permit contact. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person for permit-related communications and coordination. May be project manager, environmental compliance officer, or consultant.',
    `contact_phone` STRING COMMENT 'Phone number of the primary permit contact. Organizational contact data classified as confidential business information.',
    `coverage_area_description` STRING COMMENT 'Textual description of the geographic area or project site covered by the permit. May include street addresses, parcel numbers, legal descriptions, or geographic coordinates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `effective_date` DATE COMMENT 'Date the permit becomes legally effective and work may commence. May differ from issued date if there is a waiting period or appeal window.',
    `environmental_impact_category` STRING COMMENT 'Classification of the environmental impact level associated with the permitted activity. Determines level of environmental review and mitigation requirements.. Valid values are `none|minimal|moderate|significant`',
    `expiration_date` DATE COMMENT 'Date the permit expires and is no longer valid. Critical for tracking permit renewals and ensuring continuous compliance. Null for permits with no expiration.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether proof of insurance coverage is required as a condition of the permit. Common for construction permits requiring general liability and workers compensation coverage.',
    `issued_date` DATE COMMENT 'Date the permit was officially issued by the regulatory agency. Marks the start of permit validity and authorization to proceed with permitted activities.',
    `issuing_agency_jurisdiction` STRING COMMENT 'Level of government jurisdiction for the issuing agency. Determines regulatory authority and appeal processes.. Valid values are `federal|state|county|municipal|regional`',
    `issuing_agency_name` STRING COMMENT 'Name of the regulatory or governmental agency that issued the permit. Examples: EPA, State Department of Environmental Quality, County Building Department, City Public Works Department, U.S. Army Corps of Engineers.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection conducted by the issuing agency. Null if no inspections have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the system. Audit trail for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the primary permit site location in decimal degrees. Used for GIS mapping and spatial analysis of permit coverage.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the primary permit site location in decimal degrees. Used for GIS mapping and spatial analysis of permit coverage.',
    `mitigation_measures` STRING COMMENT 'Description of required environmental mitigation measures to offset impacts of the permitted activity. May include wetland restoration, stormwater controls, erosion prevention, habitat protection, or compensatory mitigation.',
    `monitoring_requirements` STRING COMMENT 'Description of required monitoring activities, including parameters to be monitored, frequency, methods, and reporting schedules. Common for environmental permits requiring water quality, air quality, or stormwater monitoring.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special considerations related to the permit. May include coordination notes, schedule impacts, or lessons learned.',
    `permit_number` STRING COMMENT 'Official permit number or identifier assigned by the issuing regulatory agency. This is the externally-recognized unique identifier for the permit.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Tracks progression from application through issuance, active use, and closure. Critical for project schedule management and compliance tracking. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|issued|active|expired|revoked|suspended|closed — 10 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on regulatory domain. Environmental permits include NPDES, Section 404/401 wetlands, state water quality certifications. Construction permits include building, grading, excavation. Utility coordination and right-of-way permits govern work in public spaces.. Valid values are `environmental|construction|utility_coordination|right_of_way|encroachment|other`',
    `public_comment_period_end_date` DATE COMMENT 'Date the public comment period closed for the permit application. Null if no public comment period was required.',
    `public_notice_date` DATE COMMENT 'Date public notice was published for the permit application. Null if no public notice was required.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether public notice and comment period was required for this permit. Common for major environmental permits and permits with significant public interest.',
    `renewal_application_date` DATE COMMENT 'Date the permit renewal application was submitted. Typically required 180 days before expiration for NPDES permits. Null if permit does not require renewal or renewal has not been initiated.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the permit requires periodic renewal. Common for environmental permits with fixed terms such as NPDES permits which typically require renewal every 5 years.',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to the issuing agency. Common for NPDES permits requiring monthly or quarterly discharge monitoring reports. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|as_required|none — 7 candidates stripped; promote to reference product]',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization legally responsible for permit compliance. Typically the permit holder or designated responsible official.',
    `subtype` STRING COMMENT 'Detailed classification within the permit type. Examples: NPDES Construction Stormwater, Section 404 Wetlands Fill, Building Permit Commercial, Grading Permit, Encroachment Permit Street Opening, Right-of-Way Temporary Occupancy.',
    `total_fees_paid` DECIMAL(18,2) COMMENT 'Cumulative total of all fees paid for this permit, including application, annual, renewal, and amendment fees. Recorded in US dollars.',
    `violation_count` STRING COMMENT 'Number of permit violations or non-compliance events recorded for this permit. Critical for compliance tracking and enforcement risk assessment.',
    CONSTRAINT pk_project_permit PRIMARY KEY(`project_permit_id`)
) COMMENT 'Regulatory and construction permit record required for CIP project execution including environmental permits (NPDES, Section 404/401, state water quality certifications), construction permits (building, grading, encroachment, right-of-way), and utility coordination permits. Tracks permit type, issuing agency, application date, issued date, expiration date, permit conditions, compliance requirements, associated fees, and permit status. Critical for project schedule management as permit delays are a leading cause of construction schedule impacts.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` (
    `design_submittal_id` BIGINT COMMENT 'Unique identifier for the design submittal record. Primary key for tracking engineering document submissions during the design phase of capital improvement program (CIP) projects.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent capital improvement program project for which this design submittal is prepared. Links submittal to the infrastructure expansion, rehabilitation, or renewal project.',
    `design_contract_id` BIGINT COMMENT 'Foreign key linking to project.design_contract. Business justification: Design submittals are deliverables produced under design contracts. Links the submittal to the professional services agreement that governs its creation and review. Note: design_submittal already has',
    `previous_submittal_design_submittal_id` BIGINT COMMENT 'Reference to the prior version of this design submittal if this is a resubmission. Creates a lineage chain for tracking design evolution through multiple review cycles.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Design reviewers are utility engineering staff. Tracking which licensed engineer approved design submittals is critical for professional liability, regulatory permit applications, and design quality c',
    `comment_count` STRING COMMENT 'Total number of review comments generated during the design review. Provides a quantitative measure of the extent of feedback provided.',
    `comment_resolution_status` STRING COMMENT 'Current status of addressing and resolving review comments. Tracks progress from initial comment receipt through final verification and closure.. Valid values are `not_started|in_progress|resolved|verified|closed`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard against which the design is reviewed for compliance (e.g., Safe Drinking Water Act (SDWA), Clean Water Act (CWA), American Water Works Association (AWWA) standards, Ten States Standards). May reference multiple standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design submittal record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Rated treatment or conveyance capacity of the designed facility expressed in Million Gallons per Day (MGD). Key performance metric for water and wastewater infrastructure sizing.',
    `design_discipline` STRING COMMENT 'Engineering discipline or specialty area covered by the design submittal. Categorizes the technical domain of the deliverable. [ENUM-REF-CANDIDATE: civil|structural|mechanical|electrical|instrumentation_and_control|process|environmental|geotechnical|hydraulic|architectural — 10 candidates stripped; promote to reference product]',
    `design_life_years` STRING COMMENT 'Planned operational lifespan of the designed infrastructure in years. Used for asset management planning and long-term capital improvement program (CIP) forecasting.',
    `design_phase` STRING COMMENT 'Stage of the design process to which this submittal corresponds. Aligns with standard engineering design progression from conceptual through construction documents.. Valid values are `conceptual|preliminary|intermediate|final|construction_documents`',
    `disposition` STRING COMMENT 'Final outcome of the design review process. Indicates whether the submittal is approved for construction, approved with minor notes, requires revision and resubmission, or is rejected. Represents the lifecycle status of this transaction.. Valid values are `approved|approved_as_noted|revise_and_resubmit|rejected|under_review`',
    `document_file_path` STRING COMMENT 'Storage location or file path reference for the submitted design document in the document management system or Enterprise Resource Planning (ERP) system. Enables retrieval of the actual engineering deliverable.',
    `document_format` STRING COMMENT 'File format of the submitted design document (e.g., PDF, AutoCAD DWG, Revit, Excel, Word). Indicates the software platform and format used for the engineering deliverable. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|revit|navisworks|excel|word|other — 8 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Descriptive title of the design document being submitted. Provides clear identification of the engineering deliverable content and scope.',
    `drawing_count` STRING COMMENT 'Number of individual engineering drawings or sheets included in the design submittal package. Applicable for design drawing submittals.',
    `environmental_review_required` BOOLEAN COMMENT 'Indicates whether the design requires environmental impact assessment or review under National Environmental Policy Act (NEPA), state environmental quality acts, or other environmental regulations.',
    `estimated_construction_cost` DECIMAL(18,2) COMMENT 'Projected cost to construct the designed infrastructure based on the current design phase. Used for Capital Expenditure (CAPEX) planning and budget control. Expressed in US dollars.',
    `facility_type` STRING COMMENT 'Classification of the water or wastewater infrastructure facility being designed. Indicates whether the design is for a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, storage tank, distribution network, or other asset type. [ENUM-REF-CANDIDATE: water_treatment_plant|wastewater_treatment_plant|pump_station|storage_tank|distribution_main|collection_main|intake_structure|discharge_outfall|other — 9 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design submittal record was last updated. Audit trail for tracking changes to submittal status, disposition, or other attributes.',
    `page_count` STRING COMMENT 'Total number of pages or sheets in the submitted design document. Provides a measure of document size and complexity.',
    `priority` STRING COMMENT 'Urgency level assigned to the design submittal review. Critical submittals may be on the critical path for project schedule and require expedited review.. Valid values are `critical|high|medium|low`',
    `regulatory_permit_required` BOOLEAN COMMENT 'Indicates whether the design requires regulatory permits or approvals from agencies such as the U.S. Environmental Protection Agency (EPA), state primacy agencies, or local authorities before construction can proceed.',
    `resubmission_required` BOOLEAN COMMENT 'Indicates whether the design submittal must be revised and resubmitted based on review comments. True when disposition is revise_and_resubmit or when significant comments require formal resubmission.',
    `review_completion_date` DATE COMMENT 'Actual date when the design review was completed and disposition was determined. Null if review is still in progress.',
    `review_due_date` DATE COMMENT 'Target date by which the design review must be completed. Used for schedule tracking and ensuring timely project progression through design phases.',
    `review_notes` STRING COMMENT 'Summary notes or general comments from the reviewer regarding the design submittal. Captures high-level feedback and overall assessment beyond individual line-item comments.',
    `reviewer_role` STRING COMMENT 'Functional role or title of the reviewer (e.g., Chief Engineer, Project Manager, Technical Director, Regulatory Compliance Officer). Indicates the authority level for approval.',
    `revision_number` STRING COMMENT 'Version or revision identifier for the submitted document. Tracks iterative changes and resubmissions following review comments (e.g., Rev 0, Rev A, Rev 1).',
    `specification_section` STRING COMMENT 'Reference to the technical specification section or division covered by this submittal (e.g., Division 40 - Process Integration, Section 11300 - Water Treatment Equipment). Follows Construction Specifications Institute (CSI) MasterFormat or similar standards.',
    `submission_date` DATE COMMENT 'Date when the design submittal was formally submitted to the reviewer or approval authority. Represents the principal business event timestamp for this transaction.',
    `submittal_number` STRING COMMENT 'Business identifier for the design submittal, typically following project-specific numbering conventions (e.g., DS-001, DS-002). Used for external communication and document tracking.',
    `submittal_type` STRING COMMENT 'Classification of the design deliverable being submitted. Indicates the phase and nature of the engineering document (e.g., Preliminary Engineering Report (PER), 30%/60%/90%/100% design drawings, specifications, hydraulic models, geotechnical reports, environmental assessments). [ENUM-REF-CANDIDATE: preliminary_engineering_report|30_percent_design|60_percent_design|90_percent_design|100_percent_design|specifications|hydraulic_model|geotechnical_report|environmental_assessment|other — 10 candidates stripped; promote to reference product]',
    `submitter_name` STRING COMMENT 'Name of the individual or organization submitting the design document. Typically the design consultant, engineering firm, or internal engineering staff member.',
    `submitter_organization` STRING COMMENT 'Name of the consulting firm, engineering company, or internal department responsible for preparing and submitting the design deliverable.',
    CONSTRAINT pk_design_submittal PRIMARY KEY(`design_submittal_id`)
) COMMENT 'Design deliverable submittal record tracking engineering documents submitted for review and approval during the design phase including preliminary engineering reports (PER), 30%/60%/90%/100% design drawings, specifications, hydraulic models, geotechnical reports, and environmental assessments. Tracks submittal number, document type, revision number, submission date, reviewer, review due date, review completion date, disposition (approved, approved as noted, revise and resubmit, rejected), and comment resolution status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` (
    `construction_submittal_id` BIGINT COMMENT 'Unique identifier for the construction submittal record. Primary key for the construction submittal entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent capital improvement project under which this submittal is managed.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the construction contract governing this submittal process.',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor organization submitting the construction documents for review.',
    `employee_id` BIGINT COMMENT 'Reference to the engineer or technical staff member assigned to review this submittal.',
    `construction_vendor_id` BIGINT COMMENT 'Reference to the contractor organization submitting the construction documents for review.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Construction submittals include material testing results (pipe samples, concrete testing, coating verification, backfill material analysis). Required for material acceptance, quality assurance, and wa',
    `change_order_id` BIGINT COMMENT 'Reference to a change order if this submittal is associated with a contract change, scope modification, or value engineering proposal. Null if part of original contract scope.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the engineer or technical staff member assigned to review this submittal.',
    `asset_handover_flag` BOOLEAN COMMENT 'Indicates whether this submittal includes documentation required for asset handover and commissioning (e.g., O&M manuals, as-built drawings, warranty information). True if handover documentation is included.',
    `compliance_certification` STRING COMMENT 'Industry certifications, standards compliance, or regulatory approvals applicable to the submitted product (e.g., NSF/ANSI 61 for drinking water system components, AWWA standards, UL listing).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this submittal record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this submittal is on the project critical path and delays in review or approval would impact the overall project schedule. True if on critical path.',
    `disposition_code` STRING COMMENT 'Engineer review decision code indicating the approval status: approved (no exceptions, proceed with work), approved_as_noted (minor corrections noted, proceed with work), revise_resubmit (corrections required, resubmit for approval), rejected (does not meet specifications, major revisions required), for_information_only (no approval required), withdrawn (contractor withdrew submittal).. Valid values are `approved|approved_as_noted|revise_resubmit|rejected|for_information_only|withdrawn`',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL pointing to the electronic submittal documents (drawings, specifications, data sheets, samples documentation).',
    `final_approval_date` DATE COMMENT 'Date on which the submittal received final approval disposition (approved or approved_as_noted), allowing the contractor to proceed with fabrication or installation. Null if not yet approved.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier of the material, equipment, or product being submitted for approval.',
    `model_number` STRING COMMENT 'Manufacturer model number or catalog number of the product or equipment being submitted.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this submittal record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this submittal record was last modified or updated.',
    `required_before_installation_flag` BOOLEAN COMMENT 'Indicates whether this submittal must receive final approval before the contractor may proceed with fabrication or installation of the associated material or equipment. True if approval is mandatory before work proceeds.',
    `resubmittal_count` STRING COMMENT 'Number of times this submittal has been resubmitted after initial rejection or revise-and-resubmit disposition. Zero indicates first submission.',
    `review_comments` STRING COMMENT 'Detailed comments, corrections, or notes provided by the reviewing engineer regarding the submittal, including any required changes or clarifications.',
    `review_completion_date` DATE COMMENT 'Actual date on which the engineer or owner completed the review and returned the submittal to the contractor with a disposition code.',
    `review_due_date` DATE COMMENT 'Target date by which the engineer or owner must complete the review and return the submittal to the contractor, typically defined by contract terms or project schedule.',
    `specification_section` STRING COMMENT 'CSI MasterFormat specification section number to which this submittal applies (e.g., 03 30 00 for Cast-in-Place Concrete, 40 30 00 for Water Treatment Equipment).. Valid values are `^[0-9]{2}s?[0-9]{2}s?[0-9]{2}(.[0-9]{2})?$`',
    `submission_date` DATE COMMENT 'Date on which the contractor submitted the documents to the engineer or owner for review. This is the principal business event timestamp marking the start of the review cycle.',
    `submittal_description` STRING COMMENT 'Detailed description of the submittal contents, scope, and purpose, including any special notes or instructions from the contractor.',
    `submittal_number` STRING COMMENT 'Unique business identifier for the submittal within the project, typically following a project-specific numbering convention (e.g., CIP-001234, WTP-SUB-0045).. Valid values are `^[A-Z0-9]{2,4}-[0-9]{3,6}$`',
    `submittal_priority` STRING COMMENT 'Priority level assigned to the submittal review based on project schedule impact and construction sequencing needs: urgent (immediate review required), high (expedited review needed), normal (standard review timeline), low (non-critical, review as time permits).. Valid values are `urgent|high|normal|low`',
    `submittal_status` STRING COMMENT 'Current lifecycle status of the submittal: draft (being prepared by contractor), submitted (awaiting engineer review), under_review (engineer actively reviewing), approved (final approval granted), rejected (final rejection issued), closed (submittal process complete), withdrawn (contractor withdrew submittal). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|closed|withdrawn — 7 candidates stripped; promote to reference product]',
    `submittal_title` STRING COMMENT 'Descriptive title of the submittal identifying the specific material, equipment, or system being submitted for review (e.g., Clarifier Drive Unit, 24-inch Ductile Iron Pipe, Chemical Feed Pump).',
    `submittal_type` STRING COMMENT 'Classification of the submittal document type: shop_drawing (fabrication and installation drawings), product_data (manufacturer specifications and data sheets), material_sample (physical samples for approval), mix_design (concrete or asphalt mix formulations), equipment_submittal (equipment specifications and performance data), operation_maintenance_manual (O&M documentation for commissioned assets).. Valid values are `shop_drawing|product_data|material_sample|mix_design|equipment_submittal|operation_maintenance_manual`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this submittal record in the system.',
    CONSTRAINT pk_construction_submittal PRIMARY KEY(`construction_submittal_id`)
) COMMENT 'Contractor submittal record for construction-phase documents requiring engineer review and approval including shop drawings, product data sheets, material samples, mix designs, equipment submittals, and O&M manuals. Tracks submittal number, specification section, contractor submission date, engineer review due date, review completion date, disposition code, resubmittal count, and final approval date. Manages the construction submittal log to ensure all required submittals are received and approved before installation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` (
    `request_for_information_id` BIGINT COMMENT 'Primary key for request_for_information',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: RFIs are issued during construction to resolve design ambiguities or conflicts within the scope of a specific construction contract. Links RFI to the contract context. Note: rfi already has project_id',
    CONSTRAINT pk_request_for_information PRIMARY KEY(`request_for_information_id`)
) COMMENT 'Request for Information (RFI) record issued during construction to resolve design ambiguities, conflicts, or unforeseen field conditions requiring engineering clarification. Tracks RFI number, originating party (contractor, inspector, owner), subject, description of issue, date issued, response due date, responding engineer, response date, response description, cost impact flag, schedule impact flag, and whether the RFI resulted in a change order. The RFI log is a critical construction management document for dispute resolution and project documentation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` (
    `inspection_report_id` BIGINT COMMENT 'Unique identifier for the construction inspection report. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement program (CIP) project under which this inspection was conducted.',
    `vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor performing the work being inspected.',
    `inspection_vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor performing the work being inspected.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Construction inspectors are utility employees. Regulatory compliance and quality assurance require tracking which certified employee performed each inspection. Essential for OSHA, EPA, and state drink',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Daily construction inspection reports for pipeline installation must reference the specific main segment being installed for as-built documentation, quality assurance records, and construction defect',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Station construction inspection reports must link to the specific pump_station for equipment installation verification, punch list tracking, and as-built documentation of mechanical and electrical sys',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element or work package being inspected during this site visit.',
    `approved_by` STRING COMMENT 'Name of the project manager or authorized representative who approved this inspection report.',
    `approved_date` DATE COMMENT 'Date when the inspection report was formally approved.',
    `change_order_recommended_flag` BOOLEAN COMMENT 'Indicates whether the inspector recommends a change order based on field conditions, design changes, or unforeseen circumstances observed during the inspection.',
    `contractor_crew_size` STRING COMMENT 'Number of contractor personnel on-site during the inspection, used to assess resource deployment and progress correlation.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions required to address identified non-conformance items, including deadlines and responsible parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection report record was first created in the system.',
    `daily_progress_narrative` STRING COMMENT 'Comprehensive narrative describing the overall progress of construction activities, contractor performance, site conditions, and any issues or delays encountered. Provides the contemporaneous field record for project documentation.',
    `drawings_referenced` STRING COMMENT 'List of construction drawings, plans, or specifications referenced during the inspection, including drawing numbers and revision dates.',
    `equipment_on_site` STRING COMMENT 'List or description of major construction equipment present on-site during the inspection (e.g., excavators, cranes, concrete pumps, pipe layers).',
    `inspection_date` DATE COMMENT 'The calendar date on which the field inspection was conducted. Principal business event timestamp for this report.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspector completed the site visit and departed.',
    `inspection_report_number` STRING COMMENT 'Business identifier for the inspection report, typically a sequential or project-specific numbering scheme used for external reference and filing.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspector arrived on-site and began the inspection activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection report record was last updated or modified.',
    `materials_delivered` STRING COMMENT 'Description of construction materials delivered to the site during the inspection period, including quantities and supplier information where relevant.',
    `materials_tested` STRING COMMENT 'Description of materials tested or sampled during the inspection (e.g., concrete cylinders, soil compaction, pipe pressure tests), including test types and sample identifiers.',
    `non_conformance_description` STRING COMMENT 'Detailed description of any non-conformance items identified, including location, nature of deficiency, and reference to violated specification sections.',
    `non_conformance_identified_flag` BOOLEAN COMMENT 'Indicates whether any non-conformance items, deficiencies, or deviations from plans and specifications were identified during this inspection.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations not captured in other structured fields, providing supplementary context for the inspection record.',
    `pay_application_certification_status` STRING COMMENT 'Status of the inspectors certification for contractor pay application based on the work progress documented in this report. Used to support or dispute contractor payment requests.. Valid values are `certified|not_certified|partial|pending_review`',
    `percent_complete` DECIMAL(18,2) COMMENT 'Estimated percentage of work complete for the inspected work package or activity as of the inspection date, used for progress tracking and earned value analysis.',
    `photos_attached_count` STRING COMMENT 'Number of photographs attached to this inspection report for visual documentation of site conditions, work progress, and non-conformance items.',
    `report_status` STRING COMMENT 'Current lifecycle status of the inspection report in the review and approval workflow.. Valid values are `draft|submitted|reviewed|approved|archived`',
    `rfi_generated_flag` BOOLEAN COMMENT 'Indicates whether a Request for Information (RFI) was generated as a result of this inspection due to ambiguities, conflicts, or clarifications needed in the contract documents.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection period.',
    `safety_observations` STRING COMMENT 'Documentation of safety conditions observed during the inspection, including compliance with Occupational Safety and Health Administration (OSHA) requirements, personal protective equipment (PPE) usage, and any safety concerns or violations.',
    `subcontractor_name` STRING COMMENT 'Name of the subcontractor performing the specific work activities observed during this inspection, if applicable.',
    `submitted_date` DATE COMMENT 'Date when the inspection report was formally submitted for review and approval.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Fahrenheit at the time of inspection, critical for concrete curing, asphalt placement, and coating application compliance.',
    `test_results_summary` STRING COMMENT 'Summary of field test results or observations from materials testing conducted during or immediately following the inspection.',
    `visitors_on_site` STRING COMMENT 'List of visitors present on-site during the inspection (e.g., project managers, engineers, regulatory inspectors, utility representatives), relevant for documentation and coordination.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the inspection (e.g., clear, rain, snow, temperature range), relevant for documenting construction conditions and potential impacts on work quality.',
    `work_activities_observed` STRING COMMENT 'Detailed narrative of construction activities observed during the inspection, including specific tasks, locations, and methods employed by the contractor.',
    `work_stoppage_flag` BOOLEAN COMMENT 'Indicates whether work was stopped or suspended during the inspection due to non-conformance, safety issues, or other reasons.',
    `work_stoppage_reason` STRING COMMENT 'Explanation of the reason for work stoppage if the work stoppage flag is true, including corrective actions required before work may resume.',
    CONSTRAINT pk_inspection_report PRIMARY KEY(`inspection_report_id`)
) COMMENT 'Construction inspection report documenting field observations by the owners inspector or resident project representative (RPR) during construction activities. Tracks inspection date, inspector name, weather conditions, contractor crew size, equipment on-site, work activities observed, materials tested or sampled, non-conformance items identified, safety observations, daily progress narrative, and percentage of work complete. Provides the contemporaneous field record supporting contractor pay application certification and dispute resolution.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` (
    `nonconformance_report_id` BIGINT COMMENT 'Unique identifier for the non-conformance report. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Identifier of the capital improvement program (CIP) project to which this non-conformance report belongs.',
    `location_id` BIGINT COMMENT 'GIS feature identifier or spatial reference linking the non-conformance to a specific asset or location in the utilitys geographic information system for spatial analysis and mapping.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: NCR inspectors are utility QA/QC employees. Regulatory compliance and contractor dispute resolution require tracking which certified employee identified nonconformances. Essential for construction qua',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: NCRs are triggered by failed water quality tests during construction (contaminated pipe sections, inadequate disinfection, material leaching). Required for quality control, corrective action tracking',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor or subcontractor responsible for the work or materials that are the subject of the non-conformance report.',
    `nonconformance_vendor_id` BIGINT COMMENT 'Identifier of the contractor or subcontractor responsible for the work or materials that are the subject of the non-conformance report.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Construction NCRs for pipe installation defects (improper bedding, joint failures, coating damage) must link to the affected main segment for warranty claims, future inspection targeting, and conditio',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: NCRs directly reference the specific test result that failed acceptance criteria. Essential for deficiency documentation, corrective action verification, and regulatory compliance. Provides analytical',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the specific WBS element where the non-conformance was identified, enabling granular tracking within project phases or deliverables.',
    `closeout_date` DATE COMMENT 'Date when the non-conformance report was formally closed, indicating all corrective actions have been completed, verified, and accepted.',
    `closeout_status` STRING COMMENT 'Status indicating whether the non-conformance report has been fully closed out with all corrective actions completed, verified, and documented, or remains open pending final steps.. Valid values are `open|closed|pending_verification|pending_documentation`',
    `contractor_response` STRING COMMENT 'Narrative response from the contractor acknowledging the non-conformance, providing explanation, and proposing corrective action or requesting acceptance.',
    `contractor_response_date` DATE COMMENT 'Date when the contractor submitted their formal response to the non-conformance report.',
    `corrective_action_completed_date` DATE COMMENT 'Actual date when the corrective action was completed and verified, marking the resolution of the non-conformance.',
    `corrective_action_due_date` DATE COMMENT 'Target or contractually required date by which the corrective action must be completed.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan submitted by the contractor outlining the steps, methods, materials, and schedule for implementing the corrective action.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action required to resolve the non-conformance, as determined by the engineer, inspector, or project manager. May include repair, replacement, re-testing, or other remediation steps.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost impact of the non-conformance and its resolution, including costs for rework, replacement materials, additional labor, testing, and schedule delays.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this non-conformance report record was first created in the system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount, typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `disposition` STRING COMMENT 'Final disposition decision for the non-conforming work or material, indicating whether it will be repaired, replaced, reworked, accepted as-is with engineering approval, or rejected. Disposition is typically made by the engineer of record or authorized project representative.. Valid values are `repair|replace|rework|accept_as_is|reject|use_as_is_with_concession`',
    `disposition_justification` STRING COMMENT 'Engineering justification or rationale for the disposition decision, particularly important when accepting non-conforming work as-is or granting concessions.',
    `engineer_approval_date` DATE COMMENT 'Date when the engineer or authorized representative approved the disposition decision.',
    `engineer_approval_name` STRING COMMENT 'Name of the professional engineer or authorized technical representative who approved the disposition decision, particularly for accept-as-is or use-as-is-with-concession dispositions.',
    `identified_date` DATE COMMENT 'Date when the non-conformance was first identified or discovered during inspection, testing, or construction activities.',
    `identified_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the non-conformance was first identified, supporting detailed event sequencing and audit trails.',
    `inspector_organization` STRING COMMENT 'Organization or company that the inspector represents, such as the utility owner, third-party inspection firm, or engineering consultant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this non-conformance report record was last modified, supporting audit trail and change tracking.',
    `location_description` STRING COMMENT 'Textual description of the physical location or asset where the non-conformance was identified, such as station name, pipe segment, facility area, or geographic coordinates reference.',
    `ncr_number` STRING COMMENT 'Business identifier for the non-conformance report, typically a human-readable sequential or structured code used for tracking and reference in project documentation and communications.',
    `ncr_status` STRING COMMENT 'Current lifecycle status of the non-conformance report indicating its position in the quality management workflow from identification through resolution and closeout. [ENUM-REF-CANDIDATE: open|under_review|corrective_action_pending|corrective_action_in_progress|closed|rejected|accepted_as_is — 7 candidates stripped; promote to reference product]',
    `nonconformance_category` STRING COMMENT 'Classification of the non-conformance by type, enabling trend analysis and root cause categorization across material defects, workmanship issues, design flaws, documentation errors, testing failures, safety violations, or environmental non-compliance. [ENUM-REF-CANDIDATE: material|workmanship|design|documentation|testing|safety|environmental|other — 8 candidates stripped; promote to reference product]',
    `nonconformance_description` STRING COMMENT 'Detailed narrative description of the non-conformance, including what was observed, how it deviates from requirements, and the nature of the deficiency or defect.',
    `notes` STRING COMMENT 'Additional notes, comments, or supplementary information related to the non-conformance report, including communications, clarifications, or historical context.',
    `preventive_action` STRING COMMENT 'Description of preventive actions implemented to prevent recurrence of similar non-conformances in future work, such as process changes, additional training, or specification clarifications.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator of whether the non-conformance must be reported to regulatory agencies such as EPA, state drinking water programs, or OSHA due to safety, environmental, or compliance implications.',
    `root_cause_analysis` STRING COMMENT 'Documentation of the root cause analysis performed to identify the underlying cause of the non-conformance, supporting process improvement and prevention of recurrence.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the non-conformance and its resolution delayed the project schedule or affected critical path activities.',
    `severity_level` STRING COMMENT 'Severity classification of the non-conformance indicating the impact on project quality, safety, functionality, or regulatory compliance. Critical issues require immediate action, major issues affect performance, minor issues are cosmetic or low-impact.. Valid values are `critical|major|minor`',
    `specification_reference` STRING COMMENT 'Citation of the contract specification, technical standard, approved submittal, or regulatory requirement that the work or material failed to meet, providing the basis for the non-conformance determination.',
    `standard_reference` STRING COMMENT 'Reference to applicable industry standards such as AWWA, ASTM, NSF, or other technical standards that define the conformance criteria for materials, workmanship, or testing.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and satisfactory.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was completed satisfactorily, such as re-inspection, testing, documentation review, or photographic evidence.',
    `verified_by_name` STRING COMMENT 'Name of the inspector or engineer who verified the completion and acceptability of the corrective action.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean indicator of whether this non-conformance report is associated with a warranty claim against the contractor, supplier, or manufacturer for defective materials or workmanship.',
    CONSTRAINT pk_nonconformance_report PRIMARY KEY(`nonconformance_report_id`)
) COMMENT 'Non-conformance report (NCR) documenting construction work or materials that do not meet contract specifications, approved submittals, or applicable standards. Tracks NCR number, date identified, location, description of non-conformance, specification reference, inspector, contractor response, corrective action required, corrective action completed date, disposition (repair, replace, accept as-is with engineer approval), and closeout status. Supports quality management and provides documentation for warranty claims.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` (
    `commissioning_activity_id` BIGINT COMMENT 'Unique identifier for the commissioning activity record. Primary key for this entity.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: AMI endpoint commissioning activities (communication verification, network registration, data validation) require linking to specific endpoints for acceptance criteria verification, operational handov',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent capital improvement program (CIP) project under which this commissioning activity is performed.',
    `registry_id` BIGINT COMMENT 'Reference to the newly constructed or rehabilitated asset (water treatment plant, wastewater treatment plant, pump station, pipeline, etc.) being commissioned.',
    `commissioning_registry_id` BIGINT COMMENT 'Reference to the newly constructed or rehabilitated asset (water treatment plant, wastewater treatment plant, pump station, pipeline, etc.) being commissioned.',
    `lab_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_sample. Business justification: Commissioning activities require water quality sampling for disinfection verification, bacteriological testing, and chemical analysis before facility acceptance. Essential for regulatory approval and',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Meter commissioning activities (pressure testing, flow verification, SCADA integration) performed on specific meters during project closeout require linkage for commissioning status tracking, acceptan',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Pressure testing, disinfection, bacteriological clearance, and flow testing are commissioning activities performed on specific pipe mains before they enter service. Required for regulatory acceptance',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.service_point. Business justification: Commissioning activities for new service connections (meter installation, pressure testing, bacteriological sampling) are performed at specific service points. Field crews and customer service need th',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Zone commissioning activities (hydraulic verification, pressure monitoring, demand profiling) must reference the pressure zone being brought online for operational acceptance and hydraulic model calib',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Pump station commissioning (performance testing, SCADA integration, VFD tuning, vibration analysis) must be linked to the specific station asset for acceptance testing documentation and operational re',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Commissioning activities for new distribution infrastructure include establishing and validating sampling points. Asset handover checklist requires documented sampling point installation and initial s',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Commissioning activities must demonstrate compliance with regulatory requirements (disinfection contact time per SWTR, pressure testing per state standards, water quality standards). Essential for reg',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Tank commissioning (fill testing, mixing system verification, level sensor calibration, overflow testing) requires linkage to the specific tank asset for regulatory inspection records and operational',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Commissioning acceptance criteria reference specific test results (chlorine residual, bacteriological absence, turbidity limits). Required for regulatory sign-off and operational readiness verificatio',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Commissioning activities require documented water samples for bacteriological clearance and disinfection validation. Commissioning sign-off requires attached lab results proving water quality complian',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element within the project that this commissioning activity belongs to, enabling detailed cost and schedule tracking.',
    `acceptance_criteria` STRING COMMENT 'Detailed acceptance criteria that must be met for the commissioning activity to be considered successful, including performance thresholds, quality standards, and regulatory requirements.',
    `activity_category` STRING COMMENT 'Broader category grouping for the commissioning activity, aligning with engineering disciplines and operational domains. [ENUM-REF-CANDIDATE: mechanical|electrical|instrumentation_control|civil_structural|process|environmental|safety — 7 candidates stripped; promote to reference product]',
    `activity_code` STRING COMMENT 'Unique business identifier code for the commissioning activity, typically following organizational or project-specific numbering conventions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `activity_description` STRING COMMENT 'Detailed description of the commissioning activity scope, objectives, test procedures, acceptance criteria, and any special requirements or constraints.',
    `activity_name` STRING COMMENT 'Descriptive name of the commissioning activity (e.g., WTP Clarifier Startup Test, Distribution Main Disinfection and Flushing, SCADA Integration Testing).',
    `activity_status` STRING COMMENT 'Current lifecycle status of the commissioning activity. Planned indicates not yet started. In progress indicates active testing. On hold indicates temporary suspension. Completed indicates successful finish. Cancelled indicates activity was terminated. Failed indicates activity did not meet acceptance criteria.. Valid values are `planned|in_progress|on_hold|completed|cancelled|failed`',
    `activity_type` STRING COMMENT 'Classification of the commissioning activity type. Equipment startup includes mechanical and electrical equipment testing. Process performance testing validates treatment process efficiency. Disinfection and flushing applies to water mains and WTP equipment. Pressure testing validates pipeline integrity. SCADA integration ensures control system connectivity. Regulatory notification covers startup reporting to EPA or state agencies. [ENUM-REF-CANDIDATE: equipment_startup|process_performance_test|disinfection_flushing|pressure_test|scada_integration|regulatory_notification|functional_test|safety_system_test — 8 candidates stripped; promote to reference product]',
    `actual_completion_date` DATE COMMENT 'Actual date when the commissioning activity was completed and all acceptance criteria were met or deficiencies documented.',
    `actual_start_date` DATE COMMENT 'Actual date when the commissioning activity commenced. Used for schedule variance analysis and project performance tracking.',
    `contractor_sign_off_date` DATE COMMENT 'Date when the contractor signed off on the commissioning activity, certifying that the work meets contract requirements and specifications.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required before the asset can be turned over to operations. True if deficiencies must be resolved; false if activity passed without issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the commissioning activity record was first created in the system. Used for audit trail and data lineage tracking.',
    `deficiency_count` STRING COMMENT 'Number of deficiency items identified during the commissioning activity that require corrective action before final acceptance or operational turnover.',
    `deficiency_summary` STRING COMMENT 'Summary description of deficiencies identified during commissioning, including nature of issues, severity, and impact on operational readiness.',
    `disinfection_contact_time_minutes` DECIMAL(18,2) COMMENT 'Contact time in minutes for disinfection during commissioning, measured as the time the disinfectant remains in contact with the water or equipment surface. Critical for ensuring adequate microbial inactivation per EPA requirements.',
    `disinfection_method` STRING COMMENT 'Disinfection method used during commissioning for water mains, treatment plant equipment, or storage facilities. Applicable to water infrastructure commissioning activities.. Valid values are `chlorine|chloramine|chlorine_dioxide|uv|ozone|not_applicable`',
    `engineer_sign_off_date` DATE COMMENT 'Date when the design engineer or commissioning engineer signed off on the activity, certifying that the installation and testing meet design intent and industry standards.',
    `flow_test_result_gpm` DECIMAL(18,2) COMMENT 'Flow rate achieved during commissioning flow testing, measured in gallons per minute. Used to verify pump capacity, pipeline hydraulic performance, and treatment process flow rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the commissioning activity record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `notes` STRING COMMENT 'Additional notes, observations, lessons learned, or special conditions documented during the commissioning activity execution.',
    `operations_sign_off_date` DATE COMMENT 'Date when operations staff signed off on the commissioning activity, certifying readiness to accept the asset into operational service and assume maintenance responsibility.',
    `pressure_test_result_psi` DECIMAL(18,2) COMMENT 'Maximum pressure achieved during hydrostatic pressure testing of pipelines, tanks, or pressure vessels during commissioning. Used to verify structural integrity and leak-tightness.',
    `priority_level` STRING COMMENT 'Priority level assigned to the commissioning activity based on project criticality, regulatory deadlines, operational impact, and schedule dependencies.. Valid values are `critical|high|medium|low`',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval or clearance was received from the governing body, authorizing the asset to enter operational service.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory notification was submitted to the appropriate governing body for the commissioning activity.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to EPA, state drinking water program, or other governing body is required for this commissioning activity (e.g., new water treatment plant startup, major distribution system expansion).',
    `responsible_contact_email` STRING COMMENT 'Email address of the primary contact person responsible for the commissioning activity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_contact_name` STRING COMMENT 'Name of the primary contact person responsible for coordinating and executing the commissioning activity.',
    `responsible_contact_phone` STRING COMMENT 'Phone number of the primary contact person responsible for the commissioning activity.',
    `responsible_party_name` STRING COMMENT 'Name of the organization or individual responsible for executing the commissioning activity (e.g., contractor name, engineering firm, operations manager).',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for executing the commissioning activity. Contractor indicates construction contractor. Engineer indicates design engineer or commissioning engineer. Operations staff indicates utility operations personnel. Vendor indicates equipment supplier. Consultant indicates third-party specialist. Regulatory agency indicates government oversight body.. Valid values are `contractor|engineer|operations_staff|vendor|consultant|regulatory_agency`',
    `scada_integration_status` STRING COMMENT 'Status of SCADA system integration for the commissioned asset. Not applicable if asset does not require SCADA connectivity. Operational indicates successful integration and data flow to central control system.. Valid values are `not_applicable|not_started|in_progress|testing|operational|failed`',
    `scheduled_completion_date` DATE COMMENT 'Planned date for the commissioning activity to be completed, including all testing, documentation, and sign-off requirements.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the commissioning activity to begin, as defined in the project schedule or commissioning plan.',
    `sign_off_status` STRING COMMENT 'Current approval status of the commissioning activity. Tracks progression through required sign-offs from contractor, engineer, and operations staff before final acceptance.. Valid values are `pending|contractor_signed|engineer_signed|operations_signed|fully_approved|rejected`',
    `test_procedure_reference` STRING COMMENT 'Reference to the test procedure document, standard operating procedure (SOP), or industry standard that governs the commissioning activity execution (e.g., AWWA C651, manufacturer startup manual).',
    `test_result` STRING COMMENT 'Outcome of the commissioning activity test. Pass indicates all acceptance criteria met. Fail indicates criteria not met. Conditional pass indicates minor deficiencies that do not prevent operational turnover. Not tested indicates activity was not performed. In progress indicates testing is ongoing.. Valid values are `pass|fail|conditional_pass|not_tested|in_progress`',
    `water_quality_sample_collected_flag` BOOLEAN COMMENT 'Indicates whether water quality samples were collected during the commissioning activity for laboratory analysis (e.g., bacteriological testing after main disinfection, process performance verification).',
    CONSTRAINT pk_commissioning_activity PRIMARY KEY(`commissioning_activity_id`)
) COMMENT 'Commissioning and startup activity record for newly constructed or rehabilitated water/wastewater infrastructure including equipment startup testing, process performance testing, disinfection and flushing (for water mains and WTP equipment), pressure testing, SCADA integration testing, and regulatory startup notifications. Tracks activity type, scheduled date, actual date, responsible party (contractor, engineer, operations staff), pass/fail result, deficiency items identified, and sign-off status. Bridges construction completion and operational turnover.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` (
    `asset_handover_id` BIGINT COMMENT 'Unique identifier for the asset handover record. Primary key for this entity representing the formal transfer event from project/construction to operations.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: New infrastructure commissioned for specific large customers (industrial users, bulk water customers under special contracts) must be linked to their service agreements. Operations needs this for perf',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: AMI endpoints handed over from deployment projects to operations require tracking for acceptance testing, warranty management, operational readiness verification, and commissioning documentation. Esse',
    `vendor_id` BIGINT COMMENT 'Identifier of the general contractor or construction firm that built or installed the asset.',
    `registry_id` BIGINT COMMENT 'Identifier of the infrastructure asset being transferred to operations. Links to the asset registry in IBM Maximo Asset Management (CMMS).',
    `asset_vendor_id` BIGINT COMMENT 'Identifier of the general contractor or construction firm that built or installed the asset.',
    `cip_project_id` BIGINT COMMENT 'Identifier of the Capital Improvement Program (CIP) project or construction project from which this asset is being handed over.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Newly constructed assets operate under specific permits (new discharge outfall under NPDES permit, new treatment process under operating permit). Operations staff need permit reference at handover for',
    `construction_contract_id` BIGINT COMMENT 'Identifier of the construction contract under which the asset was delivered.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Asset handovers from construction projects include meters installed during main replacements or new service connections. Linking handover records to specific meters enables operations acceptance track',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: When new mains are turned over from construction to operations, the handover record must link to the specific pipe_main asset for warranty tracking, as-built documentation association, and maintenance',
    `primary_asset_registry_id` BIGINT COMMENT 'Identifier of the infrastructure asset being transferred to operations. Links to the asset registry in IBM Maximo Asset Management (CMMS).',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Pump station handovers must link to the specific station asset for SCADA integration verification, O&M manual association, spare parts inventory setup, warranty management, and operational acceptance',
    `quality_sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Asset handover to operations must document associated sampling points for ongoing compliance monitoring. Operations acceptance requires knowing which sampling points are now their responsibility and w',
    `sampling_location_id` BIGINT COMMENT 'Foreign key linking to laboratory.sampling_location. Business justification: Asset handover transfers sampling locations from construction to operations, including compliance monitoring points, access procedures, and regulatory designation. Required for operational readiness a',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Tank handovers require direct linkage to the storage_tank asset for regulatory inspection records, coating warranty tracking, mixing system documentation, level sensor calibration records, and operati',
    `as_built_drawing_reference` STRING COMMENT 'Document reference or hyperlink to the as-built engineering drawings reflecting the final constructed condition of the asset, stored in the document management system or GIS.',
    `asset_class_code` STRING COMMENT 'Classification code identifying the asset category for maintenance planning, depreciation, and asset management purposes (e.g., water treatment plant, distribution main, pump station).',
    `asset_description` STRING COMMENT 'Detailed description of the asset being handed over including type, capacity, specifications, and functional characteristics relevant to operations.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or equipment number affixed to the asset for field identification and tracking in the Computerized Maintenance Management System (CMMS).',
    `capitalization_date` DATE COMMENT 'Date when the asset was capitalized in SAP FI fixed assets module, triggering depreciation and inclusion in rate base for regulatory reporting.',
    `commissioning_report_reference` STRING COMMENT 'Document reference to the commissioning report verifying that the asset has been tested, started up, and is operating according to design specifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset handover record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the installed cost amount. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `depreciation_class` STRING COMMENT 'Depreciation category or class code used in SAP FI to determine useful life and depreciation method for financial reporting and rate-making purposes.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the asset meets all applicable environmental compliance requirements under Safe Drinking Water Act (SDWA), Clean Water Act (CWA), and state regulations.',
    `final_acceptance_date` DATE COMMENT 'Date when operations management formally accepted the asset after inspection and verification of all handover documentation and commissioning results.',
    `functional_location` STRING COMMENT 'Hierarchical functional location code in IBM Maximo representing the assets position within the utility infrastructure hierarchy (e.g., WTP-01/Filtration/Filter-3).',
    `geographic_location` STRING COMMENT 'Geographic location description or address where the asset is physically installed (e.g., facility name, street address, service area).',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this asset to its spatial feature in the Esri ArcGIS Geographic Information System (GIS) for network modeling and mapping.',
    `handover_date` DATE COMMENT 'The official date on which the asset was formally transferred from the project/construction team to the operations and maintenance team. This is the principal business event timestamp for this transaction.',
    `handover_notes` STRING COMMENT 'Free-text notes documenting special conditions, outstanding issues, lessons learned, or other relevant information about the asset handover process.',
    `handover_number` STRING COMMENT 'Business identifier or document number for this asset handover transaction, used for tracking and reference in project closeout documentation.',
    `handover_status` STRING COMMENT 'Current lifecycle status of the asset handover process indicating workflow stage from draft through final completion and acceptance.. Valid values are `draft|pending_review|approved|rejected|completed|cancelled`',
    `installed_cost_amount` DECIMAL(18,2) COMMENT 'Total capitalized cost of the asset including construction, materials, labor, equipment, and overhead allocated for capitalization in SAP FI fixed assets module.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset handover record was last updated or modified.',
    `om_manual_reference` STRING COMMENT 'Document reference or hyperlink to the Operations and Maintenance (O&M) manual provided by the contractor or equipment vendor for operational guidance.',
    `operations_acceptance_signature` STRING COMMENT 'Digital signature or sign-off indicator confirming that the operations manager has formally accepted the asset and all associated documentation.',
    `operations_manager_name` STRING COMMENT 'Name of the operations manager or supervisor who accepted responsibility for the asset on behalf of the operations team.',
    `project_manager_name` STRING COMMENT 'Name of the project manager or construction manager who delivered the asset and initiated the handover process.',
    `regulatory_permit_number` STRING COMMENT 'Environmental or construction permit number issued by EPA, state primacy agency, or local authority authorizing the construction and operation of the asset.',
    `responsible_operations_group` STRING COMMENT 'Name or code of the operations department, work center, or functional group that will assume ownership and maintenance responsibility for the asset (e.g., Water Treatment Operations, Distribution Maintenance).',
    `safety_certification_flag` BOOLEAN COMMENT 'Indicator of whether the asset has received all required safety certifications and Occupational Safety and Health Administration (OSHA) compliance approvals.',
    `sap_asset_number` STRING COMMENT 'SAP FI fixed asset master record number assigned upon capitalization for financial accounting and depreciation tracking.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicator of whether the asset has been integrated into the OSIsoft PI Historian or SCADA system for real-time monitoring and control.',
    `spare_parts_stocked_flag` BOOLEAN COMMENT 'Indicator of whether critical spare parts for the asset have been procured and stocked in inventory for maintenance support.',
    `substantial_completion_date` DATE COMMENT 'Date when the asset reached substantial completion per the construction contract, typically preceding final handover and marking readiness for beneficial use.',
    `training_completion_flag` BOOLEAN COMMENT 'Indicator of whether operations staff have completed all required training on the operation and maintenance of the new asset.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation and long-term asset management planning.',
    `warranty_duration_months` STRING COMMENT 'Duration of the warranty period in months as specified in the construction contract or equipment purchase agreement.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or contractor warranty period ends, after which the utility assumes full responsibility for repairs and maintenance costs.',
    `warranty_start_date` DATE COMMENT 'Date when the manufacturer or contractor warranty period begins, typically aligned with substantial completion or handover date.',
    CONSTRAINT pk_asset_handover PRIMARY KEY(`asset_handover_id`)
) COMMENT 'Asset handover record documenting the formal transfer of a newly constructed or rehabilitated infrastructure asset from the project/construction domain to the operations and asset management domain (IBM Maximo). Captures handover date, asset identifier (linking to asset domain), as-built drawing references, O&M manual references, warranty start date, warranty expiration date, installed cost for capitalization, depreciation class, responsible operations group, and acceptance sign-off by operations management. Triggers asset creation in Maximo and capitalization in SAP FI.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`funding_source` (
    `funding_source_id` BIGINT COMMENT 'Unique identifier for the funding source record. Primary key.',
    `fund_id` BIGINT COMMENT 'add column fund_id (BIGINT) with FK to finance.fund.fund_id - funding sources map to specific accounting funds',
    `administering_agency` STRING COMMENT 'Government agency or financial institution that administers and oversees the funding source. Examples: U.S. Environmental Protection Agency, State Department of Environmental Quality, USDA Rural Development, State Infrastructure Bank, Municipal Bond Authority.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Total amount already allocated or committed to specific CIP (Capital Improvement Program) projects from this funding source. Sum of all project allocations.',
    `arra_flag` BOOLEAN COMMENT 'Indicates whether this funding source originated from ARRA (American Recovery and Reinvestment Act) stimulus funding. True if ARRA funding; False otherwise. ARRA funds had additional reporting and Buy American requirements.',
    `authorization_date` DATE COMMENT 'Date when the funding source was officially authorized or approved. For bonds, the issuance date; for loans, the loan agreement date; for grants, the award date.',
    `available_balance` DECIMAL(18,2) COMMENT 'Remaining unallocated funding available for new project assignments. Calculated as total_authorized_amount minus allocated_amount.',
    `bond_insurance_provider` STRING COMMENT 'Name of the insurance company providing credit enhancement for bond issues. Bond insurance guarantees payment and can improve credit rating. Null if no insurance or not applicable.',
    `bond_rating` STRING COMMENT 'Credit rating assigned by rating agencies (Moodys, S&P, Fitch) for bond issues. Examples: AAA, AA+, A1, Baa2. Higher ratings indicate lower credit risk and typically lower interest rates. Null for non-bond funding.',
    `buy_american_required_flag` BOOLEAN COMMENT 'Indicates whether projects funded by this source must comply with Buy American provisions requiring use of domestically produced iron, steel, and manufactured goods. True if Buy American applies; False otherwise. Common for federal funding.',
    `funding_source_code` STRING COMMENT 'Unique business identifier code for the funding source used in financial systems and project documentation. Examples: DWSRF-2024-001, GOB-2023-SERIES-A, WIFIA-2025-LOAN.. Valid values are `^[A-Z0-9]{4,20}$`',
    `compliance_requirements` STRING COMMENT 'Summary of key compliance obligations associated with this funding source. Examples: NEPA (National Environmental Policy Act) review required; State Environmental Review Process; Disadvantaged Business Enterprise goals; Prevailing wage compliance; Single Audit Act requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding source record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this funding source record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `davis_bacon_required_flag` BOOLEAN COMMENT 'Indicates whether projects funded by this source must comply with Davis-Bacon prevailing wage requirements. True if Davis-Bacon applies; False otherwise. Typically required for federal grants and some SRF loans.',
    `disadvantaged_community_flag` BOOLEAN COMMENT 'Indicates whether this funding source is specifically designated for disadvantaged communities (typically defined by median household income thresholds). True if designated for disadvantaged communities; False otherwise. Affects eligibility for principal forgiveness and subsidized rates.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'Total amount actually disbursed or drawn down from this funding source to date. For loans and grants, this tracks actual cash received; for bonds, proceeds distributed.',
    `drawdown_restrictions` STRING COMMENT 'Description of limitations or conditions on fund disbursement. Examples: Reimbursement only after costs incurred; Requires pre-approval for each draw; Maximum monthly draw limit; Construction milestone-based disbursement; Retainage held until project completion.',
    `effective_start_date` DATE COMMENT 'Date when funds become available for allocation and drawdown. May differ from authorization date due to closing procedures or program launch delays.',
    `eligible_cost_categories` STRING COMMENT 'Description of cost categories eligible for reimbursement or funding. Examples: Design, Construction, Equipment, Land Acquisition or Construction Only or Planning, Design, Construction, Inspection. Some funding sources restrict soft costs or administrative expenses.',
    `eligible_project_types` STRING COMMENT 'Comma-separated list or description of CIP project types eligible for funding from this source. Examples: Water Treatment Plant Expansion, Distribution System Rehabilitation, Lead Service Line Replacement or Wastewater Treatment Upgrades, CSO (Combined Sewer Overflow) Abatement, Green Infrastructure. DWSRF (Drinking Water SRF) and CWSRF (Clean Water SRF) have specific eligible use categories.',
    `expiration_date` DATE COMMENT 'Date when the funding source expires or must be fully allocated. For grants, this is the period of performance end date; for bonds, the final maturity date; for loans, the commitment expiration. Null for perpetual funding sources.',
    `final_maturity_date` DATE COMMENT 'Date when all principal and interest must be fully repaid for debt instruments. Null for grants and PAYGO funding.',
    `first_payment_due_date` DATE COMMENT 'Date when the first principal or interest payment is due for debt instruments. Null for grants and non-debt funding. SRF loans often have deferred payment periods during construction.',
    `funding_source_type` STRING COMMENT 'Classification of the funding mechanism. Revenue bonds are secured by utility revenues; general obligation bonds by tax revenues; SRF (State Revolving Fund) loans include DWSRF (Drinking Water) and CWSRF (Clean Water); federal grants include WIFIA (Water Infrastructure Finance and Innovation Act), BRIC (Building Resilient Infrastructure and Communities), ARPA (American Rescue Plan Act); impact fees are one-time charges on new development; PAYGO (pay-as-you-go) uses current revenues. [ENUM-REF-CANDIDATE: revenue_bond|general_obligation_bond|srf_loan|federal_grant|state_grant|developer_contribution|impact_fee|paygo_reserve|wifia_loan|arpa_grant|bric_grant|other — 12 candidates stripped; promote to reference product]',
    `funding_status` STRING COMMENT 'Current lifecycle status of the funding source. Available: funds can be allocated to projects; Committed: allocated but not yet disbursed; Fully Allocated: no remaining capacity; Closed: program ended; Suspended: temporarily unavailable; Pending Approval: awaiting authorization.. Valid values are `available|committed|fully_allocated|closed|suspended|pending_approval`',
    `green_project_reserve_flag` BOOLEAN COMMENT 'Indicates whether this funding source is part of the Green Project Reserve, which prioritizes environmentally innovative projects (green infrastructure, water efficiency, energy efficiency). True if GPR funding; False otherwise. SRF programs must allocate at least 10% to GPR projects.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate for debt instruments (bonds, loans) expressed as a decimal percentage. For example, 3.5% is stored as 3.5000. Null for grants and non-debt funding sources. SRF (State Revolving Fund) loans typically have below-market rates.',
    `interest_rate_type` STRING COMMENT 'Classification of interest rate structure. Fixed: rate does not change; Variable: rate adjusts based on index; Zero: no interest charged (some grants); Subsidized: below-market rate (common for SRF loans and federal programs).. Valid values are `fixed|variable|zero|subsidized`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding source record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field.',
    `match_requirement_percentage` DECIMAL(18,2) COMMENT 'Percentage of project cost that must be funded from other sources (local match). For example, a 20% match means the utility must provide 20% and the funding source covers 80%. Zero for funding sources with no match requirement. Common for federal grants.',
    `funding_source_name` STRING COMMENT 'Full descriptive name of the funding source including program name, series, and year. Example: Drinking Water State Revolving Fund 2024 Series A or General Obligation Bond 2023 Infrastructure Series.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this funding source. Free-text field for capturing unique requirements, historical context, or operational guidance.',
    `prepayment_allowed_flag` BOOLEAN COMMENT 'Indicates whether early repayment of principal is permitted without penalty for debt instruments. True if prepayment allowed; False if prepayment prohibited or penalized. Null for non-debt funding.',
    `prepayment_penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage penalty charged for early repayment if prepayment is restricted. Zero if no penalty applies. Null for non-debt funding or if prepayment is not allowed.',
    `principal_forgiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage of loan principal that is forgiven (does not require repayment). Common in SRF programs for disadvantaged communities or specific project types (e.g., lead service line replacement). Zero if no forgiveness applies.',
    `program_name` STRING COMMENT 'Official name of the funding program or initiative. Examples: EPA Drinking Water State Revolving Fund, USDA Water and Waste Disposal Loan Program, State Infrastructure Bank, Bipartisan Infrastructure Law Grant Program.',
    `reporting_frequency` STRING COMMENT 'Required frequency for progress and financial reporting to the funding agency. SRF loans typically require quarterly reports; federal grants often require quarterly or semi-annual reports; bonds may require annual disclosure.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed|none`',
    `reporting_requirements` STRING COMMENT 'Detailed description of reporting obligations including report types, submission deadlines, and required content. Examples: Quarterly progress reports due 30 days after quarter end; Annual financial audit; DBE (Disadvantaged Business Enterprise) utilization reports; Environmental compliance certifications.',
    `term_months` STRING COMMENT 'Total term or duration of the funding instrument in months. For bonds and loans, this is the repayment period. SRF loans typically have 20-30 year terms (240-360 months). Null for grants and PAYGO (pay-as-you-go) funding.',
    `total_authorized_amount` DECIMAL(18,2) COMMENT 'Total funding amount authorized or available under this funding source. For bonds, this is the par value; for loans, the principal amount; for grants, the award amount; for PAYGO, the budgeted reserve allocation.',
    `trustee_name` STRING COMMENT 'Name of the financial institution serving as trustee for bond proceeds and debt service payments. The trustee holds funds and ensures compliance with bond covenants. Null for non-bond funding.',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Funding source master record defining the financial mechanisms used to fund CIP projects including revenue bonds, state revolving fund (SRF) loans (DWSRF/CWSRF), federal grants (BRIC, WIFIA, ARPA), general obligation bonds, developer contributions, impact fees, and pay-as-you-go (PAYGO) reserves. Tracks funding source type, program name, administering agency, total available amount, interest rate (for debt instruments), compliance requirements, eligible project types, reporting obligations, and drawdown restrictions. Essential for CIP financial planning and grant compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` (
    `funding_allocation_id` BIGINT COMMENT 'Unique identifier for the project funding allocation record. Primary key for this association entity linking a Capital Improvement Program (CIP) project to a specific funding source.',
    `cip_project_id` BIGINT COMMENT 'Reference to the Capital Improvement Program (CIP) project receiving funding from this allocation. Links to the parent project entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Funding allocations may restrict use to specific cost centers or departments per grant or loan covenants. Required for compliance tracking.',
    `funding_source_id` BIGINT COMMENT 'Reference to the specific funding source providing capital for this project allocation. May represent State Revolving Fund (SRF) loans, federal grants, municipal bonds, rate revenue, or other capital sources.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Project funding from rate revenue or bonds is tied to specific tariff structures and rate cases that authorized the revenue. Regulatory financial reporting and rate case filings require linking projec',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Total dollar amount allocated from this funding source to the project. Represents the authorized funding limit that may be drawn down over the project lifecycle.',
    `allocation_number` STRING COMMENT 'Business identifier for this funding allocation, typically assigned by the finance department or funding agency. Used for tracking and reporting purposes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total project cost represented by this funding allocation. Enables analysis of funding mix and source diversification across the Capital Improvement Program (CIP).',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the funding allocation. Tracks progression from initial proposal through approval, commitment, active drawdown, and final closure or cancellation. [ENUM-REF-CANDIDATE: proposed|approved|committed|active|drawn|closed|cancelled|suspended — 8 candidates stripped; promote to reference product]',
    `american_iron_steel_required_flag` BOOLEAN COMMENT 'Indicates whether American Iron and Steel requirements apply to materials procured with this funding allocation. Mandated for State Revolving Fund (SRF) and many federal grant programs.',
    `amount_drawn_to_date` DECIMAL(18,2) COMMENT 'Cumulative dollar amount that has been drawn down or disbursed from this funding allocation as of the current date. Updated as project expenditures are incurred and reimbursement requests are processed.',
    `approval_date` DATE COMMENT 'Date when this funding allocation was officially approved by the funding authority, board of directors, or governing body. Establishes the effective start of the allocation.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Dollar amount committed through purchase orders, contracts, or other encumbrances against this funding allocation but not yet drawn. Represents funds obligated but not yet disbursed.',
    `compliance_requirements` STRING COMMENT 'Description of regulatory, environmental, and administrative compliance requirements imposed by the funding source. May include Davis-Bacon prevailing wage, American Iron and Steel requirements, environmental reviews, or other federal and state mandates.',
    `conditions_precedent` STRING COMMENT 'Description of conditions that must be satisfied before funds from this allocation may be drawn. May include regulatory approvals, environmental clearances, matching fund requirements, or other prerequisites imposed by the funding source.',
    `conditions_precedent_met_date` DATE COMMENT 'Date when all conditions precedent were satisfied and the allocation became available for drawdown. Establishes the start of the active funding period.',
    `conditions_precedent_met_flag` BOOLEAN COMMENT 'Indicates whether all conditions precedent have been satisfied and the allocation is available for drawdown. True when all prerequisites are met; false when conditions remain outstanding.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this funding allocation record was first created in the system. Audit trail field for data governance and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocation amount. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `davis_bacon_required_flag` BOOLEAN COMMENT 'Indicates whether Davis-Bacon prevailing wage requirements apply to construction work funded by this allocation. True for most federal funding sources; false for purely local funding.',
    `drawdown_schedule_type` STRING COMMENT 'Classification of the drawdown schedule governing when and how funds may be requested from this allocation. Defines the timing and frequency of fund disbursements.. Valid values are `milestone|monthly|quarterly|reimbursement|lump_sum|as_needed`',
    `effective_end_date` DATE COMMENT 'Date when this funding allocation expires or must be fully drawn. Critical for State Revolving Fund (SRF) loans and grants with time-limited availability.',
    `effective_start_date` DATE COMMENT 'Date when this funding allocation becomes available for drawdown. May differ from approval date based on funding source terms and conditions precedent.',
    `eligible_cost_categories` STRING COMMENT 'Description of project cost categories that are eligible for reimbursement from this funding allocation. May restrict use to construction, engineering, land acquisition, or other specific categories based on funding source rules.',
    `first_payment_due_date` DATE COMMENT 'Date when the first repayment installment is due for loan-based funding allocations. Null for grants and equity funding.',
    `forgiveness_amount` DECIMAL(18,2) COMMENT 'Dollar amount of principal forgiveness granted as part of this funding allocation. Common in State Revolving Fund (SRF) programs for disadvantaged communities or green infrastructure projects.',
    `forgiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage of the allocation amount that is forgiven and does not require repayment. Represents the grant portion of a subsidized loan.',
    `funding_agency_contact_email` STRING COMMENT 'Email address of the primary contact person at the funding agency. Used for submitting reports and coordinating drawdown requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `funding_agency_contact_name` STRING COMMENT 'Name of the primary contact person at the funding agency responsible for administering this allocation. Used for coordination and compliance reporting.',
    `funding_agency_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the funding agency. Used for coordination and issue resolution.',
    `funding_priority_rank` STRING COMMENT 'Priority ranking of this funding allocation relative to other allocations for the same project. Lower numbers indicate higher priority for drawdown when multiple sources are available.',
    `grant_agreement_number` STRING COMMENT 'Official agreement or contract number assigned by the funding agency for grant-based allocations. Used for tracking and reporting to federal and state agencies.',
    `ineligible_cost_categories` STRING COMMENT 'Description of project cost categories that are explicitly ineligible for reimbursement from this funding allocation. Common exclusions include administrative overhead, legal fees, or operations and maintenance (O&M) costs.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to this funding allocation if it represents a loan or bond. Expressed as a decimal (e.g., 0.0250 for 2.50 percent). Null for grants and equity funding.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this funding allocation record was most recently updated. Audit trail field for tracking changes and data lineage.',
    `loan_agreement_number` STRING COMMENT 'Official loan agreement or promissory note number assigned by the lending institution for loan-based allocations. Used for tracking State Revolving Fund (SRF) and other loan programs.',
    `matching_amount` DECIMAL(18,2) COMMENT 'Dollar amount of matching funds required from other sources to satisfy the matching requirement for this allocation.',
    `matching_percentage` DECIMAL(18,2) COMMENT 'Required percentage of project cost that must be funded from other sources to satisfy matching requirements. Common for federal and state grant programs.',
    `matching_requirement_flag` BOOLEAN COMMENT 'Indicates whether this funding allocation requires matching funds from other sources. True for grants and loans with local match requirements; false for fully-funded allocations.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special conditions, or administrative notes related to this funding allocation. Used to capture context not covered by structured fields.',
    `reimbursement_basis` STRING COMMENT 'Method by which drawdown requests are calculated and approved. Determines whether reimbursements are based on actual incurred costs, percentage of work complete, achievement of milestones, or advance payments.. Valid values are `actual_cost|percentage_complete|milestone|advance|hybrid`',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Remaining available balance in this funding allocation calculated as allocation amount minus amount drawn to date. Represents uncommitted funds still available for project expenditures.',
    `repayment_term_months` STRING COMMENT 'Number of months over which this funding allocation must be repaid if it represents a loan. Typical State Revolving Fund (SRF) loans have 20-30 year terms (240-360 months). Null for grants.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting progress and financial reports to the funding source. Defines compliance reporting obligations for this allocation.. Valid values are `monthly|quarterly|semi_annual|annual|milestone|as_required`',
    CONSTRAINT pk_funding_allocation PRIMARY KEY(`funding_allocation_id`)
) COMMENT 'Association record linking a CIP project to one or more funding sources with the specific dollar amount allocated from each source. Supports multi-source funding scenarios where a single project draws from SRF loans, grants, and rate revenue simultaneously. Tracks allocation amount, percentage of total project cost, drawdown schedule, conditions precedent to drawdown, amount drawn to date, and remaining available balance. Enables funding compliance reporting and ensures projects do not exceed authorized funding limits.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` (
    `land_acquisition_id` BIGINT COMMENT 'Unique identifier for the land acquisition record. Primary key for the land acquisition entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Land acquisition agents are utility real estate staff. Tracking which employee manages property negotiations, appraisals, and eminent domain proceedings is essential for legal accountability, audit tr',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project requiring this land acquisition. Links the property acquisition to the infrastructure project that necessitates it.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Land acquisitions charge to cost centers for project cost tracking and departmental accountability. Required for full-cost accounting.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Land acquisitions are capital expenditures funded from specific utility funds. Required for fund accounting and capital asset tracking.',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Easement acquisitions for pipeline corridors must be linked to the specific main alignment for right-of-way management, future maintenance access, encroachment prevention, and legal documentation of a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Land parcels acquired for utility infrastructure (treatment plants, pump stations, easements) are within specific service territories. GIS asset management, franchise compliance, and property tax repo',
    `acceptance_date` DATE COMMENT 'Date when the property owner accepted the utilitys acquisition offer, forming the basis for the purchase agreement.',
    `acquisition_notes` STRING COMMENT 'Free-text notes documenting negotiation history, special conditions, owner concerns, unique circumstances, or other relevant information about the acquisition process.',
    `acquisition_priority` STRING COMMENT 'Priority level for completing this acquisition based on project schedule criticality and construction sequencing requirements.. Valid values are `critical|high|medium|low`',
    `acquisition_purpose` STRING COMMENT 'Detailed description of why this property acquisition is required for the CIP project. Examples: water main installation, treatment plant expansion, pump station construction, access road, permanent facility site.',
    `acquisition_status` STRING COMMENT 'Current status of the land acquisition process. Tracks progression from initial identification through final deed recording. [ENUM-REF-CANDIDATE: identified|negotiation|appraisal_ordered|appraisal_complete|offer_made|accepted|rejected|condemnation_filed|acquired|recorded — 10 candidates stripped; promote to reference product]',
    `acquisition_type` STRING COMMENT 'Type of property interest being acquired. Fee simple represents full ownership; permanent easement grants perpetual use rights; temporary construction easement allows limited-duration construction access; right-of-way grants passage rights; license grants revocable permission; lease grants time-limited possession.. Valid values are `fee_simple|permanent_easement|temporary_construction_easement|right_of_way|license|lease`',
    `appraisal_date` DATE COMMENT 'Date when the certified appraisal was completed by a qualified real estate appraiser, establishing fair market value for just compensation purposes.',
    `appraised_value_amount` DECIMAL(18,2) COMMENT 'Fair market value of the property interest as determined by a certified real estate appraiser. Establishes baseline for just compensation under eminent domain law.',
    `appraiser_name` STRING COMMENT 'Name of the certified real estate appraiser who performed the property valuation. Used for documentation and potential testimony in condemnation proceedings.',
    `condemnation_filing_date` DATE COMMENT 'Date when the utility filed a condemnation petition or complaint with the court to acquire the property through eminent domain. Null if voluntary acquisition was successful.',
    `court_case_number` STRING COMMENT 'Official court case number assigned to the eminent domain condemnation proceeding. Used for tracking legal proceedings and court-ordered compensation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this land acquisition record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this acquisition record. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `deed_book_reference` STRING COMMENT 'Official recording reference including deed book number and page number where the instrument is recorded in county land records. Format varies by jurisdiction (e.g., Book 1234, Page 567 or Document Number 2023-12345).',
    `deed_recording_date` DATE COMMENT 'Date when the deed, easement, or other property instrument was officially recorded with the county recorders office, completing the legal transfer of property rights.',
    `eminent_domain_flag` BOOLEAN COMMENT 'Indicates whether eminent domain (condemnation) proceedings were initiated or required because voluntary acquisition negotiations failed. True if condemnation was filed; false if acquired through voluntary negotiation.',
    `environmental_assessment_status` STRING COMMENT 'Status of Phase I or Phase II environmental site assessment to identify potential contamination, hazardous materials, or environmental liabilities on the property.. Valid values are `not_required|required|in_progress|complete|remediation_needed|cleared`',
    `environmental_findings_summary` STRING COMMENT 'Summary of environmental assessment findings including any recognized environmental conditions, contamination, or remediation requirements that affect property value or acquisition feasibility.',
    `infrastructure_asset_type` STRING COMMENT 'Type of water or wastewater infrastructure asset that will be constructed on or require this acquired property. [ENUM-REF-CANDIDATE: water_main|transmission_main|distribution_main|pump_station|treatment_plant|storage_tank|well_site|access_road|utility_corridor — 9 candidates stripped; promote to reference product]',
    `just_compensation_award` DECIMAL(18,2) COMMENT 'Final compensation amount awarded by the court in condemnation proceedings. Represents the courts determination of just compensation under the Fifth Amendment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this land acquisition record was most recently updated. Used for audit trail and change tracking.',
    `legal_counsel_name` STRING COMMENT 'Name of the attorney or law firm providing legal counsel for this acquisition, including title review, contract preparation, and condemnation representation if required.',
    `negotiated_acquisition_cost` DECIMAL(18,2) COMMENT 'Final negotiated purchase price or compensation amount agreed upon between the utility and property owner. May differ from appraised value based on negotiation outcomes.',
    `offer_date` DATE COMMENT 'Date when the utility made its initial written offer to purchase or acquire the property interest from the owner.',
    `parcel_area_acres` DECIMAL(18,2) COMMENT 'Total area of the parcel or portion being acquired, measured in acres. Used for valuation and compensation calculations.',
    `parcel_area_square_feet` DECIMAL(18,2) COMMENT 'Total area of the parcel or portion being acquired, measured in square feet. Provides precise measurement for engineering and legal documentation.',
    `parcel_identifier` STRING COMMENT 'Official tax assessor parcel number or legal property identifier assigned by the county or municipal tax authority. Used for legal property identification and title search.',
    `property_owner_contact_address` STRING COMMENT 'Mailing address for the property owner used for official correspondence, notices, and negotiation communications.',
    `property_owner_email` STRING COMMENT 'Email address for electronic communication with the property owner regarding acquisition matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `property_owner_name` STRING COMMENT 'Full legal name of the property owner or entity holding title as recorded in county land records. May be individual, corporation, trust, or government entity.',
    `property_owner_phone` STRING COMMENT 'Primary telephone number for contacting the property owner during acquisition negotiations.',
    `property_use_type` STRING COMMENT 'Current use classification of the property being acquired. Affects valuation methodology, relocation assistance requirements, and environmental assessment scope. [ENUM-REF-CANDIDATE: residential|commercial|industrial|agricultural|vacant_land|government|institutional — 7 candidates stripped; promote to reference product]',
    `relocation_assistance_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost of relocation assistance benefits owed to displaced persons or businesses under the Uniform Relocation Assistance Act. Includes moving expenses, replacement housing payments, and business re-establishment costs.',
    `survey_completion_date` DATE COMMENT 'Date when the professional land survey was completed, establishing precise legal boundaries, area measurements, and identifying any encroachments or easements.',
    `title_issues_description` STRING COMMENT 'Detailed description of any title defects, liens, mortgages, easements, or other encumbrances discovered during title examination that must be resolved before acquisition.',
    `title_search_status` STRING COMMENT 'Status of the title search and examination process to verify clear ownership and identify any liens, encumbrances, or defects that could affect acquisition.. Valid values are `not_started|in_progress|complete|issues_identified|cleared`',
    `zoning_classification` STRING COMMENT 'Municipal or county zoning classification code for the property (e.g., R-1, C-2, M-1). Affects permitted uses and property valuation.',
    CONSTRAINT pk_land_acquisition PRIMARY KEY(`land_acquisition_id`)
) COMMENT 'Real property acquisition record for land, easements, and rights-of-way required for CIP project construction and permanent infrastructure operation. Tracks parcel identifier, property owner, acquisition type (fee simple, permanent easement, temporary construction easement, right-of-way), parcel area, appraised value, negotiated acquisition cost, relocation assistance obligations, title search status, environmental assessment status, deed recording date, and project association. Supports eminent domain proceedings and just compensation documentation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`risk` (
    `risk_id` BIGINT COMMENT 'Unique identifier for the project risk register entry. Primary key for the project risk product.',
    `cip_project_id` BIGINT COMMENT 'Reference to the Capital Improvement Program (CIP) project to which this risk applies. Links risk to the parent infrastructure expansion, rehabilitation, or renewal project.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk owners are project team members (employees). PMI and utility capital project standards require assigning accountability for risk mitigation to specific employees. Essential for risk register repo',
    `actual_cost_impact_amount` DECIMAL(18,2) COMMENT 'Actual financial impact incurred if the risk was realized, measured as the incremental cost to the project. Used for contingency reserve tracking and variance analysis.',
    `actual_schedule_impact_days` STRING COMMENT 'Actual schedule delay in calendar days incurred if the risk was realized. Used for schedule variance analysis and lessons learned.',
    `risk_category` STRING COMMENT 'Classification of the risk by source or domain. Categories include geotechnical (soil conditions, subsurface unknowns), regulatory (permit delays, compliance changes), design (engineering errors, scope gaps), contractor performance (quality, schedule adherence), supply chain (material availability, price volatility), environmental (contamination, protected species), community opposition (public hearings, legal challenges), financial, schedule, safety, quality, and technology risks. [ENUM-REF-CANDIDATE: geotechnical|regulatory|design|contractor_performance|supply_chain|environmental|community_opposition|financial|schedule|safety|quality|technology — 12 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date when the risk was formally closed, either because the threat passed, mitigation was successful, or the risk was realized and consequences managed. Used for risk lifecycle tracking and reporting.',
    `contingency_plan` STRING COMMENT 'Reactive response plan to be executed if the risk event occurs despite mitigation efforts. Describes the specific actions, resources, and decision authorities required to minimize damage and restore project progress.',
    `contingency_reserve_allocated_amount` DECIMAL(18,2) COMMENT 'Portion of the project contingency budget allocated to this specific risk based on its risk exposure amount. Used for contingency budget management and justification to funding authorities.',
    `cost_impact_rating` STRING COMMENT 'Qualitative assessment of the potential financial impact to the project budget if the risk is realized. Ratings range from negligible (minimal budget variance) to severe (significant budget overrun requiring board approval or funding reallocation).. Valid values are `negligible|minor|moderate|major|severe`',
    `cost_impact_score` STRING COMMENT 'Numeric score representing the cost impact rating, typically on a scale of 1 to 5, where 1 is negligible and 5 is severe. Used for quantitative risk scoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register entry was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this risk entry (e.g., USD for United States Dollar). Ensures consistent financial reporting across multi-currency projects.. Valid values are `^[A-Z]{3}$`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk event, including the nature of the threat, potential triggers, and context within the project lifecycle.',
    `estimated_cost_impact_amount` DECIMAL(18,2) COMMENT 'Quantitative estimate of the potential cost increase to the project if the risk event occurs, expressed in the project currency. Used for contingency budget planning and financial exposure analysis.',
    `estimated_schedule_impact_days` STRING COMMENT 'Quantitative estimate of the potential delay in calendar days if the risk event occurs. Used for critical path analysis and project completion forecasting.',
    `exposure_amount` DECIMAL(18,2) COMMENT 'Expected monetary value of the risk, calculated as probability (percentage) multiplied by estimated cost impact. Represents the statistically expected financial exposure and is used for contingency reserve allocation.',
    `identification_date` DATE COMMENT 'Date when the risk was first identified and entered into the project risk register. Used for tracking risk discovery patterns and audit trails.',
    `identified_by_name` STRING COMMENT 'Name of the individual or team who identified the risk. Supports knowledge management and lessons learned processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register entry was last updated. Tracks the currency of risk information and supports change management processes.',
    `last_review_date` DATE COMMENT 'Date of the most recent risk review or reassessment. Risks should be reviewed regularly (typically monthly for active CIP projects) to update probability, impact, and mitigation status.',
    `mitigation_strategy` STRING COMMENT 'Detailed description of the proactive actions, controls, or process changes planned to reduce the probability or impact of the risk. Includes preventive measures, early warning systems, and risk transfer mechanisms (e.g., insurance, performance bonds).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal risk review. Ensures risks are monitored on a regular cadence and not overlooked during project execution.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or context regarding the risk, mitigation progress, stakeholder concerns, or lessons learned. Supports comprehensive risk documentation and knowledge transfer.',
    `owner_role` STRING COMMENT 'Organizational role or title of the risk owner (e.g., Project Manager, Design Engineer, Construction Manager, Regulatory Compliance Manager). Provides context for accountability and escalation paths.',
    `probability_rating` STRING COMMENT 'Qualitative assessment of the likelihood that the risk event will occur during the project lifecycle. Ratings typically follow a five-point scale: very low (0-10%), low (10-30%), medium (30-50%), high (50-70%), very high (70-100%).. Valid values are `very_low|low|medium|high|very_high`',
    `probability_score` STRING COMMENT 'Numeric score representing the probability rating, typically on a scale of 1 to 5, where 1 is very low and 5 is very high. Used for quantitative risk scoring and prioritization.',
    `quality_impact_rating` STRING COMMENT 'Qualitative assessment of the potential impact to project deliverable quality, asset performance, or operational reliability if the risk is realized. Includes impacts to water quality compliance, treatment capacity, or asset lifespan.. Valid values are `negligible|minor|moderate|major|severe`',
    `realization_date` DATE COMMENT 'Date when the risk event actually occurred. Populated only if risk status is realized. Used for lessons learned analysis and contingency reserve reconciliation.',
    `residual_cost_impact_rating` STRING COMMENT 'Reassessed cost impact rating after mitigation actions have been implemented. Reflects the reduced financial exposure given the controls in place.. Valid values are `negligible|minor|moderate|major|severe`',
    `residual_probability_rating` STRING COMMENT 'Reassessed probability rating after mitigation actions have been implemented. Reflects the reduced likelihood of the risk event occurring given the controls in place.. Valid values are `very_low|low|medium|high|very_high`',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Recalculated composite risk score after mitigation, using residual probability and impact ratings. Used to assess the effectiveness of risk response actions and determine if additional mitigation is required.',
    `residual_schedule_impact_rating` STRING COMMENT 'Reassessed schedule impact rating after mitigation actions have been implemented. Reflects the reduced schedule exposure given the controls in place.. Valid values are `negligible|minor|moderate|major|severe`',
    `response_strategy` STRING COMMENT 'High-level strategy for managing the risk. Avoid: eliminate the threat by changing project scope or approach. Mitigate: reduce probability or impact. Transfer: shift risk to third party (insurance, contract terms). Accept: acknowledge risk and allocate contingency. Escalate: elevate to program or executive level for decision.. Valid values are `avoid|mitigate|transfer|accept|escalate`',
    `risk_number` STRING COMMENT 'Business identifier for the risk entry, typically formatted as project code plus sequential risk number (e.g., WTP-2024-R001). Used for external communication and reporting.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk. Open: identified but mitigation not yet started. Active: mitigation actions in progress. Mitigated: mitigation complete, residual risk accepted. Closed: risk no longer applicable or threat passed. Realized: risk event occurred. Monitoring: low-priority risk under passive observation.. Valid values are `open|active|mitigated|closed|realized|monitoring`',
    `schedule_impact_rating` STRING COMMENT 'Qualitative assessment of the potential delay to the project schedule if the risk is realized. Ratings range from negligible (no material delay) to severe (critical path delay, missed regulatory deadlines, or substantial commissioning postponement).. Valid values are `negligible|minor|moderate|major|severe`',
    `schedule_impact_score` STRING COMMENT 'Numeric score representing the schedule impact rating, typically on a scale of 1 to 5, where 1 is negligible and 5 is severe. Used for quantitative risk scoring.',
    `score` DECIMAL(18,2) COMMENT 'Composite quantitative risk score calculated as the product of probability score and impact scores (cost, schedule, quality). Used for risk prioritization and ranking within the project risk register. Higher scores indicate higher priority risks requiring active management.',
    `subcategory` STRING COMMENT 'Optional secondary classification providing additional granularity within the primary risk category (e.g., under regulatory: NPDES permit, SDWA compliance, wetlands permit).',
    `title` STRING COMMENT 'Concise title or name of the identified risk for quick reference and reporting.',
    `trigger_event_description` STRING COMMENT 'Description of the specific conditions, milestones, or indicators that signal the risk is about to occur or has increased in likelihood. Used for early warning and proactive response activation.',
    CONSTRAINT pk_risk PRIMARY KEY(`risk_id`)
) COMMENT 'Project risk register entry documenting identified risks that could impact CIP project scope, schedule, cost, or quality. Tracks risk identifier, risk category (geotechnical, regulatory, design, contractor performance, supply chain, environmental, community opposition), risk description, probability rating, impact rating (cost and schedule), risk score, mitigation strategy, contingency plan, risk owner, status (open, mitigated, closed, realized), and residual risk assessment. Supports proactive project risk management and contingency budget justification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`issue` (
    `issue_id` BIGINT COMMENT 'Unique identifier for the project issue record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement program (CIP) project to which this issue belongs.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the construction or service contract under which the issue arose, if applicable. Null if issue is not contract-related.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Issue identifiers are project team employees. Tracking who identified issues is essential for lessons learned, quality improvement, and employee performance reviews. Standard project management practi',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor involved in or responsible for the issue, if applicable. Null if issue does not involve a contractor.',
    `request_for_information_id` BIGINT COMMENT 'Reference to the RFI that preceded or is associated with this issue, if applicable. Null if no RFI relationship exists.',
    `issue_rfi_request_for_information_id` BIGINT COMMENT 'Reference to the RFI that preceded or is associated with this issue, if applicable. Null if no RFI relationship exists.',
    `issue_vendor_id` BIGINT COMMENT 'Reference to the contractor involved in or responsible for the issue, if applicable. Null if issue does not involve a contractor.',
    `change_order_id` BIGINT COMMENT 'Reference to the change order generated as a result of this issue, if applicable. Null if no change order was required.',
    `actual_resolution_date` DATE COMMENT 'Actual calendar date when the issue was resolved and solution implemented. Null if issue is still open or in progress.',
    `asset_class_affected` STRING COMMENT 'Type of infrastructure asset impacted by the issue (e.g., water main, pump, valve, treatment equipment, SCADA system). Used for asset management integration and maintenance planning.',
    `assigned_date` DATE COMMENT 'Date when the issue was assigned to the current resolver.',
    `assigned_resolver` STRING COMMENT 'Name or identifier of the individual or team responsible for investigating and resolving the issue. May be reassigned during escalation.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, photos, drawings, or other files attached to the issue record (e.g., site photos, correspondence, technical drawings, inspection reports).',
    `corrective_action` STRING COMMENT 'Description of the immediate corrective measures taken to resolve the issue and prevent recurrence on this project.',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the issue on project budget, expressed in the project currency. Includes direct costs (rework, materials, labor) and indirect costs (delay penalties, escalation). Positive values indicate cost increase; negative values indicate cost savings.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the issue record was first created in the project management system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost impact amount (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `date_identified` DATE COMMENT 'Calendar date when the issue was first discovered or reported. Distinct from when the issue record was created in the system.',
    `issue_description` STRING COMMENT 'Detailed narrative description of the problem, conflict, or decision requiring resolution. Includes context, background, and any relevant technical or operational details.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue has environmental consequences (e.g., potential discharge violation, habitat disturbance, contamination risk). True if environmental impact exists; false otherwise.',
    `escalation_date` DATE COMMENT 'Date when the issue was escalated to a higher authority level. Null if no escalation has occurred.',
    `escalation_level` STRING COMMENT 'Current escalation tier for the issue: none (handled at working level), supervisor (escalated to first-line supervisor), manager (escalated to department manager), director (escalated to division director), executive (escalated to C-suite), board (escalated to governing board or commission).. Valid values are `none|supervisor|manager|director|executive|board`',
    `escalation_reason` STRING COMMENT 'Explanation of why the issue was escalated (e.g., missed target resolution date, cost impact exceeds threshold, requires executive decision, regulatory urgency).',
    `issue_number` STRING COMMENT 'Business-facing unique issue tracking number assigned sequentially or per project numbering scheme. Used for communication and reference in project documentation.',
    `issue_status` STRING COMMENT 'Current lifecycle state of the issue: open (newly identified), in_progress (actively being worked), pending_approval (awaiting decision or sign-off), resolved (solution implemented), closed (issue finalized and archived), escalated (elevated to higher authority).. Valid values are `open|in_progress|pending_approval|resolved|closed|escalated`',
    `issue_type` STRING COMMENT 'Classification of the issue by nature: design conflict (engineering or architectural discrepancy), contractor dispute (disagreement with contractor), permit delay (regulatory approval holdup), utility conflict (interference with existing water/wastewater/other utilities), community complaint (public or stakeholder concern), or regulatory requirement change (new compliance mandate).. Valid values are `design_conflict|contractor_dispute|permit_delay|utility_conflict|community_complaint|regulatory_requirement_change`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the issue record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or context not captured in structured fields. Used for audit trail and knowledge transfer.',
    `preventive_action` STRING COMMENT 'Description of systemic changes or process improvements implemented to prevent similar issues on future projects (e.g., updated design standards, enhanced review procedures, training programs).',
    `priority_level` STRING COMMENT 'Urgency and importance classification for resolution sequencing. Critical issues threaten project viability or safety; high issues impact schedule or budget significantly; medium issues require attention but have workarounds; low issues are minor inconveniences.. Valid values are `critical|high|medium|low`',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue has regulatory or compliance implications (e.g., affects NPDES permit, SDWA compliance, environmental discharge limits). True if regulatory impact exists; false otherwise.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulation, permit condition, or compliance requirement affected by the issue (e.g., NPDES Permit Section 3.2, SDWA MCL for lead).',
    `resolution_description` STRING COMMENT 'Detailed narrative of the solution implemented, actions taken, decisions made, and any corrective measures applied to resolve the issue.',
    `root_cause_analysis` STRING COMMENT 'Detailed investigation findings explaining the fundamental reason the issue occurred. Used for lessons learned and process improvement.',
    `root_cause_category` STRING COMMENT 'Classification of the underlying cause of the issue: design_error (engineering or architectural mistake), construction_defect (workmanship problem), material_failure (defective or unsuitable materials), coordination_failure (communication or sequencing breakdown), scope_ambiguity (unclear requirements), external_factor (third-party or force majeure).. Valid values are `design_error|construction_defect|material_failure|coordination_failure|scope_ambiguity|external_factor`',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue poses a safety risk to workers, public, or operations. True if safety concern exists; false otherwise.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days by which the issue has delayed or is expected to delay the project schedule. Negative values indicate schedule acceleration if issue resolution improved timeline.',
    `scope_impact_description` STRING COMMENT 'Narrative description of how the issue affected project scope, including specific deliverables added, removed, or modified.',
    `scope_impact_flag` BOOLEAN COMMENT 'Indicates whether the issue resulted in a change to project scope (addition, deletion, or modification of deliverables). True if scope was affected; false otherwise.',
    `target_resolution_date` DATE COMMENT 'Planned or committed date by which the issue should be resolved. Used for tracking resolution performance and escalation triggers.',
    `title` STRING COMMENT 'Short descriptive title summarizing the issue for quick identification in dashboards and reports.',
    `work_location` STRING COMMENT 'Physical location or site area where the issue occurred (e.g., pump station 5, distribution main on Oak Street, wastewater treatment plant clarifier 2). Supports geographic analysis and field coordination.',
    CONSTRAINT pk_issue PRIMARY KEY(`issue_id`)
) COMMENT 'Active project issue record tracking problems, conflicts, or decisions requiring resolution during project execution. Distinct from risks (which are potential future events) — issues are current, active problems impacting the project. Tracks issue number, date identified, issue type (design conflict, contractor dispute, permit delay, utility conflict, community complaint, regulatory requirement change), description, priority, assigned resolver, target resolution date, actual resolution date, resolution description, and impact on schedule/cost. Supports project manager decision-making and escalation workflows.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` (
    `closeout_record_id` BIGINT COMMENT 'Unique identifier for the project closeout record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent Capital Improvement Program (CIP) project being closed out.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project closeout finalizes cost center charges and closes cost center budget lines. Required for departmental budget reconciliation and performance reporting.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Project closeout finalizes fund expenditures and releases remaining fund commitments. Essential for fund balance reconciliation and appropriation closeout.',
    `approval_date` DATE COMMENT 'Date when the closeout record received final approval from the designated authority, authorizing administrative and financial closure.',
    `approved_by_name` STRING COMMENT 'Name of the authority who provided final approval for the closeout record, authorizing project closure and financial settlement.',
    `as_built_drawings_acceptance_date` DATE COMMENT 'Date when as-built drawings were formally accepted and integrated into the Geographic Information System (GIS) and asset records.',
    `as_built_drawings_received_flag` BOOLEAN COMMENT 'Indicates whether as-built drawings reflecting actual constructed conditions have been received, reviewed, and accepted by the engineering team.',
    `asset_handover_complete_flag` BOOLEAN COMMENT 'Indicates whether all constructed assets have been formally handed over to operations and created in IBM Maximo Asset Management (CMMS) for ongoing maintenance.',
    `asset_handover_date` DATE COMMENT 'Date when assets were formally transferred from the project team to the operations and maintenance team with full documentation.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The difference between final approved budget and total actual cost, indicating over or under budget performance (positive = under budget, negative = over budget).',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the final approved budget, used for performance analysis and lessons learned.',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalization entries were posted in SAP FI, triggering depreciation calculations.',
    `closeout_coordinator_name` STRING COMMENT 'Name of the individual responsible for coordinating all closeout activities, documentation collection, and stakeholder communications.',
    `closeout_notes` STRING COMMENT 'Free-text field for capturing additional closeout information, special circumstances, outstanding issues, or recommendations for future projects.',
    `closeout_number` STRING COMMENT 'Business identifier for the closeout record, typically following organizational numbering conventions for project administrative closure documentation.',
    `closeout_status` STRING COMMENT 'Current lifecycle status of the closeout record indicating progression through the administrative closure workflow. [ENUM-REF-CANDIDATE: draft|in_review|pending_approval|approved|rejected|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `closeout_type` STRING COMMENT 'Classification of the closeout indicating whether it is a standard completion, early termination, partial closeout, or administrative-only closure.. Valid values are `normal|early_termination|partial|administrative|financial_only`',
    `completion_date` DATE COMMENT 'Date when all closeout activities were completed and the project was formally closed in all systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closeout record was first created in the system, marking the beginning of the administrative closure documentation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this closeout record.. Valid values are `^[A-Z]{3}$`',
    `final_acceptance_date` DATE COMMENT 'Date when the owner formally accepted the completed project deliverables and granted final acceptance for operational turnover.',
    `final_approved_budget_amount` DECIMAL(18,2) COMMENT 'The final approved budget amount including all approved change orders, amendments, and contingency allocations.',
    `final_capitalization_amount` DECIMAL(18,2) COMMENT 'Total amount capitalized to fixed assets in SAP FI, representing the final asset value for depreciation and financial reporting purposes.',
    `initiation_date` DATE COMMENT 'Date when the project closeout process was formally initiated, marking the beginning of administrative closure activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this closeout record, tracking the progression of closeout activities and documentation.',
    `lessons_learned_documented_flag` BOOLEAN COMMENT 'Indicates whether lessons learned documentation has been completed, capturing successes, challenges, and recommendations for future Capital Improvement Program (CIP) projects.',
    `lessons_learned_session_date` DATE COMMENT 'Date when the formal lessons learned session was conducted with project team members and stakeholders.',
    `maximo_asset_creation_complete_flag` BOOLEAN COMMENT 'Indicates whether all new assets have been created in IBM Maximo Asset Management (CMMS) with complete attributes, locations, and preventive maintenance (PM) schedules.',
    `om_manuals_delivery_date` DATE COMMENT 'Date when complete Operations and Maintenance (O&M) manuals were delivered to the operations team for ongoing asset management.',
    `om_manuals_received_flag` BOOLEAN COMMENT 'Indicates whether Operations and Maintenance (O&M) manuals for all installed equipment and systems have been delivered and accepted.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The initial approved budget amount for the Capital Improvement Program (CIP) project at the time of authorization.',
    `permit_closeout_complete_flag` BOOLEAN COMMENT 'Indicates whether all construction permits, National Pollutant Discharge Elimination System (NPDES) permits, and regulatory authorizations have been formally closed out with issuing agencies.',
    `project_manager_name` STRING COMMENT 'Name of the project manager responsible for overseeing the closeout process and ensuring all administrative requirements are met.',
    `punch_list_completion_date` DATE COMMENT 'Date when all punch list items were completed and verified, clearing the way for final acceptance and closeout.',
    `punch_list_item_count` STRING COMMENT 'Total number of punch list items identified during final inspection that required correction before final acceptance.',
    `regulatory_inspection_approval_date` DATE COMMENT 'Date when final regulatory inspection sign-offs were received from all governing agencies, clearing the project for operational use.',
    `regulatory_inspection_complete_flag` BOOLEAN COMMENT 'Indicates whether all required regulatory inspections by Environmental Protection Agency (EPA), state agencies, and local authorities have been completed and approved.',
    `retainage_release_date` DATE COMMENT 'Date when final retainage was authorized for release to contractors following completion of all punch list items and acceptance.',
    `retainage_released_amount` DECIMAL(18,2) COMMENT 'Total amount of contractor retainage released upon project completion and acceptance, typically 5-10% of contract value held during construction.',
    `sap_ps_settlement_complete_flag` BOOLEAN COMMENT 'Indicates whether the SAP PS project has been settled to fixed assets in SAP Financial Accounting (FI), completing the capitalization process.',
    `sap_ps_settlement_date` DATE COMMENT 'Date when the SAP PS project was settled and costs were transferred to fixed asset accounts in SAP FI for depreciation tracking.',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'The total actual cost incurred for the project across all cost elements including labor, materials, equipment, and contractor payments.',
    `warranty_registration_complete_flag` BOOLEAN COMMENT 'Indicates whether all equipment and material warranties have been registered with manufacturers and documented in the Computerized Maintenance Management System (CMMS).',
    `warranty_registration_date` DATE COMMENT 'Date when warranty registration was completed and warranty records were entered into IBM Maximo Asset Management (CMMS).',
    CONSTRAINT pk_closeout_record PRIMARY KEY(`closeout_record_id`)
) COMMENT 'Project closeout record documenting the formal completion and administrative closure of a CIP project including final cost reconciliation, retainage release authorization, punch list completion certification, as-built drawing acceptance, O&M manual delivery confirmation, warranty registration, final regulatory inspection sign-offs, lessons learned documentation, and SAP PS project settlement to fixed assets. Triggers final capitalization entries in SAP FI and asset record creation in IBM Maximo. Represents the definitive end-of-project administrative record.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`punch_list` (
    `punch_list_id` BIGINT COMMENT 'Unique identifier for the punch_list data product (auto-inserted pre-linking).',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Punch lists are created at substantial completion to track incomplete or deficient work items for a CIP project. Standard parent-child relationship. FK will be created automatically.',
    `closeout_record_id` BIGINT COMMENT 'Foreign key linking to project.closeout_record. Business justification: Punch list items are tracked through project closeout. Links individual punch items to the formal closeout process, enabling status tracking through final acceptance.',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Punch list items are typically tied to a specific construction contract and contractor responsible for completion. Links punch list work to the contract scope.',
    `hydrant_id` BIGINT COMMENT 'Foreign key linking to distribution.hydrant. Business justification: Hydrant installation punch list items (painting, flow testing, valve operation verification, reflector installation) must link to the specific hydrant asset for closeout tracking and operational accep',
    `inspection_report_id` BIGINT COMMENT 'Foreign key linking to project.inspection_report. Business justification: Punch list items are often identified during construction inspections. Links the deficiency to the inspection event where it was discovered for traceability.',
    `parent_punch_list_id` BIGINT COMMENT 'Self-referencing FK on punch_list (parent_punch_list_id)',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Punch list items for pipeline work (valve box adjustments, pavement restoration, marker post installation) must be linked to the specific main for closeout tracking and substantial completion verifica',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Punch list items can be organized and tracked by WBS element for detailed project cost and schedule control. Allows aggregation of punch items by work package.',
    CONSTRAINT pk_punch_list PRIMARY KEY(`punch_list_id`)
) COMMENT 'Punch list record tracking incomplete or deficient work items identified during substantial completion inspection that must be corrected before final completion and retainage release. Each item tracks location, description of deficiency, specification reference, responsible contractor, date identified, required completion date, actual completion date, verification inspector, and status (open, corrected, verified, accepted). The punch list drives the critical path between substantial completion and final completion/closeout. Aggregated punch list completion percentage gates retainage release authorization.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` (
    `project_schedule_id` BIGINT COMMENT 'Unique identifier for the project_schedule data product (auto-inserted pre-linking).',
    `baseline_project_schedule_id` BIGINT COMMENT 'Self-referencing FK on project_schedule (baseline_project_schedule_id)',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Project schedules (CPM construction schedules) belong to a CIP project. Standard parent-child relationship for schedule management.',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Construction schedules are typically submitted by contractors per contract requirements. Links the schedule to the contract it supports for compliance tracking.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Project schedules can be structured and organized by WBS elements, allowing schedule activities to map to work packages for integrated cost and schedule control.',
    CONSTRAINT pk_project_schedule PRIMARY KEY(`project_schedule_id`)
) COMMENT 'Project schedule record representing the contractors CPM (Critical Path Method) construction schedule or the owners master project schedule. Tracks schedule version/revision, submission date, approval status, data date, project completion date, total float on critical path, number of activities, schedule basis (baseline, update, recovery), and schedule health metrics. Supports schedule analysis including critical path identification, float consumption tracking, and delay claim evaluation. Each approved schedule revision becomes a baseline for schedule performance measurement.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_primary_predecessor_milestone_id` FOREIGN KEY (`primary_predecessor_milestone_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_original_cost_transaction_id` FOREIGN KEY (`original_cost_transaction_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cost_transaction`(`cost_transaction_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`design_contract`(`design_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_previous_submittal_design_submittal_id` FOREIGN KEY (`previous_submittal_design_submittal_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`design_submittal`(`design_submittal_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ADD CONSTRAINT `fk_project_request_for_information_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ADD CONSTRAINT `fk_project_risk_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_request_for_information_id` FOREIGN KEY (`request_for_information_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`request_for_information`(`request_for_information_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_issue_rfi_request_for_information_id` FOREIGN KEY (`issue_rfi_request_for_information_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`request_for_information`(`request_for_information_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_closeout_record_id` FOREIGN KEY (`closeout_record_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`closeout_record`(`closeout_record_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_inspection_report_id` FOREIGN KEY (`inspection_report_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`inspection_report`(`inspection_report_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_parent_punch_list_id` FOREIGN KEY (`parent_punch_list_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`punch_list`(`punch_list_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_baseline_project_schedule_id` FOREIGN KEY (`baseline_project_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`project_schedule`(`project_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ADD CONSTRAINT `fk_project_project_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_water_utilities_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cip_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cip_project_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cip_program_year` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Program Year');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `estimated_customers_impacted` SET TAGS ('dbx_business_glossary_term' = 'Estimated Customers Impacted');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `infrastructure_category` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `infrastructure_category` SET TAGS ('dbx_value_regex' = 'water|wastewater|shared|stormwater|other');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `operational_turnover_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Turnover Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|delayed|cancelled|completed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `sponsoring_department` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Department');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cip_project` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'capital|operating|mixed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `baseline_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `baseline_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `billing_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `commissioning_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV) for Earned Value Management (EVM)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV) for Earned Value Management (EVM)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `regulatory_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `responsible_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `responsible_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_value_regex' = 'phase|deliverable|work_package|milestone|planning_element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `primary_predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Milestone Acceptance Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Deliverable Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `is_regulatory_milestone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Milestone Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|delayed|cancelled|on_hold');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'design|permitting|procurement|construction|commissioning|closeout');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'internal|contractor|consultant|vendor|regulatory_agency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `variance_commentary` SET TAGS ('dbx_business_glossary_term' = 'Variance Commentary');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance in Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_ssot_owner' = 'finance.finance_budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `appropriation_ordinance_number` SET TAGS ('dbx_business_glossary_term' = 'Appropriation Ordinance Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `approved_amendments_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amendments Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `current_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Approved Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `encumbered_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `funding_source_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `funding_source_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `is_multi_year_budget` SET TAGS ('dbx_business_glossary_term' = 'Is Multi-Year Budget');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `opex_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Budget Phase');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'planning|design|construction|contingency|inspection|closeout');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `rate_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Revenue Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|amended|current|forecast');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_budget` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `budget_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_amount` SET TAGS ('dbx_business_glossary_term' = 'Amendment Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|contingency_draw|emergency_authorization|cost_overrun|schedule_adjustment|funding_reallocation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'board|commission|executive_director|finance_director|project_manager|delegated_authority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `board_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `board_resolution_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `contingency_amount_used` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount Used');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `contingency_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `remaining_contingency` SET TAGS ('dbx_business_glossary_term' = 'Remaining Contingency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`budget_amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` SET TAGS ('dbx_subdomain' = 'contract_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `primary_design_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `primary_design_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `primary_design_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `primary_design_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `amendment_value` SET TAGS ('dbx_business_glossary_term' = 'Amendment Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `construction_administration_included` SET TAGS ('dbx_business_glossary_term' = 'Construction Administration Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_title` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|time_and_materials|cost_plus_fixed_fee|cost_plus_percentage|unit_price|indefinite_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `current_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `deliverable_schedule` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `design_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Standard Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `disadvantaged_business_enterprise_participation` SET TAGS ('dbx_business_glossary_term' = 'Disadvantaged Business Enterprise (DBE) Participation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `engineering_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `engineering_firm_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `insurance_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Received Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `invoiced_to_date` SET TAGS ('dbx_business_glossary_term' = 'Invoiced to Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Paid to Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `permit_support_included` SET TAGS ('dbx_business_glossary_term' = 'Permit Support Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'qualifications_based_selection|competitive_sealed_proposals|sole_source|emergency_procurement|cooperative_purchasing');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `quality_assurance_review_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_contract` ALTER COLUMN `subconsultant_list` SET TAGS ('dbx_business_glossary_term' = 'Subconsultant List');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` SET TAGS ('dbx_subdomain' = 'contract_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `construction_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `bid_advertisement_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Advertisement Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `bid_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Opening Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_price|cost_plus_fixed_fee|cost_plus_percentage|gmp|time_and_materials');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `current_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Current Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `current_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `final_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Final Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `insurance_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Received');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `liquidated_damages_assessed` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Assessed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `payment_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `payment_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Payment Bond Required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `time_extensions_days` SET TAGS ('dbx_business_glossary_term' = 'Time Extensions Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `total_change_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Change Order Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `total_paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Paid to Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` SET TAGS ('dbx_subdomain' = 'contract_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `cumulative_change_order_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Change Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `change_order_description` SET TAGS ('dbx_business_glossary_term' = 'Change Order Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Change Order Initiated By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Initiated Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Change Order Justification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Change Order Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Order Priority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `scope_addition_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Addition Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `scope_deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Deletion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Order Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` SET TAGS ('dbx_subdomain' = 'contract_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_application_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Application ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_engineer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_engineer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_engineer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `pay_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `approved_change_orders_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Change Orders Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `balance_to_finish_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance to Finish Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `current_contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `current_payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Payment Due Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `engineer_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer Certification Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `engineer_certified_amount` SET TAGS ('dbx_business_glossary_term' = 'Engineer Certified Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `materials_stored_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Stored Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `original_contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `owner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Owner Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `owner_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Owner Approved Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `previous_payments_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Payments Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `total_earned_less_retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Earned Less Retainage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `total_earned_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Earned to Date Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`pay_application` ALTER COLUMN `work_completed_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Work Completed to Date Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'contract_delivery');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `original_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `primary_cost_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `commitment_item` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type Classification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontract|overhead|other');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Transaction Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`cost_transaction` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `secondary_ssot_permit_id` SET TAGS ('dbx_ssot_owner' = 'compliance.compliance_permit');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Amendment Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Permit Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|withdrawn|settled');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `application_submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bond Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `coverage_area_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Coverage Area Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issued Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|county|municipal|regional');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Permit Site Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Permit Site Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Environmental Mitigation Measures');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `monitoring_requirements` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'environmental|construction|utility_coordination|right_of_way|encroachment|other');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `public_comment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Permit Subtype');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `total_fees_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Permit Fees Paid');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Design Submittal Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `previous_submittal_design_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Submittal Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `comment_count` SET TAGS ('dbx_business_glossary_term' = 'Review Comment Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `comment_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Comment Resolution Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `comment_resolution_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|resolved|verified|closed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Gallons per Day (MGD)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_discipline` SET TAGS ('dbx_business_glossary_term' = 'Design Discipline');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_life_years` SET TAGS ('dbx_business_glossary_term' = 'Design Life Years');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `design_phase` SET TAGS ('dbx_value_regex' = 'conceptual|preliminary|intermediate|final|construction_documents');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Review Disposition');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'approved|approved_as_noted|revise_and_resubmit|rejected|under_review');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `document_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `drawing_count` SET TAGS ('dbx_business_glossary_term' = 'Drawing Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `environmental_review_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `estimated_construction_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Construction Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `estimated_construction_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submittal Priority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `regulatory_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `resubmission_required` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `reviewer_role` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Role');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `specification_section` SET TAGS ('dbx_business_glossary_term' = 'Specification Section');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Document Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submitter_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submitter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`design_submittal` ALTER COLUMN `submitter_organization` SET TAGS ('dbx_business_glossary_term' = 'Submitter Organization');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `construction_submittal_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Submittal Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Engineer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `construction_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Organization Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Engineer Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `asset_handover_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Submittal Disposition Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'approved|approved_as_noted|revise_resubmit|rejected|for_information_only|withdrawn');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Path');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `required_before_installation_flag` SET TAGS ('dbx_business_glossary_term' = 'Required Before Installation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `resubmittal_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmittal Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Engineer Review Comments');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `specification_section` SET TAGS ('dbx_business_glossary_term' = 'Specification Section Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `specification_section` SET TAGS ('dbx_value_regex' = '^[0-9]{2}s?[0-9]{2}s?[0-9]{2}(.[0-9]{2})?$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_description` SET TAGS ('dbx_business_glossary_term' = 'Submittal Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_business_glossary_term' = 'Submittal Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{3,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_priority` SET TAGS ('dbx_business_glossary_term' = 'Submittal Priority');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_status` SET TAGS ('dbx_business_glossary_term' = 'Submittal Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_title` SET TAGS ('dbx_business_glossary_term' = 'Submittal Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_business_glossary_term' = 'Submittal Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `submittal_type` SET TAGS ('dbx_value_regex' = 'shop_drawing|product_data|material_sample|mix_design|equipment_submittal|operation_maintenance_manual');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`construction_submittal` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `request_for_information_id` SET TAGS ('dbx_business_glossary_term' = 'Request For Information Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`request_for_information` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_report_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `change_order_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Recommended Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `contractor_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Contractor Crew Size');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `daily_progress_narrative` SET TAGS ('dbx_business_glossary_term' = 'Daily Progress Narrative');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `drawings_referenced` SET TAGS ('dbx_business_glossary_term' = 'Drawings Referenced');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `equipment_on_site` SET TAGS ('dbx_business_glossary_term' = 'Equipment On-Site');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `materials_delivered` SET TAGS ('dbx_business_glossary_term' = 'Materials Delivered');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `materials_tested` SET TAGS ('dbx_business_glossary_term' = 'Materials Tested');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `non_conformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `non_conformance_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `pay_application_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Pay Application Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `pay_application_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|partial|pending_review');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `photos_attached_count` SET TAGS ('dbx_business_glossary_term' = 'Photos Attached Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|archived');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `rfi_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Generated Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `safety_observations` SET TAGS ('dbx_business_glossary_term' = 'Safety Observations');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `subcontractor_name` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `subcontractor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `visitors_on_site` SET TAGS ('dbx_business_glossary_term' = 'Visitors On-Site');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `work_activities_observed` SET TAGS ('dbx_business_glossary_term' = 'Work Activities Observed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `work_stoppage_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`inspection_report` ALTER COLUMN `work_stoppage_reason` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Reason');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closeout Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Closeout Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `closeout_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending_verification|pending_documentation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `contractor_response` SET TAGS ('dbx_business_glossary_term' = 'Contractor Response');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `contractor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Response Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Disposition');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'repair|replace|rework|accept_as_is|reject|use_as_is_with_concession');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `disposition_justification` SET TAGS ('dbx_business_glossary_term' = 'Disposition Justification');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `engineer_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `engineer_approval_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer Approval Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `engineer_approval_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `ncr_number` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `ncr_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_category` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `nonconformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Severity Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`nonconformance_report` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` SET TAGS ('dbx_subdomain' = 'asset_closeout');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `commissioning_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `lab_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_category` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|on_hold|completed|cancelled|failed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `contractor_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Sign-Off Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `disinfection_contact_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Contact Time (CT) in Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Method');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_value_regex' = 'chlorine|chloramine|chlorine_dioxide|uv|ozone|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `engineer_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer Sign-Off Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `flow_test_result_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Test Result in Gallons per Minute (GPM)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `operations_sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Operations Sign-Off Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `pressure_test_result_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure Test Result in Pounds per Square Inch (PSI)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'contractor|engineer|operations_staff|vendor|consultant|regulatory_agency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `scada_integration_status` SET TAGS ('dbx_value_regex' = 'not_applicable|not_started|in_progress|testing|operational|failed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `sign_off_status` SET TAGS ('dbx_value_regex' = 'pending|contractor_signed|engineer_signed|operations_signed|fully_approved|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `test_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Procedure Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_tested|in_progress');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`commissioning_activity` ALTER COLUMN `water_quality_sample_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Sample Collected Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` SET TAGS ('dbx_subdomain' = 'asset_closeout');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `primary_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `quality_sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `as_built_drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawing Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `commissioning_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Report Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `depreciation_class` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Class');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `final_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Final Acceptance Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Handover Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_status` SET TAGS ('dbx_business_glossary_term' = 'Handover Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `handover_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|completed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `installed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Installed Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `om_manual_reference` SET TAGS ('dbx_business_glossary_term' = 'Operations and Maintenance (O&M) Manual Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `operations_acceptance_signature` SET TAGS ('dbx_business_glossary_term' = 'Operations Acceptance Signature');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `operations_acceptance_signature` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `operations_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Operations Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `operations_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `regulatory_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `responsible_operations_group` SET TAGS ('dbx_business_glossary_term' = 'Responsible Operations Group');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `safety_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `sap_asset_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `spare_parts_stocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Stocked Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `warranty_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration Months');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`asset_handover` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `administering_agency` SET TAGS ('dbx_business_glossary_term' = 'Administering Agency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `arra_flag` SET TAGS ('dbx_business_glossary_term' = 'American Recovery and Reinvestment Act (ARRA) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `bond_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Bond Insurance Provider');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `bond_rating` SET TAGS ('dbx_business_glossary_term' = 'Bond Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `buy_american_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy American Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `davis_bacon_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Davis-Bacon Act Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `disadvantaged_community_flag` SET TAGS ('dbx_business_glossary_term' = 'Disadvantaged Community Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `drawdown_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Restrictions');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `eligible_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `eligible_project_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Project Types');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `final_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Final Maturity Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `first_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_status` SET TAGS ('dbx_value_regex' = 'available|committed|fully_allocated|closed|suspended|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `green_project_reserve_flag` SET TAGS ('dbx_business_glossary_term' = 'Green Project Reserve (GPR) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|zero|subsidized');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `match_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Requirement Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `prepayment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Allowed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `prepayment_penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `principal_forgiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Principal Forgiveness Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Program Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed|none');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Term in Months');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `total_authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Authorized Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_source` ALTER COLUMN `trustee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Funding Allocation Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `american_iron_steel_required_flag` SET TAGS ('dbx_business_glossary_term' = 'American Iron and Steel Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `amount_drawn_to_date` SET TAGS ('dbx_business_glossary_term' = 'Amount Drawn to Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `conditions_precedent` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `conditions_precedent_met_date` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Met Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `conditions_precedent_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditions Precedent Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `davis_bacon_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Davis-Bacon Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `drawdown_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Drawdown Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `drawdown_schedule_type` SET TAGS ('dbx_value_regex' = 'milestone|monthly|quarterly|reimbursement|lump_sum|as_needed');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `eligible_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Eligible Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `first_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `forgiveness_amount` SET TAGS ('dbx_business_glossary_term' = 'Forgiveness Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `forgiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forgiveness Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `funding_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Funding Priority Rank');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `grant_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `ineligible_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Ineligible Cost Categories');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `loan_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `matching_amount` SET TAGS ('dbx_business_glossary_term' = 'Matching Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `matching_percentage` SET TAGS ('dbx_business_glossary_term' = 'Matching Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `matching_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Requirement Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `reimbursement_basis` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Basis');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `reimbursement_basis` SET TAGS ('dbx_value_regex' = 'actual_cost|percentage_complete|milestone|advance|hybrid');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `repayment_term_months` SET TAGS ('dbx_business_glossary_term' = 'Repayment Term Months');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`funding_allocation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|milestone|as_required');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` SET TAGS ('dbx_subdomain' = 'funding_allocation');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `land_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Land Acquisition Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Agent Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Process Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_priority` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_purpose` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Purpose Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Lifecycle Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Property Acquisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'fee_simple|permanent_easement|temporary_construction_easement|right_of_way|license|lease');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Property Appraisal Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraised_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Appraised Fair Market Value Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraised_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraiser_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Appraiser Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `appraiser_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `condemnation_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Condemnation Petition Filing Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Condemnation Court Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `deed_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Deed Book and Page Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `deed_recording_date` SET TAGS ('dbx_business_glossary_term' = 'Deed Recording Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `eminent_domain_flag` SET TAGS ('dbx_business_glossary_term' = 'Eminent Domain Condemnation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Site Assessment Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_value_regex' = 'not_required|required|in_progress|complete|remediation_needed|cleared');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `environmental_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Findings Summary');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `infrastructure_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Asset Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `just_compensation_award` SET TAGS ('dbx_business_glossary_term' = 'Court-Ordered Just Compensation Award Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `just_compensation_award` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Attorney Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `negotiated_acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Acquisition Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `negotiated_acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Acquisition Offer Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `parcel_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Parcel Area in Acres');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `parcel_area_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Parcel Area in Square Feet');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `parcel_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Parcel Identifier Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_contact_address` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Mailing Address');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_contact_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_contact_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Legal Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `property_use_type` SET TAGS ('dbx_business_glossary_term' = 'Property Current Use Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Assistance Obligation Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `survey_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Property Survey Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `title_issues_description` SET TAGS ('dbx_business_glossary_term' = 'Title Issues and Encumbrances Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `title_search_status` SET TAGS ('dbx_business_glossary_term' = 'Title Search and Examination Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `title_search_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|issues_identified|cleared');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`land_acquisition` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_id` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `actual_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `actual_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closure Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `contingency_reserve_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Allocated Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `cost_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `cost_impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|severe');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `cost_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `estimated_cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `estimated_schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `identified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Identified By Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `identified_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Role');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Probability Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `probability_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `probability_score` SET TAGS ('dbx_business_glossary_term' = 'Probability Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `quality_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `quality_impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|severe');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `realization_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Realization Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_cost_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Cost Impact Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_cost_impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|severe');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Probability Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_probability_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|medium|high|very_high');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_schedule_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Schedule Impact Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `residual_schedule_impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|severe');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `response_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Response Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `response_strategy` SET TAGS ('dbx_value_regex' = 'avoid|mitigate|transfer|accept|escalate');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|active|mitigated|closed|realized|monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `schedule_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Rating');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `schedule_impact_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|severe');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `schedule_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`risk` ALTER COLUMN `trigger_event_description` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Project Issue Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `request_for_information_id` SET TAGS ('dbx_business_glossary_term' = 'Related Request for Information (RFI) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_rfi_request_for_information_id` SET TAGS ('dbx_business_glossary_term' = 'Related Request for Information (RFI) Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `asset_class_affected` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Affected');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `assigned_resolver` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `date_identified` SET TAGS ('dbx_business_glossary_term' = 'Date Identified');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive|board');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_approval|resolved|closed|escalated');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'design_conflict|contractor_dispute|permit_delay|utility_conflict|community_complaint|regulatory_requirement_change');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design_error|construction_defect|material_failure|coordination_failure|scope_ambiguity|external_factor');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `scope_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Impact Description');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `scope_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Impact Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Issue Title');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`issue` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` SET TAGS ('dbx_subdomain' = 'asset_closeout');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closeout Record Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `as_built_drawings_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawings Acceptance Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `as_built_drawings_received_flag` SET TAGS ('dbx_business_glossary_term' = 'As-Built Drawings Received Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `asset_handover_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `asset_handover_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Handover Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Closeout Coordinator Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_coordinator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_notes` SET TAGS ('dbx_business_glossary_term' = 'Closeout Notes');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_number` SET TAGS ('dbx_business_glossary_term' = 'Closeout Record Number');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_status` SET TAGS ('dbx_business_glossary_term' = 'Closeout Status');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_type` SET TAGS ('dbx_business_glossary_term' = 'Closeout Type');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `closeout_type` SET TAGS ('dbx_value_regex' = 'normal|early_termination|partial|administrative|financial_only');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Final Acceptance Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `final_capitalization_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Capitalization Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Initiation Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `lessons_learned_documented_flag` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Documented Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `lessons_learned_session_date` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Session Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `maximo_asset_creation_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Creation Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `om_manuals_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Operations and Maintenance (O&M) Manuals Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `om_manuals_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Operations and Maintenance (O&M) Manuals Received Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `permit_closeout_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Closeout Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `punch_list_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Punch List Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `punch_list_item_count` SET TAGS ('dbx_business_glossary_term' = 'Punch List Item Count');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `regulatory_inspection_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `regulatory_inspection_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `retainage_release_date` SET TAGS ('dbx_business_glossary_term' = 'Retainage Release Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `retainage_released_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Released Amount');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `sap_ps_settlement_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'SAP Project System (PS) Settlement Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `sap_ps_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Project System (PS) Settlement Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `warranty_registration_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Complete Flag');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`closeout_record` ALTER COLUMN `warranty_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Date');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` SET TAGS ('dbx_subdomain' = 'construction_quality');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for punch_list');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `closeout_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closeout Record Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `hydrant_id` SET TAGS ('dbx_business_glossary_term' = 'Hydrant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `inspection_report_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `parent_punch_list_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Punch List Id');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `parent_punch_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`punch_list` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `project_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for project_schedule');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `baseline_project_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Project Schedule Id');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `baseline_project_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`project`.`project_schedule` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
