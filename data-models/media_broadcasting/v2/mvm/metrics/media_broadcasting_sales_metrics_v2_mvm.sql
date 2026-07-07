-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 06:47:57

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core advertising order metrics tracking contracted value, order volume, and pricing performance across campaigns and advertisers"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the advertising order (e.g., pending, confirmed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of advertising order (e.g., upfront, scatter, programmatic)"
    - name: "market_code"
      expr: market_code
      comment: "Geographic market code for the advertising order"
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target audience demographic segment for the order"
    - name: "product_category"
      expr: product_category
      comment: "Product or service category being advertised"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order financial values"
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the advertising flight begins"
    - name: "flight_end_month"
      expr: DATE_TRUNC('MONTH', flight_end_date)
      comment: "Month when the advertising flight ends"
    - name: "is_political_ad"
      expr: political_ad_flag
      comment: "Flag indicating whether this is a political advertising order"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the order (e.g., monthly, quarterly)"
  measures:
    - name: "total_contracted_value"
      expr: SUM(CAST(total_contracted_value AS DOUBLE))
      comment: "Total contracted value across all advertising orders - primary revenue metric"
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Net order value after discounts and commissions - realized revenue metric"
    - name: "avg_contracted_value_per_order"
      expr: AVG(CAST(total_contracted_value AS DOUBLE))
      comment: "Average contracted value per order - order size indicator"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to orders - pricing pressure indicator"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate paid to agencies - cost of sale metric"
    - name: "avg_contracted_cpm"
      expr: AVG(CAST(contracted_cpm AS DOUBLE))
      comment: "Average contracted cost per thousand impressions - pricing efficiency metric"
    - name: "avg_contracted_cprp"
      expr: AVG(CAST(contracted_cprp AS DOUBLE))
      comment: "Average contracted cost per rating point - audience pricing metric"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points across orders - audience reach commitment"
    - name: "order_count"
      expr: COUNT(DISTINCT ad_order_id)
      comment: "Distinct count of advertising orders - volume metric"
    - name: "avg_mmm_channel_contribution"
      expr: AVG(CAST(mmm_channel_contribution AS DOUBLE))
      comment: "Average marketing mix model channel contribution - attribution effectiveness metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed advertising order line metrics tracking spot delivery, inventory performance, and line-level revenue realization"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., scheduled, aired, preempted)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of advertising inventory (e.g., premium, standard, remnant)"
    - name: "spot_length_seconds"
      expr: spot_length_seconds
      comment: "Length of advertising spot in seconds"
    - name: "position_preference"
      expr: position_preference
      comment: "Preferred position within ad break (e.g., first, last, middle)"
    - name: "preemption_priority"
      expr: preemption_priority
      comment: "Priority level for preemption protection"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for line financial values"
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the line flight begins"
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month when revenue is recognized for accounting purposes"
    - name: "is_makegood"
      expr: CASE WHEN makegood_for_line_ad_order_line_id IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether this line is a makegood for a previous line"
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross line amount - top-line revenue metric"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net line amount after discounts - realized revenue metric"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate per spot - pricing metric"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions - efficiency metric"
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average cost per rating point - audience pricing metric"
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS BIGINT))
      comment: "Total contracted impressions across all lines - audience delivery commitment"
    - name: "total_actual_impressions_delivered"
      expr: SUM(CAST(actual_impressions_delivered AS BIGINT))
      comment: "Total actual impressions delivered - performance metric"
    - name: "total_contracted_grp"
      expr: SUM(CAST(contracted_grp AS DOUBLE))
      comment: "Total contracted gross rating points - audience reach commitment"
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total actual gross rating points delivered - performance metric"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage at line level - pricing pressure indicator"
    - name: "order_line_count"
      expr: COUNT(DISTINCT ad_order_line_id)
      comment: "Distinct count of order lines - volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular ad spot execution metrics tracking actual delivery, preemptions, makegoods, and spot-level performance"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_spot`"
  dimensions:
    - name: "spot_status"
      expr: spot_status
      comment: "Current status of the ad spot (e.g., scheduled, aired, preempted, cancelled)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the spot (e.g., billable, non-billable, disputed)"
    - name: "delivery_platform"
      expr: delivery_platform
      comment: "Platform where the spot was delivered (e.g., linear, digital, streaming)"
    - name: "daypart"
      expr: daypart
      comment: "Daypart when the spot aired (e.g., prime, daytime, late night)"
    - name: "market_code"
      expr: market_code
      comment: "Geographic market code for the spot"
    - name: "spot_length_seconds"
      expr: spot_length_seconds
      comment: "Length of the spot in seconds"
    - name: "is_bonus_spot"
      expr: bonus_spot_flag
      comment: "Flag indicating whether this is a bonus spot (no charge)"
    - name: "is_makegood"
      expr: makegood_flag
      comment: "Flag indicating whether this is a makegood spot"
    - name: "is_preempted"
      expr: preempted_flag
      comment: "Flag indicating whether the spot was preempted"
    - name: "preemption_reason"
      expr: preemption_reason
      comment: "Reason for spot preemption if applicable"
    - name: "scheduled_air_month"
      expr: DATE_TRUNC('MONTH', scheduled_air_date)
      comment: "Month when the spot was scheduled to air"
    - name: "is_dai"
      expr: dai_flag
      comment: "Flag indicating dynamic ad insertion delivery"
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Position of spot within the ad pod"
  measures:
    - name: "total_spot_rate_amount"
      expr: SUM(CAST(spot_rate_amount AS DOUBLE))
      comment: "Total spot rate amount - gross revenue metric"
    - name: "avg_spot_rate"
      expr: AVG(CAST(spot_rate_amount AS DOUBLE))
      comment: "Average spot rate - pricing metric"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average cost per thousand impressions at spot level - efficiency metric"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS BIGINT))
      comment: "Total impressions delivered across all spots - audience delivery metric"
    - name: "total_grp_value"
      expr: SUM(CAST(grp_value AS DOUBLE))
      comment: "Total gross rating points delivered - audience reach metric"
    - name: "total_trp_value"
      expr: SUM(CAST(trp_value AS DOUBLE))
      comment: "Total target rating points delivered - targeted audience reach metric"
    - name: "spot_count"
      expr: COUNT(DISTINCT ad_spot_id)
      comment: "Distinct count of ad spots - volume metric"
    - name: "preempted_spot_count"
      expr: SUM(CASE WHEN preempted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preempted spots - service quality metric"
    - name: "makegood_spot_count"
      expr: SUM(CASE WHEN makegood_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of makegood spots - service recovery metric"
    - name: "bonus_spot_count"
      expr: SUM(CASE WHEN bonus_spot_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bonus spots - value-add metric"
    - name: "avg_attribution_weight"
      expr: AVG(CAST(attribution_weight AS DOUBLE))
      comment: "Average attribution weight for multi-touch attribution - effectiveness metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity metrics tracking deal progression, win rates, and revenue forecasting"
  source: "`vibe_media_broadcasting_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current sales stage of the opportunity (e.g., prospecting, proposal, negotiation, closed)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category for pipeline management (e.g., pipeline, best case, commit, closed)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of deal (e.g., new business, renewal, upsell)"
    - name: "product_category"
      expr: product_category
      comment: "Product category for the opportunity"
    - name: "daypart"
      expr: daypart
      comment: "Target daypart for the opportunity"
    - name: "demographic_target"
      expr: demographic_target
      comment: "Target demographic segment for the opportunity"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the lead (e.g., inbound, outbound, referral)"
    - name: "is_upfront"
      expr: is_upfront
      comment: "Flag indicating whether this is an upfront deal opportunity"
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for opportunity loss if applicable"
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month when the opportunity is expected to close"
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the flight is expected to start"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of opportunities - pipeline value metric"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE) * CAST(probability AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value - forecast accuracy metric"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average opportunity value - deal size metric"
    - name: "avg_probability"
      expr: AVG(CAST(probability AS DOUBLE))
      comment: "Average win probability across opportunities - confidence metric"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate in opportunities - pricing metric"
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average CPRP rate in opportunities - audience pricing metric"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions across opportunities - audience reach commitment"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points - audience reach metric"
    - name: "opportunity_count"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Distinct count of opportunities - pipeline volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal performance metrics tracking proposal value, win rates, approval cycles, and pricing effectiveness"
  source: "`vibe_media_broadcasting_v1`.`sales`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., draft, submitted, approved, rejected)"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g., standard, custom, upfront)"
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic segment for the proposal"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for proposal financial values"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for proposal rejection if applicable"
    - name: "proposal_month"
      expr: DATE_TRUNC('MONTH', proposal_date)
      comment: "Month when the proposal was created"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the proposal was approved"
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the proposed flight starts"
  measures:
    - name: "total_proposed_value"
      expr: SUM(CAST(total_proposed_value AS DOUBLE))
      comment: "Total gross proposed value - top-line proposal metric"
    - name: "total_net_proposed_value"
      expr: SUM(CAST(net_proposed_value AS DOUBLE))
      comment: "Total net proposed value after discounts - realized proposal value"
    - name: "avg_proposed_value"
      expr: AVG(CAST(total_proposed_value AS DOUBLE))
      comment: "Average proposed value per proposal - deal size metric"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage in proposals - pricing pressure metric"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate in proposals - cost of sale metric"
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percent AS DOUBLE))
      comment: "Average win probability across proposals - confidence metric"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average cost per thousand impressions in proposals - pricing metric"
    - name: "total_proposed_impressions"
      expr: SUM(CAST(proposed_impressions AS BIGINT))
      comment: "Total proposed impressions across all proposals - audience reach commitment"
    - name: "total_proposed_grp"
      expr: SUM(CAST(proposed_grp AS DOUBLE))
      comment: "Total proposed gross rating points - audience reach metric"
    - name: "proposal_count"
      expr: COUNT(DISTINCT proposal_id)
      comment: "Distinct count of proposals - volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance metrics tracking budget utilization, audience delivery, and marketing mix effectiveness"
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the sales campaign (e.g., planning, active, completed, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand awareness, direct response, product launch)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for the campaign (e.g., direct, agency, programmatic)"
    - name: "market_type"
      expr: market_type
      comment: "Market type for the campaign (e.g., national, local, regional)"
    - name: "product_brand"
      expr: product_brand
      comment: "Product brand being advertised in the campaign"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the campaign (e.g., high, medium, low)"
    - name: "is_programmatic_enabled"
      expr: programmatic_enabled_flag
      comment: "Flag indicating whether programmatic buying is enabled"
    - name: "is_makegood_eligible"
      expr: makegood_eligible_flag
      comment: "Flag indicating whether the campaign is eligible for makegoods"
    - name: "attribution_model_type"
      expr: attribution_model_type
      comment: "Attribution model used for the campaign (e.g., last-touch, multi-touch, data-driven)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the campaign starts"
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month when the campaign ends"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns - investment metric"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign - campaign size metric"
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across campaigns - pricing efficiency target"
    - name: "avg_target_cprp"
      expr: AVG(CAST(target_cprp AS DOUBLE))
      comment: "Average target CPRP across campaigns - audience pricing target"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions across campaigns - audience reach goal"
    - name: "total_target_grp"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total target gross rating points - audience reach metric"
    - name: "avg_target_reach_percent"
      expr: AVG(CAST(target_reach_percent AS DOUBLE))
      comment: "Average target reach percentage - audience penetration goal"
    - name: "avg_target_frequency"
      expr: AVG(CAST(target_frequency AS DOUBLE))
      comment: "Average target frequency - message repetition goal"
    - name: "avg_mmm_channel_contribution"
      expr: AVG(CAST(mmm_channel_contribution AS DOUBLE))
      comment: "Average marketing mix model channel contribution - attribution effectiveness"
    - name: "avg_mmm_adstock_decay_rate"
      expr: AVG(CAST(mmm_adstock_decay_rate AS DOUBLE))
      comment: "Average adstock decay rate for marketing mix modeling - carryover effect metric"
    - name: "campaign_count"
      expr: COUNT(DISTINCT sales_campaign_id)
      comment: "Distinct count of sales campaigns - volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront deal metrics tracking committed spend, audience guarantees, pricing, and deal performance"
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the upfront deal (e.g., proposed, committed, executed, cancelled)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of upfront deal (e.g., volume, audience guarantee, hybrid)"
    - name: "deal_year"
      expr: deal_year
      comment: "Broadcast year for the upfront deal (e.g., 2024-2025)"
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Pricing basis for the deal (e.g., CPM, CPRP, fixed rate)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for deal financial values"
    - name: "has_makegood_provision"
      expr: makegood_provision_flag
      comment: "Flag indicating whether the deal includes makegood provisions"
    - name: "has_scatter_conversion_rights"
      expr: scatter_conversion_rights
      comment: "Flag indicating whether the deal allows conversion to scatter market"
    - name: "commitment_month"
      expr: DATE_TRUNC('MONTH', commitment_date)
      comment: "Month when the deal was committed"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month when the deal was executed"
  measures:
    - name: "total_committed_spend"
      expr: SUM(CAST(total_committed_spend AS DOUBLE))
      comment: "Total committed spend across all upfront deals - revenue commitment metric"
    - name: "total_proposed_spend"
      expr: SUM(CAST(total_proposed_spend AS DOUBLE))
      comment: "Total proposed spend across all upfront deals - pipeline value metric"
    - name: "avg_committed_spend_per_deal"
      expr: AVG(CAST(total_committed_spend AS DOUBLE))
      comment: "Average committed spend per deal - deal size metric"
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate in upfront deals - pricing metric"
    - name: "avg_cprp_rate"
      expr: AVG(CAST(cprp_rate AS DOUBLE))
      comment: "Average CPRP rate in upfront deals - audience pricing metric"
    - name: "total_audience_guarantee_impressions"
      expr: SUM(CAST(audience_guarantee_impressions AS BIGINT))
      comment: "Total guaranteed impressions across deals - audience delivery commitment"
    - name: "total_audience_guarantee_grp"
      expr: SUM(CAST(audience_guarantee_grp AS DOUBLE))
      comment: "Total guaranteed gross rating points - audience reach commitment"
    - name: "avg_mmm_channel_contribution"
      expr: AVG(CAST(mmm_channel_contribution AS DOUBLE))
      comment: "Average marketing mix model channel contribution - attribution effectiveness"
    - name: "upfront_deal_count"
      expr: COUNT(DISTINCT upfront_deal_id)
      comment: "Distinct count of upfront deals - volume metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertiser relationship metrics tracking credit status, spend tier, and account health"
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertiser`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the advertiser account (e.g., active, inactive, suspended)"
    - name: "annual_spend_tier"
      expr: annual_spend_tier
      comment: "Annual spend tier classification (e.g., platinum, gold, silver, bronze)"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit status of the advertiser (e.g., approved, review, hold)"
    - name: "industry_category"
      expr: industry_category
      comment: "Industry category of the advertiser (e.g., automotive, retail, pharma)"
    - name: "is_political_advertiser"
      expr: is_political_advertiser
      comment: "Flag indicating whether this is a political advertiser"
    - name: "requires_ad_clearance"
      expr: requires_ad_clearance
      comment: "Flag indicating whether ads require clearance approval"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the advertiser (e.g., net 30, net 60)"
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month when the advertiser contract starts"
    - name: "contract_end_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month when the advertiser contract ends"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across all advertisers - credit exposure metric"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per advertiser - credit capacity metric"
    - name: "advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Distinct count of advertisers - customer base metric"
    - name: "active_advertiser_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN advertiser_id END)
      comment: "Count of active advertisers - active customer base metric"
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account relationship metrics tracking credit exposure, revenue potential, and account health"
  source: "`vibe_media_broadcasting_v1`.`sales`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., active, inactive, suspended)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., direct, agency, reseller)"
    - name: "tier"
      expr: tier
      comment: "Account tier classification (e.g., strategic, enterprise, mid-market, SMB)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the account (e.g., AAA, AA, A, BBB)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the account (e.g., automotive, retail, finance)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the account has auto-renewal enabled"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code for billing address"
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month when the account contract starts"
    - name: "contract_end_month"
      expr: DATE_TRUNC('MONTH', contract_end_date)
      comment: "Month when the account contract ends"
  measures:
    - name: "total_annual_revenue_potential"
      expr: SUM(CAST(annual_revenue_potential AS DOUBLE))
      comment: "Total annual revenue potential across all accounts - revenue opportunity metric"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across all accounts - credit exposure metric"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account - credit capacity metric"
    - name: "avg_agency_commission_rate"
      expr: AVG(CAST(agency_commission_rate AS DOUBLE))
      comment: "Average agency commission rate - cost of sale metric"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Distinct count of accounts - customer base metric"
    - name: "active_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN account_id END)
      comment: "Count of active accounts - active customer base metric"
$$;