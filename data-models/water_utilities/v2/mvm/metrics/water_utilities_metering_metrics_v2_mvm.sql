-- Metric views for domain: metering | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 20:21:36

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core AMI interval consumption metrics tracking volumetric throughput, flow rates, data quality, and anomaly signals across metered endpoints. Drives operational efficiency, revenue assurance, and leak detection decisions."
  source: "`vibe_water_utilities_v1`.`metering`.`interval_consumption`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — enables spatial analysis of consumption patterns and loss detection by zone."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the interval read (e.g., Valid, Estimated, Failed) — used to filter or segment data quality tiers."
    - name: "data_quality_indicator"
      expr: data_quality_indicator
      comment: "Data quality flag assigned to the interval record — supports quality-tier segmentation for reporting."
    - name: "interval_duration_minutes"
      expr: interval_duration_minutes
      comment: "Duration of the metering interval in minutes — allows comparison across 15-min, 30-min, and hourly read configurations."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Boolean flag indicating a potential leak was detected during this interval — key operational signal."
    - name: "high_usage_flag"
      expr: high_usage_flag
      comment: "Boolean flag indicating abnormally high consumption in this interval — triggers customer notification workflows."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Boolean flag indicating reverse flow detected — signals potential backflow or meter tampering."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Boolean flag indicating zero consumption recorded — used to identify inactive accounts or meter failures."
    - name: "gap_flag"
      expr: gap_flag
      comment: "Boolean flag indicating a data gap in the interval sequence — used to assess AMI network reliability."
    - name: "interval_start_date"
      expr: DATE_TRUNC('day', interval_start_timestamp)
      comment: "Day-level truncation of interval start timestamp — enables daily consumption trend analysis."
    - name: "interval_start_month"
      expr: DATE_TRUNC('month', interval_start_timestamp)
      comment: "Month-level truncation of interval start timestamp — supports monthly billing cycle and seasonal analysis."
    - name: "ami_endpoint_id"
      expr: ami_endpoint_id
      comment: "Foreign key to the AMI endpoint device — enables device-level performance and consumption analysis."
  measures:
    - name: "total_consumption_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total water consumption in gallons across all intervals in scope. Primary volumetric KPI for revenue assurance and demand planning."
    - name: "avg_consumption_per_interval_gallons"
      expr: AVG(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Average consumption per interval in gallons. Baseline for anomaly detection and per-endpoint benchmarking."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across intervals. Indicates typical demand intensity and supports hydraulic modeling."
    - name: "max_flow_rate_gpm"
      expr: MAX(flow_rate_gpm)
      comment: "Peak flow rate in gallons per minute observed across intervals. Critical for infrastructure capacity planning and surge detection."
    - name: "total_leak_detection_intervals"
      expr: SUM(CASE WHEN leak_detection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals where a leak was detected. Directly informs non-revenue water reduction programs and field dispatch prioritization."
    - name: "total_high_usage_intervals"
      expr: SUM(CASE WHEN high_usage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals flagged for abnormally high usage. Drives customer outreach and revenue protection workflows."
    - name: "total_reverse_flow_intervals"
      expr: SUM(CASE WHEN reverse_flow_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals with reverse flow detected. Signals backflow events or meter tampering requiring immediate investigation."
    - name: "total_zero_consumption_intervals"
      expr: SUM(CASE WHEN zero_consumption_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals recording zero consumption. Identifies potentially inactive services or meter malfunctions affecting billing accuracy."
    - name: "total_gap_intervals"
      expr: SUM(CASE WHEN gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals with data gaps in the AMI transmission sequence. Measures AMI network reliability and data completeness."
    - name: "data_gap_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals with data gaps. Key AMI network health KPI — high gap rates indicate communication failures impacting billing and operations."
    - name: "leak_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN leak_detection_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals flagged for leak detection. Tracks prevalence of potential non-revenue water events across the metered network."
    - name: "valid_interval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN validation_status = 'Valid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals passing validation. Measures AMI data quality — low rates indicate systemic read or transmission issues affecting billing integrity."
    - name: "total_interval_records"
      expr: COUNT(1)
      comment: "Total count of interval consumption records. Baseline volume metric for data completeness and AMI endpoint coverage assessment."
    - name: "distinct_active_endpoints"
      expr: COUNT(DISTINCT ami_endpoint_id)
      comment: "Count of distinct AMI endpoints with interval data. Measures AMI network coverage and active device population."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average water pressure in PSI across intervals. Supports hydraulic performance monitoring and pressure zone management decisions."
    - name: "avg_battery_voltage"
      expr: AVG(CAST(battery_voltage AS DOUBLE))
      comment: "Average battery voltage across AMI endpoint intervals. Tracks fleet battery health — declining averages trigger proactive replacement programs."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High usage alert metrics tracking alert volume, severity distribution, resolution performance, estimated water loss, and revenue impact. Drives customer engagement, non-revenue water reduction, and field investigation prioritization."
  source: "`vibe_water_utilities_v1`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity classification of the alert (e.g., Low, Medium, High, Critical) — enables prioritized response and escalation tracking."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (e.g., Open, Resolved, Suppressed) — tracks lifecycle and resolution pipeline."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of high usage alert (e.g., Continuous Flow, Spike, Threshold Breach) — supports root cause categorization."
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of alert resolution (e.g., Leak Confirmed, Customer Irrigation, No Issue Found) — informs program effectiveness and false positive rates."
    - name: "notification_method"
      expr: notification_method
      comment: "Channel used to notify the customer (e.g., Email, SMS, Phone) — supports channel effectiveness analysis."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Boolean indicating whether the customer was notified — measures notification program reach."
    - name: "service_order_created_flag"
      expr: service_order_created_flag
      comment: "Boolean indicating whether a service order was created in response — tracks field investigation dispatch rate."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Boolean indicating the alert was suppressed — used to monitor suppression rates and policy compliance."
    - name: "alert_generated_date"
      expr: DATE_TRUNC('day', alert_generated_timestamp)
      comment: "Day-level truncation of alert generation timestamp — enables daily alert volume trending."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('month', alert_generated_timestamp)
      comment: "Month-level truncation of alert generation timestamp — supports monthly program performance reporting."
    - name: "actual_consumption_unit"
      expr: actual_consumption_unit
      comment: "Unit of measure for actual consumption (e.g., Gallons, CCF) — ensures dimensional consistency in consumption comparisons."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of high usage alerts generated. Baseline volume KPI for alert program scale and trend monitoring."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Total estimated water loss in gallons across all alerts. Primary non-revenue water KPI — directly informs loss reduction investment decisions."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue at risk from high usage events. Quantifies financial exposure and justifies alert program investment."
    - name: "avg_estimated_water_loss_gallons"
      expr: AVG(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Average estimated water loss per alert in gallons. Benchmarks typical event severity and supports threshold calibration."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and baseline consumption. Measures typical deviation magnitude driving alert generation."
    - name: "avg_actual_consumption"
      expr: AVG(CAST(actual_consumption_value AS DOUBLE))
      comment: "Average actual consumption value at time of alert. Contextualizes alert thresholds against real usage patterns."
    - name: "avg_baseline_consumption"
      expr: AVG(CAST(baseline_consumption_value AS DOUBLE))
      comment: "Average baseline consumption value used for alert comparison. Supports baseline calibration and accuracy assessment."
    - name: "resolved_alert_count"
      expr: SUM(CASE WHEN alert_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of alerts that have been resolved. Measures resolution throughput and backlog management effectiveness."
    - name: "alert_resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_status = 'Resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts resolved. Key operational KPI — low resolution rates indicate field capacity constraints or process gaps."
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts where the customer was notified. Measures customer engagement program reach and compliance with notification policies."
    - name: "service_order_dispatch_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_order_created_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts resulting in a field service order. Tracks escalation rate and field investigation resource demand."
    - name: "suppression_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN suppression_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts suppressed. High suppression rates may indicate over-alerting or policy misalignment requiring threshold recalibration."
    - name: "distinct_affected_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customer accounts with high usage alerts. Measures breadth of impact across the customer base."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average alert threshold value in effect across alerts. Supports threshold policy review and calibration governance."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_ami_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI endpoint fleet health and operational metrics tracking device status, battery life, signal quality, communication reliability, and tamper events. Drives AMI asset management, replacement planning, and network performance decisions."
  source: "`vibe_water_utilities_v1`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the AMI endpoint (e.g., Active, Inactive, Decommissioned) — primary fleet health segmentation dimension."
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of AMI endpoint device — enables fleet segmentation by technology generation or form factor."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the endpoint (e.g., RF, Cellular, LoRa) — supports network technology mix analysis."
    - name: "firmware_version"
      expr: firmware_version
      comment: "Current firmware version on the endpoint — tracks firmware currency and identifies devices requiring updates."
    - name: "network_node_code"
      expr: network_node_code
      comment: "Network node the endpoint communicates through — enables node-level performance and coverage analysis."
    - name: "tamper_status"
      expr: tamper_status
      comment: "Current tamper status of the endpoint — flags devices with active tamper events for revenue protection investigation."
    - name: "leak_detection_enabled_flag"
      expr: leak_detection_enabled_flag
      comment: "Boolean indicating whether leak detection is enabled on this endpoint — measures leak detection program coverage."
    - name: "reverse_flow_detected_flag"
      expr: reverse_flow_detected_flag
      comment: "Boolean indicating reverse flow has been detected on this endpoint — signals backflow or tampering requiring investigation."
    - name: "signal_quality_indicator"
      expr: signal_quality_indicator
      comment: "Qualitative signal quality classification (e.g., Good, Fair, Poor) — supports network coverage gap identification."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — enables spatial fleet health analysis by service zone."
    - name: "installation_month"
      expr: DATE_TRUNC('month', installation_date)
      comment: "Month of endpoint installation — supports fleet age cohort analysis and replacement wave planning."
    - name: "commissioning_month"
      expr: DATE_TRUNC('month', commissioning_date)
      comment: "Month of endpoint commissioning — tracks AMI rollout progress and deployment velocity."
    - name: "warranty_expiration_date"
      expr: warranty_expiration_date
      comment: "Warranty expiration date of the endpoint — enables proactive identification of out-of-warranty devices for risk management."
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total count of AMI endpoints in the fleet. Baseline fleet size KPI for coverage and investment tracking."
    - name: "active_endpoint_count"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of endpoints in active operational status. Measures effective AMI network coverage and deployment success."
    - name: "active_endpoint_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints that are operationally active. Key fleet health KPI — low rates indicate deployment gaps or device failures."
    - name: "avg_battery_level_pct"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery level percentage across the endpoint fleet. Tracks fleet battery health — declining averages trigger proactive replacement programs."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm across endpoints. Measures AMI network communication quality — low values indicate coverage gaps requiring infrastructure investment."
    - name: "avg_battery_expected_life_years"
      expr: AVG(CAST(battery_expected_life_years AS DOUBLE))
      comment: "Average expected battery life in years across the fleet. Informs battery replacement cycle planning and capital budgeting."
    - name: "tamper_detected_endpoint_count"
      expr: SUM(CASE WHEN tamper_status IS NOT NULL AND tamper_status != 'None' THEN 1 ELSE 0 END)
      comment: "Count of endpoints with an active tamper status. Revenue protection KPI — drives field investigation and enforcement actions."
    - name: "reverse_flow_endpoint_count"
      expr: SUM(CASE WHEN reverse_flow_detected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints where reverse flow has been detected. Signals backflow events or meter tampering requiring immediate investigation."
    - name: "leak_detection_enabled_count"
      expr: SUM(CASE WHEN leak_detection_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints with leak detection enabled. Measures leak detection program coverage across the AMI fleet."
    - name: "leak_detection_coverage_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN leak_detection_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with leak detection enabled. Tracks program rollout completeness — low coverage leaves non-revenue water risk undetected."
    - name: "avg_leak_alert_threshold_gpm"
      expr: AVG(CAST(leak_alert_threshold_gpm AS DOUBLE))
      comment: "Average leak alert threshold in gallons per minute across endpoints. Supports threshold policy governance and calibration review."
    - name: "distinct_network_nodes"
      expr: COUNT(DISTINCT network_node_code)
      comment: "Count of distinct network nodes serving the endpoint fleet. Measures AMI network topology breadth and single-node dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter_size_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter size type catalog metrics tracking fleet composition, accuracy specifications, cost profiles, and compliance certifications. Supports meter procurement strategy, replacement planning, and regulatory compliance governance."
  source: "`vibe_water_utilities_v1`.`metering`.`meter_size_type`"
  dimensions:
    - name: "meter_type"
      expr: meter_type
      comment: "Technology type of the meter (e.g., Positive Displacement, Turbine, Electromagnetic) — enables fleet technology mix analysis."
    - name: "measurement_class"
      expr: measurement_class
      comment: "Measurement class of the meter — supports regulatory classification and accuracy tier segmentation."
    - name: "accuracy_class"
      expr: accuracy_class
      comment: "Accuracy class designation per AWWA or regulatory standard — drives meter selection and replacement prioritization."
    - name: "typical_customer_class"
      expr: typical_customer_class
      comment: "Typical customer class served by this meter size type (e.g., Residential, Commercial, Industrial) — enables customer segment fleet analysis."
    - name: "ami_compatible_flag"
      expr: ami_compatible_flag
      comment: "Boolean indicating AMI compatibility — measures AMI-ready fleet proportion for smart meter program planning."
    - name: "amr_compatible_flag"
      expr: amr_compatible_flag
      comment: "Boolean indicating AMR compatibility — tracks legacy remote read capability across the meter catalog."
    - name: "lead_free_certified_flag"
      expr: lead_free_certified_flag
      comment: "Boolean indicating lead-free certification — critical regulatory compliance dimension for safe drinking water mandates."
    - name: "nsf_61_certified_flag"
      expr: nsf_61_certified_flag
      comment: "Boolean indicating NSF/ANSI 61 certification for drinking water contact materials — regulatory compliance dimension."
    - name: "active_flag"
      expr: active_flag
      comment: "Boolean indicating whether this meter size type is currently active in the catalog — filters active vs. retired meter types."
    - name: "meter_size_type_status"
      expr: meter_size_type_status
      comment: "Lifecycle status of the meter size type (e.g., Active, Obsolete, Discontinued) — supports catalog governance."
    - name: "awwa_standard_code"
      expr: awwa_standard_code
      comment: "AWWA standard code applicable to this meter type — ensures regulatory and industry standard traceability."
    - name: "typical_application"
      expr: typical_application
      comment: "Typical application context for this meter size type — supports application-based fleet segmentation."
  measures:
    - name: "total_meter_size_types"
      expr: COUNT(1)
      comment: "Total count of meter size type catalog entries. Baseline catalog breadth metric for procurement and standardization governance."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(average_unit_cost_usd AS DOUBLE))
      comment: "Average unit cost in USD across meter size types. Informs procurement budgeting and cost benchmarking for replacement programs."
    - name: "avg_installation_labor_hours"
      expr: AVG(CAST(installation_labor_hours AS DOUBLE))
      comment: "Average installation labor hours per meter size type. Drives field crew capacity planning and installation cost estimation."
    - name: "avg_meter_size_inches"
      expr: AVG(CAST(meter_size_inches AS DOUBLE))
      comment: "Average meter size in inches across catalog entries. Characterizes fleet size distribution for hydraulic and procurement planning."
    - name: "avg_max_flow_rate_gpm"
      expr: AVG(CAST(maximum_flow_rate_gpm AS DOUBLE))
      comment: "Average maximum flow rate capacity in GPM across meter types. Supports hydraulic capacity planning and meter sizing governance."
    - name: "avg_min_detectable_flow_gpm"
      expr: AVG(CAST(min_detectable_flow_gpm AS DOUBLE))
      comment: "Average minimum detectable flow rate in GPM. Measures low-flow accuracy capability — critical for leak detection and small consumption billing accuracy."
    - name: "avg_accuracy_pct_normal_flow"
      expr: AVG(CAST(accuracy_percentage_normal_flow AS DOUBLE))
      comment: "Average accuracy percentage at normal flow conditions. Key meter quality KPI — directly impacts billing accuracy and regulatory compliance."
    - name: "avg_accuracy_pct_low_flow"
      expr: AVG(CAST(accuracy_percentage_low_flow AS DOUBLE))
      comment: "Average accuracy percentage at low flow conditions. Measures meter performance at the most challenging operating point — informs replacement prioritization."
    - name: "ami_compatible_type_count"
      expr: SUM(CASE WHEN ami_compatible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of meter size types compatible with AMI. Measures smart meter program readiness across the catalog."
    - name: "ami_compatibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ami_compatible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of meter size types that are AMI compatible. Tracks smart meter program catalog readiness — low rates indicate catalog modernization gaps."
    - name: "lead_free_certified_count"
      expr: SUM(CASE WHEN lead_free_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of meter size types with lead-free certification. Regulatory compliance KPI for safe drinking water material standards."
    - name: "avg_pressure_loss_at_max_flow_psi"
      expr: AVG(CAST(pressure_loss_at_max_flow_psi AS DOUBLE))
      comment: "Average pressure loss at maximum flow in PSI across meter types. Informs hydraulic system design and pressure zone management."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_replacement_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter replacement order metrics tracking replacement program volume, compliance-driven replacements, and work order execution. Drives asset lifecycle management, regulatory compliance, and capital program performance."
  source: "`vibe_water_utilities_v1`.`metering`.`replacement_order`"
  dimensions:
    - name: "meter_size_type_id"
      expr: meter_size_type_id
      comment: "Meter size type being installed as replacement — enables replacement program analysis by meter technology and size class."
    - name: "accuracy_test_id"
      expr: accuracy_test_id
      comment: "Accuracy test that triggered this replacement order — links replacement activity to meter performance failures."
    - name: "violation_id"
      expr: violation_id
      comment: "Compliance violation that triggered this replacement — tracks regulatory-driven replacement volume."
    - name: "enforcement_action_id"
      expr: enforcement_action_id
      comment: "Enforcement action associated with this replacement — measures compliance-mandated replacement program scope."
  measures:
    - name: "total_replacement_orders"
      expr: COUNT(1)
      comment: "Total count of meter replacement orders. Baseline capital program volume KPI for replacement program tracking and resource planning."
    - name: "compliance_driven_replacements"
      expr: SUM(CASE WHEN violation_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacement orders triggered by a compliance violation. Measures regulatory-mandated replacement volume — directly informs compliance program resourcing."
    - name: "compliance_replacement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN violation_id IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replacement orders driven by compliance violations. Tracks regulatory pressure on the replacement program — high rates signal systemic meter performance issues."
    - name: "accuracy_test_triggered_replacements"
      expr: SUM(CASE WHEN accuracy_test_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacement orders triggered by a failed accuracy test. Measures meter accuracy program effectiveness in driving timely replacements."
    - name: "enforcement_action_replacements"
      expr: SUM(CASE WHEN enforcement_action_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacement orders associated with a regulatory enforcement action. Tracks the most severe compliance-driven replacement category requiring executive attention."
    - name: "distinct_meter_size_types_replaced"
      expr: COUNT(DISTINCT meter_size_type_id)
      comment: "Count of distinct meter size types involved in replacement orders. Measures catalog diversity of replacement activity for procurement planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_read_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter read route operational metrics tracking route efficiency, meter coverage, and active route status. Supports field operations planning, route optimization, and meter reading workforce management."
  source: "`vibe_water_utilities_v1`.`metering`.`read_route`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating whether the read route is currently active — segments active vs. retired routes for operational planning."
    - name: "geographic_area"
      expr: geographic_area
      comment: "Geographic area served by the read route — enables spatial analysis of route coverage and field crew deployment."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area served by the route — links route operations to DMA-level water balance and loss analysis."
    - name: "territory_id"
      expr: territory_id
      comment: "Service territory of the read route — enables territory-level operational performance comparison."
    - name: "route_code"
      expr: route_code
      comment: "Unique route code identifier — used for route-level operational drill-down and scheduling."
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total count of read routes. Baseline fleet size metric for field operations capacity planning."
    - name: "active_route_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active read routes. Measures operational field reading capacity."
    - name: "total_meters_on_routes"
      expr: SUM(CAST(meter_count AS DOUBLE))
      comment: "Total number of meters assigned across all read routes. Measures field reading program scope and workload volume."
    - name: "avg_meters_per_route"
      expr: AVG(CAST(meter_count AS DOUBLE))
      comment: "Average number of meters per read route. Key route efficiency KPI — imbalanced routes indicate optimization opportunities for field crew productivity."
    - name: "avg_estimated_read_time_minutes"
      expr: AVG(CAST(estimated_read_time_minutes AS DOUBLE))
      comment: "Average estimated read time in minutes per route. Drives field crew scheduling, overtime management, and route optimization decisions."
    - name: "total_estimated_read_time_minutes"
      expr: SUM(CAST(estimated_read_time_minutes AS DOUBLE))
      comment: "Total estimated read time in minutes across all routes. Quantifies total field reading labor demand for workforce capacity planning."
    - name: "max_meters_on_single_route"
      expr: MAX(meter_count)
      comment: "Maximum meter count on any single route. Identifies overloaded routes that may cause read cycle delays or missed reads."
$$;