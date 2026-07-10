-- Metric views for domain: radiology | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging order operations KPIs: volume, STAT mix, cancellations, prior-auth, and critical-finding rates. Steers radiology throughput and access."
  source: "`vibe_healthcare_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (CT, MR, XR, US, etc.) for capacity and mix analysis."
    - name: "order_priority"
      expr: order_priority
      comment: "Order priority (routine, STAT, urgent) for turnaround SLA analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current order status for pipeline monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Origin of order (ED, inpatient, outpatient) for demand steering."
    - name: "prior_auth_status"
      expr: prior_auth_status
      comment: "Prior authorization status for revenue-risk monitoring."
    - name: "referring_department"
      expr: referring_department
      comment: "Referring department for demand attribution."
    - name: "body_part"
      expr: body_part
      comment: "Body part imaged for service-line mix analysis."
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month bucket of order placement for trending."
  measures:
    - name: "Order Volume"
      expr: COUNT(1)
      comment: "Total imaging orders placed; core demand/throughput measure."
    - name: "Distinct Ordered Studies"
      expr: COUNT(DISTINCT imaging_order_id)
      comment: "Distinct imaging orders for deduplicated volume."
    - name: "STAT Order Count"
      expr: SUM(CASE WHEN order_priority = 'STAT' THEN 1 ELSE 0 END)
      comment: "Count of STAT orders; indicates urgent workload burden."
    - name: "STAT Order Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_priority = 'STAT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders that are STAT; high values strain urgent capacity."
    - name: "Cancellation Count"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Cancelled orders; wasted scheduling capacity."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders cancelled; access and scheduling efficiency signal."
    - name: "Prior Auth Denial Count"
      expr: SUM(CASE WHEN prior_auth_status = 'Denied' THEN 1 ELSE 0 END)
      comment: "Orders with denied prior authorization; revenue-at-risk driver."
    - name: "Critical Finding Order Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders flagged with critical findings; clinical acuity signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Study-level KPIs for throughput, contrast utilization, radiation dose, and report finalization. Steers operational efficiency and safety."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_study`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality of the study for capacity and dose analysis."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomy examined for service-line mix."
    - name: "study_status"
      expr: study_status
      comment: "Study lifecycle status for pipeline monitoring."
    - name: "report_status"
      expr: report_status
      comment: "Report status for reporting-backlog analysis."
    - name: "pacs_status"
      expr: pacs_status
      comment: "PACS archive status for image availability tracking."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for volume trending."
  measures:
    - name: "Study Volume"
      expr: COUNT(1)
      comment: "Total imaging studies performed; core productivity measure."
    - name: "Contrast Study Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_administered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of studies using contrast; drives supply cost and safety monitoring."
    - name: "Critical Finding Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of studies with critical findings; clinical acuity and notification-load signal."
    - name: "Avg CTDI Vol Dose mGy"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CTDIvol radiation dose; patient safety and dose-optimization KPI."
    - name: "Avg DLP Dose mGy cm"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average dose-length-product; radiation safety monitoring."
    - name: "Finalized Report Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN report_status = 'Finalized' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of studies with finalized reports; reporting completeness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_reader_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist worklist KPIs: turnaround time, SLA compliance, RVU productivity, subspecialty matching, and teleradiology routing. Steers reading efficiency."
  source: "`vibe_healthcare_v1`.`radiology`.`reader_assignment`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Modality of assigned study for productivity by modality."
    - name: "priority"
      expr: priority
      comment: "Reading priority for SLA analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status for worklist monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Assignment type (self, auto, manual) for routing analysis."
    - name: "reading_site"
      expr: reading_site
      comment: "Reading location for distributed-reading performance."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
      comment: "Month of assignment for trending."
  measures:
    - name: "Assignment Volume"
      expr: COUNT(1)
      comment: "Total reader assignments; reading workload measure."
    - name: "Total RVU"
      expr: SUM(CAST(rvu_value AS DOUBLE))
      comment: "Total relative value units read; radiologist productivity and revenue proxy."
    - name: "Avg RVU Per Assignment"
      expr: AVG(CAST(rvu_value AS DOUBLE))
      comment: "Average RVU per read; case-complexity/productivity signal."
    - name: "Avg Turnaround Minutes"
      expr: AVG(CAST(tat_minutes AS DOUBLE))
      comment: "Average reading turnaround time; core operational SLA metric."
    - name: "SLA Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reads meeting SLA target; service-level performance KPI."
    - name: "Subspecialty Match Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN subspecialty_match = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reads matched to subspecialist; quality and appropriateness KPI."
    - name: "Teleradiology Read Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_teleradiology = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reads routed to teleradiology; outsourcing/cost steering signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical result notification KPIs: acknowledgment, escalation, and read-back compliance. Steers patient safety and Joint Commission compliance."
  source: "`vibe_healthcare_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the critical finding for acuity segmentation."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of critical finding for pattern analysis."
    - name: "notification_method"
      expr: notification_method
      comment: "Method of provider notification for channel-effectiveness analysis."
    - name: "notification_status"
      expr: notification_status
      comment: "Notification status for outstanding-alert monitoring."
    - name: "modality"
      expr: modality
      comment: "Modality that generated the finding."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month of finding for trending."
  measures:
    - name: "Critical Result Volume"
      expr: COUNT(1)
      comment: "Total critical results; patient-safety workload measure."
    - name: "Acknowledged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of critical results acknowledged; closed-loop communication compliance."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of critical results escalated; notification breakdown signal."
    - name: "Read Back Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN read_back_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with read-back performed; TJC safety-protocol compliance KPI."
    - name: "Patient Safety Event Count"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical results tied to a patient safety event; risk-management driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling KPIs: no-show, cancellation, insurance verification, and reschedule behavior. Steers access, capacity, and revenue-cycle readiness."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_appointment`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality of appointment for capacity planning."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment status for pipeline monitoring."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (outpatient, inpatient) for demand segmentation."
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Insurance verification status for revenue-cycle readiness."
    - name: "auth_status"
      expr: auth_status
      comment: "Authorization status for financial-clearance monitoring."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled appointment for trending."
  measures:
    - name: "Appointment Volume"
      expr: COUNT(1)
      comment: "Total scheduled appointments; access/capacity measure."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of no-shows; lost capacity and revenue signal."
    - name: "Cancellation Count"
      expr: SUM(CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Cancelled appointments; scheduling efficiency signal."
    - name: "Insurance Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_verification_status = 'Verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of appointments insurance-verified before service; revenue-cycle KPI."
    - name: "Billing Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billing_eligibility_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of appointments financially cleared for billing; denial-prevention KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report KPIs: finalization, critical-finding communication, STAT priority, and addendum activity. Steers reporting quality and closed-loop communication."
  source: "`vibe_healthcare_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status for backlog analysis."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the report for mix analysis."
    - name: "body_part"
      expr: body_part
      comment: "Body part reported for service-line mix."
    - name: "rads_category"
      expr: rads_category
      comment: "Structured RADS reporting category for quality analysis."
  measures:
    - name: "Report Volume"
      expr: COUNT(1)
      comment: "Total radiology reports; reporting productivity measure."
    - name: "Critical Finding Communicated Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports with communicated critical findings; closed-loop safety KPI."
    - name: "STAT Report Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stat_priority_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of STAT-priority reports; urgent reporting-load signal."
    - name: "Critical Finding Report Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reports flagged with critical findings; acuity signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_follow_up`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incidental/actionable follow-up KPIs: care-gap closure, lost-to-follow-up, escalation, and notification. Steers population-health and malpractice-risk reduction."
  source: "`vibe_healthcare_v1`.`radiology`.`follow_up`"
  dimensions:
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Follow-up status for closure-tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the follow-up recommendation for triage."
    - name: "recommended_modality"
      expr: recommended_modality
      comment: "Recommended follow-up modality for demand forecasting."
    - name: "population_health_cohort"
      expr: population_health_cohort
      comment: "Population-health cohort for care-gap program targeting."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month follow-up is due for backlog planning."
  measures:
    - name: "Follow Up Volume"
      expr: COUNT(1)
      comment: "Total follow-up recommendations; care-continuity workload."
    - name: "Care Gap Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent flagged as care gaps; population-health intervention driver."
    - name: "Lost To Follow Up Count"
      expr: SUM(CASE WHEN lost_to_follow_up_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Recommendations lost to follow-up; malpractice-risk and quality signal."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of follow-ups escalated; unresolved-recommendation signal."
    - name: "Completed Follow Up Count"
      expr: SUM(CASE WHEN follow_up_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Completed follow-ups; care-gap closure outcome."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose safety KPIs: mean dose metrics, reference-level exceedances, and dose-alert rates. Steers ALARA and regulatory dose-registry compliance."
  source: "`vibe_healthcare_v1`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality of the dose record for dose benchmarking."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomy examined for dose comparison."
    - name: "drl_comparison_result"
      expr: drl_comparison_result
      comment: "Diagnostic reference level comparison result for outlier analysis."
    - name: "dose_registry_submission_status"
      expr: dose_registry_submission_status
      comment: "Dose registry submission status for regulatory compliance."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for dose trending."
  measures:
    - name: "Dose Record Volume"
      expr: COUNT(1)
      comment: "Total dose records; safety monitoring coverage."
    - name: "Avg Effective Dose mSv"
      expr: AVG(CAST(effective_dose_msv AS DOUBLE))
      comment: "Average effective dose; core patient radiation-safety KPI."
    - name: "Avg CTDI Vol mGy"
      expr: AVG(CAST(ctdi_vol_mgy AS DOUBLE))
      comment: "Average CTDIvol; dose-optimization benchmarking."
    - name: "Reference Level Exceedance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exceeds_reference_level_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent exceeding diagnostic reference level; safety-outlier KPI."
    - name: "Dose Alert Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dose_alert_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent triggering dose alerts; ALARA intervention signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_interventional_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interventional radiology KPIs: technical success, complications, sedation, fluoroscopy dose, and blood loss. Steers procedural quality and safety."
  source: "`vibe_healthcare_v1`.`radiology`.`interventional_procedure`"
  dimensions:
    - name: "procedure_category"
      expr: procedure_category
      comment: "Procedure category for service-line quality analysis."
    - name: "body_region"
      expr: body_region
      comment: "Body region treated for mix analysis."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Procedure status for pipeline monitoring."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for sedation-safety analysis."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_datetime)
      comment: "Month of procedure for volume trending."
  measures:
    - name: "Procedure Volume"
      expr: COUNT(1)
      comment: "Total interventional procedures; IR productivity measure."
    - name: "Technical Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN technical_success_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures technically successful; core IR quality KPI."
    - name: "Complication Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN complication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with complications; patient-safety and quality driver."
    - name: "Avg Fluoroscopy Time Min"
      expr: AVG(CAST(fluoroscopy_time_min AS DOUBLE))
      comment: "Average fluoroscopy time; operator dose and efficiency signal."
    - name: "Avg Blood Loss mL"
      expr: AVG(CAST(blood_loss_ml AS DOUBLE))
      comment: "Average estimated blood loss; procedural safety indicator."
    - name: "Moderate Sedation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN moderate_sedation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent using moderate sedation; sedation-resource and safety signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist peer-review KPIs: discrepancy rate, agreement, and RADPEER scoring. Steers OPPE/FPPE quality governance."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_peer_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of peer review for program analysis."
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Discrepancy category for pattern analysis."
    - name: "modality"
      expr: modality
      comment: "Modality reviewed for quality by modality."
    - name: "subspecialty"
      expr: subspecialty
      comment: "Subspecialty of the review for quality segmentation."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_datetime)
      comment: "Month of review for trending."
  measures:
    - name: "Peer Review Volume"
      expr: COUNT(1)
      comment: "Total peer reviews completed; quality-program coverage."
    - name: "Discrepancy Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews with discrepancies; core interpretive-quality KPI."
    - name: "Agreement Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN agreement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews in agreement; interpretive consistency signal."
    - name: "Escalated To Chair Count"
      expr: SUM(CASE WHEN escalated_to_chair_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews escalated to department chair; serious-discrepancy driver."
    - name: "Patient Safety Event Count"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews tied to patient safety events; risk-management signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_teleradiology_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Teleradiology outsourcing KPIs: SLA/TAT, reconciliation discrepancy, and transmission success. Steers vendor performance and cost."
  source: "`vibe_healthcare_v1`.`radiology`.`teleradiology_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Teleradiology case status for pipeline monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority for SLA analysis."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the case for vendor mix analysis."
    - name: "billing_responsibility"
      expr: billing_responsibility
      comment: "Billing responsibility for revenue-attribution analysis."
    - name: "sent_month"
      expr: DATE_TRUNC('MONTH', sent_timestamp)
      comment: "Month case was sent for volume trending."
  measures:
    - name: "Teleradiology Case Volume"
      expr: COUNT(1)
      comment: "Total teleradiology cases; outsourced-reading workload."
    - name: "Avg Turnaround Minutes"
      expr: AVG(CAST(actual_tat_minutes AS DOUBLE))
      comment: "Average actual turnaround; vendor service-level KPI."
    - name: "SLA Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of cases meeting SLA; vendor performance KPI."
    - name: "Reconciliation Discrepancy Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_discrepancy_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with prelim-vs-final discrepancy; quality-assurance KPI."
    - name: "Transmission Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transmission_success = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of successful transmissions; interoperability-reliability signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report distribution KPIs: delivery success, acknowledgment, SLA compliance, and escalation. Steers closed-loop result-delivery reliability (thin-product expansion per VREQ-036)."
  source: "`vibe_healthcare_v1`.`radiology`.`report_distribution`"
  dimensions:
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery channel (fax, direct, portal) for channel-performance analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status for undelivered-result monitoring."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient for distribution-pattern analysis."
    - name: "distribution_priority"
      expr: distribution_priority
      comment: "Distribution priority for SLA segmentation."
    - name: "distribution_month"
      expr: DATE_TRUNC('MONTH', distribution_timestamp)
      comment: "Month of distribution for trending."
  measures:
    - name: "Distribution Volume"
      expr: COUNT(1)
      comment: "Total report distributions; delivery workload measure."
    - name: "Delivery Confirmed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_confirmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of confirmed deliveries; result-delivery reliability KPI."
    - name: "Acknowledged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of acknowledged deliveries; closed-loop communication KPI."
    - name: "SLA Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of distributions meeting SLA; delivery-timeliness KPI."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of distributions escalated; failed-delivery signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_transmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Image transmission KPIs: success rate, SLA, and retransmission burden. Steers PACS/interoperability reliability."
  source: "`vibe_healthcare_v1`.`radiology`.`transmission`"
  dimensions:
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission for pattern analysis."
    - name: "transmission_status"
      expr: transmission_status
      comment: "Transmission status for failure monitoring."
    - name: "destination_system"
      expr: destination_system
      comment: "Destination system for endpoint-reliability analysis."
    - name: "transmission_month"
      expr: DATE_TRUNC('MONTH', transmission_timestamp)
      comment: "Month of transmission for trending."
  measures:
    - name: "Transmission Volume"
      expr: COUNT(1)
      comment: "Total transmissions; interoperability workload measure."
    - name: "Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN success = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of successful transmissions; core reliability KPI."
    - name: "SLA Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transmissions meeting SLA; timeliness KPI."
    - name: "Total Bytes Transmitted"
      expr: SUM(CAST(bytes_transmitted AS DOUBLE))
      comment: "Total data volume transmitted; infrastructure-load and capacity signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast administration safety KPIs: adverse-reaction rate, extravasation, premedication, and metformin-hold compliance. Steers contrast-safety governance."
  source: "`vibe_healthcare_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "agent_class"
      expr: agent_class
      comment: "Contrast agent class for safety benchmarking."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for reaction-pattern analysis."
    - name: "administration_status"
      expr: administration_status
      comment: "Administration status for completeness monitoring."
    - name: "body_region"
      expr: body_region
      comment: "Body region for mix analysis."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month of administration for trending."
  measures:
    - name: "Contrast Admin Volume"
      expr: COUNT(1)
      comment: "Total contrast administrations; safety-monitoring coverage."
    - name: "Adverse Reaction Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with adverse reactions; core contrast-safety KPI."
    - name: "Extravasation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN extravasation_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with extravasation; injection-technique safety signal."
    - name: "Premedication Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN premedication_given = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent premedicated; allergy-prophylaxis protocol adherence."
    - name: "Metformin Held Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN metformin_held = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with metformin held; nephrotoxicity-safety protocol compliance."
$$;