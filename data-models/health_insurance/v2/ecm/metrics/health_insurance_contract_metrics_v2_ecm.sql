-- Metric views for domain: contract | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract audit KPIs — tracks audit outcomes, financial recovery, error rates, and corrective action compliance. Per VREQ-006, renamed from contract_audit to audit. Drives provider payment integrity and compliance management."
  source: "`vibe_health_insurance_v1`.`contract`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of contract audit (payment accuracy, credentialing, compliance, clinical) for audit program segmentation."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, complete, closed) for audit pipeline management."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Compliance rating assigned at audit completion for provider compliance benchmarking."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level audit analysis."
    - name: "corrective_action_required_flag"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether a corrective action plan was required, for compliance risk tracking."
    - name: "regulatory_mandate_flag"
      expr: CAST(regulatory_mandate_flag AS STRING)
      comment: "Whether the audit was mandated by a regulatory requirement."
    - name: "audit_year"
      expr: DATE_TRUNC('YEAR', performed_date)
      comment: "Year the audit was performed for trend analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of contract audits performed. Baseline for audit program volume management."
    - name: "total_financial_recovery_amount"
      expr: SUM(CAST(financial_recovery_amount AS DOUBLE))
      comment: "Total financial recovery amount from audits. Primary ROI metric for the audit program."
    - name: "total_overpayment_amount"
      expr: SUM(CAST(overpayment_amount AS DOUBLE))
      comment: "Total overpayment amount identified across audits. Drives payment integrity and recovery program decisions."
    - name: "total_underpayment_amount"
      expr: SUM(CAST(underpayment_amount AS DOUBLE))
      comment: "Total underpayment amount identified. Informs provider payment accuracy and liability management."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average audit overall score. Benchmarks provider compliance performance across the network."
    - name: "avg_error_rate_pct"
      expr: AVG(CAST(error_rate_pct AS DOUBLE))
      comment: "Average payment error rate percentage across audits. Core payment accuracy KPI for contract management."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. Informs provider compliance risk and remediation workload."
    - name: "avg_net_payment_variance"
      expr: AVG(CAST(net_payment_variance AS DOUBLE))
      comment: "Average net payment variance identified per audit. Informs payment accuracy benchmarking and contract compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_bundled_payment_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundled payment episode KPIs — tracks episode program economics, target pricing, quality gates, and risk-sharing parameters. Drives bundled payment program design and financial management."
  source: "`vibe_health_insurance_v1`.`contract`.`bundled_payment_episode`"
  dimensions:
    - name: "episode_type"
      expr: episode_type
      comment: "Type of bundled payment episode (joint replacement, cardiac, maternity) for program segmentation."
    - name: "program_type"
      expr: program_type
      comment: "Bundled payment program type (BPCI, CJR, commercial) for program-level analysis."
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the bundled payment episode definition (active, terminated, pending)."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the bundled episode (prospective, retrospective, hybrid)."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year bundled payment program analysis."
    - name: "quality_gate_required_flag"
      expr: CAST(quality_gate_required AS STRING)
      comment: "Whether a quality gate is required for the episode, for quality-gated payment analysis."
    - name: "lob"
      expr: lob
      comment: "Line of business for LOB-level bundled payment analysis."
  measures:
    - name: "total_bundled_episodes"
      expr: COUNT(1)
      comment: "Total number of bundled payment episode definitions. Baseline for bundled payment program portfolio management."
    - name: "avg_target_price"
      expr: AVG(CAST(target_price AS DOUBLE))
      comment: "Average target price across bundled payment episodes. Core financial benchmark for episode-based payment design."
    - name: "avg_gain_sharing_rate"
      expr: AVG(CAST(gain_sharing_rate AS DOUBLE))
      comment: "Average gain-sharing rate across bundled episodes. Informs provider incentive economics in bundled payment programs."
    - name: "avg_loss_sharing_rate"
      expr: AVG(CAST(loss_sharing_rate AS DOUBLE))
      comment: "Average loss-sharing rate. Informs downside risk exposure in bundled payment arrangements."
    - name: "avg_quality_withhold_rate"
      expr: AVG(CAST(quality_withhold_rate AS DOUBLE))
      comment: "Average quality withhold rate across bundled episodes. Drives quality incentive program design."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold AS DOUBLE))
      comment: "Average stop-loss threshold for bundled episodes. Informs catastrophic cost protection in episode programs."
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average RAF adjustment factor applied to bundled episode target prices. Informs risk-adjusted pricing accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation arrangement KPIs — tracks PMPM rates, risk-sharing economics, attributed membership, and arrangement health across capitation contracts. Critical for value-based care financial management."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of capitation arrangement (global, professional, facility) for segmenting capitation economics."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the capitation arrangement (active, terminated, pending renewal)."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code for LOB-level capitation analysis."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the capitation arrangement."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier for tiered capitation rate analysis."
    - name: "is_vbc_arrangement"
      expr: CAST(vbc_arrangement_flag AS STRING)
      comment: "Whether the arrangement includes a value-based care component."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the capitation arrangement became effective."
  measures:
    - name: "total_capitation_arrangements"
      expr: COUNT(1)
      comment: "Total number of capitation arrangements. Baseline for capitation portfolio management."
    - name: "active_capitation_arrangements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active capitation arrangements. Drives capitation payment operations and risk management."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average PMPM capitation rate across arrangements. Core financial metric for capitation economics benchmarking."
    - name: "avg_risk_share_percentage"
      expr: AVG(CAST(risk_share_percentage AS DOUBLE))
      comment: "Average risk-sharing percentage across capitation arrangements. Informs risk transfer strategy and financial exposure."
    - name: "avg_withhold_percentage"
      expr: AVG(CAST(withhold_percentage AS DOUBLE))
      comment: "Average quality withhold percentage. Drives quality incentive program design and provider performance management."
    - name: "avg_aggregate_stop_loss_threshold"
      expr: AVG(CAST(aggregate_stop_loss_threshold AS DOUBLE))
      comment: "Average aggregate stop-loss threshold across arrangements. Informs catastrophic risk exposure management."
    - name: "avg_individual_stop_loss_threshold"
      expr: AVG(CAST(individual_stop_loss_threshold AS DOUBLE))
      comment: "Average individual stop-loss threshold. Informs per-member risk exposure limits in capitation contracts."
    - name: "avg_raf_adjustment_factor"
      expr: AVG(CAST(raf_adjustment_factor AS DOUBLE))
      comment: "Average RAF adjustment factor applied to capitation rates. Informs risk-adjusted payment accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capitation payment KPIs — tracks payment volumes, amounts, adjustments, and quality withholds. Directly informs capitation payment operations, financial reconciliation, and provider payment accuracy."
  source: "`vibe_health_insurance_v1`.`contract`.`capitation_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the capitation payment (paid, voided, pending, adjusted)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of capitation payment (regular, retroactive, adjustment) for payment classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (EFT, check) for payment operations analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB-level capitation payment analysis."
    - name: "payment_period_year"
      expr: DATE_TRUNC('YEAR', payment_period_start_date)
      comment: "Year of the capitation payment period for trend analysis."
    - name: "payment_period_month"
      expr: DATE_TRUNC('MONTH', payment_period_start_date)
      comment: "Month of the capitation payment period for monthly payment cycle analysis."
    - name: "is_prior_period_adjustment"
      expr: CAST(prior_period_adjustment_flag AS STRING)
      comment: "Whether the payment includes a prior period adjustment, for retroactive payment tracking."
  measures:
    - name: "total_capitation_payments"
      expr: COUNT(1)
      comment: "Total number of capitation payment transactions. Baseline for payment volume management."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross capitation payment amount. Core financial KPI for capitation expenditure management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net capitation payment amount after withholds and adjustments. Primary capitation cash flow metric."
    - name: "total_quality_withhold_amount"
      expr: SUM(CAST(quality_withhold_amount AS DOUBLE))
      comment: "Total quality withhold amount across capitation payments. Drives quality incentive program financial management."
    - name: "total_risk_pool_withhold_amount"
      expr: SUM(CAST(risk_pool_withhold_amount AS DOUBLE))
      comment: "Total risk pool withhold amount. Informs risk pool financial management and settlement decisions."
    - name: "total_stop_loss_recovery_amount"
      expr: SUM(CAST(stop_loss_recovery_amount AS DOUBLE))
      comment: "Total stop-loss recovery amount. Informs catastrophic risk reinsurance and stop-loss program performance."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average PMPM rate across capitation payments. Benchmarks actual payment rates against contracted rates."
    - name: "avg_risk_adjusted_pmpm_rate"
      expr: AVG(CAST(risk_adjusted_pmpm_rate AS DOUBLE))
      comment: "Average risk-adjusted PMPM rate. Informs RAF-adjusted payment accuracy and risk model performance."
    - name: "total_enrollment_adjustment_amount"
      expr: SUM(CAST(enrollment_adjustment_amount AS DOUBLE))
      comment: "Total enrollment adjustment amount across payments. Tracks financial impact of membership reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract dispute KPIs — tracks dispute volumes, financial exposure, resolution rates, and SLA compliance. Per VREQ-006, renamed from contract_dispute to dispute. Drives contract dispute management and provider relations decisions."
  source: "`vibe_health_insurance_v1`.`contract`.`contract_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of contract dispute (payment, rate, scope, termination) for dispute classification and root cause analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, resolved, escalated, arbitration) for pipeline management."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the dispute resolution (upheld, overturned, settled, withdrawn) for outcome analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level dispute analysis."
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the dispute was escalated, for escalation rate tracking."
    - name: "sla_met_flag"
      expr: CAST(sla_met_flag AS STRING)
      comment: "Whether the dispute was resolved within SLA, for SLA compliance analysis."
    - name: "initiation_year"
      expr: DATE_TRUNC('YEAR', initiation_date)
      comment: "Year the dispute was initiated for trend analysis."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of contract disputes. Baseline for dispute volume management."
    - name: "open_disputes"
      expr: COUNT(CASE WHEN dispute_status = 'open' THEN 1 END)
      comment: "Count of currently open disputes. Drives dispute resolution workload and resource allocation decisions."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount under dispute. Core financial risk metric for contract dispute management."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount resolved across disputes. Informs financial settlement outcomes and recovery tracking."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes resolved within SLA. Operational KPI for dispute management performance."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that were escalated. Informs dispute complexity and provider relations health."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute financial materiality for prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_delegation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegation agreement KPIs — tracks delegation scope, compliance status, audit frequency, and CMS oversight requirements. Drives delegation oversight and regulatory compliance management."
  source: "`vibe_health_insurance_v1`.`contract`.`delegation_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of delegation agreement (credentialing, UM, claims, network) for delegation scope analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the delegation agreement (active, terminated, under review)."
    - name: "delegated_function_type"
      expr: delegated_function_type
      comment: "Type of function delegated (credentialing, UM, QM) for functional delegation analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level delegation analysis."
    - name: "cms_oversight_required_flag"
      expr: CAST(cms_oversight_required AS STRING)
      comment: "Whether CMS oversight is required for the delegation, for regulatory compliance tracking."
    - name: "ncqa_compliance_flag"
      expr: CAST(ncqa_compliance_flag AS STRING)
      comment: "Whether the delegation agreement is NCQA-compliant, for accreditation management."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the delegation agreement became effective."
  measures:
    - name: "total_delegation_agreements"
      expr: COUNT(1)
      comment: "Total number of delegation agreements. Baseline for delegation oversight portfolio management."
    - name: "active_delegation_agreements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active delegation agreements. Drives delegation oversight workload and compliance management."
    - name: "cms_oversight_required_count"
      expr: COUNT(CASE WHEN cms_oversight_required = TRUE THEN 1 END)
      comment: "Number of delegation agreements requiring CMS oversight. Informs regulatory compliance workload and risk."
    - name: "ncqa_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegation agreements that are NCQA-compliant. Strategic KPI for accreditation maintenance."
    - name: "agreements_expiring_within_90_days"
      expr: COUNT(CASE WHEN termination_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Delegation agreements expiring within 90 days. Operational KPI for delegation renewal pipeline management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee schedule portfolio KPIs — tracks reimbursement schedule coverage, payment basis distribution, and schedule lifecycle health. Informs contract economics and rate management decisions."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of fee schedule (e.g., Medicare-based, negotiated, DRG) for segmenting reimbursement strategy."
    - name: "payment_basis"
      expr: payment_basis
      comment: "Basis for payment calculation (e.g., percent of billed, per diem, DRG) — key dimension for reimbursement strategy analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the fee schedule (active, superseded, pending) for lifecycle management."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code scoping the fee schedule, enabling LOB-level rate analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the fee schedule became effective, for trend and vintage analysis."
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic segmentation of fee schedules."
    - name: "is_active_flag"
      expr: CAST(is_active AS STRING)
      comment: "Whether the fee schedule is currently active."
  measures:
    - name: "total_fee_schedules"
      expr: COUNT(1)
      comment: "Total number of fee schedules in the contract portfolio. Baseline for schedule management."
    - name: "active_fee_schedules"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active fee schedules. Drives reimbursement governance and rate management decisions."
    - name: "avg_drg_base_rate"
      expr: AVG(CAST(drg_base_rate AS DOUBLE))
      comment: "Average DRG base rate across fee schedules. Key inpatient reimbursement benchmark for contract negotiations."
    - name: "avg_conversion_factor"
      expr: AVG(CAST(conversion_factor AS DOUBLE))
      comment: "Average RVU conversion factor across fee schedules. Drives professional fee reimbursement benchmarking."
    - name: "avg_payment_basis_pct"
      expr: AVG(CAST(payment_basis_pct AS DOUBLE))
      comment: "Average payment basis percentage (e.g., % of Medicare) across schedules. Informs rate competitiveness analysis."
    - name: "avg_stop_loss_threshold"
      expr: AVG(CAST(stop_loss_threshold_amt AS DOUBLE))
      comment: "Average stop-loss threshold amount across fee schedules. Informs risk exposure management in contract economics."
    - name: "schedules_expiring_within_90_days"
      expr: COUNT(CASE WHEN termination_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Fee schedules expiring within 90 days. Operational KPI for rate renewal pipeline management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_fee_schedule_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular fee schedule rate KPIs — tracks allowed amounts, payment rates, and reimbursement economics at the procedure/service level. Directly informs contract rate negotiations and payment accuracy."
  source: "`vibe_health_insurance_v1`.`contract`.`fee_schedule_rate`"
  dimensions:
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for the rate line (e.g., FFS, per diem, bundled) — primary segmentation for reimbursement analysis."
    - name: "procedure_code_type"
      expr: procedure_code_type
      comment: "Type of procedure code (CPT, HCPCS, DRG, Revenue) for coding-level rate analysis."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (e.g., Tier 1, Tier 2) for tiered reimbursement analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business scoping the rate (Commercial, Medicare, Medicaid) for LOB-level rate benchmarking."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code for site-of-care rate segmentation."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the rate became effective, for rate trend and vintage analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate line (active, superseded, pending)."
  measures:
    - name: "total_rate_lines"
      expr: COUNT(1)
      comment: "Total number of fee schedule rate lines. Baseline for rate schedule complexity and coverage analysis."
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per rate line. Core reimbursement benchmark for contract rate negotiations."
    - name: "avg_medicare_fee_schedule_pct"
      expr: AVG(CAST(medicare_fee_schedule_pct AS DOUBLE))
      comment: "Average percentage of Medicare fee schedule across rate lines. Key competitive benchmarking metric for contract economics."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate across applicable rate lines. Informs inpatient and SNF reimbursement strategy."
    - name: "avg_capitation_rate_pmpm"
      expr: AVG(CAST(capitation_rate_pmpm AS DOUBLE))
      comment: "Average capitation PMPM rate across rate lines. Drives capitation arrangement economics and risk-sharing decisions."
    - name: "avg_rate_percent_of_billed"
      expr: AVG(CAST(rate_percent_of_billed AS DOUBLE))
      comment: "Average rate as a percentage of billed charges. Informs discount depth and reimbursement competitiveness."
    - name: "avg_bundled_payment_amount"
      expr: AVG(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Average bundled payment amount across applicable rate lines. Informs episode-based payment program economics."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_financial_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract financial summary KPIs — tracks total payments, capitation, shared savings/losses, IBNR, and MLR at the contract level. Primary executive dashboard for contract financial performance."
  source: "`vibe_health_insurance_v1`.`contract`.`financial_summary`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (capitation, FFS, VBC, bundled) for financial performance segmentation."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level financial performance analysis."
    - name: "payment_methodology"
      expr: payment_methodology
      comment: "Payment methodology for financial performance segmentation."
    - name: "financial_summary_status"
      expr: financial_summary_status
      comment: "Status of the financial summary (draft, final, reconciled) for data completeness tracking."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year financial trend analysis."
    - name: "summary_period_type"
      expr: summary_period_type
      comment: "Period type (monthly, quarterly, annual) for financial reporting cadence analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the financial summary for close process management."
  measures:
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total paid amount across contract financial summaries. Primary contract expenditure metric."
    - name: "total_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amount across contracts. Informs allowed vs. paid variance and payment accuracy."
    - name: "total_capitation_paid"
      expr: SUM(CAST(total_capitation_paid AS DOUBLE))
      comment: "Total capitation payments made. Core capitation program expenditure metric."
    - name: "total_shared_savings"
      expr: SUM(CAST(total_shared_savings AS DOUBLE))
      comment: "Total shared savings generated across contracts. Primary VBC program ROI metric."
    - name: "total_shared_loss"
      expr: SUM(CAST(total_shared_loss AS DOUBLE))
      comment: "Total shared losses incurred. Informs downside risk exposure and financial reserve management."
    - name: "total_ibnr_reserve_amount"
      expr: SUM(CAST(ibnr_reserve_amount AS DOUBLE))
      comment: "Total IBNR reserve amount across contract financial summaries. Informs actuarial reserve adequacy."
    - name: "avg_medical_loss_ratio"
      expr: AVG(CAST(medical_loss_ratio AS DOUBLE))
      comment: "Average medical loss ratio across contracts. Strategic KPI for financial sustainability and ACA MLR compliance."
    - name: "avg_pmpm_cost"
      expr: AVG(CAST(pmpm_cost AS DOUBLE))
      comment: "Average PMPM cost across contract financial summaries. Core per-member cost benchmarking metric."
    - name: "total_withhold_pool_balance"
      expr: SUM(CAST(withhold_pool_balance AS DOUBLE))
      comment: "Total withhold pool balance across contracts. Informs quality incentive pool management and provider payment liability."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_incentive_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incentive arrangement KPIs — tracks quality incentive economics, earned amounts, withhold pools, and performance thresholds. Drives provider incentive program management and VBC financial decisions."
  source: "`vibe_health_insurance_v1`.`contract`.`incentive_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of incentive arrangement (quality bonus, shared savings, withhold release) for program segmentation."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the incentive arrangement (active, settled, terminated)."
    - name: "earned_status"
      expr: earned_status
      comment: "Whether the incentive has been earned (earned, forfeited, pending) for incentive outcome analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level incentive analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year incentive trend analysis."
    - name: "quality_gate_met_flag"
      expr: CAST(quality_gate_met AS STRING)
      comment: "Whether the quality gate was met, enabling quality-gated incentive analysis."
    - name: "withhold_pool_type"
      expr: withhold_pool_type
      comment: "Type of withhold pool (quality, risk, performance) for withhold program segmentation."
  measures:
    - name: "total_incentive_arrangements"
      expr: COUNT(1)
      comment: "Total number of incentive arrangements. Baseline for incentive program portfolio management."
    - name: "total_maximum_incentive_amount"
      expr: SUM(CAST(maximum_incentive_amount AS DOUBLE))
      comment: "Total maximum incentive amount at stake across arrangements. Informs incentive program financial exposure."
    - name: "total_amount_released"
      expr: SUM(CAST(amount_released AS DOUBLE))
      comment: "Total incentive amount released to providers. Core financial metric for incentive program payout management."
    - name: "total_amount_forfeited"
      expr: SUM(CAST(amount_forfeited AS DOUBLE))
      comment: "Total incentive amount forfeited due to non-performance. Informs provider performance management and program design."
    - name: "total_withheld_amount"
      expr: SUM(CAST(total_withheld_amount AS DOUBLE))
      comment: "Total amount currently withheld across incentive arrangements. Informs withhold pool balance and cash flow management."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across incentive arrangements. Benchmarks provider quality performance for incentive eligibility."
    - name: "avg_shared_savings_rate"
      expr: AVG(CAST(shared_savings_rate AS DOUBLE))
      comment: "Average shared savings rate across incentive arrangements. Informs VBC economics and provider incentive design."
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incentive arrangements where the quality gate was met. Strategic KPI for quality program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract obligation compliance tracking metrics monitoring fulfillment status, due date adherence, and penalty exposure for contract governance and risk management"
  source: "`vibe_health_insurance_v1`.`contract`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of contractual obligation (reporting, audit, quality, financial, etc.)"
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of obligation"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (pending, complete, overdue, waived, etc.)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (compliant, non-compliant, partial, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation (critical, high, medium, low)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicator whether obligation has been escalated"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicator whether corrective action is required"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicator whether obligation is mandated by regulator"
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Frequency of recurring obligation (annual, quarterly, monthly, etc.)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code"
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of contract obligations"
    - name: "pending_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'Pending' THEN 1 END)
      comment: "Number of pending obligations"
    - name: "complete_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'Complete' THEN 1 END)
      comment: "Number of completed obligations"
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue obligations"
    - name: "compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of compliant obligations"
    - name: "non_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant obligations"
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliance"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status = 'Complete' AND completion_date <= due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN obligation_status = 'Complete' THEN 1 END), 0), 2)
      comment: "Percentage of obligations completed on time"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations escalated"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations requiring corrective action"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount at risk for non-compliance"
    - name: "regulatory_mandate_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated obligations"
    - name: "distinct_contracts"
      expr: COUNT(DISTINCT contract_provider_contract_id)
      comment: "Number of unique contracts with obligations"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_obligation_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party regulatory obligation compliance KPIs — tracks compliance status, attestation rates, corrective action requirements, and penalty exposure across contract parties. Per VREQ-016/054, stub populated with compliance attributes. Drives regulatory compliance management."
  source: "`vibe_health_insurance_v1`.`contract`.`party_regulatory_obligation_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, remediation in progress) for compliance portfolio management."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance obligation (regulatory, contractual, accreditation) for compliance segmentation."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation being tracked for compliance analysis."
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business for LOB-level compliance analysis."
    - name: "corrective_action_required_flag"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether a corrective action is required, for compliance risk tracking."
    - name: "regulatory_mandate_flag"
      expr: CAST(regulatory_mandate_flag AS STRING)
      comment: "Whether the obligation is regulatory-mandated."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of the compliance assessment for trend analysis."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of party regulatory obligation compliance records. Baseline for compliance portfolio management."
    - name: "compliant_records"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of compliant obligation records. Drives compliance program performance reporting."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations in compliance. Strategic KPI for regulatory compliance program effectiveness."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount at risk across non-compliant obligations. Core financial risk metric for compliance management."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across party obligation records. Benchmarks overall compliance program health."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records requiring corrective action. Informs remediation workload and compliance risk."
    - name: "attestation_received_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN attestation_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance records with attestation received. Drives attestation collection and compliance evidence management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for provider contract portfolio — tracks active contract coverage, recency, and data quality across the provider contract SSOT. Per VREQ-011/027, provider_contract is the merged SSOT for provider contracting."
  source: "`vibe_health_insurance_v1`.`contract`.`provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: record_status
      comment: "Current record status of the provider contract (active, terminated, pending)."
    - name: "health_plan"
      expr: CAST(health_plan_id AS STRING)
      comment: "Health plan identifier scoping the provider contract, enabling plan-level contract analysis."
    - name: "provider"
      expr: CAST(provider_id AS STRING)
      comment: "Provider identifier for the contracted provider, enabling provider-level portfolio analysis."
    - name: "is_active_flag"
      expr: CAST(is_active AS STRING)
      comment: "Indicates whether the provider contract is currently active."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the provider contract became effective, for cohort and trend analysis."
    - name: "data_quality_tier"
      expr: data_quality_score
      comment: "Data quality score tier for the contract record, used to assess data governance health."
  measures:
    - name: "total_provider_contracts"
      expr: COUNT(1)
      comment: "Total number of provider contracts in the portfolio. Baseline KPI for contract volume management."
    - name: "active_provider_contracts"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active provider contracts. Drives network adequacy and contracting capacity decisions."
    - name: "distinct_contracted_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers under contract. Key network breadth metric for executives evaluating provider network size."
    - name: "distinct_health_plans_contracted"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct health plans with active provider contracts. Indicates cross-plan contracting coverage."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Provider contracts expiring within 90 days. Critical operational metric for contract renewal pipeline management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care contract KPIs — tracks VBC program performance, shared savings/losses, quality gate achievement, and financial outcomes. Strategic KPIs for VBC program management and executive reporting."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_contract`"
  dimensions:
    - name: "vbc_model_type"
      expr: vbc_model_type
      comment: "VBC model type (ACO, PCMH, bundled payment, etc.) for program-level performance segmentation."
    - name: "risk_arrangement_type"
      expr: risk_arrangement_type
      comment: "Risk arrangement type (one-sided, two-sided, full risk) for risk exposure segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Medicare, Medicaid, Commercial) for LOB-level VBC performance analysis."
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year VBC program trend analysis."
    - name: "quality_gate_met_flag"
      expr: CAST(quality_gate_met AS STRING)
      comment: "Whether the quality gate threshold was met, enabling quality-gated savings analysis."
    - name: "is_active_flag"
      expr: CAST(is_active AS STRING)
      comment: "Whether the VBC contract is currently active."
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for federal VBC program compliance and reporting."
  measures:
    - name: "total_vbc_contracts"
      expr: COUNT(1)
      comment: "Total number of VBC contracts. Baseline for VBC program portfolio management."
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings generated across VBC contracts. Primary financial outcome metric for VBC program ROI."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC contracts. Drives quality gate achievement and incentive release decisions."
    - name: "avg_minimum_savings_rate"
      expr: AVG(CAST(minimum_savings_rate AS DOUBLE))
      comment: "Average minimum savings rate threshold across VBC contracts. Informs program design and savings target-setting."
    - name: "avg_savings_sharing_rate"
      expr: AVG(CAST(savings_sharing_rate AS DOUBLE))
      comment: "Average savings sharing rate. Informs provider incentive economics and VBC contract negotiation strategy."
    - name: "avg_quality_gate_threshold"
      expr: AVG(CAST(quality_gate_threshold AS DOUBLE))
      comment: "Average quality gate threshold across VBC contracts. Benchmarks quality performance requirements."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure AS DOUBLE))
      comment: "Total actual expenditure across VBC contracts. Core financial metric for VBC program cost management."
    - name: "total_benchmark_expenditure_target"
      expr: SUM(CAST(benchmark_expenditure_target AS DOUBLE))
      comment: "Total benchmark expenditure target across VBC contracts. Enables actual vs. target expenditure comparison."
    - name: "quality_gate_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_gate_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VBC contracts where the quality gate was met. Strategic KPI for VBC program quality performance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`contract_vbc_performance_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VBC performance period KPIs — tracks period-level financial performance, quality scores, shared savings/losses, and settlement outcomes. Drives VBC program reconciliation and executive performance reporting."
  source: "`vibe_health_insurance_v1`.`contract`.`vbc_performance_period`"
  dimensions:
    - name: "performance_year"
      expr: performance_year
      comment: "Performance year for year-over-year VBC period trend analysis."
    - name: "period_type"
      expr: period_type
      comment: "Type of performance period (annual, interim, final) for period-level analysis."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the performance period (open, closed, reconciled, settled)."
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model for the performance period (one-sided, two-sided risk)."
    - name: "quality_gate_met_flag"
      expr: CAST(quality_gate_met AS STRING)
      comment: "Whether the quality gate was met in this performance period."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the performance period (pending, complete, disputed)."
    - name: "cms_program_track"
      expr: cms_program_track
      comment: "CMS program track for federal VBC program reporting."
  measures:
    - name: "total_performance_periods"
      expr: COUNT(1)
      comment: "Total number of VBC performance periods. Baseline for performance period management."
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_amount AS DOUBLE))
      comment: "Total shared savings across performance periods. Primary VBC financial outcome metric."
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total shared losses across performance periods. Informs downside risk exposure management."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount across performance periods. Core VBC financial reconciliation metric."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across performance periods. Drives quality gate achievement and incentive release."
    - name: "avg_hedis_composite_score"
      expr: AVG(CAST(hedis_composite_score AS DOUBLE))
      comment: "Average HEDIS composite score across VBC performance periods. Informs quality program performance and NCQA compliance."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score across performance periods. Informs risk-adjusted benchmark accuracy."
    - name: "avg_expenditure_variance"
      expr: AVG(CAST(expenditure_variance AS DOUBLE))
      comment: "Average expenditure variance (actual vs. benchmark) across performance periods. Key VBC financial performance indicator."
    - name: "avg_hcc_capture_rate"
      expr: AVG(CAST(hcc_capture_rate AS DOUBLE))
      comment: "Average HCC capture rate across performance periods. Informs risk adjustment completeness and coding quality."
    - name: "total_ibnr_reserve_amount"
      expr: SUM(CAST(ibnr_reserve_amount AS DOUBLE))
      comment: "Total IBNR reserve amount across performance periods. Informs actuarial reserve adequacy for VBC settlements."
$$;
