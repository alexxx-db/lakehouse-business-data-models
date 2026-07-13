-- Metric views for domain: promotion | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core promotional performance KPIs measuring revenue, margin, discount impact, and promotional ROI at the campaign-offer-SKU-location grain. Primary steering dashboard for promotion effectiveness reviews."
  source: "`vibe_retail_v1`.`promotion`.`promo_performance`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the promotion was executed (e.g. in-store, e-commerce, mobile)."
    - name: "performance_week_start_date"
      expr: performance_week_start_date
      comment: "Start date of the measurement week, used for weekly trend analysis."
    - name: "performance_week_end_date"
      expr: performance_week_end_date
      comment: "End date of the measurement week."
    - name: "performance_status"
      expr: performance_status
      comment: "Current status of the performance record (e.g. final, preliminary, revised)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial amounts are denominated."
    - name: "sku"
      expr: sku
      comment: "Stock-keeping unit identifier for the promoted product."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Total gross revenue generated during the promotional period. Directly measures top-line promotional sales impact."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after discounts and returns. Core P&L metric for evaluating true promotional value."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars given to customers. Measures the cost of the promotion to the retailer."
    - name: "total_cogs"
      expr: SUM(CAST(cogs AS DOUBLE))
      comment: "Total cost of goods sold during the promotional period. Required for gross margin calculation."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Total gross margin dollars earned during the promotion. Key profitability indicator for promotion investment decisions."
    - name: "avg_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across promotion performance records. Indicates whether promotions are preserving or eroding margin."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold during the promotional period. Volume KPI used to assess promotional demand generation."
    - name: "total_incremental_units"
      expr: SUM(CAST(incremental_units AS DOUBLE))
      comment: "Units sold above the baseline (non-promoted) forecast. Measures true incremental lift attributable to the promotion."
    - name: "total_baseline_units"
      expr: SUM(CAST(baseline_units AS DOUBLE))
      comment: "Expected units sold without the promotion. Used as the denominator for incremental lift calculations."
    - name: "avg_promotional_roi"
      expr: AVG(CAST(promotional_roi AS DOUBLE))
      comment: "Average return on investment across promotion performance records. Primary executive KPI for evaluating whether promotional spend generates sufficient return."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total amount funded by vendors to offset promotional costs. Measures vendor co-investment and impacts net retailer cost of promotion."
    - name: "total_retailer_funded_amount"
      expr: SUM(CAST(retailer_funded_amount AS DOUBLE))
      comment: "Total amount funded by the retailer for promotions. Measures the retailer's own investment in promotional activity."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate during the promotional period. Indicates inventory efficiency and whether promotional pricing is clearing stock effectively."
    - name: "avg_forecast_accuracy_percent"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy for promoted items. Measures planning quality and drives improvements in future promotional forecasting."
    - name: "avg_cannibalization_estimate"
      expr: AVG(CAST(cannibalization_estimate AS DOUBLE))
      comment: "Average estimated cannibalization of non-promoted items caused by the promotion. Informs net category impact assessment."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(units_per_transaction AS DOUBLE))
      comment: "Average units purchased per transaction during the promotion. Indicates basket-building effectiveness of the promotional offer."
    - name: "avg_transaction_value"
      expr: AVG(CAST(average_transaction_value AS DOUBLE))
      comment: "Average transaction value during the promotional period. Measures whether promotions are driving higher basket sizes."
    - name: "promotion_performance_record_count"
      expr: COUNT(1)
      comment: "Number of promotion performance measurement records. Used as a denominator for per-record averages and coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion redemption analytics measuring discount value delivered, fraud risk, and redemption patterns at the transaction level. Drives coupon and offer effectiveness decisions."
  source: "`vibe_retail_v1`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the promotion was redeemed (e.g. in-store, online, mobile app)."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Status of the redemption event (e.g. approved, rejected, reversed)."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. percentage off, fixed amount, BOGO)."
    - name: "promotion_tier"
      expr: promotion_tier
      comment: "Tier of the promotion applied, used to segment redemptions by offer level."
    - name: "redemption_mechanism"
      expr: redemption_mechanism
      comment: "Mechanism used to redeem the promotion (e.g. barcode scan, promo code, automatic)."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the redemption was funded by a vendor, enabling vendor vs. retailer cost split analysis."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Status of any vendor chargeback associated with this redemption."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which redemption amounts are denominated."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered to customers through redemptions. Primary measure of promotional cost and customer savings."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original price of items before promotional discount. Used to calculate effective discount rate."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price paid by customers after promotional discount. Measures actual revenue collected."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount claimed from vendors for funded promotions. Measures vendor cost recovery effectiveness."
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Total number of promotion redemption events. Core volume metric for promotion reach and uptake."
    - name: "unique_customer_redemptions"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who redeemed a promotion. Measures breadth of promotional reach across the customer base."
    - name: "avg_discount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount value per redemption event. Indicates the typical promotional benefit delivered per transaction."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across redemptions. Elevated scores signal potential promotional abuse requiring investigation."
    - name: "high_fraud_risk_redemption_count"
      expr: COUNT(CASE WHEN fraud_score > 0.7 THEN 1 END)
      comment: "Number of redemptions with a fraud score above 0.7. Operational risk metric used to trigger fraud review workflows."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional demand forecast accuracy and financial impact metrics. Enables comparison of forecasted vs. baseline performance and supports inventory and financial planning decisions."
  source: "`vibe_retail_v1`.`promotion`.`promo_forecast`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel for which the forecast was generated."
    - name: "forecast_scenario"
      expr: forecast_scenario
      comment: "Scenario label for the forecast (e.g. base, optimistic, pessimistic)."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast record (e.g. draft, approved, superseded)."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion being forecasted (e.g. price reduction, BOGO, clearance)."
    - name: "forecast_week_start_date"
      expr: forecast_week_start_date
      comment: "Start date of the forecast week for time-series trend analysis."
    - name: "forecast_week_end_date"
      expr: forecast_week_end_date
      comment: "End date of the forecast week."
    - name: "vendor_funded_flag"
      expr: vendor_funded_flag
      comment: "Indicates whether the forecasted promotion is vendor-funded."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which forecast financial amounts are denominated."
  measures:
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue_amount AS DOUBLE))
      comment: "Total forecasted revenue from promoted items. Primary financial planning metric for promotional investment decisions."
    - name: "total_forecasted_units"
      expr: SUM(CAST(total_forecasted_units AS DOUBLE))
      comment: "Total forecasted units to be sold during the promotion. Drives inventory allocation and replenishment planning."
    - name: "total_incremental_lift_units"
      expr: SUM(CAST(incremental_lift_units AS DOUBLE))
      comment: "Total forecasted incremental units above baseline. Measures expected promotional demand generation."
    - name: "total_baseline_sales_forecast_units"
      expr: SUM(CAST(baseline_sales_forecast_units AS DOUBLE))
      comment: "Total baseline (non-promoted) unit forecast. Used to isolate the incremental impact of the promotion."
    - name: "total_forecasted_discount_cost"
      expr: SUM(CAST(forecasted_discount_cost_amount AS DOUBLE))
      comment: "Total forecasted cost of discounts to be given. Measures the planned financial investment in the promotion."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor funding expected to offset promotional discount costs. Measures planned vendor co-investment."
    - name: "total_open_to_buy_impact"
      expr: SUM(CAST(open_to_buy_impact_amount AS DOUBLE))
      comment: "Total forecasted impact on open-to-buy budget from promotional inventory commitments. Critical for merchandise financial planning."
    - name: "avg_forecast_confidence_score"
      expr: AVG(CAST(forecast_confidence_score AS DOUBLE))
      comment: "Average confidence score of promotional forecasts. Low confidence signals need for forecast model review or additional data."
    - name: "avg_forecast_error_percentage"
      expr: AVG(CAST(forecast_error_percentage AS DOUBLE))
      comment: "Average forecast error percentage. Measures forecast quality and drives improvements in promotional planning accuracy."
    - name: "avg_forecast_adjustment_factor"
      expr: AVG(CAST(forecast_adjustment_factor AS DOUBLE))
      comment: "Average manual adjustment factor applied to forecasts. Large adjustments indicate model bias requiring recalibration."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of promotional forecast records. Used for coverage and completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional budget utilization and variance metrics. Enables finance and marketing leadership to monitor spend against plan, identify over/under-spend, and manage vendor-funded allocations."
  source: "`vibe_retail_v1`.`promotion`.`promo_budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of promotional budget (e.g. trade, consumer, digital, circular)."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g. draft, approved, closed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the budget record."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year to which the budget belongs, for annual planning analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) to which the budget belongs."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency in which budget amounts are denominated."
    - name: "budget_owner_type"
      expr: budget_owner_type
      comment: "Type of owner responsible for the budget (e.g. category, brand, channel)."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved promotional budget. Primary financial planning metric for promotional investment capacity."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned promotional spend. Measures committed promotional investment against total budget."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual promotional spend incurred. Core execution metric for budget management and variance analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed but not yet spent promotional budget. Measures financial obligations already locked in."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent promotional budget. Indicates available capacity for additional promotional investment."
    - name: "total_vendor_funded_amount"
      expr: SUM(CAST(vendor_funded_amount AS DOUBLE))
      comment: "Total vendor-funded portion of the promotional budget. Measures vendor co-investment and reduces net retailer cost."
    - name: "total_circular_ad_allocation"
      expr: SUM(CAST(circular_ad_allocation AS DOUBLE))
      comment: "Total budget allocated to circular advertising. Enables channel-level budget mix analysis."
    - name: "total_ecommerce_channel_allocation"
      expr: SUM(CAST(ecommerce_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to the e-commerce channel. Tracks digital promotional investment."
    - name: "total_mobile_channel_allocation"
      expr: SUM(CAST(mobile_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to the mobile channel. Tracks mobile promotional investment."
    - name: "total_pos_channel_allocation"
      expr: SUM(CAST(pos_channel_allocation AS DOUBLE))
      comment: "Total budget allocated to the point-of-sale channel. Tracks in-store promotional investment."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage set for budget monitoring. Indicates the tolerance level for spend deviation before escalation."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of promotional budget records. Used for budget coverage and completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_coupon_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon distribution effectiveness metrics measuring reach, redemption rates, and distribution costs. Drives decisions on coupon channel mix and targeting strategy."
  source: "`vibe_retail_v1`.`promotion`.`coupon_distribution`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which coupons were distributed (e.g. email, direct mail, in-app, in-store)."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution batch (e.g. pending, completed, cancelled)."
    - name: "distribution_date"
      expr: distribution_date
      comment: "Date on which the coupon distribution was executed, for trend analysis."
  measures:
    - name: "total_quantity_distributed"
      expr: SUM(CAST(quantity_distributed AS DOUBLE))
      comment: "Total number of coupons distributed. Measures promotional reach and distribution scale."
    - name: "total_redemption_count"
      expr: SUM(CAST(redemption_count AS DOUBLE))
      comment: "Total number of coupons redeemed. Core effectiveness metric for coupon campaigns."
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS DOUBLE))
      comment: "Total actual audience reached by the coupon distribution. Measures true distribution penetration."
    - name: "total_target_reach"
      expr: SUM(CAST(target_reach AS DOUBLE))
      comment: "Total targeted audience for the coupon distribution. Used as denominator for reach attainment rate."
    - name: "total_distribution_cost"
      expr: SUM(CAST(distribution_cost AS DOUBLE))
      comment: "Total cost incurred to distribute coupons. Enables cost-per-redemption and ROI calculations."
    - name: "avg_redemption_rate_percent"
      expr: AVG(CAST(redemption_rate_percent AS DOUBLE))
      comment: "Average coupon redemption rate across distribution batches. Primary KPI for coupon offer effectiveness and targeting quality."
    - name: "distribution_batch_count"
      expr: COUNT(1)
      comment: "Number of coupon distribution batches. Used for distribution activity volume monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional funding agreement metrics tracking accruals, settlements, and outstanding balances. Enables finance and merchandising to manage vendor co-op funding and chargeback exposure."
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of vendor promotional agreement (e.g. co-op, bill-back, scan-down)."
    - name: "vendor_promo_agreement_status"
      expr: vendor_promo_agreement_status
      comment: "Current status of the vendor promotional agreement (e.g. active, expired, terminated)."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue vendor funding (e.g. fixed, percentage of sales)."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency at which vendor funding is settled (e.g. monthly, quarterly, annually)."
    - name: "funding_currency_code"
      expr: funding_currency_code
      comment: "Currency in which vendor funding amounts are denominated."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Indicates whether the agreement allows chargebacks for non-compliance."
  measures:
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total vendor funding committed under promotional agreements. Measures total vendor co-investment in promotional activity."
    - name: "total_accrued_amount"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total vendor funding accrued to date. Measures earned but potentially unsettled vendor funding."
    - name: "total_settled_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total vendor funding already settled and collected. Measures cash actually received from vendor co-op programs."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding vendor funding balance not yet settled. Measures accounts receivable exposure from vendor promotional agreements."
    - name: "total_chargeback_penalty_amount"
      expr: SUM(CAST(chargeback_penalty_amount AS DOUBLE))
      comment: "Total chargeback penalties assessed against vendors for non-compliance. Measures enforcement effectiveness of promotional agreements."
    - name: "avg_funding_percentage"
      expr: AVG(CAST(funding_percentage AS DOUBLE))
      comment: "Average vendor funding percentage across agreements. Indicates the typical vendor cost-share rate for promotional activity."
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of vendor promotional agreements. Measures the scale of vendor co-op program engagement."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN vendor_promo_agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active vendor promotional agreements. Measures the live vendor funding portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_vendor_promo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor promotional claim processing metrics tracking claim volumes, approval rates, dispute rates, and settlement efficiency. Drives vendor funding recovery and accounts payable management."
  source: "`vibe_retail_v1`.`promotion`.`vendor_promo_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the vendor promotional claim (e.g. submitted, approved, disputed, settled)."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of vendor promotional claim (e.g. scan-down, bill-back, co-op)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which claim amounts are denominated."
    - name: "is_automated_claim"
      expr: is_automated_claim
      comment: "Indicates whether the claim was generated automatically or submitted manually."
    - name: "claim_date"
      expr: claim_date
      comment: "Date the claim was submitted, for trend and aging analysis."
    - name: "claim_period_start_date"
      expr: claim_period_start_date
      comment: "Start date of the claim period."
    - name: "claim_period_end_date"
      expr: claim_period_end_date
      comment: "End date of the claim period."
  measures:
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors for promotional funding. Measures the gross vendor funding recovery pipeline."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved for payment from vendor promotional claims. Measures confirmed vendor funding recovery."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount actually settled and collected from vendors. Measures cash received from vendor promotional claims."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute with vendors. Measures at-risk vendor funding requiring resolution."
    - name: "total_sales_revenue"
      expr: SUM(CAST(sales_revenue AS DOUBLE))
      comment: "Total sales revenue supporting the vendor promotional claims. Used to validate claim amounts against actual sales performance."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold supporting the vendor promotional claims. Used for per-unit funding rate validation."
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of vendor promotional claims submitted. Measures claim processing volume."
    - name: "disputed_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'disputed' THEN 1 END)
      comment: "Number of claims currently in dispute. Elevated counts signal vendor relationship or documentation issues requiring attention."
    - name: "automated_claim_count"
      expr: COUNT(CASE WHEN is_automated_claim = TRUE THEN 1 END)
      comment: "Number of claims generated through automated processes. Measures automation adoption in vendor claim management."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_rebate_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer rebate claim processing metrics tracking submission volumes, approval rates, fraud flags, and payment efficiency. Enables operations and finance to manage rebate program liability and customer experience."
  source: "`vibe_retail_v1`.`promotion`.`rebate_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the rebate claim (e.g. submitted, approved, rejected, paid)."
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of claimant (e.g. individual, business) for segmentation of rebate program usage."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the rebate claim was submitted (e.g. online, mail, in-store)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay approved rebate claims (e.g. check, prepaid card, digital transfer)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rebate claim amounts are denominated."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the claim has been flagged for potential fraud."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the rebate claim was submitted, for trend and aging analysis."
  measures:
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total rebate amount claimed by customers. Measures gross rebate program liability."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total rebate amount approved for payment. Measures confirmed rebate program payout obligation."
    - name: "total_purchase_amount"
      expr: SUM(CAST(purchase_amount AS DOUBLE))
      comment: "Total purchase amount supporting rebate claims. Used to validate claim eligibility and calculate effective rebate rates."
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of rebate claims submitted. Measures rebate program participation volume."
    - name: "fraud_flagged_claim_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of rebate claims flagged for potential fraud. Measures fraud exposure in the rebate program."
    - name: "approved_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'approved' THEN 1 END)
      comment: "Number of rebate claims approved for payment. Used to calculate approval rate."
    - name: "rejected_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'rejected' THEN 1 END)
      comment: "Number of rebate claims rejected. High rejection rates may indicate poor program communication or eligibility issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular advertising production and financial metrics. Enables marketing and finance to track circular production costs, vendor funding, and publication activity."
  source: "`vibe_retail_v1`.`promotion`.`circular_ad`"
  dimensions:
    - name: "circular_type"
      expr: circular_type
      comment: "Type of circular advertisement (e.g. weekly, seasonal, event-specific)."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the circular is distributed (e.g. print, digital, email)."
    - name: "production_status"
      expr: production_status
      comment: "Current production status of the circular (e.g. in-design, approved, published)."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market targeted by the circular."
    - name: "is_vendor_funded"
      expr: is_vendor_funded
      comment: "Indicates whether the circular is funded by a vendor."
    - name: "publication_date"
      expr: publication_date
      comment: "Date the circular was published, for trend analysis."
    - name: "production_cost_currency_code"
      expr: production_cost_currency_code
      comment: "Currency in which production costs are denominated."
  measures:
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production cost for circular advertisements. Measures the investment in circular advertising production."
    - name: "total_vendor_funding_amount"
      expr: SUM(CAST(vendor_funding_amount AS DOUBLE))
      comment: "Total vendor funding received to offset circular production costs. Measures vendor co-investment in circular advertising."
    - name: "avg_production_cost"
      expr: AVG(CAST(production_cost_amount AS DOUBLE))
      comment: "Average production cost per circular. Benchmarks production efficiency across circular types and markets."
    - name: "circular_count"
      expr: COUNT(1)
      comment: "Total number of circular advertisements produced. Measures promotional publishing activity volume."
    - name: "vendor_funded_circular_count"
      expr: COUNT(CASE WHEN is_vendor_funded = TRUE THEN 1 END)
      comment: "Number of circulars with vendor funding. Measures the proportion of circular activity supported by vendor co-investment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_circular_ad_category_feature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category feature performance within circular advertisements, measuring sales lift, space allocation, and vendor co-op contribution at the category-circular grain."
  source: "`vibe_retail_v1`.`promotion`.`circular_ad_category_feature`"
  dimensions:
    - name: "feature_prominence"
      expr: feature_prominence
      comment: "Prominence level of the category feature within the circular (e.g. cover, full-page, quarter-page)."
    - name: "creative_theme"
      expr: creative_theme
      comment: "Creative theme applied to the category feature in the circular."
    - name: "vendor_co_op_flag"
      expr: vendor_co_op_flag
      comment: "Indicates whether vendor co-op funding was applied to this category feature."
    - name: "target_currency_code"
      expr: target_currency_code
      comment: "Currency in which sales targets and actuals are denominated."
  measures:
    - name: "total_actual_sales_amount"
      expr: SUM(CAST(actual_sales_amount AS DOUBLE))
      comment: "Total actual sales generated by featured categories in circulars. Measures the revenue impact of circular category features."
    - name: "total_category_sales_target"
      expr: SUM(CAST(category_sales_target AS DOUBLE))
      comment: "Total sales target for featured categories. Used to calculate attainment rate against circular sales goals."
    - name: "total_vendor_co_op_amount"
      expr: SUM(CAST(vendor_co_op_amount AS DOUBLE))
      comment: "Total vendor co-op funding received for category features. Measures vendor investment in circular category placement."
    - name: "total_allocated_space_sqin"
      expr: SUM(CAST(allocated_space_sqin AS DOUBLE))
      comment: "Total square inches of circular space allocated to category features. Measures space investment in promotional categories."
    - name: "avg_sales_lift_percent"
      expr: AVG(CAST(sales_lift_percent AS DOUBLE))
      comment: "Average sales lift percentage achieved by circular category features. Primary KPI for evaluating circular feature effectiveness."
    - name: "avg_traffic_attribution_percent"
      expr: AVG(CAST(traffic_attribution_percent AS DOUBLE))
      comment: "Average percentage of store traffic attributed to circular category features. Measures the traffic-driving power of circular advertising."
    - name: "category_feature_count"
      expr: COUNT(1)
      comment: "Total number of category features across all circulars. Measures the breadth of category coverage in circular advertising."
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
    - name: "Coupon Code"
      expr: coupon_code
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
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Issue Channel"
      expr: issue_channel
    - name: "Issue Date"
      expr: issue_date
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
    - name: "Applicable Market Codes"
      expr: applicable_market_codes
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

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_conflict_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Conflict Rule business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_conflict_rule`"
  dimensions:
    - name: "Applies To Scope"
      expr: applies_to_scope
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Log Required Flag"
      expr: audit_log_required_flag
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment Restriction"
      expr: customer_segment_restriction
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Stack Count"
      expr: max_stack_count
    - name: "Notes"
      expr: notes
    - name: "Oms System Flag"
      expr: oms_system_flag
    - name: "Override Allowed Flag"
      expr: override_allowed_flag
    - name: "Override Authorization Level"
      expr: override_authorization_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Conflict Rule"
      expr: COUNT(DISTINCT promo_conflict_rule_id)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Max Discount Percentage"
      expr: SUM(max_discount_percentage)
    - name: "Average Max Discount Percentage"
      expr: AVG(max_discount_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Group business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_group`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Business Owner"
      expr: business_owner
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Conflict Resolution Rule"
      expr: conflict_resolution_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Applicability"
      expr: customer_segment_applicability
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Scope"
      expr: exclusion_scope
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Group Code"
      expr: group_code
    - name: "Group Description"
      expr: group_description
    - name: "Group Name"
      expr: group_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Group"
      expr: COUNT(DISTINCT promo_group_id)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promo_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Inventory Allocation business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promo_inventory_allocation`"
  dimensions:
    - name: "Allocated Inventory Units"
      expr: allocated_inventory_units
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Facility Priority Rank"
      expr: facility_priority_rank
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Inventory Allocation"
      expr: COUNT(DISTINCT promo_inventory_allocation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
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

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_promotion_stack`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Stack business metrics"
  source: "`vibe_retail_v1`.`promotion`.`promotion_stack`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Apply"
      expr: auto_apply
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Combinable With Clearance"
      expr: combinable_with_clearance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclude Sale Items"
      expr: exclude_sale_items
    - name: "Funding Source"
      expr: funding_source
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Stack"
      expr: COUNT(DISTINCT promotion_stack_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`promotion_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate business metrics"
  source: "`vibe_retail_v1`.`promotion`.`rebate`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Eligibility"
      expr: channel_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment Eligibility"
      expr: customer_segment_eligibility
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Product List"
      expr: exclusion_product_list
    - name: "Geographic Eligibility"
      expr: geographic_eligibility
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Marketing Message"
      expr: marketing_message
    - name: "Minimum Purchase Quantity"
      expr: minimum_purchase_quantity
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Processing Days"
      expr: payment_processing_days
    - name: "Qualifying Product List"
      expr: qualifying_product_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rebate"
      expr: COUNT(DISTINCT rebate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Maximum Rebate Amount"
      expr: SUM(maximum_rebate_amount)
    - name: "Average Maximum Rebate Amount"
      expr: AVG(maximum_rebate_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
    - name: "Total Total Budget Amount"
      expr: SUM(total_budget_amount)
    - name: "Average Total Budget Amount"
      expr: AVG(total_budget_amount)
    - name: "Total Vendor Funding Percentage"
      expr: SUM(vendor_funding_percentage)
    - name: "Average Vendor Funding Percentage"
      expr: AVG(vendor_funding_percentage)
$$;