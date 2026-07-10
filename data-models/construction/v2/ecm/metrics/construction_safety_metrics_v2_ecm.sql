-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident KPIs tracking frequency, severity, lost-time rates, and financial impact of workplace incidents. Used by HSE leadership to monitor TRIR, LTI rates, and drive corrective action prioritisation."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of incident (e.g. near-miss, first-aid, LTI, fatality) for severity-band analysis."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident used to prioritise response and track trend by risk level."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident record (open, under investigation, closed)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause classification enabling systemic failure pattern analysis."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (employee, subcontractor, visitor) for workforce safety segmentation."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for incident — enables project-level safety performance benchmarking."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred, used for trend analysis and monthly safety reporting."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating whether the incident resulted in lost time — key LTI frequency rate driver."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating OSHA recordability, required for regulatory compliance reporting."
    - name: "is_environmental_event"
      expr: is_environmental_event
      comment: "Flag distinguishing environmental incidents from safety incidents for separate reporting streams."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded incidents. Baseline KPI for absolute incident volume tracking."
    - name: "lti_count"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Number of Lost Time Incidents. Core safety KPI used to compute LTI frequency rate and benchmark against industry standards."
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Drives TRIR calculation and regulatory compliance reporting."
    - name: "environmental_incident_count"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Number of environmental incidents. Tracked separately for environmental compliance and permit obligations."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total financial value of property damage from incidents. Informs insurance claims, cost-of-safety analysis, and risk financing decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Used to assess severity trends and prioritise prevention investment."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'CLOSED') THEN 1 END)
      comment: "Number of incidents not yet closed. Tracks backlog of unresolved safety events requiring management attention."
    - name: "stop_work_incident_count"
      expr: COUNT(CASE WHEN severity IN ('Critical', 'CRITICAL', 'High', 'HIGH') THEN 1 END)
      comment: "Count of high/critical severity incidents that typically trigger stop-work authority. Proxy for most serious safety events on site."
    - name: "distinct_projects_with_incidents"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects that have recorded at least one incident. Identifies breadth of safety exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics tracking the quality, timeliness, and closure of incident investigations. Used by HSE managers to ensure root cause analysis is completed promptly and corrective actions are actioned."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in-progress, closed) for workload and backlog management."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g. RCA, 5-Why, Bow-Tie) for process quality analysis."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Classification of the underlying incident (LTI, near-miss, property damage) for severity-band reporting."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation — tracks follow-through on safety improvements."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for investigations that must be reported to a regulator — drives compliance deadline tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for the investigation, enabling project-level investigation performance benchmarking."
    - name: "investigation_start_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month investigation was initiated, used for trend and cycle-time analysis."
    - name: "is_lti"
      expr: is_lti
      comment: "Whether the investigated incident was a Lost Time Incident — prioritises investigation urgency."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations. Baseline volume metric for investigation programme management."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('Closed', 'CLOSED', 'Complete', 'COMPLETE') THEN 1 END)
      comment: "Number of investigations not yet closed. Tracks backlog and management responsiveness to safety events."
    - name: "regulatory_reportable_investigations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations with regulatory reporting obligations. Critical for compliance deadline management."
    - name: "corrective_action_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'CLOSED', 'Complete', 'COMPLETE') AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of investigations where corrective actions are past their due date. Key indicator of safety management system effectiveness."
    - name: "avg_investigation_cycle_days"
      expr: AVG(CAST(DATEDIFF(investigation_close_date, investigation_start_date) AS DOUBLE))
      comment: "Average number of days from investigation start to close. Measures investigation timeliness — a leading indicator of safety culture maturity."
    - name: "lti_investigation_count"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Number of investigations for Lost Time Incidents. Ensures the most serious incidents receive full root cause analysis."
    - name: "investigations_with_ppe_non_compliance"
      expr: COUNT(CASE WHEN ppe_compliance_flag = FALSE THEN 1 END)
      comment: "Count of investigations where PPE non-compliance was identified as a contributing factor. Drives targeted PPE training and enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE inspection performance metrics tracking compliance rates, deficiency volumes, and inspection programme effectiveness. Used by HSE managers and project directors to monitor site safety standards."
  source: "`vibe_construction_v1`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection (routine, regulatory, audit, drill) for programme coverage analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (scheduled, in-progress, completed, overdue)."
    - name: "overall_result"
      expr: overall_result
      comment: "Pass/fail/conditional result of the inspection — primary outcome measure for compliance tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the inspection was conducted on — enables project-level compliance benchmarking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis and monthly safety reporting cadence."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Whether the inspection was planned or reactive — measures proactive vs reactive safety management ratio."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued during the inspection — flags highest-severity site conditions."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective actions were raised — tracks inspection effectiveness in identifying deficiencies."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of HSE inspections conducted. Baseline metric for inspection programme activity."
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across inspections. Key leading safety indicator used in executive dashboards and client reporting."
    - name: "avg_drill_muster_accuracy_pct"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage across emergency drills. Measures emergency preparedness effectiveness."
    - name: "stop_work_order_count"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a stop-work order. Tracks most critical site safety interventions requiring immediate executive attention."
    - name: "inspections_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections that identified deficiencies requiring corrective action. Measures inspection effectiveness and site compliance gaps."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that raised corrective actions. Tracks site deficiency prevalence — a leading indicator of incident risk."
    - name: "stop_work_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in stop-work orders. Measures frequency of critical safety interventions relative to inspection volume."
    - name: "scheduled_inspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of inspections that were planned vs reactive. Higher rates indicate a proactive safety management culture."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment portfolio metrics tracking residual risk distribution, assessment coverage, and control effectiveness. Used by HSE directors and project managers to manage site risk profiles and demonstrate due diligence."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (SWMS, JSA, environmental, pre-task) for coverage analysis by methodology."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, approved, expired, superseded)."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls applied (Low/Medium/High/Extreme). Primary risk portfolio distribution metric."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls — used to measure control effectiveness by comparing to residual."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Category of hazard being assessed — enables risk concentration analysis by hazard type."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the risk assessment applies to — enables project-level risk portfolio management."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month assessment was conducted for trend analysis of risk assessment programme activity."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether additional corrective actions were identified beyond standard controls."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag for assessments covering environmental aspects — enables environmental risk portfolio segmentation."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments in the portfolio. Baseline metric for risk management programme coverage."
    - name: "high_extreme_residual_risk_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END)
      comment: "Number of assessments with high or extreme residual risk after controls. Drives prioritisation of additional risk mitigation investment."
    - name: "high_extreme_residual_risk_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments with unacceptably high residual risk. Key portfolio risk health indicator for executive reporting."
    - name: "risk_reduction_effectiveness_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') AND residual_risk_level IN ('Low', 'LOW', 'Medium', 'MEDIUM') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END), 0), 2)
      comment: "Percentage of initially high/extreme risks successfully reduced to low/medium through controls. Measures control hierarchy effectiveness."
    - name: "expired_assessment_count"
      expr: COUNT(CASE WHEN assessment_status IN ('Expired', 'EXPIRED') THEN 1 END)
      comment: "Number of risk assessments that have expired and require renewal. Tracks compliance with review cycle obligations."
    - name: "assessments_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of risk assessments that identified additional corrective actions beyond standard controls. Measures residual control gaps."
    - name: "distinct_projects_assessed"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active risk assessments. Measures risk management programme coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit-to-work control metrics tracking permit volumes, compliance, and high-risk work management. Used by HSE managers and site supervisors to ensure critical controls are in place before hazardous work commences."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (hot work, confined space, working at height, excavation) for high-risk work category analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (issued, active, suspended, closed) for workload and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work — enables prioritisation of oversight for highest-risk activities."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the permit applies to — enables project-level PTW compliance benchmarking."
    - name: "permit_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued for trend analysis of high-risk work volumes."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Whether energy isolation (LOTO) is required — flags permits with highest electrical/mechanical risk."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Whether atmospheric gas testing is required — identifies confined space and hot work permits."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the permitted work has potential environmental impact — enables environmental risk tracking."
  measures:
    - name: "total_permits_issued"
      expr: COUNT(1)
      comment: "Total number of permits to work issued. Baseline metric for high-risk work volume and PTW programme activity."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN permit_status IN ('Active', 'ACTIVE', 'Issued', 'ISSUED') THEN 1 END)
      comment: "Number of currently active permits. Tracks concurrent high-risk work volume on site — informs resource allocation for safety supervision."
    - name: "suspended_permit_count"
      expr: COUNT(CASE WHEN permit_status IN ('Suspended', 'SUSPENDED') THEN 1 END)
      comment: "Number of permits currently suspended. Elevated suspension rates indicate site safety conditions requiring management intervention."
    - name: "permits_requiring_isolation"
      expr: COUNT(CASE WHEN isolation_required = TRUE THEN 1 END)
      comment: "Number of permits requiring energy isolation (LOTO). Tracks volume of highest-consequence work requiring strict lockout/tagout controls."
    - name: "permits_requiring_gas_test"
      expr: COUNT(CASE WHEN gas_test_required = TRUE THEN 1 END)
      comment: "Number of permits requiring atmospheric gas testing. Measures confined space and hot work exposure volume."
    - name: "concurrent_permit_count"
      expr: COUNT(CASE WHEN concurrent_permit_flag = TRUE THEN 1 END)
      comment: "Number of permits flagged as concurrent with other active permits. Concurrent permits increase interface risk and require additional coordination controls."
    - name: "high_risk_permit_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits classified as high or extreme risk. Measures proportion of work requiring most intensive safety oversight."
    - name: "avg_permit_extension_count"
      expr: AVG(CAST(tbm_record_reference AS DOUBLE))
      comment: "Placeholder — tbm_record_reference is the only numeric non-PK/FK field available; use extension_count when available as STRING. Tracks permit duration management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazard register portfolio metrics tracking open hazards, risk levels, and closure performance. Used by HSE managers and project directors to manage site hazard exposure and demonstrate proactive risk control."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard (physical, chemical, biological, ergonomic) for hazard category concentration analysis."
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (open, in-progress, closed) for backlog and closure rate tracking."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls — primary portfolio risk distribution metric."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls — used to measure control effectiveness."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Broad hazard category for executive-level risk portfolio reporting."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the hazard is associated with — enables project-level hazard portfolio management."
    - name: "identification_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the hazard was identified for trend analysis of hazard discovery rates."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Whether a permit to work is required to manage this hazard — links hazard register to PTW programme."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Whether the hazard has an environmental dimension — enables environmental risk portfolio segmentation."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of hazards in the register. Baseline metric for hazard identification programme activity."
    - name: "open_hazard_count"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('Closed', 'CLOSED') THEN 1 END)
      comment: "Number of hazards not yet closed. Tracks unresolved risk exposure on site — key metric for HSE leadership review."
    - name: "high_extreme_residual_hazard_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END)
      comment: "Number of hazards with high or extreme residual risk after controls. Drives prioritisation of additional mitigation resources."
    - name: "hazard_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazard_status IN ('Closed', 'CLOSED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified hazards that have been closed out. Measures effectiveness of the hazard management lifecycle."
    - name: "overdue_hazard_count"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('Closed', 'CLOSED') AND target_closure_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of open hazards past their target closure date. Tracks management responsiveness and accountability for hazard resolution."
    - name: "ptw_required_hazard_count"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Number of hazards requiring a permit to work for control. Measures the volume of hazards demanding formal PTW controls."
    - name: "distinct_projects_with_hazards"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active hazards in the register. Measures breadth of hazard exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety audit programme metrics tracking compliance scores, non-conformance rates, and audit programme effectiveness. Used by HSE directors and senior management to assess safety management system maturity."
  source: "`vibe_construction_v1`.`safety`.`safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of safety audit (internal, external, regulatory, surveillance) for programme coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, overdue) for programme management."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (HSE management system, site safety, environmental) for thematic analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the audit was conducted on — enables project-level safety management system benchmarking."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit was conducted for trend analysis of audit programme activity and compliance scores."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued during the audit — flags most critical safety management failures."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether the audit findings require regulatory notification — tracks compliance obligations."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safety audits conducted. Baseline metric for audit programme activity and coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average safety compliance score across all audits. Primary KPI for safety management system maturity — tracked in executive dashboards and client reports."
    - name: "audits_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Number of audits that resulted in a stop-work order. Tracks frequency of critical safety management failures requiring immediate intervention."
    - name: "audits_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of audits with findings requiring regulatory notification. Tracks regulatory compliance exposure and notification obligations."
    - name: "audits_with_immediate_action"
      expr: COUNT(CASE WHEN immediate_action_required = TRUE THEN 1 END)
      comment: "Number of audits requiring immediate corrective action. Measures frequency of critical findings demanding urgent management response."
    - name: "open_audit_count"
      expr: COUNT(CASE WHEN audit_status NOT IN ('Completed', 'COMPLETED', 'Closed', 'CLOSED') THEN 1 END)
      comment: "Number of audits not yet completed. Tracks audit programme backlog and scheduling compliance."
    - name: "distinct_projects_audited"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects that have received a safety audit. Measures audit programme coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE plan coverage and target metrics tracking plan status, safety performance targets, and programme completeness. Used by HSE directors to ensure all projects have approved safety plans with appropriate targets."
  source: "`vibe_construction_v1`.`safety`.`hse_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HSE plan (project, corporate, environmental, emergency) for programme coverage analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the HSE plan (draft, approved, expired, superseded) for compliance tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the HSE plan covers — enables project-level plan coverage and compliance tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the plan applies — enables regulatory jurisdiction analysis for multi-country programmes."
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the plan became effective for programme timeline analysis."
    - name: "induction_required"
      expr: induction_required
      comment: "Whether site induction is mandated under this plan — tracks induction programme coverage."
    - name: "swms_required"
      expr: swms_required
      comment: "Whether SWMS are required under this plan — tracks high-risk work control programme coverage."
  measures:
    - name: "total_hse_plans"
      expr: COUNT(1)
      comment: "Total number of HSE plans in the system. Baseline metric for safety planning programme coverage."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status IN ('Approved', 'APPROVED', 'Active', 'ACTIVE') THEN 1 END)
      comment: "Number of currently approved and active HSE plans. Measures safety planning compliance — projects without approved plans are at regulatory risk."
    - name: "approved_plan_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status IN ('Approved', 'APPROVED', 'Active', 'ACTIVE') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HSE plans that are approved and active. Key compliance metric — target is 100% for all active projects."
    - name: "avg_lti_target"
      expr: AVG(CAST(lti_target AS DOUBLE))
      comment: "Average LTI frequency rate target across all HSE plans. Benchmarks the ambition level of the safety programme across the portfolio."
    - name: "avg_trir_target"
      expr: AVG(CAST(trir_target AS DOUBLE))
      comment: "Average Total Recordable Incident Rate target across all HSE plans. Tracks the stringency of safety performance commitments made to clients and regulators."
    - name: "expired_plan_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND plan_status NOT IN ('Superseded', 'SUPERSEDED', 'Closed', 'CLOSED') THEN 1 END)
      comment: "Number of HSE plans that have passed their expiry date without renewal. Tracks compliance risk from outdated safety plans."
    - name: "distinct_projects_with_approved_plans"
      expr: COUNT(DISTINCT CASE WHEN plan_status IN ('Approved', 'APPROVED', 'Active', 'ACTIVE') THEN construction_project_id END)
      comment: "Number of distinct projects with at least one approved HSE plan. Measures safety planning coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety training programme metrics tracking completion rates, certification status, and training effectiveness. Used by HSE managers and HR to ensure workforce competency and regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of safety training (induction, refresher, certification, emergency) for programme coverage analysis."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Whether the trainee attended, was absent, or withdrew — tracks training completion rates."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record (compliant, overdue, expired) for regulatory tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How training was delivered (classroom, online, on-the-job, simulation) for effectiveness analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the training was conducted for — enables project-level workforce competency tracking."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month training was conducted for trend analysis of training programme activity."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory — enables compliance gap analysis for required training."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Whether a certification was issued upon completion — tracks workforce certification programme output."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records. Baseline metric for training programme activity volume."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions. Measures training effectiveness and workforce competency levels."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total expenditure on safety training. Tracks investment in workforce competency development and regulatory compliance."
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of training sessions in hours. Benchmarks training intensity and informs programme design decisions."
    - name: "certification_issued_count"
      expr: COUNT(CASE WHEN certification_issued = TRUE THEN 1 END)
      comment: "Number of training completions resulting in a certification. Tracks workforce certification programme output and competency credentialing."
    - name: "mandatory_training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE AND attendance_status IN ('Attended', 'ATTENDED', 'Completed', 'COMPLETED') THEN 1 END) / NULLIF(COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of mandatory training records with confirmed attendance/completion. Critical compliance KPI — gaps indicate regulatory exposure and workforce safety risk."
    - name: "expiring_certifications_count"
      expr: COUNT(CASE WHEN certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of certifications expiring within the next 90 days. Leading indicator for proactive renewal scheduling to maintain workforce compliance."
    - name: "distinct_projects_with_training"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with recorded safety training activity. Measures training programme coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring compliance metrics tracking exceedances, regulatory notifications, and monitoring programme effectiveness. Used by HSE and environmental managers to manage permit compliance and regulatory obligations."
  source: "`vibe_construction_v1`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (noise, dust, water quality, air quality) for compliance analysis by parameter type."
    - name: "parameter_category"
      expr: parameter_category
      comment: "Broad category of environmental parameter for executive-level environmental compliance reporting."
    - name: "monitoring_record_status"
      expr: monitoring_record_status
      comment: "Status of the monitoring record (active, closed, under review) for data quality management."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the monitoring is associated with — enables project-level environmental compliance benchmarking."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis of environmental parameter levels and exceedance rates."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded the regulatory threshold — primary compliance indicator."
    - name: "reported_to_regulator"
      expr: reported_to_regulator
      comment: "Whether the exceedance was reported to the regulator — tracks regulatory notification compliance."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required following the measurement — tracks response to exceedances."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring measurements. Baseline metric for monitoring programme activity and coverage."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of measurements that exceeded regulatory thresholds. Primary environmental compliance KPI — drives regulatory notification and corrective action obligations."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of monitoring measurements that exceeded regulatory limits. Key environmental compliance health metric for executive and regulator reporting."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks central tendency of environmental parameter levels relative to thresholds."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude by which measurements exceeded thresholds. Measures severity of environmental exceedances — larger magnitudes indicate greater regulatory and reputational risk."
    - name: "unreported_exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = FALSE THEN 1 END)
      comment: "Number of exceedances not yet reported to the regulator. Tracks regulatory notification compliance gap — unreported exceedances create legal liability."
    - name: "distinct_projects_monitored"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active environmental monitoring. Measures environmental monitoring programme coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Toolbox meeting (TBM) programme metrics tracking attendance rates, frequency, and topic coverage. Used by HSE managers and site supervisors to ensure daily safety communication reaches the workforce."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (pre-start, weekly, emergency, topic-specific) for programme coverage analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Current status of the meeting record (planned, completed, cancelled) for programme compliance tracking."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "Category of HSE topic covered (hazard awareness, PPE, emergency procedures) for topic coverage analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the toolbox meeting was conducted on — enables project-level TBM programme compliance tracking."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month the meeting was held for trend analysis of TBM programme frequency and attendance."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Whether a corrective action was raised during the meeting — measures TBM effectiveness in identifying hazards."
    - name: "emergency_procedures_reviewed"
      expr: emergency_procedures_reviewed
      comment: "Whether emergency procedures were reviewed — tracks emergency preparedness communication coverage."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total number of toolbox meetings conducted. Baseline metric for safety communication programme activity."
    - name: "avg_attendance_rate_pct"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate across toolbox meetings. Key leading safety indicator — low attendance rates indicate workforce engagement gaps and increased incident risk."
    - name: "meetings_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END)
      comment: "Number of toolbox meetings that identified and raised corrective actions. Measures TBM effectiveness as a hazard identification tool."
    - name: "corrective_action_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that raised corrective actions. Tracks TBM programme effectiveness in surfacing site hazards."
    - name: "emergency_procedure_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included emergency procedure review. Measures emergency preparedness communication coverage across the workforce."
    - name: "distinct_projects_with_tbm"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with recorded toolbox meeting activity. Measures TBM programme coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_ppe_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPE register metrics tracking issuance, compliance, and cost of personal protective equipment. Used by HSE managers to ensure workforce PPE compliance and manage PPE programme costs."
  source: "`vibe_construction_v1`.`safety`.`ppe_register`"
  dimensions:
    - name: "ppe_category"
      expr: ppe_category
      comment: "Category of PPE (head protection, eye protection, respiratory, fall protection) for coverage and cost analysis."
    - name: "item_type"
      expr: item_type
      comment: "Specific type of PPE item for granular inventory and compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PPE record (compliant, non-compliant, expired) for regulatory tracking."
    - name: "issuance_status"
      expr: issuance_status
      comment: "Whether PPE has been issued, returned, or is pending — tracks PPE inventory and issuance programme."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the PPE was issued for — enables project-level PPE cost and compliance tracking."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month PPE was issued for trend analysis of issuance volumes and costs."
    - name: "fit_test_required"
      expr: fit_test_required
      comment: "Whether a fit test is required for this PPE item — tracks respiratory protection programme compliance."
  measures:
    - name: "total_ppe_records"
      expr: COUNT(1)
      comment: "Total number of PPE issuance records. Baseline metric for PPE programme activity and workforce coverage."
    - name: "total_ppe_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total cost of PPE issued. Tracks PPE programme expenditure for budget management and cost-per-worker analysis."
    - name: "avg_ppe_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of PPE items issued. Benchmarks PPE procurement efficiency and informs category-level cost optimisation."
    - name: "non_compliant_ppe_count"
      expr: COUNT(CASE WHEN compliance_status IN ('Non-Compliant', 'NON_COMPLIANT', 'Non Compliant') THEN 1 END)
      comment: "Number of PPE records with non-compliant status. Tracks PPE compliance gaps that create regulatory and safety risk."
    - name: "expired_ppe_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND issuance_status NOT IN ('Returned', 'RETURNED') THEN 1 END)
      comment: "Number of PPE items that have expired but are still in service. Tracks expired PPE risk — expired PPE may not provide adequate protection."
    - name: "fit_test_required_count"
      expr: COUNT(CASE WHEN fit_test_required = TRUE THEN 1 END)
      comment: "Number of PPE records requiring a fit test. Tracks respiratory protection programme compliance obligations."
    - name: "worker_acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN worker_acknowledgement = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPE issuances acknowledged by the worker. Measures PPE handover compliance — unacknowledged issuances create liability gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_chemical_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chemical register metrics tracking hazardous substance inventory, SDS compliance, and exposure limit management. Used by HSE managers to ensure chemical safety compliance and manage hazardous substance risk on site."
  source: "`vibe_construction_v1`.`safety`.`chemical_register`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "Hazard category of the chemical (flammable, toxic, corrosive, oxidising) for risk concentration analysis."
    - name: "chemical_family"
      expr: chemical_family
      comment: "Chemical family grouping for portfolio-level hazardous substance management."
    - name: "chemical_register_status"
      expr: chemical_register_status
      comment: "Current status of the chemical register entry (active, superseded, removed) for inventory management."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the chemical — enables prioritisation of control measures."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project where the chemical is in use — enables project-level hazardous substance inventory management."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the substance is classified as hazardous — primary filter for regulatory compliance reporting."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the most recent inspection of the chemical storage — tracks storage compliance."
  measures:
    - name: "total_chemicals_registered"
      expr: COUNT(1)
      comment: "Total number of chemicals in the register. Baseline metric for hazardous substance inventory scope."
    - name: "hazardous_chemical_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous chemicals on site. Tracks hazardous substance exposure scope — drives regulatory notification and control obligations."
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of chemicals on site (in native units). Tracks inventory levels for threshold quantity compliance and emergency planning."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across chemicals requiring temperature control. Monitors storage condition compliance for temperature-sensitive substances."
    - name: "sds_overdue_count"
      expr: COUNT(CASE WHEN sds_last_updated < DATE_ADD(CURRENT_DATE(), -365) THEN 1 END)
      comment: "Number of chemicals with Safety Data Sheets not updated in the past year. Tracks SDS currency compliance — outdated SDS creates regulatory and safety risk."
    - name: "unverified_quantity_count"
      expr: COUNT(CASE WHEN is_quantities_verified = FALSE THEN 1 END)
      comment: "Number of chemicals where on-site quantities have not been verified. Tracks inventory verification compliance — unverified quantities undermine emergency response planning."
    - name: "distinct_projects_with_chemicals"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with registered chemicals. Measures hazardous substance management programme coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_swms`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safe Work Method Statement (SWMS) metrics tracking approval status, review currency, and high-risk work coverage. Used by HSE managers to ensure all high-risk construction work has current, approved SWMS in place."
  source: "`vibe_construction_v1`.`safety`.`swms`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of high-risk construction activity covered by the SWMS (working at height, excavation, demolition) for coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the SWMS (draft, approved, expired, superseded) for compliance tracking."
    - name: "initial_risk_rating"
      expr: initial_risk_rating
      comment: "Initial risk rating of the activity before controls — measures the risk profile of work covered by SWMS."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls — measures SWMS control effectiveness."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project the SWMS applies to — enables project-level SWMS coverage and compliance tracking."
    - name: "swms_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the SWMS was issued for trend analysis of SWMS programme activity."
    - name: "ptw_required"
      expr: ptw_required
      comment: "Whether a permit to work is required alongside this SWMS — links SWMS to PTW programme for high-risk activities."
    - name: "worker_acknowledgement_required"
      expr: worker_acknowledgement_required
      comment: "Whether workers must sign off on the SWMS — tracks workforce engagement with safety controls."
  measures:
    - name: "total_swms"
      expr: COUNT(1)
      comment: "Total number of SWMS in the system. Baseline metric for high-risk work control programme coverage."
    - name: "approved_swms_count"
      expr: COUNT(CASE WHEN approval_status IN ('Approved', 'APPROVED') THEN 1 END)
      comment: "Number of currently approved SWMS. Measures SWMS programme compliance — unapproved SWMS for active work creates regulatory and safety risk."
    - name: "approved_swms_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status IN ('Approved', 'APPROVED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SWMS that are approved. Key compliance KPI — target is 100% for all active high-risk work activities."
    - name: "expired_swms_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND approval_status NOT IN ('Superseded', 'SUPERSEDED') THEN 1 END)
      comment: "Number of SWMS that have expired. Tracks SWMS currency compliance — expired SWMS for active work creates regulatory liability."
    - name: "high_residual_risk_swms_count"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'HIGH', 'Extreme', 'EXTREME') THEN 1 END)
      comment: "Number of SWMS where residual risk remains high or extreme after controls. Identifies activities requiring additional risk mitigation or management escalation."
    - name: "ptw_linked_swms_count"
      expr: COUNT(CASE WHEN ptw_required = TRUE THEN 1 END)
      comment: "Number of SWMS requiring an associated permit to work. Measures the volume of highest-risk activities requiring dual-control (SWMS + PTW)."
    - name: "distinct_projects_with_swms"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active SWMS. Measures high-risk work control programme coverage across the project portfolio."
$$;