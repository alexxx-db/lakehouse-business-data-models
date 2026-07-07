-- Metric views for domain: spa | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment performance metrics covering booking volume, cancellation behaviour, no-show rates, prepayment capture, and scheduling efficiency. Primary operational KPI layer for spa revenue management and therapist utilisation decisions."
  source: "`vibe_travel_hospitality_v1`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Calendar date of the spa appointment — primary time grain for trend analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current lifecycle status of the appointment (e.g. Confirmed, Cancelled, Completed, No-Show) — key segmentation for conversion and fulfilment analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (e.g. Online, Front Desk, Phone, OTA) — drives channel mix and digital adoption reporting."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for appointment cancellation — used to identify preventable cancellation patterns."
    - name: "guest_gender_preference"
      expr: guest_gender_preference
      comment: "Guest's stated therapist gender preference — informs therapist staffing and scheduling decisions."
    - name: "therapist_gender_preference"
      expr: therapist_gender_preference
      comment: "Guest's stated preference for therapist gender — used alongside guest_gender_preference for fulfilment gap analysis."
    - name: "pressure_preference"
      expr: pressure_preference
      comment: "Guest's stated massage pressure preference — supports personalisation and therapist matching quality metrics."
    - name: "intake_form_completed"
      expr: intake_form_completed
      comment: "Boolean flag indicating whether the guest completed the pre-treatment intake form — proxy for guest preparedness and compliance."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Boolean flag indicating the guest did not arrive for a confirmed appointment — key driver of lost revenue and therapist idle time."
    - name: "prepayment_currency_code"
      expr: prepayment_currency_code
      comment: "Currency of the prepayment collected at booking — supports multi-currency revenue reporting."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointment records — baseline volume KPI for spa demand and capacity planning."
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'Completed' THEN 1 END)
      comment: "Count of appointments with Completed status — measures actual service delivery volume and therapist productivity."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled appointments — tracks cancellation volume to assess revenue leakage and policy effectiveness."
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of no-show appointments — directly quantifies lost revenue from guests who did not arrive."
    - name: "rescheduled_appointments"
      expr: COUNT(CASE WHEN rescheduled_appointment_id IS NOT NULL THEN 1 END)
      comment: "Count of appointments that were rescheduled — indicates scheduling flexibility demand and operational friction."
    - name: "total_prepayment_amount"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment revenue collected at booking — measures advance cash capture and financial risk mitigation from cancellations."
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment amount per appointment — benchmarks prepayment policy effectiveness and deposit level adequacy."
    - name: "intake_form_completion_count"
      expr: COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END)
      comment: "Count of appointments where the intake form was completed — measures guest compliance with pre-treatment health screening protocols."
    - name: "appointments_with_package"
      expr: COUNT(CASE WHEN package_id IS NOT NULL THEN 1 END)
      comment: "Count of appointments linked to a spa package — measures package attachment rate as a revenue bundling KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge analytics covering total revenue, discounting, tax, service charges, gratuity, and payment behaviour. Primary financial KPI layer for spa P&L management, yield optimisation, and revenue integrity."
  source: "`vibe_travel_hospitality_v1`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date the charge was posted — primary time grain for daily and period revenue reporting."
    - name: "charge_type"
      expr: charge_type
      comment: "Classification of the charge (e.g. Treatment, Retail, Membership, Package) — enables revenue mix analysis by category."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Credit Card, Cash, Room Charge, Gift Certificate) — informs payment channel and settlement analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the charge (e.g. Posted, Voided, Adjusted) — critical for revenue integrity and audit reporting."
    - name: "revenue_center_code"
      expr: revenue_center_code
      comment: "Revenue centre to which the charge is attributed — supports departmental P&L and cost centre reporting."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the charge — enables financial system reconciliation and accounting integration."
    - name: "discount_code"
      expr: discount_code
      comment: "Discount code applied to the charge — tracks promotional discount usage and its revenue impact."
    - name: "gratuity_included_flag"
      expr: gratuity_included_flag
      comment: "Boolean flag indicating whether gratuity is included in the charge — used for gratuity revenue reporting and therapist compensation analysis."
  measures:
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross revenue from all spa charges — primary top-line revenue KPI for spa financial performance."
    - name: "avg_charge_value"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge value per transaction — benchmarks spend per visit and tracks yield per service interaction."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across all charges — measures promotional cost and discount leakage against gross revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on spa charges — required for tax compliance reporting and remittance reconciliation."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected — measures ancillary fee revenue and supports service charge policy evaluation."
    - name: "total_unit_price_revenue"
      expr: SUM(CAST(unit_price AS DOUBLE))
      comment: "Sum of unit prices across all charge line items — used to compute average unit price and rack rate realisation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per charge line — benchmarks pricing consistency and identifies rate integrity issues."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Count of voided charges — tracks revenue reversal volume as a financial control and fraud detection KPI."
    - name: "voided_charge_amount"
      expr: SUM(CASE WHEN voided_timestamp IS NOT NULL THEN CAST(total_charge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of voided charges — quantifies revenue at risk from voids and supports revenue integrity audits."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items charged — measures service volume throughput and supports per-unit revenue analysis."
    - name: "charges_with_discount"
      expr: COUNT(CASE WHEN discount_amount > 0 THEN 1 END)
      comment: "Count of charges where a discount was applied — measures discount frequency to evaluate promotional programme reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership lifecycle and revenue metrics covering active membership base, fee revenue, renewal rates, discount levels, and cancellation patterns. Strategic KPI layer for membership programme health and recurring revenue management."
  source: "`vibe_travel_hospitality_v1`.`spa`.`membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (e.g. Active, Cancelled, Suspended, Expired) — primary segmentation for membership base health reporting."
    - name: "membership_type"
      expr: membership_type
      comment: "Type or tier of spa membership (e.g. Basic, Premium, Corporate) — drives revenue mix and upsell opportunity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which membership fees are denominated — supports multi-currency revenue reporting."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type used for membership billing (e.g. Credit Card, Direct Debit) — informs payment failure risk and churn prediction."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean flag indicating whether the membership is set to auto-renew — key predictor of retention and recurring revenue stability."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for membership cancellation — identifies root causes of churn for retention programme design."
    - name: "referral_source"
      expr: referral_source
      comment: "Source through which the member was referred or acquired — supports acquisition channel ROI analysis."
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in_flag
      comment: "Boolean flag indicating member consent to marketing communications — measures marketable audience size within the membership base."
    - name: "included_fitness_access"
      expr: included_fitness_access
      comment: "Boolean flag indicating whether the membership includes fitness facility access — used for cross-facility utilisation and bundling analysis."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of membership records — baseline volume KPI for membership programme scale."
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN 1 END)
      comment: "Count of currently active memberships — primary KPI for recurring revenue base size and programme health."
    - name: "cancelled_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled memberships — measures churn volume and triggers retention intervention analysis."
    - name: "suspended_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Suspended' THEN 1 END)
      comment: "Count of suspended memberships — tracks at-risk members who may convert to cancellations without intervention."
    - name: "auto_renewal_memberships"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of memberships with auto-renewal enabled — measures predictable recurring revenue base and retention programme effectiveness."
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual membership fee revenue — primary recurring revenue KPI for spa membership programme financial performance."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual membership fee — benchmarks pricing tier mix and tracks yield per member."
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly membership fee revenue — measures monthly recurring revenue (MRR) for cash flow planning."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to memberships — tracks promotional discount depth and its impact on membership yield."
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees collected — measures revenue recovered from early cancellations and evaluates contract enforcement effectiveness."
    - name: "renewed_memberships"
      expr: COUNT(CASE WHEN renewed_membership_id IS NOT NULL THEN 1 END)
      comment: "Count of memberships that have been renewed — measures renewal volume as a direct indicator of member loyalty and programme stickiness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa therapist workforce quality and performance metrics covering guest satisfaction ratings, experience levels, commission rates, and workforce composition. Strategic KPI layer for talent management, staffing decisions, and service quality assurance."
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist`"
  dimensions:
    - name: "therapist_status"
      expr: therapist_status
      comment: "Current employment status of the therapist (e.g. Active, On Leave, Terminated) — primary segmentation for active workforce reporting."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g. Full-Time, Part-Time, Contractor) — drives labour cost and scheduling flexibility analysis."
    - name: "certification_level"
      expr: certification_level
      comment: "Professional certification level of the therapist — used for service quality tiering and treatment eligibility assignment."
    - name: "gender"
      expr: gender
      comment: "Therapist gender — used to match against guest gender preferences and ensure adequate staffing balance."
    - name: "primary_license_state"
      expr: primary_license_state
      comment: "State in which the therapist holds their primary licence — supports regulatory compliance and licence expiry monitoring."
    - name: "tip_eligible_flag"
      expr: tip_eligible_flag
      comment: "Boolean flag indicating whether the therapist is eligible to receive gratuities — used in compensation and incentive programme reporting."
  measures:
    - name: "total_therapists"
      expr: COUNT(1)
      comment: "Total number of therapist records — baseline workforce headcount KPI for capacity planning."
    - name: "active_therapists"
      expr: COUNT(CASE WHEN therapist_status = 'Active' THEN 1 END)
      comment: "Count of currently active therapists — measures available service delivery capacity and informs hiring decisions."
    - name: "avg_guest_rating"
      expr: AVG(CAST(guest_rating_average AS DOUBLE))
      comment: "Average guest satisfaction rating across all therapists — primary service quality KPI used in performance reviews and therapist development planning."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of professional experience across the therapist workforce — measures team seniority and informs training investment decisions."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across therapists — benchmarks compensation cost structure and supports commission policy reviews."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across therapists — measures labour cost per hour and supports workforce cost modelling."
    - name: "therapists_with_expiring_license"
      expr: COUNT(CASE WHEN primary_license_expiry_date IS NOT NULL THEN 1 END)
      comment: "Count of therapists with a recorded licence expiry date — used to proactively manage regulatory compliance and avoid service disruptions from lapsed licences."
    - name: "therapists_with_supervisor"
      expr: COUNT(CASE WHEN supervisor_therapist_id IS NOT NULL THEN 1 END)
      comment: "Count of therapists assigned to a supervisor — measures supervisory coverage ratio and organisational structure completeness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_therapist_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist scheduling efficiency and utilisation metrics covering booked vs available hours, overtime, schedule variance, and shift fulfilment. Operational KPI layer for workforce scheduling optimisation and labour cost management."
  source: "`vibe_travel_hospitality_v1`.`spa`.`therapist_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the therapist schedule record — primary time grain for daily scheduling and utilisation trend analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule record (e.g. Published, Confirmed, Cancelled) — used to filter active vs cancelled shifts in utilisation reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Morning, Afternoon, Evening, Split) — enables shift pattern analysis and staffing mix optimisation."
    - name: "primary_treatment_specialty"
      expr: primary_treatment_specialty
      comment: "Primary treatment specialty assigned for the shift — supports specialty-level demand vs supply gap analysis."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Boolean flag indicating whether the therapist is eligible for overtime on this schedule — used in labour cost forecasting and compliance reporting."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for schedule cancellation — identifies patterns in shift cancellations to reduce last-minute staffing gaps."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total hours scheduled across all therapist shifts — measures planned service delivery capacity for workforce planning."
    - name: "total_available_hours"
      expr: SUM(CAST(total_available_hours AS DOUBLE))
      comment: "Total hours therapists were available for bookings — denominator for utilisation rate calculation and capacity gap analysis."
    - name: "total_booked_hours"
      expr: SUM(CAST(total_booked_hours AS DOUBLE))
      comment: "Total hours booked with appointments — measures actual demand fulfilment against available capacity."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked by therapists — measures true labour input and supports payroll and productivity analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked — measures labour cost overrun and informs staffing level adequacy decisions."
    - name: "cancelled_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled therapist schedules — measures scheduling instability and its downstream impact on appointment availability."
    - name: "schedules_with_overtime"
      expr: COUNT(CASE WHEN overtime_hours > 0 THEN 1 END)
      comment: "Count of schedule records where overtime was worked — tracks overtime frequency to manage labour cost and therapist wellbeing."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_treatment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa treatment catalogue performance and pricing metrics covering treatment pricing, cost of goods, commission rates, and menu composition. Strategic KPI layer for treatment portfolio management, margin analysis, and pricing strategy."
  source: "`vibe_travel_hospitality_v1`.`spa`.`treatment`"
  dimensions:
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current status of the treatment (e.g. Active, Discontinued, Seasonal) — used to filter active treatment portfolio for pricing and margin analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Sub-classification within the treatment category — enables granular portfolio analysis and upsell opportunity identification."
    - name: "revenue_center"
      expr: revenue_center
      comment: "Revenue centre to which the treatment is attributed — supports departmental P&L and cost centre reporting."
    - name: "commission_eligible_flag"
      expr: commission_eligible_flag
      comment: "Boolean flag indicating whether the treatment is eligible for therapist commission — used in compensation cost modelling."
    - name: "gratuity_included_flag"
      expr: gratuity_included_flag
      comment: "Boolean flag indicating whether gratuity is included in the treatment price — used for gratuity revenue and therapist compensation reporting."
    - name: "pregnancy_safe_flag"
      expr: pregnancy_safe_flag
      comment: "Boolean flag indicating whether the treatment is safe for pregnant guests — used for inclusive service offering analysis and guest safety compliance."
    - name: "skill_level_required"
      expr: skill_level_required
      comment: "Minimum skill level required to deliver the treatment — used for therapist eligibility matching and training gap analysis."
  measures:
    - name: "total_treatments"
      expr: COUNT(1)
      comment: "Total number of treatment records in the catalogue — measures portfolio breadth for menu design and competitive benchmarking."
    - name: "active_treatments"
      expr: COUNT(CASE WHEN treatment_status = 'Active' THEN 1 END)
      comment: "Count of currently active treatments — measures the live sellable portfolio size for revenue planning."
    - name: "avg_recommended_retail_price"
      expr: AVG(CAST(recommended_retail_price AS DOUBLE))
      comment: "Average recommended retail price across treatments — benchmarks pricing level and supports rate strategy reviews."
    - name: "total_recommended_retail_price"
      expr: SUM(CAST(recommended_retail_price AS DOUBLE))
      comment: "Sum of recommended retail prices across the treatment catalogue — used to measure total portfolio value and average price per treatment category."
    - name: "avg_cost_of_goods"
      expr: AVG(CAST(cost_of_goods AS DOUBLE))
      comment: "Average cost of goods per treatment — measures direct cost input for gross margin calculation and pricing adequacy assessment."
    - name: "total_cost_of_goods"
      expr: SUM(CAST(cost_of_goods AS DOUBLE))
      comment: "Total cost of goods across the treatment catalogue — measures aggregate direct cost exposure for portfolio-level margin analysis."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across commission-eligible treatments — benchmarks therapist incentive cost and informs commission policy design."
    - name: "pregnancy_safe_treatment_count"
      expr: COUNT(CASE WHEN pregnancy_safe_flag = TRUE THEN 1 END)
      comment: "Count of treatments certified as pregnancy-safe — measures inclusive service offering breadth and supports targeted guest segment marketing."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa package pricing, commission, and availability metrics covering rack rates, promotional rates, deposit requirements, and loyalty eligibility. Strategic KPI layer for package revenue management, promotional strategy, and distribution channel optimisation."
  source: "`vibe_travel_hospitality_v1`.`spa`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (e.g. Active, Inactive, Seasonal) — primary filter for live sellable package portfolio reporting."
    - name: "package_type"
      expr: package_type
      comment: "Classification of the package (e.g. Couples, Day Retreat, Corporate) — drives package mix and revenue category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the package is priced — supports multi-currency revenue and yield reporting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the package is currently active and bookable — used to filter the live package portfolio."
    - name: "commission_eligible"
      expr: commission_eligible
      comment: "Boolean flag indicating whether the package is eligible for agent or channel commission — used in distribution cost analysis."
    - name: "loyalty_points_eligible"
      expr: loyalty_points_eligible
      comment: "Boolean flag indicating whether the package earns loyalty points — measures loyalty programme integration with spa package offerings."
    - name: "requires_deposit"
      expr: requires_deposit
      comment: "Boolean flag indicating whether a deposit is required at booking — used in advance payment capture and cancellation risk analysis."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Boolean flag indicating whether the package price is tax-inclusive — required for accurate revenue and tax reporting."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of spa package records — measures portfolio breadth for menu design and revenue bundling strategy."
    - name: "active_packages"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active and bookable packages — measures live sellable portfolio size for revenue planning."
    - name: "avg_rack_rate"
      expr: AVG(CAST(rack_rate AS DOUBLE))
      comment: "Average rack rate across spa packages — benchmarks standard pricing level and supports rate integrity monitoring."
    - name: "avg_promotional_rate"
      expr: AVG(CAST(promotional_rate AS DOUBLE))
      comment: "Average promotional rate across spa packages — measures discount depth relative to rack rate for promotional strategy evaluation."
    - name: "total_rack_rate_value"
      expr: SUM(CAST(rack_rate AS DOUBLE))
      comment: "Sum of rack rates across the package catalogue — used to compute average rack rate by category and measure total portfolio value at standard pricing."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission percentage across commission-eligible packages — benchmarks distribution cost and informs channel commission policy."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount required at booking — measures advance cash capture policy and financial risk mitigation from cancellations."
    - name: "packages_requiring_deposit"
      expr: COUNT(CASE WHEN requires_deposit = TRUE THEN 1 END)
      comment: "Count of packages that require a deposit — measures the proportion of the portfolio with advance payment protection."
    - name: "loyalty_eligible_packages"
      expr: COUNT(CASE WHEN loyalty_points_eligible = TRUE THEN 1 END)
      comment: "Count of packages eligible for loyalty points — measures loyalty programme integration depth within the spa package portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`spa_treatment_room`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa treatment room asset and operational metrics covering room capacity, asset value, maintenance status, and amenity features. Operational KPI layer for facility management, capital planning, and room utilisation optimisation."
  source: "`vibe_travel_hospitality_v1`.`spa`.`treatment_room`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the treatment room (e.g. Operational, Under Maintenance, Out of Service) — primary filter for available room capacity reporting."
    - name: "room_type"
      expr: room_type
      comment: "Type of treatment room (e.g. Single, Couples, Wet Room, VIP Suite) — drives room mix analysis and pricing tier assignment."
    - name: "maintenance_status"
      expr: maintenance_status
      comment: "Current maintenance status of the room — used to track rooms requiring maintenance and their impact on available capacity."
    - name: "gender_designation"
      expr: gender_designation
      comment: "Gender designation of the treatment room (e.g. Male, Female, Mixed) — used for room allocation matching against guest and therapist gender preferences."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Boolean flag indicating ADA/accessibility compliance — measures inclusive facility provision and regulatory compliance."
    - name: "has_private_shower"
      expr: has_private_shower
      comment: "Boolean flag indicating whether the room has a private shower — used for premium amenity inventory reporting and upsell opportunity identification."
    - name: "has_chromotherapy"
      expr: has_chromotherapy
      comment: "Boolean flag indicating chromotherapy lighting availability — measures premium feature inventory for targeted marketing and pricing."
    - name: "has_heated_table"
      expr: has_heated_table
      comment: "Boolean flag indicating whether the room has a heated treatment table — used for treatment eligibility matching and premium feature reporting."
  measures:
    - name: "total_treatment_rooms"
      expr: COUNT(1)
      comment: "Total number of treatment rooms — baseline capacity KPI for spa facility planning and revenue potential assessment."
    - name: "operational_rooms"
      expr: COUNT(CASE WHEN operational_status = 'Operational' THEN 1 END)
      comment: "Count of currently operational treatment rooms — measures available service delivery capacity and informs scheduling and revenue forecasting."
    - name: "rooms_under_maintenance"
      expr: COUNT(CASE WHEN maintenance_status IS NOT NULL AND operational_status != 'Operational' THEN 1 END)
      comment: "Count of rooms currently under maintenance or out of service — measures capacity loss from maintenance and its revenue impact."
    - name: "total_ffe_value"
      expr: SUM(CAST(ffe_value AS DOUBLE))
      comment: "Total furniture, fixtures, and equipment (FF&E) asset value across all treatment rooms — primary capital asset KPI for facility investment tracking and depreciation planning."
    - name: "avg_ffe_value"
      expr: AVG(CAST(ffe_value AS DOUBLE))
      comment: "Average FF&E asset value per treatment room — benchmarks investment level per room and supports capital refresh prioritisation."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate charged for treatment rooms — benchmarks room pricing and supports yield management analysis."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all treatment rooms — measures physical capacity footprint for space utilisation and revenue-per-square-foot analysis."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per treatment room — benchmarks room size mix and informs renovation and expansion planning."
    - name: "rooms_with_private_shower"
      expr: COUNT(CASE WHEN has_private_shower = TRUE THEN 1 END)
      comment: "Count of treatment rooms with private shower facilities — measures premium amenity inventory for pricing tier and upsell strategy."
    - name: "accessibility_compliant_rooms"
      expr: COUNT(CASE WHEN accessibility_compliant = TRUE THEN 1 END)
      comment: "Count of ADA/accessibility-compliant treatment rooms — measures inclusive facility provision and supports regulatory compliance reporting."
$$;