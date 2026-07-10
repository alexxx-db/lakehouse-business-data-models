-- Metric views for domain: compliance | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for compliance audit events — tracks audit outcomes, risk exposure, and corrective-action burden to steer the audit programme."
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_event_status"
      expr: audit_event_status
      comment: "Current lifecycle status of the audit event (e.g. Open, Closed, In-Progress) for pipeline analysis."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment performed (e.g. Internal, External, Regulatory) for segmenting audit coverage."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Methodology used (e.g. Document Review, On-Site Inspection) to analyse audit rigour."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity classification of the audit event to prioritise remediation effort."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory body associated with the audit event for agency-level compliance tracking."
    - name: "department"
      expr: department
      comment: "Organisational department under audit for departmental compliance benchmarking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was mandated, used to measure audit severity distribution."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month of the audit event for trend analysis over time."
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Calendar year of the audit event for annual compliance reporting."
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit events — baseline volume KPI for audit programme throughput."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across audit events; rising average signals deteriorating compliance posture requiring executive intervention."
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Highest risk score observed — flags the most critical audit event in the selected period for immediate escalation."
    - name: "total_corrective_action_required"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audit events that mandated corrective action — directly measures compliance failure volume."
    - name: "pct_with_evidence_attached"
      expr: ROUND(100.0 * SUM(CASE WHEN evidence_attached = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit events with supporting evidence attached — measures audit documentation completeness, a key audit-quality KPI."
    - name: "distinct_audited_departments"
      expr: COUNT(DISTINCT department)
      comment: "Number of distinct departments audited — measures breadth of audit coverage across the organisation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for compliance audit plans — measures planning effectiveness, compliance scores, and corrective-action backlog to guide audit programme investment."
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_plan`"
  dimensions:
    - name: "audit_plan_status"
      expr: audit_plan_status
      comment: "Lifecycle status of the audit plan (e.g. Draft, Active, Completed) for pipeline visibility."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g. Financial, Safety, Quality) for cross-functional compliance analysis."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Planned frequency of audits (e.g. Annual, Quarterly) to assess scheduling adequacy."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit plan for risk-based prioritisation."
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology applied in the audit plan for quality benchmarking."
    - name: "plan_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the audit plan is scheduled to start for annual planning analysis."
    - name: "plan_quarter"
      expr: DATE_TRUNC('QUARTER', scheduled_start_date)
      comment: "Quarter the audit plan is scheduled to start for quarterly review cadence."
  measures:
    - name: "total_audit_plans"
      expr: COUNT(1)
      comment: "Total number of audit plans — baseline measure of audit programme scope."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audit plans — primary KPI for overall compliance health; declining score triggers programme review."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit execution score — measures audit quality and thoroughness across the programme."
    - name: "min_compliance_score"
      expr: MIN(CAST(compliance_score AS DOUBLE))
      comment: "Lowest compliance score observed — identifies the most at-risk audit area requiring immediate remediation."
    - name: "plans_with_overdue_corrective_action"
      expr: SUM(CASE WHEN corrective_action_due_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of audit plans with past-due corrective action deadlines — measures remediation backlog and regulatory exposure."
    - name: "avg_plan_duration_days"
      expr: AVG(DATEDIFF(scheduled_end_date, scheduled_start_date))
      comment: "Average planned duration of audit plans in days — informs resource planning and scheduling efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance audit findings — tracks finding severity, repeat-finding rates, and resolution timeliness to drive corrective-action effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "compliance_audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current status of the finding (e.g. Open, Closed, In-Review) for backlog management."
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (e.g. Major Non-Conformance, Observation) for severity-based prioritisation."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding to focus remediation resources on critical issues."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding for risk-adjusted compliance reporting."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this is a recurrence of a prior finding — key indicator of systemic compliance failure."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required for this finding."
    - name: "impact_area"
      expr: impact_area
      comment: "Business area impacted by the finding for cross-functional compliance analysis."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the finding was discovered for trend analysis."
    - name: "affected_process"
      expr: affected_process
      comment: "Business process affected by the finding for process-level compliance benchmarking."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume KPI for compliance failure tracking."
    - name: "repeat_findings_count"
      expr: SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat findings — high repeat rate signals systemic root-cause failures requiring programme-level intervention."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats — executive KPI for corrective-action effectiveness; target is near zero."
    - name: "open_findings_count"
      expr: SUM(CASE WHEN compliance_audit_finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of currently open findings — measures unresolved compliance exposure requiring management attention."
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(actual_resolution_date, discovery_date))
      comment: "Average days from discovery to resolution — measures corrective-action speed; longer cycles increase regulatory risk."
    - name: "overdue_findings_count"
      expr: SUM(CASE WHEN target_resolution_date < CURRENT_DATE() AND compliance_audit_finding_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of findings past their target resolution date — directly measures compliance remediation backlog and regulatory exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Corrective and Preventive Action (CAPA) records — measures CAPA effectiveness, penalty exposure, and closure rates to steer quality and compliance remediation."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_capa_record`"
  dimensions:
    - name: "compliance_capa_record_status"
      expr: compliance_capa_record_status
      comment: "Current lifecycle status of the CAPA record for pipeline and backlog management."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure classification of the CAPA (e.g. Verified Effective, Closed Ineffective) for effectiveness analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the CAPA for risk-based prioritisation of remediation resources."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying compliance issue driving the CAPA."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the CAPA for resource allocation decisions."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or quality framework the CAPA addresses (e.g. ISO 9001, OSHA) for framework-level compliance tracking."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for executing the CAPA for accountability reporting."
    - name: "is_external_citation"
      expr: is_external_citation
      comment: "Whether the CAPA was triggered by an external regulatory citation — external citations carry higher penalty risk."
    - name: "capa_creation_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the CAPA was created for trend and backlog analysis."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total CAPA records — baseline volume KPI for compliance remediation workload."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties associated with CAPA records — direct measure of regulatory non-compliance cost; key CFO and CCO KPI."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per CAPA record — benchmarks penalty severity and informs risk provisioning."
    - name: "avg_effectiveness_score"
      expr: AVG(CAST(effectiveness_score AS DOUBLE))
      comment: "Average CAPA effectiveness score — measures whether corrective actions are actually resolving root causes; low scores trigger programme review."
    - name: "overdue_capa_count"
      expr: SUM(CASE WHEN target_completion_date < CURRENT_DATE() AND compliance_capa_record_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of CAPAs past their target completion date — measures remediation backlog and escalating regulatory risk."
    - name: "external_citation_count"
      expr: SUM(CASE WHEN is_external_citation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs triggered by external regulatory citations — high count signals deteriorating regulator relationship requiring executive attention."
    - name: "avg_closure_days"
      expr: AVG(DATEDIFF(closure_date, created_timestamp))
      comment: "Average days from CAPA creation to closure — measures remediation velocity; longer cycles increase penalty and reputational risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for product compliance certifications — tracks certification coverage, cost, expiry risk, and renewal status to protect market access and regulatory standing."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending) for portfolio health monitoring."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Safety, Environmental, Quality) for cross-category compliance analysis."
    - name: "compliance_region"
      expr: compliance_region
      comment: "Geographic region the certification applies to for market-access compliance tracking."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (e.g. Regulatory, Voluntary) for strategic certification portfolio management."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level of the certification for risk-based renewal prioritisation."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organisation that issued the certification for body-level performance benchmarking."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is legally mandatory — mandatory certifications require zero-lapse management."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Whether the certification requires renewal — drives renewal workload forecasting."
    - name: "is_export_controlled"
      expr: is_export_controlled
      comment: "Whether the certification relates to export-controlled products — critical for trade compliance."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires for forward-looking renewal planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total product certifications — baseline measure of certification portfolio size."
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total spend on product certifications — key cost-of-compliance KPI for budget planning and ROI analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(certification_cost AS DOUBLE))
      comment: "Average cost per certification — benchmarks certification efficiency and informs make-vs-buy decisions."
    - name: "expired_certifications_count"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of expired certifications — expired mandatory certifications create immediate market-access and regulatory risk."
    - name: "expiring_within_90_days_count"
      expr: SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Certifications expiring within 90 days — forward-looking risk KPI that triggers renewal action before lapse."
    - name: "mandatory_expired_count"
      expr: SUM(CASE WHEN is_mandatory = TRUE AND expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of expired mandatory certifications — highest-priority compliance risk KPI; any non-zero value requires immediate executive escalation."
    - name: "distinct_certifying_bodies"
      expr: COUNT(DISTINCT certifying_body)
      comment: "Number of distinct certifying bodies engaged — measures certification supply-chain diversity and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental KPIs for emissions records — tracks pollutant volumes, carbon intensity, exceedance rates, and reporting compliance to steer ESG and regulatory performance."
  source: "`vibe_manufacturing_v1`.`compliance`.`emissions_record`"
  dimensions:
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant measured (e.g. CO2, NOx, SOx) for pollutant-specific emissions management."
    - name: "report_status"
      expr: report_status
      comment: "Status of the emissions report submission for regulatory filing compliance tracking."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g. Verified, Estimated) for data quality segmentation."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Whether the measurement exceeded the regulatory limit — exceedances trigger immediate regulatory notification."
    - name: "source_category"
      expr: source_category
      comment: "Category of emission source (e.g. Stationary, Mobile) for source-level emissions analysis."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter for quarterly emissions trend analysis."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual ESG and regulatory reporting."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure emissions (e.g. CEMS, Calculation) for data quality and regulatory acceptance analysis."
    - name: "operational_shift"
      expr: operational_shift
      comment: "Operational shift during which the measurement was taken for shift-level emissions profiling."
  measures:
    - name: "total_measured_value"
      expr: SUM(CAST(measured_value AS DOUBLE))
      comment: "Total measured emissions value across all records — primary ESG KPI for absolute emissions volume reporting."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average emissions measurement per record — benchmarks typical emission levels against regulatory thresholds."
    - name: "total_greenhouse_gas_equivalent"
      expr: SUM(CAST(greenhouse_gas_equivalent AS DOUBLE))
      comment: "Total greenhouse gas equivalent (CO2e) — primary climate KPI for Scope 1/2 emissions reporting and net-zero tracking."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity across emission records — measures emissions efficiency; declining intensity signals decarbonisation progress."
    - name: "exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements that exceeded regulatory limits — each exceedance is a potential regulatory violation requiring immediate action."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements exceeding regulatory limits — key regulatory risk KPI; rising rate signals systemic emissions control failure."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for emissions measurements — low scores undermine regulatory reporting credibility and may trigger audits."
    - name: "total_emission_factor"
      expr: SUM(CAST(emission_factor AS DOUBLE))
      comment: "Sum of emission factors across records — used to assess aggregate emissions intensity for process benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility compliance KPIs — tracks environmental footprint, inspection status, permit health, and risk ratings across the facility portfolio to guide capital and compliance investment."
  source: "`vibe_manufacturing_v1`.`compliance`.`facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (e.g. Active, Decommissioned) for portfolio management."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g. Manufacturing, Warehouse) for facility-class compliance benchmarking."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status of the facility for compliance programme tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status for regulatory inspection management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the facility for risk-based compliance resource allocation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located for jurisdictional compliance analysis."
    - name: "security_level"
      expr: security_level
      comment: "Security level classification of the facility for cybersecurity and physical security compliance."
    - name: "hazardous_material_storage"
      expr: hazardous_material_storage
      comment: "Whether the facility stores hazardous materials — drives additional regulatory obligations and inspection frequency."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities in the compliance portfolio — baseline measure for compliance programme scope."
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions in tons across all facilities — primary ESG KPI for Scope 1 emissions reporting and net-zero target tracking."
    - name: "avg_co2_emissions_tons"
      expr: AVG(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Average CO2 emissions per facility — benchmarks facility-level environmental performance for decarbonisation prioritisation."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh across facilities — key sustainability KPI for energy efficiency programmes and carbon accounting."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons — ESG KPI for waste reduction programmes and circular economy reporting."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water consumption in cubic metres — sustainability KPI for water stewardship reporting and risk management in water-stressed regions."
    - name: "facilities_with_expired_epa_permit"
      expr: SUM(CASE WHEN epa_permit_expiry < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of facilities with expired EPA permits — expired permits create immediate regulatory violation risk requiring executive escalation."
    - name: "facilities_with_expired_insurance"
      expr: SUM(CASE WHEN insurance_expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of facilities with expired insurance policies — uninsured facilities represent unquantified financial and operational risk."
    - name: "hazardous_material_facility_count"
      expr: SUM(CASE WHEN hazardous_material_storage = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities storing hazardous materials — drives regulatory reporting obligations and emergency response planning scope."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety performance KPIs — tracks incident frequency, severity, lost-time rates, and regulatory reportability to steer EHS investment and OSHA compliance."
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the safety incident (e.g. Open, Closed, Under Investigation) for case management."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (e.g. Near Miss, Injury, Property Damage) for incident classification analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the incident for risk-based prioritisation of corrective actions."
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained for body-part and injury-type trend analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the incident investigation for root-cause closure tracking."
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Whether this is a repeat incident — repeat incidents signal systemic safety programme failures."
    - name: "reportable_to_osha_flag"
      expr: reportable_to_osha_flag
      comment: "Whether the incident must be reported to OSHA — OSHA-reportable incidents carry regulatory and reputational consequences."
    - name: "lost_time_flag"
      expr: lost_time_flag
      comment: "Whether the incident resulted in lost work time — lost-time incidents are the primary OSHA severity metric."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month of the incident for trend analysis and seasonal safety pattern identification."
    - name: "osha_300_log_classification"
      expr: osha_300_log_classification
      comment: "OSHA 300 log classification for regulatory recordkeeping and benchmarking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents — baseline safety KPI; rising count triggers EHS programme review and resource reallocation."
    - name: "lost_time_incident_count"
      expr: SUM(CASE WHEN lost_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lost-time incidents — primary OSHA safety KPI; directly impacts TRIR and LTIR regulatory benchmarks."
    - name: "osha_reportable_count"
      expr: SUM(CASE WHEN reportable_to_osha_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA-reportable incidents — regulatory compliance KPI; under-reporting creates significant legal liability."
    - name: "repeat_incident_count"
      expr: SUM(CASE WHEN is_repeat_incident = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat incidents — high repeat rate signals root-cause analysis failures and systemic safety programme gaps."
    - name: "repeat_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_incident = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeats — executive safety KPI; target is near zero; rising rate triggers programme overhaul."
    - name: "medical_treatment_required_count"
      expr: SUM(CASE WHEN medical_treatment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring medical treatment — measures injury severity and healthcare cost exposure."
    - name: "open_investigations_count"
      expr: SUM(CASE WHEN investigation_status != 'Completed' AND investigation_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of incidents with open investigations — measures root-cause analysis backlog and regulatory response timeliness."
    - name: "lost_time_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lost_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Lost-time incident rate as a percentage of all incidents — key EHS benchmark used in industry safety comparisons and insurance underwriting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety inspection KPIs — measures inspection scores, compliance rates, corrective-action burden, and checklist pass/fail ratios to drive proactive safety management."
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "safety_inspection_status"
      expr: safety_inspection_status
      comment: "Current status of the safety inspection (e.g. Completed, Pending, Failed) for inspection pipeline management."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Routine, Regulatory, Unannounced) for inspection programme analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the inspection for pass/fail rate tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the inspection outcome for risk-based follow-up prioritisation."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether the inspection mandated corrective action — measures inspection failure severity."
    - name: "ppe_compliance"
      expr: ppe_compliance
      comment: "Whether PPE compliance was confirmed during inspection — critical safety compliance indicator."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month of the inspection for trend analysis."
    - name: "area"
      expr: area
      comment: "Facility area inspected for location-level safety performance benchmarking."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total safety inspections conducted — baseline measure of inspection programme activity."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across inspections — primary safety inspection KPI; declining score triggers immediate corrective programme review."
    - name: "avg_average_score"
      expr: AVG(CAST(average_score AS DOUBLE))
      comment: "Average checklist item score across inspections — granular measure of inspection performance at item level."
    - name: "inspections_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections that identified corrective actions — measures safety deficiency volume across the facility portfolio."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action — key safety programme effectiveness KPI; rising rate signals deteriorating safety conditions."
    - name: "ppe_non_compliance_count"
      expr: SUM(CASE WHEN ppe_compliance = FALSE THEN 1 ELSE 0 END)
      comment: "Count of inspections where PPE non-compliance was found — PPE failures are leading indicators of injury risk and OSHA citation exposure."
    - name: "overdue_corrective_actions_count"
      expr: SUM(CASE WHEN corrective_action_deadline < CURRENT_DATE() AND corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections with past-due corrective action deadlines — measures safety remediation backlog and escalating regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory requirement KPIs — tracks compliance status, penalty exposure, and requirement lifecycle across the regulatory obligation portfolio to steer compliance investment."
  source: "`vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status against the requirement (e.g. Compliant, Non-Compliant, Partial) for gap analysis."
    - name: "regulatory_requirement_status"
      expr: regulatory_requirement_status
      comment: "Lifecycle status of the requirement (e.g. Active, Superseded, Pending) for portfolio currency management."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of regulatory requirement (e.g. Environmental, Safety, Financial) for cross-domain compliance analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category for programme-level grouping and resource allocation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the requirement for multi-jurisdictional compliance management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the requirement for risk-based compliance prioritisation."
    - name: "compliance_level"
      expr: compliance_level
      comment: "Required compliance level (e.g. Mandatory, Voluntary) for obligation classification."
    - name: "adoption_status"
      expr: adoption_status
      comment: "Status of requirement adoption within the organisation for implementation tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the requirement becomes effective for forward-looking compliance planning."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total regulatory requirements in scope — baseline measure of compliance obligation portfolio size."
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of requirements where the organisation is currently non-compliant — primary regulatory risk KPI requiring immediate executive attention."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requirements in compliant status — headline compliance health KPI for board and regulatory reporting."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all requirements — financial risk KPI for compliance budget justification and risk provisioning."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per requirement — benchmarks penalty severity for risk-weighted compliance prioritisation."
    - name: "requirements_expiring_within_90_days"
      expr: SUM(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Count of requirements expiring within 90 days — forward-looking KPI for renewal and re-certification planning."
    - name: "overdue_compliance_deadline_count"
      expr: SUM(CASE WHEN compliance_deadline < CURRENT_DATE() AND compliance_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of requirements past their compliance deadline and still non-compliant — highest-urgency regulatory risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit management KPIs — tracks permit validity, fee exposure, renewal status, and inspection outcomes to prevent operational shutdowns from permit lapses."
  source: "`vibe_manufacturing_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g. Active, Expired, Pending Renewal) for portfolio health monitoring."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g. Environmental, Operating, Construction) for permit-class compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status associated with the permit for regulatory standing assessment."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the permit renewal process for proactive renewal management."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit for agency-level relationship management."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the permit expires for forward-looking renewal planning."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Whether an expiration notice has been sent — measures proactive renewal process execution."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total permits in the portfolio — baseline measure of regulatory permit obligation scope."
    - name: "expired_permits_count"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of expired permits — expired permits create immediate operational shutdown risk and regulatory violation exposure."
    - name: "permits_expiring_within_90_days"
      expr: SUM(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Permits expiring within 90 days — forward-looking KPI that triggers renewal action before operational disruption."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees — compliance cost KPI for budget planning and cost-of-compliance reporting."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee — benchmarks permit cost for budget forecasting and vendor negotiation."
    - name: "total_limit_value"
      expr: SUM(CAST(limit_value AS DOUBLE))
      comment: "Sum of permit limit values — aggregate measure of permitted operational capacity across the portfolio."
    - name: "permits_without_expiry_notice"
      expr: SUM(CASE WHEN expiration_notice_sent = FALSE AND expiry_date < DATE_ADD(CURRENT_DATE(), 90) THEN 1 ELSE 0 END)
      comment: "Count of soon-to-expire permits where no expiry notice has been sent — measures renewal process gaps that risk permit lapse."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management KPIs — tracks waste volumes, transport emissions, hazardous waste exposure, and disposal compliance to steer environmental and regulatory performance."
  source: "`vibe_manufacturing_v1`.`compliance`.`waste_record`"
  dimensions:
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Current status of the waste record (e.g. Pending Disposal, Disposed, Reported) for waste management pipeline tracking."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (e.g. Solid, Liquid, Hazardous) for waste stream analysis and regulatory classification."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for programme-level waste reduction targeting."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the waste is classified as hazardous — hazardous waste carries significantly higher regulatory and disposal cost obligations."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (e.g. Landfill, Incineration, Recycling) for circular economy and sustainability analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the waste disposal record for regulatory adherence tracking."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the waste for regulatory reporting and emergency response planning."
    - name: "generation_month"
      expr: DATE_TRUNC('MONTH', generation_date)
      comment: "Month waste was generated for trend analysis and seasonal waste pattern identification."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for waste disposal for logistics cost and emissions analysis."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total waste quantity generated — primary ESG KPI for waste reduction programme tracking and circular economy reporting."
    - name: "avg_waste_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average waste quantity per record — benchmarks waste generation intensity for process improvement targeting."
    - name: "total_transport_emission_kg_co2"
      expr: SUM(CAST(transport_emission_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from waste transport — Scope 3 emissions KPI for carbon accounting and logistics decarbonisation."
    - name: "total_transport_distance_km"
      expr: SUM(CAST(transport_distance_km AS DOUBLE))
      comment: "Total distance waste was transported — logistics efficiency KPI for disposal network optimisation."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of hazardous waste — regulatory KPI for hazardous waste reporting thresholds and disposal cost management."
    - name: "hazardous_waste_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazardous = TRUE THEN CAST(quantity AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total waste that is hazardous — measures hazardous waste intensity; rising percentage signals process or material substitution opportunities."
    - name: "non_compliant_disposal_count"
      expr: SUM(CASE WHEN compliance_status != 'Compliant' AND compliance_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of waste records with non-compliant disposal status — each non-compliant disposal is a potential EPA violation requiring immediate remediation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_cybersecurity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity compliance KPIs — tracks risk scores, remediation status, and critical asset exposure to steer OT/IT security investment and IEC 62443 compliance."
  source: "`vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the cybersecurity assessment (e.g. In Progress, Completed, Remediation Required) for programme pipeline management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the assessment outcome for risk-based security investment prioritisation."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions identified in the assessment for closure tracking."
    - name: "is_critical_asset"
      expr: is_critical_asset
      comment: "Whether the assessed asset is classified as critical — critical assets require accelerated remediation timelines."
    - name: "is_external_assessment"
      expr: is_external_assessment
      comment: "Whether the assessment was conducted by an external party — external assessments provide independent validation of security posture."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Security framework assessed against (e.g. IEC 62443, NIST CSF) for framework-level compliance tracking."
    - name: "assessed_zone"
      expr: assessed_zone
      comment: "OT/IT security zone assessed for zone-level risk profiling."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of the assessment for trend analysis of security posture over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total cybersecurity assessments conducted — baseline measure of security assessment programme coverage."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments — primary cybersecurity KPI; rising score signals deteriorating security posture requiring CISO escalation."
    - name: "max_overall_risk_score"
      expr: MAX(CAST(overall_risk_score AS DOUBLE))
      comment: "Highest risk score observed — identifies the most critical security vulnerability requiring immediate remediation."
    - name: "critical_asset_assessment_count"
      expr: SUM(CASE WHEN is_critical_asset = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments on critical assets — measures security coverage of highest-priority assets."
    - name: "overdue_remediation_count"
      expr: SUM(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_status != 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of assessments with overdue remediation actions — measures unresolved cybersecurity vulnerability backlog and escalating breach risk."
    - name: "assessments_with_evidence"
      expr: SUM(CASE WHEN evidence_attached = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments with supporting evidence attached — measures assessment documentation completeness for audit readiness."
    - name: "evidence_attachment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN evidence_attached = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with evidence attached — measures audit-readiness of the cybersecurity assessment programme."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation KPIs — tracks compliance status, overdue obligations, and risk exposure across the full obligation register to steer compliance programme prioritisation."
  source: "`vibe_manufacturing_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g. Active, Overdue, Closed) for obligation pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against the obligation for gap analysis and regulatory standing."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (e.g. Reporting, Permit, Training) for obligation-class analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category for programme-level grouping and resource allocation."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity of risk if the obligation is not met for risk-based prioritisation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation for multi-jurisdictional compliance management."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the obligation is legally mandatory — mandatory obligations require zero-lapse management."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due for forward-looking compliance planning."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total regulatory obligations in the register — baseline measure of compliance obligation portfolio scope."
    - name: "non_compliant_obligations"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of obligations currently in non-compliant status — primary regulatory risk KPI requiring immediate executive attention."
    - name: "obligation_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliant status — headline compliance health KPI for board and regulatory reporting."
    - name: "overdue_obligations_count"
      expr: SUM(CASE WHEN due_date < CURRENT_DATE() AND obligation_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of obligations past their due date and not yet closed — measures compliance backlog and escalating regulatory exposure."
    - name: "avg_risk_rating"
      expr: AVG(CAST(risk_rating AS DOUBLE))
      comment: "Average risk rating across obligations — measures aggregate compliance risk exposure for risk provisioning and programme investment decisions."
    - name: "mandatory_non_compliant_count"
      expr: SUM(CASE WHEN is_mandatory = TRUE AND compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of mandatory obligations that are non-compliant — highest-priority compliance risk KPI; any non-zero value requires immediate executive escalation."
$$;