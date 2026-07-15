-- Metric views for domain: equipment | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic asset register metrics providing fleet composition, capital investment, and operational readiness insights for executive fleet management decisions."
  source: "`mining_ecm`.`equipment`.`asset`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (e.g. Active, Standby, Decommissioned) — primary filter for fleet availability analysis."
    - name: "asset_class_id"
      expr: asset_class_id
      comment: "Foreign key to asset class — enables grouping by equipment class for fleet composition analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the asset is owned, leased, or hired — drives capital vs. operating cost decisions."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the asset (diesel, electric, hybrid) — critical for emissions and energy transition reporting."
    - name: "is_mobile"
      expr: is_mobile
      comment: "Indicates whether the asset is mobile or fixed — used to segment fleet for utilisation benchmarking."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality rating — used to prioritise maintenance investment and risk management."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site the asset is assigned to — enables site-level fleet performance comparison."
    - name: "commissioning_date_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the asset was commissioned — supports fleet age cohort analysis."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(1)
      comment: "Total number of assets in the fleet register. Baseline measure for fleet size tracking and capacity planning."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of assets currently in active operational status. Directly informs available fleet capacity for production planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in the asset fleet. Key input for capital allocation, depreciation, and asset replacement decisions."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Benchmarks capital intensity per unit and supports replacement cost modelling."
    - name: "total_payload_capacity_tonnes"
      expr: SUM(CAST(payload_capacity_tonnes AS DOUBLE))
      comment: "Aggregate payload capacity of the fleet in tonnes. Directly links fleet composition to maximum theoretical production throughput."
    - name: "avg_engine_power_kw"
      expr: AVG(CAST(engine_power_kw AS DOUBLE))
      comment: "Average engine power across the fleet in kilowatts. Supports fleet specification benchmarking and energy consumption planning."
    - name: "total_smr_hours"
      expr: SUM(CAST(smr_hours AS DOUBLE))
      comment: "Total Service Meter Reading hours across the fleet. Indicates cumulative fleet utilisation and drives maintenance scheduling decisions."
    - name: "avg_smr_hours"
      expr: AVG(CAST(smr_hours AS DOUBLE))
      comment: "Average SMR hours per asset. Used to assess fleet age in operating hours and identify assets approaching major overhaul thresholds."
    - name: "assets_overdue_service_count"
      expr: COUNT(CASE WHEN next_scheduled_service_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets whose next scheduled service date has passed. A leading indicator of maintenance compliance risk and potential unplanned downtime."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_utilisation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilisation and availability metrics providing operational efficiency KPIs for fleet performance management, maintenance optimisation, and production planning."
  source: "`mining_ecm`.`equipment`.`utilisation_record`"
  dimensions:
    - name: "record_date"
      expr: record_date
      comment: "Date of the utilisation record — primary time dimension for trend analysis."
    - name: "record_date_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month of the utilisation record — supports monthly performance reporting and trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night) — enables shift-level performance comparison to identify productivity patterns."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier — enables individual asset performance drill-down."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site identifier — enables site-level utilisation benchmarking."
    - name: "primary_delay_category"
      expr: primary_delay_category
      comment: "Primary category of delay (e.g. Maintenance, Operational, Weather) — critical for root cause analysis of lost production time."
    - name: "record_type"
      expr: record_type
      comment: "Type of utilisation record (e.g. Shift, Daily, Weekly) — used to filter to the correct reporting granularity."
    - name: "record_status"
      expr: record_status
      comment: "Approval/reconciliation status of the record — used to filter to confirmed data for reporting."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the utilisation record has been reconciled — ensures reporting is based on verified data."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled operating hours across all assets and periods. Denominator for availability and utilisation rate calculations."
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total hours assets were actively operating. Core measure of productive fleet time and throughput capacity."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total hours lost to downtime across the fleet. Directly quantifies production loss and maintenance cost impact."
    - name: "total_planned_maintenance_hours"
      expr: SUM(CAST(planned_maintenance_hours AS DOUBLE))
      comment: "Total hours consumed by planned maintenance activities. Used to assess maintenance programme efficiency and scheduling effectiveness."
    - name: "total_unplanned_maintenance_hours"
      expr: SUM(CAST(unplanned_maintenance_hours AS DOUBLE))
      comment: "Total hours lost to unplanned maintenance. A key reliability indicator — high values signal fleet health deterioration and reactive maintenance culture."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total hours assets were idle (available but not operating). Identifies operational inefficiency and dispatch/scheduling improvement opportunities."
    - name: "total_delay_hours"
      expr: SUM(CAST(delay_hours AS DOUBLE))
      comment: "Total hours lost to operational delays. Quantifies the impact of non-maintenance delays on fleet productivity."
    - name: "avg_physical_availability_pct"
      expr: AVG(CAST(physical_availability_pct AS DOUBLE))
      comment: "Average physical availability percentage across assets and periods. Primary KPI for maintenance effectiveness — measures the proportion of time assets are mechanically available."
    - name: "avg_utilisation_pct"
      expr: AVG(CAST(utilisation_pct AS DOUBLE))
      comment: "Average utilisation percentage — measures how effectively available fleet time is converted to productive operating time. Key operational efficiency KPI."
    - name: "avg_use_of_availability_pct"
      expr: AVG(CAST(use_of_availability_pct AS DOUBLE))
      comment: "Average use-of-availability percentage — measures operational efficiency in converting mechanically available time to productive time. Distinguishes operational from maintenance losses."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across the fleet. Drives fuel cost management, emissions reporting, and energy efficiency benchmarking."
    - name: "avg_fuel_burn_rate_lph"
      expr: AVG(CAST(fuel_burn_rate_lph AS DOUBLE))
      comment: "Average fuel burn rate in litres per hour. Benchmarks fleet fuel efficiency and identifies assets with abnormal consumption patterns."
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload moved by the fleet. Directly measures productive output and links equipment performance to mining production targets."
    - name: "avg_oee_score"
      expr: AVG(CAST(oee_score AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness score. The single most comprehensive equipment performance KPI — combines availability, performance, and quality into one executive metric."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) metrics providing granular availability, performance, and quality rate analysis for equipment optimisation and production target management."
  source: "`mining_ecm`.`equipment`.`oee_record`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Production date of the OEE record — primary time dimension for daily performance tracking."
    - name: "production_date_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of production — supports monthly OEE trend reporting and target vs. actual analysis."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier — enables individual asset OEE drill-down and benchmarking."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site identifier — enables site-level OEE comparison."
    - name: "record_status"
      expr: record_status
      comment: "Status of the OEE record (e.g. Draft, Approved) — used to filter to confirmed records for reporting."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the OEE record has been reconciled against source systems — ensures data quality in reporting."
    - name: "data_source"
      expr: data_source
      comment: "Source system for the OEE record — supports data lineage and quality auditing."
  measures:
    - name: "avg_oee_rate"
      expr: AVG(CAST(oee_rate AS DOUBLE))
      comment: "Average OEE rate across assets and periods. The headline equipment performance KPI used in executive dashboards and operational steering meetings."
    - name: "avg_oee_target_rate"
      expr: AVG(CAST(oee_target_rate AS DOUBLE))
      comment: "Average OEE target rate. Used alongside actual OEE to compute performance gap and drive improvement initiatives."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate. Measures the proportion of planned time the equipment is mechanically available — primary maintenance KPI."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate — measures how efficiently the equipment operates when available. Identifies speed losses and throughput gaps."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate — measures the proportion of output meeting specification. Links equipment condition to product quality outcomes."
    - name: "total_actual_operating_time_hrs"
      expr: SUM(CAST(actual_operating_time_hrs AS DOUBLE))
      comment: "Total actual operating hours. Measures productive fleet time and is the primary input for throughput and cost-per-hour calculations."
    - name: "total_planned_operating_time_hrs"
      expr: SUM(CAST(planned_operating_time_hrs AS DOUBLE))
      comment: "Total planned operating hours. Denominator for availability calculations and baseline for production schedule adherence."
    - name: "total_unplanned_downtime_hrs"
      expr: SUM(CAST(unplanned_downtime_hrs AS DOUBLE))
      comment: "Total unplanned downtime hours. Quantifies reliability losses and drives maintenance strategy investment decisions."
    - name: "total_planned_downtime_hrs"
      expr: SUM(CAST(planned_downtime_hrs AS DOUBLE))
      comment: "Total planned downtime hours. Measures maintenance programme time consumption and supports shutdown planning optimisation."
    - name: "total_throughput_actual_t"
      expr: SUM(CAST(throughput_actual_t AS DOUBLE))
      comment: "Total actual throughput in tonnes. Directly measures equipment productive output and links OEE performance to mining production targets."
    - name: "total_throughput_target_t"
      expr: SUM(CAST(throughput_target_t AS DOUBLE))
      comment: "Total target throughput in tonnes. Used alongside actual throughput to compute production attainment and identify shortfall."
    - name: "total_fuel_consumption_l"
      expr: SUM(CAST(fuel_consumption_l AS DOUBLE))
      comment: "Total fuel consumed during OEE periods. Supports fuel cost allocation, emissions reporting, and energy efficiency analysis."
    - name: "avg_fuel_efficiency_t_per_l"
      expr: AVG(CAST(fuel_efficiency_t_per_l AS DOUBLE))
      comment: "Average fuel efficiency in tonnes per litre. A compound productivity-efficiency KPI linking throughput output to fuel input — key for cost and emissions management."
    - name: "total_reject_unit_count"
      expr: SUM(CAST(reject_unit_count AS DOUBLE))
      comment: "Total number of rejected production units. Quantifies quality losses attributable to equipment performance and drives quality improvement actions."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment downtime event metrics providing reliability, maintenance cost, and production impact analysis to drive maintenance strategy and fleet availability improvement."
  source: "`mining_ecm`.`equipment`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. Mechanical, Electrical, Operational) — primary dimension for root cause analysis and maintenance strategy targeting."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode associated with the downtime event — enables failure mode analysis to prioritise reliability improvement investments."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance triggered (Corrective, Preventive, Predictive) — measures maintenance strategy effectiveness."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset that experienced the downtime — enables individual asset reliability benchmarking."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site where the downtime occurred — supports site-level reliability comparison."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the downtime event — used to assess criticality distribution and response time performance."
    - name: "oee_impact_category"
      expr: oee_impact_category
      comment: "OEE impact category of the downtime — links downtime events to OEE loss buckets for integrated performance analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which the downtime occurred — identifies shift-level reliability patterns."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Whether the downtime event was safety-related — critical for HSE reporting and risk management."
    - name: "event_start_date"
      expr: CAST(start_timestamp AS DATE)
      comment: "Date the downtime event started — primary time dimension for trend analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the downtime event started — supports monthly reliability trend reporting."
  measures:
    - name: "total_downtime_event_count"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline reliability metric — high event counts signal fleet health deterioration and drive maintenance investment decisions."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost incurred across downtime events. Primary financial KPI for maintenance budget management and cost-per-hour benchmarking."
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(maintenance_cost AS DOUBLE))
      comment: "Average maintenance cost per downtime event. Benchmarks repair cost intensity and identifies high-cost failure modes for targeted investment."
    - name: "total_production_tonnes_lost"
      expr: SUM(CAST(production_tonnes_lost AS DOUBLE))
      comment: "Total production tonnes lost due to downtime events. Directly quantifies the revenue impact of equipment unreliability — a critical executive KPI."
    - name: "total_production_impact_hours"
      expr: SUM(CAST(production_impact_hours AS DOUBLE))
      comment: "Total production hours lost due to downtime. Measures the operational impact of equipment failures on production schedule adherence."
    - name: "total_actual_repair_hours"
      expr: SUM(CAST(actual_repair_hours AS DOUBLE))
      comment: "Total actual repair hours consumed. Measures maintenance labour demand and supports workforce planning and MTTR analysis."
    - name: "avg_actual_repair_hours"
      expr: AVG(CAST(actual_repair_hours AS DOUBLE))
      comment: "Average repair hours per downtime event — a proxy for Mean Time To Repair (MTTR). Lower values indicate more efficient maintenance execution."
    - name: "repair_efficiency_ratio"
      expr: SUM(CAST(estimated_repair_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_repair_hours AS DOUBLE)), 0)
      comment: "Ratio of estimated to actual repair hours. Values below 1.0 indicate underestimation; above 1.0 indicates efficient execution. Drives maintenance planning accuracy improvement."
    - name: "safety_related_event_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Number of downtime events with a safety dimension. Critical HSE KPI — safety-related downtime triggers mandatory investigation and corrective action."
    - name: "unplanned_downtime_event_count"
      expr: COUNT(CASE WHEN maintenance_type = 'Corrective' THEN 1 END)
      comment: "Number of unplanned (corrective) downtime events. Measures reactive maintenance burden — high values indicate reliability programme gaps."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet fuel consumption metrics providing cost, efficiency, and emissions insights for energy management, carbon reporting, and operational cost control."
  source: "`mining_ecm`.`equipment`.`fuel_consumption`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel dispensed (diesel, LNG, etc.) — enables fuel mix analysis and energy transition tracking."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site where fuel was dispensed — enables site-level fuel cost and consumption benchmarking."
    - name: "dispensing_method"
      expr: dispensing_method
      comment: "Method of fuel dispensing (bowser, fixed pump, etc.) — supports logistics and supply chain optimisation."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of fuel transaction — used to filter and categorise consumption records."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction — used to filter to confirmed transactions for accurate reporting."
    - name: "is_anomaly_flagged"
      expr: is_anomaly_flagged
      comment: "Whether the transaction was flagged as anomalous — used to identify fuel theft, measurement errors, or abnormal consumption events."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset that consumed the fuel — enables per-asset fuel cost and efficiency analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the fuel transaction — supports monthly fuel cost trend reporting."
  measures:
    - name: "total_fuel_dispensed_litres"
      expr: SUM(CAST(quantity_dispensed_litres AS DOUBLE))
      comment: "Total volume of fuel dispensed across the fleet. Primary fuel consumption KPI — drives energy cost budgeting and supply planning."
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total fuel expenditure. One of the largest operating cost line items in mining — directly informs cost reduction and procurement strategy."
    - name: "avg_unit_cost_per_litre"
      expr: AVG(CAST(unit_cost_per_litre AS DOUBLE))
      comment: "Average fuel unit cost per litre. Benchmarks procurement efficiency and tracks fuel price exposure over time."
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(co2e_emissions_kg AS DOUBLE))
      comment: "Total CO2-equivalent emissions from fleet fuel consumption. Critical for Scope 1 emissions reporting, carbon budget management, and regulatory compliance."
    - name: "avg_fuel_burn_rate_l_per_hr"
      expr: AVG(CAST(fuel_burn_rate_l_per_hr AS DOUBLE))
      comment: "Average fuel burn rate in litres per hour. Benchmarks fleet fuel efficiency and identifies assets with abnormal consumption patterns requiring investigation."
    - name: "anomaly_transaction_count"
      expr: COUNT(CASE WHEN is_anomaly_flagged = TRUE THEN 1 END)
      comment: "Number of fuel transactions flagged as anomalous. Measures fuel management control effectiveness — high counts indicate theft risk, metering issues, or process failures."
    - name: "avg_emissions_factor_kg_per_litre"
      expr: AVG(CAST(emissions_factor_kg_per_litre AS DOUBLE))
      comment: "Average emissions factor applied to fuel consumption. Supports emissions intensity benchmarking and fuel mix optimisation for decarbonisation planning."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_payload_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haul truck payload cycle metrics providing productivity, payload efficiency, and cycle time KPIs for truck fleet optimisation and production throughput management."
  source: "`mining_ecm`.`equipment`.`payload_cycle`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of the payload cycle — primary time dimension for daily productivity tracking."
    - name: "production_date_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month of the payload cycle — supports monthly throughput trend reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which the cycle occurred — enables shift-level productivity comparison."
    - name: "asset_id"
      expr: asset_id
      comment: "Haul truck asset identifier — enables per-truck productivity benchmarking."
    - name: "cycle_status"
      expr: cycle_status
      comment: "Status of the payload cycle (Completed, Aborted, etc.) — used to filter to valid completed cycles for productivity analysis."
    - name: "overload_flag"
      expr: overload_flag
      comment: "Whether the truck was overloaded during the cycle — critical for tyre and structural damage risk management."
    - name: "payload_measurement_method"
      expr: payload_measurement_method
      comment: "Method used to measure payload (onboard weighing, shovel estimate, etc.) — supports data quality stratification."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the cycle record — used to filter to high-confidence data for production reporting."
  measures:
    - name: "total_cycle_count"
      expr: COUNT(1)
      comment: "Total number of payload cycles completed. Baseline productivity metric — directly measures truck fleet activity level and dispatch effectiveness."
    - name: "total_payload_weight_tonnes"
      expr: SUM(CAST(payload_weight_tonnes AS DOUBLE))
      comment: "Total material moved in tonnes across all cycles. The primary production throughput KPI for the haul fleet — directly links to mining production targets."
    - name: "avg_payload_weight_tonnes"
      expr: AVG(CAST(payload_weight_tonnes AS DOUBLE))
      comment: "Average payload per cycle in tonnes. Measures loading efficiency — gap to target payload indicates shovel or loading practice improvement opportunities."
    - name: "avg_target_payload_tonnes"
      expr: AVG(CAST(target_payload_tonnes AS DOUBLE))
      comment: "Average target payload per cycle. Used alongside actual payload to compute payload factor and identify systematic underloading."
    - name: "total_payload_variance_tonnes"
      expr: SUM(CAST(payload_variance_tonnes AS DOUBLE))
      comment: "Total variance between actual and target payload across all cycles. Quantifies cumulative underloading or overloading — a key operational efficiency KPI."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average total cycle time in minutes. Core productivity KPI — shorter cycle times with full payloads maximise fleet throughput."
    - name: "avg_haul_time_loaded_minutes"
      expr: AVG(CAST(haul_time_loaded_minutes AS DOUBLE))
      comment: "Average loaded haul time per cycle. Identifies haul road condition and routing efficiency opportunities."
    - name: "avg_queue_time_minutes"
      expr: AVG(CAST(queue_time_minutes AS DOUBLE))
      comment: "Average queue time per cycle. Measures dispatch and shovel-truck matching efficiency — high queue times indicate fleet imbalance or bottlenecks."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all payload cycles. Enables fuel efficiency analysis at the cycle level and supports cost-per-tonne calculations."
    - name: "overload_cycle_count"
      expr: COUNT(CASE WHEN overload_flag = TRUE THEN 1 END)
      comment: "Number of cycles where the truck was overloaded. Overloading accelerates tyre wear and structural damage — this KPI drives loading practice compliance management."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet assignment and dispatch metrics providing operational efficiency, payload productivity, and fuel consumption insights for shift-level fleet management and dispatch optimisation."
  source: "`mining_ecm`.`equipment`.`fleet_assignment`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the fleet assignment shift — primary time dimension for daily operational reporting."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the fleet assignment — supports monthly fleet productivity trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (Day/Night) — enables shift-level productivity comparison."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment assigned — enables productivity analysis by equipment category."
    - name: "task_type"
      expr: task_type
      comment: "Type of task assigned (Haul, Drill, Blast, etc.) — enables productivity analysis by activity type."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the fleet assignment (Completed, Cancelled, In Progress) — used to filter to completed assignments for productivity analysis."
    - name: "is_planned_assignment"
      expr: is_planned_assignment
      comment: "Whether the assignment was planned or reactive — measures schedule adherence and dispatch planning effectiveness."
    - name: "pit_name"
      expr: pit_name
      comment: "Pit or mining area where the assignment was executed — enables pit-level productivity comparison."
    - name: "dispatch_priority"
      expr: dispatch_priority
      comment: "Dispatch priority level — used to analyse priority distribution and assess dispatch decision quality."
  measures:
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of fleet assignments. Baseline measure of dispatch activity volume and fleet utilisation intensity."
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload moved across all fleet assignments. Primary throughput KPI linking dispatch activity to production output."
    - name: "avg_payload_tonnes"
      expr: AVG(CAST(payload_tonnes AS DOUBLE))
      comment: "Average payload per assignment. Measures loading efficiency and identifies systematic underloading patterns."
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours consumed across all assignments. Measures fleet utilisation intensity and drives maintenance scheduling."
    - name: "total_fuel_consumed_litres"
      expr: SUM(CAST(fuel_consumed_litres AS DOUBLE))
      comment: "Total fuel consumed across all fleet assignments. Enables fuel cost allocation by task type, pit, and shift for operational cost management."
    - name: "total_distance_travelled_km"
      expr: SUM(CAST(distance_travelled_km AS DOUBLE))
      comment: "Total distance travelled across all assignments. Supports haul road utilisation analysis and tyre wear management."
    - name: "payload_attainment_ratio"
      expr: SUM(CAST(payload_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(target_payload_tonnes AS DOUBLE)), 0)
      comment: "Ratio of actual to target payload across assignments. Measures loading efficiency — values below 1.0 indicate systematic underloading and lost throughput opportunity."
    - name: "planned_assignment_rate"
      expr: COUNT(CASE WHEN is_planned_assignment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of assignments that were planned vs. reactive. Measures dispatch planning maturity — higher rates indicate better schedule adherence and operational predictability."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment inspection metrics providing compliance, defect detection, and safety assurance KPIs for asset integrity management and regulatory reporting."
  source: "`mining_ecm`.`equipment`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Pre-start, Periodic, Regulatory, etc.) — primary dimension for compliance and safety reporting."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (Completed, Pending, Failed) — used to track inspection programme completion."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection result (Pass, Fail, Conditional) — primary outcome dimension for compliance reporting."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset inspected — enables per-asset defect history and compliance tracking."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site where the inspection was conducted — enables site-level compliance comparison."
    - name: "equipment_grounded"
      expr: equipment_grounded
      comment: "Whether the equipment was grounded as a result of the inspection — critical safety KPI dimension."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was raised from the inspection — measures defect follow-through rate."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the inspection (Visual, NDT, Thermal, etc.) — supports inspection programme quality analysis."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the inspection was conducted — supports monthly compliance trend reporting."
  measures:
    - name: "total_inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline compliance measure — tracks inspection programme execution against schedule."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN overall_result = 'Fail' THEN 1 END)
      comment: "Number of inspections with a failed outcome. Critical safety and compliance KPI — high failure rates indicate fleet condition deterioration or inspection standard gaps."
    - name: "equipment_grounded_count"
      expr: COUNT(CASE WHEN equipment_grounded = TRUE THEN 1 END)
      comment: "Number of inspections resulting in equipment being grounded. Measures safety-critical defect prevalence — directly impacts fleet availability and safety performance."
    - name: "corrective_action_rate"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of inspections requiring corrective action. Measures defect detection rate and maintenance backlog generation — a leading indicator of fleet condition."
    - name: "avg_equipment_hours_at_inspection"
      expr: AVG(CAST(equipment_hours_at_inspection AS DOUBLE))
      comment: "Average equipment operating hours at time of inspection. Validates that inspections are being conducted at the correct service intervals."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`equipment_tyre_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tyre lifecycle and cost metrics providing tyre performance, cost-per-hour, and removal analysis for tyre management programme optimisation — tyres are one of the largest consumable cost items in open-cut mining."
  source: "`mining_ecm`.`equipment`.`tyre_record`"
  dimensions:
    - name: "tyre_status"
      expr: tyre_status
      comment: "Current status of the tyre (In Service, Removed, Scrapped, In Store) — primary dimension for tyre fleet inventory management."
    - name: "tyre_type"
      expr: tyre_type
      comment: "Type of tyre (OTR, radial, bias, etc.) — enables performance comparison across tyre specifications."
    - name: "removal_reason"
      expr: removal_reason
      comment: "Reason for tyre removal (Wear, Damage, Failure, etc.) — primary dimension for tyre failure mode analysis and haul road condition assessment."
    - name: "oem_brand"
      expr: oem_brand
      comment: "Tyre manufacturer brand — enables brand performance benchmarking to optimise procurement decisions."
    - name: "axle_position"
      expr: axle_position
      comment: "Axle position of the tyre — identifies position-specific wear patterns and loading issues."
    - name: "asset_id"
      expr: asset_id
      comment: "Asset the tyre is fitted to — enables per-asset tyre consumption analysis."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site — enables site-level tyre performance comparison, reflecting haul road condition differences."
    - name: "is_retreaded"
      expr: is_retreaded
      comment: "Whether the tyre is a retread — enables cost comparison between new and retreaded tyres."
    - name: "installation_date_month"
      expr: DATE_TRUNC('MONTH', installation_date)
      comment: "Month of tyre installation — supports tyre consumption trend analysis and procurement planning."
  measures:
    - name: "total_tyre_count"
      expr: COUNT(1)
      comment: "Total number of tyre records. Baseline measure for tyre fleet inventory and consumption tracking."
    - name: "total_purchase_cost"
      expr: SUM(CAST(purchase_cost AS DOUBLE))
      comment: "Total tyre procurement expenditure. Tyres are a top-3 consumable cost in open-cut mining — this KPI drives procurement strategy and budget management."
    - name: "avg_cost_per_hour"
      expr: AVG(CAST(cost_per_hour AS DOUBLE))
      comment: "Average tyre cost per operating hour. The primary tyre performance KPI — enables brand, size, and application benchmarking to optimise tyre selection."
    - name: "avg_accumulated_hours"
      expr: AVG(CAST(accumulated_hours AS DOUBLE))
      comment: "Average tyre life in operating hours. Measures tyre durability and is the primary input for tyre life benchmarking and replacement planning."
    - name: "avg_accumulated_km"
      expr: AVG(CAST(accumulated_km AS DOUBLE))
      comment: "Average tyre life in kilometres. Complements hours-based life analysis and reflects haul road condition impact on tyre wear."
    - name: "avg_tread_depth_current_mm"
      expr: AVG(CAST(tread_depth_current_mm AS DOUBLE))
      comment: "Average current tread depth across in-service tyres. Measures fleet-wide tyre wear status and supports proactive removal scheduling."
    - name: "avg_tkph_actual"
      expr: AVG(CAST(tkph_actual AS DOUBLE))
      comment: "Average actual Tonne-Kilometres Per Hour (TKPH) loading. Measures thermal stress on tyres — values exceeding TKPH rating accelerate failure and are a leading indicator of tyre damage risk."
    - name: "overloaded_tyre_count"
      expr: COUNT(CASE WHEN tkph_actual > tkph_rating THEN 1 END)
      comment: "Number of tyres operating above their TKPH rating. Identifies tyres at elevated failure risk — drives haul road speed management and payload control interventions."
$$;
