-- Metric views for domain: partner | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the partner master entity — tracks portfolio health, financial contribution, and relationship lifecycle across all partner types (affiliates, distributors, co-producers, syndicators, vendors)."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Classifies the partner (affiliate, distributor, co-producer, syndicator, vendor) for segment-level analysis."
    - name: "partner_subtype"
      expr: subtype
      comment: "Secondary classification within a partner type for finer segmentation."
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current lifecycle status of the partner relationship (active, inactive, terminated, onboarding)."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic importance tier assigned to the partner (tier 1, tier 2, tier 3) for prioritization."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk classification of the partner for credit and operational risk management."
    - name: "domicile_country_code"
      expr: domicile_country_code
      comment: "Country of domicile for geographic distribution analysis."
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage for partners not yet fully active."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flags whether the partner relationship is exclusive, relevant for competitive strategy."
    - name: "corporate_hierarchy_level"
      expr: corporate_hierarchy_level
      comment: "Level in the corporate hierarchy, distinguishing parent entities from subsidiaries."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating of the partner for financial risk segmentation."
  measures:
    - name: "total_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Total number of distinct partner entities in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "total_annual_revenue_contribution_usd"
      expr: SUM(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Total annual revenue contributed by all partners in USD. Core financial KPI for partner portfolio value assessment."
    - name: "avg_annual_revenue_contribution_usd"
      expr: AVG(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Average annual revenue contribution per partner in USD. Used to benchmark partner value and identify underperformers."
    - name: "total_annual_content_volume_hours"
      expr: SUM(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Total annual content volume in hours supplied by all partners. Measures content supply capacity across the partner network."
    - name: "avg_annual_content_volume_hours"
      expr: AVG(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Average annual content volume per partner in hours. Benchmarks content productivity per partner relationship."
    - name: "exclusive_partner_count"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN partner_id END)
      comment: "Number of partners with exclusive agreements. Tracks exclusivity concentration risk and competitive positioning."
    - name: "active_partner_count"
      expr: COUNT(DISTINCT CASE WHEN relationship_status = 'active' THEN partner_id END)
      comment: "Number of currently active partner relationships. Operational health indicator for the partner network."
    - name: "partner_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN relationship_status = 'active' THEN partner_id END) / NULLIF(COUNT(DISTINCT partner_id), 0), 2)
      comment: "Percentage of partners with active status. Measures the health and activation efficiency of the partner portfolio."
    - name: "tier1_strategic_partner_count"
      expr: COUNT(DISTINCT CASE WHEN strategic_tier = 'tier_1' THEN partner_id END)
      comment: "Number of tier-1 strategic partners. Tracks the most critical partner relationships for executive oversight."
    - name: "high_risk_partner_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'high' THEN partner_id END)
      comment: "Number of partners classified as high risk. Drives risk mitigation and credit management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for content acquisition deals — tracks deal value, minimum guarantees, revenue share commitments, and deal pipeline health."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of acquisition deal (license, co-production, distribution) for deal mix analysis."
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal (active, expired, pending, terminated) for pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the deal is denominated for multi-currency financial reporting."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal includes exclusivity provisions, relevant for competitive content strategy."
    - name: "distribution_rights"
      expr: distribution_rights
      comment: "Scope of distribution rights granted (linear, digital, global, regional) for rights portfolio analysis."
    - name: "content_delivery_format"
      expr: content_delivery_format
      comment: "Format in which content is delivered under the deal (HD, 4K, streaming) for technical planning."
    - name: "windowing_strategy"
      expr: windowing_strategy
      comment: "Content windowing strategy (SVOD-first, linear-first, day-and-date) for distribution planning."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the deal includes a renewal option, relevant for long-term content supply planning."
  measures:
    - name: "total_deal_value_amount"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total committed deal value across all acquisition deals. Primary financial KPI for content investment tracking."
    - name: "avg_deal_value_amount"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average deal value per acquisition deal. Benchmarks deal size and informs negotiation strategy."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all acquisition deals. Critical liability metric for financial planning."
    - name: "avg_minimum_guarantee_amount"
      expr: AVG(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Average minimum guarantee per deal. Used to assess guarantee intensity relative to deal value."
    - name: "total_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage committed across acquisition deals. Tracks revenue share burden on content monetization."
    - name: "total_runtime_hours_acquired"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total content runtime hours acquired across all deals. Measures content supply volume for programming and scheduling."
    - name: "active_deal_count"
      expr: COUNT(DISTINCT CASE WHEN deal_status = 'active' THEN acquisition_deal_id END)
      comment: "Number of currently active acquisition deals. Operational KPI for active content supply relationships."
    - name: "exclusive_deal_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN acquisition_deal_id END)
      comment: "Number of deals with exclusivity provisions. Tracks exclusive content investment for competitive differentiation."
    - name: "exclusive_deal_value"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN deal_value_amount ELSE 0 END)
      comment: "Total value of exclusive acquisition deals. Quantifies the financial commitment to exclusive content strategy."
    - name: "mg_to_deal_value_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(minimum_guarantee_amount AS DOUBLE)) / NULLIF(SUM(CAST(deal_value_amount AS DOUBLE)), 0), 2)
      comment: "Minimum guarantee as a percentage of total deal value. Measures financial risk concentration in guaranteed payments."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for distribution agreements — tracks carriage fee commitments, SLA performance, rights scope, and agreement lifecycle health across distribution partners."
  source: "`vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distribution agreement (carriage, retransmission, streaming) for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (active, expired, terminated, pending) for lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency financial reporting."
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the distribution agreement for rights and revenue analysis."
    - name: "streaming_rights_included"
      expr: streaming_rights_included
      comment: "Whether streaming rights are included, relevant for digital distribution strategy."
    - name: "svod_rights_included"
      expr: svod_rights_included
      comment: "Whether SVOD rights are included in the agreement for subscription revenue planning."
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent has been granted, a key regulatory and commercial indicator."
    - name: "must_carry_obligation"
      expr: must_carry_obligation
      comment: "Whether the agreement includes a must-carry obligation for regulatory compliance tracking."
  measures:
    - name: "total_carriage_fee_amount"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue committed across all distribution agreements. Primary revenue KPI for distribution."
    - name: "avg_carriage_fee_amount"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per distribution agreement. Benchmarks fee levels for negotiation strategy."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments in distribution agreements. Tracks guaranteed revenue floor."
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage committed across distribution agreements. Measures service quality commitments."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN distribution_agreement_id END)
      comment: "Number of currently active distribution agreements. Baseline for active distribution network size."
    - name: "streaming_rights_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN streaming_rights_included = TRUE THEN distribution_agreement_id END)
      comment: "Number of agreements that include streaming rights. Tracks digital distribution footprint expansion."
    - name: "retransmission_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retransmission_consent_granted = TRUE THEN distribution_agreement_id END) / NULLIF(COUNT(DISTINCT distribution_agreement_id), 0), 2)
      comment: "Percentage of distribution agreements with retransmission consent granted. Regulatory compliance and revenue indicator."
    - name: "total_distribution_agreement_value"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE) + CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Combined total of carriage fees and minimum guarantees across all distribution agreements. Comprehensive revenue commitment metric."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_affiliate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for affiliate agreements — tracks affiliation fees, local ad avail inventory, clearance performance, and retransmission revenue splits across affiliate station relationships."
  source: "`vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of affiliate agreement for segmentation (standard affiliation, retransmission consent, digital)."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the affiliate agreement for lifecycle management."
    - name: "affiliation_fee_currency"
      expr: affiliation_fee_currency
      comment: "Currency of the affiliation fee for multi-currency financial reporting."
    - name: "affiliation_fee_frequency"
      expr: affiliation_fee_frequency
      comment: "Payment frequency for affiliation fees (monthly, quarterly, annual) for cash flow planning."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the affiliate agreement includes exclusivity provisions."
    - name: "retransmission_consent_included_flag"
      expr: retransmission_consent_included_flag
      comment: "Whether retransmission consent is included in the affiliate agreement."
    - name: "local_insertion_rights_flag"
      expr: local_insertion_rights_flag
      comment: "Whether local ad insertion rights are granted, relevant for local advertising revenue."
    - name: "simulcast_requirement_flag"
      expr: simulcast_requirement_flag
      comment: "Whether simulcast of network programming is required under the agreement."
  measures:
    - name: "total_affiliation_fee_amount"
      expr: SUM(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Total affiliation fee revenue across all affiliate agreements. Primary revenue KPI for affiliate network."
    - name: "avg_affiliation_fee_amount"
      expr: AVG(CAST(affiliation_fee_amount AS DOUBLE))
      comment: "Average affiliation fee per agreement. Benchmarks fee levels for affiliate negotiation strategy."
    - name: "total_local_ad_avails_minutes_per_hour"
      expr: SUM(CAST(local_ad_avails_minutes_per_hour AS DOUBLE))
      comment: "Total local ad avail minutes per hour across all affiliate agreements. Measures local advertising inventory capacity."
    - name: "avg_local_ad_avails_minutes_per_hour"
      expr: AVG(CAST(local_ad_avails_minutes_per_hour AS DOUBLE))
      comment: "Average local ad avail minutes per hour per agreement. Benchmarks local inventory allocation."
    - name: "avg_minimum_clearance_percentage"
      expr: AVG(CAST(minimum_clearance_percentage AS DOUBLE))
      comment: "Average minimum clearance percentage required across affiliate agreements. Tracks programming clearance commitments."
    - name: "avg_retransmission_revenue_split_pct"
      expr: AVG(CAST(retransmission_revenue_split_percentage AS DOUBLE))
      comment: "Average retransmission revenue split percentage. Measures revenue sharing burden in retransmission consent agreements."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across affiliate agreements. Tracks overall revenue sharing commitments."
    - name: "active_affiliate_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN affiliate_agreement_id END)
      comment: "Number of currently active affiliate agreements. Baseline for active affiliate network size."
    - name: "avg_must_air_programming_hours"
      expr: AVG(CAST(must_air_programming_hours AS DOUBLE))
      comment: "Average must-air programming hours committed per affiliate agreement. Tracks programming obligation burden."
    - name: "avg_performance_standard_grp_minimum"
      expr: AVG(CAST(performance_standard_grp_minimum AS DOUBLE))
      comment: "Average minimum GRP performance standard across affiliate agreements. Measures audience delivery commitments."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_carriage_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for carriage fee schedules — tracks per-subscriber fee levels, volume discount tiers, escalation rates, and fee schedule health across distribution partners."
  source: "`vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Type of carriage fee (base, tiered, flat) for fee structure analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the fee schedule (active, expired, pending) for lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the carriage fee schedule for multi-currency financial reporting."
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of fee escalation mechanism (CPI, fixed, negotiated) for cost forecasting."
    - name: "escalation_frequency"
      expr: escalation_frequency
      comment: "Frequency of fee escalation (annual, biennial) for cash flow planning."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency for carriage fees (monthly, quarterly) for cash flow management."
    - name: "mfn_provision_flag"
      expr: mfn_provision_flag
      comment: "Whether the schedule includes a most-favored-nation provision, relevant for competitive pricing."
    - name: "subscriber_count_source"
      expr: subscriber_count_source
      comment: "Source of subscriber count data used for fee calculation (operator-reported, third-party audited)."
  measures:
    - name: "avg_base_fee_per_subscriber"
      expr: AVG(CAST(base_fee_per_subscriber AS DOUBLE))
      comment: "Average base carriage fee per subscriber across all schedules. Core pricing KPI for carriage fee benchmarking."
    - name: "total_minimum_guaranteed_fee"
      expr: SUM(CAST(minimum_guaranteed_fee AS DOUBLE))
      comment: "Total minimum guaranteed carriage fees across all schedules. Tracks guaranteed revenue floor from carriage."
    - name: "avg_escalation_rate_percentage"
      expr: AVG(CAST(escalation_rate_percentage AS DOUBLE))
      comment: "Average fee escalation rate across carriage fee schedules. Forecasts future carriage cost growth."
    - name: "avg_late_payment_penalty_rate"
      expr: AVG(CAST(late_payment_penalty_rate AS DOUBLE))
      comment: "Average late payment penalty rate across schedules. Measures financial penalty exposure for late payments."
    - name: "avg_maximum_fee_cap"
      expr: AVG(CAST(maximum_fee_cap AS DOUBLE))
      comment: "Average maximum fee cap across carriage fee schedules. Tracks ceiling on carriage fee exposure."
    - name: "mfn_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN mfn_provision_flag = TRUE THEN carriage_fee_schedule_id END)
      comment: "Number of carriage fee schedules with MFN provisions. Tracks competitive pricing obligation exposure."
    - name: "active_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN schedule_status = 'active' THEN carriage_fee_schedule_id END)
      comment: "Number of currently active carriage fee schedules. Baseline for active fee schedule portfolio."
    - name: "avg_volume_discount_tier1_rate"
      expr: AVG(CAST(volume_discount_tier_1_rate AS DOUBLE))
      comment: "Average tier-1 volume discount rate across schedules. Measures discount generosity at first volume threshold."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_minimum_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for minimum guarantee tracking — monitors MG commitments, recoupment progress, outstanding balances, and overage performance across content acquisition deals."
  source: "`vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee`"
  dimensions:
    - name: "mg_type"
      expr: mg_type
      comment: "Type of minimum guarantee (advance, floor, per-episode) for financial classification."
    - name: "mg_status"
      expr: mg_status
      comment: "Current status of the MG (active, fully recouped, in recoupment, expired) for portfolio management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the minimum guarantee for multi-currency financial reporting."
    - name: "is_recoupable"
      expr: is_recoupable
      comment: "Whether the MG is recoupable against future royalties, relevant for liability classification."
    - name: "is_cross_collateralized"
      expr: is_cross_collateralized
      comment: "Whether the MG is cross-collateralized across multiple titles, relevant for recoupment strategy."
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method used to amortize the MG (straight-line, units-of-production) for accounting treatment."
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule (milestone, periodic, upfront) for cash flow planning."
    - name: "recoupment_basis"
      expr: recoupment_basis
      comment: "Basis on which recoupment is calculated (net receipts, gross receipts) for financial modeling."
  measures:
    - name: "total_mg_amount"
      expr: SUM(CAST(mg_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all MG records. Primary liability KPI for content investment."
    - name: "total_outstanding_balance_amount"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding unrecouped MG balance. Tracks remaining financial liability from MG commitments."
    - name: "total_recouped_to_date_amount"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE))
      comment: "Total amount recouped to date across all MG records. Measures recoupment progress against commitments."
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage amounts earned above MG thresholds. Measures incremental royalty revenue beyond guaranteed floors."
    - name: "avg_recoupment_percentage"
      expr: AVG(CAST(recoupment_percentage AS DOUBLE))
      comment: "Average recoupment percentage across MG records. Benchmarks recoupment efficiency across the content portfolio."
    - name: "avg_overage_royalty_rate"
      expr: AVG(CAST(overage_royalty_rate AS DOUBLE))
      comment: "Average overage royalty rate across MG agreements. Tracks incremental royalty rate above MG threshold."
    - name: "recoupment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(recouped_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(mg_amount AS DOUBLE)), 0), 2)
      comment: "Overall recoupment rate as a percentage of total MG commitments. Key financial health indicator for content investment recovery."
    - name: "fully_recouped_mg_count"
      expr: COUNT(DISTINCT CASE WHEN mg_status = 'fully_recouped' THEN minimum_guarantee_id END)
      comment: "Number of MG records that have been fully recouped. Tracks successful content investment recovery."
    - name: "cross_collateralized_mg_count"
      expr: COUNT(DISTINCT CASE WHEN is_cross_collateralized = TRUE THEN minimum_guarantee_id END)
      comment: "Number of cross-collateralized MG records. Tracks complexity and risk in recoupment structures."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner dispute management — tracks dispute volume, financial exposure, resolution efficiency, and escalation rates across partner relationships."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (financial, contractual, content, technical) for root cause analysis."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute for detailed classification and trend analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, in mediation, resolved, escalated) for pipeline management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the dispute for management attention prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for financial reporting."
    - name: "arbitration_required"
      expr: arbitration_required
      comment: "Whether arbitration is required, indicating severity and cost of resolution."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute for resource allocation and resolution urgency."
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party that initiated the dispute (partner or internal) for accountability tracking."
  measures:
    - name: "total_disputed_amount_usd"
      expr: SUM(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Total financial amount under dispute across all partner disputes. Primary financial risk KPI for dispute management."
    - name: "avg_disputed_amount_usd"
      expr: AVG(CAST(disputed_amount_usd AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute severity and financial exposure per incident."
    - name: "total_settlement_amount_usd"
      expr: SUM(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Total settlement amounts paid across resolved disputes. Tracks actual financial cost of dispute resolution."
    - name: "open_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status = 'open' THEN partner_dispute_id END)
      comment: "Number of currently open disputes. Operational KPI for dispute backlog management."
    - name: "arbitration_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN arbitration_required = TRUE THEN partner_dispute_id END)
      comment: "Number of disputes requiring arbitration. Tracks high-severity disputes with significant legal cost implications."
    - name: "arbitration_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN arbitration_required = TRUE THEN partner_dispute_id END) / NULLIF(COUNT(DISTINCT partner_dispute_id), 0), 2)
      comment: "Percentage of disputes escalating to arbitration. Measures dispute severity and relationship health."
    - name: "settlement_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount_usd AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount_usd AS DOUBLE)), 0), 2)
      comment: "Settlement amount as a percentage of disputed amount. Measures negotiation effectiveness in dispute resolution."
    - name: "legal_hold_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN legal_hold_status = TRUE THEN partner_dispute_id END)
      comment: "Number of disputes under legal hold. Tracks disputes with active litigation risk requiring document preservation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner audit events — tracks audit findings, financial adjustments, cost recovery, and corrective action compliance across partner audits."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (royalty, compliance, financial, operational) for audit portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (in progress, completed, follow-up required) for pipeline management."
    - name: "finding_category"
      expr: finding_category
      comment: "Category of audit finding (underpayment, overpayment, reporting error) for root cause analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the audit finding for corrective action tracking."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required, indicating audit severity."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required, indicating unresolved compliance issues."
    - name: "audit_trigger"
      expr: audit_trigger
      comment: "Trigger for the audit (routine, dispute-driven, risk-based) for audit program analysis."
    - name: "cost_recovery_status"
      expr: cost_recovery_status
      comment: "Status of audit cost recovery from the partner for financial management."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial adjustment amounts identified across all partner audits. Primary financial recovery KPI."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average financial adjustment per audit event. Benchmarks audit yield and financial recovery efficiency."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amounts disputed during partner audits. Tracks financial exposure from audit-triggered disputes."
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of conducting partner audits. Measures audit program investment for ROI analysis."
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Average cost per partner audit. Benchmarks audit efficiency and cost management."
    - name: "audit_roi_ratio"
      expr: ROUND(SUM(CAST(adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(audit_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of total financial adjustments recovered to total audit costs. Measures return on investment for the audit program."
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN partner_audit_event_id END)
      comment: "Number of audits requiring corrective action. Tracks compliance remediation workload."
    - name: "follow_up_audit_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_audit_required = TRUE THEN partner_audit_event_id END) / NULLIF(COUNT(DISTINCT partner_audit_event_id), 0), 2)
      comment: "Percentage of audits requiring follow-up. Measures first-pass audit resolution effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner performance obligations — tracks compliance rates, breach frequency, penalty exposure, and SLA adherence across contractual performance commitments."
  source: "`vibe_media_broadcasting_v1`.`partner`.`performance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation (audience delivery, content clearance, SLA) for obligation portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (compliant, in breach, at risk) for risk management."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for breached obligations for management prioritization."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for non-compliance (financial, makegood, termination) for risk quantification."
    - name: "measurement_period"
      expr: measurement_period
      comment: "Period over which obligation performance is measured (weekly, monthly, quarterly)."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of performance reporting for the obligation."
    - name: "makegood_provision_flag"
      expr: makegood_provision_flag
      comment: "Whether the obligation includes a makegood provision for under-delivery remediation."
    - name: "notification_required_flag"
      expr: notification_required_flag
      comment: "Whether breach notification is required, relevant for contractual compliance."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts accrued from performance obligation breaches. Primary financial risk KPI for compliance management."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per performance obligation. Benchmarks penalty severity across obligation types."
    - name: "total_breach_count"
      expr: SUM(CAST(breach_count AS BIGINT))
      comment: "Total number of performance obligation breaches across all obligations. Tracks compliance failure frequency."
    - name: "avg_last_measured_value"
      expr: AVG(CAST(last_measured_value AS DOUBLE))
      comment: "Average last measured performance value across obligations. Tracks current performance levels against thresholds."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average performance threshold value across obligations. Benchmarks contractual performance standards."
    - name: "in_breach_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'in_breach' THEN performance_obligation_id END)
      comment: "Number of obligations currently in breach. Critical operational KPI for partner compliance management."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'compliant' THEN performance_obligation_id END) / NULLIF(COUNT(DISTINCT performance_obligation_id), 0), 2)
      comment: "Percentage of performance obligations currently in compliance. Top-level partner performance health indicator."
    - name: "makegood_obligation_count"
      expr: COUNT(DISTINCT CASE WHEN makegood_provision_flag = TRUE THEN performance_obligation_id END)
      comment: "Number of obligations with makegood provisions. Tracks remediation obligations from under-delivery."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_delivery_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for content delivery obligations — tracks delivery compliance, SLA adherence, penalty exposure, and quality control outcomes across partner content delivery commitments."
  source: "`vibe_media_broadcasting_v1`.`partner`.`delivery_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of delivery obligation (master delivery, localization, QC) for obligation portfolio analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (pending, delivered, overdue, rejected) for pipeline management."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of content delivery (satellite, FTP, cloud, physical) for logistics analysis."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of delivered content (passed, failed, pending) for quality management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the delivery obligation for resource allocation."
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "Whether the delivery met SLA requirements for compliance tracking."
    - name: "redelivery_required"
      expr: redelivery_required
      comment: "Whether redelivery is required due to quality failure or rejection."
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captioning is required for the delivered content, relevant for accessibility compliance."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts accrued from delivery obligation failures. Primary financial risk KPI for delivery management."
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size in GB for delivered content. Tracks infrastructure and bandwidth requirements for delivery operations."
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total file size in GB across all delivery obligations. Measures total content delivery volume for infrastructure planning."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_compliance = TRUE THEN delivery_obligation_id END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0), 2)
      comment: "Percentage of delivery obligations meeting SLA requirements. Top-level delivery performance KPI."
    - name: "qc_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN quality_control_status = 'passed' THEN delivery_obligation_id END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0), 2)
      comment: "Percentage of deliveries passing quality control. Measures content quality and delivery process effectiveness."
    - name: "redelivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN redelivery_required = TRUE THEN delivery_obligation_id END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0), 2)
      comment: "Percentage of deliveries requiring redelivery. Measures first-pass delivery quality and operational efficiency."
    - name: "overdue_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN delivery_status = 'overdue' THEN delivery_obligation_id END)
      comment: "Number of overdue delivery obligations. Operational KPI for delivery pipeline risk management."
    - name: "avg_required_bitrate_mbps"
      expr: AVG(CAST(required_bitrate_mbps AS DOUBLE))
      comment: "Average required bitrate in Mbps across delivery obligations. Informs technical infrastructure capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_syndication_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for syndication agreements — tracks syndication fee revenue, minimum guarantees, run limits, and agreement health across content syndication partnerships."
  source: "`vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of syndication agreement (first-run, off-network, barter) for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the syndication agreement for lifecycle management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the syndication agreement for multi-currency financial reporting."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the syndication agreement includes exclusivity provisions."
    - name: "syndication_fee_structure"
      expr: syndication_fee_structure
      comment: "Fee structure of the syndication deal (flat fee, per-episode, revenue share) for financial modeling."
    - name: "territory_grant"
      expr: territory_grant
      comment: "Geographic territory covered by the syndication agreement for rights analysis."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement includes a renewal option for long-term content supply planning."
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Broadcast standard required for syndicated content delivery (HD, SD, 4K)."
  measures:
    - name: "total_flat_fee_amount"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue across all syndication agreements. Primary revenue KPI for flat-fee syndication deals."
    - name: "total_per_episode_fee_amount"
      expr: SUM(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Total per-episode fee revenue across syndication agreements. Tracks episodic syndication revenue."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across syndication agreements. Tracks guaranteed syndication revenue floor."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across syndication agreements. Tracks revenue sharing burden in syndication."
    - name: "active_syndication_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'active' THEN syndication_agreement_id END)
      comment: "Number of currently active syndication agreements. Baseline for active syndication portfolio size."
    - name: "exclusive_syndication_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN syndication_agreement_id END)
      comment: "Number of exclusive syndication agreements. Tracks exclusive content distribution commitments."
    - name: "total_barter_spot_count"
      expr: SUM(CAST(barter_spot_count AS BIGINT))
      comment: "Total barter advertising spots committed across syndication agreements. Tracks barter inventory obligations."
    - name: "avg_per_episode_fee_amount"
      expr: AVG(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Average per-episode syndication fee. Benchmarks episodic content value in syndication market."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_deal_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for deal negotiation pipeline — tracks deal value progression, negotiation cycle times, escalation rates, and deal closure efficiency across the partner deal pipeline."
  source: "`vibe_media_broadcasting_v1`.`partner`.`deal_negotiation`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal being negotiated (acquisition, distribution, co-production, syndication) for pipeline segmentation."
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of the negotiation (active, stalled, closed, abandoned) for pipeline management."
    - name: "negotiation_stage"
      expr: negotiation_stage
      comment: "Current stage of the negotiation (term sheet, legal review, execution) for funnel analysis."
    - name: "deal_currency"
      expr: deal_currency
      comment: "Currency of the deal for multi-currency financial reporting."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the negotiation has been escalated, indicating complexity or risk."
    - name: "legal_review_status"
      expr: legal_review_status
      comment: "Status of legal review in the negotiation process for compliance tracking."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal under negotiation includes exclusivity provisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the deal negotiation for risk management prioritization."
  measures:
    - name: "total_proposed_deal_value"
      expr: SUM(CAST(proposed_deal_value AS DOUBLE))
      comment: "Total proposed deal value across all active negotiations. Measures deal pipeline value for revenue forecasting."
    - name: "total_agreed_deal_value"
      expr: SUM(CAST(agreed_deal_value AS DOUBLE))
      comment: "Total agreed deal value for closed negotiations. Tracks actual deal value secured from negotiations."
    - name: "avg_proposed_deal_value"
      expr: AVG(CAST(proposed_deal_value AS DOUBLE))
      comment: "Average proposed deal value per negotiation. Benchmarks deal size in the pipeline."
    - name: "avg_agreed_deal_value"
      expr: AVG(CAST(agreed_deal_value AS DOUBLE))
      comment: "Average agreed deal value per closed negotiation. Benchmarks actual deal closure value."
    - name: "deal_value_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(agreed_deal_value AS DOUBLE)) / NULLIF(SUM(CAST(proposed_deal_value AS DOUBLE)), 0), 2)
      comment: "Agreed deal value as a percentage of proposed deal value. Measures negotiation effectiveness and value retention."
    - name: "escalated_deal_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN deal_negotiation_id END)
      comment: "Number of negotiations that have been escalated. Tracks negotiation complexity and management intervention requirements."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN deal_negotiation_id END) / NULLIF(COUNT(DISTINCT deal_negotiation_id), 0), 2)
      comment: "Percentage of negotiations requiring escalation. Measures negotiation difficulty and process efficiency."
    - name: "avg_redline_version_count"
      expr: AVG(CAST(redline_version_count AS DOUBLE))
      comment: "Average number of redline versions per negotiation. Measures negotiation complexity and legal review intensity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner agreement renewals — tracks renewal pipeline value, success rates, value change, and strategic importance of renewals across the partner portfolio."
  source: "`vibe_media_broadcasting_v1`.`partner`.`renewal`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement being renewed for renewal portfolio segmentation."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (in progress, completed, declined, auto-renewed) for pipeline management."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the renewal (renewed, not renewed, renegotiated) for success rate analysis."
    - name: "renegotiation_required_flag"
      expr: renegotiation_required_flag
      comment: "Whether renegotiation is required, indicating relationship complexity."
    - name: "auto_renewal_clause_flag"
      expr: auto_renewal_clause_flag
      comment: "Whether the agreement has an auto-renewal clause for renewal pipeline forecasting."
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the renewal for executive prioritization."
    - name: "renegotiation_priority"
      expr: renegotiation_priority
      comment: "Priority level for renegotiation for resource allocation."
    - name: "risk_assessment"
      expr: risk_assessment
      comment: "Risk assessment of the renewal outcome for proactive retention management."
  measures:
    - name: "total_original_deal_value_amount"
      expr: SUM(CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total original deal value of agreements up for renewal. Measures renewal pipeline financial exposure."
    - name: "total_proposed_deal_value_amount"
      expr: SUM(CAST(proposed_deal_value_amount AS DOUBLE))
      comment: "Total proposed deal value for renewals. Tracks projected revenue from renewal negotiations."
    - name: "avg_value_change_percentage"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage change in deal value from original to proposed renewal. Measures pricing power in renewals."
    - name: "renewal_success_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN outcome = 'renewed' THEN renewal_id END) / NULLIF(COUNT(DISTINCT renewal_id), 0), 2)
      comment: "Percentage of renewals resulting in successful renewal. Top-level partner retention KPI."
    - name: "auto_renewal_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_clause_flag = TRUE THEN renewal_id END)
      comment: "Number of agreements with auto-renewal clauses. Tracks predictable renewal pipeline volume."
    - name: "renegotiation_required_count"
      expr: COUNT(DISTINCT CASE WHEN renegotiation_required_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals requiring active renegotiation. Measures renewal workload and relationship complexity."
    - name: "value_uplift_amount"
      expr: SUM(CAST(proposed_deal_value_amount AS DOUBLE) - CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total value uplift from original to proposed renewal deal value. Measures revenue growth from renewal negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_deal_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for partner deal approval workflows — tracks approval cycle efficiency, deal value thresholds, financial commitment levels, and approval decision outcomes."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal requiring approval for approval portfolio segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (pending, approved, rejected, escalated) for workflow management."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of approval required (manager, VP, C-suite, board) for governance analysis."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final approval decision (approved, rejected, conditional) for decision analysis."
    - name: "approval_threshold_exceeded_flag"
      expr: approval_threshold_exceeded_flag
      comment: "Whether the deal value exceeded the standard approval threshold, requiring elevated review."
    - name: "finance_review_required_flag"
      expr: finance_review_required_flag
      comment: "Whether finance review is required for the deal approval."
    - name: "legal_review_required_flag"
      expr: legal_review_required_flag
      comment: "Whether legal review is required for the deal approval."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the deal for approval risk management."
  measures:
    - name: "total_deal_value_amount"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total deal value across all approval requests. Measures total financial commitment under approval governance."
    - name: "avg_deal_value_amount"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average deal value per approval request. Benchmarks deal size requiring approval governance."
    - name: "total_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts in deals under approval. Tracks guaranteed financial commitments requiring governance."
    - name: "total_carriage_fee_commitment_amount"
      expr: SUM(CAST(carriage_fee_commitment_amount AS DOUBLE))
      comment: "Total carriage fee commitments in deals under approval. Tracks distribution cost commitments requiring governance."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_decision = 'approved' THEN partner_deal_approval_id END) / NULLIF(COUNT(DISTINCT partner_deal_approval_id), 0), 2)
      comment: "Percentage of deal approvals resulting in approval. Measures approval process efficiency and deal quality."
    - name: "threshold_exceeded_deal_count"
      expr: COUNT(DISTINCT CASE WHEN approval_threshold_exceeded_flag = TRUE THEN partner_deal_approval_id END)
      comment: "Number of deals exceeding standard approval thresholds. Tracks high-value deal volume requiring elevated governance."
    - name: "pending_approval_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'pending' THEN partner_deal_approval_id END)
      comment: "Number of deal approvals currently pending. Operational KPI for approval workflow backlog management."
    - name: "avg_ip_ownership_percentage"
      expr: AVG(CAST(ip_ownership_percentage AS DOUBLE))
      comment: "Average IP ownership percentage in deals under approval. Tracks intellectual property acquisition in deal approvals."
$$;