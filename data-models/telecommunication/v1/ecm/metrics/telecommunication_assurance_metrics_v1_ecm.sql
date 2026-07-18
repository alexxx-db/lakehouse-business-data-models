-- Metric views for domain: assurance | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core alarm activity metrics for operational health monitoring"
  source: "`telecommunication_ecm`.`assurance`.`alarm_event`"
  dimensions:
    - name: "alarm_severity"
      expr: alarm_severity
      comment: "Severity level of the alarm (e.g., Critical, Major, Minor)"
    - name: "alarm_type"
      expr: alarm_type
      comment: "Categorization of the alarm (e.g., Fault, Performance)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the alarm originated"
    - name: "service_affecting_flag"
      expr: service_affecting_flag
      comment: "Indicates if the alarm impacted a service (True/False)"
    - name: "alarm_raised_date"
      expr: DATE_TRUNC('DAY', alarm_raised_timestamp)
      comment: "Date (day) the alarm was raised"
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of alarm events recorded"
    - name: "distinct_affected_service_instances"
      expr: COUNT(DISTINCT svc_instance_id)
      comment: "Number of unique service instances impacted by alarms"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_outage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage performance and financial impact metrics"
  source: "`telecommunication_ecm`.`assurance`.`outage_record`"
  dimensions:
    - name: "outage_severity"
      expr: outage_severity
      comment: "Severity classification of the outage"
    - name: "outage_type"
      expr: outage_type
      comment: "Type of outage (e.g., Planned, Unplanned)"
    - name: "outage_status"
      expr: outage_status
      comment: "Current status of the outage record"
    - name: "outage_start_date"
      expr: DATE_TRUNC('DAY', outage_start_timestamp)
      comment: "Date (day) the outage started"
  measures:
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Cumulative outage duration in minutes across all outages"
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Total estimated revenue impact from outages"
    - name: "outage_count"
      expr: COUNT(1)
      comment: "Number of outage records"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_sla_breach_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach frequency, duration and financial impact"
  source: "`telecommunication_ecm`.`assurance`.`sla_breach_event`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the SLA breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type/category of the breach"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the breach"
    - name: "breach_start_date"
      expr: DATE_TRUNC('DAY', breach_start_timestamp)
      comment: "Date (day) the breach started"
  measures:
    - name: "total_breach_duration_minutes"
      expr: SUM(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Total minutes of SLA breach duration"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Aggregate monetary penalties assessed for SLA breaches"
    - name: "breach_count"
      expr: COUNT(1)
      comment: "Number of SLA breach events"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_performance_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance measurement aggregates for network and service health"
  source: "`telecommunication_ecm`.`assurance`.`performance_measurement`"
  dimensions:
    - name: "measurement_source_system"
      expr: measurement_source_system
      comment: "System that supplied the measurement data"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g., Completed, Pending)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Region where the measurement was taken"
    - name: "network_domain"
      expr: network_domain
      comment: "Network domain (e.g., Access, Core)"
  measures:
    - name: "average_availability_percent"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average availability percentage across measurements"
    - name: "average_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Mean of the measured KPI values"
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Total number of performance measurement records"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`assurance_problem_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Problem management efficiency and volume metrics"
  source: "`telecommunication_ecm`.`assurance`.`problem_record`"
  dimensions:
    - name: "problem_category"
      expr: problem_category
      comment: "High‑level category of the problem"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the problem (e.g., P1, P2)"
    - name: "problem_status"
      expr: problem_status
      comment: "Current status of the problem record"
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date (day) the problem record was created"
  measures:
    - name: "average_investigation_duration_hours"
      expr: AVG(CAST(investigation_duration_hours AS DOUBLE))
      comment: "Average time spent investigating problems"
    - name: "average_resolution_duration_hours"
      expr: AVG(CAST(resolution_duration_hours AS DOUBLE))
      comment: "Average time to resolve problems"
    - name: "problem_record_count"
      expr: COUNT(1)
      comment: "Total number of problem records"
$$;
