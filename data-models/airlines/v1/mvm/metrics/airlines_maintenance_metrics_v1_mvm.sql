-- Metric views for domain: maintenance | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over maintenance work orders. Tracks labor efficiency, cost variance, AOG exposure, downtime, and work order throughput — core levers for MRO cost control and aircraft availability management."
  source: "`airlines_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of maintenance work order (e.g. scheduled, unscheduled, AOG) — primary segmentation for maintenance cost and throughput analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (e.g. open, in-progress, closed) — used to track pipeline and backlog."
    - name: "maintenance_check_type"
      expr: maintenance_check_type
      comment: "Check type associated with the work order (e.g. A-check, C-check, line maintenance) — drives cost and downtime benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the work order — used to assess urgency distribution and AOG risk exposure."
    - name: "ata_chapter_code"
      expr: ata_chapter_code
      comment: "ATA chapter code identifying the aircraft system addressed — enables fault-pattern analysis by system."
    - name: "aog_flag"
      expr: aog_flag
      comment: "Indicates whether the work order was raised as an Aircraft on Ground event — critical for availability and revenue-impact tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are denominated — required for multi-currency cost consolidation."
    - name: "work_order_month"
      expr: DATE_TRUNC('MONTH', CAST(created_timestamp AS DATE))
      comment: "Month the work order was created — enables trend analysis of maintenance volume and cost over time."
    - name: "originating_source"
      expr: originating_source
      comment: "System or process that originated the work order (e.g. defect report, scheduled program, AD) — supports root-cause and demand-driver analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume metric for maintenance throughput and workload capacity planning."
    - name: "aog_work_orders"
      expr: COUNT(CASE WHEN aog_flag = TRUE THEN 1 END)
      comment: "Number of AOG (Aircraft on Ground) work orders. Directly linked to revenue loss and fleet availability — a key operational risk KPI."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders. Core MRO cost driver used in budget vs. actuals and vendor performance reviews."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all work orders. Used as the budget baseline for labor cost variance analysis."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material/parts cost across all work orders. Key component of total MRO spend and inventory consumption tracking."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all work orders. Budget baseline for material cost variance analysis."
    - name: "total_actual_man_hours"
      expr: SUM(CAST(actual_man_hours AS DOUBLE))
      comment: "Total actual man-hours consumed across all work orders. Drives workforce capacity planning and labor productivity benchmarking."
    - name: "total_estimated_man_hours"
      expr: SUM(CAST(estimated_man_hours AS DOUBLE))
      comment: "Total estimated man-hours across all work orders. Used as the planned baseline for labor efficiency ratio computation."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total aircraft downtime hours attributable to maintenance work orders. Directly impacts fleet utilization and schedule reliability."
    - name: "avg_downtime_hours_per_work_order"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per work order. Benchmarks maintenance turnaround efficiency and identifies check types with excessive ground time."
    - name: "avg_actual_labor_cost_per_work_order"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average actual labor cost per work order. Used to benchmark unit labor cost across check types, AMOs, and time periods."
    - name: "avg_actual_man_hours_per_work_order"
      expr: AVG(CAST(actual_man_hours AS DOUBLE))
      comment: "Average actual man-hours per work order. Productivity benchmark for technician and AMO performance management."
    - name: "labor_cost_variance"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE) - CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total labor cost overrun (positive = over budget, negative = under budget). Critical for MRO contract management and budget governance."
    - name: "material_cost_variance"
      expr: SUM(CAST(actual_material_cost AS DOUBLE) - CAST(estimated_material_cost AS DOUBLE))
      comment: "Total material cost overrun across work orders. Signals parts pricing, consumption, or scoping estimation issues."
    - name: "man_hours_variance"
      expr: SUM(CAST(actual_man_hours AS DOUBLE) - CAST(estimated_man_hours AS DOUBLE))
      comment: "Total man-hours overrun (actual minus estimated). Measures labor estimation accuracy and technician productivity gaps."
    - name: "distinct_aircraft_in_maintenance"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft with active or historical work orders in the period. Indicates fleet maintenance exposure and AMO capacity demand."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over scheduled and unscheduled maintenance checks (A/B/C/D checks and line maintenance). Tracks check execution efficiency, cost performance, downtime, and schedule adherence — essential for fleet availability and MRO cost governance."
  source: "`airlines_ecm`.`maintenance`.`check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of maintenance check (e.g. A-check, C-check, D-check, line check) — primary segmentation for cost and downtime benchmarking."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the check (e.g. planned, in-progress, completed, deferred) — used to monitor execution pipeline and overdue checks."
    - name: "aog_event_flag"
      expr: aog_event_flag
      comment: "Indicates whether the check was triggered by or resulted in an AOG event — links maintenance execution to fleet availability risk."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of check cost figures — required for multi-currency MRO spend consolidation."
    - name: "check_induction_month"
      expr: DATE_TRUNC('MONTH', actual_induction_date)
      comment: "Month of actual check induction — enables trend analysis of check volume and cost over time."
    - name: "check_release_month"
      expr: DATE_TRUNC('MONTH', actual_release_date)
      comment: "Month of actual check release — used to track completion throughput and TAT trends."
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of maintenance checks executed. Baseline volume metric for MRO throughput and capacity planning."
    - name: "aog_checks"
      expr: COUNT(CASE WHEN aog_event_flag = TRUE THEN 1 END)
      comment: "Number of checks associated with AOG events. Directly linked to revenue loss and schedule disruption — a top-tier fleet availability KPI."
    - name: "total_actual_man_hours"
      expr: SUM(CAST(actual_man_hours AS DOUBLE))
      comment: "Total actual man-hours consumed across all checks. Core labor demand metric for AMO capacity and workforce planning."
    - name: "total_planned_man_hours"
      expr: SUM(CAST(planned_man_hours AS DOUBLE))
      comment: "Total planned man-hours across all checks. Budget baseline for labor efficiency and scope-creep analysis."
    - name: "man_hours_overrun"
      expr: SUM(CAST(actual_man_hours AS DOUBLE) - CAST(planned_man_hours AS DOUBLE))
      comment: "Total man-hours overrun (actual minus planned) across checks. Measures scope creep and estimation accuracy — a key MRO contract governance metric."
    - name: "avg_actual_man_hours_per_check"
      expr: AVG(CAST(actual_man_hours AS DOUBLE))
      comment: "Average actual man-hours per check. Benchmarks check execution effort by check type and AMO for performance management."
    - name: "total_downtime_days"
      expr: SUM(CAST(downtime_days AS DOUBLE))
      comment: "Total aircraft downtime days consumed by maintenance checks. Directly impacts fleet utilization rate and schedule reliability."
    - name: "avg_downtime_days_per_check"
      expr: AVG(CAST(downtime_days AS DOUBLE))
      comment: "Average downtime days per check. Turnaround time (TAT) benchmark — used to evaluate AMO performance and check planning efficiency."
    - name: "checks_completed_on_schedule"
      expr: COUNT(CASE WHEN actual_release_date <= scheduled_release_date AND check_status = 'COMPLETED' THEN 1 END)
      comment: "Number of checks released on or before the scheduled release date. Measures schedule adherence — a key AMO SLA and fleet planning KPI."
    - name: "checks_overdue"
      expr: COUNT(CASE WHEN actual_release_date > scheduled_release_date THEN 1 END)
      comment: "Number of checks released after the scheduled release date. Overdue checks signal AMO capacity issues, scope creep, or parts availability problems."
    - name: "distinct_aircraft_checked"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft that underwent checks in the period. Indicates fleet maintenance exposure and AMO workload distribution."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_defect_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over aircraft defect reports. Tracks defect volume, severity distribution, AOG exposure, MEL deferral rates, and rectification cycle times — essential for airworthiness management and safety performance monitoring."
  source: "`airlines_ecm`.`maintenance`.`defect_report`"
  dimensions:
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (e.g. open, deferred, rectified, closed) — used to monitor open defect backlog and rectification pipeline."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the defect — critical for safety risk prioritization and regulatory reporting."
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter identifying the aircraft system where the defect was found — enables fault-pattern analysis by system."
    - name: "discovery_phase"
      expr: discovery_phase
      comment: "Phase during which the defect was discovered (e.g. pre-flight, in-flight, post-flight, hangar check) — informs inspection program effectiveness."
    - name: "mel_category"
      expr: mel_category
      comment: "MEL category of the deferred defect (A/B/C/D) — determines maximum allowable deferral period and dispatch conditions."
    - name: "aog_flag"
      expr: aog_flag
      comment: "Indicates whether the defect caused an AOG condition — directly links defect management to fleet availability and revenue impact."
    - name: "safety_reportable_flag"
      expr: safety_reportable_flag
      comment: "Indicates whether the defect is reportable to the safety/regulatory authority — used for compliance monitoring."
    - name: "mel_applicable_flag"
      expr: mel_applicable_flag
      comment: "Indicates whether a MEL item applies to this defect — used to track deferral eligibility and dispatch decision quality."
    - name: "defect_discovery_month"
      expr: DATE_TRUNC('MONTH', CAST(discovery_timestamp AS DATE))
      comment: "Month the defect was discovered — enables trend analysis of defect rates and seasonal patterns."
  measures:
    - name: "total_defect_reports"
      expr: COUNT(1)
      comment: "Total number of defect reports raised. Baseline airworthiness quality metric — rising trends signal fleet aging, inspection gaps, or operational stress."
    - name: "aog_defects"
      expr: COUNT(CASE WHEN aog_flag = TRUE THEN 1 END)
      comment: "Number of defects that caused AOG conditions. Directly linked to revenue loss and schedule disruption — a top-tier fleet availability KPI."
    - name: "safety_reportable_defects"
      expr: COUNT(CASE WHEN safety_reportable_flag = TRUE THEN 1 END)
      comment: "Number of defects flagged as safety-reportable. Regulatory compliance KPI — must be tracked and reported to the airworthiness authority."
    - name: "mel_deferred_defects"
      expr: COUNT(CASE WHEN mel_applicable_flag = TRUE THEN 1 END)
      comment: "Number of defects deferred under MEL provisions. Tracks dispatch-with-defect exposure — high volumes signal fleet reliability concerns."
    - name: "open_defects"
      expr: COUNT(CASE WHEN defect_status NOT IN ('CLOSED', 'RECTIFIED') THEN 1 END)
      comment: "Number of defects not yet closed or rectified. Open defect backlog is a key airworthiness and maintenance workload indicator."
    - name: "high_severity_defects"
      expr: COUNT(CASE WHEN severity_level IN ('HIGH', 'CRITICAL') THEN 1 END)
      comment: "Number of high or critical severity defects. Prioritization metric for maintenance resource allocation and safety risk management."
    - name: "distinct_aircraft_with_defects"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft with defect reports in the period. Measures fleet-wide defect exposure and identifies chronic problem aircraft."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_mel_deferral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over MEL (Minimum Equipment List) deferrals. Tracks deferral volume, category distribution, extension rates, AOG risk exposure, and overdue deferrals — critical for airworthiness compliance and dispatch risk management."
  source: "`airlines_ecm`.`maintenance`.`mel_deferral`"
  dimensions:
    - name: "deferral_status"
      expr: deferral_status
      comment: "Current status of the MEL deferral (e.g. open, closed, expired, extended) — used to monitor active deferral backlog and compliance."
    - name: "mel_category"
      expr: mel_category
      comment: "MEL category (A/B/C/D) determining the maximum allowable deferral period — primary risk segmentation for dispatch compliance."
    - name: "aog_risk_flag"
      expr: aog_risk_flag
      comment: "Indicates whether the deferral carries AOG risk — used to prioritize rectification and assess fleet availability exposure."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicates whether regulatory notification is required for this deferral — compliance monitoring KPI."
    - name: "deferral_open_month"
      expr: DATE_TRUNC('MONTH', deferral_open_date)
      comment: "Month the deferral was opened — enables trend analysis of deferral rates and seasonal patterns."
    - name: "rectification_station_code"
      expr: rectification_station_code
      comment: "Station where the deferred defect was rectified — used to analyze rectification network capacity and station-level performance."
  measures:
    - name: "total_mel_deferrals"
      expr: COUNT(1)
      comment: "Total number of MEL deferrals raised. Baseline dispatch-with-defect volume metric — rising trends signal fleet reliability deterioration."
    - name: "open_mel_deferrals"
      expr: COUNT(CASE WHEN deferral_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open MEL deferrals. Active airworthiness exposure metric — directly impacts dispatch risk and regulatory compliance."
    - name: "aog_risk_deferrals"
      expr: COUNT(CASE WHEN aog_risk_flag = TRUE THEN 1 END)
      comment: "Number of deferrals carrying AOG risk. Highest-priority fleet availability KPI — each represents potential revenue loss if not rectified."
    - name: "overdue_deferrals"
      expr: COUNT(CASE WHEN deferral_status = 'OPEN' AND deferral_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open deferrals past their expiry date. Critical airworthiness compliance KPI — overdue deferrals are a regulatory violation risk."
    - name: "regulatory_notification_deferrals"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of deferrals requiring regulatory notification. Compliance tracking metric — missed notifications are a direct regulatory finding risk."
    - name: "category_a_deferrals"
      expr: COUNT(CASE WHEN mel_category = 'A' THEN 1 END)
      comment: "Number of Category A MEL deferrals (shortest allowable deferral period — highest urgency). Tracks the most time-critical dispatch compliance exposure."
    - name: "distinct_aircraft_with_deferrals"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft carrying active MEL deferrals. Fleet-wide dispatch compliance exposure metric used in airworthiness reviews."
    - name: "avg_flight_hours_at_deferral"
      expr: AVG(CAST(flight_hours_at_deferral AS DOUBLE))
      comment: "Average aircraft flight hours at the time of deferral. Used to correlate deferral rates with aircraft utilization intensity and aging."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_ad_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over Airworthiness Directive (AD) compliance records. Tracks AD compliance status, repetitive AD exposure, deferral rates, and accomplishment flight hours — essential for regulatory airworthiness compliance and safety oversight."
  source: "`airlines_ecm`.`maintenance`.`ad_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the AD (e.g. complied, deferred, not-applicable, overdue) — primary regulatory compliance segmentation."
    - name: "compliance_method"
      expr: compliance_method
      comment: "Method used to comply with the AD (e.g. inspection, modification, replacement, AMOC) — used to analyze compliance approach distribution."
    - name: "repetitive_flag"
      expr: repetitive_flag
      comment: "Indicates whether the AD requires repetitive compliance actions — repetitive ADs represent ongoing airworthiness obligations."
    - name: "applicability"
      expr: applicability
      comment: "Aircraft type or configuration applicability of the AD — used to scope compliance analysis to relevant fleet segments."
    - name: "accomplishment_month"
      expr: DATE_TRUNC('MONTH', accomplishment_date)
      comment: "Month the AD was accomplished — enables trend analysis of AD compliance activity and workload."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the next AD compliance action is due — used for forward-looking compliance workload planning."
  measures:
    - name: "total_ad_compliance_records"
      expr: COUNT(1)
      comment: "Total number of AD compliance records. Baseline metric for AD compliance program scope and activity volume."
    - name: "complied_ads"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIED' THEN 1 END)
      comment: "Number of ADs with confirmed compliance. Measures the size of the compliant AD portfolio — the numerator for compliance rate calculation."
    - name: "deferred_ads"
      expr: COUNT(CASE WHEN compliance_status = 'DEFERRED' THEN 1 END)
      comment: "Number of ADs with deferred compliance. Deferred ADs represent active regulatory risk — must be tracked and resolved within deferral limits."
    - name: "overdue_ads"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('COMPLIED', 'NOT-APPLICABLE') AND next_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of ADs past their next due date without confirmed compliance. Critical regulatory violation risk — requires immediate escalation."
    - name: "repetitive_ads"
      expr: COUNT(CASE WHEN repetitive_flag = TRUE THEN 1 END)
      comment: "Number of repetitive AD compliance records. Tracks ongoing airworthiness obligations that recur at defined intervals — key for maintenance program planning."
    - name: "amoc_approved_ads"
      expr: COUNT(CASE WHEN amoc_approval_number IS NOT NULL AND amoc_approval_number <> '' THEN 1 END)
      comment: "Number of ADs complied with via an Alternative Method of Compliance (AMOC). Tracks regulatory flexibility usage — AMOCs require authority approval and must be monitored."
    - name: "total_accomplishment_flight_hours"
      expr: SUM(CAST(accomplishment_flight_hours AS DOUBLE))
      comment: "Total flight hours accumulated at the time of AD accomplishment. Used to validate compliance against flight-hour-based AD thresholds."
    - name: "avg_accomplishment_flight_hours"
      expr: AVG(CAST(accomplishment_flight_hours AS DOUBLE))
      comment: "Average flight hours at AD accomplishment. Benchmarks whether ADs are being accomplished early, on-time, or late relative to flight-hour limits."
    - name: "distinct_aircraft_with_ad_compliance"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft with AD compliance records. Measures fleet-wide AD compliance program scope."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over aircraft components and rotable parts. Tracks life-limited part exposure, serviceable inventory, overhaul cycles, warranty coverage, and component criticality — essential for airworthiness, asset management, and MRO cost control."
  source: "`airlines_ecm`.`maintenance`.`component`"
  dimensions:
    - name: "serviceable_status"
      expr: serviceable_status
      comment: "Serviceability status of the component (e.g. serviceable, unserviceable, awaiting repair) — primary inventory health segmentation."
    - name: "criticality_classification"
      expr: criticality_classification
      comment: "Criticality classification of the component (e.g. life-limited, safety-critical, standard) — drives prioritization of maintenance and procurement."
    - name: "life_limited_part_flag"
      expr: life_limited_part_flag
      comment: "Indicates whether the component is a life-limited part (LLP) with a mandatory retirement limit — LLPs require strict cycle/hour tracking for airworthiness."
    - name: "rotable_flag"
      expr: rotable_flag
      comment: "Indicates whether the component is a rotable (repairable and reusable) part — rotables are high-value assets tracked through overhaul cycles."
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter of the component — enables analysis of component health and cost by aircraft system."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "OEM manufacturer of the component — used for vendor performance analysis and warranty claim management."
    - name: "condition_code"
      expr: condition_code
      comment: "Condition code of the component (e.g. new, overhauled, serviceable used) — used for inventory valuation and dispatch eligibility."
    - name: "owner_type"
      expr: owner_type
      comment: "Ownership type of the component (e.g. owned, leased, pooled) — impacts asset accounting and MRO cost allocation."
    - name: "installation_month"
      expr: DATE_TRUNC('MONTH', installation_date)
      comment: "Month the component was installed — enables analysis of installation activity trends and component turnover rates."
  measures:
    - name: "total_components"
      expr: COUNT(1)
      comment: "Total number of component records. Baseline fleet asset inventory metric."
    - name: "life_limited_parts_count"
      expr: COUNT(CASE WHEN life_limited_part_flag = TRUE THEN 1 END)
      comment: "Number of life-limited parts (LLPs) in the fleet. LLPs have mandatory retirement limits — tracking their count and remaining life is a core airworthiness obligation."
    - name: "unserviceable_components"
      expr: COUNT(CASE WHEN serviceable_status = 'UNSERVICEABLE' THEN 1 END)
      comment: "Number of unserviceable components. Measures the size of the unserviceable pool — high counts signal MRO capacity or supply chain constraints."
    - name: "components_near_life_limit"
      expr: COUNT(CASE WHEN life_limited_part_flag = TRUE AND cycles_remaining_to_limit < 500 THEN 1 END)
      comment: "Number of life-limited parts with fewer than 500 cycles remaining to their retirement limit. Forward-looking airworthiness risk metric — drives procurement and replacement planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all components. Fleet asset value metric used in fixed asset management and insurance valuation."
    - name: "avg_time_since_overhaul"
      expr: AVG(CAST(time_since_overhaul AS DOUBLE))
      comment: "Average time since last overhaul across components. Measures fleet-wide component age relative to overhaul intervals — rising averages signal increasing overhaul demand."
    - name: "avg_cycles_since_overhaul"
      expr: AVG(CAST(cycles_since_overhaul AS DOUBLE))
      comment: "Average cycles since last overhaul across components. Cycle-based complement to time-since-overhaul for components with cycle-driven overhaul intervals."
    - name: "total_time_since_new"
      expr: SUM(CAST(total_time_since_new AS DOUBLE))
      comment: "Total accumulated flight hours since new across all components. Fleet-wide component utilization metric used in reliability and aging analysis."
    - name: "components_with_expired_warranty"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of components with expired warranties. Tracks warranty coverage gaps — expired warranties increase MRO cost exposure for defects and failures."
    - name: "avg_time_remaining_to_limit"
      expr: AVG(CAST(time_remaining_to_limit AS DOUBLE))
      comment: "Average flight hours remaining to life limit across life-limited parts. Forward-looking airworthiness health metric — declining averages signal upcoming mandatory replacements."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_work_order_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over individual maintenance work order tasks. Tracks task-level labor efficiency, deferral rates, skill trade demand, and completion performance — enables granular MRO productivity analysis and technician workforce planning."
  source: "`airlines_ecm`.`maintenance`.`work_order_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g. open, in-progress, completed, deferred) — used to monitor task pipeline and backlog."
    - name: "task_type"
      expr: task_type
      comment: "Type of maintenance task (e.g. inspection, repair, replacement, modification) — primary segmentation for labor demand and cost analysis."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task — used to assess urgency distribution and resource allocation effectiveness."
    - name: "skill_trade_required"
      expr: skill_trade_required
      comment: "Skill trade or license type required to perform the task (e.g. avionics, structures, powerplant) — drives workforce planning and trade-mix analysis."
    - name: "ata_chapter"
      expr: ata_chapter
      comment: "ATA chapter of the task — enables fault-pattern and labor demand analysis by aircraft system."
    - name: "deferral_flag"
      expr: deferral_flag
      comment: "Indicates whether the task has been deferred — deferred tasks represent unresolved maintenance obligations and airworthiness risk."
    - name: "work_location"
      expr: work_location
      comment: "Physical location where the task is performed (e.g. hangar, line, shop) — used to analyze workload distribution across maintenance facilities."
    - name: "task_start_month"
      expr: DATE_TRUNC('MONTH', CAST(task_start_timestamp AS DATE))
      comment: "Month the task was started — enables trend analysis of task volume and labor demand over time."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of work order tasks. Baseline maintenance activity volume metric for workload and capacity planning."
    - name: "deferred_tasks"
      expr: COUNT(CASE WHEN deferral_flag = TRUE THEN 1 END)
      comment: "Number of deferred tasks. Tracks unresolved maintenance obligations — high deferral rates signal capacity constraints or parts availability issues."
    - name: "overdue_deferred_tasks"
      expr: COUNT(CASE WHEN deferral_flag = TRUE AND deferral_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of deferred tasks past their deferral expiry date. Critical airworthiness compliance KPI — overdue deferrals are a regulatory violation risk."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all tasks. Core workforce productivity and MRO cost driver metric."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all tasks. Budget baseline for task-level labor efficiency analysis."
    - name: "labor_hours_overrun"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE) - CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total labor hours overrun (actual minus estimated) across tasks. Measures task-level estimation accuracy and technician productivity gaps."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost_amount AS DOUBLE))
      comment: "Total materials cost consumed across all tasks. Task-level parts and consumables spend — key component of total MRO cost."
    - name: "avg_actual_labor_hours_per_task"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per task. Benchmarks task execution effort by task type and skill trade for productivity management."
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed tasks. Throughput metric for maintenance execution — used alongside total tasks to derive completion rate."
    - name: "distinct_technicians"
      expr: COUNT(DISTINCT member_id)
      comment: "Number of distinct technicians who performed tasks in the period. Workforce utilization metric for AMO capacity and staffing analysis."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_technical_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over aircraft technical log entries. Tracks flight-sector airworthiness status, fuel and oil consumption, defect raise rates, CRS issuance, and MEL active item counts — the primary real-time airworthiness and operational health data source."
  source: "`airlines_ecm`.`maintenance`.`technical_log`"
  dimensions:
    - name: "technical_log_status"
      expr: technical_log_status
      comment: "Status of the technical log entry (e.g. open, closed, CRS-issued) — used to monitor airworthiness release pipeline."
    - name: "pre_flight_inspection_status"
      expr: pre_flight_inspection_status
      comment: "Outcome of the pre-flight inspection (e.g. satisfactory, defects-found, deferred) — key airworthiness dispatch readiness indicator."
    - name: "crs_issued_flag"
      expr: crs_issued_flag
      comment: "Indicates whether a Certificate of Release to Service was issued for the sector — mandatory airworthiness compliance indicator."
    - name: "arrival_station_code"
      expr: arrival_station_code
      comment: "IATA code of the arrival station — used to analyze defect and fuel consumption patterns by station."
    - name: "sector_month"
      expr: DATE_TRUNC('MONTH', sector_date)
      comment: "Month of the flight sector — enables trend analysis of technical log activity, defect rates, and fuel consumption over time."
  measures:
    - name: "total_technical_log_entries"
      expr: COUNT(1)
      comment: "Total number of technical log entries. Baseline metric for flight sector airworthiness activity volume."
    - name: "sectors_without_crs"
      expr: COUNT(CASE WHEN crs_issued_flag = FALSE THEN 1 END)
      comment: "Number of sectors where a CRS was not issued. Critical airworthiness compliance KPI — sectors without CRS represent potential regulatory violations."
    - name: "total_block_hours"
      expr: SUM(CAST(block_hours AS DOUBLE))
      comment: "Total block hours recorded across all technical log entries. Fleet utilization metric — block hours drive maintenance interval calculations and cost-per-block-hour KPIs."
    - name: "total_flight_hours"
      expr: SUM(CAST(flight_hours AS DOUBLE))
      comment: "Total flight hours recorded in technical logs. Core airworthiness utilization metric — drives AD compliance thresholds and component life tracking."
    - name: "total_fuel_uplift_kg"
      expr: SUM(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Total fuel uplift in kilograms across all sectors. Operational cost metric — fuel is the largest single cost item for airlines."
    - name: "avg_fuel_uplift_per_sector"
      expr: AVG(CAST(fuel_uplift_kg AS DOUBLE))
      comment: "Average fuel uplift per sector. Efficiency benchmark — deviations from baseline signal fuel planning, tankering, or aircraft performance issues."
    - name: "total_oil_uplift_litres"
      expr: SUM(CAST(oil_uplift_litres AS DOUBLE))
      comment: "Total oil uplift in litres across all sectors. Elevated oil consumption is an early indicator of engine or APU deterioration — a predictive maintenance KPI."
    - name: "avg_oil_uplift_per_sector"
      expr: AVG(CAST(oil_uplift_litres AS DOUBLE))
      comment: "Average oil uplift per sector. Benchmarks normal oil consumption — spikes indicate engine health issues requiring investigation."
    - name: "distinct_aircraft_in_service"
      expr: COUNT(DISTINCT aircraft_id)
      comment: "Number of distinct aircraft with technical log entries in the period. Measures active fleet size contributing to operational data."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_approved_maintenance_org`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over Approved Maintenance Organisations (AMOs/Part-145 organisations). Tracks AMO approval status, capability ratings, audit findings, quality scores, and contract coverage — essential for MRO vendor governance and regulatory compliance."
  source: "`airlines_ecm`.`maintenance`.`approved_maintenance_org`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the AMO (e.g. approved, suspended, expired) — primary regulatory compliance segmentation for the MRO vendor network."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of maintenance organisation (e.g. base maintenance, line maintenance, component shop, engine shop) — used to segment vendor capability analysis."
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the commercial contract with the AMO (e.g. active, expired, pending) — used to monitor vendor contract coverage."
    - name: "country_code"
      expr: country_code
      comment: "Country where the AMO is located — used for geographic analysis of MRO network coverage and regulatory jurisdiction."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the AMO is a preferred vendor — used to track preferred vendor utilization and compliance."
    - name: "aog_support_available_flag"
      expr: aog_support_available_flag
      comment: "Indicates whether the AMO offers AOG support — critical for network resilience and AOG recovery planning."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the AMO approval (e.g. EASA, FAA, GCAA) — used to segment the vendor network by regulatory jurisdiction."
  measures:
    - name: "total_approved_maintenance_orgs"
      expr: COUNT(1)
      comment: "Total number of AMOs in the network. Baseline MRO vendor network size metric."
    - name: "active_approved_orgs"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of AMOs with current valid approval. Measures the size of the compliant, usable MRO vendor network."
    - name: "orgs_with_expiring_approval"
      expr: COUNT(CASE WHEN approval_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of AMOs whose approval expires within 90 days. Forward-looking compliance risk metric — expiring approvals must be renewed before work can be assigned."
    - name: "orgs_with_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of AMOs with active commercial contracts. Measures contracted MRO network coverage — gaps indicate procurement risk."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across all AMOs. Composite vendor performance KPI used in MRO supplier scorecards and contract renewal decisions."
    - name: "aog_capable_orgs"
      expr: COUNT(CASE WHEN aog_support_available_flag = TRUE THEN 1 END)
      comment: "Number of AMOs offering AOG support. Network resilience metric — insufficient AOG-capable vendors increase recovery time and revenue loss exposure."
    - name: "preferred_vendor_orgs"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendor AMOs. Tracks preferred vendor network size — used to monitor vendor consolidation strategy execution."
    - name: "orgs_overdue_for_audit"
      expr: COUNT(CASE WHEN next_audit_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of AMOs overdue for their next scheduled audit. Regulatory compliance KPI — overdue audits are a finding risk during authority oversight inspections."
$$;


CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`maintenance_airworthiness_directive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the Airworthiness Directive (AD) master register. Tracks AD portfolio size, compliance cost estimates, labor burden, active vs. superseded AD distribution, and compliance threshold analysis — essential for regulatory program planning and cost forecasting."
  source: "`airlines_ecm`.`maintenance`.`airworthiness_directive`"
  dimensions:
    - name: "ad_status"
      expr: ad_status
      comment: "Current status of the AD (e.g. active, superseded, cancelled) — used to scope the active compliance obligation portfolio."
    - name: "aircraft_type"
      expr: aircraft_type
      comment: "Aircraft type to which the AD applies — primary segmentation for fleet-specific compliance cost and workload analysis."
    - name: "compliance_method"
      expr: compliance_method
      comment: "Required compliance method (e.g. inspection, modification, replacement) — used to analyze compliance approach distribution and resource requirements."
    - name: "component_type"
      expr: component_type
      comment: "Component type affected by the AD — enables analysis of AD burden by aircraft system and component category."
    - name: "compliance_interval_unit"
      expr: compliance_interval_unit
      comment: "Unit of the compliance interval (e.g. flight hours, cycles, calendar days) — used to categorize ADs by compliance tracking method."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the AD became effective — enables trend analysis of new AD issuance rates and compliance obligation growth."
  measures:
    - name: "total_airworthiness_directives"
      expr: COUNT(1)
      comment: "Total number of ADs in the register. Baseline metric for the size of the regulatory compliance obligation portfolio."
    - name: "active_airworthiness_directives"
      expr: COUNT(CASE WHEN ad_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active ADs. Measures the live compliance obligation portfolio — the primary scope metric for AD program management."
    - name: "total_estimated_cost_per_aircraft"
      expr: SUM(CAST(estimated_cost_per_aircraft AS DOUBLE))
      comment: "Total estimated compliance cost per aircraft across all active ADs. Fleet-level AD cost burden metric used in maintenance budget forecasting."
    - name: "avg_estimated_cost_per_aircraft"
      expr: AVG(CAST(estimated_cost_per_aircraft AS DOUBLE))
      comment: "Average estimated compliance cost per aircraft per AD. Benchmarks AD cost intensity — used to prioritize high-cost ADs for budget planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours required to comply with all ADs. Fleet-wide AD labor burden metric for workforce and AMO capacity planning."
    - name: "avg_estimated_labor_hours_per_ad"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per AD. Benchmarks AD labor intensity — high-labor ADs require advance AMO capacity reservation."
    - name: "avg_compliance_threshold_value"
      expr: AVG(CAST(compliance_threshold_value AS DOUBLE))
      comment: "Average compliance threshold value (hours/cycles/days) across ADs. Indicates the typical urgency horizon of the AD portfolio — lower averages signal near-term compliance pressure."
$$;
