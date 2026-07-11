-- Metric views for domain: manufacturing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for production order execution: cost variance, yield performance, schedule adherence, and throughput. Used by manufacturing VPs and plant managers to steer production efficiency and cost control."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g. Released, Confirmed, Closed) — primary filter for in-flight vs. completed analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g. standard, rework, trial) — used to segment performance by order category."
    - name: "plant_code"
      expr: plant_code
      comment: "ERP plant code identifying the manufacturing site — enables facility-level benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which cost amounts are denominated — required for multi-currency cost analysis."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month bucket of the scheduled production start — supports trend analysis over time."
    - name: "scheduled_finish_date"
      expr: DATE_TRUNC('month', scheduled_finish_date)
      comment: "Month bucket of the scheduled production finish — used for on-time delivery trending."
    - name: "priority"
      expr: priority
      comment: "Production order priority level — allows segmentation of high-priority vs. standard orders."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates whether the production order met GMP compliance requirements — critical for regulated manufacturing."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether a quality inspection is required for this order — used to track inspection workload."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders — baseline volume metric for capacity and throughput analysis."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders — measures manufacturing throughput demand."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed as produced — measures actual output against planned demand."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity across production orders — directly impacts material cost and yield KPIs."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned production cost — baseline for cost variance and budget adherence analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred — compared against planned cost to compute cost variance."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(planned_cost AS DOUBLE))
      comment: "Aggregate cost variance (actual minus planned) — negative values indicate under-spend; positive values indicate cost overrun requiring management action."
    - name: "avg_cost_variance_per_order"
      expr: AVG(CAST(actual_cost AS DOUBLE) - CAST(planned_cost AS DOUBLE))
      comment: "Average cost variance per production order — normalizes cost overrun signal across order volumes for fair facility comparison."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across production orders — the primary manufacturing efficiency KPI used in executive steering reviews."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders — measures process efficiency and material utilization; low yield drives cost and waste investigations."
    - name: "total_scrap_cost_impact"
      expr: SUM(scrap_quantity * (actual_cost / NULLIF(order_quantity, 0)))
      comment: "Estimated cost of scrapped material (scrap quantity × unit actual cost) — quantifies financial impact of quality losses for prioritization decisions."
    - name: "gmp_non_compliance_order_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Number of production orders that failed GMP compliance — a regulatory risk KPI; any increase triggers immediate quality and compliance review."
    - name: "orders_requiring_quality_inspection"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Count of production orders flagged for quality inspection — drives quality lab capacity planning and release scheduling."
    - name: "confirmed_vs_planned_quantity_ratio"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually confirmed as produced — measures production plan attainment; below 95% triggers supply risk escalation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMP batch execution KPIs covering yield, scrap, OEE, cost, and compliance. Used by quality directors, plant managers, and regulatory affairs to assess batch quality and manufacturing efficiency."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch record (e.g. In Process, Released, Rejected) — primary filter for batch lifecycle analysis."
    - name: "manufacturing_date_month"
      expr: DATE_TRUNC('month', manufacturing_date)
      comment: "Month of manufacturing date — enables trend analysis of batch performance over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost amounts — required for multi-currency cost reporting."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Indicates whether a GMP deviation occurred during this batch — critical compliance dimension for regulatory reporting."
    - name: "quality_release_flag"
      expr: quality_release_flag
      comment: "Indicates whether the batch has been quality-released — used to track release throughput and backlog."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether this batch is associated with a product recall — highest-severity risk dimension."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether the batch is under regulatory hold — impacts supply availability and compliance posture."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for batch quantities — required for accurate aggregation across product types."
    - name: "bom_version"
      expr: bom_version
      comment: "Bill of materials version used for this batch — enables version-level yield and cost comparison."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch records — baseline volume metric for production throughput tracking."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage — the primary process efficiency KPI; sustained decline triggers process investigation and CAPA."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE across batches — measures combined availability, performance, and quality efficiency at the batch level."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity across all batches — quantifies material waste; drives cost reduction and process improvement initiatives."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across batches — measures quality failure requiring reprocessing; high rework signals process instability."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual batch production cost — used for cost-of-goods-sold analysis and budget variance reporting."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard (planned) batch cost — baseline for cost variance calculation and standard costing reconciliation."
    - name: "total_batch_cost_variance"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(standard_cost_amount AS DOUBLE))
      comment: "Aggregate batch cost variance (actual minus standard) — positive values indicate cost overrun; monitored in monthly manufacturing finance reviews."
    - name: "gmp_deviation_batch_count"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Number of batches with GMP deviations — a regulatory compliance KPI; any increase triggers quality system escalation."
    - name: "recall_batch_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of batches associated with product recalls — highest-severity quality and financial risk indicator."
    - name: "quality_release_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches that have been quality-released — measures release throughput efficiency; low rates indicate quality bottlenecks impacting supply."
    - name: "avg_batch_size_actual"
      expr: AVG(CAST(batch_size_actual AS DOUBLE))
      comment: "Average actual batch size — compared against planned batch size to assess process consistency and capacity utilization."
    - name: "avg_batch_size_planned"
      expr: AVG(CAST(batch_size_planned AS DOUBLE))
      comment: "Average planned batch size — baseline for batch size attainment analysis and capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) KPIs at the shift and production line level. The primary manufacturing efficiency dashboard used by plant managers, operations directors, and COOs to drive continuous improvement."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`oee_record`"
  dimensions:
    - name: "shift_date_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift date — enables OEE trend analysis over time."
    - name: "shift_date"
      expr: shift_date
      comment: "Exact shift date — supports daily OEE drill-down for operational review."
    - name: "shift_name"
      expr: shift_name
      comment: "Name of the shift (e.g. Day, Night, Afternoon) — enables shift-level OEE benchmarking to identify underperforming shifts."
    - name: "oee_status"
      expr: oee_status
      comment: "OEE status classification (e.g. World Class, Acceptable, Poor) — quick segmentation for performance tier analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect OEE data (e.g. automated MES, manual entry) — data quality dimension for reliability assessment."
  measures:
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage — the headline manufacturing efficiency KPI; world-class target is ≥85%. Drives capital investment and improvement program decisions."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate — measures unplanned downtime impact; low availability triggers maintenance strategy review."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate — measures speed losses vs. ideal cycle time; low performance indicates process or equipment speed degradation."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate — measures first-pass yield at the OEE level; low quality rate drives scrap and rework cost investigations."
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good units produced across all OEE records — primary throughput volume KPI for supply planning and capacity analysis."
    - name: "total_units_rejected"
      expr: SUM(CAST(total_units_rejected AS DOUBLE))
      comment: "Total units rejected — quantifies quality failure volume; directly impacts cost of poor quality (COPQ) calculations."
    - name: "total_rework_units"
      expr: SUM(CAST(rework_units AS DOUBLE))
      comment: "Total units requiring rework — measures quality reprocessing burden; high rework signals process instability requiring CAPA."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes — aggregate measure of production time lost; used to prioritize maintenance and reliability investments."
    - name: "total_changeover_time_minutes"
      expr: SUM(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Total changeover time in minutes — measures SMED improvement opportunity; high changeover time reduces effective capacity."
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time — denominator for availability and utilization rate calculations."
    - name: "total_scrap_weight_kg"
      expr: SUM(CAST(scrap_weight_kg AS DOUBLE))
      comment: "Total scrap weight in kilograms — measures material waste volume; drives sustainability and cost reduction programs."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(total_units_rejected AS DOUBLE)) / NULLIF(SUM(CAST(total_units_produced AS DOUBLE)), 0), 2)
      comment: "Percentage of total units produced that were rejected — measures first-pass quality failure rate; above threshold triggers quality system escalation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event KPIs covering frequency, duration, financial impact, and root cause. Used by plant managers, reliability engineers, and operations VPs to prioritize maintenance investments and reduce production losses."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. mechanical, electrical, process, planned maintenance) — primary dimension for root cause analysis and investment prioritization."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event (e.g. unplanned, planned, minor stop) — distinguishes controllable from uncontrollable losses."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the downtime event — used to prioritize corrective actions and escalation."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Coded root cause of the downtime — enables Pareto analysis to identify the vital few causes driving most downtime."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the downtime event — tracks open vs. resolved events for operational follow-up."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether the downtime event involved a safety incident — highest-priority compliance and risk dimension."
    - name: "downtime_start_month"
      expr: DATE_TRUNC('month', downtime_start_timestamp)
      comment: "Month of downtime event start — enables trend analysis of downtime frequency and duration over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial impact amounts — required for multi-currency financial reporting."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency KPI; increasing trend triggers reliability program review."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — aggregate production time lost; primary input to OEE availability calculation and capacity planning."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event — measures mean time to repair (MTTR) proxy; high average duration indicates repair process inefficiency."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of downtime events — quantifies the cost of unreliability; used to justify maintenance capital investments and reliability programs."
    - name: "avg_financial_impact_per_event"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per downtime event — normalizes cost signal for cross-facility and cross-line benchmarking."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime — directly links reliability performance to supply output and revenue risk."
    - name: "safety_incident_downtime_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of downtime events involving safety incidents — a zero-tolerance KPI; any occurrence triggers immediate safety review and regulatory notification assessment."
    - name: "unresolved_downtime_event_count"
      expr: COUNT(CASE WHEN resolution_status != 'Resolved' THEN 1 END)
      comment: "Number of downtime events not yet resolved — measures open action backlog; high backlog indicates maintenance resource constraints."
    - name: "preventive_action_required_count"
      expr: COUNT(CASE WHEN preventive_action_required = TRUE THEN 1 END)
      comment: "Number of downtime events requiring preventive action — drives preventive maintenance program workload and prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_changeover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Changeover efficiency KPIs measuring SMED performance, variance from standard, and OEE impact. Used by operations managers and continuous improvement teams to reduce changeover time and increase effective capacity."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`changeover`"
  dimensions:
    - name: "changeover_type"
      expr: changeover_type
      comment: "Type of changeover (e.g. product, format, cleaning) — primary dimension for changeover time benchmarking by category."
    - name: "changeover_status"
      expr: changeover_status
      comment: "Current status of the changeover (e.g. Completed, In Progress, Cancelled) — used to filter completed events for performance analysis."
    - name: "smed_improvement_flag"
      expr: smed_improvement_flag
      comment: "Indicates whether SMED (Single-Minute Exchange of Die) improvement was applied — measures adoption of lean changeover techniques."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the changeover occurred — enables shift-level changeover performance benchmarking."
    - name: "changeover_start_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of changeover start — supports trend analysis of changeover performance improvement over time."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Reason code for changeover-related downtime — enables Pareto analysis of changeover delay causes."
  measures:
    - name: "total_changeovers"
      expr: COUNT(1)
      comment: "Total number of changeover events — baseline frequency metric for capacity planning and SMED program tracking."
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual changeover duration in minutes — the primary SMED KPI; reduction over time validates lean improvement investments."
    - name: "avg_standard_duration_minutes"
      expr: AVG(CAST(standard_duration_minutes AS DOUBLE))
      comment: "Average standard (target) changeover duration — baseline for variance analysis and target-setting."
    - name: "total_variance_minutes"
      expr: SUM(CAST(variance_minutes AS DOUBLE))
      comment: "Total changeover time variance (actual minus standard) across all events — aggregate measure of time lost to changeover inefficiency."
    - name: "avg_variance_minutes"
      expr: AVG(CAST(variance_minutes AS DOUBLE))
      comment: "Average changeover time variance per event — normalized efficiency gap metric used in continuous improvement prioritization."
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage per changeover — quantifies how much each changeover reduces overall equipment effectiveness."
    - name: "total_material_waste_kg"
      expr: SUM(CAST(material_waste_kg AS DOUBLE))
      comment: "Total material waste generated during changeovers in kilograms — measures sustainability and cost impact of changeover inefficiency."
    - name: "avg_first_pass_yield_percentage"
      expr: AVG(CAST(first_pass_yield_percentage AS DOUBLE))
      comment: "Average first-pass yield percentage after changeover — measures quality of startup following a changeover; low values indicate startup loss problems."
    - name: "changeover_time_attainment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_duration_minutes <= standard_duration_minutes THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changeovers completed within standard duration — measures changeover plan attainment; below target triggers SMED program review."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield performance KPIs at the work center and operation level. Used by process engineers, quality managers, and plant directors to identify yield loss drivers and quantify cost of poor quality."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`yield_record`"
  dimensions:
    - name: "yield_loss_reason_code"
      expr: yield_loss_reason_code
      comment: "Coded reason for yield loss — primary dimension for Pareto analysis of yield loss causes driving improvement prioritization."
    - name: "batch_record_status"
      expr: batch_record_status
      comment: "Status of the associated batch record — used to filter yield records by batch lifecycle stage."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for the yield record — segments compliant vs. non-compliant yield events for regulatory analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the yield was recorded — enables shift-level yield benchmarking to identify performance gaps."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost impact amounts — required for financial yield loss analysis."
    - name: "operation_start_month"
      expr: DATE_TRUNC('month', operation_start_timestamp)
      comment: "Month of operation start — enables yield trend analysis over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for the yield record — enables facility-level yield benchmarking."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage — the primary process efficiency KPI; sustained decline triggers process investigation and CAPA initiation."
    - name: "avg_theoretical_yield_percentage"
      expr: AVG(CAST(theoretical_yield_percentage AS DOUBLE))
      comment: "Average theoretical (maximum possible) yield percentage — baseline for yield gap analysis and improvement target-setting."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average yield variance (actual minus theoretical) — measures the gap between actual and theoretical performance; drives process optimization investments."
    - name: "total_input_quantity"
      expr: SUM(CAST(input_quantity AS DOUBLE))
      comment: "Total input quantity processed — denominator for yield rate calculations and material consumption analysis."
    - name: "total_output_quantity"
      expr: SUM(CAST(output_quantity AS DOUBLE))
      comment: "Total output quantity produced — numerator for yield rate calculations and throughput reporting."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity — measures material waste volume; directly impacts COGS and sustainability metrics."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity — measures quality reprocessing burden and associated cost of poor quality."
    - name: "total_yield_variance_cost_impact"
      expr: SUM(CAST(yield_variance_cost_impact AS DOUBLE))
      comment: "Total financial cost impact of yield variance — quantifies the monetary value of yield losses; used to prioritize process improvement investments by ROI."
    - name: "avg_standard_cost_per_unit"
      expr: AVG(CAST(standard_cost_per_unit AS DOUBLE))
      comment: "Average standard cost per unit — used to value yield losses and benchmark cost efficiency across production lines."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_gmp_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GMP compliance event KPIs covering deviation frequency, severity, risk scores, and regulatory notification requirements. Used by quality directors, regulatory affairs, and compliance officers to manage GMP risk and regulatory obligations."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`gmp_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of GMP event (e.g. deviation, OOS, contamination) — primary dimension for compliance event categorization."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity classification of the GMP event (e.g. Critical, Major, Minor) — drives escalation and regulatory notification decisions."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the GMP event (e.g. Open, Under Investigation, Closed) — tracks compliance action backlog."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the GMP event — enables systemic analysis of compliance failure drivers."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether regulatory notification is required — highest-priority compliance dimension."
    - name: "is_product_recall_trigger"
      expr: is_product_recall_trigger
      comment: "Indicates whether this GMP event triggered a product recall — most severe quality and financial risk indicator."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether this is a recurring GMP event — recurrence signals CAPA ineffectiveness requiring management escalation."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of GMP event detection — enables trend analysis of compliance event frequency over time."
    - name: "environmental_zone"
      expr: environmental_zone
      comment: "Environmental zone where the GMP event occurred — used for contamination risk analysis by facility zone."
  measures:
    - name: "total_gmp_events"
      expr: COUNT(1)
      comment: "Total number of GMP events — baseline compliance frequency KPI; increasing trend triggers quality system review and regulatory risk assessment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across GMP events — composite risk KPI used by quality leadership to prioritize CAPA resources and regulatory engagement."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity affected by GMP events — measures the supply impact of compliance failures; large values trigger supply chain contingency planning."
    - name: "recall_trigger_event_count"
      expr: COUNT(CASE WHEN is_product_recall_trigger = TRUE THEN 1 END)
      comment: "Number of GMP events that triggered product recalls — the most severe quality KPI; any occurrence requires board-level notification and crisis management."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of GMP events requiring regulatory notification — measures regulatory compliance obligation volume; missed notifications create significant legal risk."
    - name: "recurrent_event_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring GMP events — measures CAPA effectiveness; high recurrence rate indicates systemic quality system failure."
    - name: "open_event_count"
      expr: COUNT(CASE WHEN event_status != 'Closed' THEN 1 END)
      comment: "Number of open (unresolved) GMP events — measures compliance action backlog; high open count creates regulatory inspection risk."
    - name: "critical_event_count"
      expr: COUNT(CASE WHEN event_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity GMP events — zero-tolerance KPI for the most severe compliance failures requiring immediate executive action."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and maintenance KPIs. Used by plant engineering, asset management, and operations leadership to optimize maintenance strategy, capital allocation, and equipment reliability."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment (e.g. mixer, filler, labeler) — primary dimension for asset class performance benchmarking."
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment (e.g. Active, Under Maintenance, Decommissioned) — used to filter active asset base."
    - name: "department"
      expr: department
      comment: "Department responsible for the equipment — enables department-level asset performance and maintenance cost analysis."
    - name: "compliance_gmp"
      expr: compliance_gmp
      comment: "Indicates whether the equipment is GMP-compliant — critical regulatory dimension for pharmaceutical and food manufacturing."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the equipment — used for financial asset management and capital planning analysis."
    - name: "installation_date_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year of equipment installation — enables age-based analysis of reliability and maintenance cost trends."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets — baseline asset inventory metric for capacity and capital planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of equipment assets — measures total capital invested in manufacturing equipment; used for asset base valuation and depreciation planning."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across equipment — measures total cost of maintenance program; benchmarked against acquisition cost to assess maintenance intensity."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across equipment — measures fleet-wide equipment effectiveness; used to identify underperforming assets for targeted improvement."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across equipment — baseline for OEE gap analysis and improvement target-setting."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours — primary reliability KPI; low MTBF drives preventive maintenance investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours — measures maintenance responsiveness; high MTTR indicates repair process or spare parts availability issues."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across equipment — measures energy cost and sustainability footprint of the asset base."
    - name: "oee_attainment_rate"
      expr: ROUND(100.0 * AVG(CAST(oee_actual AS DOUBLE)) / NULLIF(AVG(CAST(oee_target AS DOUBLE)), 0), 2)
      comment: "OEE attainment rate (actual OEE as percentage of target OEE) — measures how close the equipment fleet is to its performance targets; below 90% triggers reliability improvement programs."
    - name: "maintenance_cost_per_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(maintenance_cost AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Maintenance cost as a percentage of acquisition cost — measures maintenance intensity of the asset base; high ratios indicate aging equipment requiring capital refresh decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation KPIs measuring actual vs. scheduled execution, labor and machine time efficiency, and quality outcomes at the work center level. Used by production supervisors and operations managers for shift-level performance management."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of production confirmation (e.g. partial, final, reversal) — used to filter meaningful confirmations from reversals."
    - name: "operation_status"
      expr: operation_status
      comment: "Status of the confirmed operation — used to segment completed vs. in-progress confirmations."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the confirmation — enables shift-level performance benchmarking."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date — enables trend analysis of production confirmation volumes and efficiency over time."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag for the confirmation — segments compliant vs. non-compliant production events."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether this confirmation involved rework — used to quantify rework volume and associated cost."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this confirmation was reversed — used to exclude reversals from production volume calculations."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of production confirmations — baseline activity volume metric for production reporting."
    - name: "total_confirmed_yield_quantity"
      expr: SUM(CAST(confirmed_yield_quantity AS DOUBLE))
      comment: "Total confirmed yield quantity — measures actual production output; primary throughput KPI for supply planning and customer order fulfillment."
    - name: "total_confirmed_scrap_quantity"
      expr: SUM(CAST(confirmed_scrap_quantity AS DOUBLE))
      comment: "Total confirmed scrap quantity — measures quality losses at the confirmation level; drives scrap cost and waste reduction programs."
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time in minutes — measures labor consumption; compared against standard to identify labor efficiency gaps."
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time in minutes — measures machine utilization; input to capacity planning and OEE calculations."
    - name: "total_actual_setup_time_minutes"
      expr: SUM(CAST(actual_setup_time_minutes AS DOUBLE))
      comment: "Total actual setup time in minutes — measures setup burden on production capacity; high setup time drives SMED improvement initiatives."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded in confirmations — measures production time lost; input to OEE availability calculation."
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability percentage from confirmations — measures equipment uptime at the operation level."
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance percentage from confirmations — measures speed efficiency at the operation level."
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality percentage from confirmations — measures first-pass quality rate at the operation level."
    - name: "rework_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN reversal_flag = FALSE THEN 1 END), 0), 2)
      comment: "Percentage of non-reversed confirmations that involved rework — measures quality failure rate at the operation level; high rates trigger process and quality system investigations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing facility master KPIs covering capacity, sustainability, compliance certifications, and operational status. Used by supply chain VPs, sustainability officers, and operations leadership for network-level strategic decisions."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of manufacturing facility (e.g. primary, secondary, contract) — primary dimension for network-level capacity analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility (e.g. Active, Idle, Decommissioned) — used to filter active network capacity."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the facility (e.g. owned, leased, contract) — used for make-vs-buy and network strategy analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located — enables geographic network analysis and regulatory jurisdiction segmentation."
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Indicates whether the facility holds GMP certification — critical compliance dimension for product allocation decisions."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates whether the facility is ISO 9001 certified — quality management system certification status."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Indicates whether the facility is ISO 14001 certified — environmental management certification status for sustainability reporting."
    - name: "primary_product_category"
      expr: primary_product_category
      comment: "Primary product category manufactured at the facility — used for network capacity analysis by product type."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of manufacturing facilities — baseline network size metric for capacity planning and network strategy."
    - name: "total_production_capacity_units_per_day"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total network production capacity in units per day — primary supply capacity KPI used in S&OP and network design decisions."
    - name: "avg_production_capacity_units_per_day"
      expr: AVG(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Average production capacity per facility — used for facility benchmarking and identifying capacity expansion opportunities."
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across the facility network — primary sustainability KPI for carbon footprint and energy cost management."
    - name: "total_water_consumption_cubic_meters_per_year"
      expr: SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Total annual water consumption across facilities — sustainability KPI for water stewardship reporting and ESG commitments."
    - name: "gmp_certified_facility_count"
      expr: COUNT(CASE WHEN gmp_certified = TRUE THEN 1 END)
      comment: "Number of GMP-certified facilities — measures regulatory compliance coverage of the manufacturing network; critical for product allocation and market access decisions."
    - name: "gmp_certification_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with GMP certification — network-level compliance coverage KPI; below target triggers regulatory risk escalation."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total manufacturing floor space in square feet across the network — used for capacity density analysis and real estate optimization."
$$;