-- Metric views for domain: analytics | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_kpi_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPI performance tracking view measuring actual vs target values, variance, and trend across all business KPIs. Used by executives and domain owners to steer performance against plan."
  source: "`vibe_retail_v1`.`analytics`.`kpi_value`"
  dimensions:
    - name: "kpi_definition_id"
      expr: kpi_definition_id
      comment: "Foreign key to the KPI definition, used to group performance values by specific KPI."
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the measurement period (e.g., daily, weekly, monthly, quarterly)."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the measurement window for time-series analysis."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the measurement window for time-series analysis."
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity the KPI value is associated with (e.g., store, product, customer)."
    - name: "performance_status"
      expr: performance_status
      comment: "Categorical performance status (e.g., on-track, at-risk, off-track) for filtering and alerting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which monetary KPI values are expressed."
    - name: "is_forecast"
      expr: is_forecast
      comment: "Flag indicating whether the value is a forecast or an actuals record."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Directional trend of the KPI (improving, declining, stable) for executive dashboards."
    - name: "alert_triggered_flag"
      expr: alert_triggered_flag
      comment: "Indicates whether this KPI value triggered an alert, used to prioritize management attention."
    - name: "location_id"
      expr: location_id
      comment: "Store location associated with the KPI value for geographic performance analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department associated with the KPI value for departmental performance analysis."
    - name: "retail_calendar_id"
      expr: retail_calendar_id
      comment: "Retail calendar reference for fiscal period alignment."
  measures:
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of all actual KPI values in the period. Used to aggregate performance across entities."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all target KPI values in the period. Used as the plan baseline for variance analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of absolute variance (actual minus target) across all KPI records. Negative values indicate underperformance."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across KPI records. Key executive metric for plan attainment."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of KPI values, indicating reliability of reported metrics."
    - name: "kpi_record_count"
      expr: COUNT(1)
      comment: "Total number of KPI value records in scope, used as a volume baseline."
    - name: "alert_triggered_count"
      expr: COUNT(CASE WHEN alert_triggered_flag = TRUE THEN 1 END)
      comment: "Number of KPI records that triggered an alert, indicating the breadth of performance exceptions."
    - name: "forecast_record_count"
      expr: COUNT(CASE WHEN is_forecast = TRUE THEN 1 END)
      comment: "Number of forecast KPI records, used to distinguish plan vs actuals volume."
    - name: "avg_prior_period_variance_percentage"
      expr: AVG(CAST(prior_period_variance_percentage AS DOUBLE))
      comment: "Average variance percentage compared to the prior period, indicating momentum and trend strength."
    - name: "avg_confidence_interval_lower"
      expr: AVG(CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average lower bound of the confidence interval for forecast KPI values."
    - name: "avg_confidence_interval_upper"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE))
      comment: "Average upper bound of the confidence interval for forecast KPI values."
    - name: "distinct_kpi_count"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of distinct KPIs being tracked, indicating breadth of performance measurement coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target-setting and governance view tracking target values, stretch goals, and floor thresholds across business entities and financial periods. Used by finance and operations leadership for planning and incentive management."
  source: "`vibe_retail_v1`.`analytics`.`analytics_kpi_target`"
  dimensions:
    - name: "kpi_definition_id"
      expr: kpi_definition_id
      comment: "KPI definition this target applies to, used to group targets by KPI type."
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity the target is set for (store, department, region, etc.)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the target for annual planning and rollup analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year for sub-annual target tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the target (draft, approved, rejected) for governance tracking."
    - name: "target_setting_method"
      expr: target_setting_method
      comment: "Method used to set the target (top-down, bottom-up, statistical) for process transparency."
    - name: "incentive_eligible_flag"
      expr: incentive_eligible_flag
      comment: "Whether the target is linked to an incentive plan, critical for compensation planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary targets for multi-currency reporting."
    - name: "location_id"
      expr: location_id
      comment: "Store location the target is assigned to for location-level performance planning."
    - name: "is_active"
      expr: is_active
      comment: "Whether the target record is currently active, used to filter to current planning cycle."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all KPI target values. Core planning metric used to understand total performance expectations."
    - name: "total_stretch_target_value"
      expr: SUM(CAST(stretch_target_value AS DOUBLE))
      comment: "Sum of stretch target values representing aspirational performance goals above the base target."
    - name: "total_floor_threshold_value"
      expr: SUM(CAST(floor_threshold_value AS DOUBLE))
      comment: "Sum of floor threshold values representing minimum acceptable performance levels."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average KPI target value across entities, used for benchmarking and normalization."
    - name: "avg_variance_alert_threshold_percent"
      expr: AVG(CAST(variance_alert_threshold_percent AS DOUBLE))
      comment: "Average variance alert threshold percentage, indicating how tightly targets are monitored."
    - name: "target_count"
      expr: COUNT(1)
      comment: "Total number of KPI target records, indicating planning coverage breadth."
    - name: "incentive_eligible_target_count"
      expr: COUNT(CASE WHEN incentive_eligible_flag = TRUE THEN 1 END)
      comment: "Number of targets linked to incentive plans, used for compensation governance."
    - name: "approved_target_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of targets that have been formally approved, indicating planning cycle completion."
    - name: "distinct_kpi_coverage"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of distinct KPIs with active targets, measuring planning coverage completeness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational alert performance view tracking alert volume, severity distribution, resolution efficiency, and false positive rates. Used by operations and analytics leadership to manage exception handling and system reliability."
  source: "`vibe_retail_v1`.`analytics`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Category of alert (inventory, pricing, compliance, etc.) for alert type distribution analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the alert (critical, high, medium, low) for prioritization."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (open, acknowledged, resolved, suppressed) for workload management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the alert, indicating how far up the management chain it has been raised."
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity the alert is associated with for domain-level alert analysis."
    - name: "period_type"
      expr: period_type
      comment: "Time period granularity of the alert measurement window."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel through which the alert notification was sent (email, Slack, PagerDuty, etc.)."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the alert was determined to be a false positive, used for alert quality analysis."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Whether the alert was suppressed, used to track noise reduction effectiveness."
    - name: "location_id"
      expr: location_id
      comment: "Store location associated with the alert for geographic exception analysis."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start of the measurement window for time-series alert trend analysis."
  measures:
    - name: "total_alert_count"
      expr: COUNT(1)
      comment: "Total number of alerts generated. Core operational health metric for exception management."
    - name: "critical_alert_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Number of critical severity alerts requiring immediate executive attention."
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Number of alerts identified as false positives, indicating alert rule quality."
    - name: "suppressed_alert_count"
      expr: COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END)
      comment: "Number of suppressed alerts, used to measure noise reduction in the alerting system."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance amounts across all alerts, quantifying the total business impact of exceptions."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance that triggered alerts, indicating typical exception magnitude."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value configured across alerts, used for threshold calibration analysis."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value at time of alert trigger, used to understand typical alert conditions."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Number of alerts for which notifications were successfully sent."
    - name: "distinct_kpi_alert_count"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of distinct KPIs that generated alerts, indicating breadth of performance exceptions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dq_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality execution results view measuring pass/fail rates, failure trends, and data trust scores across domains and products. Used by data governance and engineering leadership to manage data reliability."
  source: "`vibe_retail_v1`.`analytics`.`dq_result`"
  dimensions:
    - name: "dq_rule_id"
      expr: dq_rule_id
      comment: "Data quality rule that was executed, used to analyze performance by rule type."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass or fail outcome of the DQ rule execution."
    - name: "execution_status"
      expr: execution_status
      comment: "Technical execution status (success, error, timeout) of the DQ check run."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the DQ result (critical, high, medium, low) for prioritizing remediation."
    - name: "target_domain"
      expr: target_domain
      comment: "Business domain of the data being quality-checked for domain-level DQ analysis."
    - name: "target_product"
      expr: target_product
      comment: "Specific data product being quality-checked for product-level DQ analysis."
    - name: "target_attribute"
      expr: target_attribute
      comment: "Specific attribute being quality-checked for attribute-level DQ analysis."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of DQ rule (completeness, uniqueness, validity, etc.) for rule category analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Execution schedule type (batch, streaming, on-demand) for operational planning."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the DQ check completed within its SLA window, used for SLA governance."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction of DQ results (improving, degrading, stable) for proactive governance."
  measures:
    - name: "total_records_evaluated"
      expr: SUM(CAST(records_evaluated_count AS DOUBLE))
      comment: "Total number of records evaluated across all DQ checks, indicating coverage breadth."
    - name: "total_records_failed"
      expr: SUM(CAST(records_failed_count AS DOUBLE))
      comment: "Total number of records that failed DQ checks, the primary data quality health metric."
    - name: "total_records_passed"
      expr: SUM(CAST(records_passed_count AS DOUBLE))
      comment: "Total number of records that passed DQ checks, used to compute overall pass rate."
    - name: "avg_failure_rate_percent"
      expr: AVG(CAST(failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage across DQ rule executions. Key data quality health KPI."
    - name: "avg_data_trust_score"
      expr: AVG(CAST(data_trust_score AS DOUBLE))
      comment: "Average data trust score across all DQ results, the headline data quality governance metric."
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average DQ check execution time in seconds, used for performance optimization."
    - name: "dq_run_count"
      expr: COUNT(1)
      comment: "Total number of DQ rule executions, indicating monitoring activity volume."
    - name: "failed_run_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'fail' THEN 1 END)
      comment: "Number of DQ rule executions that resulted in a failure, used for failure rate calculation."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = FALSE THEN 1 END)
      comment: "Number of DQ executions that breached their SLA, indicating operational reliability issues."
    - name: "avg_previous_failure_rate_percent"
      expr: AVG(CAST(previous_failure_rate_percent AS DOUBLE))
      comment: "Average prior-period failure rate for trend comparison against current failure rates."
    - name: "distinct_products_monitored"
      expr: COUNT(DISTINCT target_product)
      comment: "Number of distinct data products under DQ monitoring, measuring governance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dq_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality issue management view tracking issue volume, severity, remediation cost, and resolution rates. Used by data governance leadership to prioritize remediation and measure data quality program effectiveness."
  source: "`vibe_retail_v1`.`analytics`.`dq_issue`"
  dimensions:
    - name: "issue_type"
      expr: issue_type
      comment: "Category of data quality issue (completeness, accuracy, timeliness, etc.) for root cause analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the issue (critical, high, medium, low) for prioritization."
    - name: "dq_issue_status"
      expr: dq_issue_status
      comment: "Current resolution status of the issue (open, in-progress, resolved, closed)."
    - name: "domain"
      expr: domain
      comment: "Business domain where the data quality issue was detected."
    - name: "data_product"
      expr: data_product
      comment: "Specific data product affected by the issue for product-level quality analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the issue for systemic problem identification."
    - name: "compliance_impact_flag"
      expr: compliance_impact_flag
      comment: "Whether the issue has a compliance impact, used to prioritize regulatory risk remediation."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether the issue is a recurrence of a previously resolved issue, indicating systemic problems."
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the issue for workload management."
    - name: "detection_method"
      expr: detection_method
      comment: "How the issue was detected (automated rule, manual review, user report) for process improvement."
  measures:
    - name: "total_issues"
      expr: COUNT(1)
      comment: "Total number of data quality issues, the headline data quality health metric."
    - name: "total_affected_records"
      expr: SUM(CAST(affected_record_count AS DOUBLE))
      comment: "Total number of data records affected by quality issues, quantifying business impact."
    - name: "total_remediation_cost_estimate"
      expr: SUM(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to remediate all open data quality issues, used for budget planning."
    - name: "avg_remediation_cost_estimate"
      expr: AVG(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Average remediation cost per issue, used for cost-per-issue benchmarking."
    - name: "compliance_impact_issue_count"
      expr: COUNT(CASE WHEN compliance_impact_flag = TRUE THEN 1 END)
      comment: "Number of issues with compliance impact, critical for regulatory risk management."
    - name: "recurrent_issue_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring issues indicating systemic data quality problems requiring root cause fixes."
    - name: "open_issue_count"
      expr: COUNT(CASE WHEN dq_issue_status = 'open' THEN 1 END)
      comment: "Number of currently open data quality issues representing active data risk."
    - name: "distinct_domains_affected"
      expr: COUNT(DISTINCT domain)
      comment: "Number of distinct business domains with active data quality issues, measuring breadth of impact."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_self_service_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Self-service analytics adoption and efficiency view measuring query volume, compute cost, performance, and user engagement. Used by analytics platform leadership to optimize infrastructure investment and drive adoption."
  source: "`vibe_retail_v1`.`analytics`.`self_service_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of query (ad-hoc, saved, scheduled) for usage pattern analysis."
    - name: "query_status"
      expr: query_status
      comment: "Execution status of the query (success, error, timeout) for reliability monitoring."
    - name: "bi_tool"
      expr: bi_tool
      comment: "BI tool used to execute the query for platform adoption analysis."
    - name: "target_domain"
      expr: target_domain
      comment: "Business domain being queried for domain-level consumption analysis."
    - name: "target_data_product"
      expr: target_data_product
      comment: "Specific data product being queried for product-level usage analysis."
    - name: "user_department"
      expr: user_department
      comment: "Department of the user running the query for departmental adoption analysis."
    - name: "user_role"
      expr: user_role
      comment: "Role of the user running the query for persona-based adoption analysis."
    - name: "cache_hit"
      expr: cache_hit
      comment: "Whether the query was served from cache, used for infrastructure optimization analysis."
    - name: "contains_pii"
      expr: contains_pii
      comment: "Whether the query accessed PII data, used for data governance and compliance monitoring."
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level of the query results for security governance."
  measures:
    - name: "total_query_count"
      expr: COUNT(1)
      comment: "Total number of self-service queries executed, the headline platform adoption metric."
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(compute_cost_usd AS DOUBLE))
      comment: "Total compute cost in USD across all queries, the primary infrastructure cost metric."
    - name: "avg_compute_cost_usd"
      expr: AVG(CAST(compute_cost_usd AS DOUBLE))
      comment: "Average compute cost per query, used for cost efficiency benchmarking."
    - name: "total_data_scanned_bytes"
      expr: SUM(CAST(data_scanned_bytes AS DOUBLE))
      comment: "Total data scanned in bytes across all queries, used for storage and performance optimization."
    - name: "avg_query_duration_seconds"
      expr: AVG(CAST(query_duration_seconds AS DOUBLE))
      comment: "Average query execution time in seconds, the primary platform performance KPI."
    - name: "avg_query_complexity_score"
      expr: AVG(CAST(query_complexity_score AS DOUBLE))
      comment: "Average query complexity score, used to understand workload characteristics and optimization needs."
    - name: "total_rows_returned"
      expr: SUM(CAST(rows_returned AS DOUBLE))
      comment: "Total rows returned across all queries, indicating data consumption volume."
    - name: "avg_result_set_size_mb"
      expr: AVG(CAST(result_set_size_mb AS DOUBLE))
      comment: "Average result set size in MB, used for network and storage capacity planning."
    - name: "cache_hit_count"
      expr: COUNT(CASE WHEN cache_hit = TRUE THEN 1 END)
      comment: "Number of queries served from cache, used to measure caching effectiveness and cost savings."
    - name: "error_query_count"
      expr: COUNT(CASE WHEN query_status = 'error' THEN 1 END)
      comment: "Number of queries that resulted in errors, indicating platform reliability issues."
    - name: "distinct_active_users"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of distinct users executing queries, the primary platform adoption metric."
    - name: "pii_query_count"
      expr: COUNT(CASE WHEN contains_pii = TRUE THEN 1 END)
      comment: "Number of queries accessing PII data, used for data governance and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_report_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report subscription and delivery performance view measuring subscription volume, delivery success rates, and engagement. Used by analytics platform leadership to optimize report distribution and measure content value."
  source: "`vibe_retail_v1`.`analytics`.`report_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, paused, cancelled) for lifecycle analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the report is delivered (email, Slack, API) for channel effectiveness analysis."
    - name: "delivery_schedule_type"
      expr: delivery_schedule_type
      comment: "Frequency type of the delivery schedule (daily, weekly, monthly) for scheduling analysis."
    - name: "output_format"
      expr: output_format
      comment: "Format of the delivered report (PDF, Excel, CSV) for format preference analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the subscription for resource allocation and SLA management."
    - name: "is_shared_subscription"
      expr: is_shared_subscription
      comment: "Whether the subscription is shared across multiple users, indicating collaborative usage."
    - name: "data_refresh_required_flag"
      expr: data_refresh_required_flag
      comment: "Whether a data refresh is required before delivery, used for pipeline dependency management."
  measures:
    - name: "total_subscription_count"
      expr: COUNT(1)
      comment: "Total number of report subscriptions, indicating report distribution breadth."
    - name: "active_subscription_count"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Number of currently active subscriptions, the primary report engagement metric."
    - name: "cancelled_subscription_count"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled subscriptions, used to measure report relevance and churn."
    - name: "distinct_reports_subscribed"
      expr: COUNT(DISTINCT report_definition_id)
      comment: "Number of distinct reports with active subscriptions, measuring content portfolio utilization."
    - name: "shared_subscription_count"
      expr: COUNT(CASE WHEN is_shared_subscription = TRUE THEN 1 END)
      comment: "Number of shared subscriptions, indicating collaborative analytics consumption patterns."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dashboard_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dashboard governance and adoption view measuring dashboard portfolio health, certification status, and usage. Used by analytics leadership to manage the dashboard catalog and prioritize maintenance investment."
  source: "`vibe_retail_v1`.`analytics`.`dashboard_config`"
  dimensions:
    - name: "dashboard_type"
      expr: dashboard_type
      comment: "Type of dashboard (operational, strategic, self-service) for portfolio categorization."
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the dashboard (draft, published, archived) for lifecycle management."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the dashboard (certified, pending, uncertified) for governance tracking."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit that owns the dashboard for accountability and maintenance tracking."
    - name: "bi_platform"
      expr: bi_platform
      comment: "BI platform hosting the dashboard for platform portfolio management."
    - name: "mobile_enabled"
      expr: mobile_enabled
      comment: "Whether the dashboard is mobile-enabled for device accessibility analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the dashboard is currently active for active portfolio sizing."
    - name: "access_tier"
      expr: access_tier
      comment: "Access tier of the dashboard (public, restricted, confidential) for security governance."
  measures:
    - name: "total_dashboard_count"
      expr: COUNT(1)
      comment: "Total number of dashboards in the catalog, the headline portfolio size metric."
    - name: "certified_dashboard_count"
      expr: COUNT(CASE WHEN certification_status = 'certified' THEN 1 END)
      comment: "Number of certified dashboards, indicating the proportion of governed, trusted content."
    - name: "active_dashboard_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active dashboards for active portfolio management."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all dashboards, the primary engagement and adoption metric."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per dashboard, used to identify high-value vs low-value content."
    - name: "mobile_enabled_dashboard_count"
      expr: COUNT(CASE WHEN mobile_enabled = TRUE THEN 1 END)
      comment: "Number of mobile-enabled dashboards, indicating mobile accessibility coverage."
    - name: "distinct_owning_units"
      expr: COUNT(DISTINCT owning_business_unit)
      comment: "Number of distinct business units with dashboards, measuring analytics democratization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_sla_kpi_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA-KPI linkage view measuring SLA performance thresholds, breach penalties, and measurement weights. Used by operations and vendor management leadership to govern SLA compliance and financial exposure."
  source: "`vibe_retail_v1`.`analytics`.`sla_kpi_measurement`"
  dimensions:
    - name: "kpi_definition_id"
      expr: kpi_definition_id
      comment: "KPI definition linked to the SLA measurement for KPI-level SLA analysis."
    - name: "sla_definition_id"
      expr: sla_definition_id
      comment: "SLA definition being measured for SLA-level performance analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the SLA measurement (active, breached, compliant) for exception management."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the SLA KPI is measured (daily, weekly, monthly) for operational planning."
    - name: "is_primary_kpi"
      expr: is_primary_kpi
      comment: "Whether this is the primary KPI for the SLA, used to focus on headline SLA metrics."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the SLA measurement period for temporal analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the SLA measurement period for temporal analysis."
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA-KPI measurement configurations, indicating SLA governance coverage."
    - name: "total_breach_penalty_rate"
      expr: SUM(CAST(breach_penalty_rate AS DOUBLE))
      comment: "Sum of breach penalty rates across all SLA measurements, quantifying total financial exposure from SLA breaches."
    - name: "avg_breach_penalty_rate"
      expr: AVG(CAST(breach_penalty_rate AS DOUBLE))
      comment: "Average breach penalty rate per SLA measurement, used for SLA risk benchmarking."
    - name: "avg_alert_threshold_value"
      expr: AVG(CAST(alert_threshold_value AS DOUBLE))
      comment: "Average alert threshold value across SLA measurements, used for threshold calibration."
    - name: "avg_measurement_weight"
      expr: AVG(CAST(measurement_weight AS DOUBLE))
      comment: "Average measurement weight across SLA KPIs, used to understand relative importance of SLA components."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average SLA threshold value, used for SLA standard benchmarking across contracts."
    - name: "primary_kpi_count"
      expr: COUNT(CASE WHEN is_primary_kpi = TRUE THEN 1 END)
      comment: "Number of primary SLA KPI measurements, indicating the core SLA performance indicators being tracked."
    - name: "distinct_slas_measured"
      expr: COUNT(DISTINCT sla_definition_id)
      comment: "Number of distinct SLAs under active KPI measurement, indicating SLA governance breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_retail_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail calendar reference view providing fiscal period alignment, holiday period flags, and comparable period mapping. Used by finance and merchandising leadership for period-over-period analysis and seasonal planning."
  source: "`vibe_retail_v1`.`analytics`.`retail_calendar`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year label for annual rollup and year-over-year comparison."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly performance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month equivalent) for period-level analysis."
    - name: "fiscal_week"
      expr: fiscal_week
      comment: "Fiscal week for weekly operational reporting."
    - name: "season"
      expr: season
      comment: "Retail season (spring, summer, fall, winter) for seasonal performance analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Whether the date is a holiday, used for holiday vs non-holiday performance comparison."
    - name: "is_holiday_shopping_period"
      expr: is_holiday_shopping_period
      comment: "Whether the date falls in the holiday shopping period, critical for seasonal planning."
    - name: "is_black_friday_week"
      expr: is_black_friday_week
      comment: "Whether the date falls in Black Friday week, the highest-volume retail period."
    - name: "is_back_to_school_period"
      expr: is_back_to_school_period
      comment: "Whether the date falls in the back-to-school period for seasonal category planning."
    - name: "is_weekday"
      expr: is_weekday
      comment: "Whether the date is a weekday, used for weekday vs weekend traffic and sales analysis."
    - name: "calendar_date"
      expr: calendar_date
      comment: "Gregorian calendar date for day-level analysis and joining to transactional data."
  measures:
    - name: "total_calendar_days"
      expr: COUNT(1)
      comment: "Total number of calendar days in scope, used as a denominator for daily rate calculations."
    - name: "holiday_day_count"
      expr: COUNT(CASE WHEN is_holiday = TRUE THEN 1 END)
      comment: "Number of holiday days in the period, used for holiday impact analysis."
    - name: "holiday_shopping_period_day_count"
      expr: COUNT(CASE WHEN is_holiday_shopping_period = TRUE THEN 1 END)
      comment: "Number of days in the holiday shopping period, used for seasonal planning and staffing."
    - name: "weekday_count"
      expr: COUNT(CASE WHEN is_weekday = TRUE THEN 1 END)
      comment: "Number of weekdays in the period, used for traffic normalization and staffing models."
    - name: "weekend_day_count"
      expr: COUNT(CASE WHEN is_weekend = TRUE THEN 1 END)
      comment: "Number of weekend days in the period, used for weekend vs weekday performance analysis."
$$;