-- Metric views for domain: order | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order fulfillment performance metrics"
  source: "`telecommunication_ecm`.`order`.`fulfillment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_type"
      expr: order_type
      comment: "Business type of the order (e.g., new, upgrade)"
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed"
    - name: "order_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the order was created"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_timestamp, created_timestamp))
      comment: "Average number of days from order creation to actual completion"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and discount metrics at the line-item level"
  source: "`telecommunication_ecm`.`order`.`line`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of product offered"
    - name: "service_type"
      expr: service_type
      comment: "Service category for the line"
    - name: "technology_type"
      expr: technology_type
      comment: "Underlying technology (e.g., LTE, Fiber)"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the line item"
    - name: "line_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the line item was created"
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net revenue from order lines"
    - name: "average_line_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per line item"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across lines"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance and performance metrics"
  source: "`telecommunication_ecm`.`order`.`sla`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., Service, Installation)"
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA"
    - name: "service_type"
      expr: service_type
      comment: "Service category the SLA applies to"
    - name: "sla_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the SLA record was created"
  measures:
    - name: "total_sla_records"
      expr: COUNT(1)
      comment: "Total number of SLA records"
    - name: "average_elapsed_hours"
      expr: AVG(CAST(elapsed_hours AS DOUBLE))
      comment: "Average elapsed hours for SLA fulfillment"
    - name: "average_breach_threshold_hours"
      expr: AVG(CAST(breach_threshold_hours AS DOUBLE))
      comment: "Average breach threshold hours defined in SLA"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_provisioning_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provisioning request throughput and success metrics"
  source: "`telecommunication_ecm`.`order`.`provisioning_request`"
  dimensions:
    - name: "provisioning_action"
      expr: provisioning_action
      comment: "Action taken during provisioning (e.g., Activate, Deactivate)"
    - name: "service_type"
      expr: service_type
      comment: "Service type being provisioned"
    - name: "element_id"
      expr: element_id
      comment: "Identifier of the network element involved"
    - name: "request_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the provisioning request was created"
  measures:
    - name: "total_provisioning_requests"
      expr: COUNT(1)
      comment: "Total number of provisioning requests"
    - name: "successful_provisioning_requests"
      expr: SUM(CASE WHEN request_status = 'Success' THEN 1 ELSE 0 END)
      comment: "Number of provisioning requests that completed successfully"
    - name: "average_provisioning_days"
      expr: AVG(DATEDIFF(completion_timestamp, created_timestamp))
      comment: "Average days from request creation to completion"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_fallout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fallout incident volume and resolution performance"
  source: "`telecommunication_ecm`.`order`.`fallout`"
  dimensions:
    - name: "fallout_category"
      expr: fallout_category
      comment: "Category of fallout (e.g., Critical, Minor)"
    - name: "fallout_status"
      expr: fallout_status
      comment: "Current status of the fallout incident"
    - name: "source_system"
      expr: source_system
      comment: "Originating system for the fallout record"
    - name: "fallout_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the fallout was recorded"
  measures:
    - name: "total_fallout_count"
      expr: COUNT(1)
      comment: "Total number of fallout incidents"
    - name: "critical_fallout_count"
      expr: SUM(CASE WHEN fallout_category = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of fallout incidents classified as Critical"
    - name: "average_resolution_days"
      expr: AVG(DATEDIFF(resolved_timestamp, created_timestamp))
      comment: "Average days to resolve fallout incidents"
$$;
