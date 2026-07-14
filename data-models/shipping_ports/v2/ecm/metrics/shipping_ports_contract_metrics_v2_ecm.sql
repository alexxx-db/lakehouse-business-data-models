-- Metric views for domain: contract | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level KPIs on the contract agreement portfolio: total contracted value, credit exposure, revenue share economics, and agreement lifecycle status. Used by commercial and legal leadership to steer contract strategy, renewal pipelines, and financial commitments."
  source: "`vibe_shipping_ports_v1`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g. concession, service, volume commitment) for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Lifecycle status of the agreement (active, expired, terminated, draft) for pipeline and renewal tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the agreement is denominated, enabling multi-currency portfolio analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the agreement, relevant for legal risk and compliance reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews, used to forecast future committed revenue."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective, for cohort and vintage analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires, for renewal pipeline management."
    - name: "edi_required_flag"
      expr: edi_required_flag
      comment: "Whether EDI integration is contractually required, used for digital onboarding planning."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all agreements. Core revenue commitment KPI used in board-level financial planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per agreement. Indicates deal size trends and commercial mix shifts."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit exposure extended across all agreements. Critical for treasury and credit risk management."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held against agreements. Indicates collateral coverage for credit risk mitigation."
    - name: "total_investment_commitment"
      expr: SUM(CAST(investment_commitment_amount AS DOUBLE))
      comment: "Total capital investment committed under concession and infrastructure agreements. Used in capex planning."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage mandated across agreements. Used by risk management to verify adequate coverage."
    - name: "total_revenue_share_pct_weighted"
      expr: SUM(CAST(revenue_share_percentage AS DOUBLE) * CAST(contract_value AS DOUBLE))
      comment: "Value-weighted sum of revenue share percentages. Numerator for computing weighted-average revenue share rate across the portfolio."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across agreements. Benchmarks commercial terms against market norms."
    - name: "total_magr_amount"
      expr: SUM(CAST(magr_amount AS DOUBLE))
      comment: "Total Minimum Annual Guaranteed Revenue (MAGR) committed across agreements. Key floor-revenue metric for port financial planning."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'ACTIVE' THEN agreement_id END)
      comment: "Number of currently active agreements. Baseline portfolio health indicator."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN agreement_id END)
      comment: "Number of agreements expiring within 90 days. Drives renewal urgency and commercial team prioritization."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements set to auto-renew. Used to forecast committed revenue continuity."
    - name: "insurance_required_agreement_count"
      expr: COUNT(CASE WHEN insurance_required_flag = TRUE THEN agreement_id END)
      comment: "Number of agreements requiring insurance. Used by compliance to track coverage obligations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and commercial KPIs on SLA performance measurements: achievement rates, penalty exposure, incentive earnings, and variance analysis. Used by operations, commercial, and customer success teams to manage service quality and contractual obligations."
  source: "`vibe_shipping_ports_v1`.`contract`.`sla_measurement`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "SLA performance outcome (met, breached, at-risk) for filtering and segmentation."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Granularity of the measurement period (daily, weekly, monthly, quarterly) for trend analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Workflow status of the measurement record (draft, approved, disputed) for data quality filtering."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit in which the SLA metric is measured (hours, TEU, moves/hr) for cross-KPI comparability."
    - name: "dispute_raised_flag"
      expr: dispute_raised_flag
      comment: "Whether a dispute was raised on this measurement, used to track contested SLA outcomes."
    - name: "breach_notification_triggered"
      expr: breach_notification_triggered
      comment: "Whether a breach notification was automatically triggered, for compliance and escalation tracking."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Month of the measurement period start date for time-series trending."
    - name: "billing_period"
      expr: billing_period
      comment: "Billing period associated with the SLA measurement, linking performance to invoicing cycles."
  measures:
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN performance_status = 'MET' THEN sla_measurement_id END)
      comment: "Number of SLA measurements where the target was met. Core service quality KPI."
    - name: "sla_breached_count"
      expr: COUNT(CASE WHEN performance_status = 'BREACHED' THEN sla_measurement_id END)
      comment: "Number of SLA measurements resulting in a breach. Drives penalty exposure and customer escalation."
    - name: "sla_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_status = 'MET' THEN sla_measurement_id END) / NULLIF(COUNT(sla_measurement_id), 0), 2)
      comment: "Percentage of SLA measurements where the target was achieved. Primary service quality scorecard metric."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty charges assessed from SLA breaches. Direct P&L impact metric for commercial risk management."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive credits earned from SLA over-performance. Measures upside from exceeding contractual targets."
    - name: "net_sla_financial_impact"
      expr: SUM(CAST(incentive_amount AS DOUBLE) - CAST(penalty_amount AS DOUBLE))
      comment: "Net financial impact of SLA performance (incentives minus penalties). Summarizes the P&L effect of service quality."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and target SLA values. Indicates systematic over- or under-performance."
    - name: "total_volume_shortfall"
      expr: SUM(CAST(volume_shortfall AS DOUBLE))
      comment: "Total volume shortfall against committed volumes. Drives penalty assessment and commercial renegotiation."
    - name: "total_volume_surplus"
      expr: SUM(CAST(volume_surplus AS DOUBLE))
      comment: "Total volume surplus above committed levels. Indicates incentive eligibility and capacity utilization."
    - name: "disputed_measurement_count"
      expr: COUNT(CASE WHEN dispute_raised_flag = TRUE THEN sla_measurement_id END)
      comment: "Number of SLA measurements under dispute. Signals relationship friction and revenue recognition risk."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_raised_flag = TRUE THEN sla_measurement_id END) / NULLIF(COUNT(sla_measurement_id), 0), 2)
      comment: "Percentage of SLA measurements that are disputed. High rates indicate systemic measurement or relationship issues."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value across SLA measurements. Baseline for benchmarking operational performance."
    - name: "avg_adjusted_actual_value"
      expr: AVG(CAST(adjusted_actual_value AS DOUBLE))
      comment: "Average adjusted actual value after approved corrections. Used for fair performance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on SLA breach events: severity distribution, financial exposure, resolution efficiency, and recurrence patterns. Used by operations leadership and account management to prioritize remediation and manage contractual risk."
  source: "`vibe_shipping_ports_v1`.`contract`.`sla_breach`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the breach (critical, major, minor) for prioritization and escalation."
    - name: "breach_status"
      expr: breach_status
      comment: "Current resolution status of the breach (open, resolved, disputed, waived)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the breach for systemic issue identification and corrective action."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the breach (port, shipping line, third party) for accountability reporting."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached for the breach, indicating management attention required."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a financial penalty applies to this breach, for revenue-at-risk analysis."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this breach is a recurrence of a prior breach, indicating systemic failure."
    - name: "breach_month"
      expr: DATE_TRUNC('MONTH', breach_date)
      comment: "Month of breach occurrence for trend analysis and seasonal pattern detection."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of the breached SLA metric for cross-KPI comparability."
  measures:
    - name: "total_breach_count"
      expr: COUNT(sla_breach_id)
      comment: "Total number of SLA breach events. Headline service quality failure metric."
    - name: "critical_breach_count"
      expr: COUNT(CASE WHEN breach_severity = 'CRITICAL' THEN sla_breach_id END)
      comment: "Number of critical-severity SLA breaches. Drives immediate executive escalation and remediation."
    - name: "recurrence_breach_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN sla_breach_id END)
      comment: "Number of recurring SLA breaches. Indicates systemic operational failures requiring structural intervention."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN sla_breach_id END) / NULLIF(COUNT(sla_breach_id), 0), 2)
      comment: "Percentage of breaches that are recurrences. High rates signal unresolved root causes."
    - name: "avg_breach_duration_hours"
      expr: AVG(CAST(breach_duration_hours AS DOUBLE))
      comment: "Average duration of SLA breaches in hours. Measures operational responsiveness and remediation speed."
    - name: "max_breach_duration_hours"
      expr: MAX(CAST(breach_duration_hours AS DOUBLE))
      comment: "Maximum breach duration in hours. Identifies worst-case service failures for root cause investigation."
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average percentage deviation from SLA threshold at time of breach. Measures severity of underperformance."
    - name: "total_deviation_value"
      expr: SUM(CAST(deviation_value AS DOUBLE))
      comment: "Total absolute deviation from SLA thresholds across all breaches. Aggregate underperformance volume."
    - name: "penalty_applicable_breach_count"
      expr: COUNT(CASE WHEN penalty_applicable_flag = TRUE THEN sla_breach_id END)
      comment: "Number of breaches with financial penalties applicable. Quantifies penalty exposure events."
    - name: "open_breach_count"
      expr: COUNT(CASE WHEN breach_status = 'OPEN' THEN sla_breach_id END)
      comment: "Number of currently open (unresolved) SLA breaches. Operational backlog and risk exposure indicator."
    - name: "disputed_breach_count"
      expr: COUNT(CASE WHEN dispute_raised_flag = TRUE THEN sla_breach_id END)
      comment: "Number of breaches under formal dispute. Indicates contested liability and revenue recognition risk."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_penalty_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPIs on contractual penalty assessments: gross exposure, net settlements, dispute rates, and exemption utilization. Used by finance, legal, and commercial teams to manage penalty P&L, dispute resolution, and contract compliance."
  source: "`vibe_shipping_ports_v1`.`contract`.`penalty_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of penalty assessment (volume shortfall, SLA breach, regulatory) for category-level analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (draft, issued, settled, disputed, waived) for workflow tracking."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the penalty (missed call, volume shortfall, delay) for root cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the penalty assessment for multi-currency financial reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the assessment is under dispute, for contested revenue and liability tracking."
    - name: "exemption_applied_flag"
      expr: exemption_applied_flag
      comment: "Whether an exemption was applied to reduce the penalty, for exemption utilization analysis."
    - name: "assessment_period_start_month"
      expr: DATE_TRUNC('MONTH', assessment_period_start)
      comment: "Month of the assessment period start for time-series trending of penalty exposure."
    - name: "assessed_metric_name"
      expr: assessed_metric_name
      comment: "Name of the metric that was assessed (e.g. crane moves/hr, vessel turnaround) for operational linkage."
  measures:
    - name: "total_gross_penalty_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross penalty amount before exemptions and adjustments. Headline contractual liability exposure."
    - name: "total_net_penalty_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net penalty amount after exemptions and adjustments. Actual P&L impact of contractual penalties."
    - name: "total_final_penalty_amount"
      expr: SUM(CAST(final_amount AS DOUBLE))
      comment: "Total final settled penalty amount. Definitive financial liability recognized in accounts."
    - name: "total_exemption_amount"
      expr: SUM(CAST(exemption_amount AS DOUBLE))
      comment: "Total value of exemptions applied to reduce penalties. Measures commercial concession and waiver utilization."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total adjustment applied to penalty assessments. Tracks negotiated reductions from gross to net."
    - name: "avg_penalty_rate_applied"
      expr: AVG(CAST(rate_applied AS DOUBLE))
      comment: "Average penalty rate applied across assessments. Benchmarks rate application against contractual terms."
    - name: "disputed_penalty_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN penalty_assessment_id END)
      comment: "Number of penalty assessments under dispute. Indicates contested liability and collection risk."
    - name: "penalty_dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN penalty_assessment_id END) / NULLIF(COUNT(penalty_assessment_id), 0), 2)
      comment: "Percentage of penalty assessments that are disputed. High rates signal systemic measurement or relationship issues."
    - name: "exemption_utilization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exemption_applied_flag = TRUE THEN penalty_assessment_id END) / NULLIF(COUNT(penalty_assessment_id), 0), 2)
      comment: "Percentage of assessments where an exemption was applied. Measures commercial flexibility and waiver frequency."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total variance between assessed and threshold values across all assessments. Aggregate underperformance magnitude."
    - name: "avg_assessed_value"
      expr: AVG(CAST(assessed_value AS DOUBLE))
      comment: "Average assessed metric value across penalty assessments. Baseline for benchmarking operational performance against thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on contractual volume commitments: fulfillment rates, shortfall/surplus volumes, penalty and incentive economics. Used by commercial, operations, and finance teams to manage throughput guarantees and revenue floor commitments."
  source: "`vibe_shipping_ports_v1`.`contract`.`volume_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of volume commitment (TEU, vessel calls, DWT) for commodity-level analysis."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (active, fulfilled, breached, expired) for portfolio health tracking."
    - name: "commitment_unit"
      expr: commitment_unit
      comment: "Unit of measurement for the commitment (TEU, DWT, vessel calls) for cross-commitment comparability."
    - name: "commitment_period_type"
      expr: commitment_period_type
      comment: "Period type of the commitment (annual, quarterly, monthly) for performance cycle analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive applicable for over-performance (rebate, rate reduction, bonus) for commercial analysis."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for shortfall (fixed, per-unit, percentage) for financial risk categorization."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the commitment auto-renews, for forecasting future committed volume floors."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the commitment became effective for vintage and cohort analysis."
  measures:
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total volume committed across all active commitments. Headline throughput guarantee metric for capacity planning."
    - name: "total_actual_volume_to_date"
      expr: SUM(CAST(actual_volume_to_date AS DOUBLE))
      comment: "Total actual volume delivered against commitments to date. Measures fulfillment progress."
    - name: "volume_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_to_date AS DOUBLE)) / NULLIF(SUM(CAST(committed_volume AS DOUBLE)), 0), 2)
      comment: "Percentage of committed volume fulfilled to date. Primary throughput commitment health KPI."
    - name: "total_shortfall_volume"
      expr: SUM(CAST(shortfall_volume AS DOUBLE))
      comment: "Total volume shortfall against commitments. Drives penalty assessment and commercial renegotiation."
    - name: "total_excess_volume"
      expr: SUM(CAST(excess_volume AS DOUBLE))
      comment: "Total volume delivered above committed levels. Indicates incentive eligibility and strong commercial relationships."
    - name: "total_penalty_amount_assessed"
      expr: SUM(CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Total penalty amounts assessed for volume shortfalls. Direct P&L impact of commitment underperformance."
    - name: "total_incentive_amount_earned"
      expr: SUM(CAST(incentive_amount_earned AS DOUBLE))
      comment: "Total incentive amounts earned for volume over-performance. Measures upside from exceeding commitments."
    - name: "net_commitment_financial_impact"
      expr: SUM(CAST(incentive_amount_earned AS DOUBLE) - CAST(penalty_amount_assessed AS DOUBLE))
      comment: "Net financial impact of volume commitments (incentives earned minus penalties assessed). Summarizes commercial performance."
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate applied for shortfalls. Benchmarks contractual penalty terms across the portfolio."
    - name: "avg_incentive_rate"
      expr: AVG(CAST(incentive_rate AS DOUBLE))
      comment: "Average incentive rate for over-performance. Benchmarks commercial upside terms across the portfolio."
    - name: "shortfall_commitment_count"
      expr: COUNT(CASE WHEN shortfall_volume > 0 THEN volume_commitment_id END)
      comment: "Number of commitments with a volume shortfall. Quantifies breadth of underperformance across the portfolio."
    - name: "shortfall_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shortfall_volume > 0 THEN volume_commitment_id END) / NULLIF(COUNT(volume_commitment_id), 0), 2)
      comment: "Percentage of commitments with a shortfall. Headline portfolio health metric for commercial leadership."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_dispute_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on contractual dispute records: resolution rates, settlement economics, escalation patterns, and financial exposure. Used by legal, commercial, and executive teams to manage dispute liability, resolution efficiency, and relationship risk."
  source: "`vibe_shipping_ports_v1`.`contract`.`dispute_record`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (billing, SLA, volume, regulatory) for category-level analysis and legal routing."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current resolution status of the dispute (open, mediation, arbitration, settled, closed)."
    - name: "resolution_method"
      expr: resolution_method
      comment: "Method used to resolve the dispute (negotiation, mediation, arbitration, litigation) for process benchmarking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the dispute for systemic issue identification and prevention."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached (operational, management, executive, legal) for resource allocation."
    - name: "priority"
      expr: priority
      comment: "Priority classification of the dispute for triage and resolution sequencing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency financial reporting."
    - name: "raised_year"
      expr: YEAR(raised_date)
      comment: "Year the dispute was raised for trend and vintage analysis."
  measures:
    - name: "total_dispute_count"
      expr: COUNT(dispute_record_id)
      comment: "Total number of contractual disputes. Headline relationship health and legal risk indicator."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN dispute_record_id END)
      comment: "Number of currently open disputes. Measures unresolved legal and financial exposure."
    - name: "total_final_settled_amount"
      expr: SUM(CAST(final_settled_amount AS DOUBLE))
      comment: "Total amount settled across all resolved disputes. Measures realized financial impact of contractual disputes."
    - name: "avg_settled_amount"
      expr: AVG(CAST(final_settled_amount AS DOUBLE))
      comment: "Average settlement amount per dispute. Benchmarks dispute materiality and negotiation outcomes."
    - name: "dispute_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status IN ('SETTLED', 'CLOSED') THEN dispute_record_id END) / NULLIF(COUNT(dispute_record_id), 0), 2)
      comment: "Percentage of disputes that have been resolved. Measures legal team effectiveness and relationship management."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IN ('EXECUTIVE', 'LEGAL', 'ARBITRATION') THEN dispute_record_id END)
      comment: "Number of disputes escalated to executive or legal level. Indicates high-severity relationship and financial risk."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_level IN ('EXECUTIVE', 'LEGAL', 'ARBITRATION') THEN dispute_record_id END) / NULLIF(COUNT(dispute_record_id), 0), 2)
      comment: "Percentage of disputes escalated beyond operational level. High rates signal systemic commercial relationship issues."
    - name: "confidential_dispute_count"
      expr: COUNT(CASE WHEN confidentiality_flag = TRUE THEN dispute_record_id END)
      comment: "Number of disputes under confidentiality agreement. Relevant for legal disclosure and reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_guarantee_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on guarantee bonds and performance bonds: total bond value, utilization, claim activity, and remaining coverage. Used by treasury, legal, and risk management to monitor collateral adequacy and bond claim exposure."
  source: "`vibe_shipping_ports_v1`.`contract`.`guarantee_bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (performance bond, bank guarantee, surety bond) for portfolio segmentation."
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (active, expired, claimed, cancelled) for portfolio health tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency treasury reporting."
    - name: "bond_provider_credit_rating"
      expr: bond_provider_credit_rating
      comment: "Credit rating of the bond provider for counterparty risk assessment."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the bond auto-renews, for continuity of collateral coverage planning."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required for the bond, for compliance workflow tracking."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the bond became effective for vintage and maturity analysis."
  measures:
    - name: "total_bond_value"
      expr: SUM(CAST(bond_value AS DOUBLE))
      comment: "Total face value of all guarantee bonds. Headline collateral coverage metric for treasury and risk management."
    - name: "total_remaining_bond_value"
      expr: SUM(CAST(remaining_bond_value AS DOUBLE))
      comment: "Total remaining unclaimed bond value. Measures available collateral coverage after claims."
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total amount claimed against bonds. Measures realized collateral utilization and counterparty default exposure."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid out under bond claims. Actual cash outflow from bond claim settlements."
    - name: "bond_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_claimed_amount AS DOUBLE)) / NULLIF(SUM(CAST(bond_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total bond value that has been claimed. Measures collateral consumption and counterparty risk realization."
    - name: "total_bond_fee_amount"
      expr: SUM(CAST(bond_fee_amount AS DOUBLE))
      comment: "Total bond fees paid to providers. Measures cost of collateral and financial guarantee arrangements."
    - name: "avg_bond_value"
      expr: AVG(CAST(bond_value AS DOUBLE))
      comment: "Average bond value per guarantee. Benchmarks collateral sizing against deal values."
    - name: "expiring_bonds_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN guarantee_bond_id END)
      comment: "Number of bonds expiring within 90 days. Drives renewal urgency to maintain collateral coverage continuity."
    - name: "active_bond_count"
      expr: COUNT(CASE WHEN bond_status = 'ACTIVE' THEN guarantee_bond_id END)
      comment: "Number of currently active bonds. Baseline collateral portfolio size indicator."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on contracted rate schedules: rate levels, discount economics, escalation exposure, and tariff coverage. Used by commercial, pricing, and finance teams to manage contracted rate portfolios and revenue yield."
  source: "`vibe_shipping_ports_v1`.`contract`.`rate_schedule`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (THC, storage, handling, pilotage) for rate category analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate schedule (active, expired, pending approval) for portfolio management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate schedule for multi-currency pricing analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the rate (per move, per day, per vessel call) for revenue recognition planning."
    - name: "calculation_basis"
      expr: calculation_basis
      comment: "Basis for rate calculation (per TEU, per GRT, per DWT) for rate structure analysis."
    - name: "seasonal_flag"
      expr: seasonal_flag
      comment: "Whether the rate has seasonal variation, for peak/off-peak pricing analysis."
    - name: "hazmat_surcharge_flag"
      expr: hazmat_surcharge_flag
      comment: "Whether a hazmat surcharge applies, for DG cargo revenue analysis."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to this rate, for gross-to-net revenue analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rate schedule became effective for pricing vintage analysis."
  measures:
    - name: "avg_rate_value"
      expr: AVG(CAST(rate_value AS DOUBLE))
      comment: "Average contracted rate value. Benchmarks pricing levels across the portfolio and against tariff rates."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to contracted rates. Measures commercial concession depth."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge floor across rate schedules. Ensures revenue floor visibility in pricing analysis."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge cap across rate schedules. Measures revenue ceiling constraints in contracted pricing."
    - name: "avg_peak_season_surcharge"
      expr: AVG(CAST(peak_season_surcharge AS DOUBLE))
      comment: "Average peak season surcharge across applicable rate schedules. Measures seasonal revenue uplift potential."
    - name: "avg_escalation_percentage"
      expr: AVG(CAST(escalation_percentage AS DOUBLE))
      comment: "Average contractual escalation percentage. Measures built-in rate inflation protection across the portfolio."
    - name: "avg_tax_rate_percentage"
      expr: AVG(CAST(tax_rate_percentage AS DOUBLE))
      comment: "Average tax rate applicable to contracted rates. Used for gross-to-net revenue reconciliation."
    - name: "escalation_clause_rate_count"
      expr: COUNT(CASE WHEN escalation_clause_flag = TRUE THEN rate_schedule_id END)
      comment: "Number of rate schedules with escalation clauses. Measures inflation protection coverage in the rate portfolio."
    - name: "hazmat_surcharge_rate_count"
      expr: COUNT(CASE WHEN hazmat_surcharge_flag = TRUE THEN rate_schedule_id END)
      comment: "Number of rate schedules with hazmat surcharges. Quantifies DG cargo premium revenue coverage."
    - name: "avg_volume_threshold"
      expr: AVG(CAST(volume_threshold AS DOUBLE))
      comment: "Average volume threshold for rate applicability. Benchmarks volume-tiered pricing structures."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`contract_agreement_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on contract amendment activity: version velocity, financial impact frequency, regulatory compliance, and SLA change patterns. Used by legal and commercial teams to manage contract lifecycle governance and amendment risk."
  source: "`vibe_shipping_ports_v1`.`contract`.`agreement_version`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of contract change (amendment, renewal, termination, extension) for change category analysis."
    - name: "version_status"
      expr: version_status
      comment: "Current status of the version (draft, approved, superseded, rejected) for lifecycle tracking."
    - name: "financial_impact_flag"
      expr: financial_impact_flag
      comment: "Whether the version change has a financial impact, for revenue and cost change tracking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the version change was driven by regulatory compliance requirements."
    - name: "sla_changes_flag"
      expr: sla_changes_flag
      comment: "Whether the version includes SLA changes, for service level renegotiation tracking."
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Whether legal review was required for this version, for legal resource planning."
    - name: "counterparty_acceptance_required"
      expr: counterparty_acceptance_required
      comment: "Whether counterparty acceptance was required, for negotiation cycle time analysis."
    - name: "version_effective_year"
      expr: YEAR(version_effective_date)
      comment: "Year the version became effective for amendment trend analysis."
  measures:
    - name: "total_version_count"
      expr: COUNT(agreement_version_id)
      comment: "Total number of contract versions/amendments. Measures contract instability and renegotiation frequency."
    - name: "financial_impact_version_count"
      expr: COUNT(CASE WHEN financial_impact_flag = TRUE THEN agreement_version_id END)
      comment: "Number of versions with financial impact. Quantifies amendments that affect revenue or cost commitments."
    - name: "financial_impact_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN financial_impact_flag = TRUE THEN agreement_version_id END) / NULLIF(COUNT(agreement_version_id), 0), 2)
      comment: "Percentage of contract amendments with financial impact. High rates indicate commercially volatile relationships."
    - name: "regulatory_driven_version_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN agreement_version_id END)
      comment: "Number of versions driven by regulatory compliance requirements. Measures regulatory change burden on contracts."
    - name: "sla_change_version_count"
      expr: COUNT(CASE WHEN sla_changes_flag = TRUE THEN agreement_version_id END)
      comment: "Number of versions that include SLA changes. Tracks service level renegotiation frequency."
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required = TRUE THEN agreement_version_id END)
      comment: "Number of versions requiring legal review. Drives legal resource planning and review cycle time management."
    - name: "approved_version_count"
      expr: COUNT(CASE WHEN version_status = 'APPROVED' THEN agreement_version_id END)
      comment: "Number of approved contract versions. Measures amendment throughput and governance effectiveness."
    - name: "distinct_agreements_amended"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that have been amended. Measures breadth of contract renegotiation activity."
$$;