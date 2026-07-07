-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the master contract agreement portfolio — contract values, amendments, retention, liquidated damages, and performance bonds. Used by CFO, Legal, and Commercial teams to steer contract risk and financial exposure."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Expired, Terminated) — primary filter for portfolio health analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Classification of the contract (e.g. Lump Sum, Unit Rate, Cost-Plus) — drives commercial risk profiling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the contract is denominated — essential for multi-currency portfolio reporting."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic region or site of the contract — enables regional portfolio analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract — used for legal risk segmentation."
    - name: "award_year_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the contract was awarded — supports trend analysis of contract pipeline intake."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — used for cohort and duration analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment applied to the agreement — identifies patterns in scope or value changes."
  measures:
    - name: "total_original_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across the portfolio. Core financial KPI for CFO and commercial leadership to size the contract book."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised (current) contract value after amendments. Compared against original value to quantify scope growth or reduction."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average original contract value — benchmarks deal size and informs bidding strategy."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all agreements. Critical risk KPI — if triggered, directly impacts project profitability."
    - name: "total_performance_bond_value"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond value held across the portfolio — indicates financial security coverage for contract obligations."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across contracts — high retention ties up subcontractor cash flow and signals commercial risk."
    - name: "contract_value_growth_amount"
      expr: SUM(CAST(revised_contract_value AS DOUBLE) - CAST(contract_value AS DOUBLE))
      comment: "Net contract value growth (revised minus original) across the portfolio — measures scope creep and commercial change order impact."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active contracts — baseline for portfolio size and workload capacity planning."
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of agreements in the portfolio — used as denominator for ratio KPIs and portfolio sizing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking contract amendments — financial impact, schedule impact, approval cycle, and risk. Used by Commercial Managers and Legal to control scope creep and amendment velocity."
  source: "`vibe_construction_v1`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) — drives approval pipeline monitoring."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Scope, Time, Commercial) — identifies the nature of contract changes."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the amendment — used to prioritise review and escalation."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the amendment — enables systemic analysis of change drivers."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Status of legal review for the amendment — tracks legal bottlenecks in the approval process."
    - name: "execution_status"
      expr: execution_status
      comment: "Execution status of the amendment document — monitors document completion and signing."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the amendment was approved — supports trend analysis of amendment approval velocity."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the amendment is confidential — used for access control and reporting segmentation."
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_financial AS DOUBLE))
      comment: "Total financial impact of all amendments — quantifies cumulative cost of contract changes. Key CFO and Commercial Director KPI."
    - name: "total_payment_adjustment"
      expr: SUM(CAST(payment_adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments arising from amendments — directly affects cash flow forecasting."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Sum of revised contract values across all amendments — tracks the cumulative revised contract book."
    - name: "avg_financial_impact_per_amendment"
      expr: AVG(CAST(impact_financial AS DOUBLE))
      comment: "Average financial impact per amendment — benchmarks the materiality of individual changes."
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of amendments — high amendment velocity signals poor scope definition or contract instability."
    - name: "high_risk_amendment_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN amendment_id END)
      comment: "Number of amendments rated High or Critical risk — triggers escalation and executive review."
    - name: "unsigned_amendment_count"
      expr: COUNT(CASE WHEN document_signed_flag = FALSE THEN amendment_id END)
      comment: "Number of amendments not yet signed — unexecuted amendments represent unresolved contractual exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_commercial_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for commercial change orders (CCOs) — cost impact, net value, LD provisions, and approval cycle. Used by Commercial and Finance teams to manage variation costs and contract profitability."
  source: "`vibe_construction_v1`.`contract`.`commercial_change_order`"
  dimensions:
    - name: "contract_change_order_status"
      expr: contract_change_order_status
      comment: "Current status of the commercial change order (e.g. Submitted, Approved, Rejected) — pipeline monitoring."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g. Scope, Variation, Claim) — categorises the nature of commercial changes."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause code for the change order — identifies systemic drivers of commercial variations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order — required for multi-currency financial consolidation."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the change order is on the critical path — critical CCOs require expedited approval."
    - name: "approved_by"
      expr: approved_by
      comment: "Person or role who approved the change order — used for approval authority analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the change order became effective — supports trend analysis of variation activity."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all commercial change orders — measures the full scale of contract variations."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of commercial change orders after adjustments — the actual financial impact on the contract."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of change orders — directly affects project budget and profitability."
    - name: "total_ld_provision"
      expr: SUM(CAST(ld_provision_amount AS DOUBLE))
      comment: "Total liquidated damages provisions across change orders — quantifies LD risk embedded in variations."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to change orders — tracks commercial corrections and reconciliations."
    - name: "avg_net_amount_per_cco"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per commercial change order — benchmarks variation materiality."
    - name: "critical_cco_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN commercial_change_order_id END)
      comment: "Number of critical commercial change orders — critical CCOs require immediate executive attention."
    - name: "total_cco_count"
      expr: COUNT(1)
      comment: "Total number of commercial change orders — high count signals scope instability."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for contract disputes — claim values, settlement amounts, legal costs, and resolution outcomes. Used by Legal, Commercial, and Executive teams to manage dispute risk and resolution efficiency."
  source: "`vibe_construction_v1`.`contract`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, In Arbitration, Resolved) — tracks dispute pipeline."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. Payment, Scope, Delay) — identifies the most common dispute categories."
    - name: "claim_reason_code"
      expr: claim_reason_code
      comment: "Root cause code for the claim — enables systemic analysis of dispute drivers."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (e.g. Settled, Won, Lost) — measures legal and commercial effectiveness."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute — used to triage and escalate high-priority disputes."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the dispute is critical — critical disputes require board-level awareness."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the claim amount — required for multi-currency dispute portfolio reporting."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the dispute was resolved — supports trend analysis of resolution velocity."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total value of all claims raised — quantifies the full financial exposure from disputes. Critical risk KPI for CFO and Legal."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts paid or received — measures the actual financial outcome of dispute resolution."
    - name: "total_legal_cost"
      expr: SUM(CAST(legal_cost_amount AS DOUBLE))
      comment: "Total legal costs incurred across all disputes — a direct P&L charge that executives monitor closely."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total resolution amounts agreed — compared against claim amounts to assess negotiation effectiveness."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average claim amount per dispute — benchmarks dispute materiality and informs legal resource allocation."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status NOT IN ('Resolved', 'Closed') THEN dispute_id END)
      comment: "Number of unresolved disputes — a high open count signals unmanaged contractual risk."
    - name: "critical_dispute_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN dispute_id END)
      comment: "Number of critical disputes — requires board-level escalation and immediate legal action."
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes — baseline for dispute rate and portfolio risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for payment certificates — certified amounts, net amounts due, retention, LD deductions, and payment status. Used by Finance and Commercial teams to manage cash flow and payment compliance."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Current status of the payment certificate (e.g. Draft, Certified, Paid) — tracks payment pipeline."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status — identifies overdue or unpaid certificates."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Progress, Final, Advance Recovery) — categorises cash flow by payment nature."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment certificate — required for multi-currency cash flow reporting."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted — tracks LD enforcement across the portfolio."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld — monitors retention management."
    - name: "is_advance_recovered"
      expr: is_advance_recovered
      comment: "Flag indicating whether advance payment has been recovered — tracks advance recovery progress."
    - name: "certification_month"
      expr: DATE_TRUNC('MONTH', certification_date)
      comment: "Month the certificate was issued — supports monthly cash flow trend analysis."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due — used for cash flow forecasting and overdue payment identification."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment — the primary cash outflow KPI for Finance and Commercial teams."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions — the actual cash obligation to be settled."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts withheld across certificates — tracks cash tied up in retention."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from payment certificates — measures LD enforcement impact on cash flow."
    - name: "total_advance_recovery"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payments recovered — tracks progress in recouping advance payments from contractors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on payment certificates — required for tax compliance and cash flow planning."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage across certified payments — indicates overall project execution pace."
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Total number of payment certificates issued — baseline for payment cycle frequency analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the contractual payment schedule — gross amounts, net amounts, retention, advance payments, and discount tracking. Used by Finance to manage cash flow forecasting and payment compliance."
  source: "`vibe_construction_v1`.`contract`.`payment_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the scheduled payment (e.g. Pending, Paid, Overdue) — core cash flow management dimension."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Milestone, Progress, Final) — categorises cash flow by payment nature."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the payment schedule record — tracks schedule validity and currency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — required for multi-currency cash flow consolidation."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. Bank Transfer, Cheque) — used for treasury and payment operations analysis."
    - name: "is_final_payment"
      expr: is_final_payment
      comment: "Flag indicating whether this is the final payment — used to track contract financial close."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Flag indicating whether this is an advance payment — tracks advance payment exposure."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the payment is due — primary time dimension for cash flow forecasting."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross scheduled payment amount — the full contractual cash obligation before deductions."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net scheduled payment amount — the actual cash outflow after retention and adjustments."
    - name: "total_net_amount_after_discount"
      expr: SUM(CAST(net_amount_after_discount AS DOUBLE))
      comment: "Total net amount after early payment discounts — measures the benefit of discount programs."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across the payment schedule — tracks cash tied up in retention obligations."
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments scheduled — quantifies upfront cash exposure to contractors."
    - name: "total_advance_balance_remaining"
      expr: SUM(CAST(advance_balance_remaining AS DOUBLE))
      comment: "Total advance balance yet to be recovered — outstanding advance exposure requiring active management."
    - name: "total_retention_release_amount"
      expr: SUM(CAST(retention_release_amount AS DOUBLE))
      comment: "Total retention scheduled for release — tracks upcoming cash outflows from retention release obligations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on the payment schedule — required for tax planning and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across the payment schedule — measures commercial discount program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for subcontract portfolio management — subcontract values, liquidated damages exposure, compliance, and risk. Used by Procurement, Commercial, and Project teams to manage subcontractor performance and financial risk."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Current status of the subcontract (e.g. Active, Completed, Terminated) — portfolio health monitoring."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. Labour, Supply, Design-Build) — categorises subcontractor engagement model."
    - name: "contract_category"
      expr: contract_category
      comment: "Commercial category of the subcontract — used for spend analysis and category management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract — non-compliant subcontracts represent regulatory and project risk."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the subcontract — drives prioritisation of subcontractor oversight."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract — required for multi-currency subcontract portfolio reporting."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the subcontract is scheduled to complete — used for resource and cash flow planning."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the subcontract became effective — supports cohort and duration analysis."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts — the primary subcontract spend KPI for Procurement and Finance."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value — benchmarks deal size and informs subcontractor selection strategy."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across subcontracts — quantifies financial risk from subcontractor delays."
    - name: "non_compliant_subcontract_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Approved') THEN subcontract_id END)
      comment: "Number of non-compliant subcontracts — non-compliance triggers regulatory risk and potential project shutdown."
    - name: "high_risk_subcontract_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN subcontract_id END)
      comment: "Number of high or critical risk subcontracts — requires immediate commercial and project management intervention."
    - name: "active_subcontract_count"
      expr: COUNT(CASE WHEN subcontract_status = 'Active' THEN subcontract_id END)
      comment: "Number of currently active subcontracts — baseline for subcontractor workload and oversight capacity."
    - name: "total_subcontract_count"
      expr: COUNT(1)
      comment: "Total number of subcontracts — used as denominator for compliance rate and risk rate KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for subcontractor payment execution — gross amounts, net amounts, retention, LD deductions, and late payment tracking. Used by Finance and Procurement to manage subcontractor cash flow and payment compliance."
  source: "`vibe_construction_v1`.`contract`.`subcontract_payment`"
  dimensions:
    - name: "subcontract_payment_status"
      expr: subcontract_payment_status
      comment: "Current status of the subcontract payment (e.g. Pending, Paid, Overdue) — payment pipeline monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of subcontract payment (e.g. Progress, Final, Retention Release) — categorises cash flow."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment — used for treasury operations and payment channel analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — required for multi-currency subcontractor payment reporting."
    - name: "is_late_payment"
      expr: is_late_payment
      comment: "Flag indicating whether the payment was made late — late payments trigger penalty interest and relationship risk."
    - name: "is_ld_deduction_applied"
      expr: is_ld_deduction_applied
      comment: "Flag indicating whether LD deductions were applied — tracks LD enforcement against subcontractors."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld — monitors retention management for subcontractors."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made — primary time dimension for subcontractor cash flow analysis."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross subcontractor payments — the full cash outflow to subcontractors before deductions."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net subcontractor payments after all deductions — the actual cash paid to subcontractors."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from subcontractor payments — tracks cash owed back to subcontractors on completion."
    - name: "total_ld_deductions"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total LD deductions applied to subcontractor payments — measures financial enforcement of delay penalties."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments applied — tracks commercial corrections and reconciliation amounts."
    - name: "avg_retention_percent"
      expr: AVG(CAST(retention_percent AS DOUBLE))
      comment: "Average retention percentage applied to subcontractor payments — benchmarks retention policy consistency."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN is_late_payment = TRUE THEN subcontract_payment_id END)
      comment: "Number of late subcontractor payments — late payments expose the business to penalty interest and reputational risk."
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of subcontract payment transactions — baseline for payment frequency and volume analysis."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for bonds and guarantees portfolio — bond values, retention, expiry tracking, and status. Used by Finance and Legal to manage financial security instruments and ensure timely renewal or release."
  source: "`vibe_construction_v1`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Current status of the bond or guarantee (e.g. Active, Released, Called) — portfolio health monitoring."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g. Performance, Advance Payment, Retention) — categorises financial security instruments."
    - name: "guarantee_purpose"
      expr: guarantee_purpose
      comment: "Purpose of the guarantee — provides context for why the instrument was issued."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond or guarantee — required for multi-currency financial security reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the bond — used for regulatory compliance and legal risk segmentation."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the bond or guarantee expires — critical for renewal management and avoiding lapses in coverage."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the bond or guarantee was issued — supports portfolio vintage analysis."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total value of all bonds and guarantees — quantifies the financial security coverage held across the portfolio."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond or guarantee value — benchmarks instrument sizing relative to contract values."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage associated with bonds — monitors retention-linked financial security levels."
    - name: "active_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Active' THEN bond_guarantee_id END)
      comment: "Number of currently active bonds and guarantees — baseline for financial security portfolio size."
    - name: "called_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Called' THEN bond_guarantee_id END)
      comment: "Number of bonds that have been called — called bonds signal contractor default and trigger legal action."
    - name: "total_bond_count"
      expr: COUNT(1)
      comment: "Total number of bonds and guarantees — used as denominator for call rate and active rate KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_insurance_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the insurance register — coverage amounts, premiums, deductibles, compliance, and expiry tracking. Used by Risk, Legal, and Finance to ensure adequate insurance coverage and regulatory compliance."
  source: "`vibe_construction_v1`.`contract`.`insurance_register`"
  dimensions:
    - name: "insurance_register_status"
      expr: insurance_register_status
      comment: "Current status of the insurance policy (e.g. Active, Expired, Cancelled) — portfolio health monitoring."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of insurance coverage (e.g. Public Liability, Professional Indemnity, CAR) — categorises risk coverage."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the insurance policy — non-compliant policies represent regulatory and contractual risk."
    - name: "risk_class"
      expr: risk_class
      comment: "Risk class of the insured item — used for risk-based insurance portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the insurance policy — required for multi-currency insurance portfolio reporting."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the policy meets regulatory requirements — non-compliant policies require immediate remediation."
    - name: "renewal_notification_sent"
      expr: renewal_notification_sent
      comment: "Flag indicating whether renewal notification has been sent — tracks renewal management process."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the insurance policy expires — critical for renewal planning and avoiding coverage gaps."
  measures:
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across the portfolio — quantifies the financial protection held by the organisation."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total insurance premiums payable — a direct cost line item monitored by Finance and Risk."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across policies — quantifies the self-insured retention exposure."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per policy — benchmarks coverage adequacy relative to project risk."
    - name: "non_compliant_policy_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN insurance_register_id END)
      comment: "Number of policies failing regulatory compliance — non-compliant policies must be remediated immediately to avoid project shutdown."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN insurance_register_status = 'Active' THEN insurance_register_id END)
      comment: "Number of currently active insurance policies — baseline for coverage portfolio size."
    - name: "total_policy_count"
      expr: COUNT(1)
      comment: "Total number of insurance register entries — used as denominator for compliance rate KPIs."
$$;