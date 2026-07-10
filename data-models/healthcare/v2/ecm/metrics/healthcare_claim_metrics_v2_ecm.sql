-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claims KPIs for revenue cycle: billed vs allowed vs paid amounts, denial rates, patient responsibility, and adjudication throughput. Single-table view over claim.claim."
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Lifecycle status of the claim (submitted, adjudicated, paid, denied) for pipeline and aging analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (institutional, professional, etc.) for payer-mix and product-line steering."
    - name: "bill_type"
      expr: bill_type
      comment: "UB bill type classification for institutional claim segmentation."
    - name: "submission_method"
      expr: submission_method
      comment: "How the claim was submitted (EDI, paper, portal) for channel efficiency analysis."
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Whether this is the primary payer claim, for coordination-of-benefits analysis."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed for the claim, for denial-recovery workflow analysis."
    - name: "rac_audit_flag"
      expr: rac_audit_flag
      comment: "Whether the claim was flagged for RAC audit, for compliance risk monitoring."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month bucket for trending claim volume and revenue over time."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the claim was submitted, for submission trend analysis."
  measures:
    - name: "Claim Count"
      expr: COUNT(1)
      comment: "Total number of claims — baseline volume metric for the revenue cycle."
    - name: "Total Billed Amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Sum of billed charges — gross revenue exposure submitted to payers."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Sum of payer-allowed amounts — contractual net revenue expectation."
    - name: "Total Paid Amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Sum of amounts actually paid by payers — realized reimbursement."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of contractual and other adjustments — revenue leakage indicator."
    - name: "Total Patient Responsibility Amount"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Sum of patient responsibility — self-pay collection exposure."
    - name: "Net Collection Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_allowed_amount AS DOUBLE)), 0), 2)
      comment: "Paid as a percent of allowed — core revenue cycle collection efficiency KPI."
    - name: "Allowed To Billed Pct"
      expr: ROUND(100.0 * SUM(CAST(total_allowed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Allowed as a percent of billed — measures contractual discount/write-down pressure."
    - name: "Appeal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims that triggered an appeal — denial burden and rework indicator."
    - name: "Avg Days To Payment"
      expr: AVG(DATEDIFF(paid_timestamp, submitted_timestamp))
      comment: "Average days from submission to payment — days-in-AR/velocity indicator for cash flow."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs: denial volume, denied vs recovered amounts, preventability, and write-offs. Critical for revenue integrity steering."
  source: "`vibe_healthcare_v1`.`claim`.`claim_denial`"
  dimensions:
    - name: "denial_category"
      expr: denial_category
      comment: "High-level denial category for root-cause and prevention program targeting."
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (hard/soft) driving recovery strategy."
    - name: "denial_source"
      expr: denial_source
      comment: "Source of the denial (payer, clearinghouse, internal) for accountability analysis."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code standardizing denial reasons across payers."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the denial for work-queue prioritization."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the denial, enabling accountability reporting."
    - name: "is_preventable"
      expr: is_preventable
      comment: "Whether the denial was preventable, driving process-improvement focus."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial for trend monitoring."
  measures:
    - name: "Denial Count"
      expr: COUNT(1)
      comment: "Total number of claim denials — core denial volume KPI."
    - name: "Total Denied Amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollars denied — revenue at risk from denials."
    - name: "Total Recovered Amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total dollars recovered after appeal/rework — denial-recovery effectiveness."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total dollars written off from denials — permanent revenue loss."
    - name: "Recovery Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Recovered as percent of denied — denial-management team performance KPI."
    - name: "Preventable Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_preventable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of denials that were preventable — process improvement opportunity indicator."
    - name: "Distinct Denied Claims"
      expr: COUNT(DISTINCT claim_id)
      comment: "Unique claims with at least one denial — denial breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level reimbursement KPIs by procedure, revenue code, and service line for granular margin and payment analysis."
  source: "`vibe_healthcare_v1`.`claim`.`claim_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the claim line for adjudication and payment tracking."
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code on the line for service-mix and reimbursement analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code classification for institutional line-level revenue analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-of-care reimbursement analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Line-level denial reason code for granular denial root-cause analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month for line-level revenue trending."
  measures:
    - name: "Claim Line Count"
      expr: COUNT(1)
      comment: "Total number of claim lines — service-volume baseline."
    - name: "Total Line Billed Amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Sum of line billed amounts — gross charge by service."
    - name: "Total Line Allowed Amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Sum of line allowed amounts — contractual net at line granularity."
    - name: "Total Line Paid Amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of line paid amounts — realized reimbursement per service."
    - name: "Total Units Of Service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Sum of service units — utilization/throughput measure for capacity planning."
    - name: "Line Payment Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Paid as percent of allowed at line level — line-level collection efficiency."
    - name: "Avg Paid Per Unit"
      expr: ROUND(SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(units_of_service AS DOUBLE)), 0), 2)
      comment: "Average reimbursement per service unit — pricing/yield benchmark by procedure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization KPIs: approval rates, turnaround, denials, and unit utilization for access-to-care and payer-friction management."
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the prior authorization request for approval-pipeline monitoring."
    - name: "authorization_source"
      expr: authorization_source
      comment: "Source of the authorization for channel and payer analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request for SLA prioritization."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for authorization-friction comparison across payer segments."
    - name: "peer_review_required_flag"
      expr: peer_review_required_flag
      comment: "Whether peer review was required, an indicator of clinical review burden."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for prior-auth volume trending."
  measures:
    - name: "Prior Auth Count"
      expr: COUNT(1)
      comment: "Total prior authorization requests — access-management volume baseline."
    - name: "Approval Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of requests approved — payer-approval likelihood KPI affecting revenue and access."
    - name: "Appeal Filed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations that were appealed — payer-friction indicator."
    - name: "Total Requested Units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Sum of requested service units — demand for authorized services."
    - name: "Total Approved Units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Sum of approved units — authorized capacity for care delivery."
    - name: "Unit Approval Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(approved_units AS DOUBLE)) / NULLIF(SUM(CAST(requested_units AS DOUBLE)), 0), 2)
      comment: "Approved units as percent of requested — utilization-management stringency KPI."
    - name: "Avg Days To Decision"
      expr: AVG(DATEDIFF(decision_date, submission_date))
      comment: "Average turnaround from submission to decision — authorization SLA/velocity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance/payment posting KPIs: payment volume, adjustments, and reconciliation status for cash application and treasury monitoring."
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of the remittance for posting-workflow monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state for cash-application accuracy tracking."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method (EFT, check) for treasury and cash-flow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for cash-inflow trending."
  measures:
    - name: "Remittance Count"
      expr: COUNT(1)
      comment: "Total number of remittances processed — posting throughput baseline."
    - name: "Total Payment Amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total dollars received via remittances — realized cash inflow."
    - name: "Total Allowed Amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed on remittances — contractual net across postings."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments across remittances — revenue-leakage monitor."
    - name: "Total Provider Adjustment Amount"
      expr: SUM(CAST(provider_adjustment_amount AS DOUBLE))
      comment: "Provider-level adjustments (recoupments/offsets) affecting net cash."
    - name: "Payment To Billed Pct"
      expr: ROUND(100.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Payment as percent of billed across remittances — realized yield indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission KPIs: clean-claim/timely-filing performance and rejection tracking for front-end revenue cycle efficiency."
  source: "`vibe_healthcare_v1`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the submission (accepted, rejected) for front-end quality monitoring."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Clearinghouse/payer acknowledgment status for EDI reliability tracking."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, resubmission) for rework analysis."
    - name: "method"
      expr: method
      comment: "Submission transport method for channel efficiency comparison."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for volume trending."
  measures:
    - name: "Submission Count"
      expr: COUNT(1)
      comment: "Total claim submissions — front-end throughput baseline."
    - name: "Total Claim Charge Amount"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total charges submitted — gross submitted revenue."
    - name: "Timely Filing Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_timely_filed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions filed timely — avoids timely-filing write-offs; core RCM KPI."
    - name: "Rejection Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions rejected — clean-claim/front-end quality KPI."
    - name: "Distinct Claims Submitted"
      expr: COUNT(DISTINCT claim_id)
      comment: "Unique claims submitted — submission breadth net of resubmissions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal management KPIs: overturn/recovery outcomes and denied-amount recovery for denial-appeal team steering."
  source: "`vibe_healthcare_v1`.`claim`.`claim_appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal for work-queue monitoring."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal for strategy and outcome analysis."
    - name: "appeal_level"
      expr: appeal_level
      comment: "Appeal level (first, second, external) for escalation analysis."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome classification (overturned, upheld) for effectiveness reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of appeal submission for trend analysis."
  measures:
    - name: "Appeal Count"
      expr: COUNT(1)
      comment: "Total appeals filed — denial-recovery workload baseline."
    - name: "Total Denied Amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total denied dollars under appeal — recoverable revenue at stake."
    - name: "Total Overturn Amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total dollars overturned in favor of the provider — appeal success value."
    - name: "Total Requested Amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total dollars requested in appeals — recovery target amount."
    - name: "Overturn Recovery Rate Pct"
      expr: ROUND(100.0 * SUM(CAST(overturn_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Overturned as percent of denied — appeal-program financial effectiveness KPI."
    - name: "Avg Days To Resolution"
      expr: AVG(DATEDIFF(resolution_date, submission_date))
      comment: "Average days from appeal submission to resolution — appeal cycle-time KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility verification KPIs: coverage confirmation, verification success, and patient financial exposure for front-end access management."
  source: "`vibe_healthcare_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status returned by eligibility check for access-to-care decisions."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the verification transaction for front-end workflow monitoring."
    - name: "network_status"
      expr: network_status
      comment: "In/out-of-network status for benefit and patient-liability analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage for payer-mix segmentation."
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Month of verification for volume trending."
  measures:
    - name: "Eligibility Check Count"
      expr: COUNT(1)
      comment: "Total eligibility verifications — front-end verification volume baseline."
    - name: "Active Coverage Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN coverage_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of checks confirming active coverage — clean-registration/denial-prevention KPI."
    - name: "Avg Deductible Remaining"
      expr: AVG(CAST(deductible_remaining_amount AS DOUBLE))
      comment: "Average remaining deductible — patient financial exposure for point-of-service collection."
    - name: "Avg Out Of Pocket Maximum"
      expr: AVG(CAST(out_of_pocket_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum across members — benefit-design exposure indicator."
    - name: "Distinct Patients Verified"
      expr: COUNT(DISTINCT eligibility_patient_mpi_record_id)
      comment: "Unique patients with eligibility verification — coverage-confirmation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COB financial distribution metrics"
  source: "`vibe_healthcare_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB process"
    - name: "determination_method"
      expr: determination_method
      comment: "Method used to determine COB"
    - name: "cob_month"
      expr: DATE_TRUNC('month', determination_date)
      comment: "Month of COB determination"
  measures:
    - name: "total_primary_paid_amount"
      expr: SUM(CAST(primary_paid_amount AS DOUBLE))
      comment: "Sum of primary payer paid amounts"
    - name: "total_secondary_paid_amount"
      expr: SUM(CAST(secondary_paid_amount AS DOUBLE))
      comment: "Sum of secondary payer paid amounts"
    - name: "total_tertiary_paid_amount"
      expr: SUM(CAST(tertiary_paid_amount AS DOUBLE))
      comment: "Sum of tertiary payer paid amounts"
    - name: "cob_record_count"
      expr: COUNT(1)
      comment: "Number of coordination of benefits (COB) records"
$$;