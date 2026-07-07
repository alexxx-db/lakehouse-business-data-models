-- Metric views for domain: reservation | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-27 02:47:23

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking volume, average daily rate, cancellation exposure, and loyalty engagement. Primary steering dashboard for Revenue Management and Front Office leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the reservation (e.g., confirmed, cancelled, checked-in, no-show). Enables segmentation of active vs. lost bookings."
    - name: "booking_date"
      expr: booking_date
      comment: "Calendar date the reservation was created. Used for booking pace and lead-time trend analysis."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Scheduled guest arrival date. Drives occupancy forecasting and revenue projection by stay date."
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled guest departure date. Used alongside arrival_date to compute stay windows."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the booking was transacted. Required for multi-currency revenue normalization."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Payment guarantee type (e.g., credit card, deposit, corporate). Indicates financial risk exposure per booking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used for the reservation. Supports payment mix and fraud risk analysis."
    - name: "package_code"
      expr: package_code
      comment: "Package or bundle code associated with the booking. Enables package revenue contribution analysis."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Indicates whether the guest holds VIP status. Used to segment high-value guest bookings for service prioritization."
    - name: "accessibility_required_flag"
      expr: accessibility_required_flag
      comment: "Flags bookings requiring accessible accommodations. Supports compliance and room inventory planning."
    - name: "early_checkin_requested_flag"
      expr: early_checkin_requested_flag
      comment: "Indicates early check-in was requested. Drives front-office operational planning and upsell opportunity tracking."
    - name: "late_checkout_requested_flag"
      expr: late_checkout_requested_flag
      comment: "Indicates late check-out was requested. Supports housekeeping scheduling and ancillary revenue tracking."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation bookings. Baseline volume KPI for booking pace and demand tracking."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue across all bookings. Primary top-line revenue KPI for Revenue Management and Finance."
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average Daily Rate (ADR) across bookings. Core hotel revenue performance indicator used in every QBR and board deck."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to travel agents and OTA channels. Directly impacts net revenue and distribution cost management."
    - name: "avg_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per booking. Benchmarks distribution cost efficiency across channels and agent relationships."
    - name: "cancelled_reservations"
      expr: COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled reservations. Tracks cancellation volume for revenue risk and demand forecasting."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that were cancelled. Critical KPI for revenue leakage and demand reliability assessment."
    - name: "vip_booking_count"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Number of bookings flagged as VIP. Tracks high-value guest volume for service resource allocation and loyalty program ROI."
    - name: "vip_booking_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total bookings that are VIP. Measures penetration of high-value guest segment in overall booking mix."
    - name: "avg_room_revenue_per_booking"
      expr: ROUND(SUM(CAST(total_room_revenue AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average room revenue generated per reservation. Compound KPI combining volume and value to assess booking quality."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active bookings. Measures portfolio utilization and demand distribution across the estate."
    - name: "distinct_guests_booked"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles with reservations. Tracks new vs. returning guest demand and loyalty program reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation financial impact and operational KPIs covering penalty recovery, refund exposure, revenue loss, OTA chargeback risk, and waiver behavior. Essential for Revenue Management, Legal, and Finance steering."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized code describing the cancellation reason. Enables root-cause analysis of cancellation drivers."
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event (e.g., guest-initiated, no-show, force majeure). Supports policy and operational segmentation."
    - name: "posting_status"
      expr: posting_status
      comment: "Financial posting status of the cancellation (e.g., posted, pending, reversed). Tracks revenue recognition readiness."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the cancellation is under dispute. Flags financial and legal risk exposure."
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Current resolution status of disputed cancellations. Tracks legal and financial resolution pipeline."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether a penalty waiver was granted. Measures waiver frequency and its revenue impact."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the cancellation qualifies for a refund. Drives refund liability forecasting."
    - name: "ota_chargeback_eligible_flag"
      expr: ota_chargeback_eligible_flag
      comment: "Flags cancellations eligible for OTA chargeback. Supports OTA contract compliance and revenue recovery tracking."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Indicates whether a cancellation penalty applies. Segments cancellations by financial consequence."
    - name: "original_arrival_date"
      expr: original_arrival_date
      comment: "Original intended arrival date of the cancelled booking. Enables stay-date-level revenue loss analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the cancellation was subsequently reversed. Tracks reinstatement activity and net cancellation impact."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method on the cancelled booking. Assesses penalty collectability by payment type."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation events. Baseline volume KPI for cancellation trend monitoring."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to cancellations. Top-line financial impact KPI for Revenue Management and Finance."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total cancellation penalties assessed. Measures revenue recovery from cancellation policy enforcement."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on cancellations. Tracks cash outflow and refund liability for Finance."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts on cancellations. Monitors OTA channel financial risk and contract compliance."
    - name: "penalty_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_lost_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of lost revenue recovered through cancellation penalties. Measures policy enforcement effectiveness."
    - name: "waiver_count"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where a penalty waiver was granted. Tracks waiver frequency for policy governance."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations receiving a penalty waiver. High waiver rates signal policy enforcement gaps or guest service trade-offs."
    - name: "disputed_cancellation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of cancellations under dispute. Tracks legal and financial risk pipeline requiring resolution."
    - name: "avg_revenue_lost_per_cancellation"
      expr: ROUND(SUM(CAST(revenue_lost_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average revenue lost per cancellation event. Compound KPI measuring the financial severity of individual cancellations."
    - name: "net_cancellation_financial_impact"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE) - CAST(penalty_amount AS DOUBLE))
      comment: "Net financial impact of cancellations after penalty recovery (revenue lost minus penalties collected). True bottom-line cancellation cost."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit lifecycle KPIs covering deposit collection, forfeiture, refund activity, and revenue recognition timing. Critical for Finance, Treasury, and Revenue Accounting governance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit (e.g., received, pending, forfeited, refunded). Drives deposit pipeline and liability reporting."
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (e.g., advance deposit, guarantee deposit). Segments deposit mix for policy and risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deposit transaction. Required for multi-currency treasury and revenue recognition reporting."
    - name: "booking_source"
      expr: booking_source
      comment: "Source channel of the booking associated with the deposit. Enables channel-level deposit collection performance analysis."
    - name: "deposit_due_date"
      expr: deposit_due_date
      comment: "Date by which the deposit was due. Used for overdue deposit tracking and cash flow forecasting."
    - name: "payment_received_date"
      expr: payment_received_date
      comment: "Date the deposit payment was actually received. Enables on-time payment rate and collection lag analysis."
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date the deposit was recognized as revenue. Supports revenue accounting period alignment and audit compliance."
    - name: "forfeiture_reason"
      expr: forfeiture_reason
      comment: "Reason the deposit was forfeited. Enables root-cause analysis of forfeiture events for policy refinement."
  measures:
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected or outstanding. Primary cash flow and liability KPI for Treasury and Finance."
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit amounts forfeited. Measures revenue captured from non-refundable deposit enforcement."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit refunds issued. Tracks cash outflow from deposit reversals for treasury management."
    - name: "forfeiture_rate"
      expr: ROUND(100.0 * SUM(CAST(forfeiture_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deposit value forfeited. Measures deposit policy enforcement effectiveness and revenue retention."
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total deposit value refunded. Tracks refund liability exposure relative to deposits collected."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per transaction. Benchmarks deposit sizing across booking sources and property types."
    - name: "net_deposit_retained"
      expr: SUM(CAST(deposit_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net deposit value retained after refunds. True cash retained from deposit program for Finance reporting."
    - name: "total_deposit_transactions"
      expr: COUNT(1)
      comment: "Total number of deposit ledger entries. Baseline volume KPI for deposit activity monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance KPIs covering contracted vs. pickup room utilization, attrition risk, revenue forecast, and commission exposure. Essential for Group Sales, Revenue Management, and Event Operations leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g., tentative, definite, cancelled, consumed). Drives group pipeline and conversion reporting."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (e.g., corporate, leisure, SMERF, tour). Enables segment-level group performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the group block contract. Required for multi-currency group revenue reporting."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date. Drives occupancy and revenue forecasting by stay period."
    - name: "departure_date"
      expr: departure_date
      comment: "Group departure date. Used with arrival_date for group stay window and room-night calculations."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Date by which rooms must be picked up or released. Critical for inventory management and attrition risk monitoring."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Indicates whether the group contract includes an attrition clause. Flags blocks with contractual room-night minimums."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for the group block. Tracks financial commitment and cash flow exposure."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Last Room Availability flag. Indicates whether the group rate applies to all remaining inventory, impacting yield management."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group blocks. Baseline volume KPI for group sales pipeline tracking."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary group revenue pipeline KPI for Revenue Management and Finance."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts committed across group blocks. Tracks financial commitment and cash flow from group segment."
    - name: "total_commission_cost"
      expr: SUM(CAST(group_rate_amount AS DOUBLE) * CAST(commission_percentage AS DOUBLE) / 100.0)
      comment: "Estimated total commission cost across group blocks based on group rate and commission percentage. Measures distribution cost for group channel."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average group room rate across all blocks. Benchmarks group pricing against transient ADR for yield management decisions."
    - name: "avg_attrition_threshold_pct"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group contracts. Measures contractual room-night commitment levels for risk assessment."
    - name: "attrition_risk_block_count"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE THEN 1 END)
      comment: "Number of group blocks with attrition clauses. Quantifies the volume of blocks carrying contractual room-night risk."
    - name: "avg_revenue_forecast_per_block"
      expr: ROUND(SUM(CAST(revenue_forecast_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average forecasted revenue per group block. Compound KPI measuring group booking quality and deal size."
    - name: "cancelled_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled group blocks. Tracks group cancellation volume for revenue risk and sales pipeline management."
    - name: "group_cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of group blocks that were cancelled. Measures group segment reliability and revenue risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and operational KPIs covering upgrade rates, guest preference fulfillment, early/late service requests, and reassignment frequency. Drives Front Office, Housekeeping, and Guest Experience operational decisions."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment (e.g., assigned, checked-in, checked-out, reassigned). Tracks assignment lifecycle."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the room (e.g., auto-assigned, manually assigned, guest-requested). Measures automation vs. manual intervention rates."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date the room was assigned. Enables lead-time analysis between assignment and arrival."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Indicates whether the assignment was an upgrade from the booked room type. Tracks upgrade program volume and revenue impact."
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of upgrade granted (e.g., room type, floor, view). Enables upgrade mix analysis for loyalty and revenue programs."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Indicates early check-in was provided. Tracks early check-in fulfillment rate for guest satisfaction and operational planning."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Indicates late check-out was provided. Tracks late check-out fulfillment rate for housekeeping scheduling."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Indicates the assigned room is ADA/accessibility compliant. Supports compliance reporting and accessible inventory utilization."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Indicates the guest specifically requested this room. Measures guest preference fulfillment rate."
    - name: "view_type"
      expr: view_type
      comment: "View type of the assigned room (e.g., ocean, city, garden). Enables view preference fulfillment and upsell analysis."
    - name: "smoking_preference"
      expr: smoking_preference
      comment: "Smoking preference of the assigned room. Tracks preference fulfillment compliance."
  measures:
    - name: "total_room_assignments"
      expr: COUNT(1)
      comment: "Total number of room assignments. Baseline operational volume KPI for Front Office capacity planning."
    - name: "upgrade_count"
      expr: COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END)
      comment: "Total number of room upgrades granted. Tracks upgrade program volume for loyalty and revenue management."
    - name: "upgrade_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room assignments that resulted in an upgrade. Key loyalty and guest satisfaction KPI used in brand standard reviews."
    - name: "guest_requested_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments where the guest's specific room request was fulfilled. Directly linked to guest satisfaction scores."
    - name: "avg_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score across all room assignments. Compound quality KPI measuring how well assignments align with guest profiles."
    - name: "reassignment_count"
      expr: COUNT(CASE WHEN reassignment_count > '0' THEN 1 END)
      comment: "Number of assignments that required at least one reassignment. Tracks operational disruption and guest experience risk."
    - name: "early_checkin_fulfillment_count"
      expr: COUNT(CASE WHEN early_checkin_flag = TRUE THEN 1 END)
      comment: "Number of early check-ins fulfilled. Measures early check-in service delivery volume for operational and revenue reporting."
    - name: "late_checkout_fulfillment_count"
      expr: COUNT(CASE WHEN late_checkout_flag = TRUE THEN 1 END)
      comment: "Number of late check-outs fulfilled. Measures late check-out service delivery volume impacting housekeeping scheduling."
    - name: "distinct_rooms_assigned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of distinct rooms assigned. Measures room inventory utilization breadth across the property."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment KPIs covering fulfillment rates, failure analysis, charge revenue, VIP request handling, and guest satisfaction. Drives Guest Experience, Operations, and Loyalty program management decisions."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`special_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (e.g., amenity, accessibility, dietary, transport). Enables category-level fulfillment performance analysis."
    - name: "request_category"
      expr: request_category
      comment: "Broader category grouping of the request. Supports operational routing and resource allocation by request category."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the request (e.g., fulfilled, pending, failed, partial). Core operational KPI dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the request (e.g., high, medium, low). Enables SLA compliance analysis by priority tier."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Indicates the request is from a VIP guest. Enables VIP-specific fulfillment rate and failure analysis."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Indicates the request was made before arrival. Supports pre-arrival vs. in-stay fulfillment performance comparison."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Indicates whether the request incurs a charge. Segments chargeable vs. complimentary requests for revenue tracking."
    - name: "request_source"
      expr: request_source
      comment: "Channel through which the request was submitted (e.g., app, front desk, concierge). Enables channel-level request volume and fulfillment analysis."
    - name: "failure_category"
      expr: failure_category
      comment: "Category of failure for unfulfilled requests. Drives root-cause analysis and operational improvement initiatives."
    - name: "impacts_loyalty_points"
      expr: impacts_loyalty_points
      comment: "Indicates whether the request impacts loyalty point accrual. Tracks loyalty program touchpoints through service delivery."
    - name: "target_fulfillment_date"
      expr: target_fulfillment_date
      comment: "Target date for fulfilling the request. Enables on-time fulfillment rate and SLA compliance analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests submitted. Baseline volume KPI for guest services demand planning."
    - name: "fulfilled_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END)
      comment: "Number of special requests successfully fulfilled. Core guest experience delivery KPI."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Primary guest experience quality KPI used in brand standard and satisfaction reviews."
    - name: "vip_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip_request = TRUE AND fulfillment_status = 'fulfilled' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END), 0), 2)
      comment: "Fulfillment rate specifically for VIP guest requests. Critical loyalty and brand standard KPI — VIP failures directly impact retention."
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue generated from chargeable special requests. Measures ancillary revenue contribution from guest services."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill special requests. Enables margin analysis on guest services delivery."
    - name: "avg_guest_satisfaction_rating"
      expr: AVG(CAST(guest_satisfaction_rating AS DOUBLE))
      comment: "Average guest satisfaction rating for fulfilled special requests. Direct guest experience quality indicator linked to NPS and loyalty outcomes."
    - name: "failed_request_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'failed' THEN 1 END)
      comment: "Number of special requests that failed to be fulfilled. Tracks service failure volume for operational improvement and guest recovery programs."
    - name: "request_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests that failed. Measures service delivery risk and operational gap for management intervention."
    - name: "charge_to_cost_ratio"
      expr: ROUND(SUM(CAST(charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of charge revenue to actual fulfillment cost for chargeable requests. Measures profitability of the paid guest services program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent and agency performance KPIs covering revenue generation, commission rates, booking volume tiers, and contract health. Drives Distribution, Sales, and Finance decisions on agency partnerships."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "travel_agent_status"
      expr: travel_agent_status
      comment: "Current status of the travel agent (e.g., active, inactive, suspended). Segments active vs. inactive agency relationships."
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (e.g., OTA, brick-and-mortar, corporate TMC, wholesale). Enables channel-type performance benchmarking."
    - name: "booking_volume_tier"
      expr: booking_volume_tier
      comment: "Volume tier classification of the agency (e.g., platinum, gold, silver). Supports tiered commission and partnership management."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agency. Enables geographic distribution analysis of booking sources."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used by the travel agent. Required for multi-currency commission and revenue reporting."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Preferred payment method of the agency. Supports payment operations and settlement planning."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the agency contract. Enables contract tenure and renewal cycle analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the agency contract. Tracks upcoming contract expirations for renewal pipeline management."
    - name: "last_booking_date"
      expr: last_booking_date
      comment: "Date of the most recent booking from this agent. Identifies dormant agencies for reactivation campaigns."
  measures:
    - name: "total_active_agents"
      expr: COUNT(CASE WHEN travel_agent_status = 'active' THEN 1 END)
      comment: "Number of active travel agents in the distribution network. Tracks active channel partner count for distribution strategy."
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated across all travel agents. Primary distribution channel revenue KPI for Sales and Finance."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across travel agents. Benchmarks distribution cost and informs commission structure negotiations."
    - name: "avg_revenue_per_agent"
      expr: ROUND(SUM(CAST(total_revenue_generated AS DOUBLE)) / NULLIF(COUNT(DISTINCT travel_agent_id), 0), 2)
      comment: "Average revenue generated per travel agent. Compound KPI measuring agency productivity and partnership value."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all travel agents. Measures financial exposure and credit risk in the distribution network."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per travel agent. Benchmarks credit exposure by agency tier for risk management."
    - name: "distinct_active_agents"
      expr: COUNT(DISTINCT CASE WHEN travel_agent_status = 'active' THEN travel_agent_id END)
      comment: "Count of distinct active travel agent IDs. Precise active network size metric for distribution coverage analysis."
    - name: "revenue_concentration_top_agent"
      expr: MAX(CAST(total_revenue_generated AS DOUBLE))
      comment: "Revenue generated by the single highest-producing travel agent. Measures revenue concentration risk in the distribution network."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking status change event KPIs covering modification patterns, SLA compliance, penalty fee recovery, revenue impact of changes, and dispute tracking. Drives Revenue Management, Operations, and Compliance governance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking status event (e.g., modification, cancellation, no-show). Segments event volume by operational category."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification applied (e.g., date change, rate change, room type change). Enables modification pattern analysis."
    - name: "new_status"
      expr: new_status
      comment: "Status the booking transitioned to. Tracks booking lifecycle state transitions."
    - name: "previous_status"
      expr: previous_status
      comment: "Status the booking held before the event. Enables transition-pair analysis (e.g., confirmed → cancelled)."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the event was processed within SLA. Tracks operational compliance with service level agreements."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the status change event is under dispute. Flags events with financial or legal risk."
    - name: "guest_notification_sent_flag"
      expr: guest_notification_sent_flag
      comment: "Indicates whether the guest was notified of the status change. Tracks communication compliance and guest experience quality."
    - name: "system_source"
      expr: system_source
      comment: "Source system that generated the event (e.g., PMS, CRS, OTA). Enables system-level event volume and error analysis."
    - name: "event_date"
      expr: event_date
      comment: "Date of the booking status event. Enables time-series trend analysis of modification and cancellation activity."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for cancellation events. Supports root-cause analysis of cancellation drivers."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of booking status change events. Baseline operational volume KPI for change management and audit tracking."
    - name: "total_penalty_fees_assessed"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees assessed across all status change events. Measures revenue recovery from policy enforcement on modifications and cancellations."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (positive or negative) from booking status changes. Measures net financial effect of all booking modifications."
    - name: "total_rate_difference_amount"
      expr: SUM(CAST(rate_difference_amount AS DOUBLE))
      comment: "Total rate difference amounts from booking modifications. Tracks revenue uplift or dilution from rate changes on modified bookings."
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of booking status events processed within SLA. Operational compliance KPI for process governance and vendor management."
    - name: "guest_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status change events where the guest was notified. Measures communication compliance and guest experience quality."
    - name: "disputed_event_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of booking status events under dispute. Tracks dispute volume for legal and financial risk management."
    - name: "avg_revenue_impact_per_event"
      expr: ROUND(SUM(CAST(revenue_impact_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average revenue impact per booking status change event. Compound KPI measuring the financial materiality of individual booking changes."
$$;