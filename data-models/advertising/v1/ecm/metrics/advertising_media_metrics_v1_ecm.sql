-- Metric views for domain: media | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core media placement performance metrics tracking contracted vs delivered inventory, rates, and viewability across channels, formats, and publishers"
  source: "`advertising_ecm`.`media`.`media_placement`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of the media placement (active, paused, completed, cancelled)"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of media placement (direct, programmatic, guaranteed, non-guaranteed)"
    - name: "buying_method"
      expr: buying_method
      comment: "Method used to purchase the placement (direct buy, programmatic, auction, fixed price)"
    - name: "channel_type"
      expr: channel_type
      comment: "Type of advertising channel (display, video, social, search, audio)"
    - name: "environment_type"
      expr: environment_type
      comment: "Environment where ad is served (web, mobile app, CTV, in-game)"
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety classification tier for the placement"
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device types targeted by this placement"
    - name: "position_type"
      expr: position_type
      comment: "Ad position type (above fold, below fold, in-stream, pre-roll, mid-roll)"
    - name: "trafficking_status"
      expr: trafficking_status
      comment: "Trafficking workflow status for the placement"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the placement flight begins"
    - name: "flight_quarter"
      expr: DATE_TRUNC('QUARTER', flight_start_date)
      comment: "Quarter when the placement flight begins"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year when the placement flight begins"
    - name: "is_programmatic"
      expr: is_programmatic_eligible
      comment: "Whether the placement is eligible for programmatic buying"
    - name: "is_guaranteed"
      expr: is_guaranteed_inventory
      comment: "Whether the placement has guaranteed inventory delivery"
    - name: "is_makegood"
      expr: is_makegood
      comment: "Whether this placement is a makegood for underdelivery"
  measures:
    - name: "total_placements"
      expr: COUNT(1)
      comment: "Total number of media placements"
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total contracted spend across all placements"
    - name: "total_net_contracted_value"
      expr: SUM(CAST(net_contracted_value AS DOUBLE))
      comment: "Total net contracted spend after agency commissions"
    - name: "avg_contracted_value"
      expr: AVG(CAST(contracted_value AS DOUBLE))
      comment: "Average contracted value per placement"
    - name: "total_contracted_impressions"
      expr: SUM(CAST(contracted_impressions AS BIGINT))
      comment: "Total contracted impressions across all placements"
    - name: "avg_contracted_impressions"
      expr: AVG(CAST(contracted_impressions AS DOUBLE))
      comment: "Average contracted impressions per placement"
    - name: "total_contracted_units"
      expr: SUM(CAST(contracted_units AS BIGINT))
      comment: "Total contracted units (spots, impressions, clicks) across placements"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted rate (CPM, CPC, CPV) across placements"
    - name: "avg_cpm_floor_price"
      expr: AVG(CAST(cpm_floor_price AS DOUBLE))
      comment: "Average CPM floor price across placements"
    - name: "avg_cpm_list_price"
      expr: AVG(CAST(cpm_list_price AS DOUBLE))
      comment: "Average CPM list price across placements"
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across placements"
    - name: "total_grp_contracted"
      expr: SUM(CAST(grp_contracted AS DOUBLE))
      comment: "Total contracted Gross Rating Points across placements"
    - name: "avg_grp_contracted"
      expr: AVG(CAST(grp_contracted AS DOUBLE))
      comment: "Average contracted GRP per placement"
    - name: "avg_viewability_target_pct"
      expr: AVG(CAST(viewability_target_pct AS DOUBLE))
      comment: "Average viewability target percentage across placements"
    - name: "avg_viewability_benchmark_pct"
      expr: AVG(CAST(viewability_rate_benchmark_pct AS DOUBLE))
      comment: "Average viewability benchmark percentage across placements"
    - name: "avg_estimated_reach_pct"
      expr: AVG(CAST(estimated_reach_pct AS DOUBLE))
      comment: "Average estimated reach percentage across placements"
    - name: "total_estimated_monthly_impressions"
      expr: SUM(CAST(estimated_monthly_impressions AS BIGINT))
      comment: "Total estimated monthly impressions across placements"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers across placements"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT ad_channel_id)
      comment: "Number of unique ad channels across placements"
    - name: "distinct_formats"
      expr: COUNT(DISTINCT ad_format_id)
      comment: "Number of unique ad formats across placements"
    - name: "makegood_placement_count"
      expr: SUM(CASE WHEN is_makegood = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements that are makegoods for underdelivery"
    - name: "guaranteed_placement_count"
      expr: SUM(CASE WHEN is_guaranteed_inventory = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements with guaranteed inventory"
    - name: "programmatic_placement_count"
      expr: SUM(CASE WHEN is_programmatic_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements eligible for programmatic buying"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media buy execution and financial performance metrics tracking gross and net spend, units, rates, and reconciliation status"
  source: "`advertising_ecm`.`media`.`buy`"
  dimensions:
    - name: "buy_status"
      expr: buy_status
      comment: "Current status of the media buy (pending, confirmed, executed, cancelled)"
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (upfront, scatter, programmatic, direct)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the buy (scheduled, in-flight, completed, underdelivered)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status between contracted and delivered (pending, matched, discrepancy)"
    - name: "market_type"
      expr: market_type
      comment: "Market type for the buy (national, local, DMA, regional)"
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for rate calculation (CPM, CPC, CPV, flat fee, daypart)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for buy amounts"
    - name: "buy_month"
      expr: DATE_TRUNC('MONTH', buy_date)
      comment: "Month when the buy was executed"
    - name: "buy_quarter"
      expr: DATE_TRUNC('QUARTER', buy_date)
      comment: "Quarter when the buy was executed"
    - name: "buy_year"
      expr: YEAR(buy_date)
      comment: "Year when the buy was executed"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the buy flight begins"
    - name: "is_makegood"
      expr: makegood_flag
      comment: "Whether this buy is a makegood for underdelivery"
    - name: "is_added_value"
      expr: added_value_flag
      comment: "Whether this buy includes added value inventory"
    - name: "upfront_deal_year"
      expr: upfront_deal_year
      comment: "Year of upfront deal if applicable"
  measures:
    - name: "total_buys"
      expr: COUNT(1)
      comment: "Total number of media buys executed"
    - name: "total_gross_buy_amount"
      expr: SUM(CAST(gross_buy_amount AS DOUBLE))
      comment: "Total gross buy amount before commissions and discounts"
    - name: "total_net_buy_amount"
      expr: SUM(CAST(net_buy_amount AS DOUBLE))
      comment: "Total net buy amount after commissions"
    - name: "avg_gross_buy_amount"
      expr: AVG(CAST(gross_buy_amount AS DOUBLE))
      comment: "Average gross buy amount per buy"
    - name: "avg_net_buy_amount"
      expr: AVG(CAST(net_buy_amount AS DOUBLE))
      comment: "Average net buy amount per buy"
    - name: "total_agency_commission"
      expr: SUM(CAST(agency_commission_amount AS DOUBLE))
      comment: "Total agency commission earned across all buys"
    - name: "avg_agency_commission"
      expr: AVG(CAST(agency_commission_amount AS DOUBLE))
      comment: "Average agency commission per buy"
    - name: "total_booked_units"
      expr: SUM(CAST(booked_units AS DOUBLE))
      comment: "Total units booked across all buys (impressions, spots, clicks)"
    - name: "avg_booked_units"
      expr: AVG(CAST(booked_units AS DOUBLE))
      comment: "Average units booked per buy"
    - name: "avg_negotiated_rate"
      expr: AVG(CAST(negotiated_rate AS DOUBLE))
      comment: "Average negotiated rate (CPM, CPC, etc.) across buys"
    - name: "total_authorized_spend_ceiling"
      expr: SUM(CAST(authorized_spend_ceiling AS DOUBLE))
      comment: "Total authorized spend ceiling across all buys"
    - name: "avg_authorized_spend_ceiling"
      expr: AVG(CAST(authorized_spend_ceiling AS DOUBLE))
      comment: "Average authorized spend ceiling per buy"
    - name: "makegood_buy_count"
      expr: SUM(CASE WHEN makegood_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of buys that are makegoods for underdelivery"
    - name: "added_value_buy_count"
      expr: SUM(CASE WHEN added_value_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of buys that include added value inventory"
    - name: "cancelled_buy_count"
      expr: SUM(CASE WHEN cancellation_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of buys that have been cancelled"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers across buys"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT ad_channel_id)
      comment: "Number of unique ad channels across buys"
    - name: "distinct_buyers"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique buyers executing buys"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media plan strategic metrics tracking planned budgets, reach, frequency, GRP/TRP targets, and approval status across campaigns"
  source: "`advertising_ecm`.`media`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the media plan (draft, submitted, approved, rejected, active)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of media plan (annual, campaign, tactical, test)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the plan"
    - name: "buying_approach"
      expr: buying_approach
      comment: "Buying approach for the plan (upfront, scatter, programmatic, hybrid)"
    - name: "primary_kpi"
      expr: primary_kpi
      comment: "Primary KPI the plan is optimized for (reach, frequency, conversions, awareness)"
    - name: "secondary_kpi"
      expr: secondary_kpi
      comment: "Secondary KPI for plan evaluation"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the plan (national, regional, local, DMA)"
    - name: "channel_mix"
      expr: channel_mix
      comment: "Mix of channels in the plan (TV, digital, social, radio, OOH)"
    - name: "daypart_strategy"
      expr: daypart_strategy
      comment: "Daypart strategy for the plan (prime, daytime, late night, ROS)"
    - name: "target_gender"
      expr: target_gender
      comment: "Target gender demographic for the plan"
    - name: "target_age_range"
      expr: target_age_range
      comment: "Target age range demographic for the plan"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for plan budgets"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the plan flight begins"
    - name: "flight_quarter"
      expr: DATE_TRUNC('QUARTER', flight_start_date)
      comment: "Quarter when the plan flight begins"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year when the plan flight begins"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month when the plan was approved"
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Whether the plan includes programmatic buying"
    - name: "is_addressable"
      expr: is_addressable
      comment: "Whether the plan uses addressable/targeted media"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of media plans"
    - name: "total_planned_budget"
      expr: SUM(CAST(total_planned_budget AS DOUBLE))
      comment: "Total planned budget across all plans"
    - name: "total_net_budget"
      expr: SUM(CAST(net_budget AS DOUBLE))
      comment: "Total net budget after commissions across all plans"
    - name: "avg_planned_budget"
      expr: AVG(CAST(total_planned_budget AS DOUBLE))
      comment: "Average planned budget per plan"
    - name: "avg_net_budget"
      expr: AVG(CAST(net_budget AS DOUBLE))
      comment: "Average net budget per plan"
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across plans"
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total Gross Rating Points target across all plans"
    - name: "avg_grp_target"
      expr: AVG(CAST(grp_target AS DOUBLE))
      comment: "Average GRP target per plan"
    - name: "total_trp_target"
      expr: SUM(CAST(trp_target AS DOUBLE))
      comment: "Total Target Rating Points target across all plans"
    - name: "avg_trp_target"
      expr: AVG(CAST(trp_target AS DOUBLE))
      comment: "Average TRP target per plan"
    - name: "avg_reach_target_pct"
      expr: AVG(CAST(reach_target_pct AS DOUBLE))
      comment: "Average reach target percentage across plans"
    - name: "avg_frequency_target"
      expr: AVG(CAST(frequency_target AS DOUBLE))
      comment: "Average frequency target across plans"
    - name: "avg_target_cpm"
      expr: AVG(CAST(target_cpm AS DOUBLE))
      comment: "Average target CPM across plans"
    - name: "approved_plan_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of plans that have been approved"
    - name: "programmatic_plan_count"
      expr: SUM(CASE WHEN is_programmatic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans that include programmatic buying"
    - name: "addressable_plan_count"
      expr: SUM(CASE WHEN is_addressable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans using addressable media"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers across plans"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns across plans"
    - name: "distinct_planners"
      expr: COUNT(DISTINCT worker_id)
      comment: "Number of unique planners creating plans"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular media plan line-item metrics tracking planned spend, impressions, GRP/TRP, reach, frequency, and CPM by channel, format, and market"
  source: "`advertising_ecm`.`media`.`plan_line`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan line"
    - name: "buying_status"
      expr: buying_status
      comment: "Buying execution status of the plan line"
    - name: "buying_type"
      expr: buying_type
      comment: "Type of buying for this line (direct, programmatic, upfront, scatter)"
    - name: "media_type"
      expr: media_type
      comment: "Media type for the line (TV, digital, social, radio, print, OOH)"
    - name: "media_subtype"
      expr: media_subtype
      comment: "Media subtype for more granular classification"
    - name: "market"
      expr: market
      comment: "Market or DMA for the plan line"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the plan line"
    - name: "daypart"
      expr: daypart
      comment: "Daypart for the plan line (prime, daytime, late night, ROS)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for plan line spend"
    - name: "publisher_name"
      expr: publisher_name
      comment: "Publisher or network name for the plan line"
    - name: "vehicle_name"
      expr: vehicle_name
      comment: "Vehicle or program name for the plan line"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the plan line flight begins"
    - name: "flight_quarter"
      expr: DATE_TRUNC('QUARTER', flight_start_date)
      comment: "Quarter when the plan line flight begins"
    - name: "flight_year"
      expr: YEAR(flight_start_date)
      comment: "Year when the plan line flight begins"
    - name: "is_bonus"
      expr: is_bonus
      comment: "Whether this line is bonus inventory"
    - name: "is_makegood"
      expr: is_makegood
      comment: "Whether this line is a makegood for underdelivery"
  measures:
    - name: "total_plan_lines"
      expr: COUNT(1)
      comment: "Total number of plan lines"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend AS DOUBLE))
      comment: "Total planned spend across all plan lines"
    - name: "total_planned_net_spend"
      expr: SUM(CAST(planned_net_spend AS DOUBLE))
      comment: "Total planned net spend after commissions across all plan lines"
    - name: "avg_planned_spend"
      expr: AVG(CAST(planned_spend AS DOUBLE))
      comment: "Average planned spend per plan line"
    - name: "avg_planned_net_spend"
      expr: AVG(CAST(planned_net_spend AS DOUBLE))
      comment: "Average planned net spend per plan line"
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS BIGINT))
      comment: "Total planned impressions across all plan lines"
    - name: "avg_planned_impressions"
      expr: AVG(CAST(planned_impressions AS DOUBLE))
      comment: "Average planned impressions per plan line"
    - name: "total_planned_units"
      expr: SUM(CAST(planned_units AS DOUBLE))
      comment: "Total planned units (spots, impressions, clicks) across plan lines"
    - name: "avg_planned_units"
      expr: AVG(CAST(planned_units AS DOUBLE))
      comment: "Average planned units per plan line"
    - name: "total_planned_grps"
      expr: SUM(CAST(planned_grps AS DOUBLE))
      comment: "Total planned Gross Rating Points across all plan lines"
    - name: "avg_planned_grps"
      expr: AVG(CAST(planned_grps AS DOUBLE))
      comment: "Average planned GRP per plan line"
    - name: "total_planned_trps"
      expr: SUM(CAST(planned_trps AS DOUBLE))
      comment: "Total planned Target Rating Points across all plan lines"
    - name: "avg_planned_trps"
      expr: AVG(CAST(planned_trps AS DOUBLE))
      comment: "Average planned TRP per plan line"
    - name: "avg_planned_reach_pct"
      expr: AVG(CAST(planned_reach_pct AS DOUBLE))
      comment: "Average planned reach percentage across plan lines"
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned frequency across plan lines"
    - name: "avg_planned_cpm"
      expr: AVG(CAST(planned_cpm AS DOUBLE))
      comment: "Average planned CPM across plan lines"
    - name: "avg_planned_cpc"
      expr: AVG(CAST(planned_cpc AS DOUBLE))
      comment: "Average planned CPC across plan lines"
    - name: "avg_planned_cpa"
      expr: AVG(CAST(planned_cpa AS DOUBLE))
      comment: "Average planned CPA across plan lines"
    - name: "avg_agency_commission_pct"
      expr: AVG(CAST(agency_commission_pct AS DOUBLE))
      comment: "Average agency commission percentage across plan lines"
    - name: "bonus_line_count"
      expr: SUM(CASE WHEN is_bonus = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plan lines that are bonus inventory"
    - name: "makegood_line_count"
      expr: SUM(CASE WHEN is_makegood = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plan lines that are makegoods"
    - name: "distinct_plans"
      expr: COUNT(DISTINCT plan_id)
      comment: "Number of unique plans across plan lines"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT ad_channel_id)
      comment: "Number of unique ad channels across plan lines"
    - name: "distinct_formats"
      expr: COUNT(DISTINCT ad_format_id)
      comment: "Number of unique ad formats across plan lines"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns across plan lines"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_programmatic_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programmatic deal performance metrics tracking deal budgets, impression commitments, floor CPM, and deal status across SSPs and DSPs"
  source: "`advertising_ecm`.`media`.`programmatic_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the programmatic deal (active, paused, expired, cancelled)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of programmatic deal (PMP, PG, preferred, open auction)"
    - name: "dsp_platform"
      expr: dsp_platform
      comment: "Demand-side platform used for the deal"
    - name: "environment_type"
      expr: environment_type
      comment: "Environment type for the deal (web, mobile app, CTV, in-game)"
    - name: "brand_safety_tier"
      expr: brand_safety_tier
      comment: "Brand safety tier classification for the deal"
    - name: "rtb_bid_strategy"
      expr: rtb_bid_strategy
      comment: "Real-time bidding strategy for the deal"
    - name: "geo_targeting"
      expr: geo_targeting
      comment: "Geographic targeting parameters for the deal"
    - name: "frequency_cap"
      expr: frequency_cap
      comment: "Frequency cap setting for the deal"
    - name: "frequency_cap_period"
      expr: frequency_cap_period
      comment: "Frequency cap period (daily, weekly, monthly, lifetime)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for deal budgets and rates"
    - name: "deal_source_system"
      expr: deal_source_system
      comment: "Source system where the deal was created"
    - name: "deal_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when the deal starts"
    - name: "deal_quarter"
      expr: DATE_TRUNC('QUARTER', start_date)
      comment: "Quarter when the deal starts"
    - name: "deal_year"
      expr: YEAR(start_date)
      comment: "Year when the deal starts"
    - name: "is_closed_loop"
      expr: closed_loop_measurement
      comment: "Whether the deal has closed-loop measurement enabled"
    - name: "is_shopper_data_enabled"
      expr: shopper_data_enabled
      comment: "Whether the deal uses shopper data for targeting"
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Total number of programmatic deals"
    - name: "total_deal_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all programmatic deals"
    - name: "avg_deal_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per programmatic deal"
    - name: "total_impression_commitment"
      expr: SUM(CAST(impression_commitment AS BIGINT))
      comment: "Total impression commitment across all deals"
    - name: "avg_impression_commitment"
      expr: AVG(CAST(impression_commitment AS DOUBLE))
      comment: "Average impression commitment per deal"
    - name: "avg_floor_cpm"
      expr: AVG(CAST(floor_cpm AS DOUBLE))
      comment: "Average floor CPM across programmatic deals"
    - name: "avg_viewability_threshold_pct"
      expr: AVG(CAST(viewability_threshold_pct AS DOUBLE))
      comment: "Average viewability threshold percentage across deals"
    - name: "closed_loop_deal_count"
      expr: SUM(CASE WHEN closed_loop_measurement = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deals with closed-loop measurement enabled"
    - name: "shopper_data_deal_count"
      expr: SUM(CASE WHEN shopper_data_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of deals using shopper data for targeting"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers across deals"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers across deals"
    - name: "distinct_ssp_platforms"
      expr: COUNT(DISTINCT ssp_platform_id)
      comment: "Number of unique SSP platforms across deals"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns across deals"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_insertion_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insertion order financial and execution metrics tracking authorized spend, net spend, guaranteed impressions, and IO status across publishers and campaigns"
  source: "`advertising_ecm`.`media`.`media_insertion_order`"
  dimensions:
    - name: "io_status"
      expr: io_status
      comment: "Current status of the insertion order (draft, pending, approved, active, completed, cancelled)"
    - name: "io_type"
      expr: io_type
      comment: "Type of insertion order (standard, programmatic guaranteed, preferred deal)"
    - name: "buying_method"
      expr: buying_method
      comment: "Buying method for the IO (direct, programmatic, auction, fixed price)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the IO (CPM, CPC, CPV, CPA, flat fee)"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle for the IO (monthly, quarterly, upon completion, milestone)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the IO (net 30, net 60, net 90, prepaid)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for IO amounts"
    - name: "cancellation_policy"
      expr: cancellation_policy
      comment: "Cancellation policy terms for the IO"
    - name: "makegood_policy"
      expr: makegood_policy
      comment: "Makegood policy for underdelivery"
    - name: "brand_safety_requirements"
      expr: brand_safety_requirements
      comment: "Brand safety requirements specified in the IO"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month when the IO was executed"
    - name: "execution_quarter"
      expr: DATE_TRUNC('QUARTER', execution_date)
      comment: "Quarter when the IO was executed"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year when the IO was executed"
    - name: "flight_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month when the IO flight begins"
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Whether the IO is for programmatic buying"
  measures:
    - name: "total_insertion_orders"
      expr: COUNT(1)
      comment: "Total number of insertion orders"
    - name: "total_authorized_spend"
      expr: SUM(CAST(authorized_spend_amount AS DOUBLE))
      comment: "Total authorized spend across all insertion orders"
    - name: "total_net_spend"
      expr: SUM(CAST(net_spend_amount AS DOUBLE))
      comment: "Total net spend after commissions across all insertion orders"
    - name: "avg_authorized_spend"
      expr: AVG(CAST(authorized_spend_amount AS DOUBLE))
      comment: "Average authorized spend per insertion order"
    - name: "avg_net_spend"
      expr: AVG(CAST(net_spend_amount AS DOUBLE))
      comment: "Average net spend per insertion order"
    - name: "total_agency_commission"
      expr: SUM(CAST(agency_commission_amount AS DOUBLE))
      comment: "Total agency commission across all insertion orders"
    - name: "avg_agency_commission"
      expr: AVG(CAST(agency_commission_amount AS DOUBLE))
      comment: "Average agency commission per insertion order"
    - name: "total_guaranteed_impressions"
      expr: SUM(CAST(guaranteed_impressions AS BIGINT))
      comment: "Total guaranteed impressions across all insertion orders"
    - name: "avg_guaranteed_impressions"
      expr: AVG(CAST(guaranteed_impressions AS DOUBLE))
      comment: "Average guaranteed impressions per insertion order"
    - name: "programmatic_io_count"
      expr: SUM(CASE WHEN is_programmatic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of insertion orders for programmatic buying"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers across insertion orders"
    - name: "distinct_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of unique advertisers across insertion orders"
    - name: "distinct_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of unique campaigns across insertion orders"
    - name: "distinct_channels"
      expr: COUNT(DISTINCT ad_channel_id)
      comment: "Number of unique ad channels across insertion orders"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_audience_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience measurement and rating metrics tracking average audience, cumulative audience, rating values, GRP/TRP contribution, and share across demographics and dayparts"
  source: "`advertising_ecm`.`media`.`audience_rating`"
  dimensions:
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the audience rating (final, preliminary, estimated, revised)"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the audience measurement (Nielsen, Comscore, internal panel)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used for audience measurement (panel, census, modeled)"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type for the rating (linear TV, streaming, digital, radio)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Vehicle type (program, network, website, app)"
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code for the rating"
    - name: "daypart_name"
      expr: daypart_name
      comment: "Daypart name (prime, daytime, late night, early morning)"
    - name: "gender_segment"
      expr: gender_segment
      comment: "Gender segment for the rating (male, female, all)"
    - name: "age_range_low"
      expr: age_range_low
      comment: "Lower bound of age range for the rating"
    - name: "age_range_high"
      expr: age_range_high
      comment: "Upper bound of age range for the rating"
    - name: "geography_type"
      expr: geography_type
      comment: "Type of geography (national, DMA, local, regional)"
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code for the rating"
    - name: "geography_name"
      expr: geography_name
      comment: "Geographic name for the rating"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month of the measurement period start"
    - name: "measurement_quarter"
      expr: DATE_TRUNC('QUARTER', measurement_period_start)
      comment: "Quarter of the measurement period start"
    - name: "measurement_year"
      expr: YEAR(measurement_period_start)
      comment: "Year of the measurement period start"
    - name: "is_mrc_accredited"
      expr: mrc_accredited
      comment: "Whether the measurement is MRC accredited"
    - name: "is_low_reliability"
      expr: is_low_reliability
      comment: "Whether the rating has low reliability due to small sample size"
  measures:
    - name: "total_ratings"
      expr: COUNT(1)
      comment: "Total number of audience ratings"
    - name: "total_average_audience"
      expr: SUM(CAST(average_audience AS BIGINT))
      comment: "Total average audience across all ratings"
    - name: "avg_average_audience"
      expr: AVG(CAST(average_audience AS DOUBLE))
      comment: "Average audience size per rating"
    - name: "total_cumulative_audience"
      expr: SUM(CAST(cumulative_audience AS BIGINT))
      comment: "Total cumulative audience (reach) across all ratings"
    - name: "avg_cumulative_audience"
      expr: AVG(CAST(cumulative_audience AS DOUBLE))
      comment: "Average cumulative audience per rating"
    - name: "avg_rating_value"
      expr: AVG(CAST(rating_value AS DOUBLE))
      comment: "Average rating value (percentage of universe) across ratings"
    - name: "avg_share_value"
      expr: AVG(CAST(share_value AS DOUBLE))
      comment: "Average share value (percentage of viewing) across ratings"
    - name: "total_grp_contribution"
      expr: SUM(CAST(grp_contribution AS DOUBLE))
      comment: "Total Gross Rating Points contribution across all ratings"
    - name: "avg_grp_contribution"
      expr: AVG(CAST(grp_contribution AS DOUBLE))
      comment: "Average GRP contribution per rating"
    - name: "total_trp_contribution"
      expr: SUM(CAST(trp_contribution AS DOUBLE))
      comment: "Total Target Rating Points contribution across all ratings"
    - name: "avg_trp_contribution"
      expr: AVG(CAST(trp_contribution AS DOUBLE))
      comment: "Average TRP contribution per rating"
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS BIGINT))
      comment: "Total universe estimate (population base) across all ratings"
    - name: "avg_universe_estimate"
      expr: AVG(CAST(universe_estimate AS DOUBLE))
      comment: "Average universe estimate per rating"
    - name: "avg_confidence_interval"
      expr: AVG(CAST(confidence_interval AS DOUBLE))
      comment: "Average confidence interval across ratings"
    - name: "mrc_accredited_rating_count"
      expr: SUM(CASE WHEN mrc_accredited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ratings that are MRC accredited"
    - name: "low_reliability_rating_count"
      expr: SUM(CASE WHEN is_low_reliability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ratings flagged as low reliability"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers across ratings"
    - name: "distinct_audience_segments"
      expr: COUNT(DISTINCT audience_segment_id)
      comment: "Number of unique audience segments across ratings"
$$;


CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`media_publisher_property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Publisher property inventory and quality metrics tracking monthly impressions, unique visitors, CPM rates, viewability benchmarks, and brand safety classification"
  source: "`advertising_ecm`.`media`.`publisher_property`"
  dimensions:
    - name: "property_status"
      expr: property_status
      comment: "Current status of the publisher property (active, inactive, pending review, suspended)"
    - name: "property_type"
      expr: property_type
      comment: "Type of publisher property (website, mobile app, CTV app, game)"
    - name: "content_vertical"
      expr: content_vertical
      comment: "Content vertical or category for the property"
    - name: "iab_content_category"
      expr: iab_content_category
      comment: "IAB content category classification"
    - name: "brand_safety_classification"
      expr: brand_safety_classification
      comment: "Brand safety classification tier for the property"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the property"
    - name: "language_code"
      expr: language_code
      comment: "Primary language code for the property"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the property (national, regional, local, global)"
    - name: "ad_server_platform"
      expr: ad_server_platform
      comment: "Ad server platform used by the property"
    - name: "video_player_type"
      expr: video_player_type
      comment: "Video player type for video properties"
    - name: "vast_version"
      expr: vast_version
      comment: "VAST version supported by the property"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for property rates"
    - name: "is_programmatic_enabled"
      expr: programmatic_enabled
      comment: "Whether the property supports programmatic buying"
    - name: "is_rtb_enabled"
      expr: rtb_enabled
      comment: "Whether the property supports real-time bidding"
    - name: "is_pmp_deals_available"
      expr: pmp_deals_available
      comment: "Whether the property offers private marketplace deals"
    - name: "is_mrc_accredited"
      expr: mrc_accredited
      comment: "Whether the property is MRC accredited"
    - name: "is_tag_certified"
      expr: tag_certified
      comment: "Whether the property is TAG certified for brand safety"
    - name: "is_vpaid_supported"
      expr: vpaid_supported
      comment: "Whether the property supports VPAID"
  measures:
    - name: "total_properties"
      expr: COUNT(1)
      comment: "Total number of publisher properties"
    - name: "total_monthly_impressions"
      expr: SUM(CAST(monthly_impressions AS BIGINT))
      comment: "Total monthly impressions available across all properties"
    - name: "avg_monthly_impressions"
      expr: AVG(CAST(monthly_impressions AS DOUBLE))
      comment: "Average monthly impressions per property"
    - name: "total_monthly_unique_visitors"
      expr: SUM(CAST(monthly_unique_visitors AS BIGINT))
      comment: "Total monthly unique visitors across all properties"
    - name: "avg_monthly_unique_visitors"
      expr: AVG(CAST(monthly_unique_visitors AS DOUBLE))
      comment: "Average monthly unique visitors per property"
    - name: "avg_average_cpm"
      expr: AVG(CAST(average_cpm AS DOUBLE))
      comment: "Average CPM rate across properties"
    - name: "avg_floor_cpm"
      expr: AVG(CAST(floor_cpm AS DOUBLE))
      comment: "Average floor CPM across properties"
    - name: "avg_viewability_benchmark_pct"
      expr: AVG(CAST(viewability_benchmark_pct AS DOUBLE))
      comment: "Average viewability benchmark percentage across properties"
    - name: "avg_ad_fraud_risk_score"
      expr: AVG(CAST(ad_fraud_risk_score AS DOUBLE))
      comment: "Average ad fraud risk score across properties"
    - name: "programmatic_enabled_count"
      expr: SUM(CASE WHEN programmatic_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties with programmatic buying enabled"
    - name: "rtb_enabled_count"
      expr: SUM(CASE WHEN rtb_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties with RTB enabled"
    - name: "pmp_deals_available_count"
      expr: SUM(CASE WHEN pmp_deals_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties offering PMP deals"
    - name: "mrc_accredited_count"
      expr: SUM(CASE WHEN mrc_accredited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties that are MRC accredited"
    - name: "tag_certified_count"
      expr: SUM(CASE WHEN tag_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties that are TAG certified"
    - name: "vpaid_supported_count"
      expr: SUM(CASE WHEN vpaid_supported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of properties supporting VPAID"
    - name: "distinct_publishers"
      expr: COUNT(DISTINCT publisher_id)
      comment: "Number of unique publishers across properties"
$$;
