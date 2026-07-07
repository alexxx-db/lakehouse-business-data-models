-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for food safety audits — compliance scores, pass rates, and corrective action tracking to steer food safety program performance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit (e.g., routine, surprise, regulatory) for segmenting compliance performance."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass or fail outcome of the audit, used to track failure rates by segment."
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current lifecycle status of the audit (e.g., open, closed, pending review)."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the audit — drives follow-up prioritization."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority that mandated or will review the audit results."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Calendar month of the audit for trend analysis."
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Whether allergen control procedures were compliant during the audit."
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Whether temperature monitoring was compliant during the audit."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted — baseline volume KPI for audit program coverage."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all audits — primary indicator of overall food safety program health."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score — used to benchmark unit performance against brand standards."
    - name: "min_compliance_score"
      expr: MIN(CAST(compliance_score AS DOUBLE))
      comment: "Lowest compliance score recorded — identifies worst-performing units requiring urgent intervention."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN pass_fail = 'FAIL' THEN 1 END)
      comment: "Number of audits that resulted in a fail — directly tied to regulatory risk and brand reputation."
    - name: "passed_audit_count"
      expr: COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END)
      comment: "Number of audits that passed — used to calculate pass rate and track program improvement."
    - name: "audit_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that passed — executive KPI for food safety compliance rate."
    - name: "open_corrective_action_audits"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('CLOSED', 'COMPLETED') THEN 1 END)
      comment: "Number of audits with open corrective actions — operational risk indicator requiring management attention."
    - name: "allergen_non_compliant_audits"
      expr: COUNT(CASE WHEN allergen_control_compliant = FALSE THEN 1 END)
      comment: "Audits where allergen control was non-compliant — critical safety risk metric for allergen management programs."
    - name: "temperature_non_compliant_audits"
      expr: COUNT(CASE WHEN temperature_monitoring_compliant = FALSE THEN 1 END)
      comment: "Audits where temperature monitoring was non-compliant — key food safety risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory health inspections — scores, violation rates, closure orders, and fee exposure to manage regulatory compliance risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (routine, follow-up, complaint-driven) for segmenting compliance performance."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Pass or fail outcome of the health inspection."
    - name: "overall_grade"
      expr: overall_grade
      comment: "Letter grade or rating assigned by the health authority — public-facing compliance indicator."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned by the inspector — drives prioritization of corrective actions."
    - name: "agency_name"
      expr: agency_name
      comment: "Health regulatory agency conducting the inspection — used for multi-jurisdiction compliance tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (open, closed, appealed)."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Calendar month of the inspection for trend analysis."
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Whether a closure order was issued — highest-severity compliance event."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required following the inspection."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections — baseline coverage metric for regulatory compliance program."
    - name: "avg_inspection_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average health inspection score — primary regulatory compliance KPI tracked by operations leadership."
    - name: "min_inspection_score"
      expr: MIN(CAST(score AS DOUBLE))
      comment: "Lowest inspection score — identifies highest-risk units requiring immediate intervention."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN pass_fail = 'FAIL' THEN 1 END)
      comment: "Number of failed health inspections — regulatory risk KPI with direct brand and legal consequences."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of health inspections passed — executive-level regulatory compliance rate."
    - name: "closure_order_count"
      expr: COUNT(CASE WHEN closure_order_flag = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a closure order — highest-severity regulatory event, tracked at board level."
    - name: "total_inspection_fees"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total regulatory inspection fees paid — cost of compliance metric for finance and operations."
    - name: "avg_inspection_fee"
      expr: AVG(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Average inspection fee per inspection — benchmarks regulatory cost burden across jurisdictions."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring a follow-up — indicates unresolved compliance issues needing re-inspection."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections triggering corrective actions — operational workload and risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for individual inspection violations — severity distribution, penalty exposure, and resolution rates to prioritize compliance remediation."
  source: "`vibe_restaurants_v1`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Category of violation (e.g., temperature, sanitation, labeling) for root-cause analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the violation — drives prioritization of corrective actions."
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current resolution status of the violation (open, resolved, appealed)."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken in response to the violation."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was mandated for this violation."
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Calendar month the violation was recorded for trend analysis."
    - name: "area_of_concern"
      expr: area_of_concern
      comment: "Physical or operational area where the violation occurred — used for targeted remediation."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of inspection violations — baseline compliance risk volume metric."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties from violations — direct cost of non-compliance tracked by finance and legal."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation — benchmarks penalty severity and informs compliance investment decisions."
    - name: "open_violation_count"
      expr: COUNT(CASE WHEN inspection_violation_status NOT IN ('RESOLVED', 'CLOSED') THEN 1 END)
      comment: "Number of unresolved violations — operational risk backlog requiring management attention."
    - name: "violation_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_violation_status IN ('RESOLVED', 'CLOSED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations resolved — measures effectiveness of corrective action programs."
    - name: "high_severity_violation_count"
      expr: COUNT(CASE WHEN severity IN ('HIGH', 'CRITICAL') THEN 1 END)
      comment: "Number of high or critical severity violations — primary risk indicator for regulatory and brand exposure."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for temperature monitoring — deviation rates, critical limit breaches, and compliance status to manage food safety temperature control programs."
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (e.g., refrigerator, hot-hold, receiving) for targeted monitoring analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the temperature reading was within compliant range — primary safety classification."
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Lifecycle status of the temperature log record."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether this reading represents a deviation from critical limits — triggers corrective action."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to capture the temperature reading (manual, automated sensor) for data quality analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Calendar month of the temperature reading for trend analysis."
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend direction of temperature readings (rising, stable, falling) for predictive maintenance."
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Whether equipment maintenance is required based on temperature readings."
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings — measures monitoring program coverage and frequency."
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature reading — baseline for detecting systematic drift from safe ranges."
    - name: "deviation_count"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Number of temperature readings that deviated from critical limits — primary food safety risk KPI."
    - name: "deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings with deviations — executive KPI for temperature control program effectiveness."
    - name: "avg_critical_limit_high"
      expr: AVG(CAST(critical_limit_high AS DOUBLE))
      comment: "Average upper critical limit across monitored equipment — used for benchmarking and standard-setting."
    - name: "avg_critical_limit_low"
      expr: AVG(CAST(critical_limit_low AS DOUBLE))
      comment: "Average lower critical limit across monitored equipment — used for benchmarking and standard-setting."
    - name: "maintenance_required_count"
      expr: COUNT(CASE WHEN maintenance_required = TRUE THEN 1 END)
      comment: "Number of temperature log records flagging equipment maintenance needs — drives preventive maintenance scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food safety corrective actions — closure rates, cost of remediation, severity distribution, and overdue actions to manage compliance remediation effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g., retraining, equipment repair, process change) for root-cause categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the issue that triggered the corrective action — drives prioritization."
    - name: "foodsafety_corrective_action_status"
      expr: foodsafety_corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, closed, verified)."
    - name: "closure_status"
      expr: closure_status
      comment: "Whether the corrective action has been formally closed — key compliance completion indicator."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action — used for workload management."
    - name: "ccp_deviation"
      expr: ccp_deviation
      comment: "Whether the corrective action was triggered by a critical control point deviation — highest-risk category."
    - name: "temperature_exceedance"
      expr: temperature_exceedance
      comment: "Whether the corrective action was triggered by a temperature exceedance event."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month the corrective action was initiated for trend analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of food safety corrective actions — baseline volume metric for compliance remediation workload."
    - name: "total_action_cost"
      expr: SUM(CAST(action_cost AS DOUBLE))
      comment: "Total cost of corrective actions — direct financial impact of food safety non-compliance."
    - name: "avg_action_cost"
      expr: AVG(CAST(action_cost AS DOUBLE))
      comment: "Average cost per corrective action — benchmarks remediation efficiency and informs prevention investment."
    - name: "closed_action_count"
      expr: COUNT(CASE WHEN closure_status = 'CLOSED' THEN 1 END)
      comment: "Number of corrective actions formally closed — measures remediation completion rate."
    - name: "corrective_action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_status = 'CLOSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions closed — executive KPI for compliance remediation effectiveness."
    - name: "ccp_deviation_action_count"
      expr: COUNT(CASE WHEN ccp_deviation = TRUE THEN 1 END)
      comment: "Number of corrective actions triggered by CCP deviations — highest-risk food safety events requiring board-level visibility."
    - name: "effective_action_count"
      expr: COUNT(CASE WHEN is_effective = TRUE THEN 1 END)
      comment: "Number of corrective actions verified as effective — measures quality of remediation outcomes."
    - name: "effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_effective = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN closure_status = 'CLOSED' THEN 1 END), 0), 2)
      comment: "Percentage of closed corrective actions verified as effective — measures remediation quality, not just completion."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for allergen incidents — frequency, severity, regulatory notification rates, and resolution times to manage allergen risk and guest safety."
  source: "`vibe_restaurants_v1`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "Category of allergen incident (e.g., cross-contact, mislabeling, undisclosed ingredient) for root-cause analysis."
    - name: "allergen_name"
      expr: allergen_name
      comment: "Name of the allergen involved — identifies highest-risk allergens across the estate."
    - name: "allergen_incident_status"
      expr: allergen_incident_status
      comment: "Current status of the allergen incident (open, under investigation, resolved)."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification — tracks compliance with mandatory reporting obligations."
    - name: "fda_medwatch_filed"
      expr: fda_medwatch_filed
      comment: "Whether an FDA MedWatch report was filed — indicates severity and regulatory exposure."
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Whether this is a repeat allergen incident — repeat incidents indicate systemic control failures."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Calendar month of the allergen incident for trend analysis."
    - name: "investigation_complete"
      expr: investigation_complete
      comment: "Whether the investigation has been completed — tracks investigation backlog."
  measures:
    - name: "total_allergen_incidents"
      expr: COUNT(1)
      comment: "Total number of allergen incidents — primary guest safety risk KPI tracked at executive level."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of allergen incidents — measures overall allergen risk level across the estate."
    - name: "max_severity_score"
      expr: MAX(CAST(severity_score AS DOUBLE))
      comment: "Maximum severity score recorded — identifies worst-case allergen events for executive escalation."
    - name: "repeat_incident_count"
      expr: COUNT(CASE WHEN is_repeat_incident = TRUE THEN 1 END)
      comment: "Number of repeat allergen incidents — indicates systemic allergen control failures requiring structural intervention."
    - name: "repeat_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_incident = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergen incidents that are repeats — measures effectiveness of allergen control programs."
    - name: "fda_medwatch_filed_count"
      expr: COUNT(CASE WHEN fda_medwatch_filed = TRUE THEN 1 END)
      comment: "Number of incidents requiring FDA MedWatch filing — regulatory exposure metric tracked by legal and compliance."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN allergen_incident_status NOT IN ('RESOLVED', 'CLOSED') THEN 1 END)
      comment: "Number of open allergen incidents — active risk backlog requiring management attention."
    - name: "investigation_incomplete_count"
      expr: COUNT(CASE WHEN investigation_complete = FALSE THEN 1 END)
      comment: "Number of incidents with incomplete investigations — compliance gap metric for regulatory readiness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_haccp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HACCP plan management — approval rates, compliance status, and review currency to ensure food safety management system integrity."
  source: "`vibe_restaurants_v1`.`foodsafety`.`haccp_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of HACCP plan (e.g., production, receiving, storage) for coverage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the HACCP plan — primary regulatory readiness indicator."
    - name: "approval_status"
      expr: approval_status
      comment: "Whether the HACCP plan has been formally approved — unapproved plans represent regulatory risk."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the HACCP plan (draft, active, retired) for version management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the HACCP plan — drives review frequency and audit prioritization."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the HACCP plan is designed to comply with (e.g., FDA, USDA, EU)."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether staff training is required for this HACCP plan — drives training program planning."
  measures:
    - name: "total_haccp_plans"
      expr: COUNT(1)
      comment: "Total number of HACCP plans — measures food safety management system coverage."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of formally approved HACCP plans — regulatory compliance baseline metric."
    - name: "plan_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HACCP plans with formal approval — executive KPI for food safety management system readiness."
    - name: "compliant_plan_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of HACCP plans in compliant status — measures active compliance posture."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND lifecycle_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active HACCP plans past their review due date — regulatory risk indicator for outdated food safety controls."
    - name: "allergen_control_plan_count"
      expr: COUNT(CASE WHEN allergen_control_flag = TRUE THEN 1 END)
      comment: "Number of HACCP plans with allergen control provisions — measures allergen management program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for critical control points — deviation rates, monitoring compliance, and verification currency to manage HACCP program effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled by the CCP (biological, chemical, physical) for risk categorization."
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current operational status of the CCP (active, suspended, retired)."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether this is a critical control point vs. a prerequisite program — drives monitoring priority."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "How frequently the CCP is monitored — used to assess monitoring program adequacy."
    - name: "process_step"
      expr: process_step
      comment: "Process step where the CCP is applied (e.g., cooking, cooling, receiving) for process-level analysis."
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "Frequency of CCP verification activities — measures verification program rigor."
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total number of critical control points — measures HACCP program scope and coverage."
    - name: "avg_critical_limit_max"
      expr: AVG(CAST(critical_limit_max AS DOUBLE))
      comment: "Average upper critical limit across all CCPs — used for benchmarking and standard-setting."
    - name: "avg_critical_limit_min"
      expr: AVG(CAST(critical_limit_min AS DOUBLE))
      comment: "Average lower critical limit across all CCPs — used for benchmarking and standard-setting."
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across CCPs — measures typical magnitude of critical limit exceedances."
    - name: "active_ccp_count"
      expr: COUNT(CASE WHEN critical_control_point_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active CCPs — measures operational HACCP program scope."
    - name: "overdue_verification_count"
      expr: COUNT(CASE WHEN last_verification_timestamp < DATE_SUB(CURRENT_TIMESTAMP(), 30) AND critical_control_point_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active CCPs not verified in the last 30 days — identifies gaps in HACCP verification program."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food recall events — recall volume, severity distribution, scope, and resolution status to manage supply chain food safety risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_recall`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (I, II, III) indicating severity — Class I is the most serious, life-threatening category."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal) for regulatory classification."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (active, closed, monitoring) — tracks resolution progress."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency overseeing the recall (FDA, USDA, etc.) for multi-agency tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the recall — drives response urgency and resource allocation."
    - name: "is_voluntary"
      expr: is_voluntary
      comment: "Whether the recall was voluntary or mandated — voluntary recalls indicate proactive safety culture."
    - name: "recall_month"
      expr: DATE_TRUNC('MONTH', recall_initiation_timestamp)
      comment: "Calendar month the recall was initiated for trend analysis."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of food recalls — primary supply chain food safety risk KPI."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of food recalls — measures overall supply chain food safety risk level."
    - name: "class_one_recall_count"
      expr: COUNT(CASE WHEN recall_class = 'CLASS I' THEN 1 END)
      comment: "Number of Class I (most severe) recalls — highest-priority food safety risk metric tracked at board level."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active recalls — measures current supply chain food safety exposure."
    - name: "voluntary_recall_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voluntary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls that were voluntary — measures proactive food safety culture vs. regulatory-forced recalls."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for foodborne illness reports — incidence rates, investigation completion, health department notifications, and severity to manage public health risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report (open, under investigation, closed)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the reported illness — drives escalation and regulatory notification decisions."
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen causing the illness — identifies systemic food safety hazards."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the illness investigation — tracks investigation backlog and completion."
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Whether the health department was notified — mandatory reporting compliance indicator."
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Whether the ill employee was excluded from food handling — measures immediate safety response."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Calendar month the illness was reported for trend analysis."
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of foodborne illness reports — primary public health risk KPI for food safety programs."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of illness reports — measures overall public health risk level."
    - name: "health_dept_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_department_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports where health department was notified — mandatory reporting compliance rate."
    - name: "employee_exclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_decision = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports resulting in employee exclusion from food handling — measures immediate safety response effectiveness."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN investigation_status NOT IN ('COMPLETE', 'CLOSED') THEN 1 END)
      comment: "Number of illness reports with open investigations — active public health risk backlog."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for environmental monitoring — pathogen detection rates, positive test rates, and corrective action triggers to manage facility hygiene and food safety risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`environmental_monitoring`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of environmental test (e.g., ATP, pathogen swab, allergen) for program coverage analysis."
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample collected (surface, air, water) for environmental risk categorization."
    - name: "pathogen_tested"
      expr: pathogen_tested
      comment: "Specific pathogen tested for (e.g., Listeria, Salmonella) — identifies highest-risk pathogens in the environment."
    - name: "test_result"
      expr: test_result
      comment: "Result of the environmental test (positive, negative, inconclusive)."
    - name: "is_pass"
      expr: is_pass
      comment: "Whether the environmental monitoring test passed — primary compliance indicator."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required based on the test result."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_date)
      comment: "Calendar month of the environmental monitoring event for trend analysis."
    - name: "lab_name"
      expr: lab_name
      comment: "Laboratory that performed the analysis — used for lab performance benchmarking."
  measures:
    - name: "total_environmental_tests"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring tests — measures program coverage and frequency."
    - name: "positive_test_count"
      expr: COUNT(CASE WHEN is_positive = TRUE THEN 1 END)
      comment: "Number of positive environmental tests — primary indicator of facility contamination risk."
    - name: "positive_test_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_positive = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental tests returning positive results — executive KPI for facility hygiene program effectiveness."
    - name: "pathogen_detected_count"
      expr: COUNT(CASE WHEN pathogen_detected = TRUE THEN 1 END)
      comment: "Number of tests where a pathogen was detected — highest-severity environmental safety event."
    - name: "avg_cfu_count"
      expr: AVG(CAST(cfu_count AS DOUBLE))
      comment: "Average colony-forming unit count across tests — quantitative measure of microbial contamination levels."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average quantitative result value across environmental tests — tracks contamination level trends."
    - name: "corrective_action_trigger_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of environmental tests triggering corrective actions — measures remediation workload from environmental monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_sanitation_task_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for sanitation task execution — completion rates, compliance, chemical usage, and deviation tracking to manage sanitation program effectiveness."
  source: "`vibe_restaurants_v1`.`foodsafety`.`sanitation_task_log`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of sanitation task (e.g., surface cleaning, equipment sanitization, floor cleaning) for program analysis."
    - name: "task_status"
      expr: task_status
      comment: "Completion status of the sanitation task (completed, skipped, failed) — primary execution KPI."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the sanitation task — measures sanitation quality."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the sanitation task is classified as critical — drives prioritization and escalation."
    - name: "task_month"
      expr: DATE_TRUNC('MONTH', task_timestamp)
      comment: "Calendar month of the sanitation task for trend analysis."
    - name: "location_area"
      expr: location_area
      comment: "Physical area where the sanitation task was performed — identifies high-risk or non-compliant zones."
  measures:
    - name: "total_sanitation_tasks"
      expr: COUNT(1)
      comment: "Total number of sanitation tasks logged — measures sanitation program execution volume."
    - name: "completed_task_count"
      expr: COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END)
      comment: "Number of sanitation tasks completed — measures program execution compliance."
    - name: "task_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanitation tasks completed — executive KPI for sanitation program adherence."
    - name: "failed_task_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'FAIL' THEN 1 END)
      comment: "Number of sanitation tasks that failed quality checks — identifies sanitation quality gaps."
    - name: "avg_task_duration_seconds"
      expr: AVG(CAST(task_duration_seconds AS DOUBLE))
      comment: "Average duration of sanitation tasks in seconds — measures labor efficiency and task thoroughness."
    - name: "avg_chemical_concentration"
      expr: AVG(CAST(chemical_concentration AS DOUBLE))
      comment: "Average chemical concentration used in sanitation tasks — monitors compliance with safe chemical usage standards."
    - name: "critical_task_failure_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND pass_fail_status = 'FAIL' THEN 1 END)
      comment: "Number of critical sanitation tasks that failed — highest-priority food safety risk from sanitation program gaps."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_receiving_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for receiving inspections — temperature compliance, rejection rates, and supplier quality at point of receipt to manage inbound food safety risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`receiving_inspection`"
  dimensions:
    - name: "receiving_inspection_status"
      expr: receiving_inspection_status
      comment: "Current status of the receiving inspection (pass, fail, pending) — primary inbound quality indicator."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the received shipment — drives acceptance or rejection decisions."
    - name: "temperature_pass_flag"
      expr: temperature_pass_flag
      comment: "Whether the received product met temperature requirements — critical cold chain compliance indicator."
    - name: "visual_quality_pass"
      expr: visual_quality_pass
      comment: "Whether the received product passed visual quality inspection — measures supplier quality at delivery."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required at receiving — triggers supplier performance tracking."
    - name: "receiving_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Calendar month of the receiving inspection for trend analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for rejecting a received shipment — identifies most common supplier quality failures."
  measures:
    - name: "total_receiving_inspections"
      expr: COUNT(1)
      comment: "Total number of receiving inspections — measures inbound quality control program coverage."
    - name: "temperature_pass_count"
      expr: COUNT(CASE WHEN temperature_pass_flag = TRUE THEN 1 END)
      comment: "Number of receiving inspections passing temperature requirements — cold chain compliance volume."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of received shipments meeting temperature requirements — executive KPI for cold chain integrity."
    - name: "visual_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visual_quality_pass = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of received shipments passing visual quality inspection — supplier quality KPI."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature of received products in Celsius — monitors cold chain performance trends."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of product received through inspected deliveries — measures inbound supply volume."
    - name: "rejection_count"
      expr: COUNT(CASE WHEN receiving_inspection_status = 'FAIL' THEN 1 END)
      comment: "Number of rejected receiving inspections — measures supplier quality failure rate at point of receipt."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with receiving inspections — measures supplier quality monitoring coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for food safety training — completion rates, assessment scores, and compliance status to manage workforce food safety competency."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_training`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of food safety training (e.g., HACCP, allergen awareness, sanitation) for program coverage analysis."
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (completed, in-progress, overdue)."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the training assessment — measures workforce competency."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record — tracks regulatory training requirements."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the training was delivered (in-person, e-learning, on-the-job) for program effectiveness analysis."
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Calendar month of training completion for trend analysis."
    - name: "training_program_name"
      expr: training_program_name
      comment: "Name of the food safety training program — used to compare performance across programs."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of food safety training records — measures training program reach."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across food safety training completions — measures workforce competency level."
    - name: "training_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of food safety training assessments passed — executive KPI for workforce food safety competency."
    - name: "compliant_training_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of training records in compliant status — measures regulatory training compliance."
    - name: "training_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records meeting compliance requirements — regulatory readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_pest_control_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for pest control activities — service compliance, findings severity, and corrective action rates to manage facility pest risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`pest_control_log`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of pest control service (preventive, reactive, inspection) for program analysis."
    - name: "service_status"
      expr: service_status
      comment: "Status of the pest control service (completed, scheduled, overdue)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of pest findings — drives escalation and corrective action prioritization."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the pest control service was compliant with schedule and standards."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_timestamp)
      comment: "Calendar month of the pest control service for trend analysis."
  measures:
    - name: "total_pest_control_services"
      expr: COUNT(1)
      comment: "Total number of pest control service events — measures pest management program coverage."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of pest control findings — measures overall pest risk level across the estate."
    - name: "non_compliant_service_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of pest control services that were non-compliant — identifies gaps in pest management program execution."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pest control services that were compliant — measures pest management program adherence."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_recall_unit_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for unit-level recall responses — affected quantity, compliance rates, and verification status to manage recall execution effectiveness across the restaurant estate."
  source: "`vibe_restaurants_v1`.`foodsafety`.`recall_unit_response`"
  dimensions:
    - name: "recall_unit_response_status"
      expr: recall_unit_response_status
      comment: "Current status of the unit recall response (pending, completed, verified)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the unit recall response — measures regulatory recall execution compliance."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity of the recall event — drives response urgency and resource allocation."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to dispose of recalled product (destroyed, returned, quarantined) — measures recall execution method."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the recall response has been verified — measures recall completion quality."
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month of the recall response event for trend analysis."
  measures:
    - name: "total_recall_responses"
      expr: COUNT(1)
      comment: "Total number of unit recall responses — measures recall execution breadth across the estate."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by recalls — measures recall scope and supply chain impact."
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average quantity affected per recall response — benchmarks typical recall impact per unit."
    - name: "compliant_response_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of recall responses meeting compliance requirements — measures regulatory recall execution rate."
    - name: "recall_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recall responses that were compliant — executive KPI for recall program effectiveness."
    - name: "verified_response_count"
      expr: COUNT(CASE WHEN verification_status = 'VERIFIED' THEN 1 END)
      comment: "Number of recall responses independently verified — measures recall execution quality assurance."
    - name: "distinct_units_responding"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units that responded to recalls — measures recall communication and execution reach."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics summarizing audit findings and their severity."
  source: "`vibe_restaurants_v1`.`foodsafety`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., hygiene, documentation)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level label of the finding."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (Open, Closed, etc.)."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded."
    - name: "severity_score_avg"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average severity score of findings."
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of findings classified as Critical severity."
    - name: "open_finding_count"
      expr: SUM(CASE WHEN audit_finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of findings that remain open."
$$;