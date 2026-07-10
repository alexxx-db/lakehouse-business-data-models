-- Metric views for domain: order | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_clinical_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over clinical orders (CPOE) covering order volume, CPOE adoption, verbal order rate, cosign timeliness and cancellation behavior."
  source: "`vibe_healthcare_v1`.`order`.`clinical_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of clinical order (e.g., lab, imaging, medication) for volume segmentation."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (STAT, routine) for turnaround and urgency analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order for completion/cancellation tracking."
    - name: "order_class"
      expr: order_class
      comment: "Order class grouping used for operational segmentation."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_datetime)
      comment: "Order month bucket for trend analysis."
  measures:
    - name: "Total Orders"
      expr: COUNT(1)
      comment: "Total count of clinical orders placed; core throughput baseline for order operations."
    - name: "Distinct Ordered Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients receiving orders; indicates breadth of clinical ordering activity."
    - name: "CPOE Entered Orders"
      expr: COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END)
      comment: "Orders entered via CPOE; numerator for CPOE adoption compliance monitoring."
    - name: "CPOE Adoption Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cpoe_entered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders entered through CPOE; a Meaningful Use / EHR safety KPI leadership tracks."
    - name: "Verbal Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verbal_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders taken verbally; high rates flag safety/compliance risk requiring intervention."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancelled_datetime IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled; elevated rates signal ordering errors or workflow waste."
    - name: "Total Quantity Ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Aggregate quantity ordered; supports utilization and resource demand planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_cpoe_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical decision support alert effectiveness KPIs: alert fire volume, override behavior, acknowledgement and suppression rates for alert fatigue governance."
  source: "`vibe_healthcare_v1`.`order`.`cpoe_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Category of CDS alert (drug-drug, allergy, dose) for effectiveness segmentation."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert for prioritized safety review."
    - name: "alert_priority"
      expr: alert_priority
      comment: "Display priority of the alert for fatigue analysis."
    - name: "alert_source_system"
      expr: alert_source_system
      comment: "Source system generating the alert for integration performance review."
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_fire_timestamp)
      comment: "Month the alert fired for trend monitoring."
  measures:
    - name: "Total Alerts Fired"
      expr: COUNT(1)
      comment: "Total CDS alerts fired; baseline for alert fatigue and safety analysis."
    - name: "Acknowledged Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_acknowledged_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts acknowledged by clinicians; measures CDS engagement and fatigue risk."
    - name: "Suppressed Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_suppressed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts suppressed; high suppression indicates over-alerting to tune out."
    - name: "Override Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_reason_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of alerts overridden; a key alert fatigue and safety governance metric."
    - name: "Distinct Clinicians Alerted"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Unique clinicians receiving CDS alerts; scopes fatigue exposure across the workforce."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization performance KPIs: approval/denial rates, turnaround time, appeal activity and peer-to-peer utilization driving revenue and access outcomes."
  source: "`vibe_healthcare_v1`.`order`.`order_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Outcome status of the authorization for approval/denial reporting."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization request for segmentation by service line."
    - name: "service_category"
      expr: service_category
      comment: "Service category being authorized for payer-mix analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the authorization request for SLA analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_datetime)
      comment: "Month of authorization decision for trend tracking."
  measures:
    - name: "Total Authorizations"
      expr: COUNT(1)
      comment: "Total authorization requests; baseline for revenue-cycle access management."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations approved; directly tied to revenue realization and patient access."
    - name: "Denial Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations denied; denial trends drive payer strategy and appeal staffing."
    - name: "Avg Turnaround Hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average hours to authorization decision; core access-timeliness and patient satisfaction KPI."
    - name: "Peer To Peer Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_to_peer_conducted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations requiring peer-to-peer review; signals administrative burden and denial friction."
    - name: "Appeal Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations appealed; indicates payer disputes and recoverable denied revenue."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order fulfillment operational KPIs: fulfillment volume, partial fulfillment, charge capture, quality exceptions and captured charge amount for throughput and revenue integrity."
  source: "`vibe_healthcare_v1`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the fulfillment for completion analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order being fulfilled for service-line segmentation."
    - name: "method"
      expr: method
      comment: "Fulfillment method for operational routing analysis."
    - name: "performing_department_code"
      expr: performing_department_code
      comment: "Department performing fulfillment for throughput comparison."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of fulfillment for trend monitoring."
  measures:
    - name: "Total Fulfillments"
      expr: COUNT(1)
      comment: "Total fulfillment events; core operational throughput baseline."
    - name: "Partial Fulfillment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partial_fulfillment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders only partially fulfilled; signals supply gaps and patient care delays."
    - name: "Charge Capture Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_capture_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments with charges captured; a revenue-integrity KPI preventing lost charges."
    - name: "Quality Exception Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of fulfillments flagged for quality review; drives quality improvement action."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges captured on fulfillments; ties directly to gross revenue."
    - name: "Total Fulfilled Quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled; supports resource utilization planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order routing operational KPIs: SLA compliance, reroute behavior, transport requirements and workload distribution for throughput optimization."
  source: "`vibe_healthcare_v1`.`order`.`routing`"
  dimensions:
    - name: "routing_status"
      expr: routing_status
      comment: "Current routing status for completion analysis."
    - name: "priority"
      expr: priority
      comment: "Routing priority for SLA and urgency segmentation."
    - name: "method"
      expr: method
      comment: "Routing method for operational channel analysis."
    - name: "queue_name"
      expr: queue_name
      comment: "Destination queue for workload distribution analysis."
    - name: "routing_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of routing for trend monitoring."
  measures:
    - name: "Total Routings"
      expr: COUNT(1)
      comment: "Total routing events; baseline for order-flow operations."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings meeting SLA; core operational performance KPI for leadership dashboards."
    - name: "Transport Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transport_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of routings requiring transport; drives logistics staffing and cost planning."
    - name: "Avg Workload Score"
      expr: AVG(CAST(workload_score AS DOUBLE))
      comment: "Average workload score across routings; informs capacity balancing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_referral_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral management KPIs: referral loop closure, authorization requirements, STAT referral rate and disposition outcomes affecting care continuity and revenue leakage."
  source: "`vibe_healthcare_v1`.`order`.`referral_order`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Status of the referral for pipeline analysis."
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral for specialty segmentation."
    - name: "referral_disposition"
      expr: referral_disposition
      comment: "Final disposition of the referral for outcome tracking."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency of the referral for prioritization analysis."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month referral was placed for trend monitoring."
  measures:
    - name: "Total Referrals"
      expr: COUNT(1)
      comment: "Total referral orders; baseline for care-continuity and network-leakage management."
    - name: "Loop Closure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_loop_closed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals with closed loops; a critical care-coordination quality KPI leadership monitors."
    - name: "STAT Referral Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stat_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals marked STAT; indicates acuity mix and expedited scheduling demand."
    - name: "Authorization Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of referrals requiring authorization; drives prior-auth staffing and delay risk."
    - name: "Distinct Referred Patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients referred; scopes referral demand across the population."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_verbal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Verbal order compliance KPIs: read-back confirmation, authentication timeliness, overdue signatures and controlled substance monitoring for patient safety and regulatory compliance."
  source: "`vibe_healthcare_v1`.`order`.`verbal_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the verbal order for compliance tracking."
    - name: "verbal_order_type"
      expr: verbal_order_type
      comment: "Type of verbal order for segmentation."
    - name: "priority"
      expr: priority
      comment: "Priority of the verbal order for urgency analysis."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule of the ordered substance for controlled-substance oversight."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', order_received_datetime)
      comment: "Month verbal order was received for trend monitoring."
  measures:
    - name: "Total Verbal Orders"
      expr: COUNT(1)
      comment: "Total verbal orders; baseline for safety and Joint Commission compliance monitoring."
    - name: "Read Back Confirmed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN read_back_confirmed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders with read-back confirmed; a mandated patient-safety compliance KPI."
    - name: "Overdue Authentication Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overdue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders overdue for authentication; a regulatory risk KPI triggering escalation."
    - name: "Controlled Substance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN controlled_substance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of verbal orders for controlled substances; drives DEA compliance oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medication reconciliation quality KPIs: completion, discrepancy identification and compliance across care transitions for medication safety."
  source: "`vibe_healthcare_v1`.`order`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation for completion tracking."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation for segmentation."
    - name: "transition_event"
      expr: transition_event
      comment: "Care transition event (admit, discharge, transfer) for transition-of-care analysis."
    - name: "discrepancy_severity"
      expr: discrepancy_severity
      comment: "Severity of identified discrepancies for risk stratification."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of reconciliation for trend monitoring."
  measures:
    - name: "Total Reconciliations"
      expr: COUNT(1)
      comment: "Total medication reconciliation events; baseline for med-safety compliance monitoring."
    - name: "Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations completed; a core transitions-of-care quality KPI leadership tracks."
    - name: "Discrepancy Identified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_identified_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations identifying discrepancies; measures catch-rate of medication errors."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reconciliations meeting compliance standards; a regulatory adherence KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`order_alert_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alert rule governance KPIs: override rate, alert fatigue risk and hard-stop / regulatory rule composition for CDS content management."
  source: "`vibe_healthcare_v1`.`order`.`alert_rule`"
  dimensions:
    - name: "rule_category"
      expr: rule_category
      comment: "Category of the alert rule for content-management segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the rule for prioritized governance."
    - name: "rule_status"
      expr: rule_status
      comment: "Status of the rule (active, retired) for lifecycle tracking."
    - name: "clinical_specialty_scope"
      expr: clinical_specialty_scope
      comment: "Clinical specialty scope of the rule for targeted review."
  measures:
    - name: "Total Alert Rules"
      expr: COUNT(1)
      comment: "Total configured alert rules; baseline for CDS content governance."
    - name: "Avg Override Rate Pct"
      expr: AVG(CAST(override_rate_percent AS DOUBLE))
      comment: "Average override rate across rules; identifies low-value rules to retire for fatigue reduction."
    - name: "Avg Fatigue Risk Score"
      expr: AVG(CAST(alert_fatigue_risk_score AS DOUBLE))
      comment: "Average alert fatigue risk score; steers CDS tuning to reduce clinician burden."
    - name: "Hard Stop Rule Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hard_stop_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of rules configured as hard stops; balances safety enforcement vs workflow disruption."
    - name: "Total Fire Count"
      expr: SUM(CAST(fire_count_total AS DOUBLE))
      comment: "Total lifetime firings across rules; quantifies overall CDS interruption load."
$$;