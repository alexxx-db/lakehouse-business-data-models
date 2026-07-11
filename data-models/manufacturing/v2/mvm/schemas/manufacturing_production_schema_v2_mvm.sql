-- Schema for Domain: production | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`production` COMMENT 'Core manufacturing execution domain governing shop floor control, work orders, routing, scheduling, WIP tracking, cycle time, takt time, throughput, and OEE. Integrates with MES (Siemens Opcenter) and ERP (SAP PP) to orchestrate production runs, machine assignments, capacity planning, and shift-level output reporting via SCADA/DCS systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` (
    `production_work_order_id` BIGINT COMMENT 'Unique identifier for the production work order. Primary key for this entity.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for make-to-order production, if applicable.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Work orders must be traceable to the engineering change order that triggered production for compliance and cost impact analysis.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Work orders must be executed in compliance with the governing engineering specification. PPAP, IATF 16949, and customer quality requirements mandate that work orders reference the applicable engineeri',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: The primary PLC/device executing the work order is tracked for traceability and maintenance scheduling.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Order‑driven work‑order execution requires linking each work order to its sales order for scheduling and cost allocation.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: When a production work order is released, the applicable inspection plan governs in-process quality checks. This is a standard SAP QM / MES integration — production planners need to know which inspect',
    `lifecycle_stage_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle_stage. Business justification: Lifecycle-gated production release: manufacturing systems must prevent work order creation or release for products in EOL/discontinued lifecycle stages. Production planners and MRP systems reference l',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Required for OEE and safety reporting to capture the physical location where each production work order is executed.',
    `material_master_id` BIGINT COMMENT 'Reference to the finished or semi-finished good being produced in this work order.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order‑to‑Production report requires linking each work order to the originating sales opportunity for fulfillment tracking.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP creates planned orders then converts them to production work orders; linking enables traceability in the Production Order Execution Report.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Work order BOM assignment: a production work order is executed against a specific product BOM version for material staging, cost rollup, and variance analysis. Manufacturing planners require this link',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A work order runs on a specific production line; the FK replaces the free‑text line identifier.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for traceability of external component procurement to a work order, used in scheduling and cost reporting.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: MRP/ERP process: a production work order triggers a purchase requisition for required materials. This work-order-to-PR traceability is standard in SAP/ERP manufacturing — planners and buyers use it to',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Engineer-to-order / configure-to-order: prototype and sample work orders are created directly from a quote before formal order intake. Quote-to-actuals cost variance reporting requires linking the wor',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Captures the specific component revision manufactured, enabling quality traceability and regulatory reporting.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.version. Business justification: A production work order is executed using a specific production version, line, and shift. Adding these FKs normalizes the model and removes the redundant string fields.',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.production_run. Business justification: A production_run represents a continuous execution campaign on a production line, and multiple discrete work orders are executed within a single production run. production_work_order belongs to a prod',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Production‑to‑Sales reconciliation needs a direct FK from work order to the sales order intake that generated it, replacing the denormalized sales_order_number.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Work orders must be linked to the SKU produced for inventory, costing, and sales order fulfillment reporting.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location where finished goods from this work order will be received.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or plant location where production is executed.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: A work order is scheduled for a particular shift; the FK provides a proper relational link.',
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
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Production execution traceability: when a confirmation records scrap, rework, or downtime caused by equipment failure, linking to failure_record supports production quality root-cause reporting and re',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Order confirmations carry `inspection_lot_number` (plain-text denormalization). In SAP PP-QM integration, confirming a production operation triggers or references an inspection lot. A proper FK enable',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Confirmation-to-invoice reconciliation: in manufacturing, each production order confirmation (goods movement) must be matched to the invoice raised for that output. This direct FK enables billing audi',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being produced in this operation. Links to the material master record for inventory posting and cost calculation.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order fulfillment handoff: production order confirmations trigger delivery status updates and invoicing on the sales order intake. Direct link enables goods-movement posting and fulfillment reporting ',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Production confirmations post actual output against specific order line items, updating line-level delivery quantities and triggering billing. Standard SAP-style goods receipt confirmation links to th',
    `reversed_confirmation_order_confirmation_id` BIGINT COMMENT 'Reference to the original confirmation record that this reversal confirmation is canceling. Null if this is not a reversal transaction.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: As-built records (IATF 16949, AS9100) require each production confirmation to record the engineering revision active at time of posting. This supports regulatory compliance, warranty claims, and field',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Order confirmations must be tied to the SKU to report actual yield, scrap, and cost per product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Order confirmations post goods movements (goods_movement_type column present). The stock location for goods issue/receipt is required for material document posting in ERP. storage_location_code is a d',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production resource) where this operation was performed. Links to the work center master data defining capacity, cost center, and resource type.',
    `activity_type` STRING COMMENT 'The cost accounting activity type for this confirmation (e.g., machine setup, machine run, manual labor, quality inspection). Used for activity-based costing and rate calculation.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost amount incurred for this confirmation based on actual quantities and actual rates. Used for variance analysis and profitability reporting.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'The total labor hours consumed for this operation confirmation. Used for labor cost calculation and efficiency analysis against standard or planned hours.',
    `actual_machine_hours` DECIMAL(18,2) COMMENT 'The total machine runtime hours consumed for this operation confirmation. Used for machine cost allocation and OEE (Overall Equipment Effectiveness) calculation.',
    `confirmation_number` STRING COMMENT 'Business identifier for the confirmation transaction. Externally visible confirmation document number generated by ERP (SAP CO11N/CO15) or MES system.',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the confirmation record indicating whether it is in draft, submitted for approval, posted to inventory and cost accounting, reversed due to error, or cancelled.. Valid values are `draft|submitted|posted|reversed|cancelled`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the production activity was confirmed on the shop floor. Represents the actual business event time of goods receipt or operation completion.',
    `confirmation_type` STRING COMMENT 'Classification of the confirmation transaction indicating whether it represents a final completion, partial progress, automatic backflush, milestone achievement, rework activity, or scrap reporting.. Valid values are `final|partial|backflush|milestone|rework|scrap`',
    `created_by_user` STRING COMMENT 'The user ID or system account that created this confirmation record. Used for audit trail and accountability in production reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this confirmation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this confirmation record. Typically the plant or company code currency.. Valid values are `^[A-Z]{3}$`',
    `final_confirmation_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this confirmation represents the final completion of the operation. When true, the operation is closed for further confirmations and the work order may proceed to the next operation or completion.',
    `goods_movement_type` STRING COMMENT 'The inventory movement type code triggered by this confirmation (e.g., 101 for goods receipt, 261 for goods issue, 531 for scrap). Aligns with ERP goods movement transaction codes.',
    `last_modified_by_user` STRING COMMENT 'The user ID or system account that last modified this confirmation record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this confirmation record was last updated. Used for change tracking and data synchronization across systems.',
    `material_document_number` STRING COMMENT 'The material document number generated in ERP inventory management when this confirmation posted goods movements. Used for reconciliation between production and inventory systems.',
    `mes_transaction_code` STRING COMMENT 'The unique transaction identifier from the source MES system (e.g., Siemens Opcenter) that originated this confirmation. Used for system integration reconciliation and traceability.',
    `operation_number` STRING COMMENT 'The specific operation sequence number within the work order routing for which this confirmation is recorded. Identifies the production step (e.g., 0010, 0020, 0030) in the manufacturing process.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key.',
    `bom_id` BIGINT COMMENT 'Reference to the bill of materials used for this scheduled production. Defines the material components and structure.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Production schedules in make-to-order manufacturing are directly tied to customer accounts for ATP (Available-to-Promise) reporting and customer-facing delivery commitment management. Planners need to',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Associates production schedule with the plant location to enable plant‑level capacity planning and compliance reporting.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being scheduled for production.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP-driven scheduling: production schedules are generated by MRP runs. Schedulers must know which MRP run produced each schedule to manage re-planning cycles, respond to exception messages, and audit ',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: MRP demand pegging links production schedule requirements to specific sales order lines. This enables pegging reports showing which production schedule covers which order line demand — a standard MRP/',
    `routing_id` BIGINT COMMENT 'Reference to the production routing or process plan used for this schedule. Defines the sequence of operations and work centers.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Master production schedules are created per SKU; linking enables MPS reporting and demand planning.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: MRP scheduling assigns planned output to a target stock location (finished goods staging). Capacity and inventory planning reports require knowing which stock location receives scheduled production ou',
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
    `planning_strategy` STRING COMMENT 'Manufacturing strategy governing how this schedule is planned and executed. Make-to-stock builds for inventory; make-to-order builds against customer orders; assemble-to-order configures from standard components; engineer-to-order designs and builds custom products.. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order`',
    `priority_rank` STRING COMMENT 'Relative priority of this schedule compared to other schedules. Lower numbers indicate higher priority. Used for resource allocation and sequencing decisions.',
    `released_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule was released for execution. Marks the transition from planning to active production.',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to produce the planned quantity, excluding setup and teardown. Used for cycle time analysis.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained to protect against demand variability and supply disruptions. Influences schedule timing and quantities.',
    `schedule_number` STRING COMMENT 'Business identifier for the production schedule. Externally visible schedule reference number used in planning and execution systems.. Valid values are `^MPS-[0-9]{8}-[0-9]{4}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule. Draft schedules are under planning; released schedules are active; frozen schedules are locked for execution; revised schedules have been updated; cancelled schedules are voided; completed schedules are finished.. Valid values are `draft|released|frozen|revised|cancelled|completed`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by planning level. MPS for top-level finished goods; FAS for final assembly operations; RCCP for high-level capacity validation; MRP for detailed component planning.. Valid values are `master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan`',
    `scheduled_finish_date` DATE COMMENT 'Planned date when production for this schedule is expected to be completed. Used for order promising and delivery planning.',
    `scheduled_finish_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to finish, used for detailed capacity loading and sequencing.',
    `scheduled_start_date` DATE COMMENT 'Planned date when production for this schedule is expected to begin. Key input for capacity planning and material availability checks.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to start, including shift and time-of-day information for detailed shop floor scheduling.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to set up equipment and tooling before production can begin. Part of total lead time calculation.',
    `shift_assignment` STRING COMMENT 'Shift during which this production schedule is assigned to run. Used for labor planning and shift-level capacity allocation.. Valid values are `shift_1|shift_2|shift_3|day|night|weekend`',
    `source` STRING COMMENT 'System or process that generated this schedule. MRP run for material requirements planning; APS optimization for advanced planning and scheduling; manual planning for planner-created schedules; demand forecast for forecast-driven schedules; customer order for order-driven schedules.. Valid values are `mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters).. Valid values are `^[A-Z]{2,3}$`',
    `version` STRING COMMENT 'Version number of the schedule. Incremented each time the schedule is revised or replanned.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Master production schedule (MPS) record defining planned production quantities, start/finish dates, and shift assignments for a given production item across a planning horizon. Tracks schedule version, freeze horizon, planning bucket (daily/weekly), and schedule status (draft, released, frozen, revised). Represents the output of APS/MRP II scheduling runs. Sourced from ERP production planning (e.g., SAP PP) and APS systems (e.g., Microsoft Dynamics 365 Supply Chain).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: A work center belongs to a work center group; adding work_center_group_id creates the parent relationship and eliminates the need for ad‑hoc grouping logic.',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this work center is located.',
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
    `mes_integration_enabled` BOOLEAN COMMENT 'Indicates whether this work center is integrated with the MES for real-time shop floor control and data collection.',
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
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Routings are created or revised when an ECO is implemented (new operations, changed tooling, updated cycle times). Linking routing to the triggering ECO supports engineering change management workflow',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Routing operations must conform to engineering process specifications (tolerance specs, surface finish, process capability). IATF 16949 and AS9100 require routings to reference governing engineering s',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Routings define manufacturing process steps; inspection plans define quality checks at those steps. Linking routing to inspection_plan enables automatic inspection plan determination during production',
    `material_master_id` BIGINT COMMENT 'Reference to the material or finished good that this routing produces. Links to the material master in inventory domain.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Routing-BOM pairing for production recipe management: in manufacturing (SAP/ERP standard), a routing is always paired with a product BOM header to form the complete production recipe. This link enable',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `production_plant_id` BIGINT COMMENT 'Manufacturing plant or facility where this routing is executed. Links to plant master data.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Routings are version-controlled against engineering revisions in ERP/PLM integration (SAP PP, Teamcenter). When an engineering revision changes operation sequences or tooling, the routing must referen',
    `approval_date` DATE COMMENT 'Date on which this routing was approved for production use.',
    `approval_status` STRING COMMENT 'Current approval status of the routing. Pending routings await review; approved routings are authorized for production; rejected routings require rework; under_review routings are in the approval workflow.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this routing for production use.',
    `base_quantity` DECIMAL(18,2) COMMENT 'Standard lot size or batch quantity for which the routing times and resource requirements are defined. All operation times are calculated relative to this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity. Standard ISO unit codes such as EA (each), KG (kilogram), L (liter), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `change_number` STRING COMMENT 'Engineering Change Notice (ECN) or Engineering Change Order (ECO) number that authorized the creation or last modification of this routing. Supports traceability of process changes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost amount.. Valid values are `^[A-Z]{3}$`',
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
    `total_operation_count` STRING COMMENT 'Total number of operations (steps) defined in this routing. Derived from routing operation line items.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative setup time in minutes across all operations for the base quantity. Setup time is independent of lot size.',
    `usage` STRING COMMENT 'Intended application context for the routing. Standard routings are the default production method; alternative routings provide backup processes; trial routings support pilot runs; prototype routings support R&D; emergency routings address contingency scenarios.. Valid values are `standard|alternative|trial|prototype|emergency`',
    `usage_count` STRING COMMENT 'Total number of times this routing has been used in production orders or work orders. Indicates routing popularity and stability.',
    `valid_from_date` DATE COMMENT 'Effective start date from which this routing is valid and can be used in production planning and execution.',
    `valid_to_date` DATE COMMENT 'Effective end date after which this routing is no longer valid. Null indicates indefinite validity.',
    `version` STRING COMMENT 'Version identifier for the routing. Supports versioning of routing definitions to track engineering changes and process improvements.. Valid values are `^[A-Z0-9]{1,4}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Manufacturing routing master defining the ordered sequence of operations required to produce a finished or semi-finished item. Captures routing number, routing type (production, inspection, universal), base quantity, status, and validity dates. Each routing is composed of individual operations (modeled as line items) linked to work centers with standard times for setup, machine run, and labor. The SSOT for standard production process definitions. Sourced from ERP routing master (e.g., SAP CA01) and PLM process plans (e.g., Siemens Teamcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` (
    `wip_lot_id` BIGINT COMMENT 'Unique identifier for the work-in-progress lot or batch. Primary key for the WIP lot tracking entity.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: WIP lot traceability to customer account is required for customer-specific quality holds, product recall management, and regulatory traceability reporting in make-to-order manufacturing. Direct FK avo',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Lots produced under a specific engineering change order need linkage for compliance and cost reporting.',
    `engineering_bom_line_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_bom_line. Business justification: WIP lot genealogy and component traceability require knowing which BOM line a WIP lot corresponds to. Quality investigations, recall management, and as-built records depend on this link. bom_consumpti',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Links WIP lot to its plant location for lot traceability and site‑specific quality control.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record representing the product or component being manufactured in this lot.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: WIP lots originate from material requirements; linking enables requirement fulfillment analysis and variance reporting in the WIP Requirement Traceability report.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: WIP lots are created to fulfill specific order line items in make-to-order manufacturing. Linking wip_lot to order.line enables lot traceability per order line — critical for batch/serial-tracked manu',
    `parent_lot_wip_lot_id` BIGINT COMMENT 'Reference to the parent WIP lot if this lot was split or derived from another lot. Enables genealogy and traceability tracking.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: A WIP lot is generated from a specific production work order; linking removes the ambiguous order number field.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Lot tracking must record the component revision to ensure traceability for quality investigations.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing defining the sequence of operations this lot must traverse.',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.production_run. Business justification: A WIP lot is created and tracked during a production run — the lot physically exists on the shop floor as part of an active production campaign. Linking wip_lot.production_run_id -> production_run ena',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: WIP lot tracking requires the SKU identifier for traceability, quality inspection, and regulatory compliance.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: WIP lots physically reside in a shop-floor stock location. WIP inventory tracking and shop-floor control require a proper FK to stock_location. The plain column storage_location_code is a denormalized',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the lot actually completed all operations and was confirmed as finished. Null if lot is still in process.',
    `batch_number` STRING COMMENT 'Batch identifier for process industries where multiple lots may be grouped into a single batch for traceability or quality purposes.',
    `current_operation_sequence` STRING COMMENT 'Sequence number of the operation currently being performed on this lot within the routing. Used to track progress through the production process.',
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
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this lot record (e.g., EA for each, KG for kilograms, M for meters).',
    CONSTRAINT pk_wip_lot PRIMARY KEY(`wip_lot_id`)
) COMMENT 'Work-in-progress (WIP) lot or batch tracking entity representing a discrete quantity of material currently being processed through the production routing. Captures lot number, material number, current operation, current work center, quantity in process, quantity completed, quantity scrapped, lot creation timestamp, and lot status (in-process, on-hold, completed, scrapped). Enables real-time WIP visibility, genealogy tracing, and shop floor material flow tracking. Sourced from MES lot tracking (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` (
    `bom_consumption_id` BIGINT COMMENT 'Primary key for bom_consumption',
    `engineering_bom_line_id` BIGINT COMMENT 'Reference to the specific BOM line item that defines the planned component requirement. Links actual consumption to engineering BOM specification.',
    `inspection_lot_id` BIGINT COMMENT 'Reference to the quality inspection lot if the component underwent inspection before consumption. Links consumption to quality control records.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: BOM consumption records which specific inventory lot/batch was consumed. This is the core of lot genealogy — mandatory for backward traceability in regulated manufacturing. batch_number and vendor_bat',
    `material_master_id` BIGINT COMMENT 'Reference to the component material consumed from inventory. Identifies the specific raw material, sub-assembly, or component issued to production.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Material variance analysis: cost accountants and supply planners compare MRP-planned material requirements against actual BOM consumption to calculate material usage variances. This is a core manufact',
    `production_line_id` BIGINT COMMENT 'add column production_line_id (BIGINT) with FK to production.production_line.production_line_id - BOM consumption occurs on specific production lines for traceability',
    `production_work_order_id` BIGINT COMMENT 'Reference to the parent work order for which materials were consumed. Links consumption to the manufacturing execution context.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Material consumption entries need the SKU to roll up costs and efficiency metrics to the final product.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location or bin within the warehouse from which material was picked. Provides granular inventory tracking.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse from which the component material was issued. Identifies the physical storage facility.',
    `wip_lot_id` BIGINT COMMENT 'Foreign key linking to production.wip_lot. Business justification: bom_consumption records the actual goods issue of raw materials and components consumed during production. This consumption is directly tied to a specific WIP lot being processed — the lot that consum',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost per unit of the component material based on moving average price or FIFO/LIFO valuation. Reflects real inventory valuation at consumption time.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of component material issued from inventory to the work order. Represents the real consumption recorded via goods issue or backflush.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether this consumption was automatically backflushed by the MES system upon work order confirmation (true) or manually posted (false).',
    `consumption_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the consumption event. Captures operator notes and exception details.',
    `consumption_status` STRING COMMENT 'Current status of the consumption record: posted (finalized in ERP), pending (awaiting confirmation), reversed (cancelled), cancelled (voided), confirmed (validated by supervisor).. Valid values are `posted|pending|reversed|cancelled|confirmed`',
    `consumption_type` STRING COMMENT 'Classification of the consumption event: planned (per BOM), unplanned (ad-hoc issue), scrap (defective material), rework (reprocessing), or sample (quality testing).. Valid values are `planned|unplanned|scrap|rework|sample`',
    `cost_center_code` STRING COMMENT 'The cost center to which the material consumption cost is allocated. Used for internal cost accounting and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this consumption record was first created in the data warehouse. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts (e.g., USD, EUR, CNY). Ensures consistent financial reporting across global operations.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration or shelf-life date of the consumed component material. Critical for perishable materials, chemicals, and time-sensitive components.',
    `goods_issue_number` STRING COMMENT 'The ERP-generated document number for the material goods issue transaction. Typically corresponds to SAP movement type 261 for production consumption.',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'The date and time when the material goods issue transaction was posted in the ERP system. Represents the official consumption event time.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this consumption record was last updated in the data warehouse. Tracks data change history for audit and reconciliation.',
    `movement_type` STRING COMMENT 'Three-digit SAP movement type code indicating the nature of the goods issue. Common values: 261 (goods issue to order), 262 (reversal of 261).. Valid values are `^[0-9]{3}$`',
    `operation_number` STRING COMMENT 'The routing operation sequence number at which the component was consumed. Links consumption to the specific production step in the routing.',
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
    `work_center_code` STRING COMMENT 'The code identifying the work center or production resource where the component was consumed. Enables cost center allocation and capacity analysis.',
    CONSTRAINT pk_bom_consumption PRIMARY KEY(`bom_consumption_id`)
) COMMENT 'Component material consumption record capturing the actual goods issue of raw materials and components from inventory to a work order during production execution. Tracks component material number, planned vs. actual issued quantity, variance quantity, unit of measure, storage location, batch number, and backflush indicator. Enables actual vs. planned BOM consumption variance analysis for cost control and material planning feedback. Sourced from ERP goods issue postings (e.g., SAP movement type 261) and MES backflush events.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Unique identifier for the production line. Primary key for the production line master entity.',
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.asset_plant. Business justification: Cybersecurity compliance and network topology reports need to know which network segment each line resides in.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Line configuration & maintenance uses a specific control system; OEE and maintenance reports require linking line to its control system.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Each production line has a designated finished goods output staging stock location. Line-level WMS integration and finished goods put-away routing require this link. Role prefix output_ identifies t',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Production lines are established or upgraded through engineering projects (NPI, line expansion, automation). Linking production_line to the engineering project that designed or commissioned it support',
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
    `operational_status` STRING COMMENT 'Current operational state of the production line indicating availability for production scheduling and capacity planning.. Valid values are `active|inactive|maintenance|standby|decommissioned`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`production_plant` (
    `production_plant_id` BIGINT COMMENT 'Primary key for plant',
    `asset_plant_id` BIGINT COMMENT 'Foreign key linking to asset.asset_plant. Business justification: Unified plant master: production_plant and asset_plant represent the same physical facility from production and asset management perspectives. Linking them enables consolidated plant-level reporting (',
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
    `operational_since` DATE COMMENT 'Date the plant began commercial operations.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary function.',
    `production_plant_status` STRING COMMENT 'Current operational state of the plant.',
    `region` STRING COMMENT 'Higher‑level region (e.g., North America, EMEA) for reporting.',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents in the reporting period.',
    `safety_incident_last_date` DATE COMMENT 'Date of the most recent safety incident.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Quantity of waste produced by the plant in metric tons.',
    `water_consumption_m3` DECIMAL(18,2) COMMENT 'Total water usage for the reporting period in cubic metres.',
    CONSTRAINT pk_production_plant PRIMARY KEY(`production_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`production`.`run` (
    `run_id` BIGINT COMMENT 'Primary key for run',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In make-to-order manufacturing, production runs are executed for specific customer delivery sites. Site-level OEE reporting, delivery scheduling, and on-time delivery KPIs require linking production_r',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials used for this production run, defining the component structure and recipe.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this production run is being executed, applicable for make-to-order scenarios.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Engineering change management requires tracing which ECO was in effect during a production run. Run-level ECO reference supports change audit trails and customer-facing quality records. production_wor',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Family-level OEE and capacity reporting: production runs are aggregated by product family for S&OP dashboards, family-level OEE benchmarking, and campaign scheduling. production_work_order already car',
    `location_id` BIGINT COMMENT 'FK to production.shift',
    `material_master_id` BIGINT COMMENT 'Reference to the primary material or product being manufactured in this production run.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP traceability reporting: supply planners and production controllers must trace which MRP run initiated each production run to measure planning accuracy, analyze variances, and close the MRP feedbac',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Production runs execute against specific order line items in make-to-order/campaign manufacturing. Linking production_run to order.line enables run-level fulfillment reporting per line — which product',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: ISO 9001/IATF 16949 as-built traceability requires knowing which engineering revision was active during each production run. Run-level revision tracking supports recall management and customer quality',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: production_run already carries a routing_number (STRING) attribute, which is a denormalized reference to the routing master. Normalizing this to a proper FK routing_id -> routing.routing_id eliminates',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to production.production_schedule. Business justification: A production_run is the execution of a planned production_schedule. The schedule defines what to produce (planned quantities, dates, routing), and the run captures the actual execution. Linking produc',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Each production run must reference the SKU to calculate yield, OEE, and cost per product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Finished goods put-away process: when a production run completes, output is received into a specific stock location. Production-to-inventory goods receipt posting and run-level inventory reconciliatio',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where finished goods from this run are received.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this production run, including material, labor, and overhead costs.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution was completed or terminated.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Total actual quantity produced during this run, representing the sum of good output across all work orders.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution began on the shop floor.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Equipment availability during the production run, calculated as (operating time / planned production time) * 100.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_run_id` FOREIGN KEY (`run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`run`(`run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_reversed_confirmation_order_confirmation_id` FOREIGN KEY (`reversed_confirmation_order_confirmation_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`order_confirmation`(`order_confirmation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_parent_lot_wip_lot_id` FOREIGN KEY (`parent_lot_wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ADD CONSTRAINT `fk_production_wip_lot_run_id` FOREIGN KEY (`run_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`run`(`run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_wip_lot_id` FOREIGN KEY (`wip_lot_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`wip_lot`(`wip_lot_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`routing`(`routing_id`);
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ADD CONSTRAINT `fk_production_run_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_manufacturing_v1`.`production`.`schedule`(`schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `lifecycle_stage_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Version Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Production Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_work_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `reversed_confirmation_order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Confirmation ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`order_confirmation` ALTER COLUMN `actual_machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Hours');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` SET TAGS ('dbx_subdomain' = 'planning_resources');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cancelled Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `capacity_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Completed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `firmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Firmed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `freeze_horizon_date` SET TAGS ('dbx_business_glossary_term' = 'Freeze Horizon Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Production Lead Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_value_regex' = 'fixed_lot|lot_for_lot|economic_order_quantity|period_order_quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Planning Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket Granularity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon in Weeks');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Production Planning Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority Rank');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Released Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^MPS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|released|frozen|revised|cancelled|completed');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type Classification');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `scheduled_finish_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time in Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'shift_1|shift_2|shift_3|day|night|weekend');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source System');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'planning_resources');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Group Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `number_of_machines` SET TAGS ('dbx_business_glossary_term' = 'Number of Machines');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `number_of_operators` SET TAGS ('dbx_business_glossary_term' = 'Number of Operators');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `oee_baseline_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Baseline Target Percent');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Address');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'planning_resources');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `wip_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Progress (WIP) Lot Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `parent_lot_wip_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Lot Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Production Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`wip_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `bom_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Consumption Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `wip_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wip Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Consumption Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator Flag');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`bom_consumption` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` SET TAGS ('dbx_subdomain' = 'planning_resources');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Output Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'assembly|machining|fabrication|painting|testing|packaging');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mes_line_identifier` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'MTBF (Mean Time Between Failures) Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'MTTR (Mean Time To Repair) Hours');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `number_of_stations` SET TAGS ('dbx_business_glossary_term' = 'Number of Stations');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|standby|decommissioned');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` SET TAGS ('dbx_subdomain' = 'planning_resources');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `asset_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `oee_actual` SET TAGS ('dbx_business_glossary_term' = 'Oee Actual');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `oee_target` SET TAGS ('dbx_business_glossary_term' = 'Oee Target');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `operational_since` SET TAGS ('dbx_business_glossary_term' = 'Operational Since');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `production_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `safety_incident_last_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Last Date');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`production_plant` ALTER COLUMN `water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption M3');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `location_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`production`.`run` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
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
