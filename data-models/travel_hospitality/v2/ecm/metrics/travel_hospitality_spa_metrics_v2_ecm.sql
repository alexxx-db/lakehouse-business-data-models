-- Metric views for domain: spa | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment metrics tracking booking performance, utilization, cancellations, and no-shows for operational and revenue management"
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Date of the scheduled appointment for daily trend analysis"
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (scheduled, completed, cancelled, no-show) for funnel analysis"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (online, phone, walk-in, concierge) for channel effectiveness"
    - name: "appointment_month"
      expr: DATE_TRUNC('MONTH', appointment_date)
      comment: "Month of appointment for monthly trend and seasonality analysis"
    - name: "therapist_gender_preference"
      expr: therapist_gender_preference
      comment: "Guest preference for therapist gender to understand demand patterns"
    - name: "pressure_preference"
      expr: pressure_preference
      comment: "Guest pressure preference (light, medium, firm) for service customization insights"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointments for volume tracking"
    - name: "completed_appointments"
      expr: SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed appointments for service delivery tracking"
    - name: "cancelled_appointments"
      expr: SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled appointments for cancellation rate analysis"
    - name: "no_show_count"
      expr: SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of no-show appointments for operational efficiency and revenue loss tracking"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments completed successfully - key operational KPI"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled - critical for capacity planning and revenue forecasting"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of no-show appointments - key metric for revenue leakage and policy effectiveness"
    - name: "total_prepayment_amount"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment revenue collected to secure appointments"
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment amount per appointment for pricing strategy"
    - name: "intake_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN intake_form_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with completed intake forms - critical for service quality and compliance"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge metrics tracking total revenue, discounts, taxes, payment methods, and charge types for financial performance management"
  source: "`vibe_travel_hospitality_v1`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date of the charge for daily revenue tracking"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (treatment, product, package, addon) for revenue mix analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (cash, credit, room charge, loyalty points) for payment trend analysis"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of charge posting (posted, pending, voided) for revenue recognition tracking"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month of charge for monthly revenue trends and forecasting"
    - name: "revenue_center_code"
      expr: revenue_center_code
      comment: "Revenue center code for departmental revenue allocation"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of charge transactions for volume tracking"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross revenue from all spa charges - primary revenue KPI"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given - key metric for promotional effectiveness and margin management"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected for tax remittance and compliance"
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected for gratuity and service fee tracking"
    - name: "net_revenue"
      expr: SUM((CAST(total_charge_amount AS DOUBLE)) - (CAST(discount_amount AS DOUBLE)))
      comment: "Net revenue after discounts - critical for profitability analysis"
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction - key metric for pricing strategy and guest spend behavior"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of revenue discounted - critical for margin management and promotional ROI"
    - name: "voided_charges"
      expr: SUM(CASE WHEN voided_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of voided charges for error rate and fraud monitoring"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items/services charged for volume analysis"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all charges for pricing benchmarking"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership metrics tracking enrollment, retention, revenue, cancellations, and member lifecycle for subscription business management"
  source: "`vibe_travel_hospitality_v1`.`spa`.`membership`"
  dimensions:
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date member enrolled for cohort and acquisition trend analysis"
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status (active, suspended, cancelled, expired) for retention analysis"
    - name: "membership_tier"
      expr: membership_tier
      comment: "Membership tier level for segmentation and value analysis"
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership (individual, couple, family, corporate) for product mix analysis"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for monthly acquisition trends"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for billing and payment trend analysis"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of member referral for marketing attribution and channel effectiveness"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of memberships for portfolio size tracking"
    - name: "active_memberships"
      expr: SUM(CASE WHEN membership_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active memberships - primary membership health KPI"
    - name: "cancelled_memberships"
      expr: SUM(CASE WHEN membership_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled memberships for churn analysis"
    - name: "suspended_memberships"
      expr: SUM(CASE WHEN membership_status = 'suspended' THEN 1 ELSE 0 END)
      comment: "Number of suspended memberships for at-risk member identification"
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual fee revenue - key recurring revenue metric"
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly fee revenue for MRR tracking"
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per membership for pricing strategy"
    - name: "avg_monthly_fee"
      expr: AVG(CAST(monthly_fee AS DOUBLE))
      comment: "Average monthly fee per membership for MRR per member analysis"
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN membership_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships currently active - critical retention KPI for subscription business health"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN membership_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships cancelled - key churn metric for business sustainability"
    - name: "auto_renewal_adoption_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships with auto-renewal enabled - indicator of member commitment and billing efficiency"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across memberships for promotional impact analysis"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa retail sales metrics tracking product revenue, transaction volume, basket size, and payment methods for retail operations management"
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of retail transaction for daily sales tracking"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of transaction (completed, pending, refunded, voided) for transaction lifecycle analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for payment trend and preference analysis"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (in-spa, online, mobile) for omnichannel performance tracking"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for monthly retail revenue trends"
    - name: "pos_terminal_code"
      expr: pos_terminal_code
      comment: "POS terminal code for location-based sales analysis"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of retail transactions for volume tracking"
    - name: "total_retail_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total retail revenue - primary retail performance KPI"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before tax and service charges for gross margin analysis"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount for promotional effectiveness tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected for tax remittance"
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected"
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value - key metric for basket size and pricing strategy"
    - name: "avg_items_per_transaction"
      expr: AVG(CAST(item_count AS DOUBLE))
      comment: "Average number of items per transaction for cross-sell effectiveness"
    - name: "total_quantity_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of products sold for inventory planning"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of revenue discounted - critical for margin management"
    - name: "refund_count"
      expr: SUM(CASE WHEN transaction_status = 'refunded' THEN 1 ELSE 0 END)
      comment: "Number of refunded transactions for return rate and satisfaction tracking"
    - name: "loyalty_redemption_count"
      expr: SUM(CASE WHEN loyalty_points_redeemed IS NOT NULL AND loyalty_points_redeemed != '' THEN 1 ELSE 0 END)
      comment: "Number of transactions using loyalty points for program engagement tracking"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist workforce metrics tracking utilization, performance, certification compliance, and guest satisfaction for labor management and quality assurance"
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist`"
  dimensions:
    - name: "therapist_status"
      expr: therapist_status
      comment: "Current employment status (active, on-leave, terminated) for workforce planning"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (full-time, part-time, contractor) for labor cost analysis"
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level for skill mix and service capability analysis"
    - name: "gender"
      expr: gender
      comment: "Therapist gender for matching guest preferences and diversity tracking"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for cohort retention and onboarding effectiveness analysis"
    - name: "specializations"
      expr: specializations
      comment: "Therapist specializations for service capability and scheduling optimization"
  measures:
    - name: "total_therapists"
      expr: COUNT(1)
      comment: "Total number of therapists for workforce size tracking"
    - name: "active_therapists"
      expr: SUM(CASE WHEN therapist_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active therapists - key capacity metric for scheduling and demand planning"
    - name: "avg_guest_rating"
      expr: AVG(CAST(guest_rating_average AS DOUBLE))
      comment: "Average guest rating across all therapists - critical quality and satisfaction KPI"
    - name: "avg_years_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience for skill level and service quality benchmarking"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate for labor cost modeling"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate for labor cost analysis and budgeting"
    - name: "avg_appointments_completed"
      expr: AVG(CAST(total_appointments_completed AS DOUBLE))
      comment: "Average appointments completed per therapist for productivity benchmarking"
    - name: "certification_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN next_certification_due_date >= CURRENT_DATE() OR next_certification_due_date IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of therapists with current certifications - critical compliance and quality KPI"
    - name: "tip_eligible_therapists"
      expr: SUM(CASE WHEN tip_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tip-eligible therapists for gratuity policy and compensation planning"
    - name: "terminated_therapists"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of terminated therapists for turnover analysis"
    - name: "turnover_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Therapist turnover rate - critical HR metric for retention strategy and recruitment planning"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_treatment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment catalog metrics tracking service offerings, pricing, profitability, and availability for product management and revenue optimization"
  source: "`vibe_travel_hospitality_v1`.`spa`.`treatment`"
  dimensions:
    - name: "treatment_category"
      expr: treatment_category
      comment: "Treatment category (massage, facial, body treatment, etc.) for service mix analysis"
    - name: "treatment_status"
      expr: treatment_status
      comment: "Status of treatment offering (active, inactive, seasonal) for menu management"
    - name: "subcategory"
      expr: subcategory
      comment: "Treatment subcategory for detailed service segmentation"
    - name: "skill_level_required"
      expr: skill_level_required
      comment: "Skill level required to perform treatment for staffing and training planning"
    - name: "gender_preference"
      expr: gender_preference
      comment: "Gender preference for treatment delivery for scheduling optimization"
    - name: "seasonal_availability"
      expr: seasonal_availability
      comment: "Seasonal availability pattern for capacity and menu planning"
  measures:
    - name: "total_treatments"
      expr: COUNT(1)
      comment: "Total number of treatment offerings for menu breadth tracking"
    - name: "active_treatments"
      expr: SUM(CASE WHEN treatment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active treatment offerings for current menu size"
    - name: "avg_treatment_price"
      expr: AVG(CAST(recommended_retail_price AS DOUBLE))
      comment: "Average treatment price for pricing strategy and competitive positioning"
    - name: "avg_treatment_duration"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average treatment duration in minutes for capacity planning and scheduling"
    - name: "avg_cost_of_goods"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average cost of goods per treatment for margin analysis"
    - name: "total_treatment_revenue_potential"
      expr: SUM(CAST(recommended_retail_price AS DOUBLE))
      comment: "Total revenue potential from all treatments at recommended retail price"
    - name: "avg_margin_per_treatment"
      expr: AVG(CAST(recommended_retail_price AS DOUBLE) - CAST(cost_of_goods AS DOUBLE))
      comment: "Average gross margin per treatment - key profitability metric for menu optimization"
    - name: "commission_eligible_treatments"
      expr: SUM(CASE WHEN commission_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of treatments eligible for commission for compensation planning"
    - name: "package_eligible_treatments"
      expr: SUM(CASE WHEN package_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of treatments eligible for packages for bundling strategy"
    - name: "pregnancy_safe_treatments"
      expr: SUM(CASE WHEN pregnancy_safe_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of pregnancy-safe treatments for specialized service capability"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate for labor cost modeling"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_cancellation_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation behavior metrics tracking cancellation patterns, fees, reasons, and advance notice for policy effectiveness and revenue protection"
  source: "`vibe_travel_hospitality_v1`.`spa`.`cancellation_log`"
  dimensions:
    - name: "cancellation_date"
      expr: DATE(cancellation_timestamp)
      comment: "Date of cancellation for trend analysis"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Coded cancellation reason for root cause analysis"
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type of cancellation (guest-initiated, property-initiated, system) for accountability tracking"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel through which cancellation was made for process optimization"
    - name: "cancelled_by_party"
      expr: cancelled_by_party
      comment: "Party who initiated cancellation (guest, staff, system) for responsibility analysis"
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Month of cancellation for monthly trend analysis"
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellations for volume tracking"
    - name: "late_cancellations"
      expr: SUM(CASE WHEN late_cancellation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of late cancellations - key metric for policy enforcement and revenue protection"
    - name: "no_shows"
      expr: SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of no-shows for operational impact and policy effectiveness"
    - name: "total_cancellation_fees"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees collected for revenue recovery tracking"
    - name: "total_fees_waived"
      expr: SUM(CASE WHEN cancellation_fee_waived_flag = TRUE THEN CAST(cancellation_fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Total cancellation fees waived for policy exception and guest service analysis"
    - name: "total_original_value"
      expr: SUM(CAST(original_appointment_value AS DOUBLE))
      comment: "Total original value of cancelled appointments - represents revenue at risk"
    - name: "total_revenue_recovery"
      expr: SUM(CAST(revenue_recovery_amount AS DOUBLE))
      comment: "Total revenue recovered from cancellations through fees and rebooking"
    - name: "avg_advance_notice_hours"
      expr: AVG(CAST(advance_notice_hours AS DOUBLE))
      comment: "Average advance notice hours for cancellations - indicator of guest behavior and policy effectiveness"
    - name: "late_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN late_cancellation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that are late - critical for policy design and revenue protection"
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_fee_waived_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN cancellation_fee_applicable_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of applicable fees that were waived - indicator of policy enforcement consistency"
    - name: "rebooking_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rebooking_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that resulted in rebooking - key retention and recovery metric"
    - name: "revenue_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_appointment_value AS DOUBLE)), 0), 2)
      comment: "Percentage of original value recovered - critical KPI for cancellation policy ROI"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_fitness_class_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fitness class session metrics tracking attendance, utilization, waitlist, and revenue for group fitness operations management"
  source: "`vibe_travel_hospitality_v1`.`spa`.`fitness_class_session`"
  dimensions:
    - name: "session_date"
      expr: session_date
      comment: "Date of fitness class session for daily scheduling and attendance tracking"
    - name: "session_status"
      expr: session_status
      comment: "Status of session (scheduled, completed, cancelled) for operational tracking"
    - name: "booking_status"
      expr: booking_status
      comment: "Booking status (open, full, waitlist) for capacity management"
    - name: "difficulty_level"
      expr: difficulty_level
      comment: "Difficulty level of class for guest segmentation and programming"
    - name: "class_format"
      expr: class_format
      comment: "Format of class (in-person, virtual, hybrid) for delivery model analysis"
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_date)
      comment: "Month of session for monthly trend and seasonality analysis"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of fitness class sessions for programming volume tracking"
    - name: "completed_sessions"
      expr: SUM(CASE WHEN session_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of completed sessions for service delivery tracking"
    - name: "cancelled_sessions"
      expr: SUM(CASE WHEN session_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled sessions for operational reliability tracking"
    - name: "total_enrolled"
      expr: SUM(CAST(enrolled_count AS DOUBLE))
      comment: "Total enrollments across all sessions for demand tracking"
    - name: "total_attended"
      expr: SUM(CAST(actual_attendance_count AS DOUBLE))
      comment: "Total actual attendance across all sessions for utilization tracking"
    - name: "total_waitlist"
      expr: SUM(CAST(waitlist_count AS DOUBLE))
      comment: "Total waitlist count for unmet demand and capacity expansion planning"
    - name: "avg_enrollment_per_session"
      expr: AVG(CAST(enrolled_count AS DOUBLE))
      comment: "Average enrollment per session for capacity planning"
    - name: "avg_attendance_per_session"
      expr: AVG(CAST(actual_attendance_count AS DOUBLE))
      comment: "Average attendance per session for utilization analysis"
    - name: "avg_session_price"
      expr: AVG(CAST(session_price AS DOUBLE))
      comment: "Average session price for pricing strategy"
    - name: "total_session_revenue"
      expr: SUM(CAST(session_price AS DOUBLE) * CAST(enrolled_count AS DOUBLE))
      comment: "Total revenue from fitness class sessions"
    - name: "utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(enrolled_count AS DOUBLE)) / NULLIF(SUM(CAST(maximum_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of capacity utilized - critical KPI for space and instructor optimization"
    - name: "attendance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_attendance_count AS DOUBLE)) / NULLIF(SUM(CAST(enrolled_count AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled guests who actually attended - key metric for no-show management and forecasting"
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_retail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail inventory metrics tracking stock levels, turnover, shrinkage, and reorder triggers for inventory management and working capital optimization"
  source: "`vibe_travel_hospitality_v1`.`spa`.`retail_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of inventory (in-stock, low-stock, out-of-stock, expired) for availability management"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location for space utilization and picking optimization"
    - name: "last_replenishment_month"
      expr: DATE_TRUNC('MONTH', last_replenishment_date)
      comment: "Month of last replenishment for replenishment cycle analysis"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of expiration for expiry management and waste reduction"
  measures:
    - name: "total_inventory_items"
      expr: COUNT(1)
      comment: "Total number of inventory line items for SKU breadth tracking"
    - name: "total_current_stock_quantity"
      expr: SUM(CAST(current_stock_quantity AS DOUBLE))
      comment: "Total current stock quantity across all items for inventory volume tracking"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity (not reserved) for sellable inventory tracking"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total reserved quantity for order fulfillment planning"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value AS DOUBLE))
      comment: "Total inventory value at cost - key working capital metric"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total inventory variance quantity for shrinkage and accuracy tracking"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost for cost benchmarking"
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price for pricing analysis"
    - name: "avg_margin_per_unit"
      expr: AVG(CAST(unit_retail_price AS DOUBLE) - CAST(unit_cost AS DOUBLE))
      comment: "Average gross margin per unit - key profitability metric for product mix optimization"
    - name: "out_of_stock_items"
      expr: SUM(CASE WHEN current_stock_quantity = 0 THEN 1 ELSE 0 END)
      comment: "Number of out-of-stock items for availability and service level tracking"
    - name: "reorder_triggered_items"
      expr: SUM(CASE WHEN reorder_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items triggering reorder for replenishment workload tracking"
    - name: "stockout_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN current_stock_quantity = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items out of stock - critical service level and revenue loss indicator"
    - name: "inventory_accuracy_pct"
      expr: ROUND(100.0 * (COUNT(1) - SUM(CASE WHEN variance_quantity != 0 THEN 1 ELSE 0 END)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items with zero variance - key operational excellence metric for inventory control"
$$;