-- Metric views for domain: manufacturing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level manufacturing performance metrics covering yield, scrap, OEE, cost variance, and GMP compliance. Primary KPI surface for production quality and efficiency steering."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g. Released, In-Process, Rejected) — primary filter for operational dashboards."
    - name: "manufacture_date"
      expr: manufacture_date
      comment: "Date the batch was manufactured — used for time-series trending of production KPIs."
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Alternate manufacturing date field — supports cross-system date alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which batch costs are denominated — required for multi-currency cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for batch quantities — ensures consistent volume comparisons."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "Flag indicating whether the batch met GMP compliance requirements — critical for regulatory reporting."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Flag indicating a GMP deviation was recorded on this batch — used to isolate non-conforming batches."
    - name: "quality_release_flag"
      expr: quality_release_flag
      comment: "Indicates whether the batch has been quality-released for distribution — gates downstream supply."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether this batch is subject to a product recall — highest-priority risk dimension."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether the batch is under a regulatory hold — blocks release and impacts supply."
    - name: "release_date"
      expr: release_date
      comment: "Date the batch was released — used to measure cycle time from manufacture to release."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the batch — used for shelf-life analysis and waste risk assessment."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/MES system identifier — supports multi-system reconciliation."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch records — baseline volume measure for production throughput analysis."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches — primary throughput volume KPI."
    - name: "total_manufactured_quantity"
      expr: SUM(CAST(manufactured_quantity AS DOUBLE))
      comment: "Total manufactured quantity — cross-validates against quantity_produced for reconciliation."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across batches — directly impacts material cost and yield efficiency."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity — indicates quality failures requiring reprocessing, driving cost and cycle time."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage — core production efficiency KPI used in QBRs and operational steering."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batches — top-tier manufacturing performance KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual manufacturing cost across batches — primary cost accountability measure."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard (planned) manufacturing cost — denominator for cost variance analysis."
    - name: "total_batch_size_actual"
      expr: SUM(CAST(batch_size_actual AS DOUBLE))
      comment: "Sum of actual batch sizes — used to compute actual vs planned batch size variance."
    - name: "total_batch_size_planned"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Sum of planned batch sizes — denominator for batch size attainment ratio."
    - name: "gmp_compliant_batch_count"
      expr: COUNT(CASE WHEN gmp_compliant = TRUE THEN 1 END)
      comment: "Count of GMP-compliant batches — numerator for GMP compliance rate, a regulatory KPI."
    - name: "gmp_deviation_batch_count"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Count of batches with GMP deviations — risk indicator for regulatory audit exposure."
    - name: "quality_released_batch_count"
      expr: COUNT(CASE WHEN quality_release_flag = TRUE THEN 1 END)
      comment: "Count of quality-released batches — measures release throughput and supply readiness."
    - name: "recall_batch_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Count of batches subject to recall — highest-severity quality and brand risk KPI."
    - name: "regulatory_hold_batch_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Count of batches under regulatory hold — directly impacts supply availability and compliance posture."
    - name: "distinct_skus_produced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs produced — measures product mix breadth across the production period."
    - name: "distinct_production_lines_used"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines utilized — supports capacity utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics covering schedule adherence, cost variance, yield, OEE, and order fulfillment. Core operational KPI view for manufacturing planning and control."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g. Released, Confirmed, Closed) — primary operational filter."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g. Standard, Rework, Trial) — used to segment performance by order category."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Planned start date of the production order — used for schedule adherence and planning horizon analysis."
    - name: "scheduled_end_date"
      expr: scheduled_end_date
      comment: "Planned end date of the production order — used to measure on-time completion."
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual start date of the production order — compared to scheduled start for lateness analysis."
    - name: "actual_end_date"
      expr: actual_end_date
      comment: "Actual end date of the production order — used to compute actual cycle time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost fields — required for multi-currency cost variance reporting."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates whether the production order met GMP compliance requirements."
    - name: "priority"
      expr: priority
      comment: "Priority level of the production order — used to analyze whether high-priority orders are completed on time."
    - name: "plant_code"
      expr: plant_code
      comment: "ERP plant code — used to segment production performance by manufacturing site."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP system identifier — supports multi-system data reconciliation."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders — baseline volume measure for production planning throughput."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders — measures planned output volume."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (actual) production quantity — measures actual output vs plan."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity on production orders — used as denominator for schedule attainment rate."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from production orders — key quality and waste KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across production orders — primary cost accountability measure."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across production orders — denominator for cost variance analysis."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across production orders — top-tier manufacturing efficiency KPI."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders — measures production quality and material efficiency."
    - name: "gmp_compliant_order_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of production orders meeting GMP compliance — numerator for GMP compliance rate."
    - name: "late_start_order_count"
      expr: COUNT(CASE WHEN actual_start_date > scheduled_start_date THEN 1 END)
      comment: "Count of orders that started later than scheduled — measures schedule adherence failures."
    - name: "late_finish_order_count"
      expr: COUNT(CASE WHEN actual_end_date > scheduled_end_date THEN 1 END)
      comment: "Count of orders that finished later than scheduled — key on-time delivery KPI for manufacturing."
    - name: "distinct_skus_in_orders"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs across production orders — measures product mix complexity in the planning horizon."
    - name: "distinct_facilities_producing"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of distinct manufacturing facilities with active production orders — supports network utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation (goods receipt / operation confirmation) metrics covering actual labor, machine time, OEE components, scrap, yield, and downtime. Operational efficiency KPI view for shop-floor performance management."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Status of the confirmed operation — used to filter completed vs in-progress confirmations."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of production confirmation (e.g. Partial, Final, Reversal) — segments confirmation volume by type."
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type of the confirmed operation — used to analyze time and cost by activity category."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the confirmation was posted to the ERP — primary time dimension for operational trending."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the operation was confirmed — enables shift-level performance benchmarking."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag on the confirmation — used to isolate non-compliant operations."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether this confirmation involved rework — used to quantify rework volume and cost."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this confirmation was reversed — used to identify data quality and process issues."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for confirmed quantities — ensures consistent volume comparisons."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/MES system — supports multi-system reconciliation."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of production confirmations — baseline measure of shop-floor transaction volume."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed as produced — primary output volume measure at the operation level."
    - name: "total_confirmed_yield_quantity"
      expr: SUM(CAST(confirmed_yield_quantity AS DOUBLE))
      comment: "Total yield quantity from confirmations — measures good output after quality filtering."
    - name: "total_confirmed_scrap_quantity"
      expr: SUM(CAST(confirmed_scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from confirmations — key waste and quality KPI at operation level."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity (alternate field) — cross-validates confirmed_scrap_quantity for reconciliation."
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time in minutes — measures labor consumption vs standard for efficiency analysis."
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time in minutes — measures machine utilization and throughput efficiency."
    - name: "total_actual_setup_time_minutes"
      expr: SUM(CAST(actual_setup_time_minutes AS DOUBLE))
      comment: "Total actual setup time in minutes — measures changeover efficiency and its impact on capacity."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime in minutes — critical availability KPI; directly reduces OEE and throughput."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed — used for workforce productivity and cost allocation analysis."
    - name: "total_machine_hours"
      expr: SUM(CAST(machine_hours AS DOUBLE))
      comment: "Total machine hours consumed — used for equipment utilization and depreciation allocation."
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability component — measures the proportion of scheduled time equipment is available."
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance component — measures speed efficiency relative to rated capacity."
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality component — measures the proportion of output meeting quality standards."
    - name: "rework_confirmation_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Count of confirmations involving rework — measures rework frequency as a quality failure indicator."
    - name: "gmp_non_compliant_confirmation_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Count of confirmations failing GMP compliance — regulatory risk KPI for shop-floor operations."
    - name: "distinct_production_lines_active"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines with confirmations — measures active line utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and reliability metrics covering OEE, MTBF, MTTR, maintenance cost, energy consumption, and calibration compliance. Supports asset management and capital investment decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment — primary filter for active vs inactive asset analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type/category of equipment — used to benchmark performance across equipment classes."
    - name: "department"
      expr: department
      comment: "Department owning the equipment — supports departmental cost and performance allocation."
    - name: "location_code"
      expr: location_code
      comment: "Physical location code of the equipment — used for facility-level asset analysis."
    - name: "compliance_gmp"
      expr: compliance_gmp
      comment: "Indicates whether the equipment is GMP-compliant — critical for regulated manufacturing environments."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset — used for financial asset management analysis."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the equipment — used for safety compliance and risk management reporting."
    - name: "next_maintenance_due"
      expr: next_maintenance_due
      comment: "Date when next maintenance is due — used to identify overdue maintenance and plan interventions."
    - name: "next_calibration_date"
      expr: next_calibration_date
      comment: "Date when next calibration is due — used to track calibration compliance across the asset fleet."
    - name: "install_date"
      expr: install_date
      comment: "Date the equipment was installed — used to compute asset age and remaining useful life."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/CMMS system — supports multi-system asset data reconciliation."
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets — baseline measure for fleet size and asset management scope."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of the equipment fleet — primary capital investment measure for asset management."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across the equipment fleet — key operational cost KPI for asset management."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across equipment — top-tier asset performance KPI used in executive dashboards."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across equipment — denominator for OEE attainment gap analysis."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours — measures equipment reliability; higher is better."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours — measures maintenance responsiveness; lower is better."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across the equipment fleet — sustainability and operational cost KPI."
    - name: "total_usage_hours"
      expr: SUM(CAST(total_usage_hours AS DOUBLE))
      comment: "Total cumulative usage hours across equipment — used for lifecycle and depreciation analysis."
    - name: "avg_capacity_value"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average rated capacity value across equipment — used to assess fleet capacity potential."
    - name: "gmp_compliant_equipment_count"
      expr: COUNT(CASE WHEN compliance_gmp = TRUE THEN 1 END)
      comment: "Count of GMP-compliant equipment assets — numerator for GMP compliance rate across the fleet."
    - name: "overdue_maintenance_count"
      expr: COUNT(CASE WHEN next_maintenance_due < CURRENT_DATE() THEN 1 END)
      comment: "Count of equipment assets with overdue maintenance — operational risk KPI requiring immediate action."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN next_calibration_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of equipment assets with overdue calibration — regulatory compliance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order metrics covering MRP-driven demand fulfillment, firming rates, exception management, and planning horizon coverage. Supports S&OP and supply planning decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`planned_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the planned order (e.g. Open, Firmed, Converted) — primary filter for planning pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g. Production, Purchase) — used to segment planning demand by procurement type."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Conversion status of the planned order — measures how many planned orders have been converted to production."
    - name: "demand_source_type"
      expr: demand_source_type
      comment: "Source of demand driving the planned order (e.g. Sales Order, Forecast) — used for demand mix analysis."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the order — primary time dimension for planning horizon analysis."
    - name: "planned_end_date"
      expr: planned_end_date
      comment: "Planned end date of the order — used to assess planning coverage and lead time."
    - name: "mrp_run_date"
      expr: mrp_run_date
      comment: "Date of the MRP run that generated this planned order — used to track planning cycle freshness."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Indicates whether the planned order has been firmed — measures planning stability and execution readiness."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag on the planned order — used to ensure regulated products are planned compliantly."
    - name: "planning_strategy_group"
      expr: planning_strategy_group
      comment: "Planning strategy group (e.g. Make-to-Stock, Make-to-Order) — segments planned orders by supply strategy."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g. In-house, External) — used to split planned demand between manufacturing and purchasing."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/IBP system — supports multi-system planning data reconciliation."
  measures:
    - name: "total_planned_orders"
      expr: COUNT(1)
      comment: "Total number of planned orders — baseline measure of MRP-generated demand volume."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all planned orders — measures planned output volume for the horizon."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across planned orders — measures buffer inventory investment in the plan."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity — measures the aggregate replenishment trigger level across the planning horizon."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Count of firmed planned orders — numerator for firming rate; measures planning stability and execution readiness."
    - name: "converted_order_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Count of planned orders converted to production orders — measures planning-to-execution conversion rate."
    - name: "exception_order_count"
      expr: COUNT(CASE WHEN exception_message_code IS NOT NULL AND exception_message_code <> '' THEN 1 END)
      comment: "Count of planned orders with MRP exception messages — measures planning exception backlog requiring planner action."
    - name: "distinct_skus_planned"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs in the planned order horizon — measures product mix breadth in the production plan."
    - name: "distinct_production_lines_planned"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines with planned orders — measures planned capacity utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing facility master metrics covering capacity, GMP certification, sustainability, and compliance posture. Supports network strategy, capital investment, and regulatory compliance decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of manufacturing facility (e.g. Primary, Contract, Pilot) — used to segment network performance by facility class."
    - name: "manufacturing_facility_status"
      expr: manufacturing_facility_status
      comment: "Current status of the facility (e.g. Active, Decommissioned) — primary filter for active network analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the facility — used to identify facilities available for production planning."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located — used for geographic network analysis and regulatory jurisdiction."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g. Owned, Leased, Contract) — used to segment network by asset ownership strategy."
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Indicates whether the facility holds GMP certification — critical for regulated product manufacturing eligibility."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality management certification status — used for quality system compliance reporting."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 environmental management certification status — used for sustainability compliance reporting."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Sustainability rating of the facility — used for ESG reporting and green manufacturing analysis."
    - name: "gmp_certification_date"
      expr: gmp_certification_date
      comment: "Date GMP certification was granted — used to track certification age and renewal planning."
    - name: "gmp_expiration_date"
      expr: gmp_expiration_date
      comment: "GMP certification expiration date — used to identify facilities at risk of certification lapse."
    - name: "last_audit_date"
      expr: last_audit_date
      comment: "Date of the last regulatory or quality audit — used to identify facilities overdue for audit."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of manufacturing facilities — baseline measure of network footprint."
    - name: "total_capacity_units_per_year"
      expr: SUM(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Total annual production capacity across the facility network — primary network capacity KPI for S&OP."
    - name: "total_production_capacity_units_per_day"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total daily production capacity across all facilities — used for short-term capacity planning."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total facility square footage across the network — used for real estate and capacity investment analysis."
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across facilities — primary sustainability and operational cost KPI."
    - name: "total_water_consumption_cubic_meters_per_year"
      expr: SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Total annual water consumption across facilities — ESG and environmental compliance KPI."
    - name: "gmp_certified_facility_count"
      expr: COUNT(CASE WHEN gmp_certified = TRUE THEN 1 END)
      comment: "Count of GMP-certified facilities — numerator for GMP certification rate across the network."
    - name: "iso_9001_certified_facility_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END)
      comment: "Count of ISO 9001 certified facilities — measures quality management system coverage across the network."
    - name: "iso_14001_certified_facility_count"
      expr: COUNT(CASE WHEN iso_14001_certified = TRUE THEN 1 END)
      comment: "Count of ISO 14001 certified facilities — measures environmental management system coverage."
    - name: "mes_integrated_facility_count"
      expr: COUNT(CASE WHEN mes_system_integrated = TRUE THEN 1 END)
      comment: "Count of facilities with MES integration — measures digital manufacturing maturity across the network."
    - name: "gmp_expiring_soon_count"
      expr: COUNT(CASE WHEN gmp_expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Count of facilities with GMP certification expiring within 90 days — proactive compliance risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line asset and performance metrics covering design capacity, OEE targets, changeover efficiency, energy consumption, and GMP classification. Supports line investment, scheduling, and operational excellence decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the production line (e.g. Active, Idle, Under Maintenance) — primary operational filter."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g. Filling, Packaging, Blending) — used to benchmark performance by line category."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the line — used to identify lines available for scheduling."
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the production line — determines which regulated products can be manufactured on this line."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line (e.g. Manual, Semi-Auto, Fully Automated) — used for productivity benchmarking."
    - name: "allergen_handling_flag"
      expr: allergen_handling_flag
      comment: "Indicates whether the line handles allergens — critical for product safety and scheduling constraints."
    - name: "scada_integration_enabled"
      expr: scada_integration_enabled
      comment: "Indicates whether SCADA integration is enabled — measures digital manufacturing maturity."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern of the production line — used to normalize capacity and throughput by operating hours."
    - name: "product_category_capability"
      expr: product_category_capability
      comment: "Product category the line is capable of producing — used for line-to-product assignment analysis."
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the line was commissioned — used to compute line age and remaining useful life."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/MES system — supports multi-system asset data reconciliation."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines — baseline measure of manufacturing capacity footprint."
    - name: "total_design_capacity"
      expr: SUM(CAST(design_capacity AS DOUBLE))
      comment: "Total design capacity across all production lines — measures theoretical maximum output of the line network."
    - name: "total_design_capacity_units_per_hour"
      expr: SUM(CAST(design_capacity_units_per_hour AS DOUBLE))
      comment: "Total design capacity in units per hour — used for hourly throughput planning and bottleneck analysis."
    - name: "avg_nominal_oee_target_percent"
      expr: AVG(CAST(nominal_oee_target_percent AS DOUBLE))
      comment: "Average nominal OEE target across production lines — benchmark for actual OEE gap analysis."
    - name: "avg_changeover_time_standard_minutes"
      expr: AVG(CAST(changeover_time_standard_minutes AS DOUBLE))
      comment: "Average standard changeover time in minutes — measures scheduling flexibility and SMED improvement opportunity."
    - name: "avg_scrap_rate_target_percent"
      expr: AVG(CAST(scrap_rate_target_percent AS DOUBLE))
      comment: "Average scrap rate target across lines — used to benchmark actual scrap rates against line-level targets."
    - name: "total_energy_consumption_kwh_per_unit"
      expr: SUM(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Total energy consumption per unit across lines — sustainability and operational efficiency KPI."
    - name: "avg_mean_time_between_failures_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average MTBF across production lines — measures line reliability; higher values indicate better asset health."
    - name: "avg_mean_time_to_repair_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average MTTR across production lines — measures maintenance responsiveness; lower values indicate faster recovery."
    - name: "allergen_line_count"
      expr: COUNT(CASE WHEN allergen_handling_flag = TRUE THEN 1 END)
      comment: "Count of lines with allergen handling capability — used for allergen scheduling constraint management."
    - name: "scada_enabled_line_count"
      expr: COUNT(CASE WHEN scada_integration_enabled = TRUE THEN 1 END)
      comment: "Count of SCADA-integrated lines — measures digital manufacturing coverage across the line network."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity, utilization, and compliance metrics. Supports shop-floor scheduling, capacity planning, and GMP qualification management decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current status of the work center (e.g. Active, Inactive, Under Qualification) — primary operational filter."
    - name: "work_center_type"
      expr: work_center_type
      comment: "Type of work center (e.g. Machine, Labor, Process) — used to segment capacity and cost by work center class."
    - name: "category"
      expr: category
      comment: "Category classification of the work center — used for grouping in capacity and cost analysis."
    - name: "gmp_qualification_status"
      expr: gmp_qualification_status
      comment: "GMP qualification status of the work center — determines eligibility for regulated product manufacturing."
    - name: "clean_room_class"
      expr: clean_room_class
      comment: "Clean room classification of the work center — used for product-to-work-center assignment in regulated environments."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category of the work center — used for capacity planning and bottleneck identification."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern of the work center — used to normalize available capacity by operating hours."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the work center is temperature-controlled — used for product-to-work-center compatibility analysis."
    - name: "humidity_controlled_flag"
      expr: humidity_controlled_flag
      comment: "Indicates whether the work center is humidity-controlled — used for environmental compliance analysis."
    - name: "requalification_due_date"
      expr: requalification_due_date
      comment: "Date when GMP requalification is due — used to proactively manage qualification compliance."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/MES system — supports multi-system work center data reconciliation."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers — baseline measure of shop-floor capacity node count."
    - name: "total_available_capacity_hours_per_day"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across all work centers — primary capacity planning KPI."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated capacity across work centers — measures theoretical maximum throughput of the shop floor."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate across work centers — key capacity efficiency KPI; low values indicate idle capacity."
    - name: "avg_standard_cycle_time_minutes"
      expr: AVG(CAST(standard_cycle_time_minutes AS DOUBLE))
      comment: "Average standard cycle time in minutes — used for throughput rate calculation and scheduling."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time in minutes — measures changeover efficiency and its impact on available capacity."
    - name: "avg_standard_rate_per_hour"
      expr: AVG(CAST(standard_rate_per_hour AS DOUBLE))
      comment: "Average standard cost rate per hour across work centers — used for production cost estimation and variance analysis."
    - name: "total_energy_consumption_kwh_per_hour"
      expr: SUM(CAST(energy_consumption_kwh_per_hour AS DOUBLE))
      comment: "Total energy consumption per hour across work centers — sustainability and operational cost KPI."
    - name: "gmp_qualified_work_center_count"
      expr: COUNT(CASE WHEN gmp_qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of GMP-qualified work centers — numerator for GMP qualification coverage rate across the shop floor."
    - name: "requalification_overdue_count"
      expr: COUNT(CASE WHEN requalification_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of work centers with overdue GMP requalification — regulatory compliance risk KPI requiring immediate action."
    - name: "avg_capacity_per_hour"
      expr: AVG(CAST(capacity_per_hour AS DOUBLE))
      comment: "Average capacity per hour across work centers — used for throughput benchmarking and bottleneck identification."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing Bill of Materials metrics covering component complexity, scrap factors, cost allocation, and compliance. Supports product cost management, formulation governance, and regulatory compliance decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the manufacturing BOM (e.g. Active, Obsolete, In Review) — primary filter for valid BOM analysis."
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Production, Engineering, Phantom) — used to segment BOM analysis by usage category."
    - name: "manufacturing_bom_status"
      expr: manufacturing_bom_status
      comment: "Manufacturing-specific BOM status — used to identify BOMs ready for production use."
    - name: "component_item_category"
      expr: component_item_category
      comment: "Category of the BOM component (e.g. Raw Material, Packaging, Semi-Finished) — used for material mix analysis."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Indicates whether the component is critical — used to prioritize supply risk management."
    - name: "allergen_flag"
      expr: allergen_flag
      comment: "Indicates whether the BOM contains allergen components — critical for product safety and labeling compliance."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the BOM contains hazardous materials — used for safety and regulatory compliance reporting."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the BOM — used for time-based BOM validity analysis."
    - name: "effective_until"
      expr: effective_until
      comment: "Effective end date of the BOM — used to identify BOMs approaching expiry."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification associated with the BOM — used for ESG and green product reporting."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source PLM/ERP system — supports multi-system BOM data reconciliation."
  measures:
    - name: "total_bom_records"
      expr: COUNT(1)
      comment: "Total number of manufacturing BOM records — baseline measure of formulation complexity and BOM portfolio size."
    - name: "total_component_quantity"
      expr: SUM(CAST(component_quantity AS DOUBLE))
      comment: "Total component quantity across all BOM lines — measures aggregate material requirement volume."
    - name: "total_base_quantity"
      expr: SUM(CAST(base_quantity AS DOUBLE))
      comment: "Total base quantity across BOMs — used as denominator for component yield and scrap rate calculations."
    - name: "avg_scrap_factor_percentage"
      expr: AVG(CAST(scrap_factor_percentage AS DOUBLE))
      comment: "Average scrap factor percentage across BOM components — measures planned material waste; drives cost and sustainability impact."
    - name: "avg_cost_allocation_percentage"
      expr: AVG(CAST(cost_allocation_percentage AS DOUBLE))
      comment: "Average cost allocation percentage across BOM components — used for product cost structure analysis."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across BOMs — used for production scheduling and inventory optimization."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN 1 END)
      comment: "Count of critical BOM components — measures supply chain risk exposure from critical material dependencies."
    - name: "allergen_bom_count"
      expr: COUNT(CASE WHEN allergen_flag = TRUE THEN 1 END)
      comment: "Count of BOMs containing allergen components — used for allergen management and labeling compliance."
    - name: "hazardous_material_bom_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Count of BOMs containing hazardous materials — used for safety compliance and regulatory reporting."
    - name: "distinct_skus_with_bom"
      expr: COUNT(DISTINCT primary_manufacturing_sku_id)
      comment: "Number of distinct SKUs with a manufacturing BOM — measures formulation coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing routing metrics covering standard times, lead times, yield, scrap, and cost. Supports process engineering, capacity planning, and standard cost management decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Current status of the routing (e.g. Active, Obsolete, In Review) — primary filter for valid routing analysis."
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing (e.g. Standard, Rework, Trial) — used to segment routing analysis by process category."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the routing — used to identify routings approved for production use."
    - name: "gmp_critical_flag"
      expr: gmp_critical_flag
      comment: "Indicates whether the routing contains GMP-critical operations — used for regulatory compliance analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "ERP plant code for the routing — used to segment routing performance by manufacturing site."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the routing — used for time-based routing validity analysis."
    - name: "effective_until"
      expr: effective_until
      comment: "Effective end date of the routing — used to identify routings approaching expiry."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency for routing cost fields — required for multi-currency standard cost analysis."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source ERP/PLM system — supports multi-system routing data reconciliation."
  measures:
    - name: "total_routings"
      expr: COUNT(1)
      comment: "Total number of routing records — baseline measure of process complexity and routing portfolio size."
    - name: "avg_run_time_per_unit_minutes"
      expr: AVG(CAST(run_time_per_unit_minutes AS DOUBLE))
      comment: "Average run time per unit in minutes — core process efficiency measure used for capacity planning and scheduling."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time in minutes across routings — measures changeover burden on production capacity."
    - name: "avg_changeover_time_minutes"
      expr: AVG(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Average changeover time in minutes — used for SMED improvement tracking and scheduling optimization."
    - name: "avg_total_standard_lead_time_hours"
      expr: AVG(CAST(total_standard_lead_time_hours AS DOUBLE))
      comment: "Average total standard lead time in hours — key supply planning input for order promising and MRP."
    - name: "avg_expected_yield_percentage"
      expr: AVG(CAST(expected_yield_percentage AS DOUBLE))
      comment: "Average expected yield percentage across routings — used to set production targets and cost standards."
    - name: "avg_expected_scrap_percentage"
      expr: AVG(CAST(expected_scrap_percentage AS DOUBLE))
      comment: "Average expected scrap percentage across routings — used for material requirement planning and cost estimation."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost amount across routings — used for product cost roll-up and standard cost management."
    - name: "avg_total_labor_time_minutes"
      expr: AVG(CAST(total_labor_time_minutes AS DOUBLE))
      comment: "Average total labor time in minutes per routing — used for workforce planning and labor cost estimation."
    - name: "avg_total_machine_time_minutes"
      expr: AVG(CAST(total_machine_time_minutes AS DOUBLE))
      comment: "Average total machine time in minutes per routing — used for machine capacity planning and OEE target setting."
    - name: "gmp_critical_routing_count"
      expr: COUNT(CASE WHEN gmp_critical_flag = TRUE THEN 1 END)
      comment: "Count of routings with GMP-critical operations — measures regulatory process complexity and compliance scope."
    - name: "distinct_skus_with_routing"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with an active routing — measures process coverage across the product portfolio."
$$;