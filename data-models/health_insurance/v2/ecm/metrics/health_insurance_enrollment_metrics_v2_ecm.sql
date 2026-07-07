-- Metric views for domain: enrollment | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment batch processing KPIs — batch throughput, success/error rates, retroactive batch volume, and processing efficiency. Used by VP Operations and IT leadership to monitor enrollment pipeline health, SLA compliance, and data quality."
  source: "`vibe_health_insurance_v1`.`enrollment`.`batch`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Type of enrollment batch (Initial Load, Renewal, Termination, Correction) for pipeline segmentation."
    - name: "enrollment_batch_status"
      expr: enrollment_batch_status
      comment: "Current status of the batch (Pending, Processing, Completed, Failed) for operational monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the batch for governance and audit tracking."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Indicates retroactive batches — high volume signals enrollment data quality issues with financial impact."
    - name: "is_auto"
      expr: is_auto
      comment: "Distinguishes automated from manual batches for process efficiency analysis."
    - name: "is_test"
      expr: is_test
      comment: "Distinguishes test batches from production batches for accurate KPI calculation."
    - name: "source_system"
      expr: source
      comment: "Source system originating the batch for system-level quality and volume analysis."
    - name: "processing_start_month"
      expr: DATE_TRUNC('MONTH', processing_start)
      comment: "Month of batch processing start for trend analysis of enrollment pipeline volume."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Record source system for data lineage and quality monitoring."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total enrollment batches — baseline throughput KPI for enrollment operations management."
    - name: "batch_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_batch_status = 'Failed' THEN batch_id END) / NULLIF(COUNT(CASE WHEN is_test = FALSE THEN batch_id END), 0), 2)
      comment: "Percentage of production batches that failed processing — high failure rates directly impact enrollment SLAs and member coverage continuity."
    - name: "retroactive_batch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retroactive = TRUE THEN batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches that are retroactive — high rates indicate enrollment data quality problems with financial and compliance implications."
    - name: "automated_batch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto = TRUE THEN batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches processed automatically vs. manually — measures automation efficiency and operational cost reduction progress."
    - name: "batch_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches approved — used by governance teams to monitor batch approval compliance and identify bottlenecks."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS submission quality, financial, and compliance KPIs — submission success rates, RAF score impact, premium amounts, rejection analysis, and risk adjustment flags. Used by VP Compliance, CFO, and Actuarial to monitor CMS submission accuracy, revenue impact, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`cms_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (Initial, Correction, Cancellation) for submission pipeline analysis."
    - name: "enrollment_cms_submission_status"
      expr: enrollment_cms_submission_status
      comment: "Current status of the CMS submission (Accepted, Rejected, Pending) for compliance monitoring."
    - name: "processing_status"
      expr: processing_status
      comment: "Technical processing status for operational queue management."
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Indicates whether the submission includes risk adjustment data — critical for RAF revenue monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether a compliance issue was detected on the submission."
    - name: "is_test_submission"
      expr: is_test_submission
      comment: "Distinguishes test submissions from production submissions for accurate KPI calculation."
    - name: "is_legacy_submission"
      expr: is_legacy_submission
      comment: "Identifies legacy system submissions for migration tracking."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "CMS rejection reason code for root-cause analysis of submission failures."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for trend analysis of CMS submission volume and quality."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of coverage effective date for cohort-based submission analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency financial reporting."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total CMS submissions — baseline volume KPI for regulatory submission pipeline monitoring."
    - name: "total_production_submissions"
      expr: COUNT(CASE WHEN is_test_submission = FALSE THEN cms_submission_id END)
      comment: "Count of production (non-test) CMS submissions — true regulatory submission volume for compliance reporting."
    - name: "submission_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_cms_submission_status = 'Rejected' THEN cms_submission_id END) / NULLIF(COUNT(CASE WHEN is_test_submission = FALSE THEN cms_submission_id END), 0), 2)
      comment: "Percentage of production submissions rejected by CMS — high rejection rates directly impact revenue recognition and trigger regulatory scrutiny."
    - name: "compliance_error_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN cms_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions with compliance errors — used by compliance team to monitor regulatory risk and prioritize remediation."
    - name: "total_premium_amount"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Sum of total premium amounts across all CMS submissions — total premium revenue submitted to CMS, key revenue recognition metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts after adjustments — actual net premium revenue impact from CMS submissions."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of adjustment amounts — total financial impact of submission corrections, used to monitor data quality cost."
    - name: "total_raf_score_impact"
      expr: SUM(CAST(raf_score_impact AS DOUBLE))
      comment: "Sum of RAF score impacts across submissions — total risk adjustment revenue impact, critical for actuarial and CFO revenue forecasting."
    - name: "avg_raf_score_impact"
      expr: AVG(CAST(raf_score_impact AS DOUBLE))
      comment: "Average RAF score impact per submission — used by actuaries to benchmark risk adjustment performance against market norms."
    - name: "risk_adjustment_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN cms_submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions carrying risk adjustment data — used to monitor completeness of risk adjustment data submission to CMS."
    - name: "avg_premium_per_submission"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average premium amount per CMS submission — used to detect anomalies and benchmark submission value across plan years."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cobra_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cobra Election business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`cobra_election`"
  dimensions:
    - name: "Business Identifier"
      expr: business_identifier
    - name: "Classification Or Type"
      expr: classification_or_type
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Dependent Count"
      expr: dependent_count
    - name: "Early Termination Flag"
      expr: early_termination_flag
    - name: "Early Termination Notice Sent Flag"
      expr: early_termination_notice_sent_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Election Decision"
      expr: election_decision
    - name: "Election Notice Sent Flag"
      expr: election_notice_sent_flag
    - name: "Election Status"
      expr: election_status
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cobra Election"
      expr: COUNT(DISTINCT cobra_election_id)
    - name: "Total Cobra Premium Amount"
      expr: SUM(cobra_premium_amount)
    - name: "Average Cobra Premium Amount"
      expr: AVG(cobra_premium_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Edi Transaction business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`edi_transaction`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Enrollment Action Code"
      expr: enrollment_action_code
    - name: "Error Code"
      expr: error_code
    - name: "Error Description"
      expr: error_description
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
    - name: "File Name"
      expr: file_name
    - name: "File Received Timestamp"
      expr: file_received_timestamp
    - name: "Group Control Number"
      expr: group_control_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Edi Transaction"
      expr: COUNT(DISTINCT edi_transaction_id)
    - name: "Total Average Record Size Bytes"
      expr: SUM(average_record_size_bytes)
    - name: "Average Average Record Size Bytes"
      expr: AVG(average_record_size_bytes)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Verification business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`"
  dimensions:
    - name: "Authorization Number"
      expr: authorization_number
    - name: "Authorization Required"
      expr: authorization_required
    - name: "Benefit Category"
      expr: benefit_category
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Diagnosis Code"
      expr: diagnosis_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Error Code"
      expr: error_code
    - name: "Error Description"
      expr: error_description
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Verification"
      expr: COUNT(DISTINCT eligibility_verification_id)
    - name: "Total Benefit Limit"
      expr: SUM(benefit_limit)
    - name: "Average Benefit Limit"
      expr: AVG(benefit_limit)
    - name: "Total Benefit Remaining"
      expr: SUM(benefit_remaining)
    - name: "Average Benefit Remaining"
      expr: AVG(benefit_remaining)
    - name: "Total Benefit Used"
      expr: SUM(benefit_used)
    - name: "Average Benefit Used"
      expr: AVG(benefit_used)
    - name: "Total Deductible Remaining"
      expr: SUM(deductible_remaining)
    - name: "Average Deductible Remaining"
      expr: AVG(deductible_remaining)
    - name: "Total Oop Remaining"
      expr: SUM(oop_remaining)
    - name: "Average Oop Remaining"
      expr: AVG(oop_remaining)
    - name: "Total Response Time Seconds"
      expr: SUM(response_time_seconds)
    - name: "Average Response Time Seconds"
      expr: AVG(response_time_seconds)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over active eligibility spans — coverage volume, financial exposure (deductible, OOP), retroactive adjustment rates, and waiver penetration. Used by VP Enrollment and CFO to monitor covered-life counts, benefit-year financial thresholds, and compliance with retroactive adjustment policies."
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange) for segmenting covered lives and financial exposure."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (Individual, Family, Employee-Only, etc.) for premium and benefit analysis."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status (Active, Terminated, Suspended) to filter active vs. lapsed spans."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of enrollment (Exchange, Employer, Direct, Medicaid Agency) for channel attribution."
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual cohort analysis and plan-year comparisons."
    - name: "is_primary_coverage"
      expr: is_primary_coverage
      comment: "Flag indicating whether this span represents the member's primary coverage, used for COB analysis."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Indicates whether a retroactive adjustment was applied to this span, used for compliance and audit tracking."
    - name: "is_waiver_applied"
      expr: is_waiver_applied
      comment: "Indicates whether a waiver was applied to this eligibility span."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month of coverage effective start for trend analysis of new enrollments."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of coverage termination for lapse and attrition trend analysis."
    - name: "plan_code"
      expr: plan_code
      comment: "Plan code for plan-level enrollment and financial exposure segmentation."
    - name: "enrollment_eligibility_span_status"
      expr: enrollment_eligibility_span_status
      comment: "Operational status of the eligibility span record for pipeline monitoring."
  measures:
    - name: "total_active_eligibility_spans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN enrollment_eligibility_span_id END)
      comment: "Count of currently active eligibility spans — the primary covered-lives KPI used by executives to track membership volume."
    - name: "total_eligibility_spans"
      expr: COUNT(1)
      comment: "Total eligibility span records including all statuses; baseline denominator for rate calculations."
    - name: "total_deductible_exposure"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Sum of member deductible amounts across all spans — indicates total member cost-sharing exposure and informs benefit design decisions."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount per eligibility span — used by actuaries and product teams to benchmark benefit generosity across plans."
    - name: "total_oop_maximum_exposure"
      expr: SUM(CAST(oop_maximum AS DOUBLE))
      comment: "Sum of out-of-pocket maximum amounts across all spans — total member financial risk ceiling, critical for ACA compliance monitoring."
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average OOP maximum per span — used to compare plan generosity and ensure ACA OOP cap compliance."
    - name: "total_moop_threshold_exposure"
      expr: SUM(CAST(moop_threshold AS DOUBLE))
      comment: "Sum of Medicare OOP threshold amounts — key Medicare Advantage financial exposure metric for CFO and actuarial review."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Sum of coverage limit amounts across spans — total benefit liability ceiling used in actuarial reserve calculations."
    - name: "retroactive_adjustment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of eligibility spans with retroactive adjustments — high rates signal enrollment data quality issues and increase administrative cost."
    - name: "waiver_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_waiver_applied = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spans with a waiver applied — used by compliance and product teams to monitor waiver program utilization."
    - name: "primary_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_coverage = TRUE THEN enrollment_eligibility_span_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of spans designated as primary coverage — informs COB coordination workload and dual-coverage prevalence."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment Eligibility Span business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "Benefit Designation"
      expr: benefit_designation
    - name: "Benefit Period End"
      expr: benefit_period_end
    - name: "Benefit Period Start"
      expr: benefit_period_start
    - name: "Benefit Year"
      expr: benefit_year
    - name: "Coverage Category"
      expr: coverage_category
    - name: "Coverage Limit Units"
      expr: coverage_limit_units
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Deductible Reset Date"
      expr: deductible_reset_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Enrollment Eligibility Span Status"
      expr: enrollment_eligibility_span_status
    - name: "Enrollment Event Type"
      expr: enrollment_event_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Enrollment Eligibility Span"
      expr: COUNT(DISTINCT enrollment_eligibility_span_id)
    - name: "Total Coverage Limit Amount"
      expr: SUM(coverage_limit_amount)
    - name: "Average Coverage Limit Amount"
      expr: AVG(coverage_limit_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Moop Threshold"
      expr: SUM(moop_threshold)
    - name: "Average Moop Threshold"
      expr: AVG(moop_threshold)
    - name: "Total Oop Maximum"
      expr: SUM(oop_maximum)
    - name: "Average Oop Maximum"
      expr: AVG(oop_maximum)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  dimensions:
    - name: "Actor Type"
      expr: actor_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Event Description"
      expr: event_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
    - name: "Is Active"
      expr: is_active
    - name: "Is Manual"
      expr: is_manual
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Event"
      expr: COUNT(DISTINCT event_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying Life Event (QLE) and Special Enrollment Period (SEP) KPIs — QLE volume by type, SEP window compliance, documentation verification rates, and CMS SEP outcome analysis. Used by VP Enrollment and Compliance to monitor SEP eligibility integrity, CMS audit readiness, and enrollment conversion from QLEs."
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_qualifying_life_events"
      expr: COUNT(1)
      comment: "Total qualifying life events — baseline volume KPI for SEP enrollment opportunity pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_exchange_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ACA Exchange enrollment KPIs — effectuation rates, APTC/subsidy amounts, renewal rates, termination analysis, and 1095-A reporting compliance. Used by VP Enrollment, CFO, and Compliance to monitor Exchange market performance, subsidy exposure, and ACA regulatory compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Terminated, Pending Effectuation) for membership monitoring."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (New, Renewal, SEP, Auto-Renewal) for acquisition vs. retention analysis."
    - name: "effectuation_status"
      expr: effectuation_status
      comment: "Effectuation status (Effectuated, Pending, Failed) — critical for revenue recognition and CMS compliance."
    - name: "marketplace_state"
      expr: marketplace_state
      comment: "State marketplace for geographic enrollment performance analysis."
    - name: "marketplace_source"
      expr: marketplace_source
      comment: "Marketplace source (FFM, SBM, Direct) for channel attribution."
    - name: "marketplace_year"
      expr: marketplace_year
      comment: "Marketplace plan year for annual cohort analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (Individual, Family) for benefit and premium analysis."
    - name: "enrollment_renewal_indicator"
      expr: enrollment_renewal_indicator
      comment: "Indicates renewal enrollments — used to track retention rates vs. new acquisition."
    - name: "reporting_1095a_flag"
      expr: reporting_1095a_flag
      comment: "Indicates whether a 1095-A form is required — used for ACA tax reporting compliance monitoring."
    - name: "enrollment_termination_reason_code"
      expr: enrollment_termination_reason_code
      comment: "Reason for enrollment termination for attrition root-cause analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of coverage effective date for enrollment trend analysis."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (APTC, CSR, None) for subsidy program analysis."
  measures:
    - name: "total_exchange_enrollments"
      expr: COUNT(1)
      comment: "Total Exchange enrollment records — primary volume KPI for ACA marketplace performance monitoring."
    - name: "effectuated_enrollment_count"
      expr: COUNT(CASE WHEN effectuation_status = 'Effectuated' THEN exchange_enrollment_id END)
      comment: "Count of effectuated enrollments — only effectuated enrollments generate premium revenue; critical for revenue recognition."
    - name: "effectuation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectuation_status = 'Effectuated' THEN exchange_enrollment_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN exchange_enrollment_id END), 0), 2)
      comment: "Percentage of active enrollments that have been effectuated — low rates indicate premium collection risk and potential CMS compliance issues."
    - name: "renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_renewal_indicator = TRUE THEN exchange_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that are renewals — key retention metric for Exchange market strategy and member lifetime value analysis."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Sum of APTC (Advanced Premium Tax Credit) amounts — total federal subsidy exposure, critical for CFO financial planning and ACA compliance."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Sum of all subsidy amounts (APTC + CSR) — total government subsidy liability used for financial reporting and risk management."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Sum of gross premium amounts for Exchange enrollments — total Exchange premium revenue pipeline."
    - name: "avg_aptc_per_enrollment"
      expr: AVG(CAST(aptc_amount AS DOUBLE))
      comment: "Average APTC amount per enrollment — used by actuaries to benchmark subsidy levels and forecast federal reconciliation exposure."
    - name: "reporting_1095a_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reporting_1095a_flag = TRUE AND reporting_1095a_generated_date IS NOT NULL THEN exchange_enrollment_id END) / NULLIF(COUNT(CASE WHEN reporting_1095a_flag = TRUE THEN exchange_enrollment_id END), 0), 2)
      comment: "Percentage of 1095-A required enrollments with a generated form — ACA tax reporting compliance rate; failures trigger IRS penalties."
    - name: "early_termination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_termination_type = 'Early' THEN exchange_enrollment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments terminated early — high rates indicate member satisfaction issues and impact premium revenue projections."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid eligibility KPIs — dual-eligible population size, income verification rates, redetermination compliance, and ESRD/special program penetration. Used by VP Enrollment, Compliance, and Actuarial to monitor Medicaid membership, dual-eligible risk, and state agency compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current Medicaid eligibility status (Active, Terminated, Pending) for membership monitoring."
    - name: "eligibility_category"
      expr: eligibility_category
      comment: "Medicaid eligibility category (MAGI, ABD, CHIP, etc.) for program segmentation and actuarial analysis."
    - name: "medicaid_program_type"
      expr: medicaid_program_type
      comment: "Medicaid program type (FFS, Managed Care, LTSS) for program mix analysis."
    - name: "dual_eligible_flag"
      expr: dual_eligible_flag
      comment: "Indicates dual Medicare-Medicaid eligible members — high-cost, high-complexity population requiring special care management."
    - name: "income_verification_status"
      expr: income_verification_status
      comment: "Income verification status for eligibility integrity monitoring."
    - name: "federal_program_indicator"
      expr: federal_program_indicator
      comment: "Indicates federal program participation for federal reporting and funding analysis."
    - name: "state_agency"
      expr: state_agency
      comment: "State Medicaid agency for state-level compliance and performance monitoring."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of Medicaid enrollment for channel analysis."
    - name: "eligibility_determination_month"
      expr: DATE_TRUNC('MONTH', eligibility_determination_timestamp)
      comment: "Month of eligibility determination for trend analysis of Medicaid enrollment volume."
    - name: "redetermination_due_month"
      expr: DATE_TRUNC('MONTH', redetermination_due_date)
      comment: "Month redetermination is due — used to forecast redetermination workload and compliance risk."
  measures:
    - name: "total_medicaid_eligibility_records"
      expr: COUNT(1)
      comment: "Total Medicaid eligibility records — baseline Medicaid membership volume KPI."
    - name: "active_medicaid_members"
      expr: COUNT(CASE WHEN is_active = TRUE THEN medicaid_eligibility_id END)
      comment: "Count of currently active Medicaid members — primary Medicaid covered-lives KPI for state reporting and capitation rate setting."
    - name: "dual_eligible_count"
      expr: COUNT(CASE WHEN dual_eligible_flag = TRUE THEN medicaid_eligibility_id END)
      comment: "Count of dual Medicare-Medicaid eligible members — critical population for care management investment and risk adjustment strategy."
    - name: "dual_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dual_eligible_flag = TRUE THEN medicaid_eligibility_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN medicaid_eligibility_id END), 0), 2)
      comment: "Percentage of active Medicaid members who are dual-eligible — high rates indicate elevated care management cost and risk adjustment opportunity."
    - name: "income_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN income_verification_status = 'Verified' THEN medicaid_eligibility_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Medicaid eligibility records with verified income — low rates indicate eligibility integrity risk and potential state audit exposure."
    - name: "total_income_amount"
      expr: SUM(CAST(income_amount AS DOUBLE))
      comment: "Sum of reported income amounts across Medicaid eligibility records — used for FPL analysis and program eligibility benchmarking."
    - name: "avg_fpl_percentage"
      expr: AVG(CAST(fpl_percentage AS DOUBLE))
      comment: "Average Federal Poverty Level percentage across Medicaid members — used to characterize the income profile of the Medicaid population for actuarial and policy analysis."
    - name: "redetermination_overdue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN redetermination_due_date < CURRENT_DATE AND is_active = TRUE THEN medicaid_eligibility_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN medicaid_eligibility_id END), 0), 2)
      comment: "Percentage of active Medicaid members with overdue redeterminations — high rates indicate compliance risk with state and federal Medicaid requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicare_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Entitlement business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement`"
  dimensions:
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Span End"
      expr: eligibility_span_end
    - name: "Eligibility Span Start"
      expr: eligibility_span_start
    - name: "Entitlement Number"
      expr: entitlement_number
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Entitlement Type"
      expr: entitlement_type
    - name: "Extra Help Effective Date"
      expr: extra_help_effective_date
    - name: "Extra Help Status"
      expr: extra_help_status
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Medicare Entitlement"
      expr: COUNT(DISTINCT medicare_entitlement_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Enrollment Period business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Score"
      expr: data_quality_score
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Segment"
      expr: eligibility_segment
    - name: "End Date"
      expr: end_date
    - name: "Enrollment Cutoff Time"
      expr: enrollment_cutoff_time
    - name: "Enrollment Deadline Date"
      expr: enrollment_deadline_date
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Exchange Type"
      expr: exchange_type
    - name: "Fhir Last Updated"
      expr: fhir_last_updated
    - name: "Fhir Profile Url"
      expr: fhir_profile_url
    - name: "Fhir Resource Identifier"
      expr: fhir_resource_identifier
    - name: "Fhir Resource Type"
      expr: fhir_resource_type
    - name: "Fhir Version Code"
      expr: fhir_version_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Open Enrollment Period"
      expr: COUNT(DISTINCT open_enrollment_period_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_pend_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment pend queue operational KPIs — pend volume, resolution rates, SLA compliance, escalation rates, and pend reason analysis. Used by VP Operations and Compliance to monitor enrollment processing bottlenecks, SLA adherence, and regulatory risk."
  source: "`vibe_health_insurance_v1`.`enrollment`.`pend_queue`"
  dimensions:
    - name: "pend_reason_code"
      expr: pend_reason_code
      comment: "Reason code for the pend (Missing Documentation, Eligibility Discrepancy, CMS Match Failure, etc.) for root-cause analysis."
    - name: "pend_status"
      expr: pend_status
      comment: "Current status of the pend item (Open, Resolved, Escalated, Closed) for queue management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the pend item for workload prioritization and SLA management."
    - name: "sla_compliance_status"
      expr: sla_compliance_status
      comment: "SLA compliance status (Met, Breached, At Risk) — critical for regulatory and contractual SLA monitoring."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for identifying chronic or complex pend items."
    - name: "is_documentation_missing_flag"
      expr: is_documentation_missing_flag
      comment: "Indicates pends caused by missing documentation — used to target member outreach and reduce pend volume."
    - name: "is_eligibility_discrepancy_flag"
      expr: is_eligibility_discrepancy_flag
      comment: "Indicates pends caused by eligibility discrepancies — used to identify systemic data quality issues."
    - name: "is_cms_match_failure_flag"
      expr: is_cms_match_failure_flag
      comment: "Indicates CMS match failures — high rates signal regulatory compliance risk."
    - name: "is_duplicate_flag"
      expr: is_duplicate_flag
      comment: "Indicates duplicate enrollment records — used to monitor data quality and prevent overpayment."
    - name: "pend_month"
      expr: DATE_TRUNC('MONTH', pend_timestamp)
      comment: "Month the pend was created for trend analysis of enrollment processing quality."
    - name: "resolver_team"
      expr: resolver_team
      comment: "Team responsible for resolving the pend — used for workload distribution and capacity planning."
  measures:
    - name: "total_pend_items"
      expr: COUNT(1)
      comment: "Total pend queue items — primary operational KPI for enrollment processing backlog management."
    - name: "open_pend_items"
      expr: COUNT(CASE WHEN pend_status = 'Open' THEN pend_queue_id END)
      comment: "Count of currently open pend items — real-time backlog size used by operations leadership to manage staffing and SLA risk."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_status = 'Breached' THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pend items that breached SLA — directly impacts regulatory compliance and member satisfaction; triggers leadership intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pend items escalated — high escalation rates indicate systemic enrollment processing problems requiring executive attention."
    - name: "auto_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto_resolved = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pend items resolved automatically — measures automation effectiveness and operational efficiency improvement."
    - name: "documentation_missing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_documentation_missing_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pends caused by missing documentation — used to target member outreach programs and reduce enrollment friction."
    - name: "cms_match_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cms_match_failure_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pends caused by CMS match failures — high rates signal regulatory compliance risk and potential CMS audit exposure."
    - name: "compliance_pend_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pend items flagged for compliance issues — used by compliance team to monitor regulatory risk in the enrollment pipeline."
    - name: "manual_review_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_review_required = TRUE THEN pend_queue_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pend items requiring manual review — used to forecast staffing needs and identify automation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan election KPIs — election volume, premium contribution analysis, benefit rider adoption, COBRA eligibility, and election type mix. Used by VP Benefits, CFO, and Actuarial to monitor employer group plan selection patterns, premium cost-sharing, and benefit design performance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`plan_election`"
  dimensions:
    - name: "election_type"
      expr: election_type
      comment: "Type of plan election (New, Change, Renewal, Waiver) for enrollment action analysis."
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Current status of the plan election (Active, Terminated, Pending) for membership monitoring."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (Employee Only, Employee + Spouse, Family, etc.) for premium and benefit analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of the election (Open Enrollment, SEP, New Hire) for channel attribution."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Enrollment event type for election trigger analysis."
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Indicates COBRA-eligible elections — used to forecast COBRA continuation liability."
    - name: "dental_rider_flag"
      expr: dental_rider_flag
      comment: "Indicates dental rider election — used to monitor ancillary benefit adoption rates."
    - name: "vision_rider_flag"
      expr: vision_rider_flag
      comment: "Indicates vision rider election — used to monitor ancillary benefit adoption rates."
    - name: "hsa_election_flag"
      expr: hsa_election_flag
      comment: "Indicates HSA election — used to monitor HDHP/HSA adoption and tax-advantaged account utilization."
    - name: "fsa_election_flag"
      expr: fsa_election_flag
      comment: "Indicates FSA election — used to monitor flexible spending account adoption."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of election effective date for enrollment trend analysis."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Premium payment frequency (Monthly, Bi-Weekly, Annual) for billing cycle analysis."
  measures:
    - name: "total_plan_elections"
      expr: COUNT(1)
      comment: "Total plan elections — baseline enrollment volume KPI for benefits administration."
    - name: "active_plan_elections"
      expr: COUNT(CASE WHEN plan_election_status = 'Active' THEN plan_election_id END)
      comment: "Count of currently active plan elections — primary covered-lives KPI for employer group benefits management."
    - name: "total_premium_employer_contribution"
      expr: SUM(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Sum of employer premium contributions — total employer benefit cost, critical for group underwriting and renewal pricing."
    - name: "total_premium_employee_contribution"
      expr: SUM(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Sum of employee premium contributions — total member cost-sharing for premium, used in benefit design and affordability analysis."
    - name: "total_premium_volume"
      expr: SUM(CAST(total_premium AS DOUBLE))
      comment: "Sum of total premium amounts across all elections — total premium revenue from plan elections, key revenue KPI."
    - name: "avg_total_premium_per_election"
      expr: AVG(CAST(total_premium AS DOUBLE))
      comment: "Average total premium per plan election — used to benchmark premium levels across coverage tiers and plan types."
    - name: "avg_employer_contribution_per_election"
      expr: AVG(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Average employer contribution per election — used in group renewal negotiations and benefit cost benchmarking."
    - name: "employer_contribution_share"
      expr: ROUND(100.0 * SUM(CAST(premium_contribution_employer AS DOUBLE)) / NULLIF(SUM(CAST(total_premium AS DOUBLE)), 0), 2)
      comment: "Employer share of total premium as a percentage — key metric for benefit generosity benchmarking and group retention strategy."
    - name: "cobra_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cobra_eligible = TRUE THEN plan_election_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with COBRA eligibility — used to forecast COBRA continuation liability and administrative workload."
    - name: "dental_rider_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dental_rider_flag = TRUE THEN plan_election_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with dental rider — used to monitor ancillary benefit adoption and cross-sell performance."
    - name: "hsa_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hsa_election_flag = TRUE THEN plan_election_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of elections with HSA — used to monitor HDHP/HSA program adoption and consumer-directed health plan strategy effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment reconciliation KPIs — discrepancy rates, financial impact of reconciliation, resolution timeliness, and auto-resolution efficiency. Used by VP Operations and CFO to monitor enrollment data accuracy, financial exposure from discrepancies, and reconciliation SLA compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation run (Completed, In Progress, Failed, Pending) for operational monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (Monthly, Quarterly, Ad-Hoc, CMS) for segmenting reconciliation workload."
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Indicates whether discrepancies were auto-resolved — used to measure automation effectiveness."
    - name: "manual_resolution_flag"
      expr: manual_resolution_flag
      comment: "Indicates whether manual intervention was required — used to forecast staffing needs."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month of reconciliation period for trend analysis of enrollment data quality over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial impact reporting."
  measures:
    - name: "total_reconciliation_runs"
      expr: COUNT(1)
      comment: "Total reconciliation runs — baseline operational KPI for reconciliation pipeline monitoring."
    - name: "total_financial_impact_net"
      expr: SUM(CAST(financial_impact_net AS DOUBLE))
      comment: "Sum of net financial impact across all reconciliation runs — total financial exposure from enrollment discrepancies, critical for CFO reporting."
    - name: "total_financial_impact_gross"
      expr: SUM(CAST(financial_impact_gross AS DOUBLE))
      comment: "Sum of gross financial impact before adjustments — used to size the total reconciliation financial risk."
    - name: "total_financial_impact_adjustment"
      expr: SUM(CAST(financial_impact_adjustment AS DOUBLE))
      comment: "Sum of financial adjustments from reconciliation — measures the cost of enrollment data quality issues."
    - name: "avg_net_financial_impact_per_run"
      expr: AVG(CAST(financial_impact_net AS DOUBLE))
      comment: "Average net financial impact per reconciliation run — used to benchmark reconciliation efficiency and detect anomalous runs."
    - name: "auto_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_resolution_flag = TRUE THEN reconciliation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation runs resolved automatically — measures automation maturity and operational efficiency."
    - name: "failed_reconciliation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Failed' THEN reconciliation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation runs that failed — high failure rates indicate systemic data quality or system integration issues requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_submission_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS submission batch KPIs — batch success/failure rates, financial volume, retroactive batch analysis, and processing efficiency. Used by VP Compliance and CFO to monitor CMS submission pipeline health, financial accuracy, and regulatory submission SLA compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`submission_batch`"
  dimensions:
    - name: "batch_type"
      expr: batch_type
      comment: "Type of submission batch (Initial, Correction, Cancellation, Reconciliation) for pipeline segmentation."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the submission batch (Pending, Processing, Completed, Failed) for operational monitoring."
    - name: "batch_is_retroactive"
      expr: batch_is_retroactive
      comment: "Indicates retroactive submission batches — high volume signals enrollment data quality issues with financial impact."
    - name: "batch_is_automatic"
      expr: batch_is_automatic
      comment: "Distinguishes automated from manual submission batches for process efficiency analysis."
    - name: "batch_is_approved"
      expr: batch_is_approved
      comment: "Indicates whether the batch has been approved — used for governance and audit tracking."
    - name: "batch_is_finalized"
      expr: batch_is_finalized
      comment: "Indicates whether the batch has been finalized — used for revenue recognition timing."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', batch_submission_date)
      comment: "Month of batch submission for trend analysis of CMS submission volume."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Source system for data lineage and quality monitoring."
  measures:
    - name: "total_submission_batches"
      expr: COUNT(1)
      comment: "Total submission batches — baseline throughput KPI for CMS submission pipeline monitoring."
    - name: "total_submission_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total financial amounts across all submission batches — total premium revenue submitted to CMS, key revenue recognition metric."
    - name: "avg_amount_per_batch"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average financial amount per submission batch — used to detect anomalous batches and benchmark submission value."
    - name: "batch_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN batch_status = 'Failed' THEN submission_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submission batches that failed — high failure rates directly impact CMS revenue and trigger regulatory scrutiny."
    - name: "retroactive_batch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN batch_is_retroactive = TRUE THEN submission_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submission batches that are retroactive — high rates indicate enrollment data quality problems with financial and compliance implications."
    - name: "batch_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN batch_is_approved = TRUE THEN submission_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submission batches approved — used by governance teams to monitor submission approval compliance."
    - name: "automated_batch_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN batch_is_automatic = TRUE THEN submission_batch_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submission batches processed automatically — measures automation efficiency and operational cost reduction."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs over enrollment transactions — transaction throughput, financial impact, retroactive adjustment volume, grace period exposure, and processing quality. Used by VP Operations and CFO to monitor enrollment pipeline health, financial adjustments, and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment transaction (New, Renewal, Termination, Change) for pipeline segmentation."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current processing status of the transaction for operational queue management."
    - name: "processing_status"
      expr: processing_status
      comment: "Technical processing status (Pending, Processed, Failed, Rejected) for SLA monitoring."
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin channel of the enrollment (Exchange, Employer Portal, Paper, EDI) for channel performance analysis."
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Health plan type (HMO, PPO, EPO, HDHP) for plan-type enrollment volume analysis."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Indicates retroactive adjustment transactions — high volume signals data quality or eligibility issues."
    - name: "is_grace_period"
      expr: is_grace_period
      comment: "Indicates whether the transaction falls within a grace period — used for premium collection risk monitoring."
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Indicates whether the transaction has a financial impact — used to prioritize financial reconciliation."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the transaction requires regulatory reporting — used for compliance workload planning."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of transaction effective date for enrollment trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of termination date for attrition trend analysis."
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Coverage period type (Annual, Short-Term, COBRA) for product mix analysis."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total enrollment transactions processed — primary throughput KPI for enrollment operations management."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross premium amounts across all transactions — total premium revenue pipeline, critical for CFO revenue forecasting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts after adjustments — actual financial impact of enrollment transactions on premium revenue."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of adjustment amounts — total financial impact of enrollment corrections, used to monitor data quality cost."
    - name: "avg_net_amount_per_transaction"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net premium amount per transaction — used to benchmark transaction value and detect anomalies."
    - name: "retroactive_adjustment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring retroactive adjustment — high rates indicate enrollment data quality problems with direct financial impact."
    - name: "grace_period_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_grace_period = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions in grace period — indicates premium collection risk and potential lapse exposure."
    - name: "financial_impact_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_impact_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with financial impact — used to size financial reconciliation workload."
    - name: "regulatory_reporting_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions requiring regulatory reporting — used by compliance team to forecast reporting burden."
    - name: "claims_reprocess_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN claims_reprocess_flag = TRUE THEN transaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollment transactions triggering claims reprocessing — high rates indicate significant downstream cost and operational burden."
$$;
