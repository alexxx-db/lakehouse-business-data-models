-- Metric views for domain: reservation | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking package revenue and performance KPIs covering package revenue mix, refundability, commission eligibility, and redemption patterns. Used by Revenue Management and Marketing to optimize package strategy and ancillary revenue."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_package`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level package performance analysis."
    - name: "package_category"
      expr: package_category
      comment: "Category of the package (romance, family, spa, F&B) for package mix and demand analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the booking package (active, cancelled, redeemed) for lifecycle analysis."
    - name: "is_refundable"
      expr: is_refundable
      comment: "Whether the package is refundable, for revenue certainty and refund liability analysis."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Whether the package is commission-eligible, for distribution cost analysis."
    - name: "is_inclusive"
      expr: is_inclusive
      comment: "Whether the package is all-inclusive, for package type mix analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the package is mandatory, for mandatory vs optional package revenue analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment for package demand segmentation."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_date)
      comment: "Month of package redemption for redemption trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency package revenue reporting."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of booking packages. Baseline volume for package adoption analysis."
    - name: "total_package_rate_revenue"
      expr: SUM(CAST(package_rate_amount AS DOUBLE))
      comment: "Total package rate revenue. Primary package revenue KPI for ancillary revenue management."
    - name: "total_rooms_revenue_from_packages"
      expr: SUM(CAST(rooms_revenue_amount AS DOUBLE))
      comment: "Total rooms revenue component from packages. Tracks rooms revenue contribution within package bundles."
    - name: "total_fb_revenue_from_packages"
      expr: SUM(CAST(fb_revenue_amount AS DOUBLE))
      comment: "Total F&B revenue component from packages. Tracks F&B revenue contribution within package bundles."
    - name: "total_other_revenue_from_packages"
      expr: SUM(CAST(other_revenue_amount AS DOUBLE))
      comment: "Total other revenue component from packages. Tracks miscellaneous ancillary revenue within packages."
    - name: "total_package_cost"
      expr: SUM(CAST(package_cost_amount AS DOUBLE))
      comment: "Total cost of delivering booking packages. Tracks package margin and profitability."
    - name: "avg_package_rate"
      expr: AVG(CAST(package_rate_amount AS DOUBLE))
      comment: "Average package rate amount. Benchmarks package pricing strategy."
    - name: "package_margin_amount"
      expr: SUM(CAST(package_rate_amount AS DOUBLE) - CAST(package_cost_amount AS DOUBLE))
      comment: "Total package margin (rate minus cost). Core profitability KPI for package strategy decisions."
    - name: "refundable_package_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refundable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages that are refundable. Tracks refund liability exposure in the package portfolio."
    - name: "commission_eligible_package_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commission_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages eligible for commission. Tracks distribution cost exposure in the package portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking status change event analytics covering modification patterns, SLA compliance, revenue impact of changes, and penalty fee collection. Used by Operations and Revenue Management to monitor booking lifecycle quality."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking status event (cancellation, modification, no-show, check-in) for event mix analysis."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification (date change, room type change, rate change) for modification pattern analysis."
    - name: "new_status"
      expr: new_status
      comment: "New booking status after the event for status transition analysis."
    - name: "previous_status"
      expr: previous_status
      comment: "Previous booking status before the event for funnel and transition analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of the status change event for trend analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the status change met SLA targets, for operational quality monitoring."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the status change is under dispute, for chargeback and dispute risk monitoring."
    - name: "guest_notification_sent_flag"
      expr: guest_notification_sent_flag
      comment: "Whether the guest was notified of the status change, for communication compliance."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of booking status change events. Baseline volume for booking lifecycle activity."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from booking status changes. Quantifies financial effect of modifications and cancellations."
    - name: "total_penalty_fees_collected"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees collected from status change events. Tracks revenue recovery from policy enforcement."
    - name: "avg_penalty_fee"
      expr: AVG(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Average penalty fee per status change event. Benchmarks penalty policy effectiveness."
    - name: "total_rate_difference"
      expr: SUM(CAST(rate_difference_amount AS DOUBLE))
      comment: "Total rate difference from booking modifications. Tracks revenue uplift or dilution from rate changes."
    - name: "sla_compliant_event_count"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of status change events that met SLA targets. Tracks operational service quality."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status change events meeting SLA. Core operational quality KPI for Front Office management."
    - name: "guest_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status change events where guest was notified. Tracks communication compliance and guest experience quality."
    - name: "disputed_event_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed status change events. Monitors chargeback and dispute risk volume."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation analytics covering penalty revenue, refund exposure, OTA chargeback risk, and waiver patterns. Used by Revenue Management and Finance to quantify cancellation financial impact and policy effectiveness."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level cancellation analysis."
    - name: "cancellation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of cancellation event for trend analysis."
    - name: "original_arrival_month"
      expr: DATE_TRUNC('month', original_arrival_date)
      comment: "Month of the original intended arrival for lead-time and seasonality analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Cancellation reason code for root-cause analysis and policy refinement."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a penalty was applicable, for policy enforcement analysis."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether a waiver was granted, for waiver rate and revenue leakage analysis."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Whether the cancellation is eligible for refund, for cash flow and liability analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the cancellation is under dispute, for chargeback risk monitoring."
    - name: "ota_chargeback_eligible_flag"
      expr: ota_chargeback_eligible_flag
      comment: "Whether the OTA chargeback is eligible, for OTA contract compliance monitoring."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the cancellation for financial reconciliation."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation events. Baseline volume for cancellation trend analysis."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty revenue collected from cancellations. Directly impacts revenue recovery and policy ROI."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per cancellation. Benchmarks policy effectiveness across segments."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued. Key cash outflow metric for Finance and treasury planning."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total revenue lost due to cancellations. Primary financial impact KPI for Revenue Management."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amount. Monitors OTA contract compliance and dispute exposure."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where a penalty waiver was granted. Tracks policy exception frequency."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations where a waiver was granted. High waiver rates signal policy enforcement gaps."
    - name: "penalty_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_applicable_flag = TRUE AND penalty_amount > 0 THEN 1 END) / NULLIF(COUNT(CASE WHEN penalty_applicable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of penalty-eligible cancellations where a penalty was actually collected. Measures policy enforcement effectiveness."
    - name: "dispute_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed cancellations. Tracks chargeback and dispute risk volume."
    - name: "avg_revenue_lost_per_cancellation"
      expr: AVG(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Average revenue lost per cancellation event. Informs cancellation policy stringency decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation policy inventory and configuration analytics. Used by Revenue Management to audit policy coverage, deposit requirements, and non-refundable policy mix across properties."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation_policy`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level policy configuration analysis."
    - name: "policy_status"
      expr: policy_status
      comment: "Active/inactive status of the policy for policy lifecycle management."
    - name: "policy_tier"
      expr: policy_tier
      comment: "Policy tier (standard, premium, non-refundable) for mix analysis."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty (nights, percentage, flat fee) for policy structure analysis."
    - name: "is_non_refundable"
      expr: is_non_refundable
      comment: "Whether the policy is non-refundable, for NRF mix and revenue certainty analysis."
    - name: "deposit_required"
      expr: deposit_required
      comment: "Whether a deposit is required, for cash flow and guarantee coverage analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the policy became effective for policy vintage analysis."
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of cancellation policies. Baseline for policy portfolio complexity management."
    - name: "active_policies"
      expr: COUNT(CASE WHEN policy_status = 'active' THEN 1 END)
      comment: "Number of currently active cancellation policies. Tracks policy portfolio size."
    - name: "non_refundable_policy_count"
      expr: COUNT(CASE WHEN is_non_refundable = TRUE THEN 1 END)
      comment: "Number of non-refundable policies. Monitors NRF policy penetration for revenue certainty strategy."
    - name: "non_refundable_policy_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_non_refundable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of policies that are non-refundable. Key lever for revenue certainty and demand management."
    - name: "deposit_required_policy_count"
      expr: COUNT(CASE WHEN deposit_required = TRUE THEN 1 END)
      comment: "Number of policies requiring a deposit. Tracks deposit coverage for cash flow planning."
    - name: "avg_deposit_percentage"
      expr: AVG(CAST(deposit_percentage AS DOUBLE))
      comment: "Average deposit percentage across policies requiring deposits. Benchmarks deposit stringency."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage across policies. Informs policy calibration for revenue recovery."
    - name: "avg_no_show_penalty_amount"
      expr: AVG(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Average no-show penalty amount. Benchmarks no-show deterrence across the policy portfolio."
    - name: "avg_modification_fee"
      expr: AVG(CAST(modification_fee AS DOUBLE))
      comment: "Average modification fee across policies. Tracks ancillary fee revenue potential from policy changes."
    - name: "distinct_properties_with_policies"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with at least one cancellation policy. Monitors policy coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit lifecycle KPIs covering deposit collection, forfeiture, and refund performance. Used by Finance and Revenue Management to manage cash flow, forfeiture revenue, and refund liability."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level deposit analysis."
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit (pending, received, forfeited, refunded) for lifecycle tracking."
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (credit card guarantee, cash, corporate) for payment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency deposit reporting."
    - name: "payment_received_month"
      expr: DATE_TRUNC('month', payment_received_date)
      comment: "Month deposit payment was received for cash flow timing analysis."
    - name: "revenue_recognition_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Month deposit revenue was recognized for financial reporting."
  measures:
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected. Primary cash inflow KPI for treasury and Finance."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per booking. Benchmarks deposit policy effectiveness."
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit forfeiture revenue. Tracks revenue recovered from cancellations via deposit forfeiture."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued from deposits. Key cash outflow and liability metric for Finance."
    - name: "forfeiture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(forfeiture_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of collected deposits that were forfeited. Measures cancellation revenue recovery effectiveness."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of collected deposits that were refunded. Tracks refund liability exposure."
    - name: "total_deposit_records"
      expr: COUNT(1)
      comment: "Total number of deposit ledger records. Baseline volume for deposit processing operations."
    - name: "distinct_properties_with_deposits"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with deposit activity. Portfolio coverage for Finance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block_pickup`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block pickup performance KPIs tracking room pickup progress, revenue realization, and cutoff compliance. Used by Group Sales and Revenue Management to manage block utilization and attrition risk."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_block_pickup`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level pickup analysis."
    - name: "pickup_status"
      expr: pickup_status
      comment: "Status of the pickup record (confirmed, cancelled, no-show) for pickup quality analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Month of group arrival for pickup trend analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the pickup for group segment mix analysis."
    - name: "booking_channel_code"
      expr: booking_channel_code
      comment: "Booking channel for group pickup channel mix analysis."
    - name: "pickup_before_cutoff_flag"
      expr: pickup_before_cutoff_flag
      comment: "Whether the pickup occurred before the block cutoff date, for cutoff compliance analysis."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether the group pickup resulted in a no-show, for group no-show risk analysis."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "VIP indicator for premium group attendee analysis."
  measures:
    - name: "total_pickup_records"
      expr: COUNT(1)
      comment: "Total number of group block pickup records. Baseline volume for pickup tracking."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue realized from group block pickups. Primary group revenue realization KPI."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average rate per pickup record. Benchmarks group rate realization against contracted rates."
    - name: "avg_block_utilization_pct"
      expr: AVG(CAST(block_utilization_percentage AS DOUBLE))
      comment: "Average block utilization percentage. Core KPI for group block efficiency and attrition risk management."
    - name: "before_cutoff_pickup_count"
      expr: COUNT(CASE WHEN pickup_before_cutoff_flag = TRUE THEN 1 END)
      comment: "Number of pickups made before the block cutoff date. Tracks timely pickup compliance."
    - name: "before_cutoff_pickup_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pickup_before_cutoff_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pickups made before cutoff. High pre-cutoff pickup rates reduce attrition risk."
    - name: "no_show_pickup_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of group pickup no-shows. Tracks group no-show exposure for revenue recovery planning."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group pickups resulting in no-shows. Informs group guarantee and deposit policy."
    - name: "total_revenue_per_block"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue from pickups, aggregatable by group block for block-level revenue realization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking volume, average daily rate, length of stay, and cancellation patterns. Primary steering dashboard for Revenue Management and Front Office leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level revenue and booking analysis."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the reservation (confirmed, cancelled, checked-in, checked-out, no-show) for funnel and conversion analysis."
    - name: "booking_date"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month of booking date for trend and seasonality analysis."
    - name: "arrival_date"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Month of guest arrival for occupancy and revenue forecasting."
    - name: "market_segment_id"
      expr: market_segment_id
      comment: "Market segment FK for segmented revenue and booking mix analysis."
    - name: "revenue_rate_plan_id"
      expr: revenue_rate_plan_id
      comment: "Revenue master rate plan FK for rate plan performance analysis."
    - name: "booking_source_id"
      expr: booking_source_id
      comment: "Booking source FK for channel mix and cost-of-acquisition analysis."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "VIP indicator for premium guest segment analysis."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method (credit card, deposit, corporate) for risk and no-show analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for financial reconciliation and fraud analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency revenue reporting."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation bookings. Baseline volume KPI for occupancy and demand planning."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue across all bookings. Primary top-line revenue KPI for Revenue Management."
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average daily rate (ADR) across bookings. Core pricing KPI used in every revenue management steering meeting."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to booking sources and travel agents. Drives cost-of-distribution decisions."
    - name: "avg_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per booking. Used to benchmark channel cost efficiency."
    - name: "cancelled_reservations"
      expr: COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled reservations. Drives cancellation policy review and revenue protection decisions."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were cancelled. Key risk metric for revenue forecasting accuracy."
    - name: "no_show_reservations"
      expr: COUNT(CASE WHEN booking_status = 'no_show' THEN 1 END)
      comment: "Count of no-show reservations. Informs overbooking strategy and guarantee policy decisions."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'no_show' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings resulting in no-shows. Directly informs overbooking level-setting."
    - name: "vip_reservation_count"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Count of VIP reservations. Tracks premium guest volume for service resource allocation."
    - name: "vip_reservation_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings flagged as VIP. Monitors premium guest mix for loyalty and service strategy."
    - name: "avg_total_room_revenue_per_booking"
      expr: AVG(CAST(total_room_revenue AS DOUBLE))
      comment: "Average total room revenue per booking. Compound KPI combining rate and length of stay value."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active bookings. Portfolio coverage metric for enterprise reporting."
    - name: "distinct_guests_booked"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles with bookings. Demand breadth metric for loyalty and CRM strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance KPIs covering contracted room inventory, pickup progress, attrition risk, and revenue forecasting. Used by Group Sales and Revenue Management to manage group business and attrition exposure."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_group_block`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level group block analysis."
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (tentative, definite, cancelled, closed) for pipeline management."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (corporate, leisure, SMERF, convention) for segment mix analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('month', arrival_date)
      comment: "Month of group arrival for demand forecasting and capacity planning."
    - name: "cutoff_month"
      expr: DATE_TRUNC('month', cutoff_date)
      comment: "Month of block cutoff date for pickup urgency analysis."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Whether an attrition clause is in place, for attrition risk portfolio analysis."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Availability flag for rate integrity and yield management analysis."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Whether a deposit is required for the group block, for cash flow planning."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group blocks. Baseline volume for group sales pipeline management."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary group revenue pipeline KPI for Revenue Management."
    - name: "avg_revenue_forecast_per_block"
      expr: AVG(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Average forecasted revenue per group block. Benchmarks group deal size for sales strategy."
    - name: "total_group_rate_amount"
      expr: SUM(CAST(group_rate_amount AS DOUBLE))
      comment: "Total contracted group rate value. Tracks group pricing and rate integrity."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average contracted group rate. Benchmarks group pricing against transient rate strategy."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount committed by group blocks. Tracks group cash flow and commitment."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group blocks. Monitors attrition risk exposure."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage on group blocks. Tracks cost of group distribution."
    - name: "cancelled_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled group blocks. Tracks group cancellation risk and pipeline attrition."
    - name: "group_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group blocks that were cancelled. Key risk metric for group revenue forecasting."
    - name: "attrition_risk_block_count"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE AND block_status NOT IN ('cancelled', 'closed') THEN 1 END)
      comment: "Number of active group blocks with attrition clauses. Quantifies attrition penalty exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation rate plan portfolio KPIs covering plan mix, channel eligibility, loyalty integration, commission structure, and length-of-stay restrictions. Used by Revenue Management to govern rate plan strategy and distribution."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_rate_plan`"
  dimensions:
    - name: "rate_plan_status"
      expr: rate_plan_status
      comment: "Current status of the rate plan (active, inactive, archived) for portfolio health monitoring."
    - name: "rate_plan_category"
      expr: rate_plan_category
      comment: "Category of the rate plan (BAR, corporate, package, group) for rate plan mix analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment the rate plan targets for segment-rate alignment analysis."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method required for the rate plan for risk and no-show analysis."
    - name: "loyalty_eligible_flag"
      expr: loyalty_eligible_flag
      comment: "Whether the rate plan earns loyalty points, for loyalty program integration analysis."
    - name: "commissionable_flag"
      expr: commissionable_flag
      comment: "Whether the rate plan is commissionable, for distribution cost analysis."
    - name: "member_only_flag"
      expr: member_only_flag
      comment: "Whether the rate plan is restricted to loyalty members, for member-exclusive rate analysis."
    - name: "package_inclusion_flag"
      expr: package_inclusion_flag
      comment: "Whether the rate plan includes package components, for package rate mix analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rate plan became effective for rate plan vintage analysis."
  measures:
    - name: "total_rate_plans"
      expr: COUNT(1)
      comment: "Total number of reservation rate plans. Baseline for rate plan portfolio complexity management."
    - name: "active_rate_plans"
      expr: COUNT(CASE WHEN rate_plan_status = 'active' THEN 1 END)
      comment: "Number of currently active rate plans. Tracks active rate plan portfolio size."
    - name: "loyalty_eligible_rate_plan_count"
      expr: COUNT(CASE WHEN loyalty_eligible_flag = TRUE THEN 1 END)
      comment: "Number of rate plans eligible for loyalty points. Tracks loyalty program integration breadth."
    - name: "loyalty_eligible_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans eligible for loyalty points. Monitors loyalty program coverage across rate plans."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across commissionable rate plans. Benchmarks distribution cost structure."
    - name: "avg_loyalty_points_multiplier"
      expr: AVG(CAST(loyalty_points_multiplier AS DOUBLE))
      comment: "Average loyalty points multiplier across eligible rate plans. Tracks loyalty incentive generosity."
    - name: "member_only_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_only_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans restricted to loyalty members. Tracks member-exclusive rate strategy penetration."
    - name: "commissionable_rate_plan_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commissionable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate plans that are commissionable. Tracks distribution cost exposure across the rate plan portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment KPIs covering fulfillment rates, cost management, VIP request handling, and guest satisfaction. Used by Operations and Guest Experience teams to monitor service delivery quality."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_special_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level special request analysis."
    - name: "request_category"
      expr: request_category
      comment: "Category of special request (amenity, room preference, dietary, transport) for demand pattern analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of special request for operational routing and fulfillment analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status (pending, fulfilled, failed, partial) for SLA and quality monitoring."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfillment for workload and accountability analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request for triage and SLA management."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Whether the request is from a VIP guest, for premium service delivery monitoring."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Whether the request was made pre-arrival, for pre-arrival service planning."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Whether the request requires a charge, for ancillary revenue tracking."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month of request submission for trend analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests. Baseline volume for operational capacity planning."
    - name: "fulfilled_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END)
      comment: "Number of successfully fulfilled special requests. Core service delivery quality KPI."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Primary guest experience quality KPI for Operations."
    - name: "failed_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'failed' THEN 1 END)
      comment: "Number of failed special requests. Tracks service failure rate for root-cause analysis."
    - name: "failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests that failed. Drives operational improvement and training decisions."
    - name: "vip_request_count"
      expr: COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END)
      comment: "Number of VIP special requests. Tracks premium guest service demand volume."
    - name: "vip_fulfillment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_request = TRUE AND fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of VIP special requests successfully fulfilled. Critical KPI for premium guest experience and loyalty retention."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount from special requests. Tracks ancillary revenue from special request services."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of fulfilling special requests. Tracks operational cost of service delivery."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per special request. Benchmarks service delivery cost efficiency."
    - name: "cost_vs_estimate_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total variance between actual and estimated cost of special requests. Tracks cost estimation accuracy and budget adherence."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and efficiency KPIs covering upgrade rates, early check-in, late checkout, reassignment frequency, and guest preference matching. Used by Front Office and Operations to optimize room assignment quality."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level room assignment analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used for room assignment (manual, automated, guest-requested) for process efficiency analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment for operational tracking."
    - name: "assignment_date"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of room assignment for trend analysis."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Whether the assignment was an upgrade, for upgrade rate and upsell analysis."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Whether the assigned room is accessible, for ADA compliance monitoring."
    - name: "is_connecting_room"
      expr: is_connecting_room
      comment: "Whether the assigned room is a connecting room, for family/group accommodation analysis."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Whether an early check-in was provided, for ancillary service and revenue analysis."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Whether a late checkout was provided, for ancillary service and revenue analysis."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Whether the room was specifically requested by the guest, for preference fulfillment analysis."
  measures:
    - name: "total_room_assignments"
      expr: COUNT(1)
      comment: "Total number of room assignments. Baseline volume for Front Office operations."
    - name: "upgrade_count"
      expr: COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END)
      comment: "Number of room upgrades provided. Tracks upsell and loyalty recognition activity."
    - name: "upgrade_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room assignments that were upgrades. Key loyalty and upsell performance KPI."
    - name: "avg_guest_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score for room assignments. Measures how well assignments align with guest preferences — directly linked to satisfaction scores."
    - name: "early_checkin_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_checkin_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with early check-in. Tracks ancillary service delivery and operational flexibility."
    - name: "late_checkout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_checkout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with late checkout. Tracks ancillary service delivery and housekeeping scheduling impact."
    - name: "guest_requested_room_fulfillment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments fulfilling a specific guest room request. Measures guest preference fulfillment quality."
    - name: "distinct_rooms_assigned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of distinct rooms assigned. Tracks room inventory utilization breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent performance and portfolio KPIs covering commission rates, booking volume, revenue generation, and credit management. Used by Sales and Distribution leadership to manage travel agent relationships and cost of distribution."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (OTA, TMC, leisure, corporate) for channel mix analysis."
    - name: "travel_agent_status"
      expr: travel_agent_status
      comment: "Current status of the travel agent (active, inactive, suspended) for portfolio health monitoring."
    - name: "booking_volume_tier"
      expr: booking_volume_tier
      comment: "Volume tier of the travel agent for tiered commission and incentive analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agent for geographic distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency commission and revenue analysis."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Preferred payment method for accounts payable and settlement analysis."
    - name: "onboarding_month"
      expr: DATE_TRUNC('month', onboarding_completed_date)
      comment: "Month onboarding was completed for agent cohort and vintage analysis."
  measures:
    - name: "total_travel_agents"
      expr: COUNT(1)
      comment: "Total number of travel agents in the portfolio. Baseline for distribution network size management."
    - name: "active_travel_agents"
      expr: COUNT(CASE WHEN travel_agent_status = 'active' THEN 1 END)
      comment: "Number of active travel agents. Tracks active distribution network size."
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by travel agents. Primary top-line KPI for travel agent channel performance."
    - name: "avg_revenue_per_agent"
      expr: AVG(CAST(total_revenue_generated AS DOUBLE))
      comment: "Average revenue generated per travel agent. Benchmarks agent productivity for portfolio management."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across travel agents. Tracks cost of distribution and commission policy compliance."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to travel agents. Tracks credit exposure for financial risk management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per travel agent. Benchmarks credit policy and risk exposure."
    - name: "distinct_countries_represented"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with travel agent representation. Tracks geographic distribution network breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_waitlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist demand and conversion KPIs covering waitlist volume, conversion rates, quoted rate levels, and expiration patterns. Used by Revenue Management and Front Office to manage demand overflow and conversion opportunity."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`waitlist`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level waitlist demand analysis."
    - name: "waitlist_status"
      expr: waitlist_status
      comment: "Current status of the waitlist entry (active, converted, expired, cancelled) for conversion funnel analysis."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the waitlisted guest for demand segment analysis."
    - name: "guest_priority_tier"
      expr: guest_priority_tier
      comment: "Priority tier of the waitlisted guest (VIP, loyalty, standard) for priority management."
    - name: "requested_arrival_month"
      expr: DATE_TRUNC('month', requested_arrival_date)
      comment: "Month of requested arrival for demand forecasting and capacity planning."
    - name: "auto_convert_flag"
      expr: auto_convert_flag
      comment: "Whether the waitlist entry is set for automatic conversion, for automation adoption analysis."
    - name: "channel_code"
      expr: channel_code
      comment: "Channel through which the waitlist entry was created for channel mix analysis."
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries. Baseline demand overflow volume for capacity and pricing decisions."
    - name: "converted_waitlist_count"
      expr: COUNT(CASE WHEN waitlist_status = 'converted' THEN 1 END)
      comment: "Number of waitlist entries converted to confirmed bookings. Tracks demand recovery from waitlist."
    - name: "waitlist_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waitlist_status = 'converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries converted to bookings. Key demand management KPI for Revenue Management."
    - name: "expired_waitlist_count"
      expr: COUNT(CASE WHEN waitlist_status = 'expired' THEN 1 END)
      comment: "Number of waitlist entries that expired without conversion. Tracks lost demand opportunity."
    - name: "expiration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waitlist_status = 'expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries that expired. High expiration rates signal missed revenue recovery opportunities."
    - name: "avg_quoted_rate"
      expr: AVG(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Average quoted rate for waitlisted guests. Benchmarks waitlist pricing against available inventory rates."
    - name: "total_quoted_rate_value"
      expr: SUM(CAST(quoted_rate_amount AS DOUBLE))
      comment: "Total quoted rate value across all waitlist entries. Quantifies potential revenue from waitlist conversion."
    - name: "distinct_properties_with_waitlist"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active waitlist demand. Tracks demand overflow breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_walk_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Walk (relocation) incident KPIs covering compensation costs, revenue loss, OTA penalty exposure, and guest satisfaction impact. Used by Operations and Revenue Management to manage walk risk and brand standard compliance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`walk_record`"
  dimensions:
    - name: "primary_walk_property_id"
      expr: primary_walk_property_id
      comment: "Property that walked the guest, for property-level walk incident analysis."
    - name: "walk_reason_code"
      expr: walk_reason_code
      comment: "Reason for the walk (overbooking, maintenance, VIP displacement) for root-cause analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation provided (cash, points, complimentary nights) for compensation mix analysis."
    - name: "walk_month"
      expr: DATE_TRUNC('month', walk_date)
      comment: "Month of walk incident for trend and seasonality analysis."
    - name: "brand_standard_compliance_flag"
      expr: brand_standard_compliance_flag
      comment: "Whether the walk handling met brand standards, for compliance monitoring."
    - name: "complaint_filed_flag"
      expr: complaint_filed_flag
      comment: "Whether a complaint was filed, for guest satisfaction and brand risk analysis."
    - name: "ota_penalty_applicable_flag"
      expr: ota_penalty_applicable_flag
      comment: "Whether an OTA penalty applies, for OTA contract compliance and cost exposure analysis."
    - name: "transportation_provided_flag"
      expr: transportation_provided_flag
      comment: "Whether transportation was provided to the walked guest, for service recovery cost analysis."
  measures:
    - name: "total_walk_incidents"
      expr: COUNT(1)
      comment: "Total number of walk incidents. Baseline volume for overbooking and walk risk management."
    - name: "total_compensation_value"
      expr: SUM(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Total compensation value provided to walked guests. Primary cost KPI for walk incident management."
    - name: "avg_compensation_per_walk"
      expr: AVG(CAST(total_compensation_value_amount AS DOUBLE))
      comment: "Average compensation cost per walk incident. Benchmarks walk cost and informs overbooking policy calibration."
    - name: "total_cash_compensation"
      expr: SUM(CAST(cash_compensation_amount AS DOUBLE))
      comment: "Total cash compensation paid to walked guests. Tracks direct cash outflow from walk incidents."
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost_amount AS DOUBLE))
      comment: "Total transportation cost for walked guests. Tracks ancillary walk cost for full incident cost accounting."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total revenue lost due to walk incidents. Quantifies the full financial impact of overbooking."
    - name: "total_ota_penalty_amount"
      expr: SUM(CAST(ota_penalty_amount AS DOUBLE))
      comment: "Total OTA penalty amount incurred from walk incidents. Tracks OTA contract compliance cost."
    - name: "brand_standard_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_standard_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walk incidents handled in compliance with brand standards. Critical brand integrity KPI."
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complaint_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walk incidents resulting in a guest complaint. Tracks guest satisfaction impact of walk incidents."
    - name: "ota_penalty_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_penalty_applicable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of walk incidents with OTA penalty exposure. Monitors OTA contract compliance risk."
$$;
