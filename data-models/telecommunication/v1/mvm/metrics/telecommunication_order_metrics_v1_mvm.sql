-- Metric views for domain: order | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_fulfillment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order fulfillment metrics tracking order volume, cycle time, SLA performance, and operational efficiency across channels and service types"
  source: "`telecommunication_ecm`.`order`.`fulfillment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the fulfillment order (e.g., submitted, in-progress, completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., new activation, upgrade, change, disconnect)"
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed (e.g., web, retail, telesales, partner)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being ordered (e.g., mobile, broadband, fiber, enterprise)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order (e.g., standard, high, urgent)"
    - name: "sla_status"
      expr: sla_status
      comment: "SLA compliance status (e.g., on-track, at-risk, breached)"
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Result of credit check process (e.g., passed, failed, manual-review)"
    - name: "field_work_required"
      expr: field_work_required
      comment: "Whether the order requires field technician visit (True/False)"
    - name: "is_regulatory_order"
      expr: is_regulatory_order
      comment: "Whether the order is subject to regulatory requirements (True/False)"
    - name: "submitted_year_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Year-month when the order was submitted"
    - name: "promised_completion_year_month"
      expr: DATE_TRUNC('month', promised_completion_date)
      comment: "Year-month of promised completion date"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of fulfillment orders"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts placing orders"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across orders"
    - name: "total_sla_breach_hours"
      expr: SUM(CAST(sla_breach_threshold_hours AS DOUBLE))
      comment: "Total SLA breach threshold hours across all orders"
    - name: "orders_with_sla_breach"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_timestamp IS NOT NULL THEN fulfillment_order_id END)
      comment: "Count of orders that experienced an SLA breach"
    - name: "orders_requiring_field_work"
      expr: COUNT(DISTINCT CASE WHEN field_work_required = true THEN fulfillment_order_id END)
      comment: "Count of orders requiring field technician visits"
    - name: "regulatory_orders"
      expr: COUNT(DISTINCT CASE WHEN is_regulatory_order = true THEN fulfillment_order_id END)
      comment: "Count of orders subject to regulatory requirements"
    - name: "completed_orders"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_timestamp IS NOT NULL THEN fulfillment_order_id END)
      comment: "Count of orders that have been completed"
    - name: "cancelled_orders"
      expr: COUNT(DISTINCT CASE WHEN cancellation_timestamp IS NOT NULL THEN fulfillment_order_id END)
      comment: "Count of orders that were cancelled"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level revenue, pricing, and product mix metrics for financial and commercial analysis"
  source: "`telecommunication_ecm`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., pending, active, completed, failed)"
    - name: "action_code"
      expr: action_code
      comment: "Action being performed on the line (e.g., add, modify, disconnect)"
    - name: "product_type"
      expr: product_type
      comment: "Type of product on the line (e.g., device, service, addon)"
    - name: "service_type"
      expr: service_type
      comment: "Service type for the line (e.g., mobile, broadband, voice)"
    - name: "technology_type"
      expr: technology_type
      comment: "Technology used (e.g., 4G, 5G, fiber, copper)"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel code for the line"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the line is priced"
    - name: "is_mnp_line"
      expr: is_mnp_line
      comment: "Whether the line involves mobile number portability (True/False)"
    - name: "is_esim"
      expr: is_esim
      comment: "Whether the line uses eSIM technology (True/False)"
    - name: "requires_field_visit"
      expr: requires_field_visit
      comment: "Whether the line requires field technician visit (True/False)"
    - name: "requested_start_year_month"
      expr: DATE_TRUNC('month', requested_start_date)
      comment: "Year-month of requested service start date"
  measures:
    - name: "total_lines"
      expr: COUNT(1)
      comment: "Total number of order lines"
    - name: "total_gross_revenue"
      expr: SUM(CAST(unit_price AS DOUBLE))
      comment: "Total gross revenue from unit prices across all lines"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all lines"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net revenue after discounts across all lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per order line"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line after discounts"
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees across all lines"
    - name: "mnp_lines"
      expr: COUNT(DISTINCT CASE WHEN is_mnp_line = true THEN line_id END)
      comment: "Count of lines involving mobile number portability"
    - name: "esim_lines"
      expr: COUNT(DISTINCT CASE WHEN is_esim = true THEN line_id END)
      comment: "Count of lines using eSIM technology"
    - name: "lines_requiring_field_visit"
      expr: COUNT(DISTINCT CASE WHEN requires_field_visit = true THEN line_id END)
      comment: "Count of lines requiring field technician visits"
    - name: "unique_fulfillment_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders containing these lines"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial charges and revenue recognition metrics for order-related billing events"
  source: "`telecommunication_ecm`.`order`.`order_charge`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (e.g., activation, installation, monthly-recurring, one-time)"
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge (e.g., service, equipment, penalty, credit)"
    - name: "charge_status"
      expr: charge_status
      comment: "Status of the charge (e.g., pending, approved, billed, reversed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the charge is denominated"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel associated with the charge"
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category applied to the charge"
    - name: "is_prorated"
      expr: is_prorated
      comment: "Whether the charge is prorated (True/False)"
    - name: "trigger_event"
      expr: trigger_event
      comment: "Event that triggered the charge (e.g., order-submit, service-activation, contract-renewal)"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for revenue recognition"
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Year-month when the charge becomes effective"
    - name: "revenue_recognition_year_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Year-month for revenue recognition"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of order charges"
    - name: "total_charge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross charge amount before discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to charges"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on charges"
    - name: "avg_charge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average charge amount per charge record"
    - name: "approved_charges"
      expr: COUNT(DISTINCT CASE WHEN approval_timestamp IS NOT NULL THEN order_charge_id END)
      comment: "Count of charges that have been approved"
    - name: "billed_charges"
      expr: COUNT(DISTINCT CASE WHEN billed_timestamp IS NOT NULL THEN order_charge_id END)
      comment: "Count of charges that have been billed"
    - name: "reversed_charges"
      expr: COUNT(DISTINCT CASE WHEN reversal_timestamp IS NOT NULL THEN order_charge_id END)
      comment: "Count of charges that have been reversed"
    - name: "prorated_charges"
      expr: COUNT(DISTINCT CASE WHEN is_prorated = true THEN order_charge_id END)
      comment: "Count of charges that are prorated"
    - name: "unique_fulfillment_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders associated with charges"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_fallout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fallout and exception management metrics tracking failure rates, resolution efficiency, and root cause analysis"
  source: "`telecommunication_ecm`.`order`.`fallout`"
  dimensions:
    - name: "fallout_status"
      expr: fallout_status
      comment: "Current status of the fallout (e.g., open, in-progress, resolved, escalated)"
    - name: "fallout_category"
      expr: fallout_category
      comment: "Category of fallout (e.g., technical, credit, inventory, validation)"
    - name: "sub_category"
      expr: sub_category
      comment: "Sub-category providing more granular classification"
    - name: "failing_system"
      expr: failing_system
      comment: "System that generated the fallout"
    - name: "error_code"
      expr: error_code
      comment: "Error code associated with the fallout"
    - name: "priority"
      expr: priority
      comment: "Priority level of the fallout (e.g., low, medium, high, critical)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level (e.g., L1, L2, L3, management)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the order was placed"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment (e.g., consumer, SMB, enterprise)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "auto_resolution_eligible"
      expr: auto_resolution_eligible
      comment: "Whether the fallout is eligible for automated resolution (True/False)"
    - name: "sla_breached"
      expr: sla_breached
      comment: "Whether the fallout resolution breached SLA (True/False)"
    - name: "detected_year_month"
      expr: DATE_TRUNC('month', detected_timestamp)
      comment: "Year-month when the fallout was detected"
  measures:
    - name: "total_fallouts"
      expr: COUNT(1)
      comment: "Total number of order fallouts"
    - name: "unique_affected_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders affected by fallouts"
    - name: "unique_affected_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers affected by fallouts"
    - name: "resolved_fallouts"
      expr: COUNT(DISTINCT CASE WHEN resolved_timestamp IS NOT NULL THEN fallout_id END)
      comment: "Count of fallouts that have been resolved"
    - name: "escalated_fallouts"
      expr: COUNT(DISTINCT CASE WHEN escalated_timestamp IS NOT NULL THEN fallout_id END)
      comment: "Count of fallouts that have been escalated"
    - name: "sla_breached_fallouts"
      expr: COUNT(DISTINCT CASE WHEN sla_breached = true THEN fallout_id END)
      comment: "Count of fallouts that breached resolution SLA"
    - name: "auto_resolution_eligible_fallouts"
      expr: COUNT(DISTINCT CASE WHEN auto_resolution_eligible = true THEN fallout_id END)
      comment: "Count of fallouts eligible for automated resolution"
    - name: "resubmitted_fallouts"
      expr: COUNT(DISTINCT CASE WHEN resubmission_timestamp IS NOT NULL THEN fallout_id END)
      comment: "Count of fallouts that were resubmitted"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retry attempts per fallout"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance and compliance metrics tracking target achievement, breach rates, and penalty exposure"
  source: "`telecommunication_ecm`.`order`.`sla`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current SLA status (e.g., on-track, at-risk, breached, completed)"
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., order-fulfillment, provisioning, repair, installation)"
    - name: "sla_category"
      expr: sla_category
      comment: "Category of SLA (e.g., operational, regulatory, contractual)"
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the SLA"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment (e.g., consumer, SMB, enterprise)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the SLA (e.g., standard, high, critical)"
    - name: "calendar_type"
      expr: calendar_type
      comment: "Calendar type for SLA measurement (e.g., business-days, calendar-days, 24x7)"
    - name: "penalty_applicable"
      expr: penalty_applicable
      comment: "Whether financial penalty applies for breach (True/False)"
    - name: "breach_notification_sent"
      expr: breach_notification_sent
      comment: "Whether breach notification was sent (True/False)"
    - name: "clock_suspended"
      expr: clock_suspended
      comment: "Whether SLA clock is currently suspended (True/False)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the SLA (if applicable)"
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Year-month when the SLA became effective"
  measures:
    - name: "total_slas"
      expr: COUNT(1)
      comment: "Total number of SLA records"
    - name: "unique_fulfillment_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders with SLA tracking"
    - name: "breached_slas"
      expr: COUNT(DISTINCT CASE WHEN breach_timestamp IS NOT NULL THEN sla_id END)
      comment: "Count of SLAs that have been breached"
    - name: "completed_slas"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_timestamp IS NOT NULL THEN sla_id END)
      comment: "Count of SLAs that have been completed"
    - name: "slas_with_penalty"
      expr: COUNT(DISTINCT CASE WHEN penalty_applicable = true THEN sla_id END)
      comment: "Count of SLAs where penalty is applicable"
    - name: "total_penalty_credit_amount"
      expr: SUM(CAST(penalty_credit_amount AS DOUBLE))
      comment: "Total penalty credit amount across all SLAs"
    - name: "avg_target_completion_hours"
      expr: AVG(CAST(target_completion_hours AS DOUBLE))
      comment: "Average target completion hours across SLAs"
    - name: "avg_elapsed_hours"
      expr: AVG(CAST(elapsed_hours AS DOUBLE))
      comment: "Average elapsed hours across SLAs"
    - name: "total_suspended_hours"
      expr: SUM(CAST(total_suspended_hours AS DOUBLE))
      comment: "Total hours SLA clocks were suspended"
    - name: "avg_breach_threshold_hours"
      expr: AVG(CAST(breach_threshold_hours AS DOUBLE))
      comment: "Average breach threshold hours across SLAs"
    - name: "breach_notifications_sent"
      expr: COUNT(DISTINCT CASE WHEN breach_notification_sent = true THEN sla_id END)
      comment: "Count of SLAs where breach notification was sent"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field appointment scheduling and execution metrics tracking on-time performance, technician utilization, and customer experience"
  source: "`telecommunication_ecm`.`order`.`appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (e.g., scheduled, confirmed, in-progress, completed, missed)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (e.g., installation, repair, upgrade, survey)"
    - name: "service_type"
      expr: service_type
      comment: "Service type for the appointment"
    - name: "technology_type"
      expr: technology_type
      comment: "Technology type involved (e.g., fiber, copper, wireless)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the appointment"
    - name: "customer_confirmed"
      expr: customer_confirmed
      comment: "Whether customer confirmed the appointment (True/False)"
    - name: "sla_commitment_met"
      expr: sla_commitment_met
      comment: "Whether SLA commitment was met (True/False)"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up appointment is required (True/False)"
    - name: "confirmation_channel"
      expr: confirmation_channel
      comment: "Channel used for appointment confirmation (e.g., SMS, email, call)"
    - name: "scheduled_year_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Year-month of scheduled appointment date"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointments"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with appointments"
    - name: "unique_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of unique technicians assigned to appointments"
    - name: "completed_appointments"
      expr: COUNT(DISTINCT CASE WHEN actual_completion_time IS NOT NULL THEN appointment_id END)
      comment: "Count of appointments that have been completed"
    - name: "confirmed_appointments"
      expr: COUNT(DISTINCT CASE WHEN customer_confirmed = true THEN appointment_id END)
      comment: "Count of appointments confirmed by customer"
    - name: "sla_met_appointments"
      expr: COUNT(DISTINCT CASE WHEN sla_commitment_met = true THEN appointment_id END)
      comment: "Count of appointments where SLA commitment was met"
    - name: "missed_appointments"
      expr: COUNT(DISTINCT CASE WHEN missed_reason IS NOT NULL THEN appointment_id END)
      comment: "Count of appointments that were missed"
    - name: "follow_up_required_appointments"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = true THEN appointment_id END)
      comment: "Count of appointments requiring follow-up"
    - name: "avg_estimated_duration_minutes"
      expr: AVG(CAST(estimated_duration_minutes AS DOUBLE))
      comment: "Average estimated duration in minutes per appointment"
    - name: "avg_reschedule_count"
      expr: AVG(CAST(reschedule_count AS DOUBLE))
      comment: "Average number of reschedules per appointment"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order task execution and workflow orchestration metrics tracking task completion, automation rates, and system integration health"
  source: "`telecommunication_ecm`.`order`.`task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g., pending, in-progress, completed, failed)"
    - name: "task_type"
      expr: task_type
      comment: "Type of task (e.g., provisioning, validation, notification, billing)"
    - name: "order_action_type"
      expr: order_action_type
      comment: "Order action type (e.g., add, modify, disconnect)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the task"
    - name: "automation_indicator"
      expr: automation_indicator
      comment: "Whether the task is automated (True/False)"
    - name: "fallout_indicator"
      expr: fallout_indicator
      comment: "Whether the task resulted in fallout (True/False)"
    - name: "sla_breach_indicator"
      expr: sla_breach_indicator
      comment: "Whether the task breached SLA (True/False)"
    - name: "child_system_target"
      expr: child_system_target
      comment: "Target system for task execution"
    - name: "network_technology"
      expr: network_technology
      comment: "Network technology involved (e.g., 4G, 5G, fiber)"
    - name: "sync_status"
      expr: sync_status
      comment: "Synchronization status with downstream systems"
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification level (e.g., public, internal, confidential)"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of order tasks"
    - name: "unique_fulfillment_orders"
      expr: COUNT(DISTINCT fulfillment_order_id)
      comment: "Number of unique fulfillment orders with tasks"
    - name: "completed_tasks"
      expr: COUNT(DISTINCT CASE WHEN completion_time IS NOT NULL THEN task_id END)
      comment: "Count of tasks that have been completed"
    - name: "automated_tasks"
      expr: COUNT(DISTINCT CASE WHEN automation_indicator = true THEN task_id END)
      comment: "Count of tasks that are automated"
    - name: "fallout_tasks"
      expr: COUNT(DISTINCT CASE WHEN fallout_indicator = true THEN task_id END)
      comment: "Count of tasks that resulted in fallout"
    - name: "sla_breached_tasks"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_indicator = true THEN task_id END)
      comment: "Count of tasks that breached SLA"
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average execution duration in seconds per task"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retry attempts per task"
    - name: "unique_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Number of unique technicians assigned to tasks"
