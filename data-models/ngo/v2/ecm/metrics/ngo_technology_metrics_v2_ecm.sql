-- Metric views for domain: technology | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for IT incident management — tracks incident volume, severity distribution, financial impact, resolution efficiency, and data-breach exposure. Informs ITSM steering decisions and SLA compliance reviews."
  source: "`vibe_ngo_v1`.`technology`.`it_incident`"
  dimensions:
    - name: "incident_severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (e.g., Critical, High, Medium, Low) — primary grouping for triage and escalation analysis."
    - name: "incident_category"
      expr: it_incident_category
      comment: "Functional category of the incident (e.g., Network, Application, Security) — used to identify systemic problem areas."
    - name: "incident_status"
      expr: it_incident_status
      comment: "Current lifecycle status of the incident (e.g., Open, In Progress, Resolved, Closed) — used to monitor backlog and throughput."
    - name: "is_security_incident"
      expr: security_incident
      comment: "Flag indicating whether the incident is classified as a security event — critical for compliance and risk reporting."
    - name: "is_data_breach"
      expr: data_breach
      comment: "Flag indicating whether the incident involved a data breach — triggers regulatory notification obligations."
    - name: "breach_notification_required"
      expr: breach_notification_required
      comment: "Flag indicating whether external breach notification is legally required — drives compliance action tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level classification of the root cause — used for problem management and preventive action prioritization."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the incident was escalated — indicates severity of operational disruption."
    - name: "affected_country_office"
      expr: affected_country_office
      comment: "Country office impacted by the incident — enables geographic analysis of IT reliability."
    - name: "affected_program"
      expr: affected_program
      comment: "Program impacted by the incident — links IT disruption to programmatic delivery risk."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month the incident was reported — used for trend analysis and monthly SLA reporting."
    - name: "resolved_month"
      expr: DATE_TRUNC('MONTH', resolved_timestamp)
      comment: "Month the incident was resolved — used to track resolution throughput over time."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of IT incidents recorded — baseline volume metric for ITSM capacity and trend analysis."
    - name: "total_security_incidents"
      expr: COUNT(CASE WHEN security_incident = TRUE THEN 1 END)
      comment: "Count of incidents classified as security events — key risk indicator for the CISO and compliance team."
    - name: "total_data_breach_incidents"
      expr: COUNT(CASE WHEN data_breach = TRUE THEN 1 END)
      comment: "Count of incidents involving a confirmed data breach — directly triggers regulatory and donor reporting obligations."
    - name: "total_breach_notifications_required"
      expr: COUNT(CASE WHEN breach_notification_required = TRUE THEN 1 END)
      comment: "Count of incidents requiring external breach notification — tracks legal compliance exposure."
    - name: "total_escalated_incidents"
      expr: COUNT(CASE WHEN escalated = TRUE THEN 1 END)
      comment: "Count of incidents that were escalated — indicates incidents exceeding normal resolution capacity."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total financial impact of all incidents in USD — quantifies the cost of IT disruptions for budget and risk management."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per incident in USD — benchmarks the typical cost of an IT incident for risk modeling."
    - name: "security_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN security_incident = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all incidents classified as security incidents — tracks the security risk profile of the IT environment."
    - name: "data_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that resulted in a data breach — critical compliance and risk KPI for leadership."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that required escalation — indicates ITSM team capacity and first-line resolution effectiveness."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN it_incident_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of incidents not yet resolved or closed — operational backlog metric for ITSM queue management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_vulnerability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security vulnerability management KPIs — tracks open vulnerabilities, severity distribution, CVSS scores, remediation timeliness, and patch coverage. Informs security posture decisions and compliance reporting."
  source: "`vibe_ngo_v1`.`technology`.`vulnerability`"
  dimensions:
    - name: "vulnerability_severity_rating"
      expr: severity_rating
      comment: "Severity classification of the vulnerability (e.g., Critical, High, Medium, Low) — primary grouping for remediation prioritization."
    - name: "vulnerability_risk_level"
      expr: risk_level
      comment: "Risk level assigned to the vulnerability — used to prioritize remediation effort and resource allocation."
    - name: "vulnerability_status"
      expr: vulnerability_status
      comment: "Current remediation status of the vulnerability (e.g., Open, In Remediation, Remediated, Accepted) — tracks remediation pipeline."
    - name: "vulnerability_type"
      expr: vulnerability_type
      comment: "Type/class of vulnerability (e.g., SQL Injection, Misconfiguration, Unpatched Software) — identifies systemic security weaknesses."
    - name: "is_patch_available"
      expr: patch_available
      comment: "Flag indicating whether a vendor patch is available — distinguishes actionable from unmitigated vulnerabilities."
    - name: "is_workaround_available"
      expr: workaround_available
      comment: "Flag indicating whether a workaround exists — used to assess interim risk mitigation options."
    - name: "exploitability_status"
      expr: exploitability_status
      comment: "Whether the vulnerability is known to be actively exploited — highest-priority risk signal for security operations."
    - name: "affected_data_classification"
      expr: affected_data_classification
      comment: "Data classification level of the affected system — determines regulatory and donor reporting implications."
    - name: "discovery_method"
      expr: discovery_method
      comment: "How the vulnerability was discovered (e.g., Scan, Pen Test, Bug Bounty) — informs investment in detection capabilities."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month the vulnerability was discovered — used for trend analysis of new vulnerability intake."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the vulnerability has been independently verified — ensures remediation tracking is based on confirmed findings."
  measures:
    - name: "total_vulnerabilities"
      expr: COUNT(1)
      comment: "Total number of vulnerabilities recorded — baseline security posture metric."
    - name: "open_vulnerabilities"
      expr: COUNT(CASE WHEN vulnerability_status NOT IN ('Remediated', 'Closed', 'Accepted') THEN 1 END)
      comment: "Count of vulnerabilities not yet remediated or formally accepted — active security risk backlog."
    - name: "critical_high_vulnerabilities"
      expr: COUNT(CASE WHEN severity_rating IN ('Critical', 'High') THEN 1 END)
      comment: "Count of Critical and High severity vulnerabilities — primary KPI for security risk escalation to leadership."
    - name: "exploitable_open_vulnerabilities"
      expr: COUNT(CASE WHEN exploitability_status = 'Exploitable' AND vulnerability_status NOT IN ('Remediated', 'Closed', 'Accepted') THEN 1 END)
      comment: "Count of open vulnerabilities that are actively exploitable — highest-urgency security risk metric."
    - name: "avg_cvss_score"
      expr: AVG(CAST(cvss_score AS DOUBLE))
      comment: "Average CVSS score across all vulnerabilities — provides a normalized measure of overall security risk severity."
    - name: "max_cvss_score"
      expr: MAX(cvss_score)
      comment: "Maximum CVSS score in the portfolio — identifies the most severe vulnerability currently tracked."
    - name: "patch_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patch_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vulnerabilities for which a vendor patch is available — measures actionability of the remediation backlog."
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vulnerability_status IN ('Remediated', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vulnerabilities that have been remediated or closed — tracks overall remediation effectiveness."
    - name: "unpatched_critical_vulnerabilities"
      expr: COUNT(CASE WHEN severity_rating = 'Critical' AND patch_available = TRUE AND vulnerability_status NOT IN ('Remediated', 'Closed') THEN 1 END)
      comment: "Count of Critical vulnerabilities with an available patch that remain unremediated — most actionable security risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_access_provisioning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity and access management KPIs — tracks provisioning request volumes, approval timeliness, compliance signoff rates, privileged access exposure, and MFA enforcement. Informs access governance and audit readiness."
  source: "`vibe_ngo_v1`.`technology`.`access_provisioning`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of access provisioning request (e.g., New Access, Modification, Deprovisioning) — used to analyze access lifecycle patterns."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the provisioning request (e.g., Pending, Approved, Rejected, Completed) — tracks request pipeline health."
    - name: "access_level"
      expr: access_level
      comment: "Level of access being provisioned (e.g., Read, Write, Admin) — used to assess privilege distribution."
    - name: "data_classification_access_level"
      expr: data_classification_access_level
      comment: "Data classification level the access grants (e.g., Confidential, Restricted) — critical for data governance reporting."
    - name: "jml_lifecycle_stage"
      expr: jml_lifecycle_stage
      comment: "Joiner/Mover/Leaver lifecycle stage triggering the provisioning — used to track access hygiene across HR events."
    - name: "is_mfa_required"
      expr: multi_factor_authentication_required_flag
      comment: "Flag indicating whether MFA is required for this access — tracks enforcement of MFA policy across provisioned accounts."
    - name: "is_compliance_signoff_required"
      expr: compliance_signoff_required_flag
      comment: "Flag indicating whether compliance sign-off is required — used to monitor compliance gate adherence."
    - name: "is_beneficiary_data_access"
      expr: beneficiary_data_access_flag
      comment: "Flag indicating access to beneficiary data — highest sensitivity category requiring strict governance oversight."
    - name: "is_financial_data_access"
      expr: financial_data_access_flag
      comment: "Flag indicating access to financial data — requires segregation of duties and audit trail."
    - name: "target_system_environment"
      expr: target_system_environment
      comment: "Environment being accessed (e.g., Production, UAT, Development) — production access requires stricter controls."
    - name: "request_submitted_month"
      expr: DATE_TRUNC('MONTH', request_submitted_timestamp)
      comment: "Month the provisioning request was submitted — used for volume trend analysis."
  measures:
    - name: "total_provisioning_requests"
      expr: COUNT(1)
      comment: "Total number of access provisioning requests — baseline volume metric for IAM workload and governance coverage."
    - name: "pending_requests"
      expr: COUNT(CASE WHEN request_status = 'Pending' THEN 1 END)
      comment: "Count of provisioning requests currently pending approval — operational backlog metric for access governance teams."
    - name: "compliance_signoff_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_signoff_required_flag = TRUE AND compliance_signoff_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_signoff_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of compliance-required provisioning requests that have received sign-off — measures compliance gate adherence."
    - name: "mfa_enforcement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN multi_factor_authentication_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provisioned accesses requiring MFA — tracks enforcement of MFA security policy across the access portfolio."
    - name: "beneficiary_data_access_count"
      expr: COUNT(CASE WHEN beneficiary_data_access_flag = TRUE THEN 1 END)
      comment: "Count of provisioning requests granting access to beneficiary data — high-sensitivity access requiring close governance scrutiny."
    - name: "donor_audit_requirement_count"
      expr: COUNT(CASE WHEN donor_audit_requirement_flag = TRUE THEN 1 END)
      comment: "Count of provisioning requests flagged for donor audit requirements — tracks access provisioning subject to external audit."
    - name: "avg_access_duration_days"
      expr: AVG(CAST(access_duration_days AS DOUBLE))
      comment: "Average duration in days of provisioned access — identifies overly long-lived access grants that increase risk exposure. Note: access_duration_days is stored as STRING; cast applied for aggregation."
    - name: "remote_access_permitted_count"
      expr: COUNT(CASE WHEN remote_access_permitted_flag = TRUE THEN 1 END)
      comment: "Count of provisioning requests permitting remote access — tracks remote access exposure for security risk management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT change management KPIs — tracks change request volumes, approval rates, risk distribution, rollback frequency, and implementation outcomes. Informs CAB governance and change risk management decisions."
  source: "`vibe_ngo_v1`.`technology`.`change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., Standard, Normal, Emergency) — used to analyze change risk profile and approval pathway compliance."
    - name: "change_category"
      expr: change_category
      comment: "Functional category of the change (e.g., Infrastructure, Application, Security) — identifies which domains drive change volume."
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current lifecycle status of the change request — tracks pipeline health and approval throughput."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the change (e.g., Low, Medium, High) — primary dimension for change governance oversight."
    - name: "priority"
      expr: priority
      comment: "Priority of the change request — used to assess urgency and resource allocation for implementation."
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "Status of CAB approval for the change — tracks governance gate compliance."
    - name: "is_downtime_required"
      expr: downtime_required
      comment: "Flag indicating whether the change requires system downtime — used to assess operational impact of the change pipeline."
    - name: "post_implementation_review_completed"
      expr: post_implementation_review_completed
      comment: "Flag indicating whether a post-implementation review was completed — tracks change quality assurance compliance."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the change request was submitted — used for volume trend and seasonal pattern analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests — baseline volume metric for change management capacity planning."
    - name: "high_risk_changes"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk change requests — key governance metric for CAB and IT leadership risk oversight."
    - name: "emergency_changes"
      expr: COUNT(CASE WHEN change_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency change requests — elevated emergency change rates signal instability in the IT environment."
    - name: "cab_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cab_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN cab_approval_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of CAB-required changes that received CAB approval — measures governance gate effectiveness."
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_change_request_id IS NOT NULL THEN 1 END)
      comment: "Count of changes that triggered a rollback — high rollback rates indicate poor change quality or testing."
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_change_request_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes that required rollback — critical quality KPI for change management maturity assessment."
    - name: "post_implementation_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_implementation_review_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes with a completed post-implementation review — tracks change quality assurance discipline."
    - name: "downtime_required_count"
      expr: COUNT(CASE WHEN downtime_required = TRUE THEN 1 END)
      comment: "Count of changes requiring system downtime — quantifies planned service disruption from the change pipeline."
    - name: "avg_estimated_downtime_minutes"
      expr: AVG(CAST(estimated_downtime_minutes AS DOUBLE))
      comment: "Average estimated downtime per change requiring downtime — used to plan maintenance windows and communicate service impact. Note: estimated_downtime_minutes is stored as STRING; cast applied for aggregation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT project portfolio KPIs — tracks project count, budget vs. actual cost, schedule performance, completion rates, and risk distribution. Informs IT investment governance and portfolio steering decisions."
  source: "`vibe_ngo_v1`.`technology`.`it_project`"
  dimensions:
    - name: "project_status"
      expr: it_project_status
      comment: "Current lifecycle status of the IT project (e.g., Active, On Hold, Completed, Cancelled) — primary dimension for portfolio health monitoring."
    - name: "project_type"
      expr: it_project_type
      comment: "Type of IT project (e.g., Infrastructure, Application, Security, Data) — used to analyze investment allocation by category."
    - name: "project_category"
      expr: it_project_category
      comment: "Functional category of the project — provides finer-grained classification for portfolio analysis."
    - name: "health_status"
      expr: health_status
      comment: "RAG health status of the project (e.g., Green, Amber, Red) — primary executive dashboard dimension for portfolio risk."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the project — used to prioritize governance attention and escalation."
    - name: "priority"
      expr: priority
      comment: "Priority of the project in the portfolio — used to align resource allocation with strategic importance."
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Delivery methodology used (e.g., Agile, Waterfall, Hybrid) — used to compare delivery performance across methodologies."
    - name: "sponsoring_domain"
      expr: sponsoring_domain
      comment: "Business domain sponsoring the project — used to attribute IT investment to business units."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which project costs are denominated — required for multi-currency portfolio cost analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the project was planned to start — used for portfolio intake and scheduling analysis."
    - name: "planned_end_month"
      expr: DATE_TRUNC('MONTH', planned_end_date)
      comment: "Month the project was planned to end — used for delivery schedule analysis."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IT projects in the portfolio — baseline metric for portfolio size and governance coverage."
    - name: "active_projects"
      expr: COUNT(CASE WHEN it_project_status = 'Active' THEN 1 END)
      comment: "Count of currently active IT projects — measures current execution load on the IT delivery function."
    - name: "red_health_projects"
      expr: COUNT(CASE WHEN health_status = 'Red' THEN 1 END)
      comment: "Count of projects with Red health status — primary escalation metric for IT portfolio governance."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all IT projects — measures total IT investment commitment."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all IT projects — used to track spend against approved budgets."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average approved budget per IT project — benchmarks typical project investment size."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across active projects — tracks overall portfolio delivery progress."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed by actual costs — key financial governance KPI for IT portfolio management."
    - name: "cost_overrun_count"
      expr: COUNT(CASE WHEN actual_cost > budget_amount THEN 1 END)
      comment: "Count of projects where actual cost exceeds approved budget — identifies projects requiring financial intervention."
    - name: "high_risk_project_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk IT projects — used by IT leadership to prioritize risk mitigation and governance attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software asset management KPIs — tracks license costs, seat utilization, compliance status, expiration risk, and mission-critical coverage. Informs software procurement, renewal, and compliance decisions."
  source: "`vibe_ngo_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_status"
      expr: software_license_status
      comment: "Current status of the software license (e.g., Active, Expired, Pending Renewal) — primary dimension for license portfolio health."
    - name: "license_type"
      expr: software_license_type
      comment: "Type of software license (e.g., Perpetual, Subscription, SaaS) — used to analyze cost structure and renewal risk."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the license (e.g., Compliant, Non-Compliant, Under Review) — tracks software audit risk."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (e.g., Cloud, On-Premise, Hybrid) — used to analyze cloud vs. on-premise cost distribution."
    - name: "is_mission_critical"
      expr: is_mission_critical
      comment: "Flag indicating whether the licensed software is mission-critical — prioritizes renewal and compliance attention."
    - name: "is_auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Flag indicating whether auto-renewal is enabled — used to manage unplanned budget commitments."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of license payments (e.g., Annual, Monthly, One-Time) — used for cash flow and budget planning."
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Business domain the license primarily serves — used to attribute software costs to business units."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which license costs are denominated — required for multi-currency cost analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the license expires — used to identify upcoming renewal obligations and expiration risk."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of software licenses in the portfolio — baseline metric for software asset management coverage."
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost of all software licenses — primary financial KPI for software budget management."
    - name: "avg_annual_cost"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per software license — benchmarks typical license investment for procurement negotiations."
    - name: "total_cost_per_seat"
      expr: SUM(CAST(cost_per_seat AS DOUBLE))
      comment: "Sum of per-seat costs across all licenses — used to analyze per-user software spend."
    - name: "avg_cost_per_seat"
      expr: AVG(CAST(cost_per_seat AS DOUBLE))
      comment: "Average cost per seat across all licenses — benchmarks per-user software investment for cost optimization."
    - name: "non_compliant_license_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of licenses in non-compliant status — tracks software audit risk and potential penalty exposure."
    - name: "non_compliant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses that are non-compliant — key software governance KPI for audit readiness."
    - name: "mission_critical_license_count"
      expr: COUNT(CASE WHEN is_mission_critical = TRUE THEN 1 END)
      comment: "Count of mission-critical software licenses — used to prioritize renewal and continuity planning."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of licenses expiring within the next 90 days — proactive renewal risk management metric."
    - name: "mission_critical_annual_cost"
      expr: SUM(CASE WHEN is_mission_critical = TRUE THEN annual_cost ELSE 0 END)
      comment: "Total annual cost of mission-critical software licenses — quantifies the financial exposure of critical system continuity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_connectivity_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network connectivity and uptime KPIs — tracks outage frequency, duration, bandwidth performance, SLA compliance, and packet loss. Informs field connectivity investment and ISP contract management decisions."
  source: "`vibe_ngo_v1`.`technology`.`connectivity_log`"
  dimensions:
    - name: "connection_status"
      expr: connection_status
      comment: "Current connectivity status (e.g., Connected, Disconnected, Degraded) — primary dimension for uptime analysis."
    - name: "connection_type"
      expr: connection_type
      comment: "Type of network connection (e.g., Fiber, Satellite, 4G) — used to compare reliability across connectivity technologies."
    - name: "cause_classification"
      expr: cause_classification
      comment: "Classification of the connectivity issue cause (e.g., ISP Failure, Hardware, Weather) — used for root cause trend analysis."
    - name: "isp_provider_name"
      expr: isp_provider_name
      comment: "Name of the ISP provider — used to evaluate ISP performance and inform contract renegotiation decisions."
    - name: "is_sla_compliant"
      expr: sla_compliant_flag
      comment: "Flag indicating whether the connectivity event met SLA targets — tracks ISP and network SLA compliance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the connectivity event — used to assess business impact severity of outages."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of the connectivity measurement — used for trend analysis of network performance over time."
  measures:
    - name: "total_connectivity_events"
      expr: COUNT(1)
      comment: "Total number of connectivity log events — baseline metric for network monitoring coverage and event volume."
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total outage duration in minutes across all events — quantifies cumulative connectivity downtime impacting field operations."
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per event in minutes — benchmarks typical connectivity disruption length."
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds — key performance indicator for application usability at field sites."
    - name: "avg_packet_loss_pct"
      expr: AVG(CAST(packet_loss_percent AS DOUBLE))
      comment: "Average packet loss percentage — measures network quality degradation affecting field system reliability."
    - name: "avg_download_speed_mbps"
      expr: AVG(CAST(download_speed_mbps AS DOUBLE))
      comment: "Average download speed in Mbps — tracks bandwidth availability for field operations and data synchronization."
    - name: "avg_upload_speed_mbps"
      expr: AVG(CAST(upload_speed_mbps AS DOUBLE))
      comment: "Average upload speed in Mbps — tracks upload capacity for field data submission and reporting."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connectivity events meeting SLA targets — primary ISP contract performance KPI."
    - name: "avg_bandwidth_utilization_pct"
      expr: AVG(CAST(bandwidth_utilization_percent AS DOUBLE))
      comment: "Average bandwidth utilization percentage — identifies sites approaching capacity limits requiring infrastructure investment."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_compliant_flag = FALSE THEN 1 END)
      comment: "Count of connectivity events that breached SLA targets — used to trigger ISP penalty clauses and escalation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_procurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT procurement KPIs — tracks procurement volumes, budget vs. actual cost, approval timeliness, compliance check rates, and payment status. Informs IT asset investment governance and vendor management decisions."
  source: "`vibe_ngo_v1`.`technology`.`it_procurement`"
  dimensions:
    - name: "procurement_status"
      expr: it_procurement_status
      comment: "Current status of the procurement request (e.g., Pending, Approved, Delivered, Cancelled) — tracks procurement pipeline health."
    - name: "procurement_type"
      expr: it_procurement_type
      comment: "Type of IT procurement (e.g., Hardware, Software, Services) — used to analyze spend by category."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the procurement (e.g., Paid, Pending, Overdue) — tracks financial settlement of IT purchases."
    - name: "compliance_check_required"
      expr: compliance_check_required
      comment: "Flag indicating whether a compliance check is required — used to monitor procurement governance gate adherence."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of the compliance check (e.g., Passed, Failed, Pending) — tracks procurement compliance gate outcomes."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the procurement request — used to assess urgency and resource allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which procurement costs are denominated — required for multi-currency spend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the procurement order was placed — used for spend trend analysis and budget cycle reporting."
  measures:
    - name: "total_procurements"
      expr: COUNT(1)
      comment: "Total number of IT procurement requests — baseline metric for procurement workload and governance coverage."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all IT procurement requests — measures total IT procurement budget commitment."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all IT procurements — tracks realized IT spend against estimates."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per IT procurement — benchmarks typical IT purchase size for budget planning."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(estimated_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus estimated) across all procurements — positive values indicate cost overruns requiring management attention."
    - name: "compliance_check_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_check_status = 'Passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_check_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of compliance-required procurements that passed the compliance check — measures procurement governance effectiveness."
    - name: "overdue_payment_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN 1 END)
      comment: "Count of procurements with overdue payments — tracks financial liability and vendor relationship risk."
    - name: "cost_overrun_count"
      expr: COUNT(CASE WHEN actual_cost > estimated_cost THEN 1 END)
      comment: "Count of procurements where actual cost exceeded the estimate — identifies procurement estimation accuracy issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_security_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security assessment portfolio KPIs — tracks assessment coverage, findings severity, remediation status, and donor reporting obligations. Informs security investment prioritization and compliance posture decisions."
  source: "`vibe_ngo_v1`.`technology`.`security_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: security_assessment_status
      comment: "Current status of the security assessment (e.g., Planned, In Progress, Completed, Remediation) — tracks assessment pipeline."
    - name: "assessment_type"
      expr: security_assessment_type
      comment: "Type of security assessment (e.g., Penetration Test, Vulnerability Scan, Audit) — used to analyze assessment coverage by method."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating from the assessment (e.g., Critical, High, Medium, Low) — primary executive risk signal."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions from the assessment — tracks follow-through on security findings."
    - name: "is_beneficiary_data_at_risk"
      expr: beneficiary_data_at_risk
      comment: "Flag indicating whether beneficiary data was identified as at risk — highest-priority finding category for NGO operations."
    - name: "is_donor_reporting_required"
      expr: donor_reporting_required
      comment: "Flag indicating whether donor reporting is required for this assessment — tracks external reporting obligations."
    - name: "conducting_entity_type"
      expr: conducting_entity_type
      comment: "Type of entity conducting the assessment (e.g., Internal, External, Third-Party) — used to analyze assessment independence."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', security_assessment_date)
      comment: "Month the security assessment was conducted — used for assessment frequency and coverage trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of security assessments conducted — baseline metric for security assurance coverage."
    - name: "total_assessment_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of all security assessments — tracks investment in security assurance activities."
    - name: "avg_assessment_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per security assessment — benchmarks security assurance investment for budget planning."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all assessments — primary security risk KPI requiring immediate executive attention. Note: critical_findings_count is stored as STRING; cast applied for aggregation."
    - name: "total_high_findings"
      expr: SUM(CAST(high_findings_count AS DOUBLE))
      comment: "Total number of high-severity findings across all assessments — tracks significant security risk requiring prioritized remediation. Note: high_findings_count is stored as STRING; cast applied for aggregation."
    - name: "beneficiary_data_at_risk_count"
      expr: COUNT(CASE WHEN beneficiary_data_at_risk = TRUE THEN 1 END)
      comment: "Count of assessments where beneficiary data was identified as at risk — highest-priority finding for NGO data protection obligations."
    - name: "donor_reporting_required_count"
      expr: COUNT(CASE WHEN donor_reporting_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring donor reporting — tracks external reporting obligations arising from security assessments."
    - name: "remediation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with completed remediation — measures follow-through on security findings."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_user_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User account governance KPIs — tracks active account counts, MFA enrollment, privileged access exposure, security training compliance, and account lifecycle hygiene. Informs identity governance and access risk management."
  source: "`vibe_ngo_v1`.`technology`.`user_account`"
  dimensions:
    - name: "account_status"
      expr: user_account_status
      comment: "Current status of the user account (e.g., Active, Suspended, Deprovisioned) — primary dimension for account lifecycle analysis."
    - name: "account_type"
      expr: user_account_type
      comment: "Type of user account (e.g., Standard, Service, Admin, Shared) — used to analyze account risk profile distribution."
    - name: "is_mfa_enrolled"
      expr: mfa_enrolled_flag
      comment: "Flag indicating whether MFA is enrolled for the account — tracks MFA adoption across the user population."
    - name: "is_privileged_account"
      expr: privileged_account_flag
      comment: "Flag indicating whether the account has privileged access — privileged accounts require enhanced governance oversight."
    - name: "is_beneficiary_data_access"
      expr: beneficiary_data_access_flag
      comment: "Flag indicating whether the account has access to beneficiary data — highest sensitivity access category."
    - name: "is_financial_system_access"
      expr: financial_system_access_flag
      comment: "Flag indicating whether the account has financial system access — requires segregation of duties controls."
    - name: "is_remote_access_enabled"
      expr: remote_access_enabled_flag
      comment: "Flag indicating whether remote access is enabled — tracks remote access exposure for security risk management."
    - name: "mfa_method"
      expr: mfa_method
      comment: "MFA method enrolled (e.g., Authenticator App, SMS, Hardware Token) — used to assess MFA strength distribution."
    - name: "provisioning_month"
      expr: DATE_TRUNC('MONTH', provisioning_date)
      comment: "Month the account was provisioned — used for account creation trend analysis."
  measures:
    - name: "total_user_accounts"
      expr: COUNT(1)
      comment: "Total number of user accounts — baseline metric for identity governance scope."
    - name: "active_accounts"
      expr: COUNT(CASE WHEN user_account_status = 'Active' THEN 1 END)
      comment: "Count of currently active user accounts — measures the active identity footprint requiring ongoing governance."
    - name: "mfa_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mfa_enrolled_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN user_account_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active accounts with MFA enrolled — critical security policy compliance KPI for identity governance."
    - name: "privileged_account_count"
      expr: COUNT(CASE WHEN privileged_account_flag = TRUE THEN 1 END)
      comment: "Count of privileged user accounts — tracks privileged access exposure requiring enhanced monitoring and review."
    - name: "privileged_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN privileged_account_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN user_account_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active accounts with privileged access — measures privilege sprawl risk in the identity environment."
    - name: "locked_account_count"
      expr: COUNT(CASE WHEN locked_flag = TRUE THEN 1 END)
      comment: "Count of currently locked user accounts — elevated locked account counts may indicate brute-force attacks or access issues."
    - name: "security_training_overdue_count"
      expr: COUNT(CASE WHEN security_training_completion_date < DATE_ADD(CURRENT_DATE, -365) OR security_training_completion_date IS NULL THEN 1 END)
      comment: "Count of accounts where security training is overdue (not completed in the past year or never completed) — tracks security awareness compliance."
    - name: "beneficiary_data_access_count"
      expr: COUNT(CASE WHEN beneficiary_data_access_flag = TRUE AND user_account_status = 'Active' THEN 1 END)
      comment: "Count of active accounts with beneficiary data access — tracks the population of accounts with highest-sensitivity data access."
    - name: "data_protection_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_protection_acknowledgment_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN user_account_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active accounts with data protection acknowledgment completed — tracks compliance with data protection policy requirements."
$$;