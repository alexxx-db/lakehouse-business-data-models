-- Metric views for domain: compliance | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for accreditation programs — measures accreditation status, completion rates, survey scheduling, and risk levels to govern NCQA, URAC, and other accreditation program performance."
  source: "`vibe_health_insurance_v1`.`compliance`.`accreditation_program`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., NCQA, URAC, AAAHC) — different accreditation bodies have different standards and renewal cycles."
    - name: "accreditation_program_status"
      expr: accreditation_program_status
      comment: "Current status of the accreditation program (e.g., active, expired, under review) for portfolio management."
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Accrediting body overseeing the program — enables body-specific compliance tracking and reporting."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the accreditation — enables area-specific accreditation investment analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the accreditation program — high-risk programs require priority management attention."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the accreditation program is currently active."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Flag indicating the accreditation program has been escalated — signals compliance risk requiring executive attention."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of accreditation survey (e.g., initial, renewal, focused) — informs survey preparation resource planning."
  measures:
    - name: "total_accreditation_programs"
      expr: COUNT(1)
      comment: "Total number of accreditation programs — baseline measure for accreditation portfolio breadth."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all accreditation programs — measures overall accreditation readiness and preparation progress."
    - name: "avg_final_score"
      expr: AVG(CAST(final_score AS DOUBLE))
      comment: "Average final accreditation score — primary quality indicator for accreditation program performance reported to the board."
    - name: "active_accreditation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active accreditation programs — measures live accreditation coverage for regulatory and market credibility."
    - name: "escalated_program_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated accreditation programs — tracks high-risk accreditation situations requiring executive intervention."
    - name: "programs_with_upcoming_survey"
      expr: COUNT(CASE WHEN next_survey_due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of accreditation programs with a survey due within 90 days — drives proactive survey preparation resource allocation."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk accreditation programs — prioritizes executive attention and remediation investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for compliance audit engagements — tracks audit volume, cost efficiency, remediation velocity, and risk exposure across the organization."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external, regulatory) for segmenting audit activity."
    - name: "audit_category"
      expr: audit_category
      comment: "Business category of the audit engagement for domain-level analysis."
    - name: "audit_engagement_status"
      expr: audit_engagement_status
      comment: "Current lifecycle status of the audit engagement (e.g., in-progress, closed, pending)."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit engagement — used to prioritize remediation resources."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the audit (e.g., pass, fail, conditional) for executive reporting."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation activities following audit findings."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or compliance framework under which the audit was conducted (e.g., HIPAA, CMS)."
    - name: "engagement_start_year_month"
      expr: DATE_TRUNC('month', engagement_start_date)
      comment: "Month the audit engagement started — enables trend analysis of audit activity over time."
    - name: "audit_period_start_year"
      expr: YEAR(audit_period_start)
      comment: "Year of the audit period start — supports annual compliance cycle reporting."
  measures:
    - name: "total_audit_engagements"
      expr: COUNT(1)
      comment: "Total number of audit engagements — baseline volume metric for compliance program capacity planning."
    - name: "total_audit_cost_actual"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual cost incurred across all audit engagements — drives compliance budget management and cost-efficiency decisions."
    - name: "total_audit_cost_estimate"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated cost for audit engagements — used to compare against actuals for budget variance analysis."
    - name: "avg_audit_cost_actual"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average actual cost per audit engagement — benchmarks audit efficiency and identifies cost outliers."
    - name: "audit_cost_variance"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE) - CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total cost variance (actual minus estimate) across all audits — signals budget discipline and estimation accuracy."
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Number of audit engagements requiring follow-up action — key indicator of unresolved compliance risk."
    - name: "followup_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up — high rates signal systemic compliance gaps demanding executive attention."
    - name: "open_audit_engagements"
      expr: COUNT(CASE WHEN audit_engagement_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of currently open audit engagements — tracks compliance program workload and backlog."
    - name: "high_risk_audit_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risk-rated audit engagements — prioritizes executive escalation and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance audit findings — measures severity distribution, financial impact, remediation performance, and repeat-finding rates to drive corrective action prioritization."
  source: "`vibe_health_insurance_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the audit finding (e.g., control deficiency, policy violation) for root-cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the finding (e.g., critical, significant, minor) — drives remediation prioritization."
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (e.g., open, in-remediation, closed) for workload tracking."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken against the finding — measures remediation execution."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance domain area where the finding was identified (e.g., HIPAA, billing) for targeted improvement."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit that produced this finding — enables cross-audit trend analysis."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this is a repeat finding from a prior audit cycle — signals persistent control failures."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical findings requiring immediate executive escalation."
    - name: "identified_year_month"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month the finding was identified — supports trend analysis of finding emergence over time."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline measure for compliance program health and audit rigor."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all audit findings — quantifies monetary exposure from compliance gaps for CFO and board reporting."
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per audit finding — benchmarks severity and informs risk-based audit prioritization."
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical audit findings — primary executive escalation metric for compliance risk management."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings from prior audit cycles — indicates systemic control failures requiring structural remediation."
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats — high rates signal ineffective corrective action programs and persistent compliance risk."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN audit_finding_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Number of currently open audit findings — tracks unresolved compliance exposure requiring active management."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_completion_date IS NULL AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of findings with overdue corrective actions — directly signals SLA breach risk and regulatory exposure."
    - name: "critical_financial_impact"
      expr: SUM(CASE WHEN is_critical = TRUE THEN financial_impact_amount ELSE 0 END)
      comment: "Total financial impact attributable to critical findings only — focuses executive attention on highest-risk monetary exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_baa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Business Associate Agreements (BAAs) — measures BAA portfolio health, active coverage, subcontractor risk, and renewal management to ensure HIPAA business associate compliance."
  source: "`vibe_health_insurance_v1`.`compliance`.`baa`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the BAA (e.g., active, expired, terminated) for portfolio management."
    - name: "business_associate_type"
      expr: business_associate_type
      comment: "Type of business associate (e.g., vendor, contractor, subcontractor) — informs risk-based BAA oversight."
    - name: "subcontractor_allowed"
      expr: subcontractor_allowed
      comment: "Flag indicating whether the BAA permits subcontractors — subcontractor chains extend HIPAA liability."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the BAA is currently active — inactive BAAs with ongoing vendor relationships are HIPAA violations."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction governing the BAA — enables multi-state compliance analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the BAA became effective — supports BAA portfolio vintage analysis."
  measures:
    - name: "total_baas"
      expr: COUNT(1)
      comment: "Total number of Business Associate Agreements — baseline measure for HIPAA BAA compliance portfolio scale."
    - name: "active_baa_count"
      expr: COUNT(CASE WHEN is_active = TRUE AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active BAAs — measures live HIPAA business associate coverage."
    - name: "active_baa_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE AND agreement_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BAAs that are currently active — low rates signal expired BAA risk requiring immediate remediation."
    - name: "expired_baa_count"
      expr: COUNT(CASE WHEN agreement_status IN ('Expired', 'Terminated') OR effective_end_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of expired or terminated BAAs — expired BAAs with ongoing vendor relationships are HIPAA violations requiring immediate action."
    - name: "subcontractor_allowed_baa_count"
      expr: COUNT(CASE WHEN subcontractor_allowed = TRUE THEN 1 END)
      comment: "Number of BAAs permitting subcontractors — tracks extended HIPAA liability chain exposure."
    - name: "distinct_business_associates"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct business associates covered by BAAs — measures breadth of HIPAA business associate oversight."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HIPAA and data breach incidents — measures breach volume, notification compliance, regulatory filing timeliness, and risk exposure to drive breach response program effectiveness."
  source: "`vibe_health_insurance_v1`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach (e.g., unauthorized access, theft, improper disposal) for root-cause and prevention analysis."
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach incident (e.g., open, under investigation, resolved) for workload tracking."
    - name: "breach_source"
      expr: breach_source
      comment: "Source of the breach (e.g., internal, vendor, cyber) — informs targeted prevention investments."
    - name: "business_associate_involved"
      expr: business_associate_involved
      comment: "Flag indicating whether a business associate (BAA partner) was involved — triggers specific HIPAA notification obligations."
    - name: "hhs_notified"
      expr: hhs_notified
      comment: "Flag indicating whether HHS was notified — measures regulatory notification compliance."
    - name: "state_notified"
      expr: state_notified
      comment: "Flag indicating whether state regulators were notified — tracks multi-jurisdictional notification compliance."
    - name: "breach_discovery_year_month"
      expr: DATE_TRUNC('month', breach_discovery_date)
      comment: "Month the breach was discovered — enables trend analysis of breach frequency over time."
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Status of regulatory filing for the breach — tracks compliance with mandatory reporting deadlines."
  measures:
    - name: "total_breach_incidents"
      expr: COUNT(1)
      comment: "Total number of breach incidents — baseline measure for HIPAA breach program scale and organizational risk exposure."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach incidents — measures overall breach severity and informs resource prioritization."
    - name: "hhs_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches where HHS was notified — critical regulatory compliance KPI; failure triggers CMS enforcement actions."
    - name: "state_notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN state_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches where state regulators were notified — measures multi-jurisdictional notification compliance."
    - name: "business_associate_breach_count"
      expr: COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END)
      comment: "Number of breaches involving business associates — drives BAA oversight and vendor risk management decisions."
    - name: "business_associate_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches attributable to business associates — high rates signal vendor oversight failures requiring contract and audit action."
    - name: "open_breach_incident_count"
      expr: COUNT(CASE WHEN breach_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Number of currently open breach incidents — tracks unresolved regulatory exposure requiring active management."
    - name: "regulatory_filing_overdue_count"
      expr: COUNT(CASE WHEN regulatory_filing_status NOT IN ('Filed', 'Accepted', 'Completed') AND regulatory_filing_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of breach incidents with overdue regulatory filings — directly measures HIPAA deadline compliance failure risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_breach_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for breach notification execution — measures notification timeliness, deadline compliance, and delivery confirmation rates to ensure HIPAA 60-day notification rule adherence."
  source: "`vibe_health_insurance_v1`.`compliance`.`breach_notification`"
  dimensions:
    - name: "breach_notification_status"
      expr: breach_notification_status
      comment: "Current status of the breach notification (e.g., pending, sent, confirmed) for execution tracking."
    - name: "notification_type"
      expr: notification_type
      comment: "Type of notification (e.g., individual, media, HHS) — different types have different regulatory deadlines."
    - name: "notification_method"
      expr: notification_method
      comment: "Delivery method used for notification (e.g., mail, email, substitute notice) — informs channel effectiveness analysis."
    - name: "deadline_met"
      expr: deadline_met
      comment: "Flag indicating whether the notification deadline was met — primary HIPAA compliance indicator."
    - name: "delivery_confirmation"
      expr: delivery_confirmation
      comment: "Flag indicating delivery was confirmed — measures notification program execution quality."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the notification — used for regulatory reporting and audit evidence."
    - name: "notification_year_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month the notification was sent — enables trend analysis of breach notification activity."
  measures:
    - name: "total_breach_notifications"
      expr: COUNT(1)
      comment: "Total number of breach notifications issued — baseline measure for breach response program scale."
    - name: "deadline_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deadline_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breach notifications meeting the regulatory deadline — primary HIPAA 60-day rule compliance KPI reported to regulators and the board."
    - name: "delivery_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_confirmation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notifications with confirmed delivery — measures notification program execution quality and evidentiary completeness."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach notifications — measures severity-weighted notification burden."
    - name: "missed_deadline_count"
      expr: COUNT(CASE WHEN deadline_met = FALSE THEN 1 END)
      comment: "Number of notifications that missed the regulatory deadline — each missed deadline is a potential HIPAA violation requiring immediate remediation."
    - name: "unconfirmed_delivery_count"
      expr: COUNT(CASE WHEN delivery_confirmation = FALSE OR delivery_confirmation IS NULL THEN 1 END)
      comment: "Number of notifications without confirmed delivery — unconfirmed deliveries create evidentiary gaps in regulatory defense."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_cap_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for corrective action plan milestones — tracks completion rates, escalation frequency, and on-time delivery to measure remediation execution quality."
  source: "`vibe_health_insurance_v1`.`compliance`.`cap_milestone`"
  dimensions:
    - name: "cap_milestone_status"
      expr: cap_milestone_status
      comment: "Current status of the milestone (e.g., pending, in-progress, completed, overdue) for execution tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., evidence submission, policy update, training) for categorized progress reporting."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the milestone — enables area-specific remediation progress analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the milestone — drives resource allocation for remediation execution."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for milestones on the critical path of remediation — missed critical milestones escalate regulatory risk."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Flag indicating the milestone has been escalated — tracks escalation frequency as a program health indicator."
    - name: "planned_completion_year_month"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month the milestone was planned for completion — supports capacity planning and deadline management."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of CAP milestones — baseline measure for remediation program granularity and workload."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all milestones — provides a real-time progress indicator for the overall remediation program."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN cap_milestone_status IN ('Completed', 'Closed') THEN 1 END)
      comment: "Number of fully completed milestones — measures remediation throughput and program execution velocity."
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cap_milestone_status IN ('Completed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed — primary KPI for corrective action program effectiveness reported to regulators."
    - name: "escalated_milestone_count"
      expr: COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END)
      comment: "Number of escalated milestones — high escalation counts signal execution bottlenecks requiring leadership intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones that required escalation — measures remediation program friction and management effectiveness."
    - name: "critical_milestone_overdue_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND cap_milestone_status NOT IN ('Completed', 'Closed') AND planned_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of overdue critical milestones — highest-priority compliance risk indicator requiring immediate executive action."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_attestation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance attestations — measures attestation volume, active coverage, and linkage to regulatory obligations to ensure workforce compliance certification requirements are met."
  source: "`vibe_health_insurance_v1`.`compliance`.`compliance_attestation`"
  dimensions:
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the attestation is currently active — active attestations represent current compliance certifications."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status of the attestation — used for data governance and attestation portfolio management."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the attestation became effective — enables trend analysis of attestation activity over time."
    - name: "effective_end_year_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the attestation expires — supports proactive renewal management and compliance gap prevention."
  measures:
    - name: "total_attestations"
      expr: COUNT(1)
      comment: "Total number of compliance attestations on record — baseline measure for attestation program scale."
    - name: "active_attestation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active compliance attestations — measures live compliance certification coverage across the workforce."
    - name: "active_attestation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attestations that are currently active — low rates signal compliance certification gaps requiring immediate remediation."
    - name: "attestations_linked_to_obligation"
      expr: COUNT(CASE WHEN regulatory_obligation_id IS NOT NULL THEN 1 END)
      comment: "Number of attestations linked to a specific regulatory obligation — measures attestation traceability to regulatory requirements."
    - name: "obligation_linkage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_obligation_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attestations linked to a regulatory obligation — high linkage rates indicate a well-governed attestation program with clear regulatory traceability."
    - name: "expired_attestation_count"
      expr: COUNT(CASE WHEN effective_end_date < CURRENT_DATE() AND is_active = FALSE THEN 1 END)
      comment: "Number of expired attestations — tracks compliance certification gaps requiring renewal to maintain regulatory standing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for corrective action plans (CAPs) — measures remediation cost, completion rates, overdue plans, and risk reduction effectiveness to steer compliance program execution."
  source: "`vibe_health_insurance_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Current lifecycle status of the CAP (e.g., open, in-progress, closed) for workload management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan — differentiates regulatory-mandated from internally-driven remediation."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the CAP — enables targeted remediation investment by area."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAP — drives resource allocation and escalation decisions."
    - name: "severity"
      expr: severity
      comment: "Severity of the underlying issue driving the CAP — informs risk-based prioritization."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Flag indicating whether the CAP was triggered by an external audit — external CAPs carry higher regulatory stakes."
    - name: "is_fwa_monitoring"
      expr: is_fwa_monitoring
      comment: "Flag for CAPs related to fraud, waste, and abuse monitoring — critical for CMS compliance."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that mandated or is monitoring the CAP — enables regulator-specific compliance reporting."
    - name: "target_completion_year_month"
      expr: DATE_TRUNC('month', target_completion_date)
      comment: "Month the CAP is targeted for completion — supports capacity planning and deadline management."
  measures:
    - name: "total_corrective_action_plans"
      expr: COUNT(1)
      comment: "Total number of corrective action plans — baseline measure for compliance remediation program scale."
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost spent on corrective action remediation — critical for compliance budget management and ROI analysis."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated remediation cost across all CAPs — used for budget forecasting and resource planning."
    - name: "avg_actual_remediation_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per corrective action plan — benchmarks remediation efficiency and identifies cost outliers."
    - name: "remediation_cost_variance"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE) - CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across all CAPs — signals budget discipline and estimation accuracy in compliance programs."
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN corrective_action_plan_status NOT IN ('Closed', 'Completed') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of CAPs past their target completion date — directly measures regulatory deadline risk and program execution failures."
    - name: "overdue_cap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_status NOT IN ('Closed', 'Completed') AND target_completion_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs that are overdue — high rates signal systemic execution failures requiring leadership intervention."
    - name: "fwa_related_cap_count"
      expr: COUNT(CASE WHEN is_fwa_monitoring = TRUE THEN 1 END)
      comment: "Number of CAPs related to fraud, waste, and abuse monitoring — tracks CMS-mandated remediation activity."
    - name: "external_audit_cap_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN 1 END)
      comment: "Number of CAPs triggered by external audits — external CAPs carry highest regulatory risk and require priority tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_erisa_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for ERISA filings — measures filing timeliness, fee costs, rejection rates, and regulatory acknowledgment to ensure DOL compliance for employer-sponsored health plans."
  source: "`vibe_health_insurance_v1`.`compliance`.`erisa_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of ERISA filing (e.g., Form 5500, SAR, SPD) — different filing types have different DOL deadlines and penalties."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the ERISA filing (e.g., pending, submitted, accepted, rejected) for compliance pipeline management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the ERISA filing (e.g., DOL, IRS) — enables regulator-specific compliance tracking."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used for filing (e.g., EFAST2, paper) — informs channel optimization and error rate analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the ERISA filing — high-risk filings require priority compliance attention."
    - name: "regulator_acknowledged_flag"
      expr: regulator_acknowledged_flag
      comment: "Flag indicating the regulator acknowledged receipt — unacknowledged filings may not satisfy the regulatory obligation."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year covered by the ERISA filing — enables year-over-year compliance trend analysis."
    - name: "filing_year_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the ERISA filing was submitted — supports filing cycle management and deadline tracking."
  measures:
    - name: "total_erisa_filings"
      expr: COUNT(1)
      comment: "Total number of ERISA filings — baseline measure for DOL compliance program scale."
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total ERISA filing fees paid — tracks regulatory compliance cost for budget management."
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average ERISA filing fee — benchmarks regulatory cost efficiency and informs budget planning."
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_date <= filing_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN filing_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of ERISA filings submitted on or before the due date — primary DOL compliance KPI; late filings trigger significant per-day penalties."
    - name: "regulator_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulator_acknowledged_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ERISA filings acknowledged by the regulator — unacknowledged filings may not satisfy the legal obligation."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status IN ('Rejected', 'Denied') THEN 1 END)
      comment: "Number of rejected ERISA filings — rejected filings require resubmission and may trigger late penalties if not corrected promptly."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status NOT IN ('Accepted', 'Completed', 'Filed') AND filing_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of ERISA filings past their due date — each overdue filing represents active DOL penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for fraud, waste, and abuse (FWA) cases — measures case volume, financial exposure, recovery rates, and high-risk case concentration to drive SIU and compliance program effectiveness."
  source: "`vibe_health_insurance_v1`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (e.g., fraud, waste, abuse) — enables targeted program investment by category."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the FWA case (e.g., open, under investigation, closed) for workload management."
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition of the case (e.g., substantiated, unsubstantiated, referred to law enforcement) for outcome analysis."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject under investigation (e.g., provider, member, vendor) — informs targeted prevention strategies."
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Flag for high-risk FWA cases requiring priority investigation resources."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the FWA referral (e.g., claims analytics, member complaint, external tip) — measures detection channel effectiveness."
    - name: "case_open_year_month"
      expr: DATE_TRUNC('month', case_open_timestamp)
      comment: "Month the FWA case was opened — enables trend analysis of FWA activity over time."
  measures:
    - name: "total_fwa_cases"
      expr: COUNT(1)
      comment: "Total number of FWA cases — baseline measure for SIU program scale and CMS compliance reporting."
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure across all FWA cases — primary financial risk metric for CFO and compliance leadership."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases — measures SIU program financial effectiveness and ROI."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across FWA cases — measures overall FWA risk concentration in the portfolio."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_exposure_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated exposure recovered — primary SIU program effectiveness KPI; low rates signal investigation or recovery process failures."
    - name: "high_risk_case_count"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Number of high-risk FWA cases — tracks concentration of severe fraud risk requiring priority SIU resources."
    - name: "high_risk_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of FWA cases classified as high-risk — rising rates signal deteriorating fraud environment requiring program investment."
    - name: "open_fwa_case_count"
      expr: COUNT(CASE WHEN case_status NOT IN ('Closed', 'Resolved', 'Completed') THEN 1 END)
      comment: "Number of currently open FWA cases — tracks SIU workload and investigation backlog."
    - name: "regulatory_reporting_case_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of FWA cases requiring regulatory reporting — tracks mandatory CMS and state reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_fwa_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for FWA referrals — measures referral volume, escalation rates, estimated loss exposure, and triage effectiveness to optimize fraud detection and investigation intake."
  source: "`vibe_health_insurance_v1`.`compliance`.`fwa_referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of FWA referral (e.g., fraud, waste, abuse) for category-level program analysis."
    - name: "fwa_referral_status"
      expr: fwa_referral_status
      comment: "Current status of the referral (e.g., pending triage, accepted, rejected) for intake pipeline management."
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral (e.g., claims analytics, hotline, audit) — measures detection channel effectiveness."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject referred (e.g., provider, member, vendor) — informs targeted prevention strategies."
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of the triage process (e.g., opened as case, closed, referred externally) — measures triage quality."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating the referral was escalated — tracks escalation frequency as a severity indicator."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the referral — drives investigation resource allocation."
    - name: "referral_year_month"
      expr: DATE_TRUNC('month', referral_date)
      comment: "Month the referral was submitted — enables trend analysis of FWA referral intake over time."
  measures:
    - name: "total_fwa_referrals"
      expr: COUNT(1)
      comment: "Total number of FWA referrals received — baseline measure for fraud detection program intake volume."
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Total estimated loss amount across all FWA referrals — measures financial exposure entering the investigation pipeline."
    - name: "avg_estimated_loss_per_referral"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated loss per FWA referral — benchmarks referral severity and informs triage prioritization thresholds."
    - name: "escalated_referral_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated FWA referrals — tracks high-severity intake requiring priority investigation resources."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals escalated — rising escalation rates signal increasing fraud severity or detection sensitivity."
    - name: "referral_to_case_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN triage_outcome IN ('Case Opened', 'Accepted', 'Converted') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals converted to active FWA cases — measures triage effectiveness and referral quality."
    - name: "open_referral_count"
      expr: COUNT(CASE WHEN fwa_referral_status NOT IN ('Closed', 'Resolved', 'Rejected') THEN 1 END)
      comment: "Number of currently open FWA referrals — tracks investigation intake backlog and triage capacity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_hipaa_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for HIPAA privacy requests — measures request volume, response timeliness, denial rates, and appeal activity to ensure HIPAA Privacy Rule compliance and member rights fulfillment."
  source: "`vibe_health_insurance_v1`.`compliance`.`hipaa_privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of HIPAA privacy request (e.g., access, amendment, restriction, accounting of disclosures) — different types have different regulatory response deadlines."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the privacy request (e.g., pending, fulfilled, denied) for pipeline management."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the request was received (e.g., portal, mail, phone) — informs channel optimization."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the request (e.g., granted, denied, partially granted) for compliance outcome analysis."
    - name: "is_appealed"
      expr: is_appealed
      comment: "Flag indicating whether the request decision was appealed — high appeal rates signal denial quality issues."
    - name: "is_confidential_communication"
      expr: is_confidential_communication
      comment: "Flag for confidential communication requests — these require special handling under HIPAA."
    - name: "request_received_year_month"
      expr: DATE_TRUNC('month', request_received_timestamp)
      comment: "Month the privacy request was received — enables trend analysis of HIPAA request volume over time."
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy requests received — baseline measure for privacy program scale and member rights activity."
    - name: "on_time_response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_date <= response_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN response_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of privacy requests responded to within the regulatory deadline — primary HIPAA Privacy Rule compliance KPI; late responses are regulatory violations."
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition IN ('Denied', 'Rejected') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy requests denied — high denial rates may signal over-restriction of member rights and regulatory scrutiny risk."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_appealed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privacy request decisions that were appealed — high appeal rates signal denial quality issues and member dissatisfaction."
    - name: "open_request_count"
      expr: COUNT(CASE WHEN request_status NOT IN ('Closed', 'Fulfilled', 'Completed', 'Denied') THEN 1 END)
      comment: "Number of currently open HIPAA privacy requests — tracks compliance workload and response capacity."
    - name: "overdue_request_count"
      expr: COUNT(CASE WHEN request_status NOT IN ('Closed', 'Fulfilled', 'Completed', 'Denied') AND response_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of privacy requests past their regulatory response deadline — each overdue request is a potential HIPAA violation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Medical Loss Ratio (MLR) calculations — measures MLR compliance, rebate obligations, and premium-to-claims ratios to ensure ACA Section 2718 compliance and inform pricing strategy."
  source: "`vibe_health_insurance_v1`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "mlr_calculation_status"
      expr: mlr_calculation_status
      comment: "Status of the MLR calculation (e.g., draft, final, submitted) for reporting lifecycle management."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g., individual, small group, large group) — ACA MLR thresholds differ by market segment."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for MLR calculation — drives regulatory threshold applicability."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Plan year for which MLR is being calculated — enables year-over-year compliance trend analysis."
    - name: "rebate_eligibility_flag"
      expr: rebate_eligibility_flag
      comment: "Flag indicating whether a rebate is owed — triggers rebate disbursement obligations under ACA."
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement — tracks fulfillment of ACA rebate obligations."
    - name: "calculation_year_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month the MLR calculation was performed — supports calculation cycle management."
  measures:
    - name: "total_mlr_calculations"
      expr: COUNT(1)
      comment: "Total number of MLR calculations performed — baseline measure for MLR reporting program scale."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across all calculations — primary ACA compliance KPI; values below 80% (individual/small group) or 85% (large group) trigger rebate obligations."
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium across all MLR calculations — denominator for MLR ratio and key revenue metric."
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims across all MLR calculations — primary driver of MLR ratio and medical cost management."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses_amount AS DOUBLE))
      comment: "Total quality improvement expenses — these count toward the MLR numerator under ACA and reflect investment in care quality."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed across all MLR calculations — measures ACA rebate obligation and financial impact on the plan."
    - name: "rebate_eligible_calculation_count"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of MLR calculations triggering a rebate obligation — tracks ACA compliance exposure by market segment."
    - name: "rebate_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MLR calculations resulting in a rebate obligation — high rates signal persistent underperformance on medical cost management."
    - name: "avg_rebate_amount"
      expr: AVG(CAST(rebate_amount AS DOUBLE))
      comment: "Average rebate amount per MLR calculation — benchmarks rebate exposure and informs pricing strategy adjustments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_phi_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for PHI disclosure logging — measures disclosure volume, authorization compliance, and unauthorized disclosure rates to ensure HIPAA minimum necessary and accounting of disclosures requirements."
  source: "`vibe_health_insurance_v1`.`compliance`.`phi_disclosure_log`"
  dimensions:
    - name: "phi_category"
      expr: phi_category
      comment: "Category of PHI disclosed (e.g., mental health, substance abuse, general medical) — different categories have heightened protection requirements."
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Method of PHI disclosure (e.g., electronic, fax, mail) — informs channel security risk analysis."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure (e.g., completed, pending, revoked) for disclosure pipeline management."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving the PHI (e.g., provider, payer, law enforcement) — determines applicable HIPAA disclosure rules."
    - name: "is_authorized"
      expr: is_authorized
      comment: "Flag indicating whether the disclosure was properly authorized — unauthorized disclosures are HIPAA violations."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the disclosure — used for regulatory audit evidence."
    - name: "disclosure_year_month"
      expr: DATE_TRUNC('month', disclosure_timestamp)
      comment: "Month of the PHI disclosure — enables trend analysis of disclosure activity for accounting of disclosures reporting."
  measures:
    - name: "total_phi_disclosures"
      expr: COUNT(1)
      comment: "Total number of PHI disclosures logged — baseline measure for HIPAA accounting of disclosures compliance."
    - name: "authorized_disclosure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_authorized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PHI disclosures that were properly authorized — primary HIPAA Privacy Rule compliance KPI; unauthorized disclosures are reportable violations."
    - name: "unauthorized_disclosure_count"
      expr: COUNT(CASE WHEN is_authorized = FALSE THEN 1 END)
      comment: "Number of unauthorized PHI disclosures — each unauthorized disclosure is a potential HIPAA breach requiring investigation and possible notification."
    - name: "unique_members_affected"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of distinct members whose PHI was disclosed — measures scope of PHI disclosure activity for privacy risk assessment."
    - name: "disclosures_by_unique_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees who performed PHI disclosures — measures workforce PHI access breadth for minimum necessary compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_policy_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy document lifecycle metrics tracking policy volume, review currency, expiration risk, and approval status to ensure governance documentation remains current and compliant."
  source: "`vibe_health_insurance_v1`.`compliance`.`policy_document`"
  dimensions:
    - name: "policy_document_category"
      expr: policy_document_category
      comment: "Category of the policy document"
    - name: "policy_document_status"
      expr: policy_document_status
      comment: "Current status of the policy document"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area the policy covers"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy document"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the policy"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the policy is currently active"
    - name: "policy_owner_department"
      expr: policy_owner_department
      comment: "Department owning the policy"
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted on the policy"
  measures:
    - name: "total_policy_documents"
      expr: COUNT(1)
      comment: "Total number of policy documents — governance documentation scope"
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active policies — operational governance coverage"
    - name: "expired_policy_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active policies past their expiration date — governance gap risk"
    - name: "policies_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of policies due for review — governance currency indicator"
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status IN ('Pending', 'In Review', 'Draft') THEN 1 END)
      comment: "Number of policies pending approval — governance pipeline backlog"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory changes — measures change volume, implementation status, compliance deadline adherence, and risk exposure to govern the organization's regulatory change management program."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (e.g., federal, state, CMS, DOL) — enables jurisdiction-specific change management tracking."
    - name: "change_category"
      expr: change_category
      comment: "Category of regulatory change (e.g., new rule, amendment, guidance) — informs implementation complexity and resource planning."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the regulatory change (e.g., pending, in-progress, completed) for program management."
    - name: "regulatory_change_status"
      expr: regulatory_change_status
      comment: "Overall status of the regulatory change record — used for change portfolio management."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical regulatory changes requiring priority implementation resources."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory change — enables multi-state compliance impact analysis."
    - name: "governing_body"
      expr: governing_body
      comment: "Governing body issuing the regulatory change (e.g., CMS, HHS, state DOI) — enables regulator-specific tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the regulatory change takes effect — supports annual compliance planning and resource allocation."
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes tracked — baseline measure for regulatory change management program scale."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all regulatory changes — measures overall regulatory risk exposure in the change portfolio."
    - name: "critical_change_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical regulatory changes — tracks highest-priority compliance implementation obligations."
    - name: "implementation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status IN ('Completed', 'Implemented') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory changes fully implemented — primary regulatory change management KPI measuring compliance execution velocity."
    - name: "overdue_implementation_count"
      expr: COUNT(CASE WHEN implementation_status NOT IN ('Completed', 'Implemented') AND compliance_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of regulatory changes past their compliance deadline without full implementation — each represents active regulatory violation risk."
    - name: "distinct_jurisdictions_impacted"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions impacted by regulatory changes — measures geographic compliance complexity and multi-state management burden."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory obligations — measures obligation portfolio health, active obligation coverage, and domain scope distribution to govern the organization's regulatory compliance posture."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "domain_scope"
      expr: domain_scope
      comment: "Business domain scope of the regulatory obligation (e.g., claims, enrollment, network) — enables domain-level compliance gap analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the regulatory obligation is currently active — active obligations require ongoing compliance monitoring."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status of the obligation — used for data governance and obligation portfolio management."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the regulatory obligation became effective — supports compliance timeline and regulatory change analysis."
  measures:
    - name: "total_regulatory_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations tracked — baseline measure for the organization's regulatory compliance portfolio breadth."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active regulatory obligations — measures the live compliance monitoring burden on the organization."
    - name: "active_obligation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory obligations that are currently active — tracks compliance portfolio currency and relevance."
    - name: "distinct_domain_scopes_covered"
      expr: COUNT(DISTINCT domain_scope)
      comment: "Number of distinct business domains covered by regulatory obligations — measures breadth of regulatory compliance coverage across the enterprise."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for regulatory submissions — measures submission timeliness, filing fee costs, rejection rates, and deadline compliance to manage the organization's regulatory reporting obligations."
  source: "`vibe_health_insurance_v1`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the regulatory submission (e.g., pending, submitted, accepted, rejected) for pipeline management."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., rate filing, network adequacy, MLR report) for category-level compliance tracking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (e.g., CMS, state DOI) — enables regulator-specific compliance reporting."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used for submission (e.g., HIOS, paper, electronic) — informs channel optimization."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical regulatory submissions where non-compliance carries severe penalties."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for rejected submissions — enables root-cause analysis of submission quality failures."
    - name: "submission_year_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the submission was filed — enables trend analysis of regulatory filing activity."
    - name: "filing_period_start_year"
      expr: YEAR(filing_period_start)
      comment: "Year of the filing period — supports annual regulatory compliance cycle reporting."
  measures:
    - name: "total_regulatory_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — baseline measure for regulatory compliance program scale."
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all regulatory submissions — tracks regulatory compliance cost for budget management."
    - name: "total_net_fees"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fees after adjustments across all regulatory submissions — measures actual regulatory cost burden."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory submissions filed on or before the due date — primary regulatory compliance KPI; late filings trigger penalties and enforcement actions."
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status IN ('Rejected', 'Denied') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory submissions rejected — high rejection rates signal submission quality failures requiring process improvement."
    - name: "critical_submission_overdue_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND regulatory_submission_status NOT IN ('Accepted', 'Completed', 'Filed') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of overdue critical regulatory submissions — each represents a potential regulatory violation requiring immediate escalation."
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per regulatory submission — benchmarks regulatory cost efficiency and informs budget planning."
    - name: "accepted_submission_count"
      expr: COUNT(CASE WHEN regulatory_submission_status IN ('Accepted', 'Approved', 'Completed') THEN 1 END)
      comment: "Number of accepted regulatory submissions — measures successful regulatory compliance execution."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance training completion — measures training completion rates, assessment performance, cost efficiency, and regulatory requirement fulfillment to manage workforce compliance readiness."
  source: "`vibe_health_insurance_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Current status of the training completion record (e.g., completed, in-progress, expired) for workforce compliance tracking."
    - name: "training_type"
      expr: training_type
      comment: "Type of compliance training (e.g., HIPAA, FWA, code of conduct) — enables category-level compliance gap analysis."
    - name: "training_category"
      expr: training_category
      comment: "Category of training for grouping and reporting compliance training investments."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method (e.g., online, instructor-led, blended) — informs channel effectiveness and cost analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the training assessment — measures workforce competency achievement."
    - name: "compliance_requirements_met_flag"
      expr: compliance_requirements_met_flag
      comment: "Flag indicating whether the completion satisfies regulatory compliance requirements — primary compliance readiness indicator."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating whether the training requires periodic renewal — tracks upcoming compliance renewal obligations."
    - name: "is_external_training"
      expr: is_external_training
      comment: "Flag for externally delivered training — enables make-vs-buy analysis for training program investment."
    - name: "completion_year_month"
      expr: DATE_TRUNC('month', completion_timestamp)
      comment: "Month training was completed — enables trend analysis of compliance training throughput."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completions — baseline measure for compliance training program scale and workforce coverage."
    - name: "compliance_requirements_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_requirements_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions satisfying regulatory compliance requirements — primary workforce compliance readiness KPI reported to regulators."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions with a passing assessment score — measures workforce competency achievement and training program effectiveness."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all training completions — benchmarks workforce knowledge level and identifies training quality gaps."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of compliance training across all completions — tracks compliance training investment for budget management."
    - name: "avg_training_cost_per_completion"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per training completion — benchmarks training cost efficiency and informs make-vs-buy decisions."
    - name: "total_training_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total compliance training hours completed — measures workforce training investment and regulatory hour requirements fulfillment."
    - name: "avg_hours_per_completion"
      expr: AVG(CAST(hours_completed AS DOUBLE))
      comment: "Average training hours per completion — benchmarks training depth and informs curriculum design decisions."
    - name: "expired_training_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of training completions that have expired and require renewal — tracks compliance renewal backlog and workforce risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`compliance_training_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance training programs — measures program portfolio health, cost, mandatory coverage, and certification requirements to govern the compliance training curriculum."
  source: "`vibe_health_insurance_v1`.`compliance`.`training_program`"
  dimensions:
    - name: "training_program_status"
      expr: training_program_status
      comment: "Current status of the training program (e.g., active, archived, under review) for portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance training program (e.g., HIPAA, FWA, ethics) for category-level portfolio analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance domain category of the program — enables targeted curriculum investment by regulatory area."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for the program (e.g., online, instructor-led) — informs channel strategy and cost optimization."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the program is mandatory for regulatory compliance — mandatory programs require 100% completion tracking."
    - name: "certification_required"
      expr: certification_required
      comment: "Flag indicating whether the program leads to a certification — tracks certification-bearing program portfolio."
    - name: "is_external_provider"
      expr: is_external_provider
      comment: "Flag for externally provided programs — enables make-vs-buy analysis for training investment."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the compliance area covered by the program — prioritizes high-risk training investments."
  measures:
    - name: "total_training_programs"
      expr: COUNT(1)
      comment: "Total number of compliance training programs in the portfolio — baseline measure for curriculum breadth."
    - name: "mandatory_program_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory compliance training programs — tracks regulatory-required curriculum coverage."
    - name: "mandatory_program_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training programs that are mandatory — measures regulatory compliance curriculum concentration."
    - name: "total_program_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of all compliance training programs — tracks compliance training investment for budget management and vendor negotiations."
    - name: "avg_program_cost"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average cost per compliance training program — benchmarks program cost efficiency and informs procurement decisions."
    - name: "avg_passing_score_threshold"
      expr: AVG(CAST(passing_score_threshold AS DOUBLE))
      comment: "Average passing score threshold across all programs — measures rigor of compliance training assessments."
    - name: "total_training_hours_required"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours required across all programs — measures regulatory training hour obligations and workforce time investment."
    - name: "certification_required_program_count"
      expr: COUNT(CASE WHEN certification_required = TRUE THEN 1 END)
      comment: "Number of programs requiring certification — tracks certification-bearing compliance curriculum for workforce credentialing management."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN training_program_status = 'Active' AND is_active = TRUE THEN 1 END)
      comment: "Number of currently active compliance training programs — measures available curriculum for workforce compliance readiness."
$$;
