-- Metric views for domain: appeal | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over adverse determinations — tracks denial financials, appeal filing rates, and resolution outcomes to steer clinical and operational appeal strategy."
  source: "`vibe_health_insurance_v1`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal (e.g., Upheld, Overturned, Partially Overturned) — primary segmentation for appeal effectiveness analysis."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., Open, Closed, Pending) — used to track pipeline and backlog."
    - name: "basis_of_denial"
      expr: basis_of_denial
      comment: "Clinical or administrative basis for the original denial — identifies systemic denial patterns."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for the denial reason — enables root-cause analysis and regulatory reporting."
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (e.g., Medical Necessity, Experimental) — drives clinical policy review."
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the determination record — used to filter active vs. resolved determinations."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Indicates whether the determination is eligible for appeal — critical for compliance and member rights tracking."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Indicates whether prior authorization was required for the denied service — links denial patterns to PA policy."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of the service date — enables trend analysis of denials over time."
    - name: "appeal_filed_date_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_date)
      comment: "Month the appeal was filed — tracks appeal filing volume trends."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary amounts — required for multi-currency financial reporting."
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determinations — baseline volume KPI for denial management dashboards."
    - name: "total_amount_denied"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total dollar value of denied claims — directly measures financial exposure from adverse determinations; a key executive KPI for cost and risk management."
    - name: "total_amount_adjusted"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total dollar value adjusted following appeal review — measures financial recovery from successful appeals."
    - name: "avg_amount_denied_per_determination"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average denied amount per adverse determination — identifies high-cost denial categories for targeted clinical review."
    - name: "appeal_filed_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse determinations that resulted in a filed appeal — measures member and provider engagement with the appeals process; a regulatory and quality indicator."
    - name: "appeal_eligible_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of determinations eligible for appeal — baseline for appeal conversion rate calculations and compliance audits."
    - name: "overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of filed appeals that resulted in an overturned determination — a primary quality and clinical accuracy KPI; high overturn rates signal systemic denial errors."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal cases — tracks case volume, SLA compliance, escalation rates, complexity, and decision outcomes to drive operational excellence and regulatory adherence."
  source: "`vibe_health_insurance_v1`.`appeal`.`case`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (e.g., Open, Closed, Pending Review) — primary operational segmentation."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g., Clinical, Administrative, Expedited) — drives resource allocation and regulatory tracking."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., Upheld, Overturned, Remanded) — key outcome dimension for quality analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the appeal (e.g., Commercial, Medicare, Medicaid) — enables LOB-level performance benchmarking."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the appeal was filed (e.g., Online, Phone, Mail) — informs member experience and digital adoption strategy."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Party who filed the appeal (e.g., Member, Provider, Employer) — segments appeal volume by stakeholder type."
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier governing the appeal (e.g., State, Federal, ERISA) — critical for compliance reporting."
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level assigned to the appeal — used to monitor high-priority case handling and SLA adherence."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the case breached its SLA — primary compliance and operational risk indicator."
    - name: "expedited_trigger"
      expr: expedited_trigger
      comment: "Indicates whether the case was triggered for expedited review — tracks urgent clinical appeal volume."
    - name: "appeal_escalation_flag"
      expr: appeal_escalation_flag
      comment: "Indicates whether the case was escalated — measures escalation frequency for operational quality management."
    - name: "filing_timestamp_month"
      expr: DATE_TRUNC('MONTH', filing_timestamp)
      comment: "Month the appeal case was filed — enables monthly trend analysis of appeal intake volume."
    - name: "decision_timestamp_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month the decision was rendered — tracks decision throughput over time."
  measures:
    - name: "total_appeal_cases"
      expr: COUNT(1)
      comment: "Total number of appeal cases — baseline volume KPI for capacity planning and trend monitoring."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of appeal cases that breached their SLA — a direct regulatory compliance and operational risk KPI; regulators impose penalties for SLA breaches."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases that breached SLA — executive-level compliance health metric; drives corrective action and staffing decisions."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases that were escalated — measures case complexity and first-level resolution effectiveness; high rates signal process or staffing issues."
    - name: "expedited_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring expedited review — tracks urgent clinical appeal burden; regulators mandate strict turnaround times for expedited cases."
    - name: "avg_case_complexity_score"
      expr: AVG(CAST(complexity_score AS DOUBLE))
      comment: "Average complexity score across appeal cases — informs staffing, routing, and resource allocation decisions for case management operations."
    - name: "total_case_complexity_score"
      expr: SUM(CAST(complexity_score AS DOUBLE))
      comment: "Total complexity score across all cases — used alongside case count to compute weighted complexity trends and capacity planning."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN appeal_status = 'Open' THEN 1 END)
      comment: "Number of currently open appeal cases — operational backlog KPI used to manage staffing and prevent SLA breaches."
    - name: "overturn_case_count"
      expr: COUNT(CASE WHEN decision_type = 'Overturned' THEN 1 END)
      comment: "Number of cases where the original decision was overturned — measures clinical and administrative decision quality; high counts trigger policy review."
    - name: "overturn_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_type IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided cases that were overturned — a primary quality KPI for clinical decision-making accuracy; regulators and accreditors benchmark this rate."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_coverage_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over coverage disputes — tracks dispute volume, financial exposure from coordination of benefits and subrogation, resolution outcomes, and critical dispute rates."
  source: "`vibe_health_insurance_v1`.`appeal`.`coverage_dispute`"
  dimensions:
    - name: "coverage_dispute_status"
      expr: coverage_dispute_status
      comment: "Current status of the coverage dispute (e.g., Open, Resolved, Pending) — primary operational segmentation."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of coverage dispute (e.g., COB, Formulary, Eligibility) — drives root-cause analysis and policy review."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (e.g., Upheld, Reversed, Settled) — measures dispute resolution effectiveness."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of party disputing coverage (e.g., Member, Provider, Employer) — segments dispute volume by stakeholder."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Appeal status associated with the coverage dispute — links dispute resolution to the broader appeal lifecycle."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the dispute is flagged as critical — used to prioritize high-risk disputes for executive attention."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Indicates whether subrogation recovery is applicable — tracks subrogation pipeline for financial recovery management."
    - name: "formulary_exception_flag"
      expr: formulary_exception_flag
      comment: "Indicates whether a formulary exception was involved — tracks pharmacy benefit dispute patterns."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the dispute — used to monitor high-priority dispute handling and SLA adherence."
    - name: "appeal_filed_date_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_date)
      comment: "Month the appeal was filed for the dispute — enables trend analysis of dispute intake."
    - name: "resolution_date_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the dispute was resolved — tracks resolution throughput over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts — required for multi-currency financial reporting."
  measures:
    - name: "total_coverage_disputes"
      expr: COUNT(1)
      comment: "Total number of coverage disputes — baseline volume KPI for dispute management operations."
    - name: "critical_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coverage disputes flagged as critical — executive risk indicator; high rates signal systemic coverage or eligibility issues requiring immediate intervention."
    - name: "total_coordination_amount"
      expr: SUM(CAST(coordination_amount AS DOUBLE))
      comment: "Total dollar amount subject to coordination of benefits across disputes — measures COB financial exposure and recovery opportunity."
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation recovery amount across disputes — directly measures financial recovery from third-party liability; a key revenue recovery KPI."
    - name: "avg_coordination_amount"
      expr: AVG(CAST(coordination_amount AS DOUBLE))
      comment: "Average coordination of benefits amount per dispute — benchmarks COB dispute size for resource allocation and vendor performance."
    - name: "subrogation_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subrogation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes involving subrogation — tracks the proportion of disputes with financial recovery potential; informs recovery team staffing."
    - name: "resolved_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_dispute_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coverage disputes that have been resolved — operational throughput KPI; low rates indicate backlog buildup and potential SLA risk."
    - name: "formulary_exception_dispute_count"
      expr: COUNT(CASE WHEN formulary_exception_flag = TRUE THEN 1 END)
      comment: "Number of disputes involving formulary exceptions — tracks pharmacy benefit dispute volume; informs formulary design and prior authorization policy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over external (IRO) reviews — tracks review volume, financial impact, binding determination rates, regulatory reporting compliance, and urgency patterns for independent review oversight."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external reviews — baseline volume KPI for IRO program management and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_iro_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over IRO (Independent Review Organization) entities — tracks accreditation status, certification rates, conflict-of-interest exposure, and contract coverage to govern IRO network quality."
  source: "`vibe_health_insurance_v1`.`appeal`.`iro_organization`"
  dimensions:
    - name: "iro_organization_status"
      expr: iro_organization_status
      comment: "Current operational status of the IRO (e.g., Active, Inactive, Suspended) — primary segmentation for network availability analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the IRO (e.g., Accredited, Expired, Pending) — key quality and compliance dimension."
    - name: "organization_type"
      expr: organization_type
      comment: "Type of IRO organization (e.g., Clinical, Administrative, Specialty) — enables segmentation by review capability."
    - name: "state"
      expr: state
      comment: "State where the IRO is based — enables state-level IRO network coverage analysis."
    - name: "is_state_approved"
      expr: is_state_approved
      comment: "Indicates whether the IRO is approved in the relevant state — critical for regulatory compliance in state-mandated external review programs."
    - name: "ncqa_certified_flag"
      expr: ncqa_certified_flag
      comment: "Indicates NCQA certification status — a key quality credential for IRO selection and network governance."
    - name: "urac_certified_flag"
      expr: urac_certified_flag
      comment: "Indicates URAC certification status — a key quality credential for IRO selection and network governance."
    - name: "is_conflict_of_interest"
      expr: is_conflict_of_interest
      comment: "Indicates whether a conflict of interest has been identified for the IRO — a compliance and independence risk flag."
    - name: "contract_effective_start_month"
      expr: DATE_TRUNC('MONTH', contract_effective_start_date)
      comment: "Month the IRO contract became effective — enables contract lifecycle and renewal trend analysis."
    - name: "accreditation_expiration_month"
      expr: DATE_TRUNC('MONTH', accreditation_expiration_date)
      comment: "Month the IRO accreditation expires — used to proactively manage accreditation renewal and avoid compliance gaps."
  measures:
    - name: "total_iro_organizations"
      expr: COUNT(1)
      comment: "Total number of IRO organizations in the network — baseline KPI for IRO network size and capacity planning."
    - name: "active_iro_count"
      expr: COUNT(CASE WHEN iro_organization_status = 'Active' THEN 1 END)
      comment: "Number of currently active IRO organizations — measures available IRO capacity for external review assignment."
    - name: "accredited_iro_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IROs with current accreditation — a network quality KPI; regulators require accredited IROs for external review programs."
    - name: "ncqa_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IROs with NCQA certification — measures the quality credential coverage of the IRO network; informs vendor selection and accreditation strategy."
    - name: "urac_certified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN urac_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IROs with URAC certification — measures the quality credential coverage of the IRO network alongside NCQA certification."
    - name: "conflict_of_interest_count"
      expr: COUNT(CASE WHEN is_conflict_of_interest = TRUE THEN 1 END)
      comment: "Number of IROs with an identified conflict of interest — a compliance risk KPI; IROs with conflicts must be excluded from relevant reviews per regulatory requirements."
    - name: "state_approved_iro_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_state_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IROs with state approval — measures regulatory compliance of the IRO network for state-mandated external review programs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal outcomes — tracks financial impact of appeal decisions, compliance rates, overturn patterns, and downstream action triggers to steer appeal quality and financial management."
  source: "`vibe_health_insurance_v1`.`appeal`.`outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of appeal outcome (e.g., Upheld, Overturned, Partially Overturned) — primary dimension for outcome quality analysis."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the outcome record (e.g., Final, Pending, Under Review) — used to filter actionable vs. in-progress outcomes."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the outcome is compliant with regulatory requirements — primary compliance health indicator."
    - name: "downstream_action"
      expr: downstream_action
      comment: "Action triggered by the outcome (e.g., Claim Reprocessing, Enrollment Change, Refund) — tracks operational follow-through on appeal decisions."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction of the outcome — enables state-level regulatory compliance and outcome trend analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the outcome (e.g., CMS, State DOI) — enables regulatory-body-level compliance reporting."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the outcome — enables root-cause analysis of appeal decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial impact amounts — required for multi-currency financial reporting."
    - name: "outcome_timestamp_month"
      expr: DATE_TRUNC('MONTH', outcome_timestamp)
      comment: "Month the outcome was recorded — enables monthly trend analysis of appeal resolution throughput."
  measures:
    - name: "total_appeal_outcomes"
      expr: COUNT(1)
      comment: "Total number of appeal outcomes recorded — baseline volume KPI for appeal resolution throughput."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of appeal outcomes — measures the aggregate dollar effect of appeal decisions on the health plan; a primary executive financial KPI."
    - name: "avg_financial_impact_per_outcome"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per appeal outcome — benchmarks the cost of appeal decisions; informs reserve setting and financial planning."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal outcomes that are compliant with regulatory requirements — a primary regulatory health KPI; non-compliance triggers penalties and corrective action plans."
    - name: "non_compliant_outcome_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of non-compliant appeal outcomes — absolute count of regulatory violations; each non-compliant outcome represents direct regulatory risk and potential financial penalty."
    - name: "overturn_financial_impact"
      expr: SUM(CASE WHEN outcome_type = 'Overturned' THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact from overturned appeal outcomes — measures the cost of reversed decisions; a key metric for clinical decision quality and financial reserve management."
    - name: "distinct_members_with_outcomes"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members with recorded appeal outcomes — measures the breadth of member impact from appeal decisions; informs member experience and HEDIS-related quality reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal reviews — tracks review volume, independent reviewer utilization, compliance rates, and outcome patterns to govern clinical review quality and regulatory adherence."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of appeal review (e.g., Clinical, Administrative, Peer-to-Peer) — primary segmentation for review workload analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., Pending, Completed, In Progress) — operational pipeline tracking dimension."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the review (e.g., Upheld, Overturned, Modified) — primary quality outcome dimension."
    - name: "appeal_status_at_review"
      expr: appeal_status_at_review
      comment: "Status of the appeal at the time of review — provides context for review timing and process compliance."
    - name: "reviewer_type"
      expr: reviewer_type
      comment: "Type of reviewer conducting the review (e.g., Medical Director, Nurse, External Physician) — enables reviewer-type performance analysis."
    - name: "reviewer_specialty"
      expr: reviewer_specialty
      comment: "Clinical specialty of the reviewer — ensures appropriate specialty matching for clinical reviews; a quality and compliance requirement."
    - name: "is_independent_reviewer"
      expr: is_independent_reviewer
      comment: "Indicates whether the reviewer is independent — tracks independence requirements for regulatory compliance."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance status of the review — indicates whether the review met regulatory and process requirements."
    - name: "review_timestamp_month"
      expr: DATE_TRUNC('MONTH', review_timestamp)
      comment: "Month the review was conducted — enables monthly trend analysis of review throughput."
  measures:
    - name: "total_appeal_reviews"
      expr: COUNT(1)
      comment: "Total number of appeal reviews conducted — baseline volume KPI for review capacity and throughput management."
    - name: "independent_reviewer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_independent_reviewer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews conducted by independent reviewers — measures compliance with independence requirements; regulators mandate independent review for certain appeal types."
    - name: "compliant_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = 'Y' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal reviews that met compliance requirements — a primary regulatory quality KPI; non-compliant reviews expose the health plan to regulatory action."
    - name: "review_overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed reviews resulting in an overturn — measures clinical decision accuracy at the review level; high rates trigger clinical policy and criteria review."
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT reviewer_npi)
      comment: "Number of distinct reviewers (by NPI) conducting appeal reviews — measures reviewer network breadth and capacity; informs credentialing and workload distribution."
    - name: "completed_review_count"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Number of completed appeal reviews — operational throughput KPI; tracks review completion rate against intake volume to identify backlog risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over appeal timelines — tracks SLA compliance, breach rates, expedited processing, and regulatory deadline adherence to drive operational excellence and avoid regulatory penalties."
  source: "`vibe_health_insurance_v1`.`appeal`.`timeline`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal in the timeline (e.g., Open, Closed, Pending) — primary operational segmentation."
    - name: "appeal_category"
      expr: appeal_category
      comment: "Category of the appeal (e.g., Clinical, Administrative, Grievance) — enables category-level SLA performance analysis."
    - name: "appeal_origin"
      expr: appeal_origin
      comment: "Origin of the appeal (e.g., Member, Provider, Employer) — segments timeline performance by filing party."
    - name: "sla_breach"
      expr: sla_breach
      comment: "Indicates whether the appeal breached its SLA — primary compliance and operational risk dimension."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates a timeline breach event — used alongside sla_breach for multi-level breach analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the timeline record (e.g., Compliant, Non-Compliant, At Risk) — regulatory health dimension."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing the appeal timeline — enables state-level regulatory compliance reporting."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the timeline (e.g., CMS, State DOI) — enables regulatory-body-level SLA reporting."
    - name: "priority"
      expr: priority
      comment: "Priority level of the appeal in the timeline — used to monitor high-priority case SLA adherence."
    - name: "clock_type"
      expr: clock_type
      comment: "Type of regulatory clock governing the timeline (e.g., Standard, Expedited) — critical for SLA calculation and compliance."
    - name: "self_report_flag"
      expr: self_report_flag
      comment: "Indicates whether the breach was self-reported — tracks voluntary compliance disclosure; self-reporting is a regulatory best practice."
    - name: "appeal_filed_timestamp_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_timestamp)
      comment: "Month the appeal was filed — enables monthly trend analysis of appeal intake and SLA performance."
  measures:
    - name: "total_timeline_records"
      expr: COUNT(1)
      comment: "Total number of appeal timeline records — baseline volume KPI for appeal processing throughput."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach = TRUE THEN 1 END)
      comment: "Number of appeals that breached their SLA deadline — a direct regulatory compliance KPI; each breach represents a potential regulatory violation and member harm event."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that breached their SLA — the primary operational compliance KPI for appeal management; regulators benchmark this rate and impose corrective action plans for high breach rates."
    - name: "self_reported_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN self_report_flag = TRUE AND sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN sla_breach = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of SLA breaches that were self-reported — measures proactive compliance disclosure; regulators view self-reporting favorably and it reduces penalty exposure."
    - name: "non_compliant_timeline_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of appeal timelines with non-compliant status — absolute count of regulatory compliance failures; each non-compliant record represents direct regulatory risk."
    - name: "compliant_timeline_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal timelines meeting compliance requirements — executive-level regulatory health KPI; used in board reporting and regulatory submissions."
    - name: "distinct_members_in_timeline"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of distinct members with active appeal timelines — measures the breadth of member impact from appeal processing; informs member experience and capacity planning."
$$;