-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 13:03:47

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`supply` COMMENT 'Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` (
    `demand_plan_id` BIGINT COMMENT 'Unique identifier for the demand plan record. Primary key representing a specific version-point in the S&OP/IBP cycle for a SKU/location/channel/planning period combination.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the sales channel (retail, e-commerce, wholesale, DTC) for which demand is planned.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this demand plan version in the S&OP governance workflow.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Demand planning aligns forecasts with ESG commitments; linking plan to commitment enables KPI tracking.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Integrated Demand Planning uses brand forecasts; brand_id links demand plan to specific brand for Brand Demand Forecast report.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Business process: New Product Demand Planning ties each demand_plan to the originating R&D project, enabling planners to align forecasts with product development timelines.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which demand is being planned.',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the S&OP/IBP planning cycle during which this demand plan version was created.',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution location, warehouse, or market geography for which demand is planned.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: REQUIRED: Account‑level demand forecast used in S&OP planning; planners need trade_account context for each demand_plan.',
    `approval_status` STRING COMMENT 'Current approval state of the demand plan version within the S&OP governance workflow.. Valid values are `draft|submitted|under_review|approved|rejected|locked`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was formally approved and locked for supply planning execution.',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand adjustment quantity applied by field sales teams based on customer intelligence, market conditions, and sales pipeline visibility.',
    `confidence_level` STRING COMMENT 'Planner-assigned confidence rating in the demand forecast based on data quality, market visibility, and forecast stability.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'Agreed demand forecast quantity representing the single demand signal passed to supply planning after S&OP consensus process. This is the authoritative demand plan.',
    `created_by_persona` STRING COMMENT 'Role or persona of the user who created this demand plan version, used for accountability and collaboration tracking.. Valid values are `demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for any monetary values associated with this demand plan (e.g., revenue forecasts).. Valid values are `^[A-Z]{3}$`',
    `demand_pattern_type` STRING COMMENT 'Classification of historical demand behavior pattern used to select appropriate statistical forecasting algorithm.. Valid values are `stable|seasonal|trending|intermittent|lumpy|erratic`',
    `demand_sensing_signal` STRING COMMENT 'Short-term demand trend indicator derived from real-time POS data, shipment data, and market signals to enable rapid forecast adjustments.. Valid values are `increasing|stable|decreasing|volatile`',
    `effective_from_date` DATE COMMENT 'Date from which this demand plan version becomes active and is used for supply planning and ATP calculations.',
    `effective_to_date` DATE COMMENT 'Date until which this demand plan version remains active. Null indicates the version is currently active with no planned expiration.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical forecast accuracy metric for this SKU/location/channel combination, used for forecast quality benchmarking and continuous improvement.',
    `forecast_bias_percentage` DECIMAL(18,2) COMMENT 'Systematic tendency to over-forecast or under-forecast, calculated as average percentage deviation from actual demand.',
    `is_consensus_version` BOOLEAN COMMENT 'Flag indicating whether this version represents the official consensus demand plan approved through the S&OP process and used for supply planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was last updated or adjusted.',
    `lifecycle_stage` STRING COMMENT 'Product lifecycle stage classification used to apply appropriate forecasting models and demand shaping strategies.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand quantity expected from planned marketing campaigns, promotions, and brand activation events.',
    `npd_launch_volume_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity for new product launches or product line extensions during the planning period.',
    `planner_notes` STRING COMMENT 'Free-text comments and annotations from demand planners explaining assumptions, adjustments, risks, or special considerations for this forecast.',
    `planning_bucket` STRING COMMENT 'Time granularity of the demand plan (daily, weekly, monthly, quarterly) used for aggregation and reporting.. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period (week or month) for which demand is forecasted.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period (week or month) for which demand is forecasted.',
    `promotional_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand uplift quantity attributed to trade promotions, price discounts, and retail execution activities.',
    `risk_category` STRING COMMENT 'Classification of the primary risk factor affecting demand plan reliability and supply fulfillment capability.. Valid values are `supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none`',
    `risk_flag` BOOLEAN COMMENT 'Indicator that this demand plan carries elevated supply risk due to capacity constraints, material shortages, or demand volatility.',
    `source_system_record_code` STRING COMMENT 'Original unique identifier of this demand plan record in the source system, used for data lineage and reconciliation.',
    `statistical_baseline_quantity` DECIMAL(18,2) COMMENT 'Unconstrained demand forecast quantity generated by statistical forecasting algorithms before any commercial overlays or adjustments.',
    `unit_of_measure` STRING COMMENT 'Unit in which demand quantities are expressed (each, case, pallet, kilogram, liter, etc.). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_to_baseline_quantity` DECIMAL(18,2) COMMENT 'Difference between consensus quantity and statistical baseline quantity, indicating the net impact of all commercial adjustments and overlays.',
    `version_name` STRING COMMENT 'Human-readable name of the demand plan version (e.g., Statistical Baseline Q1 2024, Consensus Final March 2024).',
    `version_sequence_number` STRING COMMENT 'Sequential version number within the planning cycle, used to track iteration history and version progression.',
    `version_type` STRING COMMENT 'Classification of the demand plan version indicating its stage in the S&OP process. Statistical baseline represents unconstrained forecast; consensus represents agreed demand signal passed to supply planning.. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay`',
    CONSTRAINT pk_demand_plan PRIMARY KEY(`demand_plan_id`)
) COMMENT 'Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the supply plan record. Primary key for the supply plan entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Production scheduling must align with marketing campaign launches; campaign_id enables Campaign‑Supply Execution dashboard.',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset. Business justification: Supply planning incorporates carbon offset purchases to meet carbon‑reduction goals; offset ID must be stored on each plan.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: CARRIER_ASSIGNMENT: Supply plan assigns a primary carrier for the planned shipments, required for cost and SLA calculations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation of each supply plan to a finance cost center for budgeting and variance analysis; planners routinely charge production plans to cost centers.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: A supply plan is derived from a specific demand plan; linking plan to demand_plan captures the parent‑child relationship and enables traceability of plan origins.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the distribution center or warehouse location for which this supply plan applies.',
    `employee_id` BIGINT COMMENT 'Reference to the supply planner or demand planner responsible for this supply plan.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: TRANSPORT_PLANNING: Supply plan defines the transportation lane for moving goods; planners need lane_id to generate accurate movement schedules.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where the SKU will be produced.',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: A supply plan is generated as part of a planning run; adding planning_run_id creates the proper parent link and allows removal of the redundant planning_run_code attribute.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: S&OP supply planning must align production/replenishment with upcoming promotion events to meet forecasted uplift.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Business process: Supply Planning for a new product requires linking each supply_plan to the rd_project that defines the product, ensuring capacity and material plans reflect R&D intent.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: Supply planning must avoid producing or allocating unregistered SKUs; registration link validates plan feasibility.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU for which this supply plan is created.',
    `supplier_id` BIGINT COMMENT 'Reference to the external supplier if the supply source is external procurement or contract manufacturing.',
    `network_node_id` BIGINT COMMENT 'Reference to the source location (plant or DC) if the supply source is a transfer from another internal location.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: REQUIRED: Store‑specific supply plan ties replenishment to the owning trade_account; essential for execution and KPI reporting.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that is available to promise to customers for delivery during the planning period, based on projected supply and committed demand.',
    `capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by production or distribution capacity limitations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply plan record was first created in the system.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU that can be promised to customers considering both current inventory and planned production capacity.',
    `demand_forecast_quantity` DECIMAL(18,2) COMMENT 'The forecasted demand quantity for this SKU at this location during the planning period, used as input to the supply planning process.',
    `execution_date` DATE COMMENT 'The date when this supply plan was executed or committed, triggering downstream production orders or purchase requisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply plan record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'The number of days required from order release to receipt, including production time, procurement time, or transfer time.',
    `material_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by raw material or component availability.',
    `notes` STRING COMMENT 'Free-text notes or comments from the supply planner regarding assumptions, constraints, or special considerations for this supply plan.',
    `plan_status` STRING COMMENT 'The current lifecycle status of the supply plan record indicating its approval and execution state.. Valid values are `draft|approved|committed|executed|archived`',
    `plan_type` STRING COMMENT 'Classification of the supply plan indicating whether it is constrained by capacity and material availability, unconstrained (infinite capacity), a scenario analysis, or a simulation.. Valid values are `constrained|unconstrained|scenario|simulation`',
    `planned_order_release_date` DATE COMMENT 'The date when the production order or purchase order should be released to meet the planned receipt date, accounting for lead times.',
    `planned_production_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be produced at the specified plant during the planning period.',
    `planned_receipt_date` DATE COMMENT 'The date when the planned supply quantity is expected to be received or available at the destination location.',
    `planned_replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be replenished or transferred to the distribution center during the planning period.',
    `planning_bucket` STRING COMMENT 'The time granularity or bucket size used for this supply plan (daily, weekly, monthly, or quarterly aggregation).. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_group` STRING COMMENT 'The organizational planning group or team responsible for managing supply planning for this SKU or location combination.',
    `planning_horizon_end_date` DATE COMMENT 'The end date of the planning horizon covered by this supply plan record.',
    `planning_horizon_start_date` DATE COMMENT 'The start date of the planning horizon covered by this supply plan record.',
    `projected_inventory_balance` DECIMAL(18,2) COMMENT 'The projected on-hand inventory balance at the end of the planning period after accounting for planned supply and demand.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The target safety stock quantity maintained as a buffer against demand variability and supply uncertainty for this SKU at this location.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A calculated risk score indicating the likelihood of supply disruption or shortage for this SKU at this location, based on supplier reliability, lead time variability, and demand volatility.',
    `supply_source` STRING COMMENT 'The source from which the supply will be obtained: internal production, external procurement from suppliers, transfer from another location, or contract manufacturing.. Valid values are `internal_production|external_procurement|transfer|contract_manufacturing`',
    `transportation_constraint_flag` BOOLEAN COMMENT 'Indicates whether the supply plan is constrained by transportation or logistics capacity limitations.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned quantities (e.g., cases, pallets, kilograms, liters).',
    `version` STRING COMMENT 'Version identifier for the supply plan, enabling tracking of plan iterations and scenario comparisons (e.g., baseline, consensus, committed).',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Core master entity representing the constrained and unconstrained supply plan for each SKU/plant/DC combination. Captures planned production quantities, planned replenishment orders, supply source, planning horizon, constraint flags, and IBP supply planning run metadata. Sourced from SAP IBP Supply Planning module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` (
    `forecast_version_id` BIGINT COMMENT 'Unique identifier for the forecast version record. Primary key.',
    `baseline_version_id` BIGINT COMMENT 'Reference to the parent or baseline forecast version from which this version was derived (e.g., statistical baseline that was then adjusted). Nullable for original baseline versions.',
    `demand_plan_id` BIGINT COMMENT 'add column demand_plan_id (BIGINT) with FK to supply.demand_plan.demand_plan_id - forecast versions are snapshots of demand plans and need that reference',
    `forecast_sop_cycle_id` BIGINT COMMENT 'Foreign key linking to supply.sop_cycle. Business justification: forecast_version needs to be linked to its planning cycle; added new FK sop_cycle_id referencing sop_cycle.sop_cycle_id. Existing planning_cycle_id column renamed to sop_cycle_id, so removed planning_',
    `employee_id` BIGINT COMMENT 'Reference to the user or persona who created this forecast version (e.g., demand planner, sales analyst, system batch job).',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the Sales and Operations Planning (S&OP) or Integrated Business Planning (IBP) cycle to which this forecast version belongs.',
    `tertiary_forecast_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this forecast version record.',
    `aggregation_level` STRING COMMENT 'The level of aggregation at which this forecast version is maintained: Stock Keeping Unit (SKU) level, product family, brand, category, sales channel, customer account, geographic region, or global total. [ENUM-REF-CANDIDATE: sku|product_family|brand|category|channel|customer|region|global — 8 candidates stripped; promote to reference product]',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approver during the approval process, documenting any conditions, concerns, or guidance related to this forecast version. Nullable if not yet approved or no notes provided.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was approved. Nullable if not yet approved.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was archived and moved out of active planning use. Nullable if not yet archived.',
    `bias_percentage` DECIMAL(18,2) COMMENT 'Forecast bias percentage indicating systematic over-forecasting (positive bias) or under-forecasting (negative bias). A value near zero indicates an unbiased forecast. Nullable if not yet calculated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary values associated with this forecast version (e.g., revenue forecasts). Nullable if forecast is purely volume-based.. Valid values are `^[A-Z]{3}$`',
    `demand_sensing_applied` BOOLEAN COMMENT 'Boolean flag indicating whether demand sensing algorithms (short-term forecast adjustments based on real-time Point of Sale (POS) data, shipment data, or other leading indicators) were applied to this forecast version.',
    `effective_from_date` DATE COMMENT 'The date from which this forecast version becomes effective and is used for operational planning, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `effective_to_date` DATE COMMENT 'The date until which this forecast version remains effective. Nullable for open-ended versions that remain active until superseded.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Calculated forecast accuracy percentage for this version, measured as the percentage of forecasted demand that matched actual demand. Used for benchmarking version performance and continuous improvement. Nullable if accuracy has not yet been calculated.',
    `forecast_source_system` STRING COMMENT 'Name or identifier of the source system or application that generated or contributed to this forecast version (e.g., SAP IBP, TradeEdge, Excel Upload, Salesforce CG Cloud).',
    `is_active_version` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast version is currently active and being used for planning and execution. Only one version per planning cycle should typically be active at a time.',
    `is_consensus_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version represents the consensus forecast agreed upon by cross-functional stakeholders (sales, marketing, supply chain, finance) during the S&OP process.',
    `is_final_approved_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version is the final approved forecast that will be used for operational execution, Material Requirements Planning (MRP), and Distribution Requirements Planning (DRP).',
    `mean_absolute_percentage_error` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error (MAPE) metric for this forecast version, measuring the average magnitude of forecast errors as a percentage. Lower values indicate better forecast accuracy. Nullable if not yet calculated.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was last modified.',
    `new_product_introduction_included` BOOLEAN COMMENT 'Boolean flag indicating whether New Product Development (NPD) or New Product Introduction (NPI) launches were incorporated into this forecast version.',
    `planning_horizon_end_date` DATE COMMENT 'The last date of the planning period covered by this forecast version (e.g., end of the fiscal quarter or rolling 18-month horizon).',
    `planning_horizon_start_date` DATE COMMENT 'The first date of the planning period covered by this forecast version (e.g., start of the fiscal quarter or month).',
    `promotional_events_included` BOOLEAN COMMENT 'Boolean flag indicating whether trade promotions, marketing campaigns, and promotional events were factored into this forecast version.',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided when this forecast version was rejected during the approval process. Nullable if version was not rejected.',
    `statistical_model_applied` STRING COMMENT 'Name or identifier of the statistical forecasting model or algorithm applied to generate or adjust this forecast version (e.g., Exponential Smoothing, ARIMA, Machine Learning Ensemble, Holt-Winters). Nullable if no statistical model was used.',
    `time_bucket` STRING COMMENT 'The time granularity or bucket size used for this forecast version: daily, weekly, monthly, quarterly, or annual periods.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which forecast quantities are expressed (e.g., EA for each, CS for case, KG for kilogram, L for liter). Aligns with GS1 standards.',
    `version_code` STRING COMMENT 'Short alphanumeric code or identifier for the forecast version used in system integrations and reporting (e.g., STAT_BASE, CONS_V1, FINAL_APR).',
    `version_description` STRING COMMENT 'Detailed textual description or notes about this forecast version, including assumptions, adjustments made, special considerations, or rationale for key changes.',
    `version_name` STRING COMMENT 'Human-readable name assigned to this forecast version (e.g., Statistical Baseline Q1 2024, Consensus Forecast March, Final Approved Version).',
    `version_sequence_number` STRING COMMENT 'Sequential number indicating the iteration or revision order of this forecast version within the planning cycle (e.g., 1 for first draft, 2 for first revision, 3 for consensus).',
    `version_status` STRING COMMENT 'Current lifecycle status of the forecast version: draft (under construction), in review (submitted for approval), approved (validated and accepted), rejected (not accepted), archived (historical record), or active (currently in use for planning).. Valid values are `draft|in_review|approved|rejected|archived|active`',
    `version_type` STRING COMMENT 'Classification of the forecast version indicating its role in the planning process: statistical baseline (system-generated), field sales overlay (sales team input), marketing adjusted (marketing promotions incorporated), consensus (collaborative agreement), final approved (executive sign-off), or simulation (what-if scenario).. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation`',
    CONSTRAINT pk_forecast_version PRIMARY KEY(`forecast_version_id`)
) COMMENT 'Tracks each named version or snapshot of the demand forecast within the IBP/S&OP cycle (e.g., statistical baseline, field sales overlay, marketing-adjusted, consensus, final approved). Captures version name, version type, planning cycle reference, created-by persona, approval status, and effective date range. Enables forecast accuracy benchmarking across versions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` (
    `forecast_accuracy_id` BIGINT COMMENT 'Unique identifier for the forecast accuracy measurement record. Primary key for this transactional measurement entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the demand planner responsible for the forecast for this SKU/location combination. Enables accountability tracking and planner performance analysis.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU for which forecast accuracy is being measured. Links to the product master data.',
    `network_node_id` BIGINT COMMENT 'Identifier of the planning location (distribution center, plant, or region) for which forecast accuracy is measured.',
    `absolute_percent_error` DECIMAL(18,2) COMMENT 'Absolute percentage error calculated as |Actual - Forecast| / Actual. Used as input for Mean Absolute Percentage Error (MAPE) aggregation.',
    `accuracy_status` STRING COMMENT 'Status indicating whether the measured forecast accuracy met, exceeded, or fell short of the target. Used for exception-based management and continuous improvement prioritization.. Valid values are `on_target|below_target|above_target|not_measured`',
    `accuracy_target_percent` DECIMAL(18,2) COMMENT 'The target forecast accuracy percentage established for this SKU/location/period combination. Used for performance benchmarking and KPI tracking.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'The actual demand quantity realized during the planning period. Sourced from shipments, sales orders, or Point of Sale (POS) data depending on the measurement level.',
    `bias_percent` DECIMAL(18,2) COMMENT 'Forecast bias expressed as a percentage: (Forecast - Actual) / Actual. Positive bias indicates systematic over-forecasting; negative bias indicates under-forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast accuracy record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0.0 to 1.0) representing the completeness and reliability of the input data used for accuracy calculation. Lower scores indicate missing or questionable data that may compromise measurement validity.',
    `demand_sensing_applied_flag` BOOLEAN COMMENT 'Boolean flag indicating whether demand sensing corrections were applied to the statistical forecast for this SKU/location/period. True if near-term demand signals were incorporated.',
    `demand_volatility_coefficient` DECIMAL(18,2) COMMENT 'Coefficient of variation representing demand volatility for the SKU/location combination. Calculated as standard deviation divided by mean demand. Higher values indicate more volatile demand patterns and typically correlate with lower forecast accuracy.',
    `forecast_error` DECIMAL(18,2) COMMENT 'The absolute difference between forecast quantity and actual quantity (Actual - Forecast). Positive values indicate under-forecast; negative values indicate over-forecast.',
    `forecast_model_type` STRING COMMENT 'The type of forecasting model used to generate the original forecast. Identifies whether the forecast was produced by statistical algorithms, machine learning models, consensus planning, manual planner input, or a hybrid approach.. Valid values are `statistical|machine_learning|consensus|manual|hybrid`',
    `forecast_quantity` DECIMAL(18,2) COMMENT 'The forecasted demand quantity for the SKU/location/period as predicted by the statistical model or demand planning system at the time of forecast creation.',
    `forecast_version` STRING COMMENT 'Version identifier of the forecast used for accuracy measurement. Enables tracking of accuracy across multiple forecast iterations and scenario planning versions within the Integrated Business Planning (IBP) cycle.',
    `mape` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error for the SKU/location/period. Primary forecast accuracy metric expressed as a percentage. Lower values indicate better accuracy.',
    `measurement_cycle` STRING COMMENT 'Identifier of the Sales and Operations Planning (S&OP) or Integrated Business Planning (IBP) cycle during which this accuracy measurement was performed. Typically formatted as YYYY-MM or cycle name.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast accuracy measurement was calculated and recorded. Represents the business event time of the accuracy calculation cycle close.',
    `new_product_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this SKU was classified as a new product during the forecast period. New Product Development (NPD) items typically have limited historical data and lower forecast accuracy.',
    `notes` STRING COMMENT 'Free-text notes capturing contextual information about the accuracy measurement, including explanations for significant variances, data quality issues, or special circumstances affecting the period.',
    `out_of_stock_days` STRING COMMENT 'Number of days during the planning period when the SKU was out of stock at the location. Out of Stock (OOS) events distort accuracy measurement as actual demand is constrained by availability.',
    `percent` DECIMAL(18,2) COMMENT 'Forecast accuracy percentage calculated as 100% - MAPE. Represents the complement of error, where higher values indicate better accuracy. Commonly used for executive reporting.',
    `planning_level` STRING COMMENT 'The hierarchical level at which forecast accuracy is being measured. Supports accuracy tracking at SKU/location, product family, brand, category, or total company aggregation levels.. Valid values are `sku_location|product_family|brand|category|total_company`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period for which forecast accuracy is being measured.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period for which forecast accuracy is being measured. Typically aligned with S&OP cycle boundaries.',
    `product_lifecycle_stage` STRING COMMENT 'The lifecycle stage of the SKU at the time of forecast measurement. Accuracy expectations and benchmarks vary by lifecycle stage, with new product introductions (NPD) typically having lower accuracy than mature products.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `promotional_period_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the planning period included promotional activity for this SKU/location. Promotional periods typically exhibit different accuracy patterns than baseline demand periods.',
    `sensed_quantity` DECIMAL(18,2) COMMENT 'The demand-sensed quantity after incorporating near-term signals such as Point of Sale (POS) data, syndicated market data from Nielsen IQ, or secondary sales from TradeEdge. Null if demand sensing was not applied.',
    `sensing_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0 to 1.0) representing the reliability of the demand sensing signal. Higher scores indicate stronger signal quality and greater confidence in the sensed adjustment.',
    `sensing_horizon_days` STRING COMMENT 'The number of days into the future for which demand sensing was applied. Typically ranges from 7 to 90 days depending on product velocity and signal availability.',
    `sensing_signal_source` STRING COMMENT 'The primary data source used for demand sensing correction. Identifies whether the signal came from Point of Sale (POS) data, Nielsen IQ syndicated feeds, TradeEdge secondary sales, shipment actuals, order backlog, promotional lift models, or manual planner override. [ENUM-REF-CANDIDATE: pos_data|nielsen_iq|trade_edge|shipment_data|order_backlog|promotional_lift|manual_override — 7 candidates stripped; promote to reference product]',
    `sensing_uplift_percent` DECIMAL(18,2) COMMENT 'Percentage uplift or downlift applied by demand sensing relative to the statistical forecast. Calculated as (Sensed Quantity - Forecast Quantity) / Forecast Quantity. Positive values indicate uplift; negative values indicate downlift.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which forecast and actual quantities are expressed (e.g., cases, eaches, kilograms, liters). Must be consistent across forecast and actual for valid accuracy calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast accuracy record was last modified. Supports change tracking and audit requirements.',
    `wmape` DECIMAL(18,2) COMMENT 'Weighted Mean Absolute Percentage Error, calculated as sum of absolute errors divided by sum of actuals. Preferred metric for aggregated accuracy measurement across product hierarchies.',
    CONSTRAINT pk_forecast_accuracy PRIMARY KEY(`forecast_accuracy_id`)
) COMMENT 'Transactional record capturing forecast accuracy measurements and demand sensing corrections for each SKU/location/planning period. Stores accuracy metrics (MAPE, WMAPE, bias, FA%, forecast error), actuals vs forecast volumes, measurement period, benchmark targets, and near-term demand sensing signals (POS data, syndicated feeds from Nielsen IQ, TradeEdge secondary sales). Captures signal source, sensing horizon, sensed quantity, confidence score, and uplift/downlift versus statistical forecast. Supports both cycle-close accuracy measurement and short-horizon demand correction within SAP IBP. Enables continuous improvement of statistical models and demand sensing algorithms.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` (
    `inventory_policy_id` BIGINT COMMENT 'Unique identifier for the inventory policy record. Primary key for this entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inventory policies are driven by specific compliance obligations (e.g., temperature control); linking ties policy to obligation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory policies are owned by specific cost centers; linking enables policy‑related budgeting and compliance audits.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Inventory Policy Governance requires a policy owner employee to approve and maintain each policy.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Business need: Inventory policies for launch items are derived from the associated R&D project, allowing policy parameters to be set per project.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this inventory policy is defined.',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution facility, warehouse, or storage location node in the supply network where this policy applies.',
    `approval_date` DATE COMMENT 'Date when this inventory policy was formally approved and authorized for use in supply planning and execution.',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the policy has been reviewed and approved by authorized supply planning personnel.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by_name` STRING COMMENT 'Name of the supply planning manager or director who approved this inventory policy for operational use.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was first created in the system.',
    `customer_otif_commitment_percent` DECIMAL(18,2) COMMENT 'Specific OTIF performance level committed to a customer or channel, which may differ from internal targets and may be contractually binding.',
    `cycle_stock_target_units` DECIMAL(18,2) COMMENT 'Target cycle stock quantity representing the average inventory held to meet expected demand between replenishments, excluding safety stock.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability (coefficient of variation or standard deviation) used in safety stock calculations.',
    `effective_end_date` DATE COMMENT 'Date on which this inventory policy expires or is superseded. Null indicates an open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date from which this inventory policy becomes active and applicable for planning and execution.',
    `fill_rate_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of customer demand that should be fulfilled from available inventory without backorders or stockouts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this inventory policy was last reviewed and validated by the supply planning team.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Standard deviation or variance of replenishment lead time in days, used to account for supply uncertainty in safety stock calculations.',
    `maximum_stock_level_units` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at this location for this SKU, used to prevent overstocking and manage warehouse capacity constraints.',
    `measurement_window_days` STRING COMMENT 'Time period in days over which service level performance is measured and evaluated against targets (e.g., rolling 30 days, 90 days, quarterly).',
    `minimum_stock_level_units` DECIMAL(18,2) COMMENT 'Minimum inventory level that should be maintained at this location for this SKU, typically aligned with safety stock or regulatory requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of this inventory policy, ensuring policies remain aligned with business conditions.',
    `on_time_delivery_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of orders that should be delivered by the customer-requested or committed delivery date.',
    `otif_composite_target_percent` DECIMAL(18,2) COMMENT 'Composite OTIF (On Time In Full) target percentage representing orders delivered both on time and in full quantity, a critical customer service metric.',
    `penalty_clause_indicator` BOOLEAN COMMENT 'Indicates whether failure to meet the defined service level targets will result in financial penalties, chargebacks, or other contractual consequences.',
    `policy_code` STRING COMMENT 'Business identifier code for the inventory policy, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_notes` STRING COMMENT 'Free-text notes capturing special considerations, exceptions, seasonal adjustments, or business context relevant to this inventory policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the inventory policy indicating its approval and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|archived — 7 candidates stripped; promote to reference product]',
    `reorder_point_units` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered, calculated as lead time demand plus safety stock.',
    `replenishment_method` STRING COMMENT 'The inventory replenishment strategy applied: MRP (Material Requirements Planning), DRP (Distribution Requirements Planning), VMI (Vendor Managed Inventory), JIT (Just In Time), Kanban, or Fixed Order Quantity.. Valid values are `MRP|DRP|VMI|JIT|kanban|fixed_order_quantity`',
    `retailer_mandated_target_flag` BOOLEAN COMMENT 'Indicates whether the service level targets are mandated by a retail customer as part of their supplier requirements or vendor compliance program.',
    `review_cycle_days` STRING COMMENT 'Frequency in days at which inventory levels are reviewed and replenishment decisions are made for this SKU-location combination.',
    `safety_stock_calculated_units` DECIMAL(18,2) COMMENT 'System-calculated safety stock quantity based on demand variability, lead time variability, and service level inputs before manual approval or adjustment.',
    `safety_stock_calculation_method` STRING COMMENT 'The methodology used to calculate safety stock: fixed value, forecast error-based, demand variability, lead time variability, combined variability, or service level-driven calculation.. Valid values are `fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven`',
    `safety_stock_days_of_supply` DECIMAL(18,2) COMMENT 'Safety stock expressed as the number of days of average demand coverage, providing a time-based view of inventory buffer.',
    `safety_stock_target_units` DECIMAL(18,2) COMMENT 'Target safety stock quantity in base units of measure, representing the buffer inventory to protect against demand and supply variability.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage (e.g., 95%, 98%, 99.5%) representing the desired probability of not stocking out during the replenishment lead time.',
    CONSTRAINT pk_inventory_policy PRIMARY KEY(`inventory_policy_id`)
) COMMENT 'Master entity defining inventory policy parameters, safety stock calculations, service level commitments, and OTIF targets for each SKU/location node in the supply network. Captures safety stock target and calculated quantities (days of supply, units, calculation method, demand variability, lead time variability, service level input, calculated vs approved SS units, effective date, review status), reorder point, min/max levels, cycle stock target, replenishment method (MRP/DRP/VMI), review cycle, service level targets (fill rate %, on-time delivery %, OTIF composite %), customer/channel-level OTIF commitments, retailer-mandated target flags, penalty clause indicators, and measurement windows. Owned by supply planning; consumed by distribution and manufacturing execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` (
    `safety_stock_id` BIGINT COMMENT 'Unique identifier for the safety stock calculation record. Primary key for the safety stock entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Safety‑stock calculations must respect compliance constraints such as shelf‑life limits; link provides required obligation data.',
    `employee_id` BIGINT COMMENT 'Reference to the demand planner or supply planner responsible for reviewing and approving this safety stock calculation. Links to workforce or user master data.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU for which safety stock is calculated. Links to the product master data.',
    `network_node_id` BIGINT COMMENT 'Reference to the storage location, distribution center, or facility where the safety stock applies. Links to distribution facility master data.',
    `abc_classification` STRING COMMENT 'The ABC classification of the SKU based on revenue contribution or volume. A items are high-value requiring tight control; B items are moderate; C items are low-value. Influences service level targets and safety stock investment decisions.. Valid values are `A|B|C`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was approved by the planner. Marks the transition from calculated to approved state in the workflow.',
    `approved_safety_stock_units` DECIMAL(18,2) COMMENT 'The final approved safety stock quantity in base units of measure after planner review and adjustment. This is the target value used for inventory policy execution and Available to Promise (ATP) calculations.',
    `average_daily_demand_units` DECIMAL(18,2) COMMENT 'The mean daily demand quantity in base units of measure. Used as input to safety stock calculations and represents expected consumption rate.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'The mean replenishment lead time in days from order placement to receipt. Used in safety stock calculations to determine the exposure period for demand and supply variability.',
    `calculated_safety_stock_units` DECIMAL(18,2) COMMENT 'The system-calculated safety stock quantity in base units of measure. This is the raw output from the calculation engine before any manual adjustments or approvals.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Statistical methods use demand and lead time variability; days-of-supply uses fixed coverage targets; manual override represents planner judgment; service level and lead time methods focus on specific risk factors; hybrid combines multiple approaches.. Valid values are `statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was executed by the planning system. Provides audit trail for calculation runs and version control.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `days_of_supply_target` DECIMAL(18,2) COMMENT 'The target safety stock coverage expressed in days of average demand. Used when calculation method is days-of-supply based. Represents the buffer duration to protect against stockouts.',
    `demand_classification` STRING COMMENT 'The demand pattern category for this SKU-location. Steady indicates consistent demand; seasonal shows periodic peaks; erratic has high variability; lumpy has infrequent large orders; intermittent has sporadic demand; obsolete indicates phase-out. Influences calculation method selection.. Valid values are `steady|seasonal|erratic|lumpy|intermittent|obsolete`',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility expressed as coefficient of variation or standard deviation. Used in statistical safety stock calculations to quantify demand uncertainty.',
    `effective_date` DATE COMMENT 'The date when this safety stock target becomes active and is used for inventory policy execution, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `expiration_date` DATE COMMENT 'The date when this safety stock target expires and is replaced by a new calculation. Used to manage the lifecycle of safety stock policies and trigger recalculation cycles.',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'The historical forecast accuracy for this SKU-location combination expressed as a percentage. Used to adjust safety stock calculations based on forecasting reliability. Lower accuracy typically requires higher safety stock.',
    `holding_cost_per_unit` DECIMAL(18,2) COMMENT 'The annual cost to hold one unit of inventory including warehousing, insurance, obsolescence, and capital cost. Used in inventory optimization to balance service level against carrying cost. Expressed in local currency.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this safety stock record is currently active and being used for inventory policy execution. True means active; False means superseded or inactive.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock record was last reviewed by a planner, regardless of whether changes were made. Used to track planner engagement and ensure regular review cycles.',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Measure of supply lead time uncertainty expressed in days. Represents the standard deviation or range of lead time fluctuation used in safety stock calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity constraint from the supplier or manufacturing process. Safety stock calculations must consider MOQ to ensure replenishment orders are feasible.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was last modified. Updated whenever any field changes. Supports change tracking and audit requirements.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next safety stock review cycle. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) processes to ensure regular policy updates.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The order quantity increment or lot size multiple required by supplier or production constraints. Safety stock and reorder quantities must align with this multiple.',
    `override_notes` STRING COMMENT 'Free-text explanation provided by the planner when manually overriding the calculated safety stock. Documents the business context and rationale for the adjustment.',
    `override_reason_code` STRING COMMENT 'The business reason code when approved safety stock differs from calculated safety stock. Captures planner judgment factors such as promotional events, seasonal peaks, supply chain risks, new product introductions, product phase-outs, or quality concerns.. Valid values are `promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue`',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period for which this safety stock calculation is effective. Defines the validity window for the safety stock target.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period for which this safety stock calculation is effective. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) cycles.',
    `review_status` STRING COMMENT 'The approval workflow status of the safety stock calculation. Pending review indicates awaiting planner action; approved means active for execution; rejected requires recalculation; under revision is being adjusted; expired indicates the planning period has passed.. Valid values are `pending_review|approved|rejected|under_revision|expired`',
    `shelf_life_days` STRING COMMENT 'The shelf life or expiration period of the product in days. Critical for Fast-Moving Consumer Goods (FMCG) and Consumer Packaged Goods (CPG) safety stock decisions to prevent obsolescence. Influences maximum safety stock levels and First Expired First Out (FEFO) policies.',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated cost of a stockout per unit including lost sales, expediting costs, customer dissatisfaction, and brand impact. Used in service level optimization to quantify the cost of Out of Stock (OOS) events. Expressed in local currency.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A quantitative risk score assessing supply chain vulnerability for this SKU-location. Higher scores indicate greater risk from supplier reliability, geopolitical factors, transportation disruptions, or single-source dependencies. Used to adjust safety stock buffers.',
    `target_service_level_percent` DECIMAL(18,2) COMMENT 'The desired in-stock probability or fill rate target expressed as a percentage (e.g., 95.00, 98.50). Drives the safety stock buffer size to achieve the specified On Shelf Availability (OSA) or Service Level Agreement (SLA).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for safety stock quantities. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon. Must align with SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `xyz_classification` STRING COMMENT 'The XYZ classification based on demand variability. X items have low variability (predictable); Y items have moderate variability; Z items have high variability (unpredictable). Used alongside ABC to determine safety stock strategy.. Valid values are `X|Y|Z`',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution value corresponding to the target service level. Used in statistical safety stock formulas to translate service level percentage into buffer quantity.',
    CONSTRAINT pk_safety_stock PRIMARY KEY(`safety_stock_id`)
) COMMENT 'Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` (
    `supply_replenishment_order_id` BIGINT COMMENT 'Unique identifier for the supply replenishment order record. Primary key for this entity.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: CONTRACT_COMPLIANCE: Each replenishment order is governed by a carrier contract; needed for rate and penalty enforcement.',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or transportation provider assigned to execute this replenishment shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders incur expenses that must be tracked against the responsible cost center for expense reporting and internal charge‑backs.',
    `network_node_id` BIGINT COMMENT 'Identifier of the supply network node to which inventory will be delivered (distribution center, warehouse, or retail location).',
    `drp_run_id` BIGINT COMMENT 'Identifier of the DRP execution run that generated this replenishment order, used for traceability and audit.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Regulatory traceability requires linking each replenishment order to its inspection lot for recall and safety reporting; experts expect this FK for product safety audits.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: ORDER_EXECUTION: Replenishment order execution follows a specific lane; lane_id links order to transportation routing.',
    `logistics_shipment_id` BIGINT COMMENT 'Identifier of the physical shipment record associated with this replenishment order once released for execution.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created this replenishment order record.',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the supply network node from which inventory will be shipped (plant, distribution center, or warehouse).',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: Replenishment orders are often generated to satisfy demand generated by a specific promotion event.',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being replenished through this order.',
    `actual_receipt_date` DATE COMMENT 'Actual date the goods were received at the destination location.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location.',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'ATP quantity at the source location at the time the replenishment order was created, used to validate supply availability.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the replenishment order was cancelled, if applicable.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU confirmed for shipment by the source location, may differ from requested quantity due to supply constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `drp_run_timestamp` TIMESTAMP COMMENT 'Date and time when the DRP execution run that generated this order was executed.',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity at the destination location that drove the replenishment calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was last modified in the system.',
    `order_cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with this replenishment order, including product cost, transportation cost, and handling fees.',
    `order_notes` STRING COMMENT 'Free-text notes or special instructions related to this replenishment order, such as handling requirements or routing constraints.',
    `order_status` STRING COMMENT 'Current execution status of the replenishment order in the supply chain workflow.. Valid values are `draft|open|in_transit|received|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the replenishment order lifecycle stage: planned (system-generated recommendation), firmed (manually confirmed but not released), or released (committed for execution).. Valid values are `planned|firmed|released`',
    `planned_receipt_date` DATE COMMENT 'Target date for goods receipt at the destination location, accounting for transit lead time.',
    `planned_ship_date` DATE COMMENT 'Target date for shipment departure from the source location as calculated by the DRP engine.',
    `priority_code` STRING COMMENT 'Priority classification for order fulfillment, typically driven by stock-out risk, customer service level, or strategic importance.. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU received at the destination location, captured at goods receipt.',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique order number for the replenishment order, used for tracking and reference across systems and communications.. Valid values are `^REP-[0-9]{10}$`',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment as calculated by the DRP engine or demand planner.',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below safety stock threshold at the destination location.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU shipped from the source location, captured at dispatch.',
    `transit_lead_time_days` STRING COMMENT 'Planned number of days for goods to travel from source to destination location.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation planned or used for this replenishment shipment.. Valid values are `truck|rail|air|ocean|intermodal`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this order (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supply_replenishment_order PRIMARY KEY(`supply_replenishment_order_id`)
) COMMENT 'Transactional record representing a planned or released replenishment order generated by DRP execution for moving inventory between supply network nodes (plant-to-DC, DC-to-DC). Captures order type (planned/firmed/released), source location, destination location, SKU, requested quantity, confirmed quantity, planned ship date, planned receipt date, and DRP run reference. Distinct from purchase orders (owned by procurement) and production orders (owned by manufacturing).';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating costs of each network node (warehouse, DC) are allocated to a cost center for overhead accounting and performance tracking.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Required for Logistics Network Planning report to map each supply network node to its physical distribution center, enabling accurate cross‑dock and VMI planning.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: ESG reporting per network node requires linking node to its ESG commitment; planners need node‑level targets for compliance.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Node location must comply with jurisdictional regulations (e.g., hazardous material storage); linking enforces local compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Node Operations Management Dashboard tracks the manager responsible for each warehouse/distribution node.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Required for Cost Allocation Report: each network node is assigned to an org unit for budgeting and performance reporting.',
    `address_line_1` STRING COMMENT 'Primary street address line for the supply network node location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line (suite, building, floor) for the supply network node location. Organizational contact data classified as confidential.',
    `capacity_class` STRING COMMENT 'Classification of the supply network node storage and throughput capacity used in IBP supply planning for capacity-constrained optimization.. Valid values are `small|medium|large|extra_large|mega`',
    `city` STRING COMMENT 'City where the supply network node is located. Used for geographic analysis and transportation planning. Organizational contact data classified as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was first created in the system. Used for audit trail and data lineage.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports cross-docking operations (direct transfer without storage). Used in transportation and distribution planning.',
    `dsd_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports Direct Store Delivery operations. Used in distribution planning and route optimization.',
    `effective_end_date` DATE COMMENT 'Date when this supply network node was decommissioned or removed from the active supply network. Null for currently active nodes.',
    `effective_start_date` DATE COMMENT 'Date when this supply network node became operational and active in the supply network. Used for historical network analysis and planning.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the physical location of the supply network node for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this supply network node is certified to handle and store hazardous materials. Used for product allocation and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was last updated. Used for change tracking and data synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from this supply network node to downstream nodes or customers. Used in DRP execution and ATP/CTP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `node_code` STRING COMMENT 'Business identifier code for the supply network node used across planning and execution systems. Typically a short alphanumeric code used in SAP IBP and ERP systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `node_name` STRING COMMENT 'Human-readable name of the supply network node (e.g., Chicago Regional DC, Memphis Manufacturing Plant, Dallas Forward DC).',
    `node_status` STRING COMMENT 'Current operational status of the supply network node in the supply planning system. Active nodes participate in DRP and IBP planning runs.. Valid values are `active|inactive|planned|decommissioned|temporarily_closed`',
    `node_type` STRING COMMENT 'Classification of the supply network node indicating its role in the supply chain (manufacturing plant, regional distribution center, forward distribution center, co-manufacturer, third-party logistics warehouse, cross-dock facility, or supplier location). [ENUM-REF-CANDIDATE: manufacturing_plant|regional_dc|forward_dc|co_manufacturer|3pl_warehouse|cross_dock|supplier_location — 7 candidates stripped; promote to reference product]',
    `ownership_type` STRING COMMENT 'Ownership model of the supply network node (company-owned, leased, third-party logistics managed, co-manufacturer, or contract facility). Used for cost allocation and strategic network design.. Valid values are `owned|leased|3pl_managed|co_manufacturer|contract`',
    `planning_group` STRING COMMENT 'Planning group or cluster assignment for the supply network node used in IBP and S&OP processes to aggregate nodes for planning purposes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supply network node location. Used for logistics routing and delivery planning. Organizational contact data classified as confidential.',
    `replenishment_frequency` STRING COMMENT 'Standard replenishment frequency for inventory at this supply network node. Used in DRP planning and inventory policy definition.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `safety_stock_days` STRING COMMENT 'Target safety stock coverage in days of supply maintained at this network node. Used in inventory optimization and S&OP planning.',
    `sourcing_priority` STRING COMMENT 'Priority ranking of this supply network node in sourcing rules and allocation logic (lower number = higher priority). Used in IBP supply planning and ATP/CTP allocation.',
    `state_province` STRING COMMENT 'State or province code where the supply network node is located. Used for tax jurisdiction and regulatory compliance. Organizational contact data classified as confidential.',
    `storage_capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the supply network node measured in standard storage units (pallets, cases, or cubic meters). Used for inventory optimization and DRP planning.',
    `storage_capacity_uom` STRING COMMENT 'Unit of measure for the storage capacity (pallets, cases, cubic meters, square meters). Aligns with WMS and IBP planning units.. Valid values are `pallets|cases|cubic_meters|square_meters`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node has temperature-controlled storage capabilities for temperature-sensitive products. Used in product allocation and quality management.',
    `throughput_capacity_daily` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the supply network node measured in standard units (cases, pallets, or production units per day). Used for production and distribution planning.',
    `throughput_capacity_uom` STRING COMMENT 'Unit of measure for the daily throughput capacity. Used in production scheduling and distribution planning.. Valid values are `cases_per_day|pallets_per_day|units_per_day|tons_per_day`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supply network node location (e.g., America/Chicago, America/New_York). Used for scheduling and ATP/CTP calculations.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node participates in Vendor Managed Inventory programs. Used in collaborative planning and replenishment processes.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` (
    `network_lane_id` BIGINT COMMENT 'Primary key for network_lane',
    `carrier_id` BIGINT COMMENT 'Identifier of the preferred or contracted transportation carrier servicing this lane. Used for freight planning and cost estimation.',
    `network_node_id` BIGINT COMMENT 'Identifier of the receiving supply network node (distribution center, warehouse, retail store, or customer location) to which goods are delivered.',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the originating supply network node (plant, distribution center, warehouse, or external supplier) from which goods are sourced.',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of this lane per planning period (day, week, month), representing the upper limit of goods that can be moved. Used by Supply Planning and Sales and Operations Planning (S&OP) for capacity-constrained optimization.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity quantity field, indicating how lane capacity is measured and constrained. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `compliance_requirements` STRING COMMENT 'Regulatory or business compliance requirements applicable to this lane, such as temperature control (Good Manufacturing Practice - GMP), hazardous materials handling (Environmental Protection Agency - EPA), or cross-border customs (Food and Drug Administration - FDA).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard transportation or transfer cost per unit of measure for moving goods along this lane. Used for supply chain cost modeling and total landed cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and pricing on this lane (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this supply network lane ceases or will cease to be effective. Null for lanes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this supply network lane becomes or became effective and available for use in planning and execution systems.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is currently active and available for use in supply planning and replenishment. True if active; false if temporarily or permanently disabled.',
    `is_primary_lane` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is the primary (preferred) sourcing route for the destination. True if this is the default lane used under normal conditions; false for backup or secondary lanes.',
    `lane_code` STRING COMMENT 'Business identifier for the supply network lane, typically a concatenation or encoded representation of source-destination pair used in planning systems and operational communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lane_name` STRING COMMENT 'Human-readable descriptive name for the supply network lane, often including source and destination location names for easy identification in reports and dashboards.',
    `lane_type` STRING COMMENT 'Classification of the supply network lane based on the nature of the sourcing relationship: production (from manufacturing plant), transfer (between internal facilities), external procurement (from supplier), direct shipment (plant to customer), cross-dock (no storage), or drop-ship (supplier to customer).. Valid values are `production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship`',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this supply network lane record, used for audit trail and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was most recently updated, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard batch or lot size for replenishment orders on this lane. Orders are typically rounded to multiples of this quantity for operational efficiency (e.g., full pallet, full truckload).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or shipped on this lane in a single replenishment cycle, constrained by capacity, vehicle limits, or storage restrictions.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or shipped on this lane to meet operational or economic constraints. Used by DRP to ensure replenishment orders meet minimum thresholds.',
    `network_lane_status` STRING COMMENT 'Current lifecycle status of the supply network lane: active (operational), inactive (temporarily disabled), suspended (on hold), planned (future activation), or decommissioned (permanently closed).. Valid values are `active|inactive|suspended|planned|decommissioned`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or contextual information about this supply network lane.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Specific target percentage for On Time In Full delivery performance on this lane, a key supply chain Key Performance Indicator (KPI) measuring the percentage of orders delivered on time and complete.',
    `planning_group` STRING COMMENT 'Organizational grouping or planning segment to which this lane belongs, used for segmented planning and reporting in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `processing_lead_time_days` DECIMAL(18,2) COMMENT 'Time in days required for order processing, picking, packing, and loading at the source location before shipment begins.',
    `risk_category` STRING COMMENT 'Supply risk classification for this lane based on factors such as lead time variability, carrier reliability, geopolitical risk, and single-source dependency. Used for supply risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `safety_stock_days` DECIMAL(18,2) COMMENT 'Number of days of safety stock coverage recommended at the destination to buffer against variability in this lanes lead time and demand. Used by Inventory Optimization to calculate safety stock targets.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Target service level percentage for on-time and in-full delivery performance on this lane, expressed as a percentage (e.g., 95.00 for 95%). Used to measure On Time In Full (OTIF) performance.',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order for this lane when multiple sourcing options exist for the same destination. Lower numbers indicate higher priority (1 = primary, 2 = secondary, etc.). Used by Distribution Requirements Planning (DRP) and Integrated Business Planning (IBP) to determine replenishment routing.',
    `standard_lead_time_days` DECIMAL(18,2) COMMENT 'Total planned lead time in days from order placement to goods receipt at destination, including processing time, transportation time, and buffer. Used by Material Requirements Planning (MRP) and Distribution Requirements Planning (DRP) for replenishment calculations.',
    `transportation_lead_time_days` DECIMAL(18,2) COMMENT 'Transit time in days for goods to move from source to destination, excluding processing and handling time. Component of the total standard lead time.',
    `transportation_mode` STRING COMMENT 'Primary method of transportation used for moving goods along this lane: truck (road freight), rail (train), ocean (sea freight), air (air cargo), intermodal (combination), or parcel (small package delivery).. Valid values are `truck|rail|ocean|air|intermodal|parcel`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this lane: EA (each), CS (case), PL (pallet), TU (truck unit), KG (kilogram), LB (pound), L (liter), GAL (gallon). Aligns with GS1 standards. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_network_lane PRIMARY KEY(`network_lane_id`)
) COMMENT 'Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` (
    `atp_record_id` BIGINT COMMENT 'Primary key for atp_record',
    `atp_rule_id` BIGINT COMMENT 'Identifier for the specific ATP business rule or configuration applied during calculation, enabling traceability of ATP logic.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch for lot-controlled SKUs where ATP is tracked at the batch level.',
    `regulatory_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.registration. Business justification: ATP calculations need to confirm inventory belongs to registered products to meet legal availability commitments.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which ATP is calculated.',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution facility or warehouse location where ATP is calculated.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity already committed or reserved for existing sales orders, reducing available ATP.',
    `atp_calculation_method` STRING COMMENT 'The method used to calculate ATP. Simple ATP considers only on-hand inventory minus allocations. Cumulative ATP includes planned receipts over time. Multi-level ATP considers BOM components. Product allocation ATP applies allocation rules across customer segments.. Valid values are `simple|cumulative|multi_level|product_allocation`',
    `atp_check_horizon_days` STRING COMMENT 'The number of days into the future that the ATP check considers for availability. Defines the planning horizon for promise calculations.',
    `atp_confirmation_number` STRING COMMENT 'Unique confirmation number generated when ATP is reserved for a sales order, providing traceability between ATP records and order promising.',
    `atp_date` DATE COMMENT 'The date for which ATP quantity is calculated. Represents the promise date for order fulfillment.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The confirmed quantity available to promise to customers for the given SKU, location, and date. Represents uncommitted inventory available for new orders.',
    `atp_status` STRING COMMENT 'The current status of the ATP record. Available indicates positive ATP. Constrained indicates limited availability. Blocked indicates ATP is not available for promising. Expired indicates the ATP date has passed.. Valid values are `available|constrained|blocked|expired`',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The quantity of unfulfilled demand from previous periods that impacts current ATP availability.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this ATP record was calculated. Critical for understanding data freshness and order promising accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was first created in the lakehouse silver layer.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity that can be promised considering both current inventory and planned production or supply receipts. Extends ATP by including future supply.',
    `cumulative_atp_quantity` DECIMAL(18,2) COMMENT 'The cumulative ATP quantity calculated across multiple time periods, showing total available quantity from current date through the ATP date.',
    `customer_priority_tier` STRING COMMENT 'The priority tier of the customer or channel for which ATP is being calculated, used in allocation scenarios where high-priority customers receive preferential ATP.. Valid values are `tier_1|tier_2|tier_3|standard`',
    `demand_pegging_reference` STRING COMMENT 'Reference identifier linking ATP consumption to specific demand sources such as sales orders, forecasts, or customer reservations.',
    `expiration_date` DATE COMMENT 'The expiration date of the inventory lot or batch, relevant for FEFO (First Expired First Out) ATP logic in consumer goods with shelf life constraints.',
    `forecast_consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of forecast demand consumed by actual sales orders, used in ATP calculations to avoid double-counting demand.',
    `intransit_quantity` DECIMAL(18,2) COMMENT 'The quantity currently in transit to the location that will contribute to ATP upon arrival.',
    `minimum_shelf_life_days` STRING COMMENT 'The minimum remaining shelf life in days required for the product to be available for promising, ensuring customers receive products with adequate shelf life.',
    `on_hand_inventory` DECIMAL(18,2) COMMENT 'The physical inventory quantity available at the location at the time of ATP calculation.',
    `planned_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity expected to be received from production orders, purchase orders, or transfers by the ATP date.',
    `planning_version` STRING COMMENT 'The planning scenario or version identifier in SAP IBP under which this ATP calculation was performed, enabling what-if analysis and scenario planning.',
    `product_allocation_group` STRING COMMENT 'The allocation group or priority segment assigned to this ATP calculation, used when ATP is allocated across customer tiers or channels.',
    `production_order_quantity` DECIMAL(18,2) COMMENT 'The quantity scheduled for production that will be available by the ATP date.',
    `purchase_order_quantity` DECIMAL(18,2) COMMENT 'The quantity on open purchase orders expected to be received by the ATP date.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The minimum inventory buffer maintained to protect against demand variability and supply uncertainty. May reduce ATP if policy enforces safety stock protection.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this ATP record in the source operational system, enabling traceability and reconciliation.',
    `supply_pegging_reference` STRING COMMENT 'Reference identifier linking ATP availability to specific supply sources such as production orders, purchase orders, or stock transfers.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields in this record. Common values: EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was last updated in the lakehouse silver layer.',
    CONSTRAINT pk_atp_record PRIMARY KEY(`atp_record_id`)
) COMMENT 'Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` (
    `sop_cycle_id` BIGINT COMMENT 'Unique identifier for the S&OP/IBP planning cycle instance. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for orchestrating and governing this S&OP cycle (typically the Demand Planning Manager or S&OP Manager).',
    `tertiary_quinary_sop_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this S&OP cycle record.',
    `tertiary_sop_supply_planner_employee_id` BIGINT COMMENT 'Identifier of the lead supply planner responsible for the supply review phase of this cycle.',
    `baseline_demand_volume` DECIMAL(18,2) COMMENT 'The total baseline demand volume (in units) across all SKUs for the planning horizon at the start of this cycle.',
    `consensus_demand_volume` DECIMAL(18,2) COMMENT 'The total consensus demand volume (in units) across all SKUs after demand review adjustments.',
    `constrained_supply_volume` DECIMAL(18,2) COMMENT 'The total constrained supply volume (in units) that can be delivered given capacity and material constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this S&OP cycle record was first created in the system.',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the cycle for external reference and system integration (e.g., SOP-2024-01, IBP-Q1-24).',
    `cycle_end_date` DATE COMMENT 'The date when this S&OP cycle is scheduled to complete and be locked (typically before the start of the planning month).',
    `cycle_locked_date` DATE COMMENT 'The date when this S&OP cycle was locked and finalized.',
    `cycle_locked_flag` BOOLEAN COMMENT 'Indicates whether this S&OP cycle has been locked and no further changes are permitted (True if locked, False if still open for edits).',
    `cycle_name` STRING COMMENT 'Business-friendly name or label for the S&OP cycle (e.g., January 2024 S&OP Cycle, Q1 FY2024 IBP).',
    `cycle_notes` STRING COMMENT 'General free-text notes or comments about this S&OP cycle, including special circumstances, deviations from standard process, or other relevant context.',
    `cycle_phase` STRING COMMENT 'Current phase of the S&OP cycle: statistical_forecast (initial statistical forecast generation), demand_review (demand planning team review), supply_review (supply planning team review), pre_sop (pre-S&OP reconciliation meeting), executive_sop (executive S&OP decision meeting), closed (cycle completed and locked).. Valid values are `statistical_forecast|demand_review|supply_review|pre_sop|executive_sop|closed`',
    `cycle_start_date` DATE COMMENT 'The date when this S&OP cycle officially begins (typically the first day of the cycle month).',
    `cycle_type` STRING COMMENT 'The cadence or type of S&OP cycle: monthly (standard monthly cadence), quarterly (quarterly review), annual (annual planning), rolling (continuous rolling horizon), event_driven (triggered by specific business events).. Valid values are `monthly|quarterly|annual|rolling|event_driven`',
    `demand_consensus_achieved_flag` BOOLEAN COMMENT 'Indicates whether demand consensus was achieved during the demand review phase (True if consensus reached, False otherwise).',
    `demand_review_due_date` DATE COMMENT 'Target date by which the demand review phase must be completed.',
    `executive_approval_date` DATE COMMENT 'The date when the executive sponsor formally approved the S&OP plan for this cycle.',
    `executive_approval_flag` BOOLEAN COMMENT 'Indicates whether the executive S&OP meeting approved the plan (True if approved, False if rejected or pending).',
    `executive_approval_notes` STRING COMMENT 'Free-text notes or comments from the executive sponsor regarding the approval decision, including any conditions or action items.',
    `executive_sop_meeting_date` DATE COMMENT 'Scheduled date for the executive S&OP meeting where senior leadership reviews and approves the plan.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number) within the fiscal year (e.g., 1 for January, 12 for December).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this planning cycle belongs (e.g., 2024).',
    `frozen_period_months` STRING COMMENT 'The number of months at the start of the planning horizon that are frozen and not subject to change (typically 0-3 months).',
    `key_assumptions` STRING COMMENT 'Free-text field capturing the key business assumptions underlying this S&OP cycle (e.g., promotional plans, market trends, supply constraints, new product launches).',
    `key_risks` STRING COMMENT 'Free-text field documenting the key risks identified during this S&OP cycle (e.g., supplier reliability, demand volatility, capacity constraints).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this S&OP cycle record was last updated.',
    `mitigation_actions` STRING COMMENT 'Free-text field describing the mitigation actions agreed upon to address identified risks and supply gaps.',
    `phase_status` STRING COMMENT 'Status of the current cycle phase: not_started (phase has not begun), in_progress (phase is actively underway), completed (phase finished and approved), on_hold (phase temporarily paused), cancelled (phase or cycle cancelled).. Valid values are `not_started|in_progress|completed|on_hold|cancelled`',
    `planning_horizon_months` STRING COMMENT 'The number of months into the future that this S&OP cycle plans (e.g., 18 months, 24 months).',
    `planning_month` DATE COMMENT 'The target month for which this S&OP cycle is planning demand and supply (typically the first day of the planning month).',
    `pre_sop_meeting_date` DATE COMMENT 'Scheduled date for the pre-S&OP reconciliation meeting where demand and supply teams align on recommendations.',
    `statistical_forecast_due_date` DATE COMMENT 'Target date by which the statistical forecast phase must be completed.',
    `supply_consensus_achieved_flag` BOOLEAN COMMENT 'Indicates whether supply consensus was achieved during the supply review phase (True if consensus reached, False otherwise).',
    `supply_gap_volume` DECIMAL(18,2) COMMENT 'The total supply gap (in units) representing the difference between consensus demand and constrained supply (positive indicates shortfall, negative indicates surplus).',
    `supply_review_due_date` DATE COMMENT 'Target date by which the supply review phase must be completed.',
    CONSTRAINT pk_sop_cycle PRIMARY KEY(`sop_cycle_id`)
) COMMENT 'Master entity representing each S&OP/IBP planning cycle instance (monthly cadence). Captures cycle name, planning month, cycle phase (statistical forecast, demand review, supply review, pre-S&OP, executive S&OP), phase status, cycle owner, key milestones, and sign-off records. Provides the governance framework for all demand and supply planning activities within the cycle.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` (
    `consensus_demand_id` BIGINT COMMENT 'Unique identifier for the consensus demand record. Primary key for this entity representing a single agreed demand signal from the S&OP demand review process.',
    `demand_plan_id` BIGINT COMMENT 'FK to supply.demand_plan.demand_plan_id — Links consensus demand records to demand plan header. Required for S&OP process tracking and forecast accuracy measurement.',
    `planning_period_id` BIGINT COMMENT 'Reference to the time bucket (week, month, quarter) for which this consensus demand is valid. Links to the planning calendar.',
    `employee_id` BIGINT COMMENT 'Reference to the business user (demand manager, S&OP lead, or executive) who approved this consensus demand record. Establishes accountability for the demand signal.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the specific trade promotion or marketing event driving incremental demand. Populated only when promotion_flag is true.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which consensus demand is being planned. Links to the product master data.',
    `sop_cycle_id` BIGINT COMMENT 'Reference to the specific S&OP or IBP cycle during which this consensus demand was agreed. Enables tracking of demand evolution across planning cycles.',
    `network_node_id` BIGINT COMMENT 'Reference to the planning location (distribution center, plant, or market) for which this consensus demand applies.',
    `tertiary_consensus_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last modified this consensus demand record. Enables tracking of who made the most recent changes.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand record is currently active and should be used by supply planning. False indicates the record has been superseded or deactivated.',
    `approval_status` STRING COMMENT 'Current approval state of the consensus demand record within the S&OP workflow. Only approved records are released to supply planning.. Valid values are `draft|submitted|approved|rejected|revised`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consensus demand was formally approved and released to supply planning. Marks the transition from draft to official demand signal.',
    `bias_indicator` STRING COMMENT 'Indicator of systematic forecasting bias based on historical performance. Over-forecast indicates consistent overestimation; under-forecast indicates consistent underestimation; neutral indicates balanced accuracy.. Valid values are `over_forecast|under_forecast|neutral`',
    `comments` STRING COMMENT 'Free-text field for demand planners to capture additional context, assumptions, risks, or special considerations related to this consensus demand record.',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'The demand adjustment applied by commercial teams based on market intelligence, customer commitments, and sales insights. Can be positive or negative.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the consensus demand figure based on data quality, market stability, and input reliability. Used for risk-based supply planning.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'The final agreed demand volume for this SKU/location/period after all inputs and overlays have been applied. This is the single demand signal passed to supply planning and represents the official forecast.',
    `constrained_flag` BOOLEAN COMMENT 'Indicates whether the consensus demand has been adjusted downward due to known supply constraints. True means demand was constrained; false means demand is unconstrained.',
    `constraint_reason` STRING COMMENT 'Explanation of the supply constraint that limited consensus demand (e.g., production capacity, raw material shortage, distribution capacity). Populated only when constrained_flag is true.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was first created in the system. Part of standard audit trail.',
    `customer_commitment_quantity` DECIMAL(18,2) COMMENT 'Demand volume backed by firm customer orders, contracts, or commitments for this planning period. Represents the most reliable component of consensus demand.',
    `demand_category` STRING COMMENT 'Classification of the demand type to enable segmented planning and analysis. Base demand represents ongoing business; promotional and seasonal reflect event-driven spikes; new launch and phase-out support lifecycle transitions.. Valid values are `base|promotional|seasonal|new_launch|phase_out|special_order`',
    `demand_driver_code` STRING COMMENT 'Code identifying the primary business driver or causal factor influencing this demand (e.g., holiday season, weather pattern, competitive action, regulatory change). Supports root-cause analysis.',
    `demand_driver_description` STRING COMMENT 'Detailed explanation of the demand driver or business rationale behind the consensus demand figure. Captures qualitative insights from demand planners and commercial teams.',
    `demand_volatility_index` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability for this SKU/location combination, typically expressed as coefficient of variation. Higher values indicate greater uncertainty and require higher safety stock.',
    `forecast_accuracy_previous_period` DECIMAL(18,2) COMMENT 'The forecast accuracy percentage achieved for this SKU/location combination in the previous planning period. Used to assess forecasting performance trends and adjust confidence levels.',
    `forecast_model_code` STRING COMMENT 'Identifier of the statistical forecasting model or algorithm used to generate the baseline statistical forecast (e.g., exponential smoothing, ARIMA, machine learning model).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consensus demand record was last updated. Tracks the most recent change to any field in the record.',
    `last_review_date` DATE COMMENT 'Date when this consensus demand record was last reviewed and validated by the demand planning team during the S&OP demand review meeting.',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand volume expected from planned marketing campaigns, promotions, or trade events during this planning period.',
    `new_product_launch_quantity` DECIMAL(18,2) COMMENT 'Demand volume attributed to new product introductions or product launches scheduled for this planning period. Typically based on launch plans and market sizing.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next S&OP demand review when this consensus demand will be re-evaluated and updated based on latest market intelligence.',
    `planning_horizon_type` STRING COMMENT 'Classification of the planning time horizon for this demand record. Short-term (0-3 months) is firm; medium-term (3-12 months) is flexible; long-term (12+ months) is strategic.. Valid values are `short_term|medium_term|long_term`',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether this consensus demand includes uplift from planned trade promotions or marketing events. True means promotional activity is planned; false means base demand only.',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor representing seasonal demand patterns for this planning period. Values above 1.0 indicate peak season; below 1.0 indicate off-season.',
    `statistical_forecast_quantity` DECIMAL(18,2) COMMENT 'The baseline demand forecast generated by statistical forecasting algorithms before any manual adjustments or commercial overlays. Serves as the starting point for consensus demand.',
    `unconstrained_demand_quantity` DECIMAL(18,2) COMMENT 'The theoretical demand volume if all supply constraints (capacity, materials, inventory) were removed. Used for capacity planning and investment decisions.',
    `unit_of_measure` STRING COMMENT 'The unit in which consensus demand quantity is expressed (each, case, pallet, kilogram, liter, etc.). Must align with product master UOM. [ENUM-REF-CANDIDATE: EA|CS|PAL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between consensus demand and statistical forecast, calculated as (variance_to_statistical / statistical_forecast_quantity) * 100. Used to monitor forecast override patterns.',
    `variance_to_statistical` DECIMAL(18,2) COMMENT 'The difference between consensus demand quantity and statistical forecast quantity. Positive values indicate upward adjustments; negative values indicate downward adjustments. Key metric for forecast bias analysis.',
    `version_number` STRING COMMENT 'Sequential version number tracking iterations of this consensus demand record within the same S&OP cycle. Increments with each revision to support change history.',
    CONSTRAINT pk_consensus_demand PRIMARY KEY(`consensus_demand_id`)
) COMMENT 'Transactional record capturing the final consensus demand volume agreed upon during the S&OP demand review for each SKU/location/planning period. Stores statistical forecast input, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, approver, and S&OP cycle reference. Represents the single agreed demand signal passed to supply planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` (
    `constraint_id` BIGINT COMMENT 'Primary key for constraint',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supply constraints often generate cost impacts; linking to a cost center enables financial impact reporting and mitigation budgeting.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse node where the constraint is identified. Links to the distribution facility master.',
    `employee_id` BIGINT COMMENT 'Identifier of the supply planner or demand planner responsible for managing and resolving this constraint. Links to the workforce or user master for accountability tracking.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant or production facility where the constraint is identified. Links to the plant master for location context.',
    `planning_run_id` BIGINT COMMENT 'Identifier of the Integrated Business Planning (IBP) or Sales and Operations Planning (S&OP) run during which this constraint was identified.',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU or product family affected by this constraint. Links to the product master for constrained item identification.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external supplier when the constraint originates from supplier capacity or material availability limitations.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: constraint should reference the network node where the constraint applies; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `allocation_method` STRING COMMENT 'The algorithm applied to allocate constrained supply across competing demand: proportional (pro-rata by demand), priority_based (by customer or product priority), fair_share (equal distribution), customer_tier (by customer segmentation), or strategic_account (key account preference).. Valid values are `proportional|priority_based|fair_share|customer_tier|strategic_account`',
    `constrained_resource_identifier` STRING COMMENT 'Business identifier of the specific resource that is constrained, such as production line code, warehouse zone, labor pool identifier, or material code. Provides granular traceability to the bottleneck.',
    `constraint_status` STRING COMMENT 'Current lifecycle status of the constraint: identified (newly detected), active (currently impacting supply), mitigated (workaround applied), resolved (constraint removed), or escalated (requires executive intervention).. Valid values are `identified|active|mitigated|resolved|escalated`',
    `constraint_type` STRING COMMENT 'Classification of the constraint by root cause: capacity (production or storage capacity limitation), material (raw material or component shortage), labor (workforce availability), regulatory (compliance or certification limitation), supplier (external supplier constraint), or transportation (logistics capacity constraint).. Valid values are `capacity|material|labor|regulatory|supplier|transportation`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this constraint record was first created in the data platform. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount, such as USD, EUR, or GBP. Aligns with corporate reporting currency standards.. Valid values are `^[A-Z]{3}$`',
    `customer_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this constraint directly impacts customer order fulfillment or On Time In Full (OTIF) performance. True indicates customer-facing impact requiring expedited resolution.',
    `duration_days` STRING COMMENT 'The calculated number of days the constraint is expected to persist, derived from start and end dates. Used for prioritization and impact assessment.',
    `end_date` DATE COMMENT 'The date when the constraint is expected to be resolved or no longer impact supply. Marks the end of the constrained planning horizon. Nullable for constraints with indefinite duration.',
    `escalation_level` STRING COMMENT 'The organizational level to which this constraint has been escalated for resolution: none (managed at planner level), team_lead, director, vp (vice president), or executive (C-suite). Reflects the severity and business impact of the constraint.. Valid values are `none|team_lead|director|vp|executive`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated revenue or margin impact of the constraint in the planning currency, calculated as shortfall quantity multiplied by unit margin or revenue. Used for executive reporting and prioritization.',
    `identified_timestamp` TIMESTAMP COMMENT 'The date and time when the constraint was first detected by the planning system or planner. Represents the constraint discovery event in the planning lifecycle.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this constraint record was last updated in the data platform. Audit field for change tracking and data freshness monitoring.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'The date and time when the constraint record was last reviewed or updated by a planner. Used to track active management and ensure constraints are not stale.',
    `mitigation_action` STRING COMMENT 'Description of the action plan or workaround implemented to address the constraint, such as alternate sourcing, production rescheduling, expedited shipping, or demand shaping. Free-text field for planner notes.',
    `mitigation_effectiveness_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of how effectively the mitigation action reduced the constraint impact, expressed as a percentage (0-100). Used for continuous improvement and mitigation strategy evaluation.',
    `planning_group` STRING COMMENT 'The organizational planning team or business unit responsible for this constraint, such as regional supply planning, category planning, or global S&OP team. Used for workload distribution and escalation routing.',
    `priority_rank` STRING COMMENT 'Numerical ranking of this constraint relative to other active constraints, used to sequence resolution efforts and resource allocation. Lower numbers indicate higher priority.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The actual quantity of the resource or material available during the constraint period. Represents the constrained supply capacity.',
    `quantity_required` DECIMAL(18,2) COMMENT 'The quantity of the resource or material required to meet demand without constraint. Represents the unconstrained demand signal.',
    `quantity_shortfall` DECIMAL(18,2) COMMENT 'The calculated gap between required and available quantities (required minus available). Represents the magnitude of the constraint impact.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this constraint is driven by regulatory, certification, or compliance requirements such as Good Manufacturing Practice (GMP), Food and Drug Administration (FDA) approval, or Environmental Protection Agency (EPA) restrictions.',
    `resolution_notes` STRING COMMENT 'Free-text field capturing detailed notes on how the constraint was resolved, lessons learned, and recommendations for future prevention. Used for knowledge management and continuous improvement.',
    `resolved_timestamp` TIMESTAMP COMMENT 'The date and time when the constraint was fully resolved and supply capacity restored. Nullable for constraints that remain active or unresolved.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the constraint: demand_spike (unexpected demand increase), supply_disruption (supplier or logistics failure), quality_issue (product recall or quality hold), capacity_limitation (fixed asset bottleneck), forecast_error (planning inaccuracy), or external_event (natural disaster, geopolitical event).. Valid values are `demand_spike|supply_disruption|quality_issue|capacity_limitation|forecast_error|external_event`',
    `severity_level` STRING COMMENT 'Business impact classification of the constraint: critical (customer-facing stockout risk), high (significant revenue impact), medium (manageable with mitigation), or low (minimal business impact).. Valid values are `critical|high|medium|low`',
    `start_date` DATE COMMENT 'The date when the constraint begins to impact supply availability. Marks the beginning of the constrained planning horizon.',
    `unit_of_measure` STRING COMMENT 'The unit in which constraint quantities are expressed, such as cases, pallets, kilograms, liters, or production hours. Aligns with the constrained resource measurement standard.',
    CONSTRAINT pk_constraint PRIMARY KEY(`constraint_id`)
) COMMENT 'Master entity capturing identified supply constraints at each node in the supply network for a given planning horizon. Stores constraint type (capacity, material, labor, regulatory, supplier), constrained resource identifier, constrained SKU or product family, constraint quantity (available vs required), constraint start/end date, severity level, mitigation action, resolution status, owning planner, and allocation method applied during shortage (proportional, priority-based, fair share). Used in constrained supply planning runs within IBP to drive supply allocation decisions and exception generation.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Primary key for risk_register',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Risk mitigation actions are funded through specific cost centers; the link supports risk‑related expense tracking and SOX reporting.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center affected by this risk, if the risk is DC-specific. Links to the distribution facility master data for logistics continuity planning.',
    `manufacturing_facility_id` BIGINT COMMENT 'Identifier of the manufacturing plant affected by this risk, if the risk is plant-specific. Links to the plant master data for production continuity planning.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with this risk, if the risk is supplier-specific. Links to the supplier master data for vendor risk management.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: risk_register should be tied to a specific network node for risk tracking; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `tertiary_risk_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created this risk record in the system, linking to the workforce master data for audit trail and accountability.',
    `actual_closure_date` DATE COMMENT 'Actual date when the risk was closed or fully mitigated, enabling risk resolution cycle time analysis and mitigation effectiveness measurement.',
    `affected_node_list` STRING COMMENT 'Comma-separated list of supply network node identifiers (plants, distribution centers, suppliers) that are exposed to this risk, supporting network resilience analysis.',
    `affected_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers that are exposed to this supply chain risk, enabling product-level impact analysis and mitigation planning.',
    `assessed_date` DATE COMMENT 'Date when the risk assessment (probability and impact scoring) was completed, establishing the baseline for risk monitoring.',
    `contingency_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial cost of implementing the contingency plan, including expedited freight, alternative sourcing premiums, and safety stock carrying costs, measured in the base currency.',
    `contingency_plan` STRING COMMENT 'Reactive response plan to be executed if the risk materializes, including alternative sourcing strategies, safety stock deployment, and business continuity procedures.',
    `contingency_stock_quantity` DECIMAL(18,2) COMMENT 'Additional safety stock quantity recommended to buffer against this risk, expressed in the base unit of measure. Used for inventory optimization and DRP planning.',
    `contingency_stock_uom` STRING COMMENT 'Unit of measure for the contingency stock quantity (e.g., EA, CS, KG, LB), aligned with the SKU base UOM for consistency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this risk record (impact_score, contingency_cost_estimate).. Valid values are `^[A-Z]{3}$`',
    `escalation_date` DATE COMMENT 'Date when the risk was escalated to higher management levels, tracking the escalation timeline for governance and audit purposes.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this risk has been escalated to senior management or executive leadership due to high severity or strategic importance.',
    `geographic_region` STRING COMMENT 'Geographic region or country code where the risk is localized, using ISO 3166-1 alpha-3 country codes or regional identifiers for geopolitical and natural disaster risk tracking.',
    `identified_date` DATE COMMENT 'Date when the supply chain risk was first identified and entered into the risk register, supporting risk aging and trend analysis.',
    `impact_score` DECIMAL(18,2) COMMENT 'Quantitative financial estimate of potential loss or cost if the risk event occurs, measured in the base currency. Used for risk prioritization and contingency budget planning.',
    `impact_severity` STRING COMMENT 'Qualitative assessment of the potential business impact if the risk materializes: critical (business-threatening), high (major disruption), medium (moderate impact), low (minor inconvenience), or negligible (minimal effect).. Valid values are `critical|high|medium|low|negligible`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk record, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX, enabling change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date of the most recent risk review or reassessment, ensuring risks are periodically evaluated as part of the S&OP and IBP governance process.',
    `mitigation_plan` STRING COMMENT 'Detailed description of the proactive actions and controls implemented to reduce the probability or impact of the risk, including timelines and responsible parties.',
    `mitigation_start_date` DATE COMMENT 'Date when mitigation activities commenced, tracking the timeline of risk response execution.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next risk review or reassessment, supporting proactive risk management and compliance with review frequency policies.',
    `probability_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of the likelihood that the risk event will occur, expressed as a percentage (0.00 to 100.00) based on historical data, expert judgment, and predictive analytics.',
    `risk_category` STRING COMMENT 'Primary classification of the supply chain risk type: supplier (vendor failure, capacity constraints), logistics (transportation disruption, port delays), geopolitical (trade restrictions, political instability), regulatory (compliance changes, import/export restrictions), natural_disaster (weather events, earthquakes, pandemics), or quality (product defects, contamination).. Valid values are `supplier|logistics|geopolitical|regulatory|natural_disaster|quality`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the supply chain risk, including context, potential triggers, and business impact scenarios.',
    `risk_notes` STRING COMMENT 'Free-form text field for additional context, updates, or observations related to the risk, supporting collaborative risk management and knowledge sharing.',
    `risk_number` STRING COMMENT 'Business-facing unique identifier for the supply chain risk, formatted as RISK-NNNNNNNN for external communication and tracking.. Valid values are `^RISK-[0-9]{8}$`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating calculated as probability_score multiplied by impact_score, used for risk ranking and prioritization in the S&OP and IBP processes.',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk: identified (newly discovered), assessed (analysis complete), active (currently impacting operations), mitigated (controls in place), closed (no longer a threat), or monitoring (under observation).. Valid values are `identified|assessed|active|mitigated|closed|monitoring`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the primary risk category for more precise risk segmentation and analysis.',
    `risk_title` STRING COMMENT 'Short descriptive title summarizing the nature of the supply chain risk for quick identification and reporting.',
    `target_closure_date` DATE COMMENT 'Planned date by which the risk is expected to be fully mitigated or closed, used for risk management performance tracking and SLA monitoring.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Master entity tracking identified supply chain risks that could disrupt supply continuity. Captures risk category (supplier, logistics, geopolitical, regulatory, natural disaster), affected SKUs/nodes, probability score, impact severity, risk owner, mitigation plan, contingency stock requirement, and risk status. Supports supply risk management and business continuity planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` (
    `planning_exception_id` BIGINT COMMENT 'Unique identifier for the planning exception record. Primary key for the planning exception entity.',
    `planning_run_id` BIGINT COMMENT 'add column planning_run_id (BIGINT) with FK to supply.planning_run.planning_run_id - planning exceptions are generated by specific planning runs',
    `employee_id` BIGINT COMMENT 'Reference to the supply planner or demand planner assigned to resolve this exception.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU affected by this planning exception.',
    `network_node_id` BIGINT COMMENT 'Reference to the plant, distribution center, or location where the planning exception occurred.',
    `tertiary_planning_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the planning exception record.',
    `action_type` STRING COMMENT 'Classification of the recommended action type for resolving the exception. [ENUM-REF-CANDIDATE: expedite_order|cancel_order|increase_production|decrease_production|transfer_stock|adjust_forecast|override_plan — 7 candidates stripped; promote to reference product]',
    `auto_resolution_flag` BOOLEAN COMMENT 'Indicates whether the exception was automatically resolved by the system without planner intervention.',
    `business_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the exception if not resolved, expressed in the reporting currency.',
    `constraint_type` STRING COMMENT 'Type of supply chain constraint that contributed to the planning exception.. Valid values are `capacity|material|transportation|supplier|labor|equipment`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the planning exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the business impact amount.. Valid values are `^[A-Z]{3}$`',
    `demand_forecast_quantity` DECIMAL(18,2) COMMENT 'The forecasted demand quantity for the affected SKU-location during the exception period.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the exception was escalated to management or cross-functional teams for resolution.',
    `escalation_level` STRING COMMENT 'The organizational level to which the exception was escalated, if applicable.. Valid values are `none|supervisor|manager|director|executive`',
    `exception_date` DATE COMMENT 'The date when the planning exception was identified or when the exception condition is projected to occur.',
    `exception_notes` STRING COMMENT 'Additional free-text notes or comments related to the planning exception for planner reference.',
    `exception_number` STRING COMMENT 'Business-facing unique exception number assigned to this planning exception for tracking and reference purposes.. Valid values are `^EXC-[0-9]{10}$`',
    `exception_quantity` DECIMAL(18,2) COMMENT 'The magnitude of the exception expressed as a quantity (e.g., shortage quantity, excess quantity, unmet demand quantity).',
    `exception_recurrence_count` STRING COMMENT 'Number of times this type of exception has occurred for the same SKU-location combination within a defined time window.',
    `exception_severity` STRING COMMENT 'Severity classification of the planning exception indicating the urgency and business impact of the issue.. Valid values are `critical|high|medium|low`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the planning exception indicating its resolution progress.. Valid values are `open|assigned|in_progress|resolved|closed|cancelled`',
    `exception_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the planning exception was detected and recorded by the IBP system.',
    `exception_type` STRING COMMENT 'Classification of the planning exception indicating the nature of the supply planning issue. OOS Risk (Out of Stock Risk), Excess Inventory, Late Replenishment, Unmet Demand, Capacity Breach, or Safety Stock Breach.. Valid values are `oos_risk|excess_inventory|late_replenishment|unmet_demand|capacity_breach|safety_stock_breach`',
    `gap_quantity` DECIMAL(18,2) COMMENT 'The calculated gap between demand and supply that triggered the exception (positive for shortage, negative for excess).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the planning exception record was last modified.',
    `planning_group` STRING COMMENT 'The planning group or team responsible for managing exceptions for this SKU-location combination.',
    `planning_horizon_date` DATE COMMENT 'The specific date within the planning horizon where the exception condition manifests.',
    `priority_score` STRING COMMENT 'Calculated priority score used to rank exceptions in the planner workbench, based on severity, business impact, and urgency.',
    `projected_inventory_balance` DECIMAL(18,2) COMMENT 'The projected inventory balance at the time of the exception, used to assess the severity of stock-out or excess inventory conditions.',
    `recommended_action` STRING COMMENT 'System-generated or planner-defined recommended action to resolve the planning exception.',
    `resolution_date` DATE COMMENT 'The date when the planning exception was marked as resolved or closed.',
    `resolution_duration_hours` DECIMAL(18,2) COMMENT 'The elapsed time in hours from exception detection to resolution, used for performance tracking.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the actions taken to resolve the exception and the outcome.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the planning exception was marked as resolved or closed.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause that triggered the planning exception.. Valid values are `demand_spike|supply_disruption|forecast_error|capacity_limitation|lead_time_delay|quality_issue`',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause analysis findings for the planning exception.',
    `safety_stock_target` DECIMAL(18,2) COMMENT 'The target safety stock level for the SKU-location combination at the time of the exception.',
    `supply_plan_quantity` DECIMAL(18,2) COMMENT 'The planned supply quantity (production or replenishment) for the affected SKU-location during the exception period.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the exception quantity (e.g., EA for each, CS for case, PAL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_planning_exception PRIMARY KEY(`planning_exception_id`)
) COMMENT 'Transactional record capturing supply planning exceptions and alerts generated during IBP supply planning and DRP execution runs. Stores exception type (OOS risk, excess inventory, late replenishment, unmet demand, capacity breach), affected SKU/location, exception severity, exception date, recommended action, planner assignment, resolution status, resolution notes, and originating run reference. Drives exception-based planning workflows and planner workbench prioritization.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` (
    `sku_planning_param_id` BIGINT COMMENT 'Unique identifier for the SKU planning parameter record. Primary key for this entity.',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this SKU is produced or sourced. Used for plant-specific planning parameters.',
    `product_lca_id` BIGINT COMMENT 'Foreign key linking to sustainability.product_lca. Business justification: SKU planning uses product LCA data (carbon/water footprints) to set planning parameters and sustainability targets.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU in the product master. Links planning parameters to the specific product variant being planned.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: sku_planning_param needs to be associated with the network node it applies to; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on revenue contribution or consumption value. A items are high-value requiring tight control, C items are low-value with relaxed control.. Valid values are `A|B|C`',
    `backorder_allowed_flag` BOOLEAN COMMENT 'Indicates whether backorders are permitted for this SKU when inventory is insufficient. True allows demand to be backordered, false requires immediate fulfillment or cancellation.',
    `coverage_profile_days` STRING COMMENT 'Target days of supply to maintain in inventory. Represents desired inventory coverage horizon based on demand forecast and replenishment frequency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_part_flag` BOOLEAN COMMENT 'Indicates whether this SKU is classified as a critical part requiring special planning attention. Critical parts may have higher service levels or expedited replenishment.',
    `demand_pattern_type` STRING COMMENT 'Characterization of the SKUs historical demand pattern. Determines appropriate forecasting method and safety stock calculation approach.. Valid values are `steady|seasonal|trending|intermittent|lumpy|erratic`',
    `effective_end_date` DATE COMMENT 'Date after which these planning parameters are no longer active. Null indicates parameters are currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which these planning parameters become active and are used by planning systems. Supports time-phased parameter changes.',
    `fixed_lot_size_quantity` DECIMAL(18,2) COMMENT 'Fixed production or procurement lot size quantity when using fixed lot size method. Represents standard batch size for manufacturing or ordering.',
    `forecast_model_type` STRING COMMENT 'Statistical or machine learning model used for demand forecasting. Determines the algorithm applied during forecast generation in IBP or demand planning systems.. Valid values are `moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus`',
    `goods_receipt_processing_time_days` STRING COMMENT 'Time required for quality inspection and goods receipt processing after physical delivery. Adds to total replenishment lead time.',
    `inventory_valuation_method` STRING COMMENT 'Method used for inventory valuation and consumption. FIFO (First In First Out), FEFO (First Expired First Out), LIFO (Last In First Out), or weighted average costing.. Valid values are `fifo|fefo|lifo|weighted_average|standard_cost`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was last updated. Tracks most recent change for change management and audit purposes.',
    `last_review_date` DATE COMMENT 'Date when planning parameters were last reviewed and validated by the planning team. Supports periodic parameter maintenance and accuracy audits.',
    `lot_size_method` STRING COMMENT 'Method used to calculate production or procurement lot sizes. Determines how order quantities are calculated in MRP and supply planning runs.. Valid values are `fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size`',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single transaction. Limited by production capacity, storage constraints, or supplier capabilities.',
    `maximum_stock_level_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level target for this SKU. Used in min-max planning to cap inventory investment and prevent overstock situations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single transaction. Enforced by supplier contracts or manufacturing constraints.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at time of shipment to customer or retail delivery. Ensures product quality and retailer acceptance.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this SKU. Used for workload assignment and exception management routing.',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how the planning system generates procurement proposals. Determines planning logic and automation level.. Valid values are `mrp|reorder_point|forecast_based|time_phased|no_planning`',
    `next_review_date` DATE COMMENT 'Scheduled date for next planning parameter review. Ensures regular validation of planning assumptions and parameter accuracy.',
    `order_multiple_quantity` DECIMAL(18,2) COMMENT 'Quantity increment in which orders must be placed. All order quantities must be multiples of this value due to packaging or production constraints.',
    `parameter_notes` STRING COMMENT 'Free-text notes documenting special planning considerations, parameter rationale, or exceptions for this SKU. Provides context for planning decisions.',
    `parameter_status` STRING COMMENT 'Current lifecycle status of the planning parameter record. Active parameters are used in planning runs, inactive parameters are ignored.. Valid values are `active|inactive|pending_approval|obsolete`',
    `planned_delivery_time_days` STRING COMMENT 'Standard lead time in days from order placement to goods receipt. Used for MRP scheduling and supply plan timing calculations.',
    `planning_group` STRING COMMENT 'IBP planning group assignment for demand and supply planning segmentation. Groups SKUs with similar planning characteristics for collaborative planning processes.',
    `planning_horizon_days` STRING COMMENT 'Number of days into the future for which demand and supply planning is performed. Defines the forward-looking planning window for this SKU.',
    `planning_strategy` STRING COMMENT 'Manufacturing planning strategy that determines how the SKU is planned and produced. Make-to-stock produces to forecast, make-to-order produces against customer orders.. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly`',
    `planning_time_fence_days` STRING COMMENT 'Number of days within which the planning system cannot automatically change planned orders without planner approval. Protects near-term production schedule stability.',
    `procurement_type` STRING COMMENT 'Indicates whether the SKU is externally procured from suppliers, produced in-house, or both. Determines supply planning logic and sourcing strategy.. Valid values are `external_procurement|in_house_production|both|subcontracting`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order. Calculated based on lead time demand plus safety stock to prevent stockouts.',
    `rounding_profile_code` STRING COMMENT 'Code defining rounding rules for planned order quantities. Ensures quantities align with packaging units, pallet configurations, or production batch constraints.',
    `safety_stock_method` STRING COMMENT 'Method used to calculate safety stock levels. Fixed quantity uses static buffer, service level based uses demand variability and lead time uncertainty.. Valid values are `fixed_quantity|days_of_supply|dynamic_calculation|service_level_based`',
    `seasonality_profile_code` STRING COMMENT 'Code identifying the seasonality pattern applied to this SKU for demand forecasting. Links to predefined seasonal index curves (e.g., summer peak, holiday spike).',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage for this SKU (e.g., 95%, 98%, 99%). Drives safety stock calculation to achieve desired product availability.',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the SKU in days from production date to expiration. Critical for FEFO inventory management and demand planning for perishable goods.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all planning quantities (e.g., EA for each, CS for case, KG for kilogram). Standardizes quantity representation across planning processes.',
    `xyz_classification` STRING COMMENT 'XYZ demand variability classification. X items have stable demand, Y items have moderate variability, Z items have highly erratic or sporadic demand patterns.. Valid values are `X|Y|Z`',
    CONSTRAINT pk_sku_planning_param PRIMARY KEY(`sku_planning_param_id`)
) COMMENT 'Master entity storing SKU-level planning parameters used in demand and supply planning calculations. Captures planning horizon, lot size, minimum order quantity (MOQ), shelf life (days), FEFO/FIFO flag, planning strategy (make-to-stock/make-to-order), ABC/XYZ classification, demand pattern type, seasonality index, and IBP planning group assignment. Distinct from product master (owned by product domain) as this captures supply-planning-specific parameters.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` (
    `inventory_projection_id` BIGINT COMMENT 'Unique identifier for the inventory projection record. Primary key for this transactional projection entity.',
    `employee_id` BIGINT COMMENT 'Reference to the supply planner or planning team responsible for this SKU-location combination. Enables accountability and collaboration.',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which inventory is being projected. Links to the product master data.',
    `network_node_id` BIGINT COMMENT 'Reference to the physical location (distribution center, plant, warehouse) for which inventory is projected.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'Quantity available to promise to new customer orders on the projection date, calculated from projected balance minus committed allocations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory projection record was first created in the system. Supports audit trail and data lineage.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'Quantity capable to promise considering future production capacity and material availability, extending beyond current ATP.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Projected number of days the available inventory balance will cover forecasted demand. Critical metric for inventory health and service level assessment.',
    `demand_source` STRING COMMENT 'Source system or process that provided the demand forecast used in this projection (e.g., statistical forecast, demand sensing, customer orders, consensus demand).',
    `exception_code` STRING COMMENT 'Standardized exception or alert code triggered by this projection (e.g., LOW_STOCK, EXCESS_INV, CAPACITY_CONSTRAINT). Supports exception-based planning workflows.',
    `excess_inventory_flag` BOOLEAN COMMENT 'Indicator that the projected available balance exceeds maximum stock levels or days-of-supply targets, signaling potential overstock risk.',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'Historical forecast accuracy percentage for this SKU-location combination, used to assess confidence in the projection and adjust safety stock.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory projection record was last updated. Tracks changes and supports version control.',
    `oos_risk_flag` BOOLEAN COMMENT 'Indicator that the projected available balance falls below safety stock or service level thresholds, signaling potential stockout risk.',
    `planning_bucket` STRING COMMENT 'Time granularity of the projection. Daily for near-term tactical planning; weekly or monthly for mid-term; quarterly for long-term strategic planning.. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_group` STRING COMMENT 'Organizational planning group or segment responsible for this projection (e.g., regional planning team, product category planning team).',
    `planning_run_code` BIGINT COMMENT 'Reference to the supply planning run that generated this projection. Enables traceability to planning execution and version control.',
    `planning_run_timestamp` TIMESTAMP COMMENT 'Timestamp when the supply planning run that generated this projection was executed. Distinct from record creation; represents the business event time.',
    `projected_available_balance` DECIMAL(18,2) COMMENT 'Net projected inventory balance after accounting for on-hand, receipts, and demand. Key metric for Available-to-Promise (ATP) calculations.',
    `projected_demand_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand (consumption, sales, or shipments) expected to occur on the projection date. Input from demand planning or demand sensing.',
    `projected_on_hand_quantity` DECIMAL(18,2) COMMENT 'Forecasted physical inventory quantity expected to be available on-hand at the location on the projection date. Core output of supply planning calculation.',
    `projected_on_order_quantity` DECIMAL(18,2) COMMENT 'Forecasted quantity of inventory currently on order (in-transit or planned receipts) expected to arrive by or on the projection date.',
    `projected_receipt_quantity` DECIMAL(18,2) COMMENT 'Forecasted quantity of planned receipts (production output, purchase orders, or replenishment) expected to arrive on the projection date.',
    `projection_confidence_level` STRING COMMENT 'Qualitative assessment of confidence in this projection based on demand volatility, forecast accuracy, and supply reliability.. Valid values are `high|medium|low`',
    `projection_date` DATE COMMENT 'The specific future date for which this inventory projection applies. Core dimension for time-series inventory planning.',
    `projection_notes` STRING COMMENT 'Free-text notes or comments from the planner regarding assumptions, exceptions, or special considerations for this projection.',
    `projection_status` STRING COMMENT 'Current lifecycle status of this projection record. Indicates whether the projection is in draft, approved for execution, published to downstream systems, or superseded by a newer version.. Valid values are `draft|approved|published|superseded|archived`',
    `projection_type` STRING COMMENT 'Classification of the projection methodology. Baseline uses unconstrained demand; constrained applies capacity limits; optimized applies optimization algorithms; scenario and simulation support what-if analysis.. Valid values are `baseline|constrained|optimized|scenario|simulation`',
    `projection_version` STRING COMMENT 'Version identifier for this projection scenario. Supports multiple what-if scenarios and plan iterations within the same planning cycle.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'The reorder point threshold used in the planning logic. When projected balance falls below this level, replenishment is triggered.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The safety stock target quantity used as the baseline for OOS risk assessment on the projection date. May vary by date if dynamic safety stock policies are applied.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level (fill rate or in-stock probability) that the projection aims to achieve. Used to calibrate safety stock and OOS risk thresholds.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assessing supply chain vulnerabilities (supplier reliability, lead time variability, geopolitical risk) that may impact this projection.',
    `supply_source` STRING COMMENT 'Source of supply for projected receipts (e.g., internal production, external procurement, transfer from another location).',
    `unit_of_measure` STRING COMMENT 'The unit in which all projected quantities are expressed (e.g., EA, CS, KG, LB). Must be consistent across all quantity fields in this record.',
    CONSTRAINT pk_inventory_projection PRIMARY KEY(`inventory_projection_id`)
) COMMENT 'Transactional record capturing the forward-looking inventory projection (projected available balance) for each SKU/location/date combination as output from the supply planning run. Stores projected on-hand, projected on-order, projected demand, projected receipts, days-of-supply projection, OOS risk flag, excess inventory flag, and planning run reference. Distinct from physical inventory positions (owned by inventory domain).';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` (
    `demand_event_id` BIGINT COMMENT 'Unique identifier for the demand event record. Primary key.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution channel or sales channel affected by this demand event.',
    `employee_id` BIGINT COMMENT 'Reference to the demand planner or business user responsible for creating and maintaining this demand event.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU affected by this demand event. For multi-SKU events, this may reference a product family or be null with SKU scope defined elsewhere.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: Demand events (e.g., product launches) are linked to a promotion event for lift analysis and spend tracking.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: demand_event should be linked to the network node where the event impacts supply; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer or retail account affected by this demand event. Null for market-wide events.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this demand event requires formal approval before being included in the demand plan. True for high-impact or high-risk events.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this demand event was approved.',
    `cannibalization_rate_percent` DECIMAL(18,2) COMMENT 'For new product launches, the percentage of new product demand that is expected to cannibalize existing SKU demand rather than represent net-new volume.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level or business certainty that the event will occur and deliver the projected volume impact. Used for risk-adjusted planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this demand event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `discontinuation_reason` STRING COMMENT 'For product discontinuation events, the business rationale for discontinuing the SKU (e.g., low sales, regulatory, reformulation, portfolio rationalization).',
    `event_code` STRING COMMENT 'Business-assigned unique code for the demand event, used for external reference and cross-system tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `event_description` STRING COMMENT 'Detailed narrative description of the demand event, including business rationale, scope, and expected market impact.',
    `event_end_date` DATE COMMENT 'The date when the demand event ceases to impact demand. Null for indefinite events such as permanent price changes or discontinuations.',
    `event_name` STRING COMMENT 'Human-readable name or title of the demand event for business user identification and reporting.',
    `event_notes` STRING COMMENT 'Free-text field for planner comments, assumptions, risks, or additional context about the demand event.',
    `event_start_date` DATE COMMENT 'The date when the demand event begins to impact demand. For promotions, this is the promotion start date. For launches, this is the market availability date.',
    `event_status` STRING COMMENT 'Current lifecycle status of the demand event. Controls whether the event is included in demand planning calculations.. Valid values are `draft|planned|approved|active|completed|cancelled`',
    `event_type` STRING COMMENT 'Classification of the demand event indicating the nature of the business activity that creates demand variance. Determines which event-specific attributes are populated.. Valid values are `trade_promotion|new_product_launch|product_discontinuation|price_change|seasonal_event|market_expansion`',
    `initial_stocking_quantity` DECIMAL(18,2) COMMENT 'For new product launches, the initial pipeline fill quantity required to stock distribution centers and retail shelves before consumer demand begins.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this demand event record was most recently updated.',
    `last_order_date` DATE COMMENT 'For product discontinuation events, the final date on which orders for the SKU will be accepted.',
    `last_ship_date` DATE COMMENT 'For product discontinuation events, the final date on which the SKU will be shipped to customers.',
    `launch_channel_scope` STRING COMMENT 'For new product launches, describes which distribution channels and customer segments are included in the launch (e.g., DTC-only, mass retail, specialty, omnichannel).',
    `market_geography_code` STRING COMMENT 'Three-letter ISO country code or market region code where the demand event applies. For new product launches, indicates launch market scope.. Valid values are `^[A-Z]{3}$`',
    `planning_run_code` BIGINT COMMENT 'Reference to the demand planning run or Sales and Operations Planning (S&OP) cycle in which this event was incorporated into the forecast.',
    `price_change_amount` DECIMAL(18,2) COMMENT 'For price change events, the absolute change in unit price. Positive for price increases, negative for price decreases.',
    `price_change_percent` DECIMAL(18,2) COMMENT 'For price change events, the percentage change in unit price relative to the previous price.',
    `price_elasticity_coefficient` DECIMAL(18,2) COMMENT 'For price change events, the estimated price elasticity of demand used to calculate volume impact. Negative values indicate normal goods (price up, demand down).',
    `promotion_funding_amount` DECIMAL(18,2) COMMENT 'For trade promotion events, the total budget allocated to fund the promotion, including trade spend, discounts, and allowances.',
    `promotion_type` STRING COMMENT 'For trade promotion events, the specific promotion mechanism (e.g., temporary price reduction, buy-one-get-one, display allowance, feature ad).',
    `ramp_up_weeks` STRING COMMENT 'For new product launches, the number of weeks over which demand is expected to ramp from zero to steady-state volume.',
    `source_system_event_code` STRING COMMENT 'The unique identifier of this demand event in the source system, used for traceability and reconciliation.',
    `supply_readiness_status` STRING COMMENT 'For new product launches, indicates whether manufacturing, procurement, and supply chain are ready to support the launch volume. Critical gate for launch approval.. Valid values are `not_ready|at_risk|ready|confirmed`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for volume impact quantities. Aligns with SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `volume_impact_percent` DECIMAL(18,2) COMMENT 'Percentage change in demand relative to the statistical baseline forecast. Positive for uplift, negative for downlift.',
    `volume_impact_units` DECIMAL(18,2) COMMENT 'Absolute incremental or decremental demand volume attributed to this event, expressed in base units. Positive for uplift events, negative for downlift events.',
    CONSTRAINT pk_demand_event PRIMARY KEY(`demand_event_id`)
) COMMENT 'Master entity capturing planned business events that create demand uplift or downlift adjustments to the statistical forecast. Includes trade promotions, new product launches (with ramp-up volume curves, cannibalization impacts, and supply readiness status), product discontinuations, price changes, seasonal events, and market expansion activities. Stores event type, affected SKUs, affected customers/channels, volume impact (units and percentage), event start/end date, confidence level, initial stocking quantity (for launches), launch market/channel scope, and source system reference. Provides the causal layer that explains forecast adjustments beyond statistical extrapolation and bridges R&D/product NPD pipeline with supply chain readiness planning.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` (
    `otif_target_id` BIGINT COMMENT 'Unique identifier for the OTIF service level target record.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: otif_target is defined per supply node; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: OTIF Performance Ownership assigns a responsible employee for each OTIF target in the OTIF Management Dashboard.',
    `trade_account_id` BIGINT COMMENT 'Reference to the specific customer account for which this OTIF target is defined. Null if target applies to a customer segment or channel rather than individual customer.',
    `approval_date` DATE COMMENT 'Date on which this OTIF target was formally approved and authorized for use in supply planning and performance measurement.',
    `approval_status` STRING COMMENT 'Approval workflow status for this OTIF target definition, indicating whether it has been reviewed and approved by authorized stakeholders.. Valid values are `draft|pending|approved|rejected`',
    `approved_by_name` STRING COMMENT 'Name of the person who approved this OTIF target definition, typically a supply chain director or customer service leader.',
    `channel_code` STRING COMMENT 'Distribution channel classification for which this OTIF target is defined (retail, wholesale, direct-to-consumer, e-commerce, foodservice, export).. Valid values are `retail|wholesale|dtc|ecommerce|foodservice|export`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OTIF target record was first created in the system.',
    `customer_segment_code` STRING COMMENT 'Code identifying the customer segment (e.g., national retailers, regional chains, independent stores) to which this OTIF target applies.',
    `delivery_tolerance_hours` STRING COMMENT 'Acceptable time window variance (in hours) before or after the scheduled delivery time within which delivery is still considered on-time.',
    `effective_end_date` DATE COMMENT 'Date on which this OTIF target expires or is superseded by a new target definition. Null indicates an open-ended commitment.',
    `effective_start_date` DATE COMMENT 'Date from which this OTIF target becomes effective and is used for performance measurement and compliance evaluation.',
    `escalation_threshold_percent` DECIMAL(18,2) COMMENT 'Performance threshold below which OTIF failures trigger escalation to senior management or customer service recovery actions.',
    `in_full_fill_rate_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for in-full order fulfillment, representing the proportion of orders that must be delivered with 100% of requested quantity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this OTIF target record, used for change tracking and audit purposes.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of this OTIF target definition to assess continued relevance and appropriateness.',
    `measurement_frequency` STRING COMMENT 'Frequency at which OTIF performance against this target is measured and reported to stakeholders.. Valid values are `daily|weekly|monthly|quarterly`',
    `measurement_window_days` STRING COMMENT 'Number of days over which OTIF performance is measured and evaluated against the target (e.g., rolling 30 days, quarterly 90 days).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this OTIF target to ensure alignment with business strategy and customer expectations.',
    `on_time_delivery_target_percent` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance, representing the proportion of orders that must be delivered within the agreed delivery window.',
    `otif_composite_target_percent` DECIMAL(18,2) COMMENT 'Composite OTIF target percentage representing orders that must meet both on-time AND in-full criteria simultaneously. This is the primary service level commitment metric.',
    `penalty_clause_flag` BOOLEAN COMMENT 'Indicates whether financial penalties or chargebacks apply when OTIF performance falls below the target threshold.',
    `penalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate financial penalties when OTIF targets are not met, typically applied to order value or invoice amount.',
    `planning_group` STRING COMMENT 'Supply planning team or organizational unit responsible for achieving this OTIF target and managing associated supply plans.',
    `priority_tier` STRING COMMENT 'Priority classification for this OTIF target, indicating the strategic importance and resource allocation priority (tier 1 = highest priority customers).. Valid values are `tier_1|tier_2|tier_3|standard`',
    `product_category_code` STRING COMMENT 'Product category or hierarchy level to which this OTIF target applies, enabling category-specific service level commitments.',
    `quantity_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable variance percentage for order quantity fulfillment. Orders within this tolerance are considered in-full (e.g., 98% fulfillment may be acceptable).',
    `retailer_mandated_target_flag` BOOLEAN COMMENT 'Indicates whether this OTIF target is mandated by the retailer/customer as part of their vendor compliance program versus internally set by the manufacturer.',
    `sla_reference_number` STRING COMMENT 'Reference number of the formal SLA document or contract section that defines this OTIF commitment.',
    `target_code` STRING COMMENT 'Business identifier code for the OTIF target definition, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `target_name` STRING COMMENT 'Descriptive name of the OTIF target configuration, typically indicating the customer segment or channel it applies to.',
    `target_notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or business rationale for this OTIF target definition.',
    `target_owner_name` STRING COMMENT 'Name of the business owner or supply chain manager accountable for achieving this OTIF target.',
    `target_status` STRING COMMENT 'Current lifecycle status of the OTIF target definition (active, inactive, pending approval, expired, suspended).. Valid values are `active|inactive|pending|expired|suspended`',
    CONSTRAINT pk_otif_target PRIMARY KEY(`otif_target_id`)
) COMMENT 'Master entity defining On-Time-In-Full (OTIF) service level targets by customer, channel, and product category. Captures on-time delivery target (%), in-full fill rate target (%), OTIF composite target (%), measurement window, penalty clause flag, retailer-mandated target flag, and effective date range. Provides the service level commitment baseline for supply planning and distribution execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` (
    `atp_rule_id` BIGINT COMMENT 'Primary key for atp_rule',
    `fallback_atp_rule_id` BIGINT COMMENT 'Self-referencing FK on atp_rule (fallback_atp_rule_id)',
    `action_expression` STRING COMMENT 'Expression defining the allocation or availability action taken when the condition is met.',
    `allocation_method` STRING COMMENT 'Method used to allocate inventory when the rule is applied.',
    `condition_expression` STRING COMMENT 'Logical expression that must be satisfied for the rule to fire.',
    `created_by_user` STRING COMMENT 'Identifier of the user who created the ATP rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ATP rule record was first created.',
    `atp_rule_description` STRING COMMENT 'Detailed free‑text description of the rules purpose and logic.',
    `effective_from` DATE COMMENT 'Date from which the rule becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the rule is no longer applicable (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this rule is the default fallback rule.',
    `max_allocation_qty` DECIMAL(18,2) COMMENT 'Upper limit on quantity that can be allocated by this rule.',
    `min_allocation_qty` DECIMAL(18,2) COMMENT 'Lower limit on quantity that must be allocated when the rule fires.',
    `priority` STRING COMMENT 'Numeric priority determining rule evaluation order; lower numbers indicate higher precedence.',
    `rule_category` STRING COMMENT 'Supply‑chain domain where the rule is applied (e.g., order level, line level, inventory level).',
    `rule_code` STRING COMMENT 'Unique alphanumeric code used to reference the ATP rule in downstream systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the ATP rule.',
    `rule_type` STRING COMMENT 'Category of the ATP rule defining its logical purpose.',
    `safety_stock_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to safety stock calculations within the rule.',
    `atp_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the ATP rule record.',
    CONSTRAINT pk_atp_rule PRIMARY KEY(`atp_rule_id`)
) COMMENT 'Master reference table for atp_rule. Referenced by atp_rule_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` (
    `planning_period_id` BIGINT COMMENT 'Primary key for planning_period',
    `previous_planning_period_id` BIGINT COMMENT 'Self-referencing FK on planning_period (previous_planning_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning period record was created.',
    `planning_period_description` STRING COMMENT 'Free‑text description of the planning period purpose.',
    `duration_days` STRING COMMENT 'Number of days covered by the planning period.',
    `effective_from` DATE COMMENT 'Date when the period becomes effective for planning purposes.',
    `effective_until` DATE COMMENT 'Date when the period ceases to be effective (nullable for open‑ended).',
    `end_date` DATE COMMENT 'Last calendar day of the planning period.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the period is historical (true) or future (false).',
    `period_code` STRING COMMENT 'External code used in planning systems to reference the period.',
    `period_name` STRING COMMENT 'Human‑readable name of the planning period (e.g., FY2024 Q1).',
    `period_type` STRING COMMENT 'Category of the period (fiscal, calendar, rolling, forecast).',
    `planning_horizon` STRING COMMENT 'Planning horizon classification for the period.',
    `start_date` DATE COMMENT 'First calendar day of the planning period.',
    `planning_period_status` STRING COMMENT 'Current lifecycle status of the period.',
    `time_zone` STRING COMMENT 'Time zone applicable to the period timestamps.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the planning period record.',
    CONSTRAINT pk_planning_period PRIMARY KEY(`planning_period_id`)
) COMMENT 'Master reference table for planning_period. Referenced by planning_period_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` (
    `planning_run_id` BIGINT COMMENT 'Primary key for planning_run',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that initiated the planning run.',
    `previous_planning_run_id` BIGINT COMMENT 'Self-referencing FK on planning_run (previous_planning_run_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run record was first created in the system.',
    `data_source` STRING COMMENT 'Origin of the input data used for the planning run.',
    `duration_minutes` STRING COMMENT 'Total elapsed time of the run measured in minutes.',
    `error_message` STRING COMMENT 'Error details captured when the run fails or encounters issues.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the planner.',
    `outcome_metric` STRING COMMENT 'Key quantitative metric produced by the run (e.g., total forecast error, service level).',
    `planning_algorithm` STRING COMMENT 'Name or code of the algorithm/model used to generate the plan.',
    `planning_horizon_end` DATE COMMENT 'Last date of the planning horizon covered by the run.',
    `planning_horizon_start` DATE COMMENT 'First date of the planning horizon covered by the run.',
    `result_summary` STRING COMMENT 'High‑level textual summary of the planning outcomes.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run execution finished.',
    `run_name` STRING COMMENT 'Human‑readable name given to the planning run for easy identification.',
    `run_number` STRING COMMENT 'External reference number or code used by business users to identify the run.',
    `run_priority` STRING COMMENT 'Business‑assigned priority level influencing scheduling and resource allocation.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run execution began.',
    `run_type` STRING COMMENT 'Category of planning activity performed in the run (e.g., demand, supply, inventory, S&OP, optimization).',
    `scenario_code` STRING COMMENT 'Code representing the scenario (e.g., baseline, best‑case, worst‑case) used for this run.',
    `planning_run_status` STRING COMMENT 'Current lifecycle state of the planning run.',
    `success_flag` BOOLEAN COMMENT 'True if the run completed without errors; otherwise False.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the planning run record.',
    `version_number` STRING COMMENT 'Version identifier for the run, useful for tracking iterative improvements.',
    CONSTRAINT pk_planning_run PRIMARY KEY(`planning_run_id`)
) COMMENT 'Master reference table for planning_run. Referenced by planning_run_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` (
    `drp_run_id` BIGINT COMMENT 'Primary key for drp_run',
    `drp_last_successful_run_id` BIGINT COMMENT 'Identifier of the most recent successful DRP run preceding this one.',
    `employee_id` BIGINT COMMENT 'Identifier of the planner (person or team) responsible for initiating the DRP run.',
    `primary_previous_drp_run_id` BIGINT COMMENT 'Self-referencing FK on drp_run (previous_drp_run_id)',
    `algorithm_version` STRING COMMENT 'Version of the DRP algorithm or model applied during the run.',
    `comments` STRING COMMENT 'Free‑form notes entered by the planner or system about the DRP run.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the run passed all configured compliance validations.',
    `created_by_user` STRING COMMENT 'User identifier of the person or service that created the DRP run record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DRP run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values in this DRP run.',
    `data_snapshot_date` DATE COMMENT 'Date of the master data snapshot (inventory, demand) used as input for the run.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the DRP run execution finished or was terminated.',
    `forecast_version` STRING COMMENT 'Version identifier of the demand forecast used for this DRP run.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the DRP run was triggered automatically (true) or manually (false).',
    `planning_horizon_days` STRING COMMENT 'Number of days covered by the DRP planning horizon.',
    `priority` STRING COMMENT 'Business priority assigned to the DRP run.',
    `region_code` STRING COMMENT 'Three‑letter ISO region code indicating the geographic scope of the DRP run.',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score for the supply plan generated by this run (0‑100 scale).',
    `run_code` STRING COMMENT 'External code used to reference the DRP run in reports and interfaces.',
    `run_duration_seconds` STRING COMMENT 'Total execution time of the DRP run measured in seconds.',
    `run_name` STRING COMMENT 'Human‑readable name describing the purpose or scenario of the DRP run.',
    `run_type` STRING COMMENT 'Classification of the DRP run execution mode.',
    `scenario_name` STRING COMMENT 'Name of the planning scenario (e.g., "Base", "Optimistic", "Pessimistic").',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the DRP run execution began.',
    `drp_run_status` STRING COMMENT 'Current lifecycle status of the DRP run.',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Aggregate cost realized after execution of the supply plan (if available).',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Aggregate cost forecasted for the supply plan generated by this DRP run.',
    `updated_by_user` STRING COMMENT 'User identifier of the person or service that last updated the DRP run record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DRP run record.',
    CONSTRAINT pk_drp_run PRIMARY KEY(`drp_run_id`)
) COMMENT 'Master reference table for drp_run. Referenced by drp_run_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ADD CONSTRAINT `fk_supply_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_baseline_version_id` FOREIGN KEY (`baseline_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_forecast_sop_cycle_id` FOREIGN KEY (`forecast_sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ADD CONSTRAINT `fk_supply_forecast_accuracy_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_drp_run_id` FOREIGN KEY (`drp_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`drp_run`(`drp_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ADD CONSTRAINT `fk_supply_supply_replenishment_order_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_atp_rule_id` FOREIGN KEY (`atp_rule_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`atp_rule`(`atp_rule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ADD CONSTRAINT `fk_supply_consensus_demand_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ADD CONSTRAINT `fk_supply_constraint_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ADD CONSTRAINT `fk_supply_risk_register_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ADD CONSTRAINT `fk_supply_planning_exception_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ADD CONSTRAINT `fk_supply_inventory_projection_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ADD CONSTRAINT `fk_supply_demand_event_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ADD CONSTRAINT `fk_supply_otif_target_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ADD CONSTRAINT `fk_supply_atp_rule_fallback_atp_rule_id` FOREIGN KEY (`fallback_atp_rule_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`atp_rule`(`atp_rule_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ADD CONSTRAINT `fk_supply_planning_period_previous_planning_period_id` FOREIGN KEY (`previous_planning_period_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_period`(`planning_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_previous_planning_run_id` FOREIGN KEY (`previous_planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ADD CONSTRAINT `fk_supply_drp_run_drp_last_successful_run_id` FOREIGN KEY (`drp_last_successful_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`drp_run`(`drp_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ADD CONSTRAINT `fk_supply_drp_run_primary_previous_drp_run_id` FOREIGN KEY (`primary_previous_drp_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`drp_run`(`drp_run_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|locked');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
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
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Signal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|volatile');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `npd_launch_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Volume Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `promotional_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `statistical_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `variance_to_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance to Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Planner Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable to Promise (CTP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `demand_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Execution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `material_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Constraint Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|committed|executed|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'constrained|unconstrained|scenario|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planned_order_release_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Release Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planned_production_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planned_replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Replenishment Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Supply Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `projected_inventory_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Inventory Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_value_regex' = 'internal_production|external_procurement|transfer|contract_manufacturing');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `transportation_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Constraint Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `baseline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Cycle Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `tertiary_forecast_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `tertiary_forecast_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `tertiary_forecast_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Aggregation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `demand_sensing_applied` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Applied Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_source_system` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_active_version` SET TAGS ('dbx_business_glossary_term' = 'Is Active Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_final_approved_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Approved Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `mean_absolute_percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `new_product_introduction_included` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `promotional_events_included` SET TAGS ('dbx_business_glossary_term' = 'Promotional Events Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `statistical_model_applied` SET TAGS ('dbx_business_glossary_term' = 'Statistical Model Applied');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_business_glossary_term' = 'Forecast Time Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived|active');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_accuracy_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Planner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `absolute_percent_error` SET TAGS ('dbx_business_glossary_term' = 'Absolute Percent Error (APE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `accuracy_status` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `accuracy_status` SET TAGS ('dbx_value_regex' = 'on_target|below_target|above_target|not_measured');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `accuracy_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `bias_percent` SET TAGS ('dbx_business_glossary_term' = 'Bias Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `demand_sensing_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Applied Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `demand_volatility_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Volatility Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_error` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_value_regex' = 'statistical|machine_learning|consensus|manual|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `measurement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Measurement Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `new_product_flag` SET TAGS ('dbx_business_glossary_term' = 'New Product Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Measurement Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `out_of_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Out of Stock (OOS) Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percent (FA%)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `planning_level` SET TAGS ('dbx_value_regex' = 'sku_location|product_family|brand|category|total_company');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `promotional_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotional Period Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sensed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sensed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sensing_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Sensing Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sensing_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Sensing Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sensing_signal_source` SET TAGS ('dbx_business_glossary_term' = 'Sensing Signal Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `sensing_uplift_percent` SET TAGS ('dbx_business_glossary_term' = 'Sensing Uplift Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_accuracy` ALTER COLUMN `wmape` SET TAGS ('dbx_business_glossary_term' = 'Weighted Mean Absolute Percentage Error (WMAPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `customer_otif_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Customer OTIF Commitment Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cycle_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Cycle Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `fill_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `maximum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `minimum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `on_time_delivery_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `otif_composite_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Composite Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `penalty_clause_indicator` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `reorder_point_units` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'MRP|DRP|VMI|JIT|kanban|fixed_order_quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `retailer_mandated_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Retailer Mandated Target Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculated_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculated Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Planner Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Inventory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approved_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_daily_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Calculated Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `days_of_supply_target` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply Target');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_value_regex' = 'steady|seasonal|erratic|lumpy|intermittent|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Inventory Holding Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|under_revision|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Product Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `target_service_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Service Level Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Demand Variability Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score (Standard Normal Deviate)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `supply_replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `drp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Requirements Planning (DRP) Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `drp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Requirements Planning (DRP) Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_transit|received|cancelled|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|firmed|released');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`supply_replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Node Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_business_glossary_term' = 'Capacity Class');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large|mega');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `dsd_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|temporarily_closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|3pl_managed|co_manufacturer|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_value_regex' = 'pallets|cases|cubic_meters|square_meters');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Throughput Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_value_regex' = 'cases_per_day|pallets_per_day|units_per_day|tons_per_day');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_primary_lane` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Lane Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lane Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `processing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transportation Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Rule ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `regulatory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|cumulative|multi_level|product_allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_check_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Check Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_date` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_value_regex' = 'available|constrained|blocked|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ATP Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable-to-Promise (CTP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `demand_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `forecast_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Consumption Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `intransit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `minimum_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `on_hand_inventory` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Inventory Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planned_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planning_version` SET TAGS ('dbx_business_glossary_term' = 'Planning Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `product_allocation_group` SET TAGS ('dbx_business_glossary_term' = 'Product Allocation Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `production_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `purchase_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `supply_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Supply Pegging Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_quinary_sop_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_quinary_sop_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_quinary_sop_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_sop_supply_planner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Planner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_sop_supply_planner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `tertiary_sop_supply_planner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `baseline_demand_volume` SET TAGS ('dbx_business_glossary_term' = 'Baseline Demand Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `consensus_demand_volume` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `constrained_supply_volume` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_locked_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Locked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Cycle Locked Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_notes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_business_glossary_term' = 'Cycle Phase');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_value_regex' = 'statistical_forecast|demand_review|supply_review|pre_sop|executive_sop|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|rolling|event_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_consensus_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Consensus Achieved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `demand_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Review Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Executive Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `executive_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Executive S&OP Meeting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `frozen_period_months` SET TAGS ('dbx_business_glossary_term' = 'Frozen Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `key_risks` SET TAGS ('dbx_business_glossary_term' = 'Key Risks');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Months');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `planning_month` SET TAGS ('dbx_business_glossary_term' = 'Planning Month');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `pre_sop_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-S&OP Meeting Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `statistical_forecast_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statistical Forecast Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_consensus_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Supply Consensus Achieved Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_gap_volume` SET TAGS ('dbx_business_glossary_term' = 'Supply Gap Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sop_cycle` ALTER COLUMN `supply_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Review Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `tertiary_consensus_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `tertiary_consensus_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `tertiary_consensus_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `bias_indicator` SET TAGS ('dbx_value_regex' = 'over_forecast|under_forecast|neutral');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Planning Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `constrained_flag` SET TAGS ('dbx_business_glossary_term' = 'Constrained Demand Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `constraint_reason` SET TAGS ('dbx_business_glossary_term' = 'Constraint Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `customer_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Customer Commitment Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_category` SET TAGS ('dbx_value_regex' = 'base|promotional|seasonal|new_launch|phase_out|special_order');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_driver_description` SET TAGS ('dbx_business_glossary_term' = 'Demand Driver Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `demand_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Demand Volatility Index');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `forecast_accuracy_previous_period` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Previous Period');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `forecast_model_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `new_product_launch_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `statistical_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `unconstrained_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unconstrained Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `variance_to_statistical` SET TAGS ('dbx_business_glossary_term' = 'Variance to Statistical Forecast');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`consensus_demand` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Constraint Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Planner Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|priority_based|fair_share|customer_tier|strategic_account');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constrained_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'Constrained Resource Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_business_glossary_term' = 'Constraint Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_value_regex' = 'identified|active|mitigated|resolved|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'capacity|material|labor|regulatory|supplier|transportation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Constraint Duration in Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Constraint End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|team_lead|director|vp|executive');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `mitigation_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Effectiveness Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Constraint Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Constraint Quantity Available');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Constraint Quantity Required');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `quantity_shortfall` SET TAGS ('dbx_business_glossary_term' = 'Constraint Quantity Shortfall');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'demand_spike|supply_disruption|quality_issue|capacity_limitation|forecast_error|external_event');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Constraint Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Constraint Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`constraint` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Risk Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `tertiary_risk_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `affected_node_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Node List');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `affected_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) List');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Assessed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Contingency Cost Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contingency Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `contingency_stock_uom` SET TAGS ('dbx_business_glossary_term' = 'Contingency Stock Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `impact_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `mitigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `probability_score` SET TAGS ('dbx_business_glossary_term' = 'Probability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supplier|logistics|geopolitical|regulatory|natural_disaster|quality');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_number` SET TAGS ('dbx_value_regex' = '^RISK-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'identified|assessed|active|mitigated|closed|monitoring');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`risk_register` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` SET TAGS ('dbx_subdomain' = 'risk_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `planning_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Exception Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Planner Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `tertiary_planning_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `tertiary_planning_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `tertiary_planning_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `auto_resolution_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Resolution Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `business_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `business_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'capacity|material|transportation|supplier|labor|equipment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `demand_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|executive');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Occurrence Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_quantity` SET TAGS ('dbx_business_glossary_term' = 'Exception Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_recurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Recurrence Count');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|assigned|in_progress|resolved|closed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Detection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'oos_risk|excess_inventory|late_replenishment|unmet_demand|capacity_breach|safety_stock_breach');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `gap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply-Demand Gap Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `planning_horizon_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Exception Priority Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `projected_inventory_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Inventory Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Action');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Duration in Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Resolution Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'demand_spike|supply_disruption|forecast_error|capacity_limitation|lead_time_delay|quality_issue');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `safety_stock_target` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Target Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `supply_plan_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Planning Parameter ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `product_lca_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lca Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `backorder_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `coverage_profile_days` SET TAGS ('dbx_business_glossary_term' = 'Coverage Profile Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `critical_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'steady|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `fixed_lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Processing Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|weighted_average|standard_cost');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_value_regex' = 'fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_stock_level_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'mrp|reorder_point|forecast_based|time_phased|no_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `order_multiple_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_notes` SET TAGS ('dbx_business_glossary_term' = 'Parameter Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external_procurement|in_house_production|both|subcontracting');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `rounding_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Rounding Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'fixed_quantity|days_of_supply|dynamic_calculation|service_level_based');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `seasonality_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `inventory_projection_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Projection ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable-to-Promise (CTP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply (DOS)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `excess_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Inventory Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `oos_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Stock (OOS) Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `planning_run_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `planning_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projected_available_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Available Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projected_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Projected Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projected_on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Projected On-Hand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projected_on_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Projected On-Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projected_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Projected Receipt Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Projection Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_date` SET TAGS ('dbx_business_glossary_term' = 'Projection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_notes` SET TAGS ('dbx_business_glossary_term' = 'Projection Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_status` SET TAGS ('dbx_business_glossary_term' = 'Projection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|superseded|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_type` SET TAGS ('dbx_business_glossary_term' = 'Projection Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_type` SET TAGS ('dbx_value_regex' = 'baseline|constrained|optimized|scenario|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `projection_version` SET TAGS ('dbx_business_glossary_term' = 'Projection Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_projection` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `demand_event_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Planner Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `cannibalization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Cannibalization Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Product Discontinuation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_end_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Event End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_start_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|planned|approved|active|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'trade_promotion|new_product_launch|product_discontinuation|price_change|seasonal_event|market_expansion');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `initial_stocking_quantity` SET TAGS ('dbx_business_glossary_term' = 'Initial Stocking Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `last_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `launch_channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Launch Channel Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `market_geography_code` SET TAGS ('dbx_business_glossary_term' = 'Market Geography Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `market_geography_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `planning_run_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `price_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `price_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `price_elasticity_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Price Elasticity Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `promotion_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Promotion Funding Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `promotion_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `ramp_up_weeks` SET TAGS ('dbx_business_glossary_term' = 'Ramp-Up Period Weeks');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `supply_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Readiness Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `supply_readiness_status` SET TAGS ('dbx_value_regex' = 'not_ready|at_risk|ready|confirmed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `volume_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Impact Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_event` ALTER COLUMN `volume_impact_units` SET TAGS ('dbx_business_glossary_term' = 'Volume Impact Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `otif_target_id` SET TAGS ('dbx_business_glossary_term' = 'On-Time-In-Full (OTIF) Target ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'retail|wholesale|dtc|ecommerce|foodservice|export');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `delivery_tolerance_hours` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `escalation_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `in_full_fill_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'In-Full Fill Rate Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `on_time_delivery_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `otif_composite_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time-In-Full (OTIF) Composite Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `penalty_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `penalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `quantity_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Quantity Tolerance Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `retailer_mandated_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Retailer-Mandated Target Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `sla_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'OTIF Target Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'OTIF Target Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_notes` SET TAGS ('dbx_business_glossary_term' = 'Target Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Target Owner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'OTIF Target Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`otif_target` ALTER COLUMN `target_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `atp_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Rule Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `fallback_atp_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Atp Rule Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `fallback_atp_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `action_expression` SET TAGS ('dbx_business_glossary_term' = 'Action Expression');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `atp_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `max_allocation_qty` SET TAGS ('dbx_business_glossary_term' = 'Max Allocation Qty');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `min_allocation_qty` SET TAGS ('dbx_business_glossary_term' = 'Min Allocation Qty');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `safety_stock_factor` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Factor');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `atp_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `previous_planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Planning Period Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `previous_planning_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `planning_period_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `is_historical` SET TAGS ('dbx_business_glossary_term' = 'Is Historical');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `planning_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `previous_planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Planning Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `previous_planning_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `outcome_metric` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Planning Algorithm');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Run Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_priority` SET TAGS ('dbx_business_glossary_term' = 'Run Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `success_flag` SET TAGS ('dbx_business_glossary_term' = 'Success Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `drp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Drp Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `drp_last_successful_run_id` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `primary_previous_drp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Drp Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `primary_previous_drp_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `data_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Data Snapshot Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Run Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration Seconds');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Run Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `drp_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`drp_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
