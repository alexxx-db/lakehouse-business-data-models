-- Metric views for domain: technology | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational IT incident management KPIs for the NGO technology function. Tracks incident volume, severity distribution, breach exposure, and financial impact across systems including DHIS2, Kobo Toolbox, Primero, SAP, and eTools. Critical for CIO/CISO steering meetings and donor audit readiness."
  source: "`vibe_ngo_v1`.`technology`.`it_incident`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Incident severity tier (Critical/High/Medium/Low) — primary triage dimension for prioritisation dashboards."
    - name: "incident_category"
      expr: incident_category
      comment: "Functional category of the incident (e.g. Network, Application, Security) used to route remediation effort."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle state (Open, In Progress, Resolved, Closed) — drives SLA compliance tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause grouping enabling trend analysis and preventive investment decisions."
    - name: "is_security_incident"
      expr: security_incident
      comment: "Boolean flag distinguishing cyber/security incidents from operational outages — required for donor safeguarding and PSEA audit trails."
    - name: "is_data_breach"
      expr: data_breach
      comment: "Boolean flag indicating a confirmed data breach — triggers mandatory breach notification workflows and donor reporting obligations."
    - name: "affected_country_office"
      expr: affected_country_office
      comment: "Country office impacted by the incident — enables geographic risk concentration analysis across field operations."
    - name: "affected_program"
      expr: affected_program
      comment: "Program disrupted by the incident — links technology risk to programmatic delivery impact."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier reached during incident lifecycle — indicates severity of management response required."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Calendar month of incident report — enables trend analysis and monthly operational reviews."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of IT incidents recorded. Baseline volume KPI for capacity planning and trend monitoring."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of incidents not yet resolved or closed. Elevated open counts signal resource constraints or systemic issues requiring CIO intervention."
    - name: "security_incidents"
      expr: COUNT(CASE WHEN security_incident = TRUE THEN 1 END)
      comment: "Count of confirmed security incidents. Directly informs CISO risk posture and donor cybersecurity reporting requirements."
    - name: "data_breach_incidents"
      expr: COUNT(CASE WHEN data_breach = TRUE THEN 1 END)
      comment: "Count of confirmed data breach incidents. Triggers regulatory notification obligations and donor audit findings — zero-tolerance KPI for beneficiary data protection."
    - name: "breach_notification_required_count"
      expr: COUNT(CASE WHEN breach_notification_required = TRUE THEN 1 END)
      comment: "Incidents requiring formal breach notification to regulators or donors. Non-zero values demand immediate executive action."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Aggregate financial impact of IT incidents in USD. Quantifies technology risk exposure for budget and insurance decisions."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per incident. Benchmarks cost of incidents to justify preventive investment in security controls."
    - name: "escalated_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that required escalation. High escalation rates indicate inadequate first-line resolution capability."
    - name: "workaround_applied_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN workaround_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resolved via workaround rather than permanent fix. High rates signal technical debt accumulation."
    - name: "critical_high_incident_share"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_level IN ('Critical', 'High') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of incidents classified as Critical or High severity. Drives prioritisation of remediation resources and SLA enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_vulnerability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity vulnerability management KPIs tracking exposure, remediation velocity, and risk concentration across NGO systems. Essential for CISO reporting, donor cybersecurity audits, and compliance with frameworks such as ISO 27001 and NIST CSF. Covers systems including SAP, DHIS2, Primero, and Kobo Toolbox that process sensitive beneficiary and financial data."
  source: "`vibe_ngo_v1`.`technology`.`vulnerability`"
  dimensions:
    - name: "severity_rating"
      expr: severity_rating
      comment: "Vulnerability severity classification (Critical/High/Medium/Low/Informational) — primary risk triage dimension."
    - name: "risk_level"
      expr: risk_level
      comment: "Composite risk level assigned to the vulnerability — used for executive risk dashboards."
    - name: "vulnerability_type"
      expr: vulnerability_type
      comment: "Technical category of vulnerability (e.g. SQL Injection, Misconfiguration, Unpatched Software) — guides remediation strategy."
    - name: "vulnerability_status"
      expr: vulnerability_status
      comment: "Current remediation lifecycle state (Open, In Remediation, Remediated, Accepted) — drives SLA compliance."
    - name: "affected_data_classification"
      expr: affected_data_classification
      comment: "Data classification of systems affected (e.g. Confidential, PII-Beneficiary, Financial) — critical for prioritising remediation of beneficiary-data-bearing systems."
    - name: "exploitability_status"
      expr: exploitability_status
      comment: "Whether the vulnerability is actively exploitable — highest-priority dimension for emergency patching decisions."
    - name: "patch_available"
      expr: patch_available
      comment: "Boolean indicating vendor patch availability — determines whether remediation is actionable immediately."
    - name: "discovery_method"
      expr: discovery_method
      comment: "How the vulnerability was discovered (Scan, Pen Test, Bug Bounty, Incident) — informs investment in detection capabilities."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month vulnerability was discovered — enables trend analysis of new exposure introduction rate."
  measures:
    - name: "total_open_vulnerabilities"
      expr: COUNT(CASE WHEN vulnerability_status NOT IN ('Remediated', 'Closed', 'Accepted') THEN 1 END)
      comment: "Total count of unresolved vulnerabilities. Core KPI for CISO risk posture reporting and donor cybersecurity audits."
    - name: "critical_high_open_vulnerabilities"
      expr: COUNT(CASE WHEN severity_rating IN ('Critical', 'High') AND vulnerability_status NOT IN ('Remediated', 'Closed', 'Accepted') THEN 1 END)
      comment: "Open Critical and High severity vulnerabilities. Zero-tolerance target for systems processing beneficiary PII or financial data."
    - name: "avg_cvss_score"
      expr: AVG(CAST(cvss_score AS DOUBLE))
      comment: "Average CVSS score across all vulnerabilities. Tracks overall technical risk severity of the vulnerability portfolio."
    - name: "max_cvss_score"
      expr: MAX(cvss_score)
      comment: "Highest CVSS score in the active vulnerability portfolio. Flags worst-case exposure for executive risk briefings."
    - name: "exploitable_vulnerability_count"
      expr: COUNT(CASE WHEN exploitability_status IN ('Exploitable', 'Actively Exploited') THEN 1 END)
      comment: "Count of vulnerabilities with confirmed exploitability. Drives emergency patching prioritisation and incident response readiness."
    - name: "patchable_open_vulnerability_count"
      expr: COUNT(CASE WHEN patch_available = TRUE AND vulnerability_status NOT IN ('Remediated', 'Closed') THEN 1 END)
      comment: "Open vulnerabilities with an available patch. Measures actionable remediation backlog — high counts indicate patch management process failure."
    - name: "remediation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vulnerability_status IN ('Remediated', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all vulnerabilities that have been remediated. Primary KPI for measuring security programme effectiveness."
    - name: "beneficiary_data_at_risk_count"
      expr: COUNT(CASE WHEN affected_data_classification IN ('PII-Beneficiary', 'Confidential', 'Restricted') THEN 1 END)
      comment: "Vulnerabilities affecting systems classified as holding beneficiary PII or sensitive data. Directly linked to humanitarian data protection obligations and donor audit requirements."
    - name: "workaround_available_count"
      expr: COUNT(CASE WHEN workaround_available = TRUE AND vulnerability_status NOT IN ('Remediated', 'Closed') THEN 1 END)
      comment: "Open vulnerabilities with a documented workaround. Indicates interim risk mitigation capacity while permanent patches are applied."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset lifecycle and financial KPIs for NGO asset management. Tracks procurement investment, depreciation exposure, warranty coverage, and lifecycle status across field and HQ assets. Supports donor asset reporting, audit compliance, and capital planning decisions. Relevant to ICON procurement and SAP asset management integrations."
  source: "`vibe_ngo_v1`.`technology`.`it_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of IT asset (Laptop, Server, Network Equipment, Mobile Device) — primary classification for asset portfolio analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Broader asset category grouping for capital planning and budget allocation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage (Active, In Repair, Decommissioned, Disposed) — drives refresh planning and disposal compliance."
    - name: "asset_condition"
      expr: asset_condition
      comment: "Physical condition rating — informs maintenance prioritisation and insurance valuation."
    - name: "assigned_country_code"
      expr: assigned_country_code
      comment: "Country where asset is deployed — enables geographic asset distribution analysis for field operations planning."
    - name: "assigned_location_type"
      expr: assigned_location_type
      comment: "Location type (HQ, Country Office, Field Site) — critical for understanding asset distribution across operational tiers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of procurement cost — required for multi-currency asset valuation consolidation."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation methodology applied — relevant for financial reporting and donor asset accountability."
    - name: "procurement_year"
      expr: DATE_TRUNC('YEAR', procurement_date)
      comment: "Year of asset procurement — enables cohort analysis of asset age and refresh cycle planning."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total IT asset count. Baseline for asset density analysis and per-staff asset ratio benchmarking."
    - name: "total_procurement_cost"
      expr: SUM(CAST(procurement_cost AS DOUBLE))
      comment: "Total capital invested in IT assets. Core KPI for technology budget accountability and donor asset reporting."
    - name: "avg_procurement_cost"
      expr: AVG(CAST(procurement_cost AS DOUBLE))
      comment: "Average procurement cost per asset. Benchmarks unit costs for procurement efficiency and vendor negotiation."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Aggregate salvage value of the asset portfolio. Informs disposal planning and net book value calculations."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of assets in active service. Denominator for utilisation and per-asset cost metrics."
    - name: "decommissioned_asset_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Decommissioned' THEN 1 END)
      comment: "Count of decommissioned assets pending disposal. High counts indicate disposal process bottlenecks with potential donor compliance risk."
    - name: "warranty_expired_active_asset_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' AND warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Active assets operating beyond warranty coverage. Quantifies uninsured maintenance risk and drives refresh budget requests."
    - name: "support_contract_expired_count"
      expr: COUNT(CASE WHEN support_expiry_date < CURRENT_DATE() AND lifecycle_status = 'Active' THEN 1 END)
      comment: "Active assets with expired support contracts. Indicates operational risk from unsupported systems — critical for field connectivity and programme delivery."
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), procurement_date) / 365.25)
      comment: "Average age of active assets in years. Drives technology refresh cycle planning and capital budget forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license compliance and cost management KPIs. Tracks license utilisation, compliance status, renewal exposure, and cost efficiency across the NGO software portfolio including SAP, Salesforce, DHIS2, and other platforms. Supports donor audit readiness and IT cost optimisation. NOTE: license_owner_name is PII-tagged (pii_staff) per VREQ-055 — mask in non-prod environments."
  source: "`vibe_ngo_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "License model (Perpetual, Subscription, Named User, Concurrent) — determines renewal risk and cost structure."
    - name: "license_status"
      expr: license_status
      comment: "Current license status (Active, Expired, Pending Renewal, Cancelled) — drives compliance and renewal action."
    - name: "compliance_status"
      expr: compliance_status
      comment: "License compliance state (Compliant, Over-licensed, Under-licensed) — critical for audit risk management."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (Cloud/SaaS, On-Premise, Hybrid) — informs infrastructure cost allocation strategy."
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Business domain served by the licensed software — enables domain-level software cost allocation."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Software vendor — supports vendor spend consolidation and negotiation leverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of license cost — required for multi-currency cost consolidation."
    - name: "is_mission_critical"
      expr: is_mission_critical
      comment: "Boolean flag for mission-critical software — prioritises renewal and continuity planning."
    - name: "renewal_year"
      expr: DATE_TRUNC('YEAR', renewal_date)
      comment: "Year of license renewal — enables forward-looking renewal budget planning."
  measures:
    - name: "total_annual_license_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual software license spend. Primary KPI for IT budget management and vendor cost optimisation."
    - name: "avg_cost_per_seat"
      expr: AVG(CAST(cost_per_seat AS DOUBLE))
      comment: "Average cost per licensed seat. Benchmarks unit economics for vendor negotiation and license model optimisation."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND license_status = 'Active' THEN 1 END)
      comment: "Active licenses expiring within 90 days. Drives renewal pipeline management and prevents service disruption."
    - name: "non_compliant_license_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant') THEN 1 END)
      comment: "Count of licenses in non-compliant state. Non-zero values create audit risk and potential vendor penalty exposure."
    - name: "auto_renewal_enabled_count"
      expr: COUNT(CASE WHEN auto_renewal_enabled = TRUE THEN 1 END)
      comment: "Licenses with auto-renewal enabled. Monitors uncontrolled spend commitments requiring procurement oversight."
    - name: "mission_critical_license_count"
      expr: COUNT(CASE WHEN is_mission_critical = TRUE THEN 1 END)
      comment: "Count of mission-critical software licenses. Ensures continuity planning coverage for operationally essential systems."
    - name: "overdue_audit_license_count"
      expr: COUNT(CASE WHEN last_audit_date < DATE_ADD(CURRENT_DATE(), -365) AND license_status = 'Active' THEN 1 END)
      comment: "Active licenses not audited in the past 12 months. Indicates compliance programme gaps requiring remediation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_access_provisioning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity and access management KPIs tracking provisioning compliance, privileged access exposure, and access review currency. Critical for donor cybersecurity audits, PSEA data protection requirements, and JML (Joiner-Mover-Leaver) lifecycle governance across NGO systems including SAP, Salesforce, DHIS2, and Primero."
  source: "`vibe_ngo_v1`.`technology`.`access_provisioning`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of access provisioning request (New Access, Modification, Deprovisioning) — drives JML process compliance analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the provisioning request — identifies bottlenecks in the access approval workflow."
    - name: "jml_lifecycle_stage"
      expr: jml_lifecycle_stage
      comment: "Joiner-Mover-Leaver lifecycle stage — critical for detecting orphaned accounts and access creep."
    - name: "data_classification_access_level"
      expr: data_classification_access_level
      comment: "Data classification tier of the access granted — enables risk-stratified access governance reporting."
    - name: "target_system_environment"
      expr: target_system_environment
      comment: "Target environment (Production, UAT, Development) — production access requires stricter governance controls."
    - name: "beneficiary_data_access_flag"
      expr: beneficiary_data_access_flag
      comment: "Boolean indicating access to beneficiary PII data — highest sensitivity tier requiring enhanced oversight per humanitarian data protection standards."
    - name: "financial_data_access_flag"
      expr: financial_data_access_flag
      comment: "Boolean indicating access to financial data — relevant for segregation of duties and donor audit compliance."
    - name: "mfa_required"
      expr: multi_factor_authentication_required_flag
      comment: "Whether MFA is required for this access grant — MFA coverage rate is a key cybersecurity KPI."
    - name: "provisioning_month"
      expr: DATE_TRUNC('MONTH', provisioning_completed_timestamp)
      comment: "Month provisioning was completed — enables trend analysis of access provisioning volume and velocity."
  measures:
    - name: "total_provisioning_requests"
      expr: COUNT(1)
      comment: "Total access provisioning requests. Baseline volume KPI for IAM capacity planning."
    - name: "pending_provisioning_requests"
      expr: COUNT(CASE WHEN request_status IN ('Pending', 'Awaiting Approval', 'In Review') THEN 1 END)
      comment: "Provisioning requests not yet completed. Elevated counts indicate approval bottlenecks creating operational access delays."
    - name: "beneficiary_data_access_grants"
      expr: COUNT(CASE WHEN beneficiary_data_access_flag = TRUE THEN 1 END)
      comment: "Count of access grants covering beneficiary PII data. Monitors scope of sensitive data access — critical for humanitarian data protection compliance."
    - name: "donor_audit_flagged_count"
      expr: COUNT(CASE WHEN donor_audit_requirement_flag = TRUE THEN 1 END)
      comment: "Access grants flagged for donor audit requirements. Ensures audit trail completeness for donor cybersecurity reporting."
    - name: "compliance_signoff_pending_count"
      expr: COUNT(CASE WHEN compliance_signoff_required_flag = TRUE AND compliance_signoff_timestamp IS NULL THEN 1 END)
      comment: "Access grants requiring compliance sign-off that have not yet received it. Non-zero values represent open compliance gaps."
    - name: "avg_access_duration_days"
      expr: AVG(CAST(access_duration_days AS DOUBLE))
      comment: "Average duration of access grants in days. Long durations may indicate standing access that should be time-limited per least-privilege principles."
    - name: "overdue_access_review_count"
      expr: COUNT(CASE WHEN access_review_due_date < CURRENT_DATE() AND request_status NOT IN ('Deprovisioned', 'Closed') THEN 1 END)
      comment: "Active access grants with overdue access reviews. Directly indicates access governance programme failures requiring immediate remediation."
    - name: "mfa_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN multi_factor_authentication_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access grants requiring MFA. Core cybersecurity KPI — low coverage rates are a critical finding in donor and regulatory audits."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_system_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "System platform portfolio KPIs tracking operational status, cost, integration complexity, and lifecycle health across the NGO technology stack. Covers platforms including SAP S/4HANA, eTools, DHIS2, Kobo Toolbox, Primero, Salesforce, and Raiser's Edge NXT. Supports CIO portfolio reviews and technology investment decisions."
  source: "`vibe_ngo_v1`.`technology`.`system_platform`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform (ERP, CRM, HMIS, Data Collection, Case Management) — primary portfolio segmentation dimension."
    - name: "platform_status"
      expr: platform_status
      comment: "Operational status (Active, Decommissioning, Planned, Retired) — drives lifecycle management decisions."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (Cloud, On-Premise, Hybrid) — informs infrastructure cost and risk profile."
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Business domain served by the platform — enables domain-level technology investment analysis."
    - name: "hosting_environment"
      expr: hosting_environment
      comment: "Hosting environment (AWS, Azure, On-Premise, Managed Service) — relevant for cloud cost and vendor risk management."
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Highest data classification level hosted on the platform — drives security control and audit requirements."
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "DR tier assigned to the platform — ensures mission-critical systems have appropriate recovery capabilities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of platform cost — required for multi-currency portfolio cost consolidation."
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of system platforms in the portfolio. Baseline for portfolio complexity and rationalisation analysis."
    - name: "active_platform_count"
      expr: COUNT(CASE WHEN platform_status = 'Active' THEN 1 END)
      comment: "Count of actively operational platforms. Denominator for per-platform cost and integration density metrics."
    - name: "total_annual_platform_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost of the platform portfolio. Primary KPI for technology budget management and vendor spend optimisation."
    - name: "avg_annual_platform_cost"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per platform. Benchmarks platform unit economics for rationalisation and consolidation decisions."
    - name: "total_integration_count"
      expr: SUM(CAST(integration_count AS DOUBLE))
      comment: "Total number of integrations across all platforms. High integration counts indicate architectural complexity and change risk."
    - name: "avg_integration_count_per_platform"
      expr: AVG(CAST(integration_count AS DOUBLE))
      comment: "Average integrations per platform. Identifies highly coupled platforms where changes carry disproportionate risk."
    - name: "mobile_enabled_platform_count"
      expr: COUNT(CASE WHEN is_mobile_enabled = TRUE THEN 1 END)
      comment: "Platforms with mobile access capability. Relevant for field operations where staff use mobile devices for data collection and case management."
    - name: "offline_capable_platform_count"
      expr: COUNT(CASE WHEN is_offline_capable = TRUE THEN 1 END)
      comment: "Platforms supporting offline operation. Critical for field deployments in low-connectivity environments — directly impacts programme delivery capability."
    - name: "contract_expiring_within_90_days"
      expr: COUNT(CASE WHEN contract_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND platform_status = 'Active' THEN 1 END)
      comment: "Active platforms with contracts expiring within 90 days. Drives procurement renewal pipeline and prevents unplanned service disruption."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT project portfolio KPIs tracking delivery performance, budget adherence, and strategic alignment across NGO technology investments. Supports CIO portfolio reviews, donor-funded technology project reporting, and programme delivery risk management. Relevant to SAP implementation, DHIS2 rollouts, and digital transformation initiatives."
  source: "`vibe_ngo_v1`.`technology`.`it_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project lifecycle status (Planning, In Progress, On Hold, Completed, Cancelled) — primary portfolio health dimension."
    - name: "project_category"
      expr: project_category
      comment: "Project category (Infrastructure, Application, Security, Data) — enables investment allocation analysis by technology domain."
    - name: "project_type"
      expr: project_type
      comment: "Project type (New Implementation, Upgrade, Migration, Integration) — informs risk profile and resource planning."
    - name: "health_status"
      expr: health_status
      comment: "RAG health status (Green/Amber/Red) — primary executive dashboard dimension for portfolio risk visibility."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level — drives escalation and mitigation resource allocation decisions."
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Delivery approach (Agile, Waterfall, Hybrid) — relevant for capacity planning and milestone tracking."
    - name: "sponsoring_domain"
      expr: sponsoring_domain
      comment: "Business domain sponsoring the project — enables domain-level technology investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of project budget — required for multi-currency portfolio cost consolidation."
    - name: "project_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Planned project start year — enables cohort analysis of project portfolio by vintage."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total IT projects in the portfolio. Baseline for portfolio capacity and resource demand analysis."
    - name: "active_projects"
      expr: COUNT(CASE WHEN project_status = 'In Progress' THEN 1 END)
      comment: "Count of actively executing projects. Drives resource allocation and WIP management decisions."
    - name: "at_risk_projects"
      expr: COUNT(CASE WHEN health_status IN ('Red', 'Amber') THEN 1 END)
      comment: "Projects with Red or Amber health status. Triggers executive intervention and recovery planning."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all IT projects. Core KPI for technology investment portfolio management."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual spend across all IT projects. Compared against budget to assess portfolio cost performance."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across active projects. Indicates overall portfolio delivery velocity."
    - name: "total_integration_count"
      expr: SUM(CAST(integration_count AS DOUBLE))
      comment: "Total integrations being delivered across the project portfolio. High counts indicate architectural complexity and delivery risk."
    - name: "overdue_project_count"
      expr: COUNT(CASE WHEN planned_end_date < CURRENT_DATE() AND project_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Projects past their planned end date without completion. Directly measures delivery schedule performance and resource adequacy."
    - name: "budget_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Aggregate budget variance (actual minus planned) across the portfolio. Negative values indicate under-spend; positive values indicate cost overruns requiring executive action."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_connectivity_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network connectivity performance and outage KPIs for NGO field and country office operations. Tracks uptime, bandwidth utilisation, latency, and outage impact across field sites where connectivity directly affects programme delivery, data collection (Kobo Toolbox), and case management (Primero). Critical for field operations steering and ISP contract management."
  source: "`vibe_ngo_v1`.`technology`.`connectivity_log`"
  dimensions:
    - name: "connection_status"
      expr: connection_status
      comment: "Current connectivity status (Connected, Degraded, Disconnected) — primary operational health dimension."
    - name: "connection_type"
      expr: connection_type
      comment: "Connectivity technology (VSAT, 4G/LTE, Fibre, ADSL) — informs infrastructure investment and redundancy planning."
    - name: "cause_classification"
      expr: cause_classification
      comment: "Root cause category of connectivity issues — drives targeted remediation and ISP accountability."
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority of the affected site — ensures high-priority field sites receive preferential restoration."
    - name: "sla_compliant"
      expr: sla_compliant_flag
      comment: "Boolean indicating whether the connectivity event met SLA targets — primary ISP performance accountability metric."
    - name: "isp_provider_name"
      expr: isp_provider_name
      comment: "Internet service provider — enables ISP performance benchmarking and contract renegotiation decisions."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of connectivity measurement — enables trend analysis of network performance over time."
  measures:
    - name: "total_outage_events"
      expr: COUNT(CASE WHEN connection_status = 'Disconnected' THEN 1 END)
      comment: "Total connectivity outage events. Baseline KPI for network reliability and field operations continuity."
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total cumulative outage duration in minutes. Quantifies operational impact of connectivity failures on programme delivery."
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average duration per outage event. Benchmarks ISP restoration performance and informs SLA target setting."
    - name: "avg_download_speed_mbps"
      expr: AVG(CAST(download_speed_mbps AS DOUBLE))
      comment: "Average download bandwidth across all measurements. Tracks whether connectivity meets minimum thresholds for programme applications."
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds. High latency degrades real-time applications (video conferencing, SAP transactions) critical for field operations."
    - name: "avg_packet_loss_percent"
      expr: AVG(CAST(packet_loss_percent AS DOUBLE))
      comment: "Average packet loss percentage. Elevated packet loss indicates network quality degradation affecting data collection and case management systems."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliant_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connectivity events breaching SLA targets. Primary ISP contract performance KPI — high rates trigger penalty clauses and contract reviews."
    - name: "avg_bandwidth_utilisation_percent"
      expr: AVG(CAST(bandwidth_utilization_percent AS DOUBLE))
      comment: "Average bandwidth utilisation as a percentage of capacity. Drives capacity upgrade decisions before saturation impacts programme operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT service desk performance KPIs tracking request volume, resolution efficiency, SLA compliance, and user satisfaction. Supports IT operations management and service quality improvement across NGO staff and field operations. Measures helpdesk effectiveness for systems including SAP, DHIS2, Kobo Toolbox, and Salesforce."
  source: "`vibe_ngo_v1`.`technology`.`service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Category of service request (Password Reset, Software Install, Hardware Issue, Access Request) — drives demand analysis and self-service investment."
    - name: "service_request_status"
      expr: service_request_status
      comment: "Current request lifecycle status — identifies backlog and resolution bottlenecks."
    - name: "priority_level"
      expr: priority_level
      comment: "Request priority tier — ensures high-priority requests receive appropriate resource allocation."
    - name: "assignment_group"
      expr: assignment_group
      comment: "Team responsible for resolving the request — enables team-level workload and performance analysis."
    - name: "resolution_category"
      expr: resolution_category
      comment: "How the request was resolved (Self-Service, Remote Support, On-Site) — informs service delivery model optimisation."
    - name: "sla_breached"
      expr: sla_breach_flag
      comment: "Boolean indicating SLA breach — primary service quality accountability metric."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean indicating the request required escalation — high escalation rates signal first-line capability gaps."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month request was submitted — enables trend analysis of service demand and seasonal patterns."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total service requests received. Baseline demand KPI for IT helpdesk capacity planning."
    - name: "open_service_requests"
      expr: COUNT(CASE WHEN service_request_status NOT IN ('Closed', 'Resolved', 'Cancelled') THEN 1 END)
      comment: "Count of unresolved service requests. Elevated open counts indicate capacity constraints or process bottlenecks."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of requests that breached SLA targets. Primary service quality KPI — high counts trigger process improvement interventions."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests resolved within SLA targets. Core IT service management KPI for executive reporting."
    - name: "avg_time_spent_hours"
      expr: AVG(CAST(time_spent_hours AS DOUBLE))
      comment: "Average staff time invested per service request. Drives efficiency benchmarking and automation investment decisions."
    - name: "total_time_spent_hours"
      expr: SUM(CAST(time_spent_hours AS DOUBLE))
      comment: "Total staff hours consumed by service requests. Quantifies IT support cost and informs self-service investment ROI."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring escalation. High rates indicate first-line resolution capability gaps requiring training investment."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target resolution time in hours across request types. Benchmarks service level commitments for contract and policy review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT change management KPIs tracking change volume, approval governance, implementation success, and CAB effectiveness. Supports ITSM governance, risk management, and operational stability across NGO technology platforms. High-risk changes to SAP, DHIS2, and Primero require rigorous CAB oversight to protect programme data integrity."
  source: "`vibe_ngo_v1`.`technology`.`change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Change classification (Standard, Normal, Emergency) — drives approval workflow and risk assessment requirements."
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current change lifecycle status — tracks pipeline from submission through implementation to closure."
    - name: "change_category"
      expr: change_category
      comment: "Functional category of the change (Infrastructure, Application, Security, Configuration) — enables domain-level change risk analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the change — primary dimension for CAB prioritisation and approval authority routing."
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "CAB approval decision (Approved, Rejected, Deferred) — measures governance process effectiveness."
    - name: "downtime_required"
      expr: downtime_required
      comment: "Boolean indicating whether the change requires system downtime — drives scheduling and stakeholder communication."
    - name: "post_implementation_review_completed"
      expr: post_implementation_review_completed
      comment: "Boolean indicating PIR completion — measures change management process maturity."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month change was submitted — enables trend analysis of change velocity and seasonal patterns."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total change requests submitted. Baseline volume KPI for change management capacity planning."
    - name: "emergency_change_count"
      expr: COUNT(CASE WHEN change_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency changes. High emergency change rates indicate poor change planning and elevated operational risk."
    - name: "emergency_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_type = 'Emergency' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes classified as emergency. Industry benchmark is below 5% — higher rates signal reactive IT operations culture."
    - name: "cab_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cab_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN cab_approval_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of CAB-reviewed changes that received approval. Low rates indicate poor change quality or misaligned risk appetite."
    - name: "post_implementation_review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_implementation_review_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN change_request_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed changes with completed post-implementation reviews. Measures change management process maturity and learning culture."
    - name: "high_risk_change_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of high and critical risk changes. Drives executive awareness and enhanced oversight requirements."
    - name: "downtime_required_change_count"
      expr: COUNT(CASE WHEN downtime_required = TRUE THEN 1 END)
      comment: "Changes requiring system downtime. Informs maintenance window scheduling and stakeholder impact communication."
    - name: "open_change_count"
      expr: COUNT(CASE WHEN change_request_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of changes not yet closed. Elevated open counts indicate implementation backlogs or governance delays."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_security_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security assessment programme KPIs tracking assessment coverage, findings severity, remediation progress, and compliance posture. Critical for CISO reporting, donor cybersecurity audit requirements, and compliance with ISO 27001, NIST CSF, and humanitarian data protection standards. Covers assessments of systems processing beneficiary PII, financial data, and safeguarding records."
  source: "`vibe_ngo_v1`.`technology`.`security_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of security assessment (Penetration Test, Vulnerability Scan, Audit, Risk Assessment) — drives methodology and scope analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current assessment lifecycle status — tracks assessment pipeline from planning through reporting."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Aggregate risk rating from the assessment — primary executive risk posture dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination from the assessment — directly informs donor reporting and regulatory obligations."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of finding remediation — tracks whether identified risks are being addressed within target timelines."
    - name: "donor_reporting_required"
      expr: donor_reporting_required
      comment: "Boolean indicating donor reporting obligation — ensures assessment results are communicated to relevant donors."
    - name: "data_classification_assessed"
      expr: data_classification_assessed
      comment: "Data classification tier of systems assessed — prioritises assessments covering highest-sensitivity data."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of assessment — enables annual assessment coverage and trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total security assessments conducted. Baseline for assessment programme coverage and frequency analysis."
    - name: "total_assessment_cost"
      expr: SUM(CAST(assessment_cost AS DOUBLE))
      comment: "Total investment in security assessments. Supports security programme budget justification and ROI analysis."
    - name: "avg_assessment_cost"
      expr: AVG(CAST(assessment_cost AS DOUBLE))
      comment: "Average cost per security assessment. Benchmarks assessment procurement efficiency and vendor pricing."
    - name: "overdue_reassessment_count"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Systems with overdue security reassessments. Non-zero values indicate assessment programme gaps creating undetected risk exposure."
    - name: "donor_reporting_required_count"
      expr: COUNT(CASE WHEN donor_reporting_required = TRUE THEN 1 END)
      comment: "Assessments with donor reporting obligations. Ensures compliance with donor cybersecurity reporting requirements."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Assessments resulting in High or Critical overall risk ratings. Drives prioritised remediation investment and executive escalation."
    - name: "remediation_overdue_count"
      expr: COUNT(CASE WHEN remediation_deadline < CURRENT_DATE() AND remediation_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Assessments with overdue remediation deadlines. Directly measures security programme execution effectiveness and residual risk exposure."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Passed') THEN 1 END)
      comment: "Assessments resulting in non-compliant findings. Triggers mandatory remediation and donor notification workflows."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_platform_integration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Platform integration health and performance KPIs tracking data flow reliability, SLA compliance, and integration portfolio risk. Critical for ensuring data integrity across NGO systems including SAP-to-DHIS2 financial reporting flows, Kobo Toolbox-to-Primero case data transfers, and eTools-to-grant management integrations. Supports enterprise architecture governance and data quality assurance."
  source: "`vibe_ngo_v1`.`technology`.`platform_integration`"
  dimensions:
    - name: "integration_status"
      expr: integration_status
      comment: "Current operational status of the integration (Active, Degraded, Failed, Decommissioned) — primary health monitoring dimension."
    - name: "data_direction"
      expr: data_direction
      comment: "Direction of data flow (Inbound, Outbound, Bidirectional) — informs data lineage and impact analysis."
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data classification of information flowing through the integration — highest-sensitivity integrations require enhanced monitoring."
    - name: "data_domain"
      expr: data_domain
      comment: "Business domain of data being integrated — enables domain-level integration risk analysis."
    - name: "encryption_in_transit"
      expr: encryption_in_transit_flag
      comment: "Boolean indicating encryption of data in transit — critical security control for integrations carrying PII or financial data."
    - name: "monitoring_enabled"
      expr: monitoring_enabled_flag
      comment: "Boolean indicating active monitoring — unmonitored integrations represent blind spots in operational risk management."
    - name: "schedule_frequency"
      expr: schedule_frequency
      comment: "Integration execution frequency (Real-time, Hourly, Daily, Weekly) — informs data freshness and latency expectations."
  measures:
    - name: "total_integrations"
      expr: COUNT(1)
      comment: "Total platform integrations in the portfolio. Baseline for integration complexity and architectural risk analysis."
    - name: "active_integrations"
      expr: COUNT(CASE WHEN integration_status = 'Active' THEN 1 END)
      comment: "Count of actively operational integrations. Denominator for health and performance rate calculations."
    - name: "failed_integrations"
      expr: COUNT(CASE WHEN integration_status = 'Failed' THEN 1 END)
      comment: "Count of integrations in failed state. Non-zero values indicate data flow disruptions requiring immediate remediation."
    - name: "avg_success_rate_percent"
      expr: AVG(CAST(success_rate_percent AS DOUBLE))
      comment: "Average integration success rate across the portfolio. Below 99% indicates systemic reliability issues affecting data quality."
    - name: "total_records_transferred"
      expr: SUM(CAST(total_records_transferred AS DOUBLE))
      comment: "Total records transferred across all integrations. Quantifies data flow volume for capacity planning and audit trail completeness."
    - name: "unmonitored_active_integration_count"
      expr: COUNT(CASE WHEN monitoring_enabled_flag = FALSE AND integration_status = 'Active' THEN 1 END)
      comment: "Active integrations without monitoring enabled. Represents operational blind spots — critical risk for integrations carrying beneficiary or financial data."
    - name: "unencrypted_active_integration_count"
      expr: COUNT(CASE WHEN encryption_in_transit_flag = FALSE AND integration_status = 'Active' THEN 1 END)
      comment: "Active integrations without encryption in transit. Security control gap — particularly critical for integrations carrying PII, financial, or safeguarding data."
    - name: "avg_sla_target_percent"
      expr: AVG(CAST(sla_target_percent AS DOUBLE))
      comment: "Average SLA uptime target across integrations. Benchmarks service level commitments for integration portfolio governance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_backup_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data backup and recovery readiness KPIs tracking backup coverage, verification success, storage utilisation, and disaster recovery posture. Critical for business continuity planning, donor data protection requirements, and compliance with humanitarian data governance standards. Covers backup of SAP, DHIS2, Primero, and other mission-critical NGO systems. NOTE: technical_owner_name is PII-tagged (pii_staff) per VREQ-055 — mask in non-prod environments."
  source: "`vibe_ngo_v1`.`technology`.`backup_schedule`"
  dimensions:
    - name: "backup_type"
      expr: backup_type
      comment: "Backup type (Full, Incremental, Differential) — determines recovery completeness and storage efficiency."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current schedule status (Active, Suspended, Failed) — primary operational health dimension."
    - name: "last_backup_status"
      expr: last_backup_status
      comment: "Outcome of the most recent backup execution (Success, Failed, Partial) — immediate operational health indicator."
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data classification of assets being backed up — highest-classification assets require most rigorous backup governance."
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "DR tier of the backup schedule — Tier 1 assets require most aggressive RPO/RTO targets."
    - name: "storage_location_type"
      expr: storage_location_type
      comment: "Backup storage location type (On-Site, Off-Site, Cloud) — informs geographic redundancy and disaster recovery posture."
    - name: "encryption_enabled"
      expr: encryption_enabled_flag
      comment: "Boolean indicating backup encryption — critical control for backups containing beneficiary PII or financial data."
    - name: "offsite_copy_flag"
      expr: offsite_copy_flag
      comment: "Boolean indicating off-site backup copy existence — required for disaster recovery and donor data protection compliance."
  measures:
    - name: "total_backup_schedules"
      expr: COUNT(1)
      comment: "Total backup schedules configured. Baseline for backup coverage analysis."
    - name: "failed_backup_count"
      expr: COUNT(CASE WHEN last_backup_status = 'Failed' THEN 1 END)
      comment: "Count of schedules with most recent backup failure. Non-zero values represent immediate data protection gaps requiring remediation."
    - name: "backup_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_backup_status = 'Success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of backup schedules with successful last execution. Core data protection KPI — below 99% triggers immediate investigation."
    - name: "unencrypted_backup_count"
      expr: COUNT(CASE WHEN encryption_enabled_flag = FALSE AND schedule_status = 'Active' THEN 1 END)
      comment: "Active backup schedules without encryption. Security control gap — particularly critical for backups of beneficiary PII and financial data."
    - name: "no_offsite_copy_count"
      expr: COUNT(CASE WHEN offsite_copy_flag = FALSE AND schedule_status = 'Active' THEN 1 END)
      comment: "Active backup schedules without off-site copies. Disaster recovery gap — systems without off-site backups cannot meet RTO/RPO targets in site-loss scenarios."
    - name: "total_storage_capacity_gb"
      expr: SUM(CAST(storage_capacity_gb AS DOUBLE))
      comment: "Total backup storage capacity in GB. Drives storage procurement planning and capacity management."
    - name: "total_last_backup_size_gb"
      expr: SUM(CAST(last_backup_size_gb AS DOUBLE))
      comment: "Total size of most recent backups in GB. Monitors storage consumption trends and informs capacity expansion decisions."
    - name: "avg_compression_ratio"
      expr: AVG(CAST(compression_ratio AS DOUBLE))
      comment: "Average backup compression ratio. Measures storage efficiency of backup infrastructure — informs compression technology investment."
    - name: "overdue_restore_test_count"
      expr: COUNT(CASE WHEN last_restore_test_date < DATE_ADD(CURRENT_DATE(), -365) AND schedule_status = 'Active' THEN 1 END)
      comment: "Active backup schedules not tested for restore in over 12 months. Untested backups cannot be relied upon for disaster recovery — critical compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_user_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User account security posture, access governance, and compliance metrics for identity and access management"
  source: "`vibe_ngo_v1`.`technology`.`user_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the user account"
    - name: "account_type"
      expr: account_type
      comment: "Type of user account (employee, contractor, service, partner)"
    - name: "access_level"
      expr: access_level
      comment: "Access level granted to the account"
    - name: "privileged_account_flag"
      expr: privileged_account_flag
      comment: "Whether the account has privileged access rights"
    - name: "mfa_enrolled_flag"
      expr: mfa_enrolled_flag
      comment: "Whether multi-factor authentication is enrolled"
    - name: "beneficiary_data_access_flag"
      expr: beneficiary_data_access_flag
      comment: "Whether the account has access to beneficiary data"
    - name: "donor_data_access_flag"
      expr: donor_data_access_flag
      comment: "Whether the account has access to donor data"
    - name: "financial_system_access_flag"
      expr: financial_system_access_flag
      comment: "Whether the account has access to financial systems"
    - name: "remote_access_enabled_flag"
      expr: remote_access_enabled_flag
      comment: "Whether remote access is enabled for the account"
    - name: "field_access_flag"
      expr: field_access_flag
      comment: "Whether the account has field location access"
    - name: "account_locked_flag"
      expr: account_locked_flag
      comment: "Whether the account is currently locked"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month when the account was activated"
  measures:
    - name: "total_user_accounts"
      expr: COUNT(1)
      comment: "Total number of user accounts provisioned"
    - name: "active_accounts_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active user accounts"
    - name: "privileged_accounts_count"
      expr: SUM(CASE WHEN privileged_account_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of privileged accounts requiring enhanced monitoring"
    - name: "mfa_enrolled_accounts_count"
      expr: SUM(CASE WHEN mfa_enrolled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with multi-factor authentication enrolled"
    - name: "beneficiary_data_access_accounts_count"
      expr: SUM(CASE WHEN beneficiary_data_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with beneficiary data access requiring safeguarding compliance"
    - name: "donor_data_access_accounts_count"
      expr: SUM(CASE WHEN donor_data_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with donor data access requiring audit compliance"
    - name: "financial_system_access_accounts_count"
      expr: SUM(CASE WHEN financial_system_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with financial system access requiring segregation of duties review"
    - name: "remote_access_accounts_count"
      expr: SUM(CASE WHEN remote_access_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with remote access enabled"
    - name: "locked_accounts_count"
      expr: SUM(CASE WHEN account_locked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of locked accounts requiring investigation or unlock"
    - name: "avg_failed_login_attempts"
      expr: AVG(CAST(failed_login_attempts AS DOUBLE))
      comment: "Average failed login attempts per account indicating potential security issues"
$$;