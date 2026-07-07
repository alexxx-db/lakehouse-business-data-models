-- Metric views for domain: manufacturing | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch manufacturing performance metrics covering yield, scrap, quality release, GMP compliance, and cost variance. Critical for pharmaceutical/CPG manufacturing governance, regulatory compliance, and cost management."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level batch performance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level batch analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level batch yield and quality analysis."
    - name: "batch_status"
      expr: batch_status
      comment: "Current batch status (e.g., Released, On Hold, Rejected) for operational filtering."
    - name: "manufacture_date"
      expr: manufacture_date
      comment: "Date of manufacture for time-series batch performance trending."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "GMP compliance flag for compliance rate analysis."
    - name: "quality_release_flag"
      expr: quality_release_flag
      comment: "Quality release status for released vs. unreleased batch analysis."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Recall flag for identifying batches subject to recall — critical risk dimension."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Brand identifier for brand-level batch quality and yield reporting."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of batch manufacturing costs."
  measures:
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage. Primary manufacturing efficiency KPI — low yield drives material cost increases and capacity shortfalls. Executives use this to benchmark facilities and trigger process improvement."
    - name: "total_manufactured_quantity"
      expr: SUM(CAST(manufactured_quantity AS DOUBLE))
      comment: "Total manufactured quantity across batches. Core production volume KPI for supply planning and capacity utilization reporting."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across batches. Directly tied to material waste cost and sustainability targets. Drives scrap reduction programs."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity. Rework is a hidden cost driver and quality risk indicator — used to prioritize process improvement investments."
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual manufacturing cost across batches. Core financial KPI for cost of goods sold and manufacturing variance analysis."
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard manufacturing cost across batches. Used as denominator in cost variance analysis."
    - name: "batch_count"
      expr: COUNT(1)
      comment: "Total number of batches. Used for throughput analysis and as denominator for per-batch KPI calculations."
    - name: "gmp_deviation_batches"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Number of batches with GMP deviations. Regulatory compliance KPI — high deviation counts trigger regulatory risk escalation and audit readiness reviews."
    - name: "quality_released_batches"
      expr: COUNT(CASE WHEN quality_release_flag = TRUE THEN 1 END)
      comment: "Number of quality-released batches. Measures throughput of the quality release process — bottlenecks here delay customer shipments."
    - name: "recall_flagged_batches"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of batches flagged for recall. Critical risk KPI — any non-zero value triggers executive escalation and regulatory notification processes."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage at batch level. Provides batch-granularity OEE view complementing the OEE record-level view."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across all batches. Alternate production volume measure for cross-validation with manufactured_quantity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_changeover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Changeover efficiency metrics tracking actual vs. standard changeover duration, SMED improvement opportunities, and OEE impact. Used by operations and lean manufacturing teams to reduce changeover time and improve line flexibility."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`changeover`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level changeover benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level changeover analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center for granular changeover attribution."
    - name: "changeover_type"
      expr: changeover_type
      comment: "Changeover type (e.g., flavor, format, cleaning) for type-specific efficiency analysis."
    - name: "changeover_status"
      expr: changeover_status
      comment: "Changeover status for filtering completed vs. in-progress records."
    - name: "from_sku_id"
      expr: from_sku_id
      comment: "SKU being changed from — identifies high-changeover-time product transitions."
    - name: "to_sku_id"
      expr: to_sku_id
      comment: "SKU being changed to — used with from_sku_id to identify problematic product sequence pairs."
    - name: "smed_improvement_flag"
      expr: smed_improvement_flag
      comment: "Flag indicating SMED improvement opportunity — used to track lean program progress."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level changeover performance comparison."
  measures:
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual changeover duration in minutes. Primary changeover efficiency KPI — compared against standard to identify improvement opportunities. SMED programs target ≤10 minutes."
    - name: "avg_standard_duration_minutes"
      expr: AVG(CAST(standard_duration_minutes AS DOUBLE))
      comment: "Average standard (target) changeover duration. Benchmark for actual vs. standard variance analysis."
    - name: "total_variance_minutes"
      expr: SUM(CAST(variance_minutes AS DOUBLE))
      comment: "Total changeover time variance (actual minus standard) in minutes. Aggregate measure of changeover inefficiency — directly reduces available production time and OEE availability."
    - name: "total_material_waste_kg"
      expr: SUM(CAST(material_waste_kg AS DOUBLE))
      comment: "Total material waste generated during changeovers in kilograms. Sustainability and cost KPI — changeover waste is a significant contributor to total manufacturing waste."
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage per changeover. Quantifies the OEE availability loss attributable to changeovers — key input to scheduling optimization."
    - name: "changeover_count"
      expr: COUNT(1)
      comment: "Total number of changeovers. Frequency KPI — high changeover frequency with small batch sizes indicates scheduling inefficiency."
    - name: "smed_improvement_opportunities"
      expr: COUNT(CASE WHEN smed_improvement_flag = TRUE THEN 1 END)
      comment: "Number of changeovers flagged as SMED improvement opportunities. Tracks lean manufacturing program pipeline and prioritization."
    - name: "avg_first_pass_yield_percentage"
      expr: AVG(CAST(first_pass_yield_percentage AS DOUBLE))
      comment: "Average first-pass yield percentage following changeover. Low first-pass yield after changeover indicates setup quality issues — drives changeover procedure improvement."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing downtime event metrics covering duration, financial impact, root cause distribution, and safety incidents. Used by operations leadership to prioritize maintenance investments and reduce production losses."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level downtime benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level downtime root cause analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center for granular downtime attribution."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Downtime category (e.g., mechanical, electrical, process) for Pareto analysis of downtime causes."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Downtime type for planned vs. unplanned segmentation."
    - name: "is_planned"
      expr: is_planned
      comment: "Flag distinguishing planned maintenance downtime from unplanned failures."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level for prioritizing high-impact downtime events."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for systematic failure mode analysis."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag for downtime events associated with safety incidents — critical risk dimension."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific downtime reason code for detailed cause analysis."
  measures:
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes. Primary production loss KPI — directly impacts OEE availability rate and capacity utilization. Executives use this to justify maintenance capital expenditure."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of downtime events. Monetizes production losses for executive decision-making on maintenance investment vs. production loss trade-offs."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime. Directly links downtime to supply shortfall and customer service risk."
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Total number of downtime events. Frequency KPI — high frequency with short duration indicates chronic micro-stop issues vs. infrequent catastrophic failures."
    - name: "unplanned_downtime_events"
      expr: COUNT(CASE WHEN is_planned = FALSE THEN 1 END)
      comment: "Number of unplanned downtime events. Unplanned downtime is the primary reliability risk indicator — drives predictive maintenance investment decisions."
    - name: "safety_related_downtime_events"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of downtime events associated with safety incidents. Critical safety KPI — any non-zero value triggers safety review and regulatory reporting obligations."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime event duration in minutes. Distinguishes chronic short-duration issues from infrequent long-duration failures — informs maintenance strategy selection."
    - name: "distinct_affected_production_lines"
      expr: COUNT(DISTINCT production_line_id)
      comment: "Number of distinct production lines affected by downtime. Breadth-of-impact KPI — widespread downtime suggests systemic issues vs. isolated equipment failures."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and maintenance metrics covering OEE, MTBF, MTTR, maintenance cost, and calibration compliance. Used by asset management and operations leadership to optimize maintenance strategy and capital investment."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`equipment`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level equipment portfolio analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center for work-center-level equipment performance analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type for category-level asset performance benchmarking."
    - name: "equipment_status"
      expr: equipment_status
      comment: "Equipment status (e.g., Active, Under Maintenance, Decommissioned) for fleet availability analysis."
    - name: "compliance_gmp"
      expr: compliance_gmp
      comment: "GMP compliance flag for regulatory compliance segmentation of equipment."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for financial asset management analysis."
  measures:
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across equipment. Asset-level OEE KPI — identifies underperforming equipment for targeted improvement or replacement decisions."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across equipment. Benchmark for actual vs. target OEE gap analysis."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours. Reliability KPI — low MTBF drives predictive maintenance investment and equipment replacement decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours. Maintainability KPI — high MTTR indicates spare parts, skills, or procedure gaps that extend production downtime."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across equipment. Asset lifecycle cost KPI — used in repair vs. replace decisions and maintenance budget planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of equipment assets. Capital asset base KPI for depreciation and ROI analysis."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across equipment. Sustainability and operational cost KPI — drives energy efficiency investment decisions."
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets. Fleet size KPI for asset management and maintenance resource planning."
    - name: "avg_total_usage_hours"
      expr: AVG(CAST(total_usage_hours AS DOUBLE))
      comment: "Average total usage hours per equipment asset. Asset utilization KPI — low usage hours relative to capacity indicate underutilized assets."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_gmp_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMP (Good Manufacturing Practice) event metrics tracking deviation frequency, severity, regulatory notification requirements, and recall triggers. Critical for pharmaceutical/CPG regulatory compliance and quality governance."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`gmp_event`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level GMP compliance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level GMP event analysis."
    - name: "event_type"
      expr: event_type
      comment: "GMP event type (e.g., deviation, OOS, contamination) for event category analysis."
    - name: "event_severity"
      expr: event_severity
      comment: "Event severity for risk-based prioritization of GMP events."
    - name: "gmp_event_status"
      expr: gmp_event_status
      comment: "GMP event status (e.g., Open, Closed, Under Investigation) for pipeline management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systematic GMP failure mode analysis."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag for events requiring regulatory notification — critical compliance dimension."
    - name: "is_product_recall_trigger"
      expr: is_product_recall_trigger
      comment: "Flag for events that triggered a product recall — highest-severity risk dimension."
    - name: "event_date"
      expr: event_date
      comment: "Event date for time-series GMP compliance trending."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for product-level GMP event analysis."
  measures:
    - name: "gmp_event_count"
      expr: COUNT(1)
      comment: "Total number of GMP events. Primary regulatory compliance KPI — event frequency is a leading indicator of regulatory inspection risk and product quality issues."
    - name: "recall_trigger_events"
      expr: COUNT(CASE WHEN is_product_recall_trigger = TRUE THEN 1 END)
      comment: "Number of GMP events that triggered a product recall. Critical risk KPI — any non-zero value represents significant financial, regulatory, and brand risk."
    - name: "regulatory_notification_events"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of events requiring regulatory notification. Compliance obligation KPI — missed notifications create regulatory enforcement risk."
    - name: "recurrent_events"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring GMP events. Recurrence indicates CAPA ineffectiveness — a key quality system performance indicator."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity affected by GMP events. Quantifies the product volume at risk from GMP deviations — used in batch disposition and recall scope assessment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of GMP events. Composite risk KPI used to prioritize investigation resources and escalation decisions."
    - name: "distinct_affected_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs affected by GMP events. Breadth-of-impact KPI — widespread SKU impact suggests systemic process or material issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing facility master metrics covering capacity, GMP certification status, sustainability performance, and operational readiness. Used by operations executives and sustainability leaders to govern the global manufacturing network."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of manufacturing facility (e.g., primary, secondary, contract) — used to segment network capacity and compliance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the facility — used to filter active vs. inactive facilities."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located — enables geographic analysis of manufacturing network capacity and compliance."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., owned, leased, contract) — used to segment network strategy and cost analysis."
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "GMP certification status — critical regulatory compliance dimension for facility governance."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification status — quality management system compliance dimension."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 certification status — environmental management system compliance dimension."
    - name: "primary_product_category"
      expr: primary_product_category
      comment: "Primary product category manufactured at the facility — enables category-level network capacity analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of manufacturing facilities — baseline network scale metric."
    - name: "total_annual_capacity_units"
      expr: SUM(CAST(capacity_units_per_year AS DOUBLE))
      comment: "Total annual production capacity across all facilities — strategic network capacity KPI for supply planning and investment decisions."
    - name: "total_daily_production_capacity"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total daily production capacity across all facilities — operational capacity metric for short-term supply planning."
    - name: "gmp_certified_facility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with active GMP certification — regulatory compliance governance KPI for the manufacturing network."
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across all facilities in kWh — sustainability KPI for carbon footprint and energy efficiency programs."
    - name: "total_water_consumption_cubic_meters_per_year"
      expr: SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Total annual water consumption across all facilities — sustainability KPI for water stewardship programs and ESG reporting."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total manufacturing floor space in square feet — asset utilization metric for capacity planning and real estate strategy."
    - name: "mes_integrated_facility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mes_system_integrated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with MES system integration — digital manufacturing maturity KPI used to prioritize Industry 4.0 investment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) metrics tracking availability, performance, and quality rates across production lines and facilities. Core manufacturing efficiency KPI used in operational steering and capital investment decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`oee_record`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility identifier for facility-level OEE benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier for line-level OEE drill-down."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift for daily and weekly OEE trend analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code (e.g., A/B/C) to compare OEE performance across shifts."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being produced, enabling product-level OEE analysis."
    - name: "oee_status"
      expr: oee_status
      comment: "OEE record status for filtering validated vs. provisional records."
    - name: "record_date"
      expr: record_date
      comment: "Record date for time-series OEE reporting."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier for granular OEE analysis at the work center level."
  measures:
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_pct AS DOUBLE))
      comment: "Average OEE percentage across records. The primary manufacturing efficiency KPI — a composite of availability, performance, and quality. World-class target is ≥85%. Drives capital investment and improvement program decisions."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate. Measures the proportion of planned production time that equipment is actually available. Low availability signals maintenance or changeover issues."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate. Measures actual throughput vs. theoretical maximum speed. Identifies speed losses and micro-stops impacting output."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate. Measures the proportion of good units vs. total units produced. Directly linked to scrap cost and customer quality risk."
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good units produced across all records. Core throughput KPI used in capacity planning and sales order fulfillment analysis."
    - name: "total_units_rejected"
      expr: SUM(CAST(total_units_rejected AS DOUBLE))
      comment: "Total units rejected. Drives quality cost analysis and scrap reduction initiatives."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes. Quantifies production time lost to unplanned and planned stoppages — key input to maintenance strategy and OEE improvement programs."
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time in minutes. Denominator for availability calculations and capacity utilization reporting."
    - name: "total_rework_units"
      expr: SUM(CAST(rework_units AS DOUBLE))
      comment: "Total units requiring rework. Rework cost and quality risk indicator used in process improvement prioritization."
    - name: "total_scrap_weight_kg"
      expr: SUM(CAST(scrap_weight_kg AS DOUBLE))
      comment: "Total scrap weight in kilograms. Material waste KPI directly tied to cost of goods and sustainability targets."
    - name: "avg_changeover_time_minutes"
      expr: AVG(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Average changeover time per OEE record period. Changeover efficiency is a primary lever for improving availability and OEE."
    - name: "total_speed_loss_minutes"
      expr: SUM(CAST(speed_loss_minutes AS DOUBLE))
      comment: "Total speed loss minutes. Quantifies performance losses due to reduced operating speed — key input to SMED and lean manufacturing programs."
    - name: "total_quality_loss_minutes"
      expr: SUM(CAST(quality_loss_minutes AS DOUBLE))
      comment: "Total quality loss minutes. Time equivalent of quality defects — used to prioritize quality improvement investments."
    - name: "oee_record_count"
      expr: COUNT(1)
      comment: "Number of OEE records. Used as denominator for average calculations and to assess data completeness across shifts and lines."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing planned order metrics covering planned vs. safety stock quantities, conversion rates, and schedule adherence. Used by supply planning and operations to manage MRP output quality and production schedule stability."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`planned_order`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level planned order analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level planned order scheduling analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for product-level planned order demand analysis."
    - name: "order_status"
      expr: order_status
      comment: "Planned order status (e.g., Firmed, Open, Converted) for pipeline management."
    - name: "order_type"
      expr: order_type
      comment: "Order type for segmenting MRP-generated vs. manually created planned orders."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date for time-horizon analysis of production schedule."
    - name: "planned_end_date"
      expr: planned_end_date
      comment: "Planned end date for delivery commitment analysis."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Firmed flag distinguishing frozen planned orders from MRP-adjustable orders."
    - name: "demand_source_type"
      expr: demand_source_type
      comment: "Demand source type (e.g., Sales Order, Forecast) for demand-driven vs. forecast-driven production analysis."
  measures:
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity from MRP. Core supply planning KPI for capacity loading and material requirements analysis."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across planned orders. Inventory buffer KPI — used to assess working capital tied up in safety stock."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity. Replenishment trigger KPI for inventory policy analysis."
    - name: "planned_order_count"
      expr: COUNT(1)
      comment: "Total number of planned orders. MRP workload KPI — high planned order counts indicate fragmented scheduling or lot-size policy issues."
    - name: "firmed_planned_orders"
      expr: COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END)
      comment: "Number of firmed planned orders. Schedule stability KPI — proportion of firmed orders indicates production schedule freeze horizon adherence."
    - name: "converted_planned_orders"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of planned orders converted to production orders. MRP execution KPI — low conversion rates indicate planning-execution gaps."
    - name: "distinct_skus_planned"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with planned orders. Product mix breadth KPI for changeover and scheduling complexity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_process_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process parameter compliance and deviation metrics tracking in-spec rates, OOS events, and corrective action requirements. Used by quality engineers and process scientists to monitor critical process parameters and drive process capability improvements."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`process_parameter`"
  dimensions:
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center — enables granular process parameter analysis by process area."
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment — supports equipment-level process parameter compliance analysis."
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of process parameter (e.g., temperature, pressure, pH) — used to segment compliance analysis by parameter category."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the process parameter — enables parameter-level drill-down for process capability analysis."
    - name: "process_stage"
      expr: process_stage
      comment: "Process stage where the parameter was measured — used to identify which production stages have the highest deviation rates."
    - name: "in_spec_flag"
      expr: in_spec_flag
      comment: "Flag indicating whether the measurement was within specification — primary compliance dimension."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Out-of-specification flag — used to filter and count OOS events for regulatory reporting."
    - name: "measurement_timestamp"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement — enables monthly process compliance trending."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating whether the parameter deviation is regulatory reportable — used to track regulatory reporting obligations."
  measures:
    - name: "total_parameter_measurements"
      expr: COUNT(1)
      comment: "Total number of process parameter measurements — baseline measurement activity metric."
    - name: "in_spec_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_spec_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process parameter measurements within specification — primary process capability KPI used in quality and manufacturing reviews."
    - name: "oos_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN oos_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Out-of-specification rate — measures the frequency of process parameter excursions; high rates trigger process investigation and CAPA."
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average deviation percentage from target — measures the magnitude of process parameter drift for process capability analysis."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements requiring corrective action — measures the operational burden of process non-conformances."
    - name: "regulatory_reportable_oos_count"
      expr: SUM(CASE WHEN oos_flag = TRUE AND regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OOS measurements that are regulatory reportable — critical compliance risk KPI for regulatory affairs teams."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value — used to monitor process centering and drift over time."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation metrics covering actual labor, machine, and setup time vs. plan, scrap, yield, and OEE components at the operation level. Used by operations and finance for detailed manufacturing cost and efficiency analysis."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level confirmation analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center for operation-level performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for product-level confirmation analysis."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Confirmation type for segmenting partial vs. final confirmations."
    - name: "operation_status"
      expr: operation_status
      comment: "Operation status for filtering completed vs. in-progress operations."
    - name: "posting_date"
      expr: posting_date
      comment: "Posting date for financial period alignment of confirmation records."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for regulatory compliance segmentation."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Rework flag for isolating rework confirmations from standard production."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of confirmation labor and machine costs."
  measures:
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed production quantity. Core throughput KPI for production reporting and supply chain fulfillment."
    - name: "total_confirmed_yield_quantity"
      expr: SUM(CAST(confirmed_yield_quantity AS DOUBLE))
      comment: "Total confirmed yield quantity. Good output measure used in yield rate calculations."
    - name: "total_confirmed_scrap_quantity"
      expr: SUM(CAST(confirmed_scrap_quantity AS DOUBLE))
      comment: "Total confirmed scrap quantity. Material waste KPI at the operation level — used for scrap cost allocation."
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time in minutes. Labor efficiency KPI — compared against standard to identify labor cost variances."
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time in minutes. Machine utilization KPI for capacity planning and OEE analysis."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded in confirmations. Operational downtime KPI at the confirmation level."
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability percentage from confirmations. Operation-level availability KPI."
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance percentage from confirmations. Operation-level performance KPI."
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality percentage from confirmations. Operation-level quality KPI."
    - name: "confirmation_count"
      expr: COUNT(1)
      comment: "Total number of production confirmations. Used for throughput analysis and data completeness validation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics covering schedule adherence, cost variance, yield, scrap, and order fulfillment. Used by operations and finance leadership to manage manufacturing performance against plan."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level production order performance."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level order execution analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for product-level production order analysis."
    - name: "order_status"
      expr: order_status
      comment: "Production order status (e.g., Released, Confirmed, Closed) for pipeline and backlog analysis."
    - name: "order_type"
      expr: order_type
      comment: "Order type for segmenting standard vs. rework vs. special production orders."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date for time-series production planning analysis."
    - name: "scheduled_end_date"
      expr: scheduled_end_date
      comment: "Scheduled end date for on-time delivery analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of production order costs."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Brand for brand-level production volume and cost analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for regulatory compliance segmentation."
  measures:
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across orders. Core supply planning KPI for capacity and demand alignment."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (actually produced) quantity. Measures actual output vs. plan — gap to order_quantity reveals schedule adherence issues."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity from production orders. Used in plan vs. actual variance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost. Core financial KPI for COGS and manufacturing variance reporting."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned production cost. Used as denominator in cost variance analysis."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from production orders. Material waste KPI driving cost reduction and sustainability programs."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders. Efficiency KPI — below-target yield increases material cost and reduces effective capacity."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage at production order level. Provides order-granularity efficiency view for root cause analysis."
    - name: "production_order_count"
      expr: COUNT(1)
      comment: "Total number of production orders. Used for throughput and workload analysis."
    - name: "gmp_non_compliant_orders"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Number of production orders with GMP non-compliance. Regulatory risk KPI — non-zero values trigger quality investigation and potential batch disposition review."
    - name: "quality_inspection_required_orders"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Number of orders requiring quality inspection. Drives QC resource planning and release timeline forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and utilization metrics covering available capacity, utilization rate, standard rates, and energy consumption. Used by operations and finance for capacity planning and cost center rate setting."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`work_center`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility for facility-level work center portfolio analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line for line-level work center analysis."
    - name: "work_center_type"
      expr: work_center_type
      comment: "Work center type for category-level capacity analysis."
    - name: "work_center_status"
      expr: work_center_status
      comment: "Work center status for active vs. inactive capacity analysis."
    - name: "work_center_category"
      expr: work_center_category
      comment: "Work center category for grouping similar work centers in capacity planning."
    - name: "gmp_qualification_status"
      expr: gmp_qualification_status
      comment: "GMP qualification status for regulatory compliance capacity analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center for financial allocation of work center costs."
  measures:
    - name: "total_available_capacity_hours_per_day"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across work centers. Core capacity planning KPI — used to assess total manufacturing capacity and identify bottlenecks."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average work center utilization rate percentage. Capacity efficiency KPI — low utilization indicates overcapacity; high utilization (>85%) signals bottleneck risk."
    - name: "avg_standard_rate_per_hour"
      expr: AVG(CAST(standard_rate_per_hour AS DOUBLE))
      comment: "Average standard cost rate per hour across work centers. Used in production order cost estimation and variance analysis."
    - name: "total_energy_consumption_kwh_per_hour"
      expr: SUM(CAST(energy_consumption_kwh_per_hour AS DOUBLE))
      comment: "Total energy consumption rate across work centers. Sustainability and operational cost KPI for energy efficiency benchmarking."
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity per work center. Theoretical maximum capacity benchmark for utilization rate calculation."
    - name: "work_center_count"
      expr: COUNT(1)
      comment: "Total number of work centers. Fleet size KPI for capacity management and resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing yield metrics at the work center and batch level, covering actual vs. theoretical yield, scrap, rework, and cost impact of yield variance. Used by operations and finance to manage material efficiency and COGS."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`yield_record`"
  dimensions:
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center for granular yield performance analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for product-level yield benchmarking."
    - name: "record_date"
      expr: record_date
      comment: "Record date for time-series yield trending."
    - name: "batch_record_status"
      expr: batch_record_status
      comment: "Batch record status for filtering released vs. in-process yield records."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for regulatory compliance segmentation of yield records."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for shift-level yield comparison."
    - name: "yield_loss_reason_code"
      expr: yield_loss_reason_code
      comment: "Yield loss reason code for Pareto analysis of yield loss causes."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage. Primary material efficiency KPI — each percentage point below theoretical yield represents direct material cost loss. Drives formulation and process improvement investments."
    - name: "avg_theoretical_yield_percentage"
      expr: AVG(CAST(theoretical_yield_percentage AS DOUBLE))
      comment: "Average theoretical yield percentage. Benchmark for actual yield gap analysis."
    - name: "total_input_quantity"
      expr: SUM(CAST(input_quantity AS DOUBLE))
      comment: "Total input quantity across yield records. Used to calculate material consumption efficiency."
    - name: "total_output_quantity"
      expr: SUM(CAST(output_quantity AS DOUBLE))
      comment: "Total output quantity across yield records. Core production volume measure."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_qty AS DOUBLE))
      comment: "Total scrap quantity from yield records. Material waste KPI directly tied to COGS and sustainability targets."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity. Hidden cost driver — rework consumes capacity and increases per-unit cost."
    - name: "total_yield_variance_cost_impact"
      expr: SUM(CAST(yield_variance_cost_impact AS DOUBLE))
      comment: "Total financial cost impact of yield variance. Monetizes yield losses for executive decision-making on process improvement ROI."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average yield variance percentage (actual vs. theoretical). Negative variance indicates systematic process issues requiring investigation."
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Total number of yield records. Used for data completeness validation and as denominator for average calculations."
$$;
