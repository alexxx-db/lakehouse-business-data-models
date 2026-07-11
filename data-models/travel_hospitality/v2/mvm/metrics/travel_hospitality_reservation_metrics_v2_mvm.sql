-- Metric views for domain: reservation | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 22:17:24

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservation booking KPIs covering revenue performance, booking volume, average daily rate, length-of-stay economics, commission exposure, and VIP/accessibility demand signals. Primary steering dashboard for Revenue Management and Front Office leadership."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`reservation_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current lifecycle status of the reservation (e.g. Confirmed, Cancelled, No-Show, Checked-Out). Enables segmentation of active vs. lost revenue."
    - name: "booking_date"
      expr: booking_date
      comment: "Calendar date the reservation was created. Used for booking-pace and lead-time trend analysis."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Scheduled guest arrival date. Drives occupancy forecasting and revenue-by-stay-date reporting."
    - name: "departure_date"
      expr: departure_date
      comment: "Scheduled guest departure date. Combined with arrival_date to compute stay windows."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Payment guarantee type (e.g. Credit Card, Corporate Account, Deposit). Indicates financial risk profile of the booking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment tendered (e.g. Credit Card, Direct Bill, OTA Virtual Card). Informs treasury and reconciliation workflows."
    - name: "package_code"
      expr: package_code
      comment: "Package or rate bundle code attached to the booking. Enables package-revenue attribution analysis."
    - name: "room_type_requested"
      expr: room_type_requested
      comment: "Room type category requested by the guest at time of booking. Supports demand-by-room-type analysis."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Indicates whether the guest holds VIP status (True/False). Used to segment high-value guest bookings."
    - name: "accessibility_required_flag"
      expr: accessibility_required_flag
      comment: "Indicates whether the guest requires an accessible room (True/False). Supports ADA compliance and inventory planning."
    - name: "early_checkin_requested_flag"
      expr: early_checkin_requested_flag
      comment: "Indicates whether an early check-in was requested (True/False). Drives housekeeping prioritization and upsell opportunity tracking."
    - name: "late_checkout_requested_flag"
      expr: late_checkout_requested_flag
      comment: "Indicates whether a late check-out was requested (True/False). Supports room-turn scheduling and ancillary revenue capture."
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month-level truncation of booking_date for monthly booking-pace trend analysis."
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month-level truncation of arrival_date for monthly occupancy and revenue forecasting."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of reservation records. Baseline volume KPI for booking pace and demand tracking."
    - name: "confirmed_reservations"
      expr: COUNT(CASE WHEN booking_status = 'Confirmed' THEN 1 END)
      comment: "Count of reservations in Confirmed status. Measures active, revenue-generating demand on the books."
    - name: "cancelled_reservations"
      expr: COUNT(CASE WHEN booking_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled reservations. Drives cancellation rate analysis and revenue-at-risk assessment."
    - name: "no_show_reservations"
      expr: COUNT(CASE WHEN booking_status = 'No-Show' THEN 1 END)
      comment: "Count of no-show reservations. Informs overbooking strategy and no-show penalty revenue capture."
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total room revenue across all bookings. Primary top-line revenue KPI for the reservation domain."
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average Daily Rate (ADR) across bookings. Core RevPAR component and pricing performance indicator used in every revenue steering meeting."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission expense paid to travel agents and OTA channels. Directly impacts net room revenue and distribution cost management."
    - name: "avg_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission amount per booking. Benchmarks distribution cost efficiency across channels and agent tiers."
    - name: "vip_reservation_count"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Number of VIP guest reservations. Tracks high-value guest demand and informs personalized service resource allocation."
    - name: "early_checkin_request_count"
      expr: COUNT(CASE WHEN early_checkin_requested_flag = TRUE THEN 1 END)
      comment: "Number of reservations with early check-in requests. Drives housekeeping scheduling and early check-in upsell revenue opportunity sizing."
    - name: "late_checkout_request_count"
      expr: COUNT(CASE WHEN late_checkout_requested_flag = TRUE THEN 1 END)
      comment: "Number of reservations with late check-out requests. Supports room-turn planning and late check-out fee revenue capture."
    - name: "accessibility_request_count"
      expr: COUNT(CASE WHEN accessibility_required_flag = TRUE THEN 1 END)
      comment: "Number of reservations requiring accessible rooms. Ensures ADA-compliant inventory allocation and avoids compliance risk."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique guest profiles with reservations. Measures reach and repeat-guest penetration for loyalty and CRM strategy."
    - name: "distinct_properties_booked"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving bookings. Supports portfolio-level demand distribution analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation financial impact and operational KPIs covering penalty revenue, refund exposure, OTA chargeback risk, waiver activity, and revenue lost. Essential for Revenue Management, Finance, and Guest Experience leadership to manage cancellation policy effectiveness and financial leakage."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`cancellation`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of cancellation event (e.g. Guest-Initiated, No-Show, Force Majeure). Enables root-cause segmentation of cancellation volume."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the cancellation. Drives policy refinement and demand-recovery targeting."
    - name: "posting_status"
      expr: posting_status
      comment: "Financial posting status of the cancellation (e.g. Posted, Pending, Reversed). Tracks revenue recognition completeness."
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the cancellation was processed (e.g. Direct, OTA, GDS). Identifies channel-specific cancellation patterns."
    - name: "guarantee_method"
      expr: guarantee_method
      comment: "Guarantee method on the original booking (e.g. Credit Card, Deposit). Determines penalty enforceability."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the cancellation is under dispute (True/False). Flags financial risk requiring legal or guest-relations intervention."
    - name: "dispute_resolution_status"
      expr: dispute_resolution_status
      comment: "Current resolution status of a disputed cancellation. Tracks outstanding financial liability from unresolved disputes."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Indicates whether a cancellation penalty applies (True/False). Segments cancellations by revenue-recovery potential."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the guest is eligible for a refund (True/False). Drives cash-flow and refund-liability forecasting."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Indicates whether a penalty waiver was granted (True/False). Measures goodwill cost and policy exception frequency."
    - name: "ota_chargeback_eligible_flag"
      expr: ota_chargeback_eligible_flag
      comment: "Indicates whether the OTA cancellation is eligible for chargeback (True/False). Quantifies OTA revenue-recovery opportunity."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the cancellation was reversed (True/False). Tracks re-booking recovery and cancellation reversal effectiveness."
    - name: "original_arrival_date"
      expr: original_arrival_date
      comment: "Original intended arrival date of the cancelled booking. Enables stay-date-level revenue-lost analysis."
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month-level truncation of the cancellation event timestamp for monthly trend analysis."
  measures:
    - name: "total_cancellations"
      expr: COUNT(1)
      comment: "Total number of cancellation records. Baseline volume KPI for cancellation rate and trend monitoring."
    - name: "total_revenue_lost"
      expr: SUM(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Total room revenue lost due to cancellations. Primary financial impact KPI for cancellation policy effectiveness review."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty fees charged on cancellations. Measures revenue recovered through cancellation policy enforcement."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on cancellations. Tracks cash outflow and refund liability for treasury management."
    - name: "total_ota_chargeback_amount"
      expr: SUM(CAST(ota_chargeback_amount AS DOUBLE))
      comment: "Total OTA chargeback amounts on cancellations. Quantifies revenue-recovery potential and OTA dispute exposure."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average cancellation penalty per cancellation event. Benchmarks penalty policy calibration across segments and channels."
    - name: "avg_revenue_lost"
      expr: AVG(CAST(revenue_lost_amount AS DOUBLE))
      comment: "Average revenue lost per cancellation. Informs the financial cost of each cancellation event for policy design."
    - name: "disputed_cancellations"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of cancellations under dispute. Tracks legal and financial risk exposure from contested cancellations."
    - name: "waived_cancellations"
      expr: COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where penalty was waived. Measures goodwill cost and exception-handling frequency."
    - name: "penalty_applicable_cancellations"
      expr: COUNT(CASE WHEN penalty_applicable_flag = TRUE THEN 1 END)
      comment: "Number of cancellations where a penalty is applicable. Denominator for penalty collection rate analysis."
    - name: "refund_eligible_cancellations"
      expr: COUNT(CASE WHEN refund_eligible_flag = TRUE THEN 1 END)
      comment: "Number of cancellations eligible for refund. Drives refund liability forecasting and cash-flow planning."
    - name: "reversed_cancellations"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of cancellations that were subsequently reversed (re-booked). Measures demand-recovery effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_deposit_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deposit lifecycle and financial KPIs covering deposit collection, forfeiture, refund activity, and revenue recognition timing. Critical for Finance and Revenue Management to manage cash flow, forfeiture income, and deposit policy compliance."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`deposit_ledger`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit (e.g. Received, Pending, Forfeited, Refunded). Tracks deposit lifecycle stage."
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (e.g. Pre-Payment, Guarantee Deposit, Security Deposit). Enables deposit-type financial analysis."
    - name: "deposit_policy_code"
      expr: deposit_policy_code
      comment: "Policy code governing the deposit requirement. Links deposit performance back to policy effectiveness."
    - name: "deposit_due_date"
      expr: deposit_due_date
      comment: "Date by which the deposit was due. Enables overdue deposit tracking and collection efficiency analysis."
    - name: "payment_received_date"
      expr: payment_received_date
      comment: "Date the deposit payment was actually received. Used to measure collection timeliness vs. due date."
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date on which deposit revenue is recognized. Supports GAAP/IFRS revenue recognition compliance reporting."
    - name: "forfeiture_date"
      expr: forfeiture_date
      comment: "Date the deposit was forfeited. Tracks forfeiture income timing for financial close."
    - name: "deposit_month"
      expr: DATE_TRUNC('MONTH', deposit_due_date)
      comment: "Month-level truncation of deposit due date for monthly deposit collection trend analysis."
  measures:
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected or expected. Primary cash-flow KPI for deposit management and treasury forecasting."
    - name: "total_forfeiture_amount"
      expr: SUM(CAST(forfeiture_amount AS DOUBLE))
      comment: "Total deposit forfeiture income. Measures revenue captured from forfeited deposits — a key cancellation policy revenue stream."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit refunds issued. Tracks cash outflow from deposit refunds for treasury and liability management."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per booking. Benchmarks deposit policy calibration and identifies outlier deposit requirements."
    - name: "total_deposit_records"
      expr: COUNT(1)
      comment: "Total number of deposit ledger entries. Baseline volume for deposit collection rate and policy coverage analysis."
    - name: "forfeited_deposits"
      expr: COUNT(CASE WHEN deposit_status = 'Forfeited' THEN 1 END)
      comment: "Number of deposits that were forfeited. Tracks forfeiture frequency as a signal of cancellation policy enforcement."
    - name: "refunded_deposits"
      expr: COUNT(CASE WHEN deposit_status = 'Refunded' THEN 1 END)
      comment: "Number of deposits that were refunded. Measures refund activity volume for cash-flow and guest-satisfaction monitoring."
    - name: "distinct_properties_with_deposits"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with deposit ledger activity. Supports portfolio-level deposit policy compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance KPIs covering contracted vs. pickup room counts, attrition risk, revenue forecast, commission exposure, and deposit compliance. Essential for Group Sales, Revenue Management, and Event Operations leadership to manage group business profitability."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the group block (e.g. Tentative, Definite, Cancelled, Consumed). Tracks group business pipeline stage."
    - name: "block_type"
      expr: block_type
      comment: "Type of group block (e.g. Corporate, Association, Tour, Wedding). Enables segment-level group performance analysis."
    - name: "arrival_date"
      expr: arrival_date
      comment: "Group arrival date. Drives group occupancy forecasting and resource planning."
    - name: "departure_date"
      expr: departure_date
      comment: "Group departure date. Combined with arrival_date to compute group stay window."
    - name: "cutoff_date"
      expr: cutoff_date
      comment: "Inventory release cutoff date for the group block. Critical for inventory management and attrition risk monitoring."
    - name: "attrition_clause_flag"
      expr: attrition_clause_flag
      comment: "Indicates whether an attrition clause is in the group contract (True/False). Flags blocks with contractual minimum-pickup obligations."
    - name: "deposit_required_flag"
      expr: deposit_required_flag
      comment: "Indicates whether a deposit is required for the group block (True/False). Tracks deposit compliance and financial risk."
    - name: "lra_flag"
      expr: lra_flag
      comment: "Indicates whether the group block is under a Last Room Availability (LRA) agreement (True/False). Signals rate and inventory obligation risk."
    - name: "block_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month-level truncation of group arrival date for monthly group business pipeline analysis."
  measures:
    - name: "total_group_blocks"
      expr: COUNT(1)
      comment: "Total number of group blocks. Baseline volume KPI for group sales pipeline and booking pace."
    - name: "total_revenue_forecast"
      expr: SUM(CAST(revenue_forecast_amount AS DOUBLE))
      comment: "Total forecasted revenue from group blocks. Primary group revenue pipeline KPI for Sales and Revenue Management."
    - name: "avg_group_rate"
      expr: AVG(CAST(group_rate_amount AS DOUBLE))
      comment: "Average negotiated group room rate. Benchmarks group pricing against transient ADR to assess displacement cost."
    - name: "total_group_rate_revenue"
      expr: SUM(CAST(group_rate_amount AS DOUBLE))
      comment: "Total group rate revenue across all blocks. Measures group room revenue contribution to total property revenue."
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts required across group blocks. Tracks deposit liability and cash-flow from group business."
    - name: "total_commission_expense"
      expr: SUM(CAST(commission_percentage AS DOUBLE))
      comment: "Sum of commission percentages across group blocks (proxy for commission exposure). Informs net group revenue calculations."
    - name: "avg_attrition_threshold"
      expr: AVG(CAST(attrition_threshold_percentage AS DOUBLE))
      comment: "Average attrition threshold percentage across group contracts. Benchmarks contractual pickup obligations and attrition risk exposure."
    - name: "attrition_risk_blocks"
      expr: COUNT(CASE WHEN attrition_clause_flag = TRUE THEN 1 END)
      comment: "Number of group blocks with attrition clauses. Quantifies the portfolio of blocks at risk of attrition penalties."
    - name: "cancelled_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled group blocks. Measures group cancellation volume and associated revenue-at-risk."
    - name: "definite_group_blocks"
      expr: COUNT(CASE WHEN block_status = 'Definite' THEN 1 END)
      comment: "Number of definite (contracted) group blocks. Tracks confirmed group demand on the books for revenue forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_room_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room assignment quality and operational KPIs covering upgrade rates, guest preference fulfillment, reassignment frequency, early/late request handling, and accessible room allocation. Drives Front Office operational excellence and guest satisfaction management."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`room_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the room assignment (e.g. Assigned, Pending, Reassigned, Released). Tracks assignment lifecycle."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the room (e.g. Manual, Automated, Guest-Requested). Enables efficiency analysis of assignment workflows."
    - name: "is_upgrade"
      expr: is_upgrade
      comment: "Indicates whether the assignment is a room upgrade (True/False). Tracks upgrade frequency and upsell program performance."
    - name: "upgrade_category"
      expr: upgrade_category
      comment: "Category of upgrade granted (e.g. Room Type, Floor, View). Enables upgrade-type revenue and satisfaction analysis."
    - name: "is_accessible_room"
      expr: is_accessible_room
      comment: "Indicates whether the assigned room is ADA-accessible (True/False). Supports compliance and accessible inventory utilization tracking."
    - name: "is_connecting_room"
      expr: is_connecting_room
      comment: "Indicates whether the assigned room is a connecting room (True/False). Tracks connecting room demand fulfillment."
    - name: "is_guest_requested"
      expr: is_guest_requested
      comment: "Indicates whether the specific room was requested by the guest (True/False). Measures guest preference fulfillment rate."
    - name: "early_checkin_flag"
      expr: early_checkin_flag
      comment: "Indicates whether an early check-in was accommodated (True/False). Tracks early check-in fulfillment rate."
    - name: "late_checkout_flag"
      expr: late_checkout_flag
      comment: "Indicates whether a late check-out was accommodated (True/False). Tracks late check-out fulfillment rate."
    - name: "view_type"
      expr: view_type
      comment: "View type of the assigned room (e.g. Ocean, Garden, City). Enables view-preference fulfillment analysis."
    - name: "assignment_date"
      expr: assignment_date
      comment: "Date the room was assigned. Used for assignment lead-time and pre-arrival assignment rate analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month-level truncation of assignment date for monthly operational trend analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of room assignment records. Baseline volume for assignment rate and operational throughput analysis."
    - name: "upgrade_assignments"
      expr: COUNT(CASE WHEN is_upgrade = TRUE THEN 1 END)
      comment: "Number of room assignments that are upgrades. Numerator for upgrade rate — a key upsell and loyalty program KPI."
    - name: "guest_requested_assignments"
      expr: COUNT(CASE WHEN is_guest_requested = TRUE THEN 1 END)
      comment: "Number of assignments fulfilling a specific guest room request. Numerator for guest preference fulfillment rate."
    - name: "early_checkin_fulfilled"
      expr: COUNT(CASE WHEN early_checkin_flag = TRUE THEN 1 END)
      comment: "Number of early check-in requests fulfilled. Measures early check-in service delivery rate and operational readiness."
    - name: "late_checkout_fulfilled"
      expr: COUNT(CASE WHEN late_checkout_flag = TRUE THEN 1 END)
      comment: "Number of late check-out requests fulfilled. Measures late check-out service delivery rate and room-turn impact."
    - name: "accessible_room_assignments"
      expr: COUNT(CASE WHEN is_accessible_room = TRUE THEN 1 END)
      comment: "Number of assignments to accessible rooms. Tracks ADA-compliant inventory utilization and compliance."
    - name: "avg_preference_match_score"
      expr: AVG(CAST(guest_preference_match_score AS DOUBLE))
      comment: "Average guest preference match score across assignments. Composite KPI for room assignment quality and personalization effectiveness."
    - name: "distinct_guests_assigned"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests with room assignments. Measures assignment coverage across the guest population."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment and financial KPIs covering fulfillment rates, charge revenue, cost efficiency, VIP request handling, and guest satisfaction. Drives Guest Experience, Operations, and Revenue Management decisions on ancillary service delivery."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`special_request`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the special request (e.g. Fulfilled, Pending, Failed, Cancelled). Core dimension for service delivery analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (e.g. Amenity, Transportation, Dietary, Accessibility). Enables category-level fulfillment and cost analysis."
    - name: "request_category"
      expr: request_category
      comment: "Broader category grouping of the request. Supports department-level workload and cost allocation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request (e.g. High, Medium, Low). Enables SLA compliance analysis by priority tier."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfilling the request. Drives departmental workload and fulfillment performance accountability."
    - name: "is_vip_request"
      expr: is_vip_request
      comment: "Indicates whether the request is from a VIP guest (True/False). Enables VIP service delivery quality monitoring."
    - name: "is_pre_arrival"
      expr: is_pre_arrival
      comment: "Indicates whether the request was made pre-arrival (True/False). Tracks pre-arrival engagement and preparation effectiveness."
    - name: "requires_charge"
      expr: requires_charge
      comment: "Indicates whether the request incurs a charge (True/False). Segments chargeable vs. complimentary requests for revenue analysis."
    - name: "failure_category"
      expr: failure_category
      comment: "Category of failure for unfulfilled requests. Drives root-cause analysis of service delivery failures."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month-level truncation of request timestamp for monthly special request volume and fulfillment trend analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests. Baseline volume KPI for service demand and operational workload planning."
    - name: "fulfilled_requests"
      expr: COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 END)
      comment: "Number of successfully fulfilled special requests. Numerator for fulfillment rate — a primary guest satisfaction KPI."
    - name: "failed_requests"
      expr: COUNT(CASE WHEN fulfillment_status = 'Failed' THEN 1 END)
      comment: "Number of failed special requests. Tracks service failure volume and drives corrective action in operations."
    - name: "vip_requests"
      expr: COUNT(CASE WHEN is_vip_request = TRUE THEN 1 END)
      comment: "Number of special requests from VIP guests. Ensures VIP service delivery is tracked and prioritized."
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from chargeable special requests. Measures ancillary revenue contribution from special request services."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill special requests. Drives cost-of-service analysis and departmental budget management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for special requests. Enables budget-vs-actual cost variance analysis for service operations."
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per chargeable special request. Benchmarks ancillary pricing and identifies upsell optimization opportunities."
    - name: "pre_arrival_requests"
      expr: COUNT(CASE WHEN is_pre_arrival = TRUE THEN 1 END)
      comment: "Number of pre-arrival special requests. Measures pre-arrival engagement depth and preparation workload."
    - name: "distinct_guests_with_requests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests who submitted special requests. Tracks special request penetration across the guest population."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_booking_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking status change event KPIs covering modification activity, SLA compliance, penalty fee capture, revenue impact of changes, and dispute tracking. Enables Revenue Management and Operations to monitor booking lifecycle health and change-event financial consequences."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`booking_status_history`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of booking status change event (e.g. Modification, Cancellation, No-Show, Reinstatement). Core dimension for change-event analysis."
    - name: "modification_type"
      expr: modification_type
      comment: "Type of modification applied (e.g. Date Change, Room Type Change, Rate Change). Enables modification-type impact analysis."
    - name: "new_status"
      expr: new_status
      comment: "New booking status after the event. Tracks status transition patterns across the booking lifecycle."
    - name: "previous_status"
      expr: previous_status
      comment: "Booking status before the event. Combined with new_status to analyze status transition flows."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the status change event met SLA targets (True/False). Tracks operational responsiveness and SLA adherence."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the status change event is under dispute (True/False). Flags events with financial or legal risk."
    - name: "guest_notification_sent_flag"
      expr: guest_notification_sent_flag
      comment: "Indicates whether the guest was notified of the status change (True/False). Tracks guest communication compliance."
    - name: "system_source"
      expr: system_source
      comment: "Source system that generated the status change event (e.g. PMS, CRS, OTA). Enables system-level change-event attribution."
    - name: "event_date"
      expr: event_date
      comment: "Date of the booking status change event. Used for daily and weekly change-event trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month-level truncation of event timestamp for monthly booking change activity trend analysis."
  measures:
    - name: "total_status_change_events"
      expr: COUNT(1)
      comment: "Total number of booking status change events. Baseline volume for booking modification and cancellation activity monitoring."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from booking status change events. Measures net financial effect of modifications, cancellations, and reinstatements."
    - name: "total_penalty_fees"
      expr: SUM(CAST(penalty_fee_amount AS DOUBLE))
      comment: "Total penalty fees generated from booking status change events. Tracks penalty revenue capture from policy enforcement."
    - name: "total_rate_difference"
      expr: SUM(CAST(rate_difference_amount AS DOUBLE))
      comment: "Total rate difference amounts from booking modifications. Measures revenue uplift or dilution from rate changes on modified bookings."
    - name: "avg_revenue_impact"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per status change event. Benchmarks the financial consequence of individual booking change events."
    - name: "sla_compliant_events"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of status change events meeting SLA targets. Numerator for SLA compliance rate — an operational excellence KPI."
    - name: "disputed_events"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of status change events under dispute. Tracks dispute volume and associated financial risk exposure."
    - name: "guest_notified_events"
      expr: COUNT(CASE WHEN guest_notification_sent_flag = TRUE THEN 1 END)
      comment: "Number of status change events where guest notification was sent. Tracks guest communication compliance rate."
    - name: "distinct_bookings_changed"
      expr: COUNT(DISTINCT reservation_booking_id)
      comment: "Number of distinct reservations that experienced a status change. Measures breadth of booking modification activity."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`reservation_travel_agent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Travel agent and agency performance KPIs covering revenue generation, commission rates, credit exposure, booking volume tiers, and contract health. Enables Sales and Distribution leadership to manage agency relationships, commission spend, and channel profitability."
  source: "`vibe_travel_hospitality_v1`.`reservation`.`travel_agent`"
  dimensions:
    - name: "travel_agent_status"
      expr: travel_agent_status
      comment: "Current status of the travel agent (e.g. Active, Inactive, Suspended). Segments active vs. inactive agency relationships."
    - name: "agency_type"
      expr: agency_type
      comment: "Type of travel agency (e.g. Leisure, Corporate, Wholesale, OTA). Enables agency-type revenue and commission analysis."
    - name: "booking_volume_tier"
      expr: booking_volume_tier
      comment: "Booking volume tier of the agency (e.g. Platinum, Gold, Silver). Drives tiered commission and incentive program management."
    - name: "country_code"
      expr: country_code
      comment: "Country of the travel agency. Enables geographic distribution of agency revenue and booking volume."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Preferred payment method of the agency. Informs accounts receivable and payment processing workflows."
    - name: "contract_start_date"
      expr: contract_start_date
      comment: "Start date of the agency contract. Used for contract tenure and renewal cycle analysis."
    - name: "contract_end_date"
      expr: contract_end_date
      comment: "End date of the agency contract. Enables proactive contract renewal management and lapse risk identification."
    - name: "last_booking_date"
      expr: last_booking_date
      comment: "Date of the most recent booking from the agency. Identifies dormant agencies for re-engagement campaigns."
  measures:
    - name: "total_agents"
      expr: COUNT(1)
      comment: "Total number of travel agent records. Baseline for agency portfolio size and distribution channel coverage."
    - name: "active_agents"
      expr: COUNT(CASE WHEN travel_agent_status = 'Active' THEN 1 END)
      comment: "Number of active travel agents. Measures the productive size of the agency distribution network."
    - name: "total_revenue_generated"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by travel agents. Primary KPI for agency channel revenue contribution and ROI assessment."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across travel agents. Benchmarks commission cost efficiency and informs rate negotiation strategy."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended to travel agents. Measures aggregate financial exposure from agency credit facilities."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per travel agent. Benchmarks credit policy calibration across agency tiers."
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries represented in the agency portfolio. Measures geographic reach of the travel agent distribution network."
$$;