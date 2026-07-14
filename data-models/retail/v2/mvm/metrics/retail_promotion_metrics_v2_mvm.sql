-- Metric views for domain: promotion | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:25:19

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular Ad business metrics"
  source: "`vibe_retail_v1`.`promotion`.`circular_ad`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Circular Name"
      expr: circular_name
    - name: "Circular Number"
      expr: circular_number
    - name: "Circular Type"
      expr: circular_type
    - name: "Compliance Review Flag"
      expr: compliance_review_flag
    - name: "Cover Image Url"
      expr: cover_image_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Impressions Target"
      expr: digital_impressions_target
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Edition Number"
      expr: edition_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Is Vendor Funded"
      expr: is_vendor_funded
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Circular Ad"
      expr: COUNT(DISTINCT circular_ad_id)
    - name: "Total Production Cost Amount"
      expr: SUM(production_cost_amount)
    - name: "Average Production Cost Amount"
      expr: AVG(production_cost_amount)
    - name: "Total Vendor Funding Amount"
      expr: SUM(vendor_funding_amount)
    - name: "Average Vendor Funding Amount"
      expr: AVG(vendor_funding_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon business metrics"
  source: "`vibe_retail_v1`.`promotion`.`coupon`"
  dimensions:
    - name: "Barcode"
      expr: barcode
    - name: "Code"
      expr: code
    - name: "Coupon Status"
      expr: coupon_status
    - name: "Coupon Type"
      expr: coupon_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Digital Distribution Quantity"
      expr: digital_distribution_quantity
    - name: "Digital Wallet Enabled Flag"
      expr: digital_wallet_enabled_flag
    - name: "Discount Type"
      expr: discount_type
    - name: "Eligible Channel"
      expr: eligible_channel
    - name: "Eligible Product Scope"
      expr: eligible_product_scope
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Issue Channel"
      expr: issue_channel
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coupon"
      expr: COUNT(DISTINCT coupon_id)
    - name: "Total Face Value"
      expr: SUM(face_value)
    - name: "Average Face Value"
      expr: AVG(face_value)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Calendar business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_calendar`"
  dimensions:
    - name: "Applicable Banner Codes"
      expr: applicable_banner_codes
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Banner Applicability"
      expr: banner_applicability
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Circular Production Deadline"
      expr: circular_production_deadline
    - name: "Competitive Response Flag"
      expr: competitive_response_flag
    - name: "Competitive Trigger Description"
      expr: competitive_trigger_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Month"
      expr: fiscal_month
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Week"
      expr: fiscal_week
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Calendar"
      expr: COUNT(DISTINCT promo_calendar_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Expected Sales Lift Pct"
      expr: SUM(expected_sales_lift_pct)
    - name: "Average Expected Sales Lift Pct"
      expr: AVG(expected_sales_lift_pct)
    - name: "Total Expected Traffic Lift Pct"
      expr: SUM(expected_traffic_lift_pct)
    - name: "Average Expected Traffic Lift Pct"
      expr: AVG(expected_traffic_lift_pct)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Campaign business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Description"
      expr: campaign_description
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Circular Ad Flag"
      expr: circular_ad_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Target"
      expr: customer_segment_target
    - name: "Digital Promotion Flag"
      expr: digital_promotion_flag
    - name: "Discount Strategy"
      expr: discount_strategy
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Campaign"
      expr: COUNT(DISTINCT promo_campaign_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Target Revenue"
      expr: SUM(target_revenue)
    - name: "Average Target Revenue"
      expr: AVG(target_revenue)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Offer business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_offer`"
  dimensions:
    - name: "Activation Trigger"
      expr: activation_trigger
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Eligibility"
      expr: channel_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Eligibility"
      expr: customer_segment_eligibility
    - name: "Digital Delivery Flag"
      expr: digital_delivery_flag
    - name: "Discount Method"
      expr: discount_method
    - name: "Display Message"
      expr: display_message
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective End Time"
      expr: effective_end_time
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Start Time"
      expr: effective_start_time
    - name: "Jurisdiction Restriction Flag"
      expr: jurisdiction_restriction_flag
    - name: "Maximum Redemption Per Customer"
      expr: maximum_redemption_per_customer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Offer"
      expr: COUNT(DISTINCT promo_offer_id)
    - name: "Total Cost Share Percentage"
      expr: SUM(cost_share_percentage)
    - name: "Average Cost Share Percentage"
      expr: AVG(cost_share_percentage)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Performance business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_performance`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source System"
      expr: data_source_system
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "New Customer Count"
      expr: new_customer_count
    - name: "Notes"
      expr: notes
    - name: "Out Of Stock Days"
      expr: out_of_stock_days
    - name: "Performance Status"
      expr: performance_status
    - name: "Performance Week End Date"
      expr: performance_week_end_date
    - name: "Performance Week Start Date"
      expr: performance_week_start_date
    - name: "Redemption Count"
      expr: redemption_count
    - name: "Repeat Customer Count"
      expr: repeat_customer_count
    - name: "Sku"
      expr: sku
    - name: "Unique Customer Count"
      expr: unique_customer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Performance"
      expr: COUNT(DISTINCT promo_performance_id)
    - name: "Total Average Transaction Value"
      expr: SUM(average_transaction_value)
    - name: "Average Average Transaction Value"
      expr: AVG(average_transaction_value)
    - name: "Total Baseline Units"
      expr: SUM(baseline_units)
    - name: "Average Baseline Units"
      expr: AVG(baseline_units)
    - name: "Total Cannibalization Estimate"
      expr: SUM(cannibalization_estimate)
    - name: "Average Cannibalization Estimate"
      expr: AVG(cannibalization_estimate)
    - name: "Total Cogs"
      expr: SUM(cogs)
    - name: "Average Cogs"
      expr: AVG(cogs)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Forecast Accuracy Percent"
      expr: SUM(forecast_accuracy_percent)
    - name: "Average Forecast Accuracy Percent"
      expr: AVG(forecast_accuracy_percent)
    - name: "Total Gross Margin"
      expr: SUM(gross_margin)
    - name: "Average Gross Margin"
      expr: AVG(gross_margin)
    - name: "Total Gross Margin Percent"
      expr: SUM(gross_margin_percent)
    - name: "Average Gross Margin Percent"
      expr: AVG(gross_margin_percent)
    - name: "Total Gross Revenue"
      expr: SUM(gross_revenue)
    - name: "Average Gross Revenue"
      expr: AVG(gross_revenue)
    - name: "Total Incremental Units"
      expr: SUM(incremental_units)
    - name: "Average Incremental Units"
      expr: AVG(incremental_units)
    - name: "Total Net Revenue"
      expr: SUM(net_revenue)
    - name: "Average Net Revenue"
      expr: AVG(net_revenue)
    - name: "Total Promotional Roi"
      expr: SUM(promotional_roi)
    - name: "Average Promotional Roi"
      expr: AVG(promotional_roi)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Redemption business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "Chargeback Status"
      expr: chargeback_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Processing System"
      expr: processing_system
    - name: "Promotion Tier"
      expr: promotion_tier
    - name: "Quantity Redeemed"
      expr: quantity_redeemed
    - name: "Redemption Channel"
      expr: redemption_channel
    - name: "Redemption Limit Type"
      expr: redemption_limit_type
    - name: "Redemption Mechanism"
      expr: redemption_mechanism
    - name: "Redemption Sequence Number"
      expr: redemption_sequence_number
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Redemption Timestamp"
      expr: redemption_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Redemption"
      expr: COUNT(DISTINCT promo_redemption_id)
    - name: "Total Chargeback Amount"
      expr: SUM(chargeback_amount)
    - name: "Average Chargeback Amount"
      expr: AVG(chargeback_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Final Price"
      expr: SUM(final_price)
    - name: "Average Final Price"
      expr: AVG(final_price)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Promo Agreement business metrics"
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "Accrual Method"
      expr: accrual_method
    - name: "Ad Placement Required"
      expr: ad_placement_required
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Chargeback Eligible"
      expr: chargeback_eligible
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Compliance Required"
      expr: display_compliance_required
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Funding Currency Code"
      expr: funding_currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Performance Obligation Description"
      expr: performance_obligation_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Promo Agreement"
      expr: COUNT(DISTINCT vendor_promo_agreement_id)
    - name: "Total Chargeback Penalty Amount"
      expr: SUM(chargeback_penalty_amount)
    - name: "Average Chargeback Penalty Amount"
      expr: AVG(chargeback_penalty_amount)
    - name: "Total Funding Amount"
      expr: SUM(funding_amount)
    - name: "Average Funding Amount"
      expr: AVG(funding_amount)
    - name: "Total Funding Percentage"
      expr: SUM(funding_percentage)
    - name: "Average Funding Percentage"
      expr: AVG(funding_percentage)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Minimum Purchase Quantity"
      expr: SUM(minimum_purchase_quantity)
    - name: "Average Minimum Purchase Quantity"
      expr: AVG(minimum_purchase_quantity)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Total Accrued Amount"
      expr: SUM(total_accrued_amount)
    - name: "Average Total Accrued Amount"
      expr: AVG(total_accrued_amount)
    - name: "Total Total Settled Amount"
      expr: SUM(total_settled_amount)
    - name: "Average Total Settled Amount"
      expr: AVG(total_settled_amount)
$$;