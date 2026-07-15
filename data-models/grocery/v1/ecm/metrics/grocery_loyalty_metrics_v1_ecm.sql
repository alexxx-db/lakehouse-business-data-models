-- Metric views for domain: loyalty | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_points_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators derived from points transaction events."
  source: "`grocery_ecm`.`loyalty`.`points_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day bucket)."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where transaction occurred."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel source of the transaction."
  measures:
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of transactions."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction amount."
    - name: "distinct_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Number of unique members involved."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of point transactions."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance metrics for loyalty program."
  source: "`grocery_ecm`.`loyalty`.`loyalty_redemption`"
  dimensions:
    - name: "redemption_date"
      expr: DATE_TRUNC('day', redemption_timestamp)
      comment: "Date of redemption (day bucket)."
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g., points, fuel)."
    - name: "channel"
      expr: channel
      comment: "Channel through which redemption occurred."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location of redemption."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at time of redemption."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Number of loyalty redemptions."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed in redemptions."
    - name: "total_basket_amount"
      expr: SUM(CAST(basket_total_amount AS DOUBLE))
      comment: "Total basket amount after redemption."
    - name: "avg_basket_amount"
      expr: AVG(CAST(basket_total_amount AS DOUBLE))
      comment: "Average basket amount after redemption."
    - name: "distinct_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Unique members who redeemed."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core membership health and value metrics."
  source: "`grocery_ecm`.`loyalty`.`membership`"
  dimensions:
    - name: "tier_id"
      expr: tier_id
      comment: "Loyalty tier identifier."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled."
    - name: "enrollment_date"
      expr: DATE_TRUNC('day', enrollment_date)
      comment: "Date of enrollment (day bucket)."
    - name: "digital_wallet_linked_flag"
      expr: digital_wallet_linked_flag
      comment: "Whether member linked a digital wallet."
    - name: "primary_household_member_flag"
      expr: primary_household_member_flag
      comment: "Flag indicating primary household member."
  measures:
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total number of loyalty memberships."
    - name: "active_member_count"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN 1 END)
      comment: "Count of members with active status."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Cumulative points earned by all members."
    - name: "avg_annual_spend"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per member."
    - name: "distinct_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Number of unique households represented."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`loyalty_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement event activity and interaction metrics."
  source: "`grocery_ecm`.`loyalty`.`engagement_event`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the engagement event."
    - name: "channel"
      expr: channel
      comment: "Channel through which the event occurred."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the event."
    - name: "app_version"
      expr: app_version
      comment: "Application version at event time."
    - name: "event_type"
      expr: event_type
      comment: "Categorization of the engagement event."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of engagement events recorded."
    - name: "total_dwell_time_minutes"
      expr: SUM(CAST(dwell_time_minutes AS DOUBLE))
      comment: "Aggregate dwell time across events (minutes)."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(dwell_time_minutes AS DOUBLE))
      comment: "Average dwell time per event (minutes)."
    - name: "distinct_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Unique members generating events."
    - name: "distinct_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers involved in events."
$$;
