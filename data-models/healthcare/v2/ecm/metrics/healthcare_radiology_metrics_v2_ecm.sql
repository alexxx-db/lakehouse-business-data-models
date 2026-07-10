-- Metric views for domain: radiology | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging order operational and throughput KPIs for radiology department steering: order volume, STAT/portable mix, cancellations, prior-auth performance, and exam turnaround."
  source: "`vibe_healthcare_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Imaging modality (CT, MR, XR, US, etc.) for volume and utilization analysis by modality line."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the imaging order (ordered, scheduled, completed, cancelled)."
    - name: "order_priority"
      expr: order_priority
      comment: "Clinical priority of the order (STAT, routine) for acuity mix analysis."
    - name: "body_part"
      expr: body_part
      comment: "Anatomical region imaged, for service-line grouping."
    - name: "order_source"
      expr: order_source
      comment: "Origin of the order (ED, inpatient, outpatient) for referral channel analysis."
    - name: "prior_auth_status"
      expr: prior_auth_status
      comment: "Prior authorization status for payer/revenue-cycle risk grouping."
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month the order was placed, for trended volume analysis."
  measures:
    - name: "Imaging Order Count"
      expr: COUNT(1)
      comment: "Total imaging orders; baseline demand and capacity-planning volume metric."
    - name: "Distinct Patients Ordered"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients receiving imaging orders; measures reach of imaging services."
    - name: "STAT Override Count"
      expr: SUM(CASE WHEN is_stat_override = TRUE THEN 1 ELSE 0 END)
      comment: "Count of STAT-override orders; high override rates signal capacity strain and prioritization risk."
    - name: "Cancelled Order Count"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Cancelled imaging orders; drives lost-capacity and revenue-leakage investigation."
    - name: "Critical Finding Order Count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Orders flagged with critical findings; drives patient-safety communication compliance."
    - name: "Portable Exam Count"
      expr: SUM(CASE WHEN is_portable = TRUE THEN 1 ELSE 0 END)
      comment: "Portable imaging exams; informs mobile-equipment staffing and utilization decisions."
    - name: "Contrast Required Count"
      expr: SUM(CASE WHEN contrast_required = TRUE THEN 1 ELSE 0 END)
      comment: "Orders requiring contrast; drives contrast supply forecasting and safety screening load."
    - name: "Avg CTDI Radiation Dose"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CTDI dose per order; core radiation-safety and dose-optimization KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_reader_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiologist reading productivity and turnaround KPIs: SLA compliance, RVU productivity, subspecialty matching, and teleradiology utilization."
  source: "`vibe_healthcare_v1`.`radiology`.`reader_assignment`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Modality of the read for productivity segmentation."
    - name: "priority"
      expr: priority
      comment: "Read priority (STAT, routine) for turnaround expectation grouping."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the reader assignment for worklist state analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (auto, manual, self) for worklist-routing effectiveness."
    - name: "reading_site"
      expr: reading_site
      comment: "Site where the read was performed, for distributed-reading analysis."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
      comment: "Month of assignment for trended productivity."
  measures:
    - name: "Reader Assignment Count"
      expr: COUNT(1)
      comment: "Total reading assignments; baseline radiologist workload volume."
    - name: "SLA Met Count"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Assignments meeting turnaround SLA; core service-level and patient-flow KPI."
    - name: "Teleradiology Read Count"
      expr: SUM(CASE WHEN is_teleradiology = TRUE THEN 1 ELSE 0 END)
      comment: "Teleradiology reads; informs outsourcing cost and coverage-gap decisions."
    - name: "Subspecialty Matched Count"
      expr: SUM(CASE WHEN subspecialty_match = TRUE THEN 1 ELSE 0 END)
      comment: "Reads matched to radiologist subspecialty; drives quality and routing-rule tuning."
    - name: "Total RVU"
      expr: SUM(CAST(rvu_value AS DOUBLE))
      comment: "Total relative value units read; primary radiologist productivity and compensation KPI."
    - name: "Avg RVU Per Read"
      expr: AVG(CAST(rvu_value AS DOUBLE))
      comment: "Average RVU per assignment; complexity-mix indicator."
    - name: "Critical Finding Assignment Count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Assignments with critical findings; safety-escalation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology study production KPIs: study volume, STAT read completion, critical findings, external imports, and storage footprint for PACS capacity planning."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Study lifecycle status for production-state analysis."
    - name: "report_status"
      expr: report_status
      comment: "Report status of the study, for reporting-backlog analysis."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Anatomical region examined for service-line grouping."
    - name: "priority"
      expr: priority
      comment: "Study priority for acuity-mix analysis."
    - name: "pacs_status"
      expr: pacs_status
      comment: "PACS archive status for storage-lifecycle management."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of study for trended volume analysis."
  measures:
    - name: "Study Count"
      expr: COUNT(1)
      comment: "Total radiology studies performed; core imaging production volume KPI."
    - name: "Distinct Patients Studied"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients imaged; population reach measure."
    - name: "Critical Finding Study Count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Studies with critical findings; drives safety-notification compliance."
    - name: "External Import Count"
      expr: SUM(CASE WHEN is_external_import = TRUE THEN 1 ELSE 0 END)
      comment: "Externally imported studies; informs outside-imaging reconciliation and duplicate-scan avoidance."
    - name: "Contrast Administered Count"
      expr: SUM(CASE WHEN contrast_administered = TRUE THEN 1 ELSE 0 END)
      comment: "Studies with contrast administered; contrast-safety and supply demand."
    - name: "Total Storage MB"
      expr: SUM(CAST(size_mb AS DOUBLE))
      comment: "Total PACS storage consumed; capital storage-capacity planning KPI."
    - name: "Avg CTDI Vol Dose"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CTDI volume dose per study; radiation-safety optimization KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical result communication KPIs measuring Joint Commission / patient-safety compliance: notification turnaround, acknowledgment, escalation, and read-back performance."
  source: "`vibe_healthcare_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity classification of the critical finding for acuity segmentation."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the critical finding for pattern analysis."
    - name: "notification_status"
      expr: notification_status
      comment: "Status of critical-result notification for closed-loop compliance."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify (phone, EHR alert) for channel effectiveness."
    - name: "tjc_compliance_status"
      expr: tjc_compliance_status
      comment: "Joint Commission compliance status for regulatory reporting."
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month of the critical finding for trended safety analysis."
  measures:
    - name: "Critical Result Count"
      expr: COUNT(1)
      comment: "Total critical results requiring communication; safety workload baseline."
    - name: "Escalated Result Count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical results escalated; indicates first-attempt notification failures needing process fixes."
    - name: "Read Back Performed Count"
      expr: SUM(CASE WHEN read_back_performed = TRUE THEN 1 ELSE 0 END)
      comment: "Results with read-back confirmation; closed-loop communication compliance KPI."
    - name: "EMTALA Applicable Count"
      expr: SUM(CASE WHEN emtala_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "EMTALA-relevant critical results; regulatory-exposure tracking."
    - name: "Patient Safety Event Count"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical results linked to a patient-safety event; risk-management escalation KPI."
    - name: "Distinct Patients With Critical Results"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients with critical findings; population-safety measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_dose_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiation dose management KPIs for ALARA / regulatory dose-registry compliance: dose alerts, physicist review, DRL comparison, and cumulative dose exposure."
  source: "`vibe_healthcare_v1`.`radiology`.`dose_record`"
  dimensions:
    - name: "modality_type"
      expr: modality_type
      comment: "Modality generating the dose for dose-optimization by equipment type."
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body region examined for anatomical dose benchmarking."
    - name: "dose_alert_threshold_type"
      expr: dose_alert_threshold_type
      comment: "Type of dose alert threshold applied for alert-governance analysis."
    - name: "drl_comparison_result"
      expr: drl_comparison_result
      comment: "Result of comparison to diagnostic reference levels for benchmarking."
    - name: "dose_registry_submission_status"
      expr: dose_registry_submission_status
      comment: "Status of ACR dose-registry submission for regulatory compliance."
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month of the dosed study for trended safety analysis."
  measures:
    - name: "Dose Record Count"
      expr: COUNT(1)
      comment: "Total dose records captured; radiation-safety monitoring baseline."
    - name: "Dose Alert Count"
      expr: SUM(CASE WHEN dose_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Dose records exceeding alert thresholds; core ALARA safety KPI triggering review."
    - name: "Physicist Review Count"
      expr: SUM(CASE WHEN physicist_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Dose records reviewed by physicist; safety-oversight compliance measure."
    - name: "Avg Effective Dose mSv"
      expr: AVG(CAST(effective_dose_msv AS DOUBLE))
      comment: "Average effective dose in mSv; primary population radiation-exposure KPI."
    - name: "Avg Cumulative Dose mSv"
      expr: AVG(CAST(cumulative_dose_msv AS DOUBLE))
      comment: "Average cumulative patient dose; long-term exposure-risk monitoring."
    - name: "Avg DLP"
      expr: AVG(CAST(dlp_mgy_cm AS DOUBLE))
      comment: "Average dose-length product; CT dose-optimization benchmark."
    - name: "Distinct Patients Dosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with dose records; population-exposure denominator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology scheduling KPIs: appointment volume, no-shows, reschedules, STAT/portable mix, and authorization status for access and utilization management."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Appointment lifecycle status for access and completion analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment for scheduling-mix analysis."
    - name: "modality_type"
      expr: modality_type
      comment: "Modality scheduled for capacity utilization by equipment line."
    - name: "auth_status"
      expr: auth_status
      comment: "Authorization status for payer/revenue-cycle risk."
    - name: "body_part"
      expr: body_part
      comment: "Body region scheduled for service-line grouping."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month of scheduled appointment for trended demand analysis."
  measures:
    - name: "Appointment Count"
      expr: COUNT(1)
      comment: "Total radiology appointments; access and capacity baseline."
    - name: "No Show Count"
      expr: SUM(CASE WHEN appointment_status = 'No Show' THEN 1 ELSE 0 END)
      comment: "No-show appointments; lost-capacity and access-management KPI."
    - name: "Cancelled Appointment Count"
      expr: SUM(CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Cancelled appointments; slot-recovery and overbooking-policy driver."
    - name: "STAT Appointment Count"
      expr: SUM(CASE WHEN is_stat = TRUE THEN 1 ELSE 0 END)
      comment: "STAT appointments; acuity-mix and capacity-strain indicator."
    - name: "Contrast Required Appointment Count"
      expr: SUM(CASE WHEN contrast_required = TRUE THEN 1 ELSE 0 END)
      comment: "Appointments requiring contrast; contrast-supply and screening prep planning."
    - name: "Distinct Patients Scheduled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients scheduled; access-reach measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_teleradiology_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Teleradiology vendor performance and cost KPIs: turnaround compliance, transmission success, reconciliation discrepancies, and critical-finding handling for outsourcing governance."
  source: "`vibe_healthcare_v1`.`radiology`.`teleradiology_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Teleradiology case status for workflow-state analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority for turnaround expectation segmentation."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the teleradiology case for vendor-mix analysis."
    - name: "billing_responsibility"
      expr: billing_responsibility
      comment: "Which party bills the read for revenue-cycle attribution."
    - name: "report_reconciliation_status"
      expr: report_reconciliation_status
      comment: "Reconciliation status of the final report for QA governance."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the case was created for trended vendor-volume analysis."
  measures:
    - name: "Teleradiology Case Count"
      expr: COUNT(1)
      comment: "Total teleradiology cases; outsourcing volume and spend baseline."
    - name: "SLA Met Case Count"
      expr: SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END)
      comment: "Cases meeting turnaround SLA; vendor service-level compliance KPI."
    - name: "Transmission Success Count"
      expr: SUM(CASE WHEN transmission_success = TRUE THEN 1 ELSE 0 END)
      comment: "Successful transmissions; interoperability reliability KPI."
    - name: "Reconciliation Discrepancy Count"
      expr: SUM(CASE WHEN reconciliation_discrepancy_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Cases with preliminary-vs-final discrepancies; vendor-quality and safety KPI."
    - name: "Critical Finding Case Count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Teleradiology cases with critical findings; escalation-compliance monitoring."
    - name: "Distinct Vendors Used"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Unique teleradiology vendors; vendor-concentration and contract-negotiation insight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_peer_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology peer-review quality KPIs (RADPEER / OPPE-FPPE): discrepancy rates, escalations, and blinded-review compliance for physician-quality governance."
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_peer_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of the peer review for completion tracking."
    - name: "review_type"
      expr: review_type
      comment: "Type of peer review (prospective, retrospective) for program-mix analysis."
    - name: "review_disposition"
      expr: review_disposition
      comment: "Disposition of the review for outcome classification."
    - name: "discrepancy_category"
      expr: discrepancy_category
      comment: "Category of any discrepancy found for quality-trend analysis."
    - name: "subspecialty"
      expr: subspecialty
      comment: "Radiologist subspecialty for competency benchmarking."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_datetime)
      comment: "Month of review for trended quality analysis."
  measures:
    - name: "Peer Review Count"
      expr: COUNT(1)
      comment: "Total peer reviews performed; quality-program activity baseline."
    - name: "Discrepancy Case Count"
      expr: SUM(CASE WHEN discrepancy_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Reviews with an identified discrepancy; core diagnostic-accuracy quality KPI."
    - name: "Escalated To Chair Count"
      expr: SUM(CASE WHEN escalated_to_chair_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews escalated to department chair; serious-discrepancy governance KPI."
    - name: "Patient Safety Event Count"
      expr: SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Peer reviews tied to patient-safety events; risk-management linkage."
    - name: "Blinded Review Count"
      expr: SUM(CASE WHEN blinded_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Blinded peer reviews; program-integrity/methodology compliance measure."
    - name: "Subspecialty Matched Review Count"
      expr: SUM(CASE WHEN subspecialty_matched_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reviews performed by subspecialty-matched reviewers; review-quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report finalization and communication KPIs: report volume, STAT priority, critical-finding communication, and addendum activity for reporting-quality governance."
  source: "`vibe_healthcare_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Report lifecycle status for reporting-backlog analysis."
    - name: "body_part"
      expr: body_part
      comment: "Body region reported for service-line grouping."
    - name: "modality_code"
      expr: modality_code
      comment: "Modality of the reported study for reporting-mix analysis."
    - name: "rads_category"
      expr: rads_category
      comment: "Structured RADS category assigned for standardized-reporting compliance."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the report was created for trended volume analysis."
  measures:
    - name: "Report Count"
      expr: COUNT(1)
      comment: "Total radiology reports; reporting production baseline."
    - name: "Critical Finding Report Count"
      expr: SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Reports flagged with critical findings; safety-communication workload."
    - name: "Critical Finding Communicated Count"
      expr: SUM(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Critical findings communicated; closed-loop safety-communication compliance KPI."
    - name: "STAT Priority Report Count"
      expr: SUM(CASE WHEN stat_priority_flag = TRUE THEN 1 ELSE 0 END)
      comment: "STAT-priority reports; acuity-mix and turnaround-priority indicator."
    - name: "Distinct Reporting Radiologists"
      expr: COUNT(DISTINCT report_reading_radiologist_clinician_id)
      comment: "Unique reading radiologists; reporting capacity and coverage measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast administration safety KPIs: adverse reactions, extravasation, premedication, and screening compliance for contrast-safety governance."
  source: "`vibe_healthcare_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "modality"
      expr: modality
      comment: "Modality of the contrast study for safety segmentation."
    - name: "agent_class"
      expr: agent_class
      comment: "Class of contrast agent for agent-specific safety analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Administration route for procedural safety grouping."
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the contrast administration for completion tracking."
    - name: "body_region"
      expr: body_region
      comment: "Body region for anatomical safety analysis."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month of administration for trended safety analysis."
  measures:
    - name: "Contrast Administration Count"
      expr: COUNT(1)
      comment: "Total contrast administrations; safety-monitoring and supply baseline."
    - name: "Adverse Reaction Count"
      expr: SUM(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Contrast adverse reactions; core contrast-safety KPI driving protocol review."
    - name: "Extravasation Count"
      expr: SUM(CASE WHEN extravasation_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Extravasation events; injector-technique and safety-improvement KPI."
    - name: "Premedication Given Count"
      expr: SUM(CASE WHEN premedication_given = TRUE THEN 1 ELSE 0 END)
      comment: "Premedicated administrations; allergy-prophylaxis compliance measure."
    - name: "Power Injector Used Count"
      expr: SUM(CASE WHEN power_injector_used = TRUE THEN 1 ELSE 0 END)
      comment: "Administrations using a power injector; equipment-utilization and extravasation-risk analysis."
    - name: "Avg Dose Volume mL"
      expr: AVG(CAST(dose_volume_ml AS DOUBLE))
      comment: "Average contrast volume administered; dose-optimization and supply-cost KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_interventional_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interventional radiology procedure KPIs: procedure volume, technical success, complications, and fluoroscopy/radiation dose for IR quality and safety governance."
  source: "`vibe_healthcare_v1`.`radiology`.`interventional_procedure`"
  dimensions:
    - name: "procedure_category"
      expr: procedure_category
      comment: "Category of IR procedure for service-line grouping."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure for completion analysis."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia used for complexity and safety segmentation."
    - name: "body_region"
      expr: body_region
      comment: "Body region of the procedure for anatomical grouping."
    - name: "complication_severity"
      expr: complication_severity
      comment: "Severity of any complication for quality-outcome analysis."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_start_timestamp)
      comment: "Month of procedure for trended volume analysis."
  measures:
    - name: "Procedure Count"
      expr: COUNT(1)
      comment: "Total interventional procedures; IR production and capacity baseline."
    - name: "Technical Success Count"
      expr: SUM(CASE WHEN technical_success = TRUE THEN 1 ELSE 0 END)
      comment: "Technically successful procedures; core IR quality-outcome KPI."
    - name: "Complication Count"
      expr: SUM(CASE WHEN complication_occurred = TRUE THEN 1 ELSE 0 END)
      comment: "Procedures with complications; safety and outcome-improvement KPI."
    - name: "Implant Used Count"
      expr: SUM(CASE WHEN implant_used = TRUE THEN 1 ELSE 0 END)
      comment: "Procedures using implants; device-cost and UDI-traceability tracking."
    - name: "Avg Fluoroscopy Time Minutes"
      expr: AVG(CAST(fluoroscopy_time_minutes AS DOUBLE))
      comment: "Average fluoroscopy time; radiation-safety and dose-optimization KPI."
    - name: "Avg Radiation Dose Kerma"
      expr: AVG(CAST(radiation_dose_kerma_mgy AS DOUBLE))
      comment: "Average air-kerma radiation dose; IR radiation-safety benchmark."
$$;