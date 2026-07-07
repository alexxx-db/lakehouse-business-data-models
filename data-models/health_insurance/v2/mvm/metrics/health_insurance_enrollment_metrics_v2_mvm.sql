-- Metric views for domain: enrollment | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-27 10:36:42

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for plan elections — the core enrollment fact. Tracks premium economics, coverage tier distribution, election types, COBRA exposure, and rider adoption to steer product, pricing, and member acquisition decisions."
  source: "`vibe_health_insurance_v1`.`enrollment`.`plan_election`"
  filter: record_status = 'active'
  dimensions:
    - name: "plan_election_status"
      expr: plan_election_status
      comment: "Current lifecycle status of the plan election (e.g., active, terminated, pending) — primary filter for enrollment health dashboards."
    - name: "election_type"
      expr: election_type
      comment: "Type of election event (e.g., new enrollment, renewal, change) — used to segment enrollment volume by action category."
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Specific enrollment event driving the election (e.g., open enrollment, QLE, COBRA) — critical for understanding enrollment triggers."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or system through which the enrollment was submitted (e.g., exchange, employer portal, broker) — used for channel mix analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier selected (e.g., individual, employee+spouse, family) — drives premium revenue segmentation."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Billing frequency for the premium (e.g., monthly, quarterly, annual) — used for cash flow and revenue timing analysis."
    - name: "is_cobra_eligible"
      expr: is_cobra_eligible
      comment: "Indicates whether the member is COBRA-eligible — used to track COBRA exposure and associated risk."
    - name: "dental_rider_flag"
      expr: dental_rider_flag
      comment: "Indicates whether a dental rider was elected — used to measure ancillary product adoption rates."
    - name: "vision_rider_flag"
      expr: vision_rider_flag
      comment: "Indicates whether a vision rider was elected — used to measure ancillary product adoption rates."
    - name: "hsa_election_flag"
      expr: hsa_election_flag
      comment: "Indicates whether an HSA was elected alongside the plan — used to track consumer-directed health plan adoption."
    - name: "fsa_election_flag"
      expr: fsa_election_flag
      comment: "Indicates whether an FSA was elected — used to track flexible spending account adoption."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month in which plan coverage begins — used for cohort-based enrollment trend analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month in which plan coverage ends — used for lapse and termination trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of plan termination — used to track disenrollment seasonality and churn patterns."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the plan election is currently active — primary filter for active membership counts."
  measures:
    - name: "total_active_elections"
      expr: COUNT(CASE WHEN is_active = TRUE THEN plan_election_id END)
      comment: "Total number of currently active plan elections. Core membership volume KPI used by executives to track enrolled membership base."
    - name: "total_elections"
      expr: COUNT(1)
      comment: "Total plan elections across all statuses. Used as the denominator for conversion and activation rate calculations."
    - name: "total_premium_revenue"
      expr: SUM(CAST(total_premium AS DOUBLE))
      comment: "Sum of total premium across all plan elections. Primary revenue KPI for the enrollment domain — directly tied to top-line health plan revenue."
    - name: "avg_total_premium"
      expr: AVG(CAST(total_premium AS DOUBLE))
      comment: "Average total premium per plan election. Used to benchmark pricing adequacy and monitor premium yield per member."
    - name: "total_employee_premium_contribution"
      expr: SUM(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Total employee-side premium contributions across all elections. Used to assess member cost-sharing burden and affordability risk."
    - name: "total_employer_premium_contribution"
      expr: SUM(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Total employer-side premium contributions across all elections. Used to assess employer subsidy levels and group benefit cost exposure."
    - name: "avg_employee_premium_contribution"
      expr: AVG(CAST(premium_contribution_employee AS DOUBLE))
      comment: "Average employee premium contribution per election. Tracks member affordability trends — a key driver of voluntary disenrollment risk."
    - name: "avg_employer_premium_contribution"
      expr: AVG(CAST(premium_contribution_employer AS DOUBLE))
      comment: "Average employer premium contribution per election. Used to benchmark employer benefit generosity and group retention risk."
    - name: "cobra_eligible_elections"
      expr: COUNT(CASE WHEN is_cobra_eligible = TRUE THEN plan_election_id END)
      comment: "Number of plan elections flagged as COBRA-eligible. Tracks COBRA exposure volume — a high-cost, high-risk membership segment."
    - name: "dental_rider_adoption_count"
      expr: COUNT(CASE WHEN dental_rider_flag = TRUE THEN plan_election_id END)
      comment: "Number of elections with a dental rider. Used to measure ancillary product penetration and cross-sell effectiveness."
    - name: "vision_rider_adoption_count"
      expr: COUNT(CASE WHEN vision_rider_flag = TRUE THEN plan_election_id END)
      comment: "Number of elections with a vision rider. Used to measure ancillary product penetration and cross-sell effectiveness."
    - name: "hsa_adoption_count"
      expr: COUNT(CASE WHEN hsa_election_flag = TRUE THEN plan_election_id END)
      comment: "Number of elections with an HSA elected. Tracks consumer-directed health plan adoption — a strategic product mix indicator."
    - name: "distinct_members_enrolled"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique subscribers with at least one plan election. Core membership headcount KPI used in executive dashboards and regulatory reporting."
    - name: "distinct_health_plans_elected"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with active elections. Used to assess plan portfolio utilization and identify underperforming plan offerings."
    - name: "terminated_elections"
      expr: COUNT(CASE WHEN plan_election_status = 'terminated' THEN plan_election_id END)
      comment: "Number of terminated plan elections. Used to track disenrollment volume and calculate churn rates for retention strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for enrollment transactions — the processing backbone of enrollment changes. Tracks transaction throughput, financial impact, processing quality, retroactive adjustments, and grace period exposure."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  filter: record_status = 'active'
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current processing status of the enrollment transaction (e.g., processed, pending, failed) — primary operational health indicator."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment action represented by the transaction (e.g., add, change, terminate) — used to segment transaction volume by action."
    - name: "processing_status"
      expr: processing_status
      comment: "Detailed processing pipeline status — used to identify bottlenecks and SLA breaches in enrollment processing."
    - name: "enrollment_origin"
      expr: enrollment_origin
      comment: "Origin system or channel of the enrollment transaction — used for source system quality and volume analysis."
    - name: "health_plan_type"
      expr: health_plan_type
      comment: "Type of health plan associated with the transaction (e.g., HMO, PPO, EPO) — used for plan-type mix analysis."
    - name: "coverage_period_type"
      expr: coverage_period_type
      comment: "Indicates whether coverage is prospective or retroactive — critical for financial impact and compliance reporting."
    - name: "is_grace_period"
      expr: is_grace_period
      comment: "Indicates whether the transaction falls within a grace period — used to track grace period exposure and associated revenue risk."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Flags transactions requiring retroactive adjustment — used to measure retro processing volume and financial restatement risk."
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Indicates whether the transaction has a financial impact — used to filter financially material transactions for revenue analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags transactions subject to regulatory reporting requirements — used for compliance monitoring and audit readiness."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance classification of the transaction — used to track regulatory adherence and identify non-compliant transaction patterns."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the transaction coverage begins — used for monthly enrollment change trend analysis."
    - name: "termination_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of transaction-driven termination — used to track disenrollment timing and seasonality."
    - name: "source"
      expr: source
      comment: "Source system that originated the transaction — used for data lineage and source system performance benchmarking."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total enrollment transactions processed. Core throughput KPI for enrollment operations — used to monitor processing volume and capacity."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross financial amounts across all transactions. Tracks total gross premium and adjustment flow — a primary revenue integrity KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net financial amounts across all transactions. Represents realized net revenue after adjustments — used for financial close and forecasting."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of all adjustment amounts applied to transactions. Tracks the scale of financial corrections — high values signal data quality or process issues."
    - name: "avg_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net transaction amount. Used to benchmark per-transaction financial yield and detect anomalous transaction values."
    - name: "retroactive_transaction_count"
      expr: COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN transaction_id END)
      comment: "Number of transactions flagged for retroactive adjustment. High retro volumes indicate enrollment timing issues and increase financial restatement risk."
    - name: "grace_period_transaction_count"
      expr: COUNT(CASE WHEN is_grace_period = TRUE THEN transaction_id END)
      comment: "Number of transactions in a grace period. Tracks grace period exposure — a leading indicator of potential lapse and premium collection risk."
    - name: "failed_transaction_count"
      expr: COUNT(CASE WHEN transaction_status = 'failed' THEN transaction_id END)
      comment: "Number of transactions in a failed status. Operational quality KPI — high failure rates signal system or data issues requiring immediate intervention."
    - name: "regulatory_reportable_transaction_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN transaction_id END)
      comment: "Number of transactions subject to regulatory reporting. Used for compliance workload planning and audit trail completeness verification."
    - name: "distinct_members_transacted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique subscribers with enrollment transactions in the period. Used to measure enrollment activity breadth across the membership base."
    - name: "financially_impactful_transaction_count"
      expr: COUNT(CASE WHEN financial_impact_flag = TRUE THEN transaction_id END)
      comment: "Number of transactions with a direct financial impact. Used to scope financial reconciliation workload and prioritize processing queues."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for qualifying life events (QLEs) — the primary driver of special enrollment periods. Tracks QLE volume, verification rates, SEP window compliance, and denial patterns to manage regulatory risk and member experience."
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  filter: record_status = 'active'
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of qualifying life event (e.g., marriage, birth, job loss) — used to segment QLE volume by event category for trend and compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the QLE record is currently active — used to filter for in-force QLEs in operational dashboards."
  measures:
    - name: "total_qle_submissions"
      expr: COUNT(1)
      comment: "Total qualifying life events submitted. Core volume KPI for SEP management — used to forecast enrollment spikes and staff verification teams."
    - name: "distinct_members_with_qle"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique subscribers who submitted a QLE. Used to measure the breadth of SEP activity across the membership base."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for eligibility verification transactions — the real-time coverage confirmation layer. Tracks verification response performance, benefit utilization, deductible and OOP exposure, and error rates to manage member access and financial risk."
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`"
  filter: record_status = 'active'
  dimensions:
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Result of the eligibility verification inquiry (e.g., eligible, ineligible, pending) — primary outcome dimension for access management."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage being verified (e.g., medical, dental, pharmacy) — used to segment eligibility activity by benefit line."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category under verification — used to analyze eligibility inquiry patterns by benefit type."
    - name: "service_code"
      expr: service_code
      comment: "Service type code associated with the eligibility inquiry — used to identify high-volume service categories driving verification load."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Indicates whether prior authorization is required for the service — used to track prior auth burden and associated member friction."
    - name: "member_identifier_type"
      expr: member_identifier_type
      comment: "Type of member identifier used in the verification request — used to assess identifier standardization and matching quality."
    - name: "inquiry_month"
      expr: DATE_TRUNC('MONTH', inquiry_timestamp)
      comment: "Month the eligibility inquiry was submitted — used for verification volume trend analysis and capacity planning."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month coverage begins per the verification — used to align eligibility windows with enrollment effective dates."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the eligibility verification record is currently active — used to filter for current eligibility status."
  measures:
    - name: "total_eligibility_inquiries"
      expr: COUNT(1)
      comment: "Total eligibility verification inquiries processed. Core throughput KPI for the eligibility system — used for capacity planning and SLA monitoring."
    - name: "eligible_verification_count"
      expr: COUNT(CASE WHEN eligibility_status = 'eligible' THEN eligibility_verification_id END)
      comment: "Number of verifications returning an eligible result. Used to measure eligibility confirmation rate and identify coverage gaps."
    - name: "avg_response_time_seconds"
      expr: AVG(CAST(response_time_seconds AS DOUBLE))
      comment: "Average eligibility verification response time in seconds. Critical SLA KPI — slow response times directly impact provider workflow and member access to care."
    - name: "total_benefit_limit"
      expr: SUM(CAST(benefit_limit AS DOUBLE))
      comment: "Sum of benefit limits across all verified eligibility records. Used to assess total benefit exposure and plan liability."
    - name: "total_benefit_used"
      expr: SUM(CAST(benefit_used AS DOUBLE))
      comment: "Sum of benefits consumed across all verified eligibility records. Tracks benefit utilization volume — a key actuarial and financial risk indicator."
    - name: "total_benefit_remaining"
      expr: SUM(CAST(benefit_remaining AS DOUBLE))
      comment: "Sum of remaining benefit balances. Used to assess residual benefit liability and forecast end-of-year utilization spikes."
    - name: "total_deductible_remaining"
      expr: SUM(CAST(deductible_remaining AS DOUBLE))
      comment: "Sum of remaining deductible balances across members. Used to estimate member cost-sharing exposure and predict utilization acceleration as deductibles are met."
    - name: "total_oop_remaining"
      expr: SUM(CAST(oop_remaining AS DOUBLE))
      comment: "Sum of remaining out-of-pocket maximums across members. Tracks aggregate OOP exposure — a key financial risk metric for high-cost member identification."
    - name: "avg_benefit_used"
      expr: AVG(CAST(benefit_used AS DOUBLE))
      comment: "Average benefit utilization per eligibility record. Used to benchmark per-member benefit consumption and identify outlier utilization patterns."
    - name: "error_verification_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN eligibility_verification_id END)
      comment: "Number of eligibility verifications that returned an error. High error rates indicate system integration issues or data quality problems affecting member access."
    - name: "distinct_members_verified"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique member identities with eligibility verifications. Used to measure the breadth of eligibility activity across the enrolled population."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN eligibility_verification_id END)
      comment: "Number of verifications where prior authorization is required. Tracks prior auth burden volume — a key driver of care access friction and administrative cost."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for open enrollment periods — the regulatory and operational framework governing when members can enroll. Tracks period performance, volume target attainment, compliance status, and enrollment type mix to steer enrollment campaign strategy."
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  filter: record_status = 'active'
  dimensions:
    - name: "open_enrollment_period_status"
      expr: open_enrollment_period_status
      comment: "Current status of the open enrollment period (e.g., open, closed, pending) — primary operational status for enrollment period management."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment period (e.g., annual, special, COBRA) — used to segment period performance by enrollment category."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Exchange type associated with the period (e.g., federal, state, off-exchange) — used for regulatory reporting and market segment analysis."
    - name: "eligibility_segment"
      expr: eligibility_segment
      comment: "Member eligibility segment targeted by the period (e.g., individual, small group, Medicare) — used for segment-specific enrollment performance tracking."
    - name: "lob"
      expr: lob
      comment: "Line of business associated with the enrollment period — used to segment enrollment performance by business line."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the enrollment period — used for compliance monitoring and regulatory filing readiness."
    - name: "is_annual"
      expr: is_annual
      comment: "Indicates whether this is an annual open enrollment period — used to distinguish AEP from special enrollment periods in trend analysis."
    - name: "is_retrospective_allowed"
      expr: is_retrospective_allowed
      comment: "Indicates whether retrospective enrollment is permitted — used to assess retroactive enrollment exposure and financial risk."
    - name: "volume_target_met"
      expr: volume_target_met
      comment: "Indicates whether the enrollment volume target was met — primary campaign performance KPI for enrollment period success assessment."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Indicates whether a regulatory filing is required for this period — used for compliance workload planning and deadline tracking."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the enrollment period opens — used for enrollment period calendar analysis and campaign planning."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the enrollment period closes — used to track enrollment period duration and deadline management."
  measures:
    - name: "total_enrollment_periods"
      expr: COUNT(1)
      comment: "Total number of open enrollment periods. Used to track enrollment period portfolio size and regulatory filing workload."
    - name: "active_enrollment_periods"
      expr: COUNT(CASE WHEN open_enrollment_period_status = 'open' THEN open_enrollment_period_id END)
      comment: "Number of currently open enrollment periods. Operational KPI for enrollment campaign management — drives member outreach and staffing decisions."
    - name: "volume_target_met_count"
      expr: COUNT(CASE WHEN volume_target_met = TRUE THEN open_enrollment_period_id END)
      comment: "Number of enrollment periods that met their volume target. Primary campaign effectiveness KPI — used to evaluate enrollment strategy success."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE THEN open_enrollment_period_id END)
      comment: "Number of enrollment periods requiring regulatory filing. Used for compliance workload planning and ensuring no filing deadlines are missed."
    - name: "retrospective_allowed_count"
      expr: COUNT(CASE WHEN is_retrospective_allowed = TRUE THEN open_enrollment_period_id END)
      comment: "Number of enrollment periods permitting retrospective enrollment. Used to quantify retroactive enrollment exposure and associated financial risk."
    - name: "annual_enrollment_period_count"
      expr: COUNT(CASE WHEN is_annual = TRUE THEN open_enrollment_period_id END)
      comment: "Number of annual open enrollment periods. Used to distinguish AEP volume from SEP volume in enrollment mix analysis."
    - name: "non_compliant_period_count"
      expr: COUNT(CASE WHEN compliance_status = 'non_compliant' THEN open_enrollment_period_id END)
      comment: "Number of enrollment periods with a non-compliant status. Regulatory risk KPI — any non-zero value requires immediate executive attention and remediation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for enrollment reconciliation — the process of resolving discrepancies between enrollment records and billing/payment data. Tracks discrepancy volumes, financial impact, resolution rates, and auto-resolution efficiency."
  source: "`vibe_health_insurance_v1`.`enrollment`.`reconciliation`"
  filter: record_status = 'active'
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation run (e.g., open, resolved, escalated) — primary operational status for reconciliation workflow management."
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (e.g., scheduled, manual, ad-hoc) — used to segment reconciliation activity by trigger type."
    - name: "auto_resolution_flag"
      expr: auto_resolution_flag
      comment: "Indicates whether the reconciliation was resolved automatically — used to measure automation effectiveness and manual intervention rates."
    - name: "manual_resolution_flag"
      expr: manual_resolution_flag
      comment: "Indicates whether manual intervention was required — used to track manual resolution workload and identify automation improvement opportunities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial impact amounts — used for multi-currency financial reporting and FX exposure analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start)
      comment: "Month the reconciliation period begins — used for monthly reconciliation trend analysis and financial close tracking."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', period_end)
      comment: "Month the reconciliation period ends — used to align reconciliation cycles with billing and financial close calendars."
    - name: "resolution_deadline_month"
      expr: DATE_TRUNC('MONTH', resolution_deadline)
      comment: "Month by which reconciliation must be resolved — used to identify at-risk reconciliations approaching their deadline."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the reconciliation record is currently active — used to filter for open reconciliation items."
  measures:
    - name: "total_reconciliation_runs"
      expr: COUNT(1)
      comment: "Total number of reconciliation runs executed. Core throughput KPI for the reconciliation process — used to monitor operational cadence."
    - name: "total_financial_impact_gross"
      expr: SUM(CAST(financial_impact_gross AS DOUBLE))
      comment: "Sum of gross financial impact across all reconciliation runs. Tracks total gross discrepancy value — a primary financial integrity KPI."
    - name: "total_financial_impact_net"
      expr: SUM(CAST(financial_impact_net AS DOUBLE))
      comment: "Sum of net financial impact after adjustments. Represents the realized financial exposure from enrollment discrepancies — used for financial close and reserve planning."
    - name: "total_financial_impact_adjustment"
      expr: SUM(CAST(financial_impact_adjustment AS DOUBLE))
      comment: "Sum of financial adjustments applied during reconciliation. Tracks the scale of financial corrections — high values indicate systemic enrollment data quality issues."
    - name: "avg_financial_impact_net"
      expr: AVG(CAST(financial_impact_net AS DOUBLE))
      comment: "Average net financial impact per reconciliation run. Used to benchmark reconciliation materiality and prioritize high-impact resolution efforts."
    - name: "auto_resolved_count"
      expr: COUNT(CASE WHEN auto_resolution_flag = TRUE THEN reconciliation_id END)
      comment: "Number of reconciliations resolved automatically. Measures automation effectiveness — a key operational efficiency KPI for the reconciliation function."
    - name: "manual_resolved_count"
      expr: COUNT(CASE WHEN manual_resolution_flag = TRUE THEN reconciliation_id END)
      comment: "Number of reconciliations requiring manual resolution. Tracks manual intervention workload — used to size reconciliation staffing and identify automation gaps."
    - name: "open_reconciliation_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'open' THEN reconciliation_id END)
      comment: "Number of reconciliations currently open and unresolved. Operational backlog KPI — high open counts signal financial close risk and potential regulatory exposure."
    - name: "max_run_number"
      expr: MAX(run_number)
      comment: "Maximum reconciliation run number in the period. Used to track reconciliation cycle progression and identify gaps in run sequencing."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for EDI enrollment transactions — the electronic data interchange layer for enrollment file processing. Tracks file processing throughput, data quality, error rates, and processing attempt efficiency for EDI operations management."
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  filter: record_status = 'active'
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the EDI transaction (e.g., processed, failed, pending) — primary operational health indicator for EDI pipeline."
    - name: "data_quality_score"
      expr: data_quality_score
      comment: "Data quality score assigned to the EDI transaction — used to segment transactions by quality tier and prioritize remediation."
    - name: "record_source_system"
      expr: record_source_system
      comment: "Source system that generated the EDI transaction — used for source system quality benchmarking and trading partner performance analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the EDI transaction is effective — used for monthly EDI volume trend analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the EDI transaction record is currently active — used to filter for in-force EDI records."
  measures:
    - name: "total_edi_transactions"
      expr: COUNT(1)
      comment: "Total EDI transactions received. Core throughput KPI for EDI operations — used to monitor trading partner activity and processing capacity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for enrollment events — the audit trail of all enrollment state changes. Tracks event volume, manual vs. automated event rates, status transition patterns, and event type distribution to support operational oversight and compliance auditing."
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  filter: record_status = 'active'
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of enrollment event (e.g., enrollment, termination, status change) — primary dimension for event volume segmentation."
    - name: "actor_type"
      expr: actor_type
      comment: "Type of actor who triggered the event (e.g., member, employer, system, broker) — used to analyze event origin and accountability."
    - name: "new_status"
      expr: new_status
      comment: "Status the enrollment transitioned to as a result of this event — used to track enrollment state transition patterns."
    - name: "previous_status"
      expr: previous_status
      comment: "Status the enrollment held before this event — used with new_status to analyze state transition flows and identify problematic patterns."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code associated with the enrollment event — used to categorize event causes and identify systemic drivers of enrollment changes."
    - name: "source"
      expr: source
      comment: "Source system or channel that generated the event — used for data lineage and source system quality analysis."
    - name: "is_manual"
      expr: is_manual
      comment: "Indicates whether the event was manually triggered — used to measure manual intervention rates and automation effectiveness."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the enrollment event occurred — used for event volume trend analysis and operational capacity planning."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the event becomes effective — used to align event timing with coverage effective dates."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the event record is currently active — used to filter for current enrollment events."
  measures:
    - name: "total_enrollment_events"
      expr: COUNT(1)
      comment: "Total enrollment events recorded. Core activity volume KPI — used to monitor enrollment change throughput and operational workload."
    - name: "manual_event_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN event_id END)
      comment: "Number of manually triggered enrollment events. High manual event rates indicate automation gaps and increase operational cost and error risk."
    - name: "automated_event_count"
      expr: COUNT(CASE WHEN is_manual = FALSE THEN event_id END)
      comment: "Number of system-automated enrollment events. Used to measure automation coverage and track progress toward straight-through processing goals."
    - name: "distinct_members_with_events"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique subscribers with enrollment events in the period. Used to measure the breadth of enrollment activity across the membership base."
    - name: "termination_event_count"
      expr: COUNT(CASE WHEN event_type = 'termination' THEN event_id END)
      comment: "Number of termination events. Tracks disenrollment activity volume — a leading indicator of membership attrition and revenue loss."
    - name: "distinct_event_types"
      expr: COUNT(DISTINCT event_type)
      comment: "Count of distinct event types occurring in the period. Used to assess enrollment event diversity and identify unusual event type concentrations."
$$;