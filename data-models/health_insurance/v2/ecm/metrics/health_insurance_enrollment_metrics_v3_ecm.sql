-- Metric views for domain: enrollment | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment eligibility span metrics tracking active coverage, retroactive adjustments, and premium exposure across health plans, employer groups, and lines of business. Used by enrollment operations and finance leadership to monitor coverage population and financial risk."
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan identifier for segmenting eligibility spans by plan offering."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange) for population segmentation."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (Medical, Dental, Vision, etc.) for benefit-level analysis."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (Active, Terminated, Pending) for operational monitoring."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel through which enrollment was initiated (EDI, Exchange, Manual, etc.)."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (New, Renewal, Termination, Reinstatement) for lifecycle analysis."
    - name: "group_id"
      expr: group_id
      comment: "Employer group identifier for group-level enrollment reporting."
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Flag indicating whether this span represents the member's primary coverage."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flag indicating whether a retroactive adjustment was applied to this span."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of coverage effective date for trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of coverage termination for churn trend analysis."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual enrollment cycle reporting."
    - name: "subscriber_relationship"
      expr: subscriber_relationship
      comment: "Relationship of the member to the subscriber (Self, Spouse, Dependent) for demographic segmentation."
    - name: "enrollment_eligibility_span_status"
      expr: enrollment_eligibility_span_status
      comment: "Operational status of the eligibility span record for workflow monitoring."
  measures:
    - name: "total_active_eligibility_spans"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' THEN enrollment_eligibility_span_id END)
      comment: "Total number of active eligibility spans representing currently covered members. Core population metric used by actuaries and enrollment operations to size the insured book of business."
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total eligibility span records across all statuses. Baseline volume metric for enrollment operations capacity planning."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Sum of member deductible amounts across all eligibility spans. Used by finance and actuarial teams to assess member cost-sharing exposure and plan design impact."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average member deductible amount per eligibility span. Benchmarks plan design competitiveness and member financial burden."
    - name: "total_oop_maximum"
      expr: SUM(CAST(oop_maximum AS DOUBLE))
      comment: "Sum of out-of-pocket maximum amounts across all eligibility spans. Measures total member financial protection ceiling and regulatory compliance with ACA OOP limits."
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum per eligibility span. Used to benchmark plan design against market and regulatory standards."
    - name: "total_moop_threshold"
      expr: SUM(CAST(moop_threshold AS DOUBLE))
      comment: "Sum of Medicare out-of-pocket threshold amounts. Critical for Medicare Advantage plan compliance and financial reserve calculations."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Sum of coverage limit amounts across all spans. Measures total benefit exposure for actuarial and financial planning."
    - name: "retroactive_adjustment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility spans with retroactive adjustments applied. High rates signal data quality or operational process issues requiring leadership intervention."
    - name: "waiver_applied_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_waiver_applied = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility spans where a waiver was applied. Tracks regulatory waiver utilization for compliance reporting."
    - name: "primary_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_coverage = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spans representing primary coverage. Used to understand coordination of benefits exposure and dual-coverage population size."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique subscribers with at least one eligibility span. Core membership headcount metric for executive dashboards and regulatory filings."
    - name: "distinct_groups_enrolled"
      expr: COUNT(DISTINCT group_id)
      comment: "Count of distinct employer groups with active enrollment. Measures breadth of employer client base for sales and account management leadership."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment transaction processing metrics tracking volume, financial impact, retroactive adjustments, and processing efficiency. Used by enrollment operations, finance, and compliance leadership to monitor transaction throughput and financial accuracy."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current processing status of the transaction (Pending, Processed, Failed, Cancelled)."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment action (New, Renewal, Termination, Reinstatement, Change) for lifecycle analysis."
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin channel of the enrollment transaction for source attribution analysis."
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Type of health plan associated with the transaction (HMO, PPO, EPO, HDHP, etc.)."
    - name: "processing_status"
      expr: processing_status
      comment: "Operational processing status for workflow monitoring and SLA tracking."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flag indicating whether the transaction involves a retroactive adjustment."
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Flag indicating whether the transaction has a financial impact requiring billing adjustment."
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Type of coverage period (Annual, Short-Term, COBRA, etc.) for segmentation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of transaction effective date for trend analysis."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the transaction was created for volume trend reporting."
    - name: "group_id"
      expr: group_id
      comment: "Employer group associated with the transaction for group-level reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the transaction for regulatory monitoring."
    - name: "is_grace_period"
      expr: is_grace_period
      comment: "Flag indicating whether the transaction falls within a grace period."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total enrollment transaction volume. Baseline throughput metric for enrollment operations capacity planning and SLA monitoring."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross premium amounts across all enrollment transactions. Core financial metric for revenue recognition and billing reconciliation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net premium amounts after adjustments. Used by finance leadership for accurate revenue reporting and forecasting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of adjustment amounts applied across transactions. Measures financial correction volume for audit and reconciliation purposes."
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net premium amount per transaction. Benchmarks per-member premium yield and detects anomalies in pricing application."
    - name: "retroactive_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions involving retroactive adjustments. High rates indicate enrollment data quality issues or late-reporting problems requiring operational intervention."
    - name: "financial_impact_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_impact_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with financial impact. Used by finance to size billing adjustment workload and assess revenue volatility."
    - name: "grace_period_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_grace_period = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions in grace period status. Elevated rates signal premium collection risk and potential lapse exposure."
    - name: "distinct_members_transacted"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with enrollment transactions. Measures breadth of enrollment activity for operational planning."
    - name: "claims_reprocess_transaction_count"
      expr: COUNT(CASE WHEN claims_reprocess_flag = TRUE THEN transaction_id END)
      comment: "Number of transactions triggering claims reprocessing. High counts indicate enrollment corrections with downstream claims cost impact requiring executive attention."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment batch processing performance and quality metrics. Used by enrollment operations and IT leadership to monitor batch throughput, error rates, and processing efficiency for SLA compliance and capacity planning."
  source: "`vibe_health_insurance_v1`.`enrollment`.`batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the enrollment batch (Pending, Processing, Completed, Failed) for operational monitoring."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of enrollment batch (EDI, Manual, Exchange, Retroactive) for source attribution."
    - name: "source"
      expr: source
      comment: "Source system that originated the batch for integration monitoring."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag indicating whether the batch contains retroactive enrollment changes."
    - name: "is_auto"
      expr: is_auto
      comment: "Flag indicating whether the batch was automatically generated vs. manually submitted."
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating whether the batch is a test submission (exclude from production metrics)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the batch for governance monitoring."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month of batch effective date for trend analysis."
    - name: "load_timestamp_month"
      expr: DATE_TRUNC('MONTH', load_timestamp)
      comment: "Month the batch was loaded for processing volume trend reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the batch for queue management analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of enrollment batches processed. Baseline throughput metric for operations capacity planning."
    - name: "total_enrollments_processed"
      expr: SUM(CAST(total_enrollments AS DOUBLE))
      comment: "Sum of enrollment records processed across all batches. Core volume metric for enrollment operations and regulatory reporting."
    - name: "total_terminations_processed"
      expr: SUM(CAST(total_terminations AS DOUBLE))
      comment: "Sum of termination records processed across all batches. Tracks membership attrition volume for retention and financial planning."
    - name: "total_reinstatements_processed"
      expr: SUM(CAST(total_reinstatements AS DOUBLE))
      comment: "Sum of reinstatement records processed. Measures recovery of lapsed members for retention program effectiveness."
    - name: "total_adjustments_processed"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Sum of adjustment records processed across all batches. High volumes indicate data quality issues requiring operational intervention."
    - name: "total_errors"
      expr: SUM(CAST(error_count AS DOUBLE))
      comment: "Sum of error records across all batches. Critical quality metric — high error counts signal integration or data quality failures requiring immediate attention."
    - name: "total_successes"
      expr: SUM(CAST(success_count AS DOUBLE))
      comment: "Sum of successfully processed records across all batches. Measures effective enrollment throughput."
    - name: "batch_error_rate"
      expr: ROUND(100.0 * SUM(CAST(error_count AS DOUBLE)) / NULLIF(SUM(CAST(total_enrollments AS DOUBLE)) + SUM(CAST(total_terminations AS DOUBLE)) + SUM(CAST(total_adjustments AS DOUBLE)), 0), 2)
      comment: "Percentage of batch records resulting in errors. Key quality KPI — elevated rates trigger operational escalation and vendor/system investigations."
    - name: "avg_processing_duration_seconds"
      expr: AVG(CAST(processing_duration_seconds AS DOUBLE))
      comment: "Average batch processing duration in seconds. SLA performance metric used by IT and operations leadership to identify processing bottlenecks."
    - name: "retroactive_batch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retroactive = TRUE THEN batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches containing retroactive enrollment changes. High rates indicate enrollment data latency issues with downstream financial and claims impact."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS enrollment submission quality, compliance, and financial metrics. Used by compliance, finance, and enrollment leadership to monitor regulatory submission accuracy, risk adjustment impact, and premium reconciliation with CMS."
  source: "`vibe_health_insurance_v1`.`enrollment`.`cms_submission`"
  dimensions:
    - name: "enrollment_cms_submission_status"
      expr: enrollment_cms_submission_status
      comment: "Current status of the CMS submission (Accepted, Rejected, Pending, Error) for compliance monitoring."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (Initial, Correction, Cancellation) for regulatory reporting."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the submission for operational workflow monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the submission has a compliance issue requiring remediation."
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Flag indicating whether the submission has risk adjustment implications."
    - name: "is_test_submission"
      expr: is_test_submission
      comment: "Flag to exclude test submissions from production compliance metrics."
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan identifier for plan-level CMS submission reporting."
    - name: "submission_timestamp_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for trend analysis of CMS filing activity."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of coverage effective date for enrollment period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts for multi-currency reporting."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total CMS submission records. Baseline volume metric for regulatory filing compliance tracking."
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Sum of total premium amounts across all CMS submissions. Core financial metric for CMS reconciliation and revenue recognition."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts after adjustments across CMS submissions. Used for financial reconciliation with CMS payment reports."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of adjustment amounts applied in CMS submissions. Measures correction volume for audit and compliance purposes."
    - name: "avg_raf_score_impact"
      expr: AVG(CAST(raf_score_impact AS DOUBLE))
      comment: "Average risk adjustment factor score impact per submission. Critical for Medicare Advantage revenue forecasting and risk adjustment program effectiveness."
    - name: "total_raf_score_impact"
      expr: SUM(CAST(raf_score_impact AS DOUBLE))
      comment: "Sum of RAF score impacts across all submissions. Measures total risk adjustment revenue effect for actuarial and finance planning."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across CMS submissions. Low scores indicate systemic data issues that risk CMS rejection and revenue loss."
    - name: "compliance_issue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN cms_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CMS submissions flagged for compliance issues. Regulatory KPI — elevated rates trigger compliance remediation and potential CMS audit risk."
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_cms_submission_status = 'Rejected' THEN cms_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CMS submissions rejected. High rejection rates directly impact premium revenue and require immediate operational and compliance response."
    - name: "risk_adjustment_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN cms_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with risk adjustment implications. Used by actuarial and finance teams to size risk adjustment revenue exposure."
    - name: "distinct_members_submitted"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members included in CMS submissions. Measures regulatory filing coverage breadth for compliance completeness assessment."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_exchange_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ACA marketplace exchange enrollment metrics tracking effectuation rates, subsidy utilization, premium collection, and renewal performance. Used by exchange operations, finance, and compliance leadership to manage marketplace book of business."
  source: "`vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Pending Effectuation) for population monitoring."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of exchange enrollment (New, Renewal, SEP, Auto-Renewal) for lifecycle analysis."
    - name: "effectuation_status"
      expr: effectuation_status
      comment: "Effectuation status indicating whether the enrollment has been confirmed with first premium payment."
    - name: "marketplace_state"
      expr: marketplace_state
      comment: "State marketplace where the enrollment originated for geographic analysis."
    - name: "marketplace_source"
      expr: marketplace_source
      comment: "Source marketplace (FFM, SBM, SHOP) for channel attribution."
    - name: "marketplace_year"
      expr: marketplace_year
      comment: "Plan year of the marketplace enrollment for annual cycle reporting."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage elected on the exchange for benefit analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Premium payment status for revenue collection monitoring."
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant for subsidy program analysis."
    - name: "enrollment_renewal_indicator"
      expr: enrollment_renewal_indicator
      comment: "Flag indicating whether this is a renewal enrollment for retention analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of enrollment effective date for trend analysis."
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan identifier for plan-level exchange enrollment reporting."
    - name: "tax_credit_reconciliation_status"
      expr: tax_credit_reconciliation_status
      comment: "APTC tax credit reconciliation status for IRS reporting compliance."
  measures:
    - name: "total_exchange_enrollments"
      expr: COUNT(1)
      comment: "Total exchange enrollment records. Baseline marketplace volume metric for exchange operations and regulatory reporting."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Sum of gross premium amounts across exchange enrollments. Core revenue metric for marketplace financial planning and CMS reconciliation."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Sum of Advanced Premium Tax Credit amounts. Measures federal subsidy exposure and ACA compliance obligations."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Sum of total subsidy amounts (APTC + CSR) across exchange enrollments. Used by finance to track federal subsidy receivables."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per exchange enrollment. Benchmarks marketplace pricing competitiveness and actuarial adequacy."
    - name: "avg_aptc_amount"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC subsidy per exchange enrollment. Measures subsidy dependency of the marketplace population for financial risk assessment."
    - name: "effectuation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectuation_status = 'Effectuated' THEN exchange_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exchange enrollments that have been effectuated (first premium paid). Critical revenue conversion metric — low rates signal premium collection failures and membership shortfalls."
    - name: "renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_renewal_indicator = TRUE THEN exchange_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exchange enrollments that are renewals. Key retention metric for marketplace membership stability and revenue predictability."
    - name: "reporting_1095a_count"
      expr: COUNT(CASE WHEN reporting_1095a_flag = TRUE THEN exchange_enrollment_id END)
      comment: "Count of enrollments requiring 1095-A tax form generation. Regulatory compliance metric for ACA reporting obligations."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members enrolled through the exchange. Core marketplace membership headcount for executive and regulatory reporting."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open enrollment period performance metrics tracking volume targets, compliance status, and enrollment window management. Used by enrollment leadership and compliance to evaluate OEP effectiveness and regulatory adherence."
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "open_enrollment_period_status"
      expr: open_enrollment_period_status
      comment: "Current status of the open enrollment period (Active, Closed, Upcoming) for operational monitoring."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment period (Annual, Special, Medicare AEP, etc.) for segmentation."
    - name: "lob"
      expr: lob
      comment: "Line of business for the enrollment period (Commercial, Medicare, Medicaid, Exchange)."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Exchange type (FFM, SBM, Off-Exchange) for marketplace segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the enrollment period for compliance monitoring."
    - name: "is_annual"
      expr: is_annual
      comment: "Flag indicating whether this is an annual open enrollment period."
    - name: "volume_target_met"
      expr: volume_target_met
      comment: "Flag indicating whether the enrollment volume target was achieved."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Flag indicating whether a regulatory filing is required for this period."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the enrollment period started for calendar analysis."
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan identifier for plan-level enrollment period reporting."
  measures:
    - name: "total_enrollment_periods"
      expr: COUNT(1)
      comment: "Total number of open enrollment periods. Baseline metric for enrollment calendar management."
    - name: "total_volume_actual"
      expr: SUM(CAST(volume_actual AS DOUBLE))
      comment: "Sum of actual enrollment volumes achieved across all open enrollment periods. Core performance metric for enrollment operations and sales leadership."
    - name: "total_volume_target"
      expr: SUM(CAST(volume_target AS DOUBLE))
      comment: "Sum of enrollment volume targets across all open enrollment periods. Used as denominator for target attainment calculations."
    - name: "volume_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(volume_actual AS DOUBLE)) / NULLIF(SUM(CAST(volume_target AS DOUBLE)), 0), 2)
      comment: "Percentage of enrollment volume target achieved across open enrollment periods. Strategic KPI for enrollment leadership — below-target rates trigger sales and marketing interventions."
    - name: "target_met_period_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN volume_target_met = TRUE THEN open_enrollment_period_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollment periods that met their volume target. Measures enrollment program effectiveness for executive reporting."
    - name: "regulatory_filing_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_filing_required = TRUE THEN open_enrollment_period_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollment periods requiring regulatory filings. Used by compliance to size regulatory reporting workload."
    - name: "avg_volume_actual"
      expr: AVG(CAST(volume_actual AS DOUBLE))
      comment: "Average actual enrollment volume per open enrollment period. Benchmarks period performance for planning future enrollment campaigns."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_pend_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment pend queue operational metrics tracking resolution rates, SLA compliance, escalation patterns, and issue type distribution. Used by enrollment operations leadership to manage queue health and identify systemic enrollment processing issues."
  source: "`vibe_health_insurance_v1`.`enrollment`.`pend_queue`"
  dimensions:
    - name: "pend_status"
      expr: pend_status
      comment: "Current status of the pended enrollment record (Open, Resolved, Escalated, Cancelled)."
    - name: "pend_reason_code"
      expr: pend_reason_code
      comment: "Reason code for the pend action for root cause analysis and issue categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pended item for queue management and SLA monitoring."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for items requiring management attention."
    - name: "sla_compliance_status"
      expr: sla_compliance_status
      comment: "SLA compliance status (Met, Breached, At Risk) for service level monitoring."
    - name: "resolver_team"
      expr: resolver_team
      comment: "Team responsible for resolving the pended item for workload distribution analysis."
    - name: "is_manual_review_required"
      expr: is_manual_review_required
      comment: "Flag indicating whether manual review is required, impacting staffing needs."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the pended item has compliance implications."
    - name: "pend_timestamp_month"
      expr: DATE_TRUNC('MONTH', pend_timestamp)
      comment: "Month the item was pended for trend analysis of queue volume."
    - name: "group_id"
      expr: group_id
      comment: "Employer group associated with the pended item for group-level issue tracking."
  measures:
    - name: "total_pended_items"
      expr: COUNT(1)
      comment: "Total pended enrollment items. Baseline queue volume metric for operations staffing and capacity planning."
    - name: "open_pend_count"
      expr: COUNT(CASE WHEN pend_status = 'Open' THEN pend_queue_id END)
      comment: "Count of currently open pended items. Real-time queue depth metric for operations management — high counts signal processing backlogs."
    - name: "escalated_pend_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN pend_queue_id END)
      comment: "Count of pended items that have been escalated. Measures severity of unresolved enrollment issues requiring management intervention."
    - name: "auto_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto_resolved = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items resolved automatically without manual intervention. Higher rates indicate effective automation and lower operational cost."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_status = 'Breached' THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items where SLA was breached. Critical operational KPI — high breach rates trigger staffing and process improvement actions."
    - name: "compliance_pend_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items with compliance implications. Elevated rates signal regulatory risk requiring compliance leadership attention."
    - name: "manual_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_review_required = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items requiring manual review. Drives staffing model for enrollment operations and automation investment decisions."
    - name: "avg_sla_target_days"
      expr: AVG(CAST(sla_target_days AS DOUBLE))
      comment: "Average SLA target days across pended items. Used to benchmark resolution time commitments against actual performance."
    - name: "avg_sla_actual_days"
      expr: AVG(CAST(sla_actual_days AS DOUBLE))
      comment: "Average actual days to resolve pended items. Compared against SLA targets to measure operational efficiency and identify process bottlenecks."
    - name: "documentation_missing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_documentation_missing_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items due to missing documentation. High rates indicate member communication or broker submission quality issues."
    - name: "cms_match_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cms_match_failure_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pended items due to CMS data match failures. Regulatory risk metric — high rates indicate eligibility data integrity issues with CMS."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid eligibility determination and population metrics tracking dual eligibility, income verification, and redetermination compliance. Used by Medicaid program leadership and compliance to manage state program obligations and member eligibility accuracy."
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current Medicaid eligibility status (Active, Terminated, Pending, Denied) for population monitoring."
    - name: "eligibility_category"
      expr: eligibility_category
      comment: "Medicaid eligibility category (MAGI, SSI, CHIP, etc.) for program segmentation."
    - name: "medicaid_program_type"
      expr: medicaid_program_type
      comment: "Type of Medicaid program (FFS, Managed Care, LTSS, etc.) for program analysis."
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Flag indicating dual Medicare-Medicaid eligibility for D-SNP and coordination of benefits analysis."
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Status of income verification for eligibility determination quality monitoring."
    - name: "state_agency"
      expr: state_agency
      comment: "State Medicaid agency for multi-state program reporting."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of Medicaid enrollment (State Agency, Exchange, Auto-Enrollment) for channel analysis."
    - name: "federal_program_indicator"
      expr: federal_program_indicator
      comment: "Flag indicating federal program participation for federal reporting obligations."
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan identifier for plan-level Medicaid enrollment reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of Medicaid eligibility effective date for trend analysis."
  measures:
    - name: "total_medicaid_eligibility_records"
      expr: COUNT(1)
      comment: "Total Medicaid eligibility records. Baseline population metric for Medicaid program management and state reporting."
    - name: "active_medicaid_members"
      expr: COUNT(CASE WHEN eligibility_status = 'Active' THEN medicaid_eligibility_id END)
      comment: "Count of currently active Medicaid members. Core population metric for capitation payment calculations and state contract compliance."
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN medicaid_eligibility_id END)
      comment: "Count of dual-eligible (Medicare and Medicaid) members. Critical for D-SNP program sizing, coordination of benefits management, and CMS reporting."
    - name: "dual_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dual_eligible_flag = TRUE THEN medicaid_eligibility_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Medicaid members who are dual-eligible. Drives D-SNP program investment decisions and care coordination resource allocation."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across Medicaid members. Measures income profile of Medicaid population for program design and subsidy planning."
    - name: "avg_income_amount"
      expr: AVG(CAST(income_amount AS DOUBLE))
      comment: "Average income amount of Medicaid members. Used for eligibility category analysis and program financial planning."
    - name: "redetermination_due_count"
      expr: COUNT(CASE WHEN redetermination_due_date <= CURRENT_DATE() AND eligibility_status = 'Active' THEN medicaid_eligibility_id END)
      comment: "Count of active members with overdue redeterminations. Regulatory compliance metric — high counts risk state contract violations and CMS audit findings."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with Medicaid eligibility records. Core Medicaid membership headcount for state reporting and capitation calculations."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying life event (QLE) and special enrollment period (SEP) metrics tracking verification rates, denial patterns, and SEP window compliance. Used by enrollment operations and compliance to manage SEP integrity and ACA regulatory requirements."
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of qualifying life event (Marriage, Birth, Job Loss, Move, etc.) for SEP category analysis."
  measures:
    - name: "total_qualifying_life_events"
      expr: COUNT(1)
      comment: "Total qualifying life event records. Baseline SEP volume metric for enrollment operations planning."
    - name: "distinct_members_with_qle"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of unique members with qualifying life events. Measures SEP-eligible population size for enrollment capacity planning."
