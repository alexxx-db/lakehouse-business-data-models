-- Metric views for domain: network | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_alarm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alarm health metrics for operational leadership"
  source: "`telecommunication_ecm`.`network`.`alarm`"
  dimensions:
    - name: "alarm_status"
      expr: alarm_status
      comment: "Current status of the alarm (e.g., Active, Cleared)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the alarm"
    - name: "network_domain"
      expr: network_domain
      comment: "Logical network domain where the alarm originated"
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location tied to the alarm"
    - name: "source_system"
      expr: source_system
      comment: "Originating source system of the alarm"
    - name: "raise_date"
      expr: DATE_TRUNC('day', raise_timestamp)
      comment: "Date the alarm was raised"
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of alarms recorded"
    - name: "critical_alarms"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of alarms with Critical severity"
    - name: "acknowledged_alarms"
      expr: SUM(CASE WHEN acknowledgement_status = 'Acknowledged' THEN 1 ELSE 0 END)
      comment: "Count of alarms that have been acknowledged"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning and utilization metrics"
  source: "`telecommunication_ecm`.`network`.`capacity`"
  dimensions:
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the capacity measurement"
    - name: "network_layer"
      expr: network_layer
      comment: "Network layer (e.g., Access, Core)"
  measures:
    - name: "total_committed_capacity"
      expr: SUM(CAST(committed_capacity AS DOUBLE))
      comment: "Total committed capacity across all elements"
    - name: "total_available_capacity"
      expr: SUM(CAST(available_capacity AS DOUBLE))
      comment: "Total available capacity across all elements"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(average_utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage across capacity records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_circuit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circuit inventory and cost efficiency metrics"
  source: "`telecommunication_ecm`.`network`.`circuit`"
  dimensions:
    - name: "network_zone"
      expr: network_zone
      comment: "Network zone classification"
    - name: "technology"
      expr: technology
      comment: "Underlying technology of the circuit (e.g., Ethernet, MPLS)"
    - name: "status"
      expr: circuit_status
      comment: "Operational status of the circuit"
    - name: "activation_year"
      expr: DATE_TRUNC('year', activation_date)
      comment: "Year the circuit was activated"
  measures:
    - name: "total_capacity_mbps"
      expr: SUM(CAST(capacity_mbps AS DOUBLE))
      comment: "Aggregate capacity of all circuits in Mbps"
    - name: "primary_circuit_count"
      expr: SUM(CASE WHEN is_primary THEN 1 ELSE 0 END)
      comment: "Number of primary circuits"
    - name: "total_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost associated with circuits"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_performance_counter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance counter health and SLA compliance"
  source: "`telecommunication_ecm`.`network`.`performance_counter`"
  dimensions:
    - name: "kpi_name"
      expr: kpi_name
      comment: "Name of the KPI being measured"
    - name: "network_layer"
      expr: network_layer
      comment: "Network layer associated with the KPI"
    - name: "geographic_region_code"
      expr: geographic_region_code
      comment: "Region code for the measurement"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the performance measurement"
  measures:
    - name: "total_counter_value"
      expr: SUM(CAST(counter_value AS DOUBLE))
      comment: "Sum of raw counter values for the selected KPI"
    - name: "avg_kpi_value"
      expr: AVG(CAST(kpi_value AS DOUBLE))
      comment: "Average KPI value across measurement intervals"
    - name: "breach_count"
      expr: SUM(CASE WHEN breach_severity IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of times the KPI breached its defined severity"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`network_transmission_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmission link performance and capacity overview"
  source: "`telecommunication_ecm`.`network`.`transmission_link`"
  dimensions:
    - name: "vendor"
      expr: vendor
      comment: "Vendor supplying the transmission link"
    - name: "link_type"
      expr: link_type
      comment: "Physical or logical type of the link"
    - name: "geographic_route_description"
      expr: geographic_route_description
      comment: "Human readable description of the link route"
    - name: "link_status"
      expr: link_status
      comment: "Current operational status of the link"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the link record was created"
  measures:
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average utilization percentage of transmission links"
    - name: "total_capacity"
      expr: SUM(CAST(capacity_value AS DOUBLE))
      comment: "Total capacity (in whatever unit) of all transmission links"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average latency across links in milliseconds"
$$;
