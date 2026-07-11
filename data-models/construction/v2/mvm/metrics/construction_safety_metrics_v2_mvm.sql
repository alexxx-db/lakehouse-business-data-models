-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident metrics tracking lost-time injuries, recordable incidents, and severity for regulatory compliance and safety performance management."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (e.g., injury, near-miss, property damage)"
    - name: "severity"
      expr: severity
      comment: "Incident severity classification"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, closed, under investigation)"
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating if incident resulted in lost time injury"
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating if incident is OSHA recordable"
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (employee, contractor, visitor)"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the injury"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the incident"
    - name: "incident_year"
      expr: YEAR(occurred_at)
      comment: "Year the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred"
    - name: "shift"
      expr: shift
      comment: "Work shift during which incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents"
    - name: "lti_count"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of lost-time injuries - critical safety KPI for regulatory reporting and safety performance"
    - name: "osha_recordable_count"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA recordable incidents - required for regulatory compliance reporting"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS BIGINT))
      comment: "Total days away from work due to incidents - measures severity impact on workforce availability"
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total property damage costs from incidents - financial impact metric for risk management"
    - name: "avg_days_away_per_incident"
      expr: AVG(CAST(days_away_from_work AS BIGINT))
      comment: "Average days away from work per incident - severity indicator"
    - name: "environmental_incident_count"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of environmental incidents - tracks environmental safety performance"
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_status IS NOT NULL THEN 1 END)
      comment: "Count of incidents requiring regulatory notification - compliance tracking metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE inspection quality and compliance metrics tracking deficiency rates, stop-work orders, and PPE compliance for proactive safety management."
  source: "`vibe_construction_v1`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection conducted"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the inspection (pass, fail, conditional)"
    - name: "highest_deficiency_severity"
      expr: highest_deficiency_severity
      comment: "Highest severity level of deficiencies found"
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Flag indicating if stop-work order was issued"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating if corrective action is required"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was conducted"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was conducted"
    - name: "site_area"
      expr: site_area
      comment: "Site area where inspection was conducted"
    - name: "drill_type"
      expr: drill_type
      comment: "Type of emergency drill conducted (if applicable)"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of HSE inspections conducted"
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total deficiencies identified across all inspections - measures safety compliance gaps"
    - name: "critical_deficiencies"
      expr: SUM(CAST(critical_deficiency_count AS BIGINT))
      comment: "Total critical deficiencies requiring immediate action - high-priority safety risk indicator"
    - name: "stop_work_order_count"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of inspections resulting in stop-work orders - critical safety intervention metric"
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across inspections - worker safety behavior indicator"
    - name: "total_items_checked"
      expr: SUM(CAST(total_items_checked AS BIGINT))
      comment: "Total inspection items checked - measures inspection thoroughness"
    - name: "avg_drill_response_time"
      expr: AVG(CAST(drill_response_time_seconds AS BIGINT))
      comment: "Average emergency drill response time in seconds - emergency preparedness metric"
    - name: "avg_drill_muster_accuracy"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage for emergency drills - evacuation effectiveness metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit-to-work control metrics tracking high-risk work authorization, isolation compliance, and permit lifecycle for critical work safety management."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit to work (hot work, confined space, electrical, etc.)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (active, closed, suspended)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification for the permitted work"
    - name: "isolation_required"
      expr: isolation_required
      comment: "Flag indicating if isolation is required"
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Flag indicating if gas testing is required"
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Flag indicating if toolbox meeting was conducted before work"
    - name: "concurrent_permit_flag"
      expr: concurrent_permit_flag
      comment: "Flag indicating if multiple permits are active concurrently"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag indicating potential environmental impact"
    - name: "issued_year"
      expr: YEAR(issued_timestamp)
      comment: "Year the permit was issued"
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued"
  measures:
    - name: "total_permits_issued"
      expr: COUNT(1)
      comment: "Total number of permits to work issued"
    - name: "high_risk_permits"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk permits - tracks volume of critical safety-controlled work"
    - name: "permits_requiring_isolation"
      expr: COUNT(CASE WHEN isolation_required = TRUE THEN 1 END)
      comment: "Count of permits requiring isolation - measures hazardous energy control work volume"
    - name: "permits_with_gas_testing"
      expr: COUNT(CASE WHEN gas_test_required = TRUE THEN 1 END)
      comment: "Count of permits requiring gas testing - tracks atmospheric hazard work"
    - name: "total_permit_extensions"
      expr: SUM(CAST(extension_count AS BIGINT))
      comment: "Total permit extensions - indicates work planning accuracy and schedule adherence"
    - name: "avg_worker_count_per_permit"
      expr: AVG(CAST(worker_count AS BIGINT))
      comment: "Average number of workers per permit - workforce exposure metric"
    - name: "tbm_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits with toolbox meetings conducted - pre-work safety briefing compliance"
    - name: "concurrent_permit_count"
      expr: COUNT(CASE WHEN concurrent_permit_flag = TRUE THEN 1 END)
      comment: "Count of concurrent permits - tracks complexity and coordination risk"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazard identification and risk control metrics tracking residual risk levels, control effectiveness, and hazard closure rates for proactive risk management."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of the identified hazard"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Specific type of hazard"
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (open, closed, under review)"
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Initial risk level before controls"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls applied"
    - name: "hierarchy_of_controls"
      expr: hierarchy_of_controls
      comment: "Hierarchy of controls applied (elimination, substitution, engineering, admin, PPE)"
    - name: "identification_source"
      expr: identification_source
      comment: "Source of hazard identification (inspection, incident, audit, etc.)"
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag indicating if hazard has environmental aspect"
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Flag indicating if permit to work is required"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating if regulatory notification is required"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the hazard was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the hazard was identified"
    - name: "site_zone"
      expr: site_zone
      comment: "Site zone where hazard is located"
  measures:
    - name: "total_hazards_registered"
      expr: COUNT(1)
      comment: "Total number of hazards in the register"
    - name: "high_residual_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level = 'High' THEN 1 END)
      comment: "Count of hazards with high residual risk after controls - critical risk exposure metric"
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status = 'Open' THEN 1 END)
      comment: "Count of open hazards requiring action - active risk backlog indicator"
    - name: "closed_hazards"
      expr: COUNT(CASE WHEN hazard_status = 'Closed' THEN 1 END)
      comment: "Count of closed hazards - risk mitigation completion metric"
    - name: "hazards_requiring_ptw"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Count of hazards requiring permit to work - high-risk work volume indicator"
    - name: "environmental_hazards"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of hazards with environmental aspects - environmental risk tracking"
    - name: "total_affected_workers"
      expr: SUM(CAST(affected_workers_count AS BIGINT))
      comment: "Total workers affected by registered hazards - workforce exposure metric"
    - name: "avg_affected_workers_per_hazard"
      expr: AVG(CAST(affected_workers_count AS BIGINT))
      comment: "Average workers affected per hazard - exposure concentration indicator"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety training effectiveness and compliance metrics tracking completion rates, certification status, and competency assessment for workforce safety capability."
  source: "`vibe_construction_v1`.`safety`.`training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of safety training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (classroom, online, on-site)"
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status (attended, absent, partial)"
    - name: "assessment_result"
      expr: assessment_result
      comment: "Result of training assessment (pass, fail, pending)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Training compliance status"
    - name: "certification_issued"
      expr: certification_issued
      comment: "Flag indicating if certification was issued"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating if training is mandatory"
    - name: "refresher_required"
      expr: refresher_required
      comment: "Flag indicating if refresher training is required"
    - name: "training_year"
      expr: YEAR(training_date)
      comment: "Year the training was conducted"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month the training was conducted"
    - name: "language_of_instruction"
      expr: language_of_instruction
      comment: "Language in which training was delivered"
  measures:
    - name: "total_training_sessions"
      expr: COUNT(1)
      comment: "Total number of training sessions conducted"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours delivered - measures training investment and workforce development"
    - name: "avg_training_duration"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score - training effectiveness and competency indicator"
    - name: "certifications_issued"
      expr: COUNT(CASE WHEN certification_issued = TRUE THEN 1 END)
      comment: "Count of certifications issued - qualified workforce metric"
    - name: "mandatory_training_completed"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE AND attendance_status = 'attended' THEN 1 END)
      comment: "Count of mandatory training sessions completed - compliance metric"
    - name: "training_pass_count"
      expr: COUNT(CASE WHEN assessment_result = 'pass' THEN 1 END)
      comment: "Count of training sessions passed - competency achievement metric"
    - name: "refresher_training_count"
      expr: COUNT(CASE WHEN refresher_required = TRUE THEN 1 END)
      comment: "Count of refresher training sessions - ongoing competency maintenance metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Toolbox meeting engagement and effectiveness metrics tracking attendance rates, hazard communication, and corrective action generation for daily safety briefings."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting"
    - name: "meeting_status"
      expr: meeting_status
      comment: "Status of the meeting (completed, cancelled, scheduled)"
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "HSE topic category discussed"
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Flag indicating if corrective action was raised"
    - name: "emergency_procedures_reviewed"
      expr: emergency_procedures_reviewed
      comment: "Flag indicating if emergency procedures were reviewed"
    - name: "ppe_requirements_communicated"
      expr: ppe_requirements_communicated
      comment: "Flag indicating if PPE requirements were communicated"
    - name: "incident_review_included"
      expr: incident_review_included
      comment: "Flag indicating if incident review was included"
    - name: "meeting_year"
      expr: YEAR(meeting_date)
      comment: "Year the meeting was held"
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month the meeting was held"
    - name: "trade_group"
      expr: trade_group
      comment: "Trade group attending the meeting"
    - name: "work_area_description"
      expr: work_area_description
      comment: "Work area where meeting was conducted"
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total number of toolbox meetings conducted"
    - name: "total_planned_attendees"
      expr: SUM(CAST(planned_attendee_count AS BIGINT))
      comment: "Total planned attendees across all meetings"
    - name: "total_actual_attendees"
      expr: SUM(CAST(actual_attendee_count AS BIGINT))
      comment: "Total actual attendees across all meetings"
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate percentage - worker engagement in safety briefings indicator"
    - name: "avg_meeting_duration"
      expr: AVG(CAST(duration_minutes AS BIGINT))
      comment: "Average meeting duration in minutes"
    - name: "meetings_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END)
      comment: "Count of meetings generating corrective actions - proactive hazard identification metric"
    - name: "meetings_with_emergency_review"
      expr: COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END)
      comment: "Count of meetings reviewing emergency procedures - emergency preparedness metric"
    - name: "meetings_with_incident_review"
      expr: COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END)
      comment: "Count of meetings including incident review - lessons learned communication metric"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident investigation quality and closure metrics tracking root cause analysis completion, corrective action status, and regulatory reporting for continuous safety improvement."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation conducted"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "incident_classification"
      expr: incident_classification
      comment: "Classification of the incident being investigated"
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the incident"
    - name: "root_cause_description"
      expr: root_cause_description
      comment: "Description of the root cause identified"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating if incident was a lost-time injury"
    - name: "is_recordable"
      expr: is_recordable
      comment: "Flag indicating if incident is recordable"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag indicating if incident requires regulatory reporting"
    - name: "investigation_methodology"
      expr: investigation_methodology
      comment: "Methodology used for investigation (5-Why, Fishbone, etc.)"
    - name: "investigation_year"
      expr: YEAR(investigation_start_date)
      comment: "Year the investigation started"
    - name: "investigation_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month the investigation started"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations"
    - name: "lti_investigations"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of lost-time injury investigations - serious incident investigation volume"
    - name: "recordable_investigations"
      expr: COUNT(CASE WHEN is_recordable = TRUE THEN 1 END)
      comment: "Count of recordable incident investigations - regulatory compliance metric"
    - name: "regulatory_reportable_investigations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations requiring regulatory reporting - compliance tracking"
    - name: "closed_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END)
      comment: "Count of closed investigations - investigation completion metric"
    - name: "total_lost_time_days"
      expr: SUM(CAST(lost_time_days AS BIGINT))
      comment: "Total lost time days from investigated incidents - severity impact metric"
    - name: "avg_lost_time_days"
      expr: AVG(CAST(lost_time_days AS BIGINT))
      comment: "Average lost time days per investigation - incident severity indicator"
    - name: "total_witness_count"
      expr: SUM(CAST(witness_count AS BIGINT))
      comment: "Total witnesses across all investigations - investigation thoroughness indicator"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment effectiveness metrics tracking residual risk reduction, control measure implementation, and assessment currency for systematic risk management."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment conducted"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard assessed"
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Initial risk level before controls"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls"
    - name: "control_hierarchy"
      expr: control_hierarchy
      comment: "Hierarchy of controls applied"
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Flag indicating environmental aspect"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating if corrective action is required"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted"
    - name: "site_zone"
      expr: site_zone
      comment: "Site zone where assessment was conducted"
    - name: "source_type"
      expr: source_type
      comment: "Source type of the risk assessment"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted"
    - name: "high_initial_risk_assessments"
      expr: COUNT(CASE WHEN initial_risk_level = 'High' THEN 1 END)
      comment: "Count of assessments with high initial risk - pre-control risk exposure"
    - name: "high_residual_risk_assessments"
      expr: COUNT(CASE WHEN residual_risk_level = 'High' THEN 1 END)
      comment: "Count of assessments with high residual risk after controls - persistent high-risk activities requiring management attention"
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action - risk mitigation workload indicator"
    - name: "environmental_risk_assessments"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of assessments with environmental aspects - environmental risk management metric"
    - name: "approved_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Approved' THEN 1 END)
      comment: "Count of approved risk assessments - risk management process completion"
$$;