-- Metric views for domain: safety | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_ohs_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Occupational Health and Safety incident analytics — tracks incident frequency, severity, cost, and investigation outcomes to drive HSE performance management and regulatory compliance reporting."
  source: "`vibe_shipping_ports_v1`.`safety`.`ohs_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the OHS incident (e.g., near-miss, first-aid, lost-time injury, fatality) for severity-band analysis."
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity rating of the incident used to prioritise investigation resources and regulatory notification."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident record (open, under investigation, closed) for workload tracking."
    - name: "location_type"
      expr: location_type
      comment: "Physical area type where the incident occurred (berth, yard, gate, warehouse) for hotspot identification."
    - name: "shift"
      expr: shift
      comment: "Work shift during which the incident occurred, enabling shift-pattern safety analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_datetime)
      comment: "Calendar month of the incident for trend analysis and monthly HSE reporting."
    - name: "incident_year"
      expr: YEAR(incident_datetime)
      comment: "Calendar year of the incident for annual safety performance benchmarking."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether the incident triggers a mandatory regulatory notification, used for compliance tracking."
    - name: "medical_treatment_required"
      expr: medical_treatment_required
      comment: "Flag indicating whether medical treatment was required, distinguishing recordable from non-recordable incidents."
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "RCA methodology applied (e.g., 5-Why, Bow-Tie, ICAM) for investigation quality benchmarking."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of OHS incidents recorded. Baseline KPI for absolute incident frequency tracking."
    - name: "total_incident_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated financial cost of all OHS incidents. Drives cost-of-poor-safety analysis and insurance reserve planning."
    - name: "avg_incident_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per OHS incident. Benchmarks incident cost severity and informs risk-based investment in prevention."
    - name: "incidents_requiring_regulatory_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of incidents that triggered mandatory regulatory notification. Measures regulatory exposure and compliance burden."
    - name: "regulatory_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification. High rates signal systemic severity issues requiring executive attention."
    - name: "lost_time_incidents"
      expr: COUNT(CASE WHEN incident_type = 'Lost Time Injury' THEN 1 END)
      comment: "Count of lost-time injury incidents. Core lagging indicator for workforce safety performance and insurance premium calculation."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN 1 END)
      comment: "Count of incidents still in open status. Measures investigation backlog and closure discipline."
    - name: "investigation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with a completed investigation. Measures HSE investigation throughput and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_ohs_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OHS investigation performance analytics — measures investigation cycle time, closure rates, corrective action linkage, and regulatory submission compliance to drive accountability in the HSE investigation process."
  source: "`vibe_shipping_ports_v1`.`safety`.`ohs_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (open, in-progress, closed, reopened) for workload and closure tracking."
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (internal, external, regulatory) for resource and compliance analysis."
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level assigned to the investigation, used to assess whether high-priority cases are resolved faster."
    - name: "rca_methodology"
      expr: rca_methodology
      comment: "Root cause analysis methodology used (5-Why, Bow-Tie, ICAM) for quality benchmarking of investigation practice."
    - name: "reopened_flag"
      expr: reopened_flag
      comment: "Indicates whether the investigation was reopened after initial closure, signalling inadequate first-pass resolution."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Status of regulatory submission for the investigation, used for compliance deadline tracking."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month the investigation was initiated for trend and backlog analysis."
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of OHS investigations. Baseline volume metric for investigation workload management."
    - name: "avg_investigation_duration_days"
      expr: AVG(CAST(investigation_duration_days AS DOUBLE))
      comment: "Average number of days to complete an investigation. Key cycle-time KPI — prolonged investigations delay corrective action and increase regulatory risk."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial impact of all investigated incidents. Informs risk reserve and insurance strategy."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per investigation. Benchmarks incident severity and prioritises prevention investment."
    - name: "reopened_investigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reopened_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations that were reopened. High rates indicate poor first-pass investigation quality and systemic root-cause gaps."
    - name: "lessons_learned_documentation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lessons_learned_documented = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations with documented lessons learned. Measures organisational learning effectiveness from safety incidents."
    - name: "regulatory_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of investigations requiring regulatory submission that have been submitted. Direct compliance KPI with regulatory penalty exposure."
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND actual_completion_date IS NULL THEN 1 END)
      comment: "Count of investigations past their target completion date without closure. Measures investigation backlog risk."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety corrective and preventive action (CAPA) analytics — tracks closure rates, overdue actions, cost of remediation, and escalation patterns to ensure safety findings are resolved and recurrence is prevented."
  source: "`vibe_shipping_ports_v1`.`safety`.`safety_corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (corrective, preventive, improvement) for CAPA classification analysis."
    - name: "safety_corrective_action_status"
      expr: safety_corrective_action_status
      comment: "Current lifecycle status of the corrective action (open, in-progress, closed, overdue) for workload management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action (critical, high, medium, low) for resource allocation decisions."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the corrective action (incident, audit, inspection, risk assessment) for root-cause category analysis."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for implementing the corrective action, enabling departmental accountability reporting."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flag indicating the corrective action is past its target completion date, used for escalation dashboards."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the corrective action for management intervention tracking."
    - name: "assigned_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the corrective action was assigned for trend and ageing analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of safety corrective actions. Baseline volume metric for CAPA workload management."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Count of corrective actions that are overdue. Critical KPI — overdue CAPAs represent unmitigated safety risk and regulatory non-compliance."
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that are overdue. Measures CAPA closure discipline and safety management system effectiveness."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to implement corrective actions. Measures cost of safety remediation for budget and insurance analysis."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency and informs risk-based prevention investment."
    - name: "cost_overrun_total"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun across all corrective actions (actual minus estimate). Measures planning accuracy and budget discipline in safety remediation."
    - name: "training_required_actions"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Count of corrective actions requiring training as part of remediation. Drives workforce safety training demand planning."
    - name: "escalated_actions"
      expr: COUNT(CASE WHEN escalation_status IS NOT NULL AND escalation_status != '' THEN 1 END)
      comment: "Count of corrective actions that have been escalated. Measures management intervention demand and systemic safety issues."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_corrective_action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been closed. Primary CAPA effectiveness KPI for HSE management reviews."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_contractor_safety`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor safety performance analytics — monitors contractor LTIFR, TRIR, insurance coverage, qualification status, and suspension rates to manage third-party safety risk at port operations."
  source: "`vibe_shipping_ports_v1`.`safety`.`contractor_safety`"
  dimensions:
    - name: "contractor_company_name"
      expr: contractor_company_name
      comment: "Name of the contractor company for per-contractor safety performance benchmarking."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the contractor (qualified, expired, suspended) for access control decisions."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of safety qualification held by the contractor for competency category analysis."
    - name: "safety_accreditation_type"
      expr: safety_accreditation_type
      comment: "Type of safety accreditation (ISO 45001, OHSAS, port-specific) for accreditation scheme analysis."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Indicates whether the contractor is currently suspended from site access due to safety non-compliance."
    - name: "safety_performance_rating"
      expr: safety_performance_rating
      comment: "Overall safety performance rating assigned to the contractor for vendor selection and renewal decisions."
    - name: "competency_verification_status"
      expr: competency_verification_status
      comment: "Status of the most recent competency verification for the contractor workforce."
    - name: "induction_required_flag"
      expr: induction_required_flag
      comment: "Flag indicating whether a safety induction is required before site access is granted."
  measures:
    - name: "total_contractors"
      expr: COUNT(1)
      comment: "Total number of contractor safety records. Baseline for contractor population size management."
    - name: "suspended_contractors"
      expr: COUNT(CASE WHEN suspension_flag = TRUE THEN 1 END)
      comment: "Count of contractors currently suspended. Measures active safety non-compliance exposure in the contractor supply chain."
    - name: "suspension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suspension_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contractors currently suspended. High rates signal systemic contractor safety management failures."
    - name: "avg_ltifr"
      expr: AVG(CAST(ltifr AS DOUBLE))
      comment: "Average Lost Time Injury Frequency Rate across contractors. Industry-standard lagging safety KPI for contractor workforce safety benchmarking."
    - name: "avg_trir"
      expr: AVG(CAST(trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate across contractors. Broader safety performance indicator used in contractor pre-qualification and renewal."
    - name: "avg_safety_performance_score"
      expr: AVG(CAST(safety_performance_score AS DOUBLE))
      comment: "Average composite safety performance score across contractors. Drives contractor tier classification and renewal decisions."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all contractors. Measures aggregate risk transfer capacity in the contractor supply chain."
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN qualification_expiry_date < CURRENT_DATE AND qualification_status != 'Suspended' THEN 1 END)
      comment: "Count of contractors with expired qualifications still active. Measures compliance gap in contractor qualification management."
    - name: "avg_emr_rate"
      expr: AVG(CAST(emr_rate AS DOUBLE))
      comment: "Average Experience Modification Rate (EMR) across contractors. EMR below 1.0 indicates better-than-industry safety performance; used in contractor selection and insurance pricing."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_ghg_emission_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GHG emissions analytics — tracks CO2, CH4, N2O and total CO2-equivalent emissions by scope, source category, fuel type, and reporting period to support decarbonisation strategy, regulatory reporting (IMO, EU ETS, MARPOL), and sustainability target management."
  source: "`vibe_shipping_ports_v1`.`safety`.`ghg_emission_record`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG Protocol scope classification (Scope 1, 2, 3) for emissions boundary analysis and regulatory reporting."
    - name: "emission_source_category"
      expr: emission_source_category
      comment: "Category of emission source (vessel operations, cargo handling, utilities, transport) for hotspot identification."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed (HFO, VLSFO, LNG, MDO, electricity) for fuel-mix decarbonisation analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the emission is reported (IMO DCS, EU MRV, MARPOL Annex VI) for compliance tracking."
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for the emission record, used for annual regulatory submission and year-on-year trend analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the emission record (verified, pending, rejected) for data quality assurance."
    - name: "data_quality_rating"
      expr: data_quality_rating
      comment: "Quality rating of the underlying emission data (measured, calculated, estimated) for uncertainty management."
    - name: "offset_applied_flag"
      expr: offset_applied_flag
      comment: "Indicates whether a carbon offset has been applied to this record, used for net-zero accounting."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start of the reporting period for time-series emissions trend analysis."
  measures:
    - name: "total_co2_equivalent_tonnes"
      expr: SUM(CAST(co2_equivalent_tonnes AS DOUBLE))
      comment: "Total CO2-equivalent emissions in tonnes. Primary decarbonisation KPI used in board sustainability reporting and regulatory submissions."
    - name: "total_co2_tonnes"
      expr: SUM(CAST(co2_tonnes AS DOUBLE))
      comment: "Total direct CO2 emissions in tonnes. Core metric for MARPOL Annex VI and IMO DCS regulatory reporting."
    - name: "total_ch4_tonnes"
      expr: SUM(CAST(ch4_tonnes AS DOUBLE))
      comment: "Total methane emissions in tonnes. Important for LNG-fuelled vessel operations and well-to-wake GHG accounting."
    - name: "total_n2o_tonnes"
      expr: SUM(CAST(n2o_tonnes AS DOUBLE))
      comment: "Total nitrous oxide emissions in tonnes. Required for complete GHG inventory under ISO 14064 and regulatory frameworks."
    - name: "avg_emission_factor_value"
      expr: AVG(CAST(emission_factor_value AS DOUBLE))
      comment: "Average emission factor applied across records. Monitors emission factor quality and consistency for regulatory audit readiness."
    - name: "verified_emission_records"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of emission records with third-party verification. Measures data assurance coverage for regulatory submission confidence."
    - name: "verification_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emission records that are third-party verified. Regulatory bodies require high verification rates for credible reporting."
    - name: "avg_uncertainty_percentage"
      expr: AVG(CAST(uncertainty_percentage AS DOUBLE))
      comment: "Average measurement uncertainty percentage across emission records. Lower uncertainty indicates higher data quality and regulatory credibility."
    - name: "total_activity_data_value"
      expr: SUM(CAST(activity_data_value AS DOUBLE))
      comment: "Total activity data (e.g., fuel consumed, distance sailed) underlying the emission calculations. Supports bottom-up emissions verification."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_sustainability_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability initiative portfolio analytics — tracks progress, budget performance, GHG reduction delivery, and energy savings across the port sustainability programme to steer decarbonisation investment and ESG reporting."
  source: "`vibe_shipping_ports_v1`.`safety`.`sustainability_initiative`"
  dimensions:
    - name: "initiative_category"
      expr: initiative_category
      comment: "Category of sustainability initiative (energy efficiency, renewable energy, waste reduction, biodiversity) for portfolio analysis."
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative (planned, in-progress, completed, cancelled) for portfolio health monitoring."
    - name: "initiative_priority"
      expr: initiative_priority
      comment: "Priority level of the initiative for resource allocation and executive attention."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the initiative (e.g., ISO 14001, Green Port) for ESG credential tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the initiative is driven by regulatory compliance requirements vs. voluntary action."
    - name: "wpsp_goal_alignment"
      expr: wpsp_goal_alignment
      comment: "World Ports Sustainability Programme goal alignment for international benchmarking and ESG reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Planned start month for initiative pipeline and resource scheduling analysis."
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of sustainability initiatives in the portfolio. Baseline for programme scale and ESG reporting."
    - name: "total_ghg_reduction_tonnes_co2e"
      expr: SUM(CAST(ghg_reduction_tonnes_co2e AS DOUBLE))
      comment: "Total GHG reduction delivered in CO2-equivalent tonnes. Primary decarbonisation outcome KPI for board and regulatory reporting."
    - name: "total_energy_savings_mwh"
      expr: SUM(CAST(energy_savings_mwh AS DOUBLE))
      comment: "Total energy savings in MWh across all initiatives. Measures energy efficiency programme impact and cost avoidance."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to sustainability initiatives. Measures ESG investment commitment for stakeholder reporting."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_amount AS DOUBLE))
      comment: "Total budget spent on sustainability initiatives. Tracks actual ESG expenditure against allocation."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(budget_spent_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated sustainability budget that has been spent. Measures programme execution velocity and financial discipline."
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress across all active sustainability initiatives. Portfolio-level execution health KPI for ESG steering committees."
    - name: "total_external_funding"
      expr: SUM(CAST(external_funding_amount AS DOUBLE))
      comment: "Total external funding secured for sustainability initiatives (grants, green bonds, subsidies). Measures funding diversification and ESG financing capability."
    - name: "completed_initiatives"
      expr: COUNT(CASE WHEN initiative_status = 'Completed' THEN 1 END)
      comment: "Count of completed sustainability initiatives. Measures programme delivery rate for ESG performance reporting."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN initiative_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sustainability initiatives that have been completed. Key ESG programme delivery KPI for board and investor reporting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_permit_to_work`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit-to-Work (PTW) system analytics — tracks permit issuance, closure rates, high-risk work categories, incident occurrence during permitted work, and overdue closures to manage operational safety controls at the port."
  source: "`vibe_shipping_ports_v1`.`safety`.`permit_to_work`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit to work (hot work, confined space, working at height, electrical isolation) for risk category analysis."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (issued, active, suspended, closed, cancelled) for workload and compliance tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the permitted work (low, medium, high, critical) for safety resource allocation."
    - name: "fire_watch_required_flag"
      expr: fire_watch_required_flag
      comment: "Indicates whether a fire watch was required, used for hot-work safety compliance analysis."
    - name: "gas_test_required_flag"
      expr: gas_test_required_flag
      comment: "Indicates whether a gas test was required before work commencement, used for confined-space safety compliance."
    - name: "isolation_required_flag"
      expr: isolation_required_flag
      comment: "Indicates whether energy isolation (LOTO) was required, used for electrical and mechanical safety compliance."
    - name: "incident_occurred_flag"
      expr: incident_occurred_flag
      comment: "Indicates whether an incident occurred during the permitted work, used to measure PTW system effectiveness."
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month the permit was issued for trend and seasonal workload analysis."
  measures:
    - name: "total_permits_issued"
      expr: COUNT(1)
      comment: "Total number of permits to work issued. Baseline for PTW system workload and operational activity volume."
    - name: "permits_with_incidents"
      expr: COUNT(CASE WHEN incident_occurred_flag = TRUE THEN 1 END)
      comment: "Count of permits during which an incident occurred. Measures PTW system failure rate and residual risk in permitted work."
    - name: "incident_rate_during_ptw_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incident_occurred_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits during which an incident occurred. Critical safety KPI — high rates indicate PTW controls are ineffective."
    - name: "toolbox_talk_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN toolbox_talk_conducted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where a toolbox talk was conducted before work commencement. Measures pre-work safety briefing compliance."
    - name: "competency_verification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN competency_verification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits where worker competency was verified. Measures compliance with competency-based access controls."
    - name: "high_risk_permits"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of high or critical risk permits issued. Measures volume of highest-risk work activities requiring enhanced oversight."
    - name: "avg_permit_extensions"
      expr: AVG(CAST(permit_extension_count AS DOUBLE))
      comment: "Average number of extensions per permit. High extension rates indicate poor work planning and prolonged risk exposure."
    - name: "open_permits"
      expr: COUNT(CASE WHEN permit_status IN ('Issued', 'Active') THEN 1 END)
      comment: "Count of currently open/active permits. Measures concurrent risk exposure from permitted work activities."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and regulatory inspection analytics — tracks inspection outcomes, compliance scores, finding rates, PSC detention flags, and closure performance to manage regulatory compliance and operational safety standards."
  source: "`vibe_shipping_ports_v1`.`safety`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (PSC, internal HSE, ISPS, environmental, fire safety) for compliance category analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (scheduled, in-progress, completed, closed) for workload tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall inspection outcome rating (satisfactory, minor deficiencies, major deficiencies, detention) for performance benchmarking."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting the inspection (Port State Control, flag state, classification society) for authority-specific compliance tracking."
    - name: "psc_detention_flag"
      expr: psc_detention_flag
      comment: "Indicates whether the inspection resulted in a Port State Control detention — the most severe regulatory outcome."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether follow-up action is required after the inspection, used for corrective action pipeline management."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of the inspection for trend and seasonal compliance analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset inspected (vessel, berth, crane, gate, warehouse) for asset-class compliance benchmarking."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline for inspection programme coverage and regulatory activity volume."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all inspections. Primary inspection quality KPI for regulatory performance benchmarking."
    - name: "psc_detentions"
      expr: COUNT(CASE WHEN psc_detention_flag = TRUE THEN 1 END)
      comment: "Count of Port State Control detentions. Highest-severity regulatory outcome — directly impacts vessel operations and port reputation."
    - name: "psc_detention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN psc_detention_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in PSC detention. Tracked by port authorities and shipping lines as a key port quality indicator."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all inspections. Measures severity of compliance gaps requiring immediate remediation."
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total number of major findings across all inspections. Measures significant compliance deficiencies requiring structured corrective action."
    - name: "avg_findings_per_inspection"
      expr: ROUND(SUM(CAST(total_findings_count AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average total findings per inspection. Measures inspection thoroughness and overall compliance health of inspected assets."
    - name: "inspections_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Count of inspections requiring follow-up action. Drives corrective action pipeline volume and resource planning."
    - name: "followup_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring follow-up. High rates indicate systemic compliance gaps across inspected assets."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_marpol_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MARPOL waste reception analytics — tracks waste volumes received, disposal compliance, hazardous waste handling, and cost of waste management to ensure compliance with MARPOL Annex I-VI and port waste reception facility obligations."
  source: "`vibe_shipping_ports_v1`.`safety`.`marpol_waste_record`"
  dimensions:
    - name: "marpol_annex"
      expr: marpol_annex
      comment: "MARPOL Annex classification (I=oil, II=noxious liquids, IV=sewage, V=garbage, VI=air emissions) for regulatory category analysis."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste received (oily water, garbage, sewage, chemical waste) for waste stream management."
    - name: "waste_category_code"
      expr: waste_category_code
      comment: "Standardised waste category code for regulatory reporting and waste stream classification."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the waste (incineration, landfill, recycling, treatment) for environmental compliance analysis."
    - name: "hazardous_waste_flag"
      expr: hazardous_waste_flag
      comment: "Indicates whether the waste is classified as hazardous, requiring special handling and regulatory tracking."
    - name: "non_compliance_flag"
      expr: non_compliance_flag
      comment: "Indicates a non-compliance event in the waste reception process, used for regulatory risk management."
    - name: "record_status"
      expr: record_status
      comment: "Status of the MARPOL waste record (active, submitted, closed) for regulatory submission tracking."
    - name: "reception_month"
      expr: DATE_TRUNC('MONTH', reception_timestamp)
      comment: "Month of waste reception for trend analysis and monthly MARPOL reporting."
  measures:
    - name: "total_waste_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of waste received across all MARPOL waste records. Primary volume KPI for waste reception facility capacity planning and regulatory reporting."
    - name: "total_waste_management_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of waste management operations. Drives waste management budget planning and cost recovery from vessel operators."
    - name: "avg_waste_management_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cost per waste reception event. Benchmarks waste management cost efficiency and informs port tariff setting for waste services."
    - name: "non_compliance_events"
      expr: COUNT(CASE WHEN non_compliance_flag = TRUE THEN 1 END)
      comment: "Count of MARPOL waste reception non-compliance events. Measures regulatory compliance failures with direct penalty and reputational risk."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN non_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste reception events with non-compliance. High rates trigger regulatory scrutiny and potential port authority sanctions."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN hazardous_waste_flag = TRUE THEN CAST(quantity_received AS DOUBLE) ELSE 0 END)
      comment: "Total quantity of hazardous waste received. Measures hazardous waste handling volume for special facility capacity and regulatory reporting."
    - name: "waste_declaration_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_declaration_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waste receptions where a waste declaration was received from the vessel. Measures compliance with MARPOL pre-notification requirements."
    - name: "regulatory_submission_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_required = TRUE AND regulatory_submission_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_submission_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required regulatory submissions that have been completed. Measures MARPOL reporting compliance rate."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_kpi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and sustainability KPI performance analytics — tracks actual vs target performance, variance, trend direction, and regulatory compliance across the port HSE and sustainability KPI framework."
  source: "`vibe_shipping_ports_v1`.`safety`.`kpi`"
  dimensions:
    - name: "kpi_category"
      expr: kpi_category
      comment: "Category of the KPI (safety, environmental, sustainability, operational) for portfolio-level performance analysis."
    - name: "kpi_type"
      expr: kpi_type
      comment: "Type of KPI (lagging indicator, leading indicator, process KPI) for safety management system maturity analysis."
    - name: "performance_status"
      expr: performance_status
      comment: "Current performance status of the KPI (on-target, at-risk, off-target) for executive dashboard traffic-light reporting."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of KPI trend (improving, stable, deteriorating) for proactive management intervention."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Indicates whether the KPI feeds into mandatory regulatory reporting, used for compliance obligation tracking."
    - name: "iso_45001_compliance_flag"
      expr: iso_45001_compliance_flag
      comment: "Indicates whether the KPI is linked to ISO 45001 occupational health and safety management system requirements."
    - name: "iso_14001_compliance_flag"
      expr: iso_14001_compliance_flag
      comment: "Indicates whether the KPI is linked to ISO 14001 environmental management system requirements."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start of the KPI reporting period for time-series performance trend analysis."
    - name: "operational_area"
      expr: operational_area
      comment: "Operational area the KPI applies to (berth, yard, gate, vessel operations) for area-specific performance management."
  measures:
    - name: "total_kpis"
      expr: COUNT(1)
      comment: "Total number of KPIs in the safety and sustainability framework. Baseline for KPI portfolio coverage assessment."
    - name: "kpis_off_target"
      expr: COUNT(CASE WHEN performance_status = 'Off-Target' THEN 1 END)
      comment: "Count of KPIs currently off-target. Drives management intervention and resource reallocation decisions."
    - name: "off_target_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_status = 'Off-Target' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPIs that are off-target. High rates signal systemic safety or sustainability performance failures requiring executive attention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and target KPI values. Measures overall safety and sustainability performance gap."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual KPI value across the portfolio. Provides a portfolio-level performance baseline for benchmarking."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target KPI value across the portfolio. Provides context for interpreting actual performance levels."
    - name: "kpis_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of KPIs that have triggered a corrective action requirement. Measures the volume of performance-driven safety interventions."
    - name: "deteriorating_kpis"
      expr: COUNT(CASE WHEN trend_direction = 'Deteriorating' THEN 1 END)
      comment: "Count of KPIs with a deteriorating trend. Leading indicator of future performance failures requiring proactive management."
    - name: "avg_trend_percentage_change"
      expr: AVG(CAST(trend_percentage_change AS DOUBLE))
      comment: "Average trend percentage change across KPIs. Positive values indicate improving performance; negative values signal deterioration."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_env_monitoring_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring analytics — tracks exceedance events, GHG readings, air quality parameters, and regulatory notification compliance from port environmental monitoring stations to manage MARPOL and environmental permit obligations."
  source: "`vibe_shipping_ports_v1`.`safety`.`env_monitoring_reading`"
  dimensions:
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of environmental parameter measured (NOx, SOx, PM10, CO2, noise, water quality) for pollutant-specific analysis."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Indicates whether the reading exceeded the regulatory or operational threshold, used for compliance breach tracking."
    - name: "exceedance_severity"
      expr: exceedance_severity
      comment: "Severity of the threshold exceedance (minor, moderate, major) for prioritising regulatory response."
    - name: "operational_activity_type"
      expr: operational_activity_type
      comment: "Type of port operational activity during the reading (vessel berthing, cargo handling, bunkering) for source attribution."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Regulatory compliance standard the reading is assessed against (MARPOL, EU Air Quality Directive, local permit) for multi-framework compliance tracking."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicates whether the reading triggers a mandatory regulatory notification obligation."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates whether the reading has a data quality issue, used to filter unreliable data from compliance calculations."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the environmental reading for trend analysis and monthly regulatory reporting."
  measures:
    - name: "total_readings"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring readings. Baseline for monitoring programme coverage and data density."
    - name: "exceedance_events"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Count of readings that exceeded regulatory or operational thresholds. Primary environmental compliance KPI with direct regulatory penalty exposure."
    - name: "exceedance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that exceeded thresholds. High rates indicate systemic environmental compliance failures requiring operational changes."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured environmental parameter value. Tracks ambient environmental conditions and long-term pollution trends."
    - name: "avg_ghg_co2_equivalent_kg"
      expr: AVG(CAST(ghg_co2_equivalent_kg AS DOUBLE))
      comment: "Average GHG CO2-equivalent per reading in kilograms. Measures average emission intensity from monitored sources."
    - name: "total_ghg_co2_equivalent_kg"
      expr: SUM(CAST(ghg_co2_equivalent_kg AS DOUBLE))
      comment: "Total GHG CO2-equivalent measured across all readings in kilograms. Aggregated emission load from monitored port activities."
    - name: "regulatory_notifications_required"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Count of readings triggering mandatory regulatory notification. Measures regulatory notification burden and compliance obligation volume."
    - name: "avg_exceedance_duration_minutes"
      expr: AVG(CAST(exceedance_duration_minutes AS DOUBLE))
      comment: "Average duration of threshold exceedance events in minutes. Longer exceedances indicate more severe environmental impacts and higher regulatory risk."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`safety_hazard_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazard register analytics — tracks hazard inventory, risk ratings, control effectiveness, and review compliance to manage operational safety risk across port facilities and activities."
  source: "`vibe_shipping_ports_v1`.`safety`.`hazard_register`"
  dimensions:
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of hazard (chemical, mechanical, electrical, ergonomic, fire, marine) for risk portfolio analysis."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Specific type of hazard for granular risk classification and control measure assignment."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls are applied (low, medium, high, critical) for risk acceptability assessment."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls are applied, used to measure control effectiveness."
    - name: "risk_acceptability_status"
      expr: risk_acceptability_status
      comment: "Whether the residual risk is acceptable, tolerable, or unacceptable — drives escalation and additional control requirements."
    - name: "hazard_register_status"
      expr: hazard_register_status
      comment: "Status of the hazard register entry (active, under review, closed, superseded) for register currency management."
    - name: "permit_to_work_required"
      expr: permit_to_work_required
      comment: "Indicates whether a permit to work is required to manage this hazard, linking hazard register to PTW system."
    - name: "operational_area"
      expr: operational_area
      comment: "Operational area where the hazard exists (berth, yard, gate, vessel) for area-specific risk management."
  measures:
    - name: "total_hazards"
      expr: COUNT(1)
      comment: "Total number of hazards in the register. Baseline for hazard inventory completeness and risk management coverage."
    - name: "high_residual_risk_hazards"
      expr: COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Count of hazards with high or critical residual risk after controls. Measures unacceptable risk exposure requiring priority management action."
    - name: "high_residual_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_rating IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazards with high or critical residual risk. High rates indicate inadequate risk controls requiring investment in safety measures."
    - name: "unacceptable_risk_hazards"
      expr: COUNT(CASE WHEN risk_acceptability_status = 'Unacceptable' THEN 1 END)
      comment: "Count of hazards with unacceptable residual risk. These require immediate management intervention and additional controls."
    - name: "hazards_requiring_ptw"
      expr: COUNT(CASE WHEN permit_to_work_required = TRUE THEN 1 END)
      comment: "Count of hazards requiring a permit to work for management. Drives PTW system workload planning and compliance requirements."
    - name: "overdue_reviews"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND hazard_register_status = 'Active' THEN 1 END)
      comment: "Count of active hazards with overdue reviews. Overdue hazard reviews represent unmanaged risk and ISO 45001 non-compliance."
    - name: "overdue_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_review_date < CURRENT_DATE AND hazard_register_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN hazard_register_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active hazards with overdue reviews. Measures hazard register currency and safety management system discipline."
    - name: "avg_incident_history_count"
      expr: AVG(CAST(incident_history_count AS DOUBLE))
      comment: "Average number of historical incidents associated with hazards in the register. Higher values indicate chronic hazards requiring priority control investment."
$$;