-- Metric views for domain: appeal | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring adverse determination volume, denial patterns, financial impact, and appeal conversion rates. Used by Medical Directors and VP of Clinical Operations to manage denial quality and regulatory risk."
  source: "`vibe_health_insurance_v1`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Coded reason for the adverse determination (e.g. not medically necessary, experimental) for denial pattern analysis."
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (e.g. prior auth denial, claim denial, concurrent review) for segmenting denial categories."
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the determination (e.g. final, pending appeal) for pipeline tracking."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status at time of determination, relevant for balance billing and surprise billing compliance."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against this adverse determination, enabling appeal conversion tracking."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal (upheld, overturned) for overturn rate analysis and denial quality assessment."
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization was required, enabling PA-related denial segmentation."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the determination is eligible for appeal, used to compute the actionable denial pool."
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determinations issued. Baseline denial volume KPI tracked by regulators and used to benchmark against industry norms."
    - name: "total_amount_denied"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total dollar amount denied across all adverse determinations. Direct financial impact measure — high denial amounts drive member cost burden and regulatory scrutiny."
    - name: "total_amount_adjusted"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total dollar amount adjusted (reversed or modified) following appeal. Measures financial exposure from overturned denials."
    - name: "avg_amount_denied"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average dollar amount denied per adverse determination. Identifies high-value denial categories that warrant clinical policy review."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END)
      comment: "Number of adverse determinations that resulted in an appeal being filed. Measures member and provider engagement with the appeals process."
    - name: "appeal_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of eligible adverse determinations that resulted in an appeal filing. High rates signal member/provider dissatisfaction with denial decisions."
    - name: "overturn_count"
      expr: COUNT(CASE WHEN appeal_outcome = 'overturned' THEN 1 END)
      comment: "Number of adverse determinations overturned on appeal. A direct denial quality KPI — high overturn counts indicate flawed initial denial decisions."
    - name: "overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome = 'overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of appealed adverse determinations that were overturned. The single most important denial quality KPI — regulators use this to assess medical necessity decision quality."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on member grievances and appeals filed through the grievance process — key indicator of member satisfaction and service quality."
  source: "`vibe_health_insurance_v1`.`appeal`.`appeal_grievance`"
  dimensions:
    - name: "grievance_type"
      expr: grievance_type
      comment: "Type of grievance filed (e.g., quality of care, access, billing)."
    - name: "appeal_grievance_status"
      expr: appeal_grievance_status
      comment: "Current status of the grievance."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied to the grievance."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the grievance."
    - name: "priority"
      expr: priority
      comment: "Priority level of the grievance."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party who filed the grievance."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the grievance was filed."
    - name: "state_code"
      expr: state_code
      comment: "State where the grievance was filed."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the grievance."
    - name: "is_appeal"
      expr: CASE WHEN is_appeal = TRUE THEN 'Appeal' ELSE 'Grievance' END
      comment: "Whether the record is an appeal or a grievance."
    - name: "external_review_requested"
      expr: CASE WHEN external_review_requested = TRUE THEN 'Requested' ELSE 'Not Requested' END
      comment: "Whether external review was requested."
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month the grievance was filed for trend analysis."
  measures:
    - name: "total_grievances"
      expr: COUNT(1)
      comment: "Total number of grievances filed — primary volume metric for member dissatisfaction."
    - name: "appeal_count"
      expr: SUM(CASE WHEN is_appeal = TRUE THEN 1 ELSE 0 END)
      comment: "Number of records classified as appeals within the grievance process."
    - name: "grievance_only_count"
      expr: SUM(CASE WHEN is_appeal = FALSE THEN 1 ELSE 0 END)
      comment: "Number of pure grievances (non-appeal) — measures service quality complaints."
    - name: "external_review_requested_count"
      expr: SUM(CASE WHEN external_review_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of grievances/appeals where external review was requested — escalation severity metric."
    - name: "compliant_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of grievances handled in compliance with regulations."
    - name: "distinct_providers_involved"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers associated with grievances — identifies provider quality patterns."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appeal case management KPIs tracking volume, SLA compliance, complexity, and financial exposure across all appeal types. Primary steering dashboard for the Appeals Operations VP and Chief Compliance Officer."
  source: "`vibe_health_insurance_v1`.`appeal`.`case`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. clinical, administrative, grievance) for segmenting case volume and outcomes by appeal category."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (e.g. open, closed, pending) enabling pipeline and backlog analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (e.g. Medicare, Medicaid, Commercial) for cross-LOB appeal performance benchmarking."
    - name: "filing_channel"
      expr: filing_channel
      comment: "Channel through which the appeal was filed (e.g. phone, portal, mail) for channel mix and digital adoption analysis."
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier governing the appeal (e.g. state, federal, ERISA) for compliance segmentation."
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level assigned to the appeal case for workload triage and SLA management."
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party filing the appeal (member, provider, employer) for stakeholder-level analysis."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (upheld, overturned, partial) for quality and outcome tracking."
    - name: "expedited_trigger"
      expr: expedited_trigger
      comment: "Flag indicating whether the case triggered an expedited review, used to segment standard vs. expedited SLA performance."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the case breached its SLA deadline, the primary compliance risk indicator for appeal operations."
    - name: "priority_level_code"
      expr: priority_level_code
      comment: "Coded priority level for the case, enabling tiered SLA monitoring and escalation tracking."
  measures:
    - name: "total_appeal_cases"
      expr: COUNT(1)
      comment: "Total number of appeal cases filed. Baseline volume KPI used to size staffing, track trends, and benchmark against prior periods."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of appeal cases that breached their SLA deadline. A direct compliance risk indicator — regulatory penalties are triggered by SLA failures."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases that breached SLA. The primary regulatory compliance KPI for appeal operations; CMS and state DOI benchmarks apply."
    - name: "expedited_case_count"
      expr: COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END)
      comment: "Number of cases flagged for expedited review. Expedited cases carry tighter regulatory deadlines and higher compliance risk."
    - name: "expedited_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases requiring expedited review. High rates signal clinical urgency volume and resource pressure on expedited review teams."
    - name: "avg_complexity_score"
      expr: AVG(CAST(complexity_score AS DOUBLE))
      comment: "Average complexity score across appeal cases. Drives staffing allocation decisions — high complexity cases require senior reviewers and longer resolution cycles."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN appeal_status = 'open' THEN 1 END)
      comment: "Number of currently open appeal cases. Operational backlog KPI used to manage queue depth and prevent SLA breaches."
    - name: "appeal_escalation_count"
      expr: COUNT(CASE WHEN appeal_escalation_flag = TRUE THEN 1 END)
      comment: "Number of appeal cases that were escalated. Escalations indicate unresolved complexity and increase regulatory and financial risk."
    - name: "appeal_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal cases escalated. A quality signal — high escalation rates indicate first-level resolution failures and process gaps."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_coverage_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for coverage dispute volume, financial exposure, COB complexity, and resolution outcomes. Used by the VP of Member Services and CFO to manage coverage dispute liability and member experience."
  source: "`vibe_health_insurance_v1`.`appeal`.`coverage_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of coverage dispute (e.g. COB, formulary, network) for segmenting dispute volume by root cause."
    - name: "coverage_dispute_status"
      expr: coverage_dispute_status
      comment: "Current status of the coverage dispute (open, resolved, escalated) for pipeline and backlog management."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any associated appeal for tracking dispute-to-appeal escalation patterns."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs. out-of-network status at time of dispute, relevant for balance billing and surprise billing compliance."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of party disputing coverage (member, provider, employer) for stakeholder-level dispute analysis."
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether the dispute involves subrogation, used to track recovery opportunities."
    - name: "formulary_exception_flag"
      expr: formulary_exception_flag
      comment: "Whether the dispute involves a formulary exception, used to segment pharmacy-related coverage disputes."
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the dispute is flagged as critical, used for priority escalation and executive visibility."
  measures:
    - name: "total_coverage_disputes"
      expr: COUNT(1)
      comment: "Total number of coverage disputes filed. Baseline volume KPI for member services capacity planning and trend analysis."
    - name: "total_coordination_amount"
      expr: SUM(CAST(coordination_amount AS DOUBLE))
      comment: "Total dollar amount subject to coordination of benefits in coverage disputes. Measures COB financial exposure and recovery opportunity."
    - name: "total_subrogation_amount"
      expr: SUM(CAST(subrogation_amount AS DOUBLE))
      comment: "Total subrogation amount across coverage disputes. Measures recovery opportunity from third-party liability — a direct revenue recovery KPI."
    - name: "avg_coordination_amount"
      expr: AVG(CAST(coordination_amount AS DOUBLE))
      comment: "Average coordination of benefits amount per dispute. Identifies high-value COB dispute categories for prioritized recovery efforts."
    - name: "critical_dispute_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of coverage disputes flagged as critical. Drives executive escalation and priority resource allocation."
    - name: "critical_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coverage disputes flagged as critical. Measures the severity concentration of the dispute portfolio."
    - name: "subrogation_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subrogation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coverage disputes involving subrogation. Measures the proportion of disputes with recovery potential."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring appeal resolution quality, financial impact of outcomes, and overturn patterns. Used by the Chief Medical Officer and VP of Appeals to assess decision quality and downstream financial exposure."
  source: "`vibe_health_insurance_v1`.`appeal`.`outcome`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of appeal outcome (upheld, overturned, partial, withdrawn) for resolution pattern analysis."
    - name: "outcome_status"
      expr: outcome_status
      comment: "Current status of the outcome record (final, pending) for pipeline completeness tracking."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the outcome decision, enabling root-cause analysis of overturn and uphold patterns."
    - name: "downstream_action"
      expr: downstream_action
      comment: "Action triggered by the outcome (e.g. claim adjustment, benefit reinstatement) for operational impact tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the outcome has a compliance implication, used to flag regulatory reporting requirements."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing the appeal outcome, enabling state-level regulatory compliance benchmarking."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the appeal (e.g. CMS, state DOI) for regulatory reporting segmentation."
  measures:
    - name: "total_outcomes"
      expr: COUNT(1)
      comment: "Total number of appeal outcomes recorded. Baseline resolution volume KPI for throughput and capacity planning."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all appeal outcomes. Measures the aggregate cost of overturned denials and benefit reinstatements — a key P&L risk metric."
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per appeal outcome. Identifies high-cost outcome categories that drive disproportionate financial exposure."
    - name: "overturn_outcome_count"
      expr: COUNT(CASE WHEN outcome_type = 'overturned' THEN 1 END)
      comment: "Number of appeal outcomes resulting in overturn. Direct measure of denial quality — each overturn represents a reversed clinical or administrative decision."
    - name: "overturn_outcome_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_type = 'overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal outcomes that resulted in overturn. The primary denial quality KPI for executive and regulatory reporting."
    - name: "compliance_flagged_outcome_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of outcomes flagged for compliance implications. Drives regulatory reporting workload and corrective action planning."
    - name: "total_financial_impact_overturned"
      expr: SUM(CASE WHEN outcome_type = 'overturned' THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact attributable to overturned appeal outcomes. Quantifies the cost of initial denial errors — a key input to denial management ROI analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking regulatory penalty volume, financial exposure, and payment status from appeal-related compliance failures. Used by the CFO and Chief Compliance Officer to manage regulatory financial risk."
  source: "`vibe_health_insurance_v1`.`appeal`.`penalty`"
  dimensions:
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of regulatory penalty (e.g. late decision, improper denial) for root-cause analysis of compliance failures."
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty (assessed, paid, appealed, waived) for financial liability tracking."
    - name: "penalty_category"
      expr: penalty_category
      comment: "Category of penalty for grouping by compliance domain (e.g. SLA, clinical, administrative)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the penalty (paid, outstanding, disputed) for accounts payable and cash flow management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that assessed the penalty (e.g. CMS, state DOI) for regulatory relationship management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the penalty for prioritizing remediation and corrective action planning."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether the penalty has been appealed, used to track contested penalties and potential liability reduction."
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of any penalty appeal (reduced, waived, upheld) for financial liability resolution tracking."
  measures:
    - name: "total_penalties_assessed"
      expr: COUNT(1)
      comment: "Total number of regulatory penalties assessed. Baseline compliance failure volume KPI for executive and board reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar amount of penalties assessed. Primary financial risk KPI for regulatory compliance — directly impacts P&L and capital reserves."
    - name: "total_penalty_with_interest"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total penalty amount including interest charges. Full financial liability measure for regulatory penalty exposure."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest accrued on unpaid penalties. Measures the cost of delayed penalty resolution and incentivizes timely payment."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average penalty amount per assessed penalty. Identifies penalty severity trends and benchmarks against prior periods."
    - name: "outstanding_penalty_count"
      expr: COUNT(CASE WHEN payment_status != 'paid' THEN 1 END)
      comment: "Number of penalties not yet paid. Measures outstanding regulatory liability requiring resolution."
    - name: "outstanding_penalty_amount"
      expr: SUM(CASE WHEN payment_status != 'paid' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar amount of unpaid penalties. Outstanding regulatory financial liability — a key input to the CFO's regulatory risk reserve calculation."
    - name: "penalty_appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessed penalties that were appealed. High rates indicate contested compliance findings and potential liability reduction opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for appeal-related regulatory filing compliance, including filing timeliness, deficiency rates, and resubmission volume. Used by the Chief Compliance Officer and Regulatory Affairs team to manage state and federal filing obligations. (Note: product renamed from appeal.appeal_regulatory_filing per VREQ-006.)"
  source: "`vibe_health_insurance_v1`.`appeal`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g. grievance report, external review report) for segmenting filing volume by obligation type."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (submitted, pending, deficient) for compliance pipeline management."
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to submit the filing (e.g. electronic, paper) for submission channel analysis."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing (e.g. CMS, state DOI) for regulatory relationship management."
    - name: "deficiency_notice"
      expr: deficiency_notice
      comment: "Whether a deficiency notice was received for the filing, indicating a compliance failure requiring remediation."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Whether the filing requires resubmission, used to track rework volume and compliance remediation effort."
    - name: "acknowledgment_received"
      expr: acknowledgment_received
      comment: "Whether acknowledgment of the filing was received from the regulator, confirming successful submission."
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted. Baseline compliance activity volume for regulatory affairs capacity planning."
    - name: "deficiency_notice_count"
      expr: COUNT(CASE WHEN deficiency_notice = TRUE THEN 1 END)
      comment: "Number of filings that received a deficiency notice. Direct compliance failure indicator — deficiency notices require corrective action and resubmission."
    - name: "deficiency_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deficiency_notice = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings that received a deficiency notice. Key filing quality KPI — high rates indicate systemic data or process issues in regulatory reporting."
    - name: "resubmission_count"
      expr: COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END)
      comment: "Number of filings requiring resubmission. Measures rework volume and compliance remediation burden on the regulatory affairs team."
    - name: "resubmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings requiring resubmission. Measures filing quality and process efficiency — high rates increase regulatory risk and operational cost."
    - name: "total_filing_amount"
      expr: SUM(CAST(filing_amount AS DOUBLE))
      comment: "Total dollar amount reported across all regulatory filings. Measures the financial scope of regulatory reporting obligations."
    - name: "acknowledgment_received_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings for which acknowledgment was received. Measures submission confirmation completeness — unacknowledged filings may be lost and require follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_expedited_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for expedited appeal review performance, including decision timeliness, financial impact, and clinical urgency classification. Used by Medical Directors and Compliance Officers to manage expedited review SLA compliance."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the expedited review has a compliance implication, used to flag regulatory reporting requirements."
  measures:
    - name: "total_expedited_reviews"
      expr: COUNT(1)
      comment: "Total number of expedited reviews initiated. Baseline volume KPI for expedited review capacity planning."
    - name: "compliance_flagged_expedited_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of expedited reviews with compliance flags. Drives regulatory reporting workload and corrective action requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Independent Review Organization (IRO) and external review performance, including binding determination rates, financial impact, and regulatory reporting compliance. Used by the Chief Compliance Officer and VP of Appeals."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external reviews initiated. Baseline volume KPI for IRO utilization and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on internal appeal reviews including reviewer activity, review outcomes, and clinical review patterns."
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted (e.g., peer-to-peer, clinical, administrative)."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the review (e.g., upheld, overturned, referred)."
    - name: "reviewer_type"
      expr: reviewer_type
      comment: "Type of reviewer (e.g., physician, nurse, administrative)."
    - name: "reviewer_specialty"
      expr: reviewer_specialty
      comment: "Medical specialty of the reviewer."
    - name: "appeal_status_at_review"
      expr: appeal_status_at_review
      comment: "Status of the appeal at the time of review."
    - name: "appeal_reason_code"
      expr: appeal_reason_code
      comment: "Reason code for the appeal being reviewed."
    - name: "is_independent_reviewer"
      expr: CASE WHEN is_independent_reviewer = TRUE THEN 'Independent' ELSE 'Internal' END
      comment: "Whether the reviewer is independent or internal."
    - name: "review_month"
      expr: DATE_TRUNC('month', review_timestamp)
      comment: "Month the review was conducted."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of appeal reviews conducted — operational throughput metric."
    - name: "distinct_reviewers"
      expr: COUNT(DISTINCT reviewer_npi)
      comment: "Number of distinct reviewers by NPI — measures reviewer pool diversity."
    - name: "distinct_cases_reviewed"
      expr: COUNT(DISTINCT case_id)
      comment: "Unique appeal cases that received reviews."
    - name: "independent_review_count"
      expr: SUM(CASE WHEN is_independent_reviewer = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews conducted by independent reviewers — objectivity metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA and regulatory timeline compliance KPIs for appeal processing. Used by Compliance Officers and Operations Directors to monitor regulatory deadline adherence and identify systemic SLA failure patterns."
  source: "`vibe_health_insurance_v1`.`appeal`.`timeline`"
  dimensions:
    - name: "appeal_category"
      expr: appeal_category
      comment: "Category of appeal (e.g. clinical, administrative, grievance) for SLA performance segmentation by appeal type."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal in the timeline for pipeline and backlog analysis."
    - name: "clock_type"
      expr: clock_type
      comment: "Type of regulatory clock governing the timeline (e.g. standard, expedited) for SLA compliance segmentation."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for state-level SLA compliance benchmarking against DOI requirements."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body governing the timeline (e.g. CMS, state DOI) for regulatory reporting segmentation."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the timeline has a breach, the primary SLA compliance indicator."
    - name: "sla_breach"
      expr: sla_breach
      comment: "SLA breach indicator for the timeline record, used to compute breach rates and identify systemic failure patterns."
    - name: "appeal_origin"
      expr: appeal_origin
      comment: "Origin of the appeal (member, provider, employer) for stakeholder-level SLA performance analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for timeline breaches, enabling targeted process improvement initiatives."
    - name: "self_report_flag"
      expr: self_report_flag
      comment: "Whether the breach was self-reported to the regulator, a key compliance transparency indicator."
  measures:
    - name: "total_timeline_records"
      expr: COUNT(1)
      comment: "Total number of appeal timeline records. Baseline volume for SLA compliance analysis."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach = TRUE THEN 1 END)
      comment: "Number of appeal timelines with SLA breaches. Direct regulatory compliance risk metric — CMS and state DOI impose penalties for SLA failures."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeal timelines with SLA breaches. The headline regulatory compliance KPI for appeal operations — benchmarked against CMS 5-star thresholds."
    - name: "breach_flag_count"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of timelines with any breach flag (may include pre-breach warnings). Used for early warning monitoring before formal SLA violations occur."
    - name: "self_reported_breach_count"
      expr: COUNT(CASE WHEN self_report_flag = TRUE AND sla_breach = TRUE THEN 1 END)
      comment: "Number of SLA breaches that were self-reported to regulators. Measures compliance transparency — self-reporting typically reduces regulatory penalties."
    - name: "self_report_rate_among_breaches"
      expr: ROUND(100.0 * COUNT(CASE WHEN self_report_flag = TRUE AND sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN sla_breach = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of SLA breaches that were self-reported. A compliance culture KPI — higher self-report rates indicate proactive regulatory engagement."
$$;
