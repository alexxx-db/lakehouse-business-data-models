-- Metric views for domain: promotion | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_promo_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for promotional campaigns and offers"
  source: "`grocery_ecm`.`promotion`.`promo_performance`"
  dimensions:
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Identifier of the promo campaign"
    - name: "promo_offer_id"
      expr: promo_offer_id
      comment: "Identifier of the promo offer"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center responsible for the promotion"
    - name: "promo_zone_id"
      expr: promo_zone_id
      comment: "Promotion zone identifier"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of the measurement period"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue AS DOUBLE))
      comment: "Sum of gross revenue for the performance period"
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin AS DOUBLE))
      comment: "Sum of gross margin for the performance period"
    - name: "total_units_sold"
      expr: SUM(CAST(actual_units_sold AS DOUBLE))
      comment: "Total units sold"
    - name: "average_roi"
      expr: AVG(CAST(roi AS DOUBLE))
      comment: "Average return on investment"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of performance records"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity and financial impact"
  source: "`grocery_ecm`.`promotion`.`promotion_redemption`"
  dimensions:
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Campaign associated with the redemption"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store where redemption occurred"
    - name: "channel"
      expr: channel
      comment: "Sales channel (e.g., in‑store, online)"
    - name: "redemption_date"
      expr: redemption_date
      comment: "Date of redemption"
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted across redemptions"
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price after discounts"
    - name: "redemption_count"
      expr: COUNT(1)
      comment: "Number of redemption events"
    - name: "distinct_shopper_count"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Number of unique shoppers who redeemed"
    - name: "average_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption"
    - name: "average_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average final price per redemption"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_digital_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial characteristics of digital coupons"
  source: "`grocery_ecm`.`promotion`.`digital_coupon`"
  dimensions:
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Campaign linked to the coupon"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the coupon"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (e.g., percentage, amount)"
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which coupon was issued"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month coupon became effective"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month coupon expires"
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Whether coupon earns loyalty points"
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether coupon can be stacked with other offers"
  measures:
    - name: "total_face_value"
      expr: SUM(CAST(face_value AS DOUBLE))
      comment: "Total face value of issued digital coupons"
    - name: "total_maximum_discount"
      expr: SUM(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Sum of maximum possible discount across coupons"
    - name: "average_minimum_purchase"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required to use a coupon"
    - name: "coupon_count"
      expr: COUNT(1)
      comment: "Number of digital coupons issued"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_funding_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding claim performance and financial exposure"
  source: "`grocery_ecm`.`promotion`.`funding_claim`"
  dimensions:
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Campaign associated with the claim"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier making the claim"
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center responsible for the claim"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the claim amounts"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
  measures:
    - name: "total_claimed_funding"
      expr: SUM(CAST(claimed_funding_amount AS DOUBLE))
      comment: "Total funding amount claimed by suppliers"
    - name: "total_approved_funding"
      expr: SUM(CAST(approved_funding_amount AS DOUBLE))
      comment: "Total funding amount approved"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of adjustments to funding claims"
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Number of funding claim records"
    - name: "average_claimed_funding"
      expr: AVG(CAST(claimed_funding_amount AS DOUBLE))
      comment: "Average claimed funding per claim"
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer‑level financial and performance targets"
  source: "`grocery_ecm`.`promotion`.`promo_offer`"
  dimensions:
    - name: "category_id"
      expr: category_id
      comment: "Product category of the offer"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier providing the offer"
    - name: "segment_id"
      expr: segment_id
      comment: "Customer segment targeted"
    - name: "discount_type"
      expr: discount_type
      comment: "Discount type (percentage, amount, etc.)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of promotional offer"
  measures:
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value offered"
    - name: "average_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount per offer"
    - name: "total_gmroi_target"
      expr: SUM(CAST(gmroi_target AS DOUBLE))
      comment: "Sum of GMROI targets for offers"
    - name: "offer_count"
      expr: COUNT(1)
      comment: "Number of promo offers"
$$;
