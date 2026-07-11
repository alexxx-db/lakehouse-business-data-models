-- Metric views for domain: partner | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:10:12

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic content acquisition deal performance metrics tracking deal value, minimum guarantees, revenue share, and contract lifecycle for content procurement decisions."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the acquisition deal (e.g., active, expired, pending)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of acquisition deal (e.g., exclusive, non-exclusive, first-run)"
    - name: "content_delivery_format"
      expr: content_delivery_format
      comment: "Format in which content is delivered (e.g., HD, 4K, SD)"
    - name: "territory_coverage"
      expr: territory_coverage
      comment: "Geographic territories covered by the deal"
    - name: "distribution_rights"
      expr: distribution_rights
      comment: "Distribution rights granted (e.g., linear, digital, VOD)"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal grants exclusive rights"
    - name: "deal_year"
      expr: YEAR(deal_effective_date)
      comment: "Year the deal became effective"
    - name: "deal_quarter"
      expr: CONCAT('Q', QUARTER(deal_effective_date), '-', YEAR(deal_effective_date))
      comment: "Quarter and year the deal became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which deal value is denominated"
    - name: "windowing_strategy"
      expr: windowing_strategy
      comment: "Content release windowing strategy (e.g., theatrical, SVOD, AVOD)"
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total contracted value of all acquisition deals, key metric for content investment tracking"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across deals, critical for cash flow planning"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across deals, indicates partnership economics"
    - name: "total_runtime_hours"
      expr: SUM(CAST(total_runtime_hours AS DOUBLE))
      comment: "Total hours of content acquired, measures content volume for programming strategy"
    - name: "deal_count"
      expr: COUNT(DISTINCT acquisition_deal_id)
      comment: "Number of unique acquisition deals, tracks partnership breadth"
    - name: "avg_deal_value"
      expr: AVG(CAST(deal_value_amount AS DOUBLE))
      comment: "Average deal value, indicates typical deal size for budgeting"
    - name: "exclusive_deal_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive deals, measures competitive content positioning"
    - name: "avg_license_term_months"
      expr: AVG(CAST(license_term_months AS DOUBLE))
      comment: "Average license term duration in months, informs content lifecycle planning"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_acquisition_deal_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular content acquisition line-item metrics tracking per-title licensing fees, royalty rates, and content delivery performance for content portfolio optimization."
  source: "`vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the deal line item (e.g., active, delivered, pending)"
    - name: "content_type"
      expr: content_type
      comment: "Type of content (e.g., series, movie, documentary)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the content (e.g., delivered, in-progress, delayed)"
    - name: "genre_primary"
      expr: genre_primary
      comment: "Primary genre of the content"
    - name: "territory_code"
      expr: territory_code
      comment: "Territory code for the license"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the line item grants exclusive rights"
    - name: "language_code"
      expr: language_code
      comment: "Primary language of the content"
    - name: "production_year"
      expr: production_year
      comment: "Year the content was produced"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format for content delivery (e.g., file-based, tape, streaming)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for license fees"
  measures:
    - name: "total_license_fees"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license fees across all line items, primary content cost metric for P&L"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments at line level, critical for cash forecasting"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage, indicates content cost structure"
    - name: "line_item_count"
      expr: COUNT(DISTINCT acquisition_deal_line_id)
      comment: "Number of unique line items, measures content portfolio granularity"
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee per line item, benchmarks per-title acquisition cost"
    - name: "total_runtime_minutes"
      expr: SUM(CAST(runtime_minutes AS DOUBLE))
      comment: "Total runtime in minutes, measures content volume for scheduling"
    - name: "avg_license_duration_months"
      expr: AVG(CAST(license_duration_months AS DOUBLE))
      comment: "Average license duration, informs content amortization strategy"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic partner relationship metrics tracking revenue contribution, content volume, relationship health, and partner portfolio composition for partnership strategy and risk management."
  source: "`vibe_media_broadcasting_v1`.`partner`.`partner`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (e.g., content provider, distributor, affiliate)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the partnership (e.g., active, inactive, pending)"
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic importance tier (e.g., tier 1, tier 2, tier 3)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk classification of the partner"
    - name: "content_specialization"
      expr: content_specialization
      comment: "Content specialization area of the partner"
    - name: "domicile_country_code"
      expr: domicile_country_code
      comment: "Country code where partner is domiciled"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the partnership is exclusive"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the partner"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage for new partners"
    - name: "relationship_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the partnership relationship started"
  measures:
    - name: "total_annual_revenue_contribution"
      expr: SUM(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Total annual revenue contribution from all partners in USD, critical for partnership ROI assessment"
    - name: "total_content_volume_hours"
      expr: SUM(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Total annual content volume in hours from partners, measures content supply capacity"
    - name: "partner_count"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique partners, tracks partnership portfolio breadth"
    - name: "avg_revenue_per_partner"
      expr: AVG(CAST(annual_revenue_contribution_usd AS DOUBLE))
      comment: "Average annual revenue per partner, indicates partner value concentration"
    - name: "avg_content_volume_per_partner"
      expr: AVG(CAST(annual_content_volume_hours AS DOUBLE))
      comment: "Average content volume per partner, measures typical partner content contribution"
    - name: "exclusive_partner_count"
      expr: SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive partnerships, indicates competitive content positioning strength"
    - name: "active_partner_count"
      expr: SUM(CASE WHEN relationship_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active partners, measures current partnership ecosystem health"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_minimum_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Minimum guarantee financial performance metrics tracking MG commitments, recoupment progress, overage generation, and cash flow for content investment ROI analysis."
  source: "`vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee`"
  dimensions:
    - name: "mg_status"
      expr: mg_status
      comment: "Status of the minimum guarantee (e.g., active, recouped, outstanding)"
    - name: "mg_type"
      expr: mg_type
      comment: "Type of minimum guarantee (e.g., acquisition, production, distribution)"
    - name: "is_recoupable"
      expr: is_recoupable
      comment: "Whether the minimum guarantee is recoupable"
    - name: "is_cross_collateralized"
      expr: is_cross_collateralized
      comment: "Whether the MG is cross-collateralized across multiple titles"
    - name: "recoupment_basis"
      expr: recoupment_basis
      comment: "Basis for recoupment calculation (e.g., gross revenue, net revenue)"
    - name: "payment_schedule_type"
      expr: payment_schedule_type
      comment: "Type of payment schedule (e.g., upfront, installments, milestone-based)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which MG is denominated"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method used for amortizing the MG"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the MG became effective"
    - name: "accounting_treatment_code"
      expr: accounting_treatment_code
      comment: "Accounting treatment code for the MG"
  measures:
    - name: "total_mg_amount"
      expr: SUM(CAST(mg_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments, critical for content investment capital allocation"
    - name: "total_recouped_amount"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE))
      comment: "Total amount recouped to date, measures content investment payback performance"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding MG balance, key metric for content asset valuation and cash flow"
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage generated beyond MG, indicates high-performing content investments"
    - name: "mg_count"
      expr: COUNT(DISTINCT minimum_guarantee_id)
      comment: "Number of unique minimum guarantees, tracks content investment deal volume"
    - name: "avg_recoupment_percentage"
      expr: AVG(CAST(recoupment_percentage AS DOUBLE))
      comment: "Average recoupment percentage, indicates typical content ROI performance"
    - name: "avg_overage_royalty_rate"
      expr: AVG(CAST(overage_royalty_rate AS DOUBLE))
      comment: "Average overage royalty rate, measures profit-sharing economics on successful content"
    - name: "recoupment_rate"
      expr: SUM(CAST(recouped_to_date_amount AS DOUBLE)) / NULLIF(SUM(CAST(mg_amount AS DOUBLE)), 0)
      comment: "Overall recoupment rate (recouped / total MG), key content investment efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_syndication_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication deal performance metrics tracking flat fees, revenue share, per-episode economics, and run limits for content monetization strategy and syndication portfolio optimization."
  source: "`vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the syndication agreement (e.g., active, expired, pending)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of syndication agreement (e.g., first-run, off-network, barter)"
    - name: "syndication_fee_structure"
      expr: syndication_fee_structure
      comment: "Fee structure (e.g., flat fee, revenue share, hybrid)"
    - name: "territory_grant"
      expr: territory_grant
      comment: "Geographic territory granted for syndication"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the syndication rights are exclusive"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Broadcast standard required (e.g., NTSC, PAL, ATSC)"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format for content delivery"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for syndication fees"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the syndication agreement became effective"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Whether the agreement includes renewal options"
  measures:
    - name: "total_flat_fee"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue from syndication deals, key metric for guaranteed syndication income"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments in syndication, critical for revenue forecasting"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage, indicates syndication partnership economics"
    - name: "total_per_episode_fees"
      expr: SUM(CAST(per_episode_fee_amount AS DOUBLE))
      comment: "Total per-episode fee revenue, measures episode-level syndication value"
    - name: "syndication_agreement_count"
      expr: COUNT(DISTINCT syndication_agreement_id)
      comment: "Number of unique syndication agreements, tracks syndication distribution breadth"
    - name: "avg_flat_fee"
      expr: AVG(CAST(flat_fee_amount AS DOUBLE))
      comment: "Average flat fee per agreement, benchmarks typical syndication deal value"
    - name: "exclusive_agreement_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive syndication agreements, measures competitive positioning"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution partnership metrics tracking carriage fees, minimum guarantees, SLA performance, and rights scope for distribution strategy and platform relationship management."
  source: "`vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the distribution agreement (e.g., active, expired, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distribution agreement (e.g., carriage, retransmission, streaming)"
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Structure of carriage fees (e.g., per-subscriber, flat, tiered)"
    - name: "territory"
      expr: territory
      comment: "Geographic territory covered by the agreement"
    - name: "channel_positioning_tier"
      expr: channel_positioning_tier
      comment: "Channel positioning tier (e.g., basic, premium, sports)"
    - name: "must_carry_obligation"
      expr: must_carry_obligation
      comment: "Whether distributor has must-carry obligation"
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent was granted"
    - name: "streaming_rights_included"
      expr: streaming_rights_included
      comment: "Whether streaming rights are included"
    - name: "vod_rights_included"
      expr: vod_rights_included
      comment: "Whether VOD rights are included"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for carriage fees"
  measures:
    - name: "total_carriage_fees"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue, primary distribution income metric for platform partnerships"
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments from distributors, critical for revenue floor planning"
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average SLA uptime percentage, measures distribution reliability and service quality"
    - name: "distribution_agreement_count"
      expr: COUNT(DISTINCT distribution_agreement_id)
      comment: "Number of unique distribution agreements, tracks distribution platform reach"
    - name: "avg_carriage_fee"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per agreement, benchmarks distribution deal economics"
    - name: "streaming_enabled_count"
      expr: SUM(CASE WHEN streaming_rights_included = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with streaming rights, measures digital distribution penetration"
    - name: "retransmission_consent_count"
      expr: SUM(CASE WHEN retransmission_consent_granted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with retransmission consent, tracks broadcast distribution rights"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_coproduction_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Co-production investment and partnership metrics tracking budget allocation, IP ownership, revenue sharing, and production collaboration for content development strategy."
  source: "`vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the co-production agreement (e.g., active, completed, in-production)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of co-production agreement (e.g., joint venture, treaty, bilateral)"
    - name: "production_type"
      expr: production_type
      comment: "Type of production (e.g., series, film, documentary)"
    - name: "revenue_sharing_model"
      expr: revenue_sharing_model
      comment: "Model for revenue sharing (e.g., proportional, waterfall, hybrid)"
    - name: "our_primary_territory"
      expr: our_primary_territory
      comment: "Our primary territory for distribution rights"
    - name: "creative_control_level"
      expr: creative_control_level
      comment: "Level of creative control (e.g., full, shared, limited)"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Jurisdiction governing the agreement"
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency for production budget"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the co-production agreement became effective"
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method for dispute resolution (e.g., arbitration, mediation, litigation)"
  measures:
    - name: "total_production_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total production budget across co-productions, key metric for content development capital allocation"
    - name: "total_our_investment"
      expr: SUM(CAST(our_investment_amount AS DOUBLE))
      comment: "Total our investment in co-productions, measures our content development financial commitment"
    - name: "avg_our_investment_percentage"
      expr: AVG(CAST(our_investment_percentage AS DOUBLE))
      comment: "Average our investment percentage, indicates typical co-production ownership stake"
    - name: "avg_our_ip_ownership_percentage"
      expr: AVG(CAST(our_ip_ownership_percentage AS DOUBLE))
      comment: "Average our IP ownership percentage, measures intellectual property rights retention"
    - name: "coproduction_count"
      expr: COUNT(DISTINCT coproduction_agreement_id)
      comment: "Number of unique co-production agreements, tracks content development partnership breadth"
    - name: "avg_budget_per_production"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per co-production, benchmarks typical production investment size"
    - name: "investment_to_budget_ratio"
      expr: SUM(CAST(our_investment_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0)
      comment: "Our investment as ratio of total budget, measures our financial leverage in co-productions"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership renewal and renegotiation metrics tracking renewal rates, deal value changes, strategic importance, and decision outcomes for partnership lifecycle management."
  source: "`vibe_media_broadcasting_v1`.`partner`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g., pending, approved, declined, in-negotiation)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement being renewed (e.g., acquisition, distribution, syndication)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the renewal (e.g., renewed, not-renewed, renegotiated)"
    - name: "renegotiation_required_flag"
      expr: renegotiation_required_flag
      comment: "Whether renegotiation was required"
    - name: "auto_renewal_clause_flag"
      expr: auto_renewal_clause_flag
      comment: "Whether the agreement had an auto-renewal clause"
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the partnership"
    - name: "partner_performance_rating"
      expr: partner_performance_rating
      comment: "Performance rating of the partner"
    - name: "renegotiation_priority"
      expr: renegotiation_priority
      comment: "Priority level for renegotiation (e.g., high, medium, low)"
    - name: "risk_assessment"
      expr: risk_assessment
      comment: "Risk assessment for the renewal"
    - name: "non_renewal_reason"
      expr: non_renewal_reason
      comment: "Reason for non-renewal if applicable"
  measures:
    - name: "total_original_deal_value"
      expr: SUM(CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total original deal value for renewals, baseline for measuring renewal economics"
    - name: "total_proposed_deal_value"
      expr: SUM(CAST(proposed_deal_value_amount AS DOUBLE))
      comment: "Total proposed deal value for renewals, measures potential future partnership value"
    - name: "renewal_count"
      expr: COUNT(DISTINCT renewal_id)
      comment: "Number of unique renewal opportunities, tracks partnership lifecycle activity"
    - name: "avg_value_change_percentage"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average value change percentage in renewals, indicates partnership value trend direction"
    - name: "renewal_rate"
      expr: SUM(CASE WHEN outcome = 'renewed' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT renewal_id), 0)
      comment: "Renewal success rate, critical metric for partnership retention and relationship health"
    - name: "renegotiation_rate"
      expr: SUM(CASE WHEN renegotiation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT renewal_id), 0)
      comment: "Rate of renewals requiring renegotiation, indicates partnership terms stability"
    - name: "value_uplift_total"
      expr: SUM((CAST(proposed_deal_value_amount AS DOUBLE)) - (CAST(original_deal_value_amount AS DOUBLE)))
      comment: "Total value uplift from renewals, measures incremental partnership value creation"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`partner_delivery_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery performance metrics tracking on-time delivery, SLA compliance, quality control, and technical specifications for operational excellence and partner satisfaction."
  source: "`vibe_media_broadcasting_v1`.`partner`.`delivery_obligation`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (e.g., delivered, pending, delayed, rejected)"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of delivery obligation (e.g., master, localized, promotional)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (e.g., file transfer, physical media, streaming)"
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "Quality control status (e.g., passed, failed, in-review)"
    - name: "required_format"
      expr: required_format
      comment: "Required delivery format (e.g., ProRes, H.264, IMF)"
    - name: "required_resolution"
      expr: required_resolution
      comment: "Required resolution (e.g., 4K, HD, SD)"
    - name: "sla_compliance"
      expr: sla_compliance
      comment: "Whether delivery met SLA requirements"
    - name: "redelivery_required"
      expr: redelivery_required
      comment: "Whether redelivery was required"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the delivery (e.g., urgent, high, normal)"
    - name: "language_version"
      expr: language_version
      comment: "Language version of the content"
  measures:
    - name: "delivery_obligation_count"
      expr: COUNT(DISTINCT delivery_obligation_id)
      comment: "Number of unique delivery obligations, tracks content delivery workload volume"
    - name: "on_time_delivery_rate"
      expr: SUM(CASE WHEN actual_delivery_date <= delivery_deadline THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0)
      comment: "On-time delivery rate, critical operational KPI for partner satisfaction and SLA compliance"
    - name: "sla_compliance_rate"
      expr: SUM(CASE WHEN sla_compliance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0)
      comment: "SLA compliance rate, measures delivery service quality and contractual performance"
    - name: "qc_pass_rate"
      expr: SUM(CASE WHEN quality_control_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0)
      comment: "Quality control pass rate, indicates content delivery quality and technical accuracy"
    - name: "redelivery_rate"
      expr: SUM(CASE WHEN redelivery_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT delivery_obligation_id), 0)
      comment: "Redelivery rate, measures delivery process efficiency and first-time-right quality"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts incurred for delivery failures, financial impact of delivery performance"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Total file size delivered in GB, measures data transfer volume and infrastructure load"
    - name: "avg_required_bitrate"
      expr: AVG(CAST(required_bitrate_mbps AS DOUBLE))
      comment: "Average required bitrate in Mbps, indicates typical technical quality requirements"
$$;