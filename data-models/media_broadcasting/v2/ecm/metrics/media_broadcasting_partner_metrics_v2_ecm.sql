-- Metric views for domain: partner | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs on content acquisition deals: deal value, minimum guarantees, revenue share and renewal exposure used by content-acquisition and finance leadership."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Lifecycle status of the acquisition deal (active, expired, pending) for pipeline and exposure analysis."
    - name: "deal_type"
      expr: deal_type
      comment: "Type of acquisition deal (e.g. license, output, volume) for portfolio mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of deal financials for multi-currency reporting."
    - name: "territory_coverage"
      expr: territory_coverage
      comment: "Territory scope of the deal for geographic exposure analysis."
    - name: "deal_effective_month"
      expr: DATE_TRUNC('MONTH', deal_effective_date)
      comment: "Month the deal becomes effective, for time-trend of acquisition commitments."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the acquired rights are exclusive, a key value/risk dimension."
  measures:
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Number of acquisition deals; baseline volume of content acquisition activity."
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total committed acquisition spend; primary financial exposure metric for content budget steering."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee committed across deals; downside cash-commitment exposure."
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average value per acquisition deal; indicates deal scale and negotiation leverage."
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue-share percentage across deals; informs margin economics of acquired content."
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total acquired content runtime in hours; volume of programming acquired for cost-per-hour analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_minimum_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum guarantee recoupment KPIs: committed MG, recouped to date, and outstanding balance for finance and content-deal recoupment steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee`"
  dimensions:
    - name: "mg_status"
      expr: mg_status
      comment: "Status of the minimum guarantee (open, recouped, written off) for recoupment-pipeline analysis."
    - name: "mg_type"
      expr: mg_type
      comment: "Type of minimum guarantee for categorical exposure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of MG financials for multi-currency rollups."
    - name: "recoupment_basis"
      expr: recoupment_basis
      comment: "Basis on which recoupment is calculated, for waterfall mix analysis."
    - name: "is_recoupable"
      expr: is_recoupable
      comment: "Whether the MG is recoupable, a key economics dimension."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the MG becomes effective, for time-trend of guarantee commitments."
  measures:
    - name: "mg_count"
      expr: COUNT(1)
      comment: "Number of minimum guarantee records; baseline volume of guarantee commitments."
    - name: "total_mg_amount"
      expr: SUM(CAST(mg_amount AS DOUBLE))
      comment: "Total committed minimum guarantee amount; primary downside cash-commitment metric."
    - name: "total_recouped_amount"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE))
      comment: "Total amount recouped to date against guarantees; recovery performance metric."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total unrecouped balance; at-risk capital that leadership monitors for recoupment shortfalls."
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage earned above guarantees; upside performance beyond minimum commitments."
    - name: "avg_recoupment_pct"
      expr: AVG(CAST(recoupment_percentage AS DOUBLE))
      comment: "Average recoupment percentage applied; informs recoupment-waterfall aggressiveness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner dispute KPIs: disputed amounts, settlement exposure and resolution cycle for legal/finance risk steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, in arbitration, resolved) for risk-pipeline tracking."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute (royalty, delivery, payment) for root-cause analysis."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of partner dispute for categorical risk segmentation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute for escalation focus."
    - name: "filed_month"
      expr: DATE_TRUNC('MONTH', filed_date)
      comment: "Month the dispute was filed, for dispute-volume trend analysis."
    - name: "arbitration_required"
      expr: arbitration_required
      comment: "Whether arbitration is required, a key legal-cost driver dimension."
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of partner disputes; baseline measure of partner-relationship friction."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Total amount in dispute; financial exposure leadership monitors for risk."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Total settled dispute amount; realized cost of dispute resolution."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Average disputed amount per case; indicates severity of partner disputes."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status NOT IN ('Resolved','Closed') THEN 1 END)
      comment: "Count of unresolved disputes; active risk backlog requiring attention."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution agreement KPIs: carriage fee exposure, minimum guarantees and SLA commitments for distribution-partnership steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the distribution agreement for active-deal-base tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distribution agreement for portfolio mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of agreement financials for multi-currency reporting."
    - name: "territory"
      expr: territory
      comment: "Territory covered by the agreement for geographic distribution analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement becomes effective, for distribution-deal trend analysis."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of distribution agreements; baseline of distribution footprint."
    - name: "total_carriage_fee"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee committed across agreements; primary distribution-cost exposure."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee across distribution agreements; downside commitment exposure."
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average contracted SLA uptime percentage; service-level commitment baseline for distribution quality."
    - name: "must_carry_count"
      expr: COUNT(CASE WHEN must_carry_obligation = true THEN 1 END)
      comment: "Count of agreements carrying must-carry obligations; regulatory carriage commitment exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_carriage_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee schedule KPIs: per-subscriber fees, escalation and guaranteed minimums for affiliate revenue/cost steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the fee schedule (active, expired) for active-schedule tracking."
    - name: "fee_type"
      expr: fee_type
      comment: "Type of carriage fee for pricing-model analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of fee financials for multi-currency rollups."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of fee escalation for revenue-growth structure analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the schedule becomes effective, for fee-schedule trend analysis."
  measures:
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of carriage fee schedules; baseline of fee-arrangement volume."
    - name: "avg_base_fee_per_subscriber"
      expr: AVG(CAST(base_fee_per_subscriber AS DOUBLE))
      comment: "Average base fee per subscriber; key unit-economics metric for carriage revenue."
    - name: "total_minimum_guaranteed_fee"
      expr: SUM(CAST(minimum_guaranteed_fee AS DOUBLE))
      comment: "Total guaranteed minimum carriage fee; revenue-floor commitment metric."
    - name: "avg_escalation_rate_pct"
      expr: AVG(CAST(escalation_rate_percentage AS DOUBLE))
      comment: "Average annual escalation rate; informs forward revenue growth of carriage deals."
    - name: "total_maximum_fee_cap"
      expr: SUM(CAST(maximum_fee_cap AS DOUBLE))
      comment: "Total fee cap across schedules; upper-bound exposure for fee arrangements."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_deal_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deal compliance obligation KPIs: obligation status, penalty exposure and overdue tracking for compliance/risk steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the obligation (met, breached, pending) for risk monitoring."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation for categorical risk analysis."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the obligation, for accountability rollups."
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency of any penalty for multi-currency penalty reporting."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due, for obligation-pipeline scheduling."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether certification is required, a compliance-effort driver dimension."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of deal compliance obligations; baseline compliance workload."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount at stake across obligations; financial compliance-risk exposure."
    - name: "breached_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Breached' THEN 1 END)
      comment: "Count of breached obligations; active compliance failures requiring remediation."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = true THEN 1 END)
      comment: "Count of obligations under waiver; governance visibility into relaxed commitments."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_delivery_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery obligation KPIs: SLA compliance, penalty exposure and QC outcomes for delivery-operations steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`delivery_obligation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery obligation for fulfillment tracking."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of delivery obligation for categorical analysis."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of delivered content for quality monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the delivery for operational focus."
    - name: "delivery_deadline_month"
      expr: DATE_TRUNC('MONTH', delivery_deadline)
      comment: "Month of delivery deadline, for delivery-pipeline scheduling."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of delivery obligations; baseline delivery workload."
    - name: "sla_compliant_count"
      expr: COUNT(CASE WHEN sla_compliance = true THEN 1 END)
      comment: "Count of SLA-compliant deliveries; service-quality performance metric."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total delivery-penalty exposure; financial risk from missed delivery obligations."
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total content volume delivered in GB; storage/throughput planning metric."
    - name: "redelivery_required_count"
      expr: COUNT(CASE WHEN redelivery_required = true THEN 1 END)
      comment: "Count of deliveries requiring redelivery; quality-failure rework indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner master KPIs: relationship value, content volume and risk segmentation for partner-portfolio steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (studio, distributor, vendor) for portfolio segmentation."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current relationship status for active-partner-base tracking."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the partner for prioritization analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the partner for risk-concentration monitoring."
    - name: "domicile_country_code"
      expr: domicile_country_code
      comment: "Partner domicile country for geographic concentration analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the partner relationship is exclusive, a strategic value dimension."
  measures:
    - name: "partner_count"
      expr: COUNT(1)
      comment: "Number of partners; baseline size of the partner portfolio."
    - name: "total_annual_revenue_contribution"
      expr: SUM(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Total annual revenue contributed by partners; primary value-of-portfolio metric."
    - name: "total_annual_content_volume_hours"
      expr: SUM(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Total annual content volume in hours from partners; supply-base capacity metric."
    - name: "avg_revenue_contribution"
      expr: AVG(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Average revenue contribution per partner; indicates partner-value concentration."
    - name: "exclusive_partner_count"
      expr: COUNT(CASE WHEN is_exclusive = true THEN 1 END)
      comment: "Count of exclusive partners; strategic-lock-in indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement renewal KPIs: renewal value change, outcomes and pipeline for partner-retention steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of the renewal process for renewal-pipeline tracking."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the renewal (renewed, lapsed, renegotiated) for retention analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement being renewed for portfolio mix."
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance of the renewal for prioritization."
    - name: "decision_due_month"
      expr: DATE_TRUNC('MONTH', decision_due_date)
      comment: "Month the renewal decision is due, for renewal-pipeline scheduling."
  measures:
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Number of renewal records; baseline of renewal pipeline volume."
    - name: "total_original_deal_value"
      expr: SUM(CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total value of agreements up for renewal; revenue at stake in renewals."
    - name: "total_proposed_deal_value"
      expr: SUM(CAST(proposed_deal_value_amount AS DOUBLE))
      comment: "Total proposed renewal value; forward revenue from renewal negotiations."
    - name: "avg_value_change_pct"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage value change on renewals; pricing-power and uplift indicator."
    - name: "renegotiation_required_count"
      expr: COUNT(CASE WHEN renegotiation_required_flag = true THEN 1 END)
      comment: "Count of renewals requiring renegotiation; negotiation workload and risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner audit KPIs: adjustment recovery, audit cost and disputed amounts for revenue-assurance steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_audit_event`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit event for audit-pipeline tracking."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit for categorical analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of audit findings for closure tracking."
    - name: "cost_recovery_status"
      expr: cost_recovery_status
      comment: "Status of cost recovery from audit for revenue-assurance focus."
    - name: "audit_initiated_month"
      expr: DATE_TRUNC('MONTH', audit_initiated_date)
      comment: "Month the audit was initiated, for audit-activity trend analysis."
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of partner audit events; baseline of revenue-assurance activity."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial adjustment recovered from audits; revenue-recovery value metric."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount disputed in audits; exposure from audit findings."
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of conducting audits; ROI input for audit-program efficiency."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = true THEN 1 END)
      comment: "Count of audits requiring corrective action; remediation workload indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance obligation KPIs: breach tracking, penalty exposure and SLA compliance for partner-performance steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`performance_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the performance obligation for monitoring."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation for categorical analysis."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty associated with the obligation for risk-structure analysis."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Measurement period of the obligation for cadence analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the obligation becomes effective, for obligation-trend analysis."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of performance obligations; baseline of partner-commitment volume."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty exposure across obligations; financial risk from performance failures."
    - name: "total_breach_count"
      expr: SUM(CAST(breach_count AS DOUBLE))
      comment: "Total recorded breaches across obligations; aggregate performance-failure volume."
    - name: "avg_last_measured_value"
      expr: AVG(CAST(last_measured_value AS DOUBLE))
      comment: "Average last-measured performance value; current-state performance indicator."
    - name: "makegood_provision_count"
      expr: COUNT(CASE WHEN makegood_provision_flag = true THEN 1 END)
      comment: "Count of obligations with makegood provisions; remediation-commitment exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_syndication_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication agreement KPIs: fee structure, minimum guarantees and revenue share for syndication-business steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the syndication agreement for active-deal tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of syndication agreement for portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of agreement financials for multi-currency reporting."
    - name: "syndication_fee_structure"
      expr: syndication_fee_structure
      comment: "Fee structure of syndication (flat, per-episode, barter) for monetization mix."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement becomes effective, for syndication-deal trend analysis."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of syndication agreements; baseline of syndication footprint."
    - name: "total_flat_fee"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat-fee revenue committed in syndication deals; revenue exposure metric."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee across syndication deals; revenue-floor commitment."
    - name: "avg_per_episode_fee"
      expr: AVG(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Average per-episode syndication fee; unit-economics metric for syndicated content."
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue-share percentage in syndication deals; margin-economics indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master partner agreement KPIs: contract value, liability exposure and revenue share for governance and contract-portfolio steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the partner agreement for active-contract tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of partner agreement for portfolio mix analysis."
    - name: "contract_value_currency"
      expr: contract_value_currency
      comment: "Currency of contract value for multi-currency rollups."
    - name: "content_category"
      expr: content_category
      comment: "Content category covered by the agreement for thematic analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement becomes effective, for contract-portfolio trend analysis."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of master partner agreements; baseline of governed contract volume."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contracted value across partner agreements; primary contract-portfolio value metric."
    - name: "total_liability_cap"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap exposure across agreements; risk-ceiling metric for governance."
    - name: "total_performance_guarantee"
      expr: SUM(CAST(performance_guarantee_amount AS DOUBLE))
      comment: "Total performance guarantee committed; performance-backed value exposure."
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue-share percentage across agreements; margin-economics indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_coproduction_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coproduction agreement KPIs: investment exposure, IP ownership and budget for coproduction-portfolio steering."
  source: "`vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the coproduction agreement for active-deal tracking."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of coproduction agreement for portfolio mix."
    - name: "production_type"
      expr: production_type
      comment: "Type of production being coproduced for content-mix analysis."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of budget figures for multi-currency rollups."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the agreement becomes effective, for coproduction-deal trend analysis."
  measures:
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Number of coproduction agreements; baseline of coproduction activity."
    - name: "total_our_investment"
      expr: SUM(CAST(our_investment_amount AS DOUBLE))
      comment: "Total own-investment committed to coproductions; primary capital-exposure metric."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total coproduction budget across deals; production-scale and partner-leverage metric."
    - name: "avg_our_ip_ownership_pct"
      expr: AVG(CAST(our_ip_ownership_percentage AS DOUBLE))
      comment: "Average own IP-ownership percentage; long-term value-retention indicator."
    - name: "avg_our_investment_pct"
      expr: AVG(CAST(our_investment_percentage AS DOUBLE))
      comment: "Average own investment share of coproduction budget; financial-leverage indicator."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow commitment from payment schedules"
  source: "`vibe_media_broadcasting_v1`.`partner`.`payment_schedule`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, wire)"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments scheduled"
$$;