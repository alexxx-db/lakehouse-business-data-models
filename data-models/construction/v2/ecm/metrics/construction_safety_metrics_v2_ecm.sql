-- Metric views for domain: safety | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_chemical_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks hazardous chemical inventory, SDS currency, regulatory compliance, and on-site quantity management. Chemical management failures carry significant safety, environmental, and regulatory consequences."
  source: "`vibe_construction_v1`.`safety`.`chemical_register`"
  dimensions:
    - name: "chemical_register_status"
      expr: chemical_register_status
      comment: "Current status of the chemical register entry (active, superseded, disposed) for inventory currency management."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Hazard category of the chemical (flammable, toxic, corrosive, etc.) for risk-stratified inventory analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the chemical for prioritised management and control oversight."
    - name: "chemical_family"
      expr: chemical_family
      comment: "Chemical family classification for portfolio-level hazardous substance management."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the substance is classified as hazardous, the primary filter for regulatory compliance obligations."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the chemical entry for compliance programme management."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the chemical storage for safety compliance tracking."
  measures:
    - name: "total_chemicals_registered"
      expr: COUNT(1)
      comment: "Total chemicals in the register. Baseline measure of hazardous substance inventory scope."
    - name: "hazardous_chemicals"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Count of hazardous chemicals on site. Measures the scope of hazardous substance management obligations and regulatory exposure."
    - name: "chemicals_with_expired_sds"
      expr: COUNT(CASE WHEN sds_last_updated < DATE_ADD(CURRENT_DATE(), -1825) THEN 1 END)
      comment: "Count of chemicals with SDS documents older than 5 years. Outdated SDS represents a regulatory compliance and emergency response risk."
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of chemicals on site (in registered units). Measures aggregate hazardous substance inventory for threshold limit compliance."
    - name: "avg_quantity_on_site"
      expr: AVG(CAST(quantity_on_site AS DOUBLE))
      comment: "Average quantity per chemical on site. Benchmarks inventory levels against storage limits and regulatory thresholds."
    - name: "non_compliant_chemicals"
      expr: COUNT(CASE WHEN regulatory_compliance_status NOT IN ('Compliant', 'Approved') THEN 1 END)
      comment: "Count of chemicals with non-compliant regulatory status. Measures regulatory exposure from hazardous substance management failures."
    - name: "chemicals_overdue_inspection"
      expr: COUNT(CASE WHEN last_inspection_date < DATE_ADD(CURRENT_DATE(), -365) THEN 1 END)
      comment: "Count of chemicals not inspected within the past year. Measures inspection programme currency for hazardous substance storage compliance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental monitoring exceedances, regulatory compliance, and corrective action obligations across construction sites. Critical for environmental permit compliance and ESG reporting."
  source: "`vibe_construction_v1`.`safety`.`environmental_monitoring`"
  dimensions:
    - name: "monitoring_parameter"
      expr: monitoring_parameter
      comment: "Environmental parameter being monitored (noise, dust, water quality, air quality) for parameter-level compliance analysis."
    - name: "parameter_category"
      expr: parameter_category
      comment: "Broader category of the monitoring parameter for portfolio-level environmental compliance reporting."
    - name: "monitoring_record_status"
      expr: monitoring_record_status
      comment: "Status of the monitoring record for data completeness and compliance tracking."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for environmental monitoring, enabling project-level environmental compliance benchmarking."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded the regulatory threshold, the primary compliance outcome indicator."
    - name: "reported_to_regulator"
      expr: reported_to_regulator
      comment: "Whether the exceedance was reported to the regulator, tracking notification compliance obligations."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis of environmental compliance performance."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of monitoring (daily, weekly, monthly) for programme coverage assessment."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total environmental monitoring records. Baseline measure of environmental monitoring programme coverage."
    - name: "total_exceedances"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Total regulatory threshold exceedances. Primary environmental compliance KPI — exceedances trigger regulatory notifications and potential permit suspension."
    - name: "exceedances_not_reported_to_regulator"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND reported_to_regulator = FALSE THEN 1 END)
      comment: "Count of exceedances not yet reported to the regulator. Measures regulatory notification compliance gap and legal liability exposure."
    - name: "exceedances_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of monitoring records requiring corrective action. Measures the volume of environmental compliance remediation obligations."
    - name: "avg_exceedance_magnitude"
      expr: AVG(CASE WHEN exceedance_flag = TRUE THEN CAST(exceedance_magnitude AS DOUBLE) END)
      comment: "Average magnitude of exceedances above regulatory thresholds. Measures severity of environmental non-compliance events."
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measured value across all monitoring records. Enables trend analysis of environmental parameter levels relative to thresholds."
    - name: "distinct_monitoring_locations"
      expr: COUNT(DISTINCT monitoring_location_code)
      comment: "Count of distinct monitoring locations. Measures spatial coverage of the environmental monitoring programme."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the organisation-wide hazard inventory, residual risk profile, and hazard closure performance. Enables proactive risk elimination and supports regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard (physical, chemical, biological, ergonomic, etc.) for category-level risk analysis."
    - name: "hazard_status"
      expr: hazard_status
      comment: "Current status of the hazard (open, mitigated, closed) for backlog and closure management."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls applied, the primary measure of hazard management effectiveness."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Broader hazard category for portfolio-level risk aggregation and reporting."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for hazard, enabling project-level hazard profile comparison."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Whether a permit to work is required to manage this hazard, linking hazard register to PTW compliance."
    - name: "environmental_aspect"
      expr: environmental_aspect
      comment: "Whether the hazard has an environmental dimension, feeding environmental risk reporting."
    - name: "identification_year"
      expr: YEAR(identified_date)
      comment: "Year the hazard was identified for trend analysis of new hazard emergence rates."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total hazards in the register. Baseline measure of known risk inventory across the project portfolio."
    - name: "open_hazards"
      expr: COUNT(CASE WHEN hazard_status = 'Open' THEN 1 END)
      comment: "Count of unresolved open hazards. Measures outstanding risk exposure requiring management action."
    - name: "high_residual_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Count of hazards with high residual risk after controls. Primary executive KPI for unacceptable risk exposure requiring immediate intervention."
    - name: "hazards_requiring_ptw"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Count of hazards requiring a permit to work. Quantifies the scope of the PTW programme and associated compliance obligations."
    - name: "hazards_linked_to_incidents"
      expr: COUNT(CASE WHEN linked_incident_id IS NOT NULL THEN 1 END)
      comment: "Count of hazards that have been linked to actual incidents. Measures the rate at which identified hazards materialise into events."
    - name: "environmental_hazards"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of hazards with environmental aspects. Feeds environmental compliance programme and ESG risk disclosure."
    - name: "overdue_hazard_closures"
      expr: COUNT(CASE WHEN hazard_status = 'Open' AND target_closure_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of open hazards past their target closure date. Measures risk management programme discipline and overdue action backlog."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_hse_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures HSE inspection outcomes, deficiency rates, and compliance performance across projects and sites. Enables proactive identification of safety deterioration before incidents occur."
  source: "`vibe_construction_v1`.`safety`.`hse_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of HSE inspection (routine, regulatory, audit, drill) for stratified performance analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record for backlog and completion tracking."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail/conditional result of the inspection, the primary outcome KPI."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context enabling project-level HSE inspection performance benchmarking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of compliance performance over time."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Whether the inspection was planned or reactive, distinguishing proactive from reactive safety management."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued, the most severe inspection outcome requiring immediate executive attention."
    - name: "highest_deficiency_severity"
      expr: highest_deficiency_severity
      comment: "Highest severity deficiency found during the inspection for risk-stratified reporting."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total HSE inspections conducted. Baseline measure of proactive safety monitoring activity."
    - name: "inspections_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of inspections resulting in stop-work orders. Critical safety KPI indicating severe non-compliance requiring immediate executive intervention."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections where corrective actions were mandated. Measures the volume of safety deficiencies requiring remediation."
    - name: "avg_ppe_compliance_rate"
      expr: AVG(CAST(ppe_compliance_rate AS DOUBLE))
      comment: "Average PPE compliance rate observed during inspections. Direct measure of frontline safety culture and compliance."
    - name: "avg_drill_muster_accuracy_pct"
      expr: AVG(CAST(drill_muster_accuracy_pct AS DOUBLE))
      comment: "Average muster accuracy percentage during emergency drills. Measures emergency preparedness effectiveness."
    - name: "total_critical_deficiencies"
      expr: SUM(CAST(critical_deficiency_count AS DOUBLE))
      comment: "Total critical deficiencies identified across all inspections. Aggregate risk exposure indicator driving priority remediation investment."
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS DOUBLE))
      comment: "Total deficiencies identified across all inspections. Measures overall safety compliance gap volume."
    - name: "scheduled_inspection_rate"
      expr: COUNT(CASE WHEN is_scheduled = TRUE THEN 1 END)
      comment: "Count of planned/scheduled inspections. Higher ratio of scheduled to reactive inspections indicates a mature proactive safety culture."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety incident KPIs tracking frequency, severity, lost-time events, and regulatory recordability across construction projects. Drives executive HSE dashboards and TRIR/LTIR reporting."
  source: "`vibe_construction_v1`.`safety`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g. near-miss, first-aid, LTI, fatality) for trend analysis by incident category."
    - name: "severity"
      expr: severity
      comment: "Severity rating of the incident used to stratify risk exposure and prioritise corrective actions."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level safety performance benchmarking."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident record (open, under investigation, closed) for workload management."
    - name: "injured_party_type"
      expr: injured_party_type
      comment: "Type of injured party (direct employee, subcontractor, visitor) to identify workforce segments with elevated risk."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification to identify systemic safety failures and drive targeted prevention programmes."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred, enabling shift-pattern safety analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurred_at)
      comment: "Month the incident occurred, used for monthly trend reporting and period-over-period comparison."
    - name: "incident_year"
      expr: YEAR(occurred_at)
      comment: "Year the incident occurred for annual safety performance reporting."
    - name: "is_lti"
      expr: is_lti
      comment: "Flag indicating whether the incident resulted in lost time, the primary driver of LTIR calculation."
    - name: "is_osha_recordable"
      expr: is_osha_recordable
      comment: "Flag indicating OSHA recordability, required for regulatory compliance reporting."
    - name: "is_environmental_event"
      expr: is_environmental_event
      comment: "Flag distinguishing environmental incidents from personal injury events for ESG reporting."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of recorded safety incidents. Baseline KPI for absolute incident frequency tracking on executive dashboards."
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of incidents resulting in lost time away from work. Core input to LTIR and a primary executive safety KPI."
    - name: "osha_recordable_incidents"
      expr: COUNT(CASE WHEN is_osha_recordable = TRUE THEN 1 END)
      comment: "Count of OSHA-recordable incidents. Required for regulatory compliance reporting and TRIR calculation."
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS DOUBLE))
      comment: "Total lost calendar days due to work-related injuries. Measures severity of workforce impact and drives return-to-work programme investment decisions."
    - name: "total_property_damage_amount"
      expr: SUM(CAST(property_damage_amount AS DOUBLE))
      comment: "Total financial value of property damage from incidents. Directly informs insurance, risk management, and capital protection decisions."
    - name: "avg_property_damage_per_incident"
      expr: AVG(CAST(property_damage_amount AS DOUBLE))
      comment: "Average property damage cost per incident. Benchmarks incident severity and supports risk-based budget allocation."
    - name: "environmental_incidents"
      expr: COUNT(CASE WHEN is_environmental_event = TRUE THEN 1 END)
      comment: "Count of incidents classified as environmental events. Feeds ESG reporting and regulatory notification tracking."
    - name: "incidents_with_corrective_actions"
      expr: COUNT(CASE WHEN CAST(corrective_action_count AS INT) > 0 THEN 1 END)
      comment: "Count of incidents where corrective actions were raised. Measures organisational responsiveness to safety failures."
    - name: "subcontractor_incidents"
      expr: COUNT(CASE WHEN injured_party_type = 'Subcontractor' THEN 1 END)
      comment: "Count of incidents involving subcontractor personnel. Drives subcontractor HSE prequalification and oversight decisions."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN 1 END)
      comment: "Count of incidents not yet closed. Measures backlog of unresolved safety events requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_incident_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks investigation quality, closure timeliness, and corrective action effectiveness for safety incidents. Enables leadership to assess whether root causes are being systematically addressed."
  source: "`vibe_construction_v1`.`safety`.`incident_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in-progress, closed) for workload and backlog management."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation methodology applied (e.g. RCA, 5-Why, Bow-Tie) for quality benchmarking."
    - name: "incident_classification"
      expr: incident_classification
      comment: "Classification of the underlying incident to stratify investigation outcomes by severity tier."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the investigation, tracking closure rate."
    - name: "is_lti"
      expr: is_lti
      comment: "Whether the investigated incident was a lost-time injury, used to prioritise investigation resource allocation."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for regulatory reportability, ensuring compliance obligations are tracked at investigation level."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for investigation, enabling project-level safety culture assessment."
    - name: "investigation_year"
      expr: YEAR(investigation_start_date)
      comment: "Year investigation was initiated for annual trend analysis."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of incident investigations. Baseline measure for investigation programme volume."
    - name: "closed_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'Closed' THEN 1 END)
      comment: "Count of fully closed investigations. Measures throughput and closure effectiveness of the investigation programme."
    - name: "investigations_with_open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Investigations where corrective actions remain open. Highlights systemic risk of unresolved root causes."
    - name: "regulatory_reportable_investigations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of investigations with regulatory reporting obligations. Drives compliance calendar and notification management."
    - name: "lti_investigations"
      expr: COUNT(CASE WHEN is_lti = TRUE THEN 1 END)
      comment: "Count of investigations for lost-time incidents. Prioritisation metric for senior management review."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_close_date, investigation_start_date))
      comment: "Average calendar days from investigation start to close. Measures investigation timeliness and resource adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors permit-to-work issuance, compliance, and risk controls across construction sites. Critical for preventing high-consequence events in hazardous work activities."
  source: "`vibe_construction_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (hot work, confined space, working at height, etc.) for risk-stratified analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current lifecycle status of the permit (draft, issued, active, closed, suspended) for operational oversight."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work, enabling prioritisation of high-risk permit oversight."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for permit issuance, enabling project-level PTW compliance benchmarking."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the permit, reflecting work hazard classification."
    - name: "permit_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued for trend analysis of high-risk work activity volumes."
    - name: "isolation_required"
      expr: isolation_required
      comment: "Whether energy isolation was required, a key indicator of high-hazard work exposure."
    - name: "gas_test_required"
      expr: gas_test_required
      comment: "Whether atmospheric gas testing was required, indicating confined space or flammable atmosphere risk."
  measures:
    - name: "total_permits_issued"
      expr: COUNT(1)
      comment: "Total permits to work issued. Baseline measure of high-risk work activity volume on site."
    - name: "active_permits"
      expr: COUNT(CASE WHEN permit_status = 'Active' THEN 1 END)
      comment: "Count of currently active permits. Operational metric for site safety officer workload and concurrent risk exposure."
    - name: "suspended_permits"
      expr: COUNT(CASE WHEN permit_status = 'Suspended' THEN 1 END)
      comment: "Count of suspended permits. Elevated count signals site safety interventions and potential stop-work conditions."
    - name: "high_risk_permits"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Count of permits classified as high or critical risk. Drives senior management oversight and resource allocation for safety controls."
    - name: "permits_with_tbm_conducted"
      expr: COUNT(CASE WHEN tbm_conducted_flag = TRUE THEN 1 END)
      comment: "Count of permits where a toolbox meeting was conducted prior to work commencement. Measures pre-task safety briefing compliance."
    - name: "permits_requiring_isolation"
      expr: COUNT(CASE WHEN isolation_required = TRUE THEN 1 END)
      comment: "Count of permits requiring energy isolation. Quantifies exposure to lockout/tagout risk scenarios."
    - name: "permits_with_environmental_impact"
      expr: COUNT(CASE WHEN environmental_impact_flag = TRUE THEN 1 END)
      comment: "Count of permits flagged for environmental impact. Feeds environmental compliance and ESG reporting."
    - name: "avg_permit_extensions"
      expr: AVG(CAST(extension_count AS DOUBLE))
      comment: "Average number of extensions per permit. High extension rates indicate poor work planning or scope creep in hazardous activities."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_ppe_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks PPE issuance, compliance status, inspection currency, and cost across the workforce. PPE compliance is a fundamental safety control and regulatory requirement."
  source: "`vibe_construction_v1`.`safety`.`ppe_register`"
  dimensions:
    - name: "ppe_category"
      expr: ppe_category
      comment: "Category of PPE (head protection, eye protection, respiratory, etc.) for category-level compliance analysis."
    - name: "item_type"
      expr: item_type
      comment: "Specific type of PPE item for granular inventory and compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PPE item (compliant, expired, non-compliant) for workforce safety compliance management."
    - name: "issuance_status"
      expr: issuance_status
      comment: "Whether the PPE has been issued, returned, or is pending, for inventory management."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for PPE issuance, enabling project-level PPE compliance benchmarking."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Hazard type the PPE is designed to protect against, linking PPE provision to hazard register."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of the PPE item (good, damaged, condemned) for serviceability management."
  measures:
    - name: "total_ppe_items"
      expr: COUNT(1)
      comment: "Total PPE items in the register. Baseline measure of PPE inventory and issuance programme scale."
    - name: "non_compliant_ppe_items"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Active') THEN 1 END)
      comment: "Count of PPE items not in compliance (expired, non-compliant, condemned). Measures workforce exposure to inadequate personal protection."
    - name: "expired_ppe_items"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of PPE items past their expiry date. Expired PPE represents a direct safety and regulatory compliance risk."
    - name: "total_ppe_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total cost of PPE issued. Enables PPE budget management and cost-per-worker safety investment analysis."
    - name: "avg_ppe_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of PPE items. Benchmarks procurement efficiency and supports category-level cost optimisation."
    - name: "ppe_items_requiring_fit_test"
      expr: COUNT(CASE WHEN fit_test_required = TRUE THEN 1 END)
      comment: "Count of PPE items requiring fit testing (e.g. respirators). Measures the scope of the fit-test compliance obligation."
    - name: "ppe_items_overdue_inspection"
      expr: COUNT(CASE WHEN next_inspection_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of PPE items overdue for periodic inspection. Measures maintenance compliance backlog for safety-critical equipment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quantifies risk exposure across construction activities by tracking initial vs residual risk levels, assessment coverage, and control effectiveness. Enables proactive risk management decisions."
  source: "`vibe_construction_v1`.`safety`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (JSEA, HAZOP, generic, task-specific) for methodology benchmarking."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (draft, approved, under review, expired) for currency management."
    - name: "initial_risk_level"
      expr: initial_risk_level
      comment: "Inherent risk level before controls are applied, used to prioritise high-risk activity oversight."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls, the primary measure of control effectiveness."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard assessed (electrical, chemical, mechanical, etc.) for hazard-category trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for risk assessments, enabling project-level risk profile comparison."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether additional corrective actions were identified, indicating residual control gaps."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual risk profile trend analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total risk assessments conducted. Baseline measure of risk management programme coverage."
    - name: "high_residual_risk_assessments"
      expr: COUNT(CASE WHEN residual_risk_level IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Count of assessments where residual risk remains high after controls. Identifies activities where current controls are insufficient, requiring executive intervention."
    - name: "assessments_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of risk assessments identifying additional corrective actions needed. Measures control gap volume across the project portfolio."
    - name: "environmental_risk_assessments"
      expr: COUNT(CASE WHEN environmental_aspect = TRUE THEN 1 END)
      comment: "Count of assessments covering environmental aspects. Feeds environmental compliance programme and ESG risk reporting."
    - name: "assessments_linked_to_incidents"
      expr: COUNT(CASE WHEN linked_incident_id IS NOT NULL THEN 1 END)
      comment: "Count of risk assessments linked to actual incidents. Measures the proportion of risks that materialised, informing risk model calibration."
    - name: "approved_risk_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Approved' THEN 1 END)
      comment: "Count of formally approved risk assessments. Measures compliance with the risk assessment approval process."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks safety audit compliance scores, findings, and closure performance. Provides leadership with a systematic view of HSE management system effectiveness across the organisation."
  source: "`vibe_construction_v1`.`safety`.`safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of safety audit (internal, external, regulatory, certification) for stratified compliance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, closed) for programme management."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit scope (HSE management system, site safety, environmental, etc.) for domain-specific benchmarking."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating assigned to the audit outcome for executive-level performance reporting."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for audit results, enabling project-level HSE management system assessment."
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit for annual compliance trend analysis and year-over-year benchmarking."
    - name: "stop_work_issued"
      expr: stop_work_issued
      comment: "Whether a stop-work order was issued as a result of the audit, the most severe audit outcome."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether the audit findings triggered a regulatory notification obligation."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total safety audits conducted. Baseline measure of audit programme activity and coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits. Primary KPI for HSE management system maturity reported to executives and boards."
    - name: "total_major_nonconformances"
      expr: SUM(CAST(major_nc_count AS DOUBLE))
      comment: "Total major non-conformances identified. Drives corrective action investment and certification risk assessment."
    - name: "total_minor_nonconformances"
      expr: SUM(CAST(minor_nc_count AS DOUBLE))
      comment: "Total minor non-conformances identified. Tracks systemic improvement opportunities across the safety programme."
    - name: "total_open_findings"
      expr: SUM(CAST(open_findings_count AS DOUBLE))
      comment: "Total unresolved audit findings. Measures backlog of safety compliance gaps requiring management closure."
    - name: "audits_with_stop_work"
      expr: COUNT(CASE WHEN stop_work_issued = TRUE THEN 1 END)
      comment: "Count of audits resulting in stop-work orders. Critical indicator of severe safety non-compliance requiring board-level attention."
    - name: "audits_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of audits triggering regulatory notification. Measures regulatory compliance exposure and notification obligation volume."
    - name: "avg_total_findings_per_audit"
      expr: AVG(CAST(total_findings AS DOUBLE))
      comment: "Average number of findings per audit. Benchmarks audit thoroughness and site safety condition across projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_swms`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Safe Work Method Statement (SWMS) coverage, approval status, and risk control adequacy for high-risk construction work. SWMS compliance is a legal requirement in most jurisdictions."
  source: "`vibe_construction_v1`.`safety`.`swms`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the SWMS (draft, approved, rejected, expired) for compliance management."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of high-risk construction activity covered by the SWMS for coverage gap analysis."
    - name: "initial_risk_rating"
      expr: initial_risk_rating
      comment: "Initial risk rating of the activity before controls, used to prioritise SWMS review resources."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls applied, measuring SWMS control effectiveness."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for SWMS, enabling project-level SWMS compliance benchmarking."
    - name: "ptw_required"
      expr: ptw_required
      comment: "Whether a permit to work is required alongside the SWMS, indicating highest-risk activities."
    - name: "swms_year"
      expr: YEAR(issue_date)
      comment: "Year SWMS was issued for annual programme coverage analysis."
  measures:
    - name: "total_swms"
      expr: COUNT(1)
      comment: "Total SWMS documents in the register. Baseline measure of high-risk work method statement coverage."
    - name: "approved_swms"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of formally approved SWMS. Measures compliance with the legal requirement for approved work method statements before high-risk work commences."
    - name: "expired_swms"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND approval_status = 'Approved' THEN 1 END)
      comment: "Count of SWMS past their expiry date. Expired SWMS represent a compliance and legal liability requiring immediate renewal."
    - name: "swms_requiring_ptw"
      expr: COUNT(CASE WHEN ptw_required = TRUE THEN 1 END)
      comment: "Count of SWMS requiring an associated permit to work. Quantifies the highest-risk activity category requiring dual-control compliance."
    - name: "swms_requiring_worker_acknowledgement"
      expr: COUNT(CASE WHEN worker_acknowledgement_required = TRUE THEN 1 END)
      comment: "Count of SWMS requiring worker sign-off. Measures the scope of the worker acknowledgement compliance obligation."
    - name: "high_residual_risk_swms"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical', 'Extreme') THEN 1 END)
      comment: "Count of SWMS where residual risk remains high after controls. Identifies activities where current control measures are insufficient."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_toolbox_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures toolbox meeting (TBM) frequency, attendance compliance, and topic coverage. TBMs are a leading safety indicator — consistent, well-attended TBMs correlate with lower incident rates."
  source: "`vibe_construction_v1`.`safety`.`toolbox_meeting`"
  dimensions:
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of toolbox meeting (pre-task, weekly, emergency, etc.) for programme coverage analysis."
    - name: "meeting_status"
      expr: meeting_status
      comment: "Status of the meeting record (planned, completed, cancelled) for programme adherence tracking."
    - name: "hse_topic_category"
      expr: hse_topic_category
      comment: "HSE topic category covered in the meeting, enabling analysis of safety communication coverage gaps."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for TBM activity, enabling project-level safety communication benchmarking."
    - name: "trade_group"
      expr: trade_group
      comment: "Trade group attending the meeting, enabling trade-specific safety communication analysis."
    - name: "meeting_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month of meeting for trend analysis of TBM frequency and attendance over time."
    - name: "corrective_action_raised"
      expr: corrective_action_raised
      comment: "Whether a corrective action was raised during the meeting, indicating safety issues surfaced through TBM process."
  measures:
    - name: "total_toolbox_meetings"
      expr: COUNT(1)
      comment: "Total toolbox meetings conducted. Leading safety indicator — frequency of pre-task safety briefings correlates with incident prevention."
    - name: "avg_attendance_rate_pct"
      expr: AVG(CAST(attendance_rate_pct AS DOUBLE))
      comment: "Average attendance rate across all toolbox meetings. Measures workforce engagement with safety communication programmes."
    - name: "total_attendees"
      expr: SUM(CAST(actual_attendee_count AS DOUBLE))
      comment: "Total worker-meeting touchpoints across all TBMs. Measures the reach of the safety communication programme."
    - name: "meetings_with_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_raised = TRUE THEN 1 END)
      comment: "Count of TBMs where corrective actions were raised. Measures the effectiveness of TBMs as a hazard identification mechanism."
    - name: "meetings_with_incident_review"
      expr: COUNT(CASE WHEN incident_review_included = TRUE THEN 1 END)
      comment: "Count of TBMs that included an incident review. Measures lessons-learned dissemination through the safety communication programme."
    - name: "avg_meeting_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of toolbox meetings in minutes. Benchmarks meeting quality — very short meetings may indicate inadequate safety briefing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures safety training delivery, certification compliance, and workforce competency coverage. Training compliance is a leading indicator of incident prevention and regulatory compliance."
  source: "`vibe_construction_v1`.`safety`.`training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of safety training (induction, refresher, certification, emergency response) for programme coverage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record (compliant, overdue, expired) for workforce competency management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (classroom, online, on-the-job) for programme effectiveness analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project context for training delivery, enabling project-level workforce competency benchmarking."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory, prioritising compliance tracking for legally required competencies."
    - name: "certification_issued"
      expr: certification_issued
      comment: "Whether a certification was issued upon completion, tracking formal competency credentialing."
    - name: "training_year"
      expr: YEAR(training_date)
      comment: "Year training was delivered for annual programme coverage and investment analysis."
    - name: "assessment_result"
      expr: assessment_result
      comment: "Pass/fail result of the training assessment for competency attainment tracking."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total safety training records. Baseline measure of training programme delivery volume."
    - name: "mandatory_training_completions"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE AND attendance_status = 'Attended' THEN 1 END)
      comment: "Count of mandatory training completions. Measures compliance with legally required safety competency obligations."
    - name: "certifications_issued"
      expr: COUNT(CASE WHEN certification_issued = TRUE THEN 1 END)
      comment: "Count of safety certifications issued. Measures formal competency credentialing output of the training programme."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions. Measures training effectiveness and workforce competency attainment."
    - name: "total_training_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total investment in safety training. Enables cost-per-competency analysis and training budget optimisation decisions."
    - name: "total_training_hours_delivered"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total safety training hours delivered. Measures the scale of workforce safety education investment."
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per training record. Benchmarks training programme efficiency and supports make-vs-buy decisions for training delivery."
    - name: "overdue_refresher_training"
      expr: COUNT(CASE WHEN refresher_required = TRUE AND next_refresher_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of training records where refresher training is overdue. Measures workforce competency currency risk and regulatory compliance exposure."
$$;