$$;


CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`order_service_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service availability and qualification metrics tracking coverage, eligibility, and infrastructure readiness for sales and network planning"
  source: "`telecommunication_ecm`.`order`.`service_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification (e.g., pending, qualified, not-qualified, expired)"
    - name: "qualification_outcome"
      expr: qualification_outcome
      comment: "Outcome of the qualification (e.g., serviceable, not-serviceable, conditional)"
    - name: "requested_service_type"
      expr: requested_service_type
      comment: "Service type requested for qualification"
    - name: "infrastructure_readiness"
      expr: infrastructure_readiness
      comment: "Infrastructure readiness status (e.g., ready, build-required, planned)"
    - name: "qualification_channel"
      expr: qualification_channel
      comment: "Channel through which qualification was requested"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the service address"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the service address"
    - name: "regulatory_zone_code"
      expr: regulatory_zone_code
      comment: "Regulatory zone code"
    - name: "field_survey_required"
      expr: field_survey_required
      comment: "Whether field survey is required (True/False)"
    - name: "cpe_required"
      expr: cpe_required
      comment: "Whether customer premises equipment is required (True/False)"
    - name: "mnp_applicable"
      expr: mnp_applicable
      comment: "Whether mobile number portability is applicable (True/False)"
    - name: "broadband_subsidy_eligible"
      expr: broadband_subsidy_eligible
      comment: "Whether address is eligible for broadband subsidy (True/False)"
    - name: "requalification_required"
      expr: requalification_required
      comment: "Whether requalification is required (True/False)"
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of service qualification requests"
    - name: "unique_addresses"
      expr: COUNT(DISTINCT address_id)
      comment: "Number of unique addresses qualified"
    - name: "unique_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers requesting qualification"
    - name: "qualified_addresses"
      expr: COUNT(DISTINCT CASE WHEN qualification_outcome = 'serviceable' THEN service_qualification_id END)
      comment: "Count of addresses that qualified as serviceable"
    - name: "not_qualified_addresses"
      expr: COUNT(DISTINCT CASE WHEN qualification_outcome = 'not-serviceable' THEN service_qualification_id END)
      comment: "Count of addresses that did not qualify"
    - name: "field_survey_required_count"
      expr: COUNT(DISTINCT CASE WHEN field_survey_required = true THEN service_qualification_id END)
      comment: "Count of qualifications requiring field survey"
    - name: "broadband_subsidy_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN broadband_subsidy_eligible = true THEN service_qualification_id END)
      comment: "Count of addresses eligible for broadband subsidy"
    - name: "avg_max_download_speed_mbps"
      expr: AVG(CAST(max_download_speed_mbps AS DOUBLE))
      comment: "Average maximum download speed in Mbps across qualified addresses"
    - name: "avg_max_upload_speed_mbps"
      expr: AVG(CAST(max_upload_speed_mbps AS DOUBLE))
      comment: "Average maximum upload speed in Mbps across qualified addresses"
    - name: "avg_estimated_installation_lead_time_days"
      expr: AVG(CAST(estimated_installation_lead_time_days AS DOUBLE))
      comment: "Average estimated installation lead time in days"
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm for wireless qualifications"
$$;
