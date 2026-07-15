-- Metric views for domain: appeal | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appeal case metrics tracking volume, cycle time, overturn rates, and expedited processing performance"
  source: "`vibe_health_insurance_v1`.`appeal`.`case`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal case (open, closed, pending, etc.)"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (medical necessity, coverage, billing, etc.)"
    - name: "appeal_priority"
      expr: appeal_priority
      comment: "Priority level of the appeal (standard, urgent, expedited)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (upheld, overturned, partial, etc.)"
    - name: "regulatory_tier"
      expr: regulatory_tier
      comment: "Regulatory tier of the appeal (internal, external, state, federal)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the appeal (commercial, Medicare, Medicaid, etc.)"
    - name: "filing_party_type"
      expr: filing_party_type
      comment: "Type of party filing the appeal (member, provider, authorized representative)"
    - name: "expedited_trigger"
      expr: expedited_trigger
      comment: "Whether the appeal was triggered as expedited due to clinical urgency"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_timestamp)
      comment: "Month when the appeal was filed"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month when the appeal decision was rendered"
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total number of appeal cases"
    - name: "total_overturned_appeals"
      expr: COUNT(CASE WHEN decision_type IN ('overturned', 'partial_overturn') THEN 1 END)
      comment: "Number of appeals where the original decision was overturned fully or partially"
    - name: "total_expedited_appeals"
      expr: COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END)
      comment: "Number of appeals processed on an expedited basis due to clinical urgency"
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type IN ('overturned', 'partial_overturn') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals that resulted in overturning the original decision - key quality and fairness indicator"
    - name: "expedited_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_trigger = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals processed as expedited - indicates clinical urgency prevalence"
    - name: "avg_review_cycle_days"
      expr: AVG(CAST(appeal_review_cycle_days AS DOUBLE))
      comment: "Average number of days to complete appeal review - key operational efficiency metric"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members with appeals - indicates member experience issues"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers involved in appeals - indicates provider friction points"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal timeline and SLA compliance metrics tracking regulatory adherence and operational performance"
  source: "`vibe_health_insurance_v1`.`appeal`.`timeline`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal in the timeline"
    - name: "appeal_category"
      expr: appeal_category
      comment: "Category of appeal (pre-service, post-service, concurrent)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the appeal timeline (compliant, breach, at-risk)"
    - name: "clock_type"
      expr: clock_type
      comment: "Type of regulatory clock applied (standard, expedited, external review)"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction governing the appeal timeline requirements"
    - name: "sla_breach"
      expr: sla_breach
      comment: "Whether the appeal breached its SLA timeline"
    - name: "breach_flag"
      expr: breach_flag
      comment: "Flag indicating a regulatory timeline breach occurred"
    - name: "priority"
      expr: priority
      comment: "Priority level of the appeal"
    - name: "filed_month"
      expr: DATE_TRUNC('MONTH', appeal_filed_timestamp)
      comment: "Month when the appeal was filed"
  measures:
    - name: "total_timelines"
      expr: COUNT(1)
      comment: "Total number of appeal timeline records"
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach = TRUE THEN 1 END)
      comment: "Number of appeals that breached their SLA timeline - critical compliance metric"
    - name: "total_regulatory_breaches"
      expr: COUNT(CASE WHEN breach_flag = TRUE THEN 1 END)
      comment: "Number of appeals with regulatory timeline breaches - indicates compliance risk"
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals breaching SLA - key operational quality and regulatory compliance indicator"
    - name: "regulatory_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals with regulatory breaches - critical for audit and penalty risk assessment"
    - name: "avg_sla_target_days"
      expr: AVG(CAST(sla_target_days AS DOUBLE))
      comment: "Average SLA target days across appeals - indicates regulatory timeline requirements"
    - name: "avg_sla_actual_days"
      expr: AVG(CAST(sla_actual_days AS DOUBLE))
      comment: "Average actual days to complete appeals - key operational performance metric"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average number of days appeals are overdue when breached - indicates severity of compliance issues"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External independent review organization (IRO) metrics tracking escalation volume, outcomes, and regulatory compliance"
  source: "`vibe_health_insurance_v1`.`appeal`.`review`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_external_reviews"
      expr: COUNT(1)
      comment: "Total number of external reviews - indicates escalation volume and potential quality issues"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory penalty and fine metrics tracking compliance violations, financial impact, and appeal outcomes"
  source: "`vibe_health_insurance_v1`.`appeal`.`penalty`"
  dimensions:
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty (assessed, paid, appealed, waived)"
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty (fine, sanction, corrective action)"
    - name: "penalty_category"
      expr: penalty_category
      comment: "Category of penalty (timeliness, quality, access, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the penalty (minor, moderate, major, critical)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body that assessed the penalty (state DOI, CMS, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the penalty (unpaid, paid, disputed)"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed against the penalty"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the penalty appeal (upheld, reduced, overturned)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the penalty is related to a compliance violation"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_timestamp)
      comment: "Month when the penalty was assessed"
  measures:
    - name: "total_penalties"
      expr: COUNT(1)
      comment: "Total number of regulatory penalties assessed - indicates compliance performance"
    - name: "total_penalty_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of penalties assessed - direct financial impact of compliance violations"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest accrued on unpaid penalties"
    - name: "total_amount_with_interest"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total penalty amount including interest - full financial exposure"
    - name: "total_appealed_penalties"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of penalties that were appealed"
    - name: "total_overturned_penalties"
      expr: COUNT(CASE WHEN appeal_outcome = 'overturned' THEN 1 END)
      comment: "Number of penalties successfully overturned on appeal"
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of penalties that were appealed - indicates dispute rate"
    - name: "appeal_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome = 'overturned' THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of appealed penalties that were overturned - indicates validity of original assessments"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average penalty amount per violation - indicates typical severity"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse determination metrics tracking denial volume, appeal eligibility, outcomes, and financial impact"
  source: "`vibe_health_insurance_v1`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "determination_status"
      expr: determination_status
      comment: "Current status of the adverse determination"
    - name: "determination_type"
      expr: determination_type
      comment: "Type of adverse determination (denial, reduction, termination)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code for the reason of denial"
    - name: "basis_of_denial"
      expr: basis_of_denial
      comment: "Basis for the adverse determination (medical necessity, coverage, etc.)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed against the determination"
    - name: "appeal_outcome"
      expr: appeal_outcome
      comment: "Outcome of the appeal (upheld, overturned, modified)"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the determination is eligible for appeal"
    - name: "network_status"
      expr: network_status
      comment: "Network status of the service (in-network, out-of-network)"
    - name: "prior_authorization_required_flag"
      expr: prior_authorization_required_flag
      comment: "Whether prior authorization was required for the service"
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Month when the adverse determination was made"
  measures:
    - name: "total_adverse_determinations"
      expr: COUNT(1)
      comment: "Total number of adverse determinations - indicates denial volume and potential access issues"
    - name: "total_denied_amount"
      expr: SUM(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Total monetary amount denied - direct financial impact on members and providers"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(monetary_amount_adjusted AS DOUBLE))
      comment: "Total monetary amount adjusted after appeal - financial impact of overturns"
    - name: "total_appealable_determinations"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of adverse determinations eligible for appeal"
    - name: "total_appeals_filed"
      expr: COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END)
      comment: "Number of adverse determinations where an appeal was filed"
    - name: "total_overturned_determinations"
      expr: COUNT(CASE WHEN appeal_outcome IN ('overturned', 'modified') THEN 1 END)
      comment: "Number of adverse determinations overturned or modified on appeal"
    - name: "appeal_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of appealable determinations where appeal was filed - indicates member/provider engagement"
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_outcome IN ('overturned', 'modified') THEN 1 END) / NULLIF(COUNT(CASE WHEN appeal_filed_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of appealed determinations that were overturned - key quality indicator for initial decision accuracy"
    - name: "avg_denied_amount"
      expr: AVG(CAST(monetary_amount_denied AS DOUBLE))
      comment: "Average amount denied per adverse determination"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members with adverse determinations - indicates member experience impact"
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal outcome metrics tracking resolution types, financial impact, and downstream actions"
  source: "`vibe_health_insurance_v1`.`appeal`.`outcome`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Status of the appeal outcome"
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of outcome (upheld, overturned, partial, withdrawn)"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized code for the outcome reason"
    - name: "downstream_action"
      expr: downstream_action
      comment: "Downstream action triggered by the outcome (payment, denial, referral)"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for the appeal outcome"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the appeal"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the outcome is compliant with regulatory requirements"
    - name: "outcome_month"
      expr: DATE_TRUNC('MONTH', timestamp)
      comment: "Month when the outcome was recorded"
  measures:
    - name: "total_outcomes"
      expr: COUNT(1)
      comment: "Total number of appeal outcomes"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of appeal outcomes - direct cost of overturns and adjustments"
    - name: "total_overturned_outcomes"
      expr: COUNT(CASE WHEN outcome_type IN ('overturned', 'partial') THEN 1 END)
      comment: "Number of outcomes where original decision was overturned fully or partially"
    - name: "total_upheld_outcomes"
      expr: COUNT(CASE WHEN outcome_type = 'upheld' THEN 1 END)
      comment: "Number of outcomes where original decision was upheld"
    - name: "overturn_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_type IN ('overturned', 'partial') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outcomes that overturned the original decision - key quality metric"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per appeal outcome"
    - name: "distinct_cases"
      expr: COUNT(DISTINCT case_id)
      comment: "Number of unique appeal cases with outcomes"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members with appeal outcomes"
$$;
