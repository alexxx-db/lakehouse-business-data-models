-- Metric views for domain: metering | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-02 04:56:40

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_accuracy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter accuracy testing KPIs tracking pass/fail rates, weighted accuracy, and compliance across the meter fleet. Drives decisions on meter replacement programs, AWWA compliance posture, and capital planning for aging infrastructure."
  source: "`vibe_water_utilities_v1`.`metering`.`accuracy_test`"
  dimensions:
    - name: "accuracy_test_type"
      expr: accuracy_test_type
      comment: "Type of accuracy test performed (e.g., bench test, field test) — used to compare accuracy outcomes by test methodology."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Outcome of the accuracy test (Pass/Fail) — primary dimension for compliance and replacement decision dashboards."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the test result — used for AWWA and regulatory reporting segmentation."
    - name: "test_reason"
      expr: test_reason
      comment: "Reason the accuracy test was initiated (e.g., complaint, routine, age-based) — identifies drivers of test volume."
    - name: "test_location"
      expr: test_location
      comment: "Physical location where the test was conducted — supports geographic analysis of meter accuracy issues."
    - name: "replacement_recommended"
      expr: replacement_recommended
      comment: "Boolean flag indicating whether meter replacement was recommended following the test — key input to capital replacement planning."
    - name: "complaint_triggered"
      expr: complaint_triggered
      comment: "Boolean flag indicating whether the test was triggered by a customer complaint — links accuracy testing to customer satisfaction."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of the accuracy test date — enables trend analysis of test volumes and outcomes over time."
    - name: "test_method"
      expr: test_method
      comment: "Method used to conduct the accuracy test — supports quality control analysis by testing methodology."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the meter following the test (e.g., returned to service, replaced, retired) — tracks post-test outcomes."
  measures:
    - name: "total_accuracy_tests"
      expr: COUNT(1)
      comment: "Total number of accuracy tests conducted. Baseline volume metric for test program capacity and scheduling analysis."
    - name: "total_tests_failed"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of accuracy tests that resulted in a failure. Directly informs meter replacement prioritization and regulatory compliance risk."
    - name: "total_tests_passed"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of accuracy tests that passed. Used to track fleet health and validate meter performance against AWWA standards."
    - name: "avg_overall_accuracy_pct"
      expr: AVG(CAST(overall_accuracy_pct AS DOUBLE))
      comment: "Average overall meter accuracy percentage across all tested meters. Core KPI for fleet-wide accuracy health and AWWA compliance benchmarking."
    - name: "avg_weighted_accuracy_pct"
      expr: AVG(CAST(weighted_accuracy_pct AS DOUBLE))
      comment: "Average weighted accuracy percentage, accounting for flow-rate weighting. More representative of real-world revenue accuracy than simple average."
    - name: "avg_meter_age_at_test_years"
      expr: AVG(CAST(meter_age_years AS DOUBLE))
      comment: "Average age of meters at time of testing. Informs age-based replacement policy and helps correlate meter age with accuracy degradation."
    - name: "total_replacement_recommended"
      expr: COUNT(CASE WHEN replacement_recommended = TRUE THEN 1 END)
      comment: "Number of meters flagged for replacement following accuracy testing. Directly drives capital replacement program sizing and budget requests."
    - name: "avg_high_flow_accuracy_pct"
      expr: AVG(CAST(high_flow_accuracy_pct AS DOUBLE))
      comment: "Average accuracy at high flow rates. High-flow accuracy is critical for large commercial and industrial accounts where revenue impact is greatest."
    - name: "avg_low_flow_accuracy_pct"
      expr: AVG(CAST(low_flow_accuracy_pct AS DOUBLE))
      comment: "Average accuracy at low flow rates. Low-flow accuracy is critical for detecting slow leaks and ensuring residential billing accuracy."
    - name: "total_complaint_triggered_tests"
      expr: COUNT(CASE WHEN complaint_triggered = TRUE THEN 1 END)
      comment: "Number of accuracy tests triggered by customer complaints. Tracks the operational burden of complaint-driven testing and customer satisfaction linkage."
    - name: "total_test_volume_gallons"
      expr: SUM(CAST(test_volume_gallons AS DOUBLE))
      comment: "Total reference volume of water used across all accuracy tests. Supports operational cost tracking for the testing program."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_ami_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI (Advanced Metering Infrastructure) endpoint operational health and network performance KPIs. Drives decisions on network reliability, battery replacement programs, firmware upgrade scheduling, and leak detection coverage."
  source: "`vibe_water_utilities_v1`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of AMI endpoint device — used to segment performance metrics by device category."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the endpoint (e.g., RF, cellular) — key dimension for network performance analysis."
    - name: "firmware_version"
      expr: firmware_version
      comment: "Current firmware version installed on the endpoint — used to track firmware upgrade coverage and correlate version with performance issues."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the endpoint is currently active — primary filter for operational fleet analysis."
    - name: "leak_detection_enabled_flag"
      expr: leak_detection_enabled_flag
      comment: "Boolean flag indicating whether leak detection is enabled on the endpoint — tracks leak detection program coverage."
    - name: "tamper_status"
      expr: tamper_status
      comment: "Current tamper status of the endpoint — used for security monitoring and revenue protection analysis."
    - name: "signal_quality_indicator"
      expr: signal_quality_indicator
      comment: "Qualitative signal quality rating — used to segment endpoints by network connectivity health."
    - name: "commissioning_date_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the endpoint was commissioned — enables cohort analysis of endpoint performance by deployment vintage."
    - name: "network_node_code"
      expr: network_node_code
      comment: "Network node the endpoint is associated with — supports geographic and network topology analysis of AMI performance."
  measures:
    - name: "total_ami_endpoints"
      expr: COUNT(1)
      comment: "Total number of AMI endpoints in the fleet. Baseline measure for AMI deployment coverage and program scale."
    - name: "total_active_endpoints"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active AMI endpoints. Core operational health KPI — declining active count signals network or device failures requiring intervention."
    - name: "total_tamper_detected"
      expr: COUNT(CASE WHEN tamper_detected_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of endpoints with a recorded tamper detection event. Revenue protection KPI — tamper events indicate potential theft or unauthorized meter access."
    - name: "total_leak_detection_enabled"
      expr: COUNT(CASE WHEN leak_detection_enabled_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with leak detection enabled. Tracks coverage of the automated leak detection program — a key non-revenue water reduction initiative."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm across all endpoints. Network health KPI — low average signal strength drives infrastructure investment in network repeaters or node repositioning."
    - name: "avg_battery_level_percent"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery level percentage across the AMI fleet. Operational readiness KPI — declining average battery level triggers proactive battery replacement programs."
    - name: "total_low_battery_endpoints"
      expr: COUNT(CASE WHEN battery_level_percent < 20 THEN 1 END)
      comment: "Number of endpoints with battery level below 20%. Actionable maintenance KPI — directly drives field crew dispatch for battery replacement to prevent data gaps."
    - name: "avg_leak_alert_threshold_gpm"
      expr: AVG(CAST(leak_alert_threshold_gpm AS DOUBLE))
      comment: "Average leak alert threshold in gallons per minute configured across endpoints. Informs calibration of leak detection sensitivity across the network."
    - name: "total_reverse_flow_detected"
      expr: COUNT(CASE WHEN reverse_flow_detected_flag = TRUE THEN 1 END)
      comment: "Number of endpoints currently showing reverse flow detection. Reverse flow indicates potential backflow events, cross-connections, or meter installation issues — a water quality and billing integrity risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High usage alert KPIs tracking alert volumes, resolution rates, estimated water loss, and revenue impact. Drives decisions on leak investigation prioritization, customer notification programs, and non-revenue water reduction strategies."
  source: "`vibe_water_utilities_v1`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the high usage alert (e.g., low, medium, high, critical) — primary dimension for prioritizing investigation resources."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (e.g., open, resolved, suppressed) — tracks alert lifecycle and resolution pipeline."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of high usage alert (e.g., continuous flow, spike, threshold breach) — used to categorize alert drivers and tune detection algorithms."
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of the alert resolution (e.g., customer leak, irrigation, meter fault) — critical for understanding root causes of high usage events."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the customer (e.g., email, SMS, phone) — used to evaluate effectiveness of different notification channels."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Boolean flag indicating whether the customer was notified — tracks notification program coverage and compliance."
    - name: "service_order_created_flag"
      expr: service_order_created_flag
      comment: "Boolean flag indicating whether a service order was created in response to the alert — links alert management to field operations."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('MONTH', alert_generated_timestamp)
      comment: "Month the alert was generated — enables trend analysis of high usage event frequency over time."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Boolean flag indicating whether the alert was suppressed — tracks alert suppression rates which may indicate tuning issues or customer opt-outs."
  measures:
    - name: "total_high_usage_alerts"
      expr: COUNT(1)
      comment: "Total number of high usage alerts generated. Baseline volume KPI for alert program scale and trend monitoring."
    - name: "total_open_alerts"
      expr: COUNT(CASE WHEN alert_status = 'Open' THEN 1 END)
      comment: "Number of currently open (unresolved) high usage alerts. Operational backlog KPI — high open alert counts indicate investigation resource constraints or process bottlenecks."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Total estimated water loss in gallons across all high usage alerts. Core non-revenue water KPI — directly quantifies the water loss impact of detected high usage events."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact in USD across all high usage alerts. Financial KPI — quantifies the billing and revenue recovery opportunity from resolving high usage events."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and baseline consumption across alerts. Measures the severity of high usage events — higher average variance indicates more extreme consumption anomalies."
    - name: "avg_actual_consumption_value"
      expr: AVG(CAST(actual_consumption_value AS DOUBLE))
      comment: "Average actual consumption value at time of alert. Contextualizes alert severity and supports threshold calibration decisions."
    - name: "avg_baseline_consumption_value"
      expr: AVG(CAST(baseline_consumption_value AS DOUBLE))
      comment: "Average baseline consumption value used for alert comparison. Supports evaluation of baseline calculation methodology accuracy."
    - name: "total_customer_notified"
      expr: COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END)
      comment: "Number of alerts where the customer was notified. Tracks notification program reach — a key customer service and regulatory compliance metric."
    - name: "total_service_orders_created"
      expr: COUNT(CASE WHEN service_order_created_flag = TRUE THEN 1 END)
      comment: "Number of high usage alerts that resulted in a service order being created. Measures the operational response rate to detected high usage events."
    - name: "total_suppressed_alerts"
      expr: COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END)
      comment: "Number of alerts that were suppressed. High suppression rates may indicate over-sensitive alert thresholds or systematic customer opt-outs requiring program recalibration."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_installation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter installation lifecycle KPIs tracking active installations, connection characteristics, and service line attributes. Drives decisions on infrastructure investment, service line replacement programs, and AMI deployment coverage."
  source: "`vibe_water_utilities_v1`.`metering`.`installation`"
  dimensions:
    - name: "installation_status"
      expr: installation_status
      comment: "Current status of the meter installation (e.g., active, removed, inactive) — primary dimension for fleet status analysis."
    - name: "installation_type"
      expr: installation_type
      comment: "Type of meter installation (e.g., residential, commercial, industrial, fire) — key segmentation dimension for fleet analysis and capacity planning."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the service pipe at the installation point — critical for lead service line identification and infrastructure replacement prioritization."
    - name: "service_line_material"
      expr: service_line_material
      comment: "Material of the service line — used for lead service line inventory compliance reporting and replacement program tracking."
    - name: "meter_position"
      expr: meter_position
      comment: "Physical position of the meter (e.g., pit, wall, vault) — used for field operations planning and access difficulty analysis."
    - name: "flow_direction"
      expr: flow_direction
      comment: "Direction of flow through the meter — used to identify reverse-flow or bi-directional installations."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the installation is currently active — primary filter for operational fleet analysis."
    - name: "install_date_month"
      expr: DATE_TRUNC('MONTH', install_date)
      comment: "Month of meter installation — enables cohort analysis of installation activity and fleet vintage distribution."
    - name: "removal_reason"
      expr: removal_reason
      comment: "Reason for meter removal — used to analyze drivers of meter turnover and inform replacement program planning."
    - name: "is_accessible"
      expr: is_accessible
      comment: "Boolean flag indicating whether the meter is accessible for reading — tracks access barriers that impact read completion rates."
  measures:
    - name: "total_installations"
      expr: COUNT(1)
      comment: "Total number of meter installations on record. Baseline fleet size metric for capacity planning and program scale assessment."
    - name: "total_active_installations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active meter installations. Core fleet health KPI — represents the active revenue-generating meter base."
    - name: "total_inaccessible_installations"
      expr: COUNT(CASE WHEN is_accessible = FALSE THEN 1 END)
      comment: "Number of meter installations flagged as inaccessible. Operational efficiency KPI — inaccessible meters drive estimated reads, billing disputes, and field crew inefficiency."
    - name: "avg_connection_size_inches"
      expr: AVG(CAST(connection_size_inches AS DOUBLE))
      comment: "Average connection size in inches across the meter fleet. Infrastructure planning metric — connection size distribution informs capacity and pressure management decisions."
    - name: "avg_meter_pit_depth_inches"
      expr: AVG(CAST(meter_pit_depth_inches AS DOUBLE))
      comment: "Average meter pit depth in inches. Field operations metric — pit depth affects maintenance access time and cost."
    - name: "avg_reading_at_install"
      expr: AVG(CAST(reading_at_install AS DOUBLE))
      comment: "Average register reading at time of installation. Baseline metric for tracking cumulative volume at installation events — supports meter exchange program analysis."
    - name: "avg_reading_at_removal"
      expr: AVG(CAST(reading_at_removal AS DOUBLE))
      comment: "Average register reading at time of meter removal. Used to calculate total volume throughput per meter over its installed life — informs useful life and replacement cycle analysis."
    - name: "total_locked_installations"
      expr: COUNT(CASE WHEN is_locked = TRUE THEN 1 END)
      comment: "Number of meter installations currently in a locked state. Revenue protection KPI — locked meters typically indicate non-payment shutoffs or compliance actions."
    - name: "avg_service_line_diameter_inches"
      expr: AVG(CAST(service_line_diameter_inches AS DOUBLE))
      comment: "Average service line diameter in inches. Infrastructure planning metric — service line diameter distribution informs pressure management and flow capacity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI interval consumption KPIs tracking water usage volumes, flow rates, data quality, and anomaly detection at sub-hourly granularity. Drives decisions on non-revenue water programs, leak detection, demand forecasting, and AMI data quality management."
  source: "`vibe_water_utilities_v1`.`metering`.`interval_consumption`"
  dimensions:
    - name: "data_quality_indicator"
      expr: data_quality_indicator
      comment: "Data quality flag for the interval reading — used to segment consumption analysis by data reliability and track AMI data quality trends."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the interval consumption record — primary dimension for data quality monitoring and exception management."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Boolean flag indicating a potential leak was detected in this interval — core dimension for non-revenue water analysis."
    - name: "high_usage_flag"
      expr: high_usage_flag
      comment: "Boolean flag indicating high usage was detected in this interval — used to identify and investigate consumption anomalies."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Boolean flag indicating reverse flow was detected — used for backflow event analysis and meter installation quality control."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Boolean flag indicating zero consumption was recorded — used to identify potential meter failures, vacant properties, or data gaps."
    - name: "gap_flag"
      expr: gap_flag
      comment: "Boolean flag indicating a data gap in the interval sequence — tracks AMI network reliability and data completeness."
    - name: "interval_start_hour"
      expr: DATE_TRUNC('HOUR', interval_start_timestamp)
      comment: "Hour of the interval start timestamp — enables hourly demand pattern analysis for operational and planning purposes."
    - name: "interval_start_month"
      expr: DATE_TRUNC('MONTH', interval_start_timestamp)
      comment: "Month of the interval start timestamp — enables monthly consumption trend analysis and seasonal demand pattern identification."
    - name: "estimated_method"
      expr: estimated_method
      comment: "Method used to estimate consumption when direct measurement was unavailable — tracks estimation methodology distribution and data quality."
  measures:
    - name: "total_interval_records"
      expr: COUNT(1)
      comment: "Total number of interval consumption records. Baseline volume metric for AMI data completeness and network coverage assessment."
    - name: "total_consumption_volume_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total water consumption volume in gallons across all intervals. Core demand metric — drives production planning, supply forecasting, and revenue projection."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across all intervals. Demand characterization metric — informs pressure zone management and distribution system capacity planning."
    - name: "total_leak_detection_intervals"
      expr: COUNT(CASE WHEN leak_detection_flag = TRUE THEN 1 END)
      comment: "Number of intervals with a leak detection flag. Non-revenue water KPI — volume of leak-flagged intervals drives investigation prioritization and water loss quantification."
    - name: "total_high_usage_intervals"
      expr: COUNT(CASE WHEN high_usage_flag = TRUE THEN 1 END)
      comment: "Number of intervals flagged as high usage. Demand anomaly KPI — used to identify unusual consumption patterns requiring customer notification or investigation."
    - name: "total_gap_intervals"
      expr: COUNT(CASE WHEN gap_flag = TRUE THEN 1 END)
      comment: "Number of intervals with data gaps. AMI network reliability KPI — high gap counts indicate communication failures that compromise billing accuracy and leak detection coverage."
    - name: "total_reverse_flow_intervals"
      expr: COUNT(CASE WHEN reverse_flow_flag = TRUE THEN 1 END)
      comment: "Number of intervals with reverse flow detected. Water quality and system integrity KPI — reverse flow events may indicate backflow contamination risks."
    - name: "total_zero_consumption_intervals"
      expr: COUNT(CASE WHEN zero_consumption_flag = TRUE THEN 1 END)
      comment: "Number of intervals recording zero consumption. Operational KPI — distinguishes vacant properties from potential meter or communication failures."
    - name: "avg_consumption_volume_gallons"
      expr: AVG(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Average consumption volume per interval in gallons. Demand baseline metric — used to establish normal consumption profiles for anomaly detection threshold calibration."
    - name: "total_pulse_count"
      expr: SUM(CAST(raw_pulse_count AS DOUBLE))
      comment: "Total raw pulse count across all intervals. Data integrity metric — used to cross-validate consumption volume calculations and detect register multiplier configuration errors."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_read`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter read quality and billing readiness KPIs tracking read completion, estimation rates, exception volumes, and consumption values. Drives decisions on read route optimization, AMI expansion, and billing accuracy improvement programs."
  source: "`vibe_water_utilities_v1`.`metering`.`read`"
  dimensions:
    - name: "read_type"
      expr: read_type
      comment: "Type of meter read (e.g., regular, final, initial, special) — used to segment read volumes by billing cycle purpose."
    - name: "read_status"
      expr: read_status
      comment: "Status of the meter read (e.g., valid, estimated, exception) — primary dimension for read quality analysis."
    - name: "method"
      expr: method
      comment: "Read collection method (e.g., AMI, manual, drive-by) — used to compare read quality and cost across collection technologies."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the read record — tracks data quality pipeline outcomes and exception rates."
    - name: "estimated_flag"
      expr: estimated_flag
      comment: "Boolean flag indicating the read was estimated rather than actual — core data quality dimension for billing accuracy analysis."
    - name: "billing_flag"
      expr: billing_flag
      comment: "Boolean flag indicating the read was used for billing — distinguishes billable reads from non-billable test or exception reads."
    - name: "leak_flag"
      expr: leak_flag
      comment: "Boolean flag indicating a potential leak was detected at time of read — links field read observations to non-revenue water programs."
    - name: "tamper_flag"
      expr: tamper_flag
      comment: "Boolean flag indicating a tamper event was detected at time of read — revenue protection dimension for security and audit analysis."
    - name: "read_date_month"
      expr: DATE_TRUNC('MONTH', read_date)
      comment: "Month of the meter read date — enables monthly read volume and quality trend analysis aligned to billing cycles."
    - name: "high_read_flag"
      expr: high_read_flag
      comment: "Boolean flag indicating an unusually high read was recorded — used to identify potential billing errors or genuine high consumption events."
  measures:
    - name: "total_reads"
      expr: COUNT(1)
      comment: "Total number of meter reads recorded. Baseline volume metric for read program completeness and billing cycle coverage."
    - name: "total_estimated_reads"
      expr: COUNT(CASE WHEN estimated_flag = TRUE THEN 1 END)
      comment: "Number of reads that were estimated rather than actual. Billing accuracy KPI — high estimation rates indicate AMI communication failures or access issues that compromise billing integrity."
    - name: "total_billing_reads"
      expr: COUNT(CASE WHEN billing_flag = TRUE THEN 1 END)
      comment: "Number of reads used for billing. Revenue completeness KPI — ensures all active accounts are receiving billable reads each cycle."
    - name: "total_leak_flagged_reads"
      expr: COUNT(CASE WHEN leak_flag = TRUE THEN 1 END)
      comment: "Number of reads with a leak flag. Non-revenue water KPI — leak-flagged reads drive field investigation and customer notification workflows."
    - name: "total_tamper_flagged_reads"
      expr: COUNT(CASE WHEN tamper_flag = TRUE THEN 1 END)
      comment: "Number of reads with a tamper flag. Revenue protection KPI — tamper events indicate potential theft or unauthorized meter access requiring investigation."
    - name: "total_consumption_value"
      expr: SUM(CAST(consumption_value AS DOUBLE))
      comment: "Total consumption value across all reads. Core revenue driver metric — total billed consumption is the primary input to revenue calculation."
    - name: "avg_consumption_value"
      expr: AVG(CAST(consumption_value AS DOUBLE))
      comment: "Average consumption value per read. Demand baseline metric — used to identify anomalous reads and calibrate high/low read exception thresholds."
    - name: "total_high_reads"
      expr: COUNT(CASE WHEN high_read_flag = TRUE THEN 1 END)
      comment: "Number of reads flagged as unusually high. Billing quality KPI — high read flags require review before billing to prevent customer disputes and revenue adjustments."
    - name: "total_reverse_flow_reads"
      expr: COUNT(CASE WHEN reverse_flow_flag = TRUE THEN 1 END)
      comment: "Number of reads with reverse flow detected. System integrity KPI — reverse flow at read time indicates potential backflow or meter installation issues."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute at time of read. Demand characterization metric — supports pressure zone management and distribution system analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_read_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Read route operational efficiency KPIs tracking route coverage, scheduling, and field crew productivity. Drives decisions on route optimization, AMI conversion prioritization, and field operations resource allocation."
  source: "`vibe_water_utilities_v1`.`metering`.`read_route`"
  dimensions:
    - name: "read_route_status"
      expr: read_route_status
      comment: "Current status of the read route (e.g., active, inactive, suspended) — primary dimension for operational route fleet analysis."
    - name: "read_route_type"
      expr: read_route_type
      comment: "Type of read route (e.g., residential, commercial, industrial) — used to segment route performance by customer class."
    - name: "read_method"
      expr: read_method
      comment: "Method used to collect reads on this route (e.g., manual walk, drive-by, AMI) — key dimension for technology transition analysis."
    - name: "read_frequency"
      expr: read_frequency
      comment: "Frequency of reads on this route (e.g., monthly, bi-monthly) — used to align route analysis with billing cycle management."
    - name: "is_ami_route"
      expr: is_ami_route
      comment: "Boolean flag indicating whether this is an AMI-enabled route — tracks AMI conversion progress across the read route network."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the route is currently active — primary filter for operational route analysis."
    - name: "sequence_optimized_flag"
      expr: sequence_optimized_flag
      comment: "Boolean flag indicating whether the route sequence has been optimized — tracks route optimization program coverage and efficiency gains."
    - name: "last_read_date_month"
      expr: DATE_TRUNC('MONTH', last_read_date)
      comment: "Month of the last read date for the route — used to identify routes that are overdue for reading."
    - name: "read_cycle"
      expr: read_cycle
      comment: "Billing cycle code associated with the route — used to align route performance analysis with billing cycle management."
  measures:
    - name: "total_read_routes"
      expr: COUNT(1)
      comment: "Total number of read routes in the system. Baseline fleet size metric for field operations planning and resource allocation."
    - name: "total_active_routes"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active read routes. Operational coverage KPI — active route count determines field crew scheduling requirements."
    - name: "total_ami_routes"
      expr: COUNT(CASE WHEN is_ami_route = TRUE THEN 1 END)
      comment: "Number of routes that are AMI-enabled. AMI conversion progress KPI — tracks the transition from manual to automated meter reading, a key operational efficiency initiative."
    - name: "total_optimized_routes"
      expr: COUNT(CASE WHEN sequence_optimized_flag = TRUE THEN 1 END)
      comment: "Number of routes with optimized sequences. Field efficiency KPI — optimized routes reduce drive time and labor cost per read cycle."
    - name: "avg_route_distance_miles"
      expr: AVG(CAST(route_distance_miles AS DOUBLE))
      comment: "Average route distance in miles. Field operations efficiency metric — route distance drives fuel cost, time-per-route, and crew scheduling requirements."
    - name: "total_route_distance_miles"
      expr: SUM(CAST(route_distance_miles AS DOUBLE))
      comment: "Total distance across all read routes in miles. Fleet-level operational footprint metric — total route distance informs vehicle fleet sizing and fuel budget planning."
    - name: "avg_estimated_read_time_hours"
      expr: AVG(CAST(estimated_read_time_hours AS DOUBLE))
      comment: "Average estimated read time in hours per route. Labor productivity metric — used to benchmark field crew efficiency and identify routes requiring re-sequencing or AMI conversion."
    - name: "total_estimated_read_hours"
      expr: SUM(CAST(estimated_read_hours AS DOUBLE))
      comment: "Total estimated read hours across all routes. Workforce planning metric — total estimated hours drives field crew headcount requirements and overtime cost projections."
$$;