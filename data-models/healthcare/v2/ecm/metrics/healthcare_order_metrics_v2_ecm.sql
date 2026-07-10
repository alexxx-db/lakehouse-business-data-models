-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core CPOE clinical order metrics for volume, order-set adoption, cosignature compliance, and cancellation monitoring across the order-to-fulfillment lifecycle."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Lifecycle status of the clinical order (active, completed, cancelled, etc.) used to segment throughput and backlog."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (routine, stat, urgent) for prioritization and SLA analysis."
    - name: "order_type"
      expr: order_type
      comment: "Clinical order type (lab, medication, imaging) for order-mix analysis."
    - name: "order_class"
      expr: order_class
      comment: "Order class classification for governance and routing segmentation."
    - name: "order_mode"
      expr: order_mode
      comment: "Order entry mode (electronic, verbal, written) for CPOE quality analysis."
    - name: "order_day"
      expr: DATE_TRUNC('DAY', order_datetime)
      comment: "Order date bucket for daily/period trend analysis of order volume."
  measures:
    - name: "Total Clinical Orders"
      expr: COUNT(1)
      comment: "Total number of clinical orders placed; baseline throughput volume for capacity and demand planning."
    - name: "Distinct Ordered Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with clinical orders; indicates breadth of ordering activity across the patient population."
    - name: "CPOE Entered Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders entered via CPOE; a meaningful-use and patient-safety quality KPI leadership tracks for digital adoption."
    - name: "Verbal Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders taken as verbal orders; high rates indicate compliance/safety risk warranting intervention."
    - name: "Order Set Adoption Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_order_set_member = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders placed as part of an evidence-based order set; measures standardization of care."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled; elevated cancellation signals workflow rework and waste to investigate."
    - name: "Total Quantity Ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Sum of quantities ordered; drives supply, dosing, and resource demand forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization performance metrics covering approval rates, denial rates, appeal activity, and turnaround time for revenue-cycle and payer management."
  source: "`vibe_healthcare_v1`.`order`.`order_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the authorization request (approved, denied, pending) for payer performance segmentation."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization requested for service-line analysis."
    - name: "service_category"
      expr: service_category
      comment: "Clinical service category for identifying high-denial service lines."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal for denial-management workflow tracking."
    - name: "priority"
      expr: priority
      comment: "Authorization request priority for SLA and urgency segmentation."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_datetime)
      comment: "Month of authorization request for trend analysis of authorization volume and outcomes."
  measures:
    - name: "Total Authorization Requests"
      expr: COUNT(1)
      comment: "Total prior authorization requests; baseline workload for the authorization team."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations approved; a core revenue-cycle KPI signaling payer friction and denial risk."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations denied; drives denial-management staffing and payer negotiation decisions."
    - name: "Appeal Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations that entered appeal; indicates administrative burden and payer dispute volume."
    - name: "Peer To Peer Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases requiring peer-to-peer review; a measure of clinical escalation and physician time cost."
    - name: "Avg Turnaround Time Hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average hours to authorization decision; a service-level KPI affecting patient access and care delays."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment operational metrics covering charge capture, partial fulfillment, quality holds, and charge amount for revenue integrity and operations."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the fulfillment event for operational throughput monitoring."
    - name: "method"
      expr: method
      comment: "Fulfillment method for operational channel analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled for service-mix analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the fulfillment for SLA and urgency segmentation."
    - name: "fulfillment_day"
      expr: DATE_TRUNC('DAY', datetime)
      comment: "Fulfillment date bucket for daily operational trend analysis."
  measures:
    - name: "Total Fulfillments"
      expr: COUNT(1)
      comment: "Total fulfillment events; baseline operational volume for throughput and staffing decisions."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount captured through fulfillment; direct revenue-cycle input for financial steering."
    - name: "Charge Capture Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_capture_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments with charge captured; a revenue-integrity KPI directly tied to lost revenue."
    - name: "Partial Fulfillment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments delivered partially; signals supply or capacity shortfalls to investigate."
    - name: "Quality Hold Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments flagged for quality review; a quality-assurance KPI driving process improvement."
    - name: "Total Fulfilled Quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled; supports throughput and supply utilization analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_cpoe_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical decision support alert metrics measuring alert firing, acknowledgment, override behavior, and suppression to manage alert fatigue and patient safety."
  source: "`vibe_healthcare_v1`.`order`.`cpoe_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of CDS alert (drug interaction, allergy, dose) for safety-signal segmentation."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert for risk-stratified analysis."
    - name: "alert_priority"
      expr: alert_priority
      comment: "Priority of the alert for triage and fatigue analysis."
    - name: "alert_source_system"
      expr: alert_source_system
      comment: "Source system generating the alert for integration quality analysis."
    - name: "alert_fire_day"
      expr: DATE_TRUNC('DAY', alert_fire_timestamp)
      comment: "Date the alert fired for daily alert-volume trend analysis."
  measures:
    - name: "Total Alerts Fired"
      expr: COUNT(1)
      comment: "Total CDS alerts fired; baseline for alert-fatigue and safety monitoring."
    - name: "Override Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_reason_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts overridden; a key patient-safety KPI where high override signals alert fatigue and dismissal risk."
    - name: "Acknowledgment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_acknowledged_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts acknowledged by clinicians; measures engagement with decision support."
    - name: "Suppression Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_suppressed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts suppressed; informs CDS rule tuning to reduce noise and improve relevance."
    - name: "Distinct Alerted Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients triggering alerts; indicates breadth of safety-signal exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral order metrics measuring referral loop closure, authorization requirements, and stat-referral volume for care-coordination and network integrity."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the referral order for pipeline and backlog monitoring."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral for specialty-mix and network analysis."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Disposition of the referral for outcome and completion analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the referral for access and SLA segmentation."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the referral was placed for trend analysis of referral volume."
  measures:
    - name: "Total Referral Orders"
      expr: COUNT(1)
      comment: "Total referral orders placed; baseline for care-coordination workload and network demand."
    - name: "Referral Loop Closure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_loop_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals with closed loops; a critical care-coordination and quality KPI tied to patient safety and continuity."
    - name: "Authorization Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals requiring authorization; drives prior-auth staffing and payer friction analysis."
    - name: "Stat Referral Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of stat referrals; indicates urgent-access demand affecting scheduling capacity."
    - name: "Distinct Referred Patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients referred; measures breadth of external care coordination."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication reconciliation metrics measuring completion, compliance, and discrepancy detection at care transitions for patient-safety and regulatory compliance."
  source: "`vibe_healthcare_v1`.`order`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation for completion tracking."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation for care-transition segmentation."
    - name: "transition_event"
      expr: transition_event
      comment: "Care transition event (admission, transfer, discharge) triggering reconciliation."
    - name: "discrepancy_severity"
      expr: discrepancy_severity
      comment: "Severity of any identified discrepancy for risk-stratified safety analysis."
    - name: "reconciliation_day"
      expr: DATE_TRUNC('DAY', datetime)
      comment: "Date of reconciliation for daily compliance-trend analysis."
  measures:
    - name: "Total Reconciliations"
      expr: COUNT(1)
      comment: "Total medication reconciliations performed; baseline for care-transition safety workload."
    - name: "Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations completed; a regulatory and Joint Commission quality KPI."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations meeting compliance standards; directly ties to regulatory risk."
    - name: "Discrepancy Detection Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_identified_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations that identified a discrepancy; measures safety-net effectiveness of the reconciliation process."
    - name: "Avg Duration Minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average reconciliation duration; informs clinical-time cost and workflow efficiency. Note: duration_minutes stored as STRING and cast for aggregation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order routing operational metrics measuring SLA compliance, rerouting, and auto-routing to steer throughput and turnaround performance."
  source: "`vibe_healthcare_v1`.`order`.`order_routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Status of the routing event for queue and backlog monitoring."
    - name: "routing_method"
      expr: routing_method
      comment: "Routing method (auto, manual) for automation-efficiency analysis."
    - name: "priority"
      expr: priority
      comment: "Routing priority for SLA and urgency segmentation."
    - name: "queue_name"
      expr: queue_name
      comment: "Destination queue for workload-balancing analysis."
    - name: "routing_day"
      expr: DATE_TRUNC('DAY', datetime)
      comment: "Date of routing event for daily throughput trend analysis."
  measures:
    - name: "Total Routing Events"
      expr: COUNT(1)
      comment: "Total order routing events; baseline for operational throughput and queue-load analysis."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings meeting SLA targets; a core operations KPI driving process and staffing intervention."
    - name: "Auto Route Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_route_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings eligible for automation; measures opportunity for reducing manual routing effort."
    - name: "Avg Workload Score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average routing workload score; informs capacity balancing across queues and departments."
    - name: "Avg Delay Minutes"
      expr: AVG(CAST(delay_minutes AS DOUBLE))
      comment: "Average routing delay in minutes; a turnaround KPI. Note: delay_minutes stored as STRING and cast for aggregation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_therapy_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapy order metrics tracking session completion and recurring therapy volume for rehabilitation and therapy-service capacity management."
  source: "`vibe_healthcare_v1`.`order`.`therapy_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the therapy order for pipeline monitoring."
    - name: "therapy_type"
      expr: therapy_type
      comment: "Type of therapy for service-line mix analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the therapy order for access and scheduling segmentation."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Month the therapy order was placed for volume-trend analysis."
  measures:
    - name: "Total Therapy Orders"
      expr: COUNT(1)
      comment: "Total therapy orders placed; baseline demand for therapy-service capacity planning."
    - name: "Recurring Therapy Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recurring = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of therapy orders that are recurring; drives longitudinal capacity and staffing planning."
    - name: "Total Sessions Completed"
      expr: SUM(CAST(sessions_completed AS DOUBLE))
      comment: "Total therapy sessions completed; throughput measure for utilization. Note: sessions_completed stored as STRING and cast for aggregation."
    - name: "Total Sessions Remaining"
      expr: SUM(CAST(sessions_remaining AS DOUBLE))
      comment: "Total therapy sessions remaining; forward-looking demand backlog for capacity planning. Note: sessions_remaining stored as STRING and cast for aggregation."
$$;