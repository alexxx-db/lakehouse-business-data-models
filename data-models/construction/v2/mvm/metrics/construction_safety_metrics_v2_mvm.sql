-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic safety incident KPIs tracking injury severity, lost-time events, recordable rates, and financial impact of property damage. Core dashboard for HSE leadership and executive steering."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g. near-miss, first-aid, LTI, environmental) for trend analysis by incident category."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident (e.g. low, medium, high, critical) used to prioritise corrective actions and escalation."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident record (e.g. open, under investigation, closed)."
    - name: "is_lti"
      expr: is_lti
      comment: "Boolean flag indicating whether the incident resulted in a Lost Time Injury, the primary lagging safety indicator."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Boolean flag indicating OSHA recordability, required for regulatory compliance reporting."
    - name: "is_environmental_event"
      expr: is_environmental_event
      comment: "Boolean flag distinguishing environmental incidents from personnel safety incidents for separate regulatory tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause grouping (e.g. human error, equipment failure, procedural gap) to drive systemic corrective actions."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (e.g. direct employee, subcontractor, visitor) for workforce safety segmentation."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred, enabling shift-pattern safety analysis."
    - name: "site_area"
      expr: site_area
      comment: "Physical area of the site where the incident occurred, used for hotspot identification."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred, enabling monthly trend and seasonality analysis."
    - name: "incident_year"
      expr: YEAR(occurred_at)
      comment: "Year the incident occurred for annual performance benchmarking."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification (e.g. notified, pending, not required) for compliance tracking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded safety incidents. Baseline KPI for overall safety performance and TRIR denominator."
    - name: "total_lti_incidents"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of Lost Time Injury incidents. Primary lagging safety indicator used in LTIFR calculations and executive reporting."
    - name: "total_osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Required for regulatory compliance and TRIR calculation."
    - name: "total_environmental_incidents"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of environmental incidents. Tracks environmental liability exposure and regulatory notification obligations."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total financial value of property damage from incidents. Directly informs insurance, risk provisioning, and cost-of-safety decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Tracks severity trend of damage-causing events over time."
    - name: "lti_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lti = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Percentage of incidents that resulted in a Lost Time Injury. Key safety performance ratio for executive dashboards and client reporting."
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Percentage of incidents that are OSHA-recordable. Tracks regulatory exposure and compliance posture."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('closed', 'Closed') THEN 1 END)
      comment: "Count of incidents not yet closed. Measures backlog of unresolved safety events requiring management attention."
    - name: "incidents_pending_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_status IN ('pending', 'Pending') THEN 1 END)
      comment: "Count of incidents where regulatory notification is pending. Tracks compliance risk from overdue notifications."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation quality and closure KPIs measuring investigation timeliness, corrective action completion, and recurrence prevention effectiveness. Used by HSE managers to drive accountability and systemic improvement."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (e.g. open, in progress, closed) for workload and backlog management."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g. RCA, 5-Why, bow-tie) for quality benchmarking."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the underlying incident being investigated, enabling trend analysis by incident type."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Severity classification of the incident (e.g. minor, serious, critical) driving investigation depth requirements."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation (e.g. open, in progress, completed)."
    - name: "is_lti"
      expr: is_lti
      comment: "Boolean flag indicating whether the investigated incident was a Lost Time Injury."
    - name: "is_recordable"
      expr: is_recordable
      comment: "Boolean flag indicating whether the investigated incident is recordable for regulatory purposes."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Boolean flag indicating whether the investigation outcome must be reported to a regulator."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party in the investigated incident for workforce segmentation."
    - name: "investigation_start_month"
      expr: DATE_TRUNC('MONTH', investigation_start_date)
      comment: "Month the investigation was initiated for trend and capacity planning analysis."
    - name: "investigation_year"
      expr: YEAR(investigation_start_date)
      comment: "Year the investigation was initiated for annual performance benchmarking."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations. Baseline volume metric for investigation workload management."
    - name: "open_investigations"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('closed', 'Closed', 'complete', 'Complete') THEN 1 END)
      comment: "Count of investigations not yet closed. Tracks backlog and accountability for timely resolution."
    - name: "investigations_with_completed_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status IN ('completed', 'Completed', 'closed', 'Closed') THEN 1 END)
      comment: "Count of investigations where corrective actions have been fully completed. Measures follow-through on safety improvement commitments."
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status IN ('completed', 'Completed', 'closed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations with completed corrective actions. Key accountability KPI for HSE leadership and client reporting."
    - name: "lti_investigation_count"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of investigations for Lost Time Injury incidents. Tracks the most serious injury events requiring full investigation."
    - name: "regulatory_reportable_investigation_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations with regulatory reporting obligations. Tracks compliance exposure from serious incidents."
    - name: "avg_investigation_duration_days"
      expr: AVG(CAST(DATEDIFF(investigation_close_date, investigation_start_date) AS DOUBLE))
      comment: "Average number of days from investigation start to close. Measures investigation timeliness and process efficiency."
    - name: "investigations_with_swms_in_place"
      expr: COUNT(CASE WHEN swms_in_place_flag = TRUE THEN 1 END)
      comment: "Count of investigations where a SWMS was in place at the time of the incident. Informs whether procedural controls were adequate."
    - name: "swms_in_place_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN swms_in_place_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigated incidents where a SWMS was in place. Measures procedural control coverage at time of incident."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSE inspection performance KPIs covering deficiency rates, PPE compliance, stop-work authority usage, and drill effectiveness. Used by site managers and HSE teams to monitor field safety standards."
  source: "`vibe_construction_v1`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g. routine, audit, pre-start, regulatory) for performance segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g. open, completed, overdue)."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail/conditional result of the inspection for compliance rate tracking."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Boolean flag indicating whether the inspection was planned or reactive, for schedule adherence analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether the inspection raised corrective actions requiring follow-up."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Boolean flag indicating whether a stop-work order was issued during the inspection. Tracks use of highest-level safety intervention."
    - name: "highest_deficiency_severity"
      expr: highest_deficiency_severity
      comment: "Severity of the most critical deficiency found during the inspection for risk prioritisation."
    - name: "drill_type"
      expr: drill_type
      comment: "Type of emergency drill conducted (e.g. evacuation, fire, spill) for drill programme coverage analysis."
    - name: "site_area"
      expr: site_area
      comment: "Site area inspected for spatial hotspot analysis of deficiencies."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis and scheduling compliance."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for annual safety programme performance review."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of HSE inspections conducted. Baseline volume metric for inspection programme activity."
    - name: "inspections_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections that identified deficiencies requiring corrective action. Measures field non-compliance volume."
    - name: "corrective_action_raise_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that raised corrective actions. Key indicator of field safety standard compliance."
    - name: "stop_work_order_count"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of inspections where a stop-work order was issued. Tracks the most serious safety interventions on site."
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate across all inspections. Measures workforce adherence to personal protective equipment requirements."
    - name: "avg_drill_muster_accuracy_pct"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage across emergency drills. Measures effectiveness of emergency response preparedness."
    - name: "scheduled_inspection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_scheduled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that were planned vs reactive. Measures proactive safety management programme adherence."
    - name: "inspections_with_critical_deficiencies"
      expr: COUNT(CASE WHEN highest_deficiency_severity IN ('critical', 'Critical', 'high', 'High') THEN 1 END)
      comment: "Count of inspections with critical or high-severity deficiencies. Tracks the most serious field safety non-conformances."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazard management KPIs tracking open hazard volumes, risk level distribution, residual risk effectiveness, and closure performance. Used by HSE managers to demonstrate risk control adequacy to clients and regulators."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current lifecycle status of the hazard (e.g. open, under review, closed) for backlog management."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard (e.g. electrical, working at height, chemical) for risk programme prioritisation."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard for detailed classification and control measure selection."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls are applied (e.g. low, medium, high, extreme). Measures raw risk exposure."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls are applied. Measures effectiveness of risk mitigation programme."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Boolean flag indicating whether the hazard has an environmental dimension for environmental risk tracking."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Boolean flag indicating whether a permit to work is required to manage this hazard."
    - name: "tbm_topic_flag"
      expr: tbm_topic_flag
      comment: "Boolean flag indicating whether this hazard has been communicated in toolbox meetings."
    - name: "hierarchy_of_controls"
      expr: hierarchy_of_controls
      comment: "Control hierarchy applied (e.g. elimination, substitution, engineering, administrative, PPE) for control adequacy analysis."
    - name: "site_zone"
      expr: site_zone
      comment: "Site zone where the hazard exists for spatial risk mapping."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the hazard was identified for trend analysis of new hazard emergence."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of registered hazards. Baseline measure of hazard identification programme activity."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status NOT IN ('closed', 'Closed') THEN 1 END)
      comment: "Count of hazards not yet closed. Tracks unresolved risk exposure requiring active management."
    - name: "high_extreme_risk_hazards"
      expr: COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END)
      comment: "Count of hazards with high or extreme initial risk ratings. Tracks the most critical risk exposures on site."
    - name: "residual_high_extreme_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END)
      comment: "Count of hazards where residual risk remains high or extreme after controls. Measures inadequacy of current control measures."
    - name: "risk_reduction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') AND residual_risk_level NOT IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END), 0), 2)
      comment: "Percentage of high/extreme initial risk hazards successfully reduced to lower residual risk. Measures effectiveness of the risk control programme."
    - name: "hazards_requiring_ptw"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Count of hazards requiring a permit to work. Informs PTW programme scope and resource requirements."
    - name: "environmental_hazard_count"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of hazards with environmental aspects. Tracks environmental risk exposure for regulatory compliance."
    - name: "hazard_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazard_status IN ('closed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered hazards that have been closed. Measures risk management programme effectiveness and throughput."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit to Work (PTW) programme KPIs measuring permit volumes, active permit exposure, isolation compliance, and gas testing requirements. Critical for high-risk work authorisation governance and regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. hot work, confined space, electrical isolation, working at height) for risk-based programme analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g. draft, issued, active, suspended, closed) for active work authorisation tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work for high-risk work volume monitoring."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of authority required to approve the permit (e.g. supervisor, HSE manager, site director) for governance compliance."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Boolean flag indicating whether energy isolation is required for the permitted work."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Boolean flag indicating whether atmospheric gas testing is required before work commences."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Boolean flag indicating whether the permitted work has potential environmental impact."
    - name: "concurrent_permit_flag"
      expr: concurrent_permit_flag
      comment: "Boolean flag indicating concurrent permits in the same work area, a key risk indicator for simultaneous operations."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Boolean flag indicating whether a toolbox meeting was conducted before work commenced under this permit."
    - name: "permit_issued_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued for trend analysis of high-risk work activity volumes."
    - name: "issuing_authority_role"
      expr: issuing_authority_role
      comment: "Role of the person who issued the permit for governance and accountability analysis."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits to work issued. Baseline measure of high-risk work authorisation programme activity."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status IN ('active', 'Active', 'issued', 'Issued') THEN 1 END)
      comment: "Count of currently active or issued permits. Measures live high-risk work exposure on site at any point in time."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN permit_status IN ('suspended', 'Suspended') THEN 1 END)
      comment: "Count of suspended permits. Tracks work stoppages due to unsafe conditions, a leading safety indicator."
    - name: "permits_requiring_isolation"
      expr: COUNT(CASE WHEN isolation_required = TRUE THEN 1 END)
      comment: "Count of permits requiring energy isolation. Tracks exposure to energy isolation risk, a critical safety control."
    - name: "permits_requiring_gas_test"
      expr: COUNT(CASE WHEN gas_test_required = TRUE THEN 1 END)
      comment: "Count of permits requiring atmospheric gas testing. Tracks confined space and flammable atmosphere work volumes."
    - name: "concurrent_permit_count"
      expr: COUNT(CASE WHEN concurrent_permit_flag = TRUE THEN 1 END)
      comment: "Count of permits with concurrent operations in the same area. Tracks simultaneous operations risk, a major cause of serious incidents."
    - name: "tbm_conducted_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where a toolbox meeting was conducted before work. Measures pre-task safety briefing compliance."
    - name: "permit_extension_total"
      expr: SUM(CAST(extension_count AS DOUBLE))
      comment: "Total number of permit extensions granted. High extension volumes indicate poor work planning or scope creep in high-risk activities."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs tracking exceedance rates, regulatory notification compliance, and measurement coverage. Used by HSE and environmental managers to demonstrate regulatory compliance and manage environmental liability."
  source: "`vibe_construction_v1`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (e.g. noise, dust, water quality, air quality) for parameter-level compliance tracking."
    - name: "parameter_category"
      expr: parameter_category
      comment: "High-level category of the monitoring parameter (e.g. air, water, soil, noise) for programme coverage analysis."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Boolean flag indicating whether the measurement exceeded the regulatory or project threshold."
    - name: "threshold_type"
      expr: threshold_type
      comment: "Type of threshold exceeded (e.g. regulatory limit, project trigger level, action level) for compliance severity classification."
    - name: "reported_to_regulator"
      expr: reported_to_regulator
      comment: "Boolean flag indicating whether the exceedance was reported to the relevant regulator."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was raised in response to the monitoring result."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of monitoring instrument used for data quality and calibration programme management."
    - name: "monitoring_record_status"
      expr: monitoring_record_status
      comment: "Status of the monitoring record (e.g. draft, validated, submitted) for data governance tracking."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis of environmental parameter levels over time."
    - name: "monitoring_location_name"
      expr: monitoring_location_name
      comment: "Name of the monitoring location for spatial analysis of exceedances and hotspot identification."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the measurement record, used to filter valid data in compliance reporting."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of environmental measurements recorded. Baseline measure of monitoring programme activity and coverage."
    - name: "total_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Count of measurements that exceeded regulatory or project thresholds. Primary environmental compliance KPI."
    - name: "exceedance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Percentage of measurements that exceeded thresholds. Tracks environmental compliance performance over time and by parameter."
    - name: "unreported_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = FALSE THEN 1 END)
      comment: "Count of exceedances not yet reported to the regulator. Tracks regulatory notification compliance risk and potential enforcement exposure."
    - name: "regulatory_reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of exceedances that were reported to the regulator. Measures regulatory notification compliance for environmental incidents."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Average magnitude by which measurements exceeded thresholds. Measures severity of environmental exceedances, not just frequency."
    - name: "max_exceedance_magnitude"
      expr: MAX(CAST(exceedance_magnitude AS DOUBLE))
      comment: "Maximum exceedance magnitude recorded. Identifies worst-case environmental breaches for regulatory and reputational risk management."
    - name: "corrective_actions_raised_from_monitoring"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of monitoring results that triggered corrective actions. Measures environmental management response effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Toolbox meeting (TBM) programme KPIs measuring attendance rates, topic coverage, and safety communication effectiveness. Used by HSE managers to verify pre-task safety briefing compliance across crews and trade groups."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (e.g. pre-start, weekly, incident review) for programme coverage analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Status of the meeting record (e.g. planned, completed, cancelled) for schedule adherence tracking."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "Category of HSE topic discussed (e.g. hazard awareness, emergency procedures, PPE) for safety communication coverage."
    - name: "trade_group"
      expr: trade_group
      comment: "Trade group attending the meeting for workforce safety engagement segmentation."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Boolean flag indicating whether a corrective action was raised during the meeting."
    - name: "emergency_procedures_reviewed"
      expr: emergency_procedures_reviewed
      comment: "Boolean flag indicating whether emergency procedures were reviewed in the meeting."
    - name: "incident_review_included"
      expr: incident_review_included
      comment: "Boolean flag indicating whether an incident review was included, measuring lessons-learned communication."
    - name: "ppe_requirements_communicated"
      expr: ppe_requirements_communicated
      comment: "Boolean flag indicating whether PPE requirements were communicated in the meeting."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month the meeting was held for trend analysis of TBM programme frequency and coverage."
    - name: "meeting_year"
      expr: YEAR(meeting_date)
      comment: "Year the meeting was held for annual safety communication programme review."
    - name: "language_conducted"
      expr: language_conducted
      comment: "Language in which the meeting was conducted for workforce inclusivity and comprehension compliance."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total number of toolbox meetings conducted. Baseline measure of pre-task safety briefing programme activity."
    - name: "avg_attendance_rate_pct"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate across all toolbox meetings. Measures workforce engagement with safety communication programme."
    - name: "meetings_with_emergency_procedure_review"
      expr: COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END)
      comment: "Count of meetings that included emergency procedure review. Tracks emergency preparedness communication coverage."
    - name: "emergency_procedure_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_procedures_reviewed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included emergency procedure review. Measures emergency preparedness communication compliance."
    - name: "meetings_with_incident_review"
      expr: COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END)
      comment: "Count of meetings that included an incident review. Measures lessons-learned communication effectiveness across the workforce."
    - name: "incident_review_inclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings that included incident review. Tracks lessons-learned dissemination across crews."
    - name: "meetings_raising_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END)
      comment: "Count of toolbox meetings that raised corrective actions. Measures proactive hazard identification during pre-task briefings."
    - name: "ppe_communication_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppe_requirements_communicated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of toolbox meetings where PPE requirements were communicated. Tracks PPE compliance briefing coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment programme KPIs measuring risk profile distribution, control adequacy, and assessment currency. Used by HSE managers and project directors to demonstrate ALARP (As Low As Reasonably Practicable) compliance."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g. draft, approved, under review, superseded) for programme governance."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g. JSEA, HAZID, HAZOP, generic) for methodology coverage analysis."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls (e.g. low, medium, high, extreme) for raw risk exposure profiling."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls for ALARP compliance verification."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard assessed for risk programme coverage by hazard category."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether additional corrective actions are required beyond existing controls."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Boolean flag indicating whether the assessment covers an environmental aspect."
    - name: "control_hierarchy"
      expr: control_hierarchy
      comment: "Hierarchy of controls applied (e.g. elimination, engineering, administrative, PPE) for control adequacy benchmarking."
    - name: "site_zone"
      expr: site_zone
      comment: "Site zone covered by the assessment for spatial risk coverage analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the assessment was conducted for trend analysis of risk assessment programme activity."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments on record. Baseline measure of risk management programme coverage."
    - name: "approved_risk_assessments"
      expr: COUNT(CASE WHEN assessment_status IN ('approved', 'Approved') THEN 1 END)
      comment: "Count of formally approved risk assessments. Measures governance compliance of the risk assessment programme."
    - name: "high_extreme_initial_risk_count"
      expr: COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END)
      comment: "Count of assessments with high or extreme initial risk ratings. Tracks the volume of critical risk activities requiring robust controls."
    - name: "residual_high_extreme_risk_count"
      expr: COUNT(CASE WHEN residual_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END)
      comment: "Count of assessments where residual risk remains high or extreme. Identifies activities where current controls are insufficient for ALARP."
    - name: "alarp_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') AND residual_risk_level NOT IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END) / NULLIF(COUNT(CASE WHEN initial_risk_level IN ('high', 'High', 'extreme', 'Extreme') THEN 1 END), 0), 2)
      comment: "Percentage of high/extreme risk activities successfully reduced to acceptable residual risk. Primary ALARP compliance KPI for regulatory and client reporting."
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of risk assessments that identified additional corrective actions beyond existing controls. Tracks outstanding risk treatment obligations."
    - name: "environmental_risk_assessment_count"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of risk assessments covering environmental aspects. Tracks environmental risk management programme coverage."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND assessment_status NOT IN ('superseded', 'Superseded', 'closed', 'Closed') THEN 1 END)
      comment: "Count of risk assessments past their review date that are still active. Tracks currency of risk controls and regulatory compliance obligations."
$$;