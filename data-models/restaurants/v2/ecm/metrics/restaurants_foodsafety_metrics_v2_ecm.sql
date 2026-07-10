-- Metric views for domain: foodsafety | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_health_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for health inspections across restaurant units — tracks pass/fail rates, compliance scores, inspection fees, and corrective action backlog to steer food safety governance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`health_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of health inspection (routine, follow-up, complaint-driven) for segmenting compliance performance."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (open, closed, pending) for pipeline tracking."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Binary pass/fail outcome of the inspection — primary compliance signal."
    - name: "overall_grade"
      expr: overall_grade
      comment: "Letter or numeric grade assigned by the inspecting agency."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned during inspection (low, medium, high, critical)."
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the regulatory agency conducting the inspection."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was mandated as a result of this inspection."
    - name: "follow_up_inspection_required"
      expr: follow_up_inspection_required
      comment: "Flag indicating a follow-up inspection was required, signaling unresolved compliance issues."
    - name: "closure_order_flag"
      expr: closure_order_flag
      comment: "Flag indicating a closure order was issued — highest severity outcome."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month bucket of inspection date for trend analysis."
    - name: "inspection_date_year"
      expr: DATE_TRUNC('YEAR', inspection_date)
      comment: "Year bucket of inspection date for annual compliance reporting."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of health inspections conducted — baseline volume metric for compliance activity."
    - name: "total_inspection_fee_amount"
      expr: SUM(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Total regulatory inspection fees incurred — tracks compliance cost burden across the portfolio."
    - name: "avg_inspection_fee_amount"
      expr: AVG(CAST(inspection_fee_amount AS DOUBLE))
      comment: "Average inspection fee per inspection — benchmarks cost per compliance event."
    - name: "inspections_with_closure_order"
      expr: COUNT(CASE WHEN closure_order_flag = TRUE THEN 1 END)
      comment: "Count of inspections resulting in a closure order — highest-severity compliance failure indicator."
    - name: "inspections_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections that mandated corrective action — measures remediation workload."
    - name: "inspections_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Count of inspections requiring a follow-up visit — signals unresolved compliance gaps."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that required corrective action — key compliance quality rate for executive dashboards."
    - name: "closure_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_order_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in closure orders — critical risk metric for brand and regulatory exposure."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring follow-up — measures first-pass compliance effectiveness."
    - name: "distinct_units_inspected"
      expr: COUNT(DISTINCT health_unit_id)
      comment: "Number of distinct restaurant units that received a health inspection — measures compliance coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for internal food safety audits — tracks compliance scores, critical findings, corrective action status, and audit throughput to drive continuous improvement."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of food safety audit (internal, third-party, regulatory) for segmenting audit rigor and source."
    - name: "food_safety_audit_status"
      expr: food_safety_audit_status
      comment: "Current lifecycle status of the audit (scheduled, in-progress, completed, closed)."
    - name: "pass_fail"
      expr: pass_fail
      comment: "Overall pass/fail outcome of the audit — primary compliance signal."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from the audit — tracks remediation progress."
    - name: "allergen_control_compliant"
      expr: allergen_control_compliant
      comment: "Flag indicating allergen control compliance during the audit — critical food safety dimension."
    - name: "sanitation_schedule_compliant"
      expr: sanitation_schedule_compliant
      comment: "Flag indicating sanitation schedule compliance — operational hygiene signal."
    - name: "temperature_monitoring_compliant"
      expr: temperature_monitoring_compliant
      comment: "Flag indicating temperature monitoring compliance — HACCP critical control signal."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the audit standard being assessed."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_timestamp)
      comment: "Month bucket of audit timestamp for trend analysis."
    - name: "audit_date_year"
      expr: DATE_TRUNC('YEAR', audit_timestamp)
      comment: "Year bucket of audit timestamp for annual compliance reporting."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of food safety audits conducted — baseline volume for compliance activity tracking."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits — primary KPI for food safety program effectiveness."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score — composite quality signal used in QBR dashboards."
    - name: "total_critical_findings"
      expr: COUNT(CASE WHEN critical_findings_count IS NOT NULL AND critical_findings_count != '0' THEN 1 END)
      comment: "Count of audits with at least one critical finding — measures severity of compliance failures."
    - name: "audits_passed"
      expr: COUNT(CASE WHEN pass_fail = 'Pass' THEN 1 END)
      comment: "Number of audits with a passing outcome — measures compliance success volume."
    - name: "audits_failed"
      expr: COUNT(CASE WHEN pass_fail = 'Fail' THEN 1 END)
      comment: "Number of audits with a failing outcome — measures compliance failure volume."
    - name: "audit_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits passed — headline compliance rate for executive and board reporting."
    - name: "allergen_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_control_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where allergen controls were compliant — critical food safety risk metric."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_monitoring_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where temperature monitoring was compliant — HACCP adherence rate."
    - name: "sanitation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanitation_schedule_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where sanitation schedules were compliant — hygiene program effectiveness."
    - name: "distinct_units_audited"
      expr: COUNT(DISTINCT food_unit_id)
      comment: "Number of distinct restaurant units audited — measures audit coverage breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for audit findings — tracks finding severity distribution, resolution rates, overdue items, and cost center exposure to prioritize remediation and reduce compliance risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`audit_finding`"
  dimensions:
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (open, in-progress, resolved, closed) for pipeline management."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., temperature, sanitation, labeling) for root-cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (critical, major, minor) — drives prioritization."
    - name: "has_attachment"
      expr: has_attachment
      comment: "Flag indicating whether supporting documentation is attached — measures evidence quality."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month bucket of finding due date for remediation timeline tracking."
    - name: "finding_timestamp_month"
      expr: DATE_TRUNC('MONTH', finding_timestamp)
      comment: "Month bucket of when the finding was recorded for trend analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume for compliance gap tracking."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average numeric severity score across findings — composite risk signal for prioritization."
    - name: "critical_findings_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of critical-severity findings — highest-priority compliance failures requiring immediate action."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status = 'Open' THEN 1 END)
      comment: "Count of currently open findings — measures unresolved compliance backlog."
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND audit_finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of findings past their due date without resolution — critical operational risk indicator."
    - name: "finding_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_finding_status IN ('Closed', 'Resolved') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been resolved or closed — measures remediation effectiveness."
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings classified as critical — risk concentration metric for executive reporting."
    - name: "distinct_audits_with_findings"
      expr: COUNT(DISTINCT food_safety_audit_id)
      comment: "Number of distinct audits that generated at least one finding — measures audit failure breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_allergen_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-priority KPIs for allergen incidents — tracks incident volume, severity, regulatory filing rates, investigation completion, and repeat incident patterns to protect guest safety and manage brand/legal risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`allergen_incident`"
  dimensions:
    - name: "allergen_incident_status"
      expr: allergen_incident_status
      comment: "Current status of the allergen incident (open, under investigation, resolved, closed)."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the allergen incident for root-cause segmentation."
    - name: "severity_score"
      expr: severity_score
      comment: "Severity classification of the incident — drives triage and escalation decisions."
    - name: "allergen_code"
      expr: allergen_code
      comment: "Standardized allergen code (e.g., peanut, gluten, shellfish) for allergen-specific trend analysis."
    - name: "allergen_name"
      expr: allergen_name
      comment: "Human-readable allergen name for reporting and guest communication."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the incident was handled in compliance with food safety protocols."
    - name: "fda_medwatch_filed"
      expr: fda_medwatch_filed
      comment: "Flag indicating whether an FDA MedWatch report was filed — regulatory obligation tracking."
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Flag indicating this is a repeat allergen incident — signals systemic control failure."
    - name: "investigation_complete"
      expr: investigation_complete
      comment: "Flag indicating whether the investigation has been completed."
    - name: "regulatory_notification_status"
      expr: regulatory_notification_status
      comment: "Status of regulatory notification for the incident — compliance obligation tracking."
    - name: "incident_timestamp_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month bucket of incident timestamp for trend and seasonality analysis."
    - name: "incident_timestamp_year"
      expr: DATE_TRUNC('YEAR', incident_timestamp)
      comment: "Year bucket of incident timestamp for annual safety reporting."
  measures:
    - name: "total_allergen_incidents"
      expr: COUNT(1)
      comment: "Total number of allergen incidents recorded — baseline volume for guest safety risk tracking."
    - name: "fda_medwatch_filed_count"
      expr: COUNT(CASE WHEN fda_medwatch_filed = TRUE THEN 1 END)
      comment: "Count of incidents where an FDA MedWatch report was filed — regulatory compliance volume."
    - name: "repeat_incidents_count"
      expr: COUNT(CASE WHEN is_repeat_incident = TRUE THEN 1 END)
      comment: "Count of repeat allergen incidents — signals systemic allergen control failures requiring escalation."
    - name: "investigations_complete_count"
      expr: COUNT(CASE WHEN investigation_complete = TRUE THEN 1 END)
      comment: "Count of incidents with completed investigations — measures investigation throughput."
    - name: "repeat_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_incident = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergen incidents that are repeats — key indicator of systemic control failure."
    - name: "investigation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergen incidents with completed investigations — measures response thoroughness."
    - name: "fda_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fda_medwatch_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in FDA MedWatch filings — regulatory compliance rate."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergen incidents handled in compliance with food safety protocols."
    - name: "distinct_units_with_incidents"
      expr: COUNT(DISTINCT allergen_restaurant_unit_id)
      comment: "Number of distinct restaurant units with allergen incidents — measures geographic risk spread."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive KPIs for food recall events — tracks recall volume, severity, scope, units recalled vs. disposed, and regulatory compliance to manage brand risk and supply chain safety."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (active, closed, monitoring) for pipeline management."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (voluntary, mandatory, market withdrawal) — regulatory classification."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (Class I, II, III) indicating health hazard severity."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the recall — drives escalation and resource allocation."
    - name: "is_voluntary"
      expr: is_voluntary
      comment: "Flag indicating whether the recall was voluntary — distinguishes proactive vs. mandated recalls."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency overseeing the recall (FDA, USDA, etc.)."
    - name: "distribution_region"
      expr: distribution_region
      comment: "Geographic region affected by the recall — scope and impact dimension."
    - name: "recall_effective_date_month"
      expr: DATE_TRUNC('MONTH', recall_effective_date)
      comment: "Month bucket of recall effective date for trend analysis."
    - name: "recall_effective_date_year"
      expr: DATE_TRUNC('YEAR', recall_effective_date)
      comment: "Year bucket of recall effective date for annual safety reporting."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of food recall events — baseline volume for supply chain safety risk tracking."
    - name: "avg_severity_score"
      expr: AVG(CAST(severity_score AS DOUBLE))
      comment: "Average numeric severity score across recalls — composite risk signal for executive reporting."
    - name: "voluntary_recall_count"
      expr: COUNT(CASE WHEN is_voluntary = TRUE THEN 1 END)
      comment: "Count of voluntary recalls — measures proactive food safety culture."
    - name: "active_recalls_count"
      expr: COUNT(CASE WHEN recall_status = 'Active' THEN 1 END)
      comment: "Count of currently active recalls — real-time supply chain risk exposure."
    - name: "voluntary_recall_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voluntary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls that were voluntary — measures proactive safety culture vs. regulatory-forced action."
    - name: "distinct_suppliers_with_recalls"
      expr: COUNT(DISTINCT food_procurement_supplier_id)
      comment: "Number of distinct suppliers involved in recall events — supplier risk concentration metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for food safety corrective actions — tracks action volume, cost, completion rates, CCP deviations, and temperature exceedances to measure remediation effectiveness and compliance closure."
  source: "`vibe_restaurants_v1`.`foodsafety`.`foodsafety_corrective_action`"
  dimensions:
    - name: "foodsafety_corrective_action_status"
      expr: foodsafety_corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, verified, closed)."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action taken — categorizes remediation approach."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the corrective action — drives prioritization and escalation."
    - name: "priority"
      expr: priority
      comment: "Priority classification of the corrective action (high, medium, low)."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the corrective action — measures remediation completion."
    - name: "ccp_deviation"
      expr: ccp_deviation
      comment: "Flag indicating the corrective action was triggered by a Critical Control Point deviation — HACCP signal."
    - name: "temperature_exceedance"
      expr: temperature_exceedance
      comment: "Flag indicating the corrective action was triggered by a temperature exceedance — food safety risk signal."
    - name: "is_effective"
      expr: is_effective
      comment: "Flag indicating whether the corrective action was verified as effective — measures remediation quality."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the action cost for multi-currency cost analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month bucket of corrective action effective date for trend analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year bucket of corrective action effective date for annual reporting."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions recorded — baseline volume for compliance remediation tracking."
    - name: "total_action_cost"
      expr: SUM(CAST(action_cost AS DOUBLE))
      comment: "Total cost of corrective actions — measures financial burden of food safety non-compliance."
    - name: "avg_action_cost"
      expr: AVG(CAST(action_cost AS DOUBLE))
      comment: "Average cost per corrective action — benchmarks remediation cost efficiency."
    - name: "ccp_deviation_actions_count"
      expr: COUNT(CASE WHEN ccp_deviation = TRUE THEN 1 END)
      comment: "Count of corrective actions triggered by CCP deviations — HACCP critical failure volume."
    - name: "temperature_exceedance_actions_count"
      expr: COUNT(CASE WHEN temperature_exceedance = TRUE THEN 1 END)
      comment: "Count of corrective actions triggered by temperature exceedances — food safety risk volume."
    - name: "effective_actions_count"
      expr: COUNT(CASE WHEN is_effective = TRUE THEN 1 END)
      comment: "Count of corrective actions verified as effective — measures remediation success volume."
    - name: "corrective_action_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_effective = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions verified as effective — headline remediation quality KPI."
    - name: "ccp_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ccp_deviation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions triggered by CCP deviations — HACCP compliance risk rate."
    - name: "overdue_actions_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND closure_status NOT IN ('Closed', 'Verified') THEN 1 END)
      comment: "Count of corrective actions past their target completion date — measures remediation backlog risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_temperature_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HACCP-critical KPIs for temperature monitoring — tracks deviation rates, calibration compliance, average readings vs. critical limits, and maintenance status to ensure food safety temperature controls."
  source: "`vibe_restaurants_v1`.`foodsafety`.`temperature_log`"
  dimensions:
    - name: "temperature_log_status"
      expr: temperature_log_status
      comment: "Current status of the temperature log record (active, archived, flagged)."
    - name: "reading_type"
      expr: reading_type
      comment: "Type of temperature reading (ambient, product, equipment) for segmenting monitoring context."
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Flag indicating the temperature reading exceeded critical limits — primary HACCP alert signal."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the temperature reading against food safety standards."
    - name: "maintenance_required"
      expr: maintenance_required
      comment: "Flag indicating the monitoring equipment requires maintenance — equipment reliability signal."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating data quality issues with the temperature reading — data integrity signal."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of temperature measurement (Celsius, Fahrenheit) for consistent analysis."
    - name: "temperature_trend"
      expr: temperature_trend
      comment: "Trend direction of temperature readings (rising, stable, falling) for predictive monitoring."
    - name: "reading_timestamp_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month bucket of temperature reading timestamp for trend analysis."
    - name: "reading_timestamp_date"
      expr: DATE_TRUNC('DAY', reading_timestamp)
      comment: "Day bucket of temperature reading timestamp for daily operational monitoring."
  measures:
    - name: "total_temperature_readings"
      expr: COUNT(1)
      comment: "Total number of temperature readings recorded — baseline volume for HACCP monitoring coverage."
    - name: "avg_temperature_value"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature reading value — baseline for comparing against critical limits."
    - name: "avg_critical_limit_high"
      expr: AVG(CAST(critical_limit_high AS DOUBLE))
      comment: "Average configured critical high limit — context for interpreting deviation rates."
    - name: "avg_critical_limit_low"
      expr: AVG(CAST(critical_limit_low AS DOUBLE))
      comment: "Average configured critical low limit — context for interpreting deviation rates."
    - name: "deviation_count"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Count of temperature readings that exceeded critical limits — HACCP failure volume."
    - name: "maintenance_required_count"
      expr: COUNT(CASE WHEN maintenance_required = TRUE THEN 1 END)
      comment: "Count of readings where equipment maintenance is required — equipment reliability risk."
    - name: "data_quality_issue_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of readings with data quality flags — measures monitoring data integrity."
    - name: "temperature_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings that deviated from critical limits — headline HACCP compliance KPI."
    - name: "data_quality_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of temperature readings with data quality issues — monitoring reliability metric."
    - name: "distinct_equipment_monitored"
      expr: COUNT(DISTINCT temperature_equipment_asset_id)
      comment: "Number of distinct equipment assets being temperature-monitored — HACCP coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_illness_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health and workforce KPIs for illness reports — tracks report volume, exclusion decisions, health department notification rates, and investigation completion to manage foodborne illness risk."
  source: "`vibe_restaurants_v1`.`foodsafety`.`illness_report`"
  dimensions:
    - name: "illness_report_status"
      expr: illness_report_status
      comment: "Current status of the illness report (open, under investigation, closed)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the illness report — drives escalation and public health response."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the illness investigation — measures response thoroughness."
    - name: "suspected_pathogen"
      expr: suspected_pathogen
      comment: "Suspected pathogen associated with the illness — enables pathogen-specific trend analysis."
    - name: "exclusion_decision"
      expr: exclusion_decision
      comment: "Flag indicating whether the employee was excluded from work — workforce safety decision signal."
    - name: "health_department_notified"
      expr: health_department_notified
      comment: "Flag indicating whether the health department was notified — regulatory compliance signal."
    - name: "report_method"
      expr: report_method
      comment: "Method by which the illness was reported (self-report, manager, health dept) for process analysis."
    - name: "onset_date_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month bucket of illness onset date for epidemiological trend analysis."
    - name: "onset_date_year"
      expr: DATE_TRUNC('YEAR', onset_date)
      comment: "Year bucket of illness onset date for annual public health reporting."
  measures:
    - name: "total_illness_reports"
      expr: COUNT(1)
      comment: "Total number of illness reports filed — baseline volume for foodborne illness risk tracking."
    - name: "exclusion_decisions_count"
      expr: COUNT(CASE WHEN exclusion_decision = TRUE THEN 1 END)
      comment: "Count of illness reports resulting in employee exclusion from work — workforce safety action volume."
    - name: "health_dept_notifications_count"
      expr: COUNT(CASE WHEN health_department_notified = TRUE THEN 1 END)
      comment: "Count of illness reports where the health department was notified — regulatory compliance volume."
    - name: "exclusion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_decision = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports resulting in employee exclusion — workforce safety response rate."
    - name: "health_dept_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN health_department_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of illness reports where health department was notified — regulatory compliance rate."
    - name: "distinct_units_with_illness_reports"
      expr: COUNT(DISTINCT illness_unit_id)
      comment: "Number of distinct restaurant units with illness reports — geographic risk spread metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce compliance KPIs for food safety training — tracks training completion rates, assessment scores, pass/fail outcomes, and expiration management to ensure a certified and compliant workforce."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_training`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (scheduled, in-progress, completed, expired)."
    - name: "training_type"
      expr: training_type
      comment: "Type of food safety training (HACCP, allergen, sanitation, etc.) for program-level analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training assessment — primary competency signal."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training record against regulatory requirements."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (in-person, e-learning, on-the-job) for program effectiveness analysis."
    - name: "training_program_name"
      expr: training_program_name
      comment: "Name of the training program for program-level performance tracking."
    - name: "completion_timestamp_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month bucket of training completion for throughput trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month bucket of training expiration date for renewal pipeline management."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of food safety training records — baseline volume for workforce compliance tracking."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions — measures workforce competency level."
    - name: "training_passed_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Count of training records with a passing assessment — measures successful competency attainment."
    - name: "training_failed_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of training records with a failing assessment — identifies workforce competency gaps."
    - name: "expired_training_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND training_status NOT IN ('Completed', 'Renewed') THEN 1 END)
      comment: "Count of training records that have expired without renewal — compliance risk backlog."
    - name: "training_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions with a passing score — headline workforce competency KPI."
    - name: "training_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records in compliant status — regulatory training adherence rate."
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT food_employee_id)
      comment: "Number of distinct employees with food safety training records — workforce coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_inspection_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory KPIs for inspection violations — tracks violation volume, severity distribution, penalty amounts, resolution rates, and repeat patterns to manage regulatory risk and compliance remediation."
  source: "`vibe_restaurants_v1`.`foodsafety`.`inspection_violation`"
  dimensions:
    - name: "inspection_violation_status"
      expr: inspection_violation_status
      comment: "Current status of the violation record (open, corrected, contested, closed)."
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation (critical, non-critical, repeat) for risk segmentation."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the violation — drives prioritization and regulatory response."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action for the violation — measures remediation progress."
    - name: "area_of_concern"
      expr: area_of_concern
      comment: "Area of the restaurant where the violation was identified — spatial risk analysis."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty amount for multi-currency financial analysis."
    - name: "violation_timestamp_month"
      expr: DATE_TRUNC('MONTH', violation_timestamp)
      comment: "Month bucket of violation timestamp for trend analysis."
    - name: "violation_timestamp_year"
      expr: DATE_TRUNC('YEAR', violation_timestamp)
      comment: "Year bucket of violation timestamp for annual regulatory reporting."
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of inspection violations recorded — baseline volume for regulatory risk tracking."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from inspection violations — direct regulatory cost metric."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per violation — benchmarks regulatory cost per compliance failure."
    - name: "open_violations_count"
      expr: COUNT(CASE WHEN inspection_violation_status = 'Open' THEN 1 END)
      comment: "Count of currently open violations — unresolved regulatory risk backlog."
    - name: "violations_with_penalties_count"
      expr: COUNT(CASE WHEN penalty_amount > 0 THEN 1 END)
      comment: "Count of violations that resulted in financial penalties — measures regulatory enforcement severity."
    - name: "violation_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_violation_status IN ('Closed', 'Corrected') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that have been resolved — measures regulatory remediation effectiveness."
    - name: "penalty_incidence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations resulting in financial penalties — regulatory enforcement rate."
    - name: "distinct_inspections_with_violations"
      expr: COUNT(DISTINCT health_inspection_id)
      comment: "Number of distinct health inspections that generated violations — measures inspection failure breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_critical_control_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HACCP program KPIs for critical control points — tracks deviation counts, monitoring compliance, verification frequency, and CCP status to ensure HACCP plan integrity and food safety assurance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`critical_control_point`"
  dimensions:
    - name: "critical_control_point_status"
      expr: critical_control_point_status
      comment: "Current status of the CCP (active, inactive, under review) for program management."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of hazard controlled by the CCP (biological, chemical, physical) — HACCP classification."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical control point vs. a prerequisite program."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of CCP monitoring (continuous, hourly, daily) — compliance rigor dimension."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Method used to monitor the CCP (temperature probe, visual, pH meter) for process analysis."
    - name: "process_step"
      expr: process_step
      comment: "Process step where the CCP is applied (receiving, cooking, cooling) for HACCP flow analysis."
    - name: "verification_frequency"
      expr: verification_frequency
      comment: "Frequency of CCP verification activities — HACCP plan rigor signal."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month bucket of CCP effective start date for program timeline analysis."
  measures:
    - name: "total_ccps"
      expr: COUNT(1)
      comment: "Total number of critical control points defined — HACCP program scope metric."
    - name: "avg_critical_limit_max"
      expr: AVG(CAST(critical_limit_max AS DOUBLE))
      comment: "Average critical limit maximum across CCPs — baseline for limit calibration analysis."
    - name: "avg_critical_limit_min"
      expr: AVG(CAST(critical_limit_min AS DOUBLE))
      comment: "Average critical limit minimum across CCPs — baseline for limit calibration analysis."
    - name: "avg_deviation_value"
      expr: AVG(CAST(average_deviation_value AS DOUBLE))
      comment: "Average deviation value across CCPs — measures typical magnitude of CCP exceedances."
    - name: "active_ccps_count"
      expr: COUNT(CASE WHEN critical_control_point_status = 'Active' THEN 1 END)
      comment: "Count of currently active CCPs — measures active HACCP program scope."
    - name: "critical_ccps_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of CCPs classified as critical — measures highest-risk control point volume."
    - name: "ccps_with_deviations_count"
      expr: COUNT(CASE WHEN average_deviation_value > 0 THEN 1 END)
      comment: "Count of CCPs with recorded deviations — measures HACCP control failure breadth."
    - name: "ccp_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN average_deviation_value > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CCPs with recorded deviations — headline HACCP program failure rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_receiving_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain food safety KPIs for receiving inspections — tracks temperature compliance, visual quality pass rates, rejection rates, and corrective action triggers to ensure incoming product safety."
  source: "`vibe_restaurants_v1`.`foodsafety`.`receiving_inspection`"
  dimensions:
    - name: "receiving_inspection_status"
      expr: receiving_inspection_status
      comment: "Current status of the receiving inspection (pass, fail, pending, rejected)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the receiving inspection against food safety standards."
    - name: "temperature_pass_flag"
      expr: temperature_pass_flag
      comment: "Flag indicating whether the received product passed temperature requirements — HACCP receiving control."
    - name: "visual_quality_pass"
      expr: visual_quality_pass
      comment: "Flag indicating whether the received product passed visual quality inspection."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating a corrective action was required at receiving — supply chain risk signal."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for product rejection at receiving — root cause analysis dimension."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantity — context for volume analysis."
    - name: "receiving_date_month"
      expr: DATE_TRUNC('MONTH', receiving_date)
      comment: "Month bucket of receiving date for trend analysis."
    - name: "receiving_date_year"
      expr: DATE_TRUNC('YEAR', receiving_date)
      comment: "Year bucket of receiving date for annual supply chain safety reporting."
  measures:
    - name: "total_receiving_inspections"
      expr: COUNT(1)
      comment: "Total number of receiving inspections conducted — baseline volume for supply chain safety coverage."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of product received across all inspections — supply chain volume metric."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average receiving temperature in Celsius — baseline for cold chain compliance analysis."
    - name: "temperature_pass_count"
      expr: COUNT(CASE WHEN temperature_pass_flag = TRUE THEN 1 END)
      comment: "Count of receiving inspections that passed temperature requirements — cold chain compliance volume."
    - name: "visual_quality_pass_count"
      expr: COUNT(CASE WHEN visual_quality_pass = TRUE THEN 1 END)
      comment: "Count of receiving inspections that passed visual quality checks — product quality volume."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of receiving inspections requiring corrective action — supply chain failure volume."
    - name: "temperature_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving inspections passing temperature requirements — cold chain compliance rate."
    - name: "visual_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visual_quality_pass = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving inspections passing visual quality checks — incoming product quality rate."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receiving inspections requiring corrective action — supply chain non-conformance rate."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with receiving inspections — supply chain safety coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_food_safety_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance KPIs for food safety certifications — tracks certification validity, expiration pipeline, renewal rates, and compliance flags to ensure continuous regulatory certification coverage."
  source: "`vibe_restaurants_v1`.`foodsafety`.`food_safety_certification`"
  dimensions:
    - name: "food_safety_certification_status"
      expr: food_safety_certification_status
      comment: "Current status of the certification (active, expired, revoked, pending renewal)."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of food safety certification (HACCP, ServSafe, ISO 22000, etc.) for program analysis."
    - name: "certification_category"
      expr: certification_category
      comment: "Category of certification (employee, facility, process) for coverage analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the certification is currently compliant — primary validity signal."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flag indicating renewal is required — pipeline management signal."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Flag indicating an expiration notice was sent — proactive compliance management signal."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification — regulatory authority dimension."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month bucket of certification expiration date for renewal pipeline management."
    - name: "issue_date_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year bucket of certification issue date for cohort analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of food safety certifications on record — baseline compliance portfolio size."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN food_safety_certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications — measures live compliance coverage."
    - name: "expired_certifications_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND food_safety_certification_status != 'Revoked' THEN 1 END)
      comment: "Count of certifications that have expired — compliance gap risk metric."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Count of certifications expiring within 30 days — near-term renewal pipeline for proactive management."
    - name: "compliant_certifications_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of certifications currently in compliant status — active compliance coverage volume."
    - name: "certification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications in compliant status — headline certification compliance rate."
    - name: "expiration_notice_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expiration_notice_sent = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN renewal_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of renewal-required certifications where expiration notices were sent — proactive compliance management rate."
    - name: "distinct_employees_certified"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees holding food safety certifications — workforce certification coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_pest_control_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility hygiene KPIs for pest control activities — tracks service compliance, pest identification rates, corrective action triggers, and allergen control flags to manage facility safety and regulatory compliance."
  source: "`vibe_restaurants_v1`.`foodsafety`.`pest_control_log`"
  dimensions:
    - name: "record_status"
      expr: record_status
      comment: "Current status of the pest control log record (active, closed, pending)."
    - name: "service_type"
      expr: service_type
      comment: "Type of pest control service (preventive, reactive, inspection) for program analysis."
    - name: "service_status"
      expr: service_status
      comment: "Status of the pest control service (completed, scheduled, cancelled)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of pest activity identified — drives escalation and remediation priority."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the pest control activity was compliant with standards."
    - name: "allergen_control_flag"
      expr: allergen_control_flag
      comment: "Flag indicating allergen control considerations were addressed during pest control service."
    - name: "service_timestamp_month"
      expr: DATE_TRUNC('MONTH', service_timestamp)
      comment: "Month bucket of service timestamp for trend analysis."
    - name: "service_timestamp_year"
      expr: DATE_TRUNC('YEAR', service_timestamp)
      comment: "Year bucket of service timestamp for annual facility hygiene reporting."
  measures:
    - name: "total_pest_control_services"
      expr: COUNT(1)
      comment: "Total number of pest control service events — baseline volume for facility hygiene activity."
    - name: "services_with_pests_identified"
      expr: COUNT(CASE WHEN pests_identified IS NOT NULL AND pests_identified != '' THEN 1 END)
      comment: "Count of services where pests were identified — measures active infestation incidence."
    - name: "compliant_services_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of pest control services conducted in compliance with standards."
    - name: "pest_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pests_identified IS NOT NULL AND pests_identified != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pest control visits where pests were identified — facility infestation rate."
    - name: "service_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pest control services conducted in compliance — facility hygiene compliance rate."
    - name: "distinct_units_serviced"
      expr: COUNT(DISTINCT pest_unit_id)
      comment: "Number of distinct restaurant units receiving pest control services — facility coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`foodsafety_recall_unit_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for unit-level recall responses — tracks affected quantity, disposition actions, verification status, and regulatory compliance to measure recall execution effectiveness across the restaurant portfolio."
  source: "`vibe_restaurants_v1`.`foodsafety`.`recall_unit_response`"
  dimensions:
    - name: "recall_unit_response_status"
      expr: recall_unit_response_status
      comment: "Current status of the unit recall response (pending, in-progress, completed, verified)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the unit recall response against regulatory requirements."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to dispose of recalled product (destroy, return, quarantine) — recall execution dimension."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Severity classification of the recall — drives response urgency and resource allocation."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of recall response verification — measures execution quality."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating regulatory compliance of the recall response — primary regulatory obligation signal."
    - name: "evidence_documentation_flag"
      expr: evidence_documentation_flag
      comment: "Flag indicating evidence documentation was completed — audit trail quality signal."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for affected quantity — context for volume analysis."
    - name: "disposition_date_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month bucket of disposition date for recall execution timeline analysis."
  measures:
    - name: "total_unit_responses"
      expr: COUNT(1)
      comment: "Total number of unit-level recall responses — baseline volume for recall execution tracking."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by recalls across all unit responses — recall scope metric."
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average affected quantity per unit response — benchmarks recall impact per location."
    - name: "regulatory_compliant_responses_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of unit responses meeting regulatory compliance requirements — compliance execution volume."
    - name: "verified_responses_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of unit responses that have been verified — measures recall execution quality."
    - name: "regulatory_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unit recall responses meeting regulatory compliance — headline recall execution KPI."
    - name: "verification_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unit responses that have been verified — recall execution thoroughness rate."
    - name: "evidence_documentation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evidence_documentation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unit responses with evidence documentation — audit trail completeness rate."
    - name: "distinct_units_responding"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct restaurant units that responded to recall events — recall coverage breadth."
$$;