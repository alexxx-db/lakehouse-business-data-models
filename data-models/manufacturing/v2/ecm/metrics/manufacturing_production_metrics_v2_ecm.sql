-- Metric views for domain: production | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production run performance covering OEE, yield, scrap, throughput, and cost efficiency. Used by operations VPs and plant managers to steer production performance and identify improvement opportunities."
  source: "`vibe_manufacturing_v1`.`production`.`production_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Current status of the production run (e.g. In Progress, Completed, Cancelled) for filtering active vs. historical runs."
    - name: "run_type"
      expr: run_type
      comment: "Classification of the production run type (e.g. Standard, Rework, Trial) to segment performance by run category."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities produced, enabling consistent cross-run comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are denominated, supporting multi-currency financial analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the production run, enabling analysis of high-priority vs. standard run performance."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_timestamp)
      comment: "Month bucket of the planned start timestamp for trend analysis of production run scheduling."
    - name: "actual_start_date"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month bucket of the actual start timestamp for trend analysis of production execution timing."
  measures:
    - name: "total_production_runs"
      expr: COUNT(1)
      comment: "Total number of production runs. Baseline volume metric used to normalize other KPIs and track production cadence."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across production runs. The primary manufacturing efficiency KPI combining availability, performance, and quality. Executives use this to benchmark plants and drive improvement programs."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage across runs. Measures the proportion of scheduled time the line was actually available, identifying downtime impact on capacity."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate percentage across runs. Measures how close actual throughput is to theoretical maximum speed, identifying speed losses."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate percentage across runs. Measures the proportion of output meeting quality standards, directly linking to customer satisfaction and rework costs."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate across production runs. Measures the proportion of input material converted to good output, a key driver of material cost efficiency."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage across production runs. High scrap rates signal quality or process issues requiring immediate operational intervention."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced across all runs. Core volume output metric used to measure production throughput against demand."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all runs. Used as the denominator for schedule attainment calculations."
    - name: "schedule_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Production schedule attainment rate (actual vs. planned quantity %). A critical operational KPI indicating how reliably the plant executes against the production plan. Below 95% triggers supply chain escalation."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all production runs. Directly quantifies material waste and drives cost reduction initiatives."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across production runs. Rework consumes capacity and signals process instability requiring root cause analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost across all runs. Core financial KPI for cost of goods manufactured, used in P&L and margin analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all production runs. Used as the baseline for cost variance analysis against actual costs."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus standard) across production runs. Positive variance indicates cost overrun; negative indicates favorable performance. A key financial control metric."
    - name: "avg_total_downtime_minutes"
      expr: AVG(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Average total downtime minutes per production run. Downtime is a primary driver of OEE loss and capacity reduction, requiring targeted maintenance and operational response."
    - name: "avg_throughput_rate"
      expr: AVG(CAST(throughput_rate AS DOUBLE))
      comment: "Average throughput rate across production runs. Measures units produced per unit time, a key capacity and efficiency indicator for production planning."
    - name: "avg_total_cycle_time_minutes"
      expr: AVG(CAST(total_cycle_time_minutes AS DOUBLE))
      comment: "Average total cycle time in minutes per production run. Cycle time reduction is a core lean manufacturing objective directly impacting capacity and lead time."
    - name: "avg_takt_time_minutes"
      expr: AVG(CAST(takt_time_minutes AS DOUBLE))
      comment: "Average takt time in minutes across production runs. Takt time represents the rate at which products must be produced to meet customer demand; deviations signal capacity misalignment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for production work orders covering schedule adherence, cost performance, quality, and WIP management. Used by production managers, cost controllers, and supply chain teams."
  source: "`vibe_manufacturing_v1`.`production`.`production_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g. Released, In Progress, Completed, Closed) for pipeline and backlog analysis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Standard, Rework, Repair) to segment performance by order category."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the work order, enabling analysis of high-priority order execution performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which work order costs are denominated."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for work order quantities."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of the planned start date for trend analysis of work order scheduling."
    - name: "planned_finish_month"
      expr: DATE_TRUNC('month', planned_finish_date)
      comment: "Month bucket of the planned finish date for delivery schedule analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of production work orders. Baseline volume metric for production load and backlog management."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual quantity produced across all work orders. Core output volume metric for production reporting."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all work orders. Used as denominator for schedule attainment calculations."
    - name: "work_order_schedule_attainment"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Work order schedule attainment rate (actual vs. planned quantity %). Measures execution reliability against the production plan; a primary operational KPI for plant management."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all production work orders. Core cost of goods manufactured metric for financial reporting and margin analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all production work orders. Baseline for cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Total production cost variance (actual minus standard). Positive variance signals cost overrun requiring management intervention; a key financial control KPI."
    - name: "avg_cost_variance_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE) - CAST(standard_cost AS DOUBLE))
      comment: "Average cost variance per work order. Normalizes cost overrun by order volume to identify systemic vs. isolated cost issues."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all work orders. Quantifies material waste and drives quality improvement and cost reduction programs."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage across work orders. A key quality KPI; high scrap rates trigger process investigations and corrective actions."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across production work orders. Measures combined availability, performance, and quality efficiency at the work order level."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate percentage across work orders. Measures material conversion efficiency; low yield directly increases cost of goods manufactured."
    - name: "total_wip_value"
      expr: SUM(CAST(wip_value AS DOUBLE))
      comment: "Total work-in-process inventory value across open work orders. A critical balance sheet metric; excessive WIP ties up working capital and signals production bottlenecks."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across active work orders. Measures overall production progress against plan, used in daily production meetings and escalation decisions."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time in minutes per work order. Cycle time is a fundamental lean metric; reductions directly improve throughput and customer lead time."
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(downtime_minutes AS DOUBLE))
      comment: "Average downtime minutes per work order. Downtime is the primary driver of OEE loss; tracking at work order level enables targeted maintenance prioritization."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time in minutes per work order. Setup time reduction (SMED) is a key lean initiative; high setup times reduce available production capacity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime analytics KPIs measuring production loss, MTTR, OEE impact, and recurrence patterns. Used by maintenance managers, plant directors, and reliability engineers to drive uptime improvement and prioritize maintenance investments."
  source: "`vibe_manufacturing_v1`.`production`.`production_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime event (e.g. Planned, Unplanned, External) for structured loss analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (e.g. Mechanical, Electrical, Quality Hold) to identify dominant failure modes."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Specific reason for the downtime event, enabling Pareto analysis of top downtime causes."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code assigned to the downtime event, supporting systematic root cause elimination programs."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the downtime event (e.g. Critical, Major, Minor) for prioritizing response and investment."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the downtime event, enabling accountability tracking and departmental performance benchmarking."
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month bucket of the shift date for trend analysis of downtime frequency and duration over time."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the downtime event is a recurring issue, enabling focus on chronic vs. sporadic failures."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline frequency metric for downtime trend analysis and reliability benchmarking."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes. The primary capacity loss metric; directly quantifies lost production time and drives maintenance investment decisions."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes. Measures mean time to restore (MTTR) proxy; high averages indicate slow repair response or complex failures."
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mttr_minutes AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in minutes across downtime events. A core reliability KPI; reducing MTTR is a primary maintenance excellence objective."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime events. Directly quantifies the volume impact of downtime on customer order fulfillment and revenue."
    - name: "total_production_loss_value"
      expr: SUM(CAST(production_loss_value AS DOUBLE))
      comment: "Total financial value of production lost due to downtime. Enables ROI calculation for maintenance investments and justifies capital expenditure on reliability improvements."
    - name: "avg_oee_impact"
      expr: AVG(CAST(impact_on_oee AS DOUBLE))
      comment: "Average OEE impact per downtime event. Quantifies how much each downtime event degrades overall equipment effectiveness, prioritizing events with highest OEE impact for elimination."
    - name: "total_oee_impact"
      expr: SUM(CAST(impact_on_oee AS DOUBLE))
      comment: "Total cumulative OEE impact across all downtime events. Measures the aggregate drag on plant efficiency from downtime, used in OEE improvement roadmap planning."
    - name: "recurring_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recurring = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are recurring. High recurrence rates indicate systemic failures not being permanently resolved, requiring root cause elimination programs."
    - name: "unplanned_downtime_events"
      expr: COUNT(CASE WHEN downtime_category = 'Unplanned' THEN 1 END)
      comment: "Count of unplanned downtime events. Unplanned downtime is the most disruptive category; tracking its frequency drives preventive maintenance investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level operational performance KPIs covering OEE, quality, throughput, downtime, and energy consumption. Used by shift supervisors, plant managers, and operations directors for daily performance management and trend analysis."
  source: "`vibe_manufacturing_v1`.`production`.`shift_report`"
  dimensions:
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month bucket of the shift date for trend analysis of shift performance over time."
    - name: "shift_date_week"
      expr: DATE_TRUNC('week', shift_date)
      comment: "Week bucket of the shift date for weekly operational performance reviews."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities reported in the shift."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating whether a safety incident occurred during the shift, enabling safety performance segmentation."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Flag indicating whether a quality hold was placed during the shift, enabling quality event analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flag indicating whether escalation was required during the shift, measuring operational exception frequency."
  measures:
    - name: "total_shifts_reported"
      expr: COUNT(1)
      comment: "Total number of shift reports. Baseline metric for shift reporting completeness and production cadence tracking."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across shifts. The headline manufacturing efficiency KPI combining availability, performance, and quality at the shift level for daily performance management."
    - name: "avg_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage across shifts. Measures the proportion of shift time the line was available for production."
    - name: "avg_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance rate percentage across shifts. Measures how close actual speed is to theoretical maximum, identifying speed loss patterns by shift."
    - name: "avg_quality_percentage"
      expr: AVG(CAST(quality_percentage AS DOUBLE))
      comment: "Average quality rate percentage across shifts. Measures the proportion of output meeting quality standards at the shift level."
    - name: "total_actual_good_quantity"
      expr: SUM(CAST(actual_good_quantity AS DOUBLE))
      comment: "Total good quantity produced across all shifts. The primary output volume metric for production reporting and customer order fulfillment tracking."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all shifts. Used as denominator for shift schedule attainment calculations."
    - name: "shift_schedule_attainment"
      expr: ROUND(100.0 * SUM(CAST(actual_good_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Shift-level schedule attainment rate (actual good quantity vs. planned quantity %). Measures daily execution reliability; below-target performance triggers immediate operational response."
    - name: "avg_yield_rate_percentage"
      expr: AVG(CAST(yield_rate_percentage AS DOUBLE))
      comment: "Average yield rate percentage across shifts. Measures material conversion efficiency at the shift level, enabling shift-to-shift quality comparison."
    - name: "avg_scrap_rate_percentage"
      expr: AVG(CAST(scrap_rate_percentage AS DOUBLE))
      comment: "Average scrap rate percentage across shifts. High scrap rates on specific shifts indicate operator, tooling, or process issues requiring targeted intervention."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all shifts. Quantifies material waste at the shift level for cost and quality management."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all shifts. Measures aggregate capacity loss from downtime events, a primary driver of OEE degradation."
    - name: "avg_downtime_minutes_per_shift"
      expr: AVG(CAST(downtime_minutes AS DOUBLE))
      comment: "Average downtime minutes per shift. Normalizes downtime by shift count to identify chronic downtime patterns and benchmark shift performance."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across all shifts. A key sustainability and cost metric; energy intensity per unit produced drives decarbonization and cost reduction programs."
    - name: "avg_throughput_rate_per_hour"
      expr: AVG(CAST(throughput_rate_per_hour AS DOUBLE))
      comment: "Average throughput rate per hour across shifts. Measures production speed efficiency; deviations from target takt time signal capacity or process issues."
    - name: "shifts_with_safety_incidents"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of shifts with safety incidents. Safety performance is a non-negotiable executive KPI; any upward trend triggers immediate safety program review."
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with safety incidents. Normalizes safety events by shift volume for benchmarking across plants and time periods."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs for production measuring receipt volumes, yield, scrap, and quality inspection rates. Used by production planners, quality managers, and supply chain teams to monitor production output quality and inventory accuracy."
  source: "`vibe_manufacturing_v1`.`production`.`production_goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt document (e.g. Posted, Reversed, Pending) for pipeline and accuracy analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type associated with the goods receipt, enabling analysis by receipt category."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) for inventory quality segmentation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of the posting date for trend analysis of goods receipt volumes over time."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the goods receipt for financial period-end reporting and inventory valuation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the goods receipt for annual production output and inventory reporting."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection was required for the receipt, enabling quality gate compliance analysis."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of production goods receipts. Baseline volume metric for production output posting activity."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received from production. Core output volume metric for production reporting and inventory replenishment tracking."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total ordered quantity across all production goods receipts. Used as denominator for receipt completeness calculations."
    - name: "receipt_completeness_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Receipt completeness rate (received vs. ordered quantity %). Measures how completely production work orders are fulfilled; below-target rates signal production shortfalls impacting customer orders."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity recorded at goods receipt. Quantifies end-of-production material waste for cost and quality management."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage at goods receipt. Measures the proportion of production output that passes quality gates, a key indicator of process capability."
    - name: "quality_inspection_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts requiring quality inspection. High rates indicate quality risk in the production process and drive inspection resource planning."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were reversed. High reversal rates indicate posting errors or quality rejections, signaling process or system issues requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials consumption KPIs measuring material usage efficiency, cost variance, and scrap at the production order level. Used by production engineers, cost controllers, and supply chain planners to optimize material utilization and reduce waste."
  source: "`vibe_manufacturing_v1`.`production`.`bom_consumption`"
  dimensions:
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the BOM consumption record (e.g. Posted, Reversed, Pending) for data completeness analysis."
    - name: "consumption_type"
      expr: consumption_type
      comment: "Type of material consumption (e.g. Backflush, Manual, Automatic) to analyze consumption method efficiency."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the consumption, enabling analysis by goods issue category."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for consumed quantities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which consumption costs are denominated."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month bucket of the posting date for trend analysis of material consumption over time."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Flag indicating whether consumption was recorded via backflushing, enabling analysis of automated vs. manual consumption accuracy."
  measures:
    - name: "total_consumption_records"
      expr: COUNT(1)
      comment: "Total number of BOM consumption records. Baseline volume metric for material posting activity."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual material quantity consumed. Core material usage metric for production cost accounting and inventory management."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity across all consumption records. Used as denominator for material usage variance calculations."
    - name: "material_usage_variance"
      expr: SUM((CAST(actual_quantity AS DOUBLE)) - (CAST(planned_quantity AS DOUBLE)))
      comment: "Total material usage variance (actual minus planned quantity). Positive variance indicates over-consumption; a key cost driver requiring process investigation and corrective action."
    - name: "material_usage_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(actual_quantity AS DOUBLE)) - SUM(CAST(planned_quantity AS DOUBLE))) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Material usage variance rate as a percentage of planned quantity. Normalizes variance by plan to enable cross-material and cross-period benchmarking."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual material cost consumed. Core cost of goods manufactured component; drives material cost variance analysis and standard cost updates."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard material cost across all consumption records. Baseline for cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(standard_cost AS DOUBLE)))
      comment: "Total material cost variance (actual minus standard). Quantifies the financial impact of material usage and price deviations from standard, a key manufacturing cost control KPI."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from BOM consumption. Measures material waste at the component level, enabling targeted scrap reduction programs by material and operation."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance across all BOM consumption records. Aggregates all material quantity deviations for period-end variance reporting and standard cost review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production scheduling KPIs measuring plan adherence, capacity utilization, and schedule stability. Used by production planners, supply chain managers, and operations directors to optimize scheduling and ensure on-time delivery."
  source: "`vibe_manufacturing_v1`.`production`.`production_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the production schedule (e.g. Planned, Released, Completed, Cancelled) for pipeline analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (e.g. MRP, Manual, APS) to analyze planning method effectiveness."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "Planning strategy applied (e.g. Make-to-Stock, Make-to-Order) for demand-driven performance segmentation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for scheduled quantities."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled start date for trend analysis of production scheduling activity."
    - name: "scheduled_finish_month"
      expr: DATE_TRUNC('month', scheduled_finish_date)
      comment: "Month bucket of the scheduled finish date for delivery schedule analysis."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Flag indicating whether the schedule has been firmed (frozen), enabling analysis of planning stability and nervousness."
  measures:
    - name: "total_scheduled_orders"
      expr: COUNT(1)
      comment: "Total number of production schedule records. Baseline metric for production planning load and schedule volume."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all schedule records. Core capacity demand metric for production planning and resource allocation."
    - name: "total_capacity_requirement_hours"
      expr: SUM(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Total capacity requirement in hours across all scheduled orders. Measures aggregate production load against available capacity, the primary input for capacity planning decisions."
    - name: "avg_capacity_requirement_hours"
      expr: AVG(CAST(capacity_requirement_hours AS DOUBLE))
      comment: "Average capacity requirement per scheduled order. Enables comparison of order complexity and resource intensity across product types and planning periods."
    - name: "total_run_time_hours"
      expr: SUM(CAST(run_time_hours AS DOUBLE))
      comment: "Total planned run time in hours across all scheduled orders. Measures the aggregate machine and labor time required to execute the production plan."
    - name: "total_setup_time_hours"
      expr: SUM(CAST(setup_time_hours AS DOUBLE))
      comment: "Total planned setup time in hours across all scheduled orders. Setup time is non-value-added capacity consumption; high totals drive SMED improvement initiatives."
    - name: "setup_to_run_time_ratio"
      expr: ROUND(100.0 * SUM(CAST(setup_time_hours AS DOUBLE)) / NULLIF(SUM(CAST(run_time_hours AS DOUBLE)), 0), 2)
      comment: "Setup time as a percentage of run time. High ratios indicate excessive changeover overhead reducing productive capacity; a key lean manufacturing efficiency metric."
    - name: "total_lot_size_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total lot size quantity across all scheduled orders. Measures aggregate batch sizes for inventory and flow efficiency analysis."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size per scheduled order. Lot size optimization balances setup costs against inventory carrying costs; a key supply chain efficiency lever."
    - name: "firmed_schedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN firmed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled orders that have been firmed. Low firming rates indicate planning instability (schedule nervousness), which disrupts procurement and production execution."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and efficiency KPIs measuring utilization, OEE baseline, and operational readiness. Used by production managers and capacity planners to optimize work center allocation and identify bottlenecks."
  source: "`vibe_manufacturing_v1`.`production`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Operational status of the work center (e.g. Active, Inactive, Under Maintenance) for capacity availability analysis."
    - name: "work_center_category"
      expr: work_center_category
      comment: "Category of the work center (e.g. Machine, Labor, Process) for capacity planning segmentation."
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category assigned to the work center for capacity requirements planning (CRP) analysis."
    - name: "scheduling_type"
      expr: scheduling_type
      comment: "Scheduling type of the work center (e.g. Finite, Infinite) for production scheduling strategy analysis."
    - name: "mes_integration_enabled"
      expr: mes_integration_enabled
      comment: "Flag indicating whether MES integration is enabled, enabling analysis of digital vs. manual work centers."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers. Baseline capacity asset count for production network planning."
    - name: "total_available_capacity_per_shift"
      expr: SUM(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Total available capacity per shift across all work centers. Measures aggregate production capacity available for scheduling, the primary input for capacity planning."
    - name: "avg_available_capacity_per_shift"
      expr: AVG(CAST(available_capacity_per_shift AS DOUBLE))
      comment: "Average available capacity per shift per work center. Enables benchmarking of work center capacity and identification of bottleneck resources."
    - name: "avg_oee_baseline_target"
      expr: AVG(CAST(oee_baseline_target_percent AS DOUBLE))
      comment: "Average OEE baseline target percentage across work centers. Represents the expected efficiency standard; gaps between target and actual OEE drive improvement program prioritization."
    - name: "avg_efficiency_rate"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average efficiency rate percentage across work centers. Measures how effectively work centers convert available time into productive output, a key capacity utilization KPI."
    - name: "avg_utilization_rate"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average utilization rate percentage across work centers. Measures the proportion of available capacity being used; low utilization signals overcapacity or scheduling inefficiency."
    - name: "avg_standard_setup_time_minutes"
      expr: AVG(CAST(standard_setup_time_minutes AS DOUBLE))
      comment: "Average standard setup time in minutes across work centers. High setup times reduce productive capacity; benchmarking drives SMED improvement targeting."
    - name: "avg_standard_processing_time_minutes"
      expr: AVG(CAST(standard_processing_time_minutes AS DOUBLE))
      comment: "Average standard processing time in minutes across work centers. Used for capacity requirements planning and lead time calculation."
    - name: "mes_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mes_integration_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work centers with MES integration enabled. Measures digital manufacturing maturity; low rates indicate data collection gaps affecting real-time production visibility."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level strategic KPIs covering OEE performance, energy consumption, carbon emissions, safety, and operational health. Used by plant directors, sustainability officers, and executive leadership for plant benchmarking and investment decisions."
  source: "`vibe_manufacturing_v1`.`production`.`production_plant`"
  dimensions:
    - name: "production_plant_status"
      expr: production_plant_status
      comment: "Operational status of the production plant (e.g. Active, Inactive, Under Construction) for portfolio analysis."
    - name: "plant_type"
      expr: plant_type
      comment: "Type of production plant (e.g. Assembly, Fabrication, Process) for cross-plant benchmarking by plant category."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plant is located for geographic performance analysis and regulatory reporting."
    - name: "region"
      expr: region
      comment: "Regional grouping of the plant for regional performance benchmarking and resource allocation decisions."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the plant is currently active, enabling filtering of operational vs. inactive plants."
  measures:
    - name: "total_plants"
      expr: COUNT(1)
      comment: "Total number of production plants. Baseline metric for production network footprint analysis."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE percentage across production plants. The headline plant efficiency KPI used by executives to benchmark plant performance and prioritize improvement investments."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target percentage across plants. Used as the benchmark for actual OEE performance gap analysis."
    - name: "oee_gap_vs_target"
      expr: AVG(CAST(oee_actual AS DOUBLE)) - AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE gap (actual minus target) across plants. Negative values indicate underperformance against plan; a primary KPI for plant improvement program prioritization."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across all plants. A key sustainability and cost metric; drives energy reduction programs and carbon footprint reporting."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg across all plants. A critical ESG metric reported to boards and regulators; drives decarbonization investment decisions."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons across all plants. A key sustainability KPI; high waste generation drives circular economy and waste reduction initiatives."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters across all plants. A sustainability and operational cost metric; drives water efficiency programs in water-stressed regions."
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Total production capacity in MW across all plants. Measures aggregate production network capacity for strategic capacity planning and investment decisions."
    - name: "active_plant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plants that are currently active. Measures production network utilization; low rates indicate idle capacity requiring rationalization or divestiture decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`production_wip_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-process lot KPIs measuring WIP inventory levels, quality holds, scrap, and lot cycle performance. Used by production managers, quality teams, and supply chain planners to manage WIP flow and minimize inventory risk."
  source: "`vibe_manufacturing_v1`.`production`.`wip_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the WIP lot (e.g. In Process, On Hold, Completed, Scrapped) for WIP pipeline analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for WIP lot quantities."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the WIP lot, enabling analysis of high-priority lot flow and cycle time."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flag indicating whether the lot is in rework, enabling rework volume and cost analysis."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating whether quality inspection is required for the lot, enabling quality gate compliance analysis."
    - name: "lot_creation_month"
      expr: DATE_TRUNC('month', lot_creation_timestamp)
      comment: "Month bucket of the lot creation timestamp for trend analysis of WIP lot creation volume over time."
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of WIP lots. Baseline metric for WIP inventory volume and production flow analysis."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in process across all WIP lots. Measures active WIP inventory level; high levels indicate production bottlenecks or flow imbalances."
    - name: "total_quantity_on_hold"
      expr: SUM(CAST(quantity_on_hold AS DOUBLE))
      comment: "Total quantity on quality or production hold across all WIP lots. Held inventory represents blocked working capital and potential scrap risk requiring urgent resolution."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed across all WIP lots. Measures production throughput from WIP to finished goods."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped across all WIP lots. Quantifies WIP material waste, a direct cost driver and quality indicator."
    - name: "wip_scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "WIP scrap rate (scrapped quantity as % of ordered quantity). Measures in-process quality loss; high rates signal process capability issues requiring engineering intervention."
    - name: "wip_hold_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_on_hold AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "WIP hold rate (held quantity as % of ordered quantity). High hold rates indicate quality or compliance issues blocking production flow and tying up working capital."
    - name: "rework_lot_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WIP lots requiring rework. Rework consumes capacity and signals process instability; high rates drive process improvement and root cause analysis."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all WIP lots. Used as the denominator for WIP efficiency rate calculations."
$$;