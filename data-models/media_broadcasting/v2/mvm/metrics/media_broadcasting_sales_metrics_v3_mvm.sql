-- Metric views for domain: sales | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 21:13:02

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Order business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order`"
  dimensions:
    - name: "Affidavit Required Flag"
      expr: affidavit_required_flag
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart Mix"
      expr: daypart_mix
    - name: "Flight End Date"
      expr: flight_end_date
    - name: "Flight Start Date"
      expr: flight_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Makegood Policy"
      expr: makegood_policy
    - name: "Order Notes"
      expr: order_notes
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Political Ad Flag"
      expr: political_ad_flag
    - name: "Product Category"
      expr: product_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Order"
      expr: COUNT(DISTINCT ad_order_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Contracted Cpm"
      expr: SUM(contracted_cpm)
    - name: "Average Contracted Cpm"
      expr: AVG(contracted_cpm)
    - name: "Total Contracted Cprp"
      expr: SUM(contracted_cprp)
    - name: "Average Contracted Cprp"
      expr: AVG(contracted_cprp)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Net Order Value"
      expr: SUM(net_order_value)
    - name: "Average Net Order Value"
      expr: AVG(net_order_value)
    - name: "Total Target Grp"
      expr: SUM(target_grp)
    - name: "Average Target Grp"
      expr: AVG(target_grp)
    - name: "Total Target Trp"
      expr: SUM(target_trp)
    - name: "Average Target Trp"
      expr: AVG(target_trp)
    - name: "Total Total Contracted Value"
      expr: SUM(total_contracted_value)
    - name: "Average Total Contracted Value"
      expr: AVG(total_contracted_value)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Order Line business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_order_line`"
  dimensions:
    - name: "Actual Spots Aired"
      expr: actual_spots_aired
    - name: "Competitive Separation Category"
      expr: competitive_separation_category
    - name: "Contracted Spots"
      expr: contracted_spots
    - name: "Copy Split Rule"
      expr: copy_split_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Flight End Date"
      expr: flight_end_date
    - name: "Flight Start Date"
      expr: flight_start_date
    - name: "Inventory Type"
      expr: inventory_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Position Preference"
      expr: position_preference
    - name: "Preemption Priority"
      expr: preemption_priority
    - name: "Revenue Recognition Date"
      expr: revenue_recognition_date
    - name: "Rotation Instructions"
      expr: rotation_instructions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Order Line"
      expr: COUNT(DISTINCT ad_order_line_id)
    - name: "Total Actual Grp Delivered"
      expr: SUM(actual_grp_delivered)
    - name: "Average Actual Grp Delivered"
      expr: AVG(actual_grp_delivered)
    - name: "Total Actual Impressions Delivered"
      expr: SUM(actual_impressions_delivered)
    - name: "Average Actual Impressions Delivered"
      expr: AVG(actual_impressions_delivered)
    - name: "Total Contracted Grp"
      expr: SUM(contracted_grp)
    - name: "Average Contracted Grp"
      expr: AVG(contracted_grp)
    - name: "Total Contracted Impressions"
      expr: SUM(contracted_impressions)
    - name: "Average Contracted Impressions"
      expr: AVG(contracted_impressions)
    - name: "Total Contracted Trp"
      expr: SUM(contracted_trp)
    - name: "Average Contracted Trp"
      expr: AVG(contracted_trp)
    - name: "Total Cpm"
      expr: SUM(cpm)
    - name: "Average Cpm"
      expr: AVG(cpm)
    - name: "Total Cprp"
      expr: SUM(cprp)
    - name: "Average Cprp"
      expr: AVG(cprp)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Line Total Amount"
      expr: SUM(line_total_amount)
    - name: "Average Line Total Amount"
      expr: AVG(line_total_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_pod`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Pod business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_pod`"
  dimensions:
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Alcohol Ad Allowed Flag"
      expr: alcohol_ad_allowed_flag
    - name: "Blackout Flag"
      expr: blackout_flag
    - name: "Break Position"
      expr: break_position
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dai Enabled Flag"
      expr: dai_enabled_flag
    - name: "Daypart"
      expr: daypart
    - name: "Estimated Reach"
      expr: estimated_reach
    - name: "Geographic Market Code"
      expr: geographic_market_code
    - name: "Inventory Class"
      expr: inventory_class
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Spot Count"
      expr: max_spot_count
    - name: "Notes"
      expr: notes
    - name: "Platform Type"
      expr: platform_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Pod"
      expr: COUNT(DISTINCT ad_pod_id)
    - name: "Total Estimated Grp"
      expr: SUM(estimated_grp)
    - name: "Average Estimated Grp"
      expr: AVG(estimated_grp)
    - name: "Total Pod Rate Card Cpm"
      expr: SUM(pod_rate_card_cpm)
    - name: "Average Pod Rate Card Cpm"
      expr: AVG(pod_rate_card_cpm)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_ad_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad Spot business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`ad_spot`"
  dimensions:
    - name: "Actual Air Time"
      expr: actual_air_time
    - name: "Ad Pod Position"
      expr: ad_pod_position
    - name: "Affidavit Reference"
      expr: affidavit_reference
    - name: "Billing Status"
      expr: billing_status
    - name: "Bonus Spot Flag"
      expr: bonus_spot_flag
    - name: "Channel Code"
      expr: channel_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dai Flag"
      expr: dai_flag
    - name: "Daypart"
      expr: daypart
    - name: "Makegood Flag"
      expr: makegood_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Preempted Flag"
      expr: preempted_flag
    - name: "Preemption Reason"
      expr: preemption_reason
    - name: "Rotation Pattern"
      expr: rotation_pattern
    - name: "Scheduled Air Date"
      expr: scheduled_air_date
    - name: "Scheduled Air Time"
      expr: scheduled_air_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ad Spot"
      expr: COUNT(DISTINCT ad_spot_id)
    - name: "Total Cpm Amount"
      expr: SUM(cpm_amount)
    - name: "Average Cpm Amount"
      expr: AVG(cpm_amount)
    - name: "Total Grp Value"
      expr: SUM(grp_value)
    - name: "Average Grp Value"
      expr: AVG(grp_value)
    - name: "Total Impressions Delivered"
      expr: SUM(impressions_delivered)
    - name: "Average Impressions Delivered"
      expr: AVG(impressions_delivered)
    - name: "Total Spot Rate Amount"
      expr: SUM(spot_rate_amount)
    - name: "Average Spot Rate Amount"
      expr: AVG(spot_rate_amount)
    - name: "Total Trp Value"
      expr: SUM(trp_value)
    - name: "Average Trp Value"
      expr: AVG(trp_value)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertiser business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`advertiser`"
  dimensions:
    - name: "Account Status"
      expr: account_status
    - name: "Annual Spend Tier"
      expr: annual_spend_tier
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Status"
      expr: credit_status
    - name: "Industry Category"
      expr: industry_category
    - name: "Is Political Advertiser"
      expr: is_political_advertiser
    - name: "Legal Name"
      expr: legal_name
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advertiser"
      expr: COUNT(DISTINCT advertiser_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`campaign`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Code"
      expr: code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Makegood Eligible Flag"
      expr: makegood_eligible_flag
    - name: "Market Type"
      expr: market_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Name"
      expr: name
    - name: "Notes"
      expr: notes
    - name: "Priority Level"
      expr: priority_level
    - name: "Product Brand"
      expr: product_brand
    - name: "Sales Channel"
      expr: sales_channel
    - name: "Salesforce Campaign Reference"
      expr: salesforce_campaign_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign"
      expr: COUNT(DISTINCT campaign_id)
    - name: "Total Target Cpm"
      expr: SUM(target_cpm)
    - name: "Average Target Cpm"
      expr: AVG(target_cpm)
    - name: "Total Target Cprp"
      expr: SUM(target_cprp)
    - name: "Average Target Cprp"
      expr: AVG(target_cprp)
    - name: "Total Target Frequency"
      expr: SUM(target_frequency)
    - name: "Average Target Frequency"
      expr: AVG(target_frequency)
    - name: "Total Target Grp"
      expr: SUM(target_grp)
    - name: "Average Target Grp"
      expr: AVG(target_grp)
    - name: "Total Target Impressions"
      expr: SUM(target_impressions)
    - name: "Average Target Impressions"
      expr: AVG(target_impressions)
    - name: "Total Target Reach Percent"
      expr: SUM(target_reach_percent)
    - name: "Average Target Reach Percent"
      expr: AVG(target_reach_percent)
    - name: "Total Target Sov Percent"
      expr: SUM(target_sov_percent)
    - name: "Average Target Sov Percent"
      expr: AVG(target_sov_percent)
    - name: "Total Target Trp"
      expr: SUM(target_trp)
    - name: "Average Target Trp"
      expr: AVG(target_trp)
    - name: "Total Total Budget Amount"
      expr: SUM(total_budget_amount)
    - name: "Average Total Budget Amount"
      expr: AVG(total_budget_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_impression_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Impression Delivery business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`impression_delivery`"
  dimensions:
    - name: "Ad Pod Position"
      expr: ad_pod_position
    - name: "Browser Type"
      expr: browser_type
    - name: "Cdn Delivery Confirmed Flag"
      expr: cdn_delivery_confirmed_flag
    - name: "Cdn Node Reference"
      expr: cdn_node_reference
    - name: "Channel Name"
      expr: channel_name
    - name: "Content Genre"
      expr: content_genre
    - name: "Content Rating"
      expr: content_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Impression Tracking Url"
      expr: impression_tracking_url
    - name: "Insertion Status"
      expr: insertion_status
    - name: "Insertion Type"
      expr: insertion_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Impression Delivery"
      expr: COUNT(DISTINCT impression_delivery_id)
    - name: "Total Click Through Rate Percent"
      expr: SUM(click_through_rate_percent)
    - name: "Average Click Through Rate Percent"
      expr: AVG(click_through_rate_percent)
    - name: "Total Click Throughs"
      expr: SUM(click_throughs)
    - name: "Average Click Throughs"
      expr: AVG(click_throughs)
    - name: "Total Completed Views"
      expr: SUM(completed_views)
    - name: "Average Completed Views"
      expr: AVG(completed_views)
    - name: "Total Completion Rate Percent"
      expr: SUM(completion_rate_percent)
    - name: "Average Completion Rate Percent"
      expr: AVG(completion_rate_percent)
    - name: "Total Cpm Realized"
      expr: SUM(cpm_realized)
    - name: "Average Cpm Realized"
      expr: AVG(cpm_realized)
    - name: "Total Revenue Amount"
      expr: SUM(revenue_amount)
    - name: "Average Revenue Amount"
      expr: AVG(revenue_amount)
    - name: "Total Total Impressions Served"
      expr: SUM(total_impressions_served)
    - name: "Average Total Impressions Served"
      expr: AVG(total_impressions_served)
    - name: "Total Viewability Rate Percent"
      expr: SUM(viewability_rate_percent)
    - name: "Average Viewability Rate Percent"
      expr: AVG(viewability_rate_percent)
    - name: "Total Viewable Impressions"
      expr: SUM(viewable_impressions)
    - name: "Average Viewable Impressions"
      expr: AVG(viewable_impressions)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proposal business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`proposal`"
  dimensions:
    - name: "Accepted Timestamp"
      expr: accepted_timestamp
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audience Guarantee Flag"
      expr: audience_guarantee_flag
    - name: "Campaign End Date"
      expr: campaign_end_date
    - name: "Campaign Start Date"
      expr: campaign_start_date
    - name: "Cancellation Terms"
      expr: cancellation_terms
    - name: "Channel Mix Summary"
      expr: channel_mix_summary
    - name: "Competitive Situation"
      expr: competitive_situation
    - name: "Content Adjacency Preferences"
      expr: content_adjacency_preferences
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart Mix"
      expr: daypart_mix
    - name: "Daypart Mix Summary"
      expr: daypart_mix_summary
    - name: "Demographic Target"
      expr: demographic_target
    - name: "Description"
      expr: description
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Proposal"
      expr: COUNT(DISTINCT proposal_id)
    - name: "Total Agency Commission Percentage"
      expr: SUM(agency_commission_percentage)
    - name: "Average Agency Commission Percentage"
      expr: AVG(agency_commission_percentage)
    - name: "Total Cpm"
      expr: SUM(cpm)
    - name: "Average Cpm"
      expr: AVG(cpm)
    - name: "Total Cprp"
      expr: SUM(cprp)
    - name: "Average Cprp"
      expr: AVG(cprp)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Guaranteed Impressions"
      expr: SUM(guaranteed_impressions)
    - name: "Average Guaranteed Impressions"
      expr: AVG(guaranteed_impressions)
    - name: "Total Net Proposed Value"
      expr: SUM(net_proposed_value)
    - name: "Average Net Proposed Value"
      expr: AVG(net_proposed_value)
    - name: "Total Proposed Frequency"
      expr: SUM(proposed_frequency)
    - name: "Average Proposed Frequency"
      expr: AVG(proposed_frequency)
    - name: "Total Proposed Grp"
      expr: SUM(proposed_grp)
    - name: "Average Proposed Grp"
      expr: AVG(proposed_grp)
    - name: "Total Proposed Impressions"
      expr: SUM(proposed_impressions)
    - name: "Average Proposed Impressions"
      expr: AVG(proposed_impressions)
    - name: "Total Proposed Reach"
      expr: SUM(proposed_reach)
    - name: "Average Proposed Reach"
      expr: AVG(proposed_reach)
    - name: "Total Proposed Trp"
      expr: SUM(proposed_trp)
    - name: "Average Proposed Trp"
      expr: AVG(proposed_trp)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_sales_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Account business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_account`"
  dimensions:
    - name: "Account Name"
      expr: account_name
    - name: "Account Status"
      expr: account_status
    - name: "Account Tier"
      expr: account_tier
    - name: "Account Type"
      expr: account_type
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Contact Email"
      expr: billing_contact_email
    - name: "Billing Contact Name"
      expr: billing_contact_name
    - name: "Billing Contact Phone"
      expr: billing_contact_phone
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Blackout Restrictions"
      expr: blackout_restrictions
    - name: "Contract End Date"
      expr: contract_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Account"
      expr: COUNT(DISTINCT sales_account_id)
    - name: "Total Agency Commission Rate"
      expr: SUM(agency_commission_rate)
    - name: "Average Agency Commission Rate"
      expr: AVG(agency_commission_rate)
    - name: "Total Annual Revenue Potential"
      expr: SUM(annual_revenue_potential)
    - name: "Average Annual Revenue Potential"
      expr: AVG(annual_revenue_potential)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_sales_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Agency business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`sales_agency`"
  dimensions:
    - name: "Accreditation Date"
      expr: accreditation_date
    - name: "Accreditation Expiry Date"
      expr: accreditation_expiry_date
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Agency Type"
      expr: agency_type
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Model"
      expr: billing_model
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Holding Company Group"
      expr: holding_company_group
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Name"
      expr: name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Agency"
      expr: COUNT(DISTINCT sales_agency_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`sales_upfront_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upfront Deal business metrics"
  source: "`vibe_media_broadcasting_v1`.`sales`.`upfront_deal`"
  dimensions:
    - name: "Cancellation Option Window Days"
      expr: cancellation_option_window_days
    - name: "Channel Mix"
      expr: channel_mix
    - name: "Commitment Date"
      expr: commitment_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart Mix"
      expr: daypart_mix
    - name: "Deal Number"
      expr: deal_number
    - name: "Deal Status"
      expr: deal_status
    - name: "Deal Type"
      expr: deal_type
    - name: "Deal Year"
      expr: deal_year
    - name: "Execution Date"
      expr: execution_date
    - name: "Makegood Provision Flag"
      expr: makegood_provision_flag
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Negotiation Round Count"
      expr: negotiation_round_count
    - name: "Notes"
      expr: notes
    - name: "Option Exercise Deadline"
      expr: option_exercise_deadline
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Upfront Deal"
      expr: COUNT(DISTINCT upfront_deal_id)
    - name: "Total Audience Guarantee Grp"
      expr: SUM(audience_guarantee_grp)
    - name: "Average Audience Guarantee Grp"
      expr: AVG(audience_guarantee_grp)
    - name: "Total Audience Guarantee Impressions"
      expr: SUM(audience_guarantee_impressions)
    - name: "Average Audience Guarantee Impressions"
      expr: AVG(audience_guarantee_impressions)
    - name: "Total Cpm Rate"
      expr: SUM(cpm_rate)
    - name: "Average Cpm Rate"
      expr: AVG(cpm_rate)
    - name: "Total Cprp Rate"
      expr: SUM(cprp_rate)
    - name: "Average Cprp Rate"
      expr: AVG(cprp_rate)
    - name: "Total Total Committed Spend"
      expr: SUM(total_committed_spend)
    - name: "Average Total Committed Spend"
      expr: AVG(total_committed_spend)
    - name: "Total Total Proposed Spend"
      expr: SUM(total_proposed_spend)
    - name: "Average Total Proposed Spend"
      expr: AVG(total_proposed_spend)
$$;