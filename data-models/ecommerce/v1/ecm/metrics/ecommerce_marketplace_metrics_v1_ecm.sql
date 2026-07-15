-- Metric views for domain: marketplace | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core transaction performance metrics for the marketplace."
  source: "`ecommerce_ecm`.`marketplace`.`marketplace_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Transaction date (day bucket)."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., sale, refund)."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel used."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method (e.g., ship, pickup)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction."
    - name: "product_category"
      expr: product_category
      comment: "High-level product category."
  measures:
    - name: "total_gmv"
      expr: SUM(CAST(gmv_amount AS DOUBLE))
      comment: "Total gross merchandise value."
    - name: "total_commission"
      expr: SUM(CAST(marketplace_commission_amount AS DOUBLE))
      comment: "Total commission earned by marketplace."
    - name: "total_seller_payout"
      expr: SUM(CAST(seller_payout_amount AS DOUBLE))
      comment: "Total amount paid out to sellers."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of transactions."
    - name: "avg_gmv_per_transaction"
      expr: AVG(CAST(gmv_amount AS DOUBLE))
      comment: "Average GMV per transaction."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_ad_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising event performance metrics."
  source: "`ecommerce_ecm`.`marketplace`.`ad_event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the ad event."
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier."
    - name: "ad_placement_id"
      expr: ad_placement_id
      comment: "Placement identifier."
    - name: "device_type"
      expr: device_type
      comment: "Device type of the user."
    - name: "page_type"
      expr: page_type
      comment: "Page type where ad was shown."
    - name: "ad_status"
      expr: ad_status
      comment: "Current status of the ad."
  measures:
    - name: "total_ad_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total ad cost incurred."
    - name: "total_ad_revenue"
      expr: SUM(CAST(ad_revenue_amount AS DOUBLE))
      comment: "Total revenue generated from ads."
    - name: "total_clicks"
      expr: SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)
      comment: "Number of ad clicks."
    - name: "total_impressions"
      expr: SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END)
      comment: "Number of ad impressions."
    - name: "total_conversions"
      expr: SUM(CASE WHEN event_type = 'conversion' THEN 1 ELSE 0 END)
      comment: "Number of ad conversions."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_gmv_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic GMV snapshot metrics."
  source: "`ecommerce_ecm`.`marketplace`.`gmv_snapshot`"
  dimensions:
    - name: "snapshot_date"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Date of the snapshot."
    - name: "marketplace_id"
      expr: marketplace_id
      comment: "Marketplace identifier."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the snapshot."
    - name: "segment"
      expr: segment
      comment: "Customer segment."
    - name: "source_system"
      expr: source_system
      comment: "Source system of the snapshot."
  measures:
    - name: "total_gross_gmv"
      expr: SUM(CAST(gross_gmv_amount AS DOUBLE))
      comment: "Total gross GMV across snapshot."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue."
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions captured."
    - name: "avg_take_rate_pct"
      expr: AVG(CAST(take_rate_percentage AS DOUBLE))
      comment: "Average take rate percentage."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_seller_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seller settlement financial metrics."
  source: "`ecommerce_ecm`.`marketplace`.`seller_settlement`"
  dimensions:
    - name: "settlement_start_date"
      expr: settlement_start_date
      comment: "Start date of settlement period."
    - name: "settlement_end_date"
      expr: settlement_end_date
      comment: "End date of settlement period."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel used for payment."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of settlement."
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount."
    - name: "total_net_disbursement"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net amount disbursed to sellers."
    - name: "total_commission_paid"
      expr: SUM(CAST(total_commission_amount AS DOUBLE))
      comment: "Total commission paid to marketplace."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of settlement records."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`marketplace_listing_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Listing offer pricing and performance metrics."
  source: "`ecommerce_ecm`.`marketplace`.`listing_offer`"
  dimensions:
    - name: "seller_profile_id"
      expr: seller_profile_id
      comment: "Seller profile identifier."
    - name: "marketplace_listing_id"
      expr: marketplace_listing_id
      comment: "Marketplace listing identifier."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier."
    - name: "condition"
      expr: condition
      comment: "Condition of the product (new, used, etc.)."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the offer."
    - name: "is_prime_eligible"
      expr: is_prime_eligible
      comment: "Whether the offer is Prime eligible."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the offer price."
  measures:
    - name: "avg_offer_price"
      expr: AVG(CAST(offer_price AS DOUBLE))
      comment: "Average offer price."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage."
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Number of offers."
    - name: "avg_seller_rating"
      expr: AVG(CAST(seller_rating AS DOUBLE))
      comment: "Average seller rating for offers."
$$;
