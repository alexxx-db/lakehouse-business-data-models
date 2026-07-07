-- Metric views for domain: contract | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment exposure, recovery progress, and interest accrual KPIs. Used by finance and commercial teams to manage advance repayment schedules and outstanding balance risk."
  source: "`vibe_construction_v1`.`contract`.`advance_payment`"
  dimensions:
    - name: "advance_payment_status"
      expr: advance_payment_status
      comment: "Status of the advance payment (e.g. Issued, Partially Recovered, Fully Recovered)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment for multi-currency exposure reporting."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method of advance recovery (e.g. Percentage Deduction, Fixed Instalment) for cash-flow planning."
    - name: "guarantee_type"
      expr: guarantee_type
      comment: "Type of advance payment guarantee (e.g. Bank Guarantee, Insurance Bond) for security risk analysis."
    - name: "is_recovered"
      expr: is_recovered
      comment: "Flag indicating whether the advance has been fully recovered."
    - name: "is_interest_applicable"
      expr: is_interest_applicable
      comment: "Flag indicating whether interest is charged on the advance, affecting total repayment cost."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the advance was issued for time-series advance exposure analysis."
  measures:
    - name: "total_advance_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross advance payments issued. Primary KPI for advance payment exposure at portfolio level."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding advance balance yet to be recovered. Tracks unrecovered advance risk."
    - name: "total_cumulative_recovered"
      expr: SUM(CAST(cumulative_recovered_amount AS DOUBLE))
      comment: "Total advance amounts recovered to date. Measures repayment progress against total issued."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued_amount AS DOUBLE))
      comment: "Total interest accrued on advance payments. Quantifies financing cost of advance payment arrangements."
    - name: "advance_payment_count"
      expr: COUNT(1)
      comment: "Total number of advance payments issued. Volume indicator for advance payment programme scale."
    - name: "unrecovered_advance_count"
      expr: COUNT(CASE WHEN is_recovered = FALSE THEN 1 END)
      comment: "Number of advances not yet fully recovered. Prioritises recovery monitoring and guarantee enforcement."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding advance balance per payment. Benchmarks recovery pace for cash-flow forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the contract agreement portfolio — contract values, retention exposure, LD provisions, and amendment activity. Used by commercial directors and CFOs to steer contract risk and revenue recognition."
  source: "`vibe_construction_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (e.g. Active, Closed, Suspended) for portfolio segmentation."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract delivery model (e.g. Lump Sum, Reimbursable, EPC) for commercial analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency portfolio reporting."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract, relevant for legal risk segmentation."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the contract was awarded, enabling year-on-year portfolio trend analysis."
    - name: "award_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the contract was awarded for time-series award volume tracking."
    - name: "revised_completion_year"
      expr: YEAR(revised_completion_date)
      comment: "Year of the revised completion date, used to forecast contract closeout pipeline."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total original contract value across the portfolio. Core revenue baseline for commercial reporting."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Total revised contract value reflecting approved amendments and change orders. Tracks portfolio growth vs. original award."
    - name: "total_ld_provision"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages provisions across all agreements. Signals schedule risk exposure at portfolio level."
    - name: "total_performance_bond"
      expr: SUM(CAST(performance_bond_amount AS DOUBLE))
      comment: "Total performance bond value held across the portfolio. Indicates financial security coverage."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across agreements. Informs cash-flow planning and subcontractor payment strategy."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of agreements in the portfolio. Baseline volume metric for workload and pipeline analysis."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active agreements. Drives resource allocation and commercial oversight decisions."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value across the portfolio. Benchmarks deal size and informs bid strategy."
    - name: "contract_value_variance"
      expr: SUM(CAST(revised_contract_value AS DOUBLE) - CAST(contract_value AS DOUBLE))
      comment: "Aggregate variance between revised and original contract values. Measures scope growth / commercial exposure across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment KPIs covering financial impact, schedule impact, and approval activity. Used by commercial and legal teams to govern contract change management and risk exposure."
  source: "`vibe_construction_v1`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Approval status of the amendment (e.g. Draft, Approved, Rejected, Executed)."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Scope Change, Price Adjustment, Extension) for change categorisation."
    - name: "amendment_category"
      expr: amendment_category
      comment: "Category of the amendment for portfolio-level change pattern analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the amendment for prioritised governance review."
    - name: "execution_status"
      expr: execution_status
      comment: "Execution status of the amendment document (e.g. Signed, Pending Signature)."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective for trend analysis of contract change activity."
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(impact_financial AS DOUBLE))
      comment: "Total financial impact of all amendments. Measures aggregate contract value change driven by amendments."
    - name: "total_payment_adjustment"
      expr: SUM(CAST(payment_adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments arising from amendments. Tracks cash-flow impact of contract changes."
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of amendments raised. Volume indicator for contract instability and change management workload."
    - name: "approved_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Approved' THEN 1 END)
      comment: "Number of approved amendments. Tracks approved scope and value changes to the contract."
    - name: "high_risk_amendment_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk amendments. Prioritises legal and commercial review for risk mitigation."
    - name: "avg_financial_impact"
      expr: AVG(CAST(impact_financial AS DOUBLE))
      comment: "Average financial impact per amendment. Benchmarks amendment size for contingency and approval threshold setting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_bond_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bond and guarantee portfolio KPIs covering value, expiry risk, and retention exposure. Used by treasury, legal, and commercial teams to manage financial security instruments."
  source: "`vibe_construction_v1`.`contract`.`bond_guarantee`"
  dimensions:
    - name: "bond_guarantee_status"
      expr: bond_guarantee_status
      comment: "Status of the bond or guarantee (e.g. Active, Called, Released, Expired)."
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond or guarantee (e.g. Performance Bond, Advance Payment Guarantee, Retention Bond)."
    - name: "guarantee_purpose"
      expr: guarantee_purpose
      comment: "Purpose of the guarantee instrument for risk categorisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency security portfolio reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the bond for regulatory compliance tracking."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the bond expires for renewal pipeline management."
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total value of bonds and guarantees held. Primary KPI for financial security coverage at portfolio level."
    - name: "bond_count"
      expr: COUNT(1)
      comment: "Total number of bonds and guarantees. Volume indicator for treasury management workload."
    - name: "active_bond_count"
      expr: COUNT(CASE WHEN bond_guarantee_status = 'Active' THEN 1 END)
      comment: "Number of currently active bonds. Tracks live financial security coverage."
    - name: "avg_bond_amount"
      expr: AVG(CAST(bond_amount AS DOUBLE))
      comment: "Average bond value. Benchmarks security instrument size for risk adequacy assessment."
    - name: "total_retention_percentage_avg"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage associated with bond instruments. Informs retention bond substitution strategy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract closeout KPIs covering final account values, variance, and completion status. Used by commercial directors and project managers to govern contract finalisation and financial settlement."
  source: "`vibe_construction_v1`.`contract`.`closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Status of the closeout record (e.g. In Progress, Finalised, Disputed)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at closeout for regulatory obligation tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the closeout settlement for multi-currency reporting."
    - name: "is_finalized"
      expr: is_finalized
      comment: "Flag indicating whether the closeout has been fully finalised."
    - name: "eot_claims_settled_flag"
      expr: eot_claims_settled_flag
      comment: "Flag indicating all EOT claims have been settled at closeout."
    - name: "retention_release_flag"
      expr: retention_release_flag
      comment: "Flag indicating retention has been released at closeout."
    - name: "closeout_month"
      expr: DATE_TRUNC('MONTH', closeout_date)
      comment: "Month of contract closeout for pipeline and throughput analysis."
  measures:
    - name: "total_final_contract_value"
      expr: SUM(CAST(final_contract_value AS DOUBLE))
      comment: "Total final contract value across all closeout records. Measures actual contract outturn vs. original award."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Total original contract value at closeout. Baseline for variance and scope growth analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between final and original contract values. Quantifies aggregate scope growth and cost overrun."
    - name: "total_final_account_gross"
      expr: SUM(CAST(final_account_gross_amount AS DOUBLE))
      comment: "Total gross final account value. Represents total commercial settlement at contract completion."
    - name: "closeout_count"
      expr: COUNT(1)
      comment: "Total number of closeout records. Volume indicator for contract completion throughput."
    - name: "finalised_closeout_count"
      expr: COUNT(CASE WHEN is_finalized = TRUE THEN 1 END)
      comment: "Number of fully finalised closeouts. Tracks completion rate of the contract closeout pipeline."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average contract value variance at closeout. Benchmarks cost growth per contract for bid and contingency strategy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute volume, financial exposure, and resolution KPIs. Used by legal counsel, commercial directors, and executives to manage litigation risk and settlement outcomes."
  source: "`vibe_construction_v1`.`contract`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, In Arbitration, Settled, Closed)."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. Payment, EOT, Scope, Quality) for root-cause categorisation."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of dispute resolution (e.g. Settled, Arbitration Award, Withdrawn) for win/loss analysis."
    - name: "claim_currency"
      expr: claim_currency
      comment: "Currency of the dispute claim for multi-currency exposure reporting."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the dispute is critical, requiring executive escalation."
    - name: "fidic_clause"
      expr: fidic_clause
      comment: "FIDIC clause under which the dispute is raised, for contractual risk pattern analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', CAST(submission_timestamp AS DATE))
      comment: "Month the dispute was submitted for trend analysis of dispute frequency."
  measures:
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total financial value of all disputes raised. Primary KPI for legal and commercial risk exposure."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount settled across resolved disputes. Measures actual financial outcome vs. claimed exposure."
    - name: "total_legal_cost"
      expr: SUM(CAST(legal_cost_amount AS DOUBLE))
      comment: "Total legal costs incurred across disputes. Tracks dispute management overhead for cost control."
    - name: "total_net_settlement"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amounts across all disputes. Represents net financial impact after legal costs."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Volume indicator for contract relationship health and legal workload."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Open' THEN 1 END)
      comment: "Number of currently open disputes. Drives legal resource allocation and risk provisioning decisions."
    - name: "critical_dispute_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical disputes requiring executive attention. Prioritises escalation and settlement negotiation."
    - name: "avg_claim_amount"
      expr: AVG(CAST(claim_amount AS DOUBLE))
      comment: "Average dispute claim value. Benchmarks dispute size for legal provisioning and insurance adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_dlp_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defects Liability Period KPIs covering outstanding defects, retention exposure, and DLP closure status. Used by project directors and commercial teams to manage post-completion obligations."
  source: "`vibe_construction_v1`.`contract`.`dlp_register`"
  dimensions:
    - name: "dlp_status"
      expr: dlp_status
      comment: "Current status of the DLP record (e.g. Active, Closed, Extended)."
    - name: "dlp_type"
      expr: dlp_type
      comment: "Type of DLP (e.g. Structural, MEP, Civil) for defect category analysis."
    - name: "dlp_compliance_status"
      expr: dlp_compliance_status
      comment: "Compliance status of the DLP record for regulatory and contractual obligation tracking."
    - name: "dlp_extension_granted"
      expr: dlp_extension_granted
      comment: "Flag indicating whether a DLP extension was granted, signalling unresolved defect risk."
    - name: "is_liquidated_damages_applicable"
      expr: is_liquidated_damages_applicable
      comment: "Flag indicating LD applicability during the DLP period."
    - name: "dlp_end_year"
      expr: YEAR(dlp_end_date)
      comment: "Year the DLP ends for closeout pipeline planning."
  measures:
    - name: "total_dlp_retention"
      expr: SUM(CAST(dlp_retention_amount AS DOUBLE))
      comment: "Total retention held during DLP periods. Tracks post-completion cash liability to contractors."
    - name: "total_ld_amount"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total LD amounts applicable during DLP. Quantifies penalty exposure in the post-completion phase."
    - name: "dlp_record_count"
      expr: COUNT(1)
      comment: "Total number of DLP records. Volume indicator for post-completion obligation management workload."
    - name: "active_dlp_count"
      expr: COUNT(CASE WHEN dlp_status = 'Active' THEN 1 END)
      comment: "Number of currently active DLP records. Drives resource allocation for defect rectification oversight."
    - name: "extended_dlp_count"
      expr: COUNT(CASE WHEN dlp_extension_granted = TRUE THEN 1 END)
      comment: "Number of DLPs with extensions granted. Signals persistent defect issues requiring escalation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_insurance_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance certificate compliance and coverage KPIs. Used by risk managers and contract administrators to ensure adequate insurance coverage across the project and subcontractor portfolio."
  source: "`vibe_construction_v1`.`contract`.`insurance_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Status of the insurance certificate (e.g. Valid, Expired, Non-Compliant)."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of insurance policy (e.g. Public Liability, Professional Indemnity, CAR) for coverage analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certificate for compliance governance."
    - name: "insurer_name"
      expr: insurer_name
      comment: "Name of the insurer for counterparty concentration risk analysis."
    - name: "coverage_currency"
      expr: coverage_currency
      comment: "Currency of the coverage amount for multi-currency insurance portfolio reporting."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certificate expiry for renewal pipeline management."
  measures:
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value across all certificates. Primary KPI for risk coverage adequacy."
    - name: "total_aggregate_limit"
      expr: SUM(CAST(aggregate_limit AS DOUBLE))
      comment: "Total aggregate insurance limits across the portfolio. Measures maximum insured exposure."
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Total number of insurance certificates. Volume indicator for insurance compliance management workload."
    - name: "non_compliant_certificate_count"
      expr: COUNT(CASE WHEN certificate_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant certificates. Drives urgent remediation to avoid uninsured risk exposure."
    - name: "expired_certificate_count"
      expr: COUNT(CASE WHEN certificate_status = 'Expired' THEN 1 END)
      comment: "Number of expired certificates. Flags gaps in insurance coverage requiring immediate renewal."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average coverage amount per certificate. Benchmarks coverage adequacy across the subcontractor portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_ld_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidated damages assessment KPIs covering LD amounts levied, waiver activity, and delay days. Used by commercial and legal teams to enforce contract penalties and manage waiver risk."
  source: "`vibe_construction_v1`.`contract`.`ld_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the LD assessment (e.g. Draft, Finalised, Waived) for pipeline management."
    - name: "ld_waiver_flag"
      expr: ld_waiver_flag
      comment: "Indicates whether the LD was waived, enabling analysis of waiver frequency and financial impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the LD assessment for multi-currency reporting."
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the milestone against which LD is assessed, for milestone-level penalty tracking."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for time-series LD trend analysis."
  measures:
    - name: "total_ld_amount"
      expr: SUM(CAST(total_ld_amount AS DOUBLE))
      comment: "Total liquidated damages assessed across all records. Primary KPI for schedule penalty enforcement."
    - name: "total_net_ld_deducted"
      expr: SUM(CAST(net_ld_deducted AS DOUBLE))
      comment: "Total net LD actually deducted after waivers. Measures realised penalty revenue vs. assessed exposure."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total LD waived across assessments. Quantifies commercial concessions granted to contractors."
    - name: "ld_assessment_count"
      expr: COUNT(1)
      comment: "Total number of LD assessments raised. Volume indicator for schedule non-compliance frequency."
    - name: "waived_assessment_count"
      expr: COUNT(CASE WHEN ld_waiver_flag = TRUE THEN 1 END)
      comment: "Number of assessments where LD was waived. Tracks waiver frequency for commercial governance review."
    - name: "avg_ld_rate_per_day"
      expr: AVG(CAST(ld_rate_per_day AS DOUBLE))
      comment: "Average daily LD rate across assessments. Benchmarks penalty severity across the contract portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash-flow and payment performance KPIs derived from payment certificates. Used by finance directors and project commercial managers to monitor certified amounts, deductions, and payment timeliness."
  source: "`vibe_construction_v1`.`contract`.`payment_certificate`"
  dimensions:
    - name: "payment_certificate_status"
      expr: payment_certificate_status
      comment: "Approval and processing status of the certificate (e.g. Draft, Certified, Paid)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status (e.g. Pending, Paid, Overdue) for cash-flow monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Interim, Final, Advance Recovery) for payment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the certificate for multi-currency cash-flow reporting."
    - name: "is_ld_applied"
      expr: is_ld_applied
      comment: "Flag indicating whether liquidated damages were deducted on this certificate."
    - name: "is_retention_applied"
      expr: is_retention_applied
      comment: "Flag indicating whether retention was withheld on this certificate."
    - name: "certification_month"
      expr: DATE_TRUNC('MONTH', CAST(certification_date AS DATE))
      comment: "Month of certification for time-series cash-flow trend analysis."
    - name: "payment_due_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due, enabling overdue payment pipeline reporting."
  measures:
    - name: "total_certified_amount"
      expr: SUM(CAST(certified_amount AS DOUBLE))
      comment: "Total value certified for payment across all certificates. Primary cash-flow KPI for project commercial reporting."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after all deductions. Represents actual cash obligation to contractors."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across certificates. Tracks retention liability and release timing."
    - name: "total_ld_deducted"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total liquidated damages deducted from certificates. Quantifies schedule penalty exposure realised."
    - name: "total_advance_recovered"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance payment recovered through certificates. Monitors advance repayment progress."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across payment certificates. Required for VAT/GST compliance reporting."
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Total number of payment certificates issued. Volume indicator for payment processing workload."
    - name: "avg_work_progress_percent"
      expr: AVG(CAST(work_progress_percent AS DOUBLE))
      comment: "Average work progress percentage at time of certification. Correlates payment pace with physical progress."
    - name: "avg_certified_amount"
      expr: AVG(CAST(certified_amount AS DOUBLE))
      comment: "Average certified amount per certificate. Benchmarks payment run size for cash-flow forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment schedule KPIs covering planned vs. actual payment flows, retention, and advance recovery. Used by finance and commercial teams to manage contract cash-flow obligations."
  source: "`vibe_construction_v1`.`contract`.`payment_schedule`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the scheduled payment (e.g. Scheduled, Paid, Overdue)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Interim, Final, Advance) for payment mix analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the payment schedule entry for pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scheduled payment for multi-currency cash-flow reporting."
    - name: "is_final_payment"
      expr: is_final_payment
      comment: "Flag indicating whether this is the final payment, used to track contract financial closure."
    - name: "advance_payment_flag"
      expr: advance_payment_flag
      comment: "Flag indicating this is an advance payment entry for advance exposure tracking."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment is due for cash-flow forecasting."
  measures:
    - name: "total_gross_scheduled"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount scheduled for payment. Primary cash-flow planning KPI."
    - name: "total_net_scheduled"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount scheduled after deductions. Represents actual cash obligation in the payment plan."
    - name: "total_retention_scheduled"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention to be withheld per the payment schedule. Tracks planned retention accumulation."
    - name: "total_advance_recovery_scheduled"
      expr: SUM(CAST(advance_recovery_amount AS DOUBLE))
      comment: "Total advance recovery amounts scheduled. Tracks planned repayment of advance payments."
    - name: "total_tax_scheduled"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts in the payment schedule. Required for VAT/GST cash-flow planning."
    - name: "payment_schedule_entry_count"
      expr: COUNT(1)
      comment: "Total number of payment schedule entries. Volume indicator for payment plan complexity."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per schedule entry. Benchmarks payment run size for treasury planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontract portfolio KPIs covering value, risk, and compliance. Used by supply chain directors and project managers to govern subcontractor performance and financial exposure."
  source: "`vibe_construction_v1`.`contract`.`subcontract`"
  dimensions:
    - name: "subcontract_status"
      expr: subcontract_status
      comment: "Lifecycle status of the subcontract (e.g. Active, Completed, Terminated)."
    - name: "subcontract_type"
      expr: subcontract_type
      comment: "Type of subcontract (e.g. Labour Only, Supply and Install, Design and Build) for portfolio segmentation."
    - name: "contract_category"
      expr: contract_category
      comment: "Commercial category of the subcontract for spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subcontract for multi-currency spend reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the subcontract (e.g. High, Medium, Low) for risk-weighted portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the subcontract for regulatory and contractual obligation tracking."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the subcontract became effective for year-on-year subcontract volume analysis."
  measures:
    - name: "total_subcontract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all subcontracts. Primary KPI for subcontractor spend and supply chain cost management."
    - name: "total_ld_provision"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total LD provisions across subcontracts. Quantifies schedule penalty exposure in the supply chain."
    - name: "subcontract_count"
      expr: COUNT(1)
      comment: "Total number of subcontracts. Volume indicator for supply chain complexity and management overhead."
    - name: "active_subcontract_count"
      expr: COUNT(CASE WHEN subcontract_status = 'Active' THEN 1 END)
      comment: "Number of currently active subcontracts. Drives subcontractor oversight and payment management workload."
    - name: "high_risk_subcontract_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk subcontracts. Prioritises enhanced monitoring and contingency planning."
    - name: "avg_subcontract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average subcontract value. Benchmarks subcontract size for procurement strategy and risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`contract_subcontract_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor payment KPIs covering gross amounts, deductions, retention, and late payment risk. Used by supply chain finance and project commercial teams to manage subcontractor cash flows."
  source: "`vibe_construction_v1`.`contract`.`subcontract_payment`"
  dimensions:
    - name: "subcontract_payment_status"
      expr: subcontract_payment_status
      comment: "Status of the subcontractor payment (e.g. Pending, Paid, Overdue)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g. Interim, Final, Advance) for payment mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g. Bank Transfer, Cheque) for treasury operations reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-currency cash-flow reporting."
    - name: "is_late_payment"
      expr: is_late_payment
      comment: "Flag indicating whether the payment was made late. Tracks late payment risk and regulatory compliance."
    - name: "is_ld_deduction_applied"
      expr: is_ld_deduction_applied
      comment: "Flag indicating LD was deducted from this payment. Monitors penalty enforcement in the supply chain."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment for time-series subcontractor cash-flow analysis."
  measures:
    - name: "total_gross_payment"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount paid to subcontractors. Primary KPI for subcontractor spend tracking."
    - name: "total_net_payment"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount paid after all deductions. Represents actual cash outflow to subcontractors."
    - name: "total_retention_withheld"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from subcontractor payments. Tracks subcontractor retention liability."
    - name: "total_ld_deducted"
      expr: SUM(CAST(ld_deduction_amount AS DOUBLE))
      comment: "Total LD deducted from subcontractor payments. Quantifies penalty enforcement in the supply chain."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor payments processed. Volume indicator for payment operations workload."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN is_late_payment = TRUE THEN 1 END)
      comment: "Number of late subcontractor payments. Tracks regulatory compliance risk and supply chain relationship health."
    - name: "avg_net_payment"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per subcontractor payment run. Benchmarks payment size for cash-flow forecasting."
$$;
