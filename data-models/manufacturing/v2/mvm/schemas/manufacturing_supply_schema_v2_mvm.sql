-- Schema for Domain: supply | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`supply` COMMENT 'Supply chain planning and demand management domain covering MRP/MRP II runs, demand forecasting, capacity planning, APS scheduling, supplier lead times, MOQ management, supply risk, multi-tier supplier coordination, and supply network optimization. Integrates Microsoft Dynamics 365 SCM and SAP PP/MM for end-to-end supply network visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` (
    `mrp_run_id` BIGINT COMMENT 'Unique identifier for the MRP/MRP II planning run execution. Primary key.',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: MRP runs are executed for a specific plant. mrp_run.plant_code is a denormalized string that should be replaced by a proper FK to supply_plant, the authoritative plant master in this domain. Normalizi',
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
    `routing_explosion_flag` BOOLEAN COMMENT 'Indicates whether production routing and work center capacity requirements were calculated during this MRP run (True) or only material requirements were computed (False).',
    `run_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from actual start to actual end of the MRP run. Key performance indicator for planning system efficiency.',
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
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Make‑to‑order production planning requires linking each planned order to the originating customer account for order tracking and delivery scheduling.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this planned order was generated.',
    `mrp_run_id` BIGINT COMMENT 'Unique identifier of the MRP or APS planning execution that generated this planned order.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Planned orders are the execution artifacts generated to fulfill a supply plan. Linking planned_order to supply_plan enables tracking of which planned orders were created to satisfy a given supply plan',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Planned orders in manufacturing reference a specific product BOM header to define the assembly structure for production execution and MRP explosion. This is the core planned order BOM assignment pro',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: Associates each planned order with the recipe governing its production steps, required for the Order‑Recipe Traceability dashboard.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Available-to-Promise/Capable-to-Promise: manufacturers create planned orders against sales quotes for long-lead-time items to commit delivery dates before order confirmation. This ATP/CTP process is s',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Production scheduling uses a specific component revision; the Planned Order Detail report references engineering.revision.revision_id to ensure the correct version is manufactured.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing that defines the sequence of operations and work centers for manufacturing this material.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Production planning ties each planned order to the SKU master for cost, compliance, and reporting of the manufactured product.',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Planned orders are generated based on sourcing rules that define lot sizing, MOQ, procurement type, and supplier preferences. Linking planned_order to sourcing_rule provides traceability from the plan',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Planned orders are generated for a specific manufacturing plant. planned_order.plant_code is a denormalized string that should be replaced by a FK to supply_plant. This enforces referential integrity ',
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
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Manufacturing S&OP forecasts demand at the ship-to site level for multi-site customers — each customer plant has distinct demand patterns, production schedules, and replenishment needs. Site-level for',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer‑specific demand forecasts are generated per account to support sales‑aligned planning and KPI reporting.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Demand forecasting in manufacturing is routinely performed at the product family level (S&OP family-level forecasting, then disaggregated to SKU). A supply planning expert expects demand_forecast to r',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: Installed-base-driven service parts forecasting: the number and age of installed units directly drives spare parts demand forecasts. Supply planners use installed base data to generate aftermarket/ser',
    `material_master_id` BIGINT COMMENT 'Reference to the material or item being forecasted. Links to the material master record in inventory domain.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.forecast. Business justification: Demand forecasting aligns internal plans with external sales forecasts; linking enables S&OP reconciliation.',
    `plan_id` BIGINT COMMENT 'Reference to the forecast version record enabling scenario comparison and version lineage tracking.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI pipeline forecasting: demand forecasts are created for products under development in engineering projects before SKU master records exist. S&OP teams link forecasts to engineering projects to trac',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: S&OP demand forecasting in manufacturing is routinely performed at customer segment level (OEM vs. aftermarket vs. distribution). Segment-level forecasts aggregate demand without requiring a specific ',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Contract-driven service parts forecasting: service contracts with committed SLAs and coverage scopes directly drive spare parts demand forecasts. Supply planners generate contract-specific forecasts t',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Forecasting uses the SKU master to align demand quantities with product specifications and pricing.',
    `stock_location_id` BIGINT COMMENT 'Reference to the planning location, warehouse, or distribution center for which demand is forecasted.',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Demand forecasts in manufacturing MRP contexts are often plant-specific, driving plant-level supply planning. Adding plant_id to demand_forecast normalizes the plant reference and enables plant-level ',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique identifier for the capacity plan record. Primary key for capacity planning analysis.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Rough-Cut Capacity Planning (RCCP) in manufacturing S&OP operates at the product family level before SKU-level detail. Capacity plans are created and reviewed by family to assess resource feasibility.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Capacity plans are generated as part of MRP/capacity planning runs. Linking capacity_plan to the mrp_run that produced it provides full traceability from planning execution to capacity output. capacit',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plan. Business justification: Capacity plans validate whether supply plans are feasible given available work center capacity. Linking capacity_plan to supply_plan enables capacity feasibility checks against specific supply plans, ',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI capacity planning: capacity plans are created for engineering projects during new product introduction ramp-up. Operations and supply planners link capacity plans to the NPI engineering project to',
    `sku_master_id` BIGINT COMMENT 'Identifier of the manufacturing plant or facility where the work center is located. Enables multi-plant capacity planning.',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Capacity plans are for work centers that belong to specific plants. While capacity_plan already links to work_center (cross-domain), a direct plant_id FK enables plant-level capacity aggregation and r',
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
    `leveling_strategy` STRING COMMENT 'Strategy applied to resolve capacity overload. Indicates the method used to balance capacity constraints.. Valid values are `overtime|shift_add|subcontract|reschedule|none`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` (
    `material_requirement_id` BIGINT COMMENT 'Unique identifier for the material requirement record generated by MRP run.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: MRP material requirements are generated through BOM explosion from a specific product BOM header. Tracing each material requirement back to its source BOM header is fundamental to the BOM-driven MRP',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: MRP BOM explosion traceability: material_requirement records are generated by exploding a specific BOM during an MRP run. Planners and engineers use this link to trace net requirements back to the BOM',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this requirement was generated.',
    `mrp_run_id` BIGINT COMMENT 'Reference to the specific MRP execution run that generated this requirement record.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Engineering change impact on MRP: material_requirement must reference the active engineering revision used during BOM explosion. When an ECO changes a revision, planners re-run MRP and compare require',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Material requirements are linked to the SKU master to calculate net requirements for the exact product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: MRP storage-location-level net requirements: material requirements are calculated per storage location in manufacturing MRP. Replaces denormalized storage_location_code plain attribute with a proper F',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Material requirements are computed per plant in MRP. material_requirement.plant_code is a denormalized string that should be replaced by a FK to supply_plant. This normalizes the plant reference and e',
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
    `procurement_type` STRING COMMENT 'Indicates how the material is procured: E (in-house production), F (external procurement), X (both).. Valid values are `E|F|X`',
    `projected_available_balance` DECIMAL(18,2) COMMENT 'Projected on-hand inventory balance after accounting for gross requirements and scheduled receipts up to this requirement date.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered to avoid stockout.',
    `requirement_date` DATE COMMENT 'The date on which the material is needed to meet demand or production schedule.',
    `requirement_priority` STRING COMMENT 'Numeric priority ranking used to sequence requirements when allocating limited supply or production capacity (lower number = higher priority).',
    `requirement_source_item` STRING COMMENT 'The line item number within the source document that triggered this requirement.',
    `requirement_status` STRING COMMENT 'Current fulfillment status of the material requirement: open (not yet covered), partially covered (some supply allocated), fully covered (sufficient supply allocated), cancelled, or expired.. Valid values are `open|partially_covered|fully_covered|cancelled|expired`',
    `rounding_value` DECIMAL(18,2) COMMENT 'Quantity increment to which planned orders are rounded up (e.g., round to nearest pallet quantity or container size).',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained as buffer against demand variability and supply uncertainty.',
    `scheduled_receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of material expected to be received from open purchase orders, production orders, or transfer orders by the requirement date.',
    `special_procurement_type` STRING COMMENT 'Code indicating special procurement scenarios such as subcontracting, consignment, stock transfer, or third-party order processing.',
    `unit_of_measure` STRING COMMENT 'The unit in which material quantities are expressed (e.g., EA for each, KG for kilogram, M for meter).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_material_requirement PRIMARY KEY(`material_requirement_id`)
) COMMENT 'Individual material requirement record produced by MRP, representing the net requirement for a specific material at a specific plant and date. Captures gross requirement, scheduled receipts, projected available balance, net requirement, lot-size adjusted requirement, and the requirement source (sales order, forecast, safety stock). Core output of SAP PP MRP runs used to drive procurement and production planning.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` (
    `sourcing_rule_id` BIGINT COMMENT 'Unique identifier for the sourcing rule record. Primary key.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Component-level make-or-buy sourcing: sourcing rules define procurement strategy (make_or_buy_indicator, preferred_supplier, MOQ, lead time) at the component level. Procurement and supply engineers li',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record that this sourcing rule applies to. Links to the material being sourced.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Sourcing rules are defined per SKU to manage make‑or‑buy, allocation percentages and supplier contracts.',
    `supply_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this sourcing rule is applicable. Links to the plant master.',
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
    `payment_terms` STRING COMMENT 'Code representing the negotiated payment terms with the supplier, defining due dates, discounts, and payment schedules.',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in calendar days from order placement to goods receipt for this material-plant-supplier combination. Used by MRP for backward scheduling.',
    `planner_approved_flag` BOOLEAN COMMENT 'Indicates whether the sourcing rule has been reviewed and approved by the material planner or supply chain manager for use in MRP runs.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Boolean indicator marking this supplier as the preferred source for the material-plant combination. Used to prioritize sourcing decisions when multiple suppliers are available.',
    `price_unit` STRING COMMENT 'Quantity unit to which the standard price applies. For example, if price_unit is 100, the standard_price represents the cost per 100 units.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` (
    `supply_plant_id` BIGINT COMMENT 'Primary key for plant',
    `delivery_id` BIGINT COMMENT 'Primary key for plant',
    `capacity` DECIMAL(18,2) COMMENT 'Maximum production capacity of the plant expressed in the unit defined by capacity_unit.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the production capacity.',
    `carbon_emission_factor` DECIMAL(18,2) COMMENT 'CO₂ emission factor (kg CO₂ per unit of production) for the plant.',
    `city` STRING COMMENT 'City where the plant is located.',
    `closing_date` DATE COMMENT 'Date the plant ceased operations, if applicable.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ISO 9001, ISO 14001) held by the plant.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the data lake.',
    `energy_source` STRING COMMENT 'Main source of energy used by the plant.',
    `is_primary_plant` BOOLEAN COMMENT 'Indicates whether this plant is the primary manufacturing site for the company.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant.',
    `location_address` STRING COMMENT 'Street address of the plant facility.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant.',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., 02:00‑04:00) when maintenance activities are performed.',
    `manager_email` STRING COMMENT 'Email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the primary manager responsible for the plant.',
    `manager_phone` STRING COMMENT 'Contact phone number for the plant manager.',
    `supply_plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `number_of_shifts` STRING COMMENT 'Number of production shifts operated per day.',
    `opening_date` DATE COMMENT 'Date the plant began operations.',
    `operational_start_time` TIMESTAMP COMMENT 'Timestamp when the plant began its current operational run.',
    `owner` STRING COMMENT 'Legal entity that owns the plant.',
    `plant_type` STRING COMMENT 'Category describing the primary function of the plant.',
    `power_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical power capacity of the plant in megawatts.',
    `region` STRING COMMENT 'Broad geographic region where the plant resides.',
    `safety_rating` STRING COMMENT 'Safety performance rating of the plant.',
    `shift_hours` DECIMAL(18,2) COMMENT 'Length of each production shift in hours.',
    `site_area_sqm` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square meters.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the plant.',
    `supply_plant_status` STRING COMMENT 'Current lifecycle state of the plant.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_management_type` STRING COMMENT 'Primary waste management approach employed at the plant.',
    `water_usage_cubic_m` DECIMAL(18,2) COMMENT 'Total water consumption of the plant per reporting period.',
    CONSTRAINT pk_supply_plant PRIMARY KEY(`supply_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`plan` (
    `plan_id` BIGINT COMMENT 'Primary key for plan',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Customer-dedicated supply planning (VMI, strategic account allocation) requires linking supply plans to specific customer accounts. S&OP teams create customer-committed supply plans for strategic acco',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supply plans in S&OP/IBP are created at both SKU and product family level for aggregate supply balancing. Family-level supply planning drives capacity allocation and procurement strategy decisions. A ',
    `material_master_id` BIGINT COMMENT 'Specific material or SKU for which this supply plan is created. May be null for aggregate material group plans.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Supply plans are the approved output of MRP planning runs. Linking supply_plan to the mrp_run that generated it provides end-to-end traceability from planning execution to approved supply response. su',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Supply plans reference the SKU master to allocate production capacity and material supply per product.',
    `supply_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_plant. Business justification: Supply plans are created per plant. supply_plan.plant_code is a denormalized string that should be replaced by a FK to supply_plant. Normalizing this enables plant-level supply plan management and enf',
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
    `planning_strategy` STRING COMMENT 'Supply planning strategy: MTS (Make to Stock), MTO (Make to Order), ATO (Assemble to Order), or ETO (Engineer to Order).. Valid values are `MTS|MTO|ATO|ETO`',
    `planning_time_fence_days` STRING COMMENT 'Number of days from today within which the planning system will not automatically change planned orders, protecting near-term execution stability.',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` (
    `order_pegging_id` BIGINT COMMENT 'Unique identifier for this pegging assignment record. Primary key.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to the material requirement that is being satisfied by the planned order',
    `mrp_run_id` BIGINT COMMENT 'Reference to the specific MRP execution run that created this pegging assignment. Enables tracking of pegging changes across planning cycles.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to the planned order that provides supply to satisfy the material requirement',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pegging record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pegging record was last updated, typically by a subsequent MRP run or planner adjustment.',
    `pegged_quantity` DECIMAL(18,2) COMMENT 'The quantity of material from the planned order that is allocated to satisfy this specific material requirement. A planned order can be split across multiple requirements, and a requirement can be satisfied by multiple planned orders.',
    `pegging_date` TIMESTAMP COMMENT 'Date and time when this pegging relationship was established by the MRP run. Used to track pegging history across multiple planning cycles.',
    `pegging_level` STRING COMMENT 'The BOM explosion level at which this pegging occurs. Level 0 is the finished good, level 1 is direct components, level 2 is sub-components, etc. Used for multi-level pegging analysis.',
    `pegging_status` STRING COMMENT 'Lifecycle status of this pegging assignment: active (current valid pegging), superseded (replaced by subsequent MRP run), converted (planned order converted to firm order), cancelled (requirement or order deleted).',
    `pegging_type` STRING COMMENT 'Classification of the pegging relationship: direct (single-level BOM explosion), indirect (multi-level dependent requirement), multi_level (cascaded through multiple BOM levels), safety_stock (replenishment for safety stock), forecast (driven by forecast consumption).',
    CONSTRAINT pk_order_pegging PRIMARY KEY(`order_pegging_id`)
) COMMENT 'This association product represents the pegging relationship between planned orders and material requirements in MRP/APS planning systems. It captures which planned orders satisfy which material requirements, tracking the allocation of supply to demand across planning runs. Each record links one planned order to one material requirement with pegging-specific attributes that exist only in the context of this supply-demand allocation relationship. Pegging is a core MRP II concept implemented in SAP PP and Microsoft Dynamics 365 SCM.. Existence Justification: MRP pegging is a well-established operational business process in manufacturing planning systems (SAP PP, Dynamics 365 SCM) that explicitly tracks which planned orders (supply) satisfy which material requirements (demand). One planned order can be split to satisfy multiple material requirements across different BOM levels, and one material requirement can be satisfied by multiple planned orders when partial allocations occur. Planners actively query and manage pegging relationships to understand supply-demand linkages, resolve shortages, and trace requirement sources.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ADD CONSTRAINT `fk_supply_mrp_run_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_sourcing_rule_id` FOREIGN KEY (`sourcing_rule_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`sourcing_rule`(`sourcing_rule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ADD CONSTRAINT `fk_supply_planned_order_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ADD CONSTRAINT `fk_supply_demand_forecast_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`plan`(`plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ADD CONSTRAINT `fk_supply_capacity_plan_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ADD CONSTRAINT `fk_supply_material_requirement_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ADD CONSTRAINT `fk_supply_sourcing_rule_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_supply_plant_id` FOREIGN KEY (`supply_plant_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`supply_plant`(`supply_plant_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ADD CONSTRAINT `fk_supply_order_pegging_material_requirement_id` FOREIGN KEY (`material_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`material_requirement`(`material_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ADD CONSTRAINT `fk_supply_order_pegging_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ADD CONSTRAINT `fk_supply_order_pegging_planned_order_id` FOREIGN KEY (`planned_order_id`) REFERENCES `vibe_manufacturing_v1`.`supply`.`planned_order`(`planned_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_manufacturing_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` SET TAGS ('dbx_subdomain' = 'planning_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`mrp_run` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` SET TAGS ('dbx_subdomain' = 'planning_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'BOM (Bill of Materials) ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`planned_order` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'demand_capacity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Forecast Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `seasonality_index` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Index');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `trend_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Trend Coefficient');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`demand_forecast` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'baseline|sales_adjusted|consensus|approved|working');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'demand_capacity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`capacity_plan` ALTER COLUMN `leveling_strategy` SET TAGS ('dbx_value_regex' = 'overtime|shift_add|subcontract|reschedule|none');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` SET TAGS ('dbx_subdomain' = 'planning_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `projected_available_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Available Balance');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_priority` SET TAGS ('dbx_business_glossary_term' = 'Requirement Priority');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_source_item` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source Item');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'open|partially_covered|fully_covered|cancelled|expired');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `rounding_value` SET TAGS ('dbx_business_glossary_term' = 'Rounding Value');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `scheduled_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`material_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` SET TAGS ('dbx_subdomain' = 'sourcing_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`sourcing_rule` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` SET TAGS ('dbx_subdomain' = 'sourcing_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `number_of_shifts` SET TAGS ('dbx_business_glossary_term' = 'Number Of Shifts');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `operational_start_time` SET TAGS ('dbx_business_glossary_term' = 'Operational Start Time');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Plant Owner');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `power_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Capacity Mw');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `shift_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Hours');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `site_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Site Area Sqm');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Plant Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `supply_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `waste_management_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Management Type');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`supply_plant` ALTER COLUMN `water_usage_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Cubic M');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` SET TAGS ('dbx_subdomain' = 'sourcing_configuration');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `supply_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'MTS|MTO|ATO|ETO');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`plan` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
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
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` SET TAGS ('dbx_subdomain' = 'planning_execution');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` SET TAGS ('dbx_association_edges' = 'supply.planned_order,supply.material_requirement');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `order_pegging_id` SET TAGS ('dbx_business_glossary_term' = 'Order Pegging Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Order Pegging - Material Requirement Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Pegging - Planned Order Id');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `pegged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pegged Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `pegging_date` SET TAGS ('dbx_business_glossary_term' = 'Pegging Assignment Date');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `pegging_level` SET TAGS ('dbx_business_glossary_term' = 'BOM Pegging Level');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `pegging_status` SET TAGS ('dbx_business_glossary_term' = 'Pegging Status');
ALTER TABLE `vibe_manufacturing_v1`.`supply`.`order_pegging` ALTER COLUMN `pegging_type` SET TAGS ('dbx_business_glossary_term' = 'Pegging Type');
