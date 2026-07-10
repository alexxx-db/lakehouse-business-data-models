-- Metric views for domain: claim | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial and adjudication KPIs for revenue cycle steering — billed vs allowed vs paid, denial exposure, and patient responsibility."
  source: "`vibe_healthcare_v1`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current lifecycle status of the claim (submitted, adjudicated, paid, denied)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (professional, institutional, etc.) for mix analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Payer denial reason code for denial-driver analysis."
    - name: "bill_type"
      expr: bill_type
      comment: "UB bill type for institutional claim segmentation."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for site-of-care analysis."
    - name: "primary_payer_flag"
      expr: primary_payer_flag
      comment: "Whether the payer is the primary payer on the claim."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month bucket for trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Submission month bucket for throughput trending."
  measures:
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of claims — baseline volume for the revenue cycle."
    - name: "distinct_claim_count"
      expr: COUNT(DISTINCT claim_id)
      comment: "Distinct claims count for de-duplicated volume."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total gross charges billed to payers — top-line revenue cycle exposure."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount — net expected reimbursement."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount actually paid by payers — realized cash."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility — self-pay collection exposure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments/write-downs applied to claims."
    - name: "net_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_allowed_amount AS DOUBLE)), 0), 2)
      comment: "Paid as a percent of allowed — key net collection efficiency KPI."
    - name: "gross_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Paid as a percent of billed — gross reimbursement yield."
    - name: "denied_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims in denied status — front-line denial rate KPI."
    - name: "appeal_filed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims with an appeal filed — rework/dispute burden indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs — denied dollars, recovery, write-offs, and preventability for revenue integrity leadership."
  source: "`vibe_healthcare_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_category"
      expr: denial_category
      comment: "Category of denial for root-cause grouping."
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (clinical, technical, eligibility)."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim adjustment reason code driving the denial."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Assigned root cause for prevention initiatives."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the denial workflow."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the denial for ownership analysis."
    - name: "is_preventable"
      expr: is_preventable
      comment: "Whether the denial was flagged as preventable."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Denial month bucket for trend analysis."
  measures:
    - name: "denial_count"
      expr: COUNT(1)
      comment: "Total number of denials — volume baseline for denial management."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollars denied — at-risk revenue."
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total dollars recovered through denial resolution."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total dollars written off from denials — lost revenue."
    - name: "denial_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Recovered as a percent of denied — denial recovery effectiveness KPI."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Write-off as a percent of denied — irrecoverable loss rate."
    - name: "preventable_denial_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_preventable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of denials flagged preventable — process improvement target."
    - name: "avg_denied_amount"
      expr: ROUND(AVG(CAST(denied_amount AS DOUBLE)), 2)
      comment: "Average denied amount per denial — severity indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal outcome and recovery KPIs — overturn rates and denied dollars recovered through the appeals process."
  source: "`vibe_healthcare_v1`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal for workflow segmentation."
    - name: "appeal_level"
      expr: appeal_level
      comment: "Level/tier of the appeal (first, second, external)."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome code (overturned, upheld) for success analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Underlying denial reason being appealed."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether the appeal is flagged as priority."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Appeal submission month bucket for trend analysis."
  measures:
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals filed — workload baseline."
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Total dollars under appeal."
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Total dollars overturned in favor of the provider — recovered revenue."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested across appeals."
    - name: "overturn_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overturn_amount AS DOUBLE)) / NULLIF(SUM(CAST(denied_amount AS DOUBLE)), 0), 2)
      comment: "Overturned as a percent of denied — appeal financial success KPI."
    - name: "appeal_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_code = 'Overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of appeals overturned — appeal effectiveness rate."
    - name: "peer_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN peer_review_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of appeals requiring peer review — clinical resource demand."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level reimbursement KPIs — allowed vs paid at procedure granularity for contract and coding performance."
  source: "`vibe_healthcare_v1`.`claim`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Adjudication status of the claim line."
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code for service-level analysis."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for departmental reimbursement analysis."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service for site-of-care analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Line-level denial reason code."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_from_date)
      comment: "Service month bucket for trending."
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of claim lines — service volume baseline."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed at line level."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed at line level — expected reimbursement."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid at line level — realized reimbursement."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility at line level."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total service units delivered — utilization measure."
    - name: "line_net_collection_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Paid as a percent of allowed at line level — contract compliance KPI."
    - name: "avg_paid_per_line"
      expr: ROUND(AVG(CAST(paid_amount AS DOUBLE)), 2)
      comment: "Average payment per line — unit reimbursement indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_prior_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization performance KPIs — approval rates, utilization of authorized units, and appeal burden."
  source: "`vibe_healthcare_v1`.`claim`.`prior_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the prior authorization request."
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for authorization segmentation."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the request for SLA analysis."
    - name: "service_setting"
      expr: service_setting
      comment: "Service setting for the authorized care."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for authorization denials."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Submission month bucket for trending."
  measures:
    - name: "authorization_count"
      expr: COUNT(1)
      comment: "Total prior authorization requests — volume baseline."
    - name: "total_requested_units"
      expr: SUM(CAST(requested_units AS DOUBLE))
      comment: "Total units requested across authorizations."
    - name: "total_approved_units"
      expr: SUM(CAST(approved_units AS DOUBLE))
      comment: "Total units approved by payers."
    - name: "total_units_consumed"
      expr: SUM(CAST(units_consumed AS DOUBLE))
      comment: "Total authorized units actually consumed."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations approved — payer approval KPI."
    - name: "unit_approval_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_units AS DOUBLE)) / NULLIF(SUM(CAST(requested_units AS DOUBLE)), 0), 2)
      comment: "Approved units as a percent of requested — authorization yield."
    - name: "appeal_filed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of authorizations with appeals filed — dispute burden."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance / payment posting KPIs — cash posted, reconciliation status, and payer adjustment exposure."
  source: "`vibe_healthcare_v1`.`claim`.`remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Status of the remittance advice."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for cash posting control."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method (check, EFT) for cash flow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month bucket for cash trending."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month bucket for close analysis."
  measures:
    - name: "remittance_count"
      expr: COUNT(1)
      comment: "Total remittance advices processed — posting volume baseline."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash posted from remittances — realized revenue."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total billed across remittances."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed across remittances."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments across remittances — contractual write-down exposure."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total patient responsibility across remittances."
    - name: "payment_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(payment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Payment as a percent of billed — remittance yield KPI."
    - name: "reconciled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of remittances reconciled — cash control quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim submission throughput and timeliness KPIs — timely filing, acknowledgment, rejection, and resubmission burden."
  source: "`vibe_healthcare_v1`.`claim`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the submission."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (original, corrected)."
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Clearinghouse/payer acknowledgment status."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Rejection reason code for edit analysis."
    - name: "method"
      expr: method
      comment: "Submission method (electronic, paper)."
    - name: "is_timely_filed"
      expr: is_timely_filed
      comment: "Whether the claim was filed within the timely filing window."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Submission month bucket for throughput trending."
  measures:
    - name: "submission_count"
      expr: COUNT(1)
      comment: "Total claim submissions — throughput baseline."
    - name: "total_claim_charge_amount"
      expr: SUM(CAST(claim_charge_amount AS DOUBLE))
      comment: "Total charges submitted to payers."
    - name: "timely_filing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_timely_filed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of claims filed timely — compliance KPI preventing timely-filing write-offs."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions rejected — clean claim / front-end edit KPI."
    - name: "acknowledged_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of submissions acknowledged/accepted — clearinghouse acceptance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_remittance_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance line adjustment KPIs — contractual, deductible, coinsurance and copay breakdown for net revenue analysis."
  source: "`vibe_healthcare_v1`.`claim`.`line`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "Procedure code for service-level reimbursement analysis."
  measures:
    - name: "remittance_line_count"
      expr: COUNT(1)
      comment: "Total remittance lines processed — posting granularity baseline."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed at remittance line level."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed at remittance line level."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid at remittance line level."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility verification KPIs — verification success, benefit exposure, and front-end coverage risk indicators."
  source: "`vibe_healthcare_v1`.`claim`.`eligibility`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the eligibility verification transaction."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Coverage status returned by the payer."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage for benefit analysis."
    - name: "network_status"
      expr: network_status
      comment: "In/out of network status for cost-share analysis."
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Verification month bucket for trending."
  measures:
    - name: "eligibility_check_count"
      expr: COUNT(1)
      comment: "Total eligibility verifications — front-end volume baseline."
    - name: "verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of checks successfully verified — front-end eligibility KPI."
    - name: "active_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coverage_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with active coverage — coverage risk indicator."
    - name: "avg_deductible_remaining"
      expr: ROUND(AVG(CAST(deductible_remaining_amount AS DOUBLE)), 2)
      comment: "Average deductible remaining — patient collection exposure signal."
    - name: "avg_copay_amount"
      expr: ROUND(AVG(CAST(copay_amount AS DOUBLE)), 2)
      comment: "Average copay across verified benefits — point-of-service collection estimate."
    - name: "prior_auth_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of coverage requiring prior authorization — workflow demand indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of benefits KPIs — primary vs secondary payment split and duplicate-payment prevention effectiveness."
  source: "`vibe_healthcare_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Status of the COB determination."
    - name: "determination_method"
      expr: determination_method
      comment: "Method used to determine benefit coordination."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Medicare Secondary Payer indicator."
    - name: "crossover_claim_indicator"
      expr: crossover_claim_indicator
      comment: "Whether the claim crossed over automatically to secondary."
    - name: "determination_month"
      expr: DATE_TRUNC('MONTH', determination_date)
      comment: "Determination month bucket for trending."
  measures:
    - name: "cob_count"
      expr: COUNT(1)
      comment: "Total COB determinations — volume baseline."
    - name: "total_primary_paid_amount"
      expr: SUM(CAST(primary_paid_amount AS DOUBLE))
      comment: "Total paid by primary payer."
    - name: "total_secondary_paid_amount"
      expr: SUM(CAST(secondary_paid_amount AS DOUBLE))
      comment: "Total paid by secondary payer — recovered secondary revenue."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(total_patient_responsibility_amount AS DOUBLE))
      comment: "Total residual patient responsibility after coordination."
    - name: "secondary_recovery_pct"
      expr: ROUND(100.0 * SUM(CAST(secondary_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(primary_billed_amount AS DOUBLE)), 0), 2)
      comment: "Secondary payment as a percent of primary billed — COB recovery KPI."
    - name: "duplicate_prevention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_payment_prevention_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of COB records with duplicate payment prevention applied — overpayment control KPI."
$$;