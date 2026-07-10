-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for contract agreements — tracks portfolio value, amendment activity, retention exposure, and performance bond coverage to support contract governance and financial oversight."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Closed, Terminated) for portfolio segmentation."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Lump Sum, Reimbursable, Unit Rate) for benchmarking and risk profiling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency portfolio analysis."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the contract was awarded, enabling year-over-year portfolio trend analysis."
    - name: "award_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the contract was awarded for time-series pipeline reporting."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract, relevant for legal risk segmentation."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of most recent amendment applied to the agreement."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total awarded contract value across the portfolio. Core financial KPI for executive portfolio reporting."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Sum of revised contract values reflecting approved amendments and change orders. Tracks portfolio growth vs original award."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value across the portfolio. Benchmarks deal size and informs bid strategy."
    - name: "total_performance_bond_amount"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond exposure across all agreements. Tracks financial security held against contractor performance."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages provisions across the portfolio. Quantifies schedule-risk financial exposure."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across agreements. Monitors cash-flow impact of retention policy."
    - name: "contract_value_variance"
      expr: SUM((CAST(revised_contract_value AS DOUBLE)) - (CAST(contract_value AS DOUBLE)))
      comment: "Aggregate variance between revised and original contract values. Measures scope-creep and change-order impact at portfolio level."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements. Tracks live contract workload for resource and risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment certification KPIs tracking certified amounts, deductions, retention, and payment cycle performance — critical for cash-flow management and contractor payment compliance."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Certification lifecycle status (e.g. Draft, Certified, Paid) for pipeline tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status to identify overdue or disputed certificates."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Interim, Final, Advance Recovery) for payment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the certificate for multi-currency cash-flow reporting."
    - name: "certification_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for monthly billing cycle analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g. Bank Transfer, Cheque) for treasury operations analysis."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted on this certificate."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld on this certificate."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment across all certificates. Primary cash-flow KPI for contract financial management."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions. Represents actual cash obligation to contractors."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all certificates. Tracks cumulative cash held back from contractors."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payment certificates. Quantifies financial penalties applied for schedule delays."
    - name: "total_advance_recovery"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment recovered through certificates. Tracks repayment progress against advance payment balances."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average certified work progress percentage across active certificates. Indicates overall construction completion rate."
    - name: "avg_certified_amount"
      expr: AVG(CAST(certified_amount AS DOUBLE))
      comment: "Average certified amount per certificate. Benchmarks billing cycle size for cash-flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payment certificates. Required for VAT/GST compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order KPIs measuring cost impact, schedule disruption, and approval cycle performance — essential for scope management and contract risk control."
  source: "`vibe_construction_v1`.`contract`.`contract_change_order`"
  dimensions:
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Approval lifecycle status of the change order (e.g. Pending, Approved, Rejected)."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Category of change (e.g. Scope Addition, Scope Reduction, Variation) for root-cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code driving the change order. Identifies systemic causes of scope changes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order for multi-currency cost impact reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change order became effective for trend analysis."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Measures cumulative scope-creep cost against original contract value."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of change orders. Tracks overall contract value growth from variations."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of change orders after adjustments. Represents actual financial impact on contract."
    - name: "total_ld_provision"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions embedded in change orders. Quantifies delay-risk financial exposure from variations."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks variation size for contract risk profiling."
    - name: "critical_change_order_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of change orders flagged as critical path. Tracks high-risk variations requiring executive attention."
    - name: "pending_change_order_value"
      expr: SUM(CASE WHEN contract_change_order_status = 'Pending' THEN CAST(cost_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of change orders awaiting approval. Represents uncommitted financial exposure requiring decision."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Extension of time claim KPIs tracking claim volumes, financial exposure, and resolution outcomes — critical for schedule risk management and dispute avoidance."
  source: "`vibe_construction_v1`.`contract`.`contract_eot_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g. Submitted, Under Review, Approved, Rejected)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of EOT claim (e.g. Weather, Employer Risk, Force Majeure) for root-cause analysis."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination outcome (e.g. Fully Granted, Partially Granted, Rejected) for settlement analysis."
    - name: "entitlement_basis"
      expr: entitlement_basis
      comment: "Contractual basis for entitlement (e.g. FIDIC Clause 8.4) for legal risk segmentation."
    - name: "claim_is_critical"
      expr: claim_is_critical
      comment: "Flag indicating whether the claim is on the critical path."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amount for multi-currency exposure reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', claim_submission_timestamp)
      comment: "Month of claim submission for trend analysis of claim frequency."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all EOT claims submitted. Quantifies overall schedule-delay financial exposure."
    - name: "total_final_claim_amount"
      expr: SUM(CAST(claim_final_amount AS DOUBLE))
      comment: "Total final settled amount across resolved EOT claims. Measures actual financial cost of schedule delays."
    - name: "total_ld_impact"
      expr: SUM(CAST(liquidated_damages_impact AS DOUBLE))
      comment: "Total liquidated damages impact associated with EOT claims. Tracks financial risk of delay penalties."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average EOT claim value. Benchmarks claim size for risk provisioning and dispute resolution budgeting."
    - name: "critical_claim_count"
      expr: COUNT(CASE WHEN claim_is_critical = TRUE THEN 1 END)
      comment: "Number of critical-path EOT claims. Tracks highest-risk delay events requiring executive intervention."
    - name: "claim_settlement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN determination_outcome IS NOT NULL AND claim_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims that have been fully resolved. Measures dispute resolution efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_retention_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retention ledger KPIs tracking cumulative retention balances, release activity, and bond substitutions — essential for cash-flow management and contractor relationship governance."
  source: "`vibe_construction_v1`.`contract`.`contract_retention_ledger`"
  dimensions:
    - name: "contract_retention_ledger_status"
      expr: contract_retention_ledger_status
      comment: "Status of the retention ledger entry (e.g. Active, Released, Disputed)."
    - name: "retention_source"
      expr: retention_source
      comment: "Source of the retention (e.g. Interim Certificate, Milestone) for retention mix analysis."
    - name: "retention_release_type"
      expr: retention_release_type
      comment: "Type of retention release (e.g. Practical Completion, DLP Expiry) for release trigger analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the retention entry for multi-currency cash-flow reporting."
    - name: "retention_hold_flag"
      expr: retention_hold_flag
      comment: "Flag indicating whether retention is currently on hold, blocking release."
    - name: "retention_bond_substituted_flag"
      expr: retention_bond_substituted_flag
      comment: "Flag indicating whether a retention bond has been substituted for cash retention."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of retention release for cash-flow forecasting."
  measures:
    - name: "total_retention_held"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amount currently held across all ledger entries. Core cash-flow KPI for contractor payment management."
    - name: "total_cumulative_retention_balance"
      expr: SUM(CAST(cumulative_retention_balance AS DOUBLE))
      comment: "Sum of cumulative retention balances. Tracks total cash withheld from contractors across the portfolio."
    - name: "total_retention_released"
      expr: SUM(CAST(release_amount AS DOUBLE))
      comment: "Total retention released to contractors. Measures cash returned and DLP/completion milestone achievement."
    - name: "total_retention_bond_amount"
      expr: SUM(CAST(retention_bond_amount AS DOUBLE))
      comment: "Total value of retention bonds substituted for cash. Tracks non-cash retention instruments held."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across ledger entries. Monitors consistency of retention policy application."
    - name: "on_hold_retention_count"
      expr: COUNT(CASE WHEN retention_hold_flag = TRUE THEN 1 END)
      comment: "Number of retention entries currently on hold. Identifies blocked releases requiring resolution."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute KPIs tracking claim volumes, financial exposure, legal costs, and resolution outcomes — critical for legal risk management and contract governance."
  source: "`vibe_construction_v1`.`contract`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, In Arbitration, Settled, Closed)."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. Payment, Scope, Delay) for root-cause and risk analysis."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final resolution outcome (e.g. Settled, Arbitration Award, Withdrawn) for dispute resolution effectiveness analysis."
    - name: "claim_reason_code"
      expr: claim_reason_code
      comment: "Reason code for the dispute claim. Identifies systemic contract management issues."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the dispute is classified as critical/high-risk."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the dispute claim for multi-currency exposure reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the dispute was submitted for trend analysis."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all disputes. Quantifies overall legal and contractual financial exposure."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount settled across resolved disputes. Measures actual financial cost of dispute resolution."
    - name: "total_legal_cost"
      expr: SUM(CAST(legal_cost_amount AS DOUBLE))
      comment: "Total legal costs incurred across all disputes. Tracks cost of dispute management for budget control."
    - name: "total_net_settlement"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts across resolved disputes. Represents actual cash outflow from dispute resolution."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average dispute claim value. Benchmarks dispute size for legal risk provisioning."
    - name: "dispute_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that have been closed/resolved. Measures legal team effectiveness in dispute resolution."
    - name: "critical_dispute_exposure"
      expr: SUM(CASE WHEN is_critical = TRUE THEN CAST(claim_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial exposure from critical disputes only. Highlights highest-priority legal risks for executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract milestone KPIs tracking schedule performance, liquidated damages exposure, and payment milestone achievement — essential for project delivery governance."
  source: "`vibe_construction_v1`.`contract`.`contract_milestone`"
  dimensions:
    - name: "contract_milestone_status"
      expr: contract_milestone_status
      comment: "Current status of the milestone (e.g. Pending, Achieved, Overdue)."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g. Practical Completion, Sectional Completion, Payment) for milestone mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of milestone value for multi-currency reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the milestone is on the critical path."
    - name: "ld_triggered"
      expr: ld_triggered
      comment: "Flag indicating whether liquidated damages have been triggered for this milestone."
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Planned achievement month for milestone schedule analysis."
    - name: "performance_certificate_issued"
      expr: performance_certificate_issued
      comment: "Flag indicating whether a performance certificate has been issued for this milestone."
  measures:
    - name: "total_milestone_value"
      expr: SUM(CAST(milestone_value AS DOUBLE))
      comment: "Total value of all contract milestones. Tracks payment milestone portfolio for cash-flow planning."
    - name: "total_ld_rate_exposure"
      expr: SUM(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Sum of daily LD rates across all milestones. Quantifies maximum daily financial exposure from schedule delays."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts tied to milestones. Tracks cash withheld pending milestone achievement."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance across milestones. Measures financial deviation from planned milestone values."
    - name: "overdue_milestone_count"
      expr: COUNT(CASE WHEN contract_milestone_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue milestones. Critical KPI for schedule performance and LD risk management."
    - name: "ld_triggered_milestone_count"
      expr: COUNT(CASE WHEN ld_triggered = TRUE THEN 1 END)
      comment: "Number of milestones where liquidated damages have been triggered. Tracks active LD exposure events."
    - name: "milestone_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN contract_milestone_status = 'Achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones achieved on or before planned date. Key delivery performance indicator for contract governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment KPIs tracking outstanding balances, recovery progress, and interest accrual — essential for working capital management and contractor financing oversight."
  source: "`vibe_construction_v1`.`contract`.`advance_payment`"
  dimensions:
    - name: "advance_payment_status"
      expr: advance_payment_status
      comment: "Current status of the advance payment (e.g. Active, Fully Recovered, Expired)."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of advance payment guarantee (e.g. Bank Guarantee, Insurance Bond) for security instrument analysis."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method of advance recovery (e.g. Percentage Deduction, Lump Sum) for cash-flow modeling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment for multi-currency treasury reporting."
    - name: "is_recovered"
      expr: is_recovered
      comment: "Flag indicating whether the advance has been fully recovered."
    - name: "is_guarantee_required"
      expr: is_guarantee_required
      comment: "Flag indicating whether a guarantee is required for this advance."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the advance payment was issued for cash-flow trend analysis."
  measures:
    - name: "total_gross_advance_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross advance payments issued. Tracks total working capital advanced to contractors."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding advance payment balances. Critical cash-flow KPI showing unrecovered contractor financing."
    - name: "total_cumulative_recovered"
      expr: SUM(CAST(cumulative_recovered_amount AS DOUBLE))
      comment: "Total advance amounts recovered to date. Tracks repayment progress against issued advances."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued_amount AS DOUBLE))
      comment: "Total interest accrued on advance payments. Quantifies financing cost of contractor advances."
    - name: "avg_advance_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average advance payment percentage of contract value. Benchmarks advance policy consistency across contracts."
    - name: "recovery_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_recovered_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of total advances that have been recovered. Measures advance repayment progress across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontract KPIs tracking portfolio value, risk ratings, and compliance status — essential for supply chain governance and subcontractor performance management."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Current lifecycle status of the subcontract (e.g. Active, Completed, Terminated)."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. Labour Only, Supply and Install, Design and Build) for portfolio segmentation."
    - name: "contract_category"
      expr: contract_category
      comment: "Category of subcontract work (e.g. Civil, MEP, Structural) for trade analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the subcontract for risk-weighted portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract value for multi-currency reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract for regulatory and contractual obligation tracking."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts. Tracks subcontracted work volume as a proportion of overall project cost."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value. Benchmarks subcontract package size for procurement strategy."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages provisions across subcontracts. Quantifies downstream delay-risk financial exposure."
    - name: "high_risk_subcontract_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of subcontracts rated high or critical risk. Identifies supply chain risk concentration requiring management attention."
    - name: "non_compliant_subcontract_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of subcontracts with non-compliant status. Tracks regulatory and contractual compliance gaps in the supply chain."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dlp_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defects Liability Period register KPIs tracking outstanding defects, retention exposure, and DLP closure performance — critical for post-completion contract management."
  source: "`vibe_construction_v1`.`contract`.`dlp_register`"
  dimensions:
    - name: "dlp_status"
      expr: dlp_status
      comment: "Current DLP status (e.g. Active, Expired, Closed) for portfolio lifecycle tracking."
    - name: "dlp_type"
      expr: dlp_type
      comment: "Type of DLP (e.g. Sectional, Whole Works) for segmentation."
    - name: "dlp_compliance_status"
      expr: dlp_compliance_status
      comment: "Compliance status of DLP obligations for regulatory and contractual tracking."
    - name: "is_liquidated_damages_applicable"
      expr: is_liquidated_damages_applicable
      comment: "Flag indicating whether LDs apply during the DLP period."
    - name: "dlp_certification_issued"
      expr: dlp_certification_issued
      comment: "Flag indicating whether the DLP certificate has been issued."
    - name: "dlp_end_month"
      expr: DATE_TRUNC('MONTH', dlp_end_date)
      comment: "Month the DLP expires for forward-looking retention release planning."
  measures:
    - name: "total_dlp_retention_amount"
      expr: SUM(CAST(dlp_retention_amount AS DOUBLE))
      comment: "Total retention amounts held during DLP periods. Tracks cash withheld pending defect rectification and DLP expiry."
    - name: "total_ld_amount"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages amounts applicable during DLP. Quantifies financial exposure from post-completion delays."
    - name: "avg_dlp_retention_amount"
      expr: AVG(CAST(dlp_retention_amount AS DOUBLE))
      comment: "Average DLP retention amount per register entry. Benchmarks retention levels for cash-flow planning."
    - name: "open_dlp_count"
      expr: COUNT(CASE WHEN dlp_status = 'Active' AND dlp_certification_issued = FALSE THEN 1 END)
      comment: "Number of active DLP periods without a certificate issued. Tracks post-completion obligations requiring closure."
    - name: "dlp_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dlp_certification_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DLP entries where certification has been issued. Measures post-completion contract closure efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_ld_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidated damages assessment KPIs tracking delay days, LD amounts, and waiver activity — essential for schedule enforcement and financial penalty management."
  source: "`vibe_construction_v1`.`contract`.`ld_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the LD assessment (e.g. Draft, Issued, Disputed, Waived)."
    - name: "ld_waiver_flag"
      expr: ld_waiver_flag
      comment: "Flag indicating whether the LD has been waived. Tracks commercial decisions to forgo penalty enforcement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the LD assessment for multi-currency reporting."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of LD assessment for trend analysis of delay penalty activity."
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone against which LD is assessed for milestone-level analysis."
  measures:
    - name: "total_ld_amount"
      expr: SUM(CAST(total_ld_amount AS DOUBLE))
      comment: "Total liquidated damages assessed across all assessments. Quantifies cumulative financial penalties for schedule delays."
    - name: "total_net_ld_deducted"
      expr: SUM(CAST(net_ld_deducted AS DOUBLE))
      comment: "Total net LD actually deducted from payments. Measures enforced financial penalties after waivers."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total LD amounts waived. Tracks commercial concessions and their financial impact."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily LD rate across assessments. Benchmarks penalty severity for contract risk profiling."
    - name: "ld_waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ld_waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of LD assessments where a waiver was granted. Measures commercial leniency in LD enforcement."
    - name: "ld_enforcement_rate"
      expr: ROUND(100.0 * SUM(CAST(net_ld_deducted AS DOUBLE)) / NULLIF(SUM(CAST(total_ld_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of assessed LDs that were actually deducted (not waived). Measures contract enforcement rigour."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bond and guarantee KPIs tracking financial security instruments, expiry risk, and retention coverage — essential for contract risk and treasury management."
  source: "`vibe_construction_v1`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Current status of the bond/guarantee (e.g. Active, Called, Released, Expired)."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g. Performance Bond, Advance Payment Guarantee, Retention Bond)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond/guarantee for multi-currency treasury reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the bond/guarantee for legal risk segmentation."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the bond/guarantee expires for forward-looking renewal management."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total value of all bonds and guarantees held. Tracks total financial security instruments in the contract portfolio."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond/guarantee value. Benchmarks security instrument sizing relative to contract values."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage associated with bonds. Monitors retention policy consistency."
    - name: "active_bond_value"
      expr: SUM(CASE WHEN bond_guarantee_status = 'Active' THEN CAST(bond_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of currently active bonds and guarantees. Represents live financial security coverage."
    - name: "expiring_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Active' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active bonds expiring within 90 days. Triggers renewal actions to avoid security coverage gaps."
$$;