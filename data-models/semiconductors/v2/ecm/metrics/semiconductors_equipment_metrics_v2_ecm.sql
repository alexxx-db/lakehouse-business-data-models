-- Metric views for domain: equipment | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fab_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for fab tool asset management: utilization, OEE, capital investment, and lifecycle health across the tool fleet. Used by VP of Manufacturing and Equipment Engineering leadership to steer capital allocation and maintenance strategy."
  source: "`vibe_semiconductors_v1`.`equipment`.`fab_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Category of fab tool (e.g., lithography, etch, CVD) for fleet segmentation and benchmarking."
    - name: "tool_subtype"
      expr: tool_subtype
      comment: "Sub-classification of tool type for granular equipment analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the tool (active, idle, decommissioned) for fleet health reporting."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational lifecycle phase of the tool for capital planning decisions."
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "Cleanroom classification where the tool operates, relevant for process compatibility analysis."
    - name: "process_node_compatibility"
      expr: process_node_compatibility
      comment: "Technology node(s) the tool supports, enabling node-level capacity analysis."
    - name: "purchase_date_month"
      expr: DATE_TRUNC('MONTH', purchase_date)
      comment: "Month of tool purchase for capital expenditure trend analysis."
    - name: "installation_date_year"
      expr: DATE_TRUNC('YEAR', installation_date)
      comment: "Year of tool installation for fleet age and depreciation cohort analysis."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the tool, critical for export control and audit readiness."
  measures:
    - name: "total_tools"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Total number of distinct fab tools in the fleet. Baseline KPI for capacity planning and fleet size tracking."
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across the tool fleet. Core manufacturing efficiency KPI used in QBRs to benchmark against world-class 85% target."
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital invested in the tool fleet. Drives capital allocation decisions and ROI analysis for equipment investment."
    - name: "avg_capital_expenditure_per_tool"
      expr: AVG(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Average capital expenditure per tool. Used to benchmark new tool acquisition costs against fleet average."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across the fleet. Key reliability KPI — declining MTBF triggers preventive maintenance investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across the fleet. Measures maintenance responsiveness; high MTTR signals need for spare parts or technician capacity investment."
    - name: "avg_capacity_wafer_per_hour"
      expr: AVG(CAST(capacity_wafer_per_hour AS DOUBLE))
      comment: "Average wafer throughput capacity per tool per hour. Drives fab capacity planning and bottleneck identification."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across the tool fleet in kWh. Informs sustainability reporting and energy cost reduction initiatives."
    - name: "tools_with_expired_warranty"
      expr: COUNT(DISTINCT CASE WHEN warranty_expiration_date < CURRENT_DATE() THEN fab_tool_id END)
      comment: "Number of tools with expired warranties. Drives maintenance contract renewal and risk exposure decisions."
    - name: "tools_with_expired_calibration"
      expr: COUNT(DISTINCT CASE WHEN calibration_due_date < CURRENT_DATE() THEN fab_tool_id END)
      comment: "Number of tools past their calibration due date. Critical compliance KPI — out-of-calibration tools risk process excursions and regulatory findings."
    - name: "tools_requiring_maintenance"
      expr: COUNT(DISTINCT CASE WHEN last_maintenance_date < DATE_ADD(CURRENT_DATE(), -90) THEN fab_tool_id END)
      comment: "Number of tools that have not received maintenance in over 90 days. Operational risk indicator for equipment reliability."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for Overall Equipment Effectiveness (OEE) tracking at the tool level. Used by Manufacturing Operations and Equipment Engineering to identify availability, performance, and quality losses and drive continuous improvement."
  source: "`vibe_semiconductors_v1`.`equipment`.`oee_record`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the production shift for daily OEE trend analysis."
    - name: "shift_date_week"
      expr: DATE_TRUNC('WEEK', shift_date)
      comment: "Week of the shift for weekly OEE performance reporting."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift for monthly OEE trend and target tracking."
    - name: "shift_name"
      expr: shift_name
      comment: "Shift identifier (day/swing/night) for shift-level OEE comparison."
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime loss (planned, unplanned, engineering) for loss analysis and prioritization."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific reason code for downtime events, enabling Pareto analysis of top loss drivers."
    - name: "record_status"
      expr: record_status
      comment: "Status of the OEE record (confirmed, provisional) for data quality filtering."
    - name: "oee_calculation_method"
      expr: oee_calculation_method
      comment: "Method used to calculate OEE for consistency and comparability across sites."
  measures:
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage across all records. Primary manufacturing efficiency KPI benchmarked against world-class 85% target in steering meetings."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate. Measures the proportion of scheduled time the tool is available to run — key input to capacity planning."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average equipment performance rate. Measures actual throughput vs. theoretical maximum — identifies speed loss and micro-stoppages."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate from OEE decomposition. Measures good output vs. total output — directly linked to yield and scrap cost."
    - name: "total_downtime_hours"
      expr: SUM(CAST(scheduled_downtime_hours AS DOUBLE) + CAST(unscheduled_downtime_hours AS DOUBLE))
      comment: "Total downtime hours (scheduled + unscheduled). Drives maintenance scheduling and capacity recovery decisions."
    - name: "total_unscheduled_downtime_hours"
      expr: SUM(CAST(unscheduled_downtime_hours AS DOUBLE))
      comment: "Total unscheduled (reactive) downtime hours. High unscheduled downtime signals need for predictive maintenance investment."
    - name: "total_productive_hours"
      expr: SUM(CAST(productive_hours AS DOUBLE))
      comment: "Total hours the tool was productively running. Core capacity utilization metric for fab throughput planning."
    - name: "total_available_hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total scheduled available hours for the tool fleet. Denominator for utilization rate calculations."
    - name: "avg_wafer_throughput"
      expr: AVG(CAST(wafer_throughput AS DOUBLE))
      comment: "Average wafer throughput per OEE record period. Directly measures fab output rate and capacity utilization."
    - name: "unscheduled_downtime_ratio"
      expr: ROUND(100.0 * SUM(CAST(unscheduled_downtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(available_hours AS DOUBLE)), 0), 2)
      comment: "Unscheduled downtime as a percentage of available hours. Key reliability KPI — high ratio triggers root cause investigation and maintenance strategy review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for equipment maintenance execution: cost, labor efficiency, downtime impact, and compliance. Used by Equipment Engineering and Finance to manage maintenance spend, optimize PM programs, and ensure regulatory compliance."
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of maintenance event (preventive, corrective, emergency) for maintenance strategy analysis."
    - name: "maintenance_category"
      expr: maintenance_category
      comment: "Category of maintenance activity for cost allocation and program effectiveness analysis."
    - name: "maintenance_event_status"
      expr: maintenance_event_status
      comment: "Current status of the maintenance event (open, in-progress, closed) for work order management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the maintenance event for failure mode analysis and prevention."
    - name: "trigger_source"
      expr: trigger_source
      comment: "What triggered the maintenance event (alarm, schedule, operator) for proactive vs. reactive analysis."
    - name: "requalification_required"
      expr: requalification_required
      comment: "Whether tool requalification is required post-maintenance — impacts production scheduling and cycle time."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the maintenance event involved a safety incident — critical for EHS compliance reporting."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the maintenance event started for trend analysis of maintenance frequency and cost."
  measures:
    - name: "total_maintenance_events"
      expr: COUNT(1)
      comment: "Total number of maintenance events. Baseline KPI for maintenance workload and frequency tracking."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all maintenance events including labor and parts. Primary financial KPI for maintenance budget management."
    - name: "avg_maintenance_cost_per_event"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per maintenance event. Benchmarks maintenance efficiency and identifies high-cost outliers for investigation."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_total AS DOUBLE))
      comment: "Total labor cost across all maintenance events. Drives workforce planning and outsourcing decisions for maintenance."
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost_total AS DOUBLE))
      comment: "Total spare parts cost across all maintenance events. Informs spare parts inventory investment and supplier negotiations."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed by maintenance activities. Drives technician headcount and skills planning."
    - name: "avg_oee_impact_per_event"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage per maintenance event. Quantifies the production loss associated with maintenance activities."
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_incident_flag = TRUE THEN maintenance_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance events involving a safety incident. Critical EHS KPI — any increase triggers immediate safety program review."
    - name: "requalification_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN requalification_required = TRUE THEN maintenance_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance events requiring tool requalification. High rate signals process instability and impacts fab cycle time."
    - name: "labor_cost_as_pct_of_total"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_total AS DOUBLE)) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of total maintenance cost. Informs make-vs-buy decisions for maintenance services."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for equipment downtime analysis: duration, frequency, OEE impact, and root cause distribution. Used by Manufacturing Operations and Equipment Engineering to minimize unplanned downtime and maximize fab throughput."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (planned, unplanned, engineering hold) for loss categorization and prioritization."
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Specific reason code for the downtime event — enables Pareto analysis of top downtime drivers."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the downtime event — drives corrective action prioritization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the downtime event for risk-based prioritization of recovery actions."
    - name: "scheduled_flag"
      expr: scheduled_flag
      comment: "Whether the downtime was scheduled (planned) or unscheduled (reactive) — key for maintenance strategy analysis."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the downtime occurred for shift-level performance analysis."
    - name: "downtime_start_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month the downtime started for trend analysis of downtime frequency and duration."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline frequency KPI for reliability trending and alarm management."
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact per downtime event. Quantifies production loss per incident — drives prioritization of root cause elimination."
    - name: "total_oee_impact"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Cumulative OEE impact across all downtime events. Measures total production loss attributable to equipment downtime in the period."
    - name: "unplanned_downtime_event_count"
      expr: COUNT(DISTINCT CASE WHEN scheduled_flag = FALSE THEN tool_downtime_id END)
      comment: "Count of unplanned downtime events. High unplanned count signals reactive maintenance culture and drives PM program investment."
    - name: "planned_vs_unplanned_ratio"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN scheduled_flag = TRUE THEN tool_downtime_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that were planned. World-class fabs target >80% planned downtime — low ratio triggers maintenance strategy review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_fdc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Fault Detection and Classification (FDC) events: alarm frequency, severity distribution, OEE impact, and escalation rates. Used by Process Control and Equipment Engineering to detect process excursions and prevent yield loss."
  source: "`vibe_semiconductors_v1`.`equipment`.`fdc_event`"
  dimensions:
    - name: "alarm_type"
      expr: alarm_type
      comment: "Type of FDC alarm (limit violation, trend, pattern) for alarm classification and prioritization."
    - name: "severity"
      expr: severity
      comment: "Severity level of the FDC event — drives escalation and response time requirements."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category assigned to the FDC event for systematic failure mode elimination."
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (open, acknowledged, cleared) for work queue management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the event was escalated — high escalation rate signals systemic equipment or process issues."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter that triggered the FDC event for parameter-level fault analysis."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_timestamp)
      comment: "Month the FDC event occurred for trend analysis of alarm frequency over time."
  measures:
    - name: "total_fdc_events"
      expr: COUNT(1)
      comment: "Total number of FDC events. Baseline KPI for process control health — rising event count signals process drift or equipment degradation."
    - name: "escalated_event_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN fdc_event_id END)
      comment: "Number of FDC events that were escalated. High escalation count indicates systemic issues requiring engineering intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN fdc_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FDC events that were escalated. Key process control KPI — high escalation rate triggers process recipe or equipment review."
    - name: "avg_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact per FDC event. Quantifies the production loss associated with fault events — drives prioritization of alarm reduction programs."
    - name: "total_oee_impact"
      expr: SUM(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Total OEE impact from all FDC events in the period. Measures cumulative production loss from process faults."
    - name: "avg_parameter_value"
      expr: AVG(CAST(parameter_value AS DOUBLE))
      comment: "Average parameter value at time of FDC event. Used to assess how far process parameters deviate from nominal during fault conditions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for equipment calibration compliance and measurement quality. Used by Metrology and Quality Engineering to ensure measurement system integrity, track calibration pass rates, and manage compliance risk."
  source: "`vibe_semiconductors_v1`.`equipment`.`calibration_record`"
  dimensions:
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (dimensional, electrical, optical) for calibration program analysis."
    - name: "calibration_method"
      expr: calibration_method
      comment: "Method used for calibration for measurement system analysis and standardization."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Calibration pass/fail outcome — primary quality indicator for measurement system health."
    - name: "calibration_record_status"
      expr: calibration_record_status
      comment: "Administrative status of the calibration record for compliance tracking."
    - name: "calibration_result_code"
      expr: calibration_result_code
      comment: "Detailed result code for the calibration outcome — enables granular failure mode analysis."
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_timestamp)
      comment: "Month of calibration for trend analysis of calibration frequency and pass rates."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibration parameter — enables cross-tool comparability."
  measures:
    - name: "total_calibrations"
      expr: COUNT(1)
      comment: "Total number of calibration records. Baseline KPI for calibration program activity and compliance coverage."
    - name: "calibration_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_result = 'PASS' THEN calibration_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations that passed. Core measurement system quality KPI — declining pass rate signals tool drift or degradation requiring immediate action."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across calibration records. Used to detect systematic bias in measurement systems."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrations. High uncertainty signals need for measurement system improvement or tool replacement."
    - name: "overdue_calibration_count"
      expr: COUNT(DISTINCT CASE WHEN next_due_date < CURRENT_DATE() THEN calibration_record_id END)
      comment: "Number of calibration records where the next due date has passed. Compliance risk KPI — overdue calibrations can invalidate process data and trigger regulatory findings."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_spc_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Statistical Process Control (SPC) monitoring at the equipment level: violation rates, compliance, and process stability. Used by Process Control Engineering and Quality to maintain process capability and prevent yield excursions."
  source: "`vibe_semiconductors_v1`.`equipment`.`spc_control`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC chart (X-bar, R, EWMA) for control chart methodology analysis."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of SPC rule violation (Western Electric, Nelson) for systematic pattern analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the SPC violation for risk-based prioritization of corrective actions."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Process parameter being monitored — enables parameter-level process stability analysis."
    - name: "spc_control_status"
      expr: spc_control_status
      comment: "Current status of the SPC control record (open, resolved, false alarm) for work queue management."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of corrective action for the SPC violation — tracks closure rate of process excursions."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the SPC event was detected for shift-level process stability comparison."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the SPC event for trend analysis of process control performance."
  measures:
    - name: "total_spc_events"
      expr: COUNT(1)
      comment: "Total number of SPC control events. Baseline KPI for process control activity — rising count signals process instability."
    - name: "false_alarm_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_false_alarm = TRUE THEN spc_control_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC events that were false alarms. High false alarm rate erodes operator confidence and masks real process excursions."
    - name: "repeat_violation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_repeat_violation = TRUE THEN spc_control_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC violations that are repeat occurrences. High repeat rate signals ineffective corrective actions and systemic process issues."
    - name: "compliance_violation_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_flag = FALSE THEN spc_control_id END)
      comment: "Number of SPC events with compliance violations. Regulatory risk KPI — compliance violations can trigger customer notifications and audit findings."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value across SPC events. Used to assess process centering relative to target."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for monitored parameters. Used alongside avg_measured_value to quantify process bias."
    - name: "regulatory_reported_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_reported = TRUE THEN spc_control_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SPC violations that required regulatory reporting. Tracks compliance exposure and regulatory relationship health."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_recipe_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for process recipe execution quality and efficiency: yield, OEE components, parameter adherence, and compliance. Used by Process Engineering and Manufacturing Operations to optimize recipe performance and ensure process control."
  source: "`vibe_semiconductors_v1`.`equipment`.`recipe_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Status of the recipe execution (completed, aborted, failed) for process reliability analysis."
    - name: "recipe_version"
      expr: recipe_version
      comment: "Version of the recipe executed — enables version-to-version performance comparison for recipe qualification."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment on which the recipe was executed for cross-tool performance benchmarking."
    - name: "process_step"
      expr: process_step
      comment: "Process step at which the recipe was executed for step-level yield and performance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the recipe execution for regulatory and quality audit readiness."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the recipe execution is on a critical process step — enables risk-weighted performance analysis."
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month of recipe execution for trend analysis of process performance over time."
  measures:
    - name: "total_recipe_executions"
      expr: COUNT(1)
      comment: "Total number of recipe executions. Baseline throughput KPI for process activity and tool utilization."
    - name: "avg_oee_availability"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability component during recipe execution. Measures tool readiness for production runs."
    - name: "avg_oee_performance"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance component during recipe execution. Measures actual vs. theoretical throughput rate."
    - name: "avg_oee_quality"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality component during recipe execution. Measures first-pass yield at the recipe level."
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average recipe execution duration in seconds. Deviations from target duration signal process drift or equipment issues."
    - name: "avg_temperature_setpoint_c"
      expr: AVG(CAST(temperature_setpoint_c AS DOUBLE))
      comment: "Average temperature setpoint across recipe executions. Used for process parameter consistency monitoring."
    - name: "avg_temperature_actual_c"
      expr: AVG(CAST(temperature_actual_c AS DOUBLE))
      comment: "Average actual temperature during recipe execution. Compared against setpoint to detect thermal control issues."
    - name: "temperature_deviation"
      expr: ROUND(AVG(CAST(temperature_actual_c AS DOUBLE)) - AVG(CAST(temperature_setpoint_c AS DOUBLE)), 4)
      comment: "Average deviation between actual and setpoint temperature. Non-zero deviation signals thermal control drift requiring calibration or maintenance."
    - name: "non_compliant_execution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status != 'COMPLIANT' THEN recipe_execution_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipe executions with non-compliant status. Compliance risk KPI — high rate triggers process audit and corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_maintenance_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for equipment maintenance contract portfolio management: contract value, SLA performance, and renewal risk. Used by Procurement and Equipment Engineering to manage vendor relationships and ensure service coverage."
  source: "`vibe_semiconductors_v1`.`equipment`.`maintenance_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of maintenance contract (full-service, time-and-materials, OEM) for portfolio analysis."
    - name: "maintenance_contract_status"
      expr: maintenance_contract_status
      comment: "Current status of the contract (active, expired, pending renewal) for contract lifecycle management."
    - name: "service_level"
      expr: service_level
      comment: "Service level tier of the contract (gold, silver, bronze) for coverage quality analysis."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment covered by the contract for spend analysis by equipment type."
    - name: "currency"
      expr: currency
      comment: "Currency of the contract value for multi-currency portfolio analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the contract is exclusive to a single vendor — impacts negotiation leverage and risk concentration."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective for contract vintage analysis."
  measures:
    - name: "total_active_contracts"
      expr: COUNT(DISTINCT CASE WHEN maintenance_contract_status = 'ACTIVE' THEN maintenance_contract_id END)
      comment: "Number of active maintenance contracts. Baseline KPI for service coverage breadth across the tool fleet."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total value of all maintenance contracts. Primary financial KPI for maintenance spend management and budget planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value. Used to benchmark new contract negotiations against portfolio average."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN maintenance_contract_id END)
      comment: "Number of contracts expiring within 90 days. Renewal risk KPI — drives proactive procurement action to avoid coverage gaps."
    - name: "expired_contract_count"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date < CURRENT_DATE() AND maintenance_contract_status = 'ACTIVE' THEN maintenance_contract_id END)
      comment: "Number of contracts past their end date but still marked active. Compliance risk indicator requiring immediate contract management action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_capex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for equipment capital expenditure management: investment levels, warranty coverage, and cost structure. Used by Finance and Equipment Engineering leadership to govern capital allocation and track tool investment ROI."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_capex`"
  dimensions:
    - name: "tool_capex_status"
      expr: tool_capex_status
      comment: "Status of the capital expenditure (approved, in-progress, capitalized, closed) for CAPEX pipeline management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the tool asset for financial reporting consistency."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the capital expenditure (internal, CHIPS Act grant, debt) for capital structure analysis."
    - name: "extended_warranty_flag"
      expr: extended_warranty_flag
      comment: "Whether an extended warranty was purchased — impacts total cost of ownership analysis."
    - name: "capex_year"
      expr: DATE_TRUNC('YEAR', capex_date)
      comment: "Year of the capital expenditure for annual CAPEX trend and budget vs. actual analysis."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage for risk and cost analysis of warranty portfolio."
  measures:
    - name: "total_capex_investment"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total capital investment across all tool CAPEX records. Primary financial KPI for equipment investment governance and board reporting."
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price of tools. Used to calculate installation and NRE cost as a percentage of purchase price."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total installation cost across all tool CAPEX. Measures the cost of bringing tools into production — typically 10-20% of purchase price."
    - name: "total_nre_charges"
      expr: SUM(CAST(nre_charges AS DOUBLE))
      comment: "Total Non-Recurring Engineering charges associated with tool acquisitions. Tracks customization and integration costs."
    - name: "total_warranty_claim_amount"
      expr: SUM(CAST(warranty_claim_total_amount AS DOUBLE))
      comment: "Total value of warranty claims filed. High warranty claim value signals quality issues with tool suppliers and informs future procurement decisions."
    - name: "avg_response_time_sla_hours"
      expr: AVG(CAST(response_time_sla_hours AS DOUBLE))
      comment: "Average SLA response time commitment across tool CAPEX contracts. Benchmarks service level expectations for equipment support."
    - name: "installation_cost_as_pct_of_purchase"
      expr: ROUND(100.0 * SUM(CAST(installation_cost AS DOUBLE)) / NULLIF(SUM(CAST(purchase_price AS DOUBLE)), 0), 2)
      comment: "Installation cost as a percentage of purchase price. High ratio signals complex installation requirements and informs total cost of ownership modeling."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_tool_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for tool qualification program management: qualification cycle time, pass rates, and compliance. Used by Process Engineering and Quality to ensure tools are qualified before production use and to manage requalification risk."
  source: "`vibe_semiconductors_v1`.`equipment`.`tool_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (IQ, OQ, PQ, requalification) for qualification program analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification (passed, failed, in-progress, expired) for qualification pipeline management."
    - name: "qualification_reason"
      expr: qualification_reason
      comment: "Reason for qualification (new tool, post-maintenance, process change) for root cause analysis of requalification burden."
    - name: "process_node"
      expr: process_node
      comment: "Technology node for which the tool is being qualified — enables node-level qualification coverage analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the qualification is for a critical process step — enables risk-weighted qualification tracking."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the qualification for regulatory readiness tracking."
    - name: "qualification_start_month"
      expr: DATE_TRUNC('MONTH', qualification_start_date)
      comment: "Month qualification started for cycle time trend analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of tool qualification records. Baseline KPI for qualification program activity and tool readiness pipeline."
    - name: "qualification_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN qualification_status = 'PASSED' THEN tool_qualification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications that passed. Core quality KPI — low pass rate signals process or equipment issues requiring engineering investigation."
    - name: "avg_oee_impact"
      expr: AVG(CAST(oee_impact AS DOUBLE))
      comment: "Average OEE impact during tool qualification activities. Quantifies production capacity consumed by qualification programs."
    - name: "avg_result_metric_value"
      expr: AVG(CAST(result_metric_value AS DOUBLE))
      comment: "Average qualification result metric value. Used to assess qualification margin relative to specification limits."
    - name: "expired_qualification_count"
      expr: COUNT(DISTINCT CASE WHEN validity_end_date < CURRENT_DATE() AND qualification_status = 'PASSED' THEN tool_qualification_id END)
      comment: "Number of qualifications past their validity end date. Compliance risk KPI — expired qualifications must be renewed before production use."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_metrology_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for metrology run quality and measurement system performance. Used by Metrology Engineering and Process Control to ensure measurement accuracy, detect tool-to-tool variation, and maintain process capability."
  source: "`vibe_semiconductors_v1`.`equipment`.`metrology_run`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (CD, overlay, film thickness) for measurement program analysis."
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode of measurement (inline, offline, monitor wafer) for measurement strategy analysis."
    - name: "metrology_run_status"
      expr: metrology_run_status
      comment: "Status of the metrology run (completed, failed, aborted) for data quality filtering."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass/fail result of the metrology run — primary quality indicator for measurement system health."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the metrology tool at time of run — ensures measurement data validity."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot measured (production, monitor, qualification) for measurement program coverage analysis."
    - name: "shift"
      expr: shift
      comment: "Production shift during which the metrology run was performed for shift-level measurement consistency analysis."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_timestamp)
      comment: "Month of the metrology run for trend analysis of measurement volume and quality."
  measures:
    - name: "total_metrology_runs"
      expr: COUNT(1)
      comment: "Total number of metrology runs. Baseline KPI for measurement program activity and inline process control coverage."
    - name: "metrology_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail = 'PASS' THEN metrology_run_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of metrology runs that passed specification. Core process control KPI — declining pass rate signals process drift requiring immediate engineering response."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across metrology runs. Used to monitor process centering and detect systematic bias."
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean value across metrology runs. Used alongside measured value for within-run statistical analysis."
    - name: "avg_std_dev"
      expr: AVG(CAST(std_dev AS DOUBLE))
      comment: "Average standard deviation across metrology runs. Measures process variability — high std_dev signals process instability."
    - name: "avg_sigma_value"
      expr: AVG(CAST(sigma_value AS DOUBLE))
      comment: "Average sigma value across metrology runs. Key process capability indicator — declining sigma signals need for process optimization."
    - name: "avg_oee_percent"
      expr: AVG(CAST(oee_percent AS DOUBLE))
      comment: "Average OEE of the metrology tool during runs. Measures metrology tool utilization and throughput efficiency."
    - name: "spec_exceedance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN measured_value > spec_limit_high OR measured_value < spec_limit_low THEN metrology_run_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of metrology runs where measured value exceeded specification limits. Direct yield risk indicator — high rate triggers process hold and engineering investigation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`equipment_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for process recipe library management: recipe health, compliance, yield performance, and OEE. Used by Process Engineering to govern the recipe library, ensure compliance, and optimize recipe performance across the tool fleet."
  source: "`vibe_semiconductors_v1`.`equipment`.`equipment_process_recipe`"
  dimensions:
    - name: "recipe_category"
      expr: recipe_category
      comment: "Category of the process recipe (etch, deposition, lithography) for recipe portfolio analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the recipe (approved, pending, rejected) for change control compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the recipe for regulatory and quality audit readiness."
    - name: "is_active"
      expr: is_active
      comment: "Whether the recipe is currently active in production — enables active vs. archived recipe analysis."
    - name: "is_deprecated"
      expr: is_deprecated
      comment: "Whether the recipe has been deprecated — tracks recipe lifecycle and obsolescence management."
    - name: "process_node_target"
      expr: process_node_target
      comment: "Target technology node for the recipe — enables node-level recipe coverage analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the recipe became effective for recipe introduction trend analysis."
  measures:
    - name: "total_active_recipes"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN equipment_process_recipe_id END)
      comment: "Total number of active process recipes. Baseline KPI for recipe library size and process complexity management."
    - name: "avg_yield_actual_percent"
      expr: AVG(CAST(yield_actual_percent AS DOUBLE))
      comment: "Average actual yield across all process recipes. Core process performance KPI — directly linked to wafer cost and profitability."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average target yield across process recipes. Used alongside actual yield to calculate yield gap and prioritize improvement programs."
    - name: "yield_gap"
      expr: ROUND(AVG(CAST(yield_target_percent AS DOUBLE)) - AVG(CAST(yield_actual_percent AS DOUBLE)), 2)
      comment: "Gap between target and actual yield averaged across recipes. Positive gap quantifies yield improvement opportunity and drives process engineering investment."
    - name: "avg_oee_actual_percent"
      expr: AVG(CAST(oee_actual_percent AS DOUBLE))
      comment: "Average actual OEE across process recipes. Measures recipe-level equipment utilization efficiency."
    - name: "non_compliant_recipe_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status != 'COMPLIANT' THEN equipment_process_recipe_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recipes with non-compliant status. Compliance risk KPI — non-compliant recipes must be remediated before production use."
    - name: "unapproved_active_recipe_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE AND approval_status != 'APPROVED' THEN equipment_process_recipe_id END)
      comment: "Number of active recipes without approved status. Critical quality risk KPI — unapproved active recipes violate change control and can cause process excursions."
$$;