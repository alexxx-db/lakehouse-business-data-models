-- Metric views for domain: safety | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_hse_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core HSE incident metrics tracking workplace safety performance, incident severity, and operational risk exposure across transport and shipping operations."
  source: "`transport_shipping_ecm`.`safety`.`hse_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the HSE incident (e.g., injury, near-miss, property damage, spill)"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity level of the incident for risk stratification"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where incident occurred (warehouse, transit, dock, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (open, investigating, closed)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause for systemic trend analysis"
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred"
    - name: "incident_year"
      expr: YEAR(incident_datetime)
      comment: "Year the incident occurred for annual trending"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_datetime)
      comment: "Month the incident occurred for monthly trending"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable"
    - name: "dangerous_goods_involved_flag"
      expr: dangerous_goods_involved_flag
      comment: "Whether dangerous goods were involved in the incident"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the incident requires regulatory reporting"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total count of HSE incidents for frequency rate calculations"
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Count of OSHA recordable incidents — key regulatory compliance metric"
    - name: "dangerous_goods_incidents"
      expr: COUNT(CASE WHEN dangerous_goods_involved_flag = TRUE THEN 1 END)
      comment: "Count of incidents involving dangerous goods — critical for DG compliance"
    - name: "regulatory_reportable_incidents"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory notification"
    - name: "property_damage_incidents"
      expr: COUNT(CASE WHEN property_damage_flag = TRUE THEN 1 END)
      comment: "Count of incidents with property damage for loss prevention"
    - name: "total_estimated_damage_cost"
      expr: SUM(CAST(estimated_damage_cost AS DOUBLE))
      comment: "Total estimated financial impact of incident-related damages"
    - name: "avg_estimated_damage_cost"
      expr: AVG(CAST(estimated_damage_cost AS DOUBLE))
      comment: "Average damage cost per incident for severity benchmarking"
    - name: "total_spill_volume_liters"
      expr: SUM(CAST(spill_volume_liters AS DOUBLE))
      comment: "Total spill volume in liters — environmental risk indicator"
    - name: "incidents_with_corrective_actions_pending"
      expr: COUNT(CASE WHEN corrective_actions_completed_flag = FALSE THEN 1 END)
      comment: "Incidents where corrective actions remain incomplete — risk exposure indicator"
    - name: "distinct_facilities_with_incidents"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities reporting incidents — spread indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_driver_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Driver safety event metrics measuring fleet driver behavior, coaching effectiveness, and road safety risk across the transport network."
  source: "`transport_shipping_ecm`.`safety`.`driver_safety_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of driver safety event (harsh braking, speeding, distraction, etc.)"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity classification of the safety event"
    - name: "event_source"
      expr: event_source
      comment: "Source system that detected the event (telematics, dashcam, manual report)"
    - name: "road_condition"
      expr: road_condition
      comment: "Road condition at time of event for contextual analysis"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of event"
    - name: "traffic_condition"
      expr: traffic_condition
      comment: "Traffic condition at time of event"
    - name: "coaching_required_flag"
      expr: coaching_required_flag
      comment: "Whether the event triggered a coaching requirement"
    - name: "violation_flag"
      expr: violation_flag
      comment: "Whether the event constitutes a traffic violation"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the event was deemed preventable"
    - name: "supervisor_review_status"
      expr: supervisor_review_status
      comment: "Status of supervisor review for the event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the safety event for trend analysis"
  measures:
    - name: "total_safety_events"
      expr: COUNT(1)
      comment: "Total driver safety events — baseline for frequency rate calculations"
    - name: "violation_events"
      expr: COUNT(CASE WHEN violation_flag = TRUE THEN 1 END)
      comment: "Count of events classified as violations"
    - name: "preventable_events"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END)
      comment: "Count of preventable safety events — key coaching opportunity metric"
    - name: "coaching_required_events"
      expr: COUNT(CASE WHEN coaching_required_flag = TRUE THEN 1 END)
      comment: "Events requiring coaching intervention"
    - name: "coaching_completed_events"
      expr: COUNT(CASE WHEN coaching_completed_flag = TRUE THEN 1 END)
      comment: "Events where coaching has been completed — measures coaching follow-through"
    - name: "avg_speed_over_limit_kph"
      expr: AVG(CAST(speed_over_limit_kph AS DOUBLE))
      comment: "Average speed over posted limit — speeding severity indicator"
    - name: "avg_g_force_value"
      expr: AVG(CAST(g_force_value AS DOUBLE))
      comment: "Average g-force across events — harsh driving intensity measure"
    - name: "avg_safety_score_impact"
      expr: AVG(CAST(safety_score_impact AS DOUBLE))
      comment: "Average safety score impact per event — driver performance degradation measure"
    - name: "distinct_drivers_with_events"
      expr: COUNT(DISTINCT driver_profile_id)
      comment: "Number of distinct drivers with safety events — risk population sizing"
    - name: "incident_reported_events"
      expr: COUNT(CASE WHEN incident_reported_flag = TRUE THEN 1 END)
      comment: "Events that escalated to formal incident reports"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action lifecycle metrics tracking closure rates, overdue actions, cost of remediation, and effectiveness of safety improvements."
  source: "`transport_shipping_ecm`.`safety`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, closed, overdue)"
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (preventive, corrective, improvement)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "hazard_category"
      expr: hazard_category
      comment: "Hazard category the action addresses"
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of effectiveness review — measures if action resolved the issue"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the corrective action completion"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the action has been escalated due to delays or severity"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required as part of the corrective action"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for executing the corrective action"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the corrective action was created for trend analysis"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions — workload and safety culture indicator"
    - name: "escalated_actions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated corrective actions — management attention required"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions — safety investment tracking"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions — budget planning metric"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per corrective action — unit economics of safety remediation"
    - name: "actions_with_training_required"
      expr: COUNT(CASE WHEN training_required_flag = TRUE THEN 1 END)
      comment: "Actions requiring training — identifies systemic competency gaps"
    - name: "distinct_facilities_with_actions"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of facilities with open corrective actions — risk spread indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety audit performance metrics tracking audit scores, findings density, duration efficiency, and compliance posture across facilities and partners."
  source: "`transport_shipping_ecm`.`safety`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, certification)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "overall_audit_rating"
      expr: overall_audit_rating
      comment: "Overall rating/grade assigned to the audit"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility audited"
    - name: "department"
      expr: department
      comment: "Department audited"
    - name: "standard"
      expr: standard
      comment: "Standard or framework the audit was conducted against (ISO 45001, etc.)"
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required — indicates non-conformance"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month the audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of safety audits conducted"
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score — overall safety management system health indicator"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average audit duration in hours — efficiency and scope indicator"
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END)
      comment: "Audits requiring follow-up — non-conformance prevalence"
    - name: "distinct_facilities_audited"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities audited — audit coverage metric"
    - name: "distinct_partners_audited"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct partners audited — supply chain safety oversight"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety audit finding metrics tracking finding severity, closure performance, regulatory exposure, and cost impact of non-conformances."
  source: "`transport_shipping_ecm`.`safety`.`safety_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (major non-conformance, minor non-conformance, observation, opportunity)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed, overdue)"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding for thematic analysis"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the finding requires regulatory reporting"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding — indicates systemic failure"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "audit_program_type"
      expr: audit_program_type
      comment: "Type of audit program under which finding was identified"
    - name: "finding_month"
      expr: DATE_TRUNC('month', finding_date)
      comment: "Month the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total audit findings — safety management system gap indicator"
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Count of repeat findings — systemic failure indicator requiring management intervention"
    - name: "regulatory_reportable_findings"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Findings requiring regulatory reporting — compliance risk exposure"
    - name: "total_cost_impact_estimate"
      expr: SUM(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Total estimated cost impact of findings — financial risk quantification"
    - name: "avg_cost_impact_estimate"
      expr: AVG(CAST(cost_impact_estimate AS DOUBLE))
      comment: "Average cost impact per finding — severity benchmarking"
    - name: "findings_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Findings requiring corrective action — remediation workload indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_environmental_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental incident metrics tracking spill volumes, remediation costs, regulatory penalties, and environmental compliance across operations."
  source: "`transport_shipping_ecm`.`safety`.`environmental_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of environmental incident (spill, release, contamination)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the environmental incident"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the environmental incident"
    - name: "environmental_media_affected"
      expr: environmental_media_affected
      comment: "Environmental media affected (soil, water, air)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic prevention"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where incident occurred"
    - name: "country_code"
      expr: country_code
      comment: "Country where the incident occurred for jurisdictional analysis"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification was required"
    - name: "penalty_assessed_flag"
      expr: penalty_assessed_flag
      comment: "Whether a regulatory penalty was assessed"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_datetime)
      comment: "Month of the environmental incident"
  measures:
    - name: "total_environmental_incidents"
      expr: COUNT(1)
      comment: "Total environmental incidents — ESG and compliance risk indicator"
    - name: "total_quantity_released"
      expr: SUM(CAST(quantity_released AS DOUBLE))
      comment: "Total quantity of substance released — environmental impact magnitude"
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Total actual remediation costs incurred"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalties assessed — financial compliance risk"
    - name: "avg_remediation_cost"
      expr: AVG(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per incident"
    - name: "incidents_with_penalties"
      expr: COUNT(CASE WHEN penalty_assessed_flag = TRUE THEN 1 END)
      comment: "Incidents resulting in regulatory penalties"
    - name: "incidents_requiring_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Incidents requiring regulatory notification — compliance burden indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility inspection metrics tracking inspection scores, deficiency rates, and compliance status across the warehouse and logistics network."
  source: "`transport_shipping_ecm`.`safety`.`facility_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "overall_inspection_result"
      expr: overall_inspection_result
      comment: "Overall pass/fail/conditional result of the inspection"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status determined by inspection"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on inspection findings"
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Whether a follow-up inspection is needed"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the inspection for trend analysis"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total facility inspections conducted"
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score — facility safety health indicator"
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Inspections that identified corrective action needs"
    - name: "inspections_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Inspections requiring follow-up — persistent non-conformance indicator"
    - name: "distinct_facilities_inspected"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities inspected — coverage metric"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety training completion metrics tracking training investment, assessment performance, compliance rates, and workforce safety competency."
  source: "`transport_shipping_ecm`.`safety`.`safety_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of training completion (completed, in-progress, failed, expired)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (classroom, online, blended, on-the-job)"
    - name: "dangerous_goods_category"
      expr: dangerous_goods_category
      comment: "DG category for dangerous goods specific training"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether the training is a regulatory requirement"
    - name: "recertification_required_flag"
      expr: recertification_required_flag
      comment: "Whether recertification is required"
    - name: "training_language"
      expr: training_language
      comment: "Language in which training was delivered"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month of training completion"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training completions — workforce safety readiness volume"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score — workforce competency level indicator"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost — safety training investment tracking"
    - name: "total_attendance_hours"
      expr: SUM(CAST(attendance_hours AS DOUBLE))
      comment: "Total attendance hours — training effort and capacity utilization"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration — efficiency of training delivery"
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees who completed training — workforce coverage metric"
    - name: "regulatory_required_completions"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Completions for regulatory-required training — compliance assurance"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety observation metrics measuring proactive safety culture through observation reporting rates, risk identification, and action closure performance."
  source: "`transport_shipping_ecm`.`safety`.`observation`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of observation (safe act, unsafe act, unsafe condition, near-miss)"
    - name: "observation_category"
      expr: observation_category
      comment: "Category of the observation for thematic analysis"
    - name: "observation_status"
      expr: observation_status
      comment: "Current status of the observation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the observation"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where observation was made"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether the observation was escalated"
    - name: "immediate_action_flag"
      expr: immediate_action_flag
      comment: "Whether immediate action was required"
    - name: "follow_up_action_required_flag"
      expr: follow_up_action_required_flag
      comment: "Whether follow-up action is required"
    - name: "observation_month"
      expr: DATE_TRUNC('month', datetime)
      comment: "Month of the observation for trend analysis"
    - name: "shift"
      expr: shift
      comment: "Shift during which observation was made"
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total safety observations — leading indicator of safety culture maturity"
    - name: "escalated_observations"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Observations escalated due to severity — risk escalation rate"
    - name: "immediate_action_observations"
      expr: COUNT(CASE WHEN immediate_action_flag = TRUE THEN 1 END)
      comment: "Observations requiring immediate action — acute risk identification"
    - name: "observations_with_followup_required"
      expr: COUNT(CASE WHEN follow_up_action_required_flag = TRUE THEN 1 END)
      comment: "Observations requiring follow-up actions — open risk items"
    - name: "distinct_observers"
      expr: COUNT(DISTINCT observation_observer_employee_id)
      comment: "Distinct employees submitting observations — safety engagement breadth"
    - name: "distinct_facilities_observed"
      expr: COUNT(DISTINCT facility_id)
      comment: "Facilities with observations reported — observation coverage"
    - name: "recognition_given_observations"
      expr: COUNT(CASE WHEN recognition_given_flag = TRUE THEN 1 END)
      comment: "Observations where positive recognition was given — reinforcement of safe behaviors"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_dg_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dangerous goods incident metrics tracking DG-specific safety events, regulatory notifications, and financial exposure from hazardous materials handling."
  source: "`transport_shipping_ecm`.`safety`.`dg_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of DG incident (leak, spill, mislabel, undeclared, packaging failure)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the DG incident"
    - name: "hazard_class"
      expr: hazard_class
      comment: "UN hazard class of the dangerous goods involved"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport during the incident (air, sea, road, rail)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the DG incident occurred"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (IATA DGR, IMDG, ADR, 49 CFR)"
    - name: "environmental_release_flag"
      expr: environmental_release_flag
      comment: "Whether an environmental release occurred"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification was required"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_timestamp)
      comment: "Month of the DG incident"
  measures:
    - name: "total_dg_incidents"
      expr: COUNT(1)
      comment: "Total dangerous goods incidents — DG safety performance baseline"
    - name: "total_quantity_involved"
      expr: SUM(CAST(quantity_involved AS DOUBLE))
      comment: "Total quantity of dangerous goods involved in incidents"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of DG incidents — financial exposure"
    - name: "environmental_release_incidents"
      expr: COUNT(CASE WHEN environmental_release_flag = TRUE THEN 1 END)
      comment: "DG incidents with environmental release — highest severity category"
    - name: "regulatory_notifiable_incidents"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "DG incidents requiring regulatory notification — compliance burden"
    - name: "distinct_hazard_classes_involved"
      expr: COUNT(DISTINCT hazard_class)
      comment: "Number of distinct hazard classes involved — risk diversity indicator"
$$;


CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`safety_osha_recordable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA recordable case metrics for regulatory compliance reporting, injury/illness tracking, and lost-time analysis critical for TRIR and DART rate calculations."
  source: "`transport_shipping_ecm`.`safety`.`osha_recordable`"
  dimensions:
    - name: "case_classification"
      expr: case_classification
      comment: "OSHA case classification (death, days away, restricted duty, other recordable)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the OSHA recordable case"
    - name: "injury_illness_type"
      expr: injury_illness_type
      comment: "Type of injury or illness"
    - name: "nature_of_injury_illness"
      expr: nature_of_injury_illness
      comment: "Nature of the injury or illness"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the injury"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for prevention targeting"
    - name: "death_flag"
      expr: death_flag
      comment: "Whether the case resulted in a fatality"
    - name: "hospitalization_flag"
      expr: hospitalization_flag
      comment: "Whether the case required hospitalization"
    - name: "reporting_year"
      expr: reporting_year
      comment: "OSHA reporting year"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of the incident for trending"
  measures:
    - name: "total_osha_recordables"
      expr: COUNT(1)
      comment: "Total OSHA recordable cases — numerator for TRIR calculation"
    - name: "fatality_cases"
      expr: COUNT(CASE WHEN death_flag = TRUE THEN 1 END)
      comment: "Fatality cases — most critical safety outcome metric"
    - name: "hospitalization_cases"
      expr: COUNT(CASE WHEN hospitalization_flag = TRUE THEN 1 END)
      comment: "Cases requiring hospitalization — severe injury indicator"
    - name: "amputation_cases"
      expr: COUNT(CASE WHEN amputation_flag = TRUE THEN 1 END)
      comment: "Amputation cases — severe injury requiring immediate OSHA notification"
    - name: "distinct_employees_injured"
      expr: COUNT(DISTINCT employee_id)
      comment: "Distinct employees with recordable injuries — workforce impact breadth"
    - name: "distinct_facilities_with_recordables"
      expr: COUNT(DISTINCT facility_id)
      comment: "Facilities with OSHA recordables — risk concentration analysis"
$$;
