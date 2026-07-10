-- Schema for Domain: production | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`production` COMMENT 'Core manufacturing execution domain governing shop floor control, work orders, routing, scheduling, WIP tracking, cycle time, takt time, throughput, and OEE. Integrates with MES (Siemens Opcenter) and ERP (SAP PP) to orchestrate production runs, machine assignments, capacity planning, and shift-level output reporting via SCADA/DCS systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` (
    `production_work_order_id` BIGINT COMMENT 'Unique identifier for the production work order. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost of Goods Sold reporting; each work order must be allocated to a cost center for accurate product costing.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for make-to-order production, if applicable.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: The primary PLC/device executing the work order is tracked for traceability and maintenance scheduling.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Work orders must be traceable to the engineering change order that triggered production for compliance and cost impact analysis.',
    `engineering_bom_line_id` BIGINT COMMENT 'Reference to the specific BOM revision used for this production run, defining the component structure and quantities.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Captures the specific component revision manufactured, enabling quality traceability and regulatory reporting.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Required for OEE and safety reporting to capture the physical location where each production work order is executed.',
    `material_master_id` BIGINT COMMENT 'Reference to the finished or semi-finished good being produced in this work order.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order‑to‑Production report requires linking each work order to the originating sales opportunity for fulfillment tracking.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Order‑driven work‑order execution requires linking each work order to its sales order for scheduling and cost allocation.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Work orders that involve regulated activities must reference the required permit to ensure legal compliance.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP creates planned orders then converts them to production work orders; linking enables traceability in the Production Order Execution Report.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A work order runs on a specific production line; the FK replaces the free‑text line identifier.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: PROJECT COST ALLOCATION: Work orders must be tied to the capital project for cost tracking and reporting in the Project Cost Summary report.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for traceability of external component procurement to a work order, used in scheduling and cost reporting.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to automation.recipe. Business justification: Each work order follows a defined recipe; production planning and quality assurance reports need the recipe reference.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Production‑to‑Sales reconciliation needs a direct FK from work order to the sales order intake that generated it, replacing the denormalized sales_order_number.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: A work order is scheduled for a particular shift; the FK provides a proper relational link.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Work orders must be linked to the SKU produced for inventory, costing, and sales order fulfillment reporting.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location where finished goods from this work order will be received.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Work order supervision requires assigning a supervisor employee for approval and oversight, used in Work Order Approval Report.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Work Order Supplier Performance Report requires linking each work order to its primary supplier for quality and delivery metrics.',
    `version_id` BIGINT COMMENT 'Foreign key linking to production.version. Business justification: A production work order is executed using a specific production version, line, and shift. Adding these FKs normalizes the model and removes the redundant string fields.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or plant location where production is executed.',
    `asset_work_order_id` BIGINT COMMENT 'Reference to SSOT owner asset.asset_work_order for work_order conflict resolution.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this work order, including material, labor, and overhead.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution was completed on the shop floor.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished goods produced and confirmed, in base unit of measure.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution began on the shop floor.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the output of this work order for traceability and quality control.. Valid values are `^[A-Z0-9]{1,20}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this work order was formally closed and all confirmations finalized.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work order completion based on actual quantity versus planned quantity (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this work order.. Valid values are `^[A-Z]{3}$`',
    `cycle_time_minutes` DECIMAL(18,2) COMMENT 'Actual cycle time in minutes to produce one unit, used for OEE calculation and capacity planning.',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime in minutes during work order execution, impacting OEE availability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was last modified.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Calculated OEE percentage for this work order, combining availability, performance, and quality metrics (0.00 to 100.00).',
    `planned_finish_date` DATE COMMENT 'Scheduled date when production is planned to be completed for this work order.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of finished goods to be produced by this work order, in base unit of measure.',
    `planned_start_date` DATE COMMENT 'Scheduled date when production is planned to begin for this work order.',
    `priority_code` STRING COMMENT 'Scheduling priority assigned to this work order, determining its sequence in the production queue.. Valid values are `urgent|high|normal|low`',
    `production_notes` STRING COMMENT 'Free-text notes capturing special instructions, issues, or observations during work order execution.',
    `release_date` DATE COMMENT 'Date when the work order was released to the shop floor for execution.',
    `routing_number` STRING COMMENT 'Identifier for the production routing that defines the sequence of operations for this work order.. Valid values are `^[A-Z0-9]{1,15}$`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production, in base unit of measure.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of material scrapped or rejected during production (0.00 to 100.00).',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes required to set up equipment and tooling before production begins.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Planned standard cost per unit for this production run, used for variance analysis.',
    `takt_time_minutes` DECIMAL(18,2) COMMENT 'Target takt time in minutes per unit, representing the rate at which products must be completed to meet customer demand.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities (e.g., EA for each, KG for kilogram, L for liter).. Valid values are `^[A-Z]{2,6}$`',
    `wip_value` DECIMAL(18,2) COMMENT 'Current financial value of work in progress for this order, including material, labor, and overhead costs.',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the work order, typically generated by ERP or MES systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the manufacturing execution workflow. [ENUM-REF-CANDIDATE: created|released|in_progress|completed|closed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by production purpose: standard production, rework, prototype, maintenance, or sample run.. Valid values are `standard|rework|prototype|maintenance|sample`',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of good units produced versus total units started, used for OEE quality calculation (0.00 to 100.00).',
    CONSTRAINT pk_production_work_order PRIMARY KEY(`production_work_order_id`)
) COMMENT 'Core manufacturing work order representing a discrete production job issued to the shop floor. Authorizes manufacture of a specific quantity of finished or semi-finished goods by linking a routing, BOM revision, and production version. Tracks planned vs. actual dates, priority, order status, WIP value, and completion percentage. The SSOT for all production execution activity within this domain. Sourced from ERP production orders (e.g., SAP PP) and MES work order management (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` (
    `order_confirmation_id` BIGINT COMMENT 'Primary key for order_confirmation',
    `asset_work_order_id` BIGINT COMMENT 'Reference to the parent work order against which this confirmation is reported. Links to the production order master record in ERP (SAP PP) or MES (Siemens Opcenter).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order confirmations are posted to cost accounting; linking to cost_center enables proper cost allocation per confirmation.',
    `employee_id` BIGINT COMMENT 'Reference to the shop floor operator or production worker who performed and confirmed this operation. Used for labor tracking, skill-based routing, and performance analysis.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being produced in this operation. Links to the material master record for inventory posting and cost calculation.',
    `reversed_confirmation_order_confirmation_id` BIGINT COMMENT 'Reference to the original confirmation record that this reversal confirmation is canceling. Null if this is not a reversal transaction.',
    `shift_id` BIGINT COMMENT 'Reference to the production shift during which this confirmation was recorded. Links to shift calendar for shift-level output reporting and labor cost allocation.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Order confirmations must be tied to the SKU to report actual yield, scrap, and cost per product.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production resource) where this operation was performed. Links to the work center master data defining capacity, cost center, and resource type.',
    `activity_type` STRING COMMENT 'The cost accounting activity type for this confirmation (e.g., machine setup, machine run, manual labor, quality inspection). Used for activity-based costing and rate calculation.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost amount incurred for this confirmation based on actual quantities and actual rates. Used for variance analysis and profitability reporting.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'The total labor hours consumed for this operation confirmation. Used for labor cost calculation and efficiency analysis against standard or planned hours.',
    `actual_machine_hours` DECIMAL(18,2) COMMENT 'The total machine runtime hours consumed for this operation confirmation. Used for machine cost allocation and OEE (Overall Equipment Effectiveness) calculation.',
    `batch_number` STRING COMMENT 'The production batch or lot number assigned to the output of this confirmation. Used for traceability, quality control, and recall management in batch-managed materials.',
    `confirmation_number` STRING COMMENT 'Business identifier for the confirmation transaction. Externally visible confirmation document number generated by ERP (SAP CO11N/CO15) or MES system.',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the confirmation record indicating whether it is in draft, submitted for approval, posted to inventory and cost accounting, reversed due to error, or cancelled.. Valid values are `draft|submitted|posted|reversed|cancelled`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the production activity was confirmed on the shop floor. Represents the actual business event time of goods receipt or operation completion.',
    `confirmation_type` STRING COMMENT 'Classification of the confirmation transaction indicating whether it represents a final completion, partial progress, automatic backflush, milestone achievement, rework activity, or scrap reporting.. Valid values are `final|partial|backflush|milestone|rework|scrap`',
    `created_by_user` STRING COMMENT 'The user ID or system account that created this confirmation record. Used for audit trail and accountability in production reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this confirmation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this confirmation record. Typically the plant or company code currency.. Valid values are `^[A-Z]{3}$`',
    `final_confirmation_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this confirmation represents the final completion of the operation. When true, the operation is closed for further confirmations and the work order may proceed to the next operation or completion.',
    `goods_movement_type` STRING COMMENT 'The inventory movement type code triggered by this confirmation (e.g., 101 for goods receipt, 261 for goods issue, 531 for scrap). Aligns with ERP goods movement transaction codes.',
    `inspection_lot_number` STRING COMMENT 'The quality inspection lot number created for the output of this confirmation. Links to the quality management inspection lot record for usage decision and certificate of conformance.',
    `last_modified_by_user` STRING COMMENT 'The user ID or system account that last modified this confirmation record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this confirmation record was last updated. Used for change tracking and data synchronization across systems.',
    `material_document_number` STRING COMMENT 'The material document number generated in ERP inventory management when this confirmation posted goods movements. Used for reconciliation between production and inventory systems.',
    `mes_transaction_code` STRING COMMENT 'The unique transaction identifier from the source MES system (e.g., Siemens Opcenter) that originated this confirmation. Used for system integration reconciliation and traceability.',
    `operation_number` DECIMAL(18,2) COMMENT 'The specific operation sequence number within the work order routing for which this confirmation is recorded. Identifies the production step (e.g., 0010, 0020, 0030) in the manufacturing process.',
    `plant_code` STRING COMMENT 'The manufacturing plant or production facility code where this confirmation was recorded. Used for multi-site reporting and cost center assignment.',
    `posting_date` DATE COMMENT 'The accounting date on which the confirmation was posted to inventory and financial ledgers. Used for period-based cost settlement and variance analysis.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the output from this confirmation requires quality inspection before it can be released to inventory or the next operation. Drives inspection lot creation in QM module.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this confirmation is a reversal of a previously posted confirmation. Used to correct errors and maintain audit trail of production reporting changes.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'The quantity of output that requires rework or reprocessing due to quality issues. Tracked separately from scrap to measure process capability and rework costs.',
    `scada_event_reference` STRING COMMENT 'Reference to the SCADA system event or data collection record that triggered or validated this confirmation. Used for automated confirmation workflows and real-time monitoring integration.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The quantity of defective or non-conforming output that was scrapped during this operation. Used for scrap rate calculation and variance analysis.',
    `serial_numbers` STRING COMMENT 'Comma-separated list of serial numbers for serialized output units produced in this confirmation. Used for unit-level traceability in high-value or regulated products.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'The time spent on machine setup, changeover, and preparation activities before production started. Tracked separately from run time for SMED (Single-Minute Exchange of Die) analysis.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system for this confirmation record (ERP for SAP PP, MES for Siemens Opcenter, SCADA for Aveva, MANUAL for manual entry). Used for data lineage and integration monitoring.. Valid values are `ERP|MES|SCADA|MANUAL`',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'The standard cost amount for this confirmation based on planned quantities and standard rates. Used as the baseline for variance calculation in cost accounting.',
    `teardown_time_hours` DECIMAL(18,2) COMMENT 'The time spent on machine teardown, cleanup, and post-production activities after the operation completed. Used for total cycle time calculation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields in this confirmation (e.g., EA for each, KG for kilograms, L for liters, M for meters). Must align with the material master UOM.',
    `variance_comments` STRING COMMENT 'Free-text comments explaining variances, quality issues, or other notable events during the operation. Provides context for exception analysis and CAPA (Corrective and Preventive Action) investigations.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any variance between planned and actual quantities or times. Used for root cause analysis and continuous improvement initiatives.',
    `yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of good output produced and confirmed for this operation. Represents conforming units that passed quality inspection and are available for subsequent operations or finished goods inventory.',
    CONSTRAINT pk_order_confirmation PRIMARY KEY(`order_confirmation_id`)
) COMMENT 'Shop floor confirmation record capturing actual production output reported against a work order operation. Records confirmed yield quantity, scrap quantity, rework quantity, actual labor hours, machine hours, and operator ID. Represents the operation-level goods receipt event and drives actual vs. planned variance analysis for cost settlement and performance monitoring. Sourced from ERP order confirmations (e.g., SAP CO11N/CO15) and MES activity reporting (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key.',
    `bom_id` BIGINT COMMENT 'Reference to the bill of materials used for this scheduled production. Defines the material components and structure.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Associates production schedule with the plant location to enable plant‑level capacity planning and compliance reporting.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being scheduled for production.',
    `order_header_id` BIGINT COMMENT 'Reference to the customer order driving this production schedule, if make-to-order. Null for make-to-stock schedules.',
    `employee_id` BIGINT COMMENT 'User ID of the production planner responsible for creating and maintaining this schedule. Used for accountability and workload tracking.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A production schedule is defined for a particular line; the FK replaces the free‑text line code.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order generated from this schedule. Links planning to execution.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing or process plan used for this schedule. Defines the sequence of operations and work centers.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Master production schedules are created per SKU; linking enables MPS reporting and demand planning.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line assigned to execute this schedule.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this schedule requires management approval before release. True for high-value, high-risk, or exception schedules; false for routine schedules.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule was cancelled. Null if the schedule was not cancelled.',
    `capacity_requirement_hours` DECIMAL(18,2) COMMENT 'Total machine or labor hours required to complete this schedule. Used for capacity planning and load leveling.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when production for this schedule was completed. Used for schedule performance analysis and cycle time measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was first created in the system. Used for audit trail and schedule age analysis.',
    `firmed_flag` BOOLEAN COMMENT 'Indicates whether this schedule is firmed (locked) and should not be automatically rescheduled by planning systems. True means the schedule is manually controlled; false means it can be adjusted by MRP/APS.',
    `freeze_horizon_date` DATE COMMENT 'Date beyond which this schedule is frozen and cannot be changed without formal approval. Protects near-term execution from planning volatility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was last updated. Tracks schedule volatility and planning changes.',
    `lead_time_days` STRING COMMENT 'Total lead time from schedule release to completion, including queue time, setup, run, and move time. Used for order promising and planning.',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard lot or batch size for this production schedule. May be driven by economic order quantity, equipment constraints, or process requirements.',
    `lot_sizing_rule` STRING COMMENT 'Algorithm used to determine production lot sizes. Fixed lot uses a constant quantity; lot-for-lot matches demand exactly; EOQ optimizes ordering costs; POQ aggregates demand over periods.. Valid values are `fixed_lot|lot_for_lot|economic_order_quantity|period_order_quantity`',
    `mrp_controller` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this schedule. Used for accountability and workload distribution.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Free-text notes and comments from planners regarding special instructions, constraints, or considerations for this schedule.',
    `pegging_reference` STRING COMMENT 'Reference to the demand source (sales order, forecast, safety stock) that this schedule is pegged to. Enables traceability from supply to demand.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of the material to be produced according to this schedule. Expressed in the base unit of measure for the material.',
    `planning_bucket` STRING COMMENT 'Time granularity of the schedule planning horizon. Daily for short-term detailed scheduling, weekly for medium-term planning, monthly for long-term capacity planning.. Valid values are `daily|weekly|monthly`',
    `planning_horizon_weeks` STRING COMMENT 'Number of weeks into the future that this schedule covers. Defines the forward visibility window for production planning.',
    `planning_strategy` DECIMAL(18,2) COMMENT 'Manufacturing strategy governing how this schedule is planned and executed. Make-to-stock builds for inventory; make-to-order builds against customer orders; assemble-to-order configures from standard components; engineer-to-order designs and builds custom products.',
    `priority_rank` STRING COMMENT 'Relative priority of this schedule compared to other schedules. Lower numbers indicate higher priority. Used for resource allocation and sequencing decisions.',
    `released_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule was released for execution. Marks the transition from planning to active production.',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to produce the planned quantity, excluding setup and teardown. Used for cycle time analysis.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained to protect against demand variability and supply disruptions. Influences schedule timing and quantities.',
    `schedule_number` STRING COMMENT 'Business identifier for the production schedule. Externally visible schedule reference number used in planning and execution systems.. Valid values are `^MPS-[0-9]{8}-[0-9]{4}$`',
    `schedule_source` STRING COMMENT 'System or process that generated this schedule. MRP run for material requirements planning; APS optimization for advanced planning and scheduling; manual planning for planner-created schedules; demand forecast for forecast-driven schedules; customer order for order-driven schedules.. Valid values are `mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule. Draft schedules are under planning; released schedules are active; frozen schedules are locked for execution; revised schedules have been updated; cancelled schedules are voided; completed schedules are finished.. Valid values are `draft|released|frozen|revised|cancelled|completed`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by planning level. MPS for top-level finished goods; FAS for final assembly operations; RCCP for high-level capacity validation; MRP for detailed component planning.. Valid values are `master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan`',
    `scheduled_finish_date` DATE COMMENT 'Planned date when production for this schedule is expected to be completed. Used for order promising and delivery planning.',
    `scheduled_finish_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to finish, used for detailed capacity loading and sequencing.',
    `scheduled_start_date` DATE COMMENT 'Planned date when production for this schedule is expected to begin. Key input for capacity planning and material availability checks.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to start, including shift and time-of-day information for detailed shop floor scheduling.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to set up equipment and tooling before production can begin. Part of total lead time calculation.',
    `shift_assignment` STRING COMMENT 'Shift during which this production schedule is assigned to run. Used for labor planning and shift-level capacity allocation.. Valid values are `shift_1|shift_2|shift_3|day|night|weekend`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters).. Valid values are `^[A-Z]{2,3}$`',
    `version` STRING COMMENT 'Version number of the schedule. Incremented each time the schedule is revised or replanned.',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Master production schedule (MPS) record defining planned production quantities, start/finish dates, and shift assignments for a given production item across a planning horizon. Tracks schedule version, freeze horizon, planning bucket (daily/weekly), and schedule status (draft, released, frozen, revised). Represents the output of APS/MRP II scheduling runs. Sourced from ERP production planning (e.g., SAP PP) and APS systems (e.g., Microsoft Dynamics 365 Supply Chain).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for financial tracking and allocation of work center expenses.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or supervisor responsible for managing this work center.',
    `maintenance_strategy_id` BIGINT COMMENT 'Reference to the preventive maintenance strategy applied to equipment at this work center.',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this work center is located.',
    `work_center_group_id` BIGINT COMMENT 'Foreign key linking to production.work_center_group. Business justification: A work center belongs to a work center group; adding work_center_group_id creates the parent relationship and eliminates the need for ad‑hoc grouping logic.',
    `shift_sequence_id` BIGINT COMMENT 'Reference to the shift sequence or shift calendar defining operating hours for this work center.',
    `available_capacity_per_shift` DECIMAL(18,2) COMMENT 'Standard available capacity of the work center per shift, measured in the capacity category unit.',
    `capacity_category` STRING COMMENT 'Unit of measure for capacity planning (e.g., machine hours, labor hours, throughput units).. Valid values are `machine_hours|labor_hours|units_per_hour|setup_hours`',
    `capacity_planning_group` STRING COMMENT 'Grouping code for aggregating work centers in capacity planning and leveling activities.. Valid values are `^[A-Z0-9]{2,8}$`',
    `work_center_category` STRING COMMENT 'Classification of the work center type indicating the nature of the production resource.. Valid values are `machine|assembly_line|production_cell|labor_group|inspection_station|packaging_line`',
    `work_center_code` STRING COMMENT 'Business identifier for the work center used in ERP and MES systems. Externally-known unique code for capacity planning and routing assignments.. Valid values are `^[A-Z0-9]{4,12}$`',
    `control_key` STRING COMMENT 'Control key defining how operations are processed at this work center (e.g., internal processing, external processing, inspection).. Valid values are `^[A-Z0-9]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system.',
    `efficiency_rate_percent` DECIMAL(18,2) COMMENT 'Standard efficiency rate of the work center expressed as a percentage, representing the ratio of actual output to theoretical maximum output.',
    `formula_key` STRING COMMENT 'Formula key used for calculating operation times and capacity requirements at this work center.. Valid values are `^[A-Z0-9]{2,6}$`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this work center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last modified.',
    `location_description` STRING COMMENT 'Physical location description of the work center within the plant (e.g., Building 2, Floor 3, Bay 5).',
    `mes_integration_enabled` DECIMAL(18,2) COMMENT 'Indicates whether this work center is integrated with the MES for real-time shop floor control and data collection.',
    `work_center_name` STRING COMMENT 'Human-readable name or description of the work center (e.g., Assembly Line 3, CNC Machining Cell A, Welding Station 5).',
    `number_of_machines` STRING COMMENT 'Count of individual machines or equipment units within this work center.',
    `number_of_operators` STRING COMMENT 'Standard number of operators or workers assigned to this work center during normal operation.',
    `oee_baseline_target_percent` DECIMAL(18,2) COMMENT 'Target OEE baseline for this work center, calculated as Availability × Performance × Quality. Used for capacity planning and performance benchmarking.',
    `plc_address` STRING COMMENT 'Network address or identifier of the PLC controlling this work center, used for SCADA and MES integration.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether operations at this work center require mandatory quality inspection before proceeding to the next step.',
    `scada_tag_prefix` STRING COMMENT 'SCADA tag prefix used to identify real-time data points from this work center in the process control system.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `scheduling_type` STRING COMMENT 'Scheduling strategy used for operations at this work center (forward scheduling, backward scheduling, or capacity-only).. Valid values are `forward|backward|midpoint|only_capacity_requirements`',
    `standard_processing_time_minutes` DECIMAL(18,2) COMMENT 'Standard processing or cycle time in minutes per unit for operations performed at this work center.',
    `standard_queue_time_hours` DECIMAL(18,2) COMMENT 'Standard queue time in hours representing the typical wait time before an operation begins at this work center.',
    `standard_setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup or changeover time in minutes required to prepare the work center for a new production run.',
    `standard_teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard teardown time in minutes required to complete and clean up after an operation at this work center.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Target utilization rate of the work center expressed as a percentage, representing the ratio of actual operating time to available time.',
    `valid_from_date` DATE COMMENT 'Date from which this work center configuration is effective and available for production planning.',
    `valid_to_date` DATE COMMENT 'Date until which this work center configuration is effective. Null indicates indefinite validity.',
    `work_center_status` STRING COMMENT 'Current lifecycle status of the work center indicating its operational availability.. Valid values are `active|inactive|maintenance|decommissioned|planned`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this work center record in the system.',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master data entity representing a physical or logical production resource on the shop floor — a machine, assembly cell, production line segment, or labor group — at which manufacturing operations are performed. Captures work center code, plant, cost center linkage, capacity category, available capacity per shift, efficiency rate, utilization rate, and OEE baseline target. The SSOT for capacity planning and routing assignments within the production domain. Sourced from ERP work center master (e.g., SAP CR01).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the manufacturing routing. Primary key.',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the material components consumed by this routing. Links routing to BOM for integrated production planning.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or finished good that this routing produces. Links to the material master in inventory domain.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Routing planning is owned by a planner employee, needed for Routing Change Management report.',
    `production_plant_id` BIGINT COMMENT 'Manufacturing plant or facility where this routing is executed. Links to plant master data.',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `approval_date` DATE COMMENT 'Date on which this routing was approved for production use.',
    `approval_status` STRING COMMENT 'Current approval status of the routing. Pending routings await review; approved routings are authorized for production; rejected routings require rework; under_review routings are in the approval workflow.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this routing for production use.',
    `base_quantity` DECIMAL(18,2) COMMENT 'Standard lot size or batch quantity for which the routing times and resource requirements are defined. All operation times are calculated relative to this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity. Standard ISO unit codes such as EA (each), KG (kilogram), L (liter), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `change_number` STRING COMMENT 'Engineering Change Notice (ECN) or Engineering Change Order (ECO) number that authorized the creation or last modification of this routing. Supports traceability of process changes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code for the standard cost amount.',
    `counter` STRING COMMENT 'Sequential counter within the routing group. Together with routing_group, forms an alternative business key.. Valid values are `^[0-9]{1,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was first created in the system.',
    `routing_description` STRING COMMENT 'Detailed textual description of the routing purpose, scope, and special instructions. Provides context for production planners and shop floor operators.',
    `is_default_routing` BOOLEAN COMMENT 'Indicates whether this routing is the default routing for the material. True if this is the primary routing; false if it is an alternative.',
    `is_phantom_routing` BOOLEAN COMMENT 'Indicates whether this is a phantom routing that is automatically consumed without generating a separate production order. Used for subassemblies that are immediately incorporated into parent assemblies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was last modified.',
    `last_used_date` DATE COMMENT 'Most recent date on which this routing was used in a production order or work order. Used to identify obsolete or inactive routings.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'Minimum lot size for which this routing is applicable. Supports lot-size-dependent routing selection.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'Maximum lot size for which this routing is applicable. Null indicates no upper limit.',
    `planner_group` STRING COMMENT 'Production planning team or planner responsible for maintaining and scheduling this routing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `routing_group` STRING COMMENT 'Grouping code for related routings. Used to organize routings by product family, process type, or manufacturing cell.. Valid values are `^[A-Z0-9]{1,8}$`',
    `routing_number` STRING COMMENT 'Business identifier for the routing. Externally visible routing code used in production planning and shop floor documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Draft routings are under development; released routings are approved for use; active routings are currently in production; inactive routings are temporarily suspended; obsolete routings are retired; blocked routings are prohibited from use.. Valid values are `draft|released|active|inactive|obsolete|blocked`',
    `routing_type` STRING COMMENT 'Classification of the routing purpose. Production routings define standard manufacturing sequences; inspection routings define quality check sequences; rework routings define repair processes; universal routings apply across multiple materials; rate routings define continuous process flows; reference routings serve as templates.. Valid values are `production|inspection|rework|universal|rate|reference`',
    `scheduling_type` STRING COMMENT 'Scheduling strategy for this routing. Forward scheduling starts from the earliest start date; backward scheduling works back from the required finish date; midpoint scheduling balances around a target date.. Valid values are `forward|backward|midpoint`',
    `source_system_code` STRING COMMENT 'Unique identifier of this routing in the source system. Used for data lineage and reconciliation.',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard cost to execute this routing for the base quantity. Includes labor, machine, overhead, and tooling costs. Used for cost accounting and variance analysis.',
    `text` STRING COMMENT 'Extended free-form text field for detailed routing notes, special handling instructions, safety warnings, and quality requirements.',
    `total_labor_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative labor time in minutes across all operations for the base quantity. Labor time may scale differently than machine time.',
    `total_lead_time_hours` DECIMAL(18,2) COMMENT 'Total cumulative lead time in hours required to complete all operations in this routing for the base quantity. Includes setup, machine, labor, and queue times.',
    `total_machine_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative machine processing time in minutes across all operations for the base quantity. Machine time scales with lot size.',
    `total_operation_count` DECIMAL(18,2) COMMENT 'Total number of operations (steps) defined in this routing. Derived from routing operation line items.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative setup time in minutes across all operations for the base quantity. Setup time is independent of lot size.',
    `usage` STRING COMMENT 'Intended application context for the routing. Standard routings are the default production method; alternative routings provide backup processes; trial routings support pilot runs; prototype routings support R&D; emergency routings address contingency scenarios.. Valid values are `standard|alternative|trial|prototype|emergency`',
    `usage_count` STRING COMMENT 'Total number of times this routing has been used in production orders or work orders. Indicates routing popularity and stability.',
    `valid_from_date` DATE COMMENT 'Effective start date from which this routing is valid and can be used in production planning and execution.',
    `valid_to_date` DATE COMMENT 'Effective end date after which this routing is no longer valid. Null indicates indefinite validity.',
    `version` STRING COMMENT 'Version identifier for the routing. Supports versioning of routing definitions to track engineering changes and process improvements.. Valid values are `^[A-Z0-9]{1,4}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Manufacturing routing master defining the ordered sequence of operations required to produce a finished or semi-finished item. Captures routing number, routing type (production, inspection, universal), base quantity, status, and validity dates. Each routing is composed of individual operations (modeled as line items) linked to work centers with standard times for setup, machine run, and labor. The SSOT for standard production process definitions. Sourced from ERP routing master (e.g., SAP CA01) and PLM process plans (e.g., Siemens Teamcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`version` (
    `version_id` BIGINT COMMENT 'Unique identifier for the production version record. Primary key.',
    `bom_id` BIGINT COMMENT 'Reference to the specific BOM (Bill of Materials) that defines the component structure and material requirements for this production version.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master that this production version is defined for. Links to the finished good or semi-finished product being manufactured.',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant where this production version is valid and executable.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `routing_id` BIGINT COMMENT 'Reference to the routing that defines the sequence of operations, work centers, and process steps for manufacturing this material under this production version.',
    `approval_date` DATE COMMENT 'Date when this production version was formally approved for use in production by authorized personnel or quality management.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this production version for production use.',
    `bom_alternative` STRING COMMENT 'Alternative BOM indicator when multiple BOMs exist for the same material. Allows selection of different component lists for different production scenarios.. Valid values are `^[A-Z0-9]{1,2}$`',
    `bom_usage` STRING COMMENT 'BOM usage indicator defining the purpose of the BOM (e.g., 1 for production, 3 for engineering). Determines which BOM alternative is selected.. Valid values are `^[0-9]{1}$`',
    `change_number` STRING COMMENT 'Engineering Change Number (ECN) or Engineering Change Order (ECO) that authorized the creation or modification of this production version. Links to change management process.. Valid values are `^[A-Z0-9]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production version record was first created in the system.',
    `version_description` STRING COMMENT 'Textual description of the production version explaining its purpose, characteristics, or usage scenario (e.g., Standard Production, High Volume Line, Alternate Routing for Capacity Constraint).',
    `distribution_key` STRING COMMENT 'Key that controls how production quantities are distributed across multiple production versions when more than one version is valid for the same material and lot size.. Valid values are `^[A-Z0-9]{1,4}$`',
    `is_costing_relevant` BOOLEAN COMMENT 'Flag indicating whether this production version is used for product costing calculations. True means this version is included in standard cost estimates.',
    `is_locked` BOOLEAN COMMENT 'Flag indicating whether this production version is locked and cannot be used for new production orders. True means locked, False means available for use.',
    `is_mrp_relevant` BOOLEAN COMMENT 'Flag indicating whether this production version is considered during MRP (Material Requirements Planning) runs. True means MRP will use this version for planning.',
    `issue_storage_location` BOOLEAN COMMENT 'Default storage location from which components are issued for production orders created with this production version. 4-character alphanumeric code.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this production version record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this production version record was last modified in the system.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'Minimum production lot size (quantity) for which this production version is valid. Defines the lower bound of the lot size range.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'Maximum production lot size (quantity) for which this production version is valid. Defines the upper bound of the lot size range. Null indicates no upper limit.',
    `lot_size_unit` STRING COMMENT 'Unit of measure for the lot size range (e.g., EA for each, KG for kilogram, L for liter). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this production version. May include setup requirements, quality considerations, or operational constraints.',
    `production_version_code` STRING COMMENT 'Alphanumeric code identifying the production version within the material-plant combination. Typically 1-4 characters. Business identifier for the production version.. Valid values are `^[A-Z0-9]{1,4}$`',
    `production_version_status` STRING COMMENT 'Current lifecycle status of the production version indicating its operational state and usability for production planning and execution.. Valid values are `active|inactive|planned|obsolete|under_review|approved`',
    `receipt_storage_location` STRING COMMENT 'Default storage location where finished goods are received after production completion for this production version. 4-character alphanumeric code.. Valid values are `^[A-Z0-9]{4}$`',
    `task_list_type` STRING COMMENT 'Type of task list used in this production version. N=Standard routing, R=Rate routing, Q=Inspection plan. Determines the structure of operations.. Valid values are `N|R|Q`',
    `valid_from_date` DATE COMMENT 'Start date from which this production version becomes effective and can be used for production planning and execution.',
    `valid_to_date` DATE COMMENT 'End date until which this production version remains effective. Null indicates indefinite validity.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this production version record in the system.',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Production version master linking a specific BOM and routing combination valid for manufacturing a material within a defined quantity range and validity period. Captures production version code, description, BOM usage, routing group, lot size range (minimum/maximum), valid-from/valid-to dates, and MRP relevance flag. Sourced from SAP PP material master production version (MRP4 view). Determines which BOM and routing are used when a work order is created.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique identifier for the shift definition record. Primary key.',
    `calendar_id` BIGINT COMMENT 'Reference to the factory calendar that defines working days, holidays, and plant shutdowns for this shift. Used to exclude non-working days from capacity calculations.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Links shift to its site location, enabling shift‑level labor cost and safety incident aggregation per plant.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Shift supervisor employee oversees shift operations, needed for Shift Performance and Safety reports.',
    `work_center_id` BIGINT COMMENT 'Reference to the specific work center or production line where this shift is applicable. Nullable if the shift applies plant-wide. Used for capacity planning and machine-specific scheduling.',
    `break_duration_minutes` DECIMAL(18,2) COMMENT 'Sum of all scheduled break periods (lunch, rest breaks) within the shift, in minutes. Subtracted from gross duration to calculate net available time for production.',
    `break_schedule` STRING COMMENT 'Textual description of the break structure, including start times and durations (e.g., 10:00-10:15 (15 min), 12:00-12:30 (30 min)). Used for communication to shop floor personnel and HMI display.',
    `shift_category` STRING COMMENT 'Broad categorization of shift purpose. Production shifts are used for manufacturing execution and OEE calculation; non-production shifts (e.g., maintenance, training) are excluded from throughput metrics; mixed shifts include both activities.. Valid values are `production|non_production|mixed`',
    `changeover_allowance_minutes` STRING COMMENT 'Standard time reserved within the shift for product changeovers, tool changes, or setup activities. Used to adjust net available time for multi-product shifts and to calculate planned downtime for OEE.',
    `shift_code` STRING COMMENT 'Unique business identifier for the shift pattern (e.g., DAY_1, NIGHT_A, SWING_2). Used as the externally-known reference in scheduling systems and MES.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift definition record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_size` STRING COMMENT 'Standard number of operators or workers assigned to this shift pattern. Used for labor capacity planning and cost allocation. Nullable if crew size varies by work center.',
    `days_of_week` STRING COMMENT 'Comma-separated list of weekday codes (MON, TUE, WED, THU, FRI, SAT, SUN) indicating which days this shift pattern applies to. Used for weekly capacity planning and workforce rostering.',
    `effective_end_date` DATE COMMENT 'Date after which this shift definition is no longer valid. Nullable for open-ended shift patterns. Used to retire obsolete shift definitions while preserving historical data.',
    `effective_start_date` DATE COMMENT 'Date from which this shift definition becomes active and can be used for production scheduling. Supports versioning of shift patterns over time.',
    `end_time` TIMESTAMP COMMENT 'Time of day when the shift ends, in HH:mm:ss format (24-hour clock). May be less than start_time for shifts that cross midnight. Used to calculate gross shift duration.',
    `gross_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time of the shift from start to end, in minutes, including all breaks and non-productive time. Used as the denominator for availability calculations.',
    `handover_duration_minutes` DECIMAL(18,2) COMMENT 'Planned overlap time between consecutive shifts for handover communication, equipment status review, and safety briefing. Subtracted from net available time if included in shift boundaries. Nullable for non-continuous operations.',
    `is_continuous_operation` BOOLEAN COMMENT 'Indicates whether this shift is part of a 24/7 continuous manufacturing operation (True) or a discrete batch operation (False). Used to determine handover requirements and WIP tracking rules.',
    `labor_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base labor rates for this shift type (e.g., 1.0 for regular, 1.5 for overtime, 2.0 for holiday). Used for labor cost calculation and variance analysis.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this shift definition record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift definition record was last updated. Used for audit trail and to track the currency of master data.',
    `shift_name` STRING COMMENT 'Human-readable name of the shift (e.g., Day Shift, Night Shift, Morning Shift). Used for display in reports and HMI screens.',
    `net_available_minutes` STRING COMMENT 'Net productive time available for manufacturing execution, calculated as gross_duration_minutes minus break_duration_minutes. Used as the planned production time for OEE availability calculation and takt time planning.',
    `notes` STRING COMMENT 'Free-text field for additional information about the shift pattern, special instructions, or exceptions. Used for communication to planners and supervisors.',
    `number_of_breaks` STRING COMMENT 'Count of distinct break periods scheduled within the shift (e.g., 2 for a shift with one lunch break and one rest break). Used for workforce scheduling and labor compliance reporting.',
    `planned_output_quantity` DECIMAL(18,2) COMMENT 'Target production volume for this shift, in base unit of measure. Used as the denominator for performance OEE calculation and as input to takt time calculation. Nullable for non-production shifts.',
    `priority` STRING COMMENT 'Numeric priority ranking for shift selection when multiple shift definitions are valid for the same time period (lower number = higher priority). Used by APS systems to resolve scheduling conflicts.',
    `rotation_pattern` STRING COMMENT 'Description of the multi-day or multi-week rotation cycle this shift belongs to (e.g., 2-2-3 Continental, 4-on-4-off, DuPont 12-hour). Used for long-term workforce scheduling and fatigue management.',
    `sequence` STRING COMMENT 'Ordinal position of this shift within a daily rotation (e.g., 1 for first shift, 2 for second shift, 3 for third shift). Used for shift handover reporting and continuous production tracking.',
    `shift_status` STRING COMMENT 'Current lifecycle state of the shift definition. Active shifts are available for scheduling; inactive shifts are temporarily disabled; draft shifts are under review; archived shifts are retained for historical reference only.. Valid values are `active|inactive|draft|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift pattern indicating the nature of the working period. Regular shifts are standard production periods; overtime, weekend, and holiday shifts may carry premium labor rates; maintenance and emergency shifts are non-production periods.. Valid values are `regular|overtime|weekend|holiday|maintenance|emergency`',
    `start_time` TIMESTAMP COMMENT 'Time of day when the shift begins, in HH:mm:ss format (24-hour clock). Used to calculate shift boundaries for production tracking and OEE reporting.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target cycle time per unit to meet customer demand, calculated as net_available_minutes * 60 / planned_output_quantity. Used for production pacing and line balancing. Nullable if not applicable to this shift type.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the plant location where this shift operates (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used to convert shift boundaries to UTC for global reporting and to handle daylight saving time transitions.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for planned_output_quantity (e.g., EA for each, KG for kilograms, M for meters). Must align with material master UOM for the products manufactured during this shift.. Valid values are `^[A-Z]{2,5}$`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this shift definition record. Used for audit trail and data governance.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Shift definition master representing a named working period pattern for a plant or work center. Defines shift code, start/end times, break structure, net available minutes, and shift type (regular, overtime, weekend). Used as the time-boundary reference for capacity planning, OEE shift-level reporting, takt time calculation, and workforce scheduling integration.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`shift_report` (
    `shift_report_id` BIGINT COMMENT 'Unique identifier for the shift report record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor or shift leader responsible for this production shift.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Allows shift reports to be tied to the plant location for accurate reporting of downtime and quality metrics per site.',
    `shift_id` BIGINT COMMENT 'Reference to the shift definition (e.g., Day Shift, Night Shift, Swing Shift).',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or material that was produced during this shift.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where this shift occurred.',
    `actual_good_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of conforming units produced during the shift that passed quality inspection.',
    `actual_production_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the work center was actively producing during the shift, excluding downtime.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned production time that the equipment was available and operating, calculated as (Planned Time - Downtime) / Planned Time × 100.',
    `batch_number` STRING COMMENT 'Production batch or lot number assigned to output from this shift for traceability.',
    `changeover_count` STRING COMMENT 'Number of production changeovers or setups performed during the shift.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time spent on changeovers and setups during the shift.',
    `comments` STRING COMMENT 'Free-text comments from the shift supervisor documenting notable events, issues, or observations during the shift.',
    `cycle_time_seconds` DECIMAL(18,2) COMMENT 'Average time in seconds to complete one production cycle or unit during the shift.',
    `data_source_system` STRING COMMENT 'Identifies the primary source system from which shift data was captured (MES, SCADA, ERP, or manual entry).. Valid values are `MES|SCADA|ERP|MANUAL`',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the shift due to equipment failures, material shortages, or other interruptions.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed by the work center during the shift, measured in kilowatt-hours.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this shift report requires management escalation due to performance issues, quality problems, or safety concerns.',
    `material_consumed_quantity` DECIMAL(18,2) COMMENT 'Total quantity of raw materials or components consumed during the shift.',
    `material_waste_quantity` DECIMAL(18,2) COMMENT 'Quantity of material wasted or lost during production beyond normal scrap allowances.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness calculated as Availability × Performance × Quality, expressed as a percentage.',
    `operator_count` STRING COMMENT 'Number of operators assigned to the work center during this shift.',
    `performance_percentage` DECIMAL(18,2) COMMENT 'Percentage of maximum possible output achieved during operating time, calculated as (Actual Output / Theoretical Maximum Output) × 100.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total planned available production time for the shift, excluding scheduled breaks and maintenance windows.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target production quantity planned for this shift based on production schedule and capacity.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether production output from this shift is on quality hold pending inspection or investigation.',
    `quality_percentage` DECIMAL(18,2) COMMENT 'Percentage of good units produced out of total units, calculated as (Good Quantity / Total Produced Quantity) × 100.',
    `report_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift report was officially closed and finalized in the MES system.',
    `report_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift report record was first created in the system.',
    `report_number` STRING COMMENT 'Business identifier for the shift report, typically formatted as YYYYMMDD-SHIFT-WORKCENTER.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of units requiring rework or reprocessing to meet quality standards.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this shift requiring documentation and follow-up.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of units scrapped during the shift due to defects or non-conformance.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of total produced quantity that was scrapped, calculated as (Scrap Quantity / Total Produced Quantity) × 100.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred.',
    `shift_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the shift in minutes, calculated from start to end timestamp.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift ended production activities.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift started production activities.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target production rate in seconds per unit, calculated from customer demand and available production time.',
    `throughput_rate_per_hour` DECIMAL(18,2) COMMENT 'Average number of units produced per hour during the shift.',
    `total_produced_quantity` DECIMAL(18,2) COMMENT 'Total quantity produced during the shift, including good, scrap, and rework units.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this report (e.g., EA for each, KG for kilograms). [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|TON|LB|GAL|FT — 10 candidates stripped; promote to reference product]',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'First-pass yield rate representing the percentage of units that passed quality inspection without rework.',
    CONSTRAINT pk_shift_report PRIMARY KEY(`shift_report_id`)
) COMMENT 'Shift-level production performance report capturing actual results for a specific shift at a work center or line. Records planned vs. actual good quantity, scrap, rework, downtime minutes, OEE (availability × performance × quality), cycle time, takt time, and throughput rate. The SSOT for shift-level OEE and production KPIs. Drives daily production meetings, continuous improvement actions, and management escalation triggers. Sourced from MES shift close procedures (e.g., Siemens Opcenter) and SCADA data aggregation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` (
    `wip_lot_id` BIGINT COMMENT 'Unique identifier for the work-in-progress lot or batch. Primary key for the WIP lot tracking entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WIP lot valuation requires assignment to a cost center for inventory costing and financial statements.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production resource where this lot is currently located and being processed.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Lots produced under a specific engineering change order need linkage for compliance and cost reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or technician currently responsible for processing this lot at the current work center.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Lot tracking must record the component revision to ensure traceability for quality investigations.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Links WIP lot to its plant location for lot traceability and site‑specific quality control.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record representing the product or component being manufactured in this lot.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: WIP lots originate from material requirements; linking enables requirement fulfillment analysis and variance reporting in the WIP Requirement Traceability report.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Lot traceability to the sales order is required for compliance and customer‑specific quality tracking.',
    `parent_lot_wip_lot_id` BIGINT COMMENT 'Reference to the parent WIP lot if this lot was split or derived from another lot. Enables genealogy and traceability tracking.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: A WIP lot is generated from a specific production work order; linking removes the ambiguous order number field.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: WIP TRACKING PER PROJECT: Associates each WIP lot with its project for progress reporting and earned value calculations.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing defining the sequence of operations this lot must traverse.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: WIP lot tracking requires the SKU identifier for traceability, quality inspection, and regulatory compliance.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: WIP lot tracking includes source supplier to support recall management and supplier quality analysis.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the lot actually completed all operations and was confirmed as finished. Null if lot is still in process.',
    `batch_number` STRING COMMENT 'Batch identifier for process industries where multiple lots may be grouped into a single batch for traceability or quality purposes.',
    `current_operation_sequence` DECIMAL(18,2) COMMENT 'Sequence number of the operation currently being performed on this lot within the routing. Used to track progress through the production process.',
    `current_operation_start_timestamp` TIMESTAMP COMMENT 'Date and time when the lot arrived at and began processing at the current operation. Used for operation cycle time tracking.',
    `expiration_date` DATE COMMENT 'Shelf life expiration date for this lot, applicable for materials with limited shelf life such as chemicals, adhesives, or perishable components.',
    `hold_reason_code` STRING COMMENT 'Code indicating the reason why this lot is on hold, if applicable. Examples include quality issue, material shortage, engineering change, equipment failure.',
    `inspection_lot_number` STRING COMMENT 'Quality inspection lot number assigned by the QM system if this WIP lot is subject to inspection. Links to quality inspection records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this WIP lot record was last updated in the system. Used for audit trail and data synchronization.',
    `lot_creation_timestamp` TIMESTAMP COMMENT 'Date and time when this WIP lot record was created in the MES system, marking the start of lot tracking.',
    `lot_number` STRING COMMENT 'Business identifier for the lot or batch. Human-readable unique code used for tracking and traceability across the shop floor and in MES systems.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the WIP lot. Indicates whether the lot is released for production, actively in process, on hold, completed, scrapped, or cancelled.. Valid values are `released|in_process|on_hold|completed|scrapped|cancelled`',
    `notes` STRING COMMENT 'Free-text field for capturing additional notes, comments, or special instructions related to this WIP lot that do not fit structured fields.',
    `original_lot_number` STRING COMMENT 'Lot number of the original lot if this is a rework or split lot. Maintains traceability to the source lot for genealogy purposes.',
    `priority_code` STRING COMMENT 'Production priority level assigned to this lot. Determines scheduling precedence and resource allocation on the shop floor.. Valid values are `urgent|high|normal|low`',
    `production_start_timestamp` TIMESTAMP COMMENT 'Date and time when physical production of this lot began at the first operation. Used for lead time and cycle time calculation.',
    `project_number` STRING COMMENT 'Project identifier if this lot is being produced for a specific engineering or customer project. Used for project-based manufacturing tracking.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this lot requires quality inspection before proceeding to the next operation or before final goods receipt.',
    `quantity_completed` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has successfully completed all operations in the routing and is ready for goods receipt.',
    `quantity_in_process` DECIMAL(18,2) COMMENT 'Current quantity of material actively being processed at the current operation. Represents material that has not yet completed the current step.',
    `quantity_on_hold` DECIMAL(18,2) COMMENT 'Quantity of material in this lot that is currently on hold pending quality inspection, engineering review, or other disposition decision.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Total quantity of material originally planned to be produced in this lot as specified in the production order.',
    `quantity_scrapped` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has been rejected or scrapped due to quality defects or process failures during production.',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether this lot is a rework lot created to reprocess previously rejected or non-conforming material.',
    `scheduled_completion_date` DATE COMMENT 'Planned date by which this lot is scheduled to complete all operations and be available for goods receipt. Used for capacity planning and delivery commitment.',
    `scrap_reason_code` STRING COMMENT 'Code indicating the primary reason for any scrapped quantity in this lot. Used for root cause analysis and process improvement.',
    `serial_number_profile` STRING COMMENT 'Serial number profile code indicating whether and how individual units within this lot are serialized for traceability.',
    `shift_code` STRING COMMENT 'Identifier of the production shift during which this lot is currently being processed. Used for shift-level performance reporting.',
    `special_stock_indicator` STRING COMMENT 'Code indicating if this lot represents special stock such as consignment, project stock, or customer-owned material.',
    `storage_location_code` STRING COMMENT 'Storage location or staging area code where this WIP lot is currently physically located within the plant.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this lot record (e.g., EA for each, KG for kilograms, M for meters).',
    CONSTRAINT pk_wip_lot PRIMARY KEY(`wip_lot_id`)
) COMMENT 'Work-in-progress (WIP) lot or batch tracking entity representing a discrete quantity of material currently being processed through the production routing. Captures lot number, material number, current operation, current work center, quantity in process, quantity completed, quantity scrapped, lot creation timestamp, and lot status (in-process, on-hold, completed, scrapped). Enables real-time WIP visibility, genealogy tracing, and shop floor material flow tracking. Sourced from MES lot tracking (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` (
    `production_downtime_event_id` BIGINT COMMENT 'Unique identifier for the production downtime event record. Primary key.',
    `alarm_definition_id` BIGINT COMMENT 'Foreign key linking to automation.alarm_definition. Business justification: Root‑cause analysis links downtime events to the specific alarm definition that triggered them, required for OEE loss reporting.',
    `asset_work_order_id` BIGINT COMMENT 'Identifier of the maintenance work order created to address the downtime event. Null for non-maintenance related downtime.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the specific equipment or machine that experienced downtime. Links to equipment register.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Captures the exact plant location of each downtime event, required for safety incident analysis and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the maintenance technician or operator assigned to resolve the downtime event. Links to employee master data.',
    `production_work_order_id` BIGINT COMMENT 'Identifier of the production order that was interrupted by this downtime event. May be null for unplanned stoppages outside scheduled production.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: DOWNTIME COST ATTRIBUTION: Downtime events are allocated to the owning project for KPI dashboards and project profitability analysis.',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.safety_incident. Business justification: Downtime root‑cause analysis links downtime events to recorded safety incidents for safety performance reporting.',
    `shift_id` BIGINT COMMENT 'Identifier of the production shift during which the downtime event occurred. Links to shift schedule master data.',
    `tertiary_production_recorded_by_employee_id` BIGINT COMMENT 'Identifier of the operator or technician who initially recorded this downtime event. Links to employee master data.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production line where the downtime occurred. Links to the work center master data.',
    `asset_downtime_event_id` BIGINT COMMENT 'Reference to SSOT owner asset.asset_downtime_event for downtime_event conflict resolution.',
    `alarm_code` STRING COMMENT 'SCADA or DCS alarm code that triggered the downtime event. Used to correlate downtime with specific equipment faults.',
    `alarm_description` STRING COMMENT 'Human-readable description of the SCADA alarm that initiated the downtime event.',
    `approval_status` STRING COMMENT 'Approval status of the downtime event record. Pending indicates awaiting supervisor review, approved indicates validated, rejected indicates disputed or incorrect entry.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event record was approved by a supervisor or manager.',
    `comments` STRING COMMENT 'Additional free-text comments or notes about the downtime event from operators, technicians, or supervisors.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for production loss value (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event: breakdown (unplanned equipment failure), planned_maintenance (scheduled PM), changeover (product/tool change), material_shortage (feedstock unavailable), quality_hold (production stopped for quality issue), operator_absence (staffing gap).. Valid values are `breakdown|planned_maintenance|changeover|material_shortage|quality_hold|operator_absence`',
    `downtime_event_number` STRING COMMENT 'Business-readable unique identifier for the downtime event, typically generated by MES or SCADA system.. Valid values are `^DT-[0-9]{10}$`',
    `downtime_reason` STRING COMMENT 'Operator or supervisor entered reason for the downtime event. Free-text field capturing immediate observed cause.',
    `downtime_type` STRING COMMENT 'Indicates whether the downtime was planned (scheduled maintenance, changeover) or unplanned (breakdown, material shortage, quality hold).. Valid values are `planned|unplanned`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event in minutes. Calculated as the difference between end_timestamp and start_timestamp, or current time if still ongoing.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when production resumed after the downtime event. Null if downtime is still ongoing.',
    `impact_on_oee` DECIMAL(18,2) COMMENT 'Calculated percentage impact of this downtime event on the work center or line OEE for the shift or day. Expressed as percentage points lost.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this downtime event record is currently active. False indicates the record has been logically deleted or superseded.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this downtime event is part of a recurring pattern at this work center or equipment. True if similar events have occurred within the past 30 days.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was last updated. Audit trail field.',
    `mttr_minutes` DECIMAL(18,2) COMMENT 'Mean time to repair for this type of downtime event, calculated from historical data. Used for benchmarking and performance tracking.',
    `notification_sent` BOOLEAN COMMENT 'Flag indicating whether automated notifications were sent to supervisors, maintenance team, or management when this downtime event occurred.',
    `preventive_action` STRING COMMENT 'Description of preventive measures implemented to avoid recurrence of this type of downtime event.',
    `production_loss_units` DECIMAL(18,2) COMMENT 'Estimated quantity of production units lost due to this downtime event. Calculated based on standard cycle time and downtime duration.',
    `production_loss_value` DECIMAL(18,2) COMMENT 'Estimated financial value of production lost due to this downtime event. Calculated using standard cost per unit and production loss units.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was first created in the system. Audit trail field.',
    `recurrence_count` STRING COMMENT 'Number of times this type of downtime event has occurred at this work center or equipment within the past 30 days. Used for chronic loss identification.',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve the downtime event and restore production.',
    `responsible_department` STRING COMMENT 'Department accountable for resolving the downtime event: production (operator-related), maintenance (equipment repair), quality (inspection/testing), materials (supply chain), engineering (design/process), operations (planning/scheduling).. Valid values are `production|maintenance|quality|materials|engineering|operations`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the downtime event. Typically references a root cause taxonomy maintained in the CMMS or MES system.',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings for this downtime event.',
    `severity_level` STRING COMMENT 'Business impact severity of the downtime event: critical (full line stoppage, safety risk), high (major capacity loss), medium (partial degradation), low (minor impact).. Valid values are `critical|high|medium|low`',
    `shift_date` DATE COMMENT 'Calendar date of the shift during which the downtime occurred. Used for daily OEE reporting and trend analysis.',
    `source_system_code` STRING COMMENT 'Unique identifier of this downtime event in the source system. Used for data lineage and reconciliation.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the downtime event began. Captured from SCADA alarm logs or MES operator entry.',
    CONSTRAINT pk_production_downtime_event PRIMARY KEY(`production_downtime_event_id`)
) COMMENT 'Downtime event capturing a planned or unplanned production stoppage at a work center or line. Records start/end timestamps, duration, downtime category (breakdown, planned maintenance, changeover, material shortage, quality hold, operator absence), root cause code, and responsible department. Critical input for OEE availability calculation, TPM analysis, and changeover time (SMED) tracking. Sourced from SCADA alarm logs and MES downtime tracking (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` (
    `production_goods_receipt_id` BIGINT COMMENT 'Unique identifier for the production goods receipt event. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the production activity. Used for cost allocation and variance analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or technician who confirmed the goods receipt on the shop floor. Used for accountability and performance tracking.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Connects goods receipt to the receiving plant location, supporting traceability and inventory valuation per site.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the lot or batch number assigned to the received goods for traceability and quality control purposes.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the finished or semi-finished good that was received. Links to the material being produced.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Goods receipts are posted as a result of an MRP run; linking enables receipt verification against the originating run in the Goods Receipt Reconciliation report.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: Replace string line code with a proper foreign key to the production line entity for referential integrity.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Link goods receipt to the work order it finalizes, enabling traceability from receipt to production work order.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: PROJECT INVENTORY RECEIPT: Goods receipts are linked to the project to reconcile received materials against project budgets.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: Replace string shift identifier with a foreign key to the shift entity, allowing accurate shift‑level reporting.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Goods receipt records need the SKU to validate received quantity against the product master and enable downstream inventory updates.',
    `stock_location_id` BIGINT COMMENT 'Reference to the storage location within the plant where the received goods were posted to inventory. Links to warehouse storage location.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Goods receipt must record the supplying vendor to enable invoice matching and supplier performance tracking.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received goods for traceability. May be system-generated or manually assigned based on batch management configuration.',
    `confirmation_number` STRING COMMENT 'The production confirmation number from the MES or ERP system that triggered this goods receipt. Links shop floor execution to inventory posting.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was first created in the data warehouse. Used for data lineage and audit purposes.',
    `delivery_note_number` STRING COMMENT 'Reference number from the physical delivery documentation or packing slip accompanying the goods. Used for reconciliation with physical documents.',
    `document_date` DATE COMMENT 'The date on which the goods receipt document was created or initiated. May differ from posting date in cases of backdated transactions.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the goods receipt was posted. Used for monthly financial closing and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the goods receipt was posted. Used for period-based financial reporting and inventory valuation.',
    `gr_document_number` STRING COMMENT 'The unique document number generated by the ERP system for this goods receipt transaction. This is the business identifier used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the receipt has been successfully posted, reversed, cancelled, or is awaiting quality inspection.. Valid values are `posted|reversed|cancelled|pending_quality|blocked`',
    `inspection_lot_number` STRING COMMENT 'The quality inspection lot number created for this goods receipt if quality inspection is required. Links to quality management inspection results.',
    `modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was last updated in the data warehouse. Used for change tracking and data quality monitoring.',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the type of inventory transaction. For production goods receipts, typically 101 (goods receipt to stock) or 131 (goods receipt from production order).. Valid values are `^[0-9]{3}$`',
    `note` STRING COMMENT 'Free-text notes or comments entered by the operator or warehouse personnel regarding the goods receipt. Captures exceptions, observations, or special handling instructions.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The total quantity originally planned to be produced on the work order. Used to calculate yield and completion percentage.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to inventory in the ERP system. This is the accounting-effective date for inventory valuation.',
    `posting_user` STRING COMMENT 'The system user ID who posted the goods receipt transaction in the ERP system. Used for audit trail and accountability.',
    `production_version` STRING COMMENT 'Identifies the specific production version (combination of BOM and routing) used to manufacture the goods. Used for process traceability and costing.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released to unrestricted stock. Drives QM workflow.',
    `receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the goods were physically received and confirmed on the shop floor or warehouse. Captures the real-world event time for production completion.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of finished or semi-finished goods received and posted to inventory. Measured in the base unit of measure for the material.',
    `reservation_number` STRING COMMENT 'The material reservation number that was created for the work order and fulfilled by this goods receipt. Links production output to material planning.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt was reversed. Provides audit trail for corrections.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this goods receipt has been reversed or cancelled. Used to filter active vs. reversed transactions in reporting.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the goods receipt (e.g., quantity error, wrong material, quality issue). Used for root cause analysis.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The quantity of material scrapped or rejected during the production run that resulted in this goods receipt. Used for yield calculation and quality analysis.',
    `special_stock_indicator` STRING COMMENT 'Code indicating if the goods receipt is for special stock types such as consignment, project stock, or sales order stock. Affects inventory valuation and availability.',
    `stock_type` STRING COMMENT 'The type of stock to which the goods were received. Unrestricted stock is available for use, quality inspection stock is awaiting QA approval, blocked stock cannot be used.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilograms, L for liters). Must match the material master base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Classification code used for split valuation of materials when the same material is valued differently based on procurement type or quality grade.',
    `vendor_batch_number` STRING COMMENT 'External batch number from a supplier or contract manufacturer, if the goods receipt is for subcontracted production. Used for external traceability.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The percentage of good output relative to the total input or planned quantity. Calculated as (received_quantity / order_quantity) * 100. Key OEE component.',
    CONSTRAINT pk_production_goods_receipt PRIMARY KEY(`production_goods_receipt_id`)
) COMMENT 'Goods receipt event recording formal completion and stock posting of finished or semi-finished goods produced against a work order. Captures GR document number, posting date, material, plant, storage location, received quantity, batch number, and movement type (101). Sourced from SAP PP/WM (MIGO). This is the production domains handoff point — it triggers inventory update in the inventory domain and signals work order completion. Does NOT own ongoing stock balances (inventory domain owns those).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` (
    `bom_consumption_id` BIGINT COMMENT 'Primary key for bom_consumption',
    `employee_id` BIGINT COMMENT 'Identifier of the shop floor operator who performed or confirmed the material consumption. Enables accountability and labor tracking.',
    `engineering_bom_line_id` BIGINT COMMENT 'Reference to the specific BOM line item that defines the planned component requirement. Links actual consumption to engineering BOM specification.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the quality inspection lot if the component underwent inspection before consumption. Links consumption to quality control records.',
    `material_master_id` BIGINT COMMENT 'Reference to the component material consumed from inventory. Identifies the specific raw material, sub-assembly, or component issued to production.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the parent work order for which materials were consumed. Links consumption to the manufacturing execution context.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Material consumption entries need the SKU to roll up costs and efficiency metrics to the final product.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or bin within the warehouse from which material was picked. Provides granular inventory tracking.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse from which the component material was issued. Identifies the physical storage facility.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost per unit of the component material based on moving average price or FIFO/LIFO valuation. Reflects real inventory valuation at consumption time.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of component material issued from inventory to the work order. Represents the real consumption recorded via goods issue or backflush.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether this consumption was automatically backflushed by the MES system upon work order confirmation (true) or manually posted (false).',
    `batch_number` STRING COMMENT 'The batch or lot number of the component material consumed. Enables traceability for quality control, recall management, and shelf-life tracking.',
    `consumption_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the consumption event. Captures operator notes and exception details.',
    `consumption_status` STRING COMMENT 'Current status of the consumption record: posted (finalized in ERP), pending (awaiting confirmation), reversed (cancelled), cancelled (voided), confirmed (validated by supervisor).. Valid values are `posted|pending|reversed|cancelled|confirmed`',
    `consumption_type` STRING COMMENT 'Classification of the consumption event: planned (per BOM), unplanned (ad-hoc issue), scrap (defective material), rework (reprocessing), or sample (quality testing).. Valid values are `planned|unplanned|scrap|rework|sample`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'The cost center to which the material consumption cost is allocated. Used for internal cost accounting and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consumption record was first created in the data warehouse. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts (e.g., USD, EUR, CNY). Ensures consistent financial reporting across global operations.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration or shelf-life date of the consumed component material. Critical for perishable materials, chemicals, and time-sensitive components.',
    `goods_issue_number` STRING COMMENT 'The ERP-generated document number for the material goods issue transaction. Typically corresponds to SAP movement type 261 for production consumption.',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'The date and time when the material goods issue transaction was posted in the ERP system. Represents the official consumption event time.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this consumption record was last updated in the data warehouse. Tracks data change history for audit and reconciliation.',
    `movement_type` STRING COMMENT 'Three-digit SAP movement type code indicating the nature of the goods issue. Common values: 261 (goods issue to order), 262 (reversal of 261).. Valid values are `^[0-9]{3}$`',
    `operation_number` DECIMAL(18,2) COMMENT 'The routing operation sequence number at which the component was consumed. Links consumption to the specific production step in the routing.',
    `original_goods_issue_number` STRING COMMENT 'If this is a reversal transaction, the goods issue document number of the original transaction being reversed. Enables audit trail for corrections.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of component material planned to be consumed according to the BOM specification and work order quantity. Basis for variance analysis.',
    `posting_date` DATE COMMENT 'The accounting date on which the consumption transaction was posted to the general ledger. May differ from goods issue timestamp for period-end adjustments.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether the consumed component required quality inspection before use (true) or not (false). Supports quality assurance compliance tracking.',
    `reason_code` STRING COMMENT 'Code indicating the reason for the consumption or variance. Examples: normal production, rework, quality testing, engineering change, process improvement.',
    `reservation_item_number` STRING COMMENT 'The line item number within the material reservation document. Provides granular linkage to the specific reserved component.',
    `reservation_number` STRING COMMENT 'The ERP reservation document number that allocated the material to the work order. Links consumption to the material requirements planning reservation.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this record represents a reversal of a previous goods issue (true) or an original consumption posting (false). Used for correction and adjustment tracking.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The quantity of component material scrapped or wasted during production. Subset of actual quantity representing non-conforming or damaged material.',
    `serial_number` STRING COMMENT 'The unique serial number of the component if serialized inventory control is used. Provides unit-level traceability for critical components.',
    `shift_code` STRING COMMENT 'The shift during which the material was consumed (e.g., day shift, night shift, weekend shift). Supports shift-level performance analysis.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard cost per unit of the component material at the time of consumption. Used for cost variance calculation and financial reporting.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the consumption transaction (actual quantity multiplied by actual unit cost). Represents the financial impact of the material issue.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields (e.g., EA for each, KG for kilograms, L for liters, M for meters). Must align with material master base UOM.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual and planned consumption quantity (actual minus planned). Positive values indicate over-consumption; negative values indicate under-consumption.',
    `variance_reason_code` STRING COMMENT 'Specific code explaining the root cause of consumption variance when actual differs from planned. Used for continuous improvement and cost control analysis.',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number assigned by the component supplier. Enables upstream traceability to vendor quality records and certificates of conformance.',
    `work_center_code` STRING COMMENT 'The code identifying the work center or production resource where the component was consumed. Enables cost center allocation and capacity analysis.',
    CONSTRAINT pk_bom_consumption PRIMARY KEY(`bom_consumption_id`)
) COMMENT 'Component material consumption record capturing the actual goods issue of raw materials and components from inventory to a work order during production execution. Tracks component material number, planned vs. actual issued quantity, variance quantity, unit of measure, storage location, batch number, and backflush indicator. Enables actual vs. planned BOM consumption variance analysis for cost control and material planning feedback. Sourced from ERP goods issue postings (e.g., SAP movement type 261) and MES backflush events.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` (
    `resource_tool_id` BIGINT COMMENT 'Primary key for resource_tool',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Tools are calibrated and allocated per component type; linking supports tool‑component compatibility and maintenance planning.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the equipment register in the asset management domain if this production resource tool is also tracked as a capital asset. Links to Computerized Maintenance Management System (CMMS) for maintenance lifecycle details.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record if this production resource tool is also managed as an inventory item (e.g., consumable cutting tools). Links to inventory domain for stock tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tool custodianship assigns a responsible employee, required for Tool Calibration and Maintenance schedule.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Tool Allocation process requires exact stock location of each tool; the Tool Management report joins resource_tool with stock_location to show current location.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Tool assets are procured from vendors; linking enables warranty management and supplier performance monitoring.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where this production resource tool is primarily assigned. Used for capacity planning and scheduling.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or fabrication cost of the production resource tool in the specified currency. Used for capital expenditure (CapEx) tracking and asset valuation.',
    `acquisition_date` DATE COMMENT 'Date when the production resource tool was acquired or placed into service. Used for depreciation calculations and lifecycle tracking.',
    `calibration_certificate_number` DECIMAL(18,2) COMMENT 'Reference number of the most recent calibration certificate issued by the calibration laboratory. Used for quality audit trails and traceability.',
    `calibration_interval_days` DECIMAL(18,2) COMMENT 'Standard number of days between calibration events for this production resource tool. Used to automatically calculate next calibration due date.',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether this production resource tool requires periodic calibration to maintain measurement accuracy and quality compliance. True = calibration required; False = no calibration needed.',
    `calibration_status` DECIMAL(18,2) COMMENT 'Current calibration compliance status. Current = within calibration interval; Due = approaching calibration date; Overdue = past calibration date and blocked from use; Not Applicable = calibration not required for this tool type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production resource tool record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `current_usage_cycles` STRING COMMENT 'Cumulative number of production cycles or operations this production resource tool has performed to date. Used to calculate remaining useful life and trigger replacement.',
    `resource_tool_description` STRING COMMENT 'Detailed business description of the production resource tool, including its purpose, specifications, and operational characteristics.',
    `drawing_number` STRING COMMENT 'Reference to the engineering drawing or Computer-Aided Design (CAD) model that defines the production resource tool design. Links to Product Lifecycle Management (PLM) system.',
    `expected_useful_life_years` STRING COMMENT 'Estimated useful life of the production resource tool in years. Used for depreciation calculations and replacement planning.',
    `last_calibration_date` DATE COMMENT 'Date when the production resource tool was last calibrated. Used to calculate next calibration due date and track calibration history.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production resource tool record was last updated. Used for audit trails and change tracking.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced this production resource tool. Used for spare parts sourcing and technical support.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number or model number for this production resource tool. Used for procurement and technical documentation.',
    `maximum_usage_cycles` STRING COMMENT 'Maximum number of production cycles or operations this production resource tool can perform before requiring replacement or refurbishment. Used for preventive maintenance planning.',
    `next_calibration_date` DATE COMMENT 'Scheduled date for the next calibration event. Used for preventive maintenance planning and tool availability forecasting. Tool may be blocked from use if this date is exceeded.',
    `notes` STRING COMMENT 'Free-text notes capturing additional operational information, special handling instructions, or historical context for this production resource tool.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where the production resource tool is physically located and managed. Aligns with ERP plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `prt_number` STRING COMMENT 'Externally-known unique business identifier for the production resource tool (jig, fixture, mold, die, NC program, or specialized equipment). Used for scheduling, capacity planning, and shop floor control.. Valid values are `^[A-Z0-9]{6,20}$`',
    `prt_type` STRING COMMENT 'Classification of the production resource tool by functional category. Determines usage patterns, calibration requirements, and scheduling logic.. Valid values are `jig|fixture|mold|die|nc_program|cutting_tool`',
    `resource_tool_status` STRING COMMENT 'Current lifecycle status of the production resource tool. Determines availability for scheduling and capacity planning. Available = ready for use; In Use = assigned to active work order; Maintenance = under repair; Calibration = undergoing calibration; Retired = no longer in service; Quarantine = blocked pending quality review.. Valid values are `available|in_use|maintenance|calibration|retired|quarantine`',
    `revision_level` STRING COMMENT 'Current engineering revision level of the production resource tool design. Used to track Engineering Change Orders (ECO) and Engineering Change Notices (ECN).',
    `safety_certification_expiry_date` DATE COMMENT 'Expiration date of the current safety certification. Tool may be blocked from use if this date is exceeded.',
    `safety_certification_number` STRING COMMENT 'Reference number of the current safety certification or inspection certificate. Used for regulatory compliance and audit trails.',
    `safety_certification_required_flag` BOOLEAN COMMENT 'Indicates whether this production resource tool requires safety certification or inspection per Occupational Safety and Health Administration (OSHA) or other regulatory requirements. True = certification required; False = no certification needed.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific production resource tool instance. Used for asset tracking and warranty management.',
    `technical_specification` STRING COMMENT 'Detailed technical specifications of the production resource tool, including dimensions, tolerances, materials, and performance characteristics. Used for engineering and quality control.',
    `usage_quantity_per_operation` DECIMAL(18,2) COMMENT 'Standard quantity of this production resource tool required per routing operation. Used for tool availability checks during scheduling and capacity planning.',
    `usage_unit_of_measure` STRING COMMENT 'Unit of measure for the usage quantity (e.g., EA for each, SET for set, HR for hour). Aligns with ISO standard UOM codes.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_resource_tool PRIMARY KEY(`resource_tool_id`)
) COMMENT 'Production resource and tool (PRT) master representing jigs, fixtures, molds, dies, NC programs, and specialized equipment required during routing operations but not consumed in production. Tracks PRT number, type, description, plant, usage quantity per operation, calibration status, next calibration date, and availability status. Enables tool availability checks during scheduling and capacity planning. Maintenance lifecycle details are owned by the asset domain; this entity owns the production-scheduling view of tool readiness. Sourced from ERP PRT master (e.g., SAP PP).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`run` (
    `run_id` BIGINT COMMENT 'Primary key for run',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials used for this production run, defining the component structure and recipe.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this production run is being executed, applicable for make-to-order scenarios.',
    `equipment_register_id` BIGINT COMMENT 'Reference to the primary equipment or machine asset assigned to execute this production run.',
    `material_master_id` BIGINT COMMENT 'Reference to the primary material or product being manufactured in this production run.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Run‑level reporting and profitability analysis need a direct reference to the originating sales order.',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Run scheduling dashboards rely on the originating sales order intake to allocate runs; the FK replaces the redundant sales_order_number field.',
    `shift_id` BIGINT COMMENT 'FK to production.shift',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Each production run must reference the SKU to calculate yield, OEE, and cost per product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Run supervision links a supervisor employee to each production run for accountability in Run Efficiency analysis.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Production runs need supplier reference to calculate cost, quality impact, and compliance per material batch.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where finished goods from this run are received.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this production run, including material, labor, and overhead costs.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution was completed or terminated.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Total actual quantity produced during this run, representing the sum of good output across all work orders.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution began on the shop floor.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Equipment availability during the production run, calculated as (operating time / planned production time) * 100.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the output of this production run for traceability and quality tracking purposes.',
    `campaign_code` STRING COMMENT 'Campaign or project code associated with this production run, used for grouping related runs for reporting and analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost and financial values in this production run.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this production run record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments about the production run, capturing operational observations, issues, or special instructions.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness metric for this production run, calculated as availability * performance * quality, expressed as a percentage.',
    `performance_percentage` DECIMAL(18,2) COMMENT 'Equipment performance efficiency during the production run, calculated as (actual output / target output) * 100.',
    `planned_finish_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the production run is planned to complete execution.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Total planned production quantity for this run across all included work orders.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the production run is planned to begin execution.',
    `priority_code` STRING COMMENT 'Priority level assigned to this production run for scheduling and resource allocation purposes.. Valid values are `low|normal|high|urgent|critical`',
    `quality_percentage` DECIMAL(18,2) COMMENT 'Quality rate during the production run, calculated as (good units / total units produced) * 100.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material sent for rework or reprocessing during this production run.',
    `routing_number` STRING COMMENT 'Identifier of the production routing or process sequence followed during this run, defining the operations and work centers.',
    `run_number` STRING COMMENT 'Business identifier for the production run campaign, externally visible and used for tracking and reporting purposes.',
    `run_status` STRING COMMENT 'Current lifecycle status of the production run indicating its operational state.. Valid values are `planned|active|paused|completed|cancelled|aborted`',
    `run_type` STRING COMMENT 'Classification of the production run indicating the purpose or nature of the execution (standard production, pilot run, rework campaign, validation run, trial batch, or extended campaign).. Valid values are `standard|pilot|rework|validation|trial|campaign`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Total quantity of scrap or rejected material generated during this production run.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Overall scrap rate for the production run, calculated as (scrap quantity / (actual quantity + scrap quantity)) * 100.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit for this production run based on the costing model and BOM.',
    `takt_time_minutes` DECIMAL(18,2) COMMENT 'Target production rate or takt time for this run, representing the available production time divided by customer demand, measured in minutes per unit.',
    `throughput_rate` DECIMAL(18,2) COMMENT 'Average throughput rate achieved during the production run, measured as units produced per hour.',
    `total_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Total cycle time for the production run, representing the sum of all processing time across all operations, measured in minutes.',
    `total_downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the production run, measured in minutes.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Total setup and changeover time for the production run, measured in minutes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this production run (e.g., EA, KG, L, M).',
    `work_order_count` STRING COMMENT 'Number of individual work orders included or consolidated within this production run campaign.',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'Overall yield rate for the production run, calculated as (actual quantity / (actual quantity + scrap quantity)) * 100.',
    CONSTRAINT pk_run PRIMARY KEY(`run_id`)
) COMMENT 'Production run entity representing a continuous execution campaign on a production line or work center, potentially spanning multiple work orders for the same or similar products. Captures run number, production line, start timestamp, end timestamp, total planned quantity, total actual quantity, total scrap quantity, overall yield rate, number of work orders included, and run status (active, completed, cancelled). Sourced from Siemens Opcenter MES campaign/run management. Enables campaign-level performance analysis beyond individual work orders.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Unique identifier for the production line. Primary key for the production line master entity.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Line configuration & maintenance uses a specific control system; OEE and maintenance reports require linking line to its control system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production line overhead is budgeted and reported per cost center; the link supports line‑level cost reporting.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Needed to associate each production line with its plant location for capacity planning and regulatory compliance.',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to automation.network_segment. Business justification: Cybersecurity compliance and network topology reports need to know which network segment each line resides in.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for supervising operations on this production line.',
    `production_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this production line master record.',
    `work_center_group_id` BIGINT COMMENT 'Reference to the work center group that this production line belongs to for capacity planning and resource allocation.',
    `actual_oee_percentage` DECIMAL(18,2) COMMENT 'Most recent calculated Overall Equipment Effectiveness percentage for this production line based on actual performance data.',
    `automation_level` STRING COMMENT 'Degree of automation implemented on the production line, ranging from manual operations to fully automated lights-out manufacturing.. Valid values are `manual|semi_automated|fully_automated|lights_out`',
    `capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether this production line is identified as a bottleneck or capacity constraint in the manufacturing process requiring special attention in scheduling.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time from last good piece of previous run to first good piece of new run, including setup and stabilization time.',
    `commissioning_date` DATE COMMENT 'Date when the production line was first commissioned and put into operational service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was first created in the system.',
    `cycle_time_seconds` DECIMAL(18,2) COMMENT 'Actual average time required to complete one production cycle on this line. Used to compare against takt time for performance analysis.',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this production line master data originated or is synchronized.. Valid values are `SAP_PP|OPCENTER_MES|SCADA|MDM|MANUAL`',
    `design_throughput_rate` DECIMAL(18,2) COMMENT 'Theoretical maximum production rate of the line measured in units per hour under ideal conditions. Used for capacity planning and OEE calculations.',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Average energy consumption in kilowatt-hours required to produce one unit of output on this production line. Used for energy management and cost analysis.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this production line is subject to environmental compliance monitoring and reporting requirements.',
    `erp_work_center_code` STRING COMMENT 'Corresponding work center code in the ERP system for integration with production planning and costing modules.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major upgrade or modernization performed on the production line equipment or control systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was most recently updated or modified.',
    `layout_diagram_url` STRING COMMENT 'Reference URL or document path to the physical layout diagram or CAD drawing of the production line configuration.',
    `line_code` STRING COMMENT 'Unique business identifier code for the production line used across MES and ERP systems. Externally-known identifier for scheduling, capacity planning, and shop floor control.. Valid values are `^[A-Z0-9]{4,12}$`',
    `line_name` STRING COMMENT 'Human-readable name of the production line for identification and reporting purposes.',
    `line_type` STRING COMMENT 'Classification of the production line based on its primary manufacturing function. Determines the type of operations performed on this line.. Valid values are `assembly|machining|fabrication|painting|testing|packaging`',
    `mes_line_identifier` STRING COMMENT 'Unique identifier for this production line in the Manufacturing Execution System used for shop floor control and production tracking.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time between equipment failures on this production line, used for reliability analysis and preventive maintenance planning.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair and restore this production line to operational status after a failure event.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations specific to this production line.',
    `number_of_stations` STRING COMMENT 'Total count of work stations or process steps configured on this production line. Defines the line configuration and complexity.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational state of the production line indicating availability for production scheduling and capacity planning.',
    `planned_availability_hours_per_day` DECIMAL(18,2) COMMENT 'Total hours per day that the production line is scheduled to be available for production, excluding planned maintenance windows.',
    `planned_decommission_date` DATE COMMENT 'Planned date for decommissioning or retirement of this production line from active service.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether output from this production line requires mandatory quality inspection before release to inventory.',
    `safety_certification_required` STRING COMMENT 'List of safety certifications or compliance requirements applicable to this production line based on the products manufactured and jurisdictional regulations.',
    `scada_system_tag` STRING COMMENT 'Unique tag identifier in the SCADA system used to monitor and control this production line in real-time.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Average time required to change over the production line from one product or batch to another, including tooling changes and adjustments.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern configured for this production line defining daily operational hours and crew rotation.. Valid values are `single_shift|two_shift|three_shift|continuous|custom`',
    `standard_operating_procedure_url` STRING COMMENT 'Reference URL or document path to the standard operating procedures governing operation of this production line.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target time interval between completion of successive units, calculated as available production time divided by customer demand. Critical metric for lean manufacturing and production scheduling.',
    `target_oee_percentage` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage for this production line, representing the goal for availability, performance, and quality combined.',
    `throughput_unit_of_measure` STRING COMMENT 'Unit of measure for the throughput rate indicating how production output is quantified for this line.. Valid values are `units_per_hour|pieces_per_hour|kg_per_hour|liters_per_hour`',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Production line master entity representing a named, configured manufacturing line within a plant, composed of an ordered set of work centers and machines. Captures line code, line name, plant, line type (assembly, machining, fabrication, painting, testing), design throughput rate (units/hour), takt time target, number of stations, automation level (manual, semi-automated, fully automated), and current operational status. The SSOT for production line configuration used in scheduling, OEE reporting, and capacity planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` (
    `work_order_allocation_id` BIGINT COMMENT 'Primary key for the work_order_allocation association',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the allocation',
    `line_id` BIGINT COMMENT 'Foreign key linking to the order line',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to the production work order',
    `allocated_by` STRING COMMENT 'Identifier of the user or system that performed the allocation',
    `allocated_by_name` STRING COMMENT 'Name of the person or entity who allocated the work order',
    `allocated_by_user` STRING COMMENT 'allocated by user',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of the order line that this work order is allocated to produce',
    `allocation_date` DATE COMMENT 'The date when the work order allocation was made',
    `allocation_notes` STRING COMMENT 'Notes related to the work order allocation',
    `allocation_number` STRING COMMENT '',
    `allocation_priority` STRING COMMENT '',
    `allocation_status` STRING COMMENT 'Current status of the allocation (e.g., Pending, Confirmed, Completed)',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation was created or last updated',
    `allocation_type` STRING COMMENT '',
    `consumed_quantity` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `planned_end_time` TIMESTAMP COMMENT '',
    `planned_start_time` TIMESTAMP COMMENT '',
    `priority` STRING COMMENT 'Business data attribute for work_order_allocation.',
    `priority_rank` STRING COMMENT '',
    `remaining_quantity` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_work_order_allocation PRIMARY KEY(`work_order_allocation_id`)
) COMMENT 'Represents the allocation of production work orders to sales order lines. Each record links one production_work_order to one order_line and captures allocation-specific data such as quantity, status, and timestamps.. Existence Justification: A production work order can be allocated to multiple order lines, and a single order line can be fulfilled by multiple work orders when production is split across runs. Planners actively create, update, and delete allocation records that capture allocated quantity, status, and timestamps, making the allocation a managed business entity.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` (
    `work_center_group_id` BIGINT COMMENT 'Primary key for work_center_group',
    `location_id` BIGINT COMMENT 'Identifier of the physical location or plant where the group operates.',
    `parent_work_center_group_id` BIGINT COMMENT 'Self-referencing FK on work_center_group (parent_work_center_group_id)',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Work center groups are defined within a plant; linking to plant provides hierarchy and enables plant‑level reporting.',
    `capacity_per_hour` DECIMAL(18,2) COMMENT 'Maximum production capacity of the group expressed in units per hour.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Financial cost center associated with the group.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the group record was first created in the system.',
    `default_shift_length_minutes` STRING COMMENT 'Typical length of a shift for the group in minutes.',
    `effective_from` DATE COMMENT 'Date when the work center group becomes operational.',
    `effective_until` DATE COMMENT 'Date when the work center group is retired or no longer valid (nullable).',
    `group_code` STRING COMMENT 'External code or tag used to identify the group across systems.',
    `group_name` STRING COMMENT 'Human‑readable name of the work center group.',
    `group_type` STRING COMMENT 'Category that defines the primary purpose of the group (e.g., production, maintenance).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this group is the default selection for new work orders.',
    `manager_email` STRING COMMENT 'Email address of the group manager.',
    `manager_name` STRING COMMENT 'Full name of the manager responsible for the group.',
    `manager_phone` STRING COMMENT 'Contact phone number of the group manager.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the group.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target OEE value the group aims to achieve, expressed as a percentage.',
    `responsible_department` STRING COMMENT 'Organizational department that owns the work center group.',
    `shift_pattern` STRING COMMENT 'Standard shift arrangement used by the group.',
    `work_center_group_status` STRING COMMENT 'Current lifecycle status of the group.',
    `total_work_centers` DECIMAL(18,2) COMMENT 'Count of individual work centers that belong to this group.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the group record.',
    CONSTRAINT pk_work_center_group PRIMARY KEY(`work_center_group_id`)
) COMMENT 'Master reference table for work_center_group. Referenced by work_center_group_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_plant` (
    `production_plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT 'Connect finance.plant by adding column finance_company_code_id (BIGINT) with an FK to finance.company_code.company_code_id. P19: connect_table: finance.plant** - add column finance_company_code_id (BIGINT) with FK to finance.company_c',
    `asset_plant_id` BIGINT COMMENT 'SSOT reference to canonical single source of truth.',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building).',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical output capacity of the plant in megawatts.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Total CO₂ equivalent emissions for the plant in kilograms.',
    `city` STRING COMMENT 'City where the plant is located.',
    `closure_date` DATE COMMENT 'Date the plant was permanently shut down, if applicable.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created.',
    `production_plant_description` STRING COMMENT 'Free‑form textual description of the plants purpose and characteristics.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption for the reporting period in megawatt‑hours.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the plant record is currently active in the system.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant site.',
    `maintenance_cycle_days` STRING COMMENT 'Standard interval in days between routine maintenance events.',
    `manager_email` STRING COMMENT 'Email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the plant manager.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the plant manager.',
    `production_plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next major maintenance activity.',
    `notes` STRING COMMENT 'Supplementary information or remarks about the plant.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Measured OEE percentage achieved.',
    `oee_target` DECIMAL(18,2) COMMENT 'Planned OEE percentage target for the plant.',
    `operational_since` DECIMAL(18,2) COMMENT 'Date the plant began commercial operations.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary function.',
    `region` STRING COMMENT 'Higher‑level region (e.g., North America, EMEA) for reporting.',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents in the reporting period.',
    `safety_incident_last_date` DATE COMMENT 'Date of the most recent safety incident.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `production_plant_status` STRING COMMENT 'Current operational state of the plant.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Quantity of waste produced by the plant in metric tons.',
    `water_consumption_m3` DECIMAL(18,2) COMMENT 'Total water usage for the reporting period in cubic metres.',
    CONSTRAINT pk_production_plant PRIMARY KEY(`production_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Primary key for calendar',
    `base_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (base_calendar_id)',
    `calendar_type` STRING COMMENT 'Type of calendar definition applied to the row.',
    `calendar_code` STRING COMMENT 'Unique code identifying the calendar entry',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was first inserted.',
    `calendar_date` DATE COMMENT 'The calendar day represented by this row.',
    `day_of_month` STRING COMMENT 'Numeric day within the month (1‑31).',
    `day_of_week` STRING COMMENT 'Name of the weekday (e.g., Monday, Tuesday). [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `day_of_year` STRING COMMENT 'Ordinal day within the year (1‑366).',
    `fiscal_month` STRING COMMENT 'Fiscal month (1‑12) for the date.',
    `fiscal_period` STRING COMMENT 'Fiscal period designation for the calendar entry',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) for the date.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the date belongs, based on the companys fiscal calendar.',
    `fiscal_year_start_date` DATE COMMENT 'First day of the fiscal year to which the row belongs.',
    `holiday_name` STRING COMMENT 'Name of the holiday when is_holiday is true; null otherwise.',
    `holiday_type` STRING COMMENT 'Classification of the holiday (national, regional, or observance).',
    `is_business_day` BOOLEAN COMMENT 'True if the date is a regular working day (not weekend or holiday).',
    `is_holiday` BOOLEAN COMMENT 'True if the date is a recognized public or company holiday.',
    `is_leap_year` BOOLEAN COMMENT 'True if the year of the date is a leap year.',
    `is_shutdown` BOOLEAN COMMENT 'Indicates whether the calendar day is a shutdown day',
    `is_weekend` BOOLEAN COMMENT 'True if the date falls on a Saturday or Sunday.',
    `is_working_day` BOOLEAN COMMENT '',
    `iso_week_number` BOOLEAN COMMENT 'ISO‑8601 week number (1‑53) for the date.',
    `iso_year` BOOLEAN COMMENT 'ISO‑8601 year associated with the week number.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `month` STRING COMMENT 'Numeric month of the year (1‑12).',
    `month_name` STRING COMMENT 'Full name of the month (e.g., January). [ENUM-REF-CANDIDATE: January|February|March|April|May|June|July|August|September|October|November|December — promote to reference product]',
    `month_start_date` DATE COMMENT 'First calendar day of the month for the row.',
    `calendar_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `quarter` STRING COMMENT 'Fiscal quarter of the year (1‑4).',
    `quarter_name` STRING COMMENT 'Label for the quarter (Q1‑Q4).',
    `quarter_start_date` DATE COMMENT 'First calendar day of the quarter for the row.',
    `region_code` STRING COMMENT '',
    `shift_indicator` STRING COMMENT 'Designated shift for the date in production planning (day, night, or swing).',
    `shift_pattern` STRING COMMENT '',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the date (e.g., UTC, America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calendar record.',
    `week_of_year` STRING COMMENT 'ISO week number within the year (1‑53).',
    `week_start_date` DATE COMMENT 'Date of the Monday (or first day of week) for the week containing the row.',
    `working_hours` DECIMAL(18,2) COMMENT '',
    `year` STRING COMMENT 'Four‑digit calendar year.',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Master reference table for calendar. Referenced by calendar_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` (
    `shift_sequence_id` BIGINT COMMENT 'Primary key for shift_sequence',
    `calendar_id` BIGINT COMMENT '',
    `rotation_shift_sequence_id` BIGINT COMMENT 'Self-referencing FK on shift_sequence (rotation_shift_sequence_id)',
    `shift_id` BIGINT COMMENT '',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production line where this shift sequence is applicable.',
    `break_count` STRING COMMENT 'Number of scheduled breaks within the shift.',
    `break_duration_minutes` DECIMAL(18,2) COMMENT 'Total break time in minutes per shift.',
    `shift_sequence_code` STRING COMMENT 'Short alphanumeric code used to identify the shift sequence in systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift sequence record was created.',
    `cycle_length_days` STRING COMMENT '',
    `shift_sequence_description` STRING COMMENT 'Detailed description of the shift sequence purpose and characteristics.',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the shift in minutes.',
    `effective_end_date` DATE COMMENT '',
    `effective_from` DATE COMMENT 'Date when the shift sequence becomes effective.',
    `effective_start_date` DATE COMMENT '',
    `effective_until` DATE COMMENT 'Date when the shift sequence expires (null if indefinite).',
    `end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift (HH:mm, 24‑hour clock).',
    `is_active` BOOLEAN COMMENT '',
    `is_overtime_allowed` BOOLEAN COMMENT 'Indicates if overtime work is permitted during this shift.',
    `labor_category` STRING COMMENT 'Primary labor category assigned to this shift.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `max_workers` STRING COMMENT 'Maximum number of workers allowed simultaneously on this shift.',
    `shift_sequence_name` STRING COMMENT 'Descriptive name of the shift sequence (e.g., Day Shift, Night Shift).',
    `notes` STRING COMMENT 'Additional free‑text notes regarding the shift sequence.',
    `rotation_pattern` STRING COMMENT '',
    `sequence_code` STRING COMMENT '',
    `sequence_name` STRING COMMENT '',
    `sequence_number` STRING COMMENT '',
    `shift_type` STRING COMMENT 'Category of shift based on time of day or work pattern.',
    `start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift (HH:mm, 24‑hour clock).',
    `shift_sequence_status` STRING COMMENT 'Current lifecycle status of the shift sequence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift sequence record.',
    CONSTRAINT pk_shift_sequence PRIMARY KEY(`shift_sequence_id`)
) COMMENT 'Master reference table for shift_sequence. Referenced by shift_sequence_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_version_id` FOREIGN KEY (`version_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`version`(`version_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_reversed_confirmation_order_confirmation_id` FOREIGN KEY (`reversed_confirmation_order_confirmation_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`order_confirmation`(`order_confirmation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ADD CONSTRAINT `fk_production_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_work_center_group_id` FOREIGN KEY (`work_center_group_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center_group`(`work_center_group_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_shift_sequence_id` FOREIGN KEY (`shift_sequence_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift_sequence`(`shift_sequence_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ADD CONSTRAINT `fk_production_version_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_parent_lot_wip_lot_id` FOREIGN KEY (`parent_lot_wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ADD CONSTRAINT `fk_production_production_goods_receipt_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ADD CONSTRAINT `fk_production_resource_tool_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_work_center_group_id` FOREIGN KEY (`work_center_group_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center_group`(`work_center_group_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ADD CONSTRAINT `fk_production_work_order_allocation_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ADD CONSTRAINT `fk_production_work_center_group_parent_work_center_group_id` FOREIGN KEY (`parent_work_center_group_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center_group`(`work_center_group_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ADD CONSTRAINT `fk_production_work_center_group_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ADD CONSTRAINT `fk_production_calendar_base_calendar_id` FOREIGN KEY (`base_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ADD CONSTRAINT `fk_production_shift_sequence_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`calendar`(`calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ADD CONSTRAINT `fk_production_shift_sequence_rotation_shift_sequence_id` FOREIGN KEY (`rotation_shift_sequence_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift_sequence`(`shift_sequence_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ADD CONSTRAINT `fk_production_shift_sequence_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`shift`(`shift_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ADD CONSTRAINT `fk_production_shift_sequence_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot_group' = 'work_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot_master' = 'asset.asset_work_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot_of' = 'production.production_work_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_work_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `takt_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `wip_value` SET TAGS ('dbx_business_glossary_term' = 'Work In Progress (WIP) Value');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `wip_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'standard|rework|prototype|maintenance|sample');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `reversed_confirmation_order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Confirmation ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|posted|reversed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_value_regex' = 'final|partial|backflush|milestone|rework|scrap');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `final_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Confirmation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `goods_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `mes_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `scada_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Serial Numbers');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ERP|MES|SCADA|MANUAL');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `teardown_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `variance_comments` SET TAGS ('dbx_business_glossary_term' = 'Variance Comments');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner User ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cancelled Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `capacity_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Completed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `firmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Firmed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `freeze_horizon_date` SET TAGS ('dbx_business_glossary_term' = 'Freeze Horizon Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Production Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_value_regex' = 'fixed_lot|lot_for_lot|economic_order_quantity|period_order_quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Planning Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket Granularity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon in Weeks');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Production Planning Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority Rank');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Released Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^MPS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source System');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|released|frozen|revised|cancelled|completed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `scheduled_finish_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'shift_1|shift_2|shift_3|day|night|weekend');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `maintenance_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_group_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Group Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `shift_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Sequence ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `available_capacity_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Per Shift');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_value_regex' = 'machine_hours|labor_hours|units_per_hour|setup_hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `capacity_planning_group` SET TAGS ('dbx_business_glossary_term' = 'Capacity Planning Group');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `capacity_planning_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'machine|assembly_line|production_cell|labor_group|inspection_station|packaging_line');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `efficiency_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_business_glossary_term' = 'Formula Key');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `mes_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `number_of_machines` SET TAGS ('dbx_business_glossary_term' = 'Number of Machines');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `number_of_operators` SET TAGS ('dbx_business_glossary_term' = 'Number of Operators');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `oee_baseline_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Baseline Target Percent');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Address');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint|only_capacity_requirements');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `standard_processing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Processing Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `standard_queue_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Queue Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `standard_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Setup Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `standard_teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Teardown Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|planned');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `counter` SET TAGS ('dbx_business_glossary_term' = 'Routing Group Counter');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `counter` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `is_default_routing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Routing Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `is_phantom_routing` SET TAGS ('dbx_business_glossary_term' = 'Is Phantom Routing Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `planner_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_business_glossary_term' = 'Routing Group');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|released|active|inactive|obsolete|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'production|inspection|rework|universal|rate|reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Routing Long Text');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `total_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `total_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Lead Time (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `total_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Machine Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `total_operation_count` SET TAGS ('dbx_business_glossary_term' = 'Total Operation Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Routing Usage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'standard|alternative|trial|prototype|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Production Version ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Version Employee Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `bom_alternative` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Alternative');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `bom_alternative` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `bom_usage` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Usage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `bom_usage` SET TAGS ('dbx_value_regex' = '^[0-9]{1}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Production Version Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `distribution_key` SET TAGS ('dbx_business_glossary_term' = 'Distribution Key');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `distribution_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `is_costing_relevant` SET TAGS ('dbx_business_glossary_term' = 'Costing Relevant Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Production Version Locked Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `is_mrp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevant Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `issue_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Issue Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `lot_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `lot_size_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Version Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_version_code` SET TAGS ('dbx_business_glossary_term' = 'Production Version Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_version_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_version_status` SET TAGS ('dbx_business_glossary_term' = 'Production Version Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `production_version_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|obsolete|under_review|approved');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `receipt_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Receipt Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `receipt_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `task_list_type` SET TAGS ('dbx_business_glossary_term' = 'Task List Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `task_list_type` SET TAGS ('dbx_value_regex' = 'N|R|Q');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Calendar Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Break Duration in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `break_schedule` SET TAGS ('dbx_business_glossary_term' = 'Break Schedule Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_business_glossary_term' = 'Shift Category');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_value_regex' = 'production|non_production|mixed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `changeover_allowance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Allowance in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Applicable Days of Week');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `gross_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Gross Shift Duration in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `handover_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Duration in Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `is_continuous_operation` SET TAGS ('dbx_business_glossary_term' = 'Continuous Operation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `labor_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Multiplier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `net_available_minutes` SET TAGS ('dbx_business_glossary_term' = 'Net Available Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Definition Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `number_of_breaks` SET TAGS ('dbx_business_glossary_term' = 'Number of Scheduled Breaks');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `planned_output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Output Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Shift Priority');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Rotation Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Shift Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Definition Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|weekend|holiday|maintenance|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time in Seconds');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Shift Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `timezone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `actual_good_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Good Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `actual_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `changeover_count` SET TAGS ('dbx_business_glossary_term' = 'Changeover Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Shift Comments');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'MES|SCADA|ERP|MANUAL');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `material_consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Consumed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `material_waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Waste Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `performance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `quality_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `report_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `report_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `throughput_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Rate (Per Hour)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `total_produced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Produced Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_report` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `wip_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Lot Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Current Work Center Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `parent_lot_wip_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `current_operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `current_operation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Current Operation Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `lot_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'released|in_process|on_hold|completed|scrapped|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `original_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Original Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `production_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quantity_completed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Completed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quantity_in_process` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Process');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quantity_on_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hold');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `quantity_scrapped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Scrapped');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot_group' = 'downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot_master' = 'asset.asset_downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot_of' = 'asset.asset_downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_downtime_event');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `production_downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Production Downtime Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `alarm_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Alarm Definition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `tertiary_production_recorded_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `tertiary_production_recorded_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `tertiary_production_recorded_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `asset_downtime_event_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA Alarm Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `alarm_description` SET TAGS ('dbx_business_glossary_term' = 'SCADA Alarm Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Comments');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'breakdown|planned_maintenance|changeover|material_shortage|quality_hold|operator_absence');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_value_regex' = '^DT-[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `impact_on_oee` SET TAGS ('dbx_business_glossary_term' = 'Impact on Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Downtime');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `mttr_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_units` SET TAGS ('dbx_business_glossary_term' = 'Production Loss (Units)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_value` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Value (Currency)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `recurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'production|maintenance|quality|materials|engineering|operations');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Downtime Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_downtime_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Production Goods Receipt ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_goods_receipt_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_goods_receipt_id` SET TAGS ('dbx_ssot_master' = 'procurement.procurement_goods_receipt');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_quality|blocked');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_goods_receipt` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `bom_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Consumption Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Material Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `consumption_notes` SET TAGS ('dbx_business_glossary_term' = 'Consumption Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Consumption Transaction Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `consumption_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled|confirmed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_business_glossary_term' = 'Consumption Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned|scrap|rework|sample');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Material Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `goods_issue_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Material Movement Type Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `original_goods_issue_number` SET TAGS ('dbx_business_glossary_term' = 'Original Goods Issue Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Consumption Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Consumption Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `reservation_item_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Item Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Material Reservation Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Transaction Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Component Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Production Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumption Variance Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `resource_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Tool Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval Days');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `current_usage_cycles` SET TAGS ('dbx_business_glossary_term' = 'Current Usage Cycles');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `resource_tool_description` SET TAGS ('dbx_business_glossary_term' = 'Production Resource Tool (PRT) Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Drawing Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life Years');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `maximum_usage_cycles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Usage Cycles');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Resource Tool (PRT) Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `prt_number` SET TAGS ('dbx_business_glossary_term' = 'Production Resource Tool (PRT) Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `prt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `prt_type` SET TAGS ('dbx_business_glossary_term' = 'Production Resource Tool (PRT) Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `prt_type` SET TAGS ('dbx_value_regex' = 'jig|fixture|mold|die|nc_program|cutting_tool');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `resource_tool_status` SET TAGS ('dbx_business_glossary_term' = 'Production Resource Tool (PRT) Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `resource_tool_status` SET TAGS ('dbx_value_regex' = 'available|in_use|maintenance|calibration|retired|quarantine');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `revision_level` SET TAGS ('dbx_business_glossary_term' = 'Revision Level');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `safety_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `safety_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `safety_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `technical_specification` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `usage_quantity_per_operation` SET TAGS ('dbx_business_glossary_term' = 'Usage Quantity Per Operation');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `usage_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Usage Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`resource_tool` ALTER COLUMN `usage_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `shift_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Run Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `performance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `planned_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `quality_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Production Run Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Production Run Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|active|paused|completed|cancelled|aborted');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Production Run Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'standard|pilot|rework|validation|trial|campaign');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `takt_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `throughput_rate` SET TAGS ('dbx_business_glossary_term' = 'Throughput Rate');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `total_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `total_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Supervisor ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `production_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `production_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `production_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `work_center_group_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Group ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `actual_oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual OEE (Overall Equipment Effectiveness) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|lights_out');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|OPCENTER_MES|SCADA|MDM|MANUAL');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `design_throughput_rate` SET TAGS ('dbx_business_glossary_term' = 'Design Throughput Rate');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `energy_consumption_kwh_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh per Unit)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `erp_work_center_code` SET TAGS ('dbx_business_glossary_term' = 'ERP (Enterprise Resource Planning) Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `layout_diagram_url` SET TAGS ('dbx_business_glossary_term' = 'Line Layout Diagram URL');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Production Line Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'assembly|machining|fabrication|painting|testing|packaging');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mes_line_identifier` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'MTBF (Mean Time Between Failures) Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'MTTR (Mean Time To Repair) Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `number_of_stations` SET TAGS ('dbx_business_glossary_term' = 'Number of Stations');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `planned_availability_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Planned Availability Hours Per Day');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `planned_decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `safety_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `scada_system_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) System Tag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|custom');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `standard_operating_procedure_url` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) URL');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `target_oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target OEE (Overall Equipment Effectiveness) Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `throughput_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Throughput Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `throughput_unit_of_measure` SET TAGS ('dbx_value_regex' = 'units_per_hour|pieces_per_hour|kg_per_hour|liters_per_hour');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` SET TAGS ('dbx_association_edges' = 'production.production_work_order,order.order_line');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `work_order_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Allocation - Work Order Allocation Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Allocation - Order Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Allocation - Production Work Order Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocated_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocated_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_order_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` SET TAGS ('dbx_subdomain' = 'resource_master');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `work_center_group_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Group Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `parent_work_center_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Center Group Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `parent_work_center_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `capacity_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Hour');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `default_shift_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Shift Length Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `group_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `group_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Oee Target Percent');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `work_center_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `total_work_centers` SET TAGS ('dbx_business_glossary_term' = 'Total Work Centers');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot_group' = 'plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot_master' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot_of' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot_canonical' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_ssot_ref' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_ssot_master' = 'asset.asset_plant');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Mw');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Kg');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Mwh');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `maintenance_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Days');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `oee_actual` SET TAGS ('dbx_business_glossary_term' = 'Oee Actual');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `oee_target` SET TAGS ('dbx_business_glossary_term' = 'Oee Target');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `operational_since` SET TAGS ('dbx_business_glossary_term' = 'Operational Since');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `safety_incident_last_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Last Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption M3');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Calendar Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `base_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Base Calendar Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `base_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `calendar_date` SET TAGS ('dbx_business_glossary_term' = 'Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Day Of Month');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day Of Week');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `day_of_year` SET TAGS ('dbx_business_glossary_term' = 'Day Of Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `fiscal_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `holiday_type` SET TAGS ('dbx_business_glossary_term' = 'Holiday Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `is_business_day` SET TAGS ('dbx_business_glossary_term' = 'Is Business Day');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `is_leap_year` SET TAGS ('dbx_business_glossary_term' = 'Is Leap Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `is_weekend` SET TAGS ('dbx_business_glossary_term' = 'Is Weekend');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `iso_week_number` SET TAGS ('dbx_business_glossary_term' = 'Iso Week Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `iso_year` SET TAGS ('dbx_business_glossary_term' = 'Iso Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `month` SET TAGS ('dbx_business_glossary_term' = 'Month');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `month_name` SET TAGS ('dbx_business_glossary_term' = 'Month Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `month_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `month_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `month_start_date` SET TAGS ('dbx_business_glossary_term' = 'Month Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `quarter` SET TAGS ('dbx_business_glossary_term' = 'Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `quarter_name` SET TAGS ('dbx_business_glossary_term' = 'Quarter Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `quarter_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `quarter_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `quarter_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quarter Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `shift_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shift Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `week_of_year` SET TAGS ('dbx_business_glossary_term' = 'Week Of Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `week_start_date` SET TAGS ('dbx_business_glossary_term' = 'Week Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`calendar` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` SET TAGS ('dbx_subdomain' = 'shift_planning');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Sequence Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `rotation_shift_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Rotation Shift Sequence Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `rotation_shift_sequence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `break_count` SET TAGS ('dbx_business_glossary_term' = 'Break Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `is_overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `max_workers` SET TAGS ('dbx_business_glossary_term' = 'Max Workers');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `sequence_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `shift_sequence_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`shift_sequence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
