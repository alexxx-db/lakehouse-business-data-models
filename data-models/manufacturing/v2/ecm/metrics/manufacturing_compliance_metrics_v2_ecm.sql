-- Metric views for domain: compliance | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit event outcomes, risk exposure, and corrective action rates across facilities and regulatory domains. Enables compliance leadership to monitor audit health and prioritize remediation."
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_event_status"
      expr: audit_event_status
      comment: "Current lifecycle status of the audit event (e.g., Open, Closed, In Progress) for pipeline analysis."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment performed (e.g., Internal, External, Regulatory) to segment audit coverage."
    - name: "department"
      expr: department
      comment: "Organizational department under audit, enabling departmental compliance benchmarking."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity classification of the audit event to prioritize high-risk findings."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the audit event (e.g., Pass, Fail, Conditional) for pass-rate analysis."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory body associated with the audit, enabling agency-level compliance tracking."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit date for trend analysis over time."
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit events. Baseline volume metric for audit program coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across audit events. Indicates overall risk exposure level; rising scores trigger escalation."
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Aggregate risk score across all audit events. Used to rank departments or agencies by cumulative risk burden."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audit events requiring corrective action. High values signal systemic compliance gaps demanding leadership intervention."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audit events that required corrective action. A key compliance health KPI; targets typically below 20%."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures audit plan effectiveness, compliance scoring, and scheduling adherence. Enables compliance officers to evaluate audit program quality and regulatory readiness."
  source: "`vibe_manufacturing_v1`.`compliance`.`audit_plan`"
  dimensions:
    - name: "audit_plan_status"
      expr: audit_plan_status
      comment: "Current status of the audit plan (e.g., Draft, Active, Completed) for pipeline management."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Internal, Supplier, Regulatory) to segment plan coverage."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the audit plan, enabling prioritization of high-risk audits."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency of audit execution (e.g., Annual, Quarterly) for scheduling analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled audit start for workload planning and trend analysis."
  measures:
    - name: "total_audit_plans"
      expr: COUNT(1)
      comment: "Total number of audit plans. Baseline measure for audit program scope."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audit plans. Core KPI for regulatory readiness; declining scores trigger program review."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit execution quality score. Measures auditor effectiveness and process rigor."
    - name: "total_audit_plans_active"
      expr: SUM(CASE WHEN audit_plan_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active audit plans. Indicates live compliance monitoring coverage."
    - name: "high_risk_audit_plan_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Number of audit plans classified as high risk. Drives resource allocation and executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks audit finding severity, repeat rates, and resolution timeliness. Enables quality and compliance leadership to identify systemic issues and measure corrective action effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "compliance_audit_finding_status"
      expr: compliance_audit_finding_status
      comment: "Current status of the finding (e.g., Open, Closed, In Review) for backlog management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding (e.g., Critical, Major, Minor) for risk prioritization."
    - name: "finding_type"
      expr: finding_type
      comment: "Category of finding (e.g., Observation, Nonconformance, Opportunity) for classification analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding for executive risk reporting."
    - name: "affected_process"
      expr: affected_process
      comment: "Business process impacted by the finding, enabling process-level compliance analysis."
    - name: "discovery_date_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month of finding discovery for trend and aging analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume metric for compliance gap tracking."
    - name: "open_findings_count"
      expr: SUM(CASE WHEN compliance_audit_finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of unresolved findings. High open counts signal compliance backlog requiring leadership escalation."
    - name: "repeat_finding_count"
      expr: SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END)
      comment: "Number of repeat findings. Repeat findings indicate ineffective corrective actions and systemic process failures."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_finding = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats. A critical quality KPI; high rates indicate root cause analysis failures."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings requiring corrective action. Drives CAPA workload planning and resource allocation."
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity findings. Directly triggers executive escalation and regulatory risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures CAPA effectiveness, closure rates, and penalty exposure for compliance corrective actions. Enables compliance and quality leadership to track remediation performance and regulatory risk."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_capa_record`"
  dimensions:
    - name: "compliance_capa_record_status"
      expr: compliance_capa_record_status
      comment: "Current lifecycle status of the CAPA record (e.g., Open, Closed, Verified) for pipeline tracking."
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (e.g., Corrective, Preventive) to distinguish reactive vs. proactive actions."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA for resource allocation and escalation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA for executive risk reporting."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department accountable for CAPA execution, enabling departmental performance benchmarking."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or quality framework driving the CAPA (e.g., ISO 9001, OSHA) for framework-level analysis."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month of target CAPA completion for workload forecasting."
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total CAPA records. Baseline volume metric for compliance remediation workload."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties associated with compliance CAPAs. Direct financial risk KPI for CFO and compliance leadership."
    - name: "avg_effectiveness_score"
      expr: AVG(CAST(effectiveness_score AS DOUBLE))
      comment: "Average CAPA effectiveness score. Measures quality of corrective actions; low scores indicate systemic remediation failures."
    - name: "effectiveness_verified_count"
      expr: SUM(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs with verified effectiveness. Indicates mature, closed-loop corrective action processes."
    - name: "effectiveness_verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs with verified effectiveness. A leading indicator of compliance program maturity."
    - name: "external_citation_count"
      expr: SUM(CASE WHEN is_external_citation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs driven by external regulatory citations. High counts signal regulatory enforcement risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks product certification status, costs, and expiry risk across regulatory frameworks. Enables product compliance and regulatory affairs teams to manage certification portfolios and avoid lapses."
  source: "`vibe_manufacturing_v1`.`compliance`.`compliance_product_certification`"
  dimensions:
    - name: "compliance_product_certification_status"
      expr: compliance_product_certification_status
      comment: "Current status of the product certification (e.g., Active, Expired, Pending) for portfolio management."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., CE, UL, RoHS) for regulatory framework analysis."
    - name: "compliance_region"
      expr: compliance_region
      comment: "Geographic region of compliance applicability for market access analysis."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level of the certification for prioritizing renewal and audit activities."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization issuing the certification for vendor and body performance analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether the certification is legally mandatory, enabling prioritization of critical renewals."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certification expiry for renewal pipeline planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total product certifications in portfolio. Baseline measure for regulatory coverage scope."
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total spend on product certifications. Key cost management KPI for regulatory affairs budget planning."
    - name: "avg_certification_cost"
      expr: AVG(CAST(certification_cost AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification spend efficiency across bodies and types."
    - name: "renewal_required_count"
      expr: SUM(CASE WHEN renewal_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certifications requiring renewal. Drives renewal workload planning and budget forecasting."
    - name: "export_controlled_count"
      expr: SUM(CASE WHEN is_export_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of export-controlled product certifications. Critical for trade compliance risk management."
    - name: "active_certification_count"
      expr: SUM(CASE WHEN compliance_product_certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active certifications. Measures live regulatory coverage for the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_cybersecurity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures cybersecurity risk exposure, assessment coverage, and remediation status across facilities and control systems. Enables CISO and compliance leadership to manage OT/IT security posture."
  source: "`vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment`"
  dimensions:
    - name: "cybersecurity_assessment_status"
      expr: cybersecurity_assessment_status
      comment: "Current status of the cybersecurity assessment (e.g., In Progress, Completed, Remediation) for pipeline tracking."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of cybersecurity assessment (e.g., Vulnerability Scan, Penetration Test, Gap Analysis) for coverage analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the assessment for executive risk reporting."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Cybersecurity framework applied (e.g., IEC 62443, NIST CSF) for framework-level compliance tracking."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation activities following the assessment for closure rate analysis."
    - name: "is_critical_asset"
      expr: is_critical_asset
      comment: "Flag for critical asset assessments, enabling prioritization of high-consequence systems."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend and coverage frequency analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total cybersecurity assessments conducted. Baseline measure for security program coverage."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments. Primary CISO KPI; rising scores trigger security investment decisions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average granular risk score per assessment. Complements overall risk score for detailed risk profiling."
    - name: "critical_asset_assessment_count"
      expr: SUM(CASE WHEN is_critical_asset = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments on critical assets. Ensures critical infrastructure receives adequate security scrutiny."
    - name: "external_assessment_count"
      expr: SUM(CASE WHEN is_external_assessment = TRUE THEN 1 ELSE 0 END)
      comment: "Count of externally conducted assessments. Measures independent validation coverage of security posture."
    - name: "remediation_pending_count"
      expr: SUM(CASE WHEN remediation_status NOT IN ('Completed', 'Closed') THEN 1 ELSE 0 END)
      comment: "Count of assessments with open remediation items. Directly measures unresolved cybersecurity risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_cybersecurity_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks cybersecurity control implementation maturity, cost, and compliance status. Enables CISO and compliance teams to measure control effectiveness and investment adequacy."
  source: "`vibe_manufacturing_v1`.`compliance`.`cybersecurity_control`"
  dimensions:
    - name: "cybersecurity_control_status"
      expr: cybersecurity_control_status
      comment: "Current status of the control (e.g., Implemented, Planned, Retired) for portfolio management."
    - name: "control_category"
      expr: control_category
      comment: "Category of cybersecurity control (e.g., Access Control, Monitoring) for coverage gap analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation progress of the control for deployment tracking."
    - name: "maturity_level"
      expr: maturity_level
      comment: "Maturity level of the control (e.g., Initial, Managed, Optimized) for program maturity benchmarking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the control for prioritization of implementation efforts."
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g., Preventive, Detective, Corrective) for defense-in-depth analysis."
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total cybersecurity controls in the program. Baseline measure for control portfolio scope."
    - name: "total_control_cost"
      expr: SUM(CAST(control_cost AS DOUBLE))
      comment: "Total investment in cybersecurity controls. Key budget KPI for CISO and CFO security spend decisions."
    - name: "avg_control_cost"
      expr: AVG(CAST(control_cost AS DOUBLE))
      comment: "Average cost per cybersecurity control. Benchmarks control investment efficiency."
    - name: "implemented_control_count"
      expr: SUM(CASE WHEN implementation_status = 'Implemented' THEN 1 ELSE 0 END)
      comment: "Count of fully implemented controls. Measures security program deployment completeness."
    - name: "implementation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_status = 'Implemented' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls fully implemented. Core CISO KPI for security program maturity; targets typically above 85%."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks environmental emissions quantities, exceedances, and greenhouse gas equivalents by facility and pollutant. Enables sustainability and EHS leadership to manage regulatory limits and ESG reporting."
  source: "`vibe_manufacturing_v1`.`compliance`.`emissions_record`"
  dimensions:
    - name: "emissions_record_status"
      expr: emissions_record_status
      comment: "Current status of the emissions record (e.g., Submitted, Pending, Approved) for reporting pipeline management."
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant (e.g., CO2, NOx, SOx) for substance-level emissions analysis."
    - name: "source_category"
      expr: source_category
      comment: "Category of emission source (e.g., Combustion, Process, Fugitive) for source-level analysis."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Year of emissions reporting for annual trend and regulatory comparison."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Quarter of emissions reporting for seasonal and quarterly regulatory analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure emissions (e.g., CEMS, Calculation, Estimation) for data quality segmentation."
    - name: "measurement_date_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of measurement for time-series emissions trend analysis."
  measures:
    - name: "total_emission_quantity"
      expr: SUM(CAST(emission_quantity AS DOUBLE))
      comment: "Total emissions quantity across all records. Primary ESG and regulatory compliance KPI for environmental reporting."
    - name: "total_greenhouse_gas_equivalent"
      expr: SUM(CAST(greenhouse_gas_equivalent AS DOUBLE))
      comment: "Total greenhouse gas equivalent (CO2e). Core ESG metric for carbon footprint reporting and net-zero tracking."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity per emissions record. Measures emissions efficiency; declining values indicate decarbonization progress."
    - name: "exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emissions records exceeding permitted limits. Critical regulatory risk KPI; each exceedance may trigger penalties."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exceedance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emissions records with permit exceedances. Measures regulatory compliance rate for environmental permits."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for emissions measurements. Low scores indicate unreliable reporting data requiring investment in monitoring systems."
    - name: "total_permit_limit_quantity"
      expr: SUM(CAST(permit_limit_quantity AS DOUBLE))
      comment: "Total permitted emission limits across all records. Used as denominator for utilization rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_environmental_aspect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures environmental aspect significance, compliance status, and target vs. actual performance. Enables EHS leadership to prioritize environmental controls and track ISO 14001 compliance."
  source: "`vibe_manufacturing_v1`.`compliance`.`environmental_aspect`"
  dimensions:
    - name: "environmental_aspect_status"
      expr: environmental_aspect_status
      comment: "Current status of the environmental aspect (e.g., Active, Under Review, Closed) for portfolio management."
    - name: "aspect_category"
      expr: aspect_category
      comment: "Category of environmental aspect (e.g., Air, Water, Waste) for media-level analysis."
    - name: "significance_rating"
      expr: significance_rating
      comment: "Significance rating of the aspect (e.g., Significant, Non-Significant) for prioritization."
    - name: "impact_type"
      expr: impact_type
      comment: "Type of environmental impact (e.g., Negative, Positive) for impact classification."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical environmental aspects requiring immediate management attention."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of environmental monitoring for compliance scheduling analysis."
  measures:
    - name: "total_environmental_aspects"
      expr: COUNT(1)
      comment: "Total environmental aspects tracked. Baseline measure for environmental management program scope."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value across environmental aspects. Tracks real-world environmental performance."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across environmental aspects. Provides performance benchmark for gap analysis."
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target environmental values. Negative variance indicates underperformance against environmental targets."
    - name: "critical_aspect_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical environmental aspects. Drives prioritization of environmental control investments."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of environmental aspects requiring corrective action. Measures environmental compliance gap backlog."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks facility-level environmental performance, compliance status, and operational risk. Enables EHS and operations leadership to benchmark facilities and prioritize compliance investments."
  source: "`vibe_manufacturing_v1`.`compliance`.`facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (e.g., Active, Decommissioned, Under Construction) for portfolio management."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Manufacturing Plant, Warehouse, Office) for facility-type benchmarking."
    - name: "country"
      expr: country
      comment: "Country of facility location for geographic compliance and regulatory jurisdiction analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the facility for prioritizing compliance audits and inspections."
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status of the facility for compliance program tracking."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities. Baseline measure for compliance program geographic scope."
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions across all facilities in tons. Primary ESG KPI for carbon footprint and net-zero target tracking."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption across facilities in MWh. Key sustainability KPI for energy efficiency programs."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated across facilities. Drives waste reduction programs and circular economy initiatives."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water consumption across facilities in cubic meters. Key ESG metric for water stewardship reporting."
    - name: "avg_facility_size_sqft"
      expr: AVG(CAST(size_sqft AS DOUBLE))
      comment: "Average facility size in square feet. Used for normalizing environmental intensity metrics (emissions per sqft)."
    - name: "hazardous_material_facility_count"
      expr: SUM(CASE WHEN hazardous_material_storage = TRUE THEN 1 ELSE 0 END)
      comment: "Count of facilities storing hazardous materials. Drives regulatory reporting obligations and emergency response planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks workplace safety incident rates, severity, lost time, and regulatory reportability. Enables EHS and operations leadership to manage OSHA compliance and drive zero-harm programs."
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_incident`"
  dimensions:
    - name: "safety_incident_status"
      expr: safety_incident_status
      comment: "Current status of the safety incident (e.g., Open, Under Investigation, Closed) for case management."
    - name: "incident_type"
      expr: incident_type
      comment: "Type of safety incident (e.g., Near Miss, First Aid, Lost Time) for severity classification."
    - name: "severity"
      expr: severity
      comment: "Severity level of the incident for risk prioritization and regulatory classification."
    - name: "osha_300_log_classification"
      expr: osha_300_log_classification
      comment: "OSHA 300 log classification for regulatory reporting compliance."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility code where the incident occurred for location-level safety benchmarking."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred for shift-level safety analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_timestamp)
      comment: "Month of incident occurrence for trend analysis and TRIR calculation periods."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total safety incidents. Baseline measure for safety program performance and TRIR calculation."
    - name: "lost_time_incident_count"
      expr: SUM(CASE WHEN lost_time_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lost-time incidents. Core OSHA KPI; directly impacts LTIR (Lost Time Incident Rate) regulatory metric."
    - name: "total_lost_time_hours"
      expr: SUM(CAST(lost_time_hours AS DOUBLE))
      comment: "Total hours lost due to workplace injuries. Measures productivity impact and drives return-to-work program investment."
    - name: "avg_lost_time_hours_per_incident"
      expr: AVG(CAST(lost_time_hours AS DOUBLE))
      comment: "Average lost time hours per incident. Indicates average severity of lost-time events for benchmarking."
    - name: "injury_incident_count"
      expr: SUM(CASE WHEN injury_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents resulting in injury. Key safety KPI for injury prevention program effectiveness."
    - name: "osha_reportable_count"
      expr: SUM(CASE WHEN reportable_to_osha_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of OSHA-reportable incidents. Directly measures regulatory reporting obligations and compliance risk."
    - name: "repeat_incident_count"
      expr: SUM(CASE WHEN is_repeat_incident = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat incidents. Indicates ineffective corrective actions and systemic safety culture issues."
    - name: "medical_treatment_required_count"
      expr: SUM(CASE WHEN medical_treatment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring medical treatment. Measures recordable incident rate for OSHA compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures safety inspection pass rates, scores, and corrective action requirements. Enables EHS leadership to evaluate workplace safety compliance and inspection program effectiveness."
  source: "`vibe_manufacturing_v1`.`compliance`.`safety_inspection`"
  dimensions:
    - name: "safety_inspection_status"
      expr: safety_inspection_status
      comment: "Current status of the safety inspection (e.g., Completed, Pending, Failed) for pipeline management."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of safety inspection (e.g., Routine, Regulatory, Pre-Startup) for coverage analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the inspection for prioritization of follow-up actions."
    - name: "result_rating"
      expr: result_rating
      comment: "Overall result rating of the inspection for pass/fail trend analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend and frequency analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total safety inspections conducted. Baseline measure for inspection program coverage."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety score across inspections. Primary EHS KPI for workplace safety performance; declining scores trigger program review."
    - name: "avg_average_score"
      expr: AVG(CAST(average_score AS DOUBLE))
      comment: "Average composite inspection score. Complements safety score for holistic inspection quality assessment."
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections that passed. Measures overall safety compliance rate."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety inspections that passed. Core EHS KPI; targets typically above 90% for compliant operations."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring corrective action. Drives safety remediation workload and resource planning."
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(inspection_duration_minutes AS DOUBLE))
      comment: "Average inspection duration in minutes. Measures inspection thoroughness and resource efficiency."
    - name: "avg_total_items_checked"
      expr: AVG(CAST(total_items_checked AS DOUBLE))
      comment: "Average number of checklist items verified per inspection. Indicates inspection comprehensiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks waste generation volumes, hazardous waste quantities, and disposal compliance. Enables EHS and sustainability leadership to manage waste reduction programs and regulatory reporting."
  source: "`vibe_manufacturing_v1`.`compliance`.`waste_record`"
  dimensions:
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Current status of the waste record (e.g., Pending Disposal, Disposed, Reported) for compliance tracking."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (e.g., Solid, Liquid, Hazardous) for waste stream analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste for regulatory classification and reporting."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (e.g., Landfill, Incineration, Recycling) for circular economy analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag for hazardous waste records, enabling segregated hazardous waste compliance tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of waste transport for logistics and emissions analysis."
    - name: "generation_date_month"
      expr: DATE_TRUNC('MONTH', generation_date)
      comment: "Month of waste generation for trend analysis and regulatory period reporting."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity generated. Primary ESG KPI for waste reduction program tracking and regulatory reporting."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of waste across all records. Supports regulatory manifest and disposal volume reporting."
    - name: "total_transport_emission_kg_co2"
      expr: SUM(CAST(transport_emission_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from waste transport in kg. Measures Scope 3 emissions from waste logistics for ESG reporting."
    - name: "avg_transport_distance_km"
      expr: AVG(CAST(transport_distance_km AS DOUBLE))
      comment: "Average waste transport distance in km. Drives optimization of disposal logistics to reduce cost and emissions."
    - name: "hazardous_waste_record_count"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous waste records. Measures regulatory reporting obligation volume for hazardous waste compliance."
    - name: "hazardous_waste_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hazardous = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste records classified as hazardous. Tracks hazardous waste intensity for regulatory risk management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_regulatory_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory requirement compliance status, penalty exposure, and review currency. Enables compliance leadership to manage regulatory obligation portfolios and prioritize high-risk requirements."
  source: "`vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`"
  dimensions:
    - name: "regulatory_requirement_status"
      expr: regulatory_requirement_status
      comment: "Current status of the regulatory requirement (e.g., Active, Expired, Pending) for obligation management."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of regulatory requirement (e.g., Environmental, Safety, Quality) for domain-level compliance analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the requirement (e.g., Federal, State, EU) for geographic compliance management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category for grouping requirements by regulatory domain."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of non-compliance for prioritizing regulatory attention."
    - name: "compliance_level"
      expr: compliance_level
      comment: "Level of compliance achieved (e.g., Full, Partial, Non-Compliant) for compliance gap analysis."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year of regulatory requirement effective date for compliance timeline planning."
  measures:
    - name: "total_requirements"
      expr: COUNT(1)
      comment: "Total regulatory requirements tracked. Baseline measure for compliance obligation portfolio scope."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all regulatory requirements. Critical financial risk KPI for CFO and compliance leadership."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per regulatory requirement. Benchmarks financial risk per obligation for prioritization."
    - name: "non_compliant_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of requirements currently non-compliant. Directly measures regulatory violation exposure requiring immediate action."
    - name: "high_risk_requirement_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk regulatory requirements. Drives prioritization of compliance investment and legal review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures compliance obligation status, risk ratings, and overdue rates. Enables compliance officers to manage regulatory obligation portfolios and ensure timely fulfillment."
  source: "`vibe_manufacturing_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., Open, Fulfilled, Overdue) for pipeline management."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., Reporting, Permit, Training) for obligation category analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category for grouping obligations by regulatory area."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation for geographic compliance management."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity of risk from non-fulfillment for prioritization of compliance activities."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag for mandatory obligations, enabling prioritization of legally required compliance activities."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of obligation due date for workload planning and deadline management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total compliance obligations tracked. Baseline measure for regulatory obligation portfolio scope."
    - name: "avg_risk_rating"
      expr: AVG(CAST(risk_rating AS DOUBLE))
      comment: "Average risk rating across obligations. Tracks overall compliance risk exposure; rising values trigger portfolio review."
    - name: "total_risk_rating"
      expr: SUM(CAST(risk_rating AS DOUBLE))
      comment: "Aggregate risk rating across all obligations. Used to rank departments or jurisdictions by cumulative compliance risk."
    - name: "mandatory_obligation_count"
      expr: SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mandatory compliance obligations. Measures legally required compliance workload."
    - name: "overdue_obligation_count"
      expr: SUM(CASE WHEN obligation_status = 'Overdue' THEN 1 ELSE 0 END)
      comment: "Count of overdue obligations. Critical compliance risk KPI; overdue mandatory obligations may trigger regulatory penalties."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_periodic_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks periodic compliance evaluation conformance ratings, risk scores, and assessment frequency. Enables compliance leadership to measure ongoing regulatory conformance and identify deteriorating areas."
  source: "`vibe_manufacturing_v1`.`compliance`.`periodic_evaluation`"
  dimensions:
    - name: "periodic_evaluation_status"
      expr: periodic_evaluation_status
      comment: "Current status of the periodic evaluation (e.g., Completed, Overdue, Scheduled) for program management."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of periodic evaluation (e.g., Legal Compliance, Environmental, Safety) for domain-level analysis."
    - name: "conformance_status"
      expr: conformance_status
      comment: "Conformance outcome of the evaluation (e.g., Conforming, Non-Conforming, Partially Conforming) for compliance rate analysis."
    - name: "result_rating"
      expr: result_rating
      comment: "Overall result rating of the evaluation for performance benchmarking."
    - name: "risk_severity"
      expr: risk_severity
      comment: "Risk severity level of identified gaps for prioritization of remediation."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend analysis and evaluation frequency monitoring."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total periodic evaluations conducted. Baseline measure for compliance evaluation program coverage."
    - name: "avg_conformance_rating"
      expr: AVG(CAST(conformance_rating AS DOUBLE))
      comment: "Average conformance rating across evaluations. Primary KPI for ongoing regulatory compliance health; declining values trigger corrective programs."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from periodic evaluations. Measures residual compliance risk after controls; rising scores trigger leadership escalation."
    - name: "non_conforming_count"
      expr: SUM(CASE WHEN conformance_status = 'Non-Conforming' THEN 1 ELSE 0 END)
      comment: "Count of non-conforming evaluations. Directly measures compliance failures requiring corrective action."
    - name: "conformance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN conformance_status = 'Conforming' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations with conforming outcomes. Core compliance program KPI; targets typically above 90%."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks permit status, expiry risk, fee exposure, and compliance outcomes. Enables EHS and legal teams to manage permit portfolios and avoid operational shutdowns from permit lapses."
  source: "`vibe_manufacturing_v1`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g., Active, Expired, Pending Renewal) for portfolio management."
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., Air Emission, Water Discharge, Operating) for regulatory domain analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the permit for regulatory risk assessment."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the permit for proactive renewal pipeline management."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the most recent permit inspection for compliance performance analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of permit expiry for renewal deadline planning and operational risk management."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total permits in portfolio. Baseline measure for regulatory permit management scope."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees across all permits. Key cost management KPI for regulatory compliance budget planning."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee. Benchmarks permit cost efficiency across types and jurisdictions."
    - name: "total_limit_value"
      expr: SUM(CAST(limit_value AS DOUBLE))
      comment: "Total permitted limit values across all permits. Used for aggregate regulatory limit exposure analysis."
    - name: "active_permit_count"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active permits. Measures live regulatory authorization coverage for operations."
    - name: "expired_permit_count"
      expr: SUM(CASE WHEN permit_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Count of expired permits. Critical operational risk KPI; expired permits may halt production or trigger regulatory action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory filing submission status, timeliness, and compliance risk. Enables compliance and legal teams to manage filing obligations and avoid penalties from late or missing submissions."
  source: "`vibe_manufacturing_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Current status of the regulatory filing (e.g., Submitted, Pending, Overdue) for submission pipeline management."
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., Annual Report, Incident Report, Permit Application) for obligation category analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status of the filing for tracking completion against deadlines."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Regulatory compliance area of the filing (e.g., Environmental, Safety, Financial) for domain-level analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the filing for prioritizing high-consequence submissions."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag for mandatory filings, enabling prioritization of legally required submissions."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of filing date for submission volume trend analysis."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings. Baseline measure for regulatory reporting obligation volume."
    - name: "submitted_filing_count"
      expr: SUM(CASE WHEN submission_status = 'Submitted' THEN 1 ELSE 0 END)
      comment: "Count of successfully submitted filings. Measures regulatory reporting compliance rate."
    - name: "submission_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'Submitted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings successfully submitted. Core regulatory compliance KPI; below-target rates trigger penalty risk."
    - name: "mandatory_filing_count"
      expr: SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mandatory regulatory filings. Measures legally required reporting workload and compliance exposure."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of regulatory filings in bytes. Measures documentation volume for storage and archival planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`compliance_hazardous_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks hazardous substance inventory, risk scores, and regulatory reporting thresholds. Enables EHS and supply chain teams to manage chemical compliance and emergency response obligations."
  source: "`vibe_manufacturing_v1`.`compliance`.`hazardous_substance`"
  dimensions:
    - name: "hazardous_substance_status"
      expr: hazardous_substance_status
      comment: "Current status of the hazardous substance record (e.g., Active, Disposed, Quarantined) for inventory management."
    - name: "hazard_class"
      expr: hazard_class
      comment: "Hazard classification of the substance (e.g., Flammable, Toxic, Corrosive) for regulatory category analysis."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Detailed hazard classification for GHS and regulatory reporting compliance."
    - name: "chemical_family"
      expr: chemical_family
      comment: "Chemical family of the substance for grouped inventory and risk analysis."
    - name: "is_controlled_substance"
      expr: is_controlled_substance
      comment: "Flag for controlled substances requiring enhanced regulatory oversight."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Flag for substances with regulatory reporting obligations (e.g., SARA Title III) for compliance tracking."
  measures:
    - name: "total_substances"
      expr: COUNT(1)
      comment: "Total hazardous substances tracked. Baseline measure for chemical inventory compliance scope."
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of hazardous substances on hand. Drives regulatory threshold reporting (e.g., SARA 312) and emergency planning."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across hazardous substances. Measures overall chemical risk profile of the facility."
    - name: "total_threshold_quantity"
      expr: SUM(CAST(threshold_quantity AS DOUBLE))
      comment: "Total regulatory threshold quantities across substances. Used to assess aggregate regulatory reporting obligations."
    - name: "reporting_threshold_exceeded_count"
      expr: SUM(CASE WHEN reporting_threshold_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of substances exceeding regulatory reporting thresholds. Directly triggers mandatory regulatory notifications and emergency planning updates."
    - name: "avg_molecular_weight"
      expr: AVG(CAST(molecular_weight AS DOUBLE))
      comment: "Average molecular weight of tracked substances. Supports chemical inventory characterization for safety data sheet management."
$$;