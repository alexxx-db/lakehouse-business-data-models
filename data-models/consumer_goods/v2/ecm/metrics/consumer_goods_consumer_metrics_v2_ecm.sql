-- Metric views for domain: consumer | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer lifetime value KPIs covering predicted value, historical revenue, churn risk, and tier migration. Used by CMO and VP Analytics to prioritize retention investment and personalization strategy."
  source: "`vibe_consumer_goods_v1`.`consumer`.`cltv_record`"
  dimensions:
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "CLTV value segment (high, mid, low) for investment prioritization."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier for tiered retention strategy."
    - name: "cltv_band"
      expr: cltv_band
      comment: "CLTV value band for cohort analysis."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate CLTV (ML model, RFM, etc.) for model governance."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary purchase channel of the shopper for channel-based CLTV analysis."
    - name: "primary_brand_code"
      expr: primary_brand_code
      comment: "Primary brand affinity of the shopper for brand-level CLTV analysis."
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Flags shoppers who changed CLTV tier in the current period for migration analysis."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of CLTV calculation for trend and model refresh monitoring."
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (promoter, passive, detractor) for satisfaction-value correlation."
  measures:
    - name: "total_cltv_records"
      expr: COUNT(DISTINCT cltv_record_id)
      comment: "Total CLTV records computed. Measures model coverage across the consumer base."
    - name: "total_predicted_cltv"
      expr: SUM(CAST(predicted_cltv AS DOUBLE))
      comment: "Total predicted lifetime value across all scored shoppers. Measures total consumer equity at risk."
    - name: "avg_predicted_cltv"
      expr: AVG(CAST(predicted_cltv AS DOUBLE))
      comment: "Average predicted CLTV per shopper. Benchmarks consumer quality and informs acquisition spend."
    - name: "total_predicted_revenue_12m"
      expr: SUM(CAST(predicted_revenue_12m AS DOUBLE))
      comment: "Total predicted revenue in the next 12 months. Forward-looking revenue forecast from consumer base."
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability across scored shoppers. Measures overall consumer retention risk."
    - name: "total_historical_revenue_lifetime"
      expr: SUM(CAST(revenue_lifetime_historical AS DOUBLE))
      comment: "Total historical lifetime revenue across all shoppers. Measures realized consumer equity."
    - name: "avg_historical_revenue_12m"
      expr: AVG(CAST(revenue_12m_historical AS DOUBLE))
      comment: "Average historical revenue per shopper in the last 12 months. Benchmarks recent consumer value."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across shoppers. Measures engagement depth and repurchase behavior."
    - name: "tier_changed_shoppers"
      expr: COUNT(DISTINCT CASE WHEN tier_change_flag = TRUE THEN cltv_record_id END)
      comment: "Shoppers who changed CLTV tier. Measures tier migration velocity for retention program effectiveness."
    - name: "avg_model_confidence_score"
      expr: AVG(CAST(model_confidence_score AS DOUBLE))
      comment: "Average model confidence score. Measures CLTV model reliability and data quality."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_consent_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent event stream analytics for opt-in/opt-out velocity, double opt-in compliance, and consent change pattern monitoring."
  source: "`vibe_consumer_goods_v1`.`consumer`.`consent_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of consent event (opt-in, opt-out, withdrawal, renewal) for flow analysis."
    - name: "consent_event_status"
      expr: consent_event_status
      comment: "Status of the consent event for processing pipeline monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel of the consent event for channel-level compliance analysis."
    - name: "legal_basis_code"
      expr: legal_basis_code
      comment: "Legal basis code for the consent event for regulatory compliance reporting."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the event (GDPR, CCPA)."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was completed for consent quality analysis."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of consent event for trend analysis."
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Whether the event represents an opt-in action."
  measures:
    - name: "total_consent_events"
      expr: COUNT(DISTINCT consent_event_id)
      comment: "Total consent events; baseline for consent activity volume monitoring."
    - name: "opt_in_events"
      expr: COUNT(DISTINCT CASE WHEN opt_in_flag = TRUE THEN consent_event_id END)
      comment: "Count of opt-in events; measures consent acquisition velocity."
    - name: "opt_out_events"
      expr: COUNT(DISTINCT CASE WHEN opt_in_flag = FALSE THEN consent_event_id END)
      comment: "Count of opt-out events; measures consent attrition velocity."
    - name: "double_opt_in_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT consent_event_id), 0), 2)
      comment: "Percentage of events with double opt-in completed; measures consent quality compliance."
    - name: "minor_consent_event_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN minor_flag = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT consent_event_id), 0), 2)
      comment: "Percentage of consent events involving minors; drives enhanced compliance handling."
    - name: "parental_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN parental_consent_flag = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT consent_event_id), 0), 2)
      comment: "Percentage of events with parental consent; measures COPPA/minor protection compliance."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management KPIs covering opt-in rates, consent coverage, regulatory compliance, and re-consent urgency. Used by Chief Privacy Officer and VP Marketing to manage regulatory risk and addressable audience."
  source: "`vibe_consumer_goods_v1`.`consumer`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, profiling, third-party sharing) for compliance breakdown."
    - name: "consent_record_status"
      expr: consent_record_status
      comment: "Current status of the consent record (active, withdrawn, expired) for compliance monitoring."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status (opted-in, opted-out, pending) for addressable audience sizing."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, legitimate interest, contract) for GDPR compliance."
    - name: "channel"
      expr: channel
      comment: "Channel through which consent was captured for consent quality analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of consent for jurisdiction-specific compliance reporting."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month of consent capture for trend and compliance audit."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Flags double opt-in consents for higher-quality consent segmentation."
    - name: "re_consent_required_flag"
      expr: re_consent_required_flag
      comment: "Flags records requiring re-consent for compliance urgency monitoring."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records. Measures consent management coverage across the consumer base."
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_given = TRUE AND consent_record_status = 'active' THEN consent_record_id END)
      comment: "Active, given consents. Defines the legally compliant addressable audience."
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_record_status = 'withdrawn' THEN consent_record_id END)
      comment: "Withdrawn consents. Measures opt-out volume and regulatory risk exposure."
    - name: "re_consent_required_records"
      expr: COUNT(DISTINCT CASE WHEN re_consent_required_flag = TRUE THEN consent_record_id END)
      comment: "Records requiring re-consent. Measures compliance urgency and audience at risk of becoming unreachable."
    - name: "double_opt_in_consents"
      expr: COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN consent_record_id END)
      comment: "Double opt-in consents. Measures highest-quality consent coverage for premium channel use."
    - name: "third_party_sharing_consents"
      expr: COUNT(DISTINCT CASE WHEN third_party_sharing_flag = TRUE THEN consent_record_id END)
      comment: "Consents permitting third-party data sharing. Measures data monetization eligibility."
    - name: "profiling_consents"
      expr: COUNT(DISTINCT CASE WHEN profiling_consent_flag = TRUE THEN consent_record_id END)
      comment: "Consents permitting profiling. Measures personalization-eligible audience size."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_data_subject_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy and data subject request KPIs covering request volume, SLA compliance, breach risk, and fulfillment performance. Used by Chief Privacy Officer and Legal to manage regulatory compliance and operational risk."
  source: "`vibe_consumer_goods_v1`.`consumer`.`data_subject_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of data subject request (erasure, access, portability, rectification) for regulatory breakdown."
    - name: "data_subject_request_status"
      expr: data_subject_request_status
      comment: "Current status of the request (open, in-progress, completed, rejected) for workload management."
    - name: "country_code"
      expr: country_code
      comment: "Country of the data subject for jurisdiction-specific compliance reporting."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (GDPR, CCPA, etc.) for compliance breakdown."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the request was submitted for operational routing analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flags requests that breached SLA for compliance risk monitoring."
    - name: "received_date_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month of request receipt for volume trend and regulatory reporting."
    - name: "identity_verified_flag"
      expr: identity_verified_flag
      comment: "Flags requests with verified identity for data quality and fraud risk analysis."
  measures:
    - name: "total_dsr_requests"
      expr: COUNT(DISTINCT data_subject_request_id)
      comment: "Total data subject requests received. Core privacy compliance volume metric."
    - name: "sla_breached_requests"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN data_subject_request_id END)
      comment: "Requests that breached SLA. Measures regulatory non-compliance risk and potential fine exposure."
    - name: "escalated_requests"
      expr: COUNT(DISTINCT CASE WHEN escalated_flag = TRUE THEN data_subject_request_id END)
      comment: "Escalated requests. Measures complex or disputed privacy cases requiring senior attention."
    - name: "sensitive_data_requests"
      expr: COUNT(DISTINCT CASE WHEN is_sensitive_data = TRUE THEN data_subject_request_id END)
      comment: "Requests involving sensitive data categories. Measures elevated compliance risk exposure."
    - name: "identity_verified_requests"
      expr: COUNT(DISTINCT CASE WHEN identity_verified_flag = TRUE THEN data_subject_request_id END)
      comment: "Requests with verified identity. Measures compliance with identity verification requirements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order performance KPIs covering revenue, order volume, fulfillment, and return rates. Used by VP eCommerce and CFO to steer DTC channel investment and operational efficiency."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order`"
  dimensions:
    - name: "dtc_order_status"
      expr: dtc_order_status
      comment: "Current status of the DTC order (placed, shipped, delivered, cancelled) for funnel analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel of the DTC order (web, app, phone) for channel mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order for payment mix and fraud analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the order for operational performance monitoring."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month of order placement for revenue trend and seasonality analysis."
    - name: "subscription_order_flag"
      expr: subscription_order_flag
      comment: "Flags subscription-driven orders for recurring revenue analysis."
    - name: "return_flag"
      expr: return_flag
      comment: "Flags orders with returns for return rate and margin impact analysis."
    - name: "ip_country_code"
      expr: ip_country_code
      comment: "Country of order origin for geographic revenue analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT dtc_order_id)
      comment: "Total DTC orders placed. Core volume metric for DTC channel scale."
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from DTC orders. Primary DTC channel revenue KPI."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV). Key DTC efficiency metric — higher AOV reduces per-order fulfillment cost ratio."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to DTC orders. Measures promotional spend and margin erosion."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected. Measures shipping cost recovery rate."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on DTC orders. Required for tax compliance reporting."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping order subtotal. Measures net product revenue before adjustments."
    - name: "returned_orders"
      expr: COUNT(DISTINCT CASE WHEN return_flag = TRUE THEN dtc_order_id END)
      comment: "Count of orders with at least one return. Measures return volume and associated reverse logistics cost."
    - name: "subscription_orders"
      expr: COUNT(DISTINCT CASE WHEN subscription_order_flag = TRUE THEN dtc_order_id END)
      comment: "Count of subscription-driven orders. Measures recurring revenue order volume."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC order line-level KPIs covering SKU-level revenue, margin, returns, and promotional impact. Used by VP Merchandising and eCommerce to optimize product mix and promotional effectiveness."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`"
  dimensions:
    - name: "dtc_order_line_status"
      expr: dtc_order_line_status
      comment: "Status of the order line (active, cancelled, returned) for line-level funnel analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the line item for operational performance monitoring."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the order line for brand-level revenue analysis."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category of the line item for category mix and performance analysis."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel code of the order line for channel attribution."
    - name: "is_returned"
      expr: is_returned
      comment: "Flags returned line items for return rate and margin impact analysis."
    - name: "subscription_flag"
      expr: subscription_flag
      comment: "Flags subscription line items for recurring revenue analysis."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Flags lines under regulatory hold for compliance risk monitoring."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT dtc_order_line_id)
      comment: "Total DTC order lines. Measures order line volume and product breadth per order."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue across all DTC order lines. SKU-level revenue for product mix analysis."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS across DTC order lines. Required for gross margin calculation."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total line-level discounts. Measures promotional spend at SKU level."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price. Tracks price realization and promotional price erosion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on order lines. Supports tax compliance and reporting."
    - name: "returned_lines"
      expr: COUNT(DISTINCT CASE WHEN is_returned = TRUE THEN dtc_order_line_id END)
      comment: "Count of returned order lines. Measures return volume at SKU level for product quality and satisfaction analysis."
    - name: "avg_line_discount_pct"
      expr: AVG(CAST(line_discount_pct AS DOUBLE))
      comment: "Average discount percentage per line. Measures promotional depth and margin erosion rate."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC return KPIs covering return volume, refund economics, fraud exposure, and quality signals. Used by VP Operations and CFO to manage reverse logistics cost and product quality risk."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_return`"
  dimensions:
    - name: "dtc_return_status"
      expr: dtc_return_status
      comment: "Current status of the return (initiated, received, processed, rejected) for return funnel analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return (defective, wrong item, changed mind) for root cause analysis."
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated for reverse logistics optimization."
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (original payment, store credit, points) for financial reconciliation."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition of returned item (restock, destroy, donate) for inventory and sustainability reporting."
    - name: "fraud_review_flag"
      expr: fraud_review_flag
      comment: "Flags returns under fraud review for risk management."
    - name: "return_date_month"
      expr: DATE_TRUNC('MONTH', return_date)
      comment: "Month of return for trend and seasonality analysis."
    - name: "quality_defect_code"
      expr: quality_defect_code
      comment: "Quality defect code associated with the return for product quality monitoring."
  measures:
    - name: "total_returns"
      expr: COUNT(DISTINCT dtc_return_id)
      comment: "Total DTC returns processed. Core reverse logistics volume metric."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued to consumers. Measures financial impact of returns on DTC revenue."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund amount after restocking fees. Measures actual cash outflow from returns."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per return. Benchmarks return value and financial exposure per incident."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected. Measures cost recovery from return processing."
    - name: "fraud_flagged_returns"
      expr: COUNT(DISTINCT CASE WHEN fraud_review_flag = TRUE THEN dtc_return_id END)
      comment: "Returns flagged for fraud review. Measures return fraud exposure and financial risk."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across returns. Tracks overall return fraud risk level."
    - name: "regulatory_reportable_returns"
      expr: COUNT(DISTINCT CASE WHEN regulatory_report_required = TRUE THEN dtc_return_id END)
      comment: "Returns requiring regulatory reporting (e.g., adverse events). Measures compliance risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level consumer analytics for demographic segmentation, loyalty penetration, and market coverage."
  source: "`vibe_consumer_goods_v1`.`consumer`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household record for active base analysis."
    - name: "household_type"
      expr: household_type
      comment: "Type of household for demographic segmentation."
    - name: "income_band"
      expr: income_band
      comment: "Income band of the household for value-based targeting."
    - name: "life_stage"
      expr: life_stage
      comment: "Life stage of the household for lifecycle marketing."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household for program performance analysis."
    - name: "cltv_band"
      expr: cltv_band
      comment: "CLTV band of the household for value portfolio analysis."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary purchase channel of the household for channel mix analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household for geographic analysis."
    - name: "dwelling_type"
      expr: dwelling_type
      comment: "Dwelling type for demographic and targeting analysis."
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total households in the consumer base; baseline for market penetration analysis."
    - name: "loyalty_enrolled_households"
      expr: COUNT(DISTINCT CASE WHEN loyalty_enrollment_date IS NOT NULL THEN household_id END)
      comment: "Households enrolled in loyalty programs; measures loyalty program household penetration."
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per household; measures household-level engagement."
    - name: "marketing_opted_in_households"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in_flag = TRUE THEN household_id END)
      comment: "Households opted into marketing; measures addressable household audience."
    - name: "digital_engaged_households"
      expr: COUNT(DISTINCT CASE WHEN digital_engagement_flag = TRUE THEN household_id END)
      comment: "Digitally engaged households; measures digital channel penetration."
    - name: "brand_affinity_households"
      expr: COUNT(DISTINCT CASE WHEN brand_affinity_flag = TRUE THEN household_id END)
      comment: "Households with brand affinity; measures brand loyalty at household level."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer interaction analytics for service quality, escalation management, and omnichannel engagement performance."
  source: "`vibe_consumer_goods_v1`.`consumer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of consumer interaction (complaint, inquiry, feedback) for workload analysis."
    - name: "channel"
      expr: channel
      comment: "Channel of the interaction for omnichannel service analysis."
    - name: "interaction_channel"
      expr: interaction_channel
      comment: "Specific interaction channel for granular channel performance."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the interaction for service quality monitoring."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment label for qualitative service experience analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the interaction was escalated for complexity analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the interaction breached SLA; service quality risk indicator."
    - name: "adverse_event_flag"
      expr: adverse_event_flag
      comment: "Whether the interaction involved an adverse event; regulatory risk indicator."
    - name: "interaction_timestamp_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of interaction for volume trend analysis."
    - name: "is_bot_handled"
      expr: is_bot_handled
      comment: "Whether the interaction was handled by a bot for automation efficiency analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total consumer interactions; baseline for service volume and capacity planning."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions escalated; measures service complexity and quality."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions breaching SLA; key service quality KPI."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions; measures overall consumer experience quality."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours; informs service level standard calibration."
    - name: "adverse_event_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN adverse_event_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions involving adverse events; regulatory and safety risk KPI."
    - name: "bot_handled_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_bot_handled = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions handled by bots; measures automation efficiency and cost savings."
    - name: "repeat_contact_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN repeat_contact_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of repeat contacts; measures first-contact resolution failure rate."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty account performance KPIs covering points economics, tier distribution, enrollment health, and fraud exposure. Used by VP Loyalty and CFO to manage program liability and engagement ROI."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the loyalty account (active, suspended, closed) for health monitoring."
    - name: "account_type"
      expr: account_type
      comment: "Type of loyalty account (standard, premium, corporate) for segmented analysis."
    - name: "membership_tier"
      expr: membership_tier
      comment: "Current membership tier of the account for tier-based economics analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the account was enrolled for acquisition channel ROI."
    - name: "country_code"
      expr: country_code
      comment: "Country of the loyalty account for geographic program performance."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort and growth trend analysis."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "CLTV segment of the account holder for value-based tier management."
    - name: "loyalty_account_status"
      expr: loyalty_account_status
      comment: "Operational loyalty account status for active base reporting."
  measures:
    - name: "total_loyalty_accounts"
      expr: COUNT(DISTINCT loyalty_account_id)
      comment: "Total loyalty accounts enrolled. Core program scale metric."
    - name: "active_loyalty_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN loyalty_account_id END)
      comment: "Active loyalty accounts. Measures the engaged, revenue-generating loyalty base."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all accounts. Represents the program's financial liability."
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per account. Indicates engagement depth and redemption pressure."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all accounts. Measures cumulative program engagement volume."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points ever redeemed. Measures program value delivery to consumers."
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total points expired without redemption. Indicates breakage revenue and consumer dissatisfaction risk."
    - name: "fraud_flagged_accounts"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_account_id END)
      comment: "Accounts flagged for fraud. Measures program integrity risk and financial exposure."
    - name: "total_tier_qualification_spend"
      expr: SUM(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Total qualifying spend across accounts. Measures revenue driven by loyalty tier incentives."
    - name: "avg_tier_qualification_spend"
      expr: AVG(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Average qualifying spend per account. Benchmarks tier attainment economics."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program portfolio metrics for program economics, enrollment performance, and points liability management."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_program`"
  dimensions:
    - name: "loyalty_program_status"
      expr: loyalty_program_status
      comment: "Current status of the loyalty program for active portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of loyalty program (points, tiered, cashback) for program design analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country scope of the program for geographic performance analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Primary enrollment channel for acquisition channel analysis."
    - name: "launch_date_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month of program launch for program age and maturity analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(DISTINCT loyalty_program_id)
      comment: "Total loyalty programs; baseline for program portfolio management."
    - name: "total_enrollment_count"
      expr: SUM(CAST(enrollment_count AS DOUBLE))
      comment: "Total enrollments across all programs; measures program reach."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across programs; measures total loyalty liability."
    - name: "total_points_earned"
      expr: SUM(CAST(points_earned AS DOUBLE))
      comment: "Total points earned across programs; measures program engagement volume."
    - name: "avg_earn_rate"
      expr: AVG(CAST(earn_rate AS DOUBLE))
      comment: "Average earn rate across programs; informs program economics calibration."
    - name: "avg_redemption_rate"
      expr: AVG(CAST(redemption_rate AS DOUBLE))
      comment: "Average redemption rate across programs; measures member value realization."
    - name: "avg_cltv_estimate"
      expr: AVG(CAST(cltv_estimate AS DOUBLE))
      comment: "Average CLTV estimate per program; measures program value generation."
    - name: "avg_enrollment_fee"
      expr: AVG(CAST(enrollment_fee AS DOUBLE))
      comment: "Average enrollment fee across programs; informs program monetization strategy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty transaction economics KPIs covering points earn/burn velocity, monetary value, fraud, and program engagement. Used by VP Loyalty and Finance to manage program P&L and consumer engagement."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (earn, redeem, adjust, expire) for economics breakdown."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, pending, reversed) for reconciliation."
    - name: "channel"
      expr: channel
      comment: "Channel where the transaction occurred (DTC, retail, app) for channel attribution."
    - name: "points_direction"
      expr: points_direction
      comment: "Direction of points movement (credit, debit) for earn vs burn analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the transaction for geographic program performance."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for trend and seasonality analysis."
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Flags bonus/promotional transactions for incremental program cost analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Fraud indicator for risk monitoring and financial exposure assessment."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT loyalty_transaction_id)
      comment: "Total loyalty transactions. Measures program engagement volume and activity."
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points issued or redeemed across all transactions. Core program velocity metric."
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points per transaction. Benchmarks earn/burn rate per engagement event."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of loyalty transactions. Measures revenue associated with loyalty activity."
    - name: "avg_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per loyalty transaction. Benchmarks transaction quality."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend driving loyalty points. Measures revenue directly attributable to loyalty incentives."
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value AS DOUBLE))
      comment: "Total monetary value of points redeemed. Represents program cost/liability discharged."
    - name: "fraud_flagged_transactions"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_transaction_id END)
      comment: "Transactions flagged for fraud. Measures program integrity risk and financial exposure."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier applied to transactions. Measures promotional generosity and program cost inflation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score KPIs covering score distribution, sentiment, closed-loop performance, and brand/channel breakdown. Used by CMO and VP Customer Experience to steer satisfaction and loyalty investment."
  source: "`vibe_consumer_goods_v1`.`consumer`.`nps_response`"
  dimensions:
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (promoter, passive, detractor) for satisfaction distribution analysis."
    - name: "channel"
      expr: channel
      comment: "Channel of the NPS survey response for channel satisfaction benchmarking."
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered for survey methodology analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the NPS response for category-level satisfaction."
    - name: "country_code"
      expr: country_code
      comment: "Country of the respondent for geographic satisfaction benchmarking."
    - name: "response_date_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month of response for NPS trend analysis."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Flags loyalty members for loyalty vs non-loyalty NPS comparison."
    - name: "closed_loop_status"
      expr: closed_loop_status
      comment: "Status of closed-loop follow-up action for detractor recovery monitoring."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment label from verbatim analysis for qualitative NPS enrichment."
  measures:
    - name: "total_nps_responses"
      expr: COUNT(DISTINCT nps_response_id)
      comment: "Total NPS responses collected. Measures survey coverage and statistical confidence."
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'promoter' THEN nps_response_id END)
      comment: "Count of promoter responses (score 9-10). Used in NPS calculation numerator."
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN nps_category = 'detractor' THEN nps_response_id END)
      comment: "Count of detractor responses (score 0-6). Used in NPS calculation and churn risk assessment."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from verbatim analysis. Measures qualitative satisfaction beyond NPS score."
    - name: "follow_up_required_responses"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required_flag = TRUE THEN nps_response_id END)
      comment: "Responses requiring closed-loop follow-up. Measures detractor recovery workload."
    - name: "repeat_buyer_responses"
      expr: COUNT(DISTINCT CASE WHEN repeat_buyer_flag = TRUE THEN nps_response_id END)
      comment: "NPS responses from repeat buyers. Measures satisfaction among high-value repeat consumers."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program performance metrics for acquisition efficiency, reward economics, and fraud risk management."
  source: "`vibe_consumer_goods_v1`.`consumer`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (pending, converted, expired) for pipeline analysis."
    - name: "referral_channel"
      expr: referral_channel
      comment: "Channel through which the referral was made for channel attribution."
    - name: "channel"
      expr: channel
      comment: "General channel of the referral for omnichannel analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the referral for geographic program performance."
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward offered for referral economics analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the referral is flagged for fraud for risk management."
    - name: "self_referral_flag"
      expr: self_referral_flag
      comment: "Whether the referral is a self-referral for abuse detection."
    - name: "referral_date_month"
      expr: DATE_TRUNC('month', referral_date)
      comment: "Month of referral for program volume trend analysis."
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total referrals generated; baseline for referral program scale."
    - name: "converted_referrals"
      expr: COUNT(DISTINCT CASE WHEN referral_status = 'CONVERTED' THEN referral_id END)
      comment: "Count of referrals that converted to customers; primary referral program success KPI."
    - name: "referral_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN referral_status = 'CONVERTED' THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals that converted; key acquisition efficiency metric."
    - name: "total_referrer_reward_amount"
      expr: SUM(CAST(referrer_reward_amount AS DOUBLE))
      comment: "Total rewards paid to referrers; measures referral program cost."
    - name: "total_referred_reward_amount"
      expr: SUM(CAST(referred_reward_amount AS DOUBLE))
      comment: "Total rewards paid to referred consumers; measures acquisition incentive cost."
    - name: "total_reward_points"
      expr: SUM(CAST(reward_points AS DOUBLE))
      comment: "Total reward points issued through referrals; measures loyalty program impact of referrals."
    - name: "fraud_referral_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals flagged as fraudulent; drives fraud prevention investment."
    - name: "self_referral_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN self_referral_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of self-referrals; measures program abuse and policy enforcement need."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_research_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer research participation KPIs covering study enrollment, completion rates, incentive spend, and data quality. Used by VP Consumer Insights and R&D to manage research program effectiveness and consumer panel health."
  source: "`vibe_consumer_goods_v1`.`consumer`.`research_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current participation status (enrolled, completed, withdrawn, screened-out) for study funnel analysis."
    - name: "research_participation_status"
      expr: research_participation_status
      comment: "Operational status of the participation record."
    - name: "study_type"
      expr: study_type
      comment: "Type of research study (concept test, usage test, ethnography) for research portfolio analysis."
    - name: "participation_type"
      expr: participation_type
      comment: "Type of participation (in-person, online, diary) for methodology analysis."
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Channel used to recruit the participant for recruitment effectiveness analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (cash, points, product) for incentive cost analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the participant for geographic research coverage."
    - name: "completion_flag"
      expr: completion_flag
      comment: "Flags completed participations for completion rate calculation."
    - name: "participation_date_month"
      expr: DATE_TRUNC('MONTH', participation_date)
      comment: "Month of participation for research activity trend analysis."
  measures:
    - name: "total_participations"
      expr: COUNT(DISTINCT research_participation_id)
      comment: "Total research participations. Measures research program scale and consumer engagement."
    - name: "completed_participations"
      expr: COUNT(DISTINCT CASE WHEN completion_flag = TRUE THEN research_participation_id END)
      comment: "Completed participations. Measures usable data yield from research programs."
    - name: "total_incentive_spend"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive spend across all participations. Measures research program cost."
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive per participation. Benchmarks research cost per data point."
    - name: "avg_response_quality_score"
      expr: AVG(CAST(response_quality_score AS DOUBLE))
      comment: "Average response quality score. Measures data quality of research outputs."
    - name: "opted_out_participants"
      expr: COUNT(DISTINCT CASE WHEN opt_out_flag = TRUE THEN research_participation_id END)
      comment: "Participants who opted out. Measures panel attrition and consent management effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment portfolio metrics for audience sizing, personalization eligibility, and segment strategy management."
  source: "`vibe_consumer_goods_v1`.`consumer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, predictive) for portfolio analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment for active portfolio management."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit owning the segment for governance and accountability."
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope of the segment for omnichannel activation planning."
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Whether the segment is eligible for personalization."
    - name: "consent_required"
      expr: consent_required
      comment: "Whether consent is required for segment activation; compliance dimension."
    - name: "is_suppression_segment"
      expr: is_suppression_segment
      comment: "Whether the segment is a suppression list for exclusion management."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total consumer segments defined; measures segmentation portfolio breadth."
    - name: "active_segments"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN segment_id END)
      comment: "Active segments available for activation; measures actionable audience portfolio."
    - name: "total_target_audience_size"
      expr: SUM(CAST(target_audience_size AS DOUBLE))
      comment: "Total target audience size across all segments; measures total addressable audience."
    - name: "avg_target_audience_size"
      expr: AVG(CAST(target_audience_size AS DOUBLE))
      comment: "Average segment size; informs segment granularity and activation efficiency."
    - name: "personalization_eligible_segment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_eligible = TRUE THEN segment_id END) / NULLIF(COUNT(DISTINCT segment_id), 0), 2)
      comment: "Percentage of segments eligible for personalization; measures personalization program reach."
    - name: "avg_min_confidence_score"
      expr: AVG(CAST(min_confidence_score AS DOUBLE))
      comment: "Average minimum confidence score threshold across segments; measures model quality standards."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment membership KPIs covering segment size, activation, suppression, and engagement scoring. Used by VP Marketing and Data Science to evaluate segmentation effectiveness and campaign targeting quality."
  source: "`vibe_consumer_goods_v1`.`consumer`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (active, expired, suppressed) for segment health monitoring."
    - name: "segment_membership_status"
      expr: segment_membership_status
      comment: "Operational status of the segment membership record."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the shopper to the segment (rule-based, ML, manual) for model governance."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier of the segment member for value-based segment analysis."
    - name: "channel"
      expr: channel
      comment: "Channel associated with the segment membership for channel-specific targeting."
    - name: "is_control_group"
      expr: is_control_group
      comment: "Flags control group members for A/B test and holdout analysis."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Flags suppressed members for compliance and deliverability analysis."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of segment assignment for segment growth trend analysis."
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Flags members eligible for personalization for addressable personalization audience sizing."
  measures:
    - name: "total_segment_memberships"
      expr: COUNT(DISTINCT segment_membership_id)
      comment: "Total segment membership records. Measures total segmentation coverage."
    - name: "active_segment_members"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN segment_membership_id END)
      comment: "Active segment members. Measures the actionable, targetable segment population."
    - name: "suppressed_members"
      expr: COUNT(DISTINCT CASE WHEN suppression_flag = TRUE THEN segment_membership_id END)
      comment: "Suppressed segment members. Measures compliance-driven audience reduction."
    - name: "avg_membership_score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership/propensity score. Measures segment quality and targeting precision."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for segment assignments. Measures segmentation model reliability."
    - name: "personalization_eligible_members"
      expr: COUNT(DISTINCT CASE WHEN personalization_eligible = TRUE THEN segment_membership_id END)
      comment: "Members eligible for personalization. Defines the personalization-addressable audience."
    - name: "control_group_members"
      expr: COUNT(DISTINCT CASE WHEN is_control_group = TRUE THEN segment_membership_id END)
      comment: "Control group members. Measures holdout group size for campaign incrementality measurement."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shopper master KPIs tracking active consumer base, loyalty enrollment, lifetime value, and engagement health. Used by CMO and VP Consumer Insights to steer acquisition, retention, and loyalty investment."
  source: "`vibe_consumer_goods_v1`.`consumer`.`shopper`"
  dimensions:
    - name: "consumer_type"
      expr: consumer_type
      comment: "Classifies shopper as DTC, loyalty member, panel participant, etc. for cohort analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the shopper (active, lapsed, churned, new) for retention segmentation."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the shopper was acquired (DTC, retail, referral, etc.) for CAC analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the shopper for geographic performance breakdown."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty tier of the shopper for tier-based value analysis."
    - name: "gender"
      expr: gender
      comment: "Gender of the shopper for demographic segmentation."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "CLTV-based value segment of the shopper (high, mid, low value) for prioritization."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language for localization and communication strategy."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of shopper acquisition for cohort and trend analysis."
    - name: "shopper_status"
      expr: shopper_status
      comment: "Operational status of the shopper record (active, inactive, merged, deleted)."
  measures:
    - name: "total_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique shoppers in the consumer base. Core KPI for market reach and consumer base sizing."
    - name: "active_shoppers"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN shopper_id END)
      comment: "Count of shoppers with active status. Tracks the engaged, reachable consumer base."
    - name: "loyalty_enrolled_shoppers"
      expr: COUNT(DISTINCT CASE WHEN loyalty_enrollment_date IS NOT NULL THEN shopper_id END)
      comment: "Shoppers enrolled in at least one loyalty program. Measures loyalty program penetration."
    - name: "marketing_opted_in_shoppers"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN shopper_id END)
      comment: "Shoppers who have opted into marketing communications. Defines the addressable marketing audience."
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Sum of lifetime value across all shoppers. Measures total consumer equity in the portfolio."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average lifetime value per shopper. Benchmarks consumer quality and informs acquisition spend thresholds."
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total outstanding loyalty points balance across all shoppers. Represents loyalty liability on the balance sheet."
    - name: "email_opt_in_shoppers"
      expr: COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN shopper_id END)
      comment: "Shoppers opted into email communications. Defines the email-reachable audience for campaign planning."
    - name: "sms_opt_in_shoppers"
      expr: COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN shopper_id END)
      comment: "Shoppers opted into SMS communications. Defines the SMS-reachable audience."
    - name: "identity_verified_shoppers"
      expr: COUNT(DISTINCT CASE WHEN identity_verified = TRUE THEN shopper_id END)
      comment: "Shoppers with verified identity. Measures data quality and fraud risk mitigation coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC subscription KPIs covering active subscriber base, recurring revenue, churn, and trial conversion. Used by VP eCommerce and CFO to manage subscription P&L and growth strategy."
  source: "`vibe_consumer_goods_v1`.`consumer`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current subscription status (active, paused, cancelled, trial) for subscriber base health."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (replenishment, curated, membership) for product mix analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for revenue timing analysis."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Delivery frequency for operational planning."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for payment failure risk analysis."
    - name: "trial_flag"
      expr: trial_flag
      comment: "Flags trial subscriptions for trial-to-paid conversion analysis."
    - name: "pause_flag"
      expr: pause_flag
      comment: "Flags paused subscriptions for churn risk and reactivation opportunity analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of subscription start for cohort and growth trend analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation for churn root cause analysis."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total subscriptions. Core subscriber base scale metric."
    - name: "active_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'active' THEN subscription_id END)
      comment: "Active subscriptions. Measures the revenue-generating subscriber base."
    - name: "trial_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN trial_flag = TRUE THEN subscription_id END)
      comment: "Trial subscriptions. Measures trial pipeline for conversion forecasting."
    - name: "paused_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN pause_flag = TRUE THEN subscription_id END)
      comment: "Paused subscriptions. Measures at-risk subscribers for reactivation campaigns."
    - name: "total_recurring_amount"
      expr: SUM(CAST(recurring_amount AS DOUBLE))
      comment: "Total recurring revenue amount across active subscriptions. Measures MRR/ARR base."
    - name: "avg_recurring_amount"
      expr: AVG(CAST(recurring_amount AS DOUBLE))
      comment: "Average recurring revenue per subscription. Benchmarks subscription value and pricing effectiveness."
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net subscription price after discounts. Measures realized subscription revenue."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to subscriptions. Measures promotional depth and margin erosion."
$$;
