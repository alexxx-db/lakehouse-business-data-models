-- Schema for Domain: equipment | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`equipment` COMMENT 'Construction equipment and fleet management domain tracking heavy machinery (cranes, excavators, concrete pumps), tools, generators, and fleet vehicles. Owns asset master data, utilization tracking, maintenance schedules, equipment hours, mobilization/demobilization records, rental vs. owned classification, and asset lifecycle management via SAP PM and HCSS HeavyJob.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the construction equipment or fleet asset. Primary key for the asset master record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Procurement contracts assign each purchased or leased asset to an agreement; required for contract cost reporting and asset ownership tracking.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Asset belongs to an asset category; replace free‑text category with FK to asset_category for proper hierarchy and eliminate redundancy.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the asset is currently assigned. Null when asset is idle or in yard storage.',
    `asset_current_location_site_construction_project_id` BIGINT COMMENT 'Identifier of the construction site or yard where the asset is currently located. Updated during mobilization and demobilization events.',
    `obligation_calendar_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_calendar. Business justification: Compliance calendars schedule inspections/maintenance for each asset; linking asset to calendar entry provides traceability.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Equipment Ownership Tracking for Subcontractor‑Provided assets, required for billing, insurance, and compliance reporting on project equipment usage.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Associates each asset with its primary fuel material, enabling accurate fuel consumption tracking and environmental compliance.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Required for Daily Equipment Operator Assignment report, linking each asset to the assigned craft worker for safety compliance and productivity tracking.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Specific permit conditions (e.g., emissions limits) apply to individual equipment; linking enables condition monitoring per asset.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Asset accountability report requires a designated responsible employee for safety and compliance; construction managers assign responsibility per asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost to acquire the asset including purchase price, delivery, installation, and initial setup. Basis for depreciation calculations and capital asset reporting.',
    `acquisition_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost (e.g., USD, EUR, GBP). Required for multi-currency fleet management.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired by the company through purchase, lease commencement, or rental agreement start. Used for depreciation start date and asset age calculations.',
    `asset_status` STRING COMMENT 'Current operational status of the asset. Determines availability for project assignment and utilization reporting. [ENUM-REF-CANDIDATE: active|idle|under_maintenance|in_transit|disposed|retired|reserved — 7 candidates stripped; promote to reference product]',
    `capacity_rating` DECIMAL(18,2) COMMENT 'Maximum rated capacity of the equipment in appropriate units (tons for cranes, cubic yards for excavators, kilowatts for generators). Critical for safe operation and project planning.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the capacity rating. Varies by equipment type and regional standards.. Valid values are `tons|cubic_yards|cubic_meters|kilowatts|gallons_per_minute|pounds`',
    `classification` STRING COMMENT 'Primary equipment type classification. Determines maintenance requirements, operator certification needs, and utilization tracking methods. [ENUM-REF-CANDIDATE: crane|excavator|concrete_pump|generator|fleet_vehicle|small_tool|bulldozer|loader|grader|compactor|paver|drill_rig — 12 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset master record was first created in the system. Used for data lineage and audit trail.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset after accumulated depreciation. Updated periodically based on depreciation schedule and impairment assessments.',
    `disposal_approver_name` STRING COMMENT 'Name of the manager or executive who authorized the asset disposal. Required for governance and audit compliance.',
    `disposal_buyer_name` STRING COMMENT 'Name of the party who purchased or received the disposed asset. Required for audit trail and warranty transfer documentation.',
    `disposal_date` DATE COMMENT 'Date the asset was disposed of or removed from active fleet. Triggers final depreciation calculation and asset retirement accounting entries.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the asset at end of life. Populated only for disposed assets. Impacts accounting treatment and tax reporting.. Valid values are `sale|auction|scrap|write_off|trade_in|donation`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from disposal of the asset through sale, auction, or trade-in. Used to calculate gain or loss on disposal for financial reporting.',
    `disposal_reason` STRING COMMENT 'Business justification for disposing of the asset (e.g., end of useful life, excessive maintenance costs, fleet optimization, project completion, regulatory non-compliance).',
    `emissions_tier` STRING COMMENT 'EPA emissions tier classification (e.g., Tier 4 Final, Tier 3). Determines regulatory compliance for site operations and environmental permitting.',
    `hcss_heavyjob_asset_code` STRING COMMENT 'Asset identifier in HCSS HeavyJob field operations system. Used for time tracking, production tracking, and equipment hour logging.',
    `home_yard_location` STRING COMMENT 'Primary equipment yard or depot where the asset is based when not deployed to a project site. Used for logistics planning and idle asset management.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of current insurance coverage. Equipment cannot operate without valid insurance.',
    `insurance_policy_number` STRING COMMENT 'Policy number for equipment insurance coverage. Required for risk management and claims processing.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection. Required for OSHA compliance and equipment certification tracking.',
    `last_meter_reading_date` DATE COMMENT 'Date of the most recent operating hours meter reading. Used to validate meter reading frequency and detect anomalies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the asset master record. Used for change tracking and data quality monitoring.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the asset lifecycle from acquisition through disposal. Used for lifecycle cost analysis and replacement planning.. Valid values are `commissioning|operational|aging|end_of_life|disposed`',
    `make` STRING COMMENT 'Manufacturer or brand name of the equipment (e.g., Caterpillar, Komatsu, Liebherr, Volvo, John Deere).',
    `model` STRING COMMENT 'Manufacturer model designation for the equipment. Used for parts compatibility, operator training, and maintenance procedure lookup.',
    `next_inspection_due_date` DATE COMMENT 'Date by which the next regulatory inspection must be completed. Equipment cannot operate on site after this date without recertification.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance service. Calculated based on operating hours, calendar time, or manufacturer recommendations.',
    `operating_weight_kg` DECIMAL(18,2) COMMENT 'Total operating weight of the equipment in kilograms. Used for transportation planning, site access evaluation, and ground bearing pressure calculations.',
    `ownership_type` STRING COMMENT 'Classification of how the company controls the asset. Owned assets are capitalized, rented assets are expensed, leased assets follow lease accounting standards.. Valid values are `owned|rented|leased|operator_owned`',
    `regulatory_compliance_class` STRING COMMENT 'Regulatory classification determining inspection frequency, operator certification requirements, and safety standards (e.g., OSHA crane certification class, EPA emissions tier).',
    `sap_pm_equipment_number` STRING COMMENT 'Equipment master record number in SAP S/4HANA Plant Maintenance module. System of record identifier for maintenance planning and execution.. Valid values are `^[0-9]{10}$`',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the equipment unit. Critical for warranty claims, parts ordering, and regulatory compliance.',
    `tag_number` STRING COMMENT 'Externally visible unique identifier physically affixed to the equipment. Used for field identification and tracking across sites.. Valid values are `^[A-Z0-9]{6,20}$`',
    `total_operating_hours` DECIMAL(18,2) COMMENT 'Cumulative operating hours recorded on the equipment meter. Used for maintenance scheduling, utilization analysis, and residual value estimation.',
    `year_of_manufacture` STRING COMMENT 'Calendar year the equipment was manufactured. Used for depreciation calculations, regulatory compliance age limits, and resale value estimation.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Core master record for every piece of construction equipment and fleet vehicle owned, long-term leased, or rented by the company. Captures asset identity, classification (crane, excavator, concrete pump, generator, fleet vehicle, small tool), make, model, serial number, year of manufacture, acquisition date, acquisition cost, ownership type (owned/rented/leased), current status (active, idle, under maintenance, disposed), SAP PM equipment number, HCSS HeavyJob asset ID, regulatory compliance class, and asset lifecycle stage. For disposed assets: captures disposal method (sale, auction, scrap, write-off, trade-in), disposal date, disposal proceeds, buyer details, reason for disposal, and authorizing approver. This is the SSOT for all equipment identity and lifecycle data across the enterprise, from commissioning through disposal.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset_category` (
    `asset_category_id` BIGINT COMMENT 'Unique identifier for the asset category. Primary key for the asset category reference hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset category default cost center ensures new assets inherit correct cost center for accounting.',
    `parent_category_asset_category_id` BIGINT COMMENT 'Reference to the parent category in the asset classification hierarchy. Enables multi-level taxonomy (e.g., Heavy Equipment > Earthmoving > Excavators). Null for top-level categories.',
    `asset_category_status` STRING COMMENT 'Current lifecycle status of the asset category in the master taxonomy: active (in use for classification), inactive (no longer used but retained for historical data), deprecated (being phased out), pending (awaiting approval for activation).. Valid values are `active|inactive|deprecated|pending`',
    `asset_class_sap` STRING COMMENT 'SAP S/4HANA Asset Accounting asset class code for assets in this category. Determines account determination, depreciation keys, and asset master data screen layout in SAP FI-AA module.. Valid values are `^[0-9]{4,8}$`',
    `benchmark_utilization_rate` DECIMAL(18,2) COMMENT 'Target utilization rate percentage for assets in this category, used for fleet optimization and equipment productivity benchmarking. Represents industry-standard or company target for equipment hours versus available hours.',
    `capitalization_threshold` DECIMAL(18,2) COMMENT 'Minimum acquisition cost threshold for capitalizing assets in this category as fixed assets versus expensing as consumables. Aligns with company capitalization policy and GAAP/IFRS materiality thresholds.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the asset category. Aligned with HCSS HeavyJob cost coding structure and SAP PM functional location classification. Used for cost allocation, reporting, and system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `category_description` STRING COMMENT 'Detailed description of the asset category scope, typical equipment types included, and business purpose. Provides context for classification decisions and user guidance.',
    `category_level` STRING COMMENT 'Numeric level in the asset category hierarchy. Level 1 represents top-level categories (e.g., Heavy Equipment), Level 2 represents sub-categories (e.g., Earthmoving), Level 3 represents equipment classes (e.g., Excavators).',
    `category_name` STRING COMMENT 'Full business name of the asset category (e.g., Heavy Earthmoving Equipment, Lifting and Hoisting, Concrete Placement, MEP Tools, Fleet Vehicles, Small Tools, Generators and Power).',
    `category_type` STRING COMMENT 'Classification of the category node type within the taxonomy: major (top-level grouping), sub (intermediate grouping), class (equipment class), specialty (niche/specialized equipment).. Valid values are `major|sub|class|specialty`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset category record was first created in the system. Supports audit trail and data lineage tracking.',
    `depreciation_method` STRING COMMENT 'Standard depreciation method applied to owned assets in this category for financial reporting: straight_line (equal annual depreciation), declining_balance (accelerated depreciation), units_of_production (usage-based depreciation for heavy equipment), none (non-depreciable or rental assets).. Valid values are `straight_line|declining_balance|units_of_production|none`',
    `effective_end_date` DATE COMMENT 'Date when this asset category was retired or deprecated. Null for currently active categories. Supports historical reporting and taxonomy evolution tracking.',
    `effective_start_date` DATE COMMENT 'Date when this asset category became active and available for asset classification. Supports temporal validity and historical taxonomy tracking.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether assets in this category are subject to environmental compliance tracking (emissions monitoring, fuel consumption reporting, EPA regulations). True for generators, diesel equipment, and vehicles; False for non-powered tools.',
    `gl_account_code` STRING COMMENT 'Default General Ledger account code for asset capitalization and depreciation expense posting in SAP S/4HANA Finance. Aligns with chart of accounts structure for fixed asset accounting.. Valid values are `^[0-9]{4,10}$`',
    `hcss_equipment_type` STRING COMMENT 'HCSS HeavyJob equipment type classification for field operations time tracking and production reporting. Maps asset category to HeavyJob cost coding and equipment hour tracking structure.',
    `inspection_frequency_days` STRING COMMENT 'Standard inspection interval in days for assets in this category, aligned with manufacturer recommendations and regulatory requirements. Used to generate preventive maintenance schedules in SAP PM. Null for categories not requiring periodic inspection.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether assets in this category require dedicated insurance coverage beyond general liability. True for high-value equipment (cranes, excavators, specialized machinery); False for low-value consumable tools.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset category record was last updated. Supports change tracking and audit trail for taxonomy governance.',
    `maintenance_strategy_code` STRING COMMENT 'Default maintenance strategy code assigned to assets in this category, aligned with SAP PM maintenance strategy master data. Defines preventive maintenance frequency, inspection intervals, and service requirements (e.g., HVYEQ for heavy equipment, LTTOOL for light tools).. Valid values are `^[A-Z0-9]{2,6}$`',
    `mobilization_required` BOOLEAN COMMENT 'Indicates whether assets in this category require formal mobilization and demobilization tracking when deployed to project sites. True for heavy equipment requiring transport logistics; False for small portable tools.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this asset category record. Supports accountability and audit trail for master data governance.',
    `operator_certification_required` BOOLEAN COMMENT 'Indicates whether operation of assets in this category requires certified/licensed operators per OSHA regulations and company HSE policy. True for cranes, forklifts, and heavy machinery; False for hand tools and general equipment.',
    `ownership_classification` STRING COMMENT 'Default ownership model for assets in this category: owned (company-owned assets), rented (short-term rental), leased (long-term lease), mixed (category contains both owned and rented assets). Drives depreciation and cost allocation rules.. Valid values are `owned|rented|leased|mixed`',
    `sort_order` STRING COMMENT 'Numeric sort order for displaying asset categories in user interfaces and reports. Enables custom sequencing independent of alphabetical or hierarchical order.',
    `useful_life_years` STRING COMMENT 'Standard useful life in years for assets in this category, used for depreciation calculation and lifecycle planning. Null for rental/leased assets or categories with variable lifespans.',
    `utilization_tracking_required` BOOLEAN COMMENT 'Indicates whether assets in this category require detailed utilization tracking (equipment hours, production tracking) via HCSS HeavyJob or SAP PM. True for high-value equipment requiring cost recovery and productivity analysis; False for low-value consumable tools.',
    CONSTRAINT pk_asset_category PRIMARY KEY(`asset_category_id`)
) COMMENT 'Reference classification hierarchy for construction equipment and fleet assets. Defines the taxonomy of equipment types used across the enterprise: major categories (heavy earthmoving, lifting, concrete, MEP, fleet, small tools, generators), sub-categories, and equipment class codes aligned with HCSS HeavyJob cost coding and SAP PM functional location structures. Drives cost coding, depreciation rules, maintenance strategy assignment, and utilization benchmarking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` (
    `fleet_assignment_id` BIGINT COMMENT 'Unique identifier for the fleet assignment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment lease/assignment to a project is governed by a contract; linking records the contract that authorizes each assignment.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment or fleet vehicle being assigned. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which the equipment is assigned.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the operator or driver responsible for operating the equipment during this assignment.',
    `vendor_id` BIGINT COMMENT 'Reference to the rental company or vendor supplying the equipment, if applicable. Null for owned equipment.',
    `site_id` BIGINT COMMENT 'Reference to the specific site or work location where the equipment is deployed.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element for cost allocation and project accounting. Used for internal charge-back to projects.',
    `work_front_id` BIGINT COMMENT 'Reference to the specific work front or activity area within the site where the equipment is operating.',
    `actual_utilization_hours` DECIMAL(18,2) COMMENT 'Actual cumulative equipment operating hours recorded during this assignment. Updated from daily logs and equipment hour meters.',
    `assignment_end_date` DATE COMMENT 'The date when the equipment assignment ends or is planned to end. Nullable for open-ended assignments. Marks the end of cost allocation for this assignment.',
    `assignment_notes` STRING COMMENT 'Free-text notes and comments related to this equipment assignment. Captures special instructions, constraints, or operational considerations.',
    `assignment_number` STRING COMMENT 'Business identifier for the fleet assignment. Externally visible reference number used in mobilization documents and site logistics planning.. Valid values are `^FA-[0-9]{8}$`',
    `assignment_priority` STRING COMMENT 'Business priority level of this equipment assignment. Used for resource allocation decisions and conflict resolution when equipment is in high demand.. Valid values are `critical|high|medium|low`',
    `assignment_purpose` STRING COMMENT 'Business description of the purpose or scope of work for this equipment assignment. Describes the specific activities or tasks the equipment will perform.',
    `assignment_start_date` DATE COMMENT 'The date when the equipment assignment begins. Marks the start of cost allocation and utilization tracking for this assignment.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the equipment assignment. Tracks progression from planning through mobilization, active use, and demobilization. [ENUM-REF-CANDIDATE: planned|mobilizing|active|standby|demobilizing|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Classification of the equipment ownership or procurement method for this assignment. Determines applicable cost rates and billing rules.. Valid values are `owned|rental|lease|subcontractor_supplied|client_supplied`',
    `cost_allocation_code` STRING COMMENT 'Cost center or cost allocation code for internal charge-back and financial reporting. Used to route equipment costs to the appropriate project budget line.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the source system. Audit trail for record creation.',
    `daily_rate` DECIMAL(18,2) COMMENT 'Internal daily cost rate for equipment assignment. Alternative to hourly rates for equipment charged on a daily basis.',
    `demobilization_cost` DECIMAL(18,2) COMMENT 'Actual or estimated cost of demobilizing the equipment from the site, including transportation, cleaning, and inspection. One-time cost allocated to the project.',
    `demobilization_date` DATE COMMENT 'The date when the equipment was demobilized from the site. Actual date of equipment removal and return to fleet pool or rental company.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Cumulative hours the equipment was on site but not actively operating during this assignment. Used for standby cost allocation and utilization analysis.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the equipment during this assignment. Required for high-value equipment and rental assets.',
    `mobilization_cost` DECIMAL(18,2) COMMENT 'Actual or estimated cost of mobilizing the equipment to the site, including transportation, permits, and setup. One-time cost allocated to the project.',
    `mobilization_date` DATE COMMENT 'The date when the equipment was physically mobilized to the site. Actual date of equipment arrival and readiness for work.',
    `mobilization_status` STRING COMMENT 'Current physical mobilization status of the equipment. Tracks whether equipment is in transit, on site, or has been demobilized.. Valid values are `not_started|in_transit|on_site|demobilized`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this assignment record in the source system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last modified in the source system. Audit trail for record updates.',
    `operating_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly operating cost rate including fuel, maintenance, and operator costs. Used for project cost allocation when equipment is actively operating.',
    `ownership_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly ownership cost rate for owned equipment. Used for project cost allocation and internal charge-back calculations.',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number required for operating this equipment on the site. Applicable for cranes, heavy lifts, and specialized machinery.',
    `planned_utilization_hours` DECIMAL(18,2) COMMENT 'Planned or estimated total equipment operating hours for this assignment. Used for capacity planning and utilization forecasting.',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all rate amounts in this assignment record.. Valid values are `^[A-Z]{3}$`',
    `rental_contract_number` STRING COMMENT 'External rental contract or purchase order number for rented equipment. Used for vendor billing reconciliation.',
    `source_system_code` STRING COMMENT 'Unique identifier of this assignment record in the source system. Used for data lineage, reconciliation, and incremental updates.',
    `standby_rate_per_hour` DECIMAL(18,2) COMMENT 'Internal hourly standby cost rate when equipment is on site but not actively operating. Lower rate than operating rate, used for idle time cost allocation.',
    `weekly_rate` DECIMAL(18,2) COMMENT 'Internal weekly cost rate for equipment assignment. Alternative to hourly or daily rates for equipment charged on a weekly basis.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this assignment record in the source system.',
    CONSTRAINT pk_fleet_assignment PRIMARY KEY(`fleet_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific piece of equipment or fleet vehicle to a project, site, or work front for a defined period. Tracks assignment start and end dates, assigned project, site location, responsible operator or driver, mobilization status, cost allocation code (WBS element), and applicable internal hire rate (ownership rate, operating rate, standby rate per hour/day/week). Supports equipment utilization tracking, inter-project cost allocation, internal charge-back to projects, and site logistics planning. Sourced from HCSS HeavyJob and SAP PS project systems.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`hours` (
    `hours_id` BIGINT COMMENT 'Unique identifier for the equipment hours transaction record. Primary key for daily or shift-level equipment operating time entries.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment usage hours are charged to the project contract; linking supports progress billing and utilization reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit (crane, excavator, concrete pump, generator, vehicle) for which hours are being recorded.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the equipment was deployed and operated during this time period.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Equipment operating hour costs are posted to cost codes for labor and equipment cost tracking.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the supervisor or project manager who approved this equipment hours record for cost posting and payroll processing.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element or work package where equipment hours were charged for granular cost tracking and EVM reporting.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the equipment hours record. Tracks progression from field entry through supervisor approval to final posting for cost allocation.. Valid values are `draft|submitted|approved|rejected|disputed`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment hours record was approved by the authorized supervisor. Used for audit trail and approval cycle time analysis.',
    `cost_per_hour` DECIMAL(18,2) COMMENT 'Calculated or allocated cost per operating hour for this equipment during the shift. Includes ownership cost, fuel, operator labor, and maintenance allocation. Used for job costing and CPI calculation.',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event cause (breakdown, awaiting parts, awaiting operator, weather hold, scheduled maintenance, unscheduled repair). Used for downtime root cause analysis.. Valid values are `breakdown|awaiting_parts|awaiting_operator|weather_hold|scheduled_maintenance|unscheduled_repair`',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when equipment downtime event ended and equipment returned to service. Used for MTTR and downtime duration calculation.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was unavailable due to breakdown, maintenance, repair, or other non-productive events. Sum of all downtime event durations for the shift.',
    `downtime_impact_assessment` STRING COMMENT 'Business assessment of the downtime events impact on project schedule, cost, and critical path activities. Used for prioritizing maintenance and resource allocation.. Valid values are `critical|high|medium|low|none`',
    `downtime_resolution_action` STRING COMMENT 'Free-text description of the corrective action taken to resolve the downtime event and return equipment to service. Includes repair details, parts replaced, or workaround applied.',
    `downtime_root_cause_code` STRING COMMENT 'Detailed alphanumeric code identifying the specific root cause of the downtime event (e.g., hydraulic failure, tire puncture, electrical fault). Used for MTBF and failure pattern analysis.. Valid values are `^[A-Z0-9]{2,8}$`',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when equipment downtime event began. Used for MTTR (Mean Time To Repair) and availability rate calculations.',
    `equipment_availability_rate` DECIMAL(18,2) COMMENT 'Calculated percentage of scheduled time that equipment was available for use (not in downtime). Formula: ((total_hours - downtime_hours) / total_hours) * 100. Used for maintenance effectiveness and reliability analysis.',
    `equipment_utilization_rate` DECIMAL(18,2) COMMENT 'Calculated percentage of available time that equipment was productively operating. Formula: (operating_hours / (operating_hours + idle_hours + standby_hours + downtime_hours)) * 100. Key performance indicator for fleet management.',
    `fuel_consumption_liters` DECIMAL(18,2) COMMENT 'Total fuel consumed by the equipment during the shift, measured in liters. Used for fuel efficiency analysis, cost allocation, and environmental reporting.',
    `idle_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was powered on but not performing productive work (waiting for materials, operator break, minor delays). Excludes scheduled downtime.',
    `is_billable` BOOLEAN COMMENT 'Flag indicating whether these equipment hours are billable to the client under the contract terms. Used for revenue recognition and client invoicing.',
    `is_overtime` BOOLEAN COMMENT 'Flag indicating whether these equipment hours were logged during overtime shift periods, affecting cost rates and operator compensation.',
    `location_description` STRING COMMENT 'Free-text description of the specific work location or area within the project site where equipment was deployed (e.g., North Excavation Zone, Building A Foundation, Access Road KM 12).',
    `meter_reading_end` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading at the end of the shift. Used to validate reported hours and track cumulative equipment usage for maintenance scheduling.',
    `meter_reading_start` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading at the start of the shift. Used to validate reported hours and track cumulative equipment usage for maintenance scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context about the equipment hours entry. May include operational notes, safety observations, or special conditions.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was actively operating and performing productive work during the shift. Core metric for utilization rate calculation and cost-per-hour analysis.',
    `ownership_type` STRING COMMENT 'Classification of equipment ownership model (owned, rented, leased, subcontractor-supplied). Affects cost allocation method and asset management responsibility.. Valid values are `owned|rented|leased|subcontractor_supplied`',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work output achieved during the shift (e.g., cubic meters excavated, tons hauled, square meters paved). Used for productivity rate calculation and earned value analysis.',
    `production_unit_of_measure` STRING COMMENT 'Unit of measure for the production quantity achieved (cubic meters, tons, square meters, linear meters, each, kilograms, liters). Aligns with project quantity takeoff and BOQ units. [ENUM-REF-CANDIDATE: m3|ton|m2|linear_m|each|kg|liter — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment hours record was first created in the source system. Audit field for data lineage and record lifecycle tracking.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this equipment hours record was last modified in the source system. Audit field for change tracking and data quality monitoring.',
    `rental_invoice_reference` STRING COMMENT 'External rental company invoice number or reference for rented equipment hours. Used for rental cost reconciliation and accounts payable matching.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `shift_date` DATE COMMENT 'Calendar date on which the equipment hours were recorded. Primary business event date for daily time tracking and utilization reporting.',
    `shift_type` STRING COMMENT 'Classification of the work shift during which equipment hours were logged (day, night, swing, weekend, holiday, emergency). Used for shift differential costing and scheduling analysis.. Valid values are `day|night|swing|weekend|holiday|emergency`',
    `source_record_reference` STRING COMMENT 'Unique identifier of the equipment hours record in the source operational system. Used for data lineage traceability and reconciliation.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `standby_hours` DECIMAL(18,2) COMMENT 'Hours the equipment was on-site, available for use, but not powered on or actively deployed. Includes weather holds and awaiting instructions.',
    `total_equipment_cost` DECIMAL(18,2) COMMENT 'Total cost charged to the project for this equipment hours record. Calculated as operating_hours * cost_per_hour plus any additional charges. Used for project cost control and EVM.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition during the shift that may have affected equipment operation and productivity. Used for weather impact analysis and EOT claims. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hours PRIMARY KEY(`hours_id`)
) COMMENT 'Daily or shift-level transactional record of equipment operating hours, idle hours, standby hours, and downtime events captured from HCSS HeavyJob field time tracking. Includes cost code, operator ID, project and WBS reference, fuel consumption, meter reading (odometer or hour meter), shift date, production quantity achieved. For non-productive time: captures downtime start/end timestamps, duration, downtime category (breakdown, awaiting parts, awaiting operator, weather hold, scheduled maintenance), root cause code, resolution action, and impact assessment. Foundational for equipment utilization rate calculation, cost-per-hour analysis, MTTR (Mean Time To Repair), MTBF (Mean Time Between Failures), availability rate reporting, and CPI/SPI reporting under EVM. SSOT for all equipment time and downtime recording. Primary source: HCSS HeavyJob daily time entry.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the maintenance plan record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Maintenance plans are defined in equipment service contracts; linking supports schedule and financial tracking per agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset or equipment class covered by this maintenance plan.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and its maintenance plan are assigned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance plan budgeting is tracked against a cost center to align planned expenses with financial budgets.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Maintenance planning system records the planner (employee) who creates each plan, needed for accountability and cost allocation.',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance crew or team responsible for executing this maintenance plan.',
    `functional_location_id` BIGINT COMMENT 'add column functional_location_id (BIGINT) with FK to equipment.functional_location.functional_location_id - maintenance plans attach to functional locations',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether completion of this maintenance plan requires formal certification or inspection sign-off by a qualified authority.',
    `compliance_requirement_code` STRING COMMENT 'Code identifying the regulatory or compliance requirement driving this maintenance plan (e.g., OSHA crane certification, EPA emissions inspection, manufacturer warranty requirement).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance plan record was first created in the system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment must be taken out of service to perform the maintenance activities in this plan.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance plan expires or is scheduled to be deactivated. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the maintenance plan becomes active and begins generating scheduled maintenance tasks.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan includes activities required for environmental compliance (emissions testing, fluid disposal, spill prevention).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the equipment will be unavailable during maintenance execution.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete the maintenance activities defined in this plan.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated labor cost in base currency for executing one cycle of this maintenance plan.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of parts, materials, and consumables required for one maintenance cycle.',
    `interval_unit` STRING COMMENT 'Unit of measure for the maintenance interval (hours, days, weeks, months, years, kilometers, cycles). [ENUM-REF-CANDIDATE: hours|days|weeks|months|years|kilometers|cycles — 7 candidates stripped; promote to reference product]',
    `interval_value` DECIMAL(18,2) COMMENT 'Numeric value defining the service interval (e.g., 250 for every 250 engine hours, 6 for every 6 months).',
    `last_execution_date` DATE COMMENT 'Date when the maintenance plan was last executed, used to calculate the next scheduled maintenance date.',
    `lead_time_days` STRING COMMENT 'Number of days advance notice required before the scheduled maintenance date to allow for planning, parts procurement, and resource allocation.',
    `manufacturer_recommendation_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan follows the equipment manufacturers recommended service schedule.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this maintenance plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance plan record was last updated.',
    `next_scheduled_date` DATE COMMENT 'Calculated date for the next scheduled maintenance activity based on the interval and last execution date.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special considerations, or operational notes related to the execution of this maintenance plan.',
    `parts_list_reference` STRING COMMENT 'Reference to the bill of materials (BOM) or parts list defining the spare parts and materials required for this maintenance plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the maintenance plan for human identification and reporting purposes.',
    `plan_number` STRING COMMENT 'Business identifier for the maintenance plan, externally visible and used in operational communications.. Valid values are `^[A-Z0-9]{8,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the maintenance plan indicating whether it is generating work orders.. Valid values are `draft|active|suspended|inactive|archived`',
    `plan_type` STRING COMMENT 'Classification of the maintenance strategy: time-based (calendar intervals), meter-based (usage hours/kilometers), condition-based (sensor thresholds), predictive (AI/ML forecasting), or statutory (regulatory compliance).. Valid values are `time_based|meter_based|condition_based|predictive|statutory`',
    `priority_level` STRING COMMENT 'Business priority classification for scheduling and resource allocation of maintenance activities generated by this plan.. Valid values are `critical|high|medium|low`',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan addresses safety-critical equipment or systems where failure could result in injury or fatality.',
    `scheduling_strategy` STRING COMMENT 'Defines how maintenance tasks are scheduled: fixed schedule (specific calendar dates), floating schedule (relative to last completion), or on-demand (triggered by condition).. Valid values are `fixed_schedule|floating_schedule|on_demand`',
    `site_location_code` STRING COMMENT 'Code identifying the construction site, yard, or facility where the equipment is located and maintenance will be performed.. Valid values are `^[A-Z0-9]{3,8}$`',
    `task_list_reference` STRING COMMENT 'Reference code to the detailed maintenance task list or work instruction document that defines the specific activities, steps, and procedures to be performed.. Valid values are `^TL[A-Z0-9]{6,10}$`',
    `tolerance_after_days` STRING COMMENT 'Number of days after the scheduled date that maintenance can be delayed without triggering an overdue alert.',
    `tolerance_before_days` STRING COMMENT 'Number of days before the scheduled date that maintenance can be performed early without resetting the interval counter.',
    `warranty_impact_flag` BOOLEAN COMMENT 'Indicates whether adherence to this maintenance plan is required to maintain equipment warranty coverage.',
    `work_order_type` STRING COMMENT 'Classification of the work orders generated by this maintenance plan (preventive maintenance, inspection, calibration, overhaul, statutory compliance).. Valid values are `preventive|inspection|calibration|overhaul|statutory`',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Master record defining the preventive maintenance strategy and schedule for a class of equipment or individual asset. Captures maintenance plan type (time-based, meter-based, condition-based), service intervals (e.g., every 250 engine hours, every 6 months), maintenance task list reference, responsible maintenance team, estimated duration, parts and materials required, and compliance requirements (e.g., crane certification intervals, OSHA inspection schedules). Sourced from SAP PM Maintenance Plan.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` (
    `maintenance_order_id` BIGINT COMMENT 'Unique identifier for the maintenance order record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Maintenance services are often covered by service contracts; the link allocates labor and parts costs to the correct agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset on which this maintenance activity was performed. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment and maintenance activity are assigned. Enables project-level cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance order costs must be charged to the responsible cost center for accurate project cost reporting.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Assign Maintenance Orders to Subcontractor responsible for servicing the asset, enabling cost allocation and work order routing per contract terms.',
    `maintenance_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that generated this order, if applicable. Null for corrective or breakdown orders.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Needed to record which material (spare part) is consumed in a maintenance order, supporting inventory control and maintenance cost analysis.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the primary technician or mechanic assigned to execute this maintenance order. Links to workforce or employee master data.',
    `tertiary_maintenance_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last updated this maintenance order record. Used for audit trail and change tracking.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the maintenance work was completed. Used to calculate actual downtime and compare against planned duration.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the maintenance work commenced. Captured from field logs or technician time entry systems.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order was formally closed in the system, indicating all work and cost postings are complete. Null if order is not yet closed.',
    `compliance_inspection_flag` BOOLEAN COMMENT 'Indicates whether this maintenance order includes a statutory or regulatory compliance inspection (e.g., OSHA crane inspection, pressure vessel certification). True if compliance inspection performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order record was first created in the system. Part of the audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts in this maintenance order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the equipment was out of service due to this maintenance activity. Critical metric for availability analysis and project impact assessment.',
    `external_services_cost` DECIMAL(18,2) COMMENT 'Cost of external contractor services or specialized vendor support procured for this maintenance order (e.g., OEM technician, crane inspection service).',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or defect addressed by this maintenance order (e.g., hydraulic leak, engine overheating, electrical fault). Used for failure pattern analysis.',
    `failure_description` STRING COMMENT 'Detailed narrative description of the failure, defect, or maintenance requirement that this order addresses. Captured from technician notes or notification text.',
    `inspection_certificate_number` STRING COMMENT 'Certificate or permit number issued upon successful completion of a statutory inspection, if applicable. Required for regulatory audit trails.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for this maintenance order, calculated from labor hours and technician rates. Excludes parts and external services.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended on this maintenance order, aggregated across all technicians and activities. Used for cost calculation and productivity analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this maintenance order record was last updated. Part of the audit trail for compliance and data governance.',
    `meter_reading_at_maintenance` DECIMAL(18,2) COMMENT 'Equipment hour meter or odometer reading captured at the time of maintenance. Used for usage-based maintenance scheduling and lifecycle tracking.',
    `next_inspection_due_date` DATE COMMENT 'Date when the next statutory or preventive inspection is due for this equipment, updated upon completion of this maintenance order.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this maintenance order. May include safety precautions, access requirements, or follow-up actions.',
    `notification_id` BIGINT COMMENT 'Reference to the maintenance notification or work request that triggered this corrective or breakdown order. Null for preventive orders.',
    `order_number` STRING COMMENT 'Business identifier for the maintenance order, typically the SAP PM order number or HCSS work order reference used for tracking and reporting.',
    `order_status` STRING COMMENT 'Current lifecycle status of the maintenance order. Tracks progression from creation through execution to closure. [ENUM-REF-CANDIDATE: created|released|in_progress|completed|technically_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the maintenance activity: preventive (scheduled), corrective (planned repair), breakdown (emergency), statutory inspection (regulatory), calibration, or overhaul.. Valid values are `preventive|corrective|breakdown|statutory_inspection|calibration|overhaul`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts and materials consumed during this maintenance activity, aggregated from all parts line items.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the maintenance activity is planned to be completed. Used for equipment downtime planning and project scheduling.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the maintenance activity is planned to begin. Used for resource planning and equipment availability forecasting.',
    `priority` STRING COMMENT 'Urgency level of the maintenance order. Critical and high priority orders require immediate attention to prevent safety hazards or project delays.. Valid values are `critical|high|medium|low`',
    `purchase_order_number` STRING COMMENT 'Purchase order number for external services or parts procured for this maintenance order, if applicable. Links to procurement records.',
    `site_location_code` STRING COMMENT 'Code identifying the construction site or yard location where the maintenance was performed. Supports geographic cost analysis and logistics planning.',
    `total_maintenance_cost` DECIMAL(18,2) COMMENT 'Total cost of the maintenance order, summing labor, parts, and external services. Used for asset lifecycle costing and budget tracking.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this maintenance order is associated with a warranty claim against the equipment manufacturer or supplier. True if warranty claim was filed.',
    `warranty_claim_number` STRING COMMENT 'External warranty claim reference number provided by the equipment manufacturer or supplier, if applicable. Null if no warranty claim.',
    `work_center_code` STRING COMMENT 'Code identifying the maintenance work center or shop responsible for executing this order (e.g., heavy equipment shop, electrical shop, hydraulics shop).',
    `work_performed_description` STRING COMMENT 'Detailed narrative of the maintenance work actually performed, including repairs, replacements, adjustments, and inspections. Serves as technical record and warranty evidence.',
    CONSTRAINT pk_maintenance_order PRIMARY KEY(`maintenance_order_id`)
) COMMENT 'Transactional work order record for a specific maintenance activity executed on an asset, generated from a maintenance plan (preventive) or raised as a corrective/breakdown order from a notification. Captures order type (preventive, corrective, breakdown, statutory inspection), priority, planned and actual start/end dates, assigned technician, labor hours, parts consumed (part number, quantity, unit cost per line item), total maintenance cost (labor + parts + external services), order status (created, released, in-progress, completed, technically complete, closed), and SAP PM order number. Supports maintenance cost tracking at labor and parts level, asset downtime analysis, warranty claim evidence, and compliance audit trails. Parts consumption data here serves as the equipment domains record of materials used — material domain owns stock levels and replenishment.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` (
    `maintenance_notification_id` BIGINT COMMENT 'Unique identifier for the maintenance notification record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset against which this notification was raised.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which the equipment was assigned at the time of the notification, enabling project-level downtime and cost tracking.',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location where the equipment was positioned at the time of fault or observation.',
    `maintenance_order_id` BIGINT COMMENT 'Reference to the resulting maintenance work order created to address this notification. Links the fault report to the corrective action.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the employee (operator, site supervisor, or maintenance technician) who raised the notification.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element or activity where the equipment was deployed, allowing cost allocation of maintenance and downtime to project tasks.',
    `actual_downtime_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours that the equipment was unavailable due to the fault, calculated from breakdown start to breakdown end timestamps. Used for MTTR and availability KPIs.',
    `breakdown_end_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment was restored to operational status following repair. Used to calculate total downtime duration.',
    `breakdown_indicator` BOOLEAN COMMENT 'Flag indicating whether the notification represents a complete equipment breakdown (true) or a partial malfunction/observation (false). Breakdown status triggers expedited response and downtime tracking.',
    `breakdown_start_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment became inoperable due to the fault. Used to calculate downtime and Mean Time To Repair (MTTR).',
    `catalog_profile` STRING COMMENT 'Code linking this notification to a predefined catalog of fault codes, damage codes, and object parts, ensuring standardized classification.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cause_text` STRING COMMENT 'Description of the suspected or confirmed root cause of the fault, captured during investigation or repair.',
    `completion_date` DATE COMMENT 'Date on which the notification was closed after successful resolution of the fault and verification of equipment operability.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this notification record was first created in the database.',
    `damage_code` STRING COMMENT 'Code identifying the specific component or part that is damaged or malfunctioning, enabling root cause analysis and spare parts planning.. Valid values are `^[A-Z0-9]{4,10}$`',
    `detection_method` STRING COMMENT 'Method by which the fault or defect was discovered: operator observation during use, routine inspection, condition monitoring system alert, breakdown event, or safety audit finding.. Valid values are `operator_observation|routine_inspection|condition_monitoring|breakdown|safety_audit`',
    `effect_text` STRING COMMENT 'Description of the operational impact or consequence of the fault (e.g., reduced productivity, safety hazard, complete stoppage).',
    `equipment_location_at_fault` STRING COMMENT 'Physical location or site area where the equipment was positioned when the fault occurred (e.g., site name, zone, GPS coordinates). Critical for dispatching repair crews.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the equipment will be out of service for repair, used for production planning and resource scheduling.',
    `fault_code` STRING COMMENT 'Standardized code classifying the type of fault or defect according to the organizations maintenance taxonomy (e.g., hydraulic leak, electrical failure, structural crack).. Valid values are `^[A-Z0-9]{4,10}$`',
    `fault_description` STRING COMMENT 'Detailed narrative description of the observed fault, defect, malfunction, or condition as reported by field personnel. Includes symptoms, context, and any immediate actions taken.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to this notification record, supporting audit trail and change tracking.',
    `main_work_center` STRING COMMENT 'Code identifying the primary maintenance work center (trade or craft) responsible for executing the repair (e.g., mechanical, electrical, hydraulic).. Valid values are `^[A-Z0-9]{4,10}$`',
    `notification_number` STRING COMMENT 'Externally visible business identifier for the maintenance notification, typically system-generated in SAP PM format.. Valid values are `^[A-Z0-9]{10,20}$`',
    `notification_origin` STRING COMMENT 'Source or trigger that initiated the notification: field report from site, preventive maintenance inspection, condition monitoring system, safety inspection, or operator daily logbook entry.. Valid values are `field_report|preventive_maintenance|condition_monitoring|safety_inspection|operator_logbook`',
    `notification_status` STRING COMMENT 'Current lifecycle state of the notification. Outstanding indicates newly created and awaiting action; in_progress indicates work has commenced; completed indicates fault resolved and notification closed; cancelled indicates notification withdrawn; deferred indicates postponed for future action.. Valid values are `outstanding|in_progress|completed|cancelled|deferred`',
    `notification_type` STRING COMMENT 'Classification of the notification indicating the nature of the issue: malfunction (operational fault), breakdown (complete failure), damage (physical harm), activity request (planned work), preventive observation (condition monitoring finding), or safety defect (HSE-related issue).. Valid values are `malfunction|breakdown|damage|activity_request|preventive_observation|safety_defect`',
    `object_part_code` STRING COMMENT 'Code specifying the equipment component or assembly affected by the fault (e.g., engine, hydraulic pump, boom, track).. Valid values are `^[A-Z0-9]{4,10}$`',
    `planner_group` STRING COMMENT 'Code identifying the maintenance planning team or department responsible for scheduling and coordinating the repair work.. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority` STRING COMMENT 'Urgency classification of the notification determining response time and resource allocation. Critical indicates immediate safety or production impact; high indicates significant operational impact; medium indicates moderate impact; low indicates minor or cosmetic issues.. Valid values are `critical|high|medium|low`',
    `reported_date` DATE COMMENT 'Calendar date on which the fault, defect, or observation was first reported by field personnel.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the notification was created in the system, capturing the moment the fault or observation was logged.',
    `required_end_date` DATE COMMENT 'Target date by which the fault should be resolved and equipment returned to service, based on priority and operational commitments.',
    `required_start_date` DATE COMMENT 'Target date by which maintenance work should commence, based on priority and operational impact.',
    `safety_related_flag` BOOLEAN COMMENT 'Indicator that the fault or defect poses a Health, Safety, and Environment (HSE) risk, triggering additional safety protocols and HSE reporting.',
    `system_condition` STRING COMMENT 'Code describing the operational state of the equipment at the time of fault (e.g., running, idle, startup, shutdown).. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_maintenance_notification PRIMARY KEY(`maintenance_notification_id`)
) COMMENT 'Transactional record capturing a fault report, breakdown notification, or defect observation raised against an asset in the field. Includes notification type (malfunction, damage, activity request), reported date and time, reported by (operator or site supervisor), fault description, asset location at time of fault, urgency classification, and link to the resulting maintenance order. Sourced from SAP PM Notification. Enables rapid response to equipment breakdowns and tracks mean time to repair (MTTR).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`inspection_record` (
    `inspection_record_id` BIGINT COMMENT 'Unique identifier for the equipment inspection record. Primary key for the inspection_record product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Inspection services are often covered by contracts; associating inspections with the agreement enables compliance and cost tracking.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset that was inspected. Links to the equipment master data product.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment is currently assigned at the time of inspection. Null if equipment is in yard or not assigned to a project.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Regulatory inspection logs must capture the certified employee who performed the inspection for audit trails and compliance reporting.',
    `certificate_document_reference` STRING COMMENT 'File path, document management system reference, or URL pointing to the stored digital copy of the compliance certificate. Used for audit retrieval and regulatory verification. Null if no certificate was issued.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the compliance certificate expires and the equipment must be re-inspected to maintain certification. Critical for compliance tracking and pre-mobilization checks. Null if no certificate was issued or certificate has no expiry.',
    `certificate_issue_date` DATE COMMENT 'Date on which the compliance certificate was formally issued by the issuing authority. Null if no certificate was issued.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal compliance certificate was issued as a result of this inspection. True indicates a certificate was generated and is on file. False indicates no certificate was issued (typical for routine pre-start checks or failed inspections).',
    `certificate_issuing_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the compliance certificate. Examples include OSHA, ASME authorized inspector, insurance company, third-party certification body, or internal HSE department. Null if no certificate was issued.',
    `certificate_number` STRING COMMENT 'Unique identifier assigned to the compliance certificate issued as a result of this inspection. Used for regulatory audit trails and insurance verification. Null if no certificate was issued.',
    `certificate_type` STRING COMMENT 'Classification of the compliance certificate issued. Crane load test certificate: structural capacity verification. Pressure vessel certificate: boiler and pressure equipment certification. Lifting gear certificate: rigging and lifting equipment certification. OSHA compliance certificate: regulatory safety certification. Insurance certificate: insurer-required equipment certification. FAT: Factory Acceptance Test certificate. SAT: Site Acceptance Test certificate. Fitness for use: general equipment fitness certification. Null if no certificate was issued. [ENUM-REF-CANDIDATE: crane_load_test|pressure_vessel|lifting_gear|osha_compliance|insurance|fat|sat|fitness_for_use — 8 candidates stripped; promote to reference product]',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions must be completed to restore equipment compliance. Null if no corrective actions are required.',
    `corrective_actions_required` STRING COMMENT 'Detailed description of corrective actions, repairs, or remediation work required to address identified defects and restore equipment to compliant, fit-for-use condition.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was first created in the maintenance management or HSE system. Audit trail for data lineage.',
    `defects_description` STRING COMMENT 'Detailed narrative description of all defects, non-conformances, observations, or safety concerns identified during the inspection. Includes location, severity, and nature of each finding.',
    `defects_identified_count` STRING COMMENT 'Total number of defects, non-conformances, or observations identified during the inspection. Zero indicates no issues found.',
    `equipment_hours_at_inspection` DECIMAL(18,2) COMMENT 'Total accumulated operating hours recorded on the equipment hour meter at the time of inspection. Used for usage-based maintenance scheduling and lifecycle tracking.',
    `inspection_checklist_reference` STRING COMMENT 'Reference to the standard inspection checklist, Inspection and Test Plan (ITP), or procedure document used to conduct this inspection. Links to document management system.',
    `inspection_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this inspection event, including inspector fees, third-party inspection charges, testing costs, and administrative overhead. Null if cost not tracked.',
    `inspection_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the inspection cost. Examples: USD, EUR, GBP. Null if cost not tracked.. Valid values are `^[A-Z]{3}$`',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was performed. This is the principal business event date for the inspection record.',
    `inspection_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity was completed and findings were recorded.',
    `inspection_frequency_days` STRING COMMENT 'Standard interval in days between required inspections for this equipment and inspection type. Used to calculate next inspection due date. Examples: 1 day for pre-start checks, 30 days for monthly inspections, 365 days for annual statutory inspections.',
    `inspection_location` STRING COMMENT 'Physical location where the inspection was performed. May be a construction site name, yard location, workshop, factory, or field location identifier.',
    `inspection_notes` STRING COMMENT 'Free-form text field for additional observations, comments, recommendations, or contextual information recorded by the inspector that does not fit into structured fields.',
    `inspection_number` STRING COMMENT 'Externally-known unique business identifier for the inspection event, typically generated by the maintenance management system or HSE system.',
    `inspection_outcome` STRING COMMENT 'Final pass/fail determination of the inspection. Pass: equipment meets all requirements and is fit for use. Fail: equipment does not meet requirements and must not be used until corrective action is completed. Conditional pass: equipment passed with minor observations or time-limited approval. Not applicable: inspection was not completed or outcome not yet determined.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `inspection_scope` STRING COMMENT 'Detailed description of the scope of work covered by this inspection. Specifies which components, systems, or functions were inspected and any exclusions or limitations.',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity commenced on site or in the facility.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record. Scheduled: inspection planned but not started. In progress: inspection underway. Completed: inspection finished, outcome recorded. Passed: equipment meets all requirements. Failed: equipment does not meet requirements, corrective action required. Conditional pass: equipment passed with minor observations or time-limited approval. Cancelled: inspection was cancelled before completion. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|passed|failed|conditional_pass|cancelled — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection event. Pre-start check: operator daily verification before use. Periodic statutory: legally mandated recurring inspection. OSHA compliance check: regulatory safety inspection per Occupational Safety and Health Administration requirements. Crane load test: structural load capacity verification. Lifting gear: rigging and lifting equipment inspection. Pressure vessel test: boiler and pressure equipment certification. FAT: Factory Acceptance Test. SAT: Site Acceptance Test. Operator daily: routine operator checklist. Preventive maintenance: scheduled PM inspection. [ENUM-REF-CANDIDATE: pre_start_check|periodic_statutory|osha_compliance|crane_load_test|lifting_gear|pressure_vessel|fat|sat|operator_daily|preventive_maintenance — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this inspection record was last updated or modified. Audit trail for data lineage and change tracking.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of this equipment, based on regulatory requirements, manufacturer recommendations, or internal maintenance schedules. Critical for compliance tracking and preventive maintenance planning.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of the specific regulatory requirement, standard, or code that mandates this inspection. Examples: OSHA 1926.550 for cranes, ASME Section VIII for pressure vessels, manufacturer maintenance manual reference.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor equipment inspections where environmental factors may affect inspection validity or equipment condition assessment.',
    CONSTRAINT pk_inspection_record PRIMARY KEY(`inspection_record_id`)
) COMMENT 'Transactional record of a statutory, regulatory, or internal safety inspection performed on a piece of equipment, and the master register of all resulting compliance certificates issued. Captures inspection type (pre-start check, periodic statutory inspection, OSHA compliance check, crane load test, lifting gear inspection, pressure vessel test, FAT/SAT), inspection date, inspector name and certification, pass/fail outcome, defects identified, corrective actions required, next inspection due date. For certificates: captures certificate type (crane load test certificate, pressure vessel certificate, lifting gear certificate, OSHA compliance certificate, insurance certificate), certificate number, issuing authority, issue date, expiry date, and document storage reference. SSOT for all equipment inspection events AND asset-level compliance certificates. Supports OSHA compliance, insurance requirements, equipment fitness-for-use certification, pre-mobilization compliance checks, and regulatory audit trails. Distinct from quality ITP inspections (owned by quality domain) and operator certifications (which track people, not assets).';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` (
    `rental_agreement_id` BIGINT COMMENT 'Unique identifier for the equipment rental agreement. Primary key for the rental agreement record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Rental agreements are a type of contract; linking enables compliance, billing, and performance reporting against the governing agreement.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Rental agreements require approval by a procurement officer; linking to employee enables approval audit and compliance reporting.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment unit being rented. Links to the equipment master record in the equipment domain.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this rental equipment is assigned. Links to the project master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rental agreement expenses are allocated to a cost center for cost tracking and billing.',
    `vendor_id` BIGINT COMMENT 'Reference to the plant hire company or equipment supplier providing the rental equipment. Links to the supplier master record.',
    `actual_demobilization_date` DATE COMMENT 'Actual date when the equipment was demobilized and removed from the project site. Used for final billing and cost reconciliation.',
    `actual_mobilization_date` DATE COMMENT 'Actual date when the equipment was delivered and mobilized to the project site. May differ from planned rental start date.',
    `approval_date` DATE COMMENT 'Date when the rental agreement was formally approved and authorized for execution.',
    `billing_frequency` STRING COMMENT 'Frequency at which rental charges are invoiced by the supplier (daily, weekly, monthly, or milestone-based).. Valid values are `daily|weekly|monthly|milestone`',
    `contract_document_reference` STRING COMMENT 'Reference to the physical or digital contract document stored in the document management system (e.g., Aconex document ID).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rental agreement record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rental agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daily_hire_rate` DECIMAL(18,2) COMMENT 'Agreed daily rental rate for the equipment in the contract currency. Used when billing is on a daily basis.',
    `damage_waiver_amount` DECIMAL(18,2) COMMENT 'Optional damage waiver fee paid to limit contractor liability for equipment damage during the rental period.',
    `demobilization_charge` DECIMAL(18,2) COMMENT 'One-time charge for dismantling and removing the equipment from the project site. Invoiced at rental completion.',
    `equipment_description` STRING COMMENT 'Detailed description of the rented equipment including make, model, capacity, and specifications (e.g., Liebherr LTM 1200-5.1 Mobile Crane, 200-ton capacity).',
    `equipment_type` STRING COMMENT 'Classification of the rented equipment by type. Used for fleet management and cost analysis. [ENUM-REF-CANDIDATE: crane|excavator|bulldozer|loader|concrete_pump|generator|compressor|scaffolding|formwork|tower_crane|mobile_crane — 11 candidates stripped; promote to reference product]',
    `fuel_included_flag` BOOLEAN COMMENT 'Indicates whether fuel costs are included in the hire rate (True) or billed separately (False).',
    `insurance_certificate_number` STRING COMMENT 'Reference number of the insurance certificate covering the rented equipment. Used for compliance verification.',
    `insurance_requirement` STRING COMMENT 'Description of insurance coverage requirements for the rented equipment, including liability limits and coverage types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rental agreement record was last updated. Used for audit trail and change tracking.',
    `late_return_penalty_rate` DECIMAL(18,2) COMMENT 'Daily penalty rate charged by the supplier if equipment is returned after the agreed rental end date.',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for routine maintenance and repairs during the rental period (supplier, contractor, or shared).. Valid values are `supplier|contractor|shared`',
    `minimum_hire_period_days` STRING COMMENT 'Minimum number of days the equipment must be hired as stipulated in the rental agreement. Used for cost commitment calculation.',
    `mobilization_charge` DECIMAL(18,2) COMMENT 'One-time charge for transporting and setting up the equipment at the project site. Invoiced at rental commencement.',
    `monthly_hire_rate` DECIMAL(18,2) COMMENT 'Agreed monthly rental rate for the equipment in the contract currency. Used when billing is on a monthly basis.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or remarks related to the rental agreement.',
    `operator_supplied_flag` BOOLEAN COMMENT 'Indicates whether the rental supplier provides a qualified operator with the equipment (True) or if the contractor provides their own operator (False).',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the supplier (e.g., Net 30 days, Net 45 days, 2/10 Net 30). Governs invoice payment schedule.',
    `rental_agreement_number` STRING COMMENT 'Business-facing unique identifier for the rental agreement, typically used in contracts and invoices. Format: RA-NNNNNN.. Valid values are `^RA-[0-9]{6,10}$`',
    `rental_end_date` DATE COMMENT 'Planned or actual date when the rental period ends and equipment is demobilized. Nullable for open-ended rentals.',
    `rental_po_number` STRING COMMENT 'Purchase order number issued to the supplier for this rental agreement. Links the rental agreement to the procurement transaction.. Valid values are `^PO-[0-9]{8,12}$`',
    `rental_start_date` DATE COMMENT 'Date when the rental period begins and hire charges commence. Typically aligned with equipment mobilization date.',
    `rental_status` STRING COMMENT 'Current lifecycle status of the rental agreement. Tracks the agreement from draft through completion or cancellation. [ENUM-REF-CANDIDATE: draft|approved|active|on_hire|demobilized|completed|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Refundable security deposit held by the supplier to cover potential damage or late return penalties.',
    `site_location` STRING COMMENT 'Physical location or site address where the rented equipment will be deployed. Used for logistics and mobilization planning.',
    `total_committed_cost` DECIMAL(18,2) COMMENT 'Total committed cost for the rental agreement including minimum hire period charges, mobilization, and demobilization. Used for budget commitment and accrual.',
    `wbs_element_code` STRING COMMENT 'WBS element code for detailed project cost allocation and tracking. Links rental costs to specific work packages.',
    `weekly_hire_rate` DECIMAL(18,2) COMMENT 'Agreed weekly rental rate for the equipment in the contract currency. Used when billing is on a weekly basis.',
    CONSTRAINT pk_rental_agreement PRIMARY KEY(`rental_agreement_id`)
) COMMENT 'Master record governing the rental or hire of external equipment from a plant hire company or equipment supplier. Captures rental supplier, equipment description and type, rental start and end dates, agreed daily/weekly/monthly hire rate, minimum hire period, mobilization and demobilization charges, insurance requirements, operator-supplied flag, rental PO reference, and total committed rental cost. Distinct from procurement POs (owned by procurement domain) — this is the equipment-domain SSOT for rental fleet management and cost accrual.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` (
    `equipment_mobilization_id` BIGINT COMMENT 'Unique identifier for the equipment mobilization or demobilization event.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Mobilization costs are billed to equipment mobilization contracts; the FK ties each mobilization event to its contract agreement.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset being mobilized or demobilized.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with this mobilization event.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Logistics dispatch is performed by a specific employee; tracking supports operational reporting and liability management.',
    `vendor_id` BIGINT COMMENT 'Reference to the subcontractor or vendor responsible for transporting the equipment.',
    `actual_arrival_date` DATE COMMENT 'Actual date when the equipment arrived at the destination location.',
    `actual_dispatch_date` DATE COMMENT 'Actual date when the equipment departed from the origin location.',
    `actual_transit_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours that the equipment was in transit from origin to destination.',
    `cost_allocation_code` STRING COMMENT 'Cost center or Work Breakdown Structure (WBS) code to which the mobilization cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the mobilization record was first created in the system.',
    `destination_location` STRING COMMENT 'Name or identifier of the location to which the equipment is being mobilized (project site, yard, storage facility).',
    `destination_site_code` STRING COMMENT 'Standardized code identifying the destination site or facility.',
    `dispatch_condition` STRING COMMENT 'Assessed physical and operational condition of the equipment at the time of dispatch from the origin location.. Valid values are `excellent|good|fair|poor|requires_repair`',
    `dispatch_condition_notes` STRING COMMENT 'Detailed notes or observations regarding the equipment condition at dispatch, including any pre-existing damage or defects.',
    `dispatch_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch sign-off was completed.',
    `distance_km` DECIMAL(18,2) COMMENT 'Total distance in kilometers between the origin and destination locations.',
    `estimated_transit_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours for the equipment to be transported from origin to destination.',
    `event_type` STRING COMMENT 'Type of equipment movement event: mobilization (to site), demobilization (from site), inter-site transfer, or relocation.. Valid values are `mobilization|demobilization|inter_site_transfer|relocation`',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the equipment is covered by insurance during the mobilization transport.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance coverage applicable to this mobilization event.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the mobilization record was last updated in the system.',
    `mobilization_number` STRING COMMENT 'Externally-known business identifier for the mobilization event, typically formatted as MOB-YYYYNNNN.. Valid values are `^MOB-[0-9]{8}$`',
    `mobilization_status` STRING COMMENT 'Current lifecycle status of the mobilization event in the workflow.. Valid values are `planned|in_transit|completed|cancelled|delayed`',
    `origin_location` STRING COMMENT 'Name or identifier of the location from which the equipment is being mobilized (yard, warehouse, previous site).',
    `origin_site_code` STRING COMMENT 'Standardized code identifying the origin site or facility.',
    `permit_number` STRING COMMENT 'Official permit number(s) issued by the governing authority for this transport.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether special permits (oversize load, road permits, environmental permits) are required for this mobilization.',
    `permit_type` STRING COMMENT 'Type of permit(s) required for the transport, such as oversize load permit, road use permit, or environmental permit. Multiple permits may be listed.',
    `planned_arrival_date` DATE COMMENT 'Scheduled date when the equipment is expected to arrive at the destination location.',
    `planned_dispatch_date` DATE COMMENT 'Scheduled date when the equipment is planned to depart from the origin location.',
    `reason` STRING COMMENT 'Business justification or reason for the mobilization event, such as project start, equipment replacement, or maintenance requirement.',
    `receipt_condition` STRING COMMENT 'Assessed physical and operational condition of the equipment upon receipt at the destination location.. Valid values are `excellent|good|fair|poor|damaged_in_transit`',
    `receipt_condition_notes` STRING COMMENT 'Detailed notes or observations regarding the equipment condition at receipt, including any damage incurred during transport.',
    `receipt_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the receipt sign-off was completed.',
    `receipt_signed_by` STRING COMMENT 'Name of the site manager or authorized personnel who signed off on the equipment receipt at the destination.',
    `remarks` STRING COMMENT 'Additional comments, notes, or special instructions related to the mobilization event.',
    `transport_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for transporting the equipment, including freight, permits, and handling charges.',
    `transport_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transport cost.. Valid values are `^[A-Z]{3}$`',
    `transport_method` STRING COMMENT 'Method or mode of transportation used to move the equipment.. Valid values are `flatbed_truck|lowboy_trailer|self_propelled|rail|barge|air_freight`',
    CONSTRAINT pk_equipment_mobilization PRIMARY KEY(`equipment_mobilization_id`)
) COMMENT 'Transactional record capturing the mobilization or demobilization event of a piece of equipment to or from a project site. Tracks event type (mobilization, demobilization, inter-site transfer), planned and actual transport dates, origin and destination locations, transport contractor, transport cost, permits required (oversize load, road permits), equipment condition at dispatch and receipt, and sign-off by site manager. Supports site logistics planning, cost allocation, and equipment tracking across the fleet.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` (
    `fuel_transaction_id` BIGINT COMMENT 'Unique identifier for the fuel transaction record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Fuel supply is frequently contracted; associating each transaction with the governing agreement enables expense allocation and audit.',
    `asset_id` BIGINT COMMENT 'Identifier of the equipment or fleet vehicle that received fuel. Links to the equipment master data.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this fuel transaction is allocated for cost tracking.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the equipment operator who confirmed or authorized the fuel transaction. Links to workforce or employee master data.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Fuel consumption is charged to a cost code for cost allocation and EVM reporting.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Fuel transactions for equipment used by Subcontractor are billed to that Subcontractor, needed for cost recovery and fuel consumption reporting.',
    `fuel_point_id` BIGINT COMMENT 'Identifier of the fuel point, fuel station, or bowser from which the fuel was issued. May be an on-site fuel depot or external vendor station.',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Links fuel transactions to the material master for standardized fuel type, pricing, and regulatory reporting.',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or location where the equipment was operating at the time of fueling.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external fuel vendor or supplier if fuel was purchased from a third-party station. Null for internal fuel depots.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element for detailed project cost allocation and tracking.',
    `approval_status` STRING COMMENT 'Approval status of the fuel transaction. Indicates whether the transaction has been reviewed and approved by a supervisor or cost controller.. Valid values are `approved|pending_approval|rejected|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction was approved. Null if not yet approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the fuel transaction. Null if auto-approved or pending approval.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide emissions in kilograms resulting from the fuel consumed. Calculated based on fuel type and quantity for ISO 14001 environmental reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was first created in the system. Represents the audit trail creation time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fuel_card_number` STRING COMMENT 'Fuel card or fleet card number used for the transaction. Masked or tokenized for security. Used for reconciliation with vendor invoices.',
    `hour_meter_reading` DECIMAL(18,2) COMMENT 'Hour meter reading of the equipment at the time of fueling. Used to calculate fuel consumption per operating hour and detect anomalies.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with the fuel transaction. Used for accounts payable reconciliation.',
    `is_emergency_refuel` BOOLEAN COMMENT 'Flag indicating whether this was an emergency or unplanned refueling event. True indicates emergency; False indicates scheduled refueling.',
    `is_theft_suspected` BOOLEAN COMMENT 'Flag indicating whether fuel theft or wastage is suspected based on consumption patterns or anomaly detection. True indicates suspected theft; False indicates normal transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel transaction record was last modified. Used for audit trail and change tracking.',
    `odometer_reading` DECIMAL(18,2) COMMENT 'Odometer reading of the fleet vehicle at the time of fueling. Used for mileage-based fuel consumption analysis. Applicable to vehicles with odometers.',
    `operator_name` STRING COMMENT 'Name of the equipment operator who received the fuel on behalf of the equipment.',
    `purchase_order_number` STRING COMMENT 'Purchase order number if the fuel transaction was part of a formal procurement process. Used for contract compliance and spend tracking.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Quantity of fuel issued to the equipment in the specified unit of measure. Typically measured in litres or gallons.',
    `source_system_code` STRING COMMENT 'Unique identifier of the fuel transaction in the source system. Used for traceability and reconciliation.',
    `tank_capacity_percentage` DECIMAL(18,2) COMMENT 'Percentage of the equipment fuel tank capacity filled during this transaction. Used to detect partial fills and optimize refueling schedules.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel transaction calculated as quantity issued multiplied by unit cost. Expressed in the transaction currency.',
    `transaction_notes` STRING COMMENT 'Free-text notes or comments about the fuel transaction. May include reasons for emergency refueling, discrepancies, or special circumstances.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or receipt number issued at the time of fueling. Used for audit trail and reconciliation.',
    `transaction_status` STRING COMMENT 'Current status of the fuel transaction in its lifecycle. Completed indicates finalized and posted; pending indicates awaiting approval; cancelled indicates voided; disputed indicates under review.. Valid values are `completed|pending|cancelled|disputed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel was issued to the equipment. Represents the actual business event time of fueling.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of fuel at the time of transaction. Expressed in the transaction currency.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the fuel quantity issued. Common units include litres, gallons, or kWh for electric charging.. Valid values are `litres|gallons|kwh`',
    CONSTRAINT pk_fuel_transaction PRIMARY KEY(`fuel_transaction_id`)
) COMMENT 'Transactional record of fuel issued to a piece of equipment or fleet vehicle. Captures fuel type (diesel, petrol, LPG), quantity issued (litres), unit cost, total cost, issuing fuel point or bowser, date and time of issue, hour meter or odometer reading at fueling, project and cost code allocation, and operator confirmation. Enables fuel consumption tracking, cost-per-hour analysis, carbon emissions reporting (ISO 14001), and detection of fuel wastage or theft.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`operator_certification` (
    `operator_certification_id` BIGINT COMMENT 'Unique identifier for the operator certification record. Primary key for the operator certification entity.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Operator certification is tied to an equipment category; replace free‑text category with FK to asset_category to enforce consistency.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the equipment operator in the workforce domain who holds this certification. Links to the workforce master data to identify the individual operator.',
    `document_register_id` BIGINT COMMENT 'Reference to the digital document or scanned copy of the physical certification document stored in the document management system. Links to Aconex or BIM 360 document repository.',
    `assessment_date` DATE COMMENT 'The date on which the operator completed the certification assessment or examination. Represents the formal evaluation event.',
    `assessor_name` STRING COMMENT 'Name of the qualified assessor or examiner who conducted the certification assessment and validated the operators competency.',
    `capacity_rating` STRING COMMENT 'The maximum capacity or tonnage rating of equipment the operator is certified to operate, such as cranes up to 100 tons or forklifts up to 5 tons. Defines operational limits for equipment assignment.',
    `certificate_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification document.',
    `certification_level` STRING COMMENT 'The proficiency or skill level represented by the certification, such as basic, intermediate, advanced, or master operator. Indicates the complexity of equipment and operations the operator is qualified to perform. [ENUM-REF-CANDIDATE: basic|intermediate|advanced|master|trainee|journeyman|supervisor — 7 candidates stripped; promote to reference product]',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Indicates whether the certification is valid and active, expired, suspended, revoked, or pending renewal. Critical for HSE pre-start checks and operator assignment validation.. Valid values are `valid|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'The type or nature of the certification, such as operator license, competency card, safety certification, or manufacturer-specific certification.. Valid values are `operator_license|competency_card|safety_certification|manufacturer_certification|trade_qualification|endorsement`',
    `certifying_body` STRING COMMENT 'Name of the organization, authority, or institution that issued the certification. Examples include NCCCO, OSHA-approved training providers, manufacturer training centers, or government licensing authorities.',
    `certifying_body_accreditation_number` STRING COMMENT 'Accreditation or registration number of the certifying body, validating that the issuing organization is authorized to provide certifications.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or renew this certification, including training fees, examination fees, and administrative charges. Used for workforce development cost tracking.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount. Enables multi-currency cost tracking for international operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this certification record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `endorsements` STRING COMMENT 'Additional endorsements, specializations, or restrictions associated with the certification, such as night operations, confined spaces, or specific attachment types. Comma-separated list of endorsement codes or descriptions.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Operators must renew or recertify before this date to maintain valid certification status.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued to the operator. Represents the start of the certification validity period.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country in which the certification was issued. Important for cross-border projects and international operator mobility.. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'State, province, or regional jurisdiction within the issuing country where the certification was granted. Relevant for jurisdictions with state-level licensing requirements.',
    `last_renewal_date` DATE COMMENT 'The most recent date on which the certification was renewed or recertified. Tracks the certification maintenance history.',
    `medical_clearance_date` DATE COMMENT 'The date on which the operator received medical clearance or passed the required health examination for this certification. Nullable if medical clearance is not required.',
    `medical_clearance_expiry_date` DATE COMMENT 'The date on which the medical clearance expires and must be renewed. Nullable if medical clearance is not required or does not expire.',
    `medical_clearance_required` BOOLEAN COMMENT 'Indicates whether a medical examination or health clearance is required as part of the certification or renewal process. True if medical clearance is mandatory, false otherwise.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this certification record. Provides audit trail for data changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this certification record was last modified in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_renewal_due_date` DATE COMMENT 'The date by which the operator must complete renewal requirements to maintain continuous certification. Used for proactive renewal planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the certification. Captures contextual information not covered by structured fields.',
    `practical_assessment_score` DECIMAL(18,2) COMMENT 'Score or grade achieved by the operator in the practical hands-on assessment component of the certification. Typically expressed as a percentage or numeric score.',
    `reciprocity_agreements` STRING COMMENT 'List of countries, states, or jurisdictions where this certification is recognized under reciprocity or mutual recognition agreements. Enables cross-jurisdictional operator deployment.',
    `renewal_requirement` STRING COMMENT 'Description of the requirements the operator must fulfill to renew the certification, such as refresher training hours, re-assessment, continuing education credits, or medical examination.',
    `restrictions` STRING COMMENT 'Any limitations or restrictions placed on the certification, such as daylight operations only, supervised operation required, or specific site conditions. Defines operational boundaries for the operator.',
    `source_system_code` STRING COMMENT 'Unique identifier of this certification record in the source operational system. Enables traceability and reconciliation with source systems.',
    `sponsor_organization` STRING COMMENT 'Name of the organization that sponsored or paid for the operators certification training and examination. May be the construction company, a subcontractor, or the operator themselves.',
    `theory_assessment_score` DECIMAL(18,2) COMMENT 'Score or grade achieved by the operator in the theoretical or written examination component of the certification. Typically expressed as a percentage or numeric score.',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Total number of training hours completed by the operator to achieve this certification. Demonstrates the depth of training and preparation.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified with the certifying body or through an independent verification process.',
    `verification_status` STRING COMMENT 'Status of the certification verification process, indicating whether the certification has been independently verified with the issuing body. Critical for compliance and audit purposes.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    `verified_by` STRING COMMENT 'Name or identifier of the person, system, or organization that performed the certification verification. Provides audit trail for verification activities.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this certification record in the system. Provides audit trail for data entry.',
    CONSTRAINT pk_operator_certification PRIMARY KEY(`operator_certification_id`)
) COMMENT 'Master record of an equipment operators certification, licence, or competency qualification for a specific equipment type or class. Captures operator reference (linked to workforce domain), equipment category certified for (e.g., tower crane, mobile crane, excavator, forklift), certifying body, certificate number, issue date, expiry date, certification status (valid, expired, suspended), and renewal requirements. Supports OSHA compliance, HSE pre-start checks, and operator-to-equipment assignment validation. Owned by equipment domain as it governs equipment operation rights.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` (
    `telematics_reading_id` BIGINT COMMENT 'Unique identifier for the telematics reading record. Primary key for this IoT/telemetry transactional event.',
    `asset_id` BIGINT COMMENT 'Reference to the heavy equipment or fleet vehicle that generated this telematics reading. Links to the equipment master data asset.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this equipment is currently assigned. Derived from fleet assignment or geofence mapping. Enables project-level utilization and cost allocation.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the operator assigned to this equipment at the time of reading, if operator identification is captured via RFID, keypad, or mobile app login. Enables operator performance tracking and accountability.',
    `site_id` BIGINT COMMENT 'Reference to the construction site where this equipment is currently located. Derived from GPS coordinates and geofence mapping. Enables site-level fleet visibility.',
    `battery_voltage` DECIMAL(18,2) COMMENT 'Current battery voltage of the equipment. Low voltage may indicate battery health issues or electrical system faults.',
    `coolant_temperature_c` DECIMAL(18,2) COMMENT 'Engine coolant temperature in degrees Celsius. High temperatures may indicate overheating or cooling system faults.',
    `data_source` STRING COMMENT 'Source system or OEM telematics platform that provided this reading (e.g., Caterpillar Product Link, Komatsu KOMTRAX, John Deere JDLink, AEMP API, IoT Platform). Enables multi-vendor telematics integration and data lineage tracking.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation above sea level in meters at the time of reading. Useful for terrain analysis and site operations in mountainous or variable-elevation projects.',
    `engine_hours` DECIMAL(18,2) COMMENT 'Cumulative engine operating hours recorded by the equipment at the time of this reading. Critical metric for utilization tracking, maintenance scheduling, and asset lifecycle management.',
    `engine_rpm` STRING COMMENT 'Engine revolutions per minute at the time of reading. Indicates operational intensity and can signal abnormal operating conditions or maintenance needs.',
    `fault_code` STRING COMMENT 'Diagnostic Trouble Code (DTC) or J1939 fault code reported by the equipment at the time of reading. Empty if no fault detected. Enables predictive maintenance and early fault detection.',
    `fault_description` STRING COMMENT 'Human-readable description of the fault code, if available from the OEM telematics system. Assists maintenance teams in diagnosing issues.',
    `fault_severity` STRING COMMENT 'Severity level of the reported fault code. Critical faults may trigger immediate maintenance alerts or equipment shutdown protocols.. Valid values are `critical|high|medium|low|informational`',
    `fuel_consumed_liters` DECIMAL(18,2) COMMENT 'Cumulative fuel consumed in liters since the last reset or equipment initialization. Used for cost tracking and environmental reporting.',
    `fuel_level_percent` DECIMAL(18,2) COMMENT 'Current fuel tank level as a percentage of total capacity. Enables fuel consumption monitoring, refueling planning, and theft detection.',
    `geofence_code` BIGINT COMMENT 'Reference to the geofence zone that the equipment is currently within, if applicable. Null if equipment is outside all defined geofences. Enables site boundary compliance and theft detection.',
    `geofence_status` STRING COMMENT 'Status of the equipment relative to the assigned geofence at the time of reading. Triggers alerts for unauthorized movement or equipment theft.. Valid values are `inside|outside|entering|exiting|unknown`',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated accuracy of the GPS coordinates in meters. Lower values indicate higher precision. Used to assess reliability of location data for geofence and tracking analytics.',
    `hydraulic_pressure_bar` DECIMAL(18,2) COMMENT 'Hydraulic system pressure in bar. Applicable to equipment with hydraulic systems (excavators, cranes, concrete pumps). Abnormal pressure may indicate system faults.',
    `idle_time_minutes` DECIMAL(18,2) COMMENT 'Cumulative idle time in minutes (engine running but equipment not performing work). Key metric for utilization optimization and fuel efficiency analysis.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Date and time when this telematics reading was ingested into the lakehouse platform. Used for data pipeline monitoring and latency analysis.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the equipment at the time of reading, in decimal degrees. Enables real-time fleet tracking and geofence compliance monitoring.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the equipment at the time of reading, in decimal degrees. Enables real-time fleet tracking and geofence compliance monitoring.',
    `odometer_km` DECIMAL(18,2) COMMENT 'Cumulative distance traveled in kilometers. Applicable to mobile equipment and fleet vehicles. Used for maintenance scheduling and asset utilization tracking.',
    `operational_state` STRING COMMENT 'Current operational state of the equipment at the time of reading. Derived from engine status, movement, and sensor data. Enables real-time fleet status dashboards.. Valid values are `operating|idle|off|maintenance|fault|unknown`',
    `payload_weight_kg` DECIMAL(18,2) COMMENT 'Current payload weight in kilograms, if the equipment is equipped with onboard weighing systems (e.g., haul trucks, loaders). Used for production tracking and overload prevention.',
    `reading_quality` STRING COMMENT 'Quality indicator for this telematics reading. Suspect or invalid readings may result from sensor faults, connectivity issues, or data transmission errors. Used for data quality filtering in analytics.. Valid values are `valid|suspect|invalid|estimated`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the telematics reading was captured by the onboard device. Represents the real-world event time of the measurement, distinct from transmission or ingestion timestamps.',
    `source_system_code` STRING COMMENT 'Unique identifier of this reading in the source telematics system or IoT platform. Used for data reconciliation and deduplication.',
    `speed_kmh` DECIMAL(18,2) COMMENT 'Current speed of the equipment in kilometers per hour at the time of reading. Used for safety monitoring, route optimization, and geofence compliance.',
    `telematics_device_code` STRING COMMENT 'Unique identifier of the onboard telematics unit or IoT device that transmitted this reading (e.g., Caterpillar Product Link, Komatsu KOMTRAX, John Deere JDLink device serial number).',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the telematics reading was transmitted from the device to the IoT platform or AEMP API gateway. May differ from reading_timestamp due to connectivity delays.',
    CONSTRAINT pk_telematics_reading PRIMARY KEY(`telematics_reading_id`)
) COMMENT 'IoT/telemetry transactional record capturing real-time or near-real-time data transmitted from GPS and telematics devices fitted to heavy equipment and fleet vehicles, aligned with ISO 15143-3 (AEMP telematics standard) and OEM-agnostic integration patterns. Captures timestamp, GPS coordinates (latitude, longitude, elevation), engine hours, engine RPM, fuel level, idle time, fault codes (DTC/J1939), speed, geofence status, and asset operational state. Sourced from onboard telematics units (e.g., Caterpillar Product Link, Komatsu KOMTRAX, John Deere JDLink) integrated via IoT platform or AEMP API. Enables real-time fleet tracking, utilization monitoring, predictive maintenance triggers, geofence compliance, and theft detection.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` (
    `asset_valuation_id` BIGINT COMMENT 'Unique identifier for the asset valuation record.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment asset being valued. Links to the equipment master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for posting asset valuation depreciation to the correct cost center in financial statements.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to allocate asset valuation entries to the appropriate GL account for depreciation expense tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized from acquisition date through the valuation date. Represents the cumulative reduction in asset value due to wear, tear, and obsolescence.',
    `accumulated_operating_hours` DECIMAL(18,2) COMMENT 'Total operating hours logged by the equipment from acquisition through the valuation date. Used for units-of-production depreciation and lifecycle analysis.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or capitalized cost of the equipment asset at the time of acquisition, including delivery, installation, and commissioning costs.',
    `appraisal_report_number` STRING COMMENT 'Reference number of the external appraisal report document. Used to trace valuation back to supporting documentation.',
    `appraiser_name` STRING COMMENT 'Name of the professional appraiser or valuation firm that conducted the most recent independent valuation. Null if no external appraisal has been performed.',
    `asset_class` STRING COMMENT 'Financial accounting classification of the asset for reporting and tax purposes (e.g., heavy equipment, vehicles, tools, generators). Aligns with chart of accounts and fixed asset subledger structure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this valuation record was first created in the system.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Net book value of the asset as of the valuation date, calculated as acquisition cost minus accumulated depreciation. This is the carrying amount on the balance sheet.',
    `depreciation_method` STRING COMMENT 'The accounting method used to calculate periodic depreciation expense. Straight-line allocates cost evenly over useful life, reducing balance applies a fixed percentage to declining book value, units of production bases depreciation on actual usage hours.. Valid values are `straight_line|reducing_balance|units_of_production|sum_of_years_digits`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage, applicable for reducing balance and other rate-based depreciation methods. Null for straight-line method.',
    `disposal_date` DATE COMMENT 'Date when the asset was sold, scrapped, or otherwise disposed of. Null if the asset is still in service.',
    `disposal_method` STRING COMMENT 'The method by which the asset was disposed. Sale indicates sold to third party, trade-in exchanged for new equipment, scrap sold for parts/metal value, donation given to charity, write-off removed with no proceeds.. Valid values are `sale|trade_in|scrap|donation|write_off`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Actual amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal. Null if asset has not been disposed.',
    `fair_market_value` DECIMAL(18,2) COMMENT 'Current estimated market value of the asset if sold in an arms-length transaction. Used for insurance, disposal decisions, and rent-vs-buy analysis. May differ from book value.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether the asset shows signs of impairment (carrying amount exceeds recoverable amount). True triggers impairment testing per accounting standards.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Amount by which the carrying amount of the asset exceeds its recoverable amount. Recognized as an expense when impairment is identified. Null if no impairment.',
    `insurance_replacement_value` DECIMAL(18,2) COMMENT 'The cost to replace the asset with a new equivalent unit at current market prices. Used for insurance coverage determination and renewal valuations.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this valuation record.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this valuation record was last modified.',
    `next_revaluation_date` DATE COMMENT 'Scheduled date for the next periodic revaluation or impairment review. Used for fleet management planning and compliance with revaluation policies.',
    `ownership_type` STRING COMMENT 'Classification of asset ownership. Owned assets are capitalized and depreciated, leased assets may be capitalized under IFRS 16, rented assets are expensed and not valued here.. Valid values are `owned|leased|rented`',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining economic life of the asset in years from the valuation date. Used for fleet replacement planning and rent-vs-buy decisions.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated salvage or scrap value of the asset at the end of its useful life. The amount expected to be recovered through sale or disposal after full depreciation.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'The adjustment amount applied during the most recent revaluation. Positive values indicate upward revaluation, negative values indicate impairment. Null if no revaluation has occurred.',
    `revaluation_date` DATE COMMENT 'Date of the most recent revaluation event, if the asset has been revalued to fair market value. Null if no revaluation has occurred since acquisition.',
    `source_system_code` STRING COMMENT 'Unique identifier of this valuation record in the source system. Used for data lineage and reconciliation.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes, which may differ from book depreciation. MACRS (Modified Accelerated Cost Recovery System) is common in the US, Section 179 allows immediate expensing.. Valid values are `straight_line|declining_balance|macrs|section_179`',
    `tax_useful_life_years` DECIMAL(18,2) COMMENT 'Useful life in years for tax depreciation purposes, as defined by tax regulations. May differ from book useful life.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected economic life of the asset in years, used to calculate depreciation. Determined based on manufacturer specifications, industry standards, and organizational experience.',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this valuation record (acquisition cost, book value, depreciation, etc.).. Valid values are `^[A-Z]{3}$`',
    `valuation_date` DATE COMMENT 'The effective date of this valuation snapshot. Represents the point in time when this valuation is applicable.',
    `valuation_notes` STRING COMMENT 'Free-text field for additional context, assumptions, or special considerations affecting this valuation (e.g., major overhaul capitalized, damage affecting value, market conditions).',
    `valuation_number` STRING COMMENT 'Business identifier for the valuation record, typically system-generated or following organizational numbering convention.. Valid values are `^VAL-[0-9]{8}$`',
    `valuation_source` STRING COMMENT 'The source or method used to determine the current valuation. Acquisition uses original cost, appraisal uses third-party professional valuation, market index uses industry pricing data, insurance quote from carrier, internal estimate by equipment managers.. Valid values are `acquisition|appraisal|market_index|insurance_quote|internal_estimate`',
    `valuation_status` STRING COMMENT 'Current lifecycle status of the valuation record. Draft indicates preliminary valuation, active is current book value, superseded indicates replaced by newer valuation, archived for historical records.. Valid values are `draft|active|superseded|archived`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this valuation record.',
    CONSTRAINT pk_asset_valuation PRIMARY KEY(`asset_valuation_id`)
) COMMENT 'Master record tracking the financial valuation and depreciation profile of owned equipment assets over their lifecycle from an equipment management perspective. Captures acquisition cost, current book value, accumulated depreciation, depreciation method (straight-line, reducing balance), useful life (years), residual value, last revaluation date, revaluation amount, insurance replacement value, and disposal proceeds (if disposed). Serves equipment-domain decisions: fleet replacement planning, rent-vs-buy analysis, insurance renewal valuations, and asset disposal timing. Finance domain owns the authoritative GL entries and fixed asset subledger (SAP FI-AA) — this product provides the equipment managers operational view of asset value for fleet management decisions.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` (
    `insurance_policy_id` BIGINT COMMENT 'Unique identifier for the insurance policy record. Primary key for the insurance policy entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Equipment insurance policies are procured under contracts; linking allows compliance monitoring and claim tracking per agreement.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Insurance policy is issued for a specific asset; linking policy to asset captures ownership and removes need for policy number fields on asset.',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - equipment insurance policies are often project-scoped',
    `broker_name` STRING COMMENT 'The name of the insurance broker or intermediary who arranged the policy on behalf of the construction company. Nullable if policy was purchased directly.',
    `certificate_issue_date` DATE COMMENT 'The date when the Certificate of Insurance was issued. Nullable if certificate has not been issued. Format: yyyy-MM-dd.',
    `certificate_of_insurance_issued` BOOLEAN COMMENT 'Boolean flag indicating whether a Certificate of Insurance has been issued for this policy. COIs are required for equipment mobilization and regulatory compliance.',
    `claims_contact_email` STRING COMMENT 'The email address for submitting claims documentation and correspondence with the claims adjuster.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `claims_contact_name` STRING COMMENT 'The name of the claims adjuster or contact person at the insurer for reporting and processing claims under this policy.',
    `claims_contact_phone` STRING COMMENT 'The phone number to reach the claims contact for reporting incidents and tracking claim status.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting specific regulatory requirements met by this policy, any compliance gaps, or special conditions required by clients or governing bodies.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The maximum monetary amount the insurer will pay for covered losses under this policy. This is the policy limit or sum insured.',
    `coverage_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the coverage amount and premium (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `coverage_scope` STRING COMMENT 'Detailed description of what assets, risks, and perils are covered under this policy. Includes covered equipment types, geographic scope, and specific inclusions or exclusions.',
    `covered_asset_category` STRING COMMENT 'The category of construction equipment and assets covered by this policy. Heavy equipment includes cranes and excavators, light equipment includes smaller machinery, fleet vehicles includes trucks and cars, tools includes hand and power tools, generators includes power generation equipment, and all equipment covers comprehensive asset types.. Valid values are `heavy_equipment|light_equipment|fleet_vehicles|tools|generators|all_equipment`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance policy record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The amount the policyholder must pay out-of-pocket before the insurer pays a claim. This is the self-insured retention or excess.',
    `geographic_coverage` STRING COMMENT 'The geographic regions or territories where the insurance coverage is valid. May specify countries, states, or project sites where equipment is covered.',
    `insurer_contact_email` STRING COMMENT 'The email address of the insurer contact for policy correspondence, claims submission, and documentation exchange.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `insurer_contact_name` STRING COMMENT 'The name of the primary contact person or account manager at the insurance company for policy administration and claims.',
    `insurer_contact_phone` STRING COMMENT 'The primary phone number to reach the insurer contact for policy inquiries, claims reporting, and emergency notifications.',
    `insurer_name` STRING COMMENT 'The legal name of the insurance company or underwriter providing the coverage. This is the carrier responsible for claims payment.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this insurance policy record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this insurance policy record was last modified in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ownership_classification` STRING COMMENT 'Specifies whether this policy covers only company-owned equipment, only rented equipment, or both owned and rented assets.. Valid values are `owned_only|rented_only|both_owned_and_rented`',
    `policy_document_reference` STRING COMMENT 'Reference identifier or file path to the full policy document, terms and conditions, and endorsements stored in the document management system.',
    `policy_end_date` DATE COMMENT 'The date when the insurance policy coverage expires or terminates. Nullable for open-ended policies. Format: yyyy-MM-dd.',
    `policy_notes` STRING COMMENT 'General free-text notes about the policy including special terms, exclusions, endorsements, or internal administrative information.',
    `policy_number` STRING COMMENT 'Externally-known unique policy number issued by the insurer. This is the business identifier used in all correspondence and claims.. Valid values are `^[A-Z0-9]{8,20}$`',
    `policy_start_date` DATE COMMENT 'The date when the insurance policy coverage becomes effective and binding. Format: yyyy-MM-dd.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the insurance policy. Active policies provide coverage, pending policies are awaiting approval, expired policies have passed their end date, cancelled policies were terminated early, suspended policies are temporarily inactive, and renewed policies have been extended.. Valid values are `active|pending|expired|cancelled|suspended|renewed`',
    `policy_type` STRING COMMENT 'Classification of the insurance policy coverage type. All-risk plant covers comprehensive equipment damage, third-party liability covers legal claims, fleet motor covers vehicle insurance, marine transit covers equipment in transport, builders risk covers construction projects, and equipment breakdown covers mechanical failure.. Valid values are `all_risk_plant|third_party_liability|fleet_motor|marine_transit|builders_risk|equipment_breakdown`',
    `premium_amount` DECIMAL(18,2) COMMENT 'The total premium cost paid to the insurer for this policy coverage period. This is the price of the insurance.',
    `premium_payment_frequency` STRING COMMENT 'The frequency at which premium payments are made to the insurer (annual, semi-annual, quarterly, monthly, or one-time lump sum).. Valid values are `annual|semi_annual|quarterly|monthly|one_time`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this policy meets all regulatory and contractual insurance requirements for equipment operation and mobilization.',
    `renewal_notice_date` DATE COMMENT 'The date by which the policyholder must notify the insurer of intent to renew or cancel. Critical for mobilization planning and compliance. Format: yyyy-MM-dd.',
    `renewal_status` STRING COMMENT 'Indicates whether the policy will automatically renew at expiration, requires manual renewal action, is non-renewable, or is currently under renewal review.. Valid values are `auto_renew|manual_renew|non_renewable|under_review`',
    `source_system_code` STRING COMMENT 'The unique identifier of this insurance policy record in the source operational system, used for data lineage and reconciliation.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this insurance policy record in the system.',
    CONSTRAINT pk_insurance_policy PRIMARY KEY(`insurance_policy_id`)
) COMMENT 'Master record of insurance policies covering owned and rented construction equipment and fleet vehicles. Captures insurer name, policy number, policy type (all-risk plant, third-party liability, fleet motor, marine transit), coverage amount, premium amount, policy start and end dates, deductible amount, covered asset scope, and renewal status. Supports risk management, mobilization pre-checks, and regulatory compliance. Owned by equipment domain as it directly governs asset coverage — distinct from corporate insurance managed by finance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` (
    `asset_activity_assignment_id` BIGINT COMMENT 'Primary key for the AssetActivityAssignment association',
    `activity_id` BIGINT COMMENT 'Foreign key linking to the schedule activity',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the equipment asset',
    `construction_project_id` BIGINT COMMENT '',
    `hr_employee_id` BIGINT COMMENT 'add column hr_employee_id (BIGINT) with FK to hr.hr.employee_id - assignments need a responsible owner/operator',
    `wbs_element_id` BIGINT COMMENT 'add column wbs_element_id (BIGINT) with FK to project.wbs_element.wbs_element_id - asset activity assignments roll up to WBS',
    `actual_hours` DECIMAL(18,2) COMMENT '',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Quantity of the asset actually used in the activity',
    `assigned_date` DATE COMMENT '',
    `assignment_end` DATE COMMENT '',
    `assignment_start` DATE COMMENT '',
    `assignment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `finish_date` DATE COMMENT 'Planned finish date of the asset assignment for the activity',
    `hourly_rate` DECIMAL(18,2) COMMENT '',
    `operator_name` STRING COMMENT '',
    `planned_hours` DECIMAL(18,2) COMMENT '',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of the asset planned for the activity',
    `released_date` DATE COMMENT '',
    `remarks` STRING COMMENT '',
    `resource_role` STRING COMMENT 'Role of the asset in the activity (e.g., primary, support, auxiliary)',
    `responsible_operator` STRING COMMENT '',
    `start_date` DATE COMMENT 'Planned start date of the asset assignment for the activity',
    `total_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `utilization_pct` DECIMAL(18,2) COMMENT '',
    `utilization_percent` DECIMAL(18,2) COMMENT '',
    `utilization_rate` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_asset_activity_assignment PRIMARY KEY(`asset_activity_assignment_id`)
) COMMENT 'Represents the assignment of construction equipment assets to schedule activities. Each record links one asset to one activity and stores assignment‑specific data such as quantities, dates, and the role of the asset in the activity.. Existence Justification: Construction projects assign multiple equipment assets to a single schedule activity, and each asset can be scheduled for multiple activities over its lifecycle. The assignment is actively managed by planners and includes quantities, dates, and role information, making the relationship a distinct business entity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`fuel_point` (
    `fuel_point_id` BIGINT COMMENT 'Primary key for fuel_point',
    `parent_fuel_point_id` BIGINT COMMENT 'Self-referencing FK on fuel_point (parent_fuel_point_id)',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to site.site.site_id - fuel points are physically located at sites',
    `address` STRING COMMENT 'Street address of the fuel point installation.',
    `capacity_liters` DECIMAL(18,2) COMMENT 'Maximum fuel volume the point can hold, expressed in liters.',
    `city` STRING COMMENT 'City where the fuel point is located.',
    `fuel_point_code` STRING COMMENT 'External code or tag used to reference the fuel point in operational systems.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the fuel point location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel point record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the fuel price.',
    `current_level_liters` DECIMAL(18,2) COMMENT 'Current amount of fuel present at the point, in liters.',
    `fuel_point_description` STRING COMMENT 'Free‑form text describing the fuel point, its purpose, or special notes.',
    `fuel_point_status` STRING COMMENT 'Current operational status of the fuel point.',
    `fuel_point_type` STRING COMMENT 'Category of fuel dispensed or stored at the point.',
    `fuel_price_per_liter` DECIMAL(18,2) COMMENT 'Current price of fuel at this point, expressed per liter.',
    `fuel_quality_rating` STRING COMMENT 'Internal rating of fuel quality at this point.',
    `installation_date` DATE COMMENT 'Date the fuel point was installed and became operational.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary fuel point for its site or fleet.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the fuel point (decimal degrees).',
    `location_name` STRING COMMENT 'Descriptive name of the physical location where the fuel point is installed.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the fuel point (decimal degrees).',
    `fuel_point_name` STRING COMMENT 'Human‑readable name of the fuel point location or asset.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `operational_status` STRING COMMENT 'Current real‑time operational condition of the fuel point.',
    `safety_certification_date` DATE COMMENT 'Date the fuel point received its most recent safety certification.',
    `safety_certification_expiry` DATE COMMENT 'Expiration date of the current safety certification.',
    `state` STRING COMMENT 'State or province of the fuel point location.',
    `supplier_contact` STRING COMMENT 'Contact information (phone or email) for the fuel supplier.',
    `supplier_name` STRING COMMENT 'Name of the external supplier providing fuel to this point.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fuel point record.',
    `zip_code` STRING COMMENT 'Postal (ZIP) code for the fuel point address.',
    CONSTRAINT pk_fuel_point PRIMARY KEY(`fuel_point_id`)
) COMMENT 'Master reference table for fuel_point. Referenced by fuel_point_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`equipment`.`functional_location` (
    `functional_location_id` BIGINT COMMENT 'Primary key for functional_location',
    `parent_functional_location_id` BIGINT COMMENT 'Self-referencing FK on functional_location (parent_functional_location_id)',
    `parent_location_id` BIGINT COMMENT 'Identifier of the immediate parent location in the hierarchy, if any.',
    `site_id` BIGINT COMMENT 'add column site_id (BIGINT) with FK to site.site.site_id - functional locations live within a site',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Physical footprint of the location in square meters.',
    `asset_count` STRING COMMENT 'Number of equipment assets assigned to this location.',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Maximum load capacity the location can support, expressed in metric tons.',
    `city` STRING COMMENT 'City where the location is situated.',
    `functional_location_code` STRING COMMENT 'Enterprise‑wide unique alphanumeric code used to reference the location in SAP PM and HCSS HeavyJob.',
    `commissioning_date` DATE COMMENT 'Date the location was officially commissioned for use.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the location resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the functional location record was first created in the lakehouse.',
    `decommission_date` DATE COMMENT 'Date the location was retired or taken out of service, if applicable.',
    `functional_location_description` STRING COMMENT 'Free‑form description providing additional context about the location.',
    `environmental_zone` STRING COMMENT 'Designation of the environmental zone (e.g., hazardous, clean, temperature‑controlled).',
    `functional_location_status` STRING COMMENT 'Current operational status of the location.',
    `functional_location_type` STRING COMMENT 'Category of the location within the equipment hierarchy.',
    `gps_accuracy_m` DOUBLE COMMENT 'Estimated accuracy of the GPS coordinates in meters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `installation_date` DATE COMMENT 'Date the location was first installed or made operational.',
    `is_owned` BOOLEAN COMMENT 'Indicates whether the location is owned by the enterprise (true) or not (false).',
    `is_rental` BOOLEAN COMMENT 'Indicates whether the location is leased/rented (true) or owned (false).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the location in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the location in decimal degrees.',
    `functional_location_name` STRING COMMENT 'Human‑readable name of the location (e.g., Main Plant, Building A).',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the location.',
    `responsible_department` STRING COMMENT 'Organizational department accountable for the locations operation and maintenance.',
    `safety_rating` STRING COMMENT 'Safety classification of the location based on internal risk assessments.',
    `state` STRING COMMENT 'State or province of the location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the functional location record.',
    CONSTRAINT pk_functional_location PRIMARY KEY(`functional_location_id`)
) COMMENT 'Master reference table for functional_location. Referenced by functional_location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_parent_category_asset_category_id` FOREIGN KEY (`parent_category_asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `vibe_construction_v1`.`equipment`.`functional_location`(`functional_location_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `vibe_construction_v1`.`equipment`.`functional_location`(`functional_location_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ADD CONSTRAINT `fk_equipment_maintenance_notification_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ADD CONSTRAINT `fk_equipment_equipment_mobilization_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_fuel_point_id` FOREIGN KEY (`fuel_point_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fuel_point`(`fuel_point_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ADD CONSTRAINT `fk_equipment_operator_certification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ADD CONSTRAINT `fk_equipment_asset_valuation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ADD CONSTRAINT `fk_equipment_insurance_policy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ADD CONSTRAINT `fk_equipment_asset_activity_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ADD CONSTRAINT `fk_equipment_fuel_point_parent_fuel_point_id` FOREIGN KEY (`parent_fuel_point_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fuel_point`(`fuel_point_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ADD CONSTRAINT `fk_equipment_functional_location_parent_functional_location_id` FOREIGN KEY (`parent_functional_location_id`) REFERENCES `vibe_construction_v1`.`equipment`.`functional_location`(`functional_location_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ADD CONSTRAINT `fk_equipment_functional_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `vibe_construction_v1`.`equipment`.`functional_location`(`functional_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`equipment` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`equipment` SET TAGS ('pii_domain' = 'equipment');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_category_id` SET TAGS ('pii_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_current_location_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Current Location Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `obligation_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Calendar Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Owner Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Fuel Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Operator Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('pii_business_glossary_term' = 'Acquisition Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('pii_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `asset_status` SET TAGS ('pii_business_glossary_term' = 'Asset Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_rating` SET TAGS ('pii_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('pii_value_regex' = 'tons|cubic_yards|cubic_meters|kilowatts|gallons_per_minute|pounds');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Asset Classification');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('pii_business_glossary_term' = 'Current Book Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `current_book_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_approver_name` SET TAGS ('pii_business_glossary_term' = 'Disposal Approver Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('pii_business_glossary_term' = 'Disposal Buyer Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_buyer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'sale|auction|scrap|write_off|trade_in|donation');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('pii_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `disposal_reason` SET TAGS ('pii_business_glossary_term' = 'Disposal Reason');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `emissions_tier` SET TAGS ('pii_business_glossary_term' = 'Emissions Tier');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `hcss_heavyjob_asset_code` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Asset ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `home_yard_location` SET TAGS ('pii_business_glossary_term' = 'Home Yard Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_meter_reading_date` SET TAGS ('pii_business_glossary_term' = 'Last Meter Reading Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('pii_business_glossary_term' = 'Asset Lifecycle Stage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `lifecycle_stage` SET TAGS ('pii_value_regex' = 'commissioning|operational|aging|end_of_life|disposed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `make` SET TAGS ('pii_business_glossary_term' = 'Equipment Make');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `model` SET TAGS ('pii_business_glossary_term' = 'Equipment Model');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `next_inspection_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `operating_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Operating Weight (Kilograms)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'owned|rented|leased|operator_owned');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `regulatory_compliance_class` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Class');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('pii_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `sap_pm_equipment_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('pii_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `tag_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `total_operating_hours` SET TAGS ('pii_business_glossary_term' = 'Total Operating Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ALTER COLUMN `year_of_manufacture` SET TAGS ('pii_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_id` SET TAGS ('pii_business_glossary_term' = 'Asset Category ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `parent_category_asset_category_id` SET TAGS ('pii_business_glossary_term' = 'Parent Asset Category ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('pii_business_glossary_term' = 'Asset Category Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_category_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('pii_business_glossary_term' = 'SAP Asset Class');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `asset_class_sap` SET TAGS ('pii_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `benchmark_utilization_rate` SET TAGS ('pii_business_glossary_term' = 'Benchmark Utilization Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `capitalization_threshold` SET TAGS ('pii_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('pii_business_glossary_term' = 'Asset Category Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_description` SET TAGS ('pii_business_glossary_term' = 'Asset Category Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_level` SET TAGS ('pii_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_name` SET TAGS ('pii_business_glossary_term' = 'Asset Category Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('pii_business_glossary_term' = 'Asset Category Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `category_type` SET TAGS ('pii_value_regex' = 'major|sub|class|specialty');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `gl_account_code` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `hcss_equipment_type` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Equipment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `inspection_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `insurance_required` SET TAGS ('pii_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('pii_business_glossary_term' = 'Maintenance Strategy Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `mobilization_required` SET TAGS ('pii_business_glossary_term' = 'Mobilization Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `modified_by_user` SET TAGS ('pii_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `operator_certification_required` SET TAGS ('pii_business_glossary_term' = 'Operator Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('pii_business_glossary_term' = 'Ownership Classification');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `ownership_classification` SET TAGS ('pii_value_regex' = 'owned|rented|leased|mixed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `sort_order` SET TAGS ('pii_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ALTER COLUMN `utilization_tracking_required` SET TAGS ('pii_business_glossary_term' = 'Utilization Tracking Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Fleet Assignment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Rental Vendor ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `work_front_id` SET TAGS ('pii_business_glossary_term' = 'Work Front ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `actual_utilization_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Utilization Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('pii_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('pii_business_glossary_term' = 'Fleet Assignment Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_number` SET TAGS ('pii_value_regex' = '^FA-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('pii_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_purpose` SET TAGS ('pii_business_glossary_term' = 'Assignment Purpose');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_value_regex' = 'owned|rental|lease|subcontractor_supplied|client_supplied');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `cost_allocation_code` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('pii_business_glossary_term' = 'Daily Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `daily_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('pii_business_glossary_term' = 'Demobilization Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `idle_hours` SET TAGS ('pii_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('pii_business_glossary_term' = 'Mobilization Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'not_started|in_transit|on_site|demobilized');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'Operating Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `operating_rate_per_hour` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'Ownership Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `ownership_rate_per_hour` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `planned_utilization_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Utilization Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('pii_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `rate_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `rental_contract_number` SET TAGS ('pii_business_glossary_term' = 'Rental Contract Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('pii_business_glossary_term' = 'Standby Rate Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `standby_rate_per_hour` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('pii_business_glossary_term' = 'Weekly Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `weekly_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `hours_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Hours ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|disputed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('pii_business_glossary_term' = 'Cost Per Hour');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `cost_per_hour` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('pii_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_category` SET TAGS ('pii_value_regex' = 'breakdown|awaiting_parts|awaiting_operator|weather_hold|scheduled_maintenance|unscheduled_repair');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Downtime Impact Assessment');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_impact_assessment` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_resolution_action` SET TAGS ('pii_business_glossary_term' = 'Downtime Resolution Action');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('pii_business_glossary_term' = 'Downtime Root Cause Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_root_cause_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `equipment_availability_rate` SET TAGS ('pii_business_glossary_term' = 'Equipment Availability Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `equipment_utilization_rate` SET TAGS ('pii_business_glossary_term' = 'Equipment Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `fuel_consumption_liters` SET TAGS ('pii_business_glossary_term' = 'Fuel Consumption Liters');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `idle_hours` SET TAGS ('pii_business_glossary_term' = 'Idle Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `is_billable` SET TAGS ('pii_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `is_overtime` SET TAGS ('pii_business_glossary_term' = 'Is Overtime');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `meter_reading_end` SET TAGS ('pii_business_glossary_term' = 'Meter Reading End');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `meter_reading_start` SET TAGS ('pii_business_glossary_term' = 'Meter Reading Start');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `operating_hours` SET TAGS ('pii_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'owned|rented|leased|subcontractor_supplied');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `production_quantity` SET TAGS ('pii_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `production_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `record_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `rental_invoice_reference` SET TAGS ('pii_business_glossary_term' = 'Rental Invoice Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `rental_invoice_reference` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_date` SET TAGS ('pii_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|weekend|holiday|emergency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `source_record_reference` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `standby_hours` SET TAGS ('pii_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('pii_business_glossary_term' = 'Total Equipment Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `total_equipment_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Team ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `certification_required_flag` SET TAGS ('pii_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `compliance_requirement_code` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirement Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `downtime_required_flag` SET TAGS ('pii_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `environmental_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_unit` SET TAGS ('pii_business_glossary_term' = 'Maintenance Interval Unit');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `interval_value` SET TAGS ('pii_business_glossary_term' = 'Maintenance Interval Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `last_execution_date` SET TAGS ('pii_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `manufacturer_recommendation_flag` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Recommendation Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `next_scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `parts_list_reference` SET TAGS ('pii_business_glossary_term' = 'Parts List Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|inactive|archived');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'time_based|meter_based|condition_based|predictive|statutory');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('pii_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `priority_level` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `safety_critical_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('pii_business_glossary_term' = 'Scheduling Strategy');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `scheduling_strategy` SET TAGS ('pii_value_regex' = 'fixed_schedule|floating_schedule|on_demand');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('pii_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `site_location_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('pii_business_glossary_term' = 'Task List Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('pii_value_regex' = '^TL[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_after_days` SET TAGS ('pii_business_glossary_term' = 'Tolerance After Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `tolerance_before_days` SET TAGS ('pii_business_glossary_term' = 'Tolerance Before Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `warranty_impact_flag` SET TAGS ('pii_business_glossary_term' = 'Warranty Impact Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('pii_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('pii_value_regex' = 'preventive|inspection|calibration|overhaul|statutory');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Subcontractor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `maintenance_plan_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_last_modified_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_last_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `tertiary_maintenance_last_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `closed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `compliance_inspection_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Inspection Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Equipment Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('pii_business_glossary_term' = 'External Services Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `external_services_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `failure_code` SET TAGS ('pii_business_glossary_term' = 'Failure Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `failure_description` SET TAGS ('pii_business_glossary_term' = 'Failure Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `inspection_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('pii_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `labor_hours` SET TAGS ('pii_business_glossary_term' = 'Labor Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `meter_reading_at_maintenance` SET TAGS ('pii_business_glossary_term' = 'Meter Reading at Maintenance');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `next_inspection_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `notification_id` SET TAGS ('pii_business_glossary_term' = 'Notification ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `order_type` SET TAGS ('pii_value_regex' = 'preventive|corrective|breakdown|statutory_inspection|calibration|overhaul');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('pii_business_glossary_term' = 'Parts Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `parts_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `planned_end_date` SET TAGS ('pii_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `site_location_code` SET TAGS ('pii_business_glossary_term' = 'Site Location Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('pii_business_glossary_term' = 'Total Maintenance Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `total_maintenance_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('pii_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `warranty_claim_number` SET TAGS ('pii_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `work_center_code` SET TAGS ('pii_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ALTER COLUMN `work_performed_description` SET TAGS ('pii_business_glossary_term' = 'Work Performed Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `maintenance_notification_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Notification ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `functional_location_id` SET TAGS ('pii_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `maintenance_order_id` SET TAGS ('pii_business_glossary_term' = 'Maintenance Order ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `actual_downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `breakdown_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Breakdown End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `breakdown_indicator` SET TAGS ('pii_business_glossary_term' = 'Breakdown Indicator');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `breakdown_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Breakdown Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `catalog_profile` SET TAGS ('pii_business_glossary_term' = 'Catalog Profile');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `catalog_profile` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `cause_text` SET TAGS ('pii_business_glossary_term' = 'Cause Text');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `damage_code` SET TAGS ('pii_business_glossary_term' = 'Damage Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `damage_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `detection_method` SET TAGS ('pii_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `detection_method` SET TAGS ('pii_value_regex' = 'operator_observation|routine_inspection|condition_monitoring|breakdown|safety_audit');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `effect_text` SET TAGS ('pii_business_glossary_term' = 'Effect Text');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `equipment_location_at_fault` SET TAGS ('pii_business_glossary_term' = 'Equipment Location at Fault');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `fault_code` SET TAGS ('pii_business_glossary_term' = 'Fault Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `fault_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `fault_description` SET TAGS ('pii_business_glossary_term' = 'Fault Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `main_work_center` SET TAGS ('pii_business_glossary_term' = 'Main Work Center');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `main_work_center` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_number` SET TAGS ('pii_business_glossary_term' = 'Notification Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_origin` SET TAGS ('pii_business_glossary_term' = 'Notification Origin');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_origin` SET TAGS ('pii_value_regex' = 'field_report|preventive_maintenance|condition_monitoring|safety_inspection|operator_logbook');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_status` SET TAGS ('pii_business_glossary_term' = 'Notification Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_status` SET TAGS ('pii_value_regex' = 'outstanding|in_progress|completed|cancelled|deferred');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_business_glossary_term' = 'Notification Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `notification_type` SET TAGS ('pii_value_regex' = 'malfunction|breakdown|damage|activity_request|preventive_observation|safety_defect');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `object_part_code` SET TAGS ('pii_business_glossary_term' = 'Object Part Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `object_part_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `planner_group` SET TAGS ('pii_business_glossary_term' = 'Planner Group');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `planner_group` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `reported_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `required_end_date` SET TAGS ('pii_business_glossary_term' = 'Required End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `required_start_date` SET TAGS ('pii_business_glossary_term' = 'Required Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `safety_related_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Related Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `system_condition` SET TAGS ('pii_business_glossary_term' = 'System Condition');
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_notification` ALTER COLUMN `system_condition` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_record_id` SET TAGS ('pii_business_glossary_term' = 'Inspection Record ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Inspector Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_document_reference` SET TAGS ('pii_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issued_flag` SET TAGS ('pii_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Certificate Issuing Authority');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `certificate_type` SET TAGS ('pii_business_glossary_term' = 'Certificate Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `corrective_actions_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `defects_description` SET TAGS ('pii_business_glossary_term' = 'Defects Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `defects_identified_count` SET TAGS ('pii_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `equipment_hours_at_inspection` SET TAGS ('pii_business_glossary_term' = 'Equipment Hours at Inspection');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_checklist_reference` SET TAGS ('pii_business_glossary_term' = 'Inspection Checklist Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('pii_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost_currency` SET TAGS ('pii_business_glossary_term' = 'Inspection Cost Currency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_cost_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_date` SET TAGS ('pii_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_frequency_days` SET TAGS ('pii_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_location` SET TAGS ('pii_business_glossary_term' = 'Inspection Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_notes` SET TAGS ('pii_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_number` SET TAGS ('pii_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('pii_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_outcome` SET TAGS ('pii_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_scope` SET TAGS ('pii_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `inspection_type` SET TAGS ('pii_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `next_inspection_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Rental Agreement ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `actual_demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Actual Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `actual_mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Actual Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('pii_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|milestone');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('pii_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `daily_hire_rate` SET TAGS ('pii_business_glossary_term' = 'Daily Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `damage_waiver_amount` SET TAGS ('pii_business_glossary_term' = 'Damage Waiver Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `demobilization_charge` SET TAGS ('pii_business_glossary_term' = 'Demobilization Charge');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_description` SET TAGS ('pii_business_glossary_term' = 'Equipment Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `equipment_type` SET TAGS ('pii_business_glossary_term' = 'Equipment Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `fuel_included_flag` SET TAGS ('pii_business_glossary_term' = 'Fuel Included Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `insurance_requirement` SET TAGS ('pii_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `late_return_penalty_rate` SET TAGS ('pii_business_glossary_term' = 'Late Return Penalty Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('pii_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `maintenance_responsibility` SET TAGS ('pii_value_regex' = 'supplier|contractor|shared');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `minimum_hire_period_days` SET TAGS ('pii_business_glossary_term' = 'Minimum Hire Period (Days)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `mobilization_charge` SET TAGS ('pii_business_glossary_term' = 'Mobilization Charge');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `monthly_hire_rate` SET TAGS ('pii_business_glossary_term' = 'Monthly Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Rental Agreement Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `operator_supplied_flag` SET TAGS ('pii_business_glossary_term' = 'Operator Supplied Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('pii_business_glossary_term' = 'Rental Agreement Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_agreement_number` SET TAGS ('pii_value_regex' = '^RA-[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_end_date` SET TAGS ('pii_business_glossary_term' = 'Rental End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('pii_business_glossary_term' = 'Rental Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_po_number` SET TAGS ('pii_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_start_date` SET TAGS ('pii_business_glossary_term' = 'Rental Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `rental_status` SET TAGS ('pii_business_glossary_term' = 'Rental Agreement Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `security_deposit_amount` SET TAGS ('pii_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `site_location` SET TAGS ('pii_business_glossary_term' = 'Site Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `total_committed_cost` SET TAGS ('pii_business_glossary_term' = 'Total Committed Rental Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `wbs_element_code` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ALTER COLUMN `weekly_hire_rate` SET TAGS ('pii_business_glossary_term' = 'Weekly Hire Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `equipment_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Mobilization ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Dispatch Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Transport Contractor ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_arrival_date` SET TAGS ('pii_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_dispatch_date` SET TAGS ('pii_business_glossary_term' = 'Actual Dispatch Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `actual_transit_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Transit Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `cost_allocation_code` SET TAGS ('pii_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `destination_location` SET TAGS ('pii_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `destination_site_code` SET TAGS ('pii_business_glossary_term' = 'Destination Site Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition` SET TAGS ('pii_business_glossary_term' = 'Dispatch Condition');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition` SET TAGS ('pii_value_regex' = 'excellent|good|fair|poor|requires_repair');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_condition_notes` SET TAGS ('pii_business_glossary_term' = 'Dispatch Condition Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `dispatch_signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Dispatch Signature Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `distance_km` SET TAGS ('pii_business_glossary_term' = 'Distance (Kilometers)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `estimated_transit_hours` SET TAGS ('pii_business_glossary_term' = 'Estimated Transit Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'mobilization|demobilization|inter_site_transfer|relocation');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `insurance_policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_value_regex' = '^MOB-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'planned|in_transit|completed|cancelled|delayed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `origin_location` SET TAGS ('pii_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `origin_site_code` SET TAGS ('pii_business_glossary_term' = 'Origin Site Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `permit_required_flag` SET TAGS ('pii_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `permit_type` SET TAGS ('pii_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `planned_arrival_date` SET TAGS ('pii_business_glossary_term' = 'Planned Arrival Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `planned_dispatch_date` SET TAGS ('pii_business_glossary_term' = 'Planned Dispatch Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `reason` SET TAGS ('pii_business_glossary_term' = 'Mobilization Reason');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition` SET TAGS ('pii_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition` SET TAGS ('pii_value_regex' = 'excellent|good|fair|poor|damaged_in_transit');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_condition_notes` SET TAGS ('pii_business_glossary_term' = 'Receipt Condition Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_signature_timestamp` SET TAGS ('pii_business_glossary_term' = 'Receipt Signature Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `receipt_signed_by` SET TAGS ('pii_business_glossary_term' = 'Receipt Signed By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_cost` SET TAGS ('pii_business_glossary_term' = 'Transport Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_currency_code` SET TAGS ('pii_business_glossary_term' = 'Transport Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_method` SET TAGS ('pii_business_glossary_term' = 'Transport Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`equipment_mobilization` ALTER COLUMN `transport_method` SET TAGS ('pii_value_regex' = 'flatbed_truck|lowboy_trailer|self_propelled|rail|barge|air_freight');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_subdomain' = 'maintenance_service');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_transaction_id` SET TAGS ('pii_business_glossary_term' = 'Fuel Transaction ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Fuel Subcontractor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_point_id` SET TAGS ('pii_business_glossary_term' = 'Fuel Point ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `master_id` SET TAGS ('pii_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'approved|pending_approval|rejected|auto_approved');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `carbon_emission_kg` SET TAGS ('pii_business_glossary_term' = 'Carbon Emission (kg CO2)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('pii_business_glossary_term' = 'Fuel Card Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `fuel_card_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `hour_meter_reading` SET TAGS ('pii_business_glossary_term' = 'Hour Meter Reading');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `invoice_number` SET TAGS ('pii_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `is_emergency_refuel` SET TAGS ('pii_business_glossary_term' = 'Is Emergency Refuel');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `is_theft_suspected` SET TAGS ('pii_business_glossary_term' = 'Is Theft Suspected');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `odometer_reading` SET TAGS ('pii_business_glossary_term' = 'Odometer Reading');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `operator_name` SET TAGS ('pii_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `operator_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `operator_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `quantity_issued` SET TAGS ('pii_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `tank_capacity_percentage` SET TAGS ('pii_business_glossary_term' = 'Tank Capacity Percentage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_notes` SET TAGS ('pii_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_number` SET TAGS ('pii_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_status` SET TAGS ('pii_value_regex' = 'completed|pending|cancelled|disputed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_value_regex' = 'litres|gallons|kwh');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `operator_certification_id` SET TAGS ('pii_business_glossary_term' = 'Operator Certification Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `asset_category_id` SET TAGS ('pii_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Attachment Document Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `capacity_rating` SET TAGS ('pii_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certification_level` SET TAGS ('pii_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certification_status` SET TAGS ('pii_value_regex' = 'valid|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_value_regex' = 'operator_license|competency_card|safety_certification|manufacturer_certification|trade_qualification|endorsement');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certifying_body` SET TAGS ('pii_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `certifying_body_accreditation_number` SET TAGS ('pii_business_glossary_term' = 'Certifying Body Accreditation Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `endorsements` SET TAGS ('pii_business_glossary_term' = 'Endorsements');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('pii_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('pii_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('pii_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('pii_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Medical Clearance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('pii_business_glossary_term' = 'Medical Clearance Required Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `medical_clearance_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `practical_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Practical Assessment Score');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `reciprocity_agreements` SET TAGS ('pii_business_glossary_term' = 'Reciprocity Agreements');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `renewal_requirement` SET TAGS ('pii_business_glossary_term' = 'Renewal Requirement');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `restrictions` SET TAGS ('pii_business_glossary_term' = 'Restrictions');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `sponsor_organization` SET TAGS ('pii_business_glossary_term' = 'Sponsor Organization');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `theory_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Theory Assessment Score');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `training_hours_completed` SET TAGS ('pii_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`operator_certification` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `telematics_reading_id` SET TAGS ('pii_business_glossary_term' = 'Telematics Reading ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `site_id` SET TAGS ('pii_business_glossary_term' = 'Site ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `battery_voltage` SET TAGS ('pii_business_glossary_term' = 'Battery Voltage');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `coolant_temperature_c` SET TAGS ('pii_business_glossary_term' = 'Coolant Temperature (Celsius)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `data_source` SET TAGS ('pii_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `elevation_m` SET TAGS ('pii_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `engine_hours` SET TAGS ('pii_business_glossary_term' = 'Engine Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `engine_rpm` SET TAGS ('pii_business_glossary_term' = 'Engine RPM (Revolutions Per Minute)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fault_code` SET TAGS ('pii_business_glossary_term' = 'Fault Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fault_description` SET TAGS ('pii_business_glossary_term' = 'Fault Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fault_severity` SET TAGS ('pii_business_glossary_term' = 'Fault Severity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fault_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fuel_consumed_liters` SET TAGS ('pii_business_glossary_term' = 'Fuel Consumed (Liters)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `fuel_level_percent` SET TAGS ('pii_business_glossary_term' = 'Fuel Level (Percent)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `geofence_code` SET TAGS ('pii_business_glossary_term' = 'Geofence ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `geofence_status` SET TAGS ('pii_business_glossary_term' = 'Geofence Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `geofence_status` SET TAGS ('pii_value_regex' = 'inside|outside|entering|exiting|unknown');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `gps_accuracy_m` SET TAGS ('pii_business_glossary_term' = 'GPS (Global Positioning System) Accuracy (Meters)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `hydraulic_pressure_bar` SET TAGS ('pii_business_glossary_term' = 'Hydraulic Pressure (Bar)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `idle_time_minutes` SET TAGS ('pii_business_glossary_term' = 'Idle Time (Minutes)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `ingestion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `odometer_km` SET TAGS ('pii_business_glossary_term' = 'Odometer (Kilometers)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `operational_state` SET TAGS ('pii_business_glossary_term' = 'Operational State');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `operational_state` SET TAGS ('pii_value_regex' = 'operating|idle|off|maintenance|fault|unknown');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `payload_weight_kg` SET TAGS ('pii_business_glossary_term' = 'Payload Weight (Kilograms)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `reading_quality` SET TAGS ('pii_business_glossary_term' = 'Reading Quality');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `reading_quality` SET TAGS ('pii_value_regex' = 'valid|suspect|invalid|estimated');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `speed_kmh` SET TAGS ('pii_business_glossary_term' = 'Speed (Kilometers Per Hour)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `telematics_device_code` SET TAGS ('pii_business_glossary_term' = 'Telematics Device ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `telematics_device_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `telematics_device_code` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`telematics_reading` ALTER COLUMN `transmission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `asset_valuation_id` SET TAGS ('pii_business_glossary_term' = 'Asset Valuation ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('pii_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `accumulated_operating_hours` SET TAGS ('pii_business_glossary_term' = 'Accumulated Operating Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `acquisition_cost` SET TAGS ('pii_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `appraisal_report_number` SET TAGS ('pii_business_glossary_term' = 'Appraisal Report Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `appraiser_name` SET TAGS ('pii_business_glossary_term' = 'Appraiser Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `asset_class` SET TAGS ('pii_business_glossary_term' = 'Asset Class');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `current_book_value` SET TAGS ('pii_business_glossary_term' = 'Current Book Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|reducing_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('pii_business_glossary_term' = 'Depreciation Rate Percent');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'sale|trade_in|scrap|donation|write_off');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `disposal_proceeds` SET TAGS ('pii_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `fair_market_value` SET TAGS ('pii_business_glossary_term' = 'Fair Market Value (FMV)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `impairment_indicator` SET TAGS ('pii_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `impairment_loss` SET TAGS ('pii_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `insurance_replacement_value` SET TAGS ('pii_business_glossary_term' = 'Insurance Replacement Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `next_revaluation_date` SET TAGS ('pii_business_glossary_term' = 'Next Revaluation Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `ownership_type` SET TAGS ('pii_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `ownership_type` SET TAGS ('pii_value_regex' = 'owned|leased|rented');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Remaining Useful Life Years');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `residual_value` SET TAGS ('pii_business_glossary_term' = 'Residual Value');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `revaluation_amount` SET TAGS ('pii_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `revaluation_date` SET TAGS ('pii_business_glossary_term' = 'Revaluation Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `tax_depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `tax_depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|macrs|section_179');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `tax_useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Tax Useful Life Years');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_currency_code` SET TAGS ('pii_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_date` SET TAGS ('pii_business_glossary_term' = 'Valuation Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_notes` SET TAGS ('pii_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_number` SET TAGS ('pii_business_glossary_term' = 'Valuation Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_number` SET TAGS ('pii_value_regex' = '^VAL-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_source` SET TAGS ('pii_business_glossary_term' = 'Valuation Source');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_source` SET TAGS ('pii_value_regex' = 'acquisition|appraisal|market_index|insurance_quote|internal_estimate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_status` SET TAGS ('pii_business_glossary_term' = 'Valuation Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `valuation_status` SET TAGS ('pii_value_regex' = 'draft|active|superseded|archived');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_valuation` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurance_policy_id` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `broker_name` SET TAGS ('pii_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `certificate_issue_date` SET TAGS ('pii_business_glossary_term' = 'Certificate of Insurance (COI) Issue Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `certificate_of_insurance_issued` SET TAGS ('pii_business_glossary_term' = 'Certificate of Insurance (COI) Issued Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_email` SET TAGS ('pii_business_glossary_term' = 'Insurance Claims Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_name` SET TAGS ('pii_business_glossary_term' = 'Insurance Claims Contact Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Insurance Claims Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `claims_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `compliance_notes` SET TAGS ('pii_business_glossary_term' = 'Insurance Compliance Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `coverage_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `coverage_currency_code` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `coverage_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `coverage_scope` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Scope Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `covered_asset_category` SET TAGS ('pii_business_glossary_term' = 'Covered Asset Category');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `covered_asset_category` SET TAGS ('pii_value_regex' = 'heavy_equipment|light_equipment|fleet_vehicles|tools|generators|all_equipment');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `deductible_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Deductible Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage Scope');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_email` SET TAGS ('pii_business_glossary_term' = 'Insurance Provider Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_business_glossary_term' = 'Insurance Provider Contact Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Insurance Provider Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `insurer_name` SET TAGS ('pii_business_glossary_term' = 'Insurance Provider Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `ownership_classification` SET TAGS ('pii_business_glossary_term' = 'Equipment Ownership Classification');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `ownership_classification` SET TAGS ('pii_value_regex' = 'owned_only|rented_only|both_owned_and_rented');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_document_reference` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Document Reference');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_end_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy End Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_notes` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Notes');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_start_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('pii_value_regex' = 'active|pending|expired|cancelled|suspended|renewed');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `policy_type` SET TAGS ('pii_value_regex' = 'all_risk_plant|third_party_liability|fleet_motor|marine_transit|builders_risk|equipment_breakdown');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `premium_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('pii_business_glossary_term' = 'Insurance Premium Payment Frequency');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('pii_value_regex' = 'annual|semi_annual|quarterly|monthly|one_time');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `renewal_notice_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Renewal Notice Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Insurance Policy Renewal Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `renewal_status` SET TAGS ('pii_value_regex' = 'auto_renew|manual_renew|non_renewable|under_review');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`equipment`.`insurance_policy` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_subdomain' = 'fleet_operations');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_association_edges' = 'equipment.asset,schedule.activity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `asset_activity_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Assignment Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Activity Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Asset Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `actual_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `actual_quantity` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Actual Quantity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `assignment_end` SET TAGS ('pii_business_glossary_term' = 'Assignment End');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `assignment_start` SET TAGS ('pii_business_glossary_term' = 'Assignment Start');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `finish_date` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Finish Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `operator_name` SET TAGS ('pii_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `operator_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `operator_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `planned_hours` SET TAGS ('pii_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `planned_quantity` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `released_date` SET TAGS ('pii_business_glossary_term' = 'Released Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `resource_role` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Resource Role');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `responsible_operator` SET TAGS ('pii_business_glossary_term' = 'Responsible Operator');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Assetactivityassignment - Start Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `total_cost` SET TAGS ('pii_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `utilization_pct` SET TAGS ('pii_business_glossary_term' = 'Utilization Pct');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `utilization_percent` SET TAGS ('pii_business_glossary_term' = 'Utilization Percent');
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_activity_assignment` ALTER COLUMN `utilization_rate` SET TAGS ('pii_business_glossary_term' = 'Utilization Rate');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_id` SET TAGS ('pii_business_glossary_term' = 'Fuel Point Identifier');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `parent_fuel_point_id` SET TAGS ('pii_business_glossary_term' = 'Parent Fuel Point Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `parent_fuel_point_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `address` SET TAGS ('pii_business_glossary_term' = 'Address');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `capacity_liters` SET TAGS ('pii_business_glossary_term' = 'Capacity Liters');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `current_level_liters` SET TAGS ('pii_business_glossary_term' = 'Current Level Liters');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_price_per_liter` SET TAGS ('pii_business_glossary_term' = 'Fuel Price Per Liter');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_quality_rating` SET TAGS ('pii_business_glossary_term' = 'Fuel Quality Rating');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `fuel_point_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `next_maintenance_due` SET TAGS ('pii_business_glossary_term' = 'Next Maintenance Due');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `safety_certification_date` SET TAGS ('pii_business_glossary_term' = 'Safety Certification Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `safety_certification_expiry` SET TAGS ('pii_business_glossary_term' = 'Safety Certification Expiry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `supplier_contact` SET TAGS ('pii_business_glossary_term' = 'Supplier Contact');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `supplier_name` SET TAGS ('pii_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_point` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_subdomain' = 'asset_registry');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_preserve' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_id` SET TAGS ('pii_business_glossary_term' = 'Functional Location Identifier');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `parent_functional_location_id` SET TAGS ('pii_business_glossary_term' = 'Parent Functional Location Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `parent_functional_location_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `parent_location_id` SET TAGS ('pii_business_glossary_term' = 'Parent Location Id');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `area_sq_m` SET TAGS ('pii_business_glossary_term' = 'Area Sq M');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `asset_count` SET TAGS ('pii_business_glossary_term' = 'Asset Count');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `capacity_tons` SET TAGS ('pii_business_glossary_term' = 'Capacity Tons');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_code` SET TAGS ('pii_business_glossary_term' = 'Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `commissioning_date` SET TAGS ('pii_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `country_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `country_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `environmental_zone` SET TAGS ('pii_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `gps_accuracy_m` SET TAGS ('pii_business_glossary_term' = 'Gps Accuracy M');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `inspection_status` SET TAGS ('pii_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `is_owned` SET TAGS ('pii_business_glossary_term' = 'Is Owned');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `is_rental` SET TAGS ('pii_business_glossary_term' = 'Is Rental');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `last_inspection_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `functional_location_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `responsible_department` SET TAGS ('pii_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `safety_rating` SET TAGS ('pii_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`equipment`.`functional_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
