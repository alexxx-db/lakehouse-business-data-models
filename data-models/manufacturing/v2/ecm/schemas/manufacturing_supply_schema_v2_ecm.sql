-- Schema for Domain: supply | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`supply` COMMENT 'Supply chain planning and demand management domain covering MRP/MRP II runs, demand forecasting, capacity planning, APS scheduling, supplier lead times, MOQ management, supply risk, multi-tier supplier coordination, and supply network optimization. Integrates Microsoft Dynamics 365 SCM and SAP PP/MM for end-to-end supply network visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` (
    `mrp_run_id` BIGINT COMMENT 'Unique identifier for the MRP/MRP II planning run execution. Primary key.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: MRP run generation must consider active Engineering Change Orders to adjust material plans; the MRP Run Report includes ECO impact, requiring mrp_run.eco_id FK to engineering.eco.eco_id.',
    `employee_id` BIGINT COMMENT 'User ID or system account that initiated or triggered this MRP run. Used for audit trail and accountability.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when this MRP run completed or terminated. Used to calculate run duration and identify performance bottlenecks.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when this MRP run began execution. Key audit field for tracking planning run performance and compliance with scheduling windows.',
    `bom_explosion_level` STRING COMMENT 'Maximum depth of BOM explosion performed during this MRP run. Indicates how many levels down the product structure the planning calculation extended (e.g., 1 for single-level, 99 for full multi-level explosion).',
    `completion_notes` STRING COMMENT 'Free-text notes or comments entered by planners or system administrators regarding the outcome, issues, or special circumstances of this MRP run.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this MRP run record was first created in the system. Audit field for data lineage and compliance.',
    `demand_time_fence_days` STRING COMMENT 'Number of days from the run date within which the MRP system does not automatically create, reschedule, or cancel planned orders. Defines the frozen zone where manual intervention is required.',
    `error_messages_count` STRING COMMENT 'Total number of error messages generated during this MRP run that prevented successful completion or caused partial failures.',
    `exception_messages_count` STRING COMMENT 'Total number of exception or warning messages generated during this MRP run, indicating planning issues such as material shortages, capacity overloads, or invalid master data.',
    `include_forecast_flag` BOOLEAN COMMENT 'Indicates whether demand forecast data was included in the MRP calculation (True) or only firm customer orders were considered (False).',
    `include_safety_stock_flag` BOOLEAN COMMENT 'Indicates whether safety stock requirements were included in the MRP calculation (True) or excluded (False).',
    `include_wip_flag` BOOLEAN COMMENT 'Indicates whether existing work-in-progress inventory was considered as available supply during this MRP run (True) or excluded (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this MRP run record was last updated. Audit field for tracking changes to run status or metadata.',
    `lead_time_offset_days` STRING COMMENT 'Global lead time offset (in days) applied to all planned orders during this MRP run to account for additional buffer time beyond standard procurement or production lead times.',
    `lot_sizing_rule` STRING COMMENT 'Default lot sizing method applied during this MRP run for planned order quantity calculation: lot-for-lot (LFL), fixed lot size, economic order quantity (EOQ), or period order quantity (POQ).. Valid values are `lot_for_lot|fixed_lot_size|economic_order_quantity|period_order_quantity`',
    `materials_processed_count` STRING COMMENT 'Total number of material master records processed during this MRP run. Indicates the scope and scale of the planning calculation.',
    `planned_orders_cancelled_count` STRING COMMENT 'Total number of existing planned orders that were cancelled by this MRP run because they were no longer needed to satisfy material requirements.',
    `planned_orders_created_count` STRING COMMENT 'Total number of new planned orders (purchase requisitions or production orders) created by this MRP run to satisfy material requirements.',
    `planned_orders_rescheduled_count` STRING COMMENT 'Total number of existing planned orders that were rescheduled (date or quantity changed) by this MRP run due to changes in demand or supply.',
    `planning_horizon_days` STRING COMMENT 'Total number of days covered by the planning horizon for this MRP run, calculated from start to end date.',
    `planning_horizon_end_date` DATE COMMENT 'End date of the planning horizon for this MRP run. Defines the end of the period for which material requirements are calculated.',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the planning horizon for this MRP run. Defines the beginning of the period for which material requirements are calculated.',
    `planning_mode` STRING COMMENT 'Manufacturing planning strategy applied during this MRP run: make-to-stock (MTS), make-to-order (MTO), assemble-to-order (ATO), or engineer-to-order (ETO).. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order`',
    `planning_time_fence_days` STRING COMMENT 'Number of days from the run date within which the MRP system can reschedule but not create new planned orders. Defines the slushy zone between frozen and free planning periods.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code for which this MRP run was executed. Defines the scope of materials and production resources included in the planning calculation.',
    `routing_explosion_flag` BOOLEAN COMMENT 'Indicates whether production routing and work center capacity requirements were calculated during this MRP run (True) or only material requirements were computed (False).',
    `run_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes from actual start to actual end of the MRP run. Key performance indicator for planning system efficiency.',
    `run_number` STRING COMMENT 'Business-facing identifier for the MRP run, typically system-generated or user-assigned for tracking and audit purposes.',
    `run_parameters_json` STRING COMMENT 'JSON-formatted string containing additional MRP run configuration parameters and settings not captured in dedicated columns. Enables flexible storage of system-specific or advanced planning parameters.',
    `run_status` STRING COMMENT 'Current execution status of the MRP run: scheduled (queued for execution), running (in progress), completed (successfully finished), failed (terminated with errors), or cancelled (manually aborted).. Valid values are `scheduled|running|completed|failed|cancelled`',
    `run_type` STRING COMMENT 'Type of MRP planning run executed: regenerative (full recalculation of all materials), net_change (incremental update based on changes since last run), single_level (one BOM level), or multi_level (full BOM explosion).. Valid values are `regenerative|net_change|single_level|multi_level`',
    `safety_stock_method` STRING COMMENT 'Safety stock calculation method applied during this MRP run: fixed quantity, days of supply, statistical (based on demand variability), or none.. Valid values are `fixed_quantity|days_of_supply|statistical|none`',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when this MRP run was scheduled to begin execution.',
    `scheduling_method` STRING COMMENT 'Scheduling algorithm applied during this MRP run: forward (schedule from earliest start), backward (schedule from due date), finite (capacity-constrained), or infinite (no capacity constraints).. Valid values are `forward|backward|finite|infinite`',
    `source_system_code` STRING COMMENT 'Code identifying the source ERP or planning system that executed this MRP run (e.g., SAP_PP, DYNAMICS_SCM, OPCENTER_APS).',
    CONSTRAINT pk_mrp_run PRIMARY KEY(`mrp_run_id`)
) COMMENT 'Captures each MRP/MRP II planning run execution, recording planning horizon, run type (regenerative vs. net change), plant scope, planning parameters, BOM/routing explosion level, and completion status. Serves as the authoritative audit record of when and how material requirements were calculated, enabling traceability of all planned orders and material requirements back to their originating MRP execution in SAP PP/MM or Microsoft Dynamics 365 SCM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` (
    `planned_order_id` BIGINT COMMENT 'Unique identifier for the planned order generated by MRP/APS system. Primary key.',
    `bom_id` BIGINT COMMENT 'Reference to the bill of materials that defines the component requirements for this planned production order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Procurement Cost Allocation Report assigns each planned order to a cost center for budgeting and cost accounting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Make‑to‑order production planning requires linking each planned order to the originating customer account for order tracking and delivery scheduling.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Production scheduling uses a specific component revision; the Planned Order Detail report references engineering.revision.revision_id to ensure the correct version is manufactured.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this planned order was generated.',
    `mrp_run_id` BIGINT COMMENT 'Unique identifier of the MRP or APS planning execution that generated this planned order.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Planned orders in make‑to‑order environments originate from a specific sales order; linking enables the Planned Order to Sales Order Traceability process.',
    `employee_id` BIGINT COMMENT 'User ID of the planner who firmed this planned order, locking it from automatic replanning.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to automation.recipe. Business justification: Associates each planned order with the recipe governing its production steps, required for the Order‑Recipe Traceability dashboard.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing that defines the sequence of operations and work centers for manufacturing this material.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Planned orders are created from confirmed order intake; linking enables order‑to‑production tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Production planning ties each planned order to the SKU master for cost, compliance, and reporting of the manufactured product.',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred supplier for this material when the order type is purchase requisition or subcontract order.',
    `available_capacity_hours` DECIMAL(18,2) COMMENT 'Production capacity in hours available at the work center or plant for executing this planned order, used for capacity planning validation.',
    `converted_order_number` STRING COMMENT 'Document number of the production order, purchase requisition, or stock transfer order created when this planned order was converted to an executable order.',
    `converted_timestamp` TIMESTAMP COMMENT 'Date and time when the planned order was converted to an executable order.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this planned order record was first created in the system by the planning run.',
    `deletion_flag` BOOLEAN COMMENT 'Indicator that this planned order has been marked for deletion by a subsequent planning run because the requirement no longer exists or has been satisfied by other means.',
    `exception_code` STRING COMMENT 'Code identifying planning exceptions or issues requiring planner intervention (e.g., capacity overload, material shortage, lead time violation, MOQ conflict).',
    `exception_message` STRING COMMENT 'Detailed description of the planning exception or constraint violation that requires planner review and resolution.',
    `firmed_timestamp` TIMESTAMP COMMENT 'Date and time when the planned order was firmed by the planner.',
    `firming_indicator` BOOLEAN COMMENT 'Flag indicating whether this planned order has been firmed by the planner, preventing it from being automatically changed or deleted by subsequent planning runs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this planned order record was last updated, either by a subsequent planning run or by manual planner intervention.',
    `lot_size_rule` STRING COMMENT 'Lot sizing method applied by the planning system: exact_quantity (order exact requirement), moq (minimum order quantity), fixed_lot (standard batch size), or rounding (round up to packaging unit).. Valid values are `exact_quantity|moq|fixed_lot|rounding`',
    `moq_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity constraint from the supplier or production process that was applied during lot sizing.',
    `mrp_controller` STRING COMMENT 'Code identifying the planner or planning group responsible for reviewing and converting this planned order.. Valid values are `^[A-Z0-9]{3,10}$`',
    `multi_tier_supplier_flag` BOOLEAN COMMENT 'Indicator that this planned order requires coordination across multiple tiers of the supply network (e.g., raw material supplier, component manufacturer, final assembly).',
    `order_type` STRING COMMENT 'Type of replenishment action proposed by the planning system: production order for in-house manufacturing, purchase requisition for external procurement, stock transfer for inter-plant movement, or subcontract order for external processing.. Valid values are `production_order|purchase_requisition|stock_transfer|subcontract_order`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material proposed for replenishment by the planning run, expressed in base unit of measure.',
    `planner_notes` STRING COMMENT 'Free-text comments entered by the planner documenting decisions, constraints, or coordination details related to this planned order.',
    `planner_override_date` DATE COMMENT 'Manually adjusted scheduled finish date entered by the planner to override the system-calculated date based on capacity constraints or customer negotiation.',
    `planner_override_quantity` DECIMAL(18,2) COMMENT 'Manually adjusted quantity entered by the planner to override the system-calculated planned quantity based on business judgment or known constraints.',
    `planning_run_timestamp` TIMESTAMP COMMENT 'Date and time when the planning run that created this planned order was executed.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or distribution center where the planned order will be executed.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_code` STRING COMMENT 'Planning priority assigned to this order based on demand urgency, customer importance, or supply risk. Critical orders require immediate planner attention.. Valid values are `critical|high|medium|low`',
    `procurement_lead_time_days` STRING COMMENT 'Number of days required to procure or produce the material, used by the planning system to calculate scheduled start date from requirement date.',
    `proposal_status` STRING COMMENT 'Current lifecycle state of the planned order proposal: open (awaiting planner review), under_review (being evaluated), firmed (approved for conversion), converted (released to execution), rejected (not needed), or cancelled (superseded by new planning run).. Valid values are `open|under_review|firmed|converted|rejected|cancelled`',
    `required_capacity_hours` DECIMAL(18,2) COMMENT 'Production capacity in hours required to complete this planned order based on routing and quantity.',
    `requirement_date` DATE COMMENT 'Date when the material is needed to fulfill a sales order, production order component, or safety stock replenishment.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock level maintained to protect against demand variability or supply disruptions, factored into the planning calculation.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when the material should be available to satisfy the downstream requirement or customer demand.',
    `scheduled_start_date` DATE COMMENT 'Planned date when production or procurement activities should begin to meet the requirement date, calculated backward from finish date using lead time.',
    `source_requirement_number` STRING COMMENT 'Document number of the originating requirement (sales order, production order, forecast entry) that drove the creation of this planned order.',
    `source_requirement_type` STRING COMMENT 'Type of demand that triggered the creation of this planned order: sales order (customer demand), production order (component requirement), safety stock (replenishment), forecast (anticipated demand), or service order (spare parts).. Valid values are `sales_order|production_order|safety_stock|forecast|service_order`',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score (0-100) indicating the likelihood of supply disruption for this planned order based on supplier performance, lead time volatility, and geopolitical factors.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for the planned quantity (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_planned_order PRIMARY KEY(`planned_order_id`)
) COMMENT 'Represents a planned production, procurement, or stock transfer order generated by MRP/APS to satisfy a material requirement. Consolidates all replenishment proposals awaiting planner review through to firmed orders ready for conversion. Tracks planned quantity, scheduled start/finish dates, order type (production order, purchase requisition, stock transfer), priority, firming status, proposal lifecycle (open, under review, firmed, converted, rejected), planner override details, converting planner ID, and the material/plant combination. Serves as the single actionable output of MRP runs requiring human review before release to procurement or production. Sourced from SAP PP/MM and Microsoft Dynamics 365 SCM planning outputs.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Unique identifier for the demand forecast record. Primary key for the demand forecast entity.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific demand forecasts are generated per account to support sales‑aligned planning and KPI reporting.',
    `demand_plan_version_id` BIGINT COMMENT 'Reference to the forecast version record enabling scenario comparison and version lineage tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this forecast version in the workflow. Used for accountability and audit trail in demand planning governance.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or item being forecasted. Links to the material master record in inventory domain.',
    `forecast_id` BIGINT COMMENT 'Foreign key linking to sales.forecast. Business justification: Demand forecasting aligns internal plans with external sales forecasts; linking enables S&OP reconciliation.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Forecasting uses the SKU master to align demand quantities with product specifications and pricing.',
    `stock_location_id` BIGINT COMMENT 'Reference to the planning location, warehouse, or distribution center for which demand is forecasted.',
    `approval_comments` STRING COMMENT 'Comments or notes provided by the approver during the forecast approval workflow, documenting decision rationale or conditions.',
    `bias_percent` DECIMAL(18,2) COMMENT 'Systematic forecast bias expressed as percentage, indicating tendency to over-forecast (positive) or under-forecast (negative). Used to detect and correct systematic errors.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the forecast confidence interval, representing the pessimistic demand scenario for risk analysis and safety stock planning.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the forecast confidence interval, representing the optimistic demand scenario for capacity planning and supply risk assessment.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level of the forecast interval expressed as a percentage (e.g., 95.00 for 95% confidence). Used for supply planning sensitivity analysis.',
    `consensus_approval_date` DATE COMMENT 'Date when the forecast achieved consensus approval in the Sales and Operations Planning (S&OP) process, marking it as the agreed demand plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_segment_code` STRING COMMENT 'Code identifying the customer segment or channel for which this forecast applies (e.g., OEM, AFTERMARKET, DISTRIBUTOR). Enables segment-level demand planning.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `demand_class` STRING COMMENT 'Classification of demand type: independent (end-customer driven, forecasted) or dependent (derived from BOM and parent item demand via MRP explosion).. Valid values are `independent|dependent`',
    `demand_pattern` STRING COMMENT 'Characterization of the historical demand behavior pattern used to select appropriate forecasting models and safety stock strategies.. Valid values are `stable|seasonal|trending|intermittent|lumpy|erratic`',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'Historical accuracy percentage of the forecast model for this material-location combination, calculated as (1 - MAPE) * 100. Used for model selection and tuning.',
    `forecast_consumption_flag` BOOLEAN COMMENT 'Indicates whether this forecast is subject to consumption by actual customer orders in the MRP logic. Controls forecast vs. order-driven planning behavior.',
    `forecast_generation_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast was generated by the forecasting engine or planning system. Represents the business event time of forecast creation.',
    `forecast_horizon_days` STRING COMMENT 'Number of days into the future that this forecast covers, calculated from the planning period start date. Used for lead time coverage analysis.',
    `forecast_model_code` STRING COMMENT 'Code identifying the statistical or algorithmic model used to generate the forecast (e.g., ARIMA, EXP_SMOOTH, MOVING_AVG, ML_ENSEMBLE).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `forecast_model_name` STRING COMMENT 'Human-readable name of the forecasting model or algorithm applied to generate this forecast.',
    `forecast_number` STRING COMMENT 'Business identifier for the forecast record, externally visible and used for tracking and reference in planning meetings.. Valid values are `^FC-[0-9]{8}-[0-9]{4}$`',
    `forecast_quantity` DECIMAL(18,2) COMMENT 'Predicted demand quantity for the material at the specified location during the planning period. Core forecast value used for MRP and capacity planning.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record in the approval workflow. Tracks progression from draft through approval or rejection.. Valid values are `draft|submitted|under_review|approved|rejected|obsolete`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this forecast record, tracking manual adjustments or workflow updates.',
    `mean_absolute_percentage_error` DECIMAL(18,2) COMMENT 'MAPE metric measuring forecast error as a percentage of actual demand. Lower values indicate better forecast accuracy. Key KPI for demand planning performance.',
    `mrp_area_code` STRING COMMENT 'MRP area code defining the planning scope and organizational unit for material requirements planning execution.. Valid values are `^[A-Z0-9]{2,4}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about this forecast record, capturing planner insights, assumptions, or special considerations.',
    `outlier_flag` BOOLEAN COMMENT 'Indicates whether this forecast was flagged as a statistical outlier requiring review. Used for data quality monitoring and exception management.',
    `outlier_reason` STRING COMMENT 'Explanation for why this forecast was flagged as an outlier, documenting the business or statistical reason for the exception.',
    `planning_group_code` STRING COMMENT 'Code identifying the planning group or demand planner responsible for this forecast. Used for workload distribution and accountability.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period for which this forecast applies. Defines the end of the demand horizon.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period for which this forecast applies. Defines the beginning of the demand horizon.',
    `product_lifecycle_stage` STRING COMMENT 'Current stage of the product in its lifecycle. Influences forecasting model selection and demand pattern expectations.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `promotional_flag` BOOLEAN COMMENT 'Indicates whether this forecast includes promotional or campaign-driven demand uplift. Used to separate base demand from promotional spikes.',
    `promotional_uplift_percent` DECIMAL(18,2) COMMENT 'Expected percentage increase in demand due to promotional activities during the planning period. Used for promotional planning and inventory pre-positioning.',
    `sales_adjustment_quantity` DECIMAL(18,2) COMMENT 'Manual adjustment quantity applied by sales team to the statistical baseline forecast, reflecting market intelligence and customer commitments.',
    `sales_adjustment_reason` STRING COMMENT 'Business justification for the sales adjustment, documenting market intelligence, customer commitments, or promotional activities driving the override.',
    `scenario_name` STRING COMMENT 'Name of the planning scenario this forecast belongs to (e.g., Base Case, Optimistic, Pessimistic, New Product Launch). Enables scenario comparison and sensitivity analysis.',
    `seasonality_index` DECIMAL(18,2) COMMENT 'Seasonal adjustment factor applied to the forecast for this planning period. Values above 1.0 indicate peak season, below 1.0 indicate off-season.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that generated or provided this forecast record (e.g., D365_SCM, SAP_APO, CUSTOM_MODEL).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `trend_coefficient` DECIMAL(18,2) COMMENT 'Trend component coefficient from the forecasting model, indicating the rate of demand growth or decline over time.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the forecast quantity (e.g., EA for each, KG for kilogram, L for liter). Must align with material master base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `version_type` STRING COMMENT 'Classification of the forecast version: baseline (statistical model output), sales_adjusted (sales team input), consensus (S&OP aligned), approved (final for MRP), or working (draft).. Valid values are `baseline|sales_adjusted|consensus|approved|working`',
    CONSTRAINT pk_demand_forecast PRIMARY KEY(`demand_forecast_id`)
) COMMENT 'Stores version-aware demand forecast records supporting scenario comparison and consensus planning. Captures statistical baseline forecasts, sales-adjusted forecasts, consensus forecasts, and approved forecasts with full version lineage. Each record includes forecast quantity, forecast horizon, forecast model used, confidence interval, demand class (independent vs. dependent), item/location combination, version type, version approval workflow status, and planning period. Supports S&OP processes by maintaining multiple demand scenarios for supply planning sensitivity analysis. Sourced from Microsoft Dynamics 365 SCM demand planning module.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`plan` (
    `plan_id` BIGINT COMMENT 'Primary key for plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supply Plan vs Budget variance analysis requires linking each supply plan to its responsible cost center.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this supply plan for execution, establishing accountability for S&OP decisions.',
    `material_master_id` BIGINT COMMENT 'Specific material or SKU for which this supply plan is created. May be null for aggregate material group plans.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Supply plans reference the SKU master to allocate production capacity and material supply per product.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the supply plan was approved, marking the transition from planning to execution phase.',
    `capacity_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of available production or procurement capacity utilized by this supply plan, indicating capacity constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this supply plan record was first created in the system.',
    `demand_forecast_quantity` DECIMAL(18,2) COMMENT 'Total forecasted demand quantity for the planning period, serving as the primary input to the supply plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this supply plan record was last updated, tracking the most recent change to planning parameters or status.',
    `lead_time_days` STRING COMMENT 'Total lead time in days from order placement to material availability, including procurement, production, and transportation time.',
    `lot_sizing_procedure` STRING COMMENT 'Lot-sizing rule used to determine planned order quantities: LOT_FOR_LOT (exact requirement), FIXED_LOT (fixed quantity), EOQ (Economic Order Quantity), POQ (Periodic Order Quantity), or PERIOD_LOT (period-based aggregation).. Valid values are `LOT_FOR_LOT|FIXED_LOT|EOQ|POQ|PERIOD_LOT`',
    `material_group_code` STRING COMMENT 'Material group or product family covered by this supply plan, enabling aggregated planning at the product category level.. Valid values are `^[A-Z0-9]{4,15}$`',
    `maximum_lot_size` DECIMAL(18,2) COMMENT 'Maximum order quantity constraint applied during supply planning, reflecting capacity or storage limitations.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT 'Minimum order quantity (MOQ) constraint applied during supply planning, reflecting supplier or production constraints.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this supply plan, enabling workload distribution and accountability.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Free-text notes and comments from planners regarding assumptions, constraints, or special considerations for this supply plan.',
    `plan_number` STRING COMMENT 'Externally-known business identifier for the supply plan, used for cross-system reference and S&OP review documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the supply plan: DRAFT (under development), PENDING_REVIEW (awaiting S&OP approval), APPROVED (approved for execution), ACTIVE (currently executing), SUPERSEDED (replaced by newer version), or CANCELLED (voided).. Valid values are `DRAFT|PENDING_REVIEW|APPROVED|ACTIVE|SUPERSEDED|CANCELLED`',
    `planned_supply_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material planned to be supplied during the planning period, aggregated across all time buckets.',
    `planning_horizon_days` STRING COMMENT 'Number of days into the future covered by this supply plan, defining the forward-looking planning window.',
    `planning_method` STRING COMMENT 'Method used to generate the supply plan: MRP (Material Requirements Planning), MRP II (Manufacturing Resource Planning), APS (Advanced Planning and Scheduling), MANUAL (manual planning), JIT (Just In Time), or KANBAN (pull-based replenishment).. Valid values are `MRP|MRP_II|APS|MANUAL|JIT|KANBAN`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning horizon covered by this supply plan.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning horizon covered by this supply plan.',
    `planning_run_timestamp` TIMESTAMP COMMENT 'Date and time when the MRP/APS planning run was executed to generate this supply plan.',
    `planning_strategy` DECIMAL(18,2) COMMENT 'Supply planning strategy: MTS (Make to Stock), MTO (Make to Order), ATO (Assemble to Order), or ETO (Engineer to Order).',
    `planning_time_fence_days` STRING COMMENT 'Number of days from today within which the planning system will not automatically change planned orders, protecting near-term execution stability.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center for which this supply plan is created.. Valid values are `^[A-Z0-9]{4,10}$`',
    `procurement_type` STRING COMMENT 'Source of supply: IN_HOUSE (internal production), EXTERNAL (external procurement from suppliers), or BOTH (mixed sourcing).. Valid values are `IN_HOUSE|EXTERNAL|BOTH`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Reorder point quantity that triggers replenishment planning when stock falls below this threshold.',
    `rounding_value` DECIMAL(18,2) COMMENT 'Rounding increment for planned order quantities, ensuring orders align with packaging or production batch multiples.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Safety stock level maintained as buffer against demand variability and supply uncertainty, factored into the supply plan.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that generated this supply plan: SAP_PP (SAP Production Planning), DYNAMICS_SCM (Microsoft Dynamics 365 Supply Chain Management), OPCENTER (Siemens Opcenter APS), or MANUAL (manually created).. Valid values are `SAP_PP|DYNAMICS_SCM|OPCENTER|MANUAL`',
    `supply_risk_level` STRING COMMENT 'Assessed risk level for supply availability: LOW (stable supply), MEDIUM (minor risks), HIGH (significant risks), or CRITICAL (severe supply constraints).. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned supply quantity (e.g., EA for each, KG for kilogram, L for liter, M for meter).. Valid values are `^[A-Z]{2,5}$`',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of demand forecast, enabling normalized comparison across materials.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Variance between planned supply quantity and demand forecast quantity, indicating over-planning or under-planning.',
    `version` STRING COMMENT 'Version identifier for the supply plan, enabling comparison of multiple planning scenarios and what-if analysis.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Master supply plan record representing the approved supply response to demand for a given planning period, plant, and material group. Captures planned supply quantities by time bucket, planning method (MRP, APS, manual), plan version, approval status, planning parameters (strategy, horizon, time fences, lot-sizing procedure, MRP controller), and variance against demand forecast. Integrates outputs from SAP PP and Microsoft Dynamics 365 SCM APS scheduling into a unified supply position for S&OP review.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique identifier for the capacity plan record. Primary key for capacity planning analysis.',
    `aps_scenario_id` BIGINT COMMENT 'Identifier of the APS scenario or simulation run that generated this capacity plan. Links to Siemens Opcenter APS or Microsoft Dynamics 365 SCM planning scenarios.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capacity Cost Allocation process charges capacity usage to cost centers for internal cost tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the production planner or capacity planner responsible for creating and maintaining this capacity plan.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production resource for which capacity is being planned. Links to the production facility or machine group.',
    `available_capacity_hours` DECIMAL(18,2) COMMENT 'Total available capacity in hours for the work center during the planning period. Calculated based on shifts, calendar days, and resource availability.',
    `capacity_buffer_hours` DECIMAL(18,2) COMMENT 'Safety buffer or protective capacity reserved to absorb variability and prevent schedule disruptions. Part of Theory of Constraints buffer management.',
    `capacity_category` STRING COMMENT 'Classification of the capacity resource based on criticality to production flow. Critical resources are closely monitored for bottlenecks.. Valid values are `critical|standard|flexible`',
    `capacity_load_profile` STRING COMMENT 'Pattern of capacity demand over the planning period. Indicates whether load is evenly distributed, concentrated in peaks, or highly variable.. Valid values are `uniform|peak|valley|variable`',
    `capacity_source_system` STRING COMMENT 'Source system that generated the capacity plan data. Typically SAP PP, Siemens Opcenter APS, or Microsoft Dynamics 365 SCM.',
    `capacity_unit` STRING COMMENT 'Unit of measure for capacity planning. Typically hours for time-based capacity or units/pieces for output-based capacity.. Valid values are `hours|minutes|units|pieces`',
    `capacity_utilization_rate` DECIMAL(18,2) COMMENT 'Percentage of available capacity that is utilized by required capacity. Calculated as (required_capacity_hours / available_capacity_hours) * 100. Key metric for identifying overload or underutilization.',
    `critical_ratio` DECIMAL(18,2) COMMENT 'Ratio of time remaining until due date to work time remaining. Used for priority scheduling and capacity allocation. Values less than 1.0 indicate behind schedule.',
    `efficiency_rate` DECIMAL(18,2) COMMENT 'Efficiency factor applied to available capacity to account for actual performance versus standard. Expressed as percentage. Used to adjust theoretical capacity to realistic capacity.',
    `is_bottleneck` BOOLEAN COMMENT 'Boolean flag indicating whether this work center is identified as a bottleneck constraint in the production schedule. True if utilization exceeds threshold or if this resource limits throughput.',
    `last_mrp_run_date` DATE COMMENT 'Date of the last MRP or MRP II run that generated the required capacity data for this plan. Indicates data freshness.',
    `leveling_adjustment_hours` DECIMAL(18,2) COMMENT 'Capacity adjustment applied through leveling actions such as overtime, shift changes, subcontracting, or order rescheduling to balance load.',
    `leveling_strategy` DECIMAL(18,2) COMMENT 'Strategy applied to resolve capacity overload. Indicates the method used to balance capacity constraints.',
    `mrp_controller` STRING COMMENT 'MRP controller code responsible for the materials and capacity planning for this work center. Links capacity planning to material planning.',
    `notes` STRING COMMENT 'Free-text notes or comments from the planner regarding capacity constraints, assumptions, or leveling decisions.',
    `overload_hours` DECIMAL(18,2) COMMENT 'Number of hours by which required capacity exceeds available capacity. Positive value indicates capacity shortage requiring leveling or additional resources.',
    `plan_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity plan record was created in the system.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan. Indicates whether the plan is in draft, approved for execution, actively used, or archived.. Valid values are `draft|approved|active|archived`',
    `plan_type` STRING COMMENT 'Type of capacity planning method applied. RCCP (Rough-Cut Capacity Planning) for aggregate planning, CRP (Capacity Requirements Planning) for detailed planning, infinite for unconstrained, finite for constrained scheduling.. Valid values are `RCCP|CRP|infinite|finite`',
    `plan_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity plan record was last updated or recalculated.',
    `planned_downtime_hours` DECIMAL(18,2) COMMENT 'Hours of planned maintenance, changeovers, or scheduled downtime that reduce available capacity during the planning period.',
    `planning_horizon` STRING COMMENT 'Time granularity of the capacity plan. Indicates whether this is a short-term, medium-term, or long-term capacity plan.. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_period_end_date` DATE COMMENT 'End date of the capacity planning period. Defines the end of the time bucket for capacity analysis.',
    `planning_period_start_date` DATE COMMENT 'Start date of the capacity planning period. Defines the beginning of the time bucket for capacity analysis.',
    `planning_version` STRING COMMENT 'Version identifier for the capacity plan. Supports scenario planning and what-if analysis by maintaining multiple plan versions.',
    `queue_time_hours` DECIMAL(18,2) COMMENT 'Average queue time or wait time for jobs at this work center during the planning period. Indicates congestion and scheduling delays.',
    `required_capacity_hours` DECIMAL(18,2) COMMENT 'Total required capacity in hours derived from planned orders, production orders, and demand forecasts for the planning period.',
    `resource_type` STRING COMMENT 'Type of production resource being planned. Distinguishes between machine capacity, labor capacity, tooling, or other equipment.. Valid values are `machine|labor|tooling|equipment`',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Total productive run time or processing time required for planned orders during the planning period.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'Total setup or changeover time required during the planning period. Reduces available productive capacity.',
    `shift_count` STRING COMMENT 'Number of production shifts scheduled for the work center during the planning period. Used to calculate available capacity.',
    `shift_hours_per_day` DECIMAL(18,2) COMMENT 'Total productive hours per day across all shifts. Excludes breaks and non-productive time.',
    `underload_hours` DECIMAL(18,2) COMMENT 'Number of hours by which available capacity exceeds required capacity. Positive value indicates spare capacity available for additional orders or maintenance.',
    `unplanned_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated or historical hours of unplanned downtime (breakdowns, failures) factored into capacity planning to provide realistic capacity estimates.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Records capacity planning data for work centers and production resources, including available capacity, required capacity derived from planned orders, utilization rate, bottleneck flags, and capacity leveling adjustments. Supports rough-cut capacity planning (RCCP) and detailed capacity planning (CRP) as executed in SAP PP and Siemens Opcenter APS. Enables identification of capacity constraints before production scheduling.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` (
    `aps_schedule_id` BIGINT COMMENT 'Unique identifier for the APS schedule record. Primary key for the schedule entry generated by the APS engine.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or workforce resource assigned to this scheduled operation. Links to workforce management system.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being manufactured in this operation. Links to the material master in SAP MM or inventory system.',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order that this schedule entry is planning for. Links to the manufacturing order in SAP PP or Dynamics 365 SCM.',
    `run_id` BIGINT COMMENT 'Reference to the APS scheduling run that generated this schedule entry. Links to the planning execution batch for traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Advanced scheduling links each operation to the SKU master for capacity planning and performance tracking.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center where this operation is scheduled to be performed. Links to the manufacturing resource/work center master.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of work center capacity consumed by this scheduled operation during its time window. Used for capacity planning analysis.',
    `constraint_type` STRING COMMENT 'Primary constraint that limited the scheduling of this operation. Identifies the bottleneck resource or dependency.. Valid values are `capacity|material|tooling|operator|none`',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center responsible for this scheduled operation. Used for production cost allocation and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the APS system. Audit trail for schedule generation.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this operation is on the critical path for the production order. True if any delay will impact the order completion date.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `earliest_start_timestamp` TIMESTAMP COMMENT 'Earliest permissible start time for this operation based on material availability, predecessor operations, and business constraints.',
    `fixed_schedule_flag` BOOLEAN COMMENT 'Indicates whether this schedule entry is locked and cannot be rescheduled by subsequent APS runs. True if fixed, false if flexible.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was last updated. Tracks schedule changes and rescheduling events.',
    `latest_end_timestamp` TIMESTAMP COMMENT 'Latest permissible completion time for this operation to meet downstream commitments and customer delivery dates.',
    `machine_code` BIGINT COMMENT 'Reference to the specific machine or equipment unit assigned to execute this operation. Links to the equipment register in asset management.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person or system process that last modified this schedule record. Supports audit and accountability.',
    `operation_number` DECIMAL(18,2) COMMENT 'Sequential operation number within the production routing. Identifies the specific manufacturing step being scheduled.',
    `overlap_allowed_flag` BOOLEAN COMMENT 'Indicates whether this operation can overlap with subsequent operations in the routing. True if overlap is permitted, false if sequential execution is required.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of units planned to be produced in this scheduled operation. Aligns with the production order quantity.',
    `planning_horizon_date` DATE COMMENT 'The planning horizon end date for the APS run that created this schedule. Defines the time boundary of the scheduling optimization.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where this operation is scheduled. Four-character plant identifier from SAP or ERP system.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_level` STRING COMMENT 'Scheduling priority assigned to this operation. Influences sequencing decisions in the APS optimization algorithm.. Valid values are `critical|high|normal|low`',
    `queue_time_minutes` DECIMAL(18,2) COMMENT 'Planned waiting time before the operation can start due to work center queue or resource availability constraints, measured in minutes.',
    `released_to_mes_flag` BOOLEAN COMMENT 'Indicates whether this schedule has been released to the MES for shop floor execution. True if released, false if still in planning state.',
    `released_to_mes_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was released to the MES system for execution. Marks the transition from planning to execution.',
    `run_time_minutes` DECIMAL(18,2) COMMENT 'Planned production run time for this operation, measured in minutes. Represents the active processing time excluding setup and teardown.',
    `schedule_number` STRING COMMENT 'Business identifier for the APS schedule. Human-readable unique schedule number assigned by the APS system.. Valid values are `^APS-[0-9]{8}-[0-9]{4}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the scheduled operation. Tracks progression from planning through execution to completion. [ENUM-REF-CANDIDATE: planned|confirmed|released|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned completion date and time for this operation. Calculated based on start time plus setup time plus run time.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for this operation as determined by the APS finite capacity scheduling algorithm. Represents the optimized start time.',
    `scheduling_method` STRING COMMENT 'Scheduling algorithm method used by APS to generate this schedule entry (forward scheduling, backward scheduling, finite capacity, infinite capacity).. Valid values are `forward|backward|finite|infinite`',
    `scheduling_notes` STRING COMMENT 'Free-text notes or comments related to this schedule entry. May include special instructions, constraint explanations, or planner annotations.',
    `sequence_number` STRING COMMENT 'Scheduling sequence position for this operation within the work center queue. Determines the execution order on the shop floor.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Planned setup or changeover time required before production can begin, measured in minutes. Includes tooling changes, material staging, and machine preparation.',
    `shift_code` STRING COMMENT 'Work shift during which this operation is scheduled to execute (e.g., DAY, NIGHT, SHIFT1, SHIFT2). Aligns with factory calendar and workforce scheduling.. Valid values are `^[A-Z0-9]{1,4}$`',
    `slack_time_minutes` DECIMAL(18,2) COMMENT 'Available buffer time between the scheduled end and the latest permissible end, measured in minutes. Indicates scheduling flexibility.',
    `source_system_code` STRING COMMENT 'Code identifying the source APS system that generated this schedule (Microsoft Dynamics 365 SCM, Siemens Opcenter, SAP PP, or custom APS engine).. Valid values are `D365_SCM|OPCENTER|SAP_PP|CUSTOM_APS`',
    `split_allowed_flag` BOOLEAN COMMENT 'Indicates whether this operation can be split across multiple work centers or time slots. True if splitting is permitted, false if operation must be continuous.',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard cost for executing this operation based on planned time and resource rates. Used for cost estimation and variance tracking.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Planned teardown or cleanup time after operation completion, measured in minutes. Includes tooling removal and work center cleanup.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned quantity (e.g., EA for each, KG for kilograms, L for liters). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_aps_schedule PRIMARY KEY(`aps_schedule_id`)
) COMMENT 'Detailed finite-capacity production schedule generated by the Advanced Planning and Scheduling (APS) engine in Microsoft Dynamics 365 SCM or Siemens Opcenter. Captures operation-level scheduling assignments including work center, machine, operator, scheduled start/end times, sequence number, setup time, run time, and schedule status. Represents the optimized shop floor execution plan prior to MES release.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` (
    `material_requirement_id` BIGINT COMMENT 'Unique identifier for the material requirement record generated by MRP run.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material Requirement Cost Tracking records which cost center bears the expense of each material requirement.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this requirement was generated.',
    `mrp_run_id` BIGINT COMMENT 'Reference to the specific MRP execution run that generated this requirement record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Material requirements are often mandated by regulations (e.g., safety standards); planning reports link each requirement to the governing regulatory requirement.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Material requirements are linked to the SKU master to calculate net requirements for the exact product.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Material requirement records assign a preferred supplier for each requirement to drive procurement planning and lead‑time estimation.',
    `abc_indicator` STRING COMMENT 'Classification of material importance based on consumption value: A (high value, tight control), B (moderate value), C (low value, loose control).. Valid values are `A|B|C`',
    `bom_explosion_date` DATE COMMENT 'The date on which the BOM was exploded to generate dependent requirements for component materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this material requirement record was first created in the system.',
    `exception_message_code` STRING COMMENT 'SAP exception code indicating planning issues such as late orders, missing parts, excess stock, or capacity overload.',
    `exception_message_text` STRING COMMENT 'Human-readable description of the planning exception or issue requiring planner attention.',
    `firming_date` DATE COMMENT 'Date after which this planned order is frozen and will not be automatically rescheduled or changed by subsequent MRP runs.',
    `goods_receipt_processing_time_days` STRING COMMENT 'Number of days required for receiving, inspecting, and putting away material after physical arrival.',
    `gross_requirement_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material required before considering available stock or scheduled receipts.',
    `in_house_production_time_days` STRING COMMENT 'Total manufacturing lead time in days from production order release to finished goods availability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this material requirement record was last updated or recalculated.',
    `lot_size_key` STRING COMMENT 'SAP lot-sizing procedure code applied to this requirement: EX (lot-for-lot), HB (replenish to maximum), FX (fixed lot size), WB (weekly lot size), PD (period lot size).. Valid values are `EX|HB|FX|WB|PD`',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered or produced in a single transaction due to capacity, storage, or supplier constraints.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from supplier or produced in a single production run.',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the planner or buyer responsible for managing this material requirement.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_element_type` STRING COMMENT 'Classification of the MRP element that created this requirement: sales order, forecast, safety stock replenishment, dependent requirement from BOM explosion, planned order, or purchase requisition.. Valid values are `sales_order|forecast|safety_stock|dependent_requirement|planned_order|purchase_requisition`',
    `mrp_run_timestamp` TIMESTAMP COMMENT 'Date and time when the MRP run that generated this requirement record was executed.',
    `net_requirement_quantity` DECIMAL(18,2) COMMENT 'The actual shortage quantity that must be procured or produced, calculated as gross requirement minus available stock and scheduled receipts.',
    `pegging_requirement_reference` BIGINT COMMENT 'Reference to the parent requirement that triggered this dependent requirement through BOM explosion (used for requirement traceability).',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in days from order placement to material receipt, used for backward scheduling.',
    `planned_order_quantity` DECIMAL(18,2) COMMENT 'The lot-size adjusted quantity that MRP proposes to procure or produce, after applying lot-sizing rules (MOQ, rounding, fixed lot size).',
    `planning_time_fence_days` STRING COMMENT 'Number of days into the future during which MRP will not automatically create or change planned orders without planner approval.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or distribution center where the material is required.. Valid values are `^[A-Z0-9]{4}$`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured: E (in-house production), F (external procurement), X (both).. Valid values are `E|F|X`',
    `projected_available_balance` DECIMAL(18,2) COMMENT 'Projected on-hand inventory balance after accounting for gross requirements and scheduled receipts up to this requirement date.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered to avoid stockout.',
    `requirement_date` DATE COMMENT 'The date on which the material is needed to meet demand or production schedule.',
    `requirement_priority` STRING COMMENT 'Numeric priority ranking used to sequence requirements when allocating limited supply or production capacity (lower number = higher priority).',
    `requirement_source_item` STRING COMMENT 'The line item number within the source document that triggered this requirement.',
    `requirement_source_number` STRING COMMENT 'The document number of the source that triggered this requirement (e.g., sales order number, forecast ID, planned order number).',
    `requirement_status` STRING COMMENT 'Current fulfillment status of the material requirement: open (not yet covered), partially covered (some supply allocated), fully covered (sufficient supply allocated), cancelled, or expired.. Valid values are `open|partially_covered|fully_covered|cancelled|expired`',
    `rounding_value` DECIMAL(18,2) COMMENT 'Quantity increment to which planned orders are rounded up (e.g., round to nearest pallet quantity or container size).',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained as buffer against demand variability and supply uncertainty.',
    `scheduled_receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of material expected to be received from open purchase orders, production orders, or transfer orders by the requirement date.',
    `special_procurement_type` STRING COMMENT 'Code indicating special procurement scenarios such as subcontracting, consignment, stock transfer, or third-party order processing.',
    `storage_location_code` STRING COMMENT 'Four-character code identifying the specific warehouse storage location within the plant where material is stocked.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit in which material quantities are expressed (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_material_requirement PRIMARY KEY(`material_requirement_id`)
) COMMENT 'Individual material requirement record produced by MRP, representing the net requirement for a specific material at a specific plant and date. Captures gross requirement, scheduled receipts, projected available balance, net requirement, lot-size adjusted requirement, and the requirement source (sales order, forecast, safety stock). Core output of SAP PP MRP runs used to drive procurement and production planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_node. Business justification: Required for mapping each supply network node to its logistics node in transport planning and execution reports.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Logistics network nodes are mapped to specific supplier sites to support risk assessment and transportation planning in the supply chain.',
    `active_sourcing_rules` STRING COMMENT 'Comma-separated list of active sourcing rule identifiers or strategies applied to this node (e.g., JIT (Just In Time), VMI (Vendor Managed Inventory), consignment).',
    `address_line_1` STRING COMMENT 'Primary street address line of the network node facility.',
    `address_line_2` STRING COMMENT 'Secondary address line (building, suite, floor) of the network node facility.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for throughput capacity (e.g., units, pallets, tons, cubic_meters).',
    `certification_status` STRING COMMENT 'Quality and compliance certification status of the node (e.g., ISO 9001, ISO 14001, ISO 45001, IATF 16949).',
    `city` STRING COMMENT 'City or municipality where the network node is located.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Financial cost center code associated with the network node for accounting and budgeting purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the network node location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the network node record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date when the network node became or will become operational in the supply chain.',
    `effective_to_date` DATE COMMENT 'Date when the network node was or will be decommissioned or removed from the supply chain (null for active nodes).',
    `erp_plant_code` STRING COMMENT 'Plant or facility code in the ERP (Enterprise Resource Planning) system (SAP S/4HANA plant identifier).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the network node record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the node location in decimal degrees format.',
    `lead_time_days` DECIMAL(18,2) COMMENT 'Standard lead time in days from order placement to delivery from this node to downstream nodes.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the node location in decimal degrees format.',
    `moq_minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required for procurement or production at this node.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., units, pallets, lots).',
    `network_tier_level` STRING COMMENT 'Hierarchical tier position in the multi-tier supply network (0=owned plant, 1=tier-1 supplier, 2=tier-2 supplier, 3=tier-3 supplier, etc.).',
    `node_subtype` STRING COMMENT 'Detailed sub-classification of the node (e.g., automation_assembly, electrification_production, smart_infrastructure_fabrication, tier_1_supplier, tier_2_supplier, tier_3_supplier).',
    `node_type` STRING COMMENT 'Classification of the network node by its primary function in the supply chain topology.. Valid values are `manufacturing_plant|distribution_center|supplier_facility|contract_manufacturer|customer_delivery_point|warehouse`',
    `operating_days_per_week` STRING COMMENT 'Number of operating days per week for the network node (typically 5, 6, or 7).',
    `operating_hours_per_day` DECIMAL(18,2) COMMENT 'Standard daily operating hours of the network node facility.',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational state of the network node in the supply chain.',
    `ownership_type` STRING COMMENT 'Legal ownership model of the network node facility.. Valid values are `owned|leased|third_party|contract|joint_venture`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the network node facility address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for the network node.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact or site manager for the network node.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact for the network node.',
    `region` STRING COMMENT 'Business-defined geographic region or market area (e.g., EMEA, APAC, Americas, Europe, North America).',
    `risk_category` STRING COMMENT 'Categorical risk classification of the node based on supply chain vulnerability assessment.. Valid values are `low|medium|high|critical`',
    `risk_exposure_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score for the node based on geopolitical, operational, financial, and supply continuity factors (scale 0-100, higher = higher risk).',
    `state_province` STRING COMMENT 'State, province, or administrative region of the network node location.',
    `storage_capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Total warehouse or storage capacity of the node in cubic meters.',
    `supplier_performance_rating` DECIMAL(18,2) COMMENT 'Performance rating score for supplier nodes based on OTD (On-Time Delivery), quality, and compliance metrics (scale 0-100).',
    `supports_cross_docking` BOOLEAN COMMENT 'Indicates whether the node supports cross-docking operations (direct transfer from inbound to outbound without storage).',
    `supports_kitting` BOOLEAN COMMENT 'Indicates whether the node supports kitting or assembly operations (combining multiple components into a kit).',
    `supports_postponement` BOOLEAN COMMENT 'Indicates whether the node supports postponement strategies (delaying final product configuration until customer order).',
    `throughput_capacity_units_per_day` DECIMAL(18,2) COMMENT 'Maximum daily production or handling capacity of the node measured in standard units (e.g., units, pallets, tons).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the node location (e.g., Europe/Berlin, America/New_York).',
    `transit_lead_time_days` DECIMAL(18,2) COMMENT 'Average transportation lead time in days from this node to primary downstream nodes.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master record for each node in the multi-tier industrial manufacturing supply network topology, representing owned manufacturing plants (automation assembly, electrification production, smart infrastructure fabrication), distribution centers, tier-1/tier-2/tier-3 supplier facilities, contract manufacturers, and customer delivery points. Captures node type, geographic coordinates, country/region, network tier level, transit lead time to downstream nodes, throughput capacity constraints, active sourcing rules, node operational status, and risk exposure score. Enables supply network optimization, multi-echelon inventory planning, supply chain digital twin modeling, and what-if scenario analysis for network disruption across the industrial manufacturing value chain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` (
    `sourcing_rule_id` BIGINT COMMENT 'Unique identifier for the sourcing rule record. Primary key.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record that this sourcing rule applies to. Links to the material being sourced.',
    `supply_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this sourcing rule is applicable. Links to the plant master.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sourcing rules must enforce vendor compliance with specific regulations; procurement policy reports reference regulatory requirement IDs.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Sourcing rules are defined per SKU to manage make‑or‑buy, allocation percentages and supplier contracts.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the material is sourced under this rule. Links to the supplier master.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total demand allocated to this sourcing rule when split sourcing is configured. Used for quota arrangements and multi-supplier strategies.',
    `automatic_po_flag` BOOLEAN COMMENT 'Indicates whether MRP is authorized to automatically convert planned orders to purchase orders without manual intervention for this sourcing rule.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this sourcing rule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price and other monetary values in this sourcing rule.. Valid values are `^[A-Z]{3}$`',
    `exception_reason` STRING COMMENT 'Free-text explanation for any exceptions or deviations from standard sourcing policies, such as emergency procurement, single-source justification, or temporary supplier changes.',
    `fixed_lot_size` DECIMAL(18,2) COMMENT 'Fixed quantity that must be ordered when this sourcing rule is applied. MRP will generate orders in exact multiples of this lot size.',
    `gr_processing_time_days` STRING COMMENT 'Number of days required for goods receipt processing, inspection, and put-away after material arrives at the plant. Included in total procurement lead time.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer in international transactions. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Specific location or port associated with the Incoterms designation, defining the point of delivery or risk transfer.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this sourcing rule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing rule record was last updated or modified.',
    `last_moq_negotiation_date` DATE COMMENT 'Date when the MOQ was last negotiated or reviewed with the supplier, used to track contract refresh cycles and renegotiation schedules.',
    `lot_size_rounding_value` DECIMAL(18,2) COMMENT 'Rounding increment for order quantities. MRP will round calculated requirements up to the nearest multiple of this value to align with packaging or production batch constraints.',
    `lot_sizing_procedure` STRING COMMENT 'SAP lot-sizing procedure code defining how MRP calculates order quantities: EX (lot-for-lot), HB (fixed lot size), FB (replenish to maximum), PD (period lot size), WM (weekly lot size), MB (monthly lot size).. Valid values are `ex|hb|fb|pd|wm|mb`',
    `make_or_buy_indicator` STRING COMMENT 'Strategic decision indicator specifying whether the material is manufactured in-house (make), procured externally (buy), or both options are available.. Valid values are `make|buy|both`',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered in a single purchase requisition or production order under this sourcing rule, based on supplier capacity or production constraints.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity negotiated with the supplier or defined by production constraints. MRP will not generate orders below this threshold.',
    `notes` STRING COMMENT 'Additional free-text notes or comments providing context, special instructions, or historical information about this sourcing rule.',
    `order_unit` STRING COMMENT 'Unit of measure in which orders are placed with the supplier (e.g., EA for each, KG for kilogram, M for meter). Must be convertible to base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `payment_terms` DECIMAL(18,2) COMMENT 'Code representing the negotiated payment terms with the supplier, defining due dates, discounts, and payment schedules.',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in calendar days from order placement to goods receipt for this material-plant-supplier combination. Used by MRP for backward scheduling.',
    `planner_approved_flag` BOOLEAN COMMENT 'Indicates whether the sourcing rule has been reviewed and approved by the material planner or supply chain manager for use in MRP runs.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Boolean indicator marking this supplier as the preferred source for the material-plant combination. Used to prioritize sourcing decisions when multiple suppliers are available.',
    `price_unit` DECIMAL(18,2) COMMENT 'Quantity unit to which the standard price applies. For example, if price_unit is 100, the standard_price represents the cost per 100 units.',
    `purchasing_group` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for managing procurement activities under this sourcing rule.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the purchasing organization responsible for negotiating and executing procurement under this sourcing rule.. Valid values are `^[A-Z0-9]{4}$`',
    `quota_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this sourcing rule is part of a quota arrangement where demand is split across multiple suppliers based on allocation percentages.',
    `rule_code` STRING COMMENT 'Business-assigned unique code identifying this sourcing rule for operational reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `rule_name` STRING COMMENT 'Descriptive name of the sourcing rule for business user identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the sourcing rule indicating whether it is active and available for MRP, temporarily blocked, awaiting approval, or expired.. Valid values are `active|inactive|blocked|pending_approval|expired`',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order when multiple sourcing rules exist for the same material-plant combination. Lower numbers indicate higher priority.',
    `sourcing_type` STRING COMMENT 'Classification of the sourcing method: external procurement from supplier, in-house production, subcontracting, stock transfer between plants, or consignment arrangement.. Valid values are `external_procurement|in_house_production|subcontracting|stock_transfer|consignment`',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard negotiated unit price for the material from this supplier, used for cost estimation and procurement planning. Excludes taxes and freight.',
    `supply_risk_level` STRING COMMENT 'Assessment of supply chain risk associated with this sourcing rule, considering supplier reliability, geopolitical factors, lead time variability, and single-source dependency.. Valid values are `low|medium|high|critical`',
    `valid_from_date` DATE COMMENT 'Start date from which this sourcing rule becomes effective and can be used by MRP for procurement planning.',
    `valid_to_date` DATE COMMENT 'End date after which this sourcing rule is no longer valid and will not be considered by MRP. Null indicates indefinite validity.',
    CONSTRAINT pk_sourcing_rule PRIMARY KEY(`sourcing_rule_id`)
) COMMENT 'Defines the complete sourcing logic, lot-sizing constraints, and MOQ parameters for each material-plant-supplier combination. Specifies preferred suppliers, make-vs-buy decisions, split sourcing percentages, sourcing priority, applicable date ranges, Minimum Order Quantity (MOQ), maximum order quantity, lot size rounding values, fixed lot sizes, order quantity constraints, MOQ negotiation history, and planner-approved exceptions. These rules directly govern how MRP generates planned purchase requisitions or production orders and enforce procurement cost optimization through lot-size calculations. Managed in SAP MM and Microsoft Dynamics 365 SCM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` (
    `supply_safety_stock_policy_id` BIGINT COMMENT 'Unique identifier for the safety stock policy record.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this safety stock policy is defined.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Safety‑stock policies are applied per SKU to meet service‑level targets and calculate reorder points.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Safety‑stock policies are often defined per supplier to reflect reliability and lead‑time variability, required for accurate buffer calculations.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and criticality: A (high-value, tight control), B (moderate-value), C (low-value, loose control).. Valid values are `A|B|C`',
    `average_daily_demand` DECIMAL(18,2) COMMENT 'Mean daily consumption or usage rate of the material, used as input for reorder point and safety stock calculations.',
    `calculation_method` STRING COMMENT 'The methodology used to determine safety stock levels: static (fixed quantity), dynamic (demand-driven), statistical (based on demand variability and service level), or manual (user-defined).. Valid values are `static|dynamic|statistical|manual`',
    `coverage_profile` STRING COMMENT 'Six-character code referencing a time-phased coverage profile used in advanced planning systems for dynamic safety stock calculation.. Valid values are `^[A-Z0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was first created in the system.',
    `criticality_code` STRING COMMENT 'Business criticality rating indicating the impact of stockout on operations: critical (production stoppage), high (significant disruption), medium (moderate impact), low (minimal impact).. Valid values are `critical|high|medium|low`',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand fluctuation (coefficient of variation or standard deviation) used in statistical safety stock calculations.',
    `effective_from_date` DATE COMMENT 'The date from which this safety stock policy becomes active and is used in MRP calculations.',
    `effective_to_date` DATE COMMENT 'The date on which this safety stock policy expires or is superseded by a new policy. Null indicates an open-ended policy.',
    `holding_cost_percent_annual` DECIMAL(18,2) COMMENT 'Annual inventory carrying cost as a percentage of material value, including warehousing, insurance, obsolescence, and cost of capital.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock policy record was most recently updated.',
    `last_review_date` DATE COMMENT 'The most recent date on which this safety stock policy was reviewed and validated by supply chain planning.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Standard deviation of supplier lead time in days, used to account for supply uncertainty in safety stock calculations.',
    `lot_size_rule` STRING COMMENT 'SAP lot-sizing procedure code: EX (Lot-for-Lot), HB (Replenish to Maximum), FX (Fixed Lot Size), WB (Weekly Lot Size), MB (Monthly Lot Size).. Valid values are `EX|HB|FX|WB|MB`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'The upper inventory limit for this material-plant combination, used to prevent overstocking and optimize working capital.',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'The lower inventory threshold below which stock should not fall under normal operating conditions.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this safety stock policy record.',
    `moq_minimum_order_quantity` DECIMAL(18,2) COMMENT 'The smallest order quantity that can be procured from the supplier, constraining replenishment order sizes.',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the MRP controller responsible for exception management and planning parameter maintenance.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_type` STRING COMMENT 'MRP procedure type that determines how material requirements are planned: PD (MRP), VB (Manual Reorder Point), VM (Forecast-Based Planning), VV (Time-Phased Planning), R1 (Reorder Point Planning), R2 (Replenishment Planning).. Valid values are `PD|VB|VM|VV|R1|R2`',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this safety stock policy.',
    `planned_delivery_lead_time_days` STRING COMMENT 'Expected number of calendar days from order placement to material receipt, used in reorder point calculation.',
    `planner_code` STRING COMMENT 'Three-character code identifying the supply chain planner or buyer responsible for managing this material-plant combination.. Valid values are `^[A-Z0-9]{3}$`',
    `plant_code` STRING COMMENT 'Four-character alphanumeric code identifying the manufacturing or distribution plant where the safety stock policy applies.. Valid values are `^[A-Z0-9]{4}$`',
    `policy_notes` STRING COMMENT 'Free-text field for planners to document special considerations, assumptions, or business rules governing this safety stock policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the safety stock policy: active (in use), inactive (not applied), suspended (temporarily disabled), under_review (pending approval).. Valid values are `active|inactive|suspended|under_review`',
    `procurement_type` STRING COMMENT 'SAP procurement type indicator: E (In-house production), F (External procurement), X (Both).. Valid values are `E|F|X`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered, calculated as safety stock plus demand during lead time.',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of this safety stock policy to ensure continued relevance and accuracy.',
    `rounding_value` DECIMAL(18,2) COMMENT 'Quantity increment to which replenishment orders are rounded (e.g., round to nearest pallet quantity).',
    `safety_days_supply` STRING COMMENT 'Number of days of average demand that the safety stock quantity is intended to cover.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The buffer stock quantity maintained to protect against demand variability and supply uncertainty, expressed in base unit of measure.',
    `safety_time_days` STRING COMMENT 'Number of days added to the planned delivery lead time as a time buffer to account for supply uncertainty.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'The target probability of not experiencing a stockout during the lead time, expressed as a percentage (e.g., 95.00 for 95% service level).',
    `special_procurement_key` STRING COMMENT 'Two-digit SAP code indicating special procurement scenarios such as subcontracting, consignment, stock transfer, or third-party processing.. Valid values are `^[0-9]{2}$`',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'Estimated cost impact per unit of stockout, including lost sales, expediting costs, and production disruption, used in economic safety stock optimization.',
    `storage_location_code` STRING COMMENT 'Four-character code identifying the specific storage location within the plant where safety stock is maintained.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which safety stock quantities are expressed (e.g., EA for each, KG for kilogram, L for liter).. Valid values are `^[A-Z]{2,3}$`',
    `xyz_classification` STRING COMMENT 'Demand variability classification: X (stable demand), Y (moderate variability), Z (highly variable or sporadic demand).. Valid values are `X|Y|Z`',
    CONSTRAINT pk_supply_safety_stock_policy PRIMARY KEY(`supply_safety_stock_policy_id`)
) COMMENT 'Defines safety stock parameters and reorder point policies for each material-plant combination, including safety stock quantity, safety days of supply, service level target, reorder point, maximum stock level, and the calculation method (static, dynamic, statistical). Captures the business rules governing buffer stock levels to protect against demand variability and supplier lead time uncertainty. Managed in SAP MM material master planning data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Primary key for risk_register',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: CAPA actions are linked to the risks they mitigate; the risk register stores the CAPA identifier for each risk to enable corrective‑action tracking.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Supply‑risk assessments often consider key customers; linking risk records to customer accounts supports risk dashboards and mitigation planning.',
    `material_master_id` BIGINT COMMENT 'Reference to the specific material or component affected by this supply risk. Links to the material master data in SAP MM.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Risk Management process requires associating each identified risk with its related Non‑Conformance Report (NCR) to trace root cause and corrective actions.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Risk register references a network node by name; replace with FK to network_node for proper relationship and eliminate redundant string column.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier associated with this supply risk. Links to supplier master data in SAP Ariba or SAP MM vendor master.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Required for Risk Register to capture compliance risk per regulatory requirement; risk management reports tie each risk to a specific regulation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for monitoring and managing this supply risk. Links to employee master data in Workday HCM.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Risk register tracks supply risks that affect active service contracts (Contract Risk Management report).',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Risk registers track supply‑chain risks at the SKU level for mitigation planning.',
    `alternative_supplier_identified_flag` BOOLEAN COMMENT 'Boolean indicator whether an alternative or backup supplier has been identified and qualified for this material or component. True indicates alternative supplier is available.',
    `assessed_date` DATE COMMENT 'Date when the risk assessment (severity, probability, impact analysis) was completed, supporting risk management process compliance.',
    `closed_date` DATE COMMENT 'Date when the supply risk was closed or resolved, indicating the risk is no longer active or applicable.',
    `contingency_plan` STRING COMMENT 'Detailed contingency or backup plan to be activated if the risk materializes and primary mitigation strategies fail, supporting business continuity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the system, supporting audit trails and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the source system or application where this risk record originated (e.g., Microsoft Dynamics 365 SCM, SAP Ariba, manual entry), supporting data lineage and integration traceability.',
    `escalation_level` STRING COMMENT 'Level of management escalation required for this risk: none (no escalation), manager (department manager), director (functional director), vp (vice president), executive (C-level), or board (board of directors).. Valid values are `none|manager|director|vp|executive|board`',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this risk requires escalation to senior management or executive leadership due to severity or strategic importance. True indicates escalation is required.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact in the base currency if the risk materializes, including potential revenue loss, additional costs, or penalties.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'Geographic region or country code (ISO 3166-1 alpha-3) where the supply risk is located or originates, supporting regional risk analysis and business continuity planning.',
    `identified_date` DATE COMMENT 'Date when the supply risk was first identified and recorded in the risk register, supporting risk lifecycle tracking and audit trails.',
    `impact_quantity_uom` STRING COMMENT 'Unit of measure for the potential supply impact quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was last updated or modified, supporting change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or reassessment of this supply risk, ensuring risk information remains current and accurate.',
    `lead_time_impact_days` STRING COMMENT 'Estimated increase in procurement or production lead time (in days) if the risk materializes, used for Material Requirements Planning (MRP) and Advanced Planning and Scheduling (APS) adjustments.',
    `mitigation_cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost to implement the mitigation strategy, used for cost-benefit analysis and budget planning.',
    `mitigation_cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the mitigation cost (e.g., USD, EUR, GBP, CNY).',
    `mitigation_status` STRING COMMENT 'Current status of the mitigation action plan: not started (planned but not initiated), in progress (actively being implemented), completed (mitigation actions finished), on hold (temporarily paused), or cancelled (mitigation plan abandoned).. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `mitigation_strategy` DECIMAL(18,2) COMMENT 'Detailed description of the mitigation actions and strategies planned or implemented to reduce the likelihood or impact of the supply risk.',
    `mitigation_target_date` DATE COMMENT 'Target completion date for the mitigation actions, used for project management and risk reduction tracking.',
    `moq_impact` DECIMAL(18,2) COMMENT 'Change in Minimum Order Quantity (MOQ) requirements if the risk materializes and alternative sourcing is required, impacting inventory planning and working capital.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reassessment of this supply risk, supporting proactive risk management and governance.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to this supply risk, supporting collaboration and knowledge sharing among risk management teams.',
    `potential_impact_duration_days` DECIMAL(18,2) COMMENT 'Estimated duration in days that the supply disruption could last if the risk materializes, used for business continuity and recovery planning.',
    `potential_supply_impact_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of material or product that could be impacted if the risk materializes, measured in the base unit of measure (UOM) for the material.',
    `probability_of_occurrence` STRING COMMENT 'Likelihood that the supply risk will materialize within the planning horizon: very high (>80% probability), high (60-80%), medium (40-60%), low (20-40%), or very low (<20%).. Valid values are `very_high|high|medium|low|very_low`',
    `risk_category` STRING COMMENT 'High-level categorization of the risk domain: supplier (vendor-related risks), material (raw material availability or price volatility), logistics (transportation and distribution risks), regulatory (compliance and legal risks), demand (demand volatility or forecast accuracy), or technology (obsolescence or system failures).. Valid values are `supplier|material|logistics|regulatory|demand|technology`',
    `risk_code` STRING COMMENT 'Business identifier code for the supply risk following the pattern AAA-NNNNNN where AAA represents risk category and NNNNNN is sequential number.. Valid values are `^[A-Z]{3}-[0-9]{6}$`',
    `risk_description` STRING COMMENT 'Detailed description of the supply chain risk including context, potential triggers, and business impact scenarios.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score based on severity and probability, typically ranging from 0 to 100, used for risk prioritization and resource allocation decisions.',
    `risk_severity` STRING COMMENT 'Severity level of the supply risk based on potential business impact: critical (severe operational disruption or financial loss), high (significant impact), medium (moderate impact), or low (minimal impact).. Valid values are `critical|high|medium|low`',
    `risk_status` STRING COMMENT 'Current lifecycle status of the supply risk: identified (newly discovered), assessed (analysis complete), active (currently impacting operations), mitigated (actions taken to reduce impact), closed (risk no longer applicable), or monitoring (under continuous observation).. Valid values are `identified|assessed|active|mitigated|closed|monitoring`',
    `risk_title` STRING COMMENT 'Short descriptive title of the supply chain risk for quick identification and reporting.',
    `risk_type` STRING COMMENT 'Classification of the supply chain risk by its nature: single-source dependency (sole supplier risk), geopolitical (trade restrictions, sanctions, political instability), capacity constraint (supplier unable to meet demand), quality issue (supplier quality failures), natural disaster (floods, earthquakes, pandemics), or financial instability (supplier bankruptcy risk).. Valid values are `single_source_dependency|geopolitical|capacity_constraint|quality_issue|natural_disaster|financial_instability`',
    `safety_stock_recommendation` DECIMAL(18,2) COMMENT 'Recommended safety stock quantity to buffer against this supply risk, used for inventory policy adjustments and working capital planning.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Records identified supply chain risks associated with materials, suppliers, supply network nodes, or geographic regions. Captures risk type (single-source dependency, geopolitical, capacity constraint, quality issue, natural disaster), risk severity, probability of occurrence, potential supply impact (quantity and duration), mitigation actions, and risk owner. Supports supply risk management and business continuity planning for the industrial manufacturing supply chain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` (
    `planning_exception_id` BIGINT COMMENT 'Primary key for planning_exception',
    `employee_id` BIGINT COMMENT 'The user ID of the supply planner assigned to resolve this exception. Used for workload balancing and accountability tracking in exception management workflow.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key reference to the MRP run that generated this exception. Links exception to the planning cycle and parameters that produced it.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Planning exceptions can be triggered by regulatory constraints; exception logs record the regulatory requirement causing the deviation.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Exceptions reference the SKU master to identify which product’s plan deviated and requires corrective action.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Exception reports require the responsible supplier ID for root‑cause analysis and corrective action tracking, a standard practice in manufacturing exception management.',
    `aging_days` STRING COMMENT 'The number of calendar days since the exception was first detected. Used to identify stale exceptions requiring escalation or management attention. Calculated as current date minus exception_detected_timestamp.',
    `available_stock_quantity` DECIMAL(18,2) COMMENT 'The current available stock (unrestricted use stock minus allocated quantities) for the material at the plant. Used to assess whether existing inventory can partially mitigate the exception.',
    `business_impact_description` STRING COMMENT 'Free-text description of the business impact if the exception is not resolved (e.g., production line stoppage, customer order delay, revenue at risk, contractual penalty exposure). Used for prioritization and escalation decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this exception record was first created in the lakehouse silver layer. Used for data lineage and audit trail. Distinct from exception_detected_timestamp which is the business event time.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the estimated cost impact (e.g., USD, EUR, CNY). Aligns with SAP FI financial reporting currency.. Valid values are `^[A-Z]{3}$`',
    `current_receipt_date` DATE COMMENT 'The currently scheduled receipt date for the supply order (purchase order, production order, or transfer order) related to this exception. Null if exception is demand-driven shortage with no existing supply order.',
    `customer_name` STRING COMMENT 'The name of the customer affected by this exception, if the demand source is a sales order. Used by planners to assess business priority and communicate potential delivery impacts.',
    `demand_order_number` STRING COMMENT 'The sales order, service order, or project number that is the source of demand causing the exception. Used to trace exception back to customer commitment and assess business impact of shortage or delay.',
    `demand_source` STRING COMMENT 'The origin of the demand that triggered the exception. Sales_order indicates firm customer commitment; forecast indicates statistical projection; safety_stock indicates buffer replenishment; dependent_requirement indicates BOM-driven demand from higher-level assembly.. Valid values are `sales_order|forecast|safety_stock|dependent_requirement|service_order|project_demand`',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) whether this exception has been escalated to management or cross-functional team due to complexity, business impact, or aging. True indicates escalation required or in progress.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the exception was escalated (e.g., supplier cannot expedite, customer will not accept delay, cross-plant transfer required, management approval needed for cost impact).',
    `estimated_cost_impact` DECIMAL(18,2) COMMENT 'The estimated financial cost impact of the exception in local currency (e.g., expedite freight cost, premium supplier pricing, production downtime cost, customer penalty). Used for cost-benefit analysis of resolution options.',
    `exception_date` DATE COMMENT 'The date when the supply-demand imbalance occurs or is projected to occur. This is the key date planners use to prioritize exception resolution by urgency.',
    `exception_detected_timestamp` TIMESTAMP COMMENT 'The date and time when the exception was first detected and created by the MRP or APS system. Used to calculate exception aging and track planner response time.',
    `exception_number` STRING COMMENT 'Human-readable business identifier for the exception, typically auto-generated by MRP or APS system. Used by planners to reference and track exceptions in daily workflow.. Valid values are `^EXC-[0-9]{8,12}$`',
    `exception_quantity` DECIMAL(18,2) COMMENT 'The quantity of material involved in the exception (shortage amount, excess amount, or quantity to reschedule). Expressed in base unit of measure for the material.',
    `exception_status` STRING COMMENT 'Current lifecycle state of the exception. Open indicates new exception requiring planner action; in_progress indicates planner is working resolution; resolved indicates action completed; cancelled indicates exception no longer valid; deferred indicates postponed to future planning cycle.. Valid values are `open|in_progress|resolved|cancelled|deferred`',
    `exception_type` STRING COMMENT 'Classification of the planning exception: shortage (demand exceeds supply), excess (supply exceeds demand), reschedule_in (move receipt earlier), reschedule_out (move receipt later), expedite (urgent acceleration needed), cancel (order no longer needed), lead_time_violation (supplier lead time exceeded). [ENUM-REF-CANDIDATE: shortage|excess|reschedule_in|reschedule_out|expedite|cancel|lead_time_violation — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this exception record was last updated in the lakehouse silver layer. Used for change tracking and incremental processing.',
    `lead_time_days` STRING COMMENT 'The standard procurement or production lead time for the material in days. Used to assess feasibility of recommended receipt date and expedite requirements.',
    `material_number` STRING COMMENT 'The material or SKU (Stock Keeping Unit) affected by this planning exception. References the material master record in SAP MM or Microsoft Dynamics 365 SCM.. Valid values are `^[A-Z0-9]{8,18}$`',
    `mrp_controller` STRING COMMENT 'The MRP controller code or planner ID responsible for resolving this exception. Used for workload assignment and accountability tracking in exception-based planning workflow.. Valid values are `^[A-Z0-9]{3,10}$`',
    `plant_code` STRING COMMENT 'The manufacturing plant or distribution center where the exception occurred. Aligns with SAP S/4HANA plant master organizational structure.. Valid values are `^[A-Z0-9]{4,6}$`',
    `recommended_action` STRING COMMENT 'The system-recommended action to resolve the exception. Planners review this recommendation and decide whether to accept, modify, or override based on business judgment and constraints not visible to the planning system. [ENUM-REF-CANDIDATE: create_order|expedite_order|reschedule_order|cancel_order|increase_quantity|decrease_quantity|transfer_stock|no_action — 8 candidates stripped; promote to reference product]',
    `recommended_receipt_date` DATE COMMENT 'The MRP or APS system-recommended new receipt date to resolve the exception. Used for reschedule-in and reschedule-out exception types.',
    `resolution_action_taken` STRING COMMENT 'Free-text description of the actual action taken by the planner to resolve the exception. May differ from recommended_action if planner used business judgment to override system recommendation.',
    `resolution_notes` STRING COMMENT 'Free-text notes entered by the planner documenting resolution rationale, coordination with suppliers or customers, constraints considered, or escalations required. Provides audit trail and knowledge transfer.',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when the exception was marked as resolved by the planner. Used to calculate resolution cycle time and planner productivity metrics.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The safety stock level defined for the material at this plant. Used to assess whether exception breaches safety stock buffer and requires urgent action.',
    `severity_level` STRING COMMENT 'Business priority of the exception. Critical indicates production stoppage risk; high indicates customer order impact; medium indicates buffer stock impact; low indicates minor planning adjustment.. Valid values are `critical|high|medium|low`',
    `source_order_number` STRING COMMENT 'The purchase order, production order, or planned order number that is the source of the exception (e.g., the order that needs to be rescheduled, expedited, or cancelled). Null for shortage exceptions with no existing supply order.',
    `source_order_type` STRING COMMENT 'The type of supply order related to this exception. Used to route exception resolution to appropriate procurement, production, or logistics team.. Valid values are `purchase_order|production_order|planned_order|transfer_order|stock_transport_order`',
    `source_system_code` STRING COMMENT 'The operational system that generated this exception record (SAP_PP for SAP Production Planning, SAP_MM for SAP Materials Management, DYNAMICS_SCM for Microsoft Dynamics 365 Supply Chain Management, OPCENTER_APS for Siemens Opcenter Advanced Planning and Scheduling).. Valid values are `SAP_PP|SAP_MM|DYNAMICS_SCM|OPCENTER_APS`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the exception quantity (e.g., EA for each, KG for kilogram, M for meter, L for liter). Aligns with material master base UOM.. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_planning_exception PRIMARY KEY(`planning_exception_id`)
) COMMENT 'Records supply planning exceptions and alerts generated by MRP or APS when supply and demand are out of balance. Captures shortage alerts, excess stock warnings, rescheduling recommendations, cancellation proposals, expedite flags, and lead time violations. Each exception includes type, severity, affected material and plant, exception quantity, recommended action, planner assignment, resolution status, and aging days. Drives the daily exception-based planning workflow — the primary screen supply planners work from each morning in SAP PP/MM and Microsoft Dynamics 365 SCM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Unique identifier for the inventory position snapshot record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory Valuation by Cost Center report allocates on‑hand stock value to the owning cost center.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Financial reporting: Map inventory snapshot to invoiced line items for accurate COGS calculation and audit trails; a standard practice in manufacturing finance.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Inventory position snapshot is generated after an MRP run; linking to mrp_run provides provenance of the snapshot.',
    `service_warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: Inventory position is used to manage stock for warranty replacements (Warranty Inventory Management process).',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Inventory snapshots are tied to the SKU master for accurate stock valuation and reporting.',
    `abc_classification` STRING COMMENT 'The ABC classification of the material based on value or consumption volume. A items are high-value/high-volume, B items are medium, C items are low-value/low-volume.. Valid values are `A|B|C`',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'The quantity of material available to promise to new customer orders. Calculated as on-hand plus scheduled receipts minus existing commitments. This is the key metric for order promising and customer service.',
    `average_daily_demand` DECIMAL(18,2) COMMENT 'The average daily consumption or demand rate for the material, used for days-of-supply calculations and replenishment planning.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that is blocked for use due to quality issues, damage, or other restrictions. This stock cannot be used for production or sales.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was first created in the lakehouse. Used for data lineage and audit trail.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'The number of days the current on-hand inventory will last based on average daily demand. Calculated as on-hand quantity divided by average daily consumption rate.',
    `excess_stock_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the material has excess inventory above normal levels. True if on-hand quantity significantly exceeds safety stock plus near-term demand.',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'Total forecasted demand quantity for the material within the planning horizon. This is the statistical forecast used for supply planning when firm sales orders are not yet available.',
    `in_quality_inspection_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently in quality inspection status and not yet released for unrestricted use. This stock is physically available but not yet approved for consumption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was last updated in the lakehouse. Used for change tracking and data freshness monitoring.',
    `last_mrp_run_date` DATE COMMENT 'The date of the most recent MRP run that calculated this inventory position. Used to track data freshness and planning cycle frequency.',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'The standard lot size or batch quantity used for replenishment orders. This is the fixed order quantity or economic order quantity (EOQ) used in lot-sizing calculations.',
    `manufacturing_lead_time_days` STRING COMMENT 'The number of days required to manufacture the material from raw materials to finished goods. This is the production lead time used in MRP calculations.',
    `material_number` STRING COMMENT 'Unique identifier for the material or SKU (Stock Keeping Unit) in the ERP system. This is the business key for the material master record.. Valid values are `^[A-Z0-9]{8,18}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from the supplier or produced in a manufacturing run. MRP respects this constraint when generating planned orders.',
    `mrp_controller_code` STRING COMMENT 'Three-character code identifying the MRP controller or planner responsible for managing this material. Used for workload distribution and accountability.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_type` STRING COMMENT 'The MRP type code that determines how the material is planned. PD = MRP, VB = consumption-based planning, ND = no planning, X0 = no MRP.. Valid values are `PD|VB|ND|X0`',
    `net_requirement_quantity` DECIMAL(18,2) COMMENT 'The net material requirement calculated by MRP as total demand minus available supply. A positive value indicates a shortage that requires replenishment action.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Physical stock quantity currently available in the warehouse or storage location. This is the unrestricted-use stock available for consumption or sale.',
    `open_planned_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material on planned orders generated by MRP but not yet converted to firm production or purchase orders. These are MRP-generated supply recommendations.',
    `open_production_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material on open production orders (manufacturing orders) that are in progress or scheduled but not yet completed and received into stock.',
    `open_purchase_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material on open purchase orders that have been released to suppliers but not yet received. This represents inbound supply in transit or scheduled for delivery.',
    `planned_receipt_date` DATE COMMENT 'The earliest date on which a planned or open order is scheduled to be received into stock. This is the next expected supply arrival date.',
    `planning_strategy_group` DECIMAL(18,2) COMMENT 'Two-character code defining the planning strategy for the material (e.g., make-to-stock, make-to-order, engineer-to-order). Determines how demand and supply are matched.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or distribution center where the inventory is held.. Valid values are `^[A-Z0-9]{4}$`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured. E = in-house production (manufactured), F = external procurement (purchased), X = both.. Valid values are `E|F|X`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The inventory level at which a replenishment order should be triggered. When on-hand stock falls to or below this level, MRP (Material Requirements Planning) generates a planned order.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of on-hand stock that has been reserved or allocated for specific production orders, projects, or customer orders and is not available for general consumption.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The target safety stock level maintained to buffer against demand variability and supply uncertainty. This is the minimum inventory level the planner aims to maintain.',
    `sales_order_demand_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material committed to open sales orders. This represents firm customer demand that must be fulfilled.',
    `snapshot_date` DATE COMMENT 'The date for which this inventory position snapshot was calculated. This is the business event date representing the point-in-time view of supply and demand.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this inventory position data was extracted (e.g., SAP, D365 for Dynamics 365, MES for Manufacturing Execution System).. Valid values are `SAP|D365|MES|LEGACY`',
    `stock_out_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the material is at risk of stock-out based on current inventory position and demand forecast. True if ATP is below safety stock or net requirement is positive.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the plant where the material is stored.. Valid values are `^[A-Z0-9]{4}$`',
    `supplier_lead_time_days` STRING COMMENT 'The number of days required from order placement to receipt of material from the supplier. This is the procurement lead time used in MRP calculations.',
    `unit_of_measure` STRING COMMENT 'The unit in which the material quantity is measured (e.g., EA for each, KG for kilogram, L for liter, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    `xyz_classification` STRING COMMENT 'The XYZ classification of the material based on demand variability. X items have stable demand, Y items have moderate variability, Z items have highly variable or sporadic demand.. Valid values are `X|Y|Z`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Point-in-time snapshot of the supply planning inventory position for each material-plant combination, capturing on-hand stock, open purchase orders, open planned orders, safety stock target, reorder point, sales order demand, forecast demand, available-to-promise (ATP) quantity, and days of supply. This is the supply planning view used for MRP net requirement calculations and supply/demand balancing — distinct from the inventory domains physical stock and warehouse location records.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` (
    `moq_constraint_id` BIGINT COMMENT 'Unique identifier for the MOQ constraint record. Primary key for the moq_constraint product.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material subject to this MOQ constraint. Links to the material master record in the inventory domain.',
    `employee_id` BIGINT COMMENT 'Identifier of the supply planner or procurement specialist who negotiated this MOQ constraint with the supplier.',
    `moq_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this MOQ constraint record.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: MOQ constraints are defined per SKU to enforce minimum order quantities in procurement.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier imposing this MOQ constraint. Links to the supplier master record.',
    `apply_to_forecast_flag` BOOLEAN COMMENT 'Indicates whether this MOQ constraint should be applied to forecast-driven planned orders in addition to customer order-driven requirements.',
    `apply_to_safety_stock_flag` BOOLEAN COMMENT 'Indicates whether this MOQ constraint should be applied when MRP generates planned orders to replenish safety stock levels.',
    `business_justification` STRING COMMENT 'Business rationale for this MOQ constraint, including supplier requirements, cost optimization considerations, logistics constraints, or contractual obligations.',
    `change_reason` STRING COMMENT 'Reason for the most recent change to this MOQ constraint, documenting supplier negotiations, market conditions, or business strategy shifts.',
    `constraint_source` STRING COMMENT 'Origin or driver of this MOQ constraint, indicating whether it stems from supplier requirements, logistics limitations, cost considerations, or other factors.. Valid values are `supplier_requirement|logistics_constraint|cost_optimization|contract_term|manufacturing_batch_size|packaging_standard`',
    `constraint_status` STRING COMMENT 'Current lifecycle status of the MOQ constraint. Only active constraints are applied by MRP during planning runs.. Valid values are `active|inactive|pending_approval|expired|superseded`',
    `constraint_type` STRING COMMENT 'Type of lot-sizing constraint applied to this material-supplier combination. Determines how MRP calculates procurement quantities.. Valid values are `minimum_order_quantity|fixed_lot_size|order_multiple|maximum_order_quantity|economic_order_quantity|supplier_package_size`',
    `contract_reference_number` STRING COMMENT 'Reference number of the purchasing contract or supplier agreement that defines this MOQ constraint.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `cost_impact_currency_code` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for the cost impact value.',
    `cost_impact_per_unit` DECIMAL(18,2) COMMENT 'Estimated cost impact per unit when ordering below the MOQ threshold. Used for cost-benefit analysis of MOQ exceptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOQ constraint record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which this MOQ constraint is no longer effective. Null indicates an open-ended constraint with no expiration.',
    `effective_start_date` DATE COMMENT 'Date from which this MOQ constraint becomes effective and is applied by MRP planning logic.',
    `exception_approval_authority` STRING COMMENT 'Role or position authorized to approve exceptions to this MOQ constraint (e.g., Supply Planning Manager, Procurement Director).',
    `exception_approval_flag` BOOLEAN COMMENT 'Indicates whether exceptions to this MOQ constraint can be approved by supply planners on a case-by-case basis.',
    `fixed_lot_size` DECIMAL(18,2) COMMENT 'Fixed lot size for procurement. When set, MRP generates planned orders in exact multiples of this quantity regardless of net requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MOQ constraint record was last modified or updated.',
    `last_review_date` DATE COMMENT 'Date when this MOQ constraint was last reviewed and validated by supply planning or procurement teams.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed per purchase order for this material-supplier combination. MRP will split requirements exceeding this limit into multiple planned orders.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the MOQ value (e.g., EA for each, KG for kilograms, M for meters). Must align with material base unit or order unit.. Valid values are `^[A-Z]{2,3}$`',
    `moq_value` DECIMAL(18,2) COMMENT 'Minimum order quantity that must be purchased from this supplier for this material. MRP will not generate planned orders below this threshold.',
    `mrp_lot_sizing_procedure_code` STRING COMMENT 'SAP MRP lot-sizing procedure code that incorporates this MOQ constraint (e.g., EX for lot-for-lot with rounding, HB for replenish to maximum stock level).. Valid values are `^[A-Z0-9]{2,4}$`',
    `negotiation_date` DATE COMMENT 'Date when this MOQ constraint was negotiated and agreed upon with the supplier.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this MOQ constraint to ensure it remains aligned with business needs and supplier capabilities.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this MOQ constraint, including special handling instructions, exception history, or supplier communication details.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where this MOQ constraint applies. May be null if constraint applies globally across all plants.. Valid values are `^[A-Z0-9]{4,10}$`',
    `previous_moq_value` DECIMAL(18,2) COMMENT 'Previous minimum order quantity value before the most recent change. Used to track MOQ negotiation history and trends.',
    `priority_ranking` STRING COMMENT 'Priority ranking of this constraint when multiple MOQ constraints exist for the same material from different suppliers. Lower numbers indicate higher priority.',
    `purchasing_organization_code` STRING COMMENT 'Purchasing organization responsible for negotiating and managing this MOQ constraint.. Valid values are `^[A-Z0-9]{4,10}$`',
    `rounding_value` DECIMAL(18,2) COMMENT 'Rounding increment for order quantities. MRP rounds planned order quantities up to the nearest multiple of this value (e.g., rounding value of 10 means orders in multiples of 10).',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this MOQ constraint record originated (e.g., SAP_MM, ARIBA, D365_SCM).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `source_system_record_reference` STRING COMMENT 'Unique identifier of this MOQ constraint record in the source system, enabling traceability and reconciliation.',
    `supplier_lead_time_days` STRING COMMENT 'Standard procurement lead time in days from this supplier for this material, associated with orders meeting the MOQ constraint.',
    `supplier_package_quantity` DECIMAL(18,2) COMMENT 'Standard package or container quantity defined by the supplier. Orders must be placed in multiples of this package size.',
    CONSTRAINT pk_moq_constraint PRIMARY KEY(`moq_constraint_id`)
) COMMENT 'Captures Minimum Order Quantity (MOQ) and lot-sizing constraints for each material-supplier combination, including MOQ value, order quantity rounding value, maximum order quantity, fixed lot size, and the business justification for the constraint. Tracks MOQ negotiation history and exceptions approved by supply planners. These constraints directly influence MRP lot-size calculations and procurement cost optimization.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` (
    `demand_plan_version_id` BIGINT COMMENT 'Unique identifier for the demand plan version record. Primary key for the demand plan version entity.',
    `plan_id` BIGINT COMMENT 'Reference to the parent demand plan that this version belongs to. Links to the master demand plan entity.',
    `employee_id` BIGINT COMMENT 'Reference to the user who granted final approval for this demand plan version. Links to the user or employee master for audit trail and accountability in the S&OP approval workflow.',
    `superseded_by_version_demand_plan_version_id` BIGINT COMMENT 'Reference to the newer demand plan version that replaces this version. Null if this is the current active version. Maintains version lineage and audit trail for plan evolution tracking.',
    `tertiary_demand_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this demand plan version record. Links to the user or employee master for change tracking and accountability.',
    `approval_date` DATE COMMENT 'Date when this demand plan version was formally approved by authorized stakeholders. Null if version has not yet been approved. Marks the transition to executable plan status.',
    `approved_flag` BOOLEAN COMMENT 'Indicates whether this demand plan version has received formal approval through the S&OP governance process. True if approved for execution, false if still in draft or review.',
    `baseline_version_flag` BOOLEAN COMMENT 'Indicates whether this version serves as the baseline reference for variance analysis and scenario comparison. True if this is the authoritative baseline, false for alternative scenarios or working versions.',
    `bias_percentage` DECIMAL(18,2) COMMENT 'Systematic tendency of this demand plan version to over-forecast (positive bias) or under-forecast (negative bias) actual demand. Calculated as the sum of forecast errors divided by sum of actuals, used to detect and correct persistent forecasting errors.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'Statistical confidence level associated with the demand forecast in this version. Represents the probability that actual demand will fall within the forecasted range, typically 80%, 90%, or 95% confidence intervals used for safety stock calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this demand plan version record was first created in the data platform. Used for audit trail, data lineage, and record lifecycle tracking.',
    `demand_time_fence_days` STRING COMMENT 'Number of days from the current date within which demand changes are frozen or restricted. Defines the period where MRP (Material Requirements Planning) will not automatically adjust planned orders based on forecast changes, protecting near-term production stability.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Measured accuracy of this demand plan version compared to actual demand realization. Calculated as 100 minus the Mean Absolute Percentage Error (MAPE), used for continuous improvement of forecasting methods and model selection.',
    `forecast_model_code` STRING COMMENT 'Identifier for the statistical or algorithmic model used to generate demand forecasts in this version (e.g., ARIMA, exponential smoothing, machine learning model). Applicable when planning method is statistical or APS.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this demand plan version record was most recently updated. Used for audit trail, change tracking, and data synchronization across systems.',
    `material_group_code` STRING COMMENT 'Product family or material group classification for demand aggregation. Used to organize demand planning at the product category level before disaggregation to individual SKUs (Stock Keeping Units).. Valid values are `^[A-Z0-9]{1,10}$`',
    `planning_horizon_days` STRING COMMENT 'Total number of calendar days covered by this demand plan version. Calculated as the difference between planning horizon end and start dates, used for capacity planning and lead time analysis.',
    `planning_horizon_end_date` DATE COMMENT 'Last date of the planning period covered by this demand plan version. Defines the end of the forecast window, typically aligned with fiscal quarters or annual planning cycles.',
    `planning_horizon_start_date` DATE COMMENT 'First date of the planning period covered by this demand plan version. Defines the beginning of the forecast window for supply planning and MRP (Material Requirements Planning) execution.',
    `planning_method` STRING COMMENT 'Methodology used to generate this demand plan version. Statistical uses algorithmic forecasting, collaborative incorporates cross-functional input, consensus reflects S&OP agreement, APS (Advanced Planning and Scheduling) uses optimization engines, and manual indicates planner-driven creation.. Valid values are `statistical|collaborative|consensus|aps|manual`',
    `planning_time_fence_days` STRING COMMENT 'Number of days from the current date within which supply planning changes require manual approval. Defines the period where automated MRP adjustments are restricted to prevent disruption to committed production schedules.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code for which this demand plan version applies. Links to the plant master in SAP PP or Microsoft Dynamics 365 SCM for location-specific demand planning.. Valid values are `^[A-Z0-9]{4,10}$`',
    `scenario_name` STRING COMMENT 'Business name for the planning scenario represented by this version. Used for what-if analysis and sensitivity testing in S&OP processes (e.g., Optimistic Growth, Conservative Base, Supply Constrained).',
    `source_system_code` STRING COMMENT 'Identifier for the operational system that created or owns this demand plan version record. Typically Microsoft Dynamics 365 SCM, SAP APO (Advanced Planning and Optimization), or specialized demand planning applications for data lineage and integration traceability.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `total_planned_demand_quantity` DECIMAL(18,2) COMMENT 'Aggregate demand quantity across all materials and time buckets within this plan version. Represents the total forecasted demand volume for supply network capacity planning and scenario comparison.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the total planned demand quantity. Typically base inventory unit (EA, KG, L, M) aligned with material master UOM definitions in SAP MM or Microsoft Dynamics 365 SCM.. Valid values are `^[A-Z]{2,6}$`',
    `version_notes` STRING COMMENT 'Free-text commentary and business context for this demand plan version. Captures assumptions, market conditions, promotional events, supply constraints, or other factors influencing the forecast that are relevant for scenario interpretation and decision-making.',
    `version_number` STRING COMMENT 'Business identifier for the demand plan version. Human-readable version code used for tracking and referencing specific plan iterations (e.g., V1.0, V2.1, BASELINE-2024Q1).. Valid values are `^[A-Z0-9]{1,20}$`',
    `version_status` STRING COMMENT 'Current lifecycle status of the demand plan version. Tracks the approval workflow state from initial draft through review, approval, and eventual archival or supersession by newer versions.. Valid values are `draft|in_review|approved|rejected|superseded|archived`',
    `version_type` STRING COMMENT 'Classification of the demand plan version indicating its purpose and stage in the S&OP (Sales and Operations Planning) process. Baseline represents initial statistical forecast, sales-adjusted includes sales team input, consensus reflects cross-functional agreement, approved is the final authorized plan, and working is an in-progress draft.. Valid values are `baseline|statistical|sales_adjusted|consensus|approved|working`',
    `creation_date` DATE COMMENT 'Date when this demand plan version was created. Represents the business event timestamp for version instantiation in the S&OP cycle.',
    CONSTRAINT pk_demand_plan_version PRIMARY KEY(`demand_plan_version_id`)
) COMMENT 'Manages versioned demand plan records enabling scenario comparison and consensus planning. Captures plan version identifier, version type (baseline statistical, sales-adjusted, consensus, approved), creation date, planning horizon, total planned demand quantity, and version approval workflow status. Supports S&OP (Sales and Operations Planning) processes by maintaining multiple demand scenarios for supply planning sensitivity analysis in Microsoft Dynamics 365 SCM.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` (
    `sop_cycle_id` BIGINT COMMENT 'Unique identifier for the S&OP cycle record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user responsible for orchestrating and managing this S&OP cycle. Typically the S&OP manager or demand planning manager.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the S&OP cycle was formally approved by executive leadership, marking the transition to execution phase.',
    `approved_demand_forecast_version` STRING COMMENT 'Version identifier of the demand forecast approved during this S&OP cycle. Links to the demand forecast master data in Microsoft Dynamics 365 SCM.. Valid values are `^DF-[0-9]{4}-[0-9]{2}-V[0-9]{2}$`',
    `approved_supply_plan_version` STRING COMMENT 'Version identifier of the supply plan approved during this S&OP cycle. Links to the supply plan master data in Microsoft Dynamics 365 SCM and SAP PP/MM.. Valid values are `^SP-[0-9]{4}-[0-9]{2}-V[0-9]{2}$`',
    `business_unit_code` STRING COMMENT 'Code identifying the primary business unit participating in this S&OP cycle (e.g., AUTO for Automation, ELEC for Electrification, INFRA for Smart Infrastructure).. Valid values are `^[A-Z]{2,6}$`',
    `capacity_utilization_target_percentage` DECIMAL(18,2) COMMENT 'Target capacity utilization percentage for manufacturing plants during the planning period. Used to assess supply plan feasibility and identify capacity constraints.',
    `cost_plan_amount` DECIMAL(18,2) COMMENT 'Total planned cost of goods sold (COGS) for the planning period based on the approved supply plan and material/labor cost assumptions. Used for financial reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this S&OP cycle record was first created in the system.',
    `cycle_name` STRING COMMENT 'Descriptive name for the S&OP cycle, often including the planning period and business context (e.g., January 2024 S&OP Cycle - Automation Division).',
    `cycle_notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or important observations related to this S&OP cycle.',
    `cycle_number` STRING COMMENT 'Business identifier for the S&OP cycle, typically formatted as SOP-YYYY-MM representing the planning period.. Valid values are `^SOP-[0-9]{4}-[0-9]{2}$`',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the S&OP cycle. Tracks progression through demand review, supply review, pre-S&OP meeting, executive S&OP decision, approval, and closure. [ENUM-REF-CANDIDATE: draft|demand_review|supply_review|pre_sop|executive_sop|approved|closed — 7 candidates stripped; promote to reference product]',
    `demand_review_completion_date` DATE COMMENT 'Date when the demand review phase was completed and demand consensus was achieved.',
    `demand_review_status` STRING COMMENT 'Status of the demand review phase within this S&OP cycle. Tracks completion of demand consensus building across sales, marketing, and product management.. Valid values are `not_started|in_progress|completed|approved`',
    `demand_supply_gap_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity gap between demand forecast and supply plan across all materials and time periods within this S&OP cycle. Positive values indicate demand exceeds supply; negative values indicate supply exceeds demand.',
    `demand_supply_gap_value` DECIMAL(18,2) COMMENT 'Aggregate financial value of the demand-supply gap in base currency. Represents revenue at risk (if demand exceeds supply) or excess inventory exposure (if supply exceeds demand).',
    `executive_sop_decision` STRING COMMENT 'Summary of executive decisions made during the executive S&OP meeting, including strategic trade-offs, investment approvals, and final plan authorization.',
    `executive_sop_meeting_date` DATE COMMENT 'Date when the executive S&OP meeting was held for final decision-making and plan approval by senior leadership.',
    `financial_reconciliation_date` DATE COMMENT 'Date when financial reconciliation was completed and the S&OP plan was aligned with the financial budget.',
    `financial_reconciliation_status` STRING COMMENT 'Status of financial reconciliation between the approved S&OP plan and the financial budget. Ensures alignment between operational plans and financial commitments.. Valid values are `not_started|in_progress|completed|approved`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year, typically 1-12, used for financial reconciliation.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this S&OP cycle belongs, used for financial reconciliation and annual planning alignment.',
    `gap_resolution_strategy` DECIMAL(18,2) COMMENT 'Description of the strategy approved to resolve demand-supply gaps, including capacity expansion, supplier escalation, demand shaping, inventory build, or customer allocation decisions.',
    `inventory_plan_value` DECIMAL(18,2) COMMENT 'Target inventory value at the end of the planning period based on the approved supply plan. Used for working capital planning and financial reconciliation.',
    `key_assumptions` STRING COMMENT 'Critical assumptions underlying the S&OP plan, including market conditions, customer demand drivers, supplier performance, capacity availability, and economic factors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this S&OP cycle record was last updated in the system.',
    `planning_horizon_months` STRING COMMENT 'Number of months into the future covered by this S&OP cycle planning horizon. Typically 12-18 months for industrial manufacturing.',
    `planning_period_end_date` DATE COMMENT 'End date of the planning horizon covered by this S&OP cycle. Typically the last day of the month for monthly S&OP cycles.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning horizon covered by this S&OP cycle. Typically the first day of the month for monthly S&OP cycles.',
    `plant_code` STRING COMMENT 'Primary manufacturing plant code for which this S&OP cycle is executed. Links to SAP S/4HANA plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `pre_sop_meeting_date` DATE COMMENT 'Date when the pre-S&OP meeting was held to reconcile demand and supply plans and prepare recommendations for executive review.',
    `pre_sop_meeting_outcome` STRING COMMENT 'Summary of key decisions, gap resolutions, and recommendations from the pre-S&OP meeting. Captures consensus on demand-supply balance and escalation items for executive S&OP.',
    `revenue_plan_amount` DECIMAL(18,2) COMMENT 'Total planned revenue for the planning period based on the approved demand forecast and pricing assumptions. Used for financial reconciliation.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this S&OP cycle record originated. Typically Microsoft Dynamics 365 SCM integrated business planning module.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `supply_review_completion_date` DATE COMMENT 'Date when the supply review phase was completed and supply commitment was established.',
    `supply_review_status` STRING COMMENT 'Status of the supply review phase within this S&OP cycle. Tracks completion of supply capability assessment across manufacturing, procurement, and logistics.. Valid values are `not_started|in_progress|completed|approved`',
    `supply_risk_level` STRING COMMENT 'Overall supply risk assessment for this S&OP cycle, considering supplier lead times, capacity constraints, material availability, and geopolitical factors.. Valid values are `low|medium|high|critical`',
    `supply_risk_mitigation_plan` STRING COMMENT 'Description of actions planned to mitigate identified supply risks, including supplier diversification, safety stock increases, or alternative sourcing strategies.',
    CONSTRAINT pk_sop_cycle PRIMARY KEY(`sop_cycle_id`)
) COMMENT 'Represents a Sales and Operations Planning (S&OP) cycle record for the industrial manufacturing business, capturing the monthly integrated business planning process execution. Records planning cycle period, participating business units (automation, electrification, smart infrastructure), demand review status, supply review status, pre-S&OP meeting outcomes, executive S&OP decisions, approved supply plan version, approved demand forecast version, key supply/demand gap resolutions, and financial reconciliation status. Serves as the governance audit record linking demand consensus to supply commitment for each planning period. Managed through Microsoft Dynamics 365 SCM integrated business planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key for allocation',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account receiving the allocation when allocation_recipient_type is customer or oem_partner.',
    `employee_id` BIGINT COMMENT 'Reference to the supply chain manager or executive who approved this allocation decision.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Allocation of supply to specific sales order lines is required for the Order Fulfillment Allocation process, ensuring each lines quantity is matched to available supply.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the automation component, electrification module, or smart infrastructure product being allocated.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Allocation of supply quantities to fulfill obligations under specific service contracts (Contract Allocation dashboard).',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Allocation records allocate available supply to specific SKUs for order fulfillment.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier whose capacity or delivery constraints triggered the allocation decision.',
    `plan_id` BIGINT COMMENT 'Reference to the constrained supply plan that triggered this allocation decision.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of material allocated to the recipient entity (customer, plant, distribution center, or product line).',
    `allocation_number` STRING COMMENT 'Business-facing unique allocation identifier used for tracking and reference in supply chain communications.. Valid values are `^ALLOC-[0-9]{8}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the allocation decision in the supply chain workflow. [ENUM-REF-CANDIDATE: draft|proposed|approved|active|partially_fulfilled|fulfilled|cancelled|superseded — 8 candidates stripped; promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation decision was formally approved for execution.',
    `available_supply_quantity` DECIMAL(18,2) COMMENT 'Total constrained supply quantity available for allocation across all competing demand requests.',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether allocation notification has been sent to the affected customer or recipient entity.',
    `communication_sent_timestamp` TIMESTAMP COMMENT 'Date and time when allocation notification was sent to the recipient.',
    `constraint_description` STRING COMMENT 'Detailed narrative explanation of the supply constraint circumstances, including supplier names, affected components, and expected resolution timeline.',
    `constraint_reason_code` STRING COMMENT 'Standardized code identifying the root cause of the supply constraint that necessitated this allocation decision.. Valid values are `semiconductor_shortage|long_lead_time|supplier_capacity|force_majeure|quality_hold|logistics_disruption`',
    `contract_reference_number` STRING COMMENT 'Reference number of the supply contract or SLA that mandates this allocation when contractual_commitment_flag is true.. Valid values are `^CTR-[0-9]{10}$`',
    `contractual_commitment_flag` BOOLEAN COMMENT 'Indicates whether this allocation fulfills a contractual supply commitment or service level agreement (SLA) obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation record was first created in the system.',
    `customer_tier` STRING COMMENT 'Customer segmentation tier used in priority-based or customer-tier allocation methods to determine allocation preference.. Valid values are `tier_1|tier_2|tier_3|strategic|standard`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation decision was made by the supply planning team or automated allocation engine.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this allocation decision required executive escalation due to high business impact or customer sensitivity.',
    `expected_resolution_date` DATE COMMENT 'Anticipated date when the supply constraint will be resolved and normal supply levels restored.',
    `fulfillment_percentage` DECIMAL(18,2) COMMENT 'Percentage of requested quantity that was allocated, calculated as (allocated_quantity / requested_quantity) * 100.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation record was last updated or revised.',
    `method` STRING COMMENT 'Algorithm or business rule used to distribute constrained supply across competing demand requests.. Valid values are `proportional|priority_based|customer_tier|contractual_commitment|fair_share|first_come_first_served`',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, exceptions, or business rationale for the allocation decision.',
    `period_end_date` DATE COMMENT 'End date of the time period for which this allocation decision is effective.',
    `period_start_date` DATE COMMENT 'Start date of the time period for which this allocation decision is effective.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or distribution center where the constrained supply originates.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Numeric priority ranking assigned to this allocation decision, where lower numbers indicate higher priority in fulfillment sequencing.',
    `product_line_code` STRING COMMENT 'Code identifying the product line receiving the allocation when allocation_recipient_type is product_line.. Valid values are `^PL-[A-Z0-9]{6}$`',
    `recipient_distribution_center_code` STRING COMMENT 'Code identifying the regional distribution center receiving the allocation when allocation_recipient_type is distribution_center.. Valid values are `^DC-[A-Z0-9]{4}$`',
    `recipient_plant_code` STRING COMMENT 'Four-character code identifying the recipient plant when allocation_recipient_type is plant.. Valid values are `^[A-Z0-9]{4}$`',
    `recipient_type` STRING COMMENT 'Type of entity receiving the allocated supply, used to determine the appropriate recipient identifier field.. Valid values are `customer|plant|distribution_center|product_line|sales_region|oem_partner`',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Original quantity requested by the recipient before allocation constraints were applied.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that created this allocation record (e.g., D365_SCM for Microsoft Dynamics 365 Supply Chain Management, SAP_PP for SAP Production Planning).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the allocated quantity (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    `version` STRING COMMENT 'Version number of the allocation decision, incremented when allocation is revised or rebalanced.',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Records supply allocation decisions made when available supply is insufficient to meet total demand across the industrial manufacturing portfolio. Specifies how constrained supply of automation components, electrification modules, or smart infrastructure products is distributed across OEM customers, regional distribution centers, plants, or product lines. Captures allocation quantity, allocation priority, allocation method (proportional, priority-based, customer-tier, contractual commitment), allocation period, demand requests being fulfilled or partially fulfilled, and the constraining supply plan reference. Critical for managing semiconductor shortages, long-lead-time component constraints, and force majeure events in industrial manufacturing supply chains.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` (
    `replenishment_proposal_id` BIGINT COMMENT 'Unique identifier for the replenishment proposal record. Primary key.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which replenishment is proposed.',
    `mrp_run_id` BIGINT COMMENT 'Reference to the MRP run that generated this replenishment proposal.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Replenishment proposals are triggered by individual sales orders; linking to order_header enables the Replenishment Proposal Generation report.',
    `employee_id` BIGINT COMMENT 'Reference to the user who firmed this proposal, locking it from automatic MRP adjustments.',
    `supply_plant_id` BIGINT COMMENT 'FK to supply.plant',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: Replenishment proposals are generated from field service requests for spare parts (Service‑Driven Replenishment process).',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Replenishment proposals are generated per SKU to trigger purchase orders or production.',
    `source_plant_id` BIGINT COMMENT 'FK to supply.plant',
    `supplier_id` BIGINT COMMENT 'Reference to the preferred or proposed supplier for external procurement proposals. Null for in-house production proposals.',
    `converted_document_number` STRING COMMENT 'Document number of the purchase order, production order, or stock transport order created from this proposal. Null if not yet converted.',
    `converted_document_type` STRING COMMENT 'Type of execution document created when the proposal was converted: purchase_order, production_order, stock_transport_order, or subcontract_order. Null if not yet converted.. Valid values are `purchase_order|production_order|stock_transport_order|subcontract_order`',
    `converted_timestamp` TIMESTAMP COMMENT 'Date and time when the proposal was converted into a purchase order, production order, or stock transport order.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment proposal record was first created in the system, typically during MRP run execution.',
    `exception_message_code` STRING COMMENT 'MRP exception or warning code associated with this proposal (e.g., reschedule in, reschedule out, cancel, increase quantity, decrease quantity). Alerts planner to abnormal conditions.',
    `exception_message_text` STRING COMMENT 'Human-readable description of the MRP exception or planning situation requiring planner attention.',
    `firmed_flag` BOOLEAN COMMENT 'Indicates whether the proposal has been firmed by the planner. Firmed proposals are protected from automatic MRP changes in subsequent runs.',
    `firmed_timestamp` TIMESTAMP COMMENT 'Date and time when the proposal was firmed by the planner.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment proposal record was last updated, capturing planner actions, status changes, or subsequent MRP run adjustments.',
    `lead_time_days` STRING COMMENT 'Total procurement or production lead time in days used to calculate the proposed order date from the requirement date. Includes processing, manufacturing, and transit time.',
    `lot_sizing_procedure` STRING COMMENT 'Algorithm used by MRP to determine the proposed quantity: lot_for_lot (exact requirement), fixed_lot_size (standard batch), economic_order_quantity (EOQ optimization), period_lot_size (aggregate period demand), or replenish_to_max (fill to maximum stock level).. Valid values are `lot_for_lot|fixed_lot_size|economic_order_quantity|period_lot_size|replenish_to_max`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity constraint applied during MRP calculation, typically driven by supplier requirements or production batch minimums.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or buyer/planner responsible for reviewing and actioning this proposal.',
    `planner_notes` STRING COMMENT 'Free-text comments entered by the planner documenting decisions, overrides, or special handling instructions for this proposal.',
    `planner_override_date` DATE COMMENT 'Manually adjusted delivery date entered by the planner, overriding the MRP-calculated proposed delivery date. Null if no override applied.',
    `planner_override_quantity` DECIMAL(18,2) COMMENT 'Manually adjusted quantity entered by the planner, overriding the MRP-calculated proposed quantity. Null if no override applied.',
    `planning_time_fence_flag` BOOLEAN COMMENT 'Indicates whether this proposal falls within the planning time fence period where automatic MRP changes are restricted and planner approval is required for modifications.',
    `priority_code` STRING COMMENT 'Urgency level assigned to the proposal: critical (immediate action required), high (expedited processing), normal (standard lead time), or low (can be delayed if needed).. Valid values are `critical|high|normal|low`',
    `procurement_type` STRING COMMENT 'Method of procurement for the material: external (purchased from supplier), in_house (manufactured internally), or both (mixed procurement strategy).. Valid values are `external|in_house|both`',
    `proposal_number` STRING COMMENT 'Business-readable unique identifier for the replenishment proposal, typically system-generated or following organizational numbering convention.',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the replenishment proposal: open (awaiting planner review), firmed (approved by planner but not yet converted), converted (transformed into purchase order or production order), rejected (declined by planner), cancelled (voided due to changed requirements), or on_hold (temporarily suspended).. Valid values are `open|firmed|converted|rejected|cancelled|on_hold`',
    `proposal_type` STRING COMMENT 'Type of replenishment action proposed by MRP: purchase requisition for external procurement, planned production order for in-house manufacturing, stock transfer request for inter-plant movement, subcontract order for external processing, or external procurement for direct vendor shipment.. Valid values are `purchase_requisition|planned_production_order|stock_transfer_request|subcontract_order|external_procurement`',
    `proposed_delivery_date` DATE COMMENT 'Date by which the material should be available to meet demand requirements, calculated by MRP based on lead time and requirement date.',
    `proposed_order_date` DATE COMMENT 'Date when the purchase requisition or production order should be created to meet the proposed delivery date, accounting for procurement or manufacturing lead time.',
    `proposed_quantity` DECIMAL(18,2) COMMENT 'Quantity of material recommended by MRP for replenishment, calculated based on net requirements, lot sizing rules, and safety stock policies.',
    `purchasing_group_code` STRING COMMENT 'Organizational unit responsible for procurement activities for this material category. Used for purchase requisition routing.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why the planner rejected this proposal (e.g., obsolete material, demand cancelled, alternative source selected). Null if not rejected.',
    `rejection_reason_text` STRING COMMENT 'Detailed explanation of why the proposal was rejected by the planner. Null if not rejected.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers replenishment proposal generation in reorder point planning scenarios.',
    `requirement_date` DATE COMMENT 'Original date when the material is needed to satisfy customer orders, production schedules, or safety stock targets. Drives the MRP calculation.',
    `rounding_value` DECIMAL(18,2) COMMENT 'Rounding increment applied to the proposed quantity to align with packaging, pallet, or container standards (e.g., round to nearest 10, 50, or 100 units).',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Safety stock level maintained for this material at this location. MRP generates proposals to maintain this buffer against demand variability.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that generated this replenishment proposal (e.g., SAP_PP, D365_SCM, APS_SYSTEM).',
    `storage_location_code` STRING COMMENT 'Specific storage location within the plant where the replenished material will be received and stored.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the proposed quantity (e.g., EA for each, KG for kilogram, L for liter, M for meter).',
    CONSTRAINT pk_replenishment_proposal PRIMARY KEY(`replenishment_proposal_id`)
) COMMENT 'Consolidates MRP-generated replenishment proposals for buyer/planner review before conversion to purchase orders or production orders. Captures proposal type (purchase requisition, planned production order, stock transfer), proposed quantity, proposed dates, supplying source, proposal status (open, firmed, converted, rejected), and planner override details. Represents the actionable output of MRP runs requiring human review in SAP MM/PP.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` (
    `planning_parameter_id` BIGINT COMMENT 'Primary key for planning_parameter',
    `planning_calendar_id` BIGINT COMMENT 'Factory calendar identifier that defines working days, holidays, and shifts used to schedule planned order dates and calculate lead times.',
    `employee_id` BIGINT COMMENT '',
    `material_master_id` BIGINT COMMENT '',
    `supply_plant_id` BIGINT COMMENT '',
    `primary_planning_employee_id` BIGINT COMMENT 'System user identifier of the planner or administrator who created this planning parameter configuration record.',
    `primary_planning_material_master_id` BIGINT COMMENT 'Reference to the material master record for which these planning parameters apply.',
    `process_parameter_id` BIGINT COMMENT 'Foreign key linking to automation.process_parameter. Business justification: Connects planning parameters to defined process parameters, enabling the Production Planning‑Execution Alignment report that validates parameter consistency.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Planning parameters (lot size, lead time) are stored per SKU to drive MRP calculations.',
    `abc_indicator` STRING COMMENT 'Classification of the material based on consumption value or strategic importance: A=High Value/Critical, B=Medium Value/Moderate, C=Low Value/Routine, used to prioritize planning attention and inventory policies.. Valid values are `A|B|C`',
    `assembly_scrap_percent` DECIMAL(18,2) COMMENT 'Expected scrap or yield loss percentage during assembly or production, used to inflate gross requirements to account for anticipated waste.',
    `availability_check_group` STRING COMMENT 'Defines the scope and logic of ATP (Available-to-Promise) checking: which stock types, planned receipts, and reservations are considered when confirming customer orders or production orders.. Valid values are `01|02|03|KP|PP`',
    `backward_consumption_period_days` STRING COMMENT 'Number of days in the past that actual demand (sales orders, shipments) can consume forecast quantities, reducing planned independent requirements retroactively.',
    `consumption_mode` STRING COMMENT 'Defines how actual demand consumes forecast: 1=Backward Only, 2=Backward and Forward, 3=Forward Only, 4=Forecast Reduction by Material.. Valid values are `1|2|3|4`',
    `conversion_indicator` STRING COMMENT 'Controls whether planned orders are automatically converted to production or purchase orders: 1=Automatic Conversion, 2=Manual Conversion Required.. Valid values are `1|2`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter configuration record was first created in the system.',
    `discontinuation_indicator` STRING COMMENT 'Flags materials in phase-out: 1=Material to be Discontinued, 2=Successor Material Exists, Z=Discontinuation Effective, used to trigger follow-up material substitution in planning.. Valid values are `1|2|Z`',
    `effective_from_date` TIMESTAMP COMMENT '',
    `effective_out_date` DATE COMMENT 'Date on which this material is discontinued and should no longer be planned or procured, triggering transition to successor materials.',
    `effective_to_date` TIMESTAMP COMMENT '',
    `fixed_lot_size` DECIMAL(18,2) COMMENT '',
    `forward_consumption_period_days` STRING COMMENT 'Number of days in the future that actual demand can consume forecast quantities, allowing early orders to reduce future planned independent requirements.',
    `goods_receipt_processing_time_days` STRING COMMENT 'Time in days required for receiving, inspection, and posting of goods after physical arrival, extending the total procurement lead time.',
    `gr_processing_time_days` STRING COMMENT '',
    `in_house_production_time_days` STRING COMMENT 'Total lead time in days required to manufacture the material in-house, from order release to goods receipt, including queue, setup, processing, and move times.',
    `individual_collective_indicator` STRING COMMENT 'Defines whether requirements are managed individually per sales order (1=Individual Requirements) or pooled across orders (2=Collective Requirements) for planning purposes.. Valid values are `1|2`',
    `jit_delivery_schedules_flag` BOOLEAN COMMENT 'Indicates whether this material is managed under JIT delivery schedules with suppliers, enabling frequent small-lot deliveries synchronized with production consumption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter configuration record was most recently updated, supporting change tracking and audit compliance.',
    `last_mrp_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent MRP run that processed this material-plant combination using these planning parameters, enabling audit and troubleshooting.',
    `lot_sizing_procedure` STRING COMMENT 'Method used to calculate order quantities: EX=Lot-for-Lot, HB=Replenish to Maximum Stock Level, FX=Fixed Lot Size, WB=Weekly Lot Size, LS=Lot Size Key, ZB=Periodic Lot Size, EW=Economic Order Quantity, FB=Fixed Bin Quantity, LZ=Lot Size with Rounding. [ENUM-REF-CANDIDATE: EX|HB|FX|WB|LS|ZB|EW|FB|LZ — 9 candidates stripped; promote to reference product]',
    `maximum_lot_size` DECIMAL(18,2) COMMENT '',
    `maximum_lot_size_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity that can be procured or produced in a single lot, driven by storage capacity, equipment constraints, or supplier limitations.',
    `minimum_lot_size` DECIMAL(18,2) COMMENT '',
    `minimum_lot_size_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity that must be procured or produced in a single lot, enforcing MOQ constraints from suppliers or production efficiency requirements.',
    `mixed_mrp_indicator` STRING COMMENT 'Controls whether subassemblies are planned with the header material or separately: 1=Plan Subassemblies Separately, 2=Plan with Header, 3=No Mixed MRP.. Valid values are `1|2|3`',
    `mrp_controller` STRING COMMENT '',
    `mrp_controller_code` STRING COMMENT 'Three-character code identifying the planner or planning group responsible for managing MRP exceptions, firming planned orders, and coordinating supply for this material-plant combination.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how the planning run processes this material: PD=MRP, VB=Manual Reorder Point, VM=Automatic Reorder Point, VV=Forecast-Based Planning, ND=No Planning, R1=Time-Phased Planning, R2=Reorder Point Planning with External Requirements. [ENUM-REF-CANDIDATE: PD|VB|VM|VV|ND|R1|R2 — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT '',
    `parameter_effective_date` DATE COMMENT 'Date from which this planning parameter configuration becomes active and is used by MRP runs, enabling time-phased parameter changes.',
    `parameter_expiry_date` DATE COMMENT 'Date on which this planning parameter configuration expires and is no longer used by MRP runs, supporting planned transitions to new parameter sets.',
    `parameter_status` STRING COMMENT 'Current lifecycle status of this planning parameter record: active=In Use by MRP, inactive=Disabled, pending=Awaiting Approval, archived=Historical Record.. Valid values are `active|inactive|pending|archived`',
    `period_indicator` STRING COMMENT 'Defines the planning period granularity for this material: D=Daily, W=Weekly, M=Monthly, controlling how requirements are bucketed and planned orders are generated.. Valid values are `D|W|M`',
    `planned_delivery_time_days` STRING COMMENT 'Expected procurement lead time in days from purchase order creation to goods receipt for externally procured materials, based on supplier lead time agreements.',
    `planning_horizon_days` STRING COMMENT 'Total number of days into the future that the MRP run will generate planned orders and evaluate requirements, defining the outer boundary of the planning window.',
    `planning_strategy_group` DECIMAL(18,2) COMMENT 'Strategy that defines the planning approach: 10=Make-to-Stock, 11=Make-to-Stock with Final Assembly, 20=Make-to-Order, 25=Make-to-Order with Planning, 30=Production by Lot Size, 40=Planning at Assembly Level, 50=Planning without Final Assembly, 52=Planning with Final Assembly, 54=Planning with Planning Material, 56=Planning with Planning Material and Final Assembly, 59=Phantom Assembly, 60=Planning with Collective Requirements, 70=Planning at Sales Order Item Level, 82=Assembly Processing, 89=Configure-to-Order. [ENUM-REF-CANDIDATE: 10|11|20|25|30|40|50|52|54|56|59|60|70|82|89 — 15 candidates stripped; promote to reference product]',
    `planning_time_fence_days` STRING COMMENT 'Number of days from today defining the firm zone where MRP will not automatically create, reschedule, or delete planned orders without planner approval, protecting near-term execution stability.',
    `procurement_type` STRING COMMENT 'Defines how the material is obtained: E=In-house Production, F=External Procurement, X=Both (production and procurement possible).. Valid values are `E|F|X`',
    `quota_arrangement_usage` STRING COMMENT 'Defines how quota arrangements distribute procurement across multiple sources: 1=Quota Arrangement Active, 2=Quota Arrangement Inactive, 3=Quota Arrangement for Subcontracting.. Valid values are `1|2|3`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT '',
    `rounding_value` DECIMAL(18,2) COMMENT '',
    `rounding_value_quantity` DECIMAL(18,2) COMMENT 'Quantity increment to which planned order quantities are rounded up to align with packaging units, pallet sizes, or standard container quantities.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT '',
    `safety_time_days` STRING COMMENT '',
    `scheduling_margin_key` STRING COMMENT 'Key that defines opening period, float before production, and float after production used in backward and forward scheduling to buffer planned order dates.. Valid values are `^[A-Z0-9]{3}$`',
    `service_level_target_percent` DECIMAL(18,2) COMMENT '',
    `source_system_code` STRING COMMENT '',
    `special_procurement_type` STRING COMMENT 'Special procurement rule: 10=Withdrawal from Alternative Storage Location, 20=Production in Alternative Plant, 30=External Procurement from Alternative Plant, 40=Stock Transfer, 50=Phantom Assembly, 52=Collective Requirements, 60=Cross-Project Material, 70=Consignment, 80=Pipeline, 90=Subcontracting. [ENUM-REF-CANDIDATE: 10|20|30|40|50|52|60|70|80|90 — 10 candidates stripped; promote to reference product]',
    `strategy_group_counter` DECIMAL(18,2) COMMENT 'Sequence number used in conjunction with planning strategy group to differentiate multiple planning variants for the same material-plant combination.',
    `takt_time_minutes` DECIMAL(18,2) COMMENT 'Target production rate in minutes per unit, defining the pace at which this material must be produced to meet customer demand without overproduction or underproduction.',
    `unit_of_measure` STRING COMMENT '',
    CONSTRAINT pk_planning_parameter PRIMARY KEY(`planning_parameter_id`)
) COMMENT 'Stores the configurable planning parameters that govern MRP and APS behavior for each material-plant combination, including planning strategy (make-to-stock, make-to-order, assemble-to-order), planning horizon, time fence (firm zone, trade-off zone, planning zone), lot-sizing procedure, planning calendar, and MRP controller assignment. These parameters directly control how the supply planning engine generates planned orders and requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` (
    `aps_scenario_id` BIGINT COMMENT 'Primary key for aps_scenario',
    `baseline_aps_scenario_id` BIGINT COMMENT 'Self-referencing FK on aps_scenario (baseline_aps_scenario_id)',
    `employee_id` BIGINT COMMENT '',
    `plan_id` BIGINT COMMENT '',
    `approval_timestamp` TIMESTAMP COMMENT '',
    `approved_flag` BOOLEAN COMMENT '',
    `backorder_allowed` BOOLEAN COMMENT 'Whether backorders are permitted when demand exceeds supply.',
    `baseline_scenario_flag` BOOLEAN COMMENT '',
    `capacity_planning_method` STRING COMMENT 'Methodology applied to allocate production capacity in the scenario.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT '',
    `aps_scenario_code` STRING COMMENT 'Short alphanumeric code used to reference the scenario in systems and reports.',
    `convergence_tolerance` DECIMAL(18,2) COMMENT 'Numeric tolerance for stopping criteria of the optimizer.',
    `cost_model_version` DECIMAL(18,2) COMMENT 'Version of the cost model applied to calculate scenario economics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scenario record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for monetary values used in the scenario.',
    `demand_forecast_method` STRING COMMENT 'Technique used to generate demand forecasts within the scenario.',
    `demand_source` STRING COMMENT 'Origin of demand data used in the scenario.',
    `aps_scenario_description` STRING COMMENT 'Detailed free‑text description of the scenario purpose, scope and assumptions.',
    `effective_end_date` DATE COMMENT 'Date after which the scenario is no longer valid (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the scenario becomes valid for planning.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the scenario is currently active for planning runs.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lead_time_buffer_days` STRING COMMENT 'Additional safety buffer added to supplier lead times.',
    `lot_sizing_rule` STRING COMMENT 'Rule used to determine production lot sizes.',
    `max_iterations` DECIMAL(18,2) COMMENT 'Upper bound on solver iterations for convergence.',
    `aps_scenario_name` STRING COMMENT 'Human‑readable name of the planning scenario.',
    `notes` STRING COMMENT 'Free‑form notes or comments from planners.',
    `objective_function` STRING COMMENT '',
    `on_time_delivery_percent` DECIMAL(18,2) COMMENT '',
    `optimization_method` STRING COMMENT '',
    `optimization_objective` STRING COMMENT 'Primary objective the optimizer seeks to achieve.',
    `overtime_allowed` BOOLEAN COMMENT 'Indicates if overtime labor can be scheduled in the scenario.',
    `planning_algorithm` STRING COMMENT 'Algorithmic approach used by the optimizer.',
    `planning_horizon_days` STRING COMMENT 'Number of future days the scenario plans for.',
    `planning_horizon_end_date` TIMESTAMP COMMENT '',
    `planning_horizon_start_date` TIMESTAMP COMMENT '',
    `plant_code` STRING COMMENT '',
    `priority_level` STRING COMMENT 'Business priority of the scenario (1 = highest).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the scenario adheres to applicable industry regulations (e.g., environmental, safety).',
    `related_product_family` STRING COMMENT 'Identifier of the product family that the scenario primarily addresses.',
    `safety_stock_policy` STRING COMMENT 'Policy governing safety stock calculations.',
    `scenario_name` STRING COMMENT '',
    `scenario_notes` STRING COMMENT '',
    `scenario_number` STRING COMMENT '',
    `scenario_status` STRING COMMENT '',
    `scenario_type` STRING COMMENT 'Broad category of planning the scenario supports.',
    `service_level_percent` DECIMAL(18,2) COMMENT '',
    `solver_run_duration_minutes` DECIMAL(18,2) COMMENT '',
    `source_system_code` STRING COMMENT '',
    `aps_scenario_status` STRING COMMENT 'Lifecycle status of the scenario.',
    `supplier_inclusion_flag` BOOLEAN COMMENT 'Indicates whether supplier constraints are considered in the scenario.',
    `total_cost_amount` DECIMAL(18,2) COMMENT '',
    `total_late_orders_count` DECIMAL(18,2) COMMENT '',
    `total_revenue_amount` DECIMAL(18,2) COMMENT '',
    `updated_by` STRING COMMENT 'Identifier of the user who last modified the scenario.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scenario record.',
    `version_number` STRING COMMENT 'Version identifier for change management of the scenario definition.',
    `created_by` STRING COMMENT 'Identifier of the user who created the scenario.',
    CONSTRAINT pk_aps_scenario PRIMARY KEY(`aps_scenario_id`)
) COMMENT 'Master reference table for aps_scenario. Referenced by aps_scenario_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` (
    `planning_calendar_id` BIGINT COMMENT 'Primary key for planning_calendar',
    `base_planning_calendar_id` BIGINT COMMENT 'Self-referencing FK on planning_calendar (base_planning_calendar_id)',
    `employee_id` BIGINT COMMENT '',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the holiday calendar that defines non‑working days for this planning calendar.',
    `supply_plant_id` BIGINT COMMENT '',
    `calendar_code` STRING COMMENT 'Business identifier code used to reference the calendar in downstream systems.',
    `calendar_name` STRING COMMENT '',
    `calendar_status` STRING COMMENT '',
    `calendar_type` STRING COMMENT 'Category of the calendar indicating its primary planning purpose.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was first created in the system.',
    `planning_calendar_description` STRING COMMENT 'Free‑form description providing context or notes about the calendar.',
    `effective_from` DATE COMMENT 'Date when the calendar becomes effective for planning activities.',
    `effective_until` DATE COMMENT 'Date when the calendar ceases to be effective (nullable for open‑ended calendars).',
    `end_date` DATE COMMENT 'Last calendar day that is included in the planning horizon.',
    `first_workday_of_week` STRING COMMENT '',
    `frequency` STRING COMMENT 'Granularity at which planning cycles repeat.',
    `holidays_count` STRING COMMENT '',
    `is_holiday_calendar` BOOLEAN COMMENT 'Indicates whether the calendar includes holiday definitions (true) or not (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent planning run that used this calendar.',
    `planning_calendar_name` STRING COMMENT 'Human‑readable name of the planning calendar (e.g., Fiscal 2025, Production Shift Calendar).',
    `next_run_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next planning run that will use this calendar.',
    `notes` STRING COMMENT '',
    `number_of_periods` STRING COMMENT '',
    `period_length_days` STRING COMMENT '',
    `period_type` STRING COMMENT '',
    `planning_horizon_days` STRING COMMENT 'Number of days covered by the calendar for forward planning.',
    `shift_pattern_code` STRING COMMENT '',
    `source_system_code` STRING COMMENT '',
    `start_date` DATE COMMENT 'First calendar day that is included in the planning horizon.',
    `planning_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier (e.g., America/Chicago) used for timestamp calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calendar record.',
    `valid_from_date` TIMESTAMP COMMENT '',
    `valid_to_date` TIMESTAMP COMMENT '',
    `working_days_per_week` STRING COMMENT '',
    `working_hours_per_day` DECIMAL(18,2) COMMENT '',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the calendar record.',
    CONSTRAINT pk_planning_calendar PRIMARY KEY(`planning_calendar_id`)
) COMMENT 'Master reference table for planning_calendar. Referenced by planning_calendar_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` (
    `supply_plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT '',
    `address_line_2` STRING COMMENT '',
    `capacity` DECIMAL(18,2) COMMENT 'Maximum production capacity of the plant expressed in the unit defined by capacity_unit.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the production capacity.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'CO₂ emission factor (kg CO₂ per unit of production) for the plant.',
    `city` STRING COMMENT 'City where the plant is located.',
    `closing_date` DATE COMMENT 'Date the plant ceased operations, if applicable.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ISO 9001, ISO 14001) held by the plant.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the data lake.',
    `currency_code` STRING COMMENT '',
    `energy_source` STRING COMMENT 'Main source of energy used by the plant.',
    `is_primary_plant` BOOLEAN COMMENT 'Indicates whether this plant is the primary manufacturing site for the company.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant.',
    `location_address` STRING COMMENT 'Street address of the plant facility.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant.',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., 02:00‑04:00) when maintenance activities are performed.',
    `manager_email` STRING COMMENT 'Email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the primary manager responsible for the plant.',
    `manager_phone` STRING COMMENT 'Contact phone number for the plant manager.',
    `mrp_area_code` STRING COMMENT '',
    `supply_plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `notes` STRING COMMENT '',
    `number_of_shifts` STRING COMMENT 'Number of production shifts operated per day.',
    `opening_date` DATE COMMENT 'Date the plant began operations.',
    `operational_start_time` TIMESTAMP COMMENT 'Timestamp when the plant began its current operational run.',
    `planning_calendar_code` STRING COMMENT '',
    `plant_owner` STRING COMMENT 'Legal entity that owns the plant.',
    `plant_status` STRING COMMENT '',
    `plant_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the plant.',
    `plant_type` STRING COMMENT 'Category describing the primary function of the plant.',
    `postal_code` STRING COMMENT '',
    `power_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity of the plant in megawatts.',
    `purchasing_organization_code` STRING COMMENT '',
    `region` STRING COMMENT 'Broad geographic region where the plant resides.',
    `safety_rating` STRING COMMENT 'Safety performance rating of the plant.',
    `shift_hours` DECIMAL(18,2) COMMENT 'Length of each production shift in hours.',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `source_system_code` STRING COMMENT '',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `supply_plant_status` STRING COMMENT 'Current lifecycle state of the plant.',
    `time_zone` STRING COMMENT '',
    `timezone` STRING COMMENT 'IANA time zone identifier for the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_management_type` STRING COMMENT 'Primary waste management approach employed at the plant.',
    `water_usage_cubic_m` DECIMAL(18,2) COMMENT 'Total water consumption of the plant per reporting period.',
    CONSTRAINT pk_supply_plant PRIMARY KEY(`supply_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_demand_plan_version_id` FOREIGN KEY (`demand_plan_version_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`demand_plan_version`(`demand_plan_version_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_aps_scenario_id` FOREIGN KEY (`aps_scenario_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`aps_scenario`(`aps_scenario_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ADD CONSTRAINT `fk_supply_inventory_position_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ADD CONSTRAINT `fk_supply_demand_plan_version_superseded_by_version_demand_plan_version_id` FOREIGN KEY (`superseded_by_version_demand_plan_version_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`demand_plan_version`(`demand_plan_version_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ADD CONSTRAINT `fk_supply_allocation_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ADD CONSTRAINT `fk_supply_replenishment_proposal_source_plant_id` FOREIGN KEY (`source_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ADD CONSTRAINT `fk_supply_planning_parameter_planning_calendar_id` FOREIGN KEY (`planning_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planning_calendar`(`planning_calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ADD CONSTRAINT `fk_supply_planning_parameter_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ADD CONSTRAINT `fk_supply_aps_scenario_baseline_aps_scenario_id` FOREIGN KEY (`baseline_aps_scenario_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`aps_scenario`(`aps_scenario_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ADD CONSTRAINT `fk_supply_aps_scenario_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ADD CONSTRAINT `fk_supply_planning_calendar_base_planning_calendar_id` FOREIGN KEY (`base_planning_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planning_calendar`(`planning_calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ADD CONSTRAINT `fk_supply_planning_calendar_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `bom_explosion_level` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Explosion Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `demand_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Demand Time Fence Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `error_messages_count` SET TAGS ('dbx_business_glossary_term' = 'Error Messages Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `exception_messages_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Messages Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `include_forecast_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Forecast Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `include_safety_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Safety Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `include_wip_flag` SET TAGS ('dbx_business_glossary_term' = 'Include Work In Progress (WIP) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `lead_time_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Offset Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_value_regex' = 'lot_for_lot|fixed_lot_size|economic_order_quantity|period_order_quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `materials_processed_count` SET TAGS ('dbx_business_glossary_term' = 'Materials Processed Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planned_orders_cancelled_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Orders Cancelled Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planned_orders_created_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Orders Created Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planned_orders_rescheduled_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Orders Rescheduled Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_mode` SET TAGS ('dbx_business_glossary_term' = 'Planning Mode');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_mode` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `routing_explosion_flag` SET TAGS ('dbx_business_glossary_term' = 'Routing Explosion Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_parameters_json` SET TAGS ('dbx_business_glossary_term' = 'Run Parameters JSON');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regenerative|net_change|single_level|multi_level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'fixed_quantity|days_of_supply|statistical|none');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_value_regex' = 'forward|backward|finite|infinite');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'BOM (Bill of Materials) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Firmed By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `available_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `converted_order_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Converted Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `exception_message` SET TAGS ('dbx_business_glossary_term' = 'Exception Message');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `firmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Firmed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `firming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Firming Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Rule');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_value_regex' = 'exact_quantity|moq|fixed_lot|rounding');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'MOQ (Minimum Order Quantity)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP (Material Requirements Planning) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `multi_tier_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Tier Supplier Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'production_order|purchase_requisition|stock_transfer|subcontract_order');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planner_override_date` SET TAGS ('dbx_business_glossary_term' = 'Planner Override Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planner_override_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planner Override Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planning_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'open|under_review|firmed|converted|rejected|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `required_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Capacity (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `source_requirement_number` SET TAGS ('dbx_business_glossary_term' = 'Source Requirement Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `source_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Source Requirement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `source_requirement_type` SET TAGS ('dbx_value_regex' = 'sales_order|production_order|safety_stock|forecast|service_order');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Forecast Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `bias_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `consensus_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Consensus Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_class` SET TAGS ('dbx_business_glossary_term' = 'Demand Class');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_class` SET TAGS ('dbx_value_regex' = 'independent|dependent');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_pattern` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_pattern` SET TAGS ('dbx_value_regex' = 'stable|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'Forecast Consumption Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_model_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|obsolete');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `mean_absolute_percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `mrp_area_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Area Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `mrp_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `outlier_flag` SET TAGS ('dbx_business_glossary_term' = 'Outlier Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `outlier_reason` SET TAGS ('dbx_business_glossary_term' = 'Outlier Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `planning_group_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `planning_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `promotional_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `promotional_uplift_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional Uplift Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `sales_adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Adjustment Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `sales_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Sales Adjustment Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `seasonality_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Index');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `trend_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Trend Coefficient');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'baseline|sales_adjusted|consensus|approved|working');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `capacity_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `demand_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'LOT_FOR_LOT|FIXED_LOT|EOQ|POQ|PERIOD_LOT');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `maximum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `minimum_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'MRP (Material Requirements Planning) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_REVIEW|APPROVED|ACTIVE|SUPERSEDED|CANCELLED');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planned_supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Supply Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_business_glossary_term' = 'Planning Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_value_regex' = 'MRP|MRP_II|APS|MANUAL|JIT|KANBAN');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'IN_HOUSE|EXTERNAL|BOTH');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PP|DYNAMICS_SCM|OPCENTER|MANUAL');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `aps_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Planning and Scheduling (APS) Scenario ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `available_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_buffer_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Buffer Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_category` SET TAGS ('dbx_value_regex' = 'critical|standard|flexible');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_load_profile` SET TAGS ('dbx_business_glossary_term' = 'Capacity Load Profile');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_load_profile` SET TAGS ('dbx_value_regex' = 'uniform|peak|valley|variable');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_source_system` SET TAGS ('dbx_business_glossary_term' = 'Capacity Source System');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'hours|minutes|units|pieces');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Rate');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `critical_ratio` SET TAGS ('dbx_business_glossary_term' = 'Critical Ratio');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `efficiency_rate` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rate');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `is_bottleneck` SET TAGS ('dbx_business_glossary_term' = 'Is Bottleneck Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `last_mrp_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Material Requirements Planning (MRP) Run Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `leveling_adjustment_hours` SET TAGS ('dbx_business_glossary_term' = 'Leveling Adjustment Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `leveling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Leveling Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `overload_hours` SET TAGS ('dbx_business_glossary_term' = 'Overload Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|archived');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'RCCP|CRP|infinite|finite');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planned_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Downtime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `planning_version` SET TAGS ('dbx_business_glossary_term' = 'Planning Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `queue_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Queue Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `required_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Capacity Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'machine|labor|tooling|equipment');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `shift_count` SET TAGS ('dbx_business_glossary_term' = 'Shift Count');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `shift_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Shift Hours Per Day');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `underload_hours` SET TAGS ('dbx_business_glossary_term' = 'Underload Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `unplanned_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Unplanned Downtime Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `aps_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Planning and Scheduling (APS) Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'capacity|material|tooling|operator|none');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `earliest_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Earliest Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `fixed_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Schedule Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `latest_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Latest End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `machine_code` SET TAGS ('dbx_business_glossary_term' = 'Machine ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `overlap_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overlap Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `planning_horizon_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `released_to_mes_flag` SET TAGS ('dbx_business_glossary_term' = 'Released to Manufacturing Execution System (MES) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `released_to_mes_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released to Manufacturing Execution System (MES) Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `run_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^APS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_value_regex' = 'forward|backward|finite|infinite');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `scheduling_notes` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `slack_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slack Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'D365_SCM|OPCENTER|SAP_PP|CUSTOM_APS');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `split_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Allowed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `bom_explosion_date` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Explosion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `exception_message_text` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Text');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `firming_date` SET TAGS ('dbx_business_glossary_term' = 'Firming Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `gross_requirement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Gross Requirement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `in_house_production_time_days` SET TAGS ('dbx_business_glossary_term' = 'In-House Production Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Key');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `lot_size_key` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|WB|PD');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_element_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_element_type` SET TAGS ('dbx_value_regex' = 'sales_order|forecast|safety_stock|dependent_requirement|planned_order|purchase_requisition');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `net_requirement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Requirement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `pegging_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Pegging Requirement ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `planned_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `projected_available_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Available Balance');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_priority` SET TAGS ('dbx_business_glossary_term' = 'Requirement Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_source_item` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source Item');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_source_number` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'open|partially_covered|fully_covered|cancelled|expired');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `scheduled_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `active_sourcing_rules` SET TAGS ('dbx_business_glossary_term' = 'Active Sourcing Rules');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'ERP (Enterprise Resource Planning) Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `moq_minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ (Minimum Order Quantity) Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `network_tier_level` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `node_subtype` SET TAGS ('dbx_business_glossary_term' = 'Node Subtype');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'manufacturing_plant|distribution_center|supplier_facility|contract_manufacturer|customer_delivery_point|warehouse');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `operating_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Operating Days Per Week');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `operating_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Per Day');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party|contract|joint_venture');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `risk_exposure_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Score');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Cubic Meters');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `supplier_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `supports_cross_docking` SET TAGS ('dbx_business_glossary_term' = 'Supports Cross-Docking');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `supports_kitting` SET TAGS ('dbx_business_glossary_term' = 'Supports Kitting');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `supports_postponement` SET TAGS ('dbx_business_glossary_term' = 'Supports Postponement');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_units_per_day` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Units Per Day');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`network_node` ALTER COLUMN `transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `automatic_po_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Purchase Order (PO) Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Exception Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `fixed_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `gr_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `last_moq_negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Minimum Order Quantity (MOQ) Negotiation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `lot_size_rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'ex|hb|fb|pd|wm|mb');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Make or Buy Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `make_or_buy_indicator` SET TAGS ('dbx_value_regex' = 'make|buy|both');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `order_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `order_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `planner_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Planner Approved Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `quota_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Quota Arrangement Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_approval|expired');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority Rank');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sourcing_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sourcing_type` SET TAGS ('dbx_value_regex' = 'external_procurement|in_house_production|subcontracting|stock_transfer|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Valid From Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Valid To Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` SET TAGS ('dbx_subdomain' = 'inventory_positioning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `supply_safety_stock_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Safety Stock Policy ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `average_daily_demand` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'static|dynamic|statistical|manual');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `coverage_profile` SET TAGS ('dbx_business_glossary_term' = 'Coverage Profile');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `coverage_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `criticality_code` SET TAGS ('dbx_business_glossary_term' = 'Material Criticality Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `criticality_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `holding_cost_percent_annual` SET TAGS ('dbx_business_glossary_term' = 'Holding Cost Percentage (Annual)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `holding_cost_percent_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Rule');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `lot_size_rule` SET TAGS ('dbx_value_regex' = 'EX|HB|FX|WB|MB');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `moq_minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|VM|VV|R1|R2');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `planned_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `planner_code` SET TAGS ('dbx_business_glossary_term' = 'Material Planner Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `planner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `safety_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Safety Days of Supply');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `safety_time_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `special_procurement_key` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Key');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `special_procurement_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_safety_stock_policy` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `alternative_supplier_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Supplier Identified Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closed Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|manager|director|vp|executive|board');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `impact_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Impact Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `lead_time_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Impact in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_cost` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Cost');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Cost Currency');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Target Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `moq_impact` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Impact');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `potential_impact_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Potential Impact Duration in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `potential_supply_impact_quantity` SET TAGS ('dbx_business_glossary_term' = 'Potential Supply Impact Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `probability_of_occurrence` SET TAGS ('dbx_business_glossary_term' = 'Probability of Occurrence');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `probability_of_occurrence` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supplier|material|logistics|regulatory|demand|technology');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'identified|assessed|active|mitigated|closed|monitoring');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'single_source_dependency|geopolitical|capacity_constraint|quality_issue|natural_disaster|financial_instability');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`risk_register` ALTER COLUMN `safety_stock_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Recommendation');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `planning_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Exception Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Assigned User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'MRP (Material Requirements Planning) Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `available_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `current_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Current Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `customer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `customer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `customer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `demand_order_number` SET TAGS ('dbx_business_glossary_term' = 'Demand Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'sales_order|forecast|safety_stock|dependent_requirement|service_order|project_demand');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Impact');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `estimated_cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Detected Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_quantity` SET TAGS ('dbx_business_glossary_term' = 'Exception Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|cancelled|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP (Material Requirements Planning) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `recommended_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Recommended Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Taken');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `source_order_number` SET TAGS ('dbx_business_glossary_term' = 'Source Order Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `source_order_type` SET TAGS ('dbx_business_glossary_term' = 'Source Order Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `source_order_type` SET TAGS ('dbx_value_regex' = 'purchase_order|production_order|planned_order|transfer_order|stock_transport_order');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PP|SAP_MM|DYNAMICS_SCM|OPCENTER_APS');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` SET TAGS ('dbx_subdomain' = 'inventory_positioning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `average_daily_demand` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply (DOS)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `excess_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `in_quality_inspection_quantity` SET TAGS ('dbx_business_glossary_term' = 'In Quality Inspection Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `last_mrp_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Material Requirements Planning (MRP) Run Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `manufacturing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|ND|X0');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `net_requirement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Requirement Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `open_planned_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Planned Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `open_production_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Production Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `open_purchase_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Purchase Order (PO) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy Group');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `sales_order_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Demand Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP|D365|MES|LEGACY');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `stock_out_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Stock-Out Risk Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `supplier_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`inventory_position` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Constraint ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `apply_to_forecast_flag` SET TAGS ('dbx_business_glossary_term' = 'Apply to Forecast Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `apply_to_safety_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Apply to Safety Stock Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_source` SET TAGS ('dbx_business_glossary_term' = 'Constraint Source');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_source` SET TAGS ('dbx_value_regex' = 'supplier_requirement|logistics_constraint|cost_optimization|contract_term|manufacturing_batch_size|packaging_standard');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_business_glossary_term' = 'Constraint Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|expired|superseded');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'minimum_order_quantity|fixed_lot_size|order_multiple|maximum_order_quantity|economic_order_quantity|supplier_package_size');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `cost_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `cost_impact_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `cost_impact_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `exception_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Authority');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `exception_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `fixed_lot_size` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `moq_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `mrp_lot_sizing_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Lot-Sizing Procedure Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `mrp_lot_sizing_procedure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `previous_moq_value` SET TAGS ('dbx_business_glossary_term' = 'Previous MOQ Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `priority_ranking` SET TAGS ('dbx_business_glossary_term' = 'Priority Ranking');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `supplier_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`moq_constraint` ALTER COLUMN `supplier_package_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supplier Package Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `demand_plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Version Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `superseded_by_version_demand_plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Version Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `tertiary_demand_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `tertiary_demand_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `tertiary_demand_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `baseline_version_flag` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `demand_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Demand Time Fence in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Duration in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_method` SET TAGS ('dbx_business_glossary_term' = 'Planning Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_method` SET TAGS ('dbx_value_regex' = 'statistical|collaborative|consensus|aps|manual');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence in Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `scenario_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `scenario_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `total_planned_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Demand Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|superseded|archived');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'baseline|statistical|sales_adjusted|consensus|approved|working');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_plan_version` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Version Creation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Owner User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `approved_demand_forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Approved Demand Forecast Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `approved_demand_forecast_version` SET TAGS ('dbx_value_regex' = '^DF-[0-9]{4}-[0-9]{2}-V[0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `approved_supply_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Approved Supply Plan Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `approved_supply_plan_version` SET TAGS ('dbx_value_regex' = '^SP-[0-9]{4}-[0-9]{2}-V[0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `capacity_utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Target Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cost_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cost_plan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_notes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_number` SET TAGS ('dbx_value_regex' = '^SOP-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Review Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_status` SET TAGS ('dbx_business_glossary_term' = 'Demand Review Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_supply_gap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand-Supply Gap Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_supply_gap_value` SET TAGS ('dbx_business_glossary_term' = 'Demand-Supply Gap Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_supply_gap_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_sop_decision` SET TAGS ('dbx_business_glossary_term' = 'Executive S&OP Decision');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Executive S&OP Meeting Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `financial_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Reconciliation Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `financial_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Reconciliation Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `financial_reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `gap_resolution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Gap Resolution Strategy');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `inventory_plan_value` SET TAGS ('dbx_business_glossary_term' = 'Inventory Plan Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `inventory_plan_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Months');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `pre_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-S&OP Meeting Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `pre_sop_meeting_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pre-S&OP Meeting Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `revenue_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Plan Amount');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `revenue_plan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Review Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Review Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Mitigation Plan');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` SET TAGS ('dbx_subdomain' = 'inventory_positioning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{8}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `available_supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Supply Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `communication_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Constraint Description');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `constraint_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Constraint Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `constraint_reason_code` SET TAGS ('dbx_value_regex' = 'semiconductor_shortage|long_lead_time|supplier_capacity|force_majeure|quality_hold|logistics_disruption');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^CTR-[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `contractual_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Contractual Commitment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic|standard');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Decision Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `expected_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'proportional|priority_based|customer_tier|contractual_commitment|fair_share|first_come_first_served');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Product Line Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `product_line_code` SET TAGS ('dbx_value_regex' = '^PL-[A-Z0-9]{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_distribution_center_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Distribution Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_distribution_center_code` SET TAGS ('dbx_value_regex' = '^DC-[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Recipient Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'customer|plant|distribution_center|product_line|sales_region|oem_partner');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`allocation` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` SET TAGS ('dbx_subdomain' = 'inventory_positioning');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `replenishment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Proposal ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Firmed By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `source_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `source_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `converted_document_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `converted_document_type` SET TAGS ('dbx_business_glossary_term' = 'Converted Document Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `converted_document_type` SET TAGS ('dbx_value_regex' = 'purchase_order|production_order|stock_transport_order|subcontract_order');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Converted Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `exception_message_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `exception_message_text` SET TAGS ('dbx_business_glossary_term' = 'Exception Message Text');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `firmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Firmed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `firmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Firmed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'lot_for_lot|fixed_lot_size|economic_order_quantity|period_lot_size|replenish_to_max');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `planner_override_date` SET TAGS ('dbx_business_glossary_term' = 'Planner Override Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `planner_override_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planner Override Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `planning_time_fence_flag` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|in_house|both');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'open|firmed|converted|rejected|cancelled|on_hold');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|planned_production_order|stock_transfer_request|subcontract_order|external_procurement');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposed_order_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `proposed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Proposed Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `rejection_reason_text` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Text');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`replenishment_proposal` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planning_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Parameter Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planning_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Calendar ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `primary_planning_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `primary_planning_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `primary_planning_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `primary_planning_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `assembly_scrap_percent` SET TAGS ('dbx_business_glossary_term' = 'Assembly Scrap Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_business_glossary_term' = 'Availability Check Group');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `availability_check_group` SET TAGS ('dbx_value_regex' = '01|02|03|KP|PP');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `backward_consumption_period_days` SET TAGS ('dbx_business_glossary_term' = 'Backward Consumption Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `consumption_mode` SET TAGS ('dbx_business_glossary_term' = 'Consumption Mode');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `consumption_mode` SET TAGS ('dbx_value_regex' = '1|2|3|4');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `conversion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conversion Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `conversion_indicator` SET TAGS ('dbx_value_regex' = '1|2');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `discontinuation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `discontinuation_indicator` SET TAGS ('dbx_value_regex' = '1|2|Z');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `effective_out_date` SET TAGS ('dbx_business_glossary_term' = 'Effective-Out Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `forward_consumption_period_days` SET TAGS ('dbx_business_glossary_term' = 'Forward Consumption Period (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `in_house_production_time_days` SET TAGS ('dbx_business_glossary_term' = 'In-House Production Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `individual_collective_indicator` SET TAGS ('dbx_business_glossary_term' = 'Individual or Collective Requirements Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `individual_collective_indicator` SET TAGS ('dbx_value_regex' = '1|2');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `jit_delivery_schedules_flag` SET TAGS ('dbx_business_glossary_term' = 'Just-In-Time (JIT) Delivery Schedules Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `last_mrp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Material Requirements Planning (MRP) Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `maximum_lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `minimum_lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `mixed_mrp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mixed Material Requirements Planning (MRP) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `mixed_mrp_indicator` SET TAGS ('dbx_value_regex' = '1|2|3');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `parameter_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Parameter Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `parameter_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Parameter Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `period_indicator` SET TAGS ('dbx_business_glossary_term' = 'Period Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `period_indicator` SET TAGS ('dbx_value_regex' = 'D|W|M');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planning_strategy_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy Group');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `quota_arrangement_usage` SET TAGS ('dbx_business_glossary_term' = 'Quota Arrangement Usage');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `quota_arrangement_usage` SET TAGS ('dbx_value_regex' = '1|2|3');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `rounding_value_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Margin Key');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `strategy_group_counter` SET TAGS ('dbx_business_glossary_term' = 'Strategy Group Counter');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_parameter` ALTER COLUMN `takt_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Aps Scenario Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `baseline_aps_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Aps Scenario Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `baseline_aps_scenario_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `backorder_allowed` SET TAGS ('dbx_business_glossary_term' = 'Backorder Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `capacity_planning_method` SET TAGS ('dbx_business_glossary_term' = 'Capacity Planning Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `convergence_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Convergence Tolerance');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `cost_model_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Model Version');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `demand_forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Method');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `lead_time_buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Buffer Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `max_iterations` SET TAGS ('dbx_business_glossary_term' = 'Max Iterations');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `overtime_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overtime Allowed');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `planning_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Planning Algorithm');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `related_product_family` SET TAGS ('dbx_business_glossary_term' = 'Related Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `safety_stock_policy` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Policy');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `aps_scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `supplier_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Inclusion Flag');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`aps_scenario` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` SET TAGS ('dbx_subdomain' = 'network_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Calendar Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `base_planning_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Base Planning Calendar Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `base_planning_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `is_holiday_calendar` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Calendar');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `last_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `next_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Run Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `planning_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planning_calendar` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_subdomain' = 'supply_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot_group' = 'plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot_master' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot_of' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot_canonical' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_ssot_ref' = 'asset.plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_ssot_duplicate_resolved' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_ssot_master' = 'asset.asset_plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `carbon_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Factor');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `is_primary_plant` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Plant');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `location_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `location_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `number_of_shifts` SET TAGS ('dbx_business_glossary_term' = 'Number Of Shifts');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `operational_start_time` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `plant_owner` SET TAGS ('dbx_business_glossary_term' = 'Plant Owner');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `plant_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Plant Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `shift_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `site_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Site Area Sqm');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `waste_management_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `water_usage_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Cubic M');
