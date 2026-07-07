-- Schema for Domain: supply | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`supply` COMMENT 'Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` (
    `demand_plan_id` BIGINT COMMENT 'Unique identifier for the demand plan record. Primary key representing a specific version-point in the S&OP/IBP cycle for a SKU/location/channel/planning period combination.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: demand_plan carries marketing_event_uplift_quantity and promotional_overlay_quantity — both campaign-driven. Linking to the specific campaign enables IBP/S&OP traceability: which campaign drove wh',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: CPG demand plans are created at category level for category management, trade planning, and S&OP category reviews. Category-level demand plans (e.g., Hair Care total demand) are standard inputs to C',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: CPG S&OP demand plans are created at hierarchy levels (brand, division, category) in IBP/APO systems, not only at SKU level. Hierarchy-level demand planning drives top-down disaggregation. A CPG suppl',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Integrated Demand Planning uses brand forecasts; brand_id links demand plan to specific brand for Brand Demand Forecast report.',
    `network_node_id` BIGINT COMMENT 'The origin network node id of the demand plan record',
    `primary_demand_supply_network_node_id` BIGINT COMMENT 'Reference to the distribution location, warehouse, or market geography for which demand is planned.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In consumer goods S&OP, demand plans are structured by profit center for financial P&L alignment and revenue planning. The financial demand review step of S&OP requires demand volumes mapped to profit',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which demand is being planned.',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the S&OP/IBP planning cycle during which this demand plan version was created.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: REQUIRED: Account‑level demand forecast used in S&OP planning; planners need trade_account context for each demand_plan.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the demand plan record',
    `approval_status` STRING COMMENT 'Current approval state of the demand plan version within the S&OP governance workflow.. Valid values are `draft|submitted|under_review|approved|rejected|locked`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was formally approved and locked for supply planning execution.',
    `demand_plan_code` STRING COMMENT 'The demand plan code of the demand plan record',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand adjustment quantity applied by field sales teams based on customer intelligence, market conditions, and sales pipeline visibility.',
    `confidence_level` STRING COMMENT 'Planner-assigned confidence rating in the demand forecast based on data quality, market visibility, and forecast stability.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'Agreed demand forecast quantity representing the single demand signal passed to supply planning after S&OP consensus process. This is the authoritative demand plan.',
    `created_by_persona` STRING COMMENT 'Role or persona of the user who created this demand plan version, used for accountability and collaboration tracking.. Valid values are `demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for any monetary values associated with this demand plan (e.g., revenue forecasts).. Valid values are `^[A-Z]{3}$`',
    `demand_pattern_type` STRING COMMENT 'Classification of historical demand behavior pattern used to select appropriate statistical forecasting algorithm.. Valid values are `stable|seasonal|trending|intermittent|lumpy|erratic`',
    `demand_plan_status` STRING COMMENT 'The demand plan status of the demand plan record',
    `demand_sensing_signal` STRING COMMENT 'Short-term demand trend indicator derived from real-time POS data, shipment data, and market signals to enable rapid forecast adjustments.. Valid values are `increasing|stable|decreasing|volatile`',
    `demand_type` STRING COMMENT 'The demand type of the demand plan record',
    `demand_plan_description` STRING COMMENT 'The demand plan description of the demand plan record',
    `effective_from` DATE COMMENT 'The effective from of the demand plan record',
    `effective_from_date` DATE COMMENT 'Date from which this demand plan version becomes active and is used for supply planning and ATP calculations.',
    `effective_to_date` DATE COMMENT 'Date until which this demand plan version remains active. Null indicates the version is currently active with no planned expiration.',
    `effective_until` DATE COMMENT 'The effective until of the demand plan record',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical forecast accuracy metric for this SKU/location/channel combination, used for forecast quality benchmarking and continuous improvement.',
    `forecast_bias_percentage` DECIMAL(18,2) COMMENT 'Systematic tendency to over-forecast or under-forecast, calculated as average percentage deviation from actual demand.',
    `is_consensus_version` BOOLEAN COMMENT 'Flag indicating whether this version represents the official consensus demand plan approved through the S&OP process and used for supply planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was last updated or adjusted.',
    `lifecycle_stage` STRING COMMENT 'Product lifecycle stage classification used to apply appropriate forecasting models and demand shaping strategies.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand quantity expected from planned marketing campaigns, promotions, and brand activation events.',
    `demand_plan_name` STRING COMMENT 'The demand plan name of the demand plan record',
    `notes` STRING COMMENT 'The notes of the demand plan record',
    `npd_launch_volume_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity for new product launches or product line extensions during the planning period.',
    `plan_horizon_end` DATE COMMENT 'The plan horizon end of the demand plan record',
    `plan_horizon_start` DATE COMMENT 'The plan horizon start of the demand plan record',
    `plan_version` STRING COMMENT 'The plan version of the demand plan record',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The planned quantity of the demand plan record',
    `planner_notes` STRING COMMENT 'Free-text comments and annotations from demand planners explaining assumptions, adjustments, risks, or special considerations for this forecast.',
    `planning_bucket` STRING COMMENT 'Time granularity of the demand plan (daily, weekly, monthly, quarterly) used for aggregation and reporting.. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period (week or month) for which demand is forecasted.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period (week or month) for which demand is forecasted.',
    `promotional_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand uplift quantity attributed to trade promotions, price discounts, and retail execution activities.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the demand plan record',
    `risk_category` STRING COMMENT 'Classification of the primary risk factor affecting demand plan reliability and supply fulfillment capability.. Valid values are `supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none`',
    `risk_flag` BOOLEAN COMMENT 'Indicator that this demand plan carries elevated supply risk due to capacity constraints, material shortages, or demand volatility.',
    `source_system_code` STRING COMMENT 'The source system code of the demand plan record',
    `source_system_record_code` STRING COMMENT 'Original unique identifier of this demand plan record in the source system, used for data lineage and reconciliation.',
    `statistical_baseline_quantity` DECIMAL(18,2) COMMENT 'Unconstrained demand forecast quantity generated by statistical forecasting algorithms before any commercial overlays or adjustments.',
    `unit_of_measure` STRING COMMENT 'Unit in which demand quantities are expressed (each, case, pallet, kilogram, liter, etc.). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the demand plan record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the demand plan record',
    `variance_to_baseline_quantity` DECIMAL(18,2) COMMENT 'Difference between consensus quantity and statistical baseline quantity, indicating the net impact of all commercial adjustments and overlays.',
    `version_name` STRING COMMENT 'Human-readable name of the demand plan version (e.g., Statistical Baseline Q1 2024, Consensus Final March 2024).',
    `version_sequence_number` STRING COMMENT 'Sequential version number within the planning cycle, used to track iteration history and version progression.',
    `version_type` STRING COMMENT 'Classification of the demand plan version indicating its stage in the S&OP process. Statistical baseline represents unconstrained forecast; consensus represents agreed demand signal passed to supply planning.. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay`',
    CONSTRAINT pk_demand_plan PRIMARY KEY(`demand_plan_id`)
) COMMENT 'Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` (
    `forecast_version_id` BIGINT COMMENT 'Reference to the parent or baseline forecast version from which this version was derived (e.g., statistical baseline that was then adjusted). Nullable for original baseline versions.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In consumer goods S&OP, forecast versions capture promotional and campaign-driven demand uplifts. Planners must trace which marketing campaign drove a specific forecast versions uplift quantity — ess',
    `demand_plan_id` BIGINT COMMENT 'The demand plan id of the forecast version record',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the Sales and Operations Planning (S&OP) or Integrated Business Planning (IBP) cycle to which this forecast version belongs.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: In CPG IBP/APO, forecast versions are generated at multiple hierarchy levels (brand, category, division) for top-down planning. A forecast_version at hierarchy level is a standard S&OP artifact; CPG d',
    `primary_forecast_sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: forecast_version needs to be linked to its planning cycle; added new FK sop_cycle_id referencing sop_cycle.sop_cycle_id. Existing planning_cycle_id column renamed to sop_cycle_id, so removed planning_',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Forecast versions in consumer goods S&OP are reviewed and approved by profit center owners during the financial review step. Revenue forecasting and margin gap analysis require forecast versions to be',
    `sku_id` BIGINT COMMENT 'The sku id of the forecast version record',
    `aggregation_level` STRING COMMENT 'The level of aggregation at which this forecast version is maintained: Stock Keeping Unit (SKU) level, product family, brand, category, sales channel, customer account, geographic region, or global total. [ENUM-REF-CANDIDATE: sku|product_family|brand|category|channel|customer|region|global — 8 candidates stripped; promote to reference product]',
    `algorithm_used` STRING COMMENT 'The algorithm used of the forecast version record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the forecast version record',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approver during the approval process, documenting any conditions, concerns, or guidance related to this forecast version. Nullable if not yet approved or no notes provided.',
    `approval_status` STRING COMMENT 'The approval status of the forecast version record',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was approved. Nullable if not yet approved.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was archived and moved out of active planning use. Nullable if not yet archived.',
    `bias_percentage` DECIMAL(18,2) COMMENT 'Forecast bias percentage indicating systematic over-forecasting (positive bias) or under-forecasting (negative bias). A value near zero indicates an unbiased forecast. Nullable if not yet calculated.',
    `forecast_version_code` STRING COMMENT 'The forecast version code of the forecast version record',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary values associated with this forecast version (e.g., revenue forecasts). Nullable if forecast is purely volume-based.. Valid values are `^[A-Z]{3}$`',
    `demand_sensing_applied` BOOLEAN COMMENT 'Boolean flag indicating whether demand sensing algorithms (short-term forecast adjustments based on real-time Point of Sale (POS) data, shipment data, or other leading indicators) were applied to this forecast version.',
    `forecast_version_description` STRING COMMENT 'The forecast version description of the forecast version record',
    `effective_from` DATE COMMENT 'The effective from of the forecast version record',
    `effective_from_date` DATE COMMENT 'The date from which this forecast version becomes effective and is used for operational planning, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `effective_to_date` DATE COMMENT 'The date until which this forecast version remains effective. Nullable for open-ended versions that remain active until superseded.',
    `effective_until` DATE COMMENT 'The effective until of the forecast version record',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Calculated forecast accuracy percentage for this version, measured as the percentage of forecasted demand that matched actual demand. Used for benchmarking version performance and continuous improvement. Nullable if accuracy has not yet been calculated.',
    `forecast_horizon_days` STRING COMMENT 'The forecast horizon days of the forecast version record',
    `forecast_method` STRING COMMENT 'The forecast method of the forecast version record',
    `forecast_quantity` DECIMAL(18,2) COMMENT 'The forecast quantity of the forecast version record',
    `forecast_source_system` STRING COMMENT 'Name or identifier of the source system or application that generated or contributed to this forecast version (e.g., SAP IBP, TradeEdge, Excel Upload, Salesforce CG Cloud).',
    `forecast_version_status` STRING COMMENT 'The forecast version status of the forecast version record',
    `is_active_version` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast version is currently active and being used for planning and execution. Only one version per planning cycle should typically be active at a time.',
    `is_baseline` BOOLEAN COMMENT 'The is baseline of the forecast version record',
    `is_consensus_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version represents the consensus forecast agreed upon by cross-functional stakeholders (sales, marketing, supply chain, finance) during the S&OP process.',
    `is_final` BOOLEAN COMMENT 'The is final of the forecast version record',
    `is_final_approved_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version is the final approved forecast that will be used for operational execution, Material Requirements Planning (MRP), and Distribution Requirements Planning (DRP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The last modified timestamp of the forecast version record',
    `mean_absolute_percentage_error` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error (MAPE) metric for this forecast version, measuring the average magnitude of forecast errors as a percentage. Lower values indicate better forecast accuracy. Nullable if not yet calculated.',
    `model_parameters` STRING COMMENT 'The model parameters of the forecast version record',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was last modified.',
    `forecast_version_name` STRING COMMENT 'The forecast version name of the forecast version record',
    `new_product_introduction_included` BOOLEAN COMMENT 'Boolean flag indicating whether New Product Development (NPD) or New Product Introduction (NPI) launches were incorporated into this forecast version.',
    `notes` STRING COMMENT 'The notes of the forecast version record',
    `planning_bucket` STRING COMMENT 'The planning bucket of the forecast version record',
    `planning_horizon_end_date` DATE COMMENT 'The last date of the planning period covered by this forecast version (e.g., end of the fiscal quarter or rolling 18-month horizon).',
    `planning_horizon_start_date` DATE COMMENT 'The first date of the planning period covered by this forecast version (e.g., start of the fiscal quarter or month).',
    `promotional_events_included` BOOLEAN COMMENT 'Boolean flag indicating whether trade promotions, marketing campaigns, and promotional events were factored into this forecast version.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the forecast version record',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided when this forecast version was rejected during the approval process. Nullable if version was not rejected.',
    `snapshot_date` DATE COMMENT 'The snapshot date of the forecast version record',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The snapshot timestamp of the forecast version record',
    `source_system_code` STRING COMMENT 'The source system code of the forecast version record',
    `statistical_model_applied` STRING COMMENT 'Name or identifier of the statistical forecasting model or algorithm applied to generate or adjust this forecast version (e.g., Exponential Smoothing, ARIMA, Machine Learning Ensemble, Holt-Winters). Nullable if no statistical model was used.',
    `time_bucket` STRING COMMENT 'The time granularity or bucket size used for this forecast version: daily, weekly, monthly, quarterly, or annual periods.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which forecast quantities are expressed (e.g., EA for each, CS for case, KG for kilogram, L for liter). Aligns with GS1 standards.',
    `uom` STRING COMMENT 'The uom of the forecast version record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the forecast version record',
    `version_code` STRING COMMENT 'Short alphanumeric code or identifier for the forecast version used in system integrations and reporting (e.g., STAT_BASE, CONS_V1, FINAL_APR).',
    `version_description` STRING COMMENT 'Detailed textual description or notes about this forecast version, including assumptions, adjustments made, special considerations, or rationale for key changes.',
    `version_label` STRING COMMENT 'The version label of the forecast version record',
    `version_name` STRING COMMENT 'Human-readable name assigned to this forecast version (e.g., Statistical Baseline Q1 2024, Consensus Forecast March, Final Approved Version).',
    `version_number` STRING COMMENT 'The version number of the forecast version record',
    `version_sequence_number` STRING COMMENT 'Sequential number indicating the iteration or revision order of this forecast version within the planning cycle (e.g., 1 for first draft, 2 for first revision, 3 for consensus).',
    `version_status` STRING COMMENT 'Current lifecycle status of the forecast version: draft (under construction), in review (submitted for approval), approved (validated and accepted), rejected (not accepted), archived (historical record), or active (currently in use for planning).. Valid values are `draft|in_review|approved|rejected|archived|active`',
    `version_type` STRING COMMENT 'Classification of the forecast version indicating its role in the planning process: statistical baseline (system-generated), field sales overlay (sales team input), marketing adjusted (marketing promotions incorporated), consensus (collaborative agreement), final approved (executive sign-off), or simulation (what-if scenario).. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation`',
    CONSTRAINT pk_forecast_version PRIMARY KEY(`forecast_version_id`)
) COMMENT 'Tracks each named version or snapshot of the demand forecast within the IBP/S&OP cycle (e.g., statistical baseline, field sales overlay, marketing-adjusted, consensus, final approved). Captures version name, version type, planning cycle reference, created-by persona, approval status, and effective date range. Enables forecast accuracy benchmarking across versions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` (
    `inventory_policy_id` BIGINT COMMENT 'Unique identifier for the inventory policy record. Primary key for this entity.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: CPG inventory policies are frequently set at category level (e.g., all Skin Care SKUs maintain 28-day safety stock). Category-level inventory policy drives SKU-level parameter inheritance. Supply plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory policies are owned by specific cost centers; linking enables policy‑related budgeting and compliance audits.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: CPG procurement teams set inventory policies for critical raw materials and packaging components (min/max stock, reorder points for key ingredients). Material-level inventory policies are a standard S',
    `network_node_id` BIGINT COMMENT 'The origin network node id of the inventory policy record',
    `primary_inventory_supply_network_node_id` BIGINT COMMENT 'Reference to the distribution facility, warehouse, or storage location node in the supply network where this policy applies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inventory policies carry service level and working capital targets owned by profit centers. Balance sheet management of safety stock investment and fill-rate commitments are tracked by profit center i',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this inventory policy is defined.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: Inventory policies are reviewed, updated, and approved within S&OP/IBP planning cycles. The last_review_date, next_review_date, and review_cycle_days on inventory_policy indicate a cycle-driven review',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Retailer-mandated inventory policies are a core consumer goods reality — major retailers (e.g., Walmart, Tesco) contractually mandate service levels, OTIF targets, and safety stock minimums. inventory',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the inventory policy record',
    `approval_date` DATE COMMENT 'Date when this inventory policy was formally approved and authorized for use in supply planning and execution.',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the policy has been reviewed and approved by authorized supply planning personnel.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by_name` STRING COMMENT 'Name of the supply planning manager or director who approved this inventory policy for operational use.',
    `inventory_policy_code` STRING COMMENT 'The inventory policy code of the inventory policy record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the inventory policy record',
    `customer_otif_commitment_percent` DECIMAL(18,2) COMMENT 'Specific OTIF performance level committed to a customer or channel, which may differ from internal targets and may be contractually binding.',
    `cycle_stock_target_units` DECIMAL(18,2) COMMENT 'Target cycle stock quantity representing the average inventory held to meet expected demand between replenishments, excluding safety stock.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability (coefficient of variation or standard deviation) used in safety stock calculations.',
    `inventory_policy_description` STRING COMMENT 'The inventory policy description of the inventory policy record',
    `effective_end_date` DATE COMMENT 'Date on which this inventory policy expires or is superseded. Null indicates an open-ended policy.',
    `effective_from` DATE COMMENT 'The effective from of the inventory policy record',
    `effective_start_date` DATE COMMENT 'Date from which this inventory policy becomes active and applicable for planning and execution.',
    `effective_until` DATE COMMENT 'The effective until of the inventory policy record',
    `fill_rate_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of customer demand that should be fulfilled from available inventory without backorders or stockouts.',
    `inventory_policy_status` STRING COMMENT 'The inventory policy status of the inventory policy record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this inventory policy was last reviewed and validated by the supply planning team.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Standard deviation or variance of replenishment lead time in days, used to account for supply uncertainty in safety stock calculations.',
    `lot_size` DECIMAL(18,2) COMMENT 'The lot size of the inventory policy record',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The max stock level of the inventory policy record',
    `maximum_stock_level_units` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at this location for this SKU, used to prevent overstocking and manage warehouse capacity constraints.',
    `measurement_window_days` STRING COMMENT 'Time period in days over which service level performance is measured and evaluated against targets (e.g., rolling 30 days, 90 days, quarterly).',
    `min_stock_level` DECIMAL(18,2) COMMENT 'The min stock level of the inventory policy record',
    `minimum_stock_level_units` DECIMAL(18,2) COMMENT 'Minimum inventory level that should be maintained at this location for this SKU, typically aligned with safety stock or regulatory requirements.',
    `inventory_policy_name` STRING COMMENT 'The inventory policy name of the inventory policy record',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of this inventory policy, ensuring policies remain aligned with business conditions.',
    `notes` STRING COMMENT 'The notes of the inventory policy record',
    `on_time_delivery_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of orders that should be delivered by the customer-requested or committed delivery date.',
    `order_up_to_level` DECIMAL(18,2) COMMENT 'The order up to level of the inventory policy record',
    `otif_composite_target_percent` DECIMAL(18,2) COMMENT 'Composite OTIF (On Time In Full) target percentage representing orders delivered both on time and in full quantity, a critical customer service metric.',
    `penalty_clause_indicator` BOOLEAN COMMENT 'Indicates whether failure to meet the defined service level targets will result in financial penalties, chargebacks, or other contractual consequences.',
    `policy_code` STRING COMMENT 'Business identifier code for the inventory policy, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_notes` STRING COMMENT 'Free-text notes capturing special considerations, exceptions, seasonal adjustments, or business context relevant to this inventory policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the inventory policy indicating its approval and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|archived — 7 candidates stripped; promote to reference product]',
    `policy_type` STRING COMMENT 'The policy type of the inventory policy record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the inventory policy record',
    `reorder_point` DECIMAL(18,2) COMMENT 'The reorder point of the inventory policy record',
    `reorder_point_units` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered, calculated as lead time demand plus safety stock.',
    `replenishment_method` STRING COMMENT 'The inventory replenishment strategy applied: MRP (Material Requirements Planning), DRP (Distribution Requirements Planning), VMI (Vendor Managed Inventory), JIT (Just In Time), Kanban, or Fixed Order Quantity.. Valid values are `MRP|DRP|VMI|JIT|kanban|fixed_order_quantity`',
    `retailer_mandated_target_flag` BOOLEAN COMMENT 'Indicates whether the service level targets are mandated by a retail customer as part of their supplier requirements or vendor compliance program.',
    `review_cycle_days` STRING COMMENT 'Frequency in days at which inventory levels are reviewed and replenishment decisions are made for this SKU-location combination.',
    `review_period_days` STRING COMMENT 'The review period days of the inventory policy record',
    `safety_stock_calculated_units` DECIMAL(18,2) COMMENT 'System-calculated safety stock quantity based on demand variability, lead time variability, and service level inputs before manual approval or adjustment.',
    `safety_stock_calculation_method` STRING COMMENT 'The methodology used to calculate safety stock: fixed value, forecast error-based, demand variability, lead time variability, combined variability, or service level-driven calculation.. Valid values are `fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven`',
    `safety_stock_days_of_supply` DECIMAL(18,2) COMMENT 'Safety stock expressed as the number of days of average demand coverage, providing a time-based view of inventory buffer.',
    `safety_stock_target_units` DECIMAL(18,2) COMMENT 'Target safety stock quantity in base units of measure, representing the buffer inventory to protect against demand and supply variability.',
    `safety_stock_units` DECIMAL(18,2) COMMENT 'The safety stock units of the inventory policy record',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'The service level target pct of the inventory policy record',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage (e.g., 95%, 98%, 99.5%) representing the desired probability of not stocking out during the replenishment lead time.',
    `source_system_code` STRING COMMENT 'The source system code of the inventory policy record',
    `unit_of_measure` STRING COMMENT 'The unit of measure of the inventory policy record',
    `uom` STRING COMMENT 'The uom of the inventory policy record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the inventory policy record',
    CONSTRAINT pk_inventory_policy PRIMARY KEY(`inventory_policy_id`)
) COMMENT 'Master entity defining inventory policy parameters, safety stock calculations, service level commitments, and OTIF targets for each SKU/location node in the supply network. Captures safety stock target and calculated quantities (days of supply, units, calculation method, demand variability, lead time variability, service level input, calculated vs approved SS units, effective date, review status), reorder point, min/max levels, cycle stock target, replenishment method (MRP/DRP/VMI), review cycle, service level targets (fill rate %, on-time delivery %, OTIF composite %), customer/channel-level OTIF commitments, retailer-mandated target flags, penalty clause indicators, and measurement windows. Owned by supply planning; consumed by distribution and manufacturing execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` (
    `safety_stock_id` BIGINT COMMENT 'Unique identifier for the safety stock calculation record. Primary key for the safety stock entity.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Safety stock calculations are driven by demand plan data — specifically demand variability, forecast accuracy, and planned quantities. The demand_variability_coefficient and forecast_accuracy_percent ',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Safety stock calculation process: inspection lead time from the applicable inspection plan inflates effective replenishment lead time used in safety stock formulas. Consumer goods planners explicitly ',
    `inventory_policy_id` BIGINT COMMENT 'The inventory policy id of the safety stock record',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: CPG supply chains maintain safety stock for raw materials and packaging components, not only finished SKUs. Material-level safety stock (e.g., fragrance ingredient, bottle) is a distinct planning conc',
    `network_node_id` BIGINT COMMENT 'The origin network node id of the safety stock record',
    `primary_safety_supply_network_node_id` BIGINT COMMENT 'Reference to the storage location, distribution center, or facility where the safety stock applies. Links to distribution facility master data.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU for which safety stock is calculated. Links to the product master data.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: Safety stock calculations are performed and approved within S&OP/IBP planning cycles. The planning_period_start_date and planning_period_end_date on safety_stock align with S&OP cycle horizons. Linkin',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Safety stock financial valuation for working capital reporting uses standard cost per unit. The safety_stock table already carries holding_cost_per_unit and stockout_cost_per_unit, which are derived f',
    `abc_classification` STRING COMMENT 'The ABC classification of the SKU based on revenue contribution or volume. A items are high-value requiring tight control; B items are moderate; C items are low-value. Influences service level targets and safety stock investment decisions.. Valid values are `A|B|C`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the safety stock record',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was approved by the planner. Marks the transition from calculated to approved state in the workflow.',
    `approved_safety_stock_units` DECIMAL(18,2) COMMENT 'The final approved safety stock quantity in base units of measure after planner review and adjustment. This is the target value used for inventory policy execution and Available to Promise (ATP) calculations.',
    `average_daily_demand_units` DECIMAL(18,2) COMMENT 'The mean daily demand quantity in base units of measure. Used as input to safety stock calculations and represents expected consumption rate.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'The mean replenishment lead time in days from order placement to receipt. Used in safety stock calculations to determine the exposure period for demand and supply variability.',
    `calculated_safety_stock_units` DECIMAL(18,2) COMMENT 'The system-calculated safety stock quantity in base units of measure. This is the raw output from the calculation engine before any manual adjustments or approvals.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Statistical methods use demand and lead time variability; days-of-supply uses fixed coverage targets; manual override represents planner judgment; service level and lead time methods focus on specific risk factors; hybrid combines multiple approaches.. Valid values are `statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was executed by the planning system. Provides audit trail for calculation runs and version control.',
    `safety_stock_code` STRING COMMENT 'The safety stock code of the safety stock record',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'The currency code of the safety stock record',
    `days` DECIMAL(18,2) COMMENT 'The days of the safety stock record',
    `days_of_supply_target` DECIMAL(18,2) COMMENT 'The target safety stock coverage expressed in days of average demand. Used when calculation method is days-of-supply based. Represents the buffer duration to protect against stockouts.',
    `demand_classification` STRING COMMENT 'The demand pattern category for this SKU-location. Steady indicates consistent demand; seasonal shows periodic peaks; erratic has high variability; lumpy has infrequent large orders; intermittent has sporadic demand; obsolete indicates phase-out. Influences calculation method selection.. Valid values are `steady|seasonal|erratic|lumpy|intermittent|obsolete`',
    `demand_variability` DECIMAL(18,2) COMMENT 'The demand variability of the safety stock record',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility expressed as coefficient of variation or standard deviation. Used in statistical safety stock calculations to quantify demand uncertainty.',
    `safety_stock_description` STRING COMMENT 'The safety stock description of the safety stock record',
    `effective_date` DATE COMMENT 'The date when this safety stock target becomes active and is used for inventory policy execution, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `effective_from` DATE COMMENT 'The effective from of the safety stock record',
    `effective_until` DATE COMMENT 'The effective until of the safety stock record',
    `expiration_date` DATE COMMENT 'The date when this safety stock target expires and is replaced by a new calculation. Used to manage the lifecycle of safety stock policies and trigger recalculation cycles.',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'The historical forecast accuracy for this SKU-location combination expressed as a percentage. Used to adjust safety stock calculations based on forecasting reliability. Lower accuracy typically requires higher safety stock.',
    `holding_cost_per_unit` DECIMAL(18,2) COMMENT 'The annual cost to hold one unit of inventory including warehousing, insurance, obsolescence, and capital cost. Used in inventory optimization to balance service level against carrying cost. Expressed in local currency.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this safety stock record is currently active and being used for inventory policy execution. True means active; False means superseded or inactive.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock record was last reviewed by a planner, regardless of whether changes were made. Used to track planner engagement and ensure regular review cycles.',
    `lead_time_days` DECIMAL(18,2) COMMENT 'The lead time days of the safety stock record',
    `lead_time_variability` DECIMAL(18,2) COMMENT 'The lead time variability of the safety stock record',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Measure of supply lead time uncertainty expressed in days. Represents the standard deviation or range of lead time fluctuation used in safety stock calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity constraint from the supplier or manufacturing process. Safety stock calculations must consider MOQ to ensure replenishment orders are feasible.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was last modified. Updated whenever any field changes. Supports change tracking and audit requirements.',
    `safety_stock_name` STRING COMMENT 'The safety stock name of the safety stock record',
    `next_review_date` DATE COMMENT 'The scheduled date for the next safety stock review cycle. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) processes to ensure regular policy updates.',
    `notes` STRING COMMENT 'The notes of the safety stock record',
    `order_multiple` DECIMAL(18,2) COMMENT 'The order quantity increment or lot size multiple required by supplier or production constraints. Safety stock and reorder quantities must align with this multiple.',
    `override_notes` STRING COMMENT 'Free-text explanation provided by the planner when manually overriding the calculated safety stock. Documents the business context and rationale for the adjustment.',
    `override_reason_code` STRING COMMENT 'The business reason code when approved safety stock differs from calculated safety stock. Captures planner judgment factors such as promotional events, seasonal peaks, supply chain risks, new product introductions, product phase-outs, or quality concerns.. Valid values are `promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue`',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period for which this safety stock calculation is effective. Defines the validity window for the safety stock target.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period for which this safety stock calculation is effective. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) cycles.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the safety stock record',
    `review_status` STRING COMMENT 'The approval workflow status of the safety stock calculation. Pending review indicates awaiting planner action; approved means active for execution; rejected requires recalculation; under revision is being adjusted; expired indicates the planning period has passed.. Valid values are `pending_review|approved|rejected|under_revision|expired`',
    `safety_stock_status` STRING COMMENT 'The safety stock status of the safety stock record',
    `service_level_pct` DECIMAL(18,2) COMMENT 'The service level pct of the safety stock record',
    `shelf_life_days` STRING COMMENT 'The shelf life or expiration period of the product in days. Critical for Fast-Moving Consumer Goods (FMCG) and Consumer Packaged Goods (CPG) safety stock decisions to prevent obsolescence. Influences maximum safety stock levels and First Expired First Out (FEFO) policies.',
    `source_system_code` STRING COMMENT 'The source system code of the safety stock record',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated cost of a stockout per unit including lost sales, expediting costs, customer dissatisfaction, and brand impact. Used in service level optimization to quantify the cost of Out of Stock (OOS) events. Expressed in local currency.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A quantitative risk score assessing supply chain vulnerability for this SKU-location. Higher scores indicate greater risk from supplier reliability, geopolitical factors, transportation disruptions, or single-source dependencies. Used to adjust safety stock buffers.',
    `target_service_level_percent` DECIMAL(18,2) COMMENT 'The desired in-stock probability or fill rate target expressed as a percentage (e.g., 95.00, 98.50). Drives the safety stock buffer size to achieve the specified On Shelf Availability (OSA) or Service Level Agreement (SLA).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for safety stock quantities. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon. Must align with SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `units` DECIMAL(18,2) COMMENT 'The units of the safety stock record',
    `uom` STRING COMMENT 'The uom of the safety stock record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the safety stock record',
    `xyz_classification` STRING COMMENT 'The XYZ classification based on demand variability. X items have low variability (predictable); Y items have moderate variability; Z items have high variability (unpredictable). Used alongside ABC to determine safety stock strategy.. Valid values are `X|Y|Z`',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution value corresponding to the target service level. Used in statistical safety stock formulas to translate service level percentage into buffer quantity.',
    CONSTRAINT pk_safety_stock PRIMARY KEY(`safety_stock_id`)
) COMMENT 'Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the supply replenishment order record. Primary key for this entity.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: CONTRACT_COMPLIANCE: Each replenishment order is governed by a carrier contract; needed for rate and penalty enforcement.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or transportation provider assigned to execute this replenishment shipment.',
    `consensus_demand_id` BIGINT COMMENT 'Foreign key linking to supply.consensus_demand. Business justification: Replenishment orders are generated to fulfill consensus demand volumes agreed upon in the S&OP process. Linking supply_replenishment_order to the specific consensus_demand record it fulfills enables d',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders incur expenses that must be tracked against the responsible cost center for expense reporting and internal charge‑backs.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Replenishment orders are generated by DRP execution to fulfill demand plans. Linking supply_replenishment_order to the originating demand_plan enables demand-supply pegging, traceability from plan to ',
    `network_node_id` BIGINT COMMENT 'Identifier of the supply network node to which inventory will be delivered (distribution center, warehouse, or retail location).',
    `destination_network_node_id` BIGINT COMMENT 'The destination network node id of the supply replenishment order record',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: Replenishment orders are generated based on inventory policy parameters (reorder point, order-up-to level, replenishment method). Linking to the governing inventory_policy record enables policy compli',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: ORDER_EXECUTION: Replenishment order execution follows a specific lane; lane_id links order to transportation routing.',
    `logistics_shipment_id` BIGINT COMMENT 'Identifier of the physical shipment record associated with this replenishment order once released for execution.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: CPG replenishment orders cover raw material and packaging procurement, not only finished goods transfers. Purchase orders for ingredients and packaging components are core supply chain operations. A C',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: A replenishment order travels along a specific supply network lane (source-destination pair). The network_lane is the supply domains lane entity defining lead times, costs, and capacity for the route',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the supply network node from which inventory will be shipped (plant, distribution center, or warehouse).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replenishment orders in consumer goods are assigned to profit centers for supply chain cost reporting, intercompany transfer pricing, and P&L allocation by business unit. This is a standard SAP/ERP or',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being replenished through this order.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: Replenishment orders are generated within a specific S&OP/IBP planning cycle. The drp_run_timestamp on supply_replenishment_order indicates a planning run context tied to a cycle. Linking to sop_cycle',
    `source_network_node_id` BIGINT COMMENT 'The source network node id of the supply replenishment order record',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Replenishment orders are financially valued using standard cost for inventory accounting, purchase price variance (PPV) analysis, and working capital reporting. The order_cost_amount on supply_repleni',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Replenishment orders are sourced from a specific supplier in consumer goods. This link enables supplier performance tracking (lead time adherence, OTIF), replenishment cost analysis by supplier, and s',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Replenishment orders ship from a specific supplier site (factory or distribution point). This link supports site-level OTIF tracking, capacity constraint analysis, and compliance auditing — essential ',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: When a replenishment order is triggered by a safety stock breach (safety_stock_trigger_flag = true), linking to the specific safety_stock record that triggered it enables precise demand-supply pegging',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Demand-driven replenishment (DRP) in consumer goods traces replenishment orders back to the customer sales order that triggered them. This link enables end-to-end order fulfillment traceability, backo',
    `actual_receipt_date` DATE COMMENT 'Actual date the goods were received at the destination location.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the supply replenishment order record',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'ATP quantity at the source location at the time the replenishment order was created, used to validate supply availability.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the replenishment order was cancelled, if applicable.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU confirmed for shipment by the source location, may differ from requested quantity due to supply constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `drp_run_timestamp` TIMESTAMP COMMENT 'Date and time when the DRP execution run that generated this order was executed.',
    `due_date` DATE COMMENT 'The due date of the supply replenishment order record',
    `effective_from` DATE COMMENT 'The effective from of the supply replenishment order record',
    `effective_until` DATE COMMENT 'The effective until of the supply replenishment order record',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity at the destination location that drove the replenishment calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was last modified in the system.',
    `lead_time_days` STRING COMMENT 'The lead time days of the supply replenishment order record',
    `notes` STRING COMMENT 'The notes of the supply replenishment order record',
    `order_cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with this replenishment order, including product cost, transportation cost, and handling fees.',
    `order_notes` STRING COMMENT 'Free-text notes or special instructions related to this replenishment order, such as handling requirements or routing constraints.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The order quantity of the supply replenishment order record',
    `order_status` STRING COMMENT 'Current execution status of the replenishment order in the supply chain workflow.. Valid values are `draft|open|in_transit|received|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the replenishment order lifecycle stage: planned (system-generated recommendation), firmed (manually confirmed but not released), or released (committed for execution).. Valid values are `planned|firmed|released`',
    `planned_receipt_date` DATE COMMENT 'Target date for goods receipt at the destination location, accounting for transit lead time.',
    `planned_ship_date` DATE COMMENT 'Target date for shipment departure from the source location as calculated by the DRP engine.',
    `priority` STRING COMMENT 'The priority of the supply replenishment order record',
    `priority_code` STRING COMMENT 'Priority classification for order fulfillment, typically driven by stock-out risk, customer service level, or strategic importance.. Valid values are `critical|high|normal|low`',
    `promised_date` DATE COMMENT 'The promised date of the supply replenishment order record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the supply replenishment order record',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU received at the destination location, captured at goods receipt.',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique order number for the replenishment order, used for tracking and reference across systems and communications.. Valid values are `^REP-[0-9]{10}$`',
    `requested_date` DATE COMMENT 'The requested date of the supply replenishment order record',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment as calculated by the DRP engine or demand planner.',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below safety stock threshold at the destination location.',
    `ship_date` DATE COMMENT 'The ship date of the supply replenishment order record',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU shipped from the source location, captured at dispatch.',
    `source_system_code` STRING COMMENT 'The source system code of the supply replenishment order record',
    `supply_replenishment_order_code` STRING COMMENT 'The supply replenishment order code of the supply replenishment order record',
    `supply_replenishment_order_description` STRING COMMENT 'The supply replenishment order description of the supply replenishment order record',
    `supply_replenishment_order_name` STRING COMMENT 'The supply replenishment order name of the supply replenishment order record',
    `supply_replenishment_order_status` STRING COMMENT 'The supply replenishment order status of the supply replenishment order record',
    `transit_lead_time_days` STRING COMMENT 'Planned number of days for goods to travel from source to destination location.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation planned or used for this replenishment shipment.. Valid values are `truck|rail|air|ocean|intermodal`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this order (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the supply replenishment order record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the supply replenishment order record',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Transactional record representing a planned or released replenishment order generated by DRP execution for moving inventory between supply network nodes (plant-to-DC, DC-to-DC). Captures order type (planned/firmed/released), source location, destination location, SKU, requested quantity, confirmed quantity, planned ship date, planned receipt date, and DRP run reference. Distinct from purchase orders (owned by procurement) and production orders (owned by manufacturing). [SSOT] Superseded by authoritative table inventory.inventory_replenishment_order for concept replenishment_order. SSOT: canonical table is inventory.inventory_replenishment_order. [SSOT for concept replenishment_order.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Network nodes (plants, DCs) belong to a legal entity (company code) for statutory reporting, intercompany transactions, and tax compliance. In consumer goods with multi-country operations, this is a f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating costs of each network node (warehouse, DC) are allocated to a cost center for overhead accounting and performance tracking.',
    `parent_network_node_id` BIGINT COMMENT 'The parent network node id of the network node record',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution network nodes (DCs, warehouses, plants) are mapped to profit centers for cost allocation, P&L reporting by location, and transfer pricing in consumer goods. This is a fundamental organiza',
    `address_line_1` STRING COMMENT 'Primary street address line for the supply network node location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line (suite, building, floor) for the supply network node location. Organizational contact data classified as confidential.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the network node record',
    `capacity_class` STRING COMMENT 'Classification of the supply network node storage and throughput capacity used in IBP supply planning for capacity-constrained optimization.. Valid values are `small|medium|large|extra_large|mega`',
    `city` STRING COMMENT 'City where the supply network node is located. Used for geographic analysis and transportation planning. Organizational contact data classified as confidential.',
    `network_node_code` STRING COMMENT 'The network node code of the network node record',
    `country_code` STRING COMMENT 'The country code of the network node record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was first created in the system. Used for audit trail and data lineage.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports cross-docking operations (direct transfer without storage). Used in transportation and distribution planning.',
    `currency_code` STRING COMMENT 'The currency code of the network node record',
    `network_node_description` STRING COMMENT 'The network node description of the network node record',
    `dsd_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports Direct Store Delivery operations. Used in distribution planning and route optimization.',
    `echelon_level` STRING COMMENT 'The echelon level of the network node record',
    `effective_end_date` DATE COMMENT 'Date when this supply network node was decommissioned or removed from the active supply network. Null for currently active nodes.',
    `effective_from` DATE COMMENT 'The effective from of the network node record',
    `effective_start_date` DATE COMMENT 'Date when this supply network node became operational and active in the supply network. Used for historical network analysis and planning.',
    `effective_until` DATE COMMENT 'The effective until of the network node record',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the physical location of the supply network node for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this supply network node is certified to handle and store hazardous materials. Used for product allocation and regulatory compliance.',
    `is_active` BOOLEAN COMMENT 'The is active of the network node record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was last updated. Used for change tracking and data synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from this supply network node to downstream nodes or customers. Used in DRP execution and ATP/CTP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `network_node_name` STRING COMMENT 'The network node name of the network node record',
    `network_node_status` STRING COMMENT 'The network node status of the network node record',
    `node_code` STRING COMMENT 'Business identifier code for the supply network node used across planning and execution systems. Typically a short alphanumeric code used in SAP IBP and ERP systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `node_name` STRING COMMENT 'Human-readable name of the supply network node (e.g., Chicago Regional DC, Memphis Manufacturing Plant, Dallas Forward DC).',
    `node_status` STRING COMMENT 'Current operational status of the supply network node in the supply planning system. Active nodes participate in DRP and IBP planning runs.. Valid values are `active|inactive|planned|decommissioned|temporarily_closed`',
    `node_type` STRING COMMENT 'Classification of the supply network node indicating its role in the supply chain (manufacturing plant, regional distribution center, forward distribution center, co-manufacturer, third-party logistics warehouse, cross-dock facility, or supplier location). [ENUM-REF-CANDIDATE: manufacturing_plant|regional_dc|forward_dc|co_manufacturer|3pl_warehouse|cross_dock|supplier_location — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'The notes of the network node record',
    `ownership_type` STRING COMMENT 'Ownership model of the supply network node (company-owned, leased, third-party logistics managed, co-manufacturer, or contract facility). Used for cost allocation and strategic network design.. Valid values are `owned|leased|3pl_managed|co_manufacturer|contract`',
    `planning_group` STRING COMMENT 'Planning group or cluster assignment for the supply network node used in IBP and S&OP processes to aggregate nodes for planning purposes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supply network node location. Used for logistics routing and delivery planning. Organizational contact data classified as confidential.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the network node record',
    `region` STRING COMMENT 'The region of the network node record',
    `replenishment_frequency` STRING COMMENT 'Standard replenishment frequency for inventory at this supply network node. Used in DRP planning and inventory policy definition.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `safety_stock_days` STRING COMMENT 'Target safety stock coverage in days of supply maintained at this network node. Used in inventory optimization and S&OP planning.',
    `source_system_code` STRING COMMENT 'The source system code of the network node record',
    `sourcing_priority` STRING COMMENT 'Priority ranking of this supply network node in sourcing rules and allocation logic (lower number = higher priority). Used in IBP supply planning and ATP/CTP allocation.',
    `state_province` STRING COMMENT 'State or province code where the supply network node is located. Used for tax jurisdiction and regulatory compliance. Organizational contact data classified as confidential.',
    `storage_capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the supply network node measured in standard storage units (pallets, cases, or cubic meters). Used for inventory optimization and DRP planning.',
    `storage_capacity_uom` STRING COMMENT 'Unit of measure for the storage capacity (pallets, cases, cubic meters, square meters). Aligns with WMS and IBP planning units.. Valid values are `pallets|cases|cubic_meters|square_meters`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node has temperature-controlled storage capabilities for temperature-sensitive products. Used in product allocation and quality management.',
    `throughput_capacity_daily` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the supply network node measured in standard units (cases, pallets, or production units per day). Used for production and distribution planning.',
    `throughput_capacity_uom` STRING COMMENT 'Unit of measure for the daily throughput capacity. Used in production scheduling and distribution planning.. Valid values are `cases_per_day|pallets_per_day|units_per_day|tons_per_day`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supply network node location (e.g., America/Chicago, America/New_York). Used for scheduling and ATP/CTP calculations.',
    `uom` STRING COMMENT 'The uom of the network node record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the network node record',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node participates in Vendor Managed Inventory programs. Used in collaborative planning and replenishment processes.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` (
    `network_lane_id` BIGINT COMMENT 'Primary key for network_lane',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Lane Rate Governance process: each supply network lane is executed under a specific carrier contract defining rates, SLAs, and penalty clauses. Linking network_lane to carrier_contract enables contrac',
    `carrier_id` BIGINT COMMENT 'Identifier of the preferred or contracted transportation carrier servicing this lane. Used for freight planning and cost estimation.',
    `network_node_id` BIGINT COMMENT 'Identifier of the receiving supply network node (distribution center, warehouse, retail store, or customer location) to which goods are delivered.',
    `destination_network_node_id` BIGINT COMMENT 'The destination network node id of the network lane record',
    `lane_id` BIGINT COMMENT 'The lane id of the network lane record',
    `origin_network_node_id` BIGINT COMMENT 'The origin network node id of the network lane record',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the originating supply network node (plant, distribution center, warehouse, or external supplier) from which goods are sourced.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the network lane record',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of this lane per planning period (day, week, month), representing the upper limit of goods that can be moved. Used by Supply Planning and Sales and Operations Planning (S&OP) for capacity-constrained optimization.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity quantity field, indicating how lane capacity is measured and constrained. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `network_lane_code` STRING COMMENT 'The network lane code of the network lane record',
    `compliance_requirements` STRING COMMENT 'Regulatory or business compliance requirements applicable to this lane, such as temperature control (Good Manufacturing Practice - GMP), hazardous materials handling (Environmental Protection Agency - EPA), or cross-border customs (Food and Drug Administration - FDA).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard transportation or transfer cost per unit of measure for moving goods along this lane. Used for supply chain cost modeling and total landed cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and pricing on this lane (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `network_lane_description` STRING COMMENT 'The network lane description of the network lane record',
    `distance_km` DECIMAL(18,2) COMMENT 'The distance km of the network lane record',
    `effective_end_date` DATE COMMENT 'Date when this supply network lane ceases or will cease to be effective. Null for lanes with no planned end date.',
    `effective_from` DATE COMMENT 'The effective from of the network lane record',
    `effective_start_date` DATE COMMENT 'Date when this supply network lane becomes or became effective and available for use in planning and execution systems.',
    `effective_until` DATE COMMENT 'The effective until of the network lane record',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is currently active and available for use in supply planning and replenishment. True if active; false if temporarily or permanently disabled.',
    `is_primary_lane` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is the primary (preferred) sourcing route for the destination. True if this is the default lane used under normal conditions; false for backup or secondary lanes.',
    `lane_cost_per_unit` DECIMAL(18,2) COMMENT 'The lane cost per unit of the network lane record',
    `lane_mode` STRING COMMENT 'The lane mode of the network lane record',
    `lane_type` STRING COMMENT 'Classification of the supply network lane based on the nature of the sourcing relationship: production (from manufacturing plant), transfer (between internal facilities), external procurement (from supplier), direct shipment (plant to customer), cross-dock (no storage), or drop-ship (supplier to customer).. Valid values are `production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship`',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this supply network lane record, used for audit trail and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was most recently updated, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lead_time_days` DECIMAL(18,2) COMMENT 'The lead time days of the network lane record',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard batch or lot size for replenishment orders on this lane. Orders are typically rounded to multiples of this quantity for operational efficiency (e.g., full pallet, full truckload).',
    `max_capacity_units` DECIMAL(18,2) COMMENT 'The max capacity units of the network lane record',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or shipped on this lane in a single replenishment cycle, constrained by capacity, vehicle limits, or storage restrictions.',
    `min_order_quantity` DECIMAL(18,2) COMMENT 'The min order quantity of the network lane record',
    `min_shipment_units` DECIMAL(18,2) COMMENT 'The min shipment units of the network lane record',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or shipped on this lane to meet operational or economic constraints. Used by DRP to ensure replenishment orders meet minimum thresholds.',
    `network_lane_name` STRING COMMENT 'The network lane name of the network lane record',
    `network_lane_status` STRING COMMENT 'Current lifecycle status of the supply network lane: active (operational), inactive (temporarily disabled), suspended (on hold), planned (future activation), or decommissioned (permanently closed).. Valid values are `active|inactive|suspended|planned|decommissioned`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or contextual information about this supply network lane.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Specific target percentage for On Time In Full delivery performance on this lane, a key supply chain Key Performance Indicator (KPI) measuring the percentage of orders delivered on time and complete.',
    `planning_group` STRING COMMENT 'Organizational grouping or planning segment to which this lane belongs, used for segmented planning and reporting in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `processing_lead_time_days` DECIMAL(18,2) COMMENT 'Time in days required for order processing, picking, packing, and loading at the source location before shipment begins.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the network lane record',
    `risk_category` STRING COMMENT 'Supply risk classification for this lane based on factors such as lead time variability, carrier reliability, geopolitical risk, and single-source dependency. Used for supply risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `safety_stock_days` DECIMAL(18,2) COMMENT 'Number of days of safety stock coverage recommended at the destination to buffer against variability in this lanes lead time and demand. Used by Inventory Optimization to calculate safety stock targets.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Target service level percentage for on-time and in-full delivery performance on this lane, expressed as a percentage (e.g., 95.00 for 95%). Used to measure On Time In Full (OTIF) performance.',
    `source_system_code` STRING COMMENT 'The source system code of the network lane record',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order for this lane when multiple sourcing options exist for the same destination. Lower numbers indicate higher priority (1 = primary, 2 = secondary, etc.). Used by Distribution Requirements Planning (DRP) and Integrated Business Planning (IBP) to determine replenishment routing.',
    `standard_lead_time_days` DECIMAL(18,2) COMMENT 'Total planned lead time in days from order placement to goods receipt at destination, including processing time, transportation time, and buffer. Used by Material Requirements Planning (MRP) and Distribution Requirements Planning (DRP) for replenishment calculations.',
    `transit_time_days` STRING COMMENT 'The transit time days of the network lane record',
    `transport_mode` STRING COMMENT 'The transport mode of the network lane record',
    `transportation_lead_time_days` DECIMAL(18,2) COMMENT 'Transit time in days for goods to move from source to destination, excluding processing and handling time. Component of the total standard lead time.',
    `transportation_mode` STRING COMMENT 'Primary method of transportation used for moving goods along this lane: truck (road freight), rail (train), ocean (sea freight), air (air cargo), intermodal (combination), or parcel (small package delivery).. Valid values are `truck|rail|ocean|air|intermodal|parcel`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this lane: EA (each), CS (case), PL (pallet), TU (truck unit), KG (kilogram), LB (pound), L (liter), GAL (gallon). Aligns with GS1 standards. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the network lane record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the network lane record',
    CONSTRAINT pk_network_lane PRIMARY KEY(`network_lane_id`)
) COMMENT 'Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` (
    `atp_record_id` BIGINT COMMENT 'Primary key for atp_record',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In consumer goods, marketing teams request ATP confirmation before committing to campaign launch dates and volume commitments. Linking atp_record directly to campaign enables campaign-specific availab',
    `consensus_demand_id` BIGINT COMMENT 'Foreign key linking to supply.consensus_demand. Business justification: ATP records are calculated against consensus demand volumes from the S&OP process. Linking atp_record to the specific consensus_demand record enables ATP availability measurement against committed con',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: ATP/CTP calculations consume demand from demand plans. The demand_pegging_reference STRING column on atp_record is a free-text reference to the demand plan — replacing it with a proper FK demand_plan_',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to supply.forecast_version. Business justification: ATP calculations consume forecast demand from a specific forecast version. The forecast_consumption_quantity on atp_record represents how much of the forecast has been consumed by committed orders. Li',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: CPG Capable-to-Promise (CTP) checks require component/material ATP alongside finished goods ATP. Material availability at a node determines whether a production order can be confirmed. CPG supply plan',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: ATP checks are performed at sales order entry to confirm fulfillment promises. Linking atp_record to the sales order it was generated for enables OTIF tracking, customer promise management, and backor',
    `network_node_id` BIGINT COMMENT 'The origin network node id of the atp record record',
    `primary_atp_supply_network_node_id` BIGINT COMMENT 'Reference to the distribution facility or warehouse location where ATP is calculated.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: ATP records peg available supply to demand by referencing specific supply replenishment orders. The supply_pegging_reference STRING column on atp_record is a free-text reference to the supply order — ',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which ATP is calculated.',
    `sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: ATP/CTP calculations are performed within a specific S&OP/IBP planning cycle. The planning_version STRING on atp_record references a planning cycle context. Linking to sop_cycle via a proper FK enable',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity already committed or reserved for existing sales orders, reducing available ATP.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the atp record record',
    `atp_calculation_method` STRING COMMENT 'The method used to calculate ATP. Simple ATP considers only on-hand inventory minus allocations. Cumulative ATP includes planned receipts over time. Multi-level ATP considers BOM components. Product allocation ATP applies allocation rules across customer segments.. Valid values are `simple|cumulative|multi_level|product_allocation`',
    `atp_check_horizon_days` STRING COMMENT 'The number of days into the future that the ATP check considers for availability. Defines the planning horizon for promise calculations.',
    `atp_confirmation_number` STRING COMMENT 'Unique confirmation number generated when ATP is reserved for a sales order, providing traceability between ATP records and order promising.',
    `atp_date` DATE COMMENT 'The date for which ATP quantity is calculated. Represents the promise date for order fulfillment.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The confirmed quantity available to promise to customers for the given SKU, location, and date. Represents uncommitted inventory available for new orders.',
    `atp_record_status` STRING COMMENT 'The atp record status of the atp record record',
    `atp_status` STRING COMMENT 'The current status of the ATP record. Available indicates positive ATP. Constrained indicates limited availability. Blocked indicates ATP is not available for promising. Expired indicates the ATP date has passed.. Valid values are `available|constrained|blocked|expired`',
    `available_date` DATE COMMENT 'The available date of the atp record record',
    `available_quantity` DECIMAL(18,2) COMMENT 'The available quantity of the atp record record',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The quantity of unfulfilled demand from previous periods that impacts current ATP availability.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this ATP record was calculated. Critical for understanding data freshness and order promising accuracy.',
    `atp_record_code` STRING COMMENT 'The atp record code of the atp record record',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The committed quantity of the atp record record',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was first created in the lakehouse silver layer.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity that can be promised considering both current inventory and planned production or supply receipts. Extends ATP by including future supply.',
    `cumulative_atp` DECIMAL(18,2) COMMENT 'The cumulative atp of the atp record record',
    `cumulative_atp_quantity` DECIMAL(18,2) COMMENT 'The cumulative ATP quantity calculated across multiple time periods, showing total available quantity from current date through the ATP date.',
    `currency_code` STRING COMMENT 'The currency code of the atp record record',
    `customer_priority_tier` STRING COMMENT 'The priority tier of the customer or channel for which ATP is being calculated, used in allocation scenarios where high-priority customers receive preferential ATP.. Valid values are `tier_1|tier_2|tier_3|standard`',
    `atp_record_description` STRING COMMENT 'The atp record description of the atp record record',
    `effective_from` DATE COMMENT 'The effective from of the atp record record',
    `effective_until` DATE COMMENT 'The effective until of the atp record record',
    `expiration_date` DATE COMMENT 'The expiration date of the inventory lot or batch, relevant for FEFO (First Expired First Out) ATP logic in consumer goods with shelf life constraints.',
    `forecast_consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of forecast demand consumed by actual sales orders, used in ATP calculations to avoid double-counting demand.',
    `intransit_quantity` DECIMAL(18,2) COMMENT 'The quantity currently in transit to the location that will contribute to ATP upon arrival.',
    `minimum_shelf_life_days` STRING COMMENT 'The minimum remaining shelf life in days required for the product to be available for promising, ensuring customers receive products with adequate shelf life.',
    `atp_record_name` STRING COMMENT 'The atp record name of the atp record record',
    `notes` STRING COMMENT 'The notes of the atp record record',
    `on_hand_inventory` DECIMAL(18,2) COMMENT 'The physical inventory quantity available at the location at the time of ATP calculation.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'The on hand quantity of the atp record record',
    `planned_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity expected to be received from production orders, purchase orders, or transfers by the ATP date.',
    `planning_bucket` STRING COMMENT 'The planning bucket of the atp record record',
    `planning_version` STRING COMMENT 'The planning scenario or version identifier in SAP IBP under which this ATP calculation was performed, enabling what-if analysis and scenario planning.',
    `product_allocation_group` STRING COMMENT 'The allocation group or priority segment assigned to this ATP calculation, used when ATP is allocated across customer tiers or channels.',
    `production_order_quantity` DECIMAL(18,2) COMMENT 'The quantity scheduled for production that will be available by the ATP date.',
    `purchase_order_quantity` DECIMAL(18,2) COMMENT 'The quantity on open purchase orders expected to be received by the ATP date.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the atp record record',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The minimum inventory buffer maintained to protect against demand variability and supply uncertainty. May reduce ATP if policy enforces safety stock protection.',
    `source_system_code` STRING COMMENT 'The source system code of the atp record record',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this ATP record in the source operational system, enabling traceability and reconciliation.',
    `supply_quantity` DECIMAL(18,2) COMMENT 'The supply quantity of the atp record record',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields in this record. Common values: EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the atp record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was last updated in the lakehouse silver layer.',
    CONSTRAINT pk_atp_record PRIMARY KEY(`atp_record_id`)
) COMMENT 'Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` (
    `sop_cycle_id` BIGINT COMMENT 'Unique identifier for the S&OP/IBP planning cycle instance. Primary key.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: S&OP cycles in consumer goods are explicitly scoped to profit centers for the financial review step — revenue, margin, and gap-to-target are reviewed by profit center during each cycle. This link enab',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sop cycle record',
    `baseline_demand_volume` DECIMAL(18,2) COMMENT 'The total baseline demand volume (in units) across all SKUs for the planning horizon at the start of this cycle.',
    `sop_cycle_code` STRING COMMENT 'The sop cycle code of the sop cycle record',
    `consensus_demand_volume` DECIMAL(18,2) COMMENT 'The total consensus demand volume (in units) across all SKUs after demand review adjustments.',
    `consensus_meeting_date` DATE COMMENT 'The consensus meeting date of the sop cycle record',
    `constrained_supply_volume` DECIMAL(18,2) COMMENT 'The total constrained supply volume (in units) that can be delivered given capacity and material constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this S&OP cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the sop cycle record',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the cycle for external reference and system integration (e.g., SOP-2024-01, IBP-Q1-24).',
    `cycle_end_date` DATE COMMENT 'The date when this S&OP cycle is scheduled to complete and be locked (typically before the start of the planning month).',
    `cycle_locked_date` DATE COMMENT 'The date when this S&OP cycle was locked and finalized.',
    `cycle_locked_flag` BOOLEAN COMMENT 'Indicates whether this S&OP cycle has been locked and no further changes are permitted (True if locked, False if still open for edits).',
    `cycle_name` STRING COMMENT 'Business-friendly name or label for the S&OP cycle (e.g., January 2024 S&OP Cycle, Q1 FY2024 IBP).',
    `cycle_notes` STRING COMMENT 'General free-text notes or comments about this S&OP cycle, including special circumstances, deviations from standard process, or other relevant context.',
    `cycle_phase` STRING COMMENT 'Current phase of the S&OP cycle: statistical_forecast (initial statistical forecast generation), demand_review (demand planning team review), supply_review (supply planning team review), pre_sop (pre-S&OP reconciliation meeting), executive_sop (executive S&OP decision meeting), closed (cycle completed and locked).. Valid values are `statistical_forecast|demand_review|supply_review|pre_sop|executive_sop|closed`',
    `cycle_start_date` DATE COMMENT 'The date when this S&OP cycle officially begins (typically the first day of the cycle month).',
    `cycle_status` STRING COMMENT 'The cycle status of the sop cycle record',
    `cycle_type` STRING COMMENT 'The cadence or type of S&OP cycle: monthly (standard monthly cadence), quarterly (quarterly review), annual (annual planning), rolling (continuous rolling horizon), event_driven (triggered by specific business events).. Valid values are `monthly|quarterly|annual|rolling|event_driven`',
    `demand_consensus_achieved_flag` BOOLEAN COMMENT 'Indicates whether demand consensus was achieved during the demand review phase (True if consensus reached, False otherwise).',
    `demand_review_date` DATE COMMENT 'The demand review date of the sop cycle record',
    `demand_review_due_date` DATE COMMENT 'Target date by which the demand review phase must be completed.',
    `sop_cycle_description` STRING COMMENT 'The sop cycle description of the sop cycle record',
    `effective_from` DATE COMMENT 'The effective from of the sop cycle record',
    `effective_until` DATE COMMENT 'The effective until of the sop cycle record',
    `end_date` DATE COMMENT 'The end date of the sop cycle record',
    `executive_approval_date` DATE COMMENT 'The date when the executive sponsor formally approved the S&OP plan for this cycle.',
    `executive_approval_flag` BOOLEAN COMMENT 'Indicates whether the executive S&OP meeting approved the plan (True if approved, False if rejected or pending).',
    `executive_approval_notes` STRING COMMENT 'Free-text notes or comments from the executive sponsor regarding the approval decision, including any conditions or action items.',
    `executive_review_date` DATE COMMENT 'The executive review date of the sop cycle record',
    `executive_sop_meeting_date` DATE COMMENT 'Scheduled date for the executive S&OP meeting where senior leadership reviews and approves the plan.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number) within the fiscal year (e.g., 1 for January, 12 for December).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this planning cycle belongs (e.g., 2024).',
    `frozen_period_months` STRING COMMENT 'The number of months at the start of the planning horizon that are frozen and not subject to change (typically 0-3 months).',
    `key_assumptions` STRING COMMENT 'Free-text field capturing the key business assumptions underlying this S&OP cycle (e.g., promotional plans, market trends, supply constraints, new product launches).',
    `key_risks` STRING COMMENT 'Free-text field documenting the key risks identified during this S&OP cycle (e.g., supplier reliability, demand volatility, capacity constraints).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this S&OP cycle record was last updated.',
    `mitigation_actions` STRING COMMENT 'Free-text field describing the mitigation actions agreed upon to address identified risks and supply gaps.',
    `sop_cycle_name` STRING COMMENT 'The sop cycle name of the sop cycle record',
    `notes` STRING COMMENT 'The notes of the sop cycle record',
    `phase_status` STRING COMMENT 'Status of the current cycle phase: not_started (phase has not begun), in_progress (phase is actively underway), completed (phase finished and approved), on_hold (phase temporarily paused), cancelled (phase or cycle cancelled).. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `planning_horizon_months` STRING COMMENT 'The number of months into the future that this S&OP cycle plans (e.g., 18 months, 24 months).',
    `planning_month` DATE COMMENT 'The target month for which this S&OP cycle is planning demand and supply (typically the first day of the planning month).',
    `pre_sop_meeting_date` DATE COMMENT 'Scheduled date for the pre-S&OP reconciliation meeting where demand and supply teams align on recommendations.',
    `pre_sop_review_date` DATE COMMENT 'The pre sop review date of the sop cycle record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sop cycle record',
    `sop_cycle_status` STRING COMMENT 'The sop cycle status of the sop cycle record',
    `source_system_code` STRING COMMENT 'The source system code of the sop cycle record',
    `start_date` DATE COMMENT 'The start date of the sop cycle record',
    `statistical_forecast_due_date` DATE COMMENT 'Target date by which the statistical forecast phase must be completed.',
    `supply_consensus_achieved_flag` BOOLEAN COMMENT 'Indicates whether supply consensus was achieved during the supply review phase (True if consensus reached, False otherwise).',
    `supply_gap_volume` DECIMAL(18,2) COMMENT 'The total supply gap (in units) representing the difference between consensus demand and constrained supply (positive indicates shortfall, negative indicates surplus).',
    `supply_review_date` DATE COMMENT 'The supply review date of the sop cycle record',
    `supply_review_due_date` DATE COMMENT 'Target date by which the supply review phase must be completed.',
    `uom` STRING COMMENT 'The uom of the sop cycle record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sop cycle record',
    CONSTRAINT pk_sop_cycle PRIMARY KEY(`sop_cycle_id`)
) COMMENT 'Master entity representing each S&OP/IBP planning cycle instance (monthly cadence). Captures cycle name, planning month, cycle phase (statistical forecast, demand review, supply review, pre-S&OP, executive S&OP), phase status, cycle owner, key milestones, and sign-off records. Provides the governance framework for all demand and supply planning activities within the cycle.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` (
    `consensus_demand_id` BIGINT COMMENT 'Unique identifier for the consensus demand record. Primary key for this entity representing a single agreed demand signal from the S&OP demand review process.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: consensus_demand holds marketing_event_uplift_quantity, commercial_overlay_quantity, and promotion_flag — all campaign-sourced inputs agreed in S&OP consensus meetings. Direct FK to campaign ena',
    `demand_plan_id` BIGINT COMMENT 'FK to supply.demand_plan.demand_plan_id — Links consensus demand records to demand plan header. Required for S&OP process tracking and forecast accuracy measurement.',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to supply.forecast_version. Business justification: Consensus demand is derived from and compared against a specific forecast version during the S&OP demand review. The statistical_forecast_quantity and forecast_model_code on consensus_demand reference',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: CPG S&OP consensus demand is agreed at hierarchy levels (brand/category) before SKU disaggregation. Category managers and brand teams provide consensus inputs at hierarchy nodes. This link supports th',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consensus demand in consumer goods S&OP is the agreed volume by profit center — finance inputs (finance_input_quantity already on consensus_demand) and approves figures by profit center for revenue pl',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which consensus demand is being planned. Links to the product master data.',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the specific S&OP or IBP cycle during which this consensus demand was agreed. Enables tracking of demand evolution across planning cycles.',
    `network_node_id` BIGINT COMMENT 'Reference to the planning location (distribution center, plant, or market) for which this consensus demand applies.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand record is currently active and should be used by supply planning. False indicates the record has been superseded or deactivated.',
    `agreed_date` DATE COMMENT 'The agreed date of the consensus demand record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consensus demand record',
    `approval_status` STRING COMMENT 'Current approval state of the consensus demand record within the S&OP workflow. Only approved records are released to supply planning.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consensus demand was formally approved and released to supply planning. Marks the transition from draft to official demand signal.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'The approved quantity of the consensus demand record',
    `bias_indicator` STRING COMMENT 'Indicator of systematic forecasting bias based on historical performance. Over-forecast indicates consistent overestimation; under-forecast indicates consistent underestimation; neutral indicates balanced accuracy.. Valid values are `over_forecast|under_forecast|neutral`',
    `consensus_demand_code` STRING COMMENT 'The consensus demand code of the consensus demand record',
    `comments` STRING COMMENT 'Free-text field for demand planners to capture additional context, assumptions, risks, or special considerations related to this consensus demand record.',
    `commercial_input_quantity` DECIMAL(18,2) COMMENT 'The commercial input quantity of the consensus demand record',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'The demand adjustment applied by commercial teams based on market intelligence, customer commitments, and sales insights. Can be positive or negative.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the consensus demand figure based on data quality, market stability, and input reliability. Used for risk-based supply planning.. Valid values are `high|medium|low`',
    `consensus_demand_status` STRING COMMENT 'The consensus demand status of the consensus demand record',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'The final agreed demand volume for this SKU/location/period after all inputs and overlays have been applied. This is the single demand signal passed to supply planning and represents the official forecast.',
    `constrained_flag` BOOLEAN COMMENT 'Indicates whether the consensus demand has been adjusted downward due to known supply constraints. True means demand was constrained; false means demand is unconstrained.',
    `constraint_reason` STRING COMMENT 'Explanation of the supply constraint that limited consensus demand (e.g., production capacity, raw material shortage, distribution capacity). Populated only when constrained_flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was first created in the system. Part of standard audit trail.',
    `currency_code` STRING COMMENT 'The currency code of the consensus demand record',
    `customer_commitment_quantity` DECIMAL(18,2) COMMENT 'Demand volume backed by firm customer orders, contracts, or commitments for this planning period. Represents the most reliable component of consensus demand.',
    `demand_category` STRING COMMENT 'Classification of the demand type to enable segmented planning and analysis. Base demand represents ongoing business; promotional and seasonal reflect event-driven spikes; new launch and phase-out support lifecycle transitions.. Valid values are `base|promotional|seasonal|new_launch|phase_out|special_order`',
    `demand_driver_code` STRING COMMENT 'Code identifying the primary business driver or causal factor influencing this demand (e.g., holiday season, weather pattern, competitive action, regulatory change). Supports root-cause analysis.',
    `demand_driver_description` STRING COMMENT 'Detailed explanation of the demand driver or business rationale behind the consensus demand figure. Captures qualitative insights from demand planners and commercial teams.',
    `demand_volatility_index` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability for this SKU/location combination, typically expressed as coefficient of variation. Higher values indicate greater uncertainty and require higher safety stock.',
    `consensus_demand_description` STRING COMMENT 'The consensus demand description of the consensus demand record',
    `effective_from` DATE COMMENT 'The effective from of the consensus demand record',
    `effective_until` DATE COMMENT 'The effective until of the consensus demand record',
    `finance_input_quantity` DECIMAL(18,2) COMMENT 'The finance input quantity of the consensus demand record',
    `forecast_accuracy_previous_period` DECIMAL(18,2) COMMENT 'The forecast accuracy percentage achieved for this SKU/location combination in the previous planning period. Used to assess forecasting performance trends and adjust confidence levels.',
    `forecast_model_code` STRING COMMENT 'Identifier of the statistical forecasting model or algorithm used to generate the baseline statistical forecast (e.g., exponential smoothing, ARIMA, machine learning model).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was last updated. Tracks the most recent change to any field in the record.',
    `last_review_date` DATE COMMENT 'Date when this consensus demand record was last reviewed and validated by the demand planning team during the S&OP demand review meeting.',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand volume expected from planned marketing campaigns, promotions, or trade events during this planning period.',
    `consensus_demand_name` STRING COMMENT 'The consensus demand name of the consensus demand record',
    `new_product_launch_quantity` DECIMAL(18,2) COMMENT 'Demand volume attributed to new product introductions or product launches scheduled for this planning period. Typically based on launch plans and market sizing.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next S&OP demand review when this consensus demand will be re-evaluated and updated based on latest market intelligence.',
    `notes` STRING COMMENT 'The notes of the consensus demand record',
    `planning_bucket` STRING COMMENT 'The planning bucket of the consensus demand record',
    `planning_horizon_type` STRING COMMENT 'Classification of the planning time horizon for this demand record. Short-term (0-3 months) is firm; medium-term (3-12 months) is flexible; long-term (12+ months) is strategic.. Valid values are `short_term|medium_term|long_term`',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand includes uplift from planned trade promotions or marketing events. True means promotional activity is planned; false means base demand only.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consensus demand record',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor representing seasonal demand patterns for this planning period. Values above 1.0 indicate peak season; below 1.0 indicate off-season.',
    `source_system_code` STRING COMMENT 'The source system code of the consensus demand record',
    `statistical_forecast_quantity` DECIMAL(18,2) COMMENT 'The baseline demand forecast generated by statistical forecasting algorithms before any manual adjustments or commercial overlays. Serves as the starting point for consensus demand.',
    `statistical_quantity` DECIMAL(18,2) COMMENT 'The statistical quantity of the consensus demand record',
    `unconstrained_demand_quantity` DECIMAL(18,2) COMMENT 'The theoretical demand volume if all supply constraints (capacity, materials, inventory) were removed. Used for capacity planning and investment decisions.',
    `unit_of_measure` STRING COMMENT 'The unit in which consensus demand quantity is expressed (each, case, pallet, kilogram, liter, etc.). Must align with product master UOM. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'The uom of the consensus demand record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consensus demand record',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between consensus demand and statistical forecast, calculated as (variance_to_statistical / statistical_forecast_quantity) * 100. Used to monitor forecast override patterns.',
    `variance_to_statistical` DECIMAL(18,2) COMMENT 'The difference between consensus demand quantity and statistical forecast quantity. Positive values indicate upward adjustments; negative values indicate downward adjustments. Key metric for forecast bias analysis.',
    `version_number` STRING COMMENT 'Sequential version number tracking iterations of this consensus demand record within the same S&OP cycle. Increments with each revision to support change history.',
    CONSTRAINT pk_consensus_demand PRIMARY KEY(`consensus_demand_id`)
) COMMENT 'Transactional record capturing the final consensus demand volume agreed upon during the S&OP demand review for each SKU/location/planning period. Stores statistical forecast input, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, approver, and S&OP cycle reference. Represents the single agreed demand signal passed to supply planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_primary_demand_supply_network_node_id` FOREIGN KEY (`primary_demand_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_primary_forecast_sop_cycle_id` FOREIGN KEY (`primary_forecast_sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_primary_inventory_supply_network_node_id` FOREIGN KEY (`primary_inventory_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_primary_safety_supply_network_node_id` FOREIGN KEY (`primary_safety_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_consensus_demand_id` FOREIGN KEY (`consensus_demand_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`consensus_demand`(`consensus_demand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_destination_network_node_id` FOREIGN KEY (`destination_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_source_network_node_id` FOREIGN KEY (`source_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_parent_network_node_id` FOREIGN KEY (`parent_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_destination_network_node_id` FOREIGN KEY (`destination_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_origin_network_node_id` FOREIGN KEY (`origin_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_consensus_demand_id` FOREIGN KEY (`consensus_demand_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`consensus_demand`(`consensus_demand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_primary_atp_supply_network_node_id` FOREIGN KEY (`primary_atp_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `primary_demand_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|locked');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_business_glossary_term' = 'Created By Persona');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_value_regex' = 'demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'stable|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Signal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|volatile');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `npd_launch_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Volume Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `plan_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Plan Horizon End');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `plan_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Plan Horizon Start');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `promotional_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `statistical_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `variance_to_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance to Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `primary_forecast_sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Aggregation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `algorithm_used` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Used');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `demand_sensing_applied` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Applied Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_description` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_source_system` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_active_version` SET TAGS ('dbx_business_glossary_term' = 'Is Active Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Is Final');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_final_approved_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Approved Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `mean_absolute_percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `model_parameters` SET TAGS ('dbx_business_glossary_term' = 'Model Parameters');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `new_product_introduction_included` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `promotional_events_included` SET TAGS ('dbx_business_glossary_term' = 'Promotional Events Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `statistical_model_applied` SET TAGS ('dbx_business_glossary_term' = 'Statistical Model Applied');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_business_glossary_term' = 'Forecast Time Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_label` SET TAGS ('dbx_business_glossary_term' = 'Version Label');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived|active');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `primary_inventory_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `customer_otif_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Customer OTIF Commitment Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cycle_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Cycle Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_description` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `fill_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Max Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `maximum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Min Stock Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `minimum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_name` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `on_time_delivery_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `order_up_to_level` SET TAGS ('dbx_business_glossary_term' = 'Order Up To Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `otif_composite_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Composite Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `penalty_clause_indicator` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `reorder_point_units` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'MRP|DRP|VMI|JIT|kanban|fixed_order_quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `retailer_mandated_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Retailer Mandated Target Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `review_period_days` SET TAGS ('dbx_business_glossary_term' = 'Review Period Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculated_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculated Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculated_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculated_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `primary_safety_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Inventory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approved_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_daily_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Calculated Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `days` SET TAGS ('dbx_business_glossary_term' = 'Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `days_of_supply_target` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply Target');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_value_regex' = 'steady|seasonal|erratic|lumpy|intermittent|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_variability` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Inventory Holding Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `lead_time_variability` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_name` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|under_revision|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `service_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Product Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `target_service_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Service Level Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Demand Variability Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score (Standard Normal Deviate)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `consensus_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `destination_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `source_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered Safety Stock Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `drp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Requirements Planning (DRP) Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_transit|received|cancelled|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|firmed|released');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `promised_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supply_replenishment_order_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supply_replenishment_order_description` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supply_replenishment_order_name` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supply_replenishment_order_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `parent_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_business_glossary_term' = 'Capacity Class');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large|mega');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_description` SET TAGS ('dbx_business_glossary_term' = 'Network Node Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `dsd_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `echelon_level` SET TAGS ('dbx_business_glossary_term' = 'Echelon Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `echelon_level` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `echelon_level` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_name` SET TAGS ('dbx_business_glossary_term' = 'Network Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_status` SET TAGS ('dbx_business_glossary_term' = 'Network Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|temporarily_closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|3pl_managed|co_manufacturer|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_value_regex' = 'pallets|cases|cubic_meters|square_meters');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Throughput Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_value_regex' = 'cases_per_day|pallets_per_day|units_per_day|tons_per_day');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `destination_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `origin_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_code` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_description` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `distance_km` SET TAGS ('dbx_business_glossary_term' = 'Distance Km');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_primary_lane` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Lane Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Lane Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_mode` SET TAGS ('dbx_business_glossary_term' = 'Lane Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `max_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Max Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `max_capacity_units` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `max_capacity_units` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Min Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `min_shipment_units` SET TAGS ('dbx_business_glossary_term' = 'Min Shipment Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_name` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lane Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `processing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transportation Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `consensus_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `primary_atp_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|cumulative|multi_level|product_allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_check_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Check Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_date` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_status` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_value_regex' = 'available|constrained|blocked|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `available_date` SET TAGS ('dbx_business_glossary_term' = 'Available Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ATP Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_code` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable-to-Promise (CTP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Atp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_description` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `forecast_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Consumption Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `intransit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `minimum_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_name` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `on_hand_inventory` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Inventory Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planned_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planning_version` SET TAGS ('dbx_business_glossary_term' = 'Planning Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `product_allocation_group` SET TAGS ('dbx_business_glossary_term' = 'Product Allocation Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `production_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `purchase_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `baseline_demand_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Demand Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `consensus_demand_volume` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `consensus_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Consensus Meeting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `constrained_supply_volume` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_locked_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Locked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Cycle Locked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_notes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_business_glossary_term' = 'Cycle Phase');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_value_regex' = 'statistical_forecast|demand_review|supply_review|pre_sop|executive_sop|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|rolling|event_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_consensus_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Consensus Achieved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Review Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_review_date` SET TAGS ('dbx_business_glossary_term' = 'Executive Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Executive S&OP Meeting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `frozen_period_months` SET TAGS ('dbx_business_glossary_term' = 'Frozen Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `key_risks` SET TAGS ('dbx_business_glossary_term' = 'Key Risks');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Months');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_month` SET TAGS ('dbx_business_glossary_term' = 'Planning Month');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `pre_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-S&OP Meeting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `pre_sop_review_date` SET TAGS ('dbx_business_glossary_term' = 'Pre Sop Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `statistical_forecast_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statistical Forecast Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_consensus_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Supply Consensus Achieved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_gap_volume` SET TAGS ('dbx_business_glossary_term' = 'Supply Gap Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Review Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `agreed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_value_regex' = 'over_forecast|under_forecast|neutral');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_code` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Planning Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `commercial_input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Input Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_status` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `constrained_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Demand Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `constraint_reason` SET TAGS ('dbx_business_glossary_term' = 'Constraint Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `customer_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Customer Commitment Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_value_regex' = 'base|promotional|seasonal|new_launch|phase_out|special_order');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_description` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Demand Volatility Index');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_volatility_index` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_volatility_index` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_description` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `finance_input_quantity` SET TAGS ('dbx_business_glossary_term' = 'Finance Input Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `forecast_accuracy_previous_period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Previous Period');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_name` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `new_product_launch_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `statistical_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `statistical_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `unconstrained_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unconstrained Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `variance_to_statistical` SET TAGS ('dbx_business_glossary_term' = 'Variance to Statistical Forecast');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
