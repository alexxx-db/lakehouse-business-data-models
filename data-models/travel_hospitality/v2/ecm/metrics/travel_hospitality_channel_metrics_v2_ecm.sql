-- Metric views for domain: channel | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core booking performance metrics across distribution channels, tracking revenue, commission costs, and booking behavior patterns"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_booking`"
  dimensions:
    - name: "booking_date"
      expr: DATE_TRUNC('day', booking_timestamp)
      comment: "Date the booking was created, for time-series analysis"
    - name: "check_in_date"
      expr: check_in_date
      comment: "Guest arrival date, for stay-date analysis and forward-looking demand"
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel category (OTA, Direct, GDS, Metasearch, etc.)"
    - name: "booking_status"
      expr: booking_status
      comment: "Current booking status (Confirmed, Cancelled, Modified, No-Show)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment classification for demand analysis"
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the booking was cancelled"
    - name: "lead_time_bucket"
      expr: CASE WHEN CAST(lead_time_days AS INT) <= 7 THEN '0-7 days' WHEN CAST(lead_time_days AS INT) <= 30 THEN '8-30 days' WHEN CAST(lead_time_days AS INT) <= 90 THEN '31-90 days' ELSE '90+ days' END
      comment: "Booking window cohort for lead-time analysis"
    - name: "length_of_stay_bucket"
      expr: CASE WHEN CAST(length_of_stay_nights AS INT) = 1 THEN '1 night' WHEN CAST(length_of_stay_nights AS INT) <= 3 THEN '2-3 nights' WHEN CAST(length_of_stay_nights AS INT) <= 7 THEN '4-7 nights' ELSE '8+ nights' END
      comment: "Length of stay cohort for stay pattern analysis"
    - name: "rate_type"
      expr: rate_type
      comment: "Rate plan type (BAR, Corporate, Negotiated, Package, etc.)"
    - name: "is_rate_parity_compliant"
      expr: is_rate_parity_compliant
      comment: "Flag indicating whether the booking rate complied with rate parity agreements"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of bookings created across all channels"
    - name: "total_room_nights"
      expr: SUM(CAST(number_of_rooms AS DOUBLE) * CAST(length_of_stay_nights AS DOUBLE))
      comment: "Total room nights booked, key volume metric for inventory utilization"
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross revenue from bookings before commissions and fees"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after channel commissions and connectivity fees"
    - name: "total_channel_commission"
      expr: SUM(CAST(channel_commission_amount AS DOUBLE))
      comment: "Total commission paid to distribution channels"
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity and transaction fees paid to channel partners"
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate across all bookings, key pricing metric"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average booking window in days, indicator of booking behavior and demand patterns"
    - name: "avg_length_of_stay"
      expr: AVG(CAST(length_of_stay_nights AS DOUBLE))
      comment: "Average length of stay in nights, key for revenue optimization"
    - name: "cancellation_count"
      expr: SUM(CASE WHEN is_cancelled = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of cancelled bookings, key for forecasting and revenue management"
    - name: "unique_guests"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Distinct guest count, measure of customer reach"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel commission and cost-of-acquisition metrics for distribution cost management and profitability analysis"
  source: "`vibe_travel_hospitality_v1`.`channel`.`commission_accrual`"
  dimensions:
    - name: "accrual_date"
      expr: accrual_date
      comment: "Date the commission was accrued for financial reporting"
    - name: "accrual_month"
      expr: DATE_TRUNC('month', accrual_date)
      comment: "Month of commission accrual for monthly P&L analysis"
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel category for cost analysis by channel"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Commission accrual status (Accrued, Invoiced, Paid, Disputed, Reversed)"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (Standard, Preferred, Promotional, etc.)"
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (Net Rate, Gross Rate, Room Revenue, etc.)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for segment-level profitability analysis"
    - name: "is_commissionable"
      expr: is_commissionable
      comment: "Flag indicating whether the booking is subject to commission"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for financial reporting integration"
  measures:
    - name: "total_commission_accruals"
      expr: COUNT(1)
      comment: "Total number of commission accrual records"
    - name: "total_commission_amount_local"
      expr: SUM(CAST(commission_amount_local AS DOUBLE))
      comment: "Total commission expense in local currency"
    - name: "total_commission_amount_base"
      expr: SUM(CAST(commission_amount_base AS DOUBLE))
      comment: "Total commission expense in base reporting currency"
    - name: "total_connectivity_fees"
      expr: SUM(CAST(connectivity_fee_amount AS DOUBLE))
      comment: "Total connectivity and transaction fees paid to channels"
    - name: "total_cost_of_acquisition"
      expr: SUM(CAST(total_cost_of_acquisition AS DOUBLE))
      comment: "Total cost to acquire bookings including commissions and fees, key profitability metric"
    - name: "total_gross_booking_value"
      expr: SUM(CAST(gross_booking_value AS DOUBLE))
      comment: "Total gross booking value subject to commission"
    - name: "total_room_nights"
      expr: SUM(CAST(room_nights AS DOUBLE))
      comment: "Total room nights associated with commission accruals"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate percentage across accruals"
    - name: "avg_adr"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average Daily Rate for commissioned bookings"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_rate_parity_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate parity compliance and violation tracking metrics for distribution integrity and contract enforcement"
  source: "`vibe_travel_hospitality_v1`.`channel`.`rate_parity_audit`"
  dimensions:
    - name: "audit_date"
      expr: DATE_TRUNC('day', audit_timestamp)
      comment: "Date the rate parity audit was performed"
    - name: "stay_date"
      expr: stay_date
      comment: "Stay date being audited for rate parity compliance"
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type being audited"
    - name: "audit_status"
      expr: audit_status
      comment: "Status of the audit record (Pending, Reviewed, Disputed, Resolved)"
    - name: "is_parity_violation"
      expr: is_parity_violation
      comment: "Flag indicating whether a rate parity violation was detected"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of rate parity violation (Undercut, Overcharge, Content Mismatch, etc.)"
    - name: "violation_severity"
      expr: violation_severity
      comment: "Severity classification of the violation (Low, Medium, High, Critical)"
    - name: "rate_plan_code"
      expr: rate_plan_code
      comment: "Rate plan code being audited"
    - name: "monitoring_source"
      expr: monitoring_source
      comment: "Source system or tool that detected the rate discrepancy"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of rate parity audits performed"
    - name: "total_violations"
      expr: SUM(CASE WHEN is_parity_violation = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of rate parity violations detected"
    - name: "avg_direct_rate"
      expr: AVG(CAST(direct_rate AS DOUBLE))
      comment: "Average direct booking rate across audits"
    - name: "avg_observed_rate"
      expr: AVG(CAST(observed_rate AS DOUBLE))
      comment: "Average observed channel rate across audits"
    - name: "avg_rate_variance"
      expr: AVG(CAST(rate_variance AS DOUBLE))
      comment: "Average absolute rate variance between direct and channel rates"
    - name: "avg_rate_variance_pct"
      expr: AVG(CAST(rate_variance_pct AS DOUBLE))
      comment: "Average rate variance as percentage of direct rate"
    - name: "total_contracted_parity_rate"
      expr: SUM(CAST(contracted_parity_rate AS DOUBLE))
      comment: "Sum of contracted parity rates for comparison analysis"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution channel contract performance and compliance metrics for partnership management"
  source: "`vibe_travel_hospitality_v1`.`channel`.`channel_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the channel contract (Active, Expired, Pending, Terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of channel contract (Master Agreement, Property-Level, Rate Agreement, etc.)"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the contract became effective"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date the contract expires or expired"
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation in the contract"
    - name: "payment_model"
      expr: payment_model
      comment: "Payment model defined in contract (Merchant, Agency, Hybrid)"
    - name: "preferred_partner_tier"
      expr: preferred_partner_tier
      comment: "Partner tier level for preferential treatment analysis"
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Flag indicating whether contract includes rate parity clause"
    - name: "bar_access"
      expr: bar_access
      comment: "Flag indicating whether partner has access to Best Available Rate"
    - name: "lra_obligation"
      expr: lra_obligation
      comment: "Flag indicating Last Room Availability obligation"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of channel contracts"
    - name: "active_contracts"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active channel contracts"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all contracts"
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee AS DOUBLE))
      comment: "Average connectivity fee per contract"
    - name: "total_marketing_coop"
      expr: SUM(CAST(marketing_coop_amount AS DOUBLE))
      comment: "Total marketing co-op investment committed across contracts"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA partner performance and relationship metrics for strategic partnership management"
  source: "`vibe_travel_hospitality_v1`.`channel`.`ota_partner`"
  dimensions:
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the OTA partner relationship (Active, Inactive, Suspended, Terminated)"
    - name: "partner_type"
      expr: partner_type
      comment: "Type of OTA partner (Global OTA, Regional OTA, Metasearch, Wholesaler, etc.)"
    - name: "preferred_partner"
      expr: preferred_partner
      comment: "Flag indicating preferred partner status for prioritization"
    - name: "commission_model"
      expr: commission_model
      comment: "Commission model used by the partner (Percentage, Flat Fee, Tiered, etc.)"
    - name: "payment_collection_party"
      expr: payment_collection_party
      comment: "Party responsible for collecting payment (Merchant, Agency)"
    - name: "inventory_allocation_model"
      expr: inventory_allocation_model
      comment: "Inventory allocation model (Free Sell, Allotment, Hybrid)"
    - name: "last_room_availability"
      expr: last_room_availability
      comment: "Flag indicating whether partner has LRA access"
    - name: "rate_parity_clause"
      expr: rate_parity_clause
      comment: "Flag indicating whether rate parity clause is in effect"
    - name: "market_coverage"
      expr: market_coverage
      comment: "Geographic market coverage of the partner (Global, Regional, Domestic)"
    - name: "mobile_app_channel"
      expr: mobile_app_channel
      comment: "Flag indicating whether partner has mobile app distribution"
  measures:
    - name: "total_partners"
      expr: COUNT(1)
      comment: "Total number of OTA partners"
    - name: "active_partners"
      expr: SUM(CASE WHEN partner_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active OTA partners"
    - name: "avg_base_commission_rate"
      expr: AVG(CAST(base_commission_rate_pct AS DOUBLE))
      comment: "Average base commission rate across all partners"
    - name: "avg_preferred_commission_rate"
      expr: AVG(CAST(preferred_commission_rate_pct AS DOUBLE))
      comment: "Average preferred partner commission rate"
    - name: "avg_connectivity_fee"
      expr: AVG(CAST(connectivity_fee_usd AS DOUBLE))
      comment: "Average monthly connectivity fee in USD"
    - name: "avg_content_score"
      expr: AVG(CAST(content_score AS DOUBLE))
      comment: "Average content quality score across partners"
    - name: "avg_review_score"
      expr: AVG(CAST(review_score AS DOUBLE))
      comment: "Average guest review score on partner platforms"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_wholesale_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale allotment utilization and performance metrics for contracted inventory management"
  source: "`vibe_travel_hospitality_v1`.`channel`.`wholesale_allotment`"
  dimensions:
    - name: "allotment_status"
      expr: allotment_status
      comment: "Current status of the allotment (Active, Released, Expired, Closed)"
    - name: "allotment_type"
      expr: allotment_type
      comment: "Type of allotment (Hard Block, Soft Block, Free Sell)"
    - name: "stay_date_from"
      expr: stay_date_from
      comment: "Start date of the allotment stay period"
    - name: "stay_date_to"
      expr: stay_date_to
      comment: "End date of the allotment stay period"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for the allotment"
    - name: "is_stop_sell"
      expr: is_stop_sell
      comment: "Flag indicating whether allotment is currently stopped"
    - name: "last_room_availability"
      expr: last_room_availability
      comment: "Flag indicating whether LRA applies to this allotment"
    - name: "rate_parity_flag"
      expr: rate_parity_flag
      comment: "Flag indicating whether rate parity monitoring is active"
  measures:
    - name: "total_allotments"
      expr: COUNT(1)
      comment: "Total number of wholesale allotment records"
    - name: "total_contracted_rooms"
      expr: SUM(CAST(contracted_allotment_size AS DOUBLE))
      comment: "Total contracted room inventory across all allotments"
    - name: "total_consumed_rooms"
      expr: SUM(CAST(consumed_units AS DOUBLE))
      comment: "Total rooms consumed from allotments"
    - name: "total_remaining_rooms"
      expr: SUM(CAST(remaining_units AS DOUBLE))
      comment: "Total remaining room inventory in allotments"
    - name: "total_pickup"
      expr: SUM(CAST(pickup_count AS DOUBLE))
      comment: "Total room pickups from allotments"
    - name: "total_cancellations"
      expr: SUM(CAST(cancellation_count AS DOUBLE))
      comment: "Total cancellations from allotments"
    - name: "avg_contracted_net_rate"
      expr: AVG(CAST(contracted_net_rate AS DOUBLE))
      comment: "Average contracted net rate across allotments"
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate for comparison with contracted rates"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate on allotment bookings"
    - name: "avg_wash_factor_pct"
      expr: AVG(CAST(wash_factor_pct AS DOUBLE))
      comment: "Average wash factor percentage for allotment forecasting"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`channel_metasearch_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metasearch advertising performance and ROI metrics for paid distribution channel optimization"
  source: "`vibe_travel_hospitality_v1`.`channel`.`metasearch_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the metasearch listing (Active, Paused, Expired)"
    - name: "platform_name"
      expr: platform_name
      comment: "Metasearch platform name (Google Hotel Ads, TripAdvisor, Trivago, etc.)"
    - name: "bid_strategy_type"
      expr: bid_strategy_type
      comment: "Bidding strategy employed (Manual, Automated, Target CPA, Target ROAS)"
    - name: "listing_type"
      expr: listing_type
      comment: "Type of listing (Free Booking Link, Commission, CPC)"
    - name: "device_type"
      expr: device_type
      comment: "Device type for performance segmentation (Desktop, Mobile, Tablet)"
    - name: "target_market"
      expr: target_market
      comment: "Target geographic market for the listing"
    - name: "is_direct_booking_eligible"
      expr: is_direct_booking_eligible
      comment: "Flag indicating whether listing supports direct booking"
    - name: "is_rate_parity_monitored"
      expr: is_rate_parity_monitored
      comment: "Flag indicating whether rate parity is monitored for this listing"
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start date of the reporting period"
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of metasearch listings"
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total ad impressions across all listings"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on metasearch listings"
    - name: "total_bookings"
      expr: SUM(CAST(booking_count AS DOUBLE))
      comment: "Total bookings attributed to metasearch listings"
    - name: "total_booking_revenue"
      expr: SUM(CAST(booking_revenue AS DOUBLE))
      comment: "Total revenue from metasearch-attributed bookings"
    - name: "total_spend"
      expr: SUM(CAST(total_spend AS DOUBLE))
      comment: "Total advertising spend on metasearch platforms"
    - name: "avg_cpc"
      expr: AVG(CAST(cpc_actual AS DOUBLE))
      comment: "Average cost per click across listings"
    - name: "avg_cpa"
      expr: AVG(CAST(cpa_actual AS DOUBLE))
      comment: "Average cost per acquisition, key efficiency metric"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate from click to booking"
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click-through rate from impression to click"
    - name: "avg_return_on_ad_spend"
      expr: AVG(CAST(return_on_ad_spend AS DOUBLE))
      comment: "Average ROAS, critical profitability metric for paid channels"
    - name: "avg_bid_amount"
      expr: AVG(CAST(bid_amount AS DOUBLE))
      comment: "Average bid amount across listings"
$$;