$$;


CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment reconciliation metrics tracking discrepancy volumes, financial impact, and resolution efficiency. Used by enrollment operations and finance leadership to monitor data integrity between health plan and employer group enrollment records."
  source: "`vibe_health_insurance_v1`.`enrollment`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation run (Pending, In Progress, Completed, Failed)."
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (Monthly, Quarterly, Ad-Hoc, Annual) for cycle analysis."
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Flag indicating whether discrepancies were automatically resolved."
    - name: "manual_resolution_flag"
      expr: manual_resolution_flag
      comment: "Flag indicating whether manual intervention was required for resolution."
    - name: "group_id"
      expr: group_id
      comment: "Employer group identifier for group-level reconciliation reporting."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month of reconciliation period start for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial impact amounts for multi-currency reporting."
  measures:
    - name: "total_reconciliation_runs"
      expr: COUNT(1)
      comment: "Total reconciliation runs executed. Baseline metric for reconciliation program activity."
    - name: "total_discrepancies"
      expr: SUM(CAST(discrepancy_total_count AS DOUBLE))
      comment: "Sum of total discrepancies identified across all reconciliation runs. Core data quality metric — high volumes indicate enrollment data integrity issues between health plan and employer records."
    - name: "total_add_discrepancies"
      expr: SUM(CAST(discrepancy_add_count AS DOUBLE))
      comment: "Sum of add discrepancies (members on employer records but not health plan). Measures enrollment under-reporting risk."
    - name: "total_termination_discrepancies"
      expr: SUM(CAST(discrepancy_termination_count AS DOUBLE))
      comment: "Sum of termination discrepancies (members terminated on one system but not the other). Measures premium overpayment risk and coverage liability exposure."
    - name: "total_demographic_mismatch_discrepancies"
      expr: SUM(CAST(discrepancy_demographic_mismatch_count AS DOUBLE))
      comment: "Sum of demographic mismatch discrepancies. Measures member identity data quality issues affecting claims processing and eligibility verification."
    - name: "total_financial_impact_net"
      expr: SUM(CAST(financial_impact_net AS DOUBLE))
      comment: "Sum of net financial impact from reconciliation adjustments. Measures total premium correction value for finance and billing leadership."
    - name: "total_financial_impact_gross"
      expr: SUM(CAST(financial_impact_gross AS DOUBLE))
      comment: "Sum of gross financial impact before netting. Used for full exposure assessment in reconciliation financial reporting."
    - name: "avg_discrepancy_rate_per_run"
      expr: AVG(CAST(discrepancy_total_count AS DOUBLE))
      comment: "Average number of discrepancies per reconciliation run. Benchmarks data quality trends and measures improvement from process changes."
    - name: "auto_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_resolution_flag = TRUE THEN reconciliation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation runs resolved automatically. Higher rates indicate effective automation reducing manual reconciliation cost."
    - name: "distinct_groups_reconciled"
      expr: COUNT(DISTINCT group_id)
      comment: "Count of distinct employer groups included in reconciliation runs. Measures breadth of reconciliation program coverage."
$$;
