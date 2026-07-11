-- Metric views for domain: metering | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_consumption_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consumption analytics metric view providing KPIs on water usage volumes, billing period performance, leak detection, and data quality. Used by operations, finance, and executive leadership to monitor consumption trends, NRW contributions, and billing readiness."
  source: "`vibe_water_utilities_v1`.`metering`.`consumption_profile`"
  dimensions:
    - name: "customer_class"
      expr: customer_class
      comment: "Customer classification (residential, commercial, industrial) for segmenting consumption patterns and rate analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of water service (potable, irrigation, fire protection) enabling service-level consumption breakdowns."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the consumption record (validated, estimated, pending) for data quality filtering."
    - name: "read_method"
      expr: read_method
      comment: "Method used to obtain the meter read (AMI, manual, estimated) for operational performance analysis."
    - name: "consumption_tier"
      expr: consumption_tier
      comment: "Tiered consumption bracket for rate structure analysis and revenue forecasting."
    - name: "billing_period_end_date"
      expr: DATE_TRUNC('month', billing_period_end_date)
      comment: "Billing period end month for time-series trending of consumption volumes."
    - name: "billing_period_start_date"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period start month for aligning consumption data to billing cycles."
    - name: "leak_detected_flag"
      expr: leak_detected_flag
      comment: "Indicates whether a leak was detected during this consumption period, enabling leak prevalence analysis."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Flags accounts with zero consumption for investigation of inactive services or meter issues."
    - name: "high_usage_alert_flag"
      expr: high_usage_alert_flag
      comment: "Flags consumption records that triggered a high usage alert for operational follow-up."
    - name: "meter_technology"
      expr: meter_technology
      comment: "Meter technology type (AMI, AMR, manual) for infrastructure performance segmentation."
  measures:
    - name: "total_consumption_gallons"
      expr: SUM(CAST(total_consumption_gallons AS DOUBLE))
      comment: "Total billed water consumption in gallons across all accounts and periods. Primary volume KPI for production planning and revenue forecasting."
    - name: "total_consumption_ccf"
      expr: SUM(CAST(total_consumption_ccf AS DOUBLE))
      comment: "Total billed water consumption in CCF (hundred cubic feet). Used for rate schedule billing calculations and regulatory reporting."
    - name: "avg_daily_usage_gpd"
      expr: AVG(CAST(average_daily_usage_gpd AS DOUBLE))
      comment: "Average daily water usage in gallons per day across consumption profiles. Key demand planning metric for capacity management."
    - name: "total_nrw_contribution_gallons"
      expr: SUM(CAST(nrw_contribution_gallons AS DOUBLE))
      comment: "Total non-revenue water contribution in gallons. Critical KPI for water loss management programs and regulatory compliance."
    - name: "avg_consumption_variance_pct"
      expr: AVG(CAST(consumption_variance_percent AS DOUBLE))
      comment: "Average percentage variance between current and expected consumption. Elevated values indicate meter issues, leaks, or billing anomalies requiring investigation."
    - name: "total_peak_day_consumption_gallons"
      expr: SUM(CAST(peak_day_consumption_gallons AS DOUBLE))
      comment: "Sum of peak day consumption across all accounts. Used for infrastructure capacity planning and demand management."
    - name: "avg_weather_normalized_consumption_gallons"
      expr: AVG(CAST(weather_normalized_consumption_gallons AS DOUBLE))
      comment: "Average weather-normalized consumption in gallons. Removes seasonal weather effects to reveal true underlying demand trends."
    - name: "total_prior_period_consumption_gallons"
      expr: SUM(CAST(prior_period_consumption_gallons AS DOUBLE))
      comment: "Total prior period consumption in gallons for period-over-period comparison and trend analysis."
    - name: "total_prior_year_consumption_gallons"
      expr: SUM(CAST(prior_year_consumption_gallons AS DOUBLE))
      comment: "Total prior year consumption in gallons for year-over-year benchmarking and demand forecasting."
    - name: "avg_minimum_night_flow_gpm"
      expr: AVG(CAST(minimum_night_flow_gpm AS DOUBLE))
      comment: "Average minimum night flow in gallons per minute. Elevated night flow is a primary indicator of customer-side leakage."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across consumption records. Low scores indicate AMI communication issues or estimation reliance affecting billing accuracy."
    - name: "count_leak_detected_accounts"
      expr: COUNT(CASE WHEN leak_detected_flag = TRUE THEN 1 END)
      comment: "Number of accounts with active leak detection flags. Drives customer notification and field investigation prioritization."
    - name: "count_zero_consumption_accounts"
      expr: COUNT(CASE WHEN zero_consumption_flag = TRUE THEN 1 END)
      comment: "Number of accounts with zero consumption in the period. Indicates potential inactive services, meter failures, or billing errors."
    - name: "count_high_usage_alert_accounts"
      expr: COUNT(CASE WHEN high_usage_alert_flag = TRUE THEN 1 END)
      comment: "Number of accounts that triggered high usage alerts. Used to size field investigation workload and customer outreach programs."
    - name: "total_adjustment_amount_gallons"
      expr: SUM(CAST(adjustment_amount_gallons AS DOUBLE))
      comment: "Total volume of billing adjustments in gallons. Large adjustment volumes signal systematic meter or estimation issues affecting revenue integrity."
    - name: "avg_seasonal_factor"
      expr: AVG(CAST(seasonal_factor AS DOUBLE))
      comment: "Average seasonal adjustment factor applied to consumption. Used to validate seasonal normalization models and rate design assumptions."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-resolution AMI interval consumption analytics providing sub-daily demand profiling, leak detection signal analysis, and data transmission quality KPIs. Used by operations and engineering for demand management, pressure zone optimization, and AMI network performance."
  source: "`vibe_water_utilities_v1`.`metering`.`interval_consumption`"
  dimensions:
    - name: "interval_start_hour"
      expr: DATE_TRUNC('hour', interval_start_timestamp)
      comment: "Hour bucket of interval start for intra-day demand profiling and peak demand identification."
    - name: "interval_start_date"
      expr: DATE_TRUNC('day', interval_start_timestamp)
      comment: "Day bucket for daily consumption aggregation and trend analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the interval read (valid, estimated, failed) for data quality segmentation."
    - name: "data_quality_indicator"
      expr: data_quality_indicator
      comment: "Data quality flag from AMI transmission for identifying unreliable interval reads."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Indicates intervals where leak detection algorithm flagged anomalous flow patterns."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Flags intervals with reverse flow detected, indicating potential backflow or meter tampering."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Flags intervals with zero consumption for gap analysis and meter communication failure detection."
    - name: "gap_flag"
      expr: gap_flag
      comment: "Indicates missing interval data gaps in the AMI transmission stream, critical for billing completeness."
    - name: "high_usage_flag"
      expr: high_usage_flag
      comment: "Flags intervals exceeding high usage thresholds for real-time demand monitoring."
    - name: "alarm_code"
      expr: alarm_code
      comment: "AMI device alarm code for categorizing device-level events and maintenance triggers."
  measures:
    - name: "total_consumption_volume_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total water consumption volume in gallons from interval reads. Foundation metric for demand analysis and NRW calculation at sub-daily resolution."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across intervals. Used for hydraulic modeling validation and pressure zone performance assessment."
    - name: "max_flow_rate_gpm"
      expr: MAX(flow_rate_gpm)
      comment: "Maximum instantaneous flow rate in gallons per minute. Critical for peak demand planning and infrastructure capacity sizing."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average pressure in PSI across interval reads. Used to monitor pressure zone compliance and identify pressure anomalies."
    - name: "avg_battery_voltage"
      expr: AVG(CAST(battery_voltage AS DOUBLE))
      comment: "Average AMI endpoint battery voltage. Declining voltage trends predict device failures before they cause data gaps."
    - name: "count_leak_detection_intervals"
      expr: COUNT(CASE WHEN leak_detection_flag = TRUE THEN 1 END)
      comment: "Number of intervals with active leak detection flags. Sustained leak flags across consecutive intervals confirm leak events requiring field response."
    - name: "count_gap_intervals"
      expr: COUNT(CASE WHEN gap_flag = TRUE THEN 1 END)
      comment: "Number of intervals with data gaps. High gap counts indicate AMI network communication failures affecting billing completeness."
    - name: "count_reverse_flow_intervals"
      expr: COUNT(CASE WHEN reverse_flow_flag = TRUE THEN 1 END)
      comment: "Number of intervals with reverse flow detected. Used for backflow prevention compliance monitoring and tamper investigation."
    - name: "total_raw_pulse_count"
      expr: SUM(CAST(raw_pulse_count AS DOUBLE))
      comment: "Total raw pulse count from AMI endpoints. Used to cross-validate consumption volume calculations and detect register drift."
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average temperature reading from AMI endpoints in Fahrenheit. Used for freeze event correlation and seasonal demand normalization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_leak_detection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leak detection event analytics providing KPIs on water loss volumes, detection performance, resolution outcomes, and customer impact. Used by operations management and executives to track NRW reduction program effectiveness and customer service quality."
  source: "`vibe_water_utilities_v1`.`metering`.`leak_detection_event`"
  dimensions:
    - name: "leak_status"
      expr: leak_status
      comment: "Current status of the leak event (detected, investigating, resolved, closed) for workload management."
    - name: "leak_type"
      expr: leak_type
      comment: "Classification of leak type (customer-side, service line, meter) for targeted remediation programs."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the leak (AMI algorithm, minimum night flow, field inspection) for detection program effectiveness analysis."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of leak resolution (repaired, customer notified, no action) for program effectiveness measurement."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity classification of the leak alert for prioritization and escalation management."
    - name: "detection_date"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of leak detection for trend analysis and seasonal pattern identification."
    - name: "billing_adjustment_eligible_flag"
      expr: billing_adjustment_eligible_flag
      comment: "Indicates whether the leak qualifies for a billing adjustment, driving revenue impact assessment."
    - name: "continuous_flow_flag"
      expr: continuous_flow_flag
      comment: "Flags leaks with continuous flow patterns indicating high-volume losses requiring urgent response."
    - name: "minimum_night_flow_anomaly_flag"
      expr: minimum_night_flow_anomaly_flag
      comment: "Indicates leaks detected via minimum night flow anomaly method for algorithm performance tracking."
  measures:
    - name: "total_estimated_leak_volume_gpd"
      expr: SUM(CAST(estimated_leak_volume_gallons_per_day AS DOUBLE))
      comment: "Total estimated daily water loss volume in gallons per day across all active leak events. Primary NRW volume KPI for water loss management programs."
    - name: "total_estimated_total_loss_gallons"
      expr: SUM(CAST(estimated_total_loss_gallons AS DOUBLE))
      comment: "Total cumulative water loss in gallons across all leak events. Used to quantify NRW program impact and prioritize infrastructure investment."
    - name: "avg_leak_duration_hours"
      expr: AVG(CAST(leak_duration_hours AS DOUBLE))
      comment: "Average duration of leak events in hours. Shorter durations indicate faster detection and response, a key operational efficiency KPI."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average detection algorithm confidence score. Low confidence scores indicate algorithm tuning needs and potential false positive rates."
    - name: "count_active_leak_events"
      expr: COUNT(CASE WHEN leak_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Number of currently active (unresolved) leak events. Drives field crew dispatch planning and customer notification workload."
    - name: "count_billing_adjustment_eligible_events"
      expr: COUNT(CASE WHEN billing_adjustment_eligible_flag = TRUE THEN 1 END)
      comment: "Number of leak events eligible for billing adjustments. Used to forecast revenue adjustment exposure and customer service workload."
    - name: "avg_flow_threshold_value"
      expr: AVG(CAST(flow_threshold_value AS DOUBLE))
      comment: "Average flow threshold value used for leak detection triggering. Used to calibrate detection sensitivity across different meter sizes and customer classes."
    - name: "count_customer_notified_events"
      expr: COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END)
      comment: "Number of leak events where customers were notified. Measures customer communication program reach and regulatory compliance with notification requirements."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High usage alert analytics providing KPIs on alert volumes, revenue impact, investigation performance, and resolution effectiveness. Used by customer service management and operations to prioritize field investigations and measure alert program ROI."
  source: "`vibe_water_utilities_v1`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the high usage alert (open, investigating, resolved, closed) for workload management."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of high usage alert (leak, irrigation, pool fill, unknown) for root cause categorization."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert for prioritization and escalation management."
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of alert resolution (leak confirmed, customer behavior, meter issue) for program effectiveness analysis."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the customer (email, SMS, phone, portal) for channel effectiveness analysis."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('month', alert_generated_timestamp)
      comment: "Month the alert was generated for trend analysis and seasonal pattern identification."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Indicates whether the customer was notified, for measuring notification program coverage."
    - name: "service_order_created_flag"
      expr: service_order_created_flag
      comment: "Indicates whether a service order was created in response to the alert, measuring field response rates."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Indicates suppressed alerts for measuring false positive rates and alert rule tuning needs."
    - name: "data_source"
      expr: data_source
      comment: "Source of the alert data (AMI, manual, SCADA) for data quality and coverage analysis."
  measures:
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact from high usage events in dollars. Primary financial KPI for alert program ROI justification."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Total estimated water loss in gallons from high usage events. Used to quantify NRW contribution from customer-side leaks and abnormal usage."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and baseline consumption. Higher averages indicate more severe usage anomalies in the alert population."
    - name: "avg_actual_consumption_value"
      expr: AVG(CAST(actual_consumption_value AS DOUBLE))
      comment: "Average actual consumption value at time of alert. Used to calibrate alert thresholds and understand typical alert trigger volumes."
    - name: "avg_baseline_consumption_value"
      expr: AVG(CAST(baseline_consumption_value AS DOUBLE))
      comment: "Average baseline consumption value used for alert comparison. Used to validate baseline calculation methodology."
    - name: "count_open_alerts"
      expr: COUNT(CASE WHEN alert_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Number of currently open high usage alerts. Drives customer service staffing and field investigation resource planning."
    - name: "count_customer_notified_alerts"
      expr: COUNT(CASE WHEN customer_notified_flag = TRUE THEN 1 END)
      comment: "Number of alerts where customers were successfully notified. Measures customer engagement program reach."
    - name: "count_service_orders_created"
      expr: COUNT(CASE WHEN service_order_created_flag = TRUE THEN 1 END)
      comment: "Number of alerts that resulted in service order creation. Measures field response rate and alert-to-action conversion."
    - name: "count_suppressed_alerts"
      expr: COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END)
      comment: "Number of suppressed alerts. High suppression rates indicate alert rule over-sensitivity requiring threshold recalibration."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value used to trigger high usage alerts. Used for alert rule performance benchmarking and sensitivity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_read_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter read exception analytics providing KPIs on read quality, exception resolution rates, billing hold exposure, and field visit requirements. Used by metering operations management to monitor AMI network health and billing data completeness."
  source: "`vibe_water_utilities_v1`.`metering`.`read_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Type of read exception (no read, high read, low read, reverse flow) for root cause categorization."
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, resolved, escalated) for workload management."
    - name: "exception_code"
      expr: exception_code
      comment: "Specific exception code for detailed operational diagnostics and pattern analysis."
    - name: "exception_source"
      expr: exception_source
      comment: "Source system that generated the exception (AMI, manual, validation engine) for data quality attribution."
    - name: "estimation_method"
      expr: estimation_method
      comment: "Method used to estimate the read when actual read unavailable, for billing accuracy assessment."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the exception for field dispatch and resolution sequencing."
    - name: "exception_date"
      expr: DATE_TRUNC('month', exception_date)
      comment: "Month of exception occurrence for trend analysis and seasonal pattern identification."
    - name: "billing_hold_flag"
      expr: billing_hold_flag
      comment: "Indicates exceptions that have placed accounts on billing hold, directly impacting revenue collection."
    - name: "field_visit_required"
      expr: field_visit_required
      comment: "Flags exceptions requiring a field visit for resource planning and cost estimation."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Indicates exceptions associated with leak detection signals for cross-program correlation."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Flags exceptions with reverse flow for backflow compliance monitoring."
    - name: "register_overflow_flag"
      expr: register_overflow_flag
      comment: "Flags register overflow events indicating meter register capacity exceeded, requiring immediate replacement."
  measures:
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average consumption variance amount on exception records. Large variances indicate systematic meter or estimation issues affecting billing accuracy."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance on exception records. Used to benchmark exception severity and prioritize resolution efforts."
    - name: "avg_current_read_value"
      expr: AVG(CAST(current_read_value AS DOUBLE))
      comment: "Average current read value on exception records. Used to understand typical consumption levels at time of exception."
    - name: "avg_estimated_read_value"
      expr: AVG(CAST(estimated_read_value AS DOUBLE))
      comment: "Average estimated read value applied to exception records. Used to assess estimation accuracy and billing exposure."
    - name: "count_billing_hold_exceptions"
      expr: COUNT(CASE WHEN billing_hold_flag = TRUE THEN 1 END)
      comment: "Number of exceptions with active billing holds. Directly measures revenue at risk from unresolved read exceptions."
    - name: "count_field_visit_required"
      expr: COUNT(CASE WHEN field_visit_required = TRUE THEN 1 END)
      comment: "Number of exceptions requiring field visits. Used to plan field crew workload and estimate operational costs."
    - name: "count_open_exceptions"
      expr: COUNT(CASE WHEN exception_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Number of currently open read exceptions. Key operational KPI for metering team workload and billing cycle readiness."
    - name: "count_register_overflow_events"
      expr: COUNT(CASE WHEN register_overflow_flag = TRUE THEN 1 END)
      comment: "Number of register overflow events. Drives urgent meter replacement prioritization to prevent consumption under-recording."
    - name: "avg_expected_consumption"
      expr: AVG(CAST(expected_consumption AS DOUBLE))
      comment: "Average expected consumption on exception records. Used to validate estimation models and identify systematic over/under-estimation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_accuracy_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter accuracy test analytics providing KPIs on testing program coverage and resource utilization. Used by metering management to ensure regulatory compliance with meter testing requirements and manage testing program costs."
  source: "`vibe_water_utilities_v1`.`metering`.`accuracy_test`"
  dimensions:
    - name: "accuracy_test_id_dim"
      expr: accuracy_test_id
      comment: "Accuracy test identifier for individual test record analysis and audit trail."
    - name: "cost_center_id_dim"
      expr: cost_center_id
      comment: "Cost center to which the accuracy test cost is allocated, for financial tracking of testing program expenditures."
    - name: "employee_id_dim"
      expr: employee_id
      comment: "Employee who performed the accuracy test, for technician productivity and certification compliance tracking."
  measures:
    - name: "total_accuracy_tests_performed"
      expr: COUNT(1)
      comment: "Total number of meter accuracy tests performed. Used to track testing program throughput against regulatory testing frequency requirements."
    - name: "distinct_meters_tested"
      expr: COUNT(DISTINCT metering_meter_id)
      comment: "Number of distinct meters that have undergone accuracy testing. Used to measure testing program coverage against the total meter population."
    - name: "distinct_technicians_performing_tests"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct technicians performing accuracy tests. Used for workforce planning and ensuring adequate certified technician capacity."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_dma_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District Metered Area (DMA) zone performance analytics providing KPIs on NRW rates, pressure performance, and infrastructure condition. Used by operations and engineering leadership to prioritize water loss reduction investments and monitor DMA program effectiveness."
  source: "`vibe_water_utilities_v1`.`metering`.`metering_dma_zone`"
  dimensions:
    - name: "dma_type"
      expr: dma_type
      comment: "Type of DMA zone (primary, sub-zone, pressure zone) for hierarchical performance analysis."
    - name: "metering_dma_zone_status"
      expr: metering_dma_zone_status
      comment: "Operational status of the DMA zone (active, decommissioned, planned) for portfolio management."
    - name: "predominant_pipe_material"
      expr: predominant_pipe_material
      comment: "Predominant pipe material in the DMA zone for infrastructure risk and NRW correlation analysis."
    - name: "scada_monitoring_enabled"
      expr: scada_monitoring_enabled
      comment: "Indicates whether SCADA monitoring is active in the zone for operational visibility assessment."
    - name: "established_date"
      expr: DATE_TRUNC('year', established_date)
      comment: "Year the DMA zone was established for infrastructure age analysis."
  measures:
    - name: "avg_actual_nrw_percentage"
      expr: AVG(CAST(actual_nrw_percentage AS DOUBLE))
      comment: "Average actual non-revenue water percentage across DMA zones. Primary KPI for water loss management program performance and regulatory reporting."
    - name: "avg_target_nrw_percentage"
      expr: AVG(CAST(target_nrw_percentage AS DOUBLE))
      comment: "Average target NRW percentage across DMA zones. Used to benchmark actual performance against program targets."
    - name: "avg_infrastructure_leakage_index"
      expr: AVG(CAST(infrastructure_leakage_index AS DOUBLE))
      comment: "Average Infrastructure Leakage Index (ILI) across DMA zones. ILI is the international standard KPI for comparing water loss performance across utilities."
    - name: "avg_minimum_night_flow_gpm"
      expr: AVG(CAST(minimum_night_flow_gpm AS DOUBLE))
      comment: "Average minimum night flow in gallons per minute across DMA zones. Elevated MNF is the primary operational indicator of background leakage levels."
    - name: "avg_average_pressure_psi"
      expr: AVG(CAST(average_pressure_psi AS DOUBLE))
      comment: "Average operating pressure in PSI across DMA zones. Pressure management is the most cost-effective lever for reducing leakage volumes."
    - name: "total_pipe_length_miles"
      expr: SUM(CAST(total_pipe_length_miles AS DOUBLE))
      comment: "Total pipe length in miles across DMA zones. Used to normalize NRW metrics per mile of main for infrastructure benchmarking."
    - name: "avg_ufw_gallons_per_connection_per_day"
      expr: AVG(CAST(ufw_gallons_per_connection_per_day AS DOUBLE))
      comment: "Average unaccounted-for water in gallons per connection per day. Standard AWWA metric for comparing water loss performance across utilities."
    - name: "count_zones_exceeding_nrw_target"
      expr: COUNT(CASE WHEN actual_nrw_percentage > target_nrw_percentage THEN 1 END)
      comment: "Number of DMA zones where actual NRW exceeds the target. Drives prioritization of active leakage control interventions."
    - name: "count_scada_monitored_zones"
      expr: COUNT(CASE WHEN scada_monitoring_enabled = TRUE THEN 1 END)
      comment: "Number of DMA zones with active SCADA monitoring. Measures real-time operational visibility coverage across the distribution network."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_nrw_water_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-revenue water balance analytics providing KPIs on water loss accounting at the DMA and territory level. Used by executives and regulators to track NRW reduction program outcomes and meet AWWA water audit reporting requirements."
  source: "`vibe_water_utilities_v1`.`metering`.`metering_nrw_water_balance`"
  dimensions:
    - name: "metering_dma_zone_id_dim"
      expr: metering_dma_zone_id
      comment: "DMA zone identifier for zone-level NRW balance analysis and benchmarking."
    - name: "territory_id_dim"
      expr: territory_id
      comment: "Service territory identifier for territory-level NRW reporting and regulatory submissions."
    - name: "regulatory_requirement_id_dim"
      expr: regulatory_requirement_id
      comment: "Regulatory requirement driving the NRW water balance reporting for compliance tracking."
  measures:
    - name: "total_nrw_balance_records"
      expr: COUNT(1)
      comment: "Total number of NRW water balance records. Used to verify completeness of water audit reporting across all DMA zones and reporting periods."
    - name: "distinct_dma_zones_with_balance"
      expr: COUNT(DISTINCT metering_dma_zone_id)
      comment: "Number of distinct DMA zones with water balance records. Measures coverage of the NRW water audit program across the distribution network."
    - name: "distinct_territories_with_balance"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of distinct service territories with NRW water balance records. Used for regulatory reporting completeness verification."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_ami_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI endpoint fleet analytics providing KPIs on device health, battery life, signal quality, and operational status. Used by metering infrastructure management to optimize AMI network performance, plan battery replacements, and ensure data collection reliability."
  source: "`vibe_water_utilities_v1`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the AMI endpoint (active, inactive, failed, decommissioned) for fleet health monitoring."
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of AMI endpoint (fixed network, mobile, cellular) for technology portfolio analysis."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the endpoint for network compatibility and upgrade planning."
    - name: "tamper_status"
      expr: tamper_status
      comment: "Tamper detection status for revenue protection monitoring and field investigation prioritization."
    - name: "leak_detection_enabled_flag"
      expr: leak_detection_enabled_flag
      comment: "Indicates whether leak detection is enabled on the endpoint for program coverage analysis."
    - name: "installation_date"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year of endpoint installation for fleet age analysis and replacement planning."
    - name: "reverse_flow_detected_flag"
      expr: reverse_flow_detected_flag
      comment: "Flags endpoints with reverse flow detected for backflow compliance monitoring."
  measures:
    - name: "avg_battery_level_percent"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery level percentage across the AMI endpoint fleet. Low averages predict imminent battery replacement needs and data collection gaps."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm across AMI endpoints. Low signal strength correlates with communication failures and read gaps."
    - name: "avg_battery_expected_life_years"
      expr: AVG(CAST(battery_expected_life_years AS DOUBLE))
      comment: "Average expected battery life in years across the fleet. Used for capital planning of battery replacement programs."
    - name: "avg_leak_alert_threshold_gpm"
      expr: AVG(CAST(leak_alert_threshold_gpm AS DOUBLE))
      comment: "Average leak alert threshold in gallons per minute across endpoints. Used to assess consistency of leak detection sensitivity across the fleet."
    - name: "count_active_endpoints"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of active AMI endpoints. Core fleet availability KPI for AMI program performance reporting."
    - name: "count_tamper_detected_endpoints"
      expr: COUNT(CASE WHEN tamper_status NOT IN ('none', 'clear', 'normal') THEN 1 END)
      comment: "Number of endpoints with active tamper status. Drives revenue protection field investigation prioritization."
    - name: "count_leak_detection_enabled_endpoints"
      expr: COUNT(CASE WHEN leak_detection_enabled_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with leak detection enabled. Measures leak detection program coverage across the metered service area."
    - name: "count_reverse_flow_endpoints"
      expr: COUNT(CASE WHEN reverse_flow_detected_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with reverse flow detected. Used for backflow prevention compliance and potential meter tampering investigation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_validation_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter read validation rule analytics providing KPIs on rule coverage, activity, and threshold configuration. Used by metering data quality management to ensure validation rules are properly configured and actively protecting billing data integrity."
  source: "`vibe_water_utilities_v1`.`metering`.`validation_rule`"
  dimensions:
    - name: "rule_category"
      expr: rule_category
      comment: "Category of validation rule (consumption, communication, tamper, pressure) for rule portfolio management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the validation rule (critical, warning, informational) for exception prioritization."
    - name: "applicable_entity"
      expr: applicable_entity
      comment: "Entity type the rule applies to (meter, endpoint, read) for rule scope analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the validation rule is currently active for rule governance monitoring."
    - name: "meter_size_type_id_dim"
      expr: meter_size_type_id
      comment: "Meter size/type the rule applies to, enabling size-specific validation rule coverage analysis."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the validation rule became effective for rule lifecycle management."
  measures:
    - name: "total_active_validation_rules"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Total number of active validation rules. Measures the breadth of automated data quality controls protecting billing data integrity."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value across validation rules. Used to benchmark rule sensitivity and identify outlier thresholds requiring review."
    - name: "count_rules_by_meter_size_type"
      expr: COUNT(DISTINCT meter_size_type_id)
      comment: "Number of distinct meter size types covered by validation rules. Measures validation rule coverage across the meter fleet by size class."
    - name: "count_critical_severity_rules"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Number of critical severity validation rules. Ensures adequate critical-level controls are in place for high-impact billing data quality scenarios."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_size_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter size and type catalog analytics providing KPIs on fleet composition, flow capacity specifications, and cost benchmarks. Used by asset management and procurement to optimize meter selection, plan replacements, and manage inventory costs."
  source: "`vibe_water_utilities_v1`.`metering`.`meter_size_type`"
  dimensions:
    - name: "meter_type"
      expr: meter_type
      comment: "Meter technology type (positive displacement, turbine, electromagnetic, ultrasonic) for technology portfolio analysis."
    - name: "meter_size_type_status"
      expr: meter_size_type_status
      comment: "Status of the meter size/type (active, obsolete, discontinued) for catalog governance."
    - name: "measurement_class"
      expr: measurement_class
      comment: "Measurement accuracy class for regulatory compliance and performance benchmarking."
    - name: "ami_compatible_flag"
      expr: ami_compatible_flag
      comment: "Indicates AMI compatibility for AMI deployment planning and fleet modernization tracking."
    - name: "lead_free_certified_flag"
      expr: lead_free_certified_flag
      comment: "Indicates lead-free certification status for LCR compliance and public health risk management."
    - name: "nsf_61_certified_flag"
      expr: nsf_61_certified_flag
      comment: "Indicates NSF/ANSI 61 certification for drinking water contact material compliance."
    - name: "typical_customer_class"
      expr: typical_customer_class
      comment: "Typical customer class served by this meter size/type for demand-based procurement planning."
  measures:
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(average_unit_cost_usd AS DOUBLE))
      comment: "Average unit cost in USD across meter size/types. Used for procurement budgeting and replacement program cost estimation."
    - name: "avg_max_flow_rate_gpm"
      expr: AVG(CAST(maximum_flow_rate_gpm AS DOUBLE))
      comment: "Average maximum flow rate capacity in GPM across meter types. Used for meter sizing validation and service connection capacity planning."
    - name: "avg_min_detectable_flow_gpm"
      expr: AVG(CAST(min_detectable_flow_gpm AS DOUBLE))
      comment: "Average minimum detectable flow in GPM across meter types. Lower values indicate better low-flow accuracy for leak detection and small consumption billing."
    - name: "avg_installation_labor_hours"
      expr: AVG(CAST(installation_labor_hours AS DOUBLE))
      comment: "Average installation labor hours per meter type. Used for field crew scheduling and replacement program cost estimation."
    - name: "count_ami_compatible_types"
      expr: COUNT(CASE WHEN ami_compatible_flag = TRUE THEN 1 END)
      comment: "Number of AMI-compatible meter size/types in the catalog. Measures the breadth of AMI-ready meter options for deployment planning."
    - name: "count_lead_free_certified_types"
      expr: COUNT(CASE WHEN lead_free_certified_flag = TRUE THEN 1 END)
      comment: "Number of lead-free certified meter types. Tracks compliance with lead-free material requirements under LCR and Safe Drinking Water Act."
    - name: "avg_pressure_loss_at_max_flow_psi"
      expr: AVG(CAST(pressure_loss_at_max_flow_psi AS DOUBLE))
      comment: "Average pressure loss at maximum flow in PSI. Used for hydraulic modeling and pressure zone design to account for meter head loss."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_field_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational quality metrics from meter field inspections"
  source: "`vibe_water_utilities_v1`.`metering`.`meter_field_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the field inspection"
    - name: "service_address_id"
      expr: service_address_id
      comment: "Service address associated with the inspected meter"
    - name: "leak_detected_flag"
      expr: leak_detected_flag
      comment: "Whether a leak was detected during inspection"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of field inspections performed"
    - name: "avg_gps_accuracy_meters"
      expr: AVG(CAST(gps_accuracy_meters AS DOUBLE))
      comment: "Average GPS accuracy of inspection locations in meters"
    - name: "seal_intact_count"
      expr: SUM(CASE WHEN seal_intact_flag THEN 1 ELSE 0 END)
      comment: "Count of inspections where the meter seal was intact"
$$;