-- Metric views for domain: spa | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment performance metrics covering booking volume, revenue, cancellations, no-shows, and therapist utilization. Primary operational KPI view for spa directors and revenue managers."
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Date of the spa appointment for daily/weekly/monthly trend analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (confirmed, completed, cancelled, no-show) for funnel analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, front desk, phone, app) for channel mix analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for appointment cancellation to identify root causes of lost revenue."
    - name: "guest_gender_preference"
      expr: guest_gender_preference
      comment: "Guest therapist gender preference for staffing and scheduling optimization."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property performance benchmarking."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of spa appointments booked. Baseline volume KPI for capacity planning and demand forecasting."
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'completed' THEN 1 END)
      comment: "Number of appointments that were completed. Measures actual service delivery vs. bookings."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled appointments. High cancellation rates signal pricing, policy, or guest experience issues."
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show appointments. No-shows represent direct revenue loss and therapist idle time."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that were cancelled. A key quality and revenue protection KPI; high rates trigger policy review."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in no-shows. Drives decisions on prepayment policy and overbooking strategy."
    - name: "total_prepayment_revenue"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment amounts collected across appointments. Indicates revenue secured in advance and deposit policy effectiveness."
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment amount per appointment. Benchmarks deposit policy against industry norms."
    - name: "intake_form_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with completed intake forms. Measures compliance with health and safety protocols."
    - name: "online_booking_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_channel = 'online' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of appointments booked through online channels. Tracks digital adoption and cost-per-booking efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa appointment package sales and revenue metrics covering package revenue, discounting, cancellations, and treatment count. Drives package product strategy and bundled revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment_package`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current booking status of the appointment package (confirmed, completed, cancelled) for lifecycle analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the package was booked for channel mix and digital adoption analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for package purchase for payment mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package transaction for multi-currency revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property package performance benchmarking."
    - name: "booking_date"
      expr: booking_date
      comment: "Date the package was booked for booking trend and lead time analysis."
  measures:
    - name: "total_packages_booked"
      expr: COUNT(1)
      comment: "Total number of appointment packages booked. Baseline volume KPI for package product demand."
    - name: "total_package_revenue"
      expr: SUM(CAST(package_price AS DOUBLE))
      comment: "Total revenue from appointment package sales. Primary bundled revenue KPI for package program P&L."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue including add-ons and taxes from appointment packages."
    - name: "total_addon_services_revenue"
      expr: SUM(CAST(addon_services_amount AS DOUBLE))
      comment: "Total add-on services revenue attached to packages. Measures upsell effectiveness within package bookings."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on appointment packages. Tracks promotional spend and its impact on package yield."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on appointment packages for tax compliance reporting."
    - name: "avg_package_price"
      expr: AVG(CAST(package_price AS DOUBLE))
      comment: "Average package price. Benchmarks package yield and tracks pricing strategy effectiveness."
    - name: "cancelled_packages"
      expr: COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled appointment packages. Tracks package cancellation volume for revenue protection."
    - name: "unique_package_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests purchasing appointment packages. Measures package product penetration of the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_cancellation_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa appointment cancellation analysis metrics covering cancellation fees, waivers, revenue recovery, and rebooking rates. Drives cancellation policy optimization and revenue protection decisions."
  source: "`vibe_travel_hospitality_v1`.`spa`.`cancellation_log`"
  dimensions:
    - name: "cancellation_timestamp_date"
      expr: DATE(cancellation_timestamp)
      comment: "Date of cancellation for trend analysis of cancellation volume over time."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Coded reason for cancellation for root cause analysis and policy adjustment."
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type of cancellation (guest-initiated, property-initiated, no-show) for accountability analysis."
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was made for channel-level policy enforcement analysis."
    - name: "late_cancellation_flag"
      expr: late_cancellation_flag
      comment: "Whether the cancellation was made within the late cancellation window for policy compliance tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property cancellation policy benchmarking."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellations logged. Baseline volume KPI for cancellation trend monitoring."
    - name: "late_cancellations"
      expr: COUNT(CASE WHEN late_cancellation_flag = TRUE THEN 1 END)
      comment: "Number of late cancellations. Late cancellations represent direct revenue loss and therapist idle time."
    - name: "no_show_count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show cancellations. No-shows are the highest-cost cancellation type for revenue recovery."
    - name: "total_cancellation_fee_revenue"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees charged. Measures revenue recovered through cancellation policy enforcement."
    - name: "total_original_appointment_value_lost"
      expr: SUM(CAST(original_appointment_value AS DOUBLE))
      comment: "Total value of cancelled appointments at original booking price. Quantifies gross revenue at risk from cancellations."
    - name: "total_revenue_recovery_amount"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovered through fees, rebooking, or other means. Measures effectiveness of revenue protection strategies."
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cancellation_fee_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cancellation_fee_applicable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of applicable cancellation fees that were waived. High waiver rates signal inconsistent policy enforcement."
    - name: "rebooking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rebooking_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that resulted in a completed rebooking. Key revenue recovery KPI; low rates trigger outreach program review."
    - name: "avg_advance_notice_hours"
      expr: AVG(CAST(advance_notice_hours AS DOUBLE))
      comment: "Average advance notice hours provided for cancellations. Benchmarks guest behavior against policy thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge metrics covering total revenue, average transaction value, discounting, tax, and service charges. Primary financial performance view for spa finance and revenue management."
  source: "`vibe_travel_hospitality_v1`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date the charge was posted for daily revenue trend analysis."
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (treatment, retail, package, gratuity) for revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge for multi-currency revenue reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (credit card, cash, room charge, loyalty points) for payment mix analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the charge (posted, voided, pending) for revenue recognition accuracy."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property revenue benchmarking."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for financial reporting and cost center allocation."
  measures:
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total spa revenue from all charges. Primary top-line revenue KPI for spa P&L reporting."
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction. Tracks average transaction value trends and pricing effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all charges. Measures promotional spend and discount policy impact on revenue."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on spa charges. Required for tax compliance reporting and remittance."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Tracks gratuity and service fee revenue separate from treatment revenue."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)) + SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross revenue. High discount rates signal over-reliance on promotions eroding margin."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of voided charges. Elevated void counts indicate operational errors or guest disputes requiring investigation."
    - name: "total_unit_price_revenue"
      expr: SUM(CAST(unit_price AS DOUBLE) * CAST(quantity AS DOUBLE))
      comment: "Gross revenue computed as unit price times quantity before discounts. Measures rack-rate revenue potential."
    - name: "gratuity_included_charge_count"
      expr: COUNT(CASE WHEN gratuity_included_flag = TRUE THEN 1 END)
      comment: "Number of charges with gratuity included. Tracks gratuity policy adoption and therapist compensation impact."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_day_pass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa day pass sales and revenue metrics covering pass volume, revenue, refunds, and guest mix. Drives day pass pricing strategy and non-resident guest revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`day_pass`"
  dimensions:
    - name: "pass_date"
      expr: pass_date
      comment: "Date of the day pass for daily demand and revenue trend analysis."
    - name: "pass_type"
      expr: pass_type
      comment: "Type of day pass (standard, premium, couples, family) for product mix and yield analysis."
    - name: "pass_status"
      expr: pass_status
      comment: "Current status of the day pass (active, used, cancelled, expired) for utilization tracking."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (hotel resident, non-resident, member) for guest segment revenue contribution analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for day pass purchase for payment mix analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property day pass performance benchmarking."
  measures:
    - name: "total_day_passes_sold"
      expr: COUNT(1)
      comment: "Total number of day passes sold. Baseline volume KPI for non-resident spa access demand."
    - name: "total_day_pass_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from day pass sales. Primary ancillary revenue KPI for non-resident spa access."
    - name: "avg_day_pass_revenue"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per day pass. Tracks yield per pass and pricing effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on day passes. Measures promotional spend and its impact on day pass yield."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on day passes. Elevated refunds signal guest dissatisfaction or policy issues."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on day pass sales for tax compliance reporting."
    - name: "loyalty_member_pass_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of day passes purchased by loyalty members. Tracks loyalty program engagement with spa day pass product."
    - name: "group_booking_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN group_booking_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of day passes sold as group bookings. Informs group sales strategy and group pricing policy."
    - name: "net_day_pass_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net day pass revenue before tax and service charges. Used for net revenue and margin analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_fitness_class_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fitness class session performance metrics covering attendance, capacity utilization, revenue, and waitlist demand — essential for class scheduling optimization and fitness program ROI."
  source: "`vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`"
  dimensions:
    - name: "session_date"
      expr: session_date
      comment: "Date of the fitness class session for daily/weekly attendance trend analysis."
    - name: "session_status"
      expr: session_status
      comment: "Status of the session (scheduled, completed, cancelled) for program delivery tracking."
    - name: "session_type"
      expr: session_type
      comment: "Type of fitness session (yoga, HIIT, pilates, aqua) for class mix and demand analysis."
    - name: "class_format"
      expr: class_format
      comment: "Format of the class (in-person, virtual, hybrid) for format preference analysis."
    - name: "difficulty_level"
      expr: difficulty_level
      comment: "Difficulty level of the session for guest segmentation and instructor assignment."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property fitness program benchmarking."
    - name: "guest_segment"
      expr: guest_segment
      comment: "Target guest segment for the session — used for program targeting and marketing alignment."
    - name: "published_flag"
      expr: published_flag
      comment: "Whether the session was published to guests — measures schedule visibility and booking lead time."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of fitness class sessions — baseline volume for program scale assessment."
    - name: "total_session_revenue"
      expr: SUM(CAST(session_price AS DOUBLE))
      comment: "Total revenue from fitness class sessions — measures fitness program financial contribution."
    - name: "avg_session_price"
      expr: AVG(CAST(session_price AS DOUBLE))
      comment: "Average session price — benchmarks pricing against competitive fitness offerings."
    - name: "session_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN session_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled sessions that were cancelled — measures program reliability and guest experience impact."
    - name: "online_booking_enabled_sessions"
      expr: COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END)
      comment: "Count of sessions available for online booking — measures digital channel accessibility for fitness program."
    - name: "loyalty_eligible_sessions"
      expr: COUNT(CASE WHEN loyalty_points_eligible_flag = TRUE THEN 1 END)
      comment: "Count of sessions eligible for loyalty points — measures loyalty program integration with fitness offerings."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_golf_tee_time`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Golf tee time booking and revenue metrics covering green fees, cart and caddie revenue, and booking patterns. Drives golf course revenue optimization and tee sheet management."
  source: "`vibe_travel_hospitality_v1`.`spa`.`golf_tee_time`"
  dimensions:
    - name: "tee_time_date"
      expr: tee_time_date
      comment: "Date of the tee time for daily revenue and demand trend analysis."
    - name: "tee_time_status"
      expr: tee_time_status
      comment: "Status of the tee time booking (confirmed, completed, cancelled, no-show) for utilization analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the tee time was booked for channel mix analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Rate type applied (rack, member, promotional, group) for yield management analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property golf revenue benchmarking."
  measures:
    - name: "total_tee_times"
      expr: COUNT(1)
      comment: "Total number of tee times booked. Baseline volume KPI for golf course demand and tee sheet utilization."
    - name: "total_golf_revenue"
      expr: SUM(CAST(total_charge AS DOUBLE))
      comment: "Total golf revenue including green fees, cart, caddie, and club rental. Primary golf P&L KPI."
    - name: "avg_revenue_per_tee_time"
      expr: AVG(CAST(total_charge AS DOUBLE))
      comment: "Average revenue per tee time booking. Tracks yield per round and pricing effectiveness."
    - name: "total_green_fee_revenue"
      expr: SUM(CAST(green_fee_per_player AS DOUBLE))
      comment: "Total green fee revenue. Primary golf course revenue component for pricing strategy decisions."
    - name: "total_cart_fee_revenue"
      expr: SUM(CAST(cart_fee_per_cart AS DOUBLE))
      comment: "Total cart rental fee revenue. Ancillary golf revenue component."
    - name: "total_caddie_fee_revenue"
      expr: SUM(CAST(caddie_fee_per_caddie AS DOUBLE))
      comment: "Total caddie fee revenue. Tracks caddie service demand and associated revenue."
    - name: "total_club_rental_fee_revenue"
      expr: SUM(CAST(club_rental_fee_per_set AS DOUBLE))
      comment: "Total club rental fee revenue. Ancillary revenue from equipment rental services."
    - name: "weather_cancellation_count"
      expr: COUNT(CASE WHEN weather_cancellation_flag = TRUE THEN 1 END)
      comment: "Number of tee times cancelled due to weather. Tracks weather-related revenue loss for insurance and contingency planning."
    - name: "unique_golf_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests booking tee times. Measures golf product reach within the property guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership lifecycle and revenue metrics covering active memberships, renewal rates, fee revenue, and churn. Strategic KPI view for membership program management and recurring revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (active, suspended, cancelled, expired) for lifecycle stage analysis."
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership (individual, couple, corporate, family) for product mix and revenue segmentation."
    - name: "tier"
      expr: tier
      comment: "Membership tier for premium vs. standard member analysis and upsell opportunity identification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of membership fees for multi-currency revenue reporting."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for auto-renewal success rate and payment failure analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property membership performance benchmarking."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of membership enrollment for cohort analysis and seasonal enrollment trend tracking."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of memberships. Baseline volume KPI for membership program scale."
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN 1 END)
      comment: "Number of currently active memberships. Primary recurring revenue base indicator."
    - name: "cancelled_memberships"
      expr: COUNT(CASE WHEN membership_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled memberships. Tracks churn volume for retention program effectiveness."
    - name: "auto_renewal_membership_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of memberships enrolled in auto-renewal. Higher auto-renewal rates reduce churn risk and stabilize recurring revenue."
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual membership fee revenue. Core recurring revenue KPI for spa membership P&L."
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly membership fee revenue. Tracks monthly recurring revenue (MRR) for cash flow planning."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual membership fee. Benchmarks pricing against market and tracks yield per member."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to memberships. Measures promotional generosity and its impact on fee yield."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN membership_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships that have been cancelled. Key churn KPI; rising rates trigger retention intervention."
    - name: "total_early_termination_fee_revenue"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees collected. Measures revenue recovered from early cancellations and policy enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_membership_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership visit frequency, credit consumption, and retail attachment metrics. Drives member engagement strategy and membership value proposition optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`membership_visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the membership visit for visit frequency and seasonal trend analysis."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of membership visit (treatment, fitness, retail, combined) for visit mix analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the visit (completed, no-show, cancelled) for engagement quality tracking."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Whether the visit was complimentary for tracking comp visit costs and member benefit utilization."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property member engagement benchmarking."
  measures:
    - name: "total_membership_visits"
      expr: COUNT(1)
      comment: "Total number of membership visits. Baseline engagement KPI; low visit frequency predicts membership cancellation."
    - name: "total_credits_consumed"
      expr: SUM(CAST(credits_consumed AS DOUBLE))
      comment: "Total membership credits consumed across visits. Measures benefit utilization and member engagement depth."
    - name: "avg_credits_per_visit"
      expr: AVG(CAST(credits_consumed AS DOUBLE))
      comment: "Average credits consumed per visit. Tracks credit burn rate for membership sustainability analysis."
    - name: "total_retail_purchase_amount"
      expr: SUM(CAST(retail_purchase_amount AS DOUBLE))
      comment: "Total retail purchases made during membership visits. Measures retail attachment rate and ancillary revenue from members."
    - name: "avg_retail_purchase_per_visit"
      expr: AVG(CAST(retail_purchase_amount AS DOUBLE))
      comment: "Average retail spend per membership visit. Tracks retail upsell effectiveness during member visits."
    - name: "total_gratuity_amount"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected during membership visits. Tracks therapist compensation and member generosity."
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of membership visits resulting in no-shows. High no-show rates among members signal disengagement risk."
    - name: "avg_remaining_credit_balance"
      expr: AVG(CAST(remaining_credit_balance AS DOUBLE))
      comment: "Average remaining credit balance after visits. Low balances indicate high engagement; high balances may signal underutilization."
    - name: "unique_visiting_members"
      expr: COUNT(DISTINCT membership_id)
      comment: "Number of unique memberships with at least one visit. Measures active member engagement rate."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail inventory health and efficiency metrics covering stock levels, inventory value, reorder triggers, and variance. Drives procurement decisions and prevents stockouts or overstock situations."
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (in-stock, low-stock, out-of-stock, discontinued) for stock health monitoring."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property inventory benchmarking and redistribution decisions."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location within the spa facility for location-level inventory management."
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total value of spa retail inventory on hand. Primary balance sheet KPI for inventory asset management."
    - name: "total_current_stock_quantity"
      expr: SUM(CAST(current_stock_quantity AS DOUBLE))
      comment: "Total units currently in stock across all retail products. Baseline inventory volume KPI."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total units available for sale (current stock minus reserved). Measures sellable inventory position."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total units reserved but not yet sold. Tracks committed inventory for fulfillment planning."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total inventory variance (physical count vs. system count). Elevated variance signals shrinkage, theft, or counting errors."
    - name: "reorder_triggered_count"
      expr: COUNT(CASE WHEN reorder_triggered_flag = TRUE THEN 1 END)
      comment: "Number of SKUs with active reorder triggers. Drives procurement action to prevent stockouts."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across retail inventory. Benchmarks procurement efficiency and cost trends."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average retail price per unit. Tracks pricing strategy and margin potential."
    - name: "total_last_replenishment_quantity"
      expr: SUM(CAST(last_replenishment_quantity AS DOUBLE))
      comment: "Total units replenished in the most recent replenishment cycle. Measures procurement volume and supply chain activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail sales performance metrics covering revenue, basket size, discounting, and refunds. Key view for retail merchandising strategy and ancillary revenue optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the retail transaction for daily/weekly sales trend analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, refunded, voided) for revenue recognition accuracy."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for retail purchase for payment mix and fraud analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (in-spa, online, phone) for channel contribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency retail revenue reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property retail performance benchmarking."
  measures:
    - name: "total_retail_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total retail sales revenue. Primary ancillary revenue KPI for spa retail P&L."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge retail revenue. Used for net revenue and margin analysis."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average retail transaction value. Tracks basket size trends and upsell effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on retail transactions. Measures promotional spend impact on retail margin."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on retail sales. Required for tax compliance and remittance reporting."
    - name: "total_service_charge_revenue"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges on retail transactions. Tracks ancillary fee revenue."
    - name: "total_quantity_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units sold across all retail transactions. Measures product throughput and inventory velocity."
    - name: "avg_quantity_per_transaction"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average number of items per retail transaction. Tracks cross-sell and upsell effectiveness."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)) + SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Retail discount as a percentage of gross retail revenue. High rates signal over-discounting eroding retail margin."
    - name: "unique_retail_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests making retail purchases. Measures retail penetration of the spa guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_class_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa fitness class enrollment metrics covering enrollment volume, revenue, no-shows, and cancellations. Drives fitness class scheduling, capacity optimization, and instructor allocation decisions."
  source: "`vibe_travel_hospitality_v1`.`spa`.`spa_class_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (enrolled, waitlisted, cancelled, completed, no-show) for enrollment funnel analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment was made (online, front desk, app) for digital adoption tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for class enrollment for payment mix analysis."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property fitness class performance benchmarking."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of class enrollments. Baseline demand KPI for fitness class capacity planning."
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'completed' THEN 1 END)
      comment: "Number of enrollments that resulted in class attendance. Measures actual class utilization."
    - name: "no_show_enrollments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Number of no-show enrollments. No-shows waste instructor time and block other guests from enrolling."
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from class enrollment charges. Measures fitness class revenue contribution."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied on class enrollments. Tracks promotional spend on fitness class revenue."
    - name: "total_no_show_fee_revenue"
      expr: SUM(CAST(no_show_fee_amount AS DOUBLE))
      comment: "Total no-show fees collected. Measures revenue recovered from no-show policy enforcement."
    - name: "no_show_fee_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_fee_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of no-show fees that were waived. High waiver rates signal inconsistent policy enforcement."
    - name: "net_enrollment_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net enrollment revenue after discounts and adjustments. Used for fitness class P&L reporting."
    - name: "unique_enrolled_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests enrolled in fitness classes. Measures fitness program reach within the spa guest base."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist certification compliance and training investment metrics — critical for regulatory compliance, service quality assurance, and workforce development planning."
  source: "`vibe_travel_hospitality_v1`.`spa`.`spa_therapist_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (state license, brand certification, specialty) for compliance category analysis."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification (basic, advanced, master) for workforce capability assessment."
    - name: "specialty_area"
      expr: specialty_area
      comment: "Specialty area covered by the certification for service capability mapping."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification (current, pending, expired, lapsed) for compliance risk monitoring."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification for audit and compliance reporting."
    - name: "is_state_required"
      expr: is_state_required
      comment: "Whether the certification is state-mandated — identifies highest-priority compliance obligations."
    - name: "is_brand_required"
      expr: is_brand_required
      comment: "Whether the certification is brand-required — measures brand standard compliance."
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Reimbursement status for certification costs — tracks training investment recovery."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records — baseline for workforce certification portfolio size."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN renewal_status = 'current' THEN 1 END)
      comment: "Count of currently active and valid certifications — primary compliance health metric."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN renewal_status = 'expired' THEN 1 END)
      comment: "Count of expired certifications — critical compliance risk indicator requiring immediate remediation."
    - name: "certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN renewal_status = 'current' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are current and valid — primary regulatory compliance KPI for spa operations."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in therapist certifications — measures training spend for workforce development ROI analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification — benchmarks training investment and informs budget planning."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested in certifications — measures workforce development intensity."
    - name: "avg_continuing_education_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(continuing_education_hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(continuing_education_hours_required AS DOUBLE)), 0), 2)
      comment: "Average continuing education completion rate — measures ongoing professional development compliance."
    - name: "unique_certified_therapists"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Count of distinct therapists with certifications — measures certified workforce breadth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist performance and workforce metrics tracking utilization, ratings, and capacity"
  source: "`travel_hospitality_ecm`.`spa`.`therapist`"
  dimensions:
    - name: "therapist_status"
      expr: therapist_status
      comment: "Current employment status of therapist (active, on-leave, terminated)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contractor)"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level of therapist"
    - name: "gender"
      expr: gender
      comment: "Gender of therapist"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month when therapist was hired"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year when therapist was hired"
    - name: "tip_eligible_flag"
      expr: tip_eligible_flag
      comment: "Indicator whether therapist is eligible for tips"
  measures:
    - name: "total_therapists"
      expr: COUNT(1)
      comment: "Total number of therapists"
    - name: "active_therapists"
      expr: COUNT(CASE WHEN therapist_status = 'active' THEN 1 END)
      comment: "Number of currently active therapists - workforce capacity metric"
    - name: "avg_guest_rating"
      expr: AVG(CAST(guest_rating_average AS DOUBLE))
      comment: "Average guest rating across all therapists - service quality KPI"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate paid to therapists"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across therapists"
    - name: "therapists_with_expired_license"
      expr: COUNT(CASE WHEN primary_license_expiry_date < CURRENT_DATE THEN 1 END)
      comment: "Number of therapists with expired primary license - compliance risk metric"
    - name: "therapists_needing_certification_renewal"
      expr: COUNT(CASE WHEN next_certification_due_date <= DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of therapists needing certification renewal within 90 days"
    - name: "tip_eligible_therapists"
      expr: COUNT(CASE WHEN tip_eligible_flag = TRUE THEN 1 END)
      comment: "Number of therapists eligible to receive tips"
    - name: "full_time_therapists"
      expr: COUNT(CASE WHEN employment_type = 'full-time' THEN 1 END)
      comment: "Number of full-time therapists"
    - name: "part_time_therapists"
      expr: COUNT(CASE WHEN employment_type = 'part-time' THEN 1 END)
      comment: "Number of part-time therapists"
    - name: "contractor_therapists"
      expr: COUNT(CASE WHEN employment_type = 'contractor' THEN 1 END)
      comment: "Number of contractor therapists"
    - name: "active_therapist_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN therapist_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of therapists currently active - workforce availability metric"
    - name: "license_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_license_expiry_date >= CURRENT_DATE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of therapists with valid licenses - regulatory compliance KPI"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist scheduling efficiency and utilization metrics. Critical operational KPI view for spa managers to optimize staffing, reduce idle time, and maximize therapist productivity."
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the therapist schedule for daily staffing analysis and trend tracking."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (published, confirmed, cancelled) for schedule reliability analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (morning, afternoon, evening, split) for shift pattern optimization."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property staffing benchmarking."
    - name: "primary_treatment_specialty"
      expr: primary_treatment_specialty
      comment: "Therapist primary treatment specialty for specialty-level capacity and demand matching."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total therapist hours scheduled. Baseline capacity KPI for staffing cost and coverage planning."
    - name: "total_booked_hours"
      expr: SUM(CAST(total_booked_hours AS DOUBLE))
      comment: "Total therapist hours booked with appointments. Measures productive utilization of scheduled capacity."
    - name: "total_available_hours"
      expr: SUM(CAST(total_available_hours AS DOUBLE))
      comment: "Total therapist hours available for booking. Tracks unbooked capacity available for revenue generation."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked by therapists. Used for payroll accuracy and labor cost management."
    - name: "avg_utilization_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average therapist utilization percentage (booked hours / available hours). Primary productivity KPI; low utilization triggers scheduling or demand action."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals understaffing or demand spikes requiring scheduling adjustment."
    - name: "avg_actual_hours_worked"
      expr: AVG(CAST(actual_hours_worked AS DOUBLE))
      comment: "Average actual hours worked per therapist schedule record. Benchmarks shift productivity."
    - name: "cancelled_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled therapist schedules. High cancellation rates indicate staffing reliability issues."
    - name: "overtime_eligible_shifts"
      expr: COUNT(CASE WHEN overtime_eligible_flag = TRUE THEN 1 END)
      comment: "Number of shifts eligible for overtime. Tracks overtime exposure for labor cost forecasting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_treatment_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment room utilization and capacity metrics tracking facility efficiency and maintenance"
  source: "`travel_hospitality_ecm`.`spa`.`treatment_room`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of treatment room (available, occupied, maintenance, closed)"
    - name: "room_type"
      expr: room_type
      comment: "Type of treatment room (single, couple, suite, wet room)"
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Maintenance status of room"
    - name: "gender_designation"
      expr: gender_designation
      comment: "Gender designation of room if applicable"
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Indicator whether room is ADA compliant"
    - name: "has_private_shower"
      expr: has_private_shower
      comment: "Indicator whether room has private shower"
    - name: "has_outdoor_access"
      expr: has_outdoor_access
      comment: "Indicator whether room has outdoor access"
  measures:
    - name: "total_treatment_rooms"
      expr: COUNT(1)
      comment: "Total number of treatment rooms - facility capacity metric"
    - name: "available_treatment_rooms"
      expr: COUNT(CASE WHEN operational_status = 'available' THEN 1 END)
      comment: "Number of treatment rooms currently available"
    - name: "occupied_treatment_rooms"
      expr: COUNT(CASE WHEN operational_status = 'occupied' THEN 1 END)
      comment: "Number of treatment rooms currently occupied"
    - name: "rooms_in_maintenance"
      expr: COUNT(CASE WHEN operational_status = 'maintenance' THEN 1 END)
      comment: "Number of rooms currently in maintenance - capacity constraint metric"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage of all treatment rooms"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per treatment room"
    - name: "total_ffe_value"
      expr: SUM(CAST(ffe_value AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment value"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for treatment rooms"
    - name: "accessible_rooms"
      expr: COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END)
      comment: "Number of ADA-compliant treatment rooms"
    - name: "rooms_with_private_shower"
      expr: COUNT(CASE WHEN has_private_shower = TRUE THEN 1 END)
      comment: "Number of rooms with private shower amenity"
    - name: "rooms_with_outdoor_access"
      expr: COUNT(CASE WHEN has_outdoor_access = TRUE THEN 1 END)
      comment: "Number of rooms with outdoor access"
    - name: "rooms_needing_maintenance"
      expr: COUNT(CASE WHEN next_maintenance_date <= DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Number of rooms needing maintenance within 30 days"
    - name: "room_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'available' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms available for use - facility utilization KPI"
    - name: "room_occupancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'occupied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms currently occupied - real-time utilization metric"
    - name: "accessibility_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rooms that are ADA compliant - regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_wellness_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program catalog and pricing metrics covering program availability, pricing, and configuration. Drives wellness program portfolio strategy and pricing optimization."
  source: "`vibe_travel_hospitality_v1`.`spa`.`wellness_program`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Active status of the wellness program for portfolio health monitoring."
    - name: "program_type"
      expr: program_type
      comment: "Type of wellness program (detox, weight loss, stress relief, fitness) for portfolio mix analysis."
    - name: "season_type"
      expr: season_type
      comment: "Season type for the wellness program for seasonal demand and pricing strategy."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for cross-property wellness program portfolio benchmarking."
    - name: "medical_supervision_required_flag"
      expr: medical_supervision_required_flag
      comment: "Whether medical supervision is required for the program for compliance and staffing planning."
    - name: "online_booking_enabled_flag"
      expr: online_booking_enabled_flag
      comment: "Whether the program is available for online booking for digital channel availability analysis."
  measures:
    - name: "total_wellness_programs"
      expr: COUNT(1)
      comment: "Total number of wellness programs in the catalog. Measures portfolio breadth for competitive positioning."
    - name: "active_wellness_programs"
      expr: COUNT(CASE WHEN active_status = 'active' THEN 1 END)
      comment: "Number of currently active wellness programs. Tracks sellable portfolio size."
    - name: "avg_program_price"
      expr: AVG(CAST(program_price AS DOUBLE))
      comment: "Average wellness program price. Benchmarks pricing strategy and tracks yield per program."
    - name: "total_program_revenue_potential"
      expr: SUM(CAST(program_price AS DOUBLE))
      comment: "Sum of all program prices as a proxy for total revenue potential if all programs were sold once. Used for portfolio value sizing."
    - name: "online_bookable_program_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wellness programs available for online booking. Tracks digital channel readiness of the wellness portfolio."
    - name: "loyalty_eligible_program_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_points_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wellness programs eligible for loyalty points. Measures loyalty program integration with wellness offerings."
    - name: "medically_supervised_program_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_supervision_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs requiring medical supervision. Tracks compliance risk exposure and staffing requirements."
$$;
