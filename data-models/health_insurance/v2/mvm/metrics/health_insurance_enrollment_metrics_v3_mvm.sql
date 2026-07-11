-- Metric views for domain: enrollment | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 22:41:45

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment metrics tracking plan elections, premium contributions, and coverage tier distribution for strategic enrollment analysis and financial planning."
  source: "`vibe_health_insurance_v1`.`enrollment`.`plan_election`"
  dimensions:
    - name: "election_type"
      expr: election_type
      comment: "Type of plan election (new, change, renewal) for segmenting enrollment patterns"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Specific enrollment event triggering the election for event-driven analysis"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (individual, family, etc.) for premium and enrollment volume analysis"
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Current status of the plan election for pipeline and completion tracking"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel of enrollment (broker, direct, exchange) for channel effectiveness analysis"
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Premium payment frequency for cash flow and billing analysis"
    - name: "election_year"
      expr: YEAR(effective_date)
      comment: "Year of election effective date for year-over-year trend analysis"
    - name: "election_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of election effective date for seasonal pattern analysis"
    - name: "has_dental_rider"
      expr: dental_rider_flag
      comment: "Whether dental rider is elected for product mix analysis"
    - name: "has_vision_rider"
      expr: vision_rider_flag
      comment: "Whether vision rider is elected for product mix analysis"
    - name: "has_hsa"
      expr: hsa_election_flag
      comment: "Whether HSA is elected for high-deductible plan analysis"
    - name: "is_cobra"
      expr: is_cobra_eligible
      comment: "Whether election is COBRA-eligible for continuation coverage tracking"
  measures:
    - name: "total_elections"
      expr: COUNT(1)
      comment: "Total number of plan elections for enrollment volume tracking"
    - name: "total_premium_revenue"
      expr: SUM(CAST(total_premium AS DOUBLE))
      comment: "Total premium revenue across all elections for financial performance tracking"
    - name: "total_employer_contribution"
      expr: SUM(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Total employer premium contributions for employer subsidy analysis"
    - name: "total_employee_contribution"
      expr: SUM(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Total employee premium contributions for member cost burden analysis"
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium AS DOUBLE))
      comment: "Average total premium per election for pricing and competitiveness analysis"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Average employer contribution per election for employer value proposition analysis"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Average employee contribution per election for affordability assessment"
    - name: "employer_contribution_rate"
      expr: ROUND(100.0 * SUM(CAST(premium_contribution_employer AS DOUBLE)) / NULLIF(SUM(CAST(total_premium AS DOUBLE)), 0), 2)
      comment: "Employer contribution as percentage of total premium for cost-sharing strategy evaluation"
    - name: "dental_rider_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dental_rider_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with dental rider for product penetration analysis"
    - name: "vision_rider_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vision_rider_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with vision rider for product penetration analysis"
    - name: "hsa_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hsa_election_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with HSA for high-deductible plan strategy evaluation"
    - name: "cobra_election_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cobra_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of COBRA-eligible elections for continuation coverage tracking"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction metrics tracking enrollment events, financial impacts, and processing efficiency for operational excellence and revenue assurance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment transaction (new, change, termination) for lifecycle analysis"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current transaction status for processing pipeline and completion tracking"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status for operational efficiency and error tracking"
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin system or channel of enrollment for source effectiveness analysis"
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Type of health plan for product mix and portfolio analysis"
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason for termination for churn analysis and retention strategy"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of transaction for regulatory risk management"
    - name: "transaction_year"
      expr: YEAR(effective_date)
      comment: "Year of transaction effective date for year-over-year trend analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of transaction effective date for seasonal pattern analysis"
    - name: "is_retroactive"
      expr: retroactive_adjustment_flag
      comment: "Whether transaction is a retroactive adjustment for reconciliation tracking"
    - name: "has_financial_impact"
      expr: financial_impact_flag
      comment: "Whether transaction has financial impact for revenue assurance"
    - name: "requires_claims_reprocess"
      expr: claims_reprocess_flag
      comment: "Whether transaction requires claims reprocessing for operational workload planning"
    - name: "is_grace_period"
      expr: is_grace_period
      comment: "Whether transaction is in grace period for payment collection strategy"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of enrollment transactions for volume and throughput tracking"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross transaction amount for revenue tracking before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction amount for actual revenue recognition"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount for reconciliation and revenue correction tracking"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross transaction amount for transaction size analysis"
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net transaction amount for actual revenue per transaction"
    - name: "adjustment_rate"
      expr: ROUND(100.0 * SUM(CAST(adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Adjustment amount as percentage of gross for data quality and process efficiency assessment"
    - name: "retroactive_transaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retroactive transactions for process quality and timeliness tracking"
    - name: "financial_impact_transaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN financial_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with financial impact for revenue-affecting event tracking"
    - name: "claims_reprocess_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN claims_reprocess_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring claims reprocessing for operational burden assessment"
    - name: "grace_period_transaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_grace_period = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions in grace period for payment collection risk tracking"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS submission quality and compliance metrics tracking submission success rates, error patterns, and risk adjustment for regulatory reporting excellence."
  source: "`vibe_health_insurance_v1`.`enrollment`.`cms_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission for submission category analysis"
    - name: "enrollment_cms_submission_status"
      expr: enrollment_cms_submission_status
      comment: "Current submission status for processing pipeline and success tracking"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status for operational efficiency tracking"
    - name: "submission_source_system"
      expr: submission_source_system
      comment: "Source system of submission for system quality and integration analysis"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether submission passed compliance checks for regulatory quality tracking"
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Whether submission includes risk adjustment for risk score tracking"
    - name: "is_legacy_submission"
      expr: is_legacy_submission
      comment: "Whether submission is from legacy system for migration tracking"
    - name: "is_test_submission"
      expr: is_test_submission
      comment: "Whether submission is test data for production quality filtering"
    - name: "error_code"
      expr: error_code
      comment: "Error code for error pattern analysis and root cause investigation"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Rejection reason code for rejection pattern analysis"
    - name: "compliance_error_code"
      expr: compliance_error_code
      comment: "Compliance error code for regulatory issue tracking"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year of submission for year-over-year trend analysis"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for seasonal pattern analysis"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of CMS submissions for volume and throughput tracking"
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount submitted to CMS for revenue reconciliation"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after adjustments for actual CMS payment tracking"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount for reconciliation and correction tracking"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for submission quality assessment"
    - name: "avg_premium_amount"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium amount per submission for transaction size analysis"
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions passing compliance checks for regulatory quality tracking"
    - name: "risk_adjustment_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with risk adjustment for risk score program participation"
    - name: "error_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN error_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with errors for data quality and process improvement"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rejection_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected by CMS for submission quality tracking"
    - name: "legacy_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_legacy_submission = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions from legacy systems for migration progress tracking"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment reconciliation metrics tracking discrepancy patterns, financial impact, and resolution efficiency for data integrity and revenue assurance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status for pipeline and completion tracking"
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (scheduled, ad-hoc, audit) for process analysis"
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Whether discrepancies were auto-resolved for automation effectiveness tracking"
    - name: "manual_resolution_flag"
      expr: manual_resolution_flag
      comment: "Whether manual resolution was required for operational workload tracking"
    - name: "reconciliation_year"
      expr: YEAR(period_start)
      comment: "Year of reconciliation period for year-over-year trend analysis"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month of reconciliation period for seasonal pattern analysis"
  measures:
    - name: "total_reconciliation_runs"
      expr: COUNT(1)
      comment: "Total number of reconciliation runs for process frequency tracking"
    - name: "total_discrepancies"
      expr: SUM(CAST(discrepancy_total_count AS DOUBLE))
      comment: "Total number of discrepancies identified for data quality assessment"
    - name: "total_add_discrepancies"
      expr: SUM(CAST(discrepancy_add_count AS DOUBLE))
      comment: "Total number of add discrepancies for enrollment accuracy tracking"
    - name: "total_change_discrepancies"
      expr: SUM(CAST(discrepancy_change_count AS DOUBLE))
      comment: "Total number of change discrepancies for update accuracy tracking"
    - name: "total_termination_discrepancies"
      expr: SUM(CAST(discrepancy_termination_count AS DOUBLE))
      comment: "Total number of termination discrepancies for termination accuracy tracking"
    - name: "total_demographic_mismatch_discrepancies"
      expr: SUM(CAST(discrepancy_demographic_mismatch_count AS DOUBLE))
      comment: "Total number of demographic mismatch discrepancies for data quality tracking"
    - name: "total_gross_financial_impact"
      expr: SUM(CAST(financial_impact_gross AS DOUBLE))
      comment: "Total gross financial impact of discrepancies for revenue risk assessment"
    - name: "total_net_financial_impact"
      expr: SUM(CAST(financial_impact_net AS DOUBLE))
      comment: "Total net financial impact after adjustments for actual revenue correction"
    - name: "total_financial_adjustment"
      expr: SUM(CAST(financial_impact_adjustment AS DOUBLE))
      comment: "Total financial adjustment amount for reconciliation correction tracking"
    - name: "avg_discrepancies_per_run"
      expr: AVG(CAST(discrepancy_total_count AS DOUBLE))
      comment: "Average discrepancies per reconciliation run for process quality trending"
    - name: "avg_gross_financial_impact"
      expr: AVG(CAST(financial_impact_gross AS DOUBLE))
      comment: "Average gross financial impact per run for risk magnitude assessment"
    - name: "auto_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_resolution_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs with auto-resolution for automation effectiveness tracking"
    - name: "manual_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN manual_resolution_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of runs requiring manual resolution for operational burden assessment"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility verification performance metrics tracking verification success rates, response times, and benefit utilization for operational efficiency and member experience."
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility verification status for success rate and denial analysis"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage verified for product mix analysis"
    - name: "benefit_category"
      expr: benefit_category
      comment: "Category of benefit verified for benefit utilization analysis"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether authorization is required for prior auth workload tracking"
    - name: "error_code"
      expr: error_code
      comment: "Error code for error pattern analysis and system improvement"
    - name: "member_identifier_type"
      expr: member_identifier_type
      comment: "Type of member identifier used for lookup method analysis"
    - name: "verification_year"
      expr: YEAR(inquiry_timestamp)
      comment: "Year of verification inquiry for year-over-year trend analysis"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', inquiry_timestamp)
      comment: "Month of verification inquiry for seasonal pattern analysis"
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total number of eligibility verifications for volume and throughput tracking"
    - name: "total_benefit_limit"
      expr: SUM(CAST(benefit_limit AS DOUBLE))
      comment: "Total benefit limit across verifications for benefit exposure tracking"
    - name: "total_benefit_used"
      expr: SUM(CAST(benefit_used AS DOUBLE))
      comment: "Total benefit used across verifications for utilization tracking"
    - name: "total_benefit_remaining"
      expr: SUM(CAST(benefit_remaining AS DOUBLE))
      comment: "Total benefit remaining across verifications for remaining exposure tracking"
    - name: "total_deductible_remaining"
      expr: SUM(CAST(deductible_remaining AS DOUBLE))
      comment: "Total deductible remaining for member cost exposure tracking"
    - name: "total_oop_remaining"
      expr: SUM(CAST(oop_remaining AS DOUBLE))
      comment: "Total out-of-pocket remaining for member financial risk tracking"
    - name: "avg_response_time_seconds"
      expr: AVG(CAST(response_time_seconds AS DOUBLE))
      comment: "Average response time in seconds for system performance and member experience tracking"
    - name: "avg_benefit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(benefit_used AS DOUBLE)) / NULLIF(SUM(CAST(benefit_limit AS DOUBLE)), 0), 2)
      comment: "Average benefit utilization rate for benefit consumption and forecasting"
    - name: "authorization_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications requiring authorization for prior auth workload forecasting"
    - name: "verification_error_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN error_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with errors for system quality and reliability tracking"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open enrollment period performance metrics tracking enrollment volume targets, compliance status, and period effectiveness for strategic enrollment planning."
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "open_enrollment_period_status"
      expr: open_enrollment_period_status
      comment: "Current status of open enrollment period for period lifecycle tracking"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment period for period category analysis"
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (public, private) for market segment analysis"
    - name: "eligibility_segment"
      expr: eligibility_segment
      comment: "Eligibility segment for targeted enrollment analysis"
    - name: "lob"
      expr: lob
      comment: "Line of business for product portfolio analysis"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of period for regulatory adherence tracking"
    - name: "is_annual"
      expr: is_annual
      comment: "Whether period is annual open enrollment for period type analysis"
    - name: "volume_target_met"
      expr: volume_target_met
      comment: "Whether enrollment volume target was met for performance assessment"
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Whether regulatory filing is required for compliance workload tracking"
    - name: "period_year"
      expr: YEAR(start_date)
      comment: "Year of period start for year-over-year comparison"
  measures:
    - name: "total_enrollment_periods"
      expr: COUNT(1)
      comment: "Total number of open enrollment periods for period frequency tracking"
    - name: "total_volume_actual"
      expr: SUM(CAST(volume_actual AS DOUBLE))
      comment: "Total actual enrollment volume across periods for performance tracking"
    - name: "total_volume_target"
      expr: SUM(CAST(volume_target AS DOUBLE))
      comment: "Total target enrollment volume across periods for goal setting and planning"
    - name: "avg_volume_actual"
      expr: AVG(CAST(volume_actual AS DOUBLE))
      comment: "Average actual enrollment volume per period for period size analysis"
    - name: "avg_volume_target"
      expr: AVG(CAST(volume_target AS DOUBLE))
      comment: "Average target enrollment volume per period for target setting benchmarks"
    - name: "volume_target_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(volume_actual AS DOUBLE)) / NULLIF(SUM(CAST(volume_target AS DOUBLE)), 0), 2)
      comment: "Actual enrollment volume as percentage of target for performance assessment"
    - name: "target_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN volume_target_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods meeting volume targets for success rate tracking"
    - name: "regulatory_filing_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_filing_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods requiring regulatory filing for compliance workload forecasting"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying life event metrics tracking special enrollment period triggers, verification success rates, and SEP window utilization for enrollment flexibility and compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of qualifying life event for event pattern analysis"
    - name: "qualifying_life_event_status"
      expr: qualifying_life_event_status
      comment: "Current status of QLE for processing pipeline tracking"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status for approval rate and fraud prevention tracking"
    - name: "sep_category_code"
      expr: sep_category_code
      comment: "Special enrollment period category code for SEP type analysis"
    - name: "sep_window_status"
      expr: sep_window_status
      comment: "Status of SEP window for timeliness and compliance tracking"
    - name: "cms_sep_outcome"
      expr: cms_sep_outcome
      comment: "CMS special enrollment period outcome for regulatory compliance tracking"
    - name: "documentation_type"
      expr: documentation_type
      comment: "Type of documentation provided for verification process analysis"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of qualifying life event for year-over-year trend analysis"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of qualifying life event for seasonal pattern analysis"
  measures:
    - name: "total_qualifying_life_events"
      expr: COUNT(1)
      comment: "Total number of qualifying life events for SEP volume tracking"
    - name: "verification_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QLEs approved after verification for approval rate and fraud prevention tracking"
    - name: "verification_denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'Denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QLEs denied after verification for denial pattern analysis"
$$